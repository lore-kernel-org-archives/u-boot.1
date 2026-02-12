Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29C7EEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7FC83DB6;
	Thu, 12 Feb 2026 21:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dYbdqd5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3B983D71; Thu, 12 Feb 2026 21:45:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B82283A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JHhKRwKgjcBzLn3rJkmebNMGs1jkBQEwco60cqbAIo=;
 b=dYbdqd5SVUmMU3A5E7zG1qsLhXdL0egjfI2F2hN01Az7hW6JxGHzwCg66yoFReabrcxIAA
 IOhNGVcI6+rGlxhDgmizAgb+soqz3+hbF9tJ+XVJ0kb4cjoPoMZ6560z68Z5WYn9LeYrcU
 +YuwGcPbIJXOkiI4OWeI45a9bWV/GRM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-YB2GYX2RP3OXo6t0_Zre2g-1; Thu, 12 Feb 2026 15:45:20 -0500
X-MC-Unique: YB2GYX2RP3OXo6t0_Zre2g-1
X-Mimecast-MFC-AGG-ID: YB2GYX2RP3OXo6t0_Zre2g_1770929120
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so2094715e9.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929119; x=1771533919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JHhKRwKgjcBzLn3rJkmebNMGs1jkBQEwco60cqbAIo=;
 b=PHJ6nl+VJBgi4wdUK5jajmvkVU6nK63cxFvYbfY7wOEVXaAkfO19aM+8y1TFF8N0Wk
 WXbVzz82QFSrokme964OkS9dzPHeZmPP+VI6NJ4LLectMM4A/Kr+Uq0YsO2jzJ5cEk+o
 OouPIUMK+oo3P3KrVz+gNJFMUMxdyiMuJg27OVVbecxc4t+q7ZsoxQBSisj6w7xCZYwZ
 pS6NDeGtn9hRSJFxy6I0GQZLtGsUV1FfjBx7Bg1+aZX0yFJYMW9mBYrDZObDmOyk/XrJ
 GirozlvQyuOKoBS34p0gXxiikK+6WgryWdgGHc8Nxuec5EpT9A2Gxk4gYpkC1Tk+1iHJ
 juOQ==
X-Gm-Message-State: AOJu0Yyj+ufQ5SlZTNm4oVJqHR6RTbMuSxDeiXajbabT+GC6c1AVa+p5
 b1PGOZJYeV4piG3o/s4Kl1yhaQF2EBfmJE7eo31qhULj6ScpE9xH/HHuz3ffmBaKAp9HiAuK/Fy
 sCb5g15Jl+fk92+r6gldzGoCdNZ5QDJQx3bFIgvfoe7MRaUaviGcr//7QHKdI4SkTbH8nHX5ksx
 NbPalo2JU8/AJ6f/DZ8mXH9192JDMl+1DX6QSODA==
X-Gm-Gg: AZuq6aKsRAjfpDXVwgBWbGFhcWIBuWE1o6dKK4EOCHn2jShszywfxqZ9ScpwX9Qd5GV
 T/gCPeGZBmfoL5+PGT+SCHsx2OMU6JHFJmEpY8juD3fnuy9WbY20vwwvPN3NfFQF2BPrnrDJstL
 bd48535mWasY4ZcAaQpJ3Iet00uca72AgitvYpSwbXsuxjBMRNbCqLRFZ2mS/BPvOj63BdMbdBz
 8ZQBSTxkiYZ8iZDwYgyu2Jc/LmD6WBSTJ3Gpu6Qada7kVk9qZVrx6lWfGjlVfn90nMas+dFd/vh
 MLIXSiN0rcSorLkzt3UH7CCL3Txj6usnD16lod9g38A2WTHt7U/K3pkyuJX9cGvBvqhNi/vwDVy
 TzJ378iHgvG26b5SN7tpTZWXDvlBI9/lLcNgiW7uBK2eUy+E=
X-Received: by 2002:a05:600c:6216:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-48370e1892dmr6888905e9.1.1770929118785; 
 Thu, 12 Feb 2026 12:45:18 -0800 (PST)
X-Received: by 2002:a05:600c:6216:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-48370e1892dmr6888635e9.1.1770929118344; 
 Thu, 12 Feb 2026 12:45:18 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a298ebsm1026155e9.13.2026.02.12.12.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:17 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 2/7] disk: part_dos: Align dos_partition_t with struct
 partition
