Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C68AC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54B082BF6;
	Thu, 15 May 2025 16:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ly8do2vN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629AA82C13; Thu, 15 May 2025 16:55:55 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F1182AFC
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so568169f8f.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747320953; x=1747925753;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/mYbTrlML1elgKVNqKlkiCK5K75EQ4TVHJxMUUMuusg=;
 b=ly8do2vNtD0J/yrhq0Xk/vOQxFDPz3FX1drxitq+FKC01DaUzV/vWEBZ9GRlS25fru
 BMcCTVUbmU29OuWhvaX0mVpxWzbET7omuaYZSHwlZT1HmN4xbdxuRZ3dMtYlNFRvO9wt
 io4GjRGCY0HR8TFeTPfcxWFuHEgI7SwHT26Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747320953; x=1747925753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/mYbTrlML1elgKVNqKlkiCK5K75EQ4TVHJxMUUMuusg=;
 b=GeV8ntIKpDJN3px1zs3dRsVuf1wbTfvsQBqVT9OqDmvyE9z6Mz7jHR2k5lvHa/c6KX
 EISuX1vaptPiud4eVGV/RfQGHYZlY1bGmFQm4VcLA317AmheuEU6PSztS9HNhuJjiAB+
 km+R9+My9jyuaoYuRF6iHtIJEvoNus4lDXUYJSoVADxh1tGcdRcJmUdi+5BmxQ0JV8AM
 pGiHchKqqw9gq+XEHyrVmv/g6CBP8OA1Ja5zHG+7g3BvDtoA8QF6aqtqafLVNqg6RECg
 b5OocKLX+O79/C3oY28QZ2ry8GdeJpKEnosJSU+IoxdmswUnwgHfQR0mVRvXs2qACo7M
 XJQg==
X-Gm-Message-State: AOJu0YyoklmZ3Lpj1rZNSQ2Br31jYEAKP1ftlBIPRbgbr22L6wkEKNCG
 e/deDcT8RX1OOxvNc1M/WCi6q28jmHEQWcWNF6hf+MpymOQQRoa/z2WyQLwoCN4AHm4FH7ec7iJ
 fFpODPTrR3w==
X-Gm-Gg: ASbGncv96nY4sTH+xZyjw+TAmuM00iXUCkH1+Z3kYpwW7qck+xFu8/JzE+7qrpMtixN
 k9F+inWRTFbxloZalnvsXMf5l6Iobh1PEj1uNMPa7Z01vYH0a/uUOSfki2g65E3PuPykywB9ill
 GnZeBucQBsu+NNgcVQFNrC/1S8by6Xa3KJObfSHd9CH0IeTtMTHaqgsPm6mu0bPJpppkNuvWa7P
 gpCl3tad4zsZR9ugk5GRPS2zY+kPN+uoIyhObnxgxgQvbtvpOn5IV+50RGqDk84pGtwjStRbLPs
 Ciqr91U8S8AtbUcvp5vazk6ddJq9qwN6sk0skbh6p88qd2KqhXzM2xZfDxkdm0XRCN1hgDM9ETT
 NkwVIcUHlcPi0gLIfIgcJ2LJSgxRKUuFtrd80DqNIrnY=
X-Google-Smtp-Source: AGHT+IHzJF3mnACZhtCC6HOf9kM+KTkPa9YG2K2L0peyqTiiMqbxNE7zRG/5GijP8wxPlHIa2mbOrg==
X-Received: by 2002:a05:6000:2387:b0:3a1:f684:39a7 with SMTP id
 ffacd0b85a97d-3a35c7e7e07mr107034f8f.0.1747320952646; 
 Thu, 15 May 2025 07:55:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369138sm77030235e9.8.2025.05.15.07.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:55:52 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [RFC PATCH v2 0/4] Restore imx8mn_bsh_smm_s2 properly booting
Date: Thu, 15 May 2025 16:55:33 +0200
Message-ID: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commits [1] and [2] broke the booting of the BSH SMM S2 board. The
patches in this series restore proper booting.

[1] 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
[2] dda454e933c6 ("serial: mxc: Support bulk enabling clocks")

(no changes since v1)

Dario Binacchi (4):
  spl: Kconfig: support U-Boot load from raw NAND
  imx: spl_imx_romapi: support raw NAND sector
  configs: imx8mn_bsh_smm_s2: load U-Boot from raw NAND
  serial: mxc: restore booting for imx8mn_bsh_smm_s2

 arch/arm/mach-imx/spl_imx_romapi.c  |  8 +++-----
 common/spl/Kconfig                  | 15 +++++++++++++++
 configs/imx8mn_bsh_smm_s2_defconfig |  2 ++
 drivers/serial/serial_mxc.c         | 23 ++++++++++++++++-------
 4 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: bsh-s2-break
