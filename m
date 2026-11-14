Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF1606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h4p3/Ap3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFE3360DA5;
	Sat, 14 Nov 2026 00:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKP1pH8Y09Me; Sat, 14 Nov 2026 00:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E720F6071D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615132;
	b=rvMK2Vy8hvYYUr5Tv6fK5Hkz2MXdJ7FHfDp9ToN+uz6h+cyXnxvANk1Q7cLNNUyhir5+
	 sGe+tfzu27Mlvp9Ns3l8HZmCLsdvRZ5t/GCU5KpT5Ykuwcj61H8wqzcEZOzaN0JrMg5Yl
	 lzGbfu/zAy4qLfGlQIu+G5dHNUgaa+hJqwx98b5Zntco0OvELZdHHFaG4RTbBasAO3fUK
	 NBHHBGO3uK3h2hKenc9OXmyKAVKIlgtmpHJ3NdbKMEHAuiiGnptbekyg+m0MFfVs+Xa3S
	 9+xuiHQIQhpy+XAwkjq9uhqd0LrhgSKudo2OBkuv8NQg4/8nBxfCm6vnlttT5KUbaNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jm+9WeTAg2MURi84gwxgLxP55qVwsdno237Qkmj9VuM=;
	b=JEn5VLdL8rgPAJQRbH4hS0dsEMcIbcOgXa4Cwl/dlkqOgzbBUpLut2WWQRwoe6WmqvFR
	 Dc++c3B8aTsmP1Em16f63pgnT7Pjt5L5Of9Se8QXvYNzB9O6361szFW2+5ThpLOFsHPTd
	 RpaQXx3qZcVIwqD3usINyPO9xEj82H3E9fkzNUuAY7KO7yl66cB3mkfgslvwVEw6PVX0o
	 5H8fE1AOjF58Xo+jMzBpY7YAOYVtY24kqj30zzDL0ETRJeFoH/AP7p/5DTnJUBhJnaR/G
	 yP87hMZ0OEVj7HIhRU4zxuFmlX/W4HqKpJ29EPf5LPifgZOCCZ2zzGjpbofFr9XMfPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615132;
	bh=Jm+9WeTAg2MURi84gwxgLxP55qVwsdno237Qkmj9VuM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h4p3/Ap3i7qd4ViTv8yxZHFi0OE4c5p5jWbSIh7q/DuLZnrJhgtc1zTb8yqVmCHxA
	 sbPj+JEgFAmIK6Xs2WakBH9BAjtuJyn3eeeWK3jRY8xmvr0hk8Op9xdusP6in0ElF/
	 Ut6Dmwd7AfXoMdDvCDz5b1ks14QprAVwlflUaCCDWBbrK92tkfpDhpfFTelf787+t/
	 5Yc9jqr9IT+M68ONPhe++X35yhx0ztcmFJczymY3D06zR4gHNqlzwX3zkNb5nPyNtz
	 vTcfTkAleqAEE9eK1bs+d41Kd/WsMk/Qk9hR+bP5EV4gSK5HAlCR5mAbEJv/JsSogm
	 DhIfCqgykQBNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E720F6071D;
	Sat, 14 Nov 2026 00:12:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7F462FB
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE312606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjjjaXsSVSkU for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B19B6065A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B19B6065A
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:12:08 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1N9-0000000007D-3AtC;
 Sat, 14 Nov 2026 00:11:59 +0000
Date: Sat, 14 Nov 2026 00:11:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 7/9] mtd: Unbind the block device when removing a master
Message-ID: <3bb8a258bbf331627e61d5a0cfc6ce4f4b234f80.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Removing an MTD master leaves its block device bound, so each SPI
flash re-probe adds another block device and leaks its pointer storage.
Unbind the block device and free the storage when deleting the master.
Share the condition used to identify masters which have block devices.

Fixes: e8a7453824b7 ("mtd: bind an mtd_blk device for non-NAND MTD masters")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/mtdcore.c | 48 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3d3a84df0a6..34009f997f8 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -30,6 +30,7 @@
 #include <linux/bug.h>
 #include <linux/err.h>
 #include <ubi_uboot.h>
+#include <dm/device-internal.h>
 #endif
 
 #include <linux/log2.h>
@@ -396,6 +397,44 @@ static struct device_type mtd_devtype = {
 };
 #endif
 
+static bool mtd_is_blk_master(struct mtd_info *mtd)
+{
+	return IS_ENABLED(CONFIG_MTD_BLOCK) && mtd->dev &&
+	       !mtd_is_partition(mtd) && !mtd_type_is_nand(mtd);
+}
+
+static void mtd_blk_unbind(struct mtd_info *mtd, struct udevice *blk)
+{
+	struct mtd_info **mtdp;
+	int ret;
+
+	if (strcmp(blk->driver->name, "mtd_blk"))
+		return;
+
+	mtdp = dev_get_priv(blk);
+	if (!mtdp || *mtdp != mtd)
+		return;
+
+	ret = device_remove(blk, DM_REMOVE_NORMAL);
+	if (!ret)
+		ret = device_unbind(blk);
+	if (ret) {
+		pr_warn("mtd: %s: cannot unbind the block device: %d\n",
+			mtd->name, ret);
+		return;
+	}
+
+	kfree(mtdp);
+}
+
+static void mtd_blk_unbind_master(struct mtd_info *mtd)
+{
+	struct udevice *blk, *next;
+
+	list_for_each_entry_safe(blk, next, &mtd->dev->child_head, sibling_node)
+		mtd_blk_unbind(mtd, blk);
+}
+
 static void mtd_blk_bind_master(struct mtd_info *mtd)
 {
 	struct mtd_info **mtdp;
@@ -403,7 +442,7 @@ static void mtd_blk_bind_master(struct mtd_info *mtd)
 
 	/*
 	 * mtd_bind() keeps the passed pointer, so it needs storage that lives
-	 * as long as the block device; an MTD master is never removed.
+	 * as long as the block device.
 	 */
 	mtdp = kmalloc(sizeof(*mtdp), GFP_KERNEL);
 	if (!mtdp) {
@@ -520,8 +559,7 @@ int add_mtd_device(struct mtd_info *mtd)
 
 	mutex_unlock(&mtd_table_mutex);
 
-	if (IS_ENABLED(CONFIG_MTD_BLOCK) && mtd->dev &&
-	    !mtd_is_partition(mtd) && !mtd_type_is_nand(mtd)) {
+	if (mtd_is_blk_master(mtd)) {
 		/*
 		 * Expose a non-NAND MTD master (parallel NOR, SPI-NOR, ...) as
 		 * a mtd_blk block device, so its partitions are reachable
@@ -596,6 +634,10 @@ int del_mtd_device(struct mtd_info *mtd)
 		device_unregister(&mtd->dev);
 #endif
 
+		if (CONFIG_IS_ENABLED(DM_DEVICE_REMOVE) &&
+		    mtd_is_blk_master(mtd))
+			mtd_blk_unbind_master(mtd);
+
 		idr_remove(&mtd_idr, mtd->index);
 
 		module_put(THIS_MODULE);
-- 
2.56.0
