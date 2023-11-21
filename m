Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8CAC61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B309D87448;
	Tue, 21 Nov 2023 15:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="bYjcpN2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5524187197; Tue, 21 Nov 2023 15:21:45 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76152875EC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20231121142139b1b7111ac6e99bad7c for <u-boot@lists.denx.de>;
 Tue, 21 Nov 2023 15:21:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zqln31pJBf8kMYl9cTBoI1wcUnTFWn4edehC9is/GZU=;
 b=bYjcpN2aHPJqbCTBQnKAI5VoNrAdsGoO4v/61R5fj+ffvxk8aajh5D6aLmPDtx5BozWi+k
 vfgXRR5J4aS1PMJxMN80QPVY6QQHzRf7MqJEwW7OP4TaLlnmZpAetjlMumjISwEDPpqtua2i
 mJmJdE8xTOozvnISWN8P+ddoYbdbo=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 0/6] board: siemens: clean up subfolders
Date: Tue, 21 Nov 2023 15:21:28 +0100
Message-Id: <20231121142134.2147652-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
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

    This serie depends on the serie:
    [PATCH 0/6] siemens,am335x: clean up the draco board family

    The common folder was initialially created for the common parts of
    the products based on draco-am355x board family. We have the
    product lines 'pxm2', 'rut' and the base line unfortunately named
    'draco'! Adding the new capricorn-imx8 board family, the files
    were enhanced without cleanup.

    Simplify first EEPROM probe and access that implements both i2c
    with & without driver model. Use abstraction functions for this.
    
    Move all am355x specifics to a new file 'board_am335x'.
    
    Clean-up includes, config checks, maintainer.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
Enrico Leto (6):
  siemens: eeprom: clean up definitions
  siemens: eeprom: simplify setup & read
  siemens draco: i2c: use driver model for u-boot
  siemens: board: clean up draco products vs common
  siemens: board: clean up includes
  siemens: factoryset: use correct config for soc specific
    implementation

 board/siemens/capricorn/board.c     |   5 +-
 board/siemens/common/board.c        | 110 ++++++++++++----------------
 board/siemens/common/board.h        |  24 ++++++
 board/siemens/common/board_am335x.c |  58 +++++++++++++++
 board/siemens/common/board_am335x.h |  38 ++++++++++
 board/siemens/common/factoryset.c   |  82 ++++-----------------
 board/siemens/draco/Makefile        |   2 +
 board/siemens/draco/board.c         |  59 ++++-----------
 board/siemens/draco/board.h         |  32 ++------
 board/siemens/draco/mux.c           |   6 +-
 board/siemens/pxm2/MAINTAINERS      |   2 +-
 board/siemens/pxm2/Makefile         |   2 +
 board/siemens/pxm2/board.c          |  34 +++------
 board/siemens/pxm2/board.h          |  21 ------
 board/siemens/pxm2/mux.c            |   6 +-
 board/siemens/rut/MAINTAINERS       |   2 +-
 board/siemens/rut/Makefile          |   2 +
 board/siemens/rut/board.c           |  33 ++-------
 board/siemens/rut/board.h           |  21 ------
 board/siemens/rut/mux.c             |   5 +-
 configs/draco-etamin_defconfig      |   4 +-
 configs/draco-rastaban_defconfig    |   4 +-
 configs/draco-thuban_defconfig      |   4 +-
 include/configs/draco-etamin.h      |   3 -
 include/configs/draco-rastaban.h    |   3 -
 include/configs/draco-thuban.h      |   3 -
 26 files changed, 245 insertions(+), 320 deletions(-)
 create mode 100644 board/siemens/common/board.h
 create mode 100644 board/siemens/common/board_am335x.c
 create mode 100644 board/siemens/common/board_am335x.h
 delete mode 100644 board/siemens/pxm2/board.h
 delete mode 100644 board/siemens/rut/board.h

-- 
2.30.2

