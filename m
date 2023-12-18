Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D761FC46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A9A870DF;
	Mon, 18 Dec 2023 19:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1/9Mscw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3571E871C3; Mon, 18 Dec 2023 19:19:41 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E678743A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59091e4a0f9so1424088eaf.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923576; x=1703528376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPrgZpWodwgPb0KblJAhNU0xeDi0U0o9ZvIxm3m/fmI=;
 b=L1/9Mscw7aOM85tE9odTS9uoHtfKtrbHdnJoylte0vGTSSpnPztv0rK4mmkvI0uV95
 aT+k79kXBGhb/ztI8Ckia8GOBUVAMlEkHitqcgnRaIdt+Kh3h7cYAGJAzIKzkde8Anm0
 FOoP3MpajVBQfR2/awecRngcEgti2bHombDIk3Q7TT574r8sChfy8bF/Ao2EhaxGzXot
 UtNYDzFpeVZc4t2IUyvZ6T3chOnVx6Cl8KakZ7VA++REFUSYOLq844riIkhws2KVANIC
 bvujR1ovfe9D3ysmNtniffBJT/42ZLk9ygomvEq318ZyLOwx6V7eksEkiEysA06zw+Wt
 cVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923576; x=1703528376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPrgZpWodwgPb0KblJAhNU0xeDi0U0o9ZvIxm3m/fmI=;
 b=NPTsxH/0T09zIy7GRsWWBX8nT7siTffbelhj++AuB5jB8/CF8AJ0rS0vrmouTMDWC9
 J2DPTNFyuzobJruO7sLq/+eWOVlI3ZeValPwkE/I1vHGkVK9WPWz3wmsMoYlTJXAp2e5
 2RPiGCUX8b77TfnguWw/ANYkWxb5Thw8qJ6EF9U8c2g04WQsLEeY1C5kaQrb1HQqXPf9
 WjRHJOPrLKTG/8gVPgYQOKJ7w3xJBZqErqN3Tn/v91ZpvUsXbgEGBQ6CNBpCU5Sii050
 n+wVoKEVU+SRsUvFHiRa1vIDMKMUa3X+3D1SUpw6pw//LZffPD5XP84lUuOTmmDLBtpq
 J7TQ==
X-Gm-Message-State: AOJu0YzU9naL1rDxRAk2O9bESC8pG2icIKuFOGWBYdzifTon57CE1JxM
 tGesAOSqvqxZYA5dkkw3WpkUnvbcoUfrEUDGJ/Q=
X-Google-Smtp-Source: AGHT+IFZKWSvUCIz0GHux3vVx2eUeS3o9s58d24Byeq6vOoi4WTXsabtR/AHPbXSfDUXmLEZl0Zgaw==
X-Received: by 2002:a05:6358:921d:b0:16d:bc51:7601 with SMTP id
 d29-20020a056358921d00b0016dbc517601mr5408954rwb.9.1702923575961; 
 Mon, 18 Dec 2023 10:19:35 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:19:35 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 01/14] bloblist: Update the tag numbering
Date: Mon, 18 Dec 2023 10:18:46 -0800
Message-Id: <20231218181901.337515-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

