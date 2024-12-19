Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F40E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996728031D;
	Thu, 19 Dec 2024 14:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="CN5y2OgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEF380362; Thu, 19 Dec 2024 14:06:02 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A4880291
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrXrjdFZHfpPhADV01ydTGreOQEU78LAMa4cMuBwwJCYSegKikbpfITd0izrvRCGn+1WbqxQrjk+FY/nn6cTpFnJDRhvoJ7U1yAaVhKiRdusAhjDUoOpj9I5BFdeVLy8aqpSedPgMSN0mmaG1zru/K/L0b2/PMsW5By6Flv/4iONgUKIhAysQSykwnTw3CZuWLPjJ/ElpHbV1T8hjGslyYmVDj5RrL/5v7v4KiGpVhY8uC3LI8GJ6SAOjx031nnTNjEtfwI7Xn6zr23eO0w+wQUF3ybsb4cjf+2KYWMHxZTaXxGA4dnhsM0TWzJpM46IQSBP5gpIY4b+pel90toZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXc/MpTrN29jEpQtlDotgArZ0lXRnhRtYegNscWFn4M=;
 b=Wcx0YVbmfVb60tFUvQ0NQHp67nm/PLcf+s3ruTCTWwHEqoexhxCt4Xu4VWVLy7opwU/KeUZsgn8ULO8zk9r3zbewLZcgFj9wNgXbXGN4kuK+5lQWjzCKiuqiT+85Y2z8Vzgyz57yapEtTtN54UhQ2OyH6mVejVquynNBIkhJkPmcp7/5OQ/KbP8cfgT6ksql+xkKvPFK9EzdkDz1qFRy63WWb4nnJhtNkgkdJcjoYRxxCTJut04RwNmVOMWdYMeysbMxIs3BFivA7SxOWHXtCCvC7iMchtKjVW+ulOCLzrOqWAElIFpskBdykgREjOeu36AJx7AwGEDh8QczEDH6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXc/MpTrN29jEpQtlDotgArZ0lXRnhRtYegNscWFn4M=;
 b=CN5y2OgP0U8MZbwHLuTobCMGcw9r1S+yoW/vxlcH5bWQt7EBNGmQj9u6JSoNVHBOBuHfNAAEqanpJaTYTkotxHZgQ2Kb62wPK7Y/s6+E4oSiODDlFFapNDsQcSLZLpunwGivar/HVsmb1NhX5+vs6r9K65CLgqO+3dWPzlEjexoZVe1UaZi9N89C2eP+t249Q2LwxrG7QJWb3F43qRZkwGeXo1gJWfmPHUdsWS7oyB4MqvS8j5QfaJa7+assyYO+y3K0kpR18Z1TZVjZWjFH8FncV/oL6W/8YLnq6beQM8m+Zimdohi2xiMmLXeJJ8aUwdmteaedTt9NUMUO7H2NYQ==
Received: from GVAP278CA0018.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::28)
 by PATP264MB4709.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 13:05:57 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:20:cafe::e6) by GVAP278CA0018.outlook.office365.com
 (2603:10a6:710:20::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Thu,
 19 Dec 2024 13:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id C5F0F201A2;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 7/9] lib: mbedtls: sha256: add support of key derivation
