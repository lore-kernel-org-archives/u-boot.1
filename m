Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3DC3DA79
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 02:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AA2870D9;
	Tue, 16 Jan 2024 03:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UsPra2RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAE2876D0; Tue, 16 Jan 2024 03:46:05 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2EB0870D9
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 03:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d51bf8a7dcso20237905ad.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 18:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705373159; x=1705977959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bubRev/bGJN2SP8lhGWb/c/yYTps1Zxijb68yFX/jk8=;
 b=UsPra2RBoEpIAhjCBlrtnq2mu86K9du3h5DrJzejwEX9qWoLgquphLrO8i/ZWNZ/CS
 G0FZYHhE2h/L9rhBuLxDsfMtwt44pPZ45HeSeyhlm/zMCsWxaQJxB7J9lzsnpb7d5Fw+
 r/w82MyzuNpkPPVUzUN8FwQzkqiGMbEjPPuPP+VS7lFwVUCekr7/66MfLk+iZykxT1vy
 of106kaITLcU+igdxA35Ylu8Fr3lRK8NrEur847/DTeGnFRtKHal7oKfPnvYF6Z+Amwp
 J7u3KosRaKlXleIvVUJoBQXkwqXid+64hbSk/YpEIhK8QlUwEZEKe/Jnv9ofT+6UoGTm
 P/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705373159; x=1705977959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bubRev/bGJN2SP8lhGWb/c/yYTps1Zxijb68yFX/jk8=;
 b=dGc1xIkU+rT1iv0JOmDCKWTnwEr1ygmYDDuT0it3jfch+8TcGLfvpzcs9VjUGUVc/p
 lcX56VNhtPSDiRYTD3DcLABxQvFawMS5dB/qUNPEhBkfMwEmtaSx1s/YFuTQIT0F5T44
 AVYf3ebEoyCf641rb8nIVJn6kLVTahldlyXBVRs1n0ft0n6H7Gb5j8kez2pIxVKpWt//
 4kt3Q/HjZwH9MZUNTUgAHRCv4n+3aUTOE7P6MMc3ASoa01Mr7mccB4YC+kOnb1jRC5R5
 pbT1rxxBeq6xfbfs581ojkFHBobKJlFnjeHbQZTyBdQpFxOynpfwnVa81/KXR7mUUSEj
 troA==
X-Gm-Message-State: AOJu0YwyaifjMYtGfTFPwl7iSavIIvVf9pso6s3zaCX6cQC/3NmepVIS
 0LPE3w08UzlWvgGjM8pbyD4=
X-Google-Smtp-Source: AGHT+IGBF6B+gT6O1FLV64tziCXqOZYVHukHyVyXKbNwo5AT6FsGUgAv3F81f2Lprp0w3+47DCLPMg==
X-Received: by 2002:a17:902:e803:b0:1d4:b46d:81fe with SMTP id
 u3-20020a170902e80300b001d4b46d81femr13131496plg.3.1705373159165; 
 Mon, 15 Jan 2024 18:45:59 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3ce7:bbce:335e:2c36])
 by smtp.gmail.com with ESMTPSA id
 kq14-20020a170903284e00b001d3ec25614bsm8301145plb.24.2024.01.15.18.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 18:45:58 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-20240115
Date: Mon, 15 Jan 2024 23:45:54 -0300
Message-Id: <20240116024554.3316040-1-festevam@gmail.com>
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

Please pull from u-boot-imx, thanks.

The following changes since commit 547d3dd28a46a18d59e00a153c8becca8d4e8cf9:

  Merge branch '2024-01-12-assorted-fixes' (2024-01-12 08:34:50 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-20240115

for you to fetch changes up to 662e7ef7f0e84114dd58d77ccdcfdf61d1a0df31:

  arm: xea: Add support for boot image source descriptor in SPL (2024-01-15 10:55:42 -0300)

u-boot-imx-20240115
-------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19324

----------------------------------------------------------------
Anatolij Gustschin (1):
      arm: xea: Add support for boot image source descriptor in SPL

Fabio Estevam (3):
      doc: imx93_var_som: Adjust the underline length
      imx9: Select BINMAN at SoC level
      imx8m: Select BINMAN at SoC level

Lukasz Majewski (3):
      defconfig: xea: Change default spi-nor memory bus to 2 (single binary)
      arm: xea: Move XEA's environment variables from xea.h to xea.env
      arm: config: Enable CRC8 support in SPL on imx287 XEA board

Marek Vasut (2):
      ARM: imx: Set stdio to serial on DH i.MX8M Plus DHCOM
      ARM: imx: Set stdio to serial on Data Modul i.MX8M Mini/Plus eDM SBC

Primoz Fiser (1):
      imx: imx9: fixup thermal trips from fuses

Yannic Moog (4):
      Add support for phyGATE-Tauri-L-iMX8MM
      doc: board: phytec: Add phyGATE-Tauri board documentation
      board: phytec: MAINTAINERS: add missing phytec doc files
      board: phytec: fix link error when disabling PHYTEC_SOM_DETECTION

 arch/arm/dts/Makefile                           |   1 +
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi |  70 ++++
 arch/arm/dts/imx8mm-phygate-tauri-l.dts         | 489 ++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/Kconfig                 |  39 +-
 arch/arm/mach-imx/imx9/Kconfig                  |   3 +-
 arch/arm/mach-imx/imx9/soc.c                    |  45 +++
 board/liebherr/xea/boot_img_scr.h               |  27 ++
 board/liebherr/xea/xea.c                        |  85 ++++
 board/liebherr/xea/xea.env                      | 139 +++++++
 board/phytec/common/Makefile                    |   4 +-
 board/phytec/common/phytec_som_detection.c      |   2 -
 board/phytec/phycore_imx8mm/MAINTAINERS         |   6 +
 board/phytec/phycore_imx8mp/MAINTAINERS         |   1 +
 configs/imx28_xea_defconfig                     |   1 +
 configs/imx28_xea_sb_defconfig                  |   2 +-
 configs/imx8mm-phygate-tauri-l_defconfig        | 115 ++++++
 doc/board/phytec/imx8mm-phygate-tauri-l.rst     |  60 +++
 doc/board/phytec/index.rst                      |   1 +
 doc/board/variscite/imx93_var_som.rst           |   4 +-
 include/configs/imx8mm_data_modul_edm_sbc.h     |  11 +-
 include/configs/imx8mp_data_modul_edm_sbc.h     |   9 +-
 include/configs/imx8mp_dhcom_pdk2.h             |  17 +-
 include/configs/xea.h                           | 140 -------
 23 files changed, 1070 insertions(+), 201 deletions(-)
 create mode 100644 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mm-phygate-tauri-l.dts
 create mode 100644 board/liebherr/xea/boot_img_scr.h
 create mode 100644 board/liebherr/xea/xea.env
 create mode 100644 configs/imx8mm-phygate-tauri-l_defconfig
 create mode 100644 doc/board/phytec/imx8mm-phygate-tauri-l.rst
