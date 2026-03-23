Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ACDF4610D
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBD6284180;
	Mon, 23 Mar 2026 14:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XpIOtFek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B048084144; Mon, 23 Mar 2026 14:48:01 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA3884099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=b0uWArjc6/32EUg7FTU6f/LF5DMispAhgn3qfH+/h1A=; b=XpIOtFekn90LvRb6T43lxSyD16
 WeIhVaXpjiIbp7CxzZokbfNHSuberq9a4qwwhyg9Ci6Q84w9MznEzfUlB0JYhuqchp3PThyAgHgYN
 yYUlIO2uiag11Nk05GxHa2oINIcz/cOq2hS6YmUuUH5mZ6+qDvgn8OerEbpztTIffbomC3ZFwez5J
 9ddQ4fMRCCg1VvwV+YZcD8khPNP/CbQU3yayMJsFrAEvCyKHyPTod2+YhmMYNmGMIZ1kgTpspU+1f
 6FWhATh75Ts05fbZTirqRk0GKnHHhMd0RvdyRmovBErk2g8L7rBf2YcXJlWiAf5LdkPsKsg5nPP4F
 YATqyaBw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w4fdO-0000d9-16; Mon, 23 Mar 2026 14:47:58 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w4fdN-000M7t-0N; Mon, 23 Mar 2026 14:47:57 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH v2 00/10] TQMa6 with preparations for integrating additional
 TQ boards
Date: Mon, 23 Mar 2026 14:47:30 +0100
Message-ID: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

This series introduces features for sharing across different TQ boards,
simplifying maintenance by avoiding code duplication.

These changes are implemented for the TQMa6.
They will also be used by TQMa7 and TQMa6UL, whose mainlining is currently
being prepared.

These changes also serve as preparation for further work on the TQMa6
(in following series).

Changes V2:
- Drop patches 1 and 2 from the series.
  They cause CI errors and need to be revised.
- Drop patch 12 with planned SPL usage the values ​​can be
  read from the device trees.
- Uptate commit log (Use imperative mood)

Markus Niebel (2):
  env: tq: add shareable environment settings
  board/tq: Add common baseboard API

Max Merchel (6):
  [cleanup]configs: tqma6.h: remove unused define for PHYS_SDRAM_SIZE
  [cleanup]configs: tqma6.h: remove unused define for PFUZE100_I2C
  board: tqma6: change to use shareable tq environment
  configs: tqma6: change to include tqma6.h in baseboard headers
  board/tq: Add common mmc API
  board: tqma6: use common TQ mmc function

Paul Gerber (2):
  board: tqma6: use common TQ baseboard
  board: tqma6: update eMMC DSR handling

 board/tq/common/Kconfig          |  13 ++
 board/tq/common/Makefile         |   9 ++
 board/tq/common/tq_bb.c          |  78 +++++++++
 board/tq/common/tq_bb.h          |  39 +++++
 board/tq/common/tq_sdmmc.c       |  46 ++++++
 board/tq/tqma6/Kconfig           |   8 +-
 board/tq/tqma6/Makefile          |   1 +
 board/tq/tqma6/tqma6.c           |  39 +++--
 board/tq/tqma6/tqma6.env         |  47 ++++++
 board/tq/tqma6/tqma6_bb.h        |  28 ----
 board/tq/tqma6/tqma6_emmc.c      |  88 ++++++++++
 board/tq/tqma6/tqma6_emmc.h      |  19 +++
 board/tq/tqma6/tqma6_mba6.c      |  26 +--
 board/tq/tqma6/tqma6_wru4.c      |  29 +---
 include/configs/tqma6.h          | 266 ++-----------------------------
 include/configs/tqma6_mba6.h     |   3 +-
 include/configs/tqma6_wru4.h     |   2 +
 include/env/tq/mmc.env           |  82 ++++++++++
 include/env/tq/nfs.env           |  51 ++++++
 include/env/tq/spi.env           |  23 +++
 include/env/tq/tq-imx-shared.env |  38 +++++
 include/env/tq/ubi.env           |  47 ++++++
 22 files changed, 641 insertions(+), 341 deletions(-)
 create mode 100644 board/tq/common/Kconfig
 create mode 100644 board/tq/common/Makefile
 create mode 100644 board/tq/common/tq_bb.c
 create mode 100644 board/tq/common/tq_bb.h
 create mode 100644 board/tq/common/tq_sdmmc.c
 create mode 100644 board/tq/tqma6/tqma6.env
 delete mode 100644 board/tq/tqma6/tqma6_bb.h
 create mode 100644 board/tq/tqma6/tqma6_emmc.c
 create mode 100644 board/tq/tqma6/tqma6_emmc.h
 create mode 100644 include/env/tq/mmc.env
 create mode 100644 include/env/tq/nfs.env
 create mode 100644 include/env/tq/spi.env
 create mode 100644 include/env/tq/tq-imx-shared.env
 create mode 100644 include/env/tq/ubi.env


base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
-- 
2.43.0

