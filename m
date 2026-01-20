Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2C1D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9AD83B55;
	Tue, 20 Jan 2026 14:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GslyrJQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB8D283B07; Tue, 20 Jan 2026 14:37:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CEA83B07
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768916217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWWgt4cWuNxs7F7d+f2oHkJ6t5uJSqLcYZ9Au7eogks=;
 b=GslyrJQCxjCKCqRnt/GzwJzumpCfeDGf65J32n6NeH4TU6gWuWoafpmowmAlX5Kng4hZOB
 ORqzyikp7vYlg1bXYYLTkClTBwUEdmkoY3N5qbyQFFKRZ2UoYEbvcTAX3sahNxjCMvObKZ
 F8lZpy4K6PUJ/jAiotvwoajV2SzBRkI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-yETUsuj_Nmih1fpKuIKNhg-1; Tue, 20 Jan 2026 08:36:56 -0500
X-MC-Unique: yETUsuj_Nmih1fpKuIKNhg-1
X-Mimecast-MFC-AGG-ID: yETUsuj_Nmih1fpKuIKNhg_1768916215
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so3529279f8f.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916215; x=1769521015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EWWgt4cWuNxs7F7d+f2oHkJ6t5uJSqLcYZ9Au7eogks=;
 b=UsWfEX6mfBVuQ/E3Bb6NpZjuXoAJwH4bd6x0WlSvMGtX5bw14jtvFlV93Ac6+cmvDq
 0sNEiYfZH0IHBDt0ZpNUpo5SsrVW7V6IAMBLbsNbPHfg8YLiCJ9JH7AlYI4GvpYZWEB7
 EHw22lkODMH4Tb/NU0jTV9sY84p4hAQfO8/YY+04yepAuR6Ubvfiz96fNJ9Bu3s9ULUF
 AmcRtKpxPpqosCMUu5gBioIn16ZDyve2/C1CT/vqOohLggDqSfyeab6HR4VFtULn04k8
 YFK6o7FZERdbqc4RbTBvbdigN5o1SCyAeRiv/DCllcZ4vUKJJOKKl6mIteME3Npv1wOv
 qViQ==
X-Gm-Message-State: AOJu0Yz+lO9YY4nsyTWCTSjqLz8gg3nJ3Qd24hl8Q8Rj6AzoMDgmij0s
 mYZr3rkesLruSSCn2uf8nvb3u3CSst1DTzR0uXjFRLbjuomzXp9Zwm3bQrlaHR/QQ6AGA4hA9Mx
 n5coZnECFM83Zs6tlaLZjaS8kSoz1iDq4kCWEL9CcK/WNFeH1qCMNcSLfgqcf4UdJF9UfYLAk4l
 fZEeSxAxW1TPAKNgWe0dnBbO8WtkHZe21bvSuuIw==
X-Gm-Gg: AZuq6aKqhdyXj4QpVyaD6nHh2SGGhNxaErXLZgl5OERxJYfishK7ohYSaVEPmEiKWBg
 Gn3H40K1ttJgtYlXy2slmDKI6ECoVvB0b7Qzoy7CNiYTUbz0QxAPB8oeyUQmHV6ZWb2P3iFTT33
 spx8160itDDi0mCJwsUgjXCiKJFrJgwiQJz9t07Pr4RrTznymmFSTonhPQ7y8pqmXI9UB1saedn
 d75wui3i+HkzdvjV6XE9Xjqvl1cfl4PtI7MsfST1WeLQTgo4zM03yUaX4spaVuN+i33MH6biiNc
 7weVh0jctu3TC2K1JJIn+hdMXXESD28dIORKDpdU1sWumqTqcjIKK/mKl1XhxowJQHBPcOsA+MM
 lQf37+XdNb/8n09WlIuHdT4cH97nORDn5ueg=
X-Received: by 2002:a05:6000:186f:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4359017515dmr3012796f8f.46.1768916214516; 
 Tue, 20 Jan 2026 05:36:54 -0800 (PST)
X-Received: by 2002:a05:6000:186f:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4359017515dmr3012741f8f.46.1768916213900; 
 Tue, 20 Jan 2026 05:36:53 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359314bbc6sm2614430f8f.12.2026.01.20.05.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:36:52 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 4/5] efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL to
 support MBR
Date: Tue, 20 Jan 2026 14:36:13 +0100
Message-ID: <20260120133630.1695055-5-javierm@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120133630.1695055-1-javierm@redhat.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wCtbpi65Gyj24ZTTRlL3h4ugftID1naizb9AnhnDwew_1768916215
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

The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
partitions. The UEFI specification mentions that both GPT and MBR
partition schemes are supported, but the U-Boot implementation only
supports the former.

This can cause compatibility issues for platforms whose boot ROM only
supports MBR. This change adds support for MBR partition tables to
the protocol, making U-Boot compatible with systems that require a
legacy MBR table.

To implement this, the existing part_get_info_extended() function,
which already traverses DOS partitions, is refactored to optionally
retrieve the raw MBR partition record. This provides the necessary
data for the EFI subsystem.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 disk/part_dos.c           | 63 ++++++++++++++++++++++++---------------
 include/part.h            | 14 +++++++++
 lib/efi_loader/efi_disk.c |  9 ++++--
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 60c3d6773696..5b508483bae7 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -201,7 +201,9 @@ static void print_partition_extended(struct blk_desc *desc,
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
@@ -232,9 +234,11 @@ static int part_get_info_extended(struct blk_desc *desc,
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
@@ -247,25 +251,29 @@ static int part_get_info_extended(struct blk_desc *desc,
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
 
@@ -285,7 +293,8 @@ static int part_get_info_extended(struct blk_desc *desc,
 
 			return part_get_info_extended(desc, lba_start,
 				 ext_part_sector == 0 ? lba_start : relative,
-				 part_num, which_part, info, disksig);
+						      part_num, which_part, info,
+						      mbr, disksig);
 		}
 	}
 
@@ -317,7 +326,13 @@ static void __maybe_unused part_print_dos(struct blk_desc *desc)
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
index daebbbc2e68f..84dbdbbd1494 100644
--- a/include/part.h
+++ b/include/part.h
@@ -704,6 +704,20 @@ int write_mbr_partitions(struct blk_desc *dev,
 int layout_mbr_partitions(struct disk_partition *p, int count,
 			  lbaint_t total_sectors);
 
+/**
+ * part_get_mbr() - Get the MBR partition record of a partition
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
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 130c4db9606f..f8a57539ec61 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -475,9 +475,12 @@ static efi_status_t efi_disk_add_dev(
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
 		case PART_TYPE_DOS:
 			info->type = PARTITION_TYPE_MBR;
-
-			/* TODO: implement support for MBR partition types */
-			log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
+			ret = part_get_mbr(desc, part, &info->info.mbr);
+			if (ret) {
+				log_debug("get MBR for part %d failed %ld\n",
+					  part, ret);
+				goto error;
+			}
 			break;
 #endif
 		default:
-- 
2.52.0

