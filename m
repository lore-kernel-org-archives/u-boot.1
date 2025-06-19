Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01028C7115E
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 08:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C3082BA1;
	Thu, 19 Jun 2025 10:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hKWfF/c+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BB482B18; Thu, 19 Jun 2025 10:34:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3A382BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750322065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Y2F7jTMtVu1es0POW08uDhVnT8xOU16bc2BsA/SvjU=;
 b=hKWfF/c+7WrdUBO8n+TiZPWMJ63/tuWtP6ffDVh90AQV4L7r7wTF7Yf5iK/e+9ocbBhdh+
 jrE2ubi7KA8c+t5t+GwYM3C16hzF12p8IWcNUTrdjefacIGKQI+FtSuj2FRA9Ap5R8lE53
 wb8nIIwmo2YPmyu7+gEPBYtcZc2I8GY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-fPcsyxOeN56XIh1urKwDbA-1; Thu, 19 Jun 2025 04:34:24 -0400
X-MC-Unique: fPcsyxOeN56XIh1urKwDbA-1
X-Mimecast-MFC-AGG-ID: fPcsyxOeN56XIh1urKwDbA_1750322064
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f55ea44dso214367f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 01:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750322063; x=1750926863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y2F7jTMtVu1es0POW08uDhVnT8xOU16bc2BsA/SvjU=;
 b=Z0XimaOf2Gc4pLNNFr53E5J4UlL5wdFeMyX/xeWvMQbL44y9xQ544U9KxF3FDN+cOO
 tpRPRRq19Pl9m9pArq4ttHpLk5o+OZsgXyjR9sda9WsU/8CBj9pgEH+8iTgTdBAYMpyi
 PR5qthYftWQl1XPJDU5hbRgDf6v5GACbR+P4Kfxs80eNOLqRGYkYHf28acbW5Ahy7Bp0
 NLE+ewZ+iOc6Gri5ALOGFYSe83enmjW+/pK6qg2gv1yS+V6pMbomYrlyTNglC9iavYIY
 9opIMamBa7/U760fd80GM2r3JxqEB3ZBoLTg5+TOIckgYypzxhKKSnS5C4uyFGiARPEy
 oV6g==
X-Gm-Message-State: AOJu0Yw2JNYpGWLX6N7jL+27tfIDoKuzSSBI2auUnFgmO9YuxFFqx5+v
 YFJ6C1Hw1hj5U4vRF5dbS3uVX6rihm9z2H02w2fdKCCZnzCrmJzea/57GOiyL+ILA5bEG1bT8ja
 m8oDhcz4ts1qKINNRlZVx3YYPyhBNsKRnoxSJixVITtoQOVPcNoKxNxxYUqqZjVypTHIwxkIbln
 w24bYcOLih55WRFFYaCVXsfxN8KjO0VrlPIHkQmg==
X-Gm-Gg: ASbGncvH0ZB/EgSfvH5z3t+VCe3974usNl9LquHCgotq8z0GoaGP90c77bes7ODlfjc
 5bZibz/ecoS25eMkQFlCX4vKfyU9irxIyoyWjVfudpLau1KrE1x5XlpJjtLb+uvqcMssUf39FaI
 e6BfjFSUukxcrAwF88Yy6WWKvcYoncH9MxDFK/CQ1/4tJ5zZUkGVd65lx02RlD29MznvQsHMcew
 pzlUwfGlyHIaVule189r1eS7Nhv26fwy6oeFsyzkt8TJzd52d0yGvtYUmm+lN4BB2R1deKALNfr
 EHPaATv6F9hIAU8cbA6aW3VYVTzCvilbvdNxoD7SSeF6FCu6sExn
X-Received: by 2002:a05:6000:178a:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a572366706mr16456941f8f.8.1750322063003; 
 Thu, 19 Jun 2025 01:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUEfFFc4fV/Sl0FlSGnhnDENGNNMh/fFaBOgL+3J82s7Kt0CUi8CqWlVwgAwCA1WG3YEEt2g==
X-Received: by 2002:a05:6000:178a:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a572366706mr16456902f8f.8.1750322062490; 
 Thu, 19 Jun 2025 01:34:22 -0700 (PDT)
