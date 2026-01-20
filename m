Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23604D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68F383A9F;
	Tue, 20 Jan 2026 14:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JquvoZPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8F883B21; Tue, 20 Jan 2026 14:36:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2E983A91
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768916212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfX837tiPwXZSo3RxWdL0tCnhD8UYNtifRGpkf9AFF0=;
 b=JquvoZPB6ManPEXcLALNcHUJIw+DoW8JYYV2GhERTQflj0n1PHAC8t2Ngu4ESLKPRCVKVE
 JqlHzzxh1VtqvmGdj29uJr1M2p1z9B42LdM8A1rzMqERtjRyQv/aaPcPeD+FcbOI2LLwxB
 FZ19Mfyt9XSlleO5Xy3QjBUz8luqH/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-52JHQ9viP-67TtmTLNvq2w-1; Tue, 20 Jan 2026 08:36:51 -0500
X-MC-Unique: 52JHQ9viP-67TtmTLNvq2w-1
X-Mimecast-MFC-AGG-ID: 52JHQ9viP-67TtmTLNvq2w_1768916210
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so34952315e9.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916209; x=1769521009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GfX837tiPwXZSo3RxWdL0tCnhD8UYNtifRGpkf9AFF0=;
 b=l9YQlkm94U+tDSm3+zcfPOv5fL0/ChIjFchZlnSGKkgVWAReJlZd6pgUGjdxVoOyyT
 EtueNyWkKbMQJKotmDzVZJ9lOxo+jEKtTIPHh1A4cllqs/yFXk/ND+GSKrhs4yLIcbYt
 RjsKh7kMJs2GUT1Xrgwo52QvU0OcAJK1SKADNQIoPpNlKw3NstQ2qWyt29jRa1TVTUlt
 BRQ406iU+d1dIdCrfLdohHc8ew138Xjqf/edRB1IS/im3JZhO4Cwvbk3bzLhW39H6Vzy
 8QSal2EDuCQkVMtQLJ61usLgB1Gnh7d09FxjK/lt9oEJiwCnvE1m1qsb+A4MZsqwNHGj
 RNGQ==
X-Gm-Message-State: AOJu0YykgHmv4C1n2sr5tB1pvs3TR+wnUlKx6RedJHCF3zhRd3dn18Fc
 7JFC8mHWTgctN/053u11PGUiDIqFxCUIH+1GiUOoJBYmype+YHU5hqlQ7HkYs26qKqgfGckR6cn
 YunfB497+ETPkTb9kZEvrLJdojrnfazmK4iIa6YDY/4CW/I4jUBf3DUU99qmvzmRl8C6tjzAE8c
 IcOLBmm5HKha9taQg+4rknEzpALgrZO7o/zxJcqA==
X-Gm-Gg: AY/fxX7s0gUko6AQka5EbS7p7OTE8OeOB9SIS05pTyR63WsG4tfXIN7tkvq6GSh9VLY
 36ZTORgIWn1no/98T10A8ZRvg4IuSHofsmPOu2+6a8t0Hr/5q/She1U1glHDoSFozO7YpojFO4H
 JBagXgD2fcjx12O/Oih0OqWBcAGEmK0vUyl6iuLNjac9D/jwNviyrx4F+WtAmuWLOPLrjdgS8UK
 KNr7rg6Ui53C8Gm1iYABdJEDa//pwGFApAO+HlC8j7JWGO1rmb/TQXJvM0zUk7Kc/jioRrh10lg
 MS0CKJc7xn3euxK2J1sCh3zM3wxG/QFcf9bqv2N2B7BzvQu/NjI86OcCD3kxsru31iALB6rW4pt
 s4SCOT1I7AVaadSsX/eYJct2U3VLT6Qg8Mqw=
X-Received: by 2002:a05:600c:4e43:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-4801e358875mr190058115e9.35.1768916209458; 
 Tue, 20 Jan 2026 05:36:49 -0800 (PST)
X-Received: by 2002:a05:600c:4e43:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-4801e358875mr190057725e9.35.1768916208919; 
 Tue, 20 Jan 2026 05:36:48 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe78fcfsm103605245e9.19.2026.01.20.05.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:36:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] disk: part_dos: Align dos_partition_t with struct
 partition
Date: Tue, 20 Jan 2026 14:36:11 +0100
Message-ID: <20260120133630.1695055-3-javierm@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120133630.1695055-1-javierm@redhat.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GhXz2Yq2YjkM0pb--tz-69FWioEUc56EvFKRoS_5sKs_1768916210
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
---

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
2.52.0

