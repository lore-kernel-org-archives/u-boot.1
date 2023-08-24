Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA913C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFAA869D3;
	Thu, 24 Aug 2023 21:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rkv9FUAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A819869D2; Thu, 24 Aug 2023 21:56:09 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E93586940
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7927182dfe3so7913139f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906964; x=1693511764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+5sgyqJ0tx/MdmsiQ52P1HXjY2EJ+Jh7MwCN58wAOg=;
 b=Rkv9FUAyv+zzWkZyonO9ajjkRpPIPyUz9cSJ1iLXA+aXgC39QuSBvaJhZsZ2HeECg9
 mxKYV4T1l74IUtCuMy9qF0Yk3PcbyVAoL7zHh7YSujl6+t8OoeyIWZZ2EgRRvpmaQzJA
 ri+y3pEVkFjVMwkKbX14+uBIeVcqKLY4T8cQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906964; x=1693511764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+5sgyqJ0tx/MdmsiQ52P1HXjY2EJ+Jh7MwCN58wAOg=;
 b=OmXz1qOqyIFitDVETT7A1y9AlK8s6CZk/3NMJ863JI520R6xQde/1SW4mg5AySWI5J
 l7tqT25m0+zUMS4UZbMfAgsZIHt4WjFwJN3maJqHsi5DuV6PvzD+rHW+LUIW4R3S0Pi2
 qvYFXOUcijlwkQcPS28Oe790eTb5lHlZNVQ8mQVjVvsfQfHRMQJdbUCHf/lO0aN9STi+
 4POVbq7HEWfNQoui/n6Cmgqlw/nYNmaZRS0MKeeIl6ghUX7obNIK5dSohF5CRASMfPRd
 8SFNxMFdWSy3gfoslIh0Uz43TNpZorPnSHDHCT+I9bFHDMRYIkwWNV0DzYhBBMSaKaHR
 FsjQ==
X-Gm-Message-State: AOJu0Yyz2mt+CK4O/TBae9Q6VLnSW9Ea023p8HKtv7n8YI3795PV567b
 ugyfwp+fOjpLAndRWCW0r1Ex6xTEux+KMCS0mmg=
X-Google-Smtp-Source: AGHT+IFLUrPT4oDcc1XZRPj2HbjeFcngnF+Yaa6WsfqUuPXqntaiNka4aQEfJ1AtFwTckW4d0aPtkw==
X-Received: by 2002:a05:6602:2579:b0:792:6cb2:e92c with SMTP id
 dj25-20020a056602257900b007926cb2e92cmr3709157iob.3.1692906964769; 
 Thu, 24 Aug 2023 12:56:04 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/23] part: nac: Use desc instead of dev_desc
Date: Thu, 24 Aug 2023 13:55:29 -0600
Message-ID: <20230824195553.1685996-7-sjg@chromium.org>
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
is now a different thing, with driver model. Update the mac code to
just use 'desc'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part_mac.c | 59 ++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/disk/part_mac.c b/disk/part_mac.c
index ae8263f755ae..db5e203be592 100644
--- a/disk/part_mac.c
+++ b/disk/part_mac.c
@@ -31,21 +31,20 @@ extern ldiv_t ldiv (long int __numer, long int __denom);
 #endif
 
 
