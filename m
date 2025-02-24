Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989EFC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 21:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC9780977;
	Mon, 24 Feb 2025 22:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="COs1TzrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B589C80017; Mon, 24 Feb 2025 22:21:10 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630C980017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 22:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZc8Rf0fQuRardsnIlVtytlALSCpW/bvkSD5v8OCbdhIOD0vP0a+BPYxffGTQi7eLMh/IZsfcaGVGBcwVPFY5Sl8DRj4JYOzgmdyPirWyti0v78fWuujtuSTSXo1GpkmP34wXLekAGHQkRRmwa0YrclynNeTxLRmUeRZ5N50OMA+L6DBR5hIWV7mTmQ8L4Qq+snNczSZJsMvTFCYulyMMc/7+LZL2+qDFF3mbKG3HPjHAYmT1vnCW31WfgMSA8ZNeOu/gNP0wcTGrzi3AewU/cIEphDvRYYpRt5x6KO5FmS8Sw0ZEmcBKNCs9y11KHb4TWxp4qyiKatHnwx320n79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4wnMwtzFbO0fqKeApiJlUpwq/iPXENZIa/B8I79wNs=;
 b=QRUTWl62jfnUEipdv/ShLOU4+rbkLkPeH9NF4SCbJ/zP2JHuaxbq7ukC0iuG93R/z7UquRwTbUy8if+iARt/KtuVULdrjKtenqOE7hrzwUL9oSyfJRzYW0T9hJUoZTPTzP1378jCoXn4s8GQTJkeMRTVwNvmFkzts5dCtQbRC20ILKl8wtemIva14SliDdGTruT7r4XI8zkN2qoI3AVkBPJtCC4RaI+R3L1bHa+9bpRiCij2m22nEBCe8rFinv2o+sePHDVQkLIgrloisJmLfbDIfiKwa/p+K37Jaooa+FZc/d2hlIB4oTSZQGI0+pNRAVX3feSFHm79sZnyppT9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4wnMwtzFbO0fqKeApiJlUpwq/iPXENZIa/B8I79wNs=;
 b=COs1TzrY/iDebHBgNlRoAGWdoacQWz63F0QFoa40Oj/fZ6ogtWhDbateVj/pRqjsS6R6kaoQgV31naxCSCY3m8CFe5B2x0krHI9h6O9kuyE+Onn0VV0QhkxIEwgITFUGUPEkxJ5CJm/31aze/uDCJCUlqA6p0hyfcoxIasjm1ZR/LNc3FkdUNmKbfIsaQy9/IyWuGjiW074IsfwbB0Q7t13lYGsd1Y3HshesVxcPTabBKbDaGDElbLz5u300aai1IZUN3yfILQdxaacB9WVzQO9jiAXQwRCHCAmK9/ajusBgRUzGjcFv1WKOfApI+blRP1heaUEdHXPJmo7wBKijpA==
Received: from PR1P264CA0101.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::9)
 by PASP264MB5076.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 21:21:06 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf:cafe::f8) by PR1P264CA0101.outlook.office365.com
 (2603:10a6:102:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 21:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Mon, 24 Feb 2025 21:21:06 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id A0D7320206;
 Mon, 24 Feb 2025 22:21:05 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, paul.henrysd+nodisclaimer@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/6] rsa: Add rsa_verify_openssl() to use openssl for host
 builds
