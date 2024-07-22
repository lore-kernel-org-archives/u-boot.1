Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC1AC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD0D87F82;
	Mon, 22 Jul 2024 23:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nNr7pfmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB2E87F82; Mon, 22 Jul 2024 23:03:02 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3299487D43
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cd16900ec5so215344a91.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682170; x=1722286970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gCFRasq2/hXbvoCSlOuCoRlz7xLupt+tuTPbF7ltSk4=;
 b=nNr7pfmPxCbcKh6+NQtLzQTKQTc+6UD85O1NkI5m0OTKoJqTVLoNYq5q3rLsIjqFP7
 rfTOx3ZJZOZOLrnOy7QIb6L2zPgeVNbFnoXwbrD5WthqDBQs7y1V+oWVWs/qMcQAE5YH
 S7kmRrG/dda92GAr7ENMAyVrb+eknQdCGQpckfS2J8FdTrGQsllEvniTOLCA3/SOPul+
 QIEqBmm7Smx4S9sXhGf3GBDMuo9K4SDUEP1eXtsCF1x+FVLHj2HajIXlKrZA6uIjny7o
 6MDLXEc6cGwRiFVIv12LyugwY+K3UlY/aiGwAulO5+3TBxh7/Ge3QKoHyJB7iwbDTHBX
 NvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682170; x=1722286970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gCFRasq2/hXbvoCSlOuCoRlz7xLupt+tuTPbF7ltSk4=;
 b=IFsv4xGwQmTEf0R2z2c8J5VVKp/90ibGLqcrrpfQEvk7yABn7rMXKUFHPWUF6Ri4CN
 e128s0UX4dvr43B30V/ZbYYXMSAGN11cQuFkvmmpa9nlMYZlrJx7LQuJ/BdsAY8uUfpd
 KRnR8wqMEi42Asf7RhgZrU/ZTvbL7gM4LIOilfmCJ2BJWeV397uKyCO92O4mO0KH3AvA
 kvgQcwE6bmbL4r1ppJDu8I5JncKY2qk86h6OlYO6QMuXNW9DBZb6UoSxBr1+xWCSEnm0
 EwmvlRfwuHtyJTOV9gpRooHRnsPyzDYFIMlZGwIE7o/Jw1kEvCIBAdk7jXXtkfzS9jLT
 vANg==
X-Gm-Message-State: AOJu0Yw2jrXY9ChCsxQ/0TNB5jf2ANk+FiKMt/rZuiBO4bavl7NSb9P3
 U6pee7iwJMNaqe1m0MKkwFhYME5W7ZNQ2mHIx+Z2tX6/pLoGhuwF1ZjMpQ==
X-Google-Smtp-Source: AGHT+IGXfvVG6ptxkX1KuspM6Q4GcxTe7iJKp4bnq6Go3PZY6QliyiegtMl3FL8+HWg/AVrdKNwgIA==
X-Received: by 2002:a17:90b:20b:b0:2cb:4382:99f1 with SMTP id
 98e67ed59e1d1-2cd16191fcdmr6586012a91.6.1721682169516; 
 Mon, 22 Jul 2024 14:02:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4af8:a5d7:cd1a:7dfb])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf80a8275sm7500835a91.47.2024.07.22.14.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:02:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240722
Date: Mon, 22 Jul 2024 18:02:44 -0300
Message-Id: <20240722210244.2294039-1-festevam@gmail.com>
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

The following changes since commit 5024a96db8ea6ff2e814f4599af9e5faf09296b7:

  Subtree merge tag 'v6.10-dts' of devicetree-rebasing repo [1] into dts/upstream (2024-07-20 11:15:22 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240722

for you to fetch changes up to a9c962941e119017eb9d5985c5c214d9711c9433:

  kontron-sl-mx6ul: switch to DM_SERIAL (2024-07-22 17:55:35 -0300)

u-boot-imx-master-20240722
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/21728

- Conversions to DM_I2C and DM_SERIAL.
- Support for I2C3 and PWM1 for the imx6q clock driver.
- Improvements for udoo-neo
- Describe the i.MX93 CPU clocks in the devicetree to fix CPU clock printing
- Fix for SPI and NANC clk-imx8mn clock driver
----------------------------------------------------------------
Anatolij Gustschin (3):
      nitrogen6x: convert to DM_I2C and DM_SERIAL
      mx6boards: convert to DM_I2C and DM_SERIAL
      kontron-sl-mx6ul: switch to DM_SERIAL

Emil Kronborg (2):
      clk: imx6q: Add definition for IMX6QDL_CLK_I2C3
      clk: imx6q: Add definition for IMX6QDL_CLK_PWM1

Fabio Estevam (5):
      imx93-u-boot: Describe the CPU clocks in the devicetree
      udoo_neo: Convert to watchdog driver model
      udoo_neo: Select LTO
      udoo-neo: Do not print devicetree model
      udoo-neo: Convert to OF_UPSTREAM

Michael Trimarchi (4):
      clk: imx: clk-imx8mn Fix nand and spi clock parent
      clk: imx8mn: Make parent names arrays const pointers
      clk: imx8mm: Make parent names arrays const pointers
      clk: imx8mp: Make parent names arrays const pointers

 arch/arm/dts/Makefile                          |   5 +-
 arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi |  12 +
 arch/arm/dts/imx6sx-udoo-neo-basic.dts         |  33 --
 arch/arm/dts/imx6sx-udoo-neo-extended.dts      |  26 --
 arch/arm/dts/imx6sx-udoo-neo-full.dts          |  41 ---
 arch/arm/dts/imx6sx-udoo-neo.dtsi              | 482 -------------------------
 arch/arm/dts/imx93-u-boot.dtsi                 |   8 +
 arch/arm/mach-imx/mx6/Kconfig                  |   1 +
 board/boundary/nitrogen6x/nitrogen6x.c         |  79 +---
 board/embest/mx6boards/mx6boards.c             |  70 +---
 board/udoo/neo/neo.c                           |  59 +--
 configs/kontron-sl-mx6ul_defconfig             |   1 +
 configs/marsboard_defconfig                    |   6 +-
 configs/mx6qsabrelite_defconfig                |   7 +-
 configs/nitrogen6dl2g_defconfig                |   7 +-
 configs/nitrogen6dl_defconfig                  |   7 +-
 configs/nitrogen6q2g_defconfig                 |   7 +-
 configs/nitrogen6q_defconfig                   |   7 +-
 configs/nitrogen6s1g_defconfig                 |   7 +-
 configs/nitrogen6s_defconfig                   |   7 +-
 configs/riotboard_defconfig                    |   6 +-
 configs/udoo_neo_defconfig                     |   9 +-
 drivers/clk/imx/clk-imx6q.c                    |   4 +
 drivers/clk/imx/clk-imx8mm.c                   | 157 ++++----
 drivers/clk/imx/clk-imx8mn.c                   | 151 ++++----
 drivers/clk/imx/clk-imx8mp.c                   | 242 ++++++-------
 include/configs/nitrogen6x.h                   |   2 -
 27 files changed, 393 insertions(+), 1050 deletions(-)
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo-basic.dts
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo-extended.dts
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo-full.dts
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo.dtsi
