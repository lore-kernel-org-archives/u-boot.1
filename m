Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFF1C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766A182C55;
	Wed, 18 Jun 2025 10:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JEGSeZAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F90A82C87; Wed, 18 Jun 2025 10:09:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4040C82C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750234172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIY4/gVR7uaSQdsHulanUW93CCjHeGOD3vka8MBnU+w=;
 b=JEGSeZArBO9338HaI0ib27WsSEgIg2cn/8kmlnBTxnUA7L90VGqDQ5ivXHwfA+esiAo4v1
 w7d2KN95H6UoWkHmlWC5K9POQgd4qRR4eJ59SUgtR59YQxh9ghWnn+v7gpsVJni7MDNQ9H
 4cfDnKnEcXMU0IgDZDQMls9+gRx5BlQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-S3IVYm8WOR241h3HETK_Fg-1; Wed, 18 Jun 2025 04:09:31 -0400
X-MC-Unique: S3IVYm8WOR241h3HETK_Fg-1
X-Mimecast-MFC-AGG-ID: S3IVYm8WOR241h3HETK_Fg_1750234170
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-606f504f228so5146081a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750234170; x=1750838970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIY4/gVR7uaSQdsHulanUW93CCjHeGOD3vka8MBnU+w=;
 b=qbLNxF24hxkY02sWV0i9VPZwYfQdZxuzq83jNZssSYFot3GZaNf14LOUgB8LscUVcy
 e2YZWRaXO8IQ+rgu6sDwlc3SZllkb8bzIrV/E0Y10l/5ugHMmo4ciufhLcVBM3giQyRK
 OHjCrxzYhAWr0VMkyWrGF+fi7DfZpguAyJSgnmRPOk2xTH0i/HB6nFoicI0pwhFUyjCY
 1eG9l4TeiP3xsosA85X6TXoPp9V8yzS/atE5U+rAgdm/KLTOpYQ9f9Vp5Wnxut9PbcNM
 EZkusPdcOJVwXP6H4Y0CoNwy0qEsdY88doauf0B/UqpivOWkFMpMVqov0IWLDBxv850Z
 wtVQ==
X-Gm-Message-State: AOJu0YwGQc0sA9uRcVNRgpkdDDsdaY4Man3Sv25o7mSbaU7gPj/6CxJe
 aE8r7r4lwrP3Ls4P16MjcXRhaYorCn9r2gWOKmZ3xpSPpJ0/vAsqXwocEHJaXxpaEXIzwFvmCWK
 4sm7pokoDDJ2VIgEHtlvz6TC46qP02t66YFFMW0oHYTI9L9pHWdmceY129WDIKvQk0WUgS9kK15
 DT4ZHdOmvupLxVA/Cdnpy7hPGtKzNdR85XXnEUlQ==
X-Gm-Gg: ASbGncto28ywit1WCiNY0ySm9MMWd8SH4SOWZi6M5PM2AGcfORJToRxikN9DyxRj9i8
 S90Kg3B+gIbln8CucQGO4rZ/5lxOLHzROq6O7lhFvrQ7eQpTQFdvugXqbitvi78u7L4Sy1tXwA4
 G8ZMlaSAmfS/HUXnsLl0M0A1JoVhK6Ld9d8b1HxcGlGJSz/c1VJUGFIULSZBTpaLKN63VFEdJOv
 hkRczm7n5rRp6DXaes4hc8TtnuHHfCDHBtgvG3C1jrGN46Is1IeDDKV0hgqx8HknBodcUEeZ9UN
 EoF3tabqYYtvdrmgexhHfrXmwaG4OJU+0ZqnEjFfRksekSQ=
X-Received: by 2002:a05:6402:1d4a:b0:607:ff13:3a24 with SMTP id
 4fb4d7f45d1cf-608d0977a58mr16302749a12.28.1750234170041; 
 Wed, 18 Jun 2025 01:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPNkMpJz0CnmpCihVWk9sVFDHkGyKAuvPZ3iUeta0whdqexp6+WaKWGh4Qb8focPlvK1QfdQ==
X-Received: by 2002:a05:600c:3b83:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-4533ca94ec8mr140996205e9.7.1750233668735; 
 Wed, 18 Jun 2025 01:01:08 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm198084535e9.6.2025.06.18.01.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 01:01:08 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, mripard@redhat.com,
 Tom Rini <trini@konsulko.com>, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/4] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
Date: Wed, 18 Jun 2025 10:00:37 +0200
Message-ID: <20250618080056.1973311-4-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618080056.1973311-1-javierm@redhat.com>
References: <20250618080056.1973311-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xCzOptCMTfTRnVKQVY1jtPXzwOv3u7R6MiaMDYtTI-0_1750234170
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
---

(no changes since v1)

 include/part_efi.h        | 20 ++++++++++++++++++++
 lib/efi_loader/efi_disk.c | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

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
index 47b583cc5e12..ba41b77b9d1c 100644
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
 
@@ -454,18 +458,47 @@ static efi_status_t efi_disk_add_dev(
 			goto error;
 		}
 
+		info->revision = EFI_PARTITION_INFO_PROTOCOL_REVISION;
+
+		switch (desc->part_type) {
+		case PART_TYPE_EFI:
+			info->type = PARTITION_TYPE_GPT;
+			ret = part_get_gpt_pte(desc, part, &info->info.gpt);
+			if (ret) {
+				log_debug("get PTE for part %d failed %ld\n",
+					  part, ret);
+				goto error;
+			}
+
+			break;
+		case PART_TYPE_DOS:
+			info->type = PARTITION_TYPE_MBR;
+
+			/* TODO: implement support for MBR partition types */
+			log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
+
+			break;
+		default:
+			info->type = PARTITION_TYPE_OTHER;
+
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
@@ -476,6 +509,7 @@ static efi_status_t efi_disk_add_dev(
 					&handle,
 					&efi_guid_device_path, diskobj->dp,
 					&efi_block_io_guid, &diskobj->ops,
+					&efi_partition_info_guid, &diskobj->info,
 					/*
 					 * esp_guid must be last entry as it
 					 * can be NULL. Its interface is NULL.
-- 
2.49.0