Date: Mon, 24 Feb 2025 22:20:50 +0100
Message-ID: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PASP264MB5076:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95016a67-8a67-4061-96b9-08dd551926a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A5RZhBmr5gq6XaXnfG2fJAnP9cYKhaG/4obP0TaKItfGPXrfBYJFP3DfWrr6?=
 =?us-ascii?Q?aEqkXl+smUcTSSKI8JRhPEFoQhykP6ZiUFZGtLrxSnVwGxvg6NuazZNOYt8g?=
 =?us-ascii?Q?Msn3xd53uGrTzIommxXQgBhk8ZeY3P0OljibAW+vKK1AjDhCKTKsxIA0582M?=
 =?us-ascii?Q?unfJOnGhmaniFtKRx9wu8FybWu+GvkimWuIK6GNSVFGX7W6sbTb1ATDpuoyG?=
 =?us-ascii?Q?M47/XE3d9mdI20LtOEzK9u8xCntNyqbY14/mcFuvvOSPCLwJSrh8b5vPIPc2?=
 =?us-ascii?Q?FLaw+jdZwNRzaf6zj+TKmBsvtBazJ6qUIHPKWm4486wLWJV0+xLBvnEYDkTv?=
 =?us-ascii?Q?1vjQR2fOyYYwYFdUnfGCDOE/aiO/fzy0PF+WVM6Qm0Kh7AWEDLSoNZrVDvxf?=
 =?us-ascii?Q?cNi8OH6pTTwJ2teq0HVXUAJ/EvO9nUsH7FNHPHfkUxbmvO8LilMbQ44Vu5dC?=
 =?us-ascii?Q?54aTBhu5oDV4t0Vg4t8k6qh6g+NFhPsB3bIJ29c+T0LoUKcvGLE+s5aTrbXs?=
 =?us-ascii?Q?4cKliFbHPJu5gRg2KDir2YTU0t6Iv4isCBwMnH9hNHN5nMpGN/P861sqvLf7?=
 =?us-ascii?Q?PpVd0ZujGYm98FHGw0E7GShSOuySgXaMi04vxBiKTCoGoYL56KejtUn1Dhm7?=
 =?us-ascii?Q?xHdB88GFSLxaG7sGeWh05jmgTrghXwWGN5B1LsM/njjuaa+Wp9L4yNf2ehcV?=
 =?us-ascii?Q?Z3DvJX///AoE/pho+/YIkIgrmctFwjGyI2bBJ8L1L98NCfesYxKWxtvKT+vP?=
 =?us-ascii?Q?72JxonWtbwDjaE046hRp5H+/A+mu/P8bDDvCok1rx223Z+cS4rtMqzBtKl7v?=
 =?us-ascii?Q?k0l1NhcLAGBia6/Pz1m90+dqHDOJVRwhlEVI5xmKgsWLTYyyhK6faq7P5PvD?=
 =?us-ascii?Q?YVpOszU+gvjLQ3zFj5RL0zSqy9bqL4EuOB5nScM4k/4GnAD2ykXq8oAOm7w0?=
 =?us-ascii?Q?KeyhDcYwPAsOQf8surKA+kMCHZltTaNcSXlibLx3ctq6RKiSSS/BRxodKN+j?=
 =?us-ascii?Q?sF0z5t4xhkVG7Gu4XkUoZcUJjkMyVJUK/SjnoROj8AVh1eG+O0lYlAHX53bu?=
 =?us-ascii?Q?e+PL9u+YBK0lK3TnxVQJ2W7cwMcrDlOXMOrgFfjB+SrcyAPbDhXzmAUJc/6/?=
 =?us-ascii?Q?4EFikJ5q8Yv77SrmXyAREJt7utIJC0F6yFxFyF69D06ypMf3TrYB1q7qIvi9?=
 =?us-ascii?Q?v0jhsTBMzbP4sTkJ5PgDLUuG+fIh4qoUTGKwJbJFNJOv7JpxSP3XtitLhXIX?=
 =?us-ascii?Q?EdQAR3+oKicnp8h3ihTVr24yNc74UxoffP1Tz3Hy6mLtd4vPwlIuKXeuWHhA?=
 =?us-ascii?Q?cYgD0JHldDbF7ZgSd8HFEEycYamcVvKANvqk9s95TcPYhXqRxGCGiNW9Si2M?=
 =?us-ascii?Q?Gjj74B1UgBuT3HyJfWot2TBwvO85UMOafRWiQz6ZYGnqHOO49i+S+YeXP5mb?=
 =?us-ascii?Q?qlHUEFt1yYPA9qQMC3LrwXW6cFtgmzXq3x342Hucx9Dk2093bHbGbx/LmHpT?=
 =?us-ascii?Q?zuJRrAfmSWSU9r4=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:21:06.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95016a67-8a67-4061-96b9-08dd551926a9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5076
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

rsa_verify_openssl() is used in lib/rsa/rsa-verify.c to authenticate data
when building host tools.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 include/image.h      |  18 ++++++
 lib/rsa/rsa-verify.c |   5 ++
 tools/image-host.c   | 141 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/include/image.h b/include/image.h
