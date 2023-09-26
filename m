Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED701E7D26B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4D086DA7;
	Tue, 26 Sep 2023 10:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BF686D93; Tue, 26 Sep 2023 10:56:16 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2782786DA7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp79t1695718534t8g941ol
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:55:32 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: I8hG9CuxGDJqKuZxo5u3u2Wc3HOLo1PDTZs5DZe33NKoNqmxphrA8lz7bD+B/
 EwK3C2iCFXtnZCyxJ9luQNPOUXD7Rx53YAB4ZdCbvX+o06sexV/WX7b7JS7LFx2+Y5WwbJp
 8MUa1FMv0OL6e4qn9MjR/OTPuf38tXbb4zZe/y99Rx2vwTeYqsUYxiSr07rwkEHHbGVWSuS
 eM0EzsY9/ufKl5LNtxd4ro3F9KUAO9ndgbea7qAIZMvVaCfjw37Ua1Ir8fDGrKd1NwiIIwG
 qaN1LmkE95E2nPBXKyVNsIA6hCVplFEB9gVytnxplm9L3y9XAEjP5gXhbETu3zbuix2rk8R
 MmgZqLDLNwe1VYYYxGyTZIltJ4q/TmcGeY9rDCQ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13712936604460321818
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 11/15] dm: blk: Rename get_desc() and make it externally
 visible
Date: Tue, 26 Sep 2023 16:43:41 +0800
Message-Id: <20230926084346.2237483-12-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

get_desc() can be useful outside blk-uclass.c. Let's change it to
an API and make it externally visible.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/block/blk-uclass.c | 26 ++++++++------------------
 include/blk.h              | 12 ++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 614b975e25..9407621fb2 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -176,17 +176,7 @@ struct blk_desc *blk_get_by_device(struct udevice *dev)
 	return NULL;
 }
 
-/**
- * get_desc() - Get the block device descriptor for the given device number
- *
- * @uclass_id:	Interface type
- * @devnum:	Device number (0 = first)
- * @descp:	Returns block device descriptor on success
- * Return: 0 on success, -ENODEV if there is no such device and no device
- * with a higher device number, -ENOENT if there is no such device but there
- * is one with a higher number, or other -ve on other error.
- */
-static int get_desc(enum uclass_id uclass_id, int devnum, struct blk_desc **descp)
+int blk_get_desc(enum uclass_id uclass_id, int devnum, struct blk_desc **descp)
 {
 	bool found_more = false;
 	struct udevice *dev;
@@ -238,7 +228,7 @@ int blk_list_part(enum uclass_id uclass_id)
 	int ret;
 
 	for (ok = 0, devnum = 0;; ++devnum) {
-		ret = get_desc(uclass_id, devnum, &desc);
+		ret = blk_get_desc(uclass_id, devnum, &desc);
 		if (ret == -ENODEV)
 			break;
 		else if (ret)
@@ -261,7 +251,7 @@ int blk_print_part_devnum(enum uclass_id uclass_id, int devnum)
 	struct blk_desc *desc;
 	int ret;
 
-	ret = get_desc(uclass_id, devnum, &desc);
+	ret = blk_get_desc(uclass_id, devnum, &desc);
 	if (ret)
 		return ret;
 	if (desc->type == DEV_TYPE_UNKNOWN)
@@ -278,7 +268,7 @@ void blk_list_devices(enum uclass_id uclass_id)
 	int i;
 
 	for (i = 0;; ++i) {
-		ret = get_desc(uclass_id, i, &desc);
+		ret = blk_get_desc(uclass_id, i, &desc);
 		if (ret == -ENODEV)
 			break;
 		else if (ret)
@@ -295,7 +285,7 @@ int blk_print_device_num(enum uclass_id uclass_id, int devnum)
 	struct blk_desc *desc;
 	int ret;
 
-	ret = get_desc(uclass_id, devnum, &desc);
+	ret = blk_get_desc(uclass_id, devnum, &desc);
 	if (ret)
 		return ret;
 	printf("\nIDE device %d: ", devnum);
@@ -310,7 +300,7 @@ int blk_show_device(enum uclass_id uclass_id, int devnum)
 	int ret;
 
 	printf("\nDevice %d: ", devnum);
-	ret = get_desc(uclass_id, devnum, &desc);
+	ret = blk_get_desc(uclass_id, devnum, &desc);
 	if (ret == -ENODEV || ret == -ENOENT) {
 		printf("unknown device\n");
 		return -ENODEV;
@@ -332,7 +322,7 @@ ulong blk_read_devnum(enum uclass_id uclass_id, int devnum, lbaint_t start,
 	ulong n;
 	int ret;
 
-	ret = get_desc(uclass_id, devnum, &desc);
+	ret = blk_get_desc(uclass_id, devnum, &desc);
 	if (ret)
 		return ret;
 	n = blk_dread(desc, start, blkcnt, buffer);
@@ -348,7 +338,7 @@ ulong blk_write_devnum(enum uclass_id uclass_id, int devnum, lbaint_t start,
 	struct blk_desc *desc;
 	int ret;
 
-	ret = get_desc(uclass_id, devnum, &desc);
+	ret = blk_get_desc(uclass_id, devnum, &desc);
 	if (ret)
 		return ret;
 	return blk_dwrite(desc, start, blkcnt, buffer);
diff --git a/include/blk.h b/include/blk.h
index 4a4365fbbf..0cd758d6f7 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -504,6 +504,18 @@ const char *blk_get_devtype(struct udevice *dev);
  */
 struct blk_desc *blk_get_by_device(struct udevice *dev);
 
+/**
+ * blk_get_desc() - Get the block device descriptor for the given device number
+ *
+ * @uclass_id:	Interface type
+ * @devnum:	Device number (0 = first)
+ * @descp:	Returns block device descriptor on success
+ * Return: 0 on success, -ENODEV if there is no such device and no device
+ * with a higher device number, -ENOENT if there is no such device but there
+ * is one with a higher number, or other -ve on other error.
+ */
+int blk_get_desc(enum uclass_id uclass_id, int devnum, struct blk_desc **descp);
+
 #else
 #include <errno.h>
 /*
-- 
2.25.1

