Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC7C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 21:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A8E887B4;
	Mon,  5 Aug 2024 23:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMcjjga/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BAA88747; Mon,  5 Aug 2024 23:25:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D0E884CA
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 23:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3686b285969so5713240f8f.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722893119; x=1723497919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig4wduSpXc3hMf1/euKsoNEKcaL2bGYbSzmCcdBk/NY=;
 b=NMcjjga/YhEWmZ5Kxjp9ks+Jrei1cpjiMdImZl87s3ej+Ictb0ihaZhdarYVLr1uxC
 RFISF4gVd5EGPa6hOQAS8dpaVoKhI8ZHWOYkDZgzvseBjn8B1N/ZgW/x/n8uNYZ3yXEf
 zgAvdwAFLYw2j00+1aFTjC08x4Qpgll0KO3H4YwBs15pnQrKgUg+LczvDOI/jBtfIKCY
 d+5yhr1JcJm1x9EWJSzpyzvTKvUTniP1AyL2LNWqj2RQsxPDd8w9Ib8iQmJSK/BwyEnI
 QMVkLszMUa92LvP5loFQjurm8abt++W0UslwEEJKL0+5V0RynAezrpPGaz6WN1+8tYCI
 2C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722893119; x=1723497919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ig4wduSpXc3hMf1/euKsoNEKcaL2bGYbSzmCcdBk/NY=;
 b=cyafHybl6CSNdCeHinFsob1Ob4e7Refl3Wkd4Nyp/7XYBaZ50cIc8/8cpUk817EdWR
 TBTk105hPmx0yJ8UyhlTnCxNtsNHmvkX4XwPLnAkr1JztH7u2+XFCaAnOG4wejor2LKR
 gVQeQrZG4I1ykLEdpunim70HE2SepO6s/wG8D+prdMBhXYT+FNJZzAGp4LoYJNyKQSH3
 AVdffcDr/CiCeI6a5dYjEmKKxSs6HJ8MXyJZITDbvnUEYf0SP2Ui0FJpcgH6u2p9aqNc
 DCAKdqrPDSK8kFNY9BGUT92vVjSkj6INp0LUHdfNQIZS34n+cXrpS9HjbiwmK77K0efm
 K6eA==
X-Gm-Message-State: AOJu0YzqgSucdc75XHze9TTkXtVXWvSUEh0uG6XuYiJPZ0w4vJLgV4RN
 oCh+R9FXSHxfr8rsi1AxnpPELAowL3ovw8ZZboq8fgM8IxKyw962M14x6g==
X-Google-Smtp-Source: AGHT+IHPT4TK/2kk8O/vYFT473frsZbZNzxZJKovCIND4YwfWFJ2IoF7UfdP42aYOHkZ2cr5KYTJeA==
X-Received: by 2002:a5d:6291:0:b0:368:3038:8290 with SMTP id
 ffacd0b85a97d-36bbc14ecfbmr10423287f8f.39.1722893118739; 
 Mon, 05 Aug 2024 14:25:18 -0700 (PDT)
Received: from p1g2.lan ([2001:861:3201:3d10:ab7b:e9dd:27f4:647d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c33bsm11018351f8f.22.2024.08.05.14.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 14:25:17 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH v2 0/5] imx: imx8ulp: add binman support
Date: Mon,  5 Aug 2024 23:25:06 +0200
Message-ID: <20240805212511.653667-1-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805124326.544310-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
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

Hi,

This series adds binman support for i.MX 8ULP processors.

It required to update the imx8mkimage tool a bit as well as adding new
container configuration files. But otherwise it is pretty close to what
has been done on other i.MX processors like the 93.

Changelog v1 > v2:
- Add reviewed-by tags from v1
- Fix commit log order of patch #1 (request from Peng)
- Fix indentation of patch #5 (request from Peng)
- Add doc on how to build a bootable binary (request from Fabio)

Regards,
Gary

Gary Bisson (5):
  tools: imx8image: fix soc variable for ULP
  tools: imx8image: add upower image support
  spl: binman: Disable u_boot_any symbols for i.MX 8ULP boards
  mach-imx: Add i.MX 8ULP binman support
  imx8ulp_evk: enable binman support

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/imx8ulp-u-boot.dtsi        | 63 ++++++++++++++++++++
 arch/arm/mach-imx/Makefile              |  4 +-
 arch/arm/mach-imx/imx8ulp/Kconfig       |  1 +
 arch/arm/mach-imx/imx8ulp/container.cfg |  7 +++
 arch/arm/mach-imx/imx8ulp/imximage.cfg  |  9 +++
 common/spl/Kconfig                      |  2 +-
 common/spl/Kconfig.tpl                  |  2 +-
 common/spl/Kconfig.vpl                  |  2 +-
 configs/imx8ulp_evk_defconfig           |  3 +-
 doc/board/nxp/imx8ulp_evk.rst           | 79 +++++++++++++++++++++++++
 doc/board/nxp/index.rst                 |  1 +
 include/imx8image.h                     |  1 +
 tools/imx8image.c                       |  7 ++-
 14 files changed, 176 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/imx8ulp-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx8ulp/container.cfg
 create mode 100644 arch/arm/mach-imx/imx8ulp/imximage.cfg
 create mode 100644 doc/board/nxp/imx8ulp_evk.rst

-- 
2.43.0

