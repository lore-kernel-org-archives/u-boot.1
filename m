Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A02CA5FEB
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037B282BF2;
	Sun, 18 Jan 2026 02:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGANj6PU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F248307F; Sun, 18 Jan 2026 02:43:59 +0100 (CET)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B6580FA1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2b6bb644e8eso4006848eec.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700635; x=1769305435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MXVvr6pdUdV1QXHo6eu/02qRr7xNibEWbnM8pOVz87M=;
 b=UGANj6PUHlCjD+NiLKVA5GoEhtxfujpVBW2hOQaaaKCMmF2QarLGdVWk0u722x5lNa
 oiUcaZCMX4d75DVn1a4g+fTR1w2FmEg2FecG0+peN5uuqH54XmxsWXMVQ3T3Vrtpwsh3
 DXI+J6kUvZocizCQtiI/QINZufueRNSPBno4MzzTayK7sz3+IhHSyJpltms1DeULYjpW
 sdOko7+JGkrCMWRcamtN/rhSe9C+BTulxqSbMdkGxR76MdD7S3WDwkQ2kzAxvxUwIW7R
 OQarTugCqCWosjW8mZ1r+inYdQo1GUzwD4U6x5aKBn2ri2YJ/+V3dFAjF6KmqotamyLZ
 89Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700635; x=1769305435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXVvr6pdUdV1QXHo6eu/02qRr7xNibEWbnM8pOVz87M=;
 b=EiCFy8ZFN6BAP/bEmS/9SEWFyFEqXc1iwO3tNospBT8YPhomD9ieyqc/PGFeMMh0s7
 pc7N2vV55NM6UBOAddox/ofnWeKyKz5HiSPfpL6MANLHhe1NdQGb3donC2TcP9vyXDnC
 XP8VaGUGlNMidwa60Rs3OUh2cWJB1h00IF6uWDailw07AERFnREgfoACq7UPx9zV7N+2
 nMWrtYcplnLrD1tr1im7oOPXV+wDlJPIcgFEJ0/Z5+y6aFwfds5P7Xvwb4BCMl3soUl5
 adSl6Cm/yYa5zRJneMiwRt1MuvjFEBPt3mYNWwk0CfLNhXGMfdgnGg3qJQQb0IkvgQJi
 fzZw==
X-Gm-Message-State: AOJu0YyylDAkMtn5aU7vObdZCHEbi5yKtAMu8wI+v3InbmIQRPnI+TpB
 0s69ZIlUvDoF0fh12igVoe0VIDx2yz3esJQVy2DLN6BHU9jNUCRBvxOG
X-Gm-Gg: AY/fxX5DOuMqnd254Z3lsEnplrnjlmdbkyhbZQBcUeRp97mfCHR+Hdp1uTfF7Egu1Ep
 B5rMrSnR+wOp98jiiV/Hykz7iT2+jpLwRrohSlNziaT3rcwOhgUvbWTOyv5N5NVDmjcICnYs3Jg
 DD/oM36lZjOb/qMKkF6v4qaaaetfOwR5RYPXl+7jiJYjQ/qezeOM8GPQogCn2GaSDRgGN2u/KXE
 RYhLM2kqEtZoH15tZ+lKUJ+Q5JvFXERciS3P9cSgzMUh4rrlnrrmMVsZlk5xuw5JNW2KkSWeerf
 QGrJVGAj9W9pjSVqAgYGemEdob+olk3jE2S0NSuVX652Tf7QezCqSUDLhPpU5crbFcGXprWVeJa
 wM1zw9vtH4EJULeu18n6jxLDS3AhuNDmemVBRNNo7e0g/ua5z8YbCM6wV58GPsOx8qEn2W4OI45
 vh8921T/JGB7FdoMZ8
X-Received: by 2002:a05:7300:50a:b0:2b0:52ac:92fe with SMTP id
 5a478bee46e88-2b6b410053emr7008804eec.21.1768700634827; 
 Sat, 17 Jan 2026 17:43:54 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61::1001])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6b3651f39sm7685987eec.24.2026.01.17.17.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 17:43:54 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20260117
Date: Sat, 17 Jan 2026 22:43:50 -0300
Message-Id: <20260118014350.1329144-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit ff498a3c5efb424accc1d825cc45cede2540ca13:

  Merge branch 'qcom-main' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2026-01-16 15:14:37 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20260117

for you to fetch changes up to e13f2a92491fa050685b5a32ffdd51a8b2c20ee8:

  board: tqma6: update RAM timing to verified settings Rev.0300D (2026-01-17 15:02:01 -0300)