Received: from localhost (35.pool90-77-212.dynamic.orange.es. [90.77.212.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535a14221csm30269775e9.1.2025.06.19.01.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 01:34:21 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mripard@redhat.com, mskrivan@redhat.com, Tom Rini <trini@konsulko.com>,
 eballetb@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 alexl@redhat.com, mkorpers@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/4] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
Date: Thu, 19 Jun 2025 10:34:01 +0200
Message-ID: <20250619083411.2214491-4-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619083411.2214491-1-javierm@redhat.com>
References: <20250619083411.2214491-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jb_82nYZ6SEci0DOZIHKeypIg092PQPbi50R-pyHWUQ_1750322064
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

The UEFI 2.10 specification mentions that this protocol shall be installed
along with EFI_BLOCK_IO_PROTOCOL. It provides cached partition information
for MBR and GPT partition types.

This patch just implements support for GPT partition types. The legacy MBR
partition types is only needed for backward compatibility and can be added
as a follow-up if needed, to make it fully compliant with the EFI spec.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v3:
- Add ifdef guards for {EFI,DOS}_PARTITION being disabled (Ilias Apalodimas).

 include/part_efi.h        | 20 ++++++++++++++++++++
 lib/efi_loader/efi_disk.c | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/part_efi.h b/include/part_efi.h
index 59b7895b8a23..fb402df6f13e 100644
--- a/include/part_efi.h
+++ b/include/part_efi.h
@@ -138,4 +138,24 @@ typedef struct _legacy_mbr {
 	__le16 signature;
 } __packed legacy_mbr;
 
+#define EFI_PARTITION_INFO_PROTOCOL_GUID \
+	EFI_GUID(0x8cf2f62c, 0xbc9b, 0x4821, 0x80, \
+		 0x8d, 0xec, 0x9e, 0xc4, 0x21, 0xa1, 0xa0)
+
+#define EFI_PARTITION_INFO_PROTOCOL_REVISION 0x0001000
+#define PARTITION_TYPE_OTHER 0x00
+#define PARTITION_TYPE_MBR 0x01
+#define PARTITION_TYPE_GPT 0x02
+
+struct efi_partition_info {
+	u32 revision;
+	u32 type;
+	u8 system;
+	u8 reserved[7];
+	union {
+		struct partition mbr;
+		gpt_entry gpt;
+	} info;
+} __packed;
+
 #endif	/* _DISK_PART_EFI_H */
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 47b583cc5e12..130c4db9606f 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -26,6 +26,7 @@ struct efi_system_partition efi_system_partition = {
 
 const efi_guid_t efi_block_io_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
 const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
+const efi_guid_t efi_partition_info_guid = EFI_PARTITION_INFO_PROTOCOL_GUID;
 
 /**
  * struct efi_disk_obj - EFI disk object
@@ -35,6 +36,7 @@ const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
  * @media:	block I/O media information
  * @dp:		device path to the block device
  * @volume:	simple file system protocol of the partition
+ * @info:	EFI partition info protocol interface
  */
 struct efi_disk_obj {
 	struct efi_object header;
@@ -42,6 +44,7 @@ struct efi_disk_obj {
 	struct efi_block_io_media media;
 	struct efi_device_path *dp;
 	struct efi_simple_file_system_protocol *volume;
+	struct efi_partition_info info;
 };
 
 /**
@@ -426,6 +429,7 @@ static efi_status_t efi_disk_add_dev(
 	/* Fill in object data */
 	if (part_info) {
 		struct efi_device_path *node = efi_dp_part_node(desc, part);
+		struct efi_partition_info *info = &diskobj->info;
 		struct efi_handler *handler;
 		void *protocol_interface;
 
@@ -454,18 +458,48 @@ static efi_status_t efi_disk_add_dev(
 			goto error;
 		}
 
+		info->revision = EFI_PARTITION_INFO_PROTOCOL_REVISION;
+
+		switch (desc->part_type) {
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+		case PART_TYPE_EFI:
+			info->type = PARTITION_TYPE_GPT;
+			ret = part_get_gpt_pte(desc, part, &info->info.gpt);
+			if (ret) {
+				log_debug("get PTE for part %d failed %ld\n",
+					  part, ret);
+				goto error;
+			}
+			break;
+#endif
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+		case PART_TYPE_DOS:
+			info->type = PARTITION_TYPE_MBR;
+
+			/* TODO: implement support for MBR partition types */
+			log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
+			break;
+#endif
+		default:
+			info->type = PARTITION_TYPE_OTHER;
+			break;
+		}
+
 		diskobj->dp = efi_dp_append_node(dp_parent, node);
 		efi_free_pool(node);
 		diskobj->media.last_block = part_info->size - 1;
-		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
+		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {
 			esp_guid = &efi_system_partition_guid;
+			info->system = 1;
+		}
+
 	} else {
 		diskobj->dp = efi_dp_from_part(desc, part);
 		diskobj->media.last_block = desc->lba - 1;
 	}
 
 	/*
-	 * Install the device path and the block IO protocol.
+	 * Install the device path, the block IO and partition info protocols.
 	 *
 	 * InstallMultipleProtocolInterfaces() checks if the device path is
 	 * already installed on an other handle and returns EFI_ALREADY_STARTED
@@ -476,6 +510,7 @@ static efi_status_t efi_disk_add_dev(
 					&handle,
 					&efi_guid_device_path, diskobj->dp,
 					&efi_block_io_guid, &diskobj->ops,
+					&efi_partition_info_guid, &diskobj->info,
 					/*
 					 * esp_guid must be last entry as it
 					 * can be NULL. Its interface is NULL.
-- 
2.49.0

