Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57269CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEC0D403B5;
	Tue, 29 Sep 2026 00:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyDCQEr_S8k9; Tue, 29 Sep 2026 00:04:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3AEA240561
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640294;
	b=CnKWRis7sg3z82FiQdz5RbOrCzF8E93CkMjHGRHRvEzgeklvlOod0IFhnzpj2RskAVrq
	 /eMORhscHYRF1T6DD5bN00SUU8fC+EO+hLvDQlf1q0D8Xglp4m9Cmdr5nu21XIL3GQWMc
	 5Ihwh5v6ccRrVWWVv4lg4b331V6vPI4jb5gI7v+jeH+bQXWNQe804LVGQBIG8/nlePQSR
	 HS9ogLDrJ+CGEfhqSUbJH1GIoNEYrpAgMrhOrg3ye4YO1x0ax0Rs2OVCA+qPLUgaMmS5l
	 nlBO/CS390nDbWttqFb2Ml5r8Om5wXvebtydbQi9/3Ds8QJxeQu0GYEHuaqh10L3L1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iDIcIZaI953ATnHTr7qXM05Yans+ylxNsdlN5v9jA2A=;
	b=OPbGMLTuyE1p/kHXnMTRDK1E88dzmBEc5CM30ih0CXne63S8mrAqqRgmpmaMJqXUITpR
	 uyHFN8cCd/TZCGZ4HOnDWWhGQEi/roDxpPDcj9if4HFsfkN3E3A0ji7/SDnXo5h3OkQyt
	 sZ3FqvC6/o+XSxr5zstNal6EFA15I9pxbqjmqo4xsHGENQdFZ9WKdG/FzZpSkKiJRpbBZ
	 sxFOyucVBk9KFHnu6VFIlC0UcN9tfscybeF53/T9Bk+eFifDEYeKPHsEVvtKM+b7+W6gi
	 UDldHygDsdoQtBRFrbqCKivVma3NcD+igDsDfCecL3QGQxX3a1e0xjU0lCdf/7Ig8Aw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640294;
	bh=iDIcIZaI953ATnHTr7qXM05Yans+ylxNsdlN5v9jA2A=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I5sCjSHyPGJENNyNRC2B3aACrP3HFwlSWO3Pa6Bpb1F9UWRas3dhYZCknNO2hr2FM
	 HsH2WsMkIzu0nDqp658B2d0FPl0G8jm0R41NYe+TgdnsEQZjZUNajOUskBaTI60p+4
	 8shX7p0Dk1p4v1k5+4WY3RNlvaIJ8YQ1zqeoQCv2Wxix8E09yyjSxx3wsaZB3nHy1i
	 yI5MqYaKMf4ZdDX1sim9DGtlP66F4sY+OgfwH7wpsbjEi/Zc74tbd6jzR52KDQ4sQM
	 a5P5QgKgOX/R5rMgUaCKsVf1DWQxDxmZ0MEltV91ReV2oziuYAHgVaBMzkQ6c2VzjV
	 g0BVU1VTErN3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AEA240561;
	Tue, 29 Sep 2026 00:04:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61065335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E93740561
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hO1qVT9xoacD for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8CFEB403B5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640291;
 b=WTHDT6k7lhYjGDzaiFGtjqVpfpSV2p6UX4+WtHJudsAqm6YJyV98QcWbaJCdWH2YvcpD
 CSst3H9KhjAQnPswKR+qJtNxT5AkrQLH6DLLTwOLOTdHVQrmYIr4KEPR7+FM1G/S7BDbT
 BWUulCICvkt6mQyjGZnBwgoJyVwqnd4ROQkGcyCMQ2SsAU4qcRQVbyDM6MQyhCGQH5M7u
 JpJo6yY7+QMHePdf4aYCdILmYYR10ap6VB0eFh/IdPWRmSyA4Vk+Jtaafr+lMQ7MsJPD3
 iHScdTurgGnxDlyD5RTAVhF436O0bBfyXK3CD2jz6TPkorJ09PWiOC9vxd0y/jA/+sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640291;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=iDIcIZaI953ATnHTr7qXM05Yans+ylxNsdlN5v9jA2A=;
 b=kgiVz3pRkSrQ0vdoeaTuY20QVjXKtIt867gqlcnGcETNuB5CbaS8ArmOIgvc+DhDAuFy
 ut5yf9LjEZDGRHvWd+FVVfaSKWUl9J3kOwqsNk5SFs+Z4dzjFSKl8i92r3In2Wo3WtWeY
 +HL7NWeG/OgpA7lCJNyoqNNypDQmNBhpYP1+ezlzihb+uRLGaTMgffxZwjBL3cHwECvzL
 XTe5w7I+OyRk7hyNhcIGSWlS0CLrKYvBAxPhsnoI97i1qxvaUqlOLeKjxc3t9rzxkgm26
 TxDp51KsDKMctZ22ryXlC15ASYtbfhRBoiuY/5V0EQdPudupWuAEoRp/3CECo2a1wjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CFEB403B5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:04:51 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLKx-000000001KW-19IS;
 Tue, 29 Sep 2026 00:04:47 +0000
