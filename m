Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F76C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D2D87B75;
	Fri, 29 Dec 2023 18:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J6ceCWeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361DC87B72; Fri, 29 Dec 2023 18:43:13 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB7AA87B6F
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78117e97becso456617285a.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871789; x=1704476589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3QKX+hsO1keqPSvEgKZESA1E7BFJOuFIbNmi2CdDnA=;
 b=J6ceCWeEwvK07h7aA5Ap2wrCsgGJVO6TVQbE+6ZpbRi8P1F+HN16XwgkYSRwGOexzt
 4E3mXsuY7NqDAr2uM3fWr+wnMry8w2F6dlRfdmedKXxslwuOk6XYuqCsRHn32lX6tuJq
 9bOABoNco0UNbcffnxQjmG+eOxYBYmRp+UfPkN1ibDGnzy6x+Sl+ESaTK7dR6rk4kOOZ
 1lYwbNrnwqQ9pxVVoUM4SuBBPbs77+LVIZgdAxAFRIb0fIFg4WsMpnZiisxYr8E4oAq/
 jUNnK7FT+PYIONOyDIglEhs2PWC/FH2pIT/VkAR9FQ1i6T/wKS22NNqIBdmuxjg1G3os
 6xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871789; x=1704476589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3QKX+hsO1keqPSvEgKZESA1E7BFJOuFIbNmi2CdDnA=;
 b=W/+HcTOAHmlKcjP6h2iNx8/G49njB6UHY+JHwYxyipzpdgqSgnrkJy6CQS9XR9j+2O
 NNM4m4Pi/Bc19+PNlRZUmugiG/F5Ceomaj1I5odNLXA2ZIP/uWw8M6Ds5p3I9ZoprUPL
 ZEg4nnHo+PHPBPdc903/j8NQ71TqT/7TBIHgUNbsXkexRCZXrPT5o4eOj5cEJSNjr875
 L3f7Vt8aVvUoNLeEjoJ1+gxoQL+KejWXBUal1zwFfPCFHa1+hxq0byqxtv/ux/JeDhE2
 1ShdVikji0HMbMtUJcq1cKHvSluFAGXblg/r0C5fNWcbz+UaojqsWJt5QBs3LpSYM6cD
 C5LA==
X-Gm-Message-State: AOJu0YyM5gk8U1TLEKzRpCawBWO7jIHu8dM0Azh8Ntbx4PiEEU0U3dYM
 K9gHzwG0fgEUE2xM2jizpD+DAhihXMee/wjFaJndWPaukKw=
X-Google-Smtp-Source: AGHT+IEkYgJRQtho4HAE7HBzvch8iO64xdDLejAAeSYPHmma4hPJMnTFi5tatodwqiNbAPOySQy29w==
X-Received: by 2002:a05:620a:55b0:b0:781:753d:cc70 with SMTP id
 vr16-20020a05620a55b000b00781753dcc70mr2269820qkn.73.1703871789287; 
 Fri, 29 Dec 2023 09:43:09 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:08 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 01/11] bloblist: Update the tag numbering
Date: Fri, 29 Dec 2023 09:42:33 -0800
Message-Id: <20231229174244.892818-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229174244.892818-1-raymond.mao@linaro.org>
References: <20231229174244.892818-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Simon Glass <sjg@chromium.org>

Align bloblist tags with the FW handoff spec v0.9.
The most common ones are from 0.
TF related ones are from 0x100.
All non-standard ones from 0xfff000.

