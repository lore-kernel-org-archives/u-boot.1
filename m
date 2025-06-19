Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCFEC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 08:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE2982D34;
	Thu, 19 Jun 2025 10:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aUc7NbUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C058882B18; Thu, 19 Jun 2025 10:34:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE6F82BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750322068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUikEwSyK0zfVH05waXd9Df2jcIf665Zts7hBf/9zeA=;
 b=aUc7NbUAlY68Rnlz+mPB8MXIpYSrGILG/WEKveoDgsTofAzqI1zaQD4H8hzC2nypu/kN02
 n5NsBkIwrBWXvDAlIAMuXtcKBtFEn+TzXXooXqLsEOu+EbmkDpt5jfgrPuYzrA6VL5C7az
 iNIjGlXNwIkkipr4d+1yysyyT2+n0/Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-zlYFb4_7MYGBL8gqdTbcFQ-1; Thu, 19 Jun 2025 04:34:27 -0400
X-MC-Unique: zlYFb4_7MYGBL8gqdTbcFQ-1
X-Mimecast-MFC-AGG-ID: zlYFb4_7MYGBL8gqdTbcFQ_1750322066
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so383918f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 01:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750322065; x=1750926865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUikEwSyK0zfVH05waXd9Df2jcIf665Zts7hBf/9zeA=;
 b=D+5T/o1njgZt2cny05ih/OUhYNcr+jsIyHJPjmIgJaxmIMfJdkzdXU9ZMQH4JEqPeY
 I8koaKweYsITZ8pQ6vrO4qh2WhMdV+MnmGq6CEHUcRlG+ryyHet3xDbgYqfDS6hPeYis
 CW/4mv0yaPzHAr/2mqsFUAOXlKe7stsgk/zALKVwv9RPQ50rOHWtVHf36Y2KD4ETX17B
 6Z6zcffRTQyprKiKzQB8p2EcqGPFGy2t1vXBLcW2vCI2FisGAVcfyPKO16O+baf/pbMC
 WRi9SLU2Bi/0cG4UZPbGO4aoAbq1812Gy3q1Z/cKkW614o35wqgrlIEpR1qXf3KtfQQc
 A1Ww==
X-Gm-Message-State: AOJu0Yx1v6zjz3e8OrS9XhgF6Cmica2uaOlyK301gRCkswfW5M9kRLMc
 KCztf7B2HSDpLF7LbDDL6P/qNAyn6bZ4ZQjT4ENzchaHzmE5mBPgCt4/iCmG+aumdbr4ENdYCS0
 8LE08mNufotdMJBGG5dIcVfNZmRzCX5IDQdX7E0yTzVKnHSmcwO8MEuoMN5nVupS+7ADOi6t+qB
 3VO/umoOKV9ExS2SEOY5kDM5lLn6K8oF6Rf7gRDw==
X-Gm-Gg: ASbGnctV5f/nHAg8U0hepmQXrC8ZWCshv/LwqntEXST7L0AgD3E+tXKdFoTvKKyaH8t
 rLtQTggAezuGzjwuxVjqpaqQDwho9zLJE8WgNJ02G4NwgImiPBwurADygkuX9oSAU4yciTMvsJ3
 Q1+2TTOMiK4gtwp2d8zAcLegfiNjkH8u+Dg2RLdfFfOUm2QTygKtMQKTuy0Jk3r3D05d2RFnNat
 /3MC6Yx9PFKSsTCARhElvxDu4BmzcGv20rkSE0db/k1WDTB9Lm+k6370bVm+Nd3j5/YvQ8B5nf8
 7TJ/87hUN3kwjcw/L85fCpduW4fBrJqcsvywNAH7qzPPQ+FKqA9K
X-Received: by 2002:a5d:5c84:0:b0:3a5:3e64:1ac4 with SMTP id
 ffacd0b85a97d-3a5723a2742mr17383832f8f.33.1750322065288; 
 Thu, 19 Jun 2025 01:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEox3CQuYxcg2cjwyQSz01T4tm1RqnFVBG5ag8X0tHKveMSNQdVL3VFOzdR7dl92ZIoJLc+OA==
