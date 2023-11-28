Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862BFC07CA9
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 10:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A9C86FBE;
	Tue, 28 Nov 2023 11:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="W25PgmbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C6287652; Tue, 28 Nov 2023 11:35:53 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F047986AB3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a00a9c6f283so708359566b.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 02:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1701167750; x=1701772550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U9dJUC3ILxE2NLVmat/t3S4bh2+MYxyyvONJx6GF+TE=;
 b=W25PgmbJ2WzZVDVjBy24DoqpJO9vl+ENYUycpkHLFPopstPMVYLeOZA1eISG6HKDpR
 AM24MPdzHEU5Vmss53yu9D6x57OiBOpFnh0HbwxuPI60fSpRgG35cfU3g51fOMCZpSDG
 gnaagg/oFRbBd0v3Z5Kh9/IPY6+60W02JsiukeJMBA5sOOnUivRyS1bJYLEbPbVtACOw
 m/ihkgG/UXnpCV9rxB0pEPOb1al1FfDbjeTcTHVToY7XzAyhc25rJaJeVcROcn0ZxnMT
 i1Ze0T/tPm0ZXsxTEGbPuAgVoJclKXnU5wy6ORzbDWPAaPj+8qcEhhTbvkjyeI2AJtgW
 5FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701167750; x=1701772550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9dJUC3ILxE2NLVmat/t3S4bh2+MYxyyvONJx6GF+TE=;
 b=fQI2gWpqIfQs5avhuqFK4y2JVCLr8/iTXootr4VcmQFiJ9xEE6BiTYlw2tpB9WFlcD
 nAvv9qQyrGmRFrS4rhDPMuVQq/6EdoDEpa2q7oA9+x2ERjhBcfvr9ms4nJVeGiFoC46s
 qYH++CqA5wddE0p0bl/npxYJ2XR1aVY0ybV8Q0iWyrVWr0lcgch6eL0d5DCDtFt2uXsu
 lJ4hCuhytjz/rf7EOOKFZD1l57uKYcXEeQRBAseaVNsUXq37u9Xzs0h9p//Sxo7gpCfv
 fsr7Rhxwbu/zADw60CZSyvrzIVIyAtG8e8k1baieEmow5XVbdjgIKzekzR7ATwxr/9xv
 fy1Q==
X-Gm-Message-State: AOJu0YzZSoBTl0zUm6Vv8vgx3JNNe+5dBXk+769Xy2kNkkFBmAlhdtvz
 ybfW8Ehut0k4olqHvudPQ7ShBw==
X-Google-Smtp-Source: AGHT+IHKHr4ZrsRgL8B11MmZ5Mc9f2fqdqerTEjG4OaTIfPfx0bYJGv6mn5DhEC4irfj8sUAejk6ww==
X-Received: by 2002:a17:906:4e:b0:a0d:a567:b92a with SMTP id
 14-20020a170906004e00b00a0da567b92amr5564858ejg.39.1701167750067; 
 Tue, 28 Nov 2023 02:35:50 -0800 (PST)
Received: from localhost.localdomain (host-93.179.209.131.static.3s.pl.
 [93.179.209.131]) by smtp.gmail.com with ESMTPSA id
 cw16-20020a170907161000b00a169550fccesm77558ejd.111.2023.11.28.02.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 02:35:49 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Tom Rini <trini@konsulko.com>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v3 0/3] Conclusive WHLE-LS1 support (was: Conclusive
 WHLE-LS1046A support)
Date: Tue, 28 Nov 2023 11:34:54 +0100
Message-ID: <20231128103457.45802-1-artur@conclusive.pl>
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

Hi all,

this is v3 of the WHLE-LS1 support.
The major change in this version is addition of WHLE-LS1088A board
support, next to the WHLE-LS1046A found in previous iterations of this
series.

Patch [1/3] and [2/3] remain unchanged.
Patch [3/3] introduces WHLE-LS1088A board support.

