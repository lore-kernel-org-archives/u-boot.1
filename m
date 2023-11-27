Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3220BC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911A4876BC;
	Mon, 27 Nov 2023 20:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c/k9R8ag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E6A877B6; Mon, 27 Nov 2023 20:52:10 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E3C876BC
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67a44ee7ab3so8752006d6.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114727; x=1701719527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48qrTAvcuxUvckPGcrpccCwABZLrr6cOVzJPr4VvXik=;
 b=c/k9R8agW62ipUoDH3vdnPJTJhdD1vEOUWeXm+LbOUMDjSD46sdq/Mlo9N5w9HwOUQ
 7IXGHWJ2iRUtc5pmt+XvnoeZ4BPLSuE77Ppq6pE1D2AES07GKp/ocVk2J/dMU5mSWqS0
 AcSEz8NJBSziv6ea5hP/7rTmTSbCakrkrLw636nnwUPeBnnGeLb35/4Zmhn36A2Q/lEV
 d2P9W9iex7qCEhKbs1Pew0hXyNprytix1JBONGdsdJQim3pb4RYQdMO0B8x4aNujVkaX
 fg10hjqYzESLKQZ+/ekYEOrJdD5dfmJvx2Fy09Ax8qryQG8dwd6OB5R547imamPL+/RX
 SfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114727; x=1701719527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48qrTAvcuxUvckPGcrpccCwABZLrr6cOVzJPr4VvXik=;
 b=kELmqHnuzSPxsSCYsFd5Plcq5xCslt3WZRE59U2YTsd1oPb/Ez5P5mSscvNcZl5ZM8
 gnu+tGN915iLqSpaeu4+zFmu60Ogo8NxspnU8/rtRqM7o67456UZkVWDuGXSRU/5wY2l
 q4OLozTza+zh6ozrQEfBZMiSv3w7ba9WhXcbPd11j6jgmac+8WmhIngTTvqlSvltZo3F
 LymnenQtUrn2sUqOu9As/unNwYzhDVhpDE3RC3Dgsvug/qqFPdyidtvxnawav9l0vbnS
 VagSSva7OhRhH2qf8F5n4MsY4QewZFnK2mOdvUwoJflJxq7pUOlj5un/TY7rj7+mIvza
 fncw==
X-Gm-Message-State: AOJu0YyNJ42/zd3t0r0fk3WRq9H+xtlXQ2rLDrEXI9lFWRQSZG5JwbHF
 FC80RVk67Mhx9QwlDWHf86H4G2EXR8BaDXQOZ96b1g==
X-Google-Smtp-Source: AGHT+IFkXyv4fgNr9s7aXtFoprQ/2P7DZWZIQjPqjVtFK1VNrrdccrqmnXtjMVEOaP/MXTHtP/tgsQ==
X-Received: by 2002:ad4:5dc6:0:b0:67a:21aa:6513 with SMTP id
 m6-20020ad45dc6000000b0067a21aa6513mr13209332qvh.17.1701114726788; 
 Mon, 27 Nov 2023 11:52:06 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:06 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 01/18] bloblist: Update the tag numbering
Date: Mon, 27 Nov 2023 11:50:12 -0800
Message-Id: <20231127195029.90951-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Align bloblist tags to FW handoff spec v0.9.

 common/bloblist.c  | 16 +++++++++---
 include/bloblist.h | 65 ++++++++++++++++++++++++----------------------
 test/bloblist.c    |  4 +--
 3 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index a22f6c12b0..349ceddea5 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -36,16 +36,24 @@ static struct tag_name {
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
 
 	/* BLOBLISTT_AREA_FIRMWARE */
-	{ BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
-	{ BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
 	{ BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
 	{ BLOBLISTT_TCPA_LOG, "TPM log space" },
-	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
+	{ BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
+
+	/* BLOBLISTT_AREA_ARM */
+	{ BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
+
+	/* BLOBLISTT_AREA_OTHER */
+	{ BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
 	{ BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
 	{ BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 080cc46a12..3a2ec91e25 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -81,7 +81,7 @@ enum {
 
 /* Supported tags - add new ones to tag_name in bloblist.c */
 enum bloblist_tag_t {
-	BLOBLISTT_NONE = 0,
+	BLOBLISTT_VOID = 0,
 
 	/*
 	 * Standard area to allocate blobs used across firmware components, for
@@ -89,42 +89,34 @@ enum bloblist_tag_t {
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
@@ -133,9 +125,20 @@ enum bloblist_tag_t {
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

