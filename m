Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C72EEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B72183D6C;
	Thu, 12 Feb 2026 21:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BA1s+RGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746B383DCA; Thu, 12 Feb 2026 21:45:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5530183D5D
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z20qoABZ2CA0QB1vSCQ9Zi0sSxjQk09IoYggdGSkk+8=;
 b=BA1s+RGrwDr/TEIy+o2PIceUdQqRl3qVdbvtqEiQUkRaSKapQmHGivAIRINY01taYdYbB0
 SN8alBOJXSRwu06AVevHmTtf6r405BOObsvG+GMcgRDBuQHCQsnAJtUgYqCi4F1ZAIuZAz
 N6cKNk/82uz1uvZZI41oQaWuxGJhLDQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-vmYbA8MxOhGm7H0pLYSNNQ-1; Thu, 12 Feb 2026 15:45:23 -0500
X-MC-Unique: vmYbA8MxOhGm7H0pLYSNNQ-1
X-Mimecast-MFC-AGG-ID: vmYbA8MxOhGm7H0pLYSNNQ_1770929122
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so1840395e9.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929121; x=1771533921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z20qoABZ2CA0QB1vSCQ9Zi0sSxjQk09IoYggdGSkk+8=;
 b=YJfxqP6T8bhZW92hERHkB3MvPk/gXKjxfEpYVgs0qVihCR4KQl48eJ9lQ7qzd2rkVk
 r+UDla75n6vV+LfUpHBbC7FonSPWupdmpR2vWwBOmL9y4ZHeHz8BIS1eXp+OKwpK08cn
 4904imCf9QvQZB96E606ve9scnNMXOEmSRqt7quZsfqdyxlLokK37BCn6T0IyJMCUE1R
 SNNGpN9IQkOn0pZ4v2HlfnHYxyB/Mvue5BCQ4xxW95J9TOH1YthNhUDMcO4iDBxSxMJt
 DGV6p5dftTDzN6Dp1ZYdmFcdTWfyBTu51yDFc/1RWyrm5bvSl+ENTZDUvDsOSBeK0Fde
 Wx0w==
X-Gm-Message-State: AOJu0YxMHUtABNTlkRFOdGzFu9MJ64TtLhj8xmx635ppf5CUgbUDzQbd
 DATpja1NR293MioXJftAPiBiN16kO483XYhH8jMwzA3DqRUiWiFdlDMSFQwiJOox20C/mRqriIe
 BqUhSMvrLOUHivcBRzM/SvtEV4D66wlHybyhjPmKegY8noi54JSCw7zwn39oR0s1IAD7lVHZV+8
 ZTKsugLxjXj1hQKj+Ja+X8VFaaygUp9AK5MsHCGQ==
X-Gm-Gg: AZuq6aJHG9R7bFYNPYl0wIyZrxpHmA1jiGc8EJdibVyJLZYx0dWJsRl0kM3Y3Q1K+gN
 uDHI6RXzGRExYCn/QNNnSalbgTCK3QrVRIYJ8dPsAkQef/PJ9qr4HE0/6DsNGYEFAeYHgusivO5
 31BfOhcLDUSQxkbjkN13dFdaNjjE4miCouOdDyFufmHBod4lMI6JzcqMVGGF9HWqdnR9ExuxJRy
 pYl3tFbPN8bDvjVB1cGltoY9o8XYJ/ZggskvGJ+LyI9KpA71e3NSYOtXW6Qjg6pEHxB9K9FX5eY
 ZYYEagXvRQAyYRwofPLhtcYC7JDmUE3keLMcb5BiSkw0kPdKBzpEaix8NHCGahHxeHWMgDRK8rm
 GoxKw18NS81D1z4Ryk8OA2LMDzJQ2M/qFXXmhasi+8Vmz6wo=
X-Received: by 2002:a05:600c:3b8b:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-48371040571mr7338495e9.28.1770929121290; 
 Thu, 12 Feb 2026 12:45:21 -0800 (PST)
X-Received: by 2002:a05:600c:3b8b:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-48371040571mr7338015e9.28.1770929120726; 
 Thu, 12 Feb 2026 12:45:20 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a3ecadsm3205185e9.3.2026.02.12.12.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:20 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 3/7] disk: part_efi: Remove redundant struct partition
 definition
Date: Thu, 12 Feb 2026 21:44:57 +0100
Message-ID: <20260212204511.619392-4-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: waoFTyp5Nb4lUw3OUZ2FyujC5g1lrXxsAubBNTuInkI_1770929122
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

Now that dos_partition_t and struct partition are identical, the duplicated
data structure definition in the part_efi.h header can just be removed.

This results in a single, shared definition for MBR partition table
entries, instead of having the same definition in two different places.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 disk/part_efi.c    |  4 ++--
 include/part_efi.h | 19 +++----------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index fb1ed534f861..d8b17ec2e91a 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -51,7 +51,7 @@ static inline u32 efi_crc32(const void *buf, u32 len)
  * Private function prototypes
  */
 
-static int pmbr_part_valid(struct partition *part);
+static int pmbr_part_valid(dos_partition_t *part);
 static int is_pmbr_valid(legacy_mbr * mbr);
 static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 			gpt_entry **pgpt_pte);
@@ -990,7 +990,7 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
  *
  * Returns: 1 if EFI GPT partition type is found.
  */
-static int pmbr_part_valid(struct partition *part)
+static int pmbr_part_valid(dos_partition_t *part)
 {
 	if (part->sys_ind == EFI_PMBR_OSTYPE_EFI_GPT &&
 		get_unaligned_le32(&part->start_sect) == 1UL) {
diff --git a/include/part_efi.h b/include/part_efi.h
index fb402df6f13e..2cea50880465 100644
--- a/include/part_efi.h
+++ b/include/part_efi.h
@@ -18,6 +18,7 @@
 #define _DISK_PART_EFI_H
 
 #include <efi.h>
+#include <part_dos.h>
 
 #define MSDOS_MBR_SIGNATURE 0xAA55
 #define MSDOS_MBR_BOOT_CODE_SIZE 440
@@ -77,20 +78,6 @@
 /* linux/include/efi.h */
 typedef u16 efi_char16_t;
 
-/* based on linux/include/genhd.h */
-struct partition {
-	u8 boot_ind;		/* 0x80 - active */
-	u8 head;		/* starting head */
-	u8 sector;		/* starting sector */
-	u8 cyl;			/* starting cylinder */
-	u8 sys_ind;		/* What partition type */
-	u8 end_head;		/* end head */
-	u8 end_sector;		/* end sector */
-	u8 end_cyl;		/* end cylinder */
-	__le32 start_sect;	/* starting sector counting from 0 */
-	__le32 nr_sects;	/* nr of sectors in partition */
-} __packed;
-
 /* based on linux/fs/partitions/efi.h */
 typedef struct _gpt_header {
 	__le64 signature;
@@ -134,7 +121,7 @@ typedef struct _legacy_mbr {
 	u8 boot_code[MSDOS_MBR_BOOT_CODE_SIZE];
 	__le32 unique_mbr_signature;
 	__le16 unknown;
-	struct partition partition_record[4];
+	dos_partition_t partition_record[4];
 	__le16 signature;
 } __packed legacy_mbr;
 
@@ -153,7 +140,7 @@ struct efi_partition_info {
 	u8 system;
 	u8 reserved[7];
 	union {
-		struct partition mbr;
+		dos_partition_t mbr;
 		gpt_entry gpt;
 	} info;
 } __packed;
-- 
2.53.0