u-boot-imx-master-20260117
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/29031

- Fix interrupt storms in Linux on the imx93_frdm board.
- Defconfig update for tqma6 board.
- Miscellaneous cleanups/improvements for imx93_evk.
- Allow booting from both USB controlles on i.MX6 DHSOM.
- Handle third MAC address for SMARC i.MX95
----------------------------------------------------------------
Francesco Valla (1):
      imx93_frdm: clear and mask TCPC interrupts

Marek Vasut (1):
      ARM: imx: Enable boot from both USB controllers on all i.MX6 DHSOM

Markus Niebel (1):
      board: tqma6: update RAM timing to verified settings Rev.0300D

Max Krummenacher (1):
      toradex: common: handle third MAC address for SMARC i.MX95

Max Merchel (3):
      board: tqma6: Kconfig: select default SoM variant based on SoC
      configs: tqma6: mba6: add and use defconfigs with general configurations
      configs: tqma6: activate CONFIG_CMD_NFS

Milan P. Stanić (1):
      tools: fix format string in tools/imx8image.c

Paul Gerber (1):
      board: tqma6: improve config settings for TQMa6x/MBa6x

Peng Fan (12):
      imx93_evk: Drop UART pad settings
      imx93_evk: Drop setup_fec
      imx93_evk: Drop board_phy_config
      imx93_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_evk: Cleanup headers
      imx93_qsb: Cleanup headers
      imx91_evk: Cleanup headers
      imx94_evk: Sort header files
      imx95_evk: Sort header files
      imx95/4_evk: Add missing header
      imx93_evk: Invoke the ELE voltage APIs when adjust VDD_SOC voltage
      imx93_qsb: Invoke the ELE voltage APIs when adjust VDD_SOC voltage

Ye Li (1):
      misc: ele_api: Add Voltage change start and finish APIs

 arch/arm/include/asm/mach-imx/ele_api.h |  4 ++
 board/freescale/imx91_evk/imx91_evk.c   |  2 -
 board/freescale/imx91_evk/spl.c         | 28 +++---------
 board/freescale/imx93_evk/imx93_evk.c   | 46 -------------------
 board/freescale/imx93_evk/spl.c         | 35 +++++----------
 board/freescale/imx93_frdm/imx93_frdm.c | 59 ++++++++++++++++++++++++
 board/freescale/imx93_qsb/imx93_qsb.c   |  2 -
 board/freescale/imx93_qsb/spl.c         | 33 +++++---------
 board/freescale/imx94_evk/imx94_evk.c   |  6 +--
 board/freescale/imx94_evk/spl.c         | 11 ++---
 board/freescale/imx95_evk/imx95_evk.c   |  2 +-
 board/freescale/imx95_evk/spl.c         |  9 ++--
 board/toradex/common/tdx-common.c       | 12 +++++
 board/tq/tqma6/Kconfig                  |  8 +++-
 board/tq/tqma6/tqma6dl.cfg              |  8 ++--
 board/tq/tqma6/tqma6q.cfg               | 37 +++++++--------
 board/tq/tqma6/tqma6s.cfg               | 25 ++++++-----
 configs/imx93_11x11_evk_defconfig       |  2 +-
 configs/tqma6_mba6_common.defconfig     | 79 +++++++++++++++++++++++++++++++++
 configs/tqma6_mba6_mmc.defconfig        |  3 ++
 configs/tqma6_mba6_spi.defconfig        |  6 +++
 configs/tqma6dl_mba6_mmc_defconfig      | 74 ++----------------------------
 configs/tqma6dl_mba6_spi_defconfig      | 77 ++------------------------------
 configs/tqma6q_mba6_mmc_defconfig       | 73 ++----------------------------
 configs/tqma6q_mba6_spi_defconfig       | 77 ++------------------------------
 configs/tqma6s_mba6_mmc_defconfig       | 73 ++----------------------------
 configs/tqma6s_mba6_spi_defconfig       | 77 ++------------------------------
 drivers/misc/imx_ele/ele_api.c          | 50 +++++++++++++++++++++
 include/configs/dh_imx6.h               |  1 +
 tools/imx8image.c                       |  2 +-
 30 files changed, 318 insertions(+), 603 deletions(-)
 create mode 100644 configs/tqma6_mba6_common.defconfig
 create mode 100644 configs/tqma6_mba6_mmc.defconfig
 create mode 100644 configs/tqma6_mba6_spi.defconfig
