Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4059C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98618869DD;
	Thu, 24 Aug 2023 21:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JGQxKcHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271E586940; Thu, 24 Aug 2023 21:56:09 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C3A8698F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7923d27b9f3so7190639f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906964; x=1693511764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IB3H5q9nF4/xfMN2v48BagY2brWQYnIHLANQWB9qHxw=;
 b=JGQxKcHFz7fP7DwNm8lGa1GBEIWSOQbzFztPPKdowRcxPSBvBK8roUVTD8AiG0WxGr
 jl+JVa8Up/Gl3EVqT8LXnZJLMYGHYuSq0X8/yNnZ2wSkkgPVOhhXhTAkFXSvDsCY9ZZU
 1gFb8ZmU8EhogkR74IDAvBGC14fFJBd4XHbIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906964; x=1693511764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IB3H5q9nF4/xfMN2v48BagY2brWQYnIHLANQWB9qHxw=;
 b=PTUrfqMZucE1dE88CJoJFn9jG8XuvPajPRX6dIdbpwJpbmXDjnUNmq1CAbpzNa9KYM
 jzYmCHT3EbZATtEAQP1Iwp8x3Cntv/EUmZrhkjKiA3DM5cvPgzNiKw+BLRkL0dqEEOV8
 z0637fUCF6fxBtTxxpzOIL8vB5NbQhImtD4UxZ84KnUA1QdkOQUlDgTt4OQpGxr1YUUR
 oaUaRaVCFs2pOYEEH6u1U2uKU4xW8dsz3FAcjFs3U5b6YPPnvY0Dj4kwZW04P5sm1f7g
 H+EPG6RcFilF8CMTwRQYxHIgPWKkqC4PxKt4Sp6vMNo1yq8rBYpst6dvXZIstYCGfza+
 aYbQ==
X-Gm-Message-State: AOJu0YwqiC9A1nwYUXuDcHWjGfX5RLTJMUWVsAncQlZSw8w/ocIDNbjg
 NE6blZqifura2SKTG/8HEZFFyJV7YZ0cN5SnZQg=
X-Google-Smtp-Source: AGHT+IF066k+I+eopskXEeSuXA+L8GefVCsO1isuExmCeTkYjZMNaWWoqzq68iewBs0hWUu2SBmPTg==
X-Received: by 2002:a6b:dc0c:0:b0:792:70f2:a8ed with SMTP id
 s12-20020a6bdc0c000000b0079270f2a8edmr2765433ioc.4.1692906964002; 
 Thu, 24 Aug 2023 12:56:04 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/23] part: iso: Use desc instead of dev_desc
Date: Thu, 24 Aug 2023 13:55:28 -0600
Message-ID: <20230824195553.1685996-6-sjg@chromium.org>
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
is now a different thing, with driver model. Update the iso code to
just use 'desc'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part_iso.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/disk/part_iso.c b/disk/part_iso.c
index 4cd619bf46d3..6ac6d95be921 100644
--- a/disk/part_iso.c
+++ b/disk/part_iso.c
@@ -46,7 +46,7 @@ unsigned long iso_dread(struct blk_desc *block_dev, lbaint_t start,
 }
 
 /* only boot records will be listed as valid partitions */
-int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
+int part_get_info_iso_verb(struct blk_desc *desc, int part_num,
 			   struct disk_partition *info, int verb)
 {
 	int i,offset,entry_num;
@@ -58,23 +58,23 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 	iso_val_entry_t *pve = (iso_val_entry_t *)tmpbuf;
 	iso_init_def_entry_t *pide;
 
-	if ((dev_desc->blksz != CD_SECTSIZE) && (dev_desc->blksz != 512))
+	if (desc->blksz != CD_SECTSIZE && desc->blksz != 512)
 		return -1;
 
 	/* the first sector (sector 0x10) must be a primary volume desc */
 	blkaddr=PVD_OFFSET;
-	if (iso_dread(dev_desc, PVD_OFFSET, 1, (ulong *)tmpbuf) != 1)
+	if (iso_dread(desc, PVD_OFFSET, 1, (ulong *)tmpbuf) != 1)
 		return -1;
 	if(ppr->desctype!=0x01) {
 		if(verb)
 			printf ("** First descriptor is NOT a primary desc on %d:%d **\n",
-				dev_desc->devnum, part_num);
+				desc->devnum, part_num);
 		return (-1);
 	}
 	if(strncmp((char *)ppr->stand_ident,"CD001",5)!=0) {
 		if(verb)
 			printf ("** Wrong ISO Ident: %s on %d:%d **\n",
-				ppr->stand_ident, dev_desc->devnum, part_num);
+				ppr->stand_ident, desc->devnum, part_num);
 		return (-1);
 	}
 	lastsect = le32_to_cpu(ppr->firstsek_LEpathtab1_LE);
@@ -83,14 +83,14 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 	PRINTF(" Lastsect:%08lx\n",lastsect);
 	for(i=blkaddr;i<lastsect;i++) {
 		PRINTF("Reading block %d\n", i);
-		if (iso_dread(dev_desc, i, 1, (ulong *)tmpbuf) != 1)
+		if (iso_dread(desc, i, 1, (ulong *)tmpbuf) != 1)
 			return -1;
 		if(ppr->desctype==0x00)
 			break; /* boot entry found */
 		if(ppr->desctype==0xff) {
 			if(verb)
 				printf ("** No valid boot catalog found on %d:%d **\n",
-					dev_desc->devnum, part_num);
+					desc->devnum, part_num);
 			return (-1);
 		}
 	}
