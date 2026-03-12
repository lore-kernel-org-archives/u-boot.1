Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C248FED2FA
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63EA8418C;
	Thu, 12 Mar 2026 10:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TV/bpsf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D160384189; Thu, 12 Mar 2026 10:57:38 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06DA83F14
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=tLUVCLrjGpwsArUSiFtjWtCgIr+B5Dzc0Sz6nIz5n2Y=; b=TV/bpsf3bxTl+QmSj59+7p+U2u
 TYe4L55wrskMh+iM08GRXVO+O9/diZTH0kPsmzG4WFo6AgoO2eDzyoH1pej0BG+yxAwapaIyh1IJ4
 6OXPWiFGz1F46JzdTfymAHvWxoDkLxPm96R4h/EQAi7T8NZgWRld12MQpiU18FjNDRsmZfKNtZ940
 5Bwh9rxEDwcWq/TRPEKZzWdt+PQHoA7GiwqovcJ0XMfjipGFVR2ZfuDrKWjprsp6VzMDj6Pcbsgcc
 8uELJKpF5TAq2xgXks08rFmP9BGiLAHzRpCTA8qPjyH14e51eHzVRpdFFzw1cAkHONUskOjLXmRRM
 CkYVJQsg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-0007xD-0D; Thu, 12 Mar 2026 10:57:36 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnP-000Fyo-2N; Thu, 12 Mar 2026 10:57:35 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 00/13] TQMa6 with preparations for integrating additional TQ
 boards
Date: Thu, 12 Mar 2026 10:56:56 +0100
Message-ID: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

This series introduces features for sharing across different TQ boards,
simplifying maintenance by avoiding code duplication.

These changes are implemented for the TQMa6.
They will also be used by TQMa7 and TQMa6UL, whose mainlining is currently
being prepared.

These changes also serve as preparation for further work on the TQMa6
(in following series).

Markus Niebel (3):
  MAINTAINERS: update entry for TQ-Systems
  env: tq: add shareable environment settings
  board/tq: Add common baseboard API

Max Merchel (8):
  tqma6: remove board MAINTAINERS
  [cleanup]configs: tqma6.h: remove unused define for PHYS_SDRAM_SIZE
  [cleanup]configs: tqma6.h: remove unused define for PFUZE100_I2C
  board: tqma6: change to use shareable tq environment
  configs: tqma6: change to include tqma6.h in baseboard headers
  board/tq: Add common mmc API
  board: tqma6: use common TQ mmc function
  board: tqma6: use runtime SoC detection in enet setup

Paul Gerber (2):
  board: tqma6: use common TQ baseboard
  board: tqma6: update eMMC DSR handling

 MAINTAINERS                      |  15 +-
 board/tq/common/Kconfig          |  13 ++
 board/tq/common/Makefile         |   9 ++
 board/tq/common/tq_bb.c          |  78 +++++++++
 board/tq/common/tq_bb.h          |  39 +++++
 board/tq/common/tq_sdmmc.c       |  46 ++++++
 board/tq/tqma6/Kconfig           |   8 +-
 board/tq/tqma6/MAINTAINERS       |   7 -
 board/tq/tqma6/Makefile          |   1 +
 board/tq/tqma6/tqma6.c           |  39 +++--
 board/tq/tqma6/tqma6.env         |  47 ++++++
 board/tq/tqma6/tqma6_bb.h        |  28 ----
 board/tq/tqma6/tqma6_emmc.c      |  88 ++++++++++
 board/tq/tqma6/tqma6_emmc.h      |  19 +++
 board/tq/tqma6/tqma6_mba6.c      | 150 ++++++++---------
 board/tq/tqma6/tqma6_wru4.c      |  29 +---
 include/configs/tqma6.h          | 266 ++-----------------------------
 include/configs/tqma6_mba6.h     |   3 +-
 include/configs/tqma6_wru4.h     |   2 +
 include/env/tq/mmc.env           |  82 ++++++++++
 include/env/tq/nfs.env           |  51 ++++++
 include/env/tq/spi.env           |  23 +++
 include/env/tq/tq-imx-shared.env |  38 +++++
 include/env/tq/ubi.env           |  47 ++++++
 24 files changed, 721 insertions(+), 407 deletions(-)
 create mode 100644 board/tq/common/Kconfig
 create mode 100644 board/tq/common/Makefile
 create mode 100644 board/tq/common/tq_bb.c
 create mode 100644 board/tq/common/tq_bb.h
 create mode 100644 board/tq/common/tq_sdmmc.c
 delete mode 100644 board/tq/tqma6/MAINTAINERS
 create mode 100644 board/tq/tqma6/tqma6.env
 delete mode 100644 board/tq/tqma6/tqma6_bb.h
 create mode 100644 board/tq/tqma6/tqma6_emmc.c
 create mode 100644 board/tq/tqma6/tqma6_emmc.h
 create mode 100644 include/env/tq/mmc.env
 create mode 100644 include/env/tq/nfs.env
 create mode 100644 include/env/tq/spi.env
 create mode 100644 include/env/tq/tq-imx-shared.env
 create mode 100644 include/env/tq/ubi.env

-- 
2.43.0

