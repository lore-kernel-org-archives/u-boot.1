Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421D5C982F3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 19:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3848836AC;
	Fri, 16 Jan 2026 20:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bU2y1dVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBE9838A5; Fri, 16 Jan 2026 20:23:01 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5258367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 20:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b872b588774so362319266b.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768591378; x=1769196178; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:to:content-language
 :references:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vHGNSK+uuV3Y7Ap/QeWuAYKsSuaQw6Boygc9h569ciM=;
 b=bU2y1dVlXHmsWG8X7kb2sVy5RM0YLiklxEttrExXmsmscEMlPwj+ClMWsDRqlyrIAq
 vEgHFbYBwKldPhjgaQ7j4PeQlBNQSIxeIRzSFa2o9E4bxmmMuR5u+4uDncmTbcMayvNk
 USnuEyTz8tyS9m9UkqxUf9/gmjnwFMQUwG1PwUcWE9z5jIq1K6ztVY25qMWUsO5MwpRa
 yXz2FCNBG5vSLsQCKov1rxChN0BaqPoLOFuB/DPfqmtBwXlqOYTrT636wRqTLjxHzNPD
 ildyv35aT3AJmsmjRiJr5ai9exiiioV5UMeecKRzyJkQa0s9o89Bea1xlXMB+y/EdZBc
 gZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768591378; x=1769196178;
 h=content-transfer-encoding:in-reply-to:from:to:content-language
 :references:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vHGNSK+uuV3Y7Ap/QeWuAYKsSuaQw6Boygc9h569ciM=;
 b=JAfCsPSilfKK1lzJR5rUErpaRjZXVwoJ/jnFcQWiZVX8bC3Qr7heUplT/ffJ9iqmyI
 0JOhO4+W8/qVEi4KHyq++gVAYjhdGfnJ/rVagN0Y8k6HP9+BvFqj+OBSmoycwscItYz7
 x6pdYWRpJMbXo1PH2sD1DuI/pkRRVCKjrZoQrT1kiEsohY788bYzwXvqeJ6Cwv5Wc3eK
 bfLyW/cSEXd4CtCk0t2B3zRyzYhn13E4rcLmvZAAxbLZAqEefxBaUIJOKoui3Zs6C7yb
 nzxrnohBqReHO91yQmAinQlXwqcumgYKIgUbXWqEk7XgdXFvipUODKCJELNsjoF+PnAz
 sFCg==
X-Gm-Message-State: AOJu0YyZKv9Sr5KoJth+32RKRwWUW7ecZFKZpP85mvsLVXUqz2ExTjmg
 OcbSEG2u1RcQGZfA1CBsUXLLTYNZX9j8bgPwsnXnjkMtCG0m3a1BnTRpxQxpU4BDKXbDApIwqCC
 mmysEHT4=
X-Gm-Gg: AY/fxX47LDSRX1sCqKUi42m99ycfAHckjW78AjV/KgszBVZ37hbC3DwTkqZmWe0zwSM
 b0IwGMPduKOwkVOEwefRp9XVbkOKJ+FpvmfX5KdtBCR/zqDIMjIiiGfzYY9j87L5B/M/i1x+SSB
 Qh21pGlYPzg+CWT6XkRPq+d4/mbESDXw14//r/RmsJL6P8NiYD6i0CNtEt0bs7yKYIkBhQfRXHj
 uIxM9wynsJ2M6FsuAj64gspmck0eeQfxmrZJo58X0Fmcs4EpXwbqvc8J7KeaB0SqlYVdB9Fcg/R
 aRpjUBOItjRotfAChbaZIokxuLvX0OAj0IsQBdw00XmVovBmKE6fV+6rWu8+j1p6ZSmxV82HE41
 y0+vgd+Kr2GQKN4GhPerXa8oQpn7o6CFTNK21i+ybYFAu1hlR7Lh7SMNJeZInMRBApbM1J2rXcN
 1qtpN2/B8NQiSyms0GAqjAprbIcgiOufcX5E+/1BDbmWA9M9mvAoJoalrqNmUX3tk=
