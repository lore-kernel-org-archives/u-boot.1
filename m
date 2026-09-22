Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B3C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40C9540DA1;
	Tue, 22 Sep 2026 14:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZVOkFtuRnCb4; Tue, 22 Sep 2026 14:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 730A140DC3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089134;
	b=DqYXH934fbXdsszXmR3ac2tbBc/5+QUduGpcgH/DDOmDrI5dRtMtr3tOfBcQ70Ky10Yf
	 5PH0Hz51CU4hPYlfSoJ7DpTvv1ERCrSLM7iiuKSbEfTFDYZcH2J/xgwBt6W+VV/RpuXSK
	 fYCszpRJa7WMlrjt1THYdzVNGWdfZqjCUHGzrV1F+I1zgMenxPijNWxWQNkR6lgsKU8+U
	 BLYKaOSO61fdbUXIur0sgaMJKWPMa4r3DmF3+QQ8JOAJYisnTukv1IUutWQFX+MippCnw
	 mHGoE0IbO3oWf8NcIJDNgF2S1u2xR8rjyPCJrLzGp8RxM5sg0+qf/BUQX2AdkRAfStA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790089134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4k5cUyOfjEL+HB0YEfe7wV42mHfaDRgzHZf65TXNtdk=;
	b=Yy4EV8EQWu4jAmmQtj/b3BSMvWnYeGZl4Qx8xrOhrBUPMMHLXb6VGbC+TXuEfxXHXR66
	 4y89ANWUQXW3kx11XML/Pc3Pfvq2hWmDoNYUySjCKcaoOaUk5Jaw66AtzwBHnALH5T1Bi
	 yp7YMvbv21vk9WROVhT9bFxSvWDwnuwGmd4C/0oJLDfzT2baIs6KHnXqRvjUdpM2G0Ch4
	 xVioRVc3jPuTqfsioQbRmpXJCR4If0NXQcJcJt8QoLExVogG7QwVw3RsGt0P8q4pc9Lx+
	 fFOFeRQnSXhWrBV/QHLBQiWTK/+Jm0BWTub7VtSdBt6Z9CJWifEpzjvFSIWfJSikByw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790089134;
	bh=4k5cUyOfjEL+HB0YEfe7wV42mHfaDRgzHZf65TXNtdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RCC7K7opsuyVc1AI3ngLcSVMK5TtwrAP1JKhvIv06kY5EofaycboQzBGRFLEtVgm7
	 Ygx9Zgzo9Xpl2ZFwuRhdtADUKXxc94sOsAoQLsVtNy5beUFcFmUMFXzrjjLFMp7+u9
	 LEWQWpZf9sZe3jlv4eZVwhSNSzik+u06xQFkXG5BspM5qDtphuRRI3J5TxNXvCP6zJ
	 yrJuXxBwB/bLOg6RatTa0ax/b4GdGo9OziNBCU3Ghz1UCEy9E3CTSEK1nj/6k/M9qe
	 28zucRnqlMoGP64MXN68Jz2rqut6BBaMinDrOJOdWRYsQFwsaXG4x/gFp3GOCd2nDx
	 luT5jcQmKH59w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 730A140DC3;
	Tue, 22 Sep 2026 14:58:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFF9935A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C54A9402CA
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEaG1Pkhqbkf for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:58:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BD2BF402DD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790089129;
 b=Orf/RAagET9RiaLeDK8YI0VaVs3zV9bmbZWGz56VfKyLdRlNDu1fUFyY8azqjFERynTV
 nnJlL2tPxOzk6BfMoEuSlRGdBe2/O6FbATVl7BbgphMEicwYI51fIfA2I/LfEYfy3DdVu
 ab0xUDrWbwDil/LMFVa/BX4i6/QADTWs22CFCkM/3SMx/fhxihSix6aQ7JXfwZAvcXgYZ
 5xYgjwT2nNIRwKCDJxUJ2fl5f6xuyG4VsZy9seSEAufoIfpYemplz154+2OAqO13qRWpW
 1Q4+BN9uRIz8buK1D336j3ZMrTmBAGOfA2Z7aZQokcDIGZ/SYXTMptdU0V8sp61JzXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089129;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=4k5cUyOfjEL+HB0YEfe7wV42mHfaDRgzHZf65TXNtdk=;
 b=DhyHFrcT//yeiilp9qBkLIlbwpvXEQrlSiXpHvJCDAglybhK2kv16EDosjXHdagAOUvc
 q9vIRBBAGsQKb5YneBuuQQMy7e4yqpFKLdqiQgUBEZ0GL2HonWGLwxxPP8PV7ho50asln
 Yb/i6jvrm+vSAS+zLARCYQn0vfPFbCCt76Xa8IH/6e/4iJVPY75V3Tkv5WREwTdg2VRvE
 lBhqwXwjvscEQNcJRkhirildEIWrP8uY9DTdMykTGvBVDa7uCQcpykWYmG8fV3R6Mc17t
 5/leYkYdhwAtDGZGrKUc7pojYEd6dMgiukvXXufamRZx5lFkau0T9rvJMfnnv/a0eiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=lQfHzHps; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=lQfHzHps
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD2BF402DD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3051BC0;
 Tue, 22 Sep 2026 07:58:42 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D1A3F632;
 Tue, 22 Sep 2026 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790089126; bh=hx7LkZB8d/wd8o7R5H1ELb60Z/0yN48ZkScLeO7YV2A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lQfHzHps+O5jQx6d9Rb/4aVYTp+cie2WBfC5VT/zFwIDVvFWVgJ0ocMxddILqe0Br
 RXQf3UYMl3IZUHEnNbdlOvh/8RI/WmdYoBuvc8ZtWgjqP7pepR/0pP9uY3R1yDgPBV
 324N9y4dhWlZMKrKpyqgp4t81f4bWgHgW3/oJNmM=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 22 Sep 2026 16:58:41 +0200
