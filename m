Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54222C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79DE84A81;
	Tue, 30 Jun 2026 15:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q6LEIGUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAB584A72; Tue, 30 Jun 2026 15:10:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F6384A5F
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so38646635e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782825051; x=1783429851; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmGUBD546QwKwVTtQ0MFWX7l1NFkEGRHIPaT+GQ2XFQ=;
 b=Q6LEIGUQX8tr6zOeyergYhYixR83tL0iR1UtTbe+EGKsAeL5IQbDS/nvh9p+0F0LHq
 AENlu/JDPIQ0gLtsLlzqFig0yi2BsOvNc1xAhi4eKoMe36pDexK7vLiuoGfl0RwMjVxZ
 ZYdgjtKsQBDGHRtj7fNM10Y92QC0DK7HYpgoIgCtsHvG3a57lRuGUarqyfhCUYAOSbez
 UUx3kT8Y6qvpNMj97E61iiWwpByq/AydmjxgFpK7/MGZoMf7G03z2jbjaBURrtvYvXO7
 wjnc1cdIvaoQ6f09/hlytdYOZUM0+hd5gY33TuTRWCh9023IT9ztYKC7VGX/0/WTKe+O
 ZazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782825051; x=1783429851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lmGUBD546QwKwVTtQ0MFWX7l1NFkEGRHIPaT+GQ2XFQ=;
 b=RRRg4jMBrfUdECGOuqnCHhxlUSoc4R9trKTxwegYcmv6yK3v/zVRbaU9k3QhJbas2k
 F4RAPQsFoV4ZfxLKU2Fz0J1VMZ8Up+PXVBvxyYHoXnvHFkboXLZxPk2N5n6mWm9tjwb9
 rXh+e4hzoPz/e4Ja4Kr6Hxg00TX6wsb6r2Jc20+lx+sqZqC1OflO+lzpP8ztnBAMtJPq
 4G7sIz4nrZi/X0fw0rT11awhJBQ1yIPAjvEqWAFcDgeHMtyIrQnz0fmWOypns5moajvB
 KAJ7kwhChFRU+AL2vdTS9B/m7gsMpB/24b5511xjjhrdD4tZ3gdXUimVOoP+55B3x+PV
 Vfug==
X-Forwarded-Encrypted: i=1;
 AFNElJ81t3AviD086SMGzlJBeHUu4dtm74n6u9MWK2+GZX1TL846nPy5Dr+D8zgmg3Xpa3WcUDdVw50=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1HCGfJiLSaV7yusdhjI4Iz4iZfvd/HUQxR5aiUYNIq1sAY5Me
 h0Zb8vWjyngLj7XkQSqEppHVaKOdbO+HPA5epU1CXE757YNVR/+2UKZXPU+QjP4qIUg=
X-Gm-Gg: AfdE7ckfjD02PaOTgHO41REsWs93+qFrvW/d7UWiMslKWOQjd2riFUqOZp20PaB897U
 ym+1yp/Wwke7vBuuy4JDNt5AoayUDhIclut0xlO0WXP13FAYNl0mXT7HDEUFQMiSZy6FpVg6w2c
 HERx9gAAHB/flxHRjitAjURQgK8RZap+uNnggzfEgXQS1jRGLT+JbwbJaM78CE+3c9mBn5bG97A
 MpepW29qIhU1KnKKSq/QtCbfxfFrQwTVv4Ko2mmqMh9S04eqI1hPtQaqkgnnPlaguwWvAHLy/SZ
 Xb7gnnr7IFu9FcZ3TQEhd7Ry8XUiR+SxuVTFb7M5HtYXTa146XPJTBaAWekbQ4WEEeDC66qWRVn
 R24cztqeNxaybjPW21P8eSB6ypwH92uZFbnvj7ACvS+oqiYCQo6HZUw8cGdcmVWmpsee/oATPFy
 0BumcfWPa1HNRlgZWC1txSCsgLle4=
X-Received: by 2002:a05:600c:c16f:b0:492:28be:6098 with SMTP id
 5b1f17b1804b1-493b828706fmr47649385e9.11.1782825050532; 
 Tue, 30 Jun 2026 06:10:50 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bc7c91d1sm23493865e9.0.2026.06.30.06.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 06:10:48 -0700 (PDT)
Message-ID: <a022e174-5542-4720-9978-9f76075a7782@linaro.org>
Date: Tue, 30 Jun 2026 15:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] spl: ufs: add UFS boot support for Qualcomm
 Snapdragon in SPL
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Tuyen Dang
 <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Alexey Charkov
 <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>, Javier Tia <floss@jetm.me>,
 Rasmus Villemoes <ravi@prevas.dk>, Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:39:51 +0200
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


