Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39201E7D273
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 10:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729D386D36;
	Tue, 26 Sep 2023 12:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A864386D55; Tue, 26 Sep 2023 12:09:42 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E67586D41
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-Spam: true
X-QQ-mid: bizesmtp85t1695718661tkokvk86
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:57:40 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 13/15] dm: blk: Drop blk_{read,write}_devnum()
Date: Tue, 26 Sep 2023 16:43:43 +0800
Message-Id: <20230926084346.2237483-14-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz6a-0
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

blk_{read,write}_devnum() are no longer used by anywhere in the
source tree. Drop them.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/block/blk-uclass.c | 29 -----------------------------
 include/blk.h              | 26 --------------------------
 2 files changed, 55 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 9407621fb2..a4c6cf194c 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -315,35 +315,6 @@ int blk_show_device(enum uclass_id uclass_id, int devnum)
 	return 0;
 }
 
-ulong blk_read_devnum(enum uclass_id uclass_id, int devnum, lbaint_t start,
-		      lbaint_t blkcnt, void *buffer)
-{
-	struct blk_desc *desc;
-	ulong n;
-	int ret;
-
-	ret = blk_get_desc(uclass_id, devnum, &desc);
-	if (ret)
-		return ret;
-	n = blk_dread(desc, start, blkcnt, buffer);
-	if (IS_ERR_VALUE(n))
-		return n;
-
-	return n;
-}
-
-ulong blk_write_devnum(enum uclass_id uclass_id, int devnum, lbaint_t start,
-		       lbaint_t blkcnt, const void *buffer)
-{
-	struct blk_desc *desc;
-	int ret;
-
-	ret = blk_get_desc(uclass_id, devnum, &desc);
-	if (ret)
-		return ret;
-	return blk_dwrite(desc, start, blkcnt, buffer);
-}
-
 int blk_select_hwpart(struct udevice *dev, int hwpart)
 {
 	const struct blk_ops *ops = blk_get_ops(dev);
diff --git a/include/blk.h b/include/blk.h
index 0cd758d6f7..e1477df3b6 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -718,32 +718,6 @@ int blk_print_device_num(enum uclass_id uclass_id, int devnum);
  */
 int blk_print_part_devnum(enum uclass_id uclass_id, int devnum);
 
-/**
- * blk_read_devnum() - read blocks from a device
- *
- * @uclass_id:	Block device type
- * @devnum:	Device number
- * @start:	Start block number to read (0=first)
- * @blkcnt:	Number of blocks to read
- * @buffer:	Address to write data to
- * Return: number of blocks read, or -ve error number on error
- */
-ulong blk_read_devnum(enum uclass_id uclass_id, int devnum, lbaint_t start,
-		      lbaint_t blkcnt, void *buffer);
-
-/**
- * blk_write_devnum() - write blocks to a device
- *
- * @uclass_id:	Block device type
- * @devnum:	Device number
- * @start:	Start block number to write (0=first)
- * @blkcnt:	Number of blocks to write
- * @buffer:	Address to read data from
- * Return: number of blocks written, or -ve error number on error
- */
-ulong blk_write_devnum(enum uclass_id uclass_id, int devnum, lbaint_t start,
-		       lbaint_t blkcnt, const void *buffer);
-
 /**
  * blk_select_hwpart_devnum() - select a hardware partition
  *
-- 
2.25.1

