Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ADCC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7AD80EAF;
	Wed, 12 Feb 2025 10:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="RXTZSnoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B2480EE5; Wed, 12 Feb 2025 10:31:42 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6537180C7E
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ual4XHNnTtF9Tbk3sjzP0weuRA80RxaSE4O4Euca210nhpH3LjrzySCanDkIwirYBP9Yf63Z1bbod3pBviB7TsueI7A4lwS8lzF68zvG/l4EYu238WZr9Fk26FCE93GGwU1W5L4zSrFZ79NjT8IsIOwf/1ohPhR4jReOS86dmOKBmnTOllUjkCqk75C3fqMLdCMvV9uwYq4E3lFSjhqVztgD+nT6k83/QpZT21rRm+ORJBKo647388eDYG1ERLma8MOvG6O4ffHy9tXEHNd15VyWvs5B8JxXFRPN3aVHQnd08Ayamdn7kXzUgHmJLADLzy44uasDTmGnuArBnD1d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwQiM2mCneP9qIygy8qrwQPbfxS5zi7ZvlpiYHEut10=;
 b=PqhEv2n90PxN8iO0ykXnairuXiitv5D4073Y35uypWDgmyKRiGm/G9UyG+9PWjFc9ZnKREjnuy9I20gIHnsrPEh6gMpq2P+0MhwurQGmVA4wzwBlkvzPMapXoEz0b/jxR/wz4e802gKHXZUTBFkLQMBFTjMmmX4rI6R/wsnTANaFrUKEKYIKhGAHvRMhGCyfsDaQBX5S4SAAgGp2m3/T90AR93mwYlWZFZof19SrGF5N1bhcOj6NYifKFApm909OEXykFG/lKI0kr6IY2vW3ZrMRrb0xeN1Qeig2lBDthgYH2Zxil04qdcUXuO0dhl82HLZHV6dHplnRhQ8etyDaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwQiM2mCneP9qIygy8qrwQPbfxS5zi7ZvlpiYHEut10=;
 b=RXTZSnoenccWSIwutpUD7oBE+m+CkXhNDdSr8i1d/8wNMopTApEhmyYUWdxReAjaSYNahmb9P63pjShQVc198XdWZAi1es4PSY5adWI1TP4eJMNpf8RXlymD8vyqlL0i9Sr7TKStVNmaGFuTCOOD6COVm5oDYUnW9UYR2bZsQLNEdPlQPfzZ6ntFcbyzPQ3xjWUvfV+CaxB7e45bopEWwCMxs+l2aah+pFFxuyUJMc2P/hheu420ExBrXk9qVSrGTRsmNmfpLaSDdMNffmeUfni8NRE32roVXoZSMxInnA8G2gn3+wsU9xBqCNuss2/f34i0RsKGz1nvAE1wgoZ9CQ==
Received: from GV0P278CA0087.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2b::20)
 by MR1PPF5375A4CE4.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 09:31:33 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:2b:cafe::d5) by GV0P278CA0087.outlook.office365.com
 (2603:10a6:710:2b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 09:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:33 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id 00D0420065;
 Wed, 12 Feb 2025 10:31:32 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/6] rsa: Add rsa_verify_openssl() to use openssl for host
 builds