On 6/15/26 08:59, Balaji Selvanathan wrote:
> This series adds UFS boot support in SPL for Qualcomm Snapdragon
> platforms, along with the necessary driver and infrastructure
> changes to support it.
> 
> Patch 1 renames SPL_UFS_SUPPORT to SPL_UFS for naming consistency.
> Patch 2 renames SPL_UFS_SUPPORT to SPL_UFS for defconfigs.
> Patch 3 adds a Kconfig choice for U-Boot location: sector or partition.
> Patch 4 refactors spl_ufs.c to add partition-based U-Boot loading.
> Patch 5 enables part_get_info_ptr() in SPL for UFS partition boot.
> Patch 6 adds UFS_MODE_RAW and UFS_MODE_FS defines to spl.h.
> Patch 7 adds SPL_UFS_QCOM to enable the Qualcomm UFS HC driver in SPL.
> Patch 8 adds SPL_PHY_QCOM_QMP_UFS to enable the QMP UFS PHY in SPL.
> Patch 9 adds SPL_CLK_STUB Kconfig for the stub clock driver in SPL.
> Patch 10 updates charset.o build rule to use SPL_UFS after the rename.
> Patch 11 adds SPL_QCOM_GENI Kconfig and $(PHASE_) support for GENI.
> Patch 12 adds SPL_PINCTRL_QCOM_* symbols and $(PHASE_) Makefile
> support for all Qualcomm pinctrl drivers.
> Patch 13 adds SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig and
> $(PHASE_) support for Qualcomm serial drivers.
> Patch 14 updates Qualcomm PMIC and SPMI Makefiles to use $(PHASE_).

We can read the list of patches below, you don't need to provide a 
reworded summary. Your cover letter should provide context and justify 
what this series is doing, etc etc... there is plenty of documentation 
around for writing a good cover letter.

What it should particularly include in this case is an explanation as to 
how it fits into all the other SPL related series ya'll are sending. Can 
they be picked without this? Do they depend on this series (none of them 
seem to indicate that).

There's also random stuff that isn't UFS related in this series. With 
the volume of patches you guys are sending you need to put in at least a 
bit of effort to offer some cohesion for how they are all meant to fit 
together.

Please clean this up and stop expecting maintainers to do all the work 
to get your patches into shape. You have plenty of colleagues at 
Qualcomm who know how to contribute to the kernel/U-Boot, ask them for help.

Thanks,
// Casey
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Simplified partition selection logic in ufs_load_image_raw_partition
> - Removed spl: ufs: add SPL_UFS_FS Kconfig and filesystem boot stub
> - Link to v2: https://lore.kernel.org/u-boot/20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com/
> 
> Changes in v2:
> - Renamed SPL_UFS_SUPPORT to SPL_UFS for naming consistency.
> - Added SPL_UFS_RAW_U_BOOT_USE_SECTOR config to clearly choose between
>    sector or partition
> - Refactored the codes in common/spl/spl_ufs.c to use helper functions
>    to make the codes readable and clear
> - Add the filesystem support in SPL UFS as a seperate patch
> - Correct SPL_UFS_SUPPORT config name in lib/Makefile
> - Added SPL_QCOM_GENI Kconfig and $(PHASE_) support for GENI
> - Added SPL_PINCTRL_QCOM_* symbols and $(PHASE_) Makefile
> - Added SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig
> - Updated Qualcomm PMIC and SPMI Makefiles to use $(PHASE_)
> - Link to v1: https://lore.kernel.org/u-boot/20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com/
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> ---
> Balaji Selvanathan (14):
>        spl: ufs: rename SPL_UFS_SUPPORT config to SPL_UFS
>        configs: rename SPL_UFS_SUPPORT to SPL_UFS
>        spl: ufs: add Kconfig choice for U-Boot location method
>        spl: ufs: add partition-based U-Boot loading support
>        part: enable part_get_info_ptr for SPL UFS partition boot
>        spl: add UFS boot mode defines to spl.h
>        ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build support
>        phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS boot
>        clk: stub: Add Kconfig option for SPL stub driver
>        lib: update charset.o build rule to use SPL_UFS
>        misc: qcom_geni: add SPL support for Qualcomm GENI driver
>        pinctrl: qcom: add SPL support for Qualcomm pinctrl drivers
>        serial: msm: add SPL support for Qualcomm serial drivers
>        power: spmi: use $(PHASE_) macro for Qualcomm PMIC and SPMI
> 
>   common/spl/Kconfig                 |  51 ++++++++--
>   common/spl/Makefile                |   2 +-
>   common/spl/spl_ufs.c               | 151 ++++++++++++++++++++++++----
>   configs/nanopi-m5-rk3576_defconfig |   2 +-
>   configs/rock-4d-rk3576_defconfig   |   2 +-
>   drivers/Makefile                   |   2 +-
>   drivers/clk/Kconfig                |   7 ++
>   drivers/misc/Kconfig               |  10 ++
>   drivers/misc/Makefile              |   2 +-
>   drivers/phy/qcom/Kconfig           |   7 ++
>   drivers/phy/qcom/Makefile          |   2 +-
>   drivers/pinctrl/qcom/Kconfig       | 201 ++++++++++++++++++++++++++++++++++++-
>   drivers/pinctrl/qcom/Makefile      |  46 ++++-----
>   drivers/power/pmic/Makefile        |   2 +-
>   drivers/scsi/Makefile              |   2 +-
>   drivers/serial/Kconfig             |  20 ++++
>   drivers/serial/Makefile            |   4 +-
>   drivers/spmi/Makefile              |   4 +-
>   drivers/ufs/Kconfig                |  12 ++-
>   drivers/ufs/Makefile               |   5 +-
>   include/part.h                     |   3 +-
>   include/spl.h                      |   4 +
>   lib/Makefile                       |   2 +-
>   23 files changed, 472 insertions(+), 71 deletions(-)
> ---
> base-commit: 1e80ee41441c612f05787a93bbef4e6e422e29d1
> change-id: 20260615-spl_ufs-5c2c4eb327aa
> 
> Best regards,

