Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B8BC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 15:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6E4B407B2;
	Wed,  9 Sep 2026 15:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzMIa58FW7-G; Wed,  9 Sep 2026 15:52:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 518594078F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788969172;
	b=WjUHAMnqlhkqBPxvr82Il6WmPvoWn8LjEAzO/32JSKdk1Hp68q8cDu7mLAQ5Pg75LvWg
	 JHXO1VMlJBAeXcKErKEOfttuPFH063AWAl4xSTwyt3GkaNrOarRYUJZq9Oyy9mws4TwXK
	 ZJoDVHzNO1/Ga2UdSz1D9xGp3ig0A/3O+7e/tOteS6R2/wXFRb6bqepr9NVCE7J97tdzq
	 9gcqc+qEFxU2xG+WkTWYBqyT4doZAczSd6rrRHT0k7TnxFFJmKXMU6aKf0QvPwsrd+7lI
	 EFg7hr6Zqq63TcEcG7FjKHUy8SWflbcFlUE2/RMCVZ+RmcbUyg8nWQzz3NyHV97mETQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788969172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4M4ebechJgweK3Db2s3tbcLsMAA4lQtwM25vWhfOf20=;
	b=Pkf29KcavymYN8Mi9rCZ70VB7JYM/dY/6b0/tzoo7kUFJEBzt9J/+lgzUWgisVKJu/TF
	 fhk8qIERoG6ONG3BYe2G9SUA+SHZKjELrEMsogZfMDLBow3/0lYXtQNup6I9iv0XNyUZX
	 tCMELM7P+E0Jv0fLXK9OyW/b1sdc8L9VOlYz4jh4UjslBvNusEtEo5+HLTAOU7M1IGp8N
	 y1bD8x6R5YtsLxNNBtrOGDYlk75PnaJsx83jpbaZddRswpiuzd7yFdsnH5NavDgzoca0u
	 EY6uw4HqZoA0HH7arPMvbipeXrJmml/4jUSQMH6QE7GxGt+uCZ5N6pbmxjNgGk0ckfw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788969172;
	bh=4M4ebechJgweK3Db2s3tbcLsMAA4lQtwM25vWhfOf20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1CbipCLdRxCkSiPfB8l6ooZi8riQfDThjtDhm8zTfPfvFOOqidXNsmKYZhY3RaEE
	 r+dabeJMSTrObnbwo5kEA5qiYZVeMDHUrrze1Ss0p6oOF4aaGZWzmz3P5t738SPBF6
	 pMN22/PNj69jvaXsrvmpHPYwT9mPzUpxIYZt5lGO0Ug32BfwToTjlKuDmjzJNFzoUs
	 sUgtyup+WBzU8apWFbfGCZh053EvOJH1XQtlk7CxwgoUo5F37HHjxDmt/LFZCN8J/c
	 gqQEEBvLbkxa+Uq1VGyjUz6ggbutKnzpCK8AIGi1EYDBjecjzUfnuMhUNAJKN8H4XN
	 vXw27sZIcfWKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 518594078F;
	Wed,  9 Sep 2026 15:52:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B288D755
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95E4A8029C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glTZyIGUjPFd for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 15:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A2C480440
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788969168;
 b=RnUjrv+UFzLl1Oi/8ChgM3rL1QTTDz3fdRqX3DUsC3ujBShpnJx7WX92a45G18v9hEdD
 q+pSOFnlTDtHppTgSUY/O9UiPcS0PAEedAynUhHtR1fCTDiimniEB5ymdJablTeUCvWAs
 5g0CYy7+T1a3O2ZJliHPkdjgkcV/bXdHFOpY2LRlj2dutfWWRIEJmyp4cRVvSPCn2vX5X
 1t9sIOP8n3mpJ6dDb4UKOSGKNVvyItOHU8Kf6KT3VplwAkulEu3r58oP6AoTzwGG/XfXc
 W8Qcr/CZR/lhOFDbwat55YYMJ+BehRC1UvfIPHDpRHiHdic2BDYwR1dJigZEO2B0TCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788969168;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=4M4ebechJgweK3Db2s3tbcLsMAA4lQtwM25vWhfOf20=;
 b=Gjea7s+Yhues3Gwpam0fIxMugCcyo1CTTZh4nc+wmJfnZbpx9YNLR6c2ksHLGSnaGE4A
 eWdMEDTajCw03PdPio4nWQV2MXZrlIg7Y8OvajlX+fg5UJz9QnnZcHxSzFP96WQr6qmBD
 4Hp15/njygJ6MZuti7I6DgabgybgvSMgex1S6XOZbbCPqj13A2cd7J2K9eIvmQNGYg5L0
 4qNbXq3wgBAjtxTgzfCW2LY2567OSWyjhzu5ZBuotdwMF3oYRVqtCeJt7fDIW6qgCtIfj
 4RHemSyXACSTT7i8B2yIyT5EufZxWpE92l5VreXJDk2mqcMYudUnHbP2hhgfX1qGVjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b="UCNvUR/C"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech
 header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail
 header.b=UCNvUR/C
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A2C480440
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788969134; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ip0ub5wyfy18h+u/2y62coUNpHBH8q1OayM4QaN5vjC8lfoQx+wdp+4C1UZwt2Dhrv4VW9YguxHAf/gUnS9jA0e+YgKRFcTwMfkvNrptNMtcyNOf2biOMRSTIowUCiGi2x92WMTxUnpdO0IBE4QllCkGeuGYhyD1G14egUNB0vg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788969134;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4M4ebechJgweK3Db2s3tbcLsMAA4lQtwM25vWhfOf20=; 
 b=Mj4lYjQ+w814puR5DSDsYha5sQKzPhcFghJ1qxs4hsQdgR/GfRTfLsCOkXBt8C2TZrrU5KBw91IwvhshabDbZEfoZdBSmfIcczHZ4JRGfCIn/rKJmM/vG5uCOqm+e9KUZviVl5aqpd/uB0k4FN5drPIPtxoewB12RHKAXp2Mfjw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788969134; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=4M4ebechJgweK3Db2s3tbcLsMAA4lQtwM25vWhfOf20=;
 b=UCNvUR/CyJABY1F73zDIrBMeEX3AKCUOxp+aHG7m/ug2ykHVbx1v5Y9ahIRkmjyQ
 x91F1iu3mk4smELDW1Hy3FLeQcXAWfhYXGgUdS743DszxjEIOgrRIlJ2W51/rooFlll
 AyqU55Wd7cGVpEE4YxfhmkwNgayAzrM/GJD2BzzU=
