Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED083CF258D
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338DC89095;
	Sun, 13 Oct 2024 22:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQfM4vao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858368905F; Sun, 13 Oct 2024 22:19:19 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6218D8906C
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so2896779a12.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728850755; x=1729455555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UIWVji2dH86/RewSpnRau8cc7bmX8Uc171vvqrlcz44=;
 b=aQfM4vaos8Y9x2dINqgJzkQAHlrAHjerwUlZ2HiAiEvRAhbFGJMD6GxXuMlUEtdvu7
 wH2d86OsdhFljkezakEGVPYtVl0y7uIGHu5FXUYn/Ro09wg/dbQPsM8dojVpLxwbIJql
 TJT0TsefZ9plzscJ9aL+VmyBCj774JsnMIZFa6P172DTl8KIbzZhLYTJqUeMOWpgkgeI
 aODq+5bJpfPHat+FAGb60QTmzlyNPmernnJpAQqnI37sVzjcrAeMlffbHAayP/QiIxki
 LmDwzkE3iWp7CtGc+flBQWGJufkgpBSJ8+Dk4DfT11SvoIX+kuBjGJ/nNDTLmqNN6lWb
 ZcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728850755; x=1729455555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIWVji2dH86/RewSpnRau8cc7bmX8Uc171vvqrlcz44=;
 b=uzDaQJ7eR10015MNMvPN9R+NWZT6fQTmtDM/BfJb0AzDut4kROR9TwKtcQka5tSMKs
 N+sNO9pHQABCpGCWyQGoEA4FgMxhdHUFuyJHf1nztAMlRdENHHjz/7zE04qAgRlPOEgn
 NPAWC2tfs1kdv5bxhroXLAtCcSiFbcpeU6uMibWVSC+8Jh/jlfzSaZ7q2UUbzbZFwYrK
 obgDjSwQbywZDmeVU3UDtx7e0KbOZ478Yal0HS1p8sQDKzqcL11C6tJxruunYI6z4dnl
 44Stm3a+ogeaqIzU3NdnBDNpi+i0Ua+6EBBplrV2DWoyd/moLz7MpzO5o5wlO50LTcRN
 Briw==
X-Gm-Message-State: AOJu0YwoHHoduIabk/NkFC0WQhjDifNaGJTCuscJxc4EkKS1i+yTC6ea
 24aCpDtq3JtcfnYdJlnGO/ZcwsqrCHKRF4yMQVPnQpgH51qH561UmQRbnQ==
X-Google-Smtp-Source: AGHT+IGpR8dvbEhPujskVVJGRyM1vy0NWRkcTnm88zG58xnSfZtAABrWVotOn0q9wu8S0hLMdaGSyg==
X-Received: by 2002:a05:6a20:e687:b0:1d8:a2d8:d190 with SMTP id
 adf61e73a8af0-1d8bcf9f091mr16867593637.39.1728850754811; 
 Sun, 13 Oct 2024 13:19:14 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e637:1c13:c5b:d24d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e6550aa07sm751605b3a.49.2024.10.13.13.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 13:19:14 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241013
Date: Sun, 13 Oct 2024 17:19:10 -0300
Message-Id: <20241013201910.1485853-1-festevam@gmail.com>
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

The following changes since commit 47e544f576699ca4630e20448db6a05178960697:

  Merge patch series "Tidy up use of 'SPL' and CONFIG_SPL_BUILD" (2024-10-11 12:23:25 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241013

for you to fetch changes up to 19c0e50a6951b22cfe175986cc54bbbd2e85f30b:

  clk: imx8mp: Add i.MX8MP Dummy clk (2024-10-13 09:46:05 -0300)

u-boot-imx-master-20241013
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22644

- Add fast authentication method for i.MX8M signing.
- Migrate imx8mp-debix-model-a to OF_UPSTREAM.
- Update MAINTAINERS file globs for i.MX6/i.MX8MP DHSOM.
- Improve ELE driver.
- Add i.MX8MP Dummy clk to fix regression.
----------------------------------------------------------------
Brian Ruley (2):
      binman: cosmetic: refactor `nxp_imx8mcst' etype code
      binman: add fast authentication method for i.MX8M signing

Gilles Talis (1):
      arm64: imx: imx8mp-debix-model-a: Migrate to OF_UPSTREAM

Marek Vasut (2):
      ARM: imx: Update MAINTAINERS file globs for i.MX6 DHSOM
      ARM: imx: Update MAINTAINERS file globs for i.MX8MP DHSOM

Peng Fan (4):
      misc: ele_mu: Clear RR when initialize MU
      misc: ele_api: Update ELE read common fuse API
      imx8: Correct the SCU API return value check
      clk: imx8mp: Add i.MX8MP Dummy clk

Ye Li (4):
      misc: ele_mu: Update ELE MU to get TR/RR number from HW
      misc: ele_api: Add read/write shadow fuse APIs
      misc: fuse: Fix FSB redundancy fuse word check and clear res
      misc: fuse: Update fuse driver

 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi |  16 +-
 arch/arm/dts/imx8mp-debix-model-a.dts         | 507 --------------------------
 arch/arm/include/asm/mach-imx/ele_api.h       |   4 +
 arch/arm/mach-imx/imx8/ahab.c                 |   8 +-
 arch/arm/mach-imx/imx8/cpu.c                  |  35 +-
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 board/dhelectronics/dh_imx6/MAINTAINERS       |   5 +-
 board/dhelectronics/dh_imx8mp/MAINTAINERS     |   6 +-
 configs/imx8mp_debix_model_a_defconfig        |   2 +-
 drivers/clk/imx/clk-imx8mp.c                  |   2 +
 drivers/misc/imx_ele/ele_api.c                |  79 +++-
 drivers/misc/imx_ele/ele_mu.c                 |  36 +-
 drivers/misc/imx_ele/fuse.c                   | 111 ++++--
 tools/binman/etype/nxp_imx8mcst.py            |  54 ++-
 15 files changed, 267 insertions(+), 600 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mp-debix-model-a.dts
