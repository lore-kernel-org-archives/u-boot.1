Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DA9C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFFD80FE1;
	Thu, 27 Feb 2025 15:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RteijHKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0083E80FF0; Thu, 27 Feb 2025 15:15:46 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF84D80F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2235908a30aso12375745ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740665741; x=1741270541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8fBHSPDZl/iu+Fpd2tk7M8aN0oyAaG4UpI9sRP9YEk=;
 b=RteijHKOprSZ7Kke4ux01d1d2/JJ17Sxetgv1uWjv81P4Jz/cOzR2Neh0OPbxxleGJ
 VoSn2hyoHomHNaS45XZbvvORVTFk+5fzaHfvMOXP2RMDmz8AZ+w5+42+rI00nsQy09/K
 9ni5fA/HjygNKcTIeANjk/pefyKkBz2yj8ebElI58BpFh2iJ2YhNkQ9LP9RWgfXf8KCE
 rqvl5IBaYrPwPrCiGG+uYTxvHyZ64Mhm3ZVtz+aPhO90OHjcu1bT7RjHy35tbMRmlFZR
 3LYmOfd28KgaF4s2RTsEJdYCRf/QEARrEvqVNd/NxZCFzRw+95QGfZf9GvtKfXRy1Q5R
 e8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665741; x=1741270541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8fBHSPDZl/iu+Fpd2tk7M8aN0oyAaG4UpI9sRP9YEk=;
 b=MHMhVE7Q7P42DVDgpIitDBAk3yZIVWlELSAm/1aK558AP4AexhSlcllBLpZgyRrCil
 wvLA+JxvG3i7qgJBBleJIO+V76F3LKjNo8mD/y24ukT6C52kZXusCbn9giA2ihlQX0Pu
 cByDnhj4wKJbMWQxeOGFMUg5GQUBrMBDLiRNb5i97+/XUSKRLF25hNeZypVwI+P4RZ6g
 UeTnIYD9jpb50TTK1g40IFtNS15Ck0z6TdHy8JwgmryzFFukkG2DX/A+ha5mNmxS9aDI
 v8sqnfzZFkyiY+B7xdaqnL76rNeD2uoGqKjqshedeiVlEJAWRupdsDB4eeM6mW9pkFK4
 cbXg==
X-Gm-Message-State: AOJu0YzWvH7xtfd8DSf9bP6PaXg10DsvcOfux8nhfJidsE6RPmBIjAhU
 SFp7x2JculpAjEKiBwjE/rMPxxByYV+/D8uVfdhYT0DZrVc5c5DIxbnkxQ==
X-Gm-Gg: ASbGncusJjShMNraw53bCsNpAj1PYbEgTK+xDYvjWm+Inrot0gqV5j6DO8J9D9daW0X
 TsFuzpEZqGpu/g2Uo5Iay202ytmHDv/+TZlMK+XQxGP0wZfB55H8bOnyKb3FqF7M5s8HM9TpcpU
 kCd4PFz4H49f4SVo3ZXaN3/BUVmn/7qDAqtTTKvpWfnx3XkJ9h4JO2YpBW+i7iU0e3Cn9ZgBfNE
 VQSAX/Hs+bYrYjC+LDZjcLPTjXNueULYrTJ7hKtMUreCsjInWI57eTYMTzoLqj+/xcsG/o/3feG
 M2Rah7fTIag1ipuRKsThv8DCbj16BBla+SXoI7dV
X-Google-Smtp-Source: AGHT+IH+mlSg+xCA2AHYr3oUghx4ZzoGvvBF8L2/vgRhqulaKWtb+AEs7cn4tcH4HVmanCMoSlQZXA==
X-Received: by 2002:a17:903:1787:b0:223:6436:72bf with SMTP id
 d9443c01a7336-2236436742amr7286995ad.44.1740665740979; 
 Thu, 27 Feb 2025 06:15:40 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5a29:6887:1512:7ff3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a005e667sm1574753b3a.157.2025.02.27.06.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:15:40 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250127
