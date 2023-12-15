Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441BEC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82EA787B88;
	Fri, 15 Dec 2023 14:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QyYQvtBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448D287B6F; Fri, 15 Dec 2023 14:07:18 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7EB87B9E
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so51864a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702645633; x=1703250433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+b2Ir3GzsOB1yOmrxip/AHulvjWjZT/cvAzisefcISQ=;
 b=QyYQvtBKzZBOO1zMNLsUTYzgDJWJwxs7AdtBbNC4vnmca8FAnaUeQiZ092EzcF2dBN
 pcj51KsnrzO1bp8Rk84NVDaYbtlFglxlk2QBv1HFpr+jagqLRJgGIaqmS6A01Y6KHKgk
 hPZiznD4u4v59HfrRbO8Ofw4372Qms0/XyVvTUueVCD8l+jnloj2QwGjdybxP8qkcPug
 eu07o2FtddTVX8J2cig5GtkQucMkzaD4RwJSSd2dYmClTP8ZoI6wUQWq1scDubJmfjqd
 Jzleltho8sagDzcqX4jEgKK8mrnnT2/28qST2SmRUJdyYlvkbHvTSrPnoJxTaI+s22Sr
 ZPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702645633; x=1703250433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+b2Ir3GzsOB1yOmrxip/AHulvjWjZT/cvAzisefcISQ=;
 b=L9d+Sd2N5wjRIPQzHXlEFXRtYRgN9ZaEY9mzVDAY5haDEInIt9axN1y+FNSywosXwB
 Fot9Pq0ARLO6tp/0yqdb/PYYqTzlcL0NFUa/TuGxbD5dn9mBSor8pMguEJ77lovKUQ85
 CpHHiBKhUbRFco+F7zoI4xGPCK8L353IPLM9vKXBN4vF9WTRGRhImwOlSOhHaCtluczn
 KatuffH3978+rpk6vly+JnTxHBwGrt4oCf4NWoxZ1oF0prK08zBeUpbaM2wHWpB974xX
 IiTKIvbTgM82FeadA9Cr+zVxlw7q3G1j0CMJpYUOU3lGHgFciQPl0loeMwhKvdxUwHo2
 PG+g==
X-Gm-Message-State: AOJu0YwGFev6DrREPUogvDXGQIcXl5V7n8k0t5XSZexgQwUuHtH145wL
 iXk2dmxO6KuR+QWj5JQ++80=
X-Google-Smtp-Source: AGHT+IEPtiSykf9vE+Eiqt+E0eRz4bOS+K5eMVVy98JuwpnafRnAdCTRkx0PVgItBbSCQF33sy85jw==
X-Received: by 2002:a17:90a:88f:b0:28a:e25d:a9da with SMTP id
 v15-20020a17090a088f00b0028ae25da9damr7591941pjc.3.1702645632634; 
 Fri, 15 Dec 2023 05:07:12 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:16e1:6184:2e5d:deaa])
 by smtp.gmail.com with ESMTPSA id
 in18-20020a17090b439200b0028b041cbef3sm3568226pjb.22.2023.12.15.05.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:07:12 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de, marex@denx.de, tharvey@gateworks.com, u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-20231214
Date: Fri, 15 Dec 2023 10:07:07 -0300
Message-Id: <20231215130707.184861-1-festevam@gmail.com>
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

Please pull these fixes from u-boot-imx, thanks.

The following changes since commit 27089f1e4d11fd7e0619097b59258d0428cde2ac:

  Merge branch '2023-12-13-assorted-minor-fixes' (2023-12-13 09:57:28 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-20231214

for you to fetch changes up to 4f7122ca1580602399afc30f94f4b37f79e4d662:

  imx8mp-venice: update DRAM config for 2000MHz (2023-12-14 15:34:12 -0300)

u-boot-imx-20231214
-------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/18937

- Fix for i.MX8M Plus eDM SBC DDR timings with inlinc ECC
- Switch to FPWM mode on Data Modul i.MX8M Plus eDM SBC so that
DRAM EDAC detects more correctable errors
- Fix for imx8mp-venice board DDR initialization 

----------------------------------------------------------------
Marek Vasut (7):
      arm64: imx8mp: Inhibit DTC warning on DH i.MX8MP DHCOM rev.100 DTO
      ddr: imx: Handle 3734 in addition to 3733 and 3732 MTps rates
      ddr: imx: Add 3600 MTps rate support
      ARM: imx: Enable CAAM on Data Modul i.MX8M Mini/Plus eDM SBC
      ARM: imx: Enable CAAM on DH i.MX8M Plus DHCOM
      ARM: imx: Force DRAM regulators into FPWM mode on Data Modul i.MX8M Plus eDM SBC
      ARM: imx: Update DRAM timings with inline ECC on Data Modul i.MX8M Plus eDM SBC

Tim Harvey (3):
      board: gateworks: venice: remove extra file
      imx8mp-venice: fix DRAM bus configuration
      imx8mp-venice: update DRAM config for 2000MHz

 arch/arm/dts/Makefile                              |    2 +
 arch/arm/mach-imx/imx8m/clock_imx8mm.c             |    1 +
 board/data_modul/common/common.c                   |   18 +-
 .../imx8mp_edm_sbc/lpddr4_timing_4G_32.c           |  175 +-
 board/data_modul/imx8mp_edm_sbc/spl.c              |    5 +
 .../gateworks/venice/lpddr4_timing_imx8mm_512mb.c  | 1849 --------------------
 board/gateworks/venice/lpddr4_timing_imx8mp.c      |  327 ++--
 configs/imx8mm_data_modul_edm_sbc_defconfig        |    1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig        |    2 +
 configs/imx8mp_dhcom_pdk2_defconfig                |    1 +
 configs/imx8mp_dhcom_pdk3_defconfig                |    1 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    5 +
 12 files changed, 301 insertions(+), 2086 deletions(-)
 delete mode 100644 board/gateworks/venice/lpddr4_timing_imx8mm_512mb.c
