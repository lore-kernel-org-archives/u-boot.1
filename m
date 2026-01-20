Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7032D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2644483B2C;
	Tue, 20 Jan 2026 14:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BKA9DPQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378AE83B22; Tue, 20 Jan 2026 14:36:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CDC83B0B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768916214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9US16T2836XFBpBirEIaRkfYLzFbsHgQFOreKguY+o=;
 b=BKA9DPQm5Wua3nIiZemC1TbL1HtnIp1v/6HvU0DYKhv1uNngMtvTv4L/z5lkRm380xbfdb
 Gq/ydCXlOaD+UZKGet8FJDz50JplcLAGGp6cm7jf8ow9IZvwXjjUHHOMYCD7lU9MxFNRaQ
 3SoRaNHe7hbrgkSmTGj4F6TOdooKSXs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-3GE2cOjTP02Ynd7etulVgQ-1; Tue, 20 Jan 2026 08:36:53 -0500
X-MC-Unique: 3GE2cOjTP02Ynd7etulVgQ-1
X-Mimecast-MFC-AGG-ID: 3GE2cOjTP02Ynd7etulVgQ_1768916212
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so3163070f8f.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916212; x=1769521012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9US16T2836XFBpBirEIaRkfYLzFbsHgQFOreKguY+o=;
 b=iUgqoEn2f9uCLPxBwxJj3w+xR+8rBU9Y2Od0dqxBNwxqEsmgooVK1/FxsMBvlnzUxE
 /ykedx9XqsdegWrRV8K1b0xk0jC1F14fCvtlPvJouFqm+1UGx8srR0F3kjxGCAgjnPIp
 KzCvvrTcO5ns2nRoVkaUW+BMYu7Lhyz5y9yYkmvaxKVfHuQELAuZ3GdOkcYI+n+yynjs
 zG/8qMiGHhQOatc15DICOA2/VnuaRJ4PjmExnfSUjjDVDeC/lStg3tD0VslLWnvyAmbo
 h8zxiBXsTO99vmlZis066QV1WiXjsi+Kmc/bH5EDODtlbFpga3DIHA5h3K1u1KGP0xtf
 zNsQ==
X-Gm-Message-State: AOJu0Yzf+VlWGUnwhlUcHTmlCFb67CLyXKMnDGdrJHh+TuGpbQYM02zt
 h1tvKshm4f4wdqvlIUhryS9IM11rhJESUBf6E/+7dFaJVgwGBJjAmwj/RAiTWYsgSxAKHltvWn/
 pgsKY9/4KpqMPEPryitOpcQfaKtF0teXyA350GfVfO/QaC5ZY1/KHR9IqSL00A9zfbfeilUpxhH
 82RFi7UgtS6dai82ggJpcI8Kx/+LCInEqi7g4QwQ==
X-Gm-Gg: AZuq6aJUDzCzrUvS168Oh+jcOymshnJUQXRDWXL5jqbkDQYNB3hdkzDOZcPDqsmencp
 vJjsUvDSRrrUAAglvoQyLCPWs/oUDrSAh/I3g5LgrQB3LJdhQ1nKYGt9I/fQIH4CWtIIew2KXG4
 UnRfjBWWa1bfKCCvfAnaG8QQYMJsa/CrVtj7QpPdoPZi/K5wGrb8OeFVSVn+yeMI3tgur5Ov5hu
 uphUc/yk5FPCn6XUJ/lAHnOiF6Ad1m8T+xmt4k7/Az9SU/CSzIB/PYpmX2MlGtcJP87nc8xx1fH
 FqpeWsy9PpkbcMBcY6MAG5JQWs1q4xViqy855LsNOtcRhGfI2MpMBepWOR69jWChLbwZm6CDa2L
 lSpwoD36dwebqFkUO/ITwpOfMZfcAv3uk2sM=
X-Received: by 2002:a05:6000:25c7:b0:430:fc3a:fbce with SMTP id
 ffacd0b85a97d-435699941abmr20819615f8f.15.1768916211637; 
 Tue, 20 Jan 2026 05:36:51 -0800 (PST)
X-Received: by 2002:a05:6000:25c7:b0:430:fc3a:fbce with SMTP id
 ffacd0b85a97d-435699941abmr20819544f8f.15.1768916211068; 
 Tue, 20 Jan 2026 05:36:51 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4358f12ee69sm5002928f8f.11.2026.01.20.05.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:36:50 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] disk: part_efi: Remove redundant struct partition
 definition
Date: Tue, 20 Jan 2026 14:36:12 +0100
Message-ID: <20260120133630.1695055-4-javierm@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120133630.1695055-1-javierm@redhat.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u7aJHMI4Y4YiJ8fROfddB0wT8MyOjcY_j_NOaMhcKtQ_1768916212
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

Now that dos_partition_t and struct partition are identical the duplicated
data structure definition in the part_efi.h header can just be removed.

This results in a single, shared definition for MBR partition table
entries, instead of having the same definition in two different places.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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
2.52.0

