Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980FEC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 02:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A861387F4B;
	Tue, 27 Feb 2024 03:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yBoUFc0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A528D87F6D; Tue, 27 Feb 2024 03:37:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1136587F4B
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 03:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412ad927275so524315e9.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709001447; x=1709606247; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7jUBPZ5js/lDQdT/8Pipf1ZmsaR6/CGCl7LeCu89qs=;
 b=yBoUFc0Jhb3ZcAYUIDk5tgbkrX1uQEuQtn4zYBKGPDIi75+RgbnUbWN6QNUGGqg5TJ
 9k6O9/HslmUIMh4CwVoA6nBC+ieAyY+VFhvMx97BVZ0Z1xJaZhD24UAX/BSc4PE5PDGZ
 UWnp5nfqBDMFMcSjs35i2II2FvTmkm3KaZuvvyKfr87KxkuEKzbpBYvyP8CYJ7APs7DF
 +mJFzqGi/0OmId8ruIN/kr1h11FGul7GOxEKlWe4Ihh8fS75Xzfz95mvAi00ek7zQqCm
 tN/2AdOjO5NWmqqQ7Oq5w6BPQhyXALntr8f9Iz4r2Ppfte9nzRx3E2Kff88Lb9mw3LvF
 3euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709001447; x=1709606247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7jUBPZ5js/lDQdT/8Pipf1ZmsaR6/CGCl7LeCu89qs=;
 b=eNHHAjl2Yt+zNe3bZQno9Kgnj7FZKTnOStB+mgFf/ypPk7cYGTFU9kUVdc9fr+JRG2
 nKAwTMiqRiYZwd3QsLZ1KFqwr6z5tJpF9krRjq5ap0DwxhNX9IPRCznNoY536sJ4XDyK
 mabEVyZXEzZGUrHsH4Z9hqUGAej6ZDss3OxhoxAY4ktS5a3I/F56Stu9/F54cRYkDUfX
 r966SBLEChkWLDvu9YbZm7nrU2p5/Ldfd2leTYYnoSKtGpXAvuA0LIAPt+AfcI2yWqmw
 Y8KTvNA1XPDJmfcGLxeVTJrhRXrtXhp04Jp6RYh77XuAAlSoj23GFxfqpQCHXFgwi8sy
 8WTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt8mDuMCJpLP1RmAF70EHE/JjjACRNzcfKYn7BjSdg7/6zVstsA8U/5WeIGYW9hkYSTae8FSM332kWtuxRzVPteaI/6w==
X-Gm-Message-State: AOJu0YysPN68VLZ9CR9cGHRxQIAZCXHyEYZeRViyVKGfT22o1H+SwqPg
 3MT1ca6kfCds6OF9u5qCsTSI+74Byh4EEcI8Y/PpfuBpxA+w3RH8qMHhrYuXF1I=
X-Google-Smtp-Source: AGHT+IEfLpc7ve4htnYqkyf7UwBF5RfLXzqvdvHRj24dOqbbT25Vb3R6Xt7JvF7kwOZBeQaLWiXYhQ==
X-Received: by 2002:a05:600c:138f:b0:411:a5f9:26f5 with SMTP id
 u15-20020a05600c138f00b00411a5f926f5mr7220220wmf.38.1709001447434; 
 Mon, 26 Feb 2024 18:37:27 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a1c4b05000000b004129f87a2c6sm106473wma.1.2024.02.26.18.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 18:37:26 -0800 (PST)
Message-ID: <940ef1ef-0f70-42ab-8503-f1a2965cc297@linaro.org>
Date: Tue, 27 Feb 2024 02:37:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Add initial support for IPQ9574 based boards
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

HI Varada,

On 26/02/2024 10:07, Varadarajan Narayanan wrote:
> These patches introduce the initial support code needed
> for the QTI IPQ9574 SoC and RDP433 board.

Awesome!
> 
> 	SoC	: QTI IPQ9574
> 	RAM	: 2GB DDR4
> 	Flash	: eMMC 8GB
> 	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz
> 
> New to both patman and posting to U-Boot. Please let
> me know if something is not correct, will try to
> rectify to the best of my abilities.

Patches came through just fine, thanks! I haven't used patman
personally, but I have used the b4 tool, I'd recommend giving it a spin
if you haven't yet. Your get_maintainers.pl options might need some
tweaking too (the defaults from b4 seem to work better ime).

I've spent some time going through your series and there's a lot to go
over, so apologies if this gets a bit long.

I'm planning to pick up this[1] patch series this week and I'm sorry to
say it has some fairly major conflicts with your work here. My series
makes some fairly significant changes to Qualcomm support in U-Boot
(moving to upstream Linux DT and getting rid of most of the compile time
board configuration among other things).

The thing I'm mostly concerned with is the totally custom init code and
linker script. I discovered this branch[2] which seems to have a fairly
complete git history, but there's still a lot of unknowns.

* What is the custom linker script for (which isn't handled by the
default one)?
* Why do you skip U-Boot relocation (GD_FLG_SKIP_RELOC)?
* How is U-Boot expected to be flashed and consequently loaded on this
platform? I get the impression that SBL1 jumps to it directly? Is it
built into an XBL image like on the mobile/IoT platforms, or flashed to
it's own partition, or to SPI flash?

In general there is very little context around the code being added
here, and as a result it's hard to understand what exactly is going on
and why things have been done a certain way.

