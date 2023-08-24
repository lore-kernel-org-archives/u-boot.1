Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBABC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E23F86900;
	Thu, 24 Aug 2023 21:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CrYCgQnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7436E86997; Thu, 24 Aug 2023 21:56:06 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C098687F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-77a62a84855so7746139f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906962; x=1693511762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yLjDBAEFXIFDmmw7NmMtss7Lt21TJVIXqBXRwJdYqg=;
 b=CrYCgQnhqqSqotQtYYK6usScHID6LmcEdyU1scmw+oPC74XhJ/CUAwGYeqv5ThI0lm
 0d4svFkxp2os6fqGmhEg/SFMIrGcx+qzEJKyI4gIo4fWcwX2OPLgiwHW25PWHgc+9ujL
 jT+TwU6dlDpiT7GnHV7yctvxwUt6Ui9NBB1Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906962; x=1693511762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yLjDBAEFXIFDmmw7NmMtss7Lt21TJVIXqBXRwJdYqg=;
 b=Zkm8sferc3r7EjlEHRdAflUfoKyQJVWuqysUqFzBGKJnKWXrGgIn9X/FYEdRWqPAEf
 arz5Ll8LIERAWpuqT1BLQADN13u9H7f134/2cC55WwzKuZi0S1QsXB5mNa63lzHM2Huy
 Yk8TD+wYtv5QYVWcqyo/3+v4fDIlGCAcxs/NmPraTXlQpjQXf1u9QY5qmJjjrbXPxSRe
 RiqdzpJPvl49UVylk8SHE1x1JmIwgD0hCC269yI+sVLQ+Aq9bqJgG3NsxduSjQTGbxoH
 fhff1ZjcnG+1nM/m8R1ltjVBHKhILfl+jVzq0InMAUWh1HqlwKPfQqFPuqHtw2yMmAAq
 D/Ug==
X-Gm-Message-State: AOJu0YxzBk0IdBBjrvz60MOaeyUMh+TCyQsCQJDa/yfwIlM18HTJVQ1z
 L/6DPGgz0ru3G+4zjlruWZzj6Cx8zoORTSIFJ24=
X-Google-Smtp-Source: AGHT+IHAGrLFEd6EqZWbQnfK68BiBgHiuwqNzSW9pnxTHJtSH3jQVjALZrE1OCp1rwDcsEB7mCmBlg==
X-Received: by 2002:a5e:990c:0:b0:786:cd9c:cfa2 with SMTP id
 t12-20020a5e990c000000b00786cd9ccfa2mr7289035ioj.0.1692906961849; 
 Thu, 24 Aug 2023 12:56:01 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/23] part: amiga: Use desc instead of dev_desc
Date: Thu, 24 Aug 2023 13:55:25 -0600
Message-ID: <20230824195553.1685996-3-sjg@chromium.org>
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
is now a different thing, with driver model. Update the amiga code to
just use 'desc'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part_amiga.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/disk/part_amiga.c b/disk/part_amiga.c
index 45d3a7048669..65e30fea558d 100644
--- a/disk/part_amiga.c
+++ b/disk/part_amiga.c
@@ -125,7 +125,7 @@ static void print_part_info(struct partition_block *p)
  * the ID AMIGA_ID_RDISK ('RDSK') and needs to have a valid
  * sum-to-zero checksum
  */
