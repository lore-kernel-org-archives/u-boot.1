Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F2CCD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 20:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE4E8799C;
	Tue,  9 Apr 2024 22:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TRTrL/Sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226A487A4B; Tue,  9 Apr 2024 22:06:17 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7DD87947
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 22:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1516F3F187; 
 Tue,  9 Apr 2024 20:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712693174;
 bh=XpsPnCn0xNFWYR4YxuGBaPJgeFrWzhaBLPjS4nMNYsQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TRTrL/Sa2PHkaxmoxw8GVcp2yxmDfCMfeijKx9ZmN0VrSnPdY1ZlondL+WzYMmk5F
 JoNiRyuv2FP17nelfrnIuskeLzU7jL9HiiswE8FvckbNgJSec0xF7A1vdFHwb1waZH
 M8NmesT32feUPjaM75cZ8/dqMCMYQGGNEyjK5CW3E34/9ZzphkHd3mbHTtXSdu+7R1
 62HCwaAMK/03zYma5VEmqH1iEgG6Hof7XemhCUyhU1kp1lghq1z9e4DtUCNpxeviXf
 Z/3y90YKaLdtSyMVd3CqbzT44CXGMOvwdvfB5337MvUO0Qv/M/pCWrFMZjvmu3ewbo
 AfTQcwgTfwnqQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: fat: fill creation and change date
Date: Tue,  9 Apr 2024 22:06:07 +0200
Message-ID: <20240409200607.61893-1-heinrich.schuchardt@canonical.com>
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

The FAT specification requires that the change date is set.

If a DM RTC device exists, set the creation and change date to the current
date when updating the directory entry. Otherwise use the date 2020-01-01.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat_write.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 8b5d669b005..c8e0fbf1a3b 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -18,6 +18,7 @@
 #include <rand.h>
 #include <asm/byteorder.h>
 #include <asm/cache.h>
+#include <dm/uclass.h>
 #include <linux/ctype.h>
 #include <linux/math64.h>
 #include "fat.c"
@@ -1151,6 +1152,41 @@ getit:
 	return 0;
 }
 
+/**
+ * dentry_set_time() - set change time
+ *
+ * @dentptr:	directory entry
+ */
+static void dentry_set_time(dir_entry *dentptr)
+{
+	if (CONFIG_IS_ENABLED(DM_RTC)) {
+		struct udevice *dev;
+		struct rtc_time tm;
+		u16 date;
+		u16 time;
+
+		uclass_first_device(UCLASS_RTC, &dev);
+		if (!dev)
+			goto err;
+		if (dm_rtc_get(dev, &tm))
+			goto err;
+		if (tm.tm_year < 1980 || tm.tm_year > 2107)
+			goto err;
+		date = (tm.tm_mday & 0x1f) |
+		       ((tm.tm_mon & 0xf) << 5) |
+		       ((tm.tm_year - 1980) << 9);
+		time = (tm.tm_sec > 1) |
+		       ((tm.tm_min & 0x3f) << 5) |
+		(tm.tm_hour << 11);
+		dentptr->date = date;
+		dentptr->time = time;
+		return;
+	}
+err:
+	dentptr->date = 0x2821; /* 2000-01-01 */
+	dentptr->time = 0;
+}
+
 /**
  * fill_dentry() - fill directory entry with shortname
  *
@@ -1171,6 +1207,12 @@ static void fill_dentry(fsdata *mydata, dir_entry *dentptr,
 
 	dentptr->attr = attr;
 
+	/* Set change date */
+	dentry_set_time(dentptr);
+	/* Set creation date */
+	dentptr->cdate = dentptr->date;
+	dentptr->ctime = dentptr->time;
+
 	memcpy(&dentptr->nameext, shortname, SHORT_NAME_SIZE);
 }
 
@@ -1376,6 +1418,8 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
 
 		/* Update file size in a directory entry */
 		retdent->size = cpu_to_le32(pos + size);
+		/* Update change date */
+		dentry_set_time(retdent);
 	} else {
 		/* Create a new file */
 		char shortname[SHORT_NAME_SIZE];
-- 
2.43.0