Artur Rojek (2):
  board: Add support for Conclusive WHLE-LS1046A
  board: Add support for Conclusive WHLE-LS1088A

Jakub Klama (1):
  armv8: layerscape: Enable ext4 environment storage

 arch/arm/Kconfig                              |  38 +++
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   5 +
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/fsl-ls1046a-whle.dts             | 208 ++++++++++++
 arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi     |   8 +
 arch/arm/dts/fsl-ls1088a-whle.dts             | 235 ++++++++++++++
 board/conclusive/whle-ls1046a/Kconfig         |  15 +
 board/conclusive/whle-ls1046a/MAINTAINERS     |   9 +
 board/conclusive/whle-ls1046a/Makefile        |   7 +
 board/conclusive/whle-ls1046a/ddr.c           |  21 ++
 board/conclusive/whle-ls1046a/eth.c           |  65 ++++
 board/conclusive/whle-ls1046a/whle-ls1046a.c  | 215 +++++++++++++
 .../conclusive/whle-ls1046a/whle-ls1046a.env  |  13 +
 board/conclusive/whle-ls1088a/Kconfig         |  29 ++
 board/conclusive/whle-ls1088a/MAINTAINERS     |  11 +
 board/conclusive/whle-ls1088a/Makefile        |   7 +
 board/conclusive/whle-ls1088a/ddr.c           | 134 ++++++++
 board/conclusive/whle-ls1088a/ddr.h           |  47 +++
 board/conclusive/whle-ls1088a/eth.c           |  13 +
 board/conclusive/whle-ls1088a/whle-ls1088a.c  | 301 ++++++++++++++++++
 .../conclusive/whle-ls1088a/whle-ls1088a.env  |  13 +
 configs/whle_ls1046a_emmc_defconfig           |  83 +++++
 configs/whle_ls1046a_qspi_defconfig           |  84 +++++
 configs/whle_ls1088a_emmc_defconfig           |  84 +++++
 configs/whle_ls1088a_qspi_defconfig           |  84 +++++
 include/configs/whle_ls1046a.h                |  47 +++
 include/configs/whle_ls1088a.h                |  92 ++++++
 27 files changed, 1870 insertions(+)
 create mode 100644 arch/arm/dts/fsl-ls1046a-whle.dts
 create mode 100644 arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi
 create mode 100644 arch/arm/dts/fsl-ls1088a-whle.dts
 create mode 100644 board/conclusive/whle-ls1046a/Kconfig
 create mode 100644 board/conclusive/whle-ls1046a/MAINTAINERS
 create mode 100644 board/conclusive/whle-ls1046a/Makefile
 create mode 100644 board/conclusive/whle-ls1046a/ddr.c
 create mode 100644 board/conclusive/whle-ls1046a/eth.c
 create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.c
 create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.env
 create mode 100644 board/conclusive/whle-ls1088a/Kconfig
 create mode 100644 board/conclusive/whle-ls1088a/MAINTAINERS
 create mode 100644 board/conclusive/whle-ls1088a/Makefile
 create mode 100644 board/conclusive/whle-ls1088a/ddr.c
 create mode 100644 board/conclusive/whle-ls1088a/ddr.h
 create mode 100644 board/conclusive/whle-ls1088a/eth.c
 create mode 100644 board/conclusive/whle-ls1088a/whle-ls1088a.c
 create mode 100644 board/conclusive/whle-ls1088a/whle-ls1088a.env
 create mode 100644 configs/whle_ls1046a_emmc_defconfig
 create mode 100644 configs/whle_ls1046a_qspi_defconfig
 create mode 100644 configs/whle_ls1088a_emmc_defconfig
 create mode 100644 configs/whle_ls1088a_qspi_defconfig
 create mode 100644 include/configs/whle_ls1046a.h
 create mode 100644 include/configs/whle_ls1088a.h

-- 
2.43.0