-struct rigid_disk_block *get_rdisk(struct blk_desc *dev_desc)
+struct rigid_disk_block *get_rdisk(struct blk_desc *desc)
 {
     int i;
     int limit;
@@ -139,7 +139,7 @@ struct rigid_disk_block *get_rdisk(struct blk_desc *dev_desc)
 
     for (i=0; i<limit; i++)
     {
-	ulong res = blk_dread(dev_desc, i, 1, (ulong *)block_buffer);
+	ulong res = blk_dread(desc, i, 1, (ulong *)block_buffer);
 	if (res == 1)
 	{
 	    struct rigid_disk_block *trdb = (struct rigid_disk_block *)block_buffer;
@@ -165,7 +165,7 @@ struct rigid_disk_block *get_rdisk(struct blk_desc *dev_desc)
  * Ridgid disk block
  */
 
-struct bootcode_block *get_bootcode(struct blk_desc *dev_desc)
+struct bootcode_block *get_bootcode(struct blk_desc *desc)
 {
     int i;
     int limit;
@@ -181,7 +181,7 @@ struct bootcode_block *get_bootcode(struct blk_desc *dev_desc)
 
     for (i = 0; i < limit; i++)
     {
-	ulong res = blk_dread(dev_desc, i, 1, (ulong *)block_buffer);
+	ulong res = blk_dread(desc, i, 1, (ulong *)block_buffer);
 	if (res == 1)
 	{
 	    struct bootcode_block *boot = (struct bootcode_block *)block_buffer;
@@ -206,17 +206,17 @@ struct bootcode_block *get_bootcode(struct blk_desc *dev_desc)
  * Test if the given partition has an Amiga partition table/Rigid
  * Disk block
  */
-static int part_test_amiga(struct blk_desc *dev_desc)
+static int part_test_amiga(struct blk_desc *desc)
 {
     struct rigid_disk_block *rdb;
     struct bootcode_block *bootcode;
 
     PRINTF("part_test_amiga: Testing for an Amiga RDB partition\n");
 
-    rdb = get_rdisk(dev_desc);
+	rdb = get_rdisk(desc);
     if (rdb)
     {
-	bootcode = get_bootcode(dev_desc);
+	bootcode = get_bootcode(desc);
 	if (bootcode)
 	    PRINTF("part_test_amiga: bootable Amiga disk\n");
 	else
@@ -235,7 +235,7 @@ static int part_test_amiga(struct blk_desc *dev_desc)
 /*
  * Find partition number partnum on the given drive.
  */
-static struct partition_block *find_partition(struct blk_desc *dev_desc,
+static struct partition_block *find_partition(struct blk_desc *desc,
 					      int partnum)
 {
     struct rigid_disk_block *rdb;
@@ -243,7 +243,7 @@ static struct partition_block *find_partition(struct blk_desc *dev_desc,
     u32 block;
 
     PRINTF("Trying to find partition block %d\n", partnum);
-    rdb = get_rdisk(dev_desc);
+	rdb = get_rdisk(desc);
     if (!rdb)
     {
 	PRINTF("find_partition: no rdb found\n");
@@ -257,7 +257,7 @@ static struct partition_block *find_partition(struct blk_desc *dev_desc,
 
     while (block != 0xFFFFFFFF)
     {
-	ulong res = blk_dread(dev_desc, block, 1, (ulong *)block_buffer);
+	ulong res = blk_dread(desc, block, 1, (ulong *)block_buffer);
 	if (res == 1)
 	{
 	    p = (struct partition_block *)block_buffer;
@@ -289,10 +289,10 @@ static struct partition_block *find_partition(struct blk_desc *dev_desc,
 /*
  * Get info about a partition
  */
-static int part_get_info_amiga(struct blk_desc *dev_desc, int part,
-				    struct disk_partition *info)
+static int part_get_info_amiga(struct blk_desc *desc, int part,
+			       struct disk_partition *info)
 {
-    struct partition_block *p = find_partition(dev_desc, part-1);
+	struct partition_block *p = find_partition(desc, part - 1);
     struct amiga_part_geometry *g;
     u32 disk_type;
 
@@ -317,7 +317,7 @@ static int part_get_info_amiga(struct blk_desc *dev_desc, int part,
     return 0;
 }
 
-static void part_print_amiga(struct blk_desc *dev_desc)
+static void part_print_amiga(struct blk_desc *desc)
 {
     struct rigid_disk_block *rdb;
     struct bootcode_block *boot;
@@ -325,7 +325,7 @@ static void part_print_amiga(struct blk_desc *dev_desc)
     u32 block;
     int i = 1;
 
-    rdb = get_rdisk(dev_desc);
+	rdb = get_rdisk(desc);
     if (!rdb)
     {
 	PRINTF("part_print_amiga: no rdb found\n");
@@ -353,7 +353,7 @@ static void part_print_amiga(struct blk_desc *dev_desc)
 
 	PRINTF("Trying to load block #0x%X\n", block);
 
-	res = blk_dread(dev_desc, block, 1, (ulong *)block_buffer);
+	res = blk_dread(desc, block, 1, (ulong *)block_buffer);
 	if (res == 1)
 	{
 	    p = (struct partition_block *)block_buffer;
@@ -370,7 +370,7 @@ static void part_print_amiga(struct blk_desc *dev_desc)
 	} else block = 0xFFFFFFFF;
     }
 
-    boot = get_bootcode(dev_desc);
+	boot = get_bootcode(desc);
     if (boot)
     {
 	printf("Disk is bootable\n");
-- 
2.42.0.rc1.204.g551eb34607-goog

