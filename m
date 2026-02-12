Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958D3EEA84B
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F0583DEC;
	Thu, 12 Feb 2026 21:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="X64nf7Id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6707D83D5D; Thu, 12 Feb 2026 21:45:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285B483DCA
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ff3LnV4UpKOVSsEDELJfWMsPJFExXBzVTn+uK1DlVDo=;
 b=X64nf7Idq0IC6rq5QkAhzdoKAq1RzdGUvWBHjLjUSLDWlcok3jYxz32+Ont2J+TKWSlx0M
 lyEf/LovfONlSBLSpomI6xe6vna4ITWMphG3frkMM4we8yg5UUSfkiSIaQqkdYKICxx3GV
 CUYjQoiZaQ+wITnRfL9mpryGB1TMfI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-61p4FokNOB2qRsK1M2e80A-1; Thu, 12 Feb 2026 15:45:29 -0500
X-MC-Unique: 61p4FokNOB2qRsK1M2e80A-1
X-Mimecast-MFC-AGG-ID: 61p4FokNOB2qRsK1M2e80A_1770929127
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso1746855e9.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929127; x=1771533927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ff3LnV4UpKOVSsEDELJfWMsPJFExXBzVTn+uK1DlVDo=;
 b=DDGCl1TE5tPqoOr2KPoOfk39RHL1ZaD8jfVdiMWF5ZLSGKR5Pmewf9p21Uq310k/m8
 +Et7G5SMn0F1awEkR08/+9KGMtEBz8gQfDctk0DXyUzdjBT07cDlMWZfIWXtAucrR3EM
 ZObggH/ZxYhWnolaPIoqq8FbA419RW5kbn/fJJVQcUrZIgctqIQ9qBNkVABiks00Eqfy
 yY6wsKXo3+++q9iBEmO4u8SvASbbC/sFYwV58I+B4pUWtUAjUH9dW8k/AyCPYMK6wwK0
 cDC5k8Ohz9u3ssDvkTd2U1ooV75oKJ6ogcd+wuAKfbnjmEKsHrOx2T0vGmx8ybHLFrp7
 hLhw==
X-Gm-Message-State: AOJu0YxIREPOvTHbSafr0oKr4MzjXub6LmsEMMujdEC2s9Y2GUoQ3a8E
 NLfIciRr9WpTUOZBco+qBMv9SFrQyEWyi5jAIaYzeDpy7QOvZxmGM03Fwa/i55w3JQ6KNNRBk3i
 PiuaHJQkjHvD+GA9cChOrz3xY9xepOnu85tqA5XCSMJEJOjWyU7EkTIJul3kR6LUH3c2Vjpj1ES
 M7NIFd8wutqk/V0zTZKICQ8JzuTAs8wtRFWpsBbQ==
X-Gm-Gg: AZuq6aJNbfMvAL3+LMrE/y4kxFd4rSG9MJmF+VF7pDOLR07CPE5m9mKi5OLfna9jYj0
 Pb+sGmubx66I/F2nCdm/TcxEMQTRGWKEhHaHUVAFCnkmoaMvYLxU+p4kWUeHZ8lzk2DTPNXPmBr
 EFRhPTL6vQ2eRMmXx/71jifHSX8g7OpFJVcBprqwkyoFLfr4Dfb0iJ3QBalpV7ecf+rdXcwqW5u
 TG9ZrqLNsT4LHqSP6WmYSdlvyeibEeENLfpzl1UmMPlEF7DaAUQpzqDhU+HVb3+fqtD60MsaiIJ
 mgW+FZrodLaL0cwGEMcJymamGJdIj7M/rGKnMFRwxiUtKV8aYVMppk+iADMVQy4nwvawjcTj2eO
 9CCsMFOABA/DhhV5kFsWSxHVFce1cFc7hMlLUxOPOlbABMKM=
X-Received: by 2002:a05:600c:8b4c:b0:480:5678:1fdd with SMTP id
 5b1f17b1804b1-4837105240amr5961245e9.12.1770929126639; 
 Thu, 12 Feb 2026 12:45:26 -0800 (PST)
X-Received: by 2002:a05:600c:8b4c:b0:480:5678:1fdd with SMTP id
 5b1f17b1804b1-4837105240amr5960775e9.12.1770929126070; 
 Thu, 12 Feb 2026 12:45:26 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfaae1sm112461635e9.10.2026.02.12.12.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:24 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 5/7] disk: part_dos: Refactor to allow retrieving raw MBR
 partition data
Date: Thu, 12 Feb 2026 21:44:59 +0100
Message-ID: <20260212204511.619392-6-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zs6NXSgdnPvAWNkwYY8acCGlkSTO_JLJJjyY6Cc_c5o_1770929127
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

Refactor the part_get_info_extended() helper function (which already
recursively traverses DOS partitions) to optionally return the raw MBR
partition structure (dos_partition_t).

