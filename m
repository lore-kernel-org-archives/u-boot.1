Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D63DC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 18:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752B980104;
	Sun, 16 Feb 2025 19:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jr1TjcyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AB8808B6; Sun, 16 Feb 2025 19:17:05 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C97080077
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 19:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54622e97753so78039e87.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739729823; x=1740334623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ijLJXoQ6AGLOKs3VqPiLbHFiY4FhiIyrmm7GPaBCHPs=;
 b=Jr1TjcyFOviH/YlKppdFdmaTibWvmrHVIrzCbDUL8QiuScHYBWYuiulDpliXIUoEqI
 M2OF8giyJwjH4S8jr/KaATUtMq1wzYiPvXo4OMSoIIYHvEsZhR6uBcTrgpw7p8sCLTmT
 4NUCtqTEDYKx67Le0gE5IB0ExEXzLFHpdteoeuX/35tiF9o6Oa8elNAgQ0PgVSgukvFX
 arzc9nNqWoL3rWEtHK04PVKyvb0BBvPYn9+2gMFz/LTF7Iyq4QtywBMlAA37It//Hzz5
 CmMmZjOGlsBKPtbewMVDuegy/GpRIbMXmw8O21rdNvxPGxtumhlLUJoGsApXGom/6CY3
 531w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739729823; x=1740334623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ijLJXoQ6AGLOKs3VqPiLbHFiY4FhiIyrmm7GPaBCHPs=;
 b=lJDPnO8AjGSSucHBaY8pQO13L7ANnuLQPt6beKM+NOlL0/491OLsoB4wanDRbTUxV3
 8infs4u8DK4WKwdEoLdAYS3HWPoZh9fhXsG0e58bvfwwwZvry2yZj626VQjesjQGUqVs
 qtfQ098wA0AfFBTPC+sQrj6FbOnID3+y+3x0xO2fktTGjH0JAh+ywYEPxhkdsksKaD6X
 U2Fl+KwhloZ0R5pXtF/bATbiIKoW1r1gYpvHge6ohC8DPySnLNSNetYHxzpY9o4fnltF
 bv+RjoYBd5uMavA6JcSkn8TcRrWp/FPplw3dD+QY7ph7xdM1QdR+IM4Yd4idTMNlQzDd
 R6Fw==
X-Gm-Message-State: AOJu0YzuRHHCVbjA0qMW4mkYG2kHY9dzk5TllwvagtHp8X0P8D7GXSVp
 7Zls1XRchCnLBoaC2mZt9D5Tu3aCtQxnLIyE7qEBzkzECT7eSXD3
X-Gm-Gg: ASbGnctv2dCvixEczTK5bYaSrC2aKMd4X0bRz6X4v0IknGEI+ZupuOJXzC20bAgCNaL
 h2F8jh1L7NBb+SqmAWe/4m6imU99qvG4YpuZEpkGyC6hxXNxDQH/O/5O5vwMmguDzBECzEj2uaF
 da0OP5g6cRpQM1ivVPdJsefVPiWIHCelGrK6y0NET5MvjiT8r2wMzaohi5nyFKBKG+9Bv8Evm/G
 1E+AVQA7tevh/HZydUui+qnB8DfBZX7KYyyGAGn7GchtGyVD98/N01nuMit5YBR79R1FLfylQ9B
 ObJU34E=
X-Google-Smtp-Source: AGHT+IGoWzPWMqBCXcBldoPoNnQrCh42GXWZA1BHTQ4W3uqoBsdBSSM68RWqJxuyzfhQ0Pc/pjKM9Q==
X-Received: by 2002:a05:6512:b12:b0:545:a70:74c5 with SMTP id
 2adb3069b0e04-54530327a4fmr1966247e87.13.1739729822421; 
 Sun, 16 Feb 2025 10:17:02 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-545243fdfb6sm1078624e87.218.2025.02.16.10.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 10:17:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] tegra20: add Acer Iconia Tab A500 support
Date: Sun, 16 Feb 2025 20:16:40 +0200
Message-ID: <20250216181641.194424-1-clamor95@gmail.com>
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

The Acer Iconia A500 is a tablet computer designed, developed and
marketed by Acer Inc. It is powered by 1 GHz Nvidia Tegra 2 processor
and 1GB DDR2 RAM. The A500 is sold with 64 GB, although both 16 GB
and 32 GB models are available.

All important functions are implemented, including:
- installation as primary bootloader
- panel support
- booting from emmc, sd and usb
- fastboot
- bootmenu
- self-update feature

Svyatoslav Ryhel (1):
  board: acer: picasso: add Acer Iconia Tab A500 support

 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 +++++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
 board/acer/picasso/Kconfig                 |  12 +
 board/acer/picasso/MAINTAINERS             |   7 +
 board/acer/picasso/Makefile                |   9 +
 board/acer/picasso/picasso.c               |  57 +++
 board/acer/picasso/picasso.env             |  18 +
 configs/picasso_defconfig                  |  83 ++++
 doc/board/acer/index.rst                   |   9 +
 doc/board/acer/picasso.rst                 | 125 +++++
 doc/board/index.rst                        |   1 +
 include/configs/picasso.h                  |  23 +
 13 files changed, 858 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 board/acer/picasso/Kconfig
 create mode 100644 board/acer/picasso/MAINTAINERS
 create mode 100644 board/acer/picasso/Makefile
 create mode 100644 board/acer/picasso/picasso.c
 create mode 100644 board/acer/picasso/picasso.env
 create mode 100644 configs/picasso_defconfig
 create mode 100644 doc/board/acer/index.rst
 create mode 100644 doc/board/acer/picasso.rst
 create mode 100644 include/configs/picasso.h

-- 
2.43.0

