Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8136C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94EE82CF4;
	Wed, 18 Jun 2025 10:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d9hYuwYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEA582B20; Wed, 18 Jun 2025 10:01:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E2082D06
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750233673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1PbqzhLLUsFfxOg2D1/PMpDFuFCQXeIpyOH2A/8wko=;
 b=d9hYuwYSg0596nX+c9vZCTpouTnWiWwiNAojXKPuk44bQGb1zZi61yjMzWblAatKBie21L
 B9NQfJfkSEdh4SkKMTrJQDRrFt7XE+Ehg4LbBSwAQJc61QPvd1lvD36o7YM69ZkXMtzXT7
 grDdnYX1PB29F4+PFReG4JJ+ZWRGKpU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-BpX9oOEOMaazOINWCdfwyA-1; Wed, 18 Jun 2025 04:01:12 -0400
X-MC-Unique: BpX9oOEOMaazOINWCdfwyA-1
X-Mimecast-MFC-AGG-ID: BpX9oOEOMaazOINWCdfwyA_1750233671
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so54630545e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750233671; x=1750838471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1PbqzhLLUsFfxOg2D1/PMpDFuFCQXeIpyOH2A/8wko=;
 b=ZpIJ4AvBe+tlY1Wekd2oaeSeqZPCEx2FvgHyisuaA/XMZyMUS+dYKK7zwSMJcaawot
 6ozCHQqgBGlRzQEdECNaVLBcW1oW6V5fO/ofMSva1QoY0N2Fp61MZLTwHLz6++CMrCbo
 IGOlIcDRiS8EmSOJ5olf7W2rMJ1c1chh7nW9/AxlaCbg5gq1+vphd9RdOk6BVBQ8VdGG
 D+fRIeLO3XjmXToZC6ray0k5PG75FIS3NSe9YaV68aqXw0mJi4oeDLr4wrB+W9llrk0f
 4BmMUSRCkWnoz4J9/cVg6utgkphAfTSzIMrQFBTwXHtKTR2Y50sBrg9ndWTiQkbiLNF2
 gLlw==
X-Gm-Message-State: AOJu0YwSJEHBeiFnzw+vuqbWPVty3hyhEGqkXyEpaQNImyI6aLUjNKg2
 cRvABQv50SFM48mkEf8DFm3DACHtemK8GQ37yjv3LT1ifWogq7aE5t7O9/pAU7Ci5q5nb0GHU2+
 mlHBe7NHzTBrB7+VQZ8DnB6f1XyqkvEOi7sOW5qYNaYFiCEH1LEiy4H4rq1ROCm8b6hRK/8EwUA
 B3eIQZknIfJNlKztw49JKSf+1KmalGxKM0s30WRA==
X-Gm-Gg: ASbGncsVI3XKJGRUdj8TRyg2e7VPyhmeBP1O1l/7WIzvlrtEZgnFmtyTyhh+MvWQY0M
 xZs2x/29ZHoOC1YgBAUE6a7CFyHMPXBmYEZihqUUzi0M6J8C9qsfZKjbYQ8eTGhU1yj5WTC1gnF
 0CrEox5gZMPhz98tP/mLDdd1iPqtepwRosIjDQJa0VqZpCYPky4ucIikvznWDKK0btZMidcUMBN
 qoV3qHnCeLOJz1tCropGbpk9WyketkTXaMMaDUsjbhvEOin6W7P00+uer233jVYGulhbmeUbZ1k
 9i4amxGk5CjTNPyz/+z61lnXZSWXu6ChuoNbDv+foy6txX8=
X-Received: by 2002:a05:600c:1f8e:b0:453:aca:4d05 with SMTP id
 5b1f17b1804b1-4533cadfd75mr170351345e9.31.1750233671117; 
 Wed, 18 Jun 2025 01:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjtKPnpMgYaU5EiC1/uLSlhliuPNZ6WdfPCknrVL103JSJzLhMkUpy7r0ueWGLT9rZy9dPbA==
X-Received: by 2002:a05:600c:1f8e:b0:453:aca:4d05 with SMTP id
 5b1f17b1804b1-4533cadfd75mr170350635e9.31.1750233670529; 
 Wed, 18 Jun 2025 01:01:10 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a633ddsm16035693f8f.26.2025.06.18.01.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 01:01:09 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, mripard@redhat.com,
 Tom Rini <trini@konsulko.com>, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 4/4] efi_selftest: Add basic partition info check to block
 io test
Date: Wed, 18 Jun 2025 10:00:38 +0200
Message-ID: <20250618080056.1973311-5-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618080056.1973311-1-javierm@redhat.com>
References: <20250618080056.1973311-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FxOe_HqfOSWg2uGcLbhbN8UMv0A04nJHQfrkCO2wAHU_1750233671
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
---

Changes in v2:
- Add a test for the EFI partition information protocol (Tom Rini).

 lib/efi_selftest/efi_selftest_block_device.c | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index a367e8b89d17..0ee909da87d6 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -29,6 +29,7 @@ static struct efi_boot_services *boottime;
 
 static const efi_guid_t block_io_protocol_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
 static const efi_guid_t guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
+static const efi_guid_t partition_info_guid = EFI_PARTITION_INFO_PROTOCOL_GUID;
 static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t guid_file_system_info = EFI_FILE_SYSTEM_INFO_GUID;
@@ -310,6 +311,7 @@ static int execute(void)
 		struct efi_file_system_info info;
 		u16 label[12];
 	} system_info;
+	struct efi_partition_info *part_info;
 	efi_uintn_t buf_size;
 	char buf[16] __aligned(ARCH_DMA_MINALIGN);
 	u32 part1_size;
@@ -375,6 +377,33 @@ static int execute(void)
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

