Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA9AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A3182F85;
	Mon,  7 Apr 2025 20:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UuPeDe8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBC582CFD; Mon,  7 Apr 2025 15:04:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8883D82CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so29440865e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744031090; x=1744635890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A+7tKBY8DftrAAxLOTJlhJBLwAVZT0N4n7ISMuqZ4kg=;
 b=UuPeDe8WQVKRKTcook9+P2AIci5+63lQeqM1P5QS21cFPlDpEgCIIqWACmNN9s5VE4
 vh+ZkUYyIFEzpcdr/zv/xVh8ztHg6F55jB16dAtz6YXwGtCn95Rsua1a66dj1Iaf3paU
 nixqxcZzaIodB3M0bhDUVCx7vxk2C9A/SL0f0kToqhwd8N0/XANYei6LwYr1dOnU6S0c
 Au7fhMFSBop5LRYCEdXkugt9Q/1/5zey3igtxR7dXHVV03uPw20qbJZCvqa916UmthN1
 w5avVR2QwMcgP9Ic5GHMvwX/fBI+7DTlODu1CmpCg5ZHBFoxNCG7AgtpAtkuGSKJv3om
 GCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744031090; x=1744635890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+7tKBY8DftrAAxLOTJlhJBLwAVZT0N4n7ISMuqZ4kg=;
 b=c702joxPqllC9SMMWwC7DsNhPoB34DVTutMMqdeL1TCz+87VZuQf2nTNDhCXx4+7YX
 azmGfhErfmYMlWPElKtRoHpKBlY5tDGGNJoUdkcS47SpqsX/vy06tn61WOsbMGdLz8CT
 hvEy3S2CzxPig6SPbqhcYuoj2xCY1s2dv8PsrfYs/kEFdBUZ+Yog6ibPT/Aew1oY4AP+
 2lUIf8PfSXDX69WIlMAyQv/EBvMaJxjmsw50gVWPviAEkBgx/JM/6rB9snZf/lYQVktr
 WkQNlJrATR1MILm2ZdwPOOmS5yTu67wkCWZokyNwKfzTUwjV8y37nN+0mmNgV48hQMBO
 ICJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+a3BHbiqEb8ClqqOd2v6rHQwM2X3qAnR4+zzLrKoOMfpZ5m8bIYQCmwc+qlz5zGaBHHzbE1c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0/L2A7KP0Ner/igMnAdelNXBmRM0ay+wpxXB+1sjhZFxvBlK2
 3zMO63WPirOyBd7Wu6NwfE7RjrpWBEmXXJGmD+z/cA6yFaAFBtBk
X-Gm-Gg: ASbGncv1GWUlGsmGk2ORqIAgLxwWu8vSgYONj0eP/hTeYwfAu/k1lWkmXUe8kcGxV79
 jeqfsOxmbIsGrCeUxgr8RXXpcmQJvP2N2bjOQQi3u15wvv/f/qrJeG/TJ0lR8b6SNZdznIPvGcl
 XVtCdZL8syuS2l49qLnf+9ns0k0WOagNkT1iVskWSk3jA6bAxo1+QtcgmYkrBbgV3jZEPSS1pyH
 HV/OSGGpW2iukn3E4ajJk+l9W11+CuQmHaB6bjIgVhE6yogv5nUAojd4AZbMCtleRr1Z5bjDqC5
 vbMuBrDuhTujMXKZgs8WmbuCd78gGMzLo/ac60kL4A==
X-Google-Smtp-Source: AGHT+IE/4d/3uzHJWlEAIMoy3MdMbm2qjMLQ2uRjGFUe2KfSSx7FJjKUW4a8zqe3qDZW5g8jN/Wd/w==
X-Received: by 2002:a05:600c:4755:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-43ecf85f22emr141232605e9.10.1744031089645; 
 Mon, 07 Apr 2025 06:04:49 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:96ff:4d69:f7ba:e072])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795db7sm135931445e9.25.2025.04.07.06.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 06:04:49 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1 0/3] Add support for Toradex SMARC i.MX8MP
