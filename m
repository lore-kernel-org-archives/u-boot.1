Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9DBD3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709B48915A;
	Fri, 18 Oct 2024 03:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rLE92TNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2245B89169; Fri, 18 Oct 2024 03:30:27 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED3289125
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BA77A408CC; 
 Fri, 18 Oct 2024 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729215023;
 bh=J/hjgtmJnHTOL7OIYLlnrXHlx5x8NXd5SnczrWboZNE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rLE92TNGHw7WU7ZlsQJ6CT6inWF8hGR2RPfxcXmvfsuAyI2PNuJHPCska8aBYIW1S
 MT761TkSEPb9/klt26A4RNWVr5QNL0SjhjrSFASViSQBUkg2e6qeCv/zKIyH3+pZM+
 reFsVv2wRQLLiJDBFLndib73aecij4f1A9B7WGwqjCLrEd3NnNmjNwcMDj9Q3May3Y
 zVO1Pt/wM6nRgwdvcFwYIwI/kXqWF+5AbQSBD4Jl35Hrj91LrzyFGEYmdTI1x/U/fl
 gI/cZH5oE7nyzUH/Znnt3qy4j5aD+bQR63ks0IneIQ7PUQMDtcR86/RIoLQL5JAqDL
 tDSYWjeJSxuQw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] block: make blk_create_device() static
Date: Fri, 18 Oct 2024 03:30:15 +0200
Message-ID: <20241018013015.127620-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
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

There are no users of the blk_create_device() function outside the uclass.
Let's make it static. This will ensure that new block drivers will use
blk_create_devicef().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/block/blk-uclass.c | 19 ++++++++++++++++---
 include/blk.h              | 17 -----------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 312e038445c..f3ac8db9464 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -695,9 +695,22 @@ static int blk_claim_devnum(enum uclass_id uclass_id, int devnum)
 	return -ENOENT;
 }
 
-int blk_create_device(struct udevice *parent, const char *drv_name,
-		      const char *name, int uclass_id, int devnum, int blksz,
-		      lbaint_t lba, struct udevice **devp)
+/**
+ * blk_create_device() - Create a new block device
+ *
+ * @parent:	Parent of the new device
+ * @drv_name:	Driver name to use for the block device
+ * @name:	Name for the device
+ * @uclass_id:	Interface type (enum uclass_id_t)
+ * @devnum:	Device number, specific to the interface type, or -1 to
+ *		allocate the next available number
+ * @blksz:	Block size of the device in bytes (typically 512)
+ * @lba:	Total number of blocks of the device
+ * @devp:	the new device (which has not been probed)
+ */
+static int blk_create_device(struct udevice *parent, const char *drv_name,
+			     const char *name, int uclass_id, int devnum,
+			     int blksz, lbaint_t lba, struct udevice **devp)
 {
 	struct blk_desc *desc;
 	struct udevice *dev;
diff --git a/include/blk.h b/include/blk.h
index 1fc9a5b8471..261c7dd6616 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -376,23 +376,6 @@ int blk_first_device(int uclass_id, struct udevice **devp);
  */
 int blk_next_device(struct udevice **devp);
 
-/**
- * blk_create_device() - Create a new block device
- *
- * @parent:	Parent of the new device
- * @drv_name:	Driver name to use for the block device
- * @name:	Name for the device
- * @uclass_id:	Interface type (enum uclass_id_t)
- * @devnum:	Device number, specific to the interface type, or -1 to
- *		allocate the next available number
- * @blksz:	Block size of the device in bytes (typically 512)
- * @lba:	Total number of blocks of the device
- * @devp:	the new device (which has not been probed)
- */
-int blk_create_device(struct udevice *parent, const char *drv_name,
-		      const char *name, int uclass_id, int devnum, int blksz,
-		      lbaint_t lba, struct udevice **devp);
-
 /**
  * blk_create_devicef() - Create a new named block device
  *
-- 
2.45.2