This allows other subsystems, such as EFI, to retrieve the partition
details in the legacy MBR format.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 disk/part_dos.c | 66 ++++++++++++++++++++++++++++++-------------------
 include/part.h  | 14 +++++++++++
 2 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index a69ad8962106..4e1d01b2f21e 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -204,7 +204,8 @@ static void print_partition_extended(struct blk_desc *desc,
  * @relative:		Relative offset for the partition
  * @part_num:		Current partition number
  * @which_part:		Target partition number
- * @info:		Returns a pointer to the partition info
+ * @info:		Returns partition information (optional)
+ * @mbr:		Returns MBR partition entry (optional)
  * @disksig:		Disk signature
  *
  * Return:		0 on success, negative on error
@@ -212,7 +213,9 @@ static void print_partition_extended(struct blk_desc *desc,
 static int part_get_info_extended(struct blk_desc *desc,
 				  lbaint_t ext_part_sector, lbaint_t relative,
 				  int part_num, int which_part,
-				  struct disk_partition *info, uint disksig)
+				  struct disk_partition *info,
+				  dos_partition_t *mbr,
+				  uint disksig)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	struct disk_partition wdinfo = { 0 };
@@ -243,9 +246,11 @@ static int part_get_info_extended(struct blk_desc *desc,
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS) && !ext_part_sector)
 		disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
 
-	ret = part_get_info_whole_disk(desc, &wdinfo);
-	if (ret)
-		return ret;
+	if (info) {
+		ret = part_get_info_whole_disk(desc, &wdinfo);
+		if (ret)
+			return ret;
+	}
 
 	/* Print all primary/logical partitions */
 	pt = (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
@@ -258,25 +263,29 @@ static int part_get_info_extended(struct blk_desc *desc,
 		    (pt->sys_ind != 0) &&
 		    (part_num == which_part) &&
 		    (ext_part_sector == 0 || is_extended(pt->sys_ind) == 0)) {
-			if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
-				info->blksz = wdinfo.blksz;
-			else
-				info->blksz = DOS_PART_DEFAULT_SECTOR;
-			info->start = (lbaint_t)(ext_part_sector +
-					get_unaligned_le32(&pt->start_sect));
-			info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
-			part_set_generic_name(desc, part_num,
-					      (char *)info->name);
-			/* sprintf(info->type, "%d, pt->sys_ind); */
-			strcpy((char *)info->type, "U-Boot");
-			info->bootable = get_bootable(pt);
-			if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-				char str[12];
-
-				sprintf(str, "%08x-%02x", disksig, part_num);
-				disk_partition_set_uuid(info, str);
+			if (info) {
+				if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
+					info->blksz = wdinfo.blksz;
+				else
+					info->blksz = DOS_PART_DEFAULT_SECTOR;
+				info->start = (lbaint_t)(ext_part_sector +
+							 get_unaligned_le32(&pt->start_sect));
+				info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
+				part_set_generic_name(desc, part_num,
+						      (char *)info->name);
+				/* sprintf(info->type, "%d, pt->sys_ind); */
+				strcpy((char *)info->type, "U-Boot");
+				info->bootable = get_bootable(pt);
+				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+					char str[12];
+
+					sprintf(str, "%08x-%02x", disksig, part_num);
+					disk_partition_set_uuid(info, str);
+				}
+				info->sys_ind = pt->sys_ind;
 			}
-			info->sys_ind = pt->sys_ind;
+			if (mbr)
+				memcpy(mbr, pt, sizeof(*mbr));
 			return 0;
 		}
 
@@ -296,7 +305,8 @@ static int part_get_info_extended(struct blk_desc *desc,
 
 			return part_get_info_extended(desc, lba_start,
 				 ext_part_sector == 0 ? lba_start : relative,
-				 part_num, which_part, info, disksig);
+						      part_num, which_part, info,
+						      mbr, disksig);
 		}
 	}
 
@@ -328,7 +338,13 @@ static void __maybe_unused part_print_dos(struct blk_desc *desc)
 static int __maybe_unused part_get_info_dos(struct blk_desc *desc, int part,
 					    struct disk_partition *info)
 {
-	return part_get_info_extended(desc, 0, 0, 1, part, info, 0);
+	return part_get_info_extended(desc, 0, 0, 1, part, info, NULL, 0);
+}
+
+int __maybe_unused part_get_mbr(struct blk_desc *desc, int part,
+				dos_partition_t *mbr)
+{
+	return part_get_info_extended(desc, 0, 0, 1, part, NULL, mbr, 0);
 }
 
 int is_valid_dos_buf(void *buf)
diff --git a/include/part.h b/include/part.h
index daebbbc2e68f..aed089d00f64 100644
--- a/include/part.h
+++ b/include/part.h
@@ -704,6 +704,20 @@ int write_mbr_partitions(struct blk_desc *dev,
 int layout_mbr_partitions(struct disk_partition *p, int count,
 			  lbaint_t total_sectors);
 
+/**
+ * part_get_mbr() - get the MBR partition record of a partition
+ *
+ * This function reads the MBR partition record for a given block
+ * device and partition number.
+ *
+ * @desc:	block device descriptor
+ * @part:	partition number for which to return the partition record
+ * @mbr:	MBR partition record
+ *
+ * Return:	0 on success, otherwise error
+ */
+int part_get_mbr(struct blk_desc *desc, int part, dos_partition_t *mbr);
+
 #endif
 
 #if CONFIG_IS_ENABLED(PARTITIONS)
-- 
2.53.0

