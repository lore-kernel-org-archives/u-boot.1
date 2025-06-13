Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2373C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 08:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8162F82CB8;
	Fri, 13 Jun 2025 10:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IAsWP03r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7C682C2F; Fri, 13 Jun 2025 10:58:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD2882CB6
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749805114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jaf7fZBSABjQ16VSVa3Db4hPzz06RbEdGx5i+ycAlc=;
 b=IAsWP03rB5kyNzU2EcgJIzRTEQglx76HuXZUpmkxwVUflihKmOolyS7J/GVtkbkgMBda+M
 hzezMyPQfWke0ZIm7vA2DxW9sbAkxNa19sey5JGbflLLnwglDmaGjX5olJ7uEQviTYCYx+
 IN6TNoeG13IHHw7BH3ULeeDmKIM55mo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-QcoqjBLpM7qX52dQ8Xk6nQ-1; Fri, 13 Jun 2025 04:58:33 -0400
X-MC-Unique: QcoqjBLpM7qX52dQ8Xk6nQ-1
X-Mimecast-MFC-AGG-ID: QcoqjBLpM7qX52dQ8Xk6nQ_1749805112
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451deff247cso16666035e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 01:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749805111; x=1750409911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jaf7fZBSABjQ16VSVa3Db4hPzz06RbEdGx5i+ycAlc=;
 b=SGOGFlRyqmceqF+ISB7kXNiOjbBALP7yUgrE/GUO0VdeVk8Ml+o9LIy1zSFp8JKx8+
 Q+PqULJLGwV1/7sPPsAw6oK/fhInTmZCBlC1RUm3Fw4TrSD0+R9ql+/lfyFFOTzMuOLF
 5cIBfEwSQ2mre635FyHM54JEKuKjepZ4vx6Mjc3GFnk1kipL9C2kCgbmw0Q/HjK+zQ3N
 GMPuzDbzA4nVYrVd5VesxqQ9wNP0+jEmqdawU9uep7S4xl07hIJUwu0jyRR+3bM8ziZ0
 hlrrXOmRG0NQvn+RILM/tuOxOjh0gG4YYyzKiTYtyrVDNMTLmCvRlhlZBb7Ru3m4xFgA
 EDxw==
X-Gm-Message-State: AOJu0Yya4wuqgm1yYcGX2Y6h6vhAwU6eJLZ69LBBSnG3UbGoUiRTy+wn
 J3Sxp1RxaEDYZWBO1S+kHX+Ue/Nyz5EEPgClPx/wgR7nZif8d07C9X54w4ym16Sr60SdoUs3qcP
 2Lbf991rQZSwhb14k9hidzRQZapu5ySvvHUN25J80dtwLdGlDyt1PdQRfxLdTAYUPXCdsH/h/jR
 w631tTW5cIKQnY1obFusfogzXr8qQoAprdPAiyOQ==
X-Gm-Gg: ASbGnctbHQS57jAk4lfi+Qfrj4V+WiJy+clFYRslaV7fJtnAyNfievVQun9wn5eKxt8
 /V6vd+b2EK5IAVGr1HMTOidAKvnfpz7QpUN63KwpdHp0GYg21T+ukOa+92bHmPDD2nA1a/j/bSX
 C2xYBMXvcMjydv8XXXdhl1DpQNojLknu59STIkn5kHZKnilJSmhQp/ssEbfjCuV3t1qhrvqtIpo
 5opRHYQQjUiVeHpNGxRVprjME7UJ0gO1fj/FVP8YK6Y3KXlt+VtTDT5HirXBobF8NXX514MUu6i
 7QBqV41AyN9AZytoo/J0gBP/Mer0oAsH6sl84ajngPKL+9g=
X-Received: by 2002:a05:600d:105:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-453372a494amr10040725e9.14.1749805111052; 
 Fri, 13 Jun 2025 01:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHclh+Jp+Kg7dMbo72E9csLwxpql+Ph1eDIs+jDTV1VAP1n8+WOcAac3SjX1A5R/B3H9OgkdQ==
X-Received: by 2002:a05:600d:105:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-453372a494amr10040435e9.14.1749805110609; 
 Fri, 13 Jun 2025 01:58:30 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4531fe8526bsm63807375e9.0.2025.06.13.01.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 01:58:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
Date: Fri, 13 Jun 2025 10:57:38 +0200
Message-ID: <20250613085742.796015-4-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613085742.796015-1-javierm@redhat.com>
References: <20250613085742.796015-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ul1BZCTDJ6rNQ3AVj4-SLiqxARsm3TxksAt4qwFBExs_1749805112
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

