Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062608687F;
	Thu, 24 Aug 2023 21:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NWj4huDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4088687F; Thu, 24 Aug 2023 21:56:07 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4CE8683C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so6140539f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906962; x=1693511762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABTgwjH33zNVbu3zk74Ezfde3bYxIayNRmAicX+NU9Y=;
 b=NWj4huDRVCNLoeu2pE4dnsurMhDd3QWs2FqllOUIsMBfRVi0vCg8k1P6lyXuD3OtJp
 t3K2w+DO9us3rAtskG56IDNkCZfFh6iDEKcMUkxytdycoPEqB1z+Hd2NxBgtnh+HE1Ca
 /nxj6Pb2LW+0SXNliB+C/Xl7Zgr74MtEfyRRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906962; x=1693511762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABTgwjH33zNVbu3zk74Ezfde3bYxIayNRmAicX+NU9Y=;
 b=LxDHCitjjNivJ7I1D03GMg0IKs1tbb80Ef2VROSNDQ/kqFfM4WLE+kZ3DgZ/OEoSuX
 /e4zNA3Z/e02FeFaukW1MewxVs/BaB6E/g5h2R6KPS1cLgIT45Df1aeI1vfGGbWDDqYE
 Lc/Gj2KFR728uZje/x3NYUyrnev+kyspMHx7NPKs1Xmhu4/TFMGQborhPLDx5ZXdO+93
 xjRhod+2rXeopkJuehVcHpnj+KVbDoiKVV+iaVJphFAaQMRSL9nglgyRB7E5aO8CiURV
 77+W83hPHF8ytmUXJlbzuNgM/4mSZArd6lMyhbIXQhzQyHIgTot4vRpeX0Zg16F8qMcX
 4gpg==
X-Gm-Message-State: AOJu0YzR3gvNHV0c5CNJ0+D7sOZJhk862ZWVfdcdOzyVVdwUcMW5Wlxi
 4AwnbGnIdL5jHONH0HB2FKeODlFYL11Yf3TuM6w=
X-Google-Smtp-Source: AGHT+IF12E0zw0T42w/6zCETCF2U95v1EbbN88oaDMI5AnUEgj6tUi5v25FLHlbUiX0afe7JJ8jveg==
X-Received: by 2002:a05:6602:19d9:b0:790:a010:4c42 with SMTP id
 ba25-20020a05660219d900b00790a0104c42mr7759432iob.13.1692906962517; 
 Thu, 24 Aug 2023 12:56:02 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/23] part: dos: Use desc instead of dev_desc
Date: Thu, 24 Aug 2023 13:55:26 -0600
Message-ID: <20230824195553.1685996-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

The dev_ prefix is a hangover from the pre-driver model days. The device
is now a different thing, with driver model. Update the dos code to
just use 'desc'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase to -next

 disk/part_dos.c | 63 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 1b81297d967f..cc050ca8c49f 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -98,27 +98,26 @@ static int test_block_type(unsigned char *buffer)
 	return -1;
 }
 
-static int part_test_dos(struct blk_desc *dev_desc)
+static int part_test_dos(struct blk_desc *desc)
 {
 #ifndef CONFIG_SPL_BUILD
 	ALLOC_CACHE_ALIGN_BUFFER(legacy_mbr, mbr,
-			DIV_ROUND_UP(dev_desc->blksz, sizeof(legacy_mbr)));
+			DIV_ROUND_UP(desc->blksz, sizeof(legacy_mbr)));
 
-	if (blk_dread(dev_desc, 0, 1, (ulong *)mbr) != 1)
+	if (blk_dread(desc, 0, 1, (ulong *)mbr) != 1)
 		return -1;
 
 	if (test_block_type((unsigned char *)mbr) != DOS_MBR)
 		return -1;
 
