Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF06CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E03560710;
	Tue, 29 Sep 2026 00:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMkXANe-rzAz; Tue, 29 Sep 2026 00:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8ED6060707
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640313;
	b=fB8Zz0TSUNUm1cA5y3KII6pxHOsCsjWcLVpAZNef73rFGGitfksFmcOr9uv1C4kBjeru
	 dby1JWcyq3u0UN1E8EfdlozuZwkLgPBvXvDjMGXmvN3vPWlGqw9lUI7ajmYXSXpWdc62d
	 XFDBThzFG0nTgPdqVggn4LIWsYZzUJ9Fk/XIXSwADrzpbaoONSNIdpKkcVBr31737YO7B
	 /n6kTIu3WBN1LFhdhSBy5ViVAtgfDWKll6+K8ycMhIvsjg6s8ek4TNdiCWIrZpd0bF52h
	 n2wN4sYsaVh7rm/dliIZj/uyQcUYVhgE4iSrbsUQiJS53HYNS4DPR+Re4K4UJM4IZbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DSdMMCiHe3gZyMuFLp1ScC2czAS+OREFUFd9BogDoCM=;
	b=VetdMYKqeAfJOPjzWXtzBHm6XtRsJZgV6qZaA8q+bbHuO5CIKnpH/uCFwBe4lop/xslW
	 5LKVjIiROzw2FgT/KogW9aTvawGuAWhn0GyJYDWHGBPyRy+lVZ1I8ZZ96xuznOgXHxfld
	 STNGRDHaqU744JDnsxc2FCSeoOh5ll+uTpzJoXR5+WnIvnxsDd1Yb/Xr4qFRcJx4/AN9A
	 f1QkTfwjuXIQ59Jw280MeXtJB20/f4UTKIvNq7r5fULRqbILjOoCbALTBg72i1CdKVb6l
	 JoNq0wDIEXWfjZKUW7UkVMSdVwqkabqGYx946GTAbKrGwY1ldA6BXXF74IRCvOCtLnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640313;
	bh=DSdMMCiHe3gZyMuFLp1ScC2czAS+OREFUFd9BogDoCM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PzqXM7v1gHhaXE314kl6Mi/9PMQY2rg2RQEMuU/9F/V03zzO3rzX/qUhF37GZo/2+
	 qnNx7Itn1ceTflaH5RjoL8R3bBTDDmhXb2RJvHhRiLRMhuFzI5UMv9mnWbHF6daApf
	 WCpJqjIM7wteWLRLW4Vmsemyz3qQUSLdinHKmv46RMs/IN0vSBgtkbT9sHH7WyRume
	 gt7Y6cocoE1IhQMwBfyemeLlrpRIoolLHkewP4FZrG3anSp5gMqL43dqeubfUnbN0P
	 XwF8qzdyT1FBPdj5bzvAZa/Tt52t5JTe7yVhjlap+NfLxEoOrufOPszHr4DxGEwflp
	 BO1+PUd9cZamg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ED6060707;
	Tue, 29 Sep 2026 00:05:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4160B61
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2315C4024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jA3NsJ3Zo18V for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C581840247
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640311;
 b=qvqkOCx7raQdo2yrotKBTwD/fCbCP/9yCMICDRzICpSFDQuiQ1CP5olDKLeT51hpyScT
 KwBnWv3YMeZ6IAB+Ru9/9TfuosixlrPn8dVXqFQy/4+WHyiETpmes1vl5xeQ/hfg3eqXN
 Wa3eytIhDuMBIQwLEJ+PPS6Hz4ty5mzwCm8lDOeap+4Kl1ubmoNPo1ioquL7HUoCvfM0R
 Z9HzGRdVCPXaER07lvxJbxOVlvnYVTt4EKTVhQyRR+kcZ+wgldBUZUQecVzYvmkhu7KZA
 cz/fqrWtH/yYA6KRCwzwyoRWo9u1QfJR0TKVO/ipQ13ihClY+3bD6pqPdfkmJeTsPbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640311;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=DSdMMCiHe3gZyMuFLp1ScC2czAS+OREFUFd9BogDoCM=;
 b=ldkdeldJq6ZD9Q3TbU5NAw05UwPn4IbWXwP+qeWuVZHxB8M+j6/ai42mj4r15EEsnwWe
 KJ8+cz5M9tpq7wTTSXScVTULpPrfRZWoSuEEN0ljDMGmEf2PUOrjBFnlHVAK7SLjUa9xE
 aFfzmNXBhATpeaenbcMks2IPNH/YakBVGS6zNQbEcvsOYaCMMMUQOql1UNy2Q6/dM0Oq/
 eB8Z2bOtBX+w+MmTESJ2AmXfwqO+CXQWkY9Bnvk3AZo9thWEkr0BCf6kIpV1MEjJK72W5
 4EIqGeuiu3/jN7fv6FLDUvJMScHmMqTTSybHQ/tSjrbMV6EbwdxQwyCpL/N3Zw8N5HQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C581840247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:09 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLLG-000000001Lh-1tJF;
 Tue, 29 Sep 2026 00:05:06 +0000
Date: Tue, 29 Sep 2026 01:05:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 03/11] cmd: ubi: unbind the block device when detaching UBI
Message-ID: <57d688c070e2624e8d37a4e16a0f0d3ac3806410.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
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