index 07912606f33..c1db8383459 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1688,6 +1688,24 @@ struct sig_header_s {
  */
 int image_pre_load(ulong addr);
 
+#if defined(USE_HOSTCC)
+/**
+ * rsa_verify_openssl() - Verify a signature against some data with openssl API
+ *
+ * Verify a RSA PKCS1.5/PSS signature against an expected hash.
+ *
+ * @info:		Specifies the key and algorithms
+ * @region:		Pointer to the input data
+ * @region_count:	Number of region
+ * @sig:		Signature
+ * @sig_len:		Number of bytes in the signature
+ * Return: 0 if verified, -ve on error
+ */
+int rsa_verify_openssl(struct image_sign_info *info,
+		       const struct image_region region[], int region_count,
+		       uint8_t *sig, uint sig_len);
+#endif
+
 /**
  * fit_image_verify_required_sigs() - Verify signatures marked as 'required'
  *
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index d3b4f71d6be..b74aaf86e6d 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -565,6 +565,11 @@ int rsa_verify(struct image_sign_info *info,
 	uint8_t hash[info->crypto->key_len];
 	int ret;
 
+#ifdef USE_HOSTCC
+	if (!info->fdt_blob)
+		return rsa_verify_openssl(info, region, region_count, sig, sig_len);
+#endif
+
 	/*
 	 * Verify that the checksum-length does not exceed the
 	 * rsa-signature-length
diff --git a/tools/image-host.c b/tools/image-host.c
index e6de34fa059..e19166aeb18 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -19,6 +19,11 @@
 #include <openssl/evp.h>
 #endif
 
+#if CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)
+#include <openssl/rsa.h>
+#include <openssl/err.h>
+#endif
+
 /**
  * fit_set_hash_value - set hash value in requested has node
  * @fit: pointer to the FIT format image header
@@ -1401,3 +1406,139 @@ int fit_check_sign(const void *fit, const void *key,
 	return ret;
 }
 #endif
+
+#if CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)
+/**
+ * rsa_verify_openssl() - Verify a signature against some data with openssl API
+ *
+ * Verify a RSA PKCS1.5/PSS signature against an expected hash.
+ *
+ * @info:		Specifies the key and algorithms
+ * @region:		Pointer to the input data
+ * @region_count:	Number of region
+ * @sig:		Signature
+ * @sig_len:		Number of bytes in the signature
+ * Return: 0 if verified, -ve on error
+ */
+int rsa_verify_openssl(struct image_sign_info *info,
+		       const struct image_region region[], int region_count,
+		       uint8_t *sig, uint sig_len)
+{
+	EVP_PKEY *pkey = NULL;
+	EVP_PKEY_CTX *ckey = NULL;
+	EVP_MD_CTX *ctx = NULL;
+	int pad;
+	int size;
+	int i;
+	int ret = 0;
+
+	if (!info) {
+		fprintf(stderr, "No info provided\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!info->key) {
+		fprintf(stderr, "No key provided\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!info->checksum) {
+		fprintf(stderr, "No checksum information\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!info->padding) {
+		fprintf(stderr, "No padding information\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (region_count < 1) {
+		fprintf(stderr, "Invalid value for region_count: %d\n", region_count);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pkey = (EVP_PKEY *)info->key;
+
+	ckey = EVP_PKEY_CTX_new(pkey, NULL);
+	if (!ckey) {
+		ret = -ENOMEM;
+		fprintf(stderr, "EVK key context setup failed: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		goto out;
+	}
+
+	size = EVP_PKEY_size(pkey);
+	if (size > sig_len) {
+		fprintf(stderr, "Invalid signature size (%d bytes)\n",
+			size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ctx = EVP_MD_CTX_new();
+	if (!ctx) {
+		ret = -ENOMEM;
+		fprintf(stderr, "EVP context creation failed: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		goto out;
+	}
+	EVP_MD_CTX_init(ctx);
+
+	if (EVP_DigestVerifyInit(ctx, &ckey,
+				 EVP_get_digestbyname(info->checksum->name),
+				 NULL, pkey) <= 0) {
+		ret = -EINVAL;
+		fprintf(stderr, "Verifier setup failed: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		goto out;
+	}
+
+	if (!strcmp(info->padding->name, "pkcs-1.5")) {
+		pad = RSA_PKCS1_PADDING;
+	} else if (!strcmp(info->padding->name, "pss")) {
+		pad = RSA_PKCS1_PSS_PADDING;
+	} else {
+		ret = -ENOMSG;
+		fprintf(stderr, "Unsupported padding: %s\n",
+			info->padding->name);
+		goto out;
+	}
+
+	if (EVP_PKEY_CTX_set_rsa_padding(ckey, pad) <= 0) {
+		ret = -EINVAL;
+		fprintf(stderr, "padding setup has failed: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		goto out;
+	}
+
+	for (i=0 ; i < region_count ; ++i) {
+		if (EVP_DigestVerifyUpdate(ctx, region[i].data,
+					   region[i].size) <= 0) {
+			ret = -EINVAL;
+			fprintf(stderr, "Hashing data failed: %s\n",
+				ERR_error_string(ERR_get_error(), NULL));
+			goto out;
+		}
+	}
+
+	if (EVP_DigestVerifyFinal(ctx, sig, sig_len) <= 0) {
+		ret = -EINVAL;
+		fprintf(stderr, "Verifying digest failed: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		goto out;
+	}
+out:
+	if (ctx)
+		EVP_MD_CTX_free(ctx);
+
+	if (ret)
+		fprintf(stderr, "Failed to verify signature\n");
+
+	return ret;
+}
+#endif
-- 
2.43.0

