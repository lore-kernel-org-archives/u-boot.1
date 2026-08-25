Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA546C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94E6960724;
	Tue, 25 Aug 2026 15:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4kTLClq727b2; Tue, 25 Aug 2026 15:58:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673511;
	bh=DvWevB0C6Aszn27MstUJ3VkEuItvdfghPAyLtEtVVmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvLgiJBKzGVcGUKRh1HfimRo3FSHFCmjbwgrZuS4RRe6+Dz6ZUlkZQaVG+jjQ6Rim
	 o1qGqvFzjipeD1q0/OGL/U+kZd9p6rraSzkelnRdTF4tmRds0n/dDwSnufa5iLPa99
	 HqdoJIldxyLMDothbe3qjWIHNH06UjckkMkH+gwt1PWB0VzXYi1ao9z5Yo1AUo9WHj
	 BADYVwOlZaWli+djoKlBcBTyXV0FOmXDni6AxDj3yMocx3O1EDjurywNANzgQ3N5mF
	 VqOHw8Tb+HJxBpNouS1qDAN1lLQhEERyCy1QYKx9OXvggFoAWw/MnA3Xn39DBnK6Wn
	 xQEyj4XjPl36A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B13AE606EC;
	Tue, 25 Aug 2026 15:58:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC2232FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE27140600
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6leNitVF5-hb for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:58:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAE2F40497
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:29 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytXf-000000003tE-1egd; Tue, 25 Aug 2026 15:58:27 +0000
Date: Tue, 25 Aug 2026 16:58:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 03/11] cmd: ubi: create a ubi_blk device when attaching UBI
Message-ID: <4ed29270083cfd1bd8a082908d628f6036065f98.1787673209.git.daniel@makrotopia.org>
References: <cover.1787673209.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787673209.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

A UBI volume can be reached as a partition on the ubi_blk block
device, but that device is only bound from spinand_bind(), so it is
missing on every other flash type (raw NAND, SPI-NOR, ...).

Bind a ubi_blk device when a UBI partition is attached, unless one has
already been created, parented to the MTD device UBI sits on. UBI
volumes then become reachable as block-device partitions regardless of
the underlying flash. The imagemap block path relies on this to read a
UBI volume.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 cmd/ubi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 2b206141a21..91ba21504f4 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -20,7 +20,10 @@
 #include <mtd.h>
 #include <nand.h>
 #include <onenand_uboot.h>
+#include <dm/device.h>
 #include <dm/devres.h>
+#include <dm/root.h>
+#include <dm/uclass-internal.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/err.h>
@@ -670,6 +673,29 @@ int ubi_detach(void)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(UBI_BLOCK)
+static void ubi_blk_bind_once(void)
+{
+	struct udevice *dev;
+
+	/*
+	 * A single ubi_blk device serves all volumes of the attached UBI
+	 * device, the volume being selected through the block descriptor's
+	 * hwpart. Bind one when UBI is attached -- unless a previous attach
+	 * already did -- parented to the MTD device UBI sits on.
+	 */
+	for (uclass_find_first_device(UCLASS_BLK, &dev); dev;
+	     uclass_find_next_device(&dev)) {
+		if (dev->driver == DM_DRIVER_GET(ubi_blk))
+			return;
+	}
+
+	ubi_bind(ubi && ubi->mtd && ubi->mtd->dev ? ubi->mtd->dev : dm_root());
+}
+#else
+static inline void ubi_blk_bind_once(void) { }
+#endif
+
 int ubi_part(const char *part_name, const char *vid_header_offset)
 {
 	struct mtd_info *mtd;
@@ -698,6 +724,7 @@ int ubi_part(const char *part_name, const char *vid_header_offset)
 	}
 
 	ubi = ubi_devices[0];
+	ubi_blk_bind_once();
 
 	return 0;
 }
-- 
2.55.0