Date: Tue, 29 Sep 2026 01:04:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 01/11] mtd: bind the block device without leaking on failure
Message-ID: <891afb4991f1e6825b5715fc918e9a9eda210bd6.1790626459.git.daniel@makrotopia.org>
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

add_mtd_device() allocates a slot to hold the mtd_info pointer that
mtd_bind() keeps, but drops the return value. mtd_bind() only logs and
returns on failure, so the slot leaks. A failed kmalloc() is ignored
too, leaving the master without a block device and no hint why its
partitions are unreachable.

Move the bind into a helper that frees the slot when mtd_bind() fails
and warns with the errno in both cases.

Fixes: e8a7453824b7 ("mtd: bind an mtd_blk device for non-NAND MTD masters")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/mtdcore.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e0d0b5ae2e9..3d3a84df0a6 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -396,6 +396,31 @@ static struct device_type mtd_devtype = {
 };
 #endif
 
+static void mtd_blk_bind_master(struct mtd_info *mtd)
+{
+	struct mtd_info **mtdp;
+	int ret;
+
+	/*
+	 * mtd_bind() keeps the passed pointer, so it needs storage that lives
+	 * as long as the block device; an MTD master is never removed.
+	 */
+	mtdp = kmalloc(sizeof(*mtdp), GFP_KERNEL);
+	if (!mtdp) {
+		ret = -ENOMEM;
+		goto warn;
+	}
+
+	*mtdp = mtd;
+	ret = mtd_bind(mtd->dev, mtdp);
+	if (!ret)
+		return;
+
+	kfree(mtdp);
+warn:
+	pr_warn("mtd: %s: cannot bind a block device: %d\n", mtd->name, ret);
+}
+
 /**
  *	add_mtd_device - register an MTD device
  *	@mtd: pointer to new MTD device info structure
@@ -504,18 +529,8 @@ int add_mtd_device(struct mtd_info *mtd)
 		 * NAND is excluded: it needs UBI, which brings its own block
 		 * device. Partitions inherit the master's block device via the
 		 * "mtd" partition type, so only masters are bound.
-		 *
-		 * mtd_bind() keeps a pointer to the passed mtd_info pointer, so
-		 * it needs storage that lives as long as the block device; the
-		 * MTD master is never removed in practice, so a small heap slot
-		 * is fine.
 		 */
-		struct mtd_info **mtdp = kmalloc(sizeof(*mtdp), GFP_KERNEL);
-
-		if (mtdp) {
-			*mtdp = mtd;
-			mtd_bind(mtd->dev, mtdp);
-		}
+		mtd_blk_bind_master(mtd);
 	}
 
 	/* We _know_ we aren't being removed, because
-- 
2.55.0