Date: Mon,  7 Apr 2025 14:04:33 +0100
Message-Id: <20250407130436.223645-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:00 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

This series adds support for the new Toradex SMARC i.MX8MP
System-on-Module (SoM), along with necessary
updates to Toradex config block and device tree synchronization.

  1. Syncs imx8mp.dtsi with Linux v6.15-rc1;
  2. Introduces Toradex SMARC iMX95 8GB WB IT (PID 0096) in the config block;
  3. Adds the initial board support for the SMARC iMX8MP. The board will be
     moved to OF_UPSTREAM once the DT has been accepted upstream Linux [1].

More information on the SoM and carrier board can be found here:
    https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx-8m-plus
    https://www.toradex.com/products/carrier-board/smarc-development-board-kit

[1] https://lore.kernel.org/all/20250404105359.18632-1-ivitro@gmail.com


Vitor Soares (3):
  arm: dts: imx8mp: sync with Linux v6.15-rc1
  toradex: tdx-cfg-block: add 0096 Toradex SMARC iMX95
  board: toradex: add Toradex SMARC iMX8MP

 .../dts/imx8mp-toradex-smarc-dev-u-boot.dtsi  |   80 +
 arch/arm/dts/imx8mp-toradex-smarc-dev.dts     |  297 +++
 arch/arm/dts/imx8mp-toradex-smarc.dtsi        | 1284 +++++++++++
 arch/arm/dts/imx8mp.dtsi                      |  413 +++-
 arch/arm/mach-imx/imx8m/Kconfig               |    7 +
 board/toradex/common/tdx-cfg-block.c          |    2 +
 board/toradex/common/tdx-cfg-block.h          |    2 +
 board/toradex/smarc-imx8mp/Kconfig            |   39 +
 board/toradex/smarc-imx8mp/MAINTAINERS        |   10 +
 board/toradex/smarc-imx8mp/Makefile           |    9 +
 board/toradex/smarc-imx8mp/imximage.cfg       |    6 +
 board/toradex/smarc-imx8mp/lpddr4_timing.c    | 1903 +++++++++++++++++
 board/toradex/smarc-imx8mp/lpddr4_timing.h    |    9 +
 board/toradex/smarc-imx8mp/smarc-imx8mp.c     |   85 +
 board/toradex/smarc-imx8mp/smarc-imx8mp.env   |   20 +
 board/toradex/smarc-imx8mp/spl.c              |  130 ++
 configs/toradex-smarc-imx8mp_defconfig        |  184 ++
 doc/board/toradex/index.rst                   |    1 +
 doc/board/toradex/smarc-imx8mp.rst            |  116 +
 include/configs/toradex-smarc-imx8mp.h        |   28 +
 20 files changed, 4567 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-toradex-smarc-dev.dts
 create mode 100644 arch/arm/dts/imx8mp-toradex-smarc.dtsi
 create mode 100644 board/toradex/smarc-imx8mp/Kconfig
 create mode 100644 board/toradex/smarc-imx8mp/MAINTAINERS
 create mode 100644 board/toradex/smarc-imx8mp/Makefile
 create mode 100644 board/toradex/smarc-imx8mp/imximage.cfg
 create mode 100644 board/toradex/smarc-imx8mp/lpddr4_timing.c
 create mode 100644 board/toradex/smarc-imx8mp/lpddr4_timing.h
 create mode 100644 board/toradex/smarc-imx8mp/smarc-imx8mp.c
 create mode 100644 board/toradex/smarc-imx8mp/smarc-imx8mp.env
 create mode 100644 board/toradex/smarc-imx8mp/spl.c
 create mode 100644 configs/toradex-smarc-imx8mp_defconfig
 create mode 100644 doc/board/toradex/smarc-imx8mp.rst
 create mode 100644 include/configs/toradex-smarc-imx8mp.h

-- 
2.34.1