X-Received: by 2002:a17:906:fe0b:b0:b83:246c:c514 with SMTP id
 a640c23a62f3a-b8792feb225mr308294866b.51.1768591377344; 
 Fri, 16 Jan 2026 11:22:57 -0800 (PST)
Received: from [192.168.1.160] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168e6asm337647766b.22.2026.01.16.11.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 11:22:56 -0800 (PST)
Message-ID: <95782989-6db8-4f83-b51a-3ca28fa97874@linaro.org>
Date: Fri, 16 Jan 2026 20:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PULL] Please pull qcom-main
References: <20260116192127.3444041-2-casey.connolly@linaro.org>
Content-Language: en-US, en-GB
To: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-qcom@groups.io
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260116192127.3444041-2-casey.connolly@linaro.org>
X-Forwarded-Message-Id: <20260116192127.3444041-2-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Oops, forgot to Cc the list!


-------- Forwarded Message --------
Subject: [PULL] Please pull qcom-main
Date: Fri, 16 Jan 2026 20:21:03 +0100
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
CC: Alexey Minnekhanov <alexeymin@minlexx.ru>, Aswin Murugan 
<aswin.murugan@oss.qualcomm.com>, Balaji Selvanathan 
<balaji.selvanathan@oss.qualcomm.com>, Biswapriyo Nath 
<nathbappai@gmail.com>, David Heidelberg <david@ixit.cz>, Gopinath Sekar 
<gopinath.sekar@oss.qualcomm.com>, Loic Poulain 
<loic.poulain@oss.qualcomm.com>, Neil Armstrong 
<neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>, Casey Connolly 
<casey.connolly@linaro.org>

Hi Tom,

Sorry for the friday PR!

We have been getting a lot more patches from Qualcomm engineers, largely
focusing on IoT, router, and automotive platforms (those with QCS, IPQ,
and SA prefixes specifically).

Quite a variety of changes here:
- Watchdog overflow fix
- Hardcoded fastboot buffer addresses for a few board (hoppefully
   temporary until fastboot is updated to read $fastboot_addr_r)
- Enable memory protection (MMU_MGPROT) for ARCH_SNAPDRAGON
- pinctrl support for the QCS615 soc
- various USB/phy fixes including phy config for msm8996/qcs615
- mmc and i2c clock configuration fixes
- significant fixes for rpmh and regulator drivers
- added config fragment for pixel devices
- sa8775p clock fixes
- support for "flattened" dwc3 DT that recently landed upstream for
   sc7280 (qcs6490) and a few other platforms

Thanks,

---

The following changes since commit d503633a36767d756c7de28305cf0de79440cbc0:

   Revert "doc: board: starfive: update jh7110 common description" 