@@ -98,15 +98,15 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 	if(strncmp(pbr->ident_str,"EL TORITO SPECIFICATION",23)!=0) {
 		if(verb)
 			printf ("** Wrong El Torito ident: %s on %d:%d **\n",
-				pbr->ident_str, dev_desc->devnum, part_num);
+				pbr->ident_str, desc->devnum, part_num);
 		return (-1);
 	}
 	bootaddr = get_unaligned_le32(pbr->pointer);
 	PRINTF(" Boot Entry at: %08lX\n",bootaddr);
-	if (iso_dread(dev_desc, bootaddr, 1, (ulong *)tmpbuf) != 1) {
+	if (iso_dread(desc, bootaddr, 1, (ulong *)tmpbuf) != 1) {
 		if(verb)
 			printf ("** Can't read Boot Entry at %lX on %d:%d **\n",
-				bootaddr, dev_desc->devnum, part_num);
+				bootaddr, desc->devnum, part_num);
 		return (-1);
 	}
 	chksum=0;
@@ -116,20 +116,20 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 	if(chksum!=0) {
 		if(verb)
 			printf("** Checksum Error in booting catalog validation entry on %d:%d **\n",
-			       dev_desc->devnum, part_num);
+			       desc->devnum, part_num);
 		return (-1);
 	}
 	if((pve->key[0]!=0x55)||(pve->key[1]!=0xAA)) {
 		if(verb)
 			printf ("** Key 0x55 0xAA error on %d:%d **\n",
-				dev_desc->devnum, part_num);
+				desc->devnum, part_num);
 		return(-1);
 	}
 #ifdef CHECK_FOR_POWERPC_PLATTFORM
 	if(pve->platform!=0x01) {
 		if(verb)
 			printf ("** No PowerPC platform CD on %d:%d **\n",
-				dev_desc->devnum, part_num);
+				desc->devnum, part_num);
 		return(-1);
 	}
 #endif
@@ -137,7 +137,7 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 	entry_num=1;
 	offset=0x20;
 	strcpy((char *)info->type, "U-Boot");
-	part_set_generic_name(dev_desc, part_num, (char *)info->name);
+	part_set_generic_name(desc, part_num, (char *)info->name);
 	/* the bootcatalog (including validation Entry) is limited to 2048Bytes
 	 * (63 boot entries + validation entry) */
 	 while(offset<2048) {
@@ -159,7 +159,7 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 		else {
 			if(verb)
 				printf ("** Partition %d not found on device %d **\n",
-					part_num, dev_desc->devnum);
+					part_num, desc->devnum);
 			return(-1);
 		}
 	}
@@ -167,13 +167,13 @@ int part_get_info_iso_verb(struct blk_desc *dev_desc, int part_num,
 	 * searched w/o succsess */
 	if(verb)
 		printf ("** Partition %d not found on device %d **\n",
-			part_num, dev_desc->devnum);
+			part_num, desc->devnum);
 	return(-1);
 found:
 	if(pide->boot_ind!=0x88) {
 		if(verb)
 			printf("** Partition %d is not bootable on device %d **\n",
-			       part_num, dev_desc->devnum);
+			       part_num, desc->devnum);
 		return (-1);
 	}
 	switch(pide->boot_media) {
@@ -189,7 +189,7 @@ found:
 	newblkaddr = get_unaligned_le32(pide->rel_block_addr);
 	info->start=newblkaddr;
 
-	if (dev_desc->blksz == 512) {
+	if (desc->blksz == 512) {
 		info->size *= 4;
 		info->start *= 4;
 		info->blksz = 512;
@@ -199,20 +199,20 @@ found:
 	return 0;
 }
 
-static int part_get_info_iso(struct blk_desc *dev_desc, int part_num,
+static int part_get_info_iso(struct blk_desc *desc, int part_num,
 			     struct disk_partition *info)
 {
-	return part_get_info_iso_verb(dev_desc, part_num, info, 0);
+	return part_get_info_iso_verb(desc, part_num, info, 0);
 }
 
-static void part_print_iso(struct blk_desc *dev_desc)
+static void part_print_iso(struct blk_desc *desc)
 {
 	struct disk_partition info;
 	int i;
 
-	if (part_get_info_iso_verb(dev_desc, 1, &info, 0) == -1) {
+	if (part_get_info_iso_verb(desc, 1, &info, 0) == -1) {
 		printf("** No boot partition found on device %d **\n",
-		       dev_desc->devnum);
+		       desc->devnum);
 		return;
 	}
 	printf("Part   Start     Sect x Size Type\n");
@@ -221,14 +221,14 @@ static void part_print_iso(struct blk_desc *dev_desc)
 		printf(" %2d %8" LBAFlength "u %8" LBAFlength "u %6ld %.32s\n",
 		       i, info.start, info.size, info.blksz, info.type);
 		i++;
-	} while (part_get_info_iso_verb(dev_desc, i, &info, 0) != -1);
+	} while (part_get_info_iso_verb(desc, i, &info, 0) != -1);
 }
 
-static int part_test_iso(struct blk_desc *dev_desc)
+static int part_test_iso(struct blk_desc *desc)
 {
 	struct disk_partition info;
 
-	return part_get_info_iso_verb(dev_desc, 1, &info, 0);
+	return part_get_info_iso_verb(desc, 1, &info, 0);
 }
 
 U_BOOT_PART_TYPE(iso) = {
-- 
2.42.0.rc1.204.g551eb34607-goog

