Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7F2E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E878023C;
	Thu, 12 Dec 2024 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="kituK37s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF1EC8020D; Thu, 12 Dec 2024 14:37:17 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B182800CF
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJRPLPVU9pYml0gbkbJ5u78p2d0tT2MFZNBBNTLUPUQpY/zoM+IOwCj+tvlUrxukDY8gfPn9h3P3PGfy/g0BGeX6vd7oVzlskaFPhU8S1Gyr2pzcWc2Tdgz+Mrutdv806A7Hfslqhqkfu2sFSKs9aFtF0kLTOgYFuWz5CBqsfsiy6knsN0u5t5KABblcXrH5e8AA/H9YgZqtiYEXB4eK/EjkFee5cYexAmO60e4AE4QkE2jLQA1+Rhl2G7ioetfaWyUNL1iCrbRXIfonbn67g+BWQnBNMiGQEmhtCHOB7Zk+xQq3OAccRJ7+LFWwRZNPHS5/j9bmXv3ljJCiRGxLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=gGH2PmTH8H9LJYAimYxaPfIZdLK+DvthMOSEkmTGT3b1wExwONe4cazfmnmyKK9ypSloK5snk4Qq7H4GtXspN3coKYmnKqv+ZP3z037BlNw9TPmk3FzrTXPVOWdNwjXDdpGDlzyTRbVnFQmM5hcyZmNNQDK8cpeR1ifXyybxzt6mI1vwOYHuvh/sow5PvEMtc7kozST2XkMTpIYoVPjzvsANPjeNqGwbJXaYoZV+8rU2meLTQGDgLDzkElDwgBxIrmJamEdH73G3ZGbQ99W04GtYyoGJY53hT2OESDhUHDXYr9LYpdoF/2s8//aYJcAPEDAd/LhxkgxhIsmseDe39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=kituK37sjwLo4Z1xEL2RDGIWgkOk/0axUjTo7hzTSwAOABXfs8HCGzZxFS7+qtQpd2M8efEhM2v1GCXIuMx/fbM/P+KoJ8Ev3SSDd+AUzUbEZNAeexElkP5pixyIEyKFOH6u4Hmi+a5RAPc7jC2PMHAEQqW4wekrGozkMYFP7yYUyI4m1Lck5b15Mg18xjGNzW1ffY/LvC+esY/Z5LTqh/6kmU2qGy5qfdi7HjjbtSwXQw8r+kRRSwC8wVETlvsj9nGw0+Y+Zk+Xrsz9cuS4ciMlyEum2Ycs8iI/CDZHsVVwpqj2JW2VSwb2QwFnkizIRd6ZMGHyLdjAW/N/Zic3ug==
Received: from PA7P264CA0201.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::18)
 by MR1PPF4BC2BB847.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::223)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 13:37:13 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d:cafe::3b) by PA7P264CA0201.outlook.office365.com
 (2603:10a6:102:36d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 409242030D;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 3/8] mbedtls: enable support of hkdf