(2026-01-13 14:18:05 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to cd8ee4fff82788546df06fae7bbe6d22a710737b:

   usb: dwc3-generic: support Qualcomm flattened DT (2026-01-16 19:02:13 
+0100)

----------------------------------------------------------------
Alexey Minnekhanov (1):
       mach-snapdragon: capsule_update: Fix eMMC detection for non-UFS 
devices

Aswin Murugan (6):
       regulator: qcom-rpmh-regulator: add support for PM8150 PM8350 PM7325
       pinctrl: qcom: add driver for QCS615 SoC
       pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all drivers by 
default
       qcom_defconfig: Remove redundant pinctrl driver selections
       smem: msm: Fix memory-region lookup, direct <reg> mapping and 
update SMEM host count
       spmi: msm: refine handling of multiple APID mappings

Balaji Selvanathan (7):
       usb: dwc3: qcom: Add delays in UTMI clock selection for Qscratch
       configs: Rename qcs9100_defconfig to qcom_qcs9100_defconfig
       configs: qcom_qcs9100: Fix fastboot buffer address for QCS9100 board
       usb: gadget: Kconfig: Correct Qualcomm config name used
       configs: qcom_qcs615: Correct debug UART clock frequency
       configs: Fix fastboot buffer address for QCS615 and QCM6490 boards
       clk: qcom: sa8775p: Fix USB clock configuration and add resets

Biswapriyo Nath (1):
       phy: Add MSM8996 support to Qualcomm QUSB2 phy

Casey Connolly (10):
       phy: qcom: snps-femto-v2: assert reset in probe
       mach-snapdragon: of_fixup: support new flat dwc3 node
       clk/qcom: sc7280: add more QUP clocks
       i2c: geni: bail when clocks can't be enabled
       soc/qcom: rpmh: document rsc registers
       soc/qcom: rpmh: correctly wait for TCS flush
       soc/qcom: rpmh: add RPMh read
       power: regulator: qcom-rpmh: read votes from rpmh
       power: regulator: qcom-rpmh: correctly map pmic mode
       usb: dwc3-generic: support Qualcomm flattened DT

David Heidelberg (2):
       doc: board: qualcomm: document Pixel 3 / 3 XL support
       configs: Add google-pixel fragment config for Pixel 3, 3 XL, 5

Gopinath Sekar (1):
       watchdog: qcom: Add max timeout check to prevent overflow

Loic Poulain (2):
       mmc: msm_sdhci: Fix incorrect divider calculation for SDCLK
       clk/qcom: qcm2290: Add SDCC1 apps clock frequency table

Neil Armstrong (2):
       mach-snapdragon: enable MMU_PGPROT by default
       soc: qcom: rpmh-rsc: reclaim the TCS to avoid spurious irq in Linux

Sumit Garg (1):
       mmc: msm_sdhci: Add DLL control hook to disable DLL below 100 MHz

Swathi Tamilselvan (1):
       clk: qcom: sa8775p: Add QUP serial engine clock support

Tom Rini (1):
       dragonboard820c: Stop disabling device tree relocation

  arch/arm/Kconfig                                   |   1 +
  arch/arm/mach-snapdragon/capsule_update.c          |  28 +-
  arch/arm/mach-snapdragon/of_fixup.c                |  40 +-
  board/qualcomm/google-pixel.config                 |   5 +
  configs/qcm6490_defconfig                          |   2 +
  configs/qcom_defconfig                             |  18 +-
  configs/qcom_qcs615_defconfig                      |   4 +-
  .../{qcs9100_defconfig => qcom_qcs9100_defconfig}  |   1 +
  doc/board/qualcomm/board.rst                       |  20 +
  drivers/clk/qcom/clock-qcm2290.c                   |  29 +-
  drivers/clk/qcom/clock-sa8775p.c                   |  82 +++-
  drivers/clk/qcom/clock-sc7280.c                    |  12 +
  drivers/i2c/geni_i2c.c                             |   4 +-
  drivers/mmc/msm_sdhci.c                            |  40 ++
  drivers/phy/qcom/phy-qcom-qusb2.c                  |  14 +
  drivers/phy/qcom/phy-qcom-snps-femto-v2.c          |   2 +-
  drivers/pinctrl/qcom/Kconfig                       |  36 ++
  drivers/pinctrl/qcom/Makefile                      |   1 +
  drivers/pinctrl/qcom/pinctrl-qcs615.c              | 473 
+++++++++++++++++++++
  drivers/power/regulator/qcom-rpmh-regulator.c      | 220 +++++++++-
  drivers/smem/msm_smem.c                            |  56 ++-
  drivers/soc/qcom/rpmh-rsc.c                        |  89 ++--
  drivers/soc/qcom/rpmh.c                            |  38 +-
  drivers/spmi/spmi-msm.c                            |  19 +-
  drivers/usb/dwc3/dwc3-generic.c                    |  32 +-
  drivers/usb/gadget/Kconfig                         |   4 +-
  drivers/watchdog/qcom-wdt.c                        |  23 +-
  include/configs/dragonboard820c.h                  |   1 -
  include/soc/qcom/rpmh.h                            |   4 +-
  include/soc/qcom/tcs.h                             |   1 +
  30 files changed, 1195 insertions(+), 104 deletions(-)
  create mode 100644 board/qualcomm/google-pixel.config
  rename configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} (93%)
  create mode 100644 drivers/pinctrl/qcom/pinctrl-qcs615.c