-	if (dev_desc->sig_type == SIG_TYPE_NONE &&
-	    mbr->unique_mbr_signature != 0) {
-		dev_desc->sig_type = SIG_TYPE_MBR;
-		dev_desc->mbr_sig = mbr->unique_mbr_signature;
+	if (desc->sig_type == SIG_TYPE_NONE && mbr->unique_mbr_signature) {
+		desc->sig_type = SIG_TYPE_MBR;
+		desc->mbr_sig = mbr->unique_mbr_signature;
 	}
 #else
-	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 
-	if (blk_dread(dev_desc, 0, 1, (ulong *)buffer) != 1)
+	if (blk_dread(desc, 0, 1, (ulong *)buffer) != 1)
 		return -1;
 
 	if (test_block_type(buffer) != DOS_MBR)
@@ -130,12 +129,12 @@ static int part_test_dos(struct blk_desc *dev_desc)
 
 /*  Print a partition that is relative to its Extended partition table
  */
-static void print_partition_extended(struct blk_desc *dev_desc,
+static void print_partition_extended(struct blk_desc *desc,
 				     lbaint_t ext_part_sector,
 				     lbaint_t relative,
 				     int part_num, unsigned int disksig)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	dos_partition_t *pt;
 	int i;
 
@@ -146,9 +145,9 @@ static void print_partition_extended(struct blk_desc *dev_desc,
 		return;
     }
 
-	if (blk_dread(dev_desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
+	if (blk_dread(desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
 		printf ("** Can't read partition table on %d:" LBAFU " **\n",
-			dev_desc->devnum, ext_part_sector);
+			desc->devnum, ext_part_sector);
 		return;
 	}
 	i=test_block_type(buffer);
@@ -189,9 +188,9 @@ static void print_partition_extended(struct blk_desc *dev_desc,
 			lbaint_t lba_start
 				= get_unaligned_le32 (pt->start4) + relative;
 
-			print_partition_extended(dev_desc, lba_start,
-				ext_part_sector == 0  ? lba_start : relative,
-				part_num, disksig);
+			print_partition_extended(desc, lba_start,
+						 !ext_part_sector ? lba_start :
+						 relative, part_num, disksig);
 		}
 	}
 
@@ -201,12 +200,12 @@ static void print_partition_extended(struct blk_desc *dev_desc,
 
 /*  Print a partition that is relative to its Extended partition table
  */
-static int part_get_info_extended(struct blk_desc *dev_desc,
+static int part_get_info_extended(struct blk_desc *desc,
 				  lbaint_t ext_part_sector, lbaint_t relative,
 				  int part_num, int which_part,
 				  struct disk_partition *info, uint disksig)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	struct disk_partition wdinfo = { 0 };
 	dos_partition_t *pt;
 	int i, ret;
@@ -219,9 +218,9 @@ static int part_get_info_extended(struct blk_desc *dev_desc,
 		return -1;
     }
 
-	if (blk_dread(dev_desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
+	if (blk_dread(desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
 		printf ("** Can't read partition table on %d:" LBAFU " **\n",
-			dev_desc->devnum, ext_part_sector);
+			desc->devnum, ext_part_sector);
 		return -1;
 	}
 	if (buffer[DOS_PART_MAGIC_OFFSET] != 0x55 ||
@@ -237,7 +236,7 @@ static int part_get_info_extended(struct blk_desc *dev_desc,
 		disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
 #endif
 
-	ret = part_get_info_whole_disk(dev_desc, &wdinfo);
+	ret = part_get_info_whole_disk(desc, &wdinfo);
 	if (ret)
 		return ret;
 
@@ -259,7 +258,7 @@ static int part_get_info_extended(struct blk_desc *dev_desc,
 			info->start = (lbaint_t)(ext_part_sector +
 					get_unaligned_le32(pt->start4));
 			info->size  = (lbaint_t)get_unaligned_le32(pt->size4);
-			part_set_generic_name(dev_desc, part_num,
+			part_set_generic_name(desc, part_num,
 					      (char *)info->name);
 			/* sprintf(info->type, "%d, pt->sys_ind); */
 			strcpy((char *)info->type, "U-Boot");
@@ -285,7 +284,7 @@ static int part_get_info_extended(struct blk_desc *dev_desc,
 			lbaint_t lba_start
 				= get_unaligned_le32 (pt->start4) + relative;
 
-			return part_get_info_extended(dev_desc, lba_start,
+			return part_get_info_extended(desc, lba_start,
 				 ext_part_sector == 0 ? lba_start : relative,
 				 part_num, which_part, info, disksig);
 		}
@@ -296,7 +295,7 @@ static int part_get_info_extended(struct blk_desc *dev_desc,
 
 	if (dos_type == DOS_PBR) {
 		info->start = 0;
-		info->size = dev_desc->lba;
+		info->size = desc->lba;
 		if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
 			info->blksz = wdinfo.blksz;
 		else
@@ -312,16 +311,16 @@ static int part_get_info_extended(struct blk_desc *dev_desc,
 	return -1;
 }
 
-static void __maybe_unused part_print_dos(struct blk_desc *dev_desc)
+static void __maybe_unused part_print_dos(struct blk_desc *desc)
 {
 	printf("Part\tStart Sector\tNum Sectors\tUUID\t\tType\n");
-	print_partition_extended(dev_desc, 0, 0, 1, 0);
+	print_partition_extended(desc, 0, 0, 1, 0);
 }
 
-static int __maybe_unused part_get_info_dos(struct blk_desc *dev_desc, int part,
-		      struct disk_partition *info)
+static int __maybe_unused part_get_info_dos(struct blk_desc *desc, int part,
+					    struct disk_partition *info)
 {
-	return part_get_info_extended(dev_desc, 0, 0, 1, part, info, 0);
+	return part_get_info_extended(desc, 0, 0, 1, part, info, 0);
 }
 
 int is_valid_dos_buf(void *buf)
@@ -501,20 +500,20 @@ int layout_mbr_partitions(struct disk_partition *p, int count,
 }
 #endif
 
-int write_mbr_sector(struct blk_desc *dev_desc, void *buf)
+int write_mbr_sector(struct blk_desc *desc, void *buf)
 {
 	if (is_valid_dos_buf(buf))
 		return -1;
 
 	/* write MBR */
-	if (blk_dwrite(dev_desc, 0, 1, buf) != 1) {
+	if (blk_dwrite(desc, 0, 1, buf) != 1) {
 		printf("%s: failed writing '%s' (1 blks at 0x0)\n",
 		       __func__, "MBR");
 		return 1;
 	}
 
 	/* Update the partition table entries*/
-	part_init(dev_desc);
+	part_init(desc);
 
 	return 0;
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