Date: Wed, 12 Feb 2025 10:31:21 +0100
Message-ID: <20250212093126.3722186-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|MR1PPF5375A4CE4:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a18e90f-e3bb-46db-f176-08dd4b4809fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVse88Sr9W9gy5lmIJ00ivO1IfZD/jxJjkrZ+9CPqf01nkfApWvJGkzPg+7J?=
 =?us-ascii?Q?fdXEZCkCAkQ7WF0VxdL6jOdXzdrIqC6+oNywpIC5BvNMzvk8/4dawC+fbonB?=
 =?us-ascii?Q?9J2bb07eeV+1QvX1HpRP5fao+X1cOxyo5+Wl143ZwbqSGzSFwEygIwqqVxdh?=
 =?us-ascii?Q?15O38ZDaNu214EcuS2tzcsGHTZtZTW/UvGNc8mxpO45/y8JUz3RbAcfU2Yrm?=
 =?us-ascii?Q?IFM7fgg2xklw+56aBUvJW2qKYrlYKx/qnBse58LNFs3yDPl729nvsbECAvXz?=
 =?us-ascii?Q?ci+Gnyw52HZ02Svk5U5g3XXATlUva0A38JFz7TLUSssh2UXC6njhRoTzFKWg?=
 =?us-ascii?Q?BMj7KQmwJ/b+AAAuDQU2HyYX/MqGlZ+ijiR7hW/Fln6tnoSs1IxSbCecZOaG?=
 =?us-ascii?Q?jEwS57onrOCFZU5t3O+Z1NuCu+KaGTHurfQhbDSFmsgV0XFcNWiRdNwOOBrw?=
 =?us-ascii?Q?OzAvoLFZAdEsQ4/o5Jrbv49XiSPNrOgiv9h8sn7iV0LYXueXQmL/ZWHPOjqH?=
 =?us-ascii?Q?nxJqhly/usqhu1sVfyFS14pA2HHftv4+0s9OorwxRCUYPNsr7qnkxikiWYGe?=
 =?us-ascii?Q?aV3a+eyM4sFiVq5yq++zSjigRvSmri3A0GXYFN+sacztxzRC+GoIOHO8ELaw?=
 =?us-ascii?Q?y39Vxn5aMTbAto48XSD/zGQcQTyF1L5/8Xxl3lLN3oSL3u1V/viAfI2w0VKr?=
 =?us-ascii?Q?mDWxgGzAmx0JRqzcnvgp6ix9x/2tdcS/udJKad2ADgyFhn5meopS9sG2WDJt?=
 =?us-ascii?Q?ekZG0t2D8oktQDuv+VTj1QaMfhHHWAX876IS8CTCTSYT8TZXrbNKbD1rS6Sv?=
 =?us-ascii?Q?oq95vu6QLs7WKSXUTF1f6qLxvKV5R26E/TlcEZ/BQJneClX0V3mjjwwy/0sK?=
 =?us-ascii?Q?MSUqhCrUS1C5Lz2iTDLh488wYgOLxKiOahO8vZrG04jAR9aa2fpvEFJw3XJU?=
 =?us-ascii?Q?8mURD5PIbmLrobctZONfeWf7xTAflowqZbCbjLeTD/hO1CVB5vCKB3MtL/Oj?=
 =?us-ascii?Q?zRjxhwaihYa41BfXPnEcJH9Q6ZqZ7WoWTqzoiN+JLAjCeCvK69eBjhpi+7qj?=
 =?us-ascii?Q?mnRpEjNHPuraxtWKtHuBgx6ynPMnJ1p46i7R3JmyDMIyJtzNKeQ0/sZ+scCB?=
 =?us-ascii?Q?z9zV9uqcTmfRT+xicGuzlbspdJB3k0Uq/I8hIVWzgdkqubigfwi9hhO2t16g?=
 =?us-ascii?Q?NtbTmVy3HIz4bCJ18MA0j27S3ZqayPB4nB8We3Dhv2FhUG71wAttQU1u1kIj?=
 =?us-ascii?Q?8cZWAUFiEUVS5JVXwh579ODYu7B4WVvX7RymPO2ShWvRNRvPgSnLmH9B5LM3?=
 =?us-ascii?Q?1N2pVQRiyuCyUoy9IgpbxMjQ+X7J75G9JPtBWZhkA8yDjSkp5/pDxwlc+zXs?=
 =?us-ascii?Q?7bfnvLBRPkC6h//sJjYjYhmtgDDvDSHc7846zd4/cgvI1TNqWHbGbcRgKAul?=
 =?us-ascii?Q?YBtRUVntQaEdBQcJhRRSxWJvvB9e2f5YaqbpAkEQPVyQ4NG1Mm0Bd3Hz/HG4?=
 =?us-ascii?Q?DGCDpXOu4ELcC9o=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:33.3244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a18e90f-e3bb-46db-f176-08dd4b4809fb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF5375A4CE4
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
index 8a9f779d3ff..54b1557d6c6 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1687,6 +1687,24 @@ struct sig_header_s {
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
index 84095d760c1..3a643367f2b 100644
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
@@ -1388,3 +1393,139 @@ int fit_check_sign(const void *fit, const void *key,
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

