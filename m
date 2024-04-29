Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427FAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 10:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED5D880F4;
	Mon, 29 Apr 2024 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LBlvPs/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8C58812B; Mon, 29 Apr 2024 12:35:34 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D19880B5
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2b0fb1b6acfso423994a91.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714386930; x=1714991730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=24FPPXkomO54c2P8bHBI9GH2AEEIvGBRk0BSauaCTsI=;
 b=LBlvPs/E0/aVMLyN/cULxGWvOE1IReqcFu3FmY4GuJprbD/+xobgH07L+HwOwksee5
 ijR4GKLSrEMdp8jfPN1Wr6ky/3AqDbVIo2hk9WpZdxeReh6Iz1dg5tFt3KKGeRkzWSZJ
 C3iTohbEp+rDXnHGwqq6kJPR+8pW2J3azjuyscVUd9bjYCjtf9n2DhX1embuxzeKgAsj
 /6UMs3Anr4mpQzQF7BIcmSdky3/1XbnBCHMcFexA+GJUOVQNFpGDGoSc27GjHuVs9C1z
 gwz0HOk0OVFwqGY2mrNbIXQackWvB+wnwHN9llnhmjBm+MKN/cb1N2D78h9juCDbb6rp
 34VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714386930; x=1714991730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24FPPXkomO54c2P8bHBI9GH2AEEIvGBRk0BSauaCTsI=;
 b=watAB6w7gEpPjhPvxkPLhjENpdAS+ADXzK6CtLxEnseFglR9q6iGGv4Kr4pXk9C2dh
 pzkfh83hN27FtgymdynTmW8NZBR/z9KaGoXWZ82k+B21jFFt8xKjFS/ogg9E7RYWHp4f
 Lfr3zEyhhrVxXNDIuyQ+0CiQS/3rf16/KeVF3DAn3t0uQ7XkRLhfz42doRsTErNS9IB9
 UBpDofc/TlJvf9pWy7boM/4eBCLmfarAiah5Vd3RhCcQKApujlf21VBc2F6V4XY01NiM
 RXIG90JCyZd98vUtFRpXAQoBecRh7pb4kmkj5FZVQ+cf7ymxzAwPj9mDZp4A7qdi1MMz
 6YXw==
X-Gm-Message-State: AOJu0YwUJeKKp8xMkVZSMyui3VvVnIvs+HOh8yUGNoBYWsvws3ADiJWY
 mnnzKRuq/1cPvqkYRePv61pLryr9l9snXHDq52F4gb8iUIhtPSwSSXnn6w==
X-Google-Smtp-Source: AGHT+IFj6nMrQV4rImgeNlzwQHJNb+a5VeYUnCy5+KeHVnDETqv/mNjz2OD+AzudrYlE/YeZ5AAQVQ==
X-Received: by 2002:a17:903:2448:b0:1e7:b7da:842 with SMTP id
 l8-20020a170903244800b001e7b7da0842mr11806550pls.2.1714386929884; 
 Mon, 29 Apr 2024 03:35:29 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:33d6:deb1:e19f:26ab])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902a38500b001e2bfd40b86sm20391058pla.47.2024.04.29.03.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 03:35:29 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240429
Date: Mon, 29 Apr 2024 07:35:24 -0300
Message-Id: <20240429103524.1146511-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 174ac987655c888017c82df1883c0c2ea0dc2495:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2024-04-26 07:39:18 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240429

for you to fetch changes up to 37e50627efacd8dae18b564e9d8886a033e181bc:

  ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman (2024-04-28 12:10:13 -0300)

u-boot-imx-master-20240429
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20563

- Fix missing fdt_fixup on colibri-imx(6ull|imx7).
- Enable PCIe and NVMe on DH i.MX8M Plus DHCOM PDK3.
- Convert i.MX8M flash.bin image generation to binman
- Convert imx93-11x11-evk to OF_UPSTREAM.
----------------------------------------------------------------
Francesco Dolcini (1):
      board: toradex: colibri-imx(6ull|imx7): Fix missing fdt_fixup boot error

Marek Vasut (4):
      ARM: dts: imx: Enable PCIe and NVMe on DH i.MX8M Plus DHCOM PDK3
      binman: Add nxp_imx8mimage etype
      ARM: dts: imx: Switch Ronetix iMX8MQ-CM to imx8mq-u-boot.dtsi
      ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman

Peng Fan (2):
      dt-bindings: imx93: sync clock header
      imx: imx93-11x11-evk: convert to OF_UPSTREAM

 arch/arm/dts/Makefile                           |   1 -
 arch/arm/dts/imx8mm-u-boot.dtsi                 | 126 ++++------
 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi |   8 +-
 arch/arm/dts/imx8mn-u-boot.dtsi                 | 147 +++++------
 arch/arm/dts/imx8mp-dhcom-pdk3-u-boot.dtsi      |  12 +
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi           |   2 +-
 arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi      |   2 +-
 arch/arm/dts/imx8mp-u-boot.dtsi                 |  96 +++----
 arch/arm/dts/imx8mq-cm-u-boot.dtsi              | 111 +-------
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi      |  15 +-
 arch/arm/dts/imx8mq-u-boot.dtsi                 | 109 ++++----
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi        | 118 +++++++++
 arch/arm/dts/imx93-11x11-evk.dts                | 322 ------------------------
 arch/arm/dts/imx93-u-boot.dtsi                  |  15 ++
 arch/arm/mach-imx/imx9/Kconfig                  |   1 +
 configs/colibri-imx6ull_defconfig               |   1 +
 configs/colibri_imx7_defconfig                  |   1 +
 configs/imx8mp_dhcom_pdk3_defconfig             |   5 +
 configs/imx93_11x11_evk_defconfig               |   2 +-
 configs/imx93_11x11_evk_ld_defconfig            |   2 +-
 include/configs/colibri-imx6ull.h               |   2 +-
 include/configs/colibri_imx7.h                  |   2 +-
 include/dt-bindings/clock/imx93-clock.h         |   3 +-
 tools/binman/etype/nxp_imx8mimage.py            |  74 ++++++
 24 files changed, 437 insertions(+), 740 deletions(-)
 delete mode 100644 arch/arm/dts/imx93-11x11-evk.dts
 create mode 100644 tools/binman/etype/nxp_imx8mimage.py