The ubi_blk device is parented to the MTD device UBI was attached to,
but ubi_detach() leaves it bound. After 'ubi part A; ubi detach; ubi
part B' the device still hangs off A's MTD while UBI sits on B, so the
driver-model tree describes a parent that is no longer in use and A's
MTD can no longer be removed. Reads happen to keep working only because
get_ubi_device() always returns ubi_devices[0].

Return the new device from ubi_bind(), remember it, and unbind it in
ubi_detach() so the next attach binds a fresh one under the right
parent. Tracking the device also replaces the scan of every UCLASS_BLK
device that was used to find it.

Fixes: dec405d1653a ("cmd: ubi: create a ubi_blk device when attaching UBI")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 cmd/ubi.c               | 73 +++++++++++++++++++++++++----------------
 drivers/mtd/ubi/block.c |  4 ++-
 include/ubi_uboot.h     |  4 +--
 3 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 7cbb3ee8668..ca8184aa736 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -21,6 +21,7 @@
 #include <nand.h>
 #include <onenand_uboot.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
@@ -650,6 +651,47 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 	return ubi_change_vtbl_record(ubi, vol->vol_id, &vtbl_rec);
 }
 
+#if CONFIG_IS_ENABLED(UBI_BLOCK)
+static struct udevice *ubi_blk_dev;
+
+static void ubi_blk_bind_once(void)
+{
+	struct udevice *parent;
+	int ret;
+
+	/*
+	 * A single ubi_blk device serves all volumes of the attached UBI
+	 * device, the volume being selected through the block descriptor's
+	 * hwpart. It is parented to the MTD device UBI sits on, so it must
+	 * not outlive the attach that created it.
+	 */
+	if (ubi_blk_dev)
+		return;
+
+	parent = ubi && ubi->mtd && ubi->mtd->dev ? ubi->mtd->dev : dm_root();
+
+	ret = ubi_bind(parent, &ubi_blk_dev);
+	if (ret)
+		printf("Cannot create UBI block device: %d\n", ret);
+}
+
+static void ubi_blk_unbind(void)
+{
+	if (!ubi_blk_dev)
+		return;
+
+	device_remove(ubi_blk_dev, DM_REMOVE_NORMAL);
+	device_unbind(ubi_blk_dev);
+	ubi_blk_dev = NULL;
+}
+#else
+static inline void ubi_blk_bind_once(void) { }
+
+static inline void ubi_blk_unbind(void)
+{
+}
+#endif
+
 int ubi_detach(void)
 {
 #ifdef CONFIG_CMD_UBIFS
@@ -662,6 +704,8 @@ int ubi_detach(void)
 		cmd_ubifs_umount();
 #endif
 
+	ubi_blk_unbind();
+
 	/*
 	 * Call ubi_exit() before re-initializing the UBI subsystem
 	 */
@@ -673,35 +717,6 @@ int ubi_detach(void)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(UBI_BLOCK)
-static void ubi_blk_bind_once(void)
-{
-	struct udevice *parent;
-	struct udevice *dev;
-	int ret;
-
-	/*
-	 * A single ubi_blk device serves all volumes of the attached UBI
-	 * device, the volume being selected through the block descriptor's
-	 * hwpart. Bind one when UBI is attached -- unless a previous attach
-	 * already did -- parented to the MTD device UBI sits on.
-	 */
-	for (uclass_find_first_device(UCLASS_BLK, &dev); dev;
-	     uclass_find_next_device(&dev)) {
-		if (dev->driver == DM_DRIVER_GET(ubi_blk))
-			return;
-	}
-
-	parent = ubi && ubi->mtd && ubi->mtd->dev ? ubi->mtd->dev : dm_root();
-
-	ret = ubi_bind(parent);
-	if (ret)
-		printf("Cannot create UBI block device: %d\n", ret);
-}
-#else
-static inline void ubi_blk_bind_once(void) { }
-#endif
-
 int ubi_part(const char *part_name, const char *vid_header_offset)
 {
 	struct mtd_info *mtd;
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 99d55282cd7..f5a79e4f475 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -11,7 +11,7 @@
 #include <dm/device.h>
 #include <dm/device-internal.h>
 
-int ubi_bind(struct udevice *dev)
+int ubi_bind(struct udevice *dev, struct udevice **bdevp)
 {
 	struct blk_desc *bdesc;
 	struct udevice *bdev;
@@ -29,6 +29,8 @@ int ubi_bind(struct udevice *dev)
 	bdesc->bdev = bdev;
 	bdesc->part_type = PART_TYPE_UBI;
 
+	*bdevp = bdev;
+
 	return 0;
 }
 
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index bdf5645de3d..9faecc3870c 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -148,9 +148,9 @@ int cmd_ubifs_mount(const char *vol_name);
 int cmd_ubifs_umount(void);
 
 #if IS_ENABLED(CONFIG_UBI_BLOCK)
-int ubi_bind(struct udevice *dev);
+int ubi_bind(struct udevice *dev, struct udevice **bdevp);
 #else
-static inline int ubi_bind(struct udevice *dev)
+static inline int ubi_bind(struct udevice *dev, struct udevice **bdevp)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.55.0