Date: Thu, 27 Feb 2025 11:15:36 -0300
Message-Id: <20250227141536.204947-1-festevam@gmail.com>
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit 8dd7186ca7821446c6f46b6cccefab502912f2e0:

  Merge patch series "Remove "saveenv" functionality from am57xx evms" (2025-02-25 11:11:32 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250227

for you to fetch changes up to ce154a45a7e550b780e07b893a87d9e411a5b8b7:

  imx6q-lxr: Convert to OF_UPSTREAM (2025-02-27 10:03:29 -0300)

u-boot-imx-next-20250127
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/24876

- Convert imx6q-lxr and imxrt1050 to OF_UPSTREAM.
- Fix potential memory leak on ]imx/imx8/imx8m]image.
- Restrict DDR_SI_TEST to only Siemens Capricorn board.
- Fix CONFIG_BOOTCOUNT_ALTBOOTCMD on Data Modul and DH imx8m boards.
----------------------------------------------------------------
Fabio Estevam (1):
      imx6q-lxr: Convert to OF_UPSTREAM

Jesse Taube (1):
      ARM: dts: imxrt1050: Migrate to OF_UPSTREAM

Liya Huang (1):
      siemens: common: Make DDR_SI_TEST depend on TARGET_CAPRICORN

Maks Mishin (3):
      tools: imximage: Fix potential memory leak
      tools: imx8image: Fix potential memory leak
      tools: imx8mimage: Fix potential memory leak

Marek Vasut (4):
      ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on Data Modul i.MX8M Mini eDM SBC
      ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD duplication on Data Modul i.MX8M eDM SBC
      ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD duplication on DH i.MX8MP DHCOM
      ARM: imx: Introduce DH i.MX6 DHSOM board specific defconfigs

 arch/arm/dts/Makefile                       |   4 +-
 arch/arm/dts/imx6q-lxr.dts                  |  87 ---
 arch/arm/dts/imx6q-phytec-pfla02.dtsi       |  17 -
 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi     | 467 -------------
 arch/arm/dts/imxrt1050-evk.dts              |  72 --
 arch/arm/dts/imxrt1050-pinfunc.h            | 993 ----------------------------
 arch/arm/dts/imxrt1050.dtsi                 | 160 -----
 arch/arm/mach-imx/mx6/Kconfig               |   1 +
 board/siemens/common/Kconfig                |   1 +
 configs/dh_imx6.config                      |  76 +++
 configs/dh_imx6_defconfig                   |  76 +--
 configs/imx6_dhcom_drc02_defconfig          |   4 +
 configs/imx6_dhcom_pdk2_defconfig           |   4 +
 configs/imx6_dhcom_picoitx_defconfig        |   4 +
 configs/imx8m_data_modul.config             |   1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig |   1 -
 configs/imx8mp_data_modul_edm_sbc_defconfig |   1 -
 configs/imx8mp_dhcom_drc02_defconfig        |   1 -
 configs/imx8mp_dhcom_pdk2_defconfig         |   1 -
 configs/imx8mp_dhcom_pdk3_defconfig         |   1 -
 configs/imx8mp_dhcom_picoitx_defconfig      |   1 -
 configs/imx8mp_dhsom.config                 |   1 +
 configs/imxrt1050-evk_defconfig             |   3 +-
 configs/imxrt1050-evk_fspi_defconfig        |   3 +-
 configs/lxr2_defconfig                      |   2 +-
 tools/imx8image.c                           |   1 +
 tools/imx8mimage.c                          |   1 +
 tools/imximage.c                            |   1 +
 28 files changed, 102 insertions(+), 1883 deletions(-)
 delete mode 100644 arch/arm/dts/imx6q-lxr.dts
 delete mode 100644 arch/arm/dts/imx6q-phytec-pfla02.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
 delete mode 100644 arch/arm/dts/imxrt1050-evk.dts
 delete mode 100644 arch/arm/dts/imxrt1050-pinfunc.h
 delete mode 100644 arch/arm/dts/imxrt1050.dtsi
 create mode 100644 configs/dh_imx6.config
 create mode 100644 configs/imx6_dhcom_drc02_defconfig
 create mode 100644 configs/imx6_dhcom_pdk2_defconfig
 create mode 100644 configs/imx6_dhcom_picoitx_defconfig