Added new defined tags:
BLOBLISTT_OPTEE_PAGABLE_PART for TF.
BLOBLISTT_TPM_EVLOG and BLOBLISTT_TPM_CRB_BASE for TPM.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Align bloblist tags to FW handoff spec v0.9.
Changes in v3
- Add TPM related tags

 common/bloblist.c  | 18 ++++++++++---
 include/bloblist.h | 67 +++++++++++++++++++++++++---------------------
 test/bloblist.c    |  4 +--
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index a22f6c12b0..5606487f5b 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -36,16 +36,26 @@ static struct tag_name {
 	enum bloblist_tag_t tag;
 	const char *name;
 } tag_name[] = {
-	{ BLOBLISTT_NONE, "(none)" },
+	{ BLOBLISTT_VOID, "(void)" },
 
 	/* BLOBLISTT_AREA_FIRMWARE_TOP */
+	{ BLOBLISTT_CONTROL_FDT, "Control FDT" },
+	{ BLOBLISTT_HOB_BLOCK, "HOB block" },
+	{ BLOBLISTT_HOB_LIST, "HOB list" },
+	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
+	{ BLOBLISTT_TPM_EVLOG, "TPM event log defined by TCG EFI" },
+	{ BLOBLISTT_TPM_CRB_BASE, "TPM Command Response Buffer address" },
 
 	/* BLOBLISTT_AREA_FIRMWARE */
-	{ BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
-	{ BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
 	{ BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
 	{ BLOBLISTT_TCPA_LOG, "TPM log space" },
-	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
+	{ BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
+
+	/* BLOBLISTT_AREA_TF */
+	{ BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
+
+	/* BLOBLISTT_AREA_OTHER */
+	{ BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
 	{ BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
 	{ BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 080cc46a12..92dbfda21b 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -81,7 +81,7 @@ enum {
 
 /* Supported tags - add new ones to tag_name in bloblist.c */
 enum bloblist_tag_t {
-	BLOBLISTT_NONE = 0,
+	BLOBLISTT_VOID = 0,
 
 	/*
 	 * Standard area to allocate blobs used across firmware components, for
@@ -89,42 +89,36 @@ enum bloblist_tag_t {
 	 * projects.
 	 */
 	BLOBLISTT_AREA_FIRMWARE_TOP = 0x1,
+	/*
+	 * Devicetree for use by firmware. On some platforms this is passed to
+	 * the OS also
+	 */
+	BLOBLISTT_CONTROL_FDT = 1,
+	BLOBLISTT_HOB_BLOCK = 2,
+	BLOBLISTT_HOB_LIST = 3,
+	BLOBLISTT_ACPI_TABLES = 4,
+	BLOBLISTT_TPM_EVLOG = 5,
+	BLOBLISTT_TPM_CRB_BASE = 6,
 
 	/* Standard area to allocate blobs used across firmware components */
-	BLOBLISTT_AREA_FIRMWARE = 0x100,
+	BLOBLISTT_AREA_FIRMWARE = 0x10,
+	BLOBLISTT_TPM2_TCG_LOG = 0x10,	/* TPM v2 log space */
+	BLOBLISTT_TCPA_LOG = 0x11,	/* TPM log space */
 	/*
 	 * Advanced Configuration and Power Interface Global Non-Volatile
 	 * Sleeping table. This forms part of the ACPI tables passed to Linux.
 	 */
-	BLOBLISTT_ACPI_GNVS = 0x100,
-	BLOBLISTT_INTEL_VBT = 0x101,	/* Intel Video-BIOS table */
-	BLOBLISTT_TPM2_TCG_LOG = 0x102,	/* TPM v2 log space */
-	BLOBLISTT_TCPA_LOG = 0x103,	/* TPM log space */
-	BLOBLISTT_ACPI_TABLES = 0x104,	/* ACPI tables for x86 */
-	BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
-	BLOBLISTT_VBOOT_CTX = 0x106,	/* Chromium OS verified boot context */
+	BLOBLISTT_ACPI_GNVS = 0x12,
 
-	/*
-	 * Project-specific tags are permitted here. Projects can be open source
-	 * or not, but the format of the data must be fuily documented in an
-	 * open source project, including all fields, bits, etc. Naming should
-	 * be: BLOBLISTT_<project>_<purpose_here>
-	 */
-	BLOBLISTT_PROJECT_AREA = 0x8000,
-	BLOBLISTT_U_BOOT_SPL_HANDOFF = 0x8000, /* Hand-off info from SPL */
-	BLOBLISTT_VBE		= 0x8001,	/* VBE per-phase state */
-	BLOBLISTT_U_BOOT_VIDEO = 0x8002, /* Video information from SPL */
-
-	/*
-	 * Vendor-specific tags are permitted here. Projects can be open source
-	 * or not, but the format of the data must be fuily documented in an
-	 * open source project, including all fields, bits, etc. Naming should
-	 * be BLOBLISTT_<vendor>_<purpose_here>
-	 */
-	BLOBLISTT_VENDOR_AREA = 0xc000,
+	/* Standard area to allocate blobs used for Trusted Firmware */
+	BLOBLISTT_AREA_TF = 0x100,
+	BLOBLISTT_OPTEE_PAGABLE_PART = 0x100,
 
-	/* Tags after this are not allocated for now */
-	BLOBLISTT_EXPANSION = 0x10000,
+	/* Other standard area to allocate blobs */
+	BLOBLISTT_AREA_OTHER = 0x200,
+	BLOBLISTT_INTEL_VBT = 0x200,	/* Intel Video-BIOS table */
+	BLOBLISTT_SMBIOS_TABLES = 0x201, /* SMBIOS tables for x86 */
+	BLOBLISTT_VBOOT_CTX = 0x202,	/* Chromium OS verified boot context */
 
 	/*
 	 * Tags from here are on reserved for private use within a single
@@ -133,9 +127,20 @@ enum bloblist_tag_t {
 	 * implementation, but cannot be used in upstream code. Allocate a
 	 * tag in one of the areas above if you want that.
 	 *
-	 * This area may move in future.
+	 * Project-specific tags are permitted here. Projects can be open source
+	 * or not, but the format of the data must be fuily documented in an
+	 * open source project, including all fields, bits, etc. Naming should
+	 * be: BLOBLISTT_<project>_<purpose_here>
+	 *
+	 * Vendor-specific tags are also permitted. Projects can be open source
+	 * or not, but the format of the data must be fuily documented in an
+	 * open source project, including all fields, bits, etc. Naming should
+	 * be BLOBLISTT_<vendor>_<purpose_here>
 	 */
-	BLOBLISTT_PRIVATE_AREA = 0xffff0000,
+	BLOBLISTT_PRIVATE_AREA		= 0xfff000,
+	BLOBLISTT_U_BOOT_SPL_HANDOFF	= 0xfff000, /* Hand-off info from SPL */
+	BLOBLISTT_VBE			= 0xfff001, /* VBE per-phase state */
+	BLOBLISTT_U_BOOT_VIDEO		= 0xfff002, /* Video info from SPL */
 };
 
 /**
diff --git a/test/bloblist.c b/test/bloblist.c
index 720be7e244..efa1e32afd 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -291,9 +291,9 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 	console_record_reset();
 	run_command("bloblist list", 0);
 	ut_assert_nextline("Address       Size   Tag Name");
-	ut_assert_nextline("%08lx  %8x  8000 SPL hand-off",
+	ut_assert_nextline("%08lx  %8x  fff000 SPL hand-off",
 			   (ulong)map_to_sysmem(data), TEST_SIZE);
-	ut_assert_nextline("%08lx  %8x   106 Chrome OS vboot context",
+	ut_assert_nextline("%08lx  %8x   202 Chrome OS vboot context",
 			   (ulong)map_to_sysmem(data2), TEST_SIZE2);
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
-- 
2.25.1