Date: Thu, 19 Dec 2024 14:05:52 +0100
Message-Id: <20241219130554.49825-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PATP264MB4709:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de3afe8e-c015-4994-36a6-08dd202de08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ox9+IAbwfLeEJM87O2HP16/J1jmKoi7pDP0nwVNnyNlkMiQs+IPIYG3KfrPi?=
 =?us-ascii?Q?fQUOXJPSNQlNjJ6QvepaFbXSOCAk32M0KfYzf/ALfCOl0flRt3VDIM0XfCEa?=
 =?us-ascii?Q?BwcBfIrqs9BaOCV9XWH32EkIfIE1+Y3/Gdh3WWKyYIt9Ume/BLKXQ8BFhI73?=
 =?us-ascii?Q?uNQsQHwZTwlmqZu3n6R/uHaPC5SSnaG/nXtaGWmTi97HFFGgxpV0pDCCuhKz?=
 =?us-ascii?Q?oS9D7HhqpGOqJjozr9xGkO2SBA73u0FFwa9R/oGL54XKpswJu1TkzPjHKJGx?=
 =?us-ascii?Q?OuKkt41PmWlOXtk3YIJDVACeEWDslq8+yibfIJDNQ6IY1N3fmeO21M5in9J6?=
 =?us-ascii?Q?nZSSNFNaFjMtqoVJVJoTVR17sxbzDuVkHhMo/gpj8hxoPsz6YJeZktX77/bO?=
 =?us-ascii?Q?UhsVG53313WfaPE1Ug4A26b9BpsitXCVcqhKQlqvDTFpD9neb8xbUapLEKpd?=
 =?us-ascii?Q?qgzRbz4xOtd0Z512QXHzQDCqrup18GInAcx2i2U5rYQEc9N2LYmnLEYZZyOg?=
 =?us-ascii?Q?wY1IMj3ULussFHLk7SBxMf94X+SGjXkMow5hOu/8L/Auv+FthapXwzb4bYSe?=
 =?us-ascii?Q?K9P7HUYp6Xyhv1bVXK6p7stxgBC2n67XNzIPUTvToJj5/IxrGCuYjD7s3bh6?=
 =?us-ascii?Q?tFJMaQLcTPGCmvU7wrIU+z8vapDdmUugvBT22GIGyL8CS1ebriQbeXFvFEtJ?=
 =?us-ascii?Q?/mf+pyeywucgVa4eRkOFfiqJjvAkD4IGBOjQMDt16PsPfIZm25NHK0Aqf6yA?=
 =?us-ascii?Q?BJUf3qLgucAXozHucuQu8uEJnrUQs1qM6Ngits5/GoHLueTvTQwSFS3sG2Tk?=
 =?us-ascii?Q?TCrGDN6V9JHOL7+QgQzsUkEvqlVNek3cFz4HEe5EHi/Ai27YVIXuQeXeBKQP?=
 =?us-ascii?Q?2M7SlCvh3waXi7+yd3yDPwzwFgw6aRPJxmw9YvBWCPW5V+BO5Z2BgbYVtd/L?=
 =?us-ascii?Q?Tb9D5lUfewJ0lH/IpoJA6EdcR9rcMwHYNiLxL3LObq+vNq3SDa6dR2f3r6sY?=
 =?us-ascii?Q?UEIyhOEbCnKFO4IxZLpE9rhwjpbTnGyR7cc7roLthPnyuN8MaKYX0Qwi5Wxc?=
 =?us-ascii?Q?monKLnlFC378ZFNHadDs7tXBAV8kdMHuq3PKvJ/JsSbvEirbioQqUHttGiDo?=
 =?us-ascii?Q?mc+Xr2CZEyL/GZ4jWK0LV8BL0XUKpm5U2NpB/AH64SPM9InG8y38oreVbeZK?=
 =?us-ascii?Q?ZVJcRcOQpgxgYha0aOpRWphAZyf9cRXVbdpOzxwsSzREzS1rEFH7TO1usdDI?=
 =?us-ascii?Q?l3IvBbvBXc9eFn/lcDeeBvUcmUXI1l0UcGXoCp9SRdBoCuTy2+pmgFy6HTbo?=
 =?us-ascii?Q?IBgobbL4Ip95olImuTDIGIWRjH9yPhY7JOz2sR9lkqRf/epWAQIa1ZeDWtKq?=
 =?us-ascii?Q?DYxuXfHCeeosWBEVtXHZB8UWnbC9z7uXVCE48VJp2lyFA2ZV9MsFMhXPYV+l?=
 =?us-ascii?Q?LC6aCWCqHV+QAE/QBOlSzLNEuc6MRy8W4ODCVyCOevjmuaKxuY+4N1Ds2bh3?=
 =?us-ascii?Q?wAc688tDmR0ZF4k=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3afe8e-c015-4994-36a6-08dd202de08f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4709
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

Adds the support of key derivation using the scheme hkdf.
This scheme is defined in rfc5869.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h | 20 ++++++++++++++++++++
 lib/mbedtls/sha256.c    | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 99cf78e204c..d7a3403270b 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -1,6 +1,8 @@
 #ifndef _SHA256_H
 #define _SHA256_H
 
+#include <linux/compiler_attributes.h>
+#include <linux/errno.h>
 #include <linux/kconfig.h>
 #include <linux/types.h>
 
@@ -49,4 +51,22 @@ int sha256_hmac(const unsigned char *key, int keylen,
 		const unsigned char *input, unsigned int ilen,
 		unsigned char *output);
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen);
+#else
+static inline int sha256_hkdf(const unsigned char __always_unused *salt,
+			      int __always_unused saltlen,
+			      const unsigned char __always_unused *ikm,
+			      int __always_unused ikmlen,
+			      const unsigned char __always_unused *info,
+			      int __always_unused infolen,
+			      unsigned char __always_unused *output,
+			      int __always_unused outputlen) {
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 7d456a82017..59edcb517df 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -12,6 +12,10 @@
 
 #include <mbedtls/md.h>
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+#include <mbedtls/hkdf.h>
+#endif
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -48,3 +52,22 @@ int sha256_hmac(const unsigned char *key, int keylen,
 
 	return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
 }
+
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen)
+{
+	const mbedtls_md_info_t *md;
+
+	md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
+	if (!md)
+		return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
+
+	return mbedtls_hkdf(md, salt, saltlen,
+			    ikm, ikmlen,
+			    info, infolen,
+			    output, outputlen);
+}
+#endif
-- 
2.25.1