Received: by mx.zohomail.com with SMTPS id 1788969133082493.8197259349247;
 Wed, 9 Sep 2026 08:52:13 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 09 Sep 2026 23:51:08 +0800
Subject: [PATCH v2 1/2] tools: mkimage: add SpacemiT K3 boot image support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-spacemit-aihd-v2-1-780e98cf2fec@pigmoral.tech>
References: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
In-Reply-To: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8615;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=vDeP6QzawO0bDcECoJRdBXLD47+QsmYhX8YIDGl3BO8=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLIWNszYH9b4I/xr0a4K76a9p8x1md/Yp2Yv2VCY9euvt
 1umQD97RykLgxgXg6yYIguXv/g/ax2eb0cEWu/DzGFlAhnCwMUpABOJNmT4n2+q8fe5kbHw1AC3
 GafthVgl9676V+tzbj2bUOoJ6VqGtYwMHW6vX75ccOH/2x9Tda9yzyrcW/xXvF+C42i/UI70y0d
 ePAA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

The SpacemiT BootROM loads the FSBL from a boot image consisting of a
fixed 4 KiB header with two metadata headers and authentication
information, followed by a 32-byte-aligned SPL payload and a trailing
authentication area. K1 and K3 share the same layout, but use different
integrity and authentication schemes. K1 requires RSA-signed images,
while K3 uses CRC32 to verify images in non-secure boot mode.

Add mkimage type "smtimage" for the K3 CRC32 path. Populate both
metadata headers, fill their CRC32 values and the payload CRC32, and
reserve the authentication areas required by the layout.

The image header has no reliable K1/K3 identifier, so select the SoC
with -n. Omit dumpimage support since it cannot take -n to distinguish
between the variants.

Only "-n k3" in non-secure boot mode is supported. Route SoC differences
through a variant table so K1 and RSA authentication support can be
added later.

