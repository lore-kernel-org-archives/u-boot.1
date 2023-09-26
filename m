Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FAEE7D266
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9DC86D22;
	Tue, 26 Sep 2023 10:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823AB86D4A; Tue, 26 Sep 2023 10:47:23 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B173186BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp63t1695718021tp7qc85d
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:47:00 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: ILHsT53NKPjiLoKPHaqoE3GVR/rsmlj3FUxxhIdF9q1W9XCMVkFpjyGlorbtI
 6Hkyjm6DaI3YSf9KR3ReUutBe6sMpOXNy5FNV4F99nu7Od4Ca4/MqcTI7ilQcaHchCXryX+
 AlO1bs6XFo9D47yciANqmACq80WKTlhW6XIpcXGQlVI4ou2Y2gsgzlyvYpcLBBc6op9ICfU
 HWt9hHUV0LxLcKbwbghEDA8n+mYYGemw5Fhlfp7wMLfTQ5EE+HYzyOO//jDMloALYwXM0RE
 STag89YH1QOZYOmtt/tZy0Hq5ua97mc0a7EUGzw0jsvj2IJ5x6/Y7xIO1NXGMZ8E8xZSNSI
 24WwTThDfkSlGXs9AE8BdFmjcu4czyHiWvDjljDU+i93UNF5YQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3404121737275044572
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 03/15] blk: sandbox: Support binding a device with a given
 logical block size
Date: Tue, 26 Sep 2023 16:43:33 +0800
Message-Id: <20230926084346.2237483-4-bmeng@tinylab.org>
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

Allow optionally set the logical block size of the host device to
bind in the "host bind" command. If not given, defaults to 512.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/host.c                  | 16 +++++++++++++---
 drivers/block/host-uclass.c | 15 ++++++++++++---
 include/sandbox_host.h      |  7 +++++--
 test/dm/blk.c               |  7 ++++---
 test/dm/host.c              |  6 +++---
 5 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/cmd/host.c b/cmd/host.c
