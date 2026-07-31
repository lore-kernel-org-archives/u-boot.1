Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A672C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 262F44078E;
	Fri, 31 Jul 2026 16:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-766nkf7jWo; Fri, 31 Jul 2026 16:35:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23FC040685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515746;
	bh=joNbBvvbVJVinjWDRPLYVMUzSg+8Ew57MrqB4oL/FQc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UaDWvJU10YhoNPMBSupaUt9pXyhMOQ6BuldZo2Yd9DnFHaxiq9cHwlJMIbfOvhynI
	 7QUMx/wLlNYWH2Fv7EEDxt/QDCQiMVEgGZk5fEPWgfu2Bi8izgLMGeNNttLGQy4C5P
	 4MzLqomkl3Ba01nB/qPLyv4/k4ZaCstVMiDzIqqlQuf8tRBy/MOmDf6UjrtKsggPI9
	 G6+gXwr3I9lTB05Fj+AQyjxWWct+zKl0FWyRg1QArmb4X3U94zSyly+PTfOwSMa8iB
	 otqxKCCmVx38QxhUJ4qKMD0nApl3oDLoIMD2dfVN0HcmhQE6B/XSyrgPdEkoy2lOgp
	 2br9M1RftSqvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23FC040685;
	Fri, 31 Jul 2026 16:35:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70E8B36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62BD44008F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kyc4PJ-IanBr for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:33:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 16E6C40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16E6C40025
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16E6C40025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:49 +0000 (UTC)
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-9770fffa5a6so317523241.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515628; x=1786120428;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=joNbBvvbVJVinjWDRPLYVMUzSg+8Ew57MrqB4oL/FQc=;
 b=FgTFmDAQadLWjVnF2VicOPPJngHlKM2Tu+MT6s1O1SzDZu9PYvIp5bQJ12HRwWuDUp
 ddmViAagbMUUGJzzWQV2aZokbxCa4qfou4IkCKXdKtNbAqGgmAv0iS38fTlHXWrP7hR9
 deE4bmgCoY9TXZDeVhvbtUKKWJEx+qll7DhuPem4D0Lk984tvcFtBU2qk8zJn7/jiwhY
 8Ob01lTO/Ocw2cxzxpfXyme4BURaRR4zKHsdhqOmM1Dv6G+O9S6iW1wYKKWdA/TffNXr
 1o0aQ1f4mRCZf4EBLdPZHEQ6AqG+dCdXDERG/NuP4geFAy1ZkKbgnm4KMZ2//0cAM16t
 +hSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSBXZRSgSN8Emy0ZV/K0CsCCZ0bxOoLKXuoO6iHKbNWbP7MTtUhP3y8D1X3e2R0YZK1u16weE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxIkwx9OQCS9QmeGq6GLys6zgu0rvbafamqfxSW7GBsKEOeHiyW
 YTDfdg91UQ5Sd8jhiJwMPVc+S1JUd5Xj5AH8VwLoYJW04t3uC0q2thzCkK6+JNKbIDg=
X-Gm-Gg: AR+sD10B+E9DxHccYDTIulInoOySI3wN1oi/zqQ5iST4EDwNH6206tT94HqiusEiSu5
 S/1MViUf2S6lXQY2uSRpxrF5t20MHhrogUW7sf88b8AMlufpyRia2Vo+us3saYLtARNm+iLskob
 U4RpjspOXZKF+bOuhqlxMHQ1/eKMa9V0HxBEicajV8w3Q0afplZyv0JXAoCdZMFthWVXwvnEFM0
 blxXlTv1gs6IJ3Ccw36olh9L0u/nYiUlrJjGMtuhmx/eZ/hpzB1WBo/O1GGrE+oirsA8EI23tco
 pO34e/b2qeoksnCAW9+3e54/qjNKMELpWA4fzl5mKYC5mGKhMX8jjUKCAkgX29RwVOrZviRSdPR
 9Qnh02Buyc/r0uvJVqk0Iqc3M60d3kKyDwEY7XPRRs91zVuvn4MqfQuMd37fKMYsptJtuUCKU0m
 AaZuV9EGwUWxrHP+BPRaD72VLMzNISPVeMjaOTqQS1OLiAf74r+R9TSSMm1tRBNT8DSM2fpKPZr
 Ixy4ikXiC76yArwHI1lYEPj9OqcbYhIrujoAcbx6sSJmn/F5iHEYOwSbd57
X-Received: by 2002:a05:6102:b0f:b0:739:5f55:3c3c with SMTP id
 ada2fe7eead31-75b238606fdmr703063137.13.1785515628537; 
 Fri, 31 Jul 2026 09:33:48 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:33:48 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH 00/17] Renesas RZ/N1 additional drivers
Date: Fri, 31 Jul 2026 12:33:29 -0400
Message-Id: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnObGoC/yXMyw5AMBBA0V+RWZuk6tHwK2LhMWUsSlpENP5ds
 TyLez04skwOqsiDpYMdLyYgiSPop9aMhDwEgxSyEEqmaC+T4CsUCmWuinJQusy0hpCsljSf365
 ufru9m6nf3gfc9wM228l/cAAAAA==