Tested-by: E Shattow <e@freeshell.de>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 boot/image.c     |   1 +
 include/image.h  |   1 +
 tools/Makefile   |   1 +
 tools/smtimage.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..3a31ef663710 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -179,6 +179,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_TFA_BL31, "tfa-bl31",  "TFA BL31 Image", },
 	{	IH_TYPE_STM32IMAGE_V2, "stm32imagev2", "STMicroelectronics STM32 Image V2.0" },
 	{	IH_TYPE_AMLIMAGE,   "amlimage",   "Amlogic Boot Image" },
+	{	IH_TYPE_SMTIMAGE, "smtimage", "SpacemiT Boot Image" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 6edcb1995bfe..53aad2dfde3f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -235,6 +235,7 @@ enum image_type_t {
 	IH_TYPE_TFA_BL31,		/* TFA BL31 image */
 	IH_TYPE_STM32IMAGE_V2,		/* STMicroelectronics STM32 Image V2.0 */
 	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
+	IH_TYPE_SMTIMAGE,		/* SpacemiT Boot Image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
diff --git a/tools/Makefile b/tools/Makefile
index 535a5d51c89e..fc0aa52455aa 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -138,6 +138,7 @@ dumpimage-mkimage-objs := aisimage.o \
 			pbl_crc32.o \
 			renesas_spkgimage.o \
 			sfspl.o \
+			smtimage.o \
 			vybridimage.o \
 			stm32image.o \
 			$(ROCKCHIP_OBS) \
diff --git a/tools/smtimage.c b/tools/smtimage.c
new file mode 100644
index 000000000000..96e8b5d8d171
--- /dev/null
+++ b/tools/smtimage.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ *
+ * The SpacemiT boot image consists of a fixed image header followed by an
+ * aligned SPL payload and a trailing authentication area. The image header
+ * contains two metadata headers and areas reserved for authentication data.
+ *
+ * The image layout is:
+ *
+ *   0x000             root key
+ *   0x100             header0
+ *   0x120             key metadata
+ *   0x300             OEM keys
+ *   0xb00             signature0
+ *   0xfe0             header1
+ *   0x1000            SPL payload, with its end aligned to 32 bytes
+ *   payload end       signature1 (0x100 bytes)
+ */
+
+#include <image.h>
+#include <u-boot/crc.h>
+#include "imagetool.h"
+
+#define SMT_MAGIC		"AIHD"
+#define SMT_PAYLOAD_ALIGN	32
+#define SMT_AUTH_SIZE		0x100
+
+#define SMT_FLAG_CRC32		(1U << 0)
+
+/**
+ * struct smtimage_header - metadata header within a SpacemiT boot image header
+ *
+ * @magic:	Magic (must be SMT_MAGIC)
+ * @version:	Image version used when anti-rollback is enabled by eFuse
+ * @secure:	Version slot used when anti-rollback is enabled by eFuse
+ * @reserved:	Reserved
+ * @image_size:	Header0 stores the image header size
+ *		Header1 stores the aligned payload size
+ * @load_addr:	Unused
+ * @header_crc:	Header0 and Header1 store the CRC32 of the preceding 24 bytes on K3
+ * @image_crc:	Header1 stores the CRC32 of the aligned payload on K3
+ */
+struct smtimage_header {
+	uint8_t magic[4];
+	uint8_t version;
+	uint8_t secure;
+	uint16_t reserved;
+	uint64_t image_size;
+	uint64_t load_addr;
+	uint32_t header_crc;
+	uint32_t image_crc;
+} __packed;
+
+/**
+ * struct smtimage_image_header - fixed header area of a SpacemiT boot image
+ *
+ * @root_key:	Root public key
+ * @header0:	Image layout and load information
+ * @key_data:	Key metadata
+ * @oem_keys:	OEM public-key area
+ * @signature0:	Signature of the image configuration
+ * @reserved:	Reserved
+ * @header1:	SPL payload information
+ */
+struct smtimage_image_header {
+	uint8_t root_key[0x100];
+	struct smtimage_header header0;
+	uint8_t key_data[0x1e0];
+	uint8_t oem_keys[0x800];
+	uint8_t signature0[SMT_AUTH_SIZE];
+	uint8_t reserved[0x3e0];
+	struct smtimage_header header1;
+} __packed;
+
+/**
+ * struct smtimage_variant - SoC-specific image properties
+ *
+ * @name:	SoC name passed to mkimage with -n
+ * @flags:	SoC-specific image flags
+ */
+struct smtimage_variant {
+	const char *name;
+	unsigned int flags;
+};
+
+static const struct smtimage_variant smtimage_variants[] = {
+	{
+		.name = "k3",
+		.flags = SMT_FLAG_CRC32,
+	},
+};
+
+static const struct smtimage_variant *smtimage_get_variant(const char *name)
+{
+	int i;
+
+	if (!name || !*name)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(smtimage_variants); i++)
+		if (!strcmp(name, smtimage_variants[i].name))
+			return &smtimage_variants[i];
+
+	return NULL;
+}
+
+static void smtimage_init_header(struct smtimage_header *header, uint64_t image_size,
+				 const struct smtimage_variant *variant)
+{
+	uint32_t crc;
+
+	memcpy(header->magic, SMT_MAGIC, sizeof(header->magic));
+
+	header->image_size = cpu_to_le64(image_size);
+
+	if (variant->flags & SMT_FLAG_CRC32) {
+		crc = crc32(0, (uint8_t *)header,
+			    offsetof(struct smtimage_header, header_crc));
+		header->header_crc = cpu_to_le32(crc);
+	}
+}
+
+static int smtimage_check_params(struct image_tool_params *params)
+{
+	if (!smtimage_get_variant(params->imagename)) {
+		fprintf(stderr, "%s: SpacemiT SoC must be specified with -n\n",
+			params->cmdname);
+		return EXIT_FAILURE;
+	}
+
+	if (!params->dflag)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static void smtimage_print_header(const void *buf, struct image_tool_params *params)
+{
+	const struct smtimage_image_header *image_header = buf;
+	const struct smtimage_header *header1 = &image_header->header1;
+	uint64_t payload_size = le64_to_cpu(header1->image_size);
+
+	printf("SpacemiT Boot Image (%s)\n", params->imagename);
+	printf("Total Size: %llu bytes\n",
+	       (unsigned long long)(sizeof(*image_header) + payload_size + SMT_AUTH_SIZE));
+	printf("Payload Size: %llu bytes\n", (unsigned long long)payload_size);
+}
+
+static void smtimage_set_header(void *buf, struct stat *sbuf, int infd,
+				struct image_tool_params *params)
+{
+	const struct smtimage_variant *variant = smtimage_get_variant(params->imagename);
+	struct smtimage_image_header *image_header = buf;
+	struct smtimage_header *header0 = &image_header->header0;
+	struct smtimage_header *header1 = &image_header->header1;
+	size_t payload_size;
+	uint32_t crc;
+
+	payload_size = sbuf->st_size - sizeof(*image_header) - SMT_AUTH_SIZE;
+
+	smtimage_init_header(header0, sizeof(*image_header), variant);
+	smtimage_init_header(header1, payload_size, variant);
+
+	if (variant->flags & SMT_FLAG_CRC32) {
+		crc = crc32(0, (uint8_t *)(image_header + 1), payload_size);
+		header1->image_crc = cpu_to_le32(crc);
+	}
+}
+
+static int smtimage_check_image_type(uint8_t type)
+{
+	if (type == IH_TYPE_SMTIMAGE)
+		return EXIT_SUCCESS;
+
+	return EXIT_FAILURE;
+}
+
+static int smtimage_vrec_header(struct image_tool_params *params,
+				struct image_type_params *tparams)
+{
+	size_t payload_size = params->file_size - tparams->header_size;
+
+	tparams->hdr = calloc(tparams->header_size, 1);
+
+	return ALIGN(payload_size, SMT_PAYLOAD_ALIGN) - payload_size + SMT_AUTH_SIZE;
+}
+
+U_BOOT_IMAGE_TYPE(
+	smtimage,
+	"SpacemiT Boot Image support",
+	sizeof(struct smtimage_image_header),
+	NULL,
+	smtimage_check_params,
+	NULL,
+	smtimage_print_header,
+	smtimage_set_header,
+	NULL,
+	smtimage_check_image_type,
+	NULL,
+	smtimage_vrec_header
+);

-- 
2.55.0