I'll leave some more detailed comments in line, but I think initially I
would just like to get a better understanding of the situation here, so
answers to the questions above would be most helpful!

Please also have a look at reworking this series on top of my patches
linked at [1], if you have any issues or questions then please do get in
touch with me via email, or better via the #u-boot IRC channel on OFTC,
my nick there is calebccff.

Regarding my series, the notable changes are in how mach-snapdragon is
handled: the target specific memory maps have been dropped in favour of
reading the memory map from DT. The sysmap headers are also gone,
instead the defines are moved to the relevant driver (mostly clock/pinctrl).

I think it would be sensible to (for example) introduce
mach-snapdragon/smem.c for handling stuff like your env_get_location()
implementation (it would provide smem_env_get_location() which would be
called from env_get_location() in board.c).

You'll probably also want to skip the carve_out_reserved_memory() call
for now.

[1]:
https://lore.kernel.org/u-boot/20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org/
[2]:
https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot/-/tree/NHSS.QSDK.12.4.5
> 
> Thanks
> Varada

Kind regards,
> 
> 
> Varadarajan Narayanan (10):
>   mach-snapdragon: Add support for IPQ9574
>   mach-snapdragon: ipq9574: Add SMEM defines needed for IPQ9574
>   clk/qcom: Add support for clock registers in IPQ9574
>   clk/qcom: Include IPQ9574
>   mach-snapdragon: Update gd->ram_size in msm_fixup_memory
>   pinctrl: qcom: Add support for 'pull-down'
>   pinctrl: qcom: Include IPQ9574
>   mmc: msm_sdhci: Handle different vendor cap register offsets
>   mmc: msm_sdhci: Reset clocks before reconfiguration
>   board: qualcomm: Add support for IPQ9574 RDP433
> 
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/ipq9574-default.dts              |  167 +++
>  arch/arm/dts/ipq9574-rdp433-mht-phy.dts       |  208 +++
>  arch/arm/dts/ipq9574.dtsi                     |  771 ++++++++++
>  arch/arm/mach-snapdragon/Kconfig              |   15 +
>  arch/arm/mach-snapdragon/Makefile             |    1 +
>  arch/arm/mach-snapdragon/dram.c               |   10 +-
>  .../include/mach/sysmap-ipq9574.h             |  252 ++++
>  arch/arm/mach-snapdragon/init_ipq9574.c       |   81 +
>  board/qualcomm/ipq9574/Kconfig                |   15 +
>  board/qualcomm/ipq9574/Makefile               |    4 +
>  board/qualcomm/ipq9574/board_init.c           |  326 ++++
>  board/qualcomm/ipq9574/ipq9574.c              |  170 +++
>  board/qualcomm/ipq9574/ipq9574.h              |   75 +
>  board/qualcomm/ipq9574/u-boot-x32.lds         |  250 ++++
>  board/qualcomm/ipq9574/u-boot-x64.lds         |  188 +++
>  configs/ipq9574_mmc_defconfig                 |  118 ++
>  drivers/clk/qcom/Kconfig                      |    8 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/clock-ipq9574.c              | 1320 +++++++++++++++++
>  drivers/clk/qcom/clock-qcom.c                 |   32 +
>  drivers/clk/qcom/clock-qcom.h                 |    8 +
>  drivers/mmc/msm_sdhci.c                       |   21 +-
>  drivers/pinctrl/qcom/Kconfig                  |    7 +
>  drivers/pinctrl/qcom/Makefile                 |    1 +
>  drivers/pinctrl/qcom/pinctrl-ipq9574.c        |   77 +
>  drivers/pinctrl/qcom/pinctrl-qcom.c           |    2 +
>  include/configs/ipq9574.h                     |  111 ++
>  include/dt-bindings/clock/gcc-ipq9574.h       |  156 ++
>  include/dt-bindings/net/qti-ipqsoc.h          |   20 +
>  include/dt-bindings/pinctrl/pinctrl-ipqsoc.h  |   19 +
>  include/dt-bindings/reset/ipq9574-reset.h     |   54 +
>  include/smem.h                                |   78 +
>  33 files changed, 4563 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/dts/ipq9574-default.dts
>  create mode 100644 arch/arm/dts/ipq9574-rdp433-mht-phy.dts
>  create mode 100644 arch/arm/dts/ipq9574.dtsi
>  create mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
>  create mode 100644 arch/arm/mach-snapdragon/init_ipq9574.c
>  create mode 100644 board/qualcomm/ipq9574/Kconfig
>  create mode 100644 board/qualcomm/ipq9574/Makefile
>  create mode 100644 board/qualcomm/ipq9574/board_init.c
>  create mode 100644 board/qualcomm/ipq9574/ipq9574.c
>  create mode 100644 board/qualcomm/ipq9574/ipq9574.h
>  create mode 100644 board/qualcomm/ipq9574/u-boot-x32.lds
>  create mode 100644 board/qualcomm/ipq9574/u-boot-x64.lds
>  create mode 100644 configs/ipq9574_mmc_defconfig
>  create mode 100644 drivers/clk/qcom/clock-ipq9574.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
>  create mode 100644 include/configs/ipq9574.h
>  create mode 100644 include/dt-bindings/clock/gcc-ipq9574.h
>  create mode 100644 include/dt-bindings/net/qti-ipqsoc.h
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
>  create mode 100644 include/dt-bindings/reset/ipq9574-reset.h
> 

-- 
// Caleb (they/them)