Subject: [PATCH 2/2] efi_selftest: add minimal fmp test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-authi-v1-2-e943530349bb@arm.com>
References: <20260922-authi-v1-0-e943530349bb@arm.com>
In-Reply-To: <20260922-authi-v1-0-e943530349bb@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5326;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=hx7LkZB8d/wd8o7R5H1ELb60Z/0yN48ZkScLeO7YV2A=;
 b=owGbwMvMwMV42vNHWNlitimMp9WSGLI2TV/4690MmQ1TDaVd1wc8+KMVwlIgIlp7fcMh/bpS/
 7aZHE1BnYzGLAyMXAyyYoos1xNEFvRFBQgWVGjlwAxiZQKZwsDFKQATSZrGwbDA9Ywgj8mFB9LN
 nPEGHab7f5ZbnDj8/lmwZqd+eTfT/v6PkzSfTV5cfzhGcGpPcsrFU8df2jsdnat82F7EtPS8M4/
 VYx2VKgcOhci6Qq2QpC/xK4TeV7zrWLiUky3+tXVNymV1vs63HLyRq6qnGYT2uGxrZuyOLK0+96
 GOL8k4/O/MfesK/j+R9n6X9/rmgqQ1UarZe/ti77zWEpLxze/7HxPh6//8h9yXQ/dEf06TDPOcl
 VtjHcp1bhIT1+knXTN/T8wRmF1wPfBqZa7Bz3IPPe81bUw6Urd2PVMz7p6q84KfySSxQFyhuNBX
 +MLZg9/sPX5/8RaLZLjGX8SU8/n4/U2BaakzGdKq998EAA==
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a minimal test for the UEFI Firmware Management Protocol.
At this point the test only does the following:

- Get current firmware images info.
- For each image, verify consistency of the authentication flags.

This can be tested on the sandbox with the following command:

  ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
                  bootefi selftest"

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_selftest/Makefile           |   2 +
 lib/efi_selftest/efi_selftest_fmp.c | 135 ++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 67102648703..9882d9f2748 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -80,6 +80,8 @@ obj-$(CONFIG_EFI_ESRT) += efi_selftest_esrt.o
 
 obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_selftest_debug_support.o
 
+obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) += efi_selftest_fmp.o
+
 targets += \
 efi_miniapp_file_image_exception.h \
 efi_miniapp_file_image_exit.h \
diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_selftest_fmp.c
new file mode 100644
index 00000000000..c17cf59a237
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_fmp.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test Firmware Management Protocol support.
+ *
+ * Copyright (C) 2026 Arm Ltd.
+ */
+#include <efi_selftest.h>
+
+static const efi_guid_t firmware_management_protocol_guid =
+	EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID;
+
+static struct efi_boot_services *boottime;
+static struct efi_firmware_management_protocol *fmp;
+
+/**
+ * setup() - Setup unit test.
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ *
+ * Keep Boot Services and locate firmware management protocol.
+ *
+ * Return:	EFI_ST_SUCCESS for success, EFI_ST_FAILURE in case of error.
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	efi_status_t ret;
+
+	boottime = systable->boottime;
+
+	ret = boottime->locate_protocol(&firmware_management_protocol_guid,
+					NULL, (void **)&fmp);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Firmware management protocol not available.\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * execute() - Perform the test.
+ *
+ * Call GetImageInfo() to retrieve current firmware images descriptors.
+ * For each descriptor, verify image authentication consistency.
+ *
+ * Return:	EFI_ST_SUCCESS for success, EFI_ST_FAILURE in case of error.
+ */
+static int execute(void)
+{
+	efi_status_t ret;
+	efi_uintn_t img_info_size, desc_size;
+	struct efi_firmware_image_descriptor *img_info = NULL;
+	u32 desc_ver, pkg_ver;
+	u8 desc_cnt;
+	u16 *pkg_ver_name;
+	int i, result = EFI_ST_FAILURE;
+
+	/* Determine buffer size */
+	img_info_size = 0;
+	ret = fmp->get_image_info(fmp, &img_info_size, NULL, NULL, NULL, NULL,
+				  NULL, NULL);
+	if (ret != EFI_BUFFER_TOO_SMALL) {
+		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
+		goto out;
+	}
+
+	/* Allocate enough memory for image info */
+	ret = boottime->allocate_pool(EFI_LOADER_DATA, img_info_size,
+				      (void **)&img_info);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("AllocatePool returned %u\n", (unsigned int)ret);
+		goto out;
+	}
+
+	ret = fmp->get_image_info(fmp, &img_info_size, img_info, &desc_ver,
+				  &desc_cnt, &desc_size, &pkg_ver,
+				  &pkg_ver_name);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
+		goto out;
+	}
+
+	if (desc_ver != EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
+		efi_st_error("Bad DescriptorVersion %u\n", desc_ver);
+		goto out;
+	}
+
+	/* Verify each image info */
+	for (i = 0; i < desc_cnt; i++) {
+		const struct efi_firmware_image_descriptor *inf = &img_info[i];
+		u64 attr_supp = inf->attributes_supported,
+		    attr_set = inf->attributes_setting;
+
+		efi_st_printf("  image %u: %ps\n", inf->image_index, inf->image_id_name);
+
+		/* Verify authentication */
+		if (CONFIG_IS_ENABLED(EFI_CAPSULE_AUTHENTICATE) &&
+		    (attr_supp & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
+		    !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
+			efi_st_error("Bad AttributesSupported %u\n",
+				     (unsigned int)attr_supp);
+			goto out;
+		}
+
+		if (CONFIG_IS_ENABLED(EFI_CAPSULE_AUTHENTICATE) &&
+		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
+		    !(attr_set & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
+			efi_st_error("Bad AttributesSetting %u\n",
+				     (unsigned int)attr_set);
+			goto out;
+		}
+	}
+
+	result = EFI_ST_SUCCESS;
+
+out:
+	if (img_info) {
+		ret = boottime->free_pool(img_info);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("FreePool returned %u\n",
+				     (unsigned int)ret);
+			result = EFI_ST_FAILURE;
+		}
+	}
+
+	return result;
+}
+
+EFI_UNIT_TEST(fmp) = {
+	.name = "firmware management protocol",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+};

-- 
2.53.0