Date: Thu, 12 Feb 2026 21:44:56 +0100
Message-ID: <20260212204511.619392-3-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fPt7jBSAujrv4TDFANb7Za8r3XesZKgoNdRV6-QyxLM_1770929120
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The dos_partition_t struct defined in part_dos.h is nearly identical to
the struct partition defined in part_efi.h. They differ primarily in how
define their starting sector and number of sectors fields.

The former uses unsigned char arrays while the latter uses __le32 types.
Using __le32 is preferable, as it removes the ambiguity and potential
misuse of a raw byte array. This also aligns the structure with how the
Linux kernel defines it nowadays, which is the original source of it.

To prepare for future consolidation where one of the data structures can
be removed, this change aligns both definitions and updates all accessors
for dos_partition_t.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 disk/part_dos.c    | 16 ++++++++--------
 include/part_dos.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 2545cc6bf5d2..60c3d6773696 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -49,8 +49,8 @@ static int get_bootable(dos_partition_t *p)
 static void print_one_part(dos_partition_t *p, lbaint_t ext_part_sector,
 			   int part_num, unsigned int disksig)
 {
-	lbaint_t lba_start = ext_part_sector + get_unaligned_le32(p->start4);
-	lbaint_t lba_size  = get_unaligned_le32(p->size4);
+	lbaint_t lba_start = ext_part_sector + get_unaligned_le32(&p->start_sect);
+	lbaint_t lba_size  = get_unaligned_le32(&p->nr_sects);
 
 	printf("%3d\t%-10" LBAFlength "u\t%-10" LBAFlength
 		"u\t%08x-%02x\t%02x%s%s\n",
@@ -185,7 +185,7 @@ static void print_partition_extended(struct blk_desc *desc,
 	for (i = 0; i < 4; i++, pt++) {
 		if (is_extended (pt->sys_ind)) {
 			lbaint_t lba_start
-				= get_unaligned_le32 (pt->start4) + relative;
+				= get_unaligned_le32 (&pt->start_sect) + relative;
 
 			print_partition_extended(desc, lba_start,
 						 !ext_part_sector ? lba_start :
@@ -252,8 +252,8 @@ static int part_get_info_extended(struct blk_desc *desc,
 			else
 				info->blksz = DOS_PART_DEFAULT_SECTOR;
 			info->start = (lbaint_t)(ext_part_sector +
-					get_unaligned_le32(pt->start4));
-			info->size  = (lbaint_t)get_unaligned_le32(pt->size4);
+					get_unaligned_le32(&pt->start_sect));
+			info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
 			part_set_generic_name(desc, part_num,
 					      (char *)info->name);
 			/* sprintf(info->type, "%d, pt->sys_ind); */
@@ -281,7 +281,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 	for (i = 0; i < 4; i++, pt++) {
 		if (is_extended (pt->sys_ind)) {
 			lbaint_t lba_start
-				= get_unaligned_le32 (pt->start4) + relative;
+				= get_unaligned_le32 (&pt->start_sect) + relative;
 
 			return part_get_info_extended(desc, lba_start,
 				 ext_part_sector == 0 ? lba_start : relative,
@@ -356,8 +356,8 @@ static void mbr_fill_pt_entry(dos_partition_t *pt, lbaint_t start,
 	pt->sys_ind = sys_ind;
 	lba_to_chs(start, &pt->cyl, &pt->head, &pt->sector);
 	lba_to_chs(start + size - 1, &pt->end_cyl, &pt->end_head, &pt->end_sector);
-	put_unaligned_le32(relative, &pt->start4);
-	put_unaligned_le32(size, &pt->size4);
+	put_unaligned_le32(relative, &pt->start_sect);
+	put_unaligned_le32(size, &pt->nr_sects);
 }
 
 int write_mbr_partitions(struct blk_desc *dev,
diff --git a/include/part_dos.h b/include/part_dos.h
index 505582242281..92956d530637 100644
--- a/include/part_dos.h
+++ b/include/part_dos.h
@@ -30,8 +30,8 @@ typedef struct dos_partition {
 	unsigned char end_head;		/* end head				*/
 	unsigned char end_sector;	/* end sector				*/
 	unsigned char end_cyl;		/* end cylinder				*/
-	unsigned char start4[4];	/* starting sector counting from 0	*/
-	unsigned char size4[4];		/* nr of sectors in partition		*/
-} dos_partition_t;
+	__le32 start_sect;		/* starting sector counting from 0	*/
+	__le32 nr_sects;		/* nr of sectors in partition		*/
+} __packed dos_partition_t;
 
 #endif	/* _DISK_PART_DOS_H */
-- 
2.53.0

