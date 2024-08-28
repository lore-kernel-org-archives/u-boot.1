Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BE3C636E9
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BE188A75;
	Wed, 28 Aug 2024 18:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284A1889F8; Wed, 28 Aug 2024 18:55:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DB5CD88703
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77412DA7;
 Wed, 28 Aug 2024 09:55:23 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352F13F73B;
 Wed, 28 Aug 2024 09:54:54 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2] list: use list_count_nodes() to count list entries
Date: Wed, 28 Aug 2024 22:24:22 +0530
Message-Id: <20240828165422.3553394-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use the API function list_count_nodes() to count the number of list
entries.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V1: Rebased on top of next

 boot/scene.c              | 8 +-------
 drivers/mtd/ubi/fastmap.c | 8 +++-----
 fs/yaffs2/yaffs_guts.c    | 5 ++---
 lib/fwu_updates/fwu_mtd.c | 5 +----
 test/boot/expo.c          | 4 +---
 5 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index ac976aa26b..270c9c6723 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -79,13 +79,7 @@ int scene_title_set(struct scene *scn, uint id)
 
 int scene_obj_count(struct scene *scn)
 {
-	struct scene_obj *obj;
-	int count = 0;
-
-	list_for_each_entry(obj, &scn->obj_head, sibling)
-		count++;
-
-	return count;
+	return list_count_nodes(&scn->obj_head);
 }
 
 void *scene_obj_find(const struct scene *scn, uint id, enum scene_obj_t type)
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 21750e1817..9c6b15b8cb 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -581,13 +581,11 @@ static int count_fastmap_pebs(struct ubi_attach_info *ai)
 	struct ubi_ainf_peb *aeb;
 	struct ubi_ainf_volume *av;
 	struct rb_node *rb1, *rb2;
-	int n = 0;
+	int n;
 
-	list_for_each_entry(aeb, &ai->erase, u.list)
-		n++;
+	n = list_count_nodes(&ai->erase);
 
-	list_for_each_entry(aeb, &ai->free, u.list)
-		n++;
+	n += list_count_nodes(&ai->free);
 
 	 ubi_rb_for_each_entry(rb1, av, &ai->volumes, rb)
 		ubi_rb_for_each_entry(rb2, aeb, &av->root, u.rb)
diff --git a/fs/yaffs2/yaffs_guts.c b/fs/yaffs2/yaffs_guts.c
index e89d02513c..c20f2f8298 100644
--- a/fs/yaffs2/yaffs_guts.c
+++ b/fs/yaffs2/yaffs_guts.c
@@ -4452,13 +4452,12 @@ loff_t yaffs_get_obj_length(struct yaffs_obj *obj)
 int yaffs_get_obj_link_count(struct yaffs_obj *obj)
 {
 	int count = 0;
-	struct list_head *i;
 
 	if (!obj->unlinked)
 		count++;	/* the object itself */
 
-	list_for_each(i, &obj->hard_links)
-	    count++;		/* add the hard links; */
+	/* add the hard links; */
+	count += list_count_nodes(&obj->hard_links);
 
 	return count;
 }
diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index ccaba3f311..c14203b9dd 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -60,10 +60,7 @@ int fwu_mtd_get_alt_num(efi_guid_t *image_id, u8 *alt_num,
 	if (ret)
 		return -ENOENT;
 
-	nalt = 0;
-	list_for_each_entry(dfu, &dfu_list, list)
-		nalt++;
-
+	nalt = list_count_nodes(&dfu_list);
 	if (!nalt) {
 		log_warning("No entities in dfu_alt_info\n");
 		dfu_free_entities();
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 4b24f504e2..9b4aa803eb 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -702,9 +702,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	txt = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 	ut_asserteq_str("2 GHz", expo_get_str(exp, txt->str_id));
 
-	count = 0;
-	list_for_each_entry(item, &menu->item_head, sibling)
-		count++;
+	count = list_count_nodes(&menu->item_head);
 	ut_asserteq(3, count);
 
 	expo_destroy(exp);
-- 
2.34.1