-static int part_mac_read_ddb(struct blk_desc *dev_desc,
-			     mac_driver_desc_t *ddb_p);
-static int part_mac_read_pdb(struct blk_desc *dev_desc, int part,
+static int part_mac_read_ddb(struct blk_desc *desc, mac_driver_desc_t *ddb_p);
+static int part_mac_read_pdb(struct blk_desc *desc, int part,
 			     mac_partition_t *pdb_p);
 
 /*
  * Test for a valid MAC partition
  */
-static int part_test_mac(struct blk_desc *dev_desc)
+static int part_test_mac(struct blk_desc *desc)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
 	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
 	ulong i, n;
 
-	if (part_mac_read_ddb (dev_desc, ddesc)) {
+	if (part_mac_read_ddb(desc, ddesc)) {
 		/*
 		 * error reading Driver Descriptor Block,
 		 * or no valid Signature
@@ -55,8 +54,8 @@ static int part_test_mac(struct blk_desc *dev_desc)
 
 	n = 1;	/* assuming at least one partition */
 	for (i=1; i<=n; ++i) {
-		if ((blk_dread(dev_desc, i, 1, (ulong *)mpart) != 1) ||
-		    (mpart->signature != MAC_PARTITION_MAGIC) ) {
+		if ((blk_dread(desc, i, 1, (ulong *)mpart) != 1) ||
+		    mpart->signature != MAC_PARTITION_MAGIC) {
 			return (-1);
 		}
 		/* update partition count */
@@ -65,14 +64,14 @@ static int part_test_mac(struct blk_desc *dev_desc)
 	return (0);
 }
 
-static void part_print_mac(struct blk_desc *dev_desc)
+static void part_print_mac(struct blk_desc *desc)
 {
 	ulong i, n;
 	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
 	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
 	ldiv_t mb, gb;
 
-	if (part_mac_read_ddb (dev_desc, ddesc)) {
+	if (part_mac_read_ddb(desc, ddesc)) {
 		/*
 		 * error reading Driver Descriptor Block,
 		 * or no valid Signature
@@ -110,15 +109,15 @@ static void part_print_mac(struct blk_desc *dev_desc)
 		char c;
 
 		printf ("%4ld: ", i);
-		if (blk_dread(dev_desc, i, 1, (ulong *)mpart) != 1) {
+		if (blk_dread(desc, i, 1, (ulong *)mpart) != 1) {
 			printf ("** Can't read Partition Map on %d:%ld **\n",
-				dev_desc->devnum, i);
+				desc->devnum, i);
 			return;
 		}
 
 		if (mpart->signature != MAC_PARTITION_MAGIC) {
 			printf("** Bad Signature on %d:%ld - expected 0x%04x, got 0x%04x\n",
-			       dev_desc->devnum, i, MAC_PARTITION_MAGIC,
+			       desc->devnum, i, MAC_PARTITION_MAGIC,
 			       mpart->signature);
 			return;
 		}
@@ -154,10 +153,9 @@ static void part_print_mac(struct blk_desc *dev_desc)
 /*
  * Read Device Descriptor Block
  */
-static int part_mac_read_ddb(struct blk_desc *dev_desc,
-			     mac_driver_desc_t *ddb_p)
+static int part_mac_read_ddb(struct blk_desc *desc, mac_driver_desc_t *ddb_p)
 {
-	if (blk_dread(dev_desc, 0, 1, (ulong *)ddb_p) != 1) {
+	if (blk_dread(desc, 0, 1, (ulong *)ddb_p) != 1) {
 		debug("** Can't read Driver Descriptor Block **\n");
 		return (-1);
 	}
@@ -171,7 +169,7 @@ static int part_mac_read_ddb(struct blk_desc *dev_desc,
 /*
  * Read Partition Descriptor Block
  */
-static int part_mac_read_pdb(struct blk_desc *dev_desc, int part,
+static int part_mac_read_pdb(struct blk_desc *desc, int part,
 			     mac_partition_t *pdb_p)
 {
 	int n = 1;
@@ -182,15 +180,15 @@ static int part_mac_read_pdb(struct blk_desc *dev_desc, int part,
 		 * partition 1 first since this is the only way to
 		 * know how many partitions we have.
 		 */
-		if (blk_dread(dev_desc, n, 1, (ulong *)pdb_p) != 1) {
-			printf ("** Can't read Partition Map on %d:%d **\n",
-				dev_desc->devnum, n);
+		if (blk_dread(desc, n, 1, (ulong *)pdb_p) != 1) {
+			printf("** Can't read Partition Map on %d:%d **\n",
+			       desc->devnum, n);
 			return (-1);
 		}
 
 		if (pdb_p->signature != MAC_PARTITION_MAGIC) {
 			printf("** Bad Signature on %d:%d: expected 0x%04x, got 0x%04x\n",
-			       dev_desc->devnum, n, MAC_PARTITION_MAGIC,
+			       desc->devnum, n, MAC_PARTITION_MAGIC,
 			       pdb_p->signature);
 			return (-1);
 		}
@@ -199,10 +197,9 @@ static int part_mac_read_pdb(struct blk_desc *dev_desc, int part,
 			return (0);
 
 		if ((part < 1) || (part > pdb_p->map_count)) {
-			printf ("** Invalid partition %d:%d [%d:1...%d:%d only]\n",
-				dev_desc->devnum, part,
-				dev_desc->devnum,
-				dev_desc->devnum, pdb_p->map_count);
+			printf("** Invalid partition %d:%d [%d:1...%d:%d only]\n",
+			       desc->devnum, part, desc->devnum, desc->devnum,
+			       pdb_p->map_count);
 			return (-1);
 		}
 
@@ -213,21 +210,19 @@ static int part_mac_read_pdb(struct blk_desc *dev_desc, int part,
 	/* NOTREACHED */
 }
 
-static int part_get_info_mac(struct blk_desc *dev_desc, int part,
-				  struct disk_partition *info)
+static int part_get_info_mac(struct blk_desc *desc, int part,
+			     struct disk_partition *info)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
 	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
 
-	if (part_mac_read_ddb (dev_desc, ddesc)) {
-		return (-1);
-	}
+	if (part_mac_read_ddb(desc, ddesc))
+		return -1;
 
 	info->blksz = ddesc->blk_size;
 
-	if (part_mac_read_pdb (dev_desc, part, mpart)) {
-		return (-1);
-	}
+	if (part_mac_read_pdb(desc, part, mpart))
+		return -1;
 
 	info->start = mpart->start_block;
 	info->size  = mpart->block_count;
-- 
2.42.0.rc1.204.g551eb34607-goog