X-Received: by 2002:a5d:5c84:0:b0:3a5:3e64:1ac4 with SMTP id
 ffacd0b85a97d-3a5723a2742mr17383794f8f.33.1750322064773; 
 Thu, 19 Jun 2025 01:34:24 -0700 (PDT)
Received: from localhost (35.pool90-77-212.dynamic.orange.es. [90.77.212.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97abf6sm21123155e9.6.2025.06.19.01.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 01:34:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mripard@redhat.com, mskrivan@redhat.com, Tom Rini <trini@konsulko.com>,
 eballetb@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 alexl@redhat.com, mkorpers@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 4/4] efi_selftest: Add basic partition info check to block
 io test
Date: Thu, 19 Jun 2025 10:34:02 +0200
Message-ID: <20250619083411.2214491-5-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619083411.2214491-1-javierm@redhat.com>
References: <20250619083411.2214491-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HQw2WImZMURhw6yTcE_-Ozg2KEv66AwQRJfaPJZoPTY_1750322066
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

Test the EFI_PARTITION_INFO_PROTOCOL in the existing EFI_BLOCK_IO_PROTOCOL
unit test. It is fairly basic, since it only checks that the values of the
struct efi_partition_info .revision, .type and .system fields are correct.

It doesn't check the MBR partition record information, because that's not
supported by the EFI_PARTITION_INFO_PROTOCOL implementation yet. The test
can be extended once the support is implemented, or if the in-memory disk
image used for the test is modified to have a GPT partition type instead.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v3:
- Fix build in -next due missing part_efi.h header include (Ilias Apalodimas).
- Rebase on top of -next (Ilias Apalodimas).

Changes in v2:
- Add a test for the EFI partition information protocol (Tom Rini).

 lib/efi_selftest/efi_selftest_block_device.c | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index a367e8b89d17..f145e58a267a 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -18,6 +18,7 @@
 #include <efi_selftest.h>
 #include "efi_selftest_disk_image.h"
 #include <asm/cache.h>
+#include <part_efi.h>
 
 /* Block size of compressed disk image */
 #define COMPRESSED_DISK_IMAGE_BLOCK_SIZE 8
@@ -29,6 +30,7 @@ static struct efi_boot_services *boottime;
 
 static const efi_guid_t block_io_protocol_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
 static const efi_guid_t guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
+static const efi_guid_t partition_info_guid = EFI_PARTITION_INFO_PROTOCOL_GUID;
 static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t guid_file_system_info = EFI_FILE_SYSTEM_INFO_GUID;
@@ -310,6 +312,7 @@ static int execute(void)
 		struct efi_file_system_info info;
 		u16 label[12];
 	} system_info;
+	struct efi_partition_info *part_info;
 	efi_uintn_t buf_size;
 	char buf[16] __aligned(ARCH_DMA_MINALIGN);
 	u32 part1_size;
@@ -375,6 +378,33 @@ static int execute(void)
 			     part1_size - 1);
 		return EFI_ST_FAILURE;
 	}
+
+	/* Open the partition information protocol  */
+	ret = boottime->open_protocol(handle_partition,
+				      &partition_info_guid,
+				      (void **)&part_info, NULL, NULL,
+				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to open partition information protocol\n");
+		return EFI_ST_FAILURE;
+	}
+	/* Check that cached partition information is the expected */
+	if (part_info->revision != EFI_PARTITION_INFO_PROTOCOL_REVISION) {
+		efi_st_error("Partition info revision %x, expected %x\n",
+			     part_info->revision, EFI_PARTITION_INFO_PROTOCOL_REVISION);
+		return EFI_ST_FAILURE;
+	}
+	if (part_info->type != PARTITION_TYPE_MBR) {
+		efi_st_error("Partition info type %x, expected %x\n",
+			     part_info->type, PARTITION_TYPE_MBR);
+		return EFI_ST_FAILURE;
+	}
+	if (part_info->system != 0) {
+		efi_st_error("Partition info system %x, expected 0\n",
+			     part_info->system);
+		return EFI_ST_FAILURE;
+	}
+
 	/* Open the simple file system protocol */
 	ret = boottime->open_protocol(handle_partition,
 				      &guid_simple_file_system_protocol,
-- 
2.49.0

