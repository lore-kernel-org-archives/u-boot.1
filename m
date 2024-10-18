Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE5D30004
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 13:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD6088FB9;
	Fri, 18 Oct 2024 15:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GG3FhahW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D097E88FBA; Fri, 18 Oct 2024 15:00:14 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561E288FA4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 15:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e06acff261so1504987a91.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729256411; x=1729861211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mtGmOpYSJdpkPGFfzC8uNJ2InbfvlPBMC27qj1NzGkI=;
 b=GG3FhahWdKd5asSkITcVDYxVQYH3Du5tUN3aFBOp3DaBbrRVf4Xnee6KE3iUJxEN1Y
 YhG7yieZaX4Du2mYaUrOoUOBc06NYhF+aHO+0l3U1FgUJIPzpsBzIgIaszOnFN1joOCp
 9Fzl+G/y/7sAmgdWkzbTk3BGNDBo7agOaq1OnvflYbC5iQUNfEwcmNSTZ8He+6onvLuP
 94FJoYuU/r5O42McvrIidLL9J/hmSX9stzwdCbC3Qunv1o3Do4O01BaclsS1D9dKYTrB
 V68xjaXllUvDmxfHP9eSnQVeV3MbQcwP3Y8n+4EIhReUQ9bTkc2epvZcY4x7auvwPzLV
 zwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729256411; x=1729861211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtGmOpYSJdpkPGFfzC8uNJ2InbfvlPBMC27qj1NzGkI=;
 b=wdAu09n79q4fGy99Hru61igJ5+cZrFC3XuTxYD6L2DjZb0iAdyuFjtIGyFNLshm9fZ
 ty/J0gheopeIVCbgayIh0+ijR8MXe7Fx2Xr4s7YgEokJExr7yJzf0CpRRTL8yz3m2xn1
 vnDFwYJlyw+VLZb7AxPAdOOARKL2m3l4DdSwBo2U1303iq50+6K7SRRDr7zaPHyYiU9G
 PDC1N3Ik+03gzrPSiQaVXZZa/hF6pdE7lWh7cei41kO00Ic9gCVe21VSXrkJsGks93BJ
 7+a/kP84NplgnFrtIa3zvTsokF/MMCcuep7NBTqBQS3JVYWarVVNRDcnQAq0ZbhtGo2o
 swYg==
X-Gm-Message-State: AOJu0YyyD3+IWGHGO8d7UFCRthBt5yBEntodBZNdm6taRn4vzrXJANgb
 5l1Z5YKkUkrpBFhokAwmgHPJDclH8F8GW/eKJhjXmlTGtxFQfVEQ
X-Google-Smtp-Source: AGHT+IGvNYQMpawEFBFsyeEzbAxyHWVhm551B3sIyD/OGGvct1to9u25u1FN6j9q/WU6gTTVxu8zRg==
X-Received: by 2002:a17:90b:4a0c:b0:2e2:b3f8:b549 with SMTP id
 98e67ed59e1d1-2e561650b59mr3022124a91.23.1729256410691; 
 Fri, 18 Oct 2024 06:00:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:96e7:fa57:5ef0:9a46:ef82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5611d601esm1788497a91.21.2024.10.18.06.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 06:00:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL v2] Please pull u-boot-imx-master-20241018a
Date: Fri, 18 Oct 2024 10:00:06 -0300
Message-Id: <20241018130006.257215-1-festevam@gmail.com>
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

The following changes since commit 608a31bdec6284ad6f821226e4c62c9cd3052874:

  Merge patch series "Introduce the lwIP network stack" (2024-10-16 11:11:57 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241018a

for you to fetch changes up to 9b1cecdd9b6eaf22c4fa268430669ceff0c48786:

  cpu: imx8_cpu: Avoid revision to corrupt device tree (2024-10-18 09:41:09 -0300)

u-boot-imx-master-20241018a
---------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22796

- Switch to using upstream DT on DH i.MX8MP DHCOM PDK2/PDK3.
- Add ability to build fallback DTBOs from arch/$(ARCH)/dts.
- Remove fdt_high and initrd_high env variables from imx6-dhcom.
- Add dummy clk for imx8.
- Fix DT corruption in imx8_cpu.
- Improve DDR stability on pico-imx7d.
----------------------------------------------------------------
Marek Vasut (3):
      dts: Add ability to build fallback DTBOs from arch/$(ARCH)/dts
      arm64: dts: imx: Switch to using upstream DT on DH i.MX8MP DHCOM PDK2/PDK3
      ARM: dts: imx6-dhcom: Remove fdt_high and initrd_high env variables

Peng Fan (2):
      clk: imx8: Add dummy clk
      cpu: imx8_cpu: Avoid revision to corrupt device tree

Ray Chang (1):
      pico-imx7d: Increase ODT resistor value

 Makefile                            |   4 +
 arch/arm/dts/Makefile               |   2 -
 arch/arm/dts/imx8mp-dhcom-pdk2.dts  | 158 ------------------
 arch/arm/dts/imx8mp-dhcom-pdk3.dts  | 317 ------------------------------------
 board/technexion/pico-imx7d/spl.c   |  10 +-
 configs/imx8mp_dhcom_pdk2_defconfig |   6 +-
 configs/imx8mp_dhcom_pdk3_defconfig |   6 +-
 drivers/clk/imx/clk-imx8qm.c        |   4 +
 drivers/clk/imx/clk-imx8qxp.c       |   4 +
 drivers/cpu/imx8_cpu.c              |  32 ++--
 dts/Kconfig                         |  16 ++
 dts/Makefile                        |  14 +-
 include/configs/dh_imx6.h           |   3 +-
 scripts/Makefile.dts                |   6 +
 14 files changed, 78 insertions(+), 504 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mp-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx8mp-dhcom-pdk3.dts