index b924940ffb..2334ccd9bc 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -13,6 +13,7 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/errno.h>
+#include <linux/log2.h>
 
 static int do_host_load(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
@@ -45,6 +46,7 @@ static int do_host_bind(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct udevice *dev;
 	const char *label;
 	char *file;
+	unsigned long blksz = DEFAULT_BLKSZ;
 	int ret;
 
 	/* Skip 'bind' */
@@ -59,12 +61,19 @@ static int do_host_bind(struct cmd_tbl *cmdtp, int flag, int argc,
 		argv++;
 	}
 
-	if (argc != 2)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 	label = argv[0];
 	file = argv[1];
+	if (argc > 2) {
+		blksz = dectoul(argv[2], NULL);
+		if (blksz < DEFAULT_BLKSZ || !is_power_of_2(blksz)) {
+			printf("blksz must be >= 512 and power of 2\n");
+			return CMD_RET_FAILURE;
+		}
+	}
 
-	ret = host_create_attach_file(label, file, removable, &dev);
+	ret = host_create_attach_file(label, file, removable, blksz, &dev);
 	if (ret) {
 		printf("Cannot create device / bind file\n");
 		return CMD_RET_FAILURE;
@@ -253,7 +262,8 @@ U_BOOT_CMD(
 	"host save hostfs - <addr> <filename> <bytes> [<offset>] - "
 		"save a file to host\n"
 	"host size hostfs - <filename> - determine size of file on host\n"
-	"host bind [-r] <label> <filename> - bind \"host\" device to file\n"
+	"host bind [-r] <label> <filename> [<blksz>] - bind \"host\" device to file,\n"
+	"     and optionally set the device's logical block size\n"
 	"     -r = mark as removable\n"
 	"host unbind <label>     - unbind file from \"host\" device\n"
 	"host info [<label>]     - show device binding & info\n"
diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
index 6460d968c2..b3647e3ce3 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -13,6 +13,7 @@
 #include <blk.h>
 #include <dm.h>
 #include <malloc.h>
+#include <part.h>
 #include <sandbox_host.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
@@ -29,7 +30,8 @@ struct host_priv {
 	struct udevice *cur_dev;
 };
 
-int host_create_device(const char *label, bool removable, struct udevice **devp)
+int host_create_device(const char *label, bool removable, unsigned long blksz,
+		       struct udevice **devp)
 {
 	char dev_name[30], *str, *label_new;
 	struct host_sb_plat *plat;
@@ -68,6 +70,12 @@ int host_create_device(const char *label, bool removable, struct udevice **devp)
 		struct blk_desc *desc = dev_get_uclass_plat(blk);
 
 		desc->removable = removable;
+
+		/* update blk device's block size with the provided one */
+		if (blksz != desc->blksz) {
+			desc->blksz = blksz;
+			desc->log2blksz = LOG2(desc->blksz);
+		}
 	}
 
 	plat = dev_get_plat(dev);
@@ -95,12 +103,13 @@ int host_attach_file(struct udevice *dev, const char *filename)
 }
 
 int host_create_attach_file(const char *label, const char *filename,
-			    bool removable, struct udevice **devp)
+			    bool removable, unsigned long blksz,
+			    struct udevice **devp)
 {
 	struct udevice *dev;
 	int ret;
 
-	ret = host_create_device(label, removable, &dev);
+	ret = host_create_device(label, removable, blksz, &dev);
 	if (ret)
 		return log_msg_ret("cre", ret);
 
diff --git a/include/sandbox_host.h b/include/sandbox_host.h
index ebd7d99b47..f7a5fc6723 100644
--- a/include/sandbox_host.h
+++ b/include/sandbox_host.h
@@ -74,10 +74,11 @@ int host_detach_file(struct udevice *dev);
  * @label: Label of the attachment, e.g. "test1"
  * @removable: true if the device should be marked as removable, false
  *	if it is fixed. See enum blk_flag_t
+ * @blksz: logical block size of the device
  * @devp: Returns the device created, on success
  * Returns: 0 if OK, -ve on error
  */
-int host_create_device(const char *label, bool removable,
+int host_create_device(const char *label, bool removable, unsigned long blksz,
 		       struct udevice **devp);
 
 /**
@@ -87,11 +88,13 @@ int host_create_device(const char *label, bool removable,
  * @filename: Name of the file, e.g. "/path/to/disk.img"
  * @removable: true if the device should be marked as removable, false
  *	if it is fixed. See enum blk_flag_t
+ * @blksz: logical block size of the device
  * @devp: Returns the device created, on success
  * Returns: 0 if OK, -ve on error
  */
 int host_create_attach_file(const char *label, const char *filename,
-			    bool removable, struct udevice **devp);
+			    bool removable, unsigned long blksz,
+			    struct udevice **devp);
 
 /**
  * host_find_by_label() - Find a host by label
diff --git a/test/dm/blk.c b/test/dm/blk.c
index 446c4423e6..799f1e4dc7 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <blk.h>
 #include <dm.h>
 #include <part.h>
 #include <sandbox_host.h>
@@ -22,8 +23,8 @@ static int dm_test_blk_base(struct unit_test_state *uts)
 	struct udevice *blk0, *blk1, *dev0, *dev1, *dev, *chk0, *chk1;
 
 	/* Create two, one the parent of the other */
-	ut_assertok(host_create_device("test0", false, &dev0));
-	ut_assertok(host_create_device("test1", false, &dev1));
+	ut_assertok(host_create_device("test0", false, DEFAULT_BLKSZ, &dev0));
+	ut_assertok(host_create_device("test1", false, DEFAULT_BLKSZ, &dev1));
 
 	/* Check we can find them */
 	ut_assertok(blk_get_device(UCLASS_HOST, 0, &blk0));
@@ -99,7 +100,7 @@ static int dm_test_blk_find(struct unit_test_state *uts)
 {
 	struct udevice *blk, *chk, *dev;
 
-	ut_assertok(host_create_device("test0", false, &dev));
+	ut_assertok(host_create_device("test0", false, DEFAULT_BLKSZ, &dev));
 
 	ut_assertok(blk_find_device(UCLASS_HOST, 0, &chk));
 	ut_assertok(device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk));
diff --git a/test/dm/host.c b/test/dm/host.c
index 355ba7770a..19f6c67462 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -32,7 +32,7 @@ static int dm_test_host(struct unit_test_state *uts)
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
 
 	mem_start = ut_check_delta(0);
-	ut_assertok(host_create_device(label, true, &dev));
+	ut_assertok(host_create_device(label, true, DEFAULT_BLKSZ, &dev));
 
 	/* Check that the plat data has been allocated */
 	plat = dev_get_plat(dev);
@@ -81,7 +81,7 @@ static int dm_test_host_dup(struct unit_test_state *uts)
 	struct udevice *dev, *chk;
 
 	ut_asserteq(0, uclass_id_count(UCLASS_HOST));
-	ut_assertok(host_create_device(label, true, &dev));
+	ut_assertok(host_create_device(label, true, DEFAULT_BLKSZ, &dev));
 
 	/* Attach a file created in test_host.py */
 	ut_assertok(host_attach_file(dev, filename));
@@ -90,7 +90,7 @@ static int dm_test_host_dup(struct unit_test_state *uts)
 	ut_asserteq(1, uclass_id_count(UCLASS_HOST));
 
 	/* Create another device with the same label (should remove old one) */
-	ut_assertok(host_create_device(label, true, &dev));
+	ut_assertok(host_create_device(label, true, DEFAULT_BLKSZ, &dev));
 
 	/* Attach a different file created in test_host.py */
 	ut_assertok(host_attach_file(dev, filename2));
-- 
2.25.1

