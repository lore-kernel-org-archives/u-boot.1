Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC6DC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61A38699A;
	Tue, 15 Aug 2023 18:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="En1ua11K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5249D867CF; Tue, 15 Aug 2023 18:07:02 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56736867CF
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9B5283FE9E; 
 Tue, 15 Aug 2023 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692115619;
 bh=qJF8ok9FGojqIEMHruvsmOJ24kVzsdVXrB6RpptPfSY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=En1ua11KfiBojJ6trXLKz2adVhxLtGsU5MIvWGIC07QqwBQPlV2tw1LH8+2pHhTGq
 qU49owAXlFtmNHp2y5LU61bmqG7JkMSioyJxBQ5H0/kI09bam6fYXxV+jEt7hIsb2W
 9k9w/+A3ekzvUaADoseYopJgjLplE5XLMaaj1Mf0nE2d1TIyxkDPcx87t/GVcyw/Cz
 HAAj7VGWkaDHbTN9xMSSZuz0aPFY4dwNKzhfuu4BVlJvKKZJ+9seqHsqIeIqbtGqWD
 ztTd9p18dgkl14wXKoiDxf+mh7JU5/FA4KByZw92cUFsIfz1+gZ8Bmlmz4/JcvEL89
 nSKj4+H188H/A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] spl: don't assume NVMe partition 1 exists
Date: Tue, 15 Aug 2023 18:07:36 +0200
Message-Id: <20230815160736.39330-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

There is no requirement that a partition 1 exists in a partition table.
We should not try to retrieve information about it.

We should not even try reading with partition number
CONFIG_SYS_NVME_BOOT_PARTITION here as this is done in the fs_set_blk_dev()
call anyway.

Fixes: 8ce6a2e17577 ("spl: blk: Support loading images from fs")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/spl_blk_fs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 16ecece702..eb6f526689 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -44,7 +44,6 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 		       enum uclass_id uclass_id, int devnum, int partnum)
 {
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
-	struct disk_partition part_info = {};
 	struct legacy_img_hdr *header;
 	struct blk_desc *blk_desc;
 	loff_t actlen, filesize;
@@ -59,11 +58,6 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 
 	blk_show_device(uclass_id, devnum);
 	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-	ret = part_get_info(blk_desc, 1, &part_info);
-	if (ret) {
-		printf("spl: no partition table found. Err - %d\n", ret);
-		goto out;
-	}
 
 	dev.ifname = blk_get_uclass_name(uclass_id);
 	snprintf(dev.dev_part_str, sizeof(dev.dev_part_str) - 1, "%x:%x",
-- 
2.40.1