X-Change-ID: 20260723-rzn1-2026-07-25769d7f94ff
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=3010;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=MUR/D3vi1NvDqoz2tV/adESi/1VbWZ1uwmZvo1PWumw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFGfk9dcu8V7SrcKgTVm7+mAuT6teX6+2V3Z2YXroVv2VH+4Jib4LW1/OHiA8t/ymns9Ggi96es
 +C9+0MmT8Pg0=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515628; x=1786120428;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=joNbBvvbVJVinjWDRPLYVMUzSg+8Ew57MrqB4oL/FQc=;
 b=zGzIa6tL+zX78+J/515K3x0erPe2SK0zrHbNk/h5o2LIt3bDc5ZVhbSt5Zobr4IWai
 pNpyb6T+IEl9oxN0KUJxGviGIrGaYofkIkGeiNHv2McQ/mljnShd8/xmIGpzuenXLrl4
 x4VASHbcwfjbpZTPH6I021SqsljsfHxyY1Zk5dgaQwmd84HEEYhrdaD79LXnst+hz6Fe
 ZRrU36kkPopKxDxRerqr/zFrSS2rGPSD5Zjz1b3dPw3nEhFKI65rTPgmUfA7yrZs+UVC
 7uu6EUfSNAYcnP2bXpgRH7ukqkofcXD35YUPOhdK3dX5tKaM7ICIX3kB0CrOXL1cCcii
 +Ghw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zGzIa6tL
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable many more of the peripherals found on Renesas RZ/N1 SoC,
including GPIO, MMC, QSPI, NAND, Ethernet GMAC/switch/converters.

This builds on top of the basic support that was added in May 2023:
https://lists.u-boot-project.org/pipermail/u-boot/2023-May/518098.html

It has been tested on the Schneider RZ/N1 board, including support
for USB (DFU/fastboot/UMS) using the driver from Romain Gantois:
https://lists.u-boot-project.org/pipermail/u-boot/2026-July/623625.html

This patch series is based on v2026.10-rc1.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Ralph Siemsen (17):
      pinctrl: renesas: r906g032: handle pin subgroups
      spi: cadence_qspi: enable clock
      spi: cadence_qspi: Use APB write protection
      gpio: dwapb_gpio: Enable all clocks
      net: add r9a06g032 A5PSW switch driver
      net: add r9a06g032 MIIC driver
      net: designware: add r9a06g032 compatible
      mmc: zynq_sdhci: support Renesas RZ/N1
      mtd: nand: add Cadence/Evatronix NAND flash driver
      board: schneider: rzn1-snarc: set serial number
      board: schneider: rzn1-snarc: add rzn1.env
      board: schneider: rzn1-snarc: update MAINTAINERS
      ARM: renesas: RZ/N1 QSPI controller features
      ARM: dts: r9a06g032: sync with upstream
      ARM: dts: r9a06g032: add QSPI controller
      ARM: dts: r9a06g032-rzn1-snarc: enable new drivers
      configs: rzn1_snarc_defconfig: enable new drivers

 arch/arm/dts/r9a06g032-rzn1-snarc.dts  |  390 ++++++++
 arch/arm/dts/r9a06g032.dtsi            |  283 +++++-
 arch/arm/mach-renesas/Kconfig          |    4 +
 board/schneider/rzn1-snarc/MAINTAINERS |    3 +
 board/schneider/rzn1-snarc/rzn1.c      |   25 +
 board/schneider/rzn1-snarc/rzn1.env    |   21 +
 configs/rzn1_snarc_defconfig           |   76 ++
 drivers/gpio/dwapb_gpio.c              |   11 +-
 drivers/mmc/Kconfig                    |    2 +-
 drivers/mmc/zynq_sdhci.c               |   39 +-
 drivers/mtd/nand/raw/Kconfig           |   12 +
 drivers/mtd/nand/raw/Makefile          |    1 +
 drivers/mtd/nand/raw/evatronix_nand.c  | 1645 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/evatronix_nand.h  |  407 ++++++++
 drivers/net/Kconfig                    |   12 +
 drivers/net/Makefile                   |    2 +
 drivers/net/designware.c               |    1 +
 drivers/net/rzn1_a5psw.c               |  377 ++++++++
 drivers/net/rzn1_miic.c                |  193 ++++
 drivers/pinctrl/renesas/pinctrl-rzn1.c |   15 +-
 drivers/spi/Kconfig                    |   11 +
 drivers/spi/cadence_qspi.c             |    1 +
 drivers/spi/cadence_qspi.h             |    6 +
 drivers/spi/cadence_qspi_apb.c         |   27 +
 include/configs/rzn1-snarc.h           |    5 +
 25 files changed, 3542 insertions(+), 27 deletions(-)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260723-rzn1-2026-07-25769d7f94ff

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