Date: Thu, 12 Dec 2024 14:37:05 +0100
Message-Id: <20241212133710.172404-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|MR1PPF4BC2BB847:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 64f96698-bc03-4894-7f94-08dd1ab21621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D1Q+NvqGjuLDwubOLicPNMhCc70cSWM2Ghjcpddur80by+OHH+QhH9iCJW3H?=
 =?us-ascii?Q?MPf22aPXNuqTeVw8V7qBksLCL3nexX1Gg33IqV37vHk7zN2LllgwwZj45S0i?=
 =?us-ascii?Q?xrnDww93zGQOfdhwvbDn5aLG7rqHMZQ32pbEgrj5VkS61eSOFoMt6GgzdANg?=
 =?us-ascii?Q?8S3d807My21XtG4GcsJ0u8ZvSQiVPahMLgPaljPV48c42qr998Tkyg4KcPJy?=
 =?us-ascii?Q?hwmfFXNM0dmEx0sytOuDMccmiSKatm4GbfrbGVxUEUts8Azn6qP3SUyqxfhh?=
 =?us-ascii?Q?UCWwX9PPAgBSeBjPX+CuWLoc591e28OSkzF/RaNCAYRiWQBWL3h8fit7Xcwk?=
 =?us-ascii?Q?mvOTvRFcp6qT/QoHXnJ4M25Pvc0BVt4eJawdEpt758IOAoft7+1NNsCtbRt6?=
 =?us-ascii?Q?W8efnkgq662eB2UqD6KGYr+JXc4ArzhbJAp5R674PIzc1KQRBDcwU97pZXac?=
 =?us-ascii?Q?++L+PnKCPtyZzZNb7DQ3F1khXkl4YF+qyxQlH5mvOWY0WaUQI7eyv4CdVMZu?=
 =?us-ascii?Q?tWswuyJhjVX7NfobnGpD7UUQC1hQTcEQUB0yDmlChuZjAvQH2CvgGYt+u0+Q?=
 =?us-ascii?Q?4T4z75hbwfzFOL63LupNCHEc4qZ3DJxc8DRms7IUzF3nA6XfYjJnhf47jVk4?=
 =?us-ascii?Q?Roc+gtBL+H/u63t8TX33DliJgV3zUZbpAol+udzPdEHzEo6v0xMXnQOzf4kG?=
 =?us-ascii?Q?2q6x2nlj50rkn9FeqPiSCaoGUYG92FWWUpyWhcXclpK0qmbJui5NVNtAzDhM?=
 =?us-ascii?Q?LKcdgfpfSNftwcdfQpqFtVWHEraDPMg/PT4Td54XxPu4B4i74bHYbs+FYNXR?=
 =?us-ascii?Q?1jaaCNFJjsdZ7//z/opSeIwLWDrf6o2I6Vf0UFZdOaXbG/OyjnzqwE1P5kqK?=
 =?us-ascii?Q?vz58L+MXIsepAh6MJXq7f2v9UxcAQxyloIvQRyWb0/Q54R0jyJj8BxThuT9v?=
 =?us-ascii?Q?HlUJz0g/6U8OpYjrtifCmNBKJKFvuGxExR88iHVQSJmRtPopMhb9448H89e6?=
 =?us-ascii?Q?LgoUMPmdHYdpSQVjMluVWCbgvTbyc7IseibuHNpvCZvLdUXCt5SKbCNJpcMp?=
 =?us-ascii?Q?VnGLwxxG7YxV/1HX3NBVwU/KOuwEWCPE7CArgLfHZtL+7VI6PVbsmFkmYIWQ?=
 =?us-ascii?Q?/lgn/NvFzZFpK+KiJRuQ51/xqabNA4xuJ5x2kqKzC+URYEoWgg11t723ZydX?=
 =?us-ascii?Q?UrkAoIPKcJRvfI5BtmF0sV69dxtG4/e/xoDoSpFPfScQ4JkDa5vWifvjandK?=
 =?us-ascii?Q?a9sokHBajMgKb2Vnp02EuSqRJAze7g+RBq2ubQugSq+te+GgZljTkGtGj2bN?=
 =?us-ascii?Q?apOdXDYuU5jevxHfqqqBiEgn0ssTKuMkNlwZagft5rbMtrMLlnWgbsndLhm9?=
 =?us-ascii?Q?FPxczrNmsNrMeLcQXq7dgwmh2rl5VbgVcWSp+zvKBuTQNllYR4Noccg1lrUK?=
 =?us-ascii?Q?1S9pcpJcc/zaAA6ntnUSYvx+0q1Fyjub?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.3804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f96698-bc03-4894-7f94-08dd1ab21621
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF4BC2BB847
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

Adds the support of key derivation using
the scheme hkdf.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 lib/mbedtls/Kconfig              | 14 ++++++++++++++
 lib/mbedtls/Makefile             |  2 ++
 lib/mbedtls/mbedtls_def_config.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 78167ffa252..aa82336ef14 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -297,6 +297,13 @@ config MD5_MBEDTLS
 	  This option enables support of hashing using MD5 algorithm
 	  with MbedTLS crypto library.
 
+config HKDF_MBEDTLS
+	bool "Enable HKDF support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library.
+
 if SPL
 
 config SPL_SHA1_MBEDTLS
@@ -335,6 +342,13 @@ config SPL_MD5_MBEDTLS
 	  This option enables support of hashing using MD5 algorithm
 	  with MbedTLS crypto library.
 
+config SPL_HKDF_MBEDTLS
+	bool "Enable HKDF support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library.
+
 endif # SPL
 
 endif # MBEDTLS_LIB_CRYPTO
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index ce0a61e4054..e66c2018d97 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -33,6 +33,8 @@ mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha256.o
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha512.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/hkdf.o
 
 # MbedTLS X509 library
 obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index 1d2314e90e4..fd440c392f9 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -56,6 +56,10 @@
 #endif
 #endif
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+#define MBEDTLS_HKDF_C
+#endif
+
 #if defined CONFIG_MBEDTLS_LIB_X509
 
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
-- 
2.25.1

