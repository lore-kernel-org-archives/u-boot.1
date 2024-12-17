Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B9FE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA63A8022B;
	Tue, 17 Dec 2024 09:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="E7Yz0FzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEED80245; Tue, 17 Dec 2024 09:32:22 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968A280214
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyj0OF8kMQ5yKqX74SVR7XuOZcoa+ps/8hWeO7dFZoua7LCrxqMcFL+xOdP3A2ZsNoN+Ldun0PcWcUKxf+eYuH7Otjj1RjtoHx7EsNfP58/7n66fp5fQXRThz4velufcm3YYaM/WPhFayHf6A/0oJv/nWN3YUagwWq/eGPbduvjrR06UR5swtNpQb6ekHEdwbeqDqFEBS0DlyGHX0oxMqcy/9KbQM9/n/sJ1CXrXhxH+gglH9ZFcnYljy5G4ZIQvKL7pim9VHsBv8UWz+Yvdki5rQbMOE8DJlHjQHv5YJNrgSwg0GOef9yNh0oX9xJ7K1ATSq1LAk+3FWSYJN5IiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXc/MpTrN29jEpQtlDotgArZ0lXRnhRtYegNscWFn4M=;
 b=QkTS+x8ldh/j3xWazwmoVywAWDQlrr7kf9pTHrO/CLCfl94pdvfY+StNcHy0JjnyKu106+y8eERzoR8LpEE9wLDL4mG9I9LuPYy9bI+Nzhh6jhuswPk8gFD8zOWAZx772czlUIzifPuish7SHMgFxada3FSlSfzw8/K9bbXs4dmOCY4rfBZ127eL4cIX/YSpkReCMFJK5i8L95cy/fHRLNDvJVMw1k9ADDBSVGC5GFMnUIWS216hFQlPoLNv6pG6cHC+9YimyiMd9PZdlJE9SjSvDIVk9xoJxSjGx8JgiDVc+himGmaUnK01S3IJdBDZxcxYJmLpnpPUR0MwVJjZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXc/MpTrN29jEpQtlDotgArZ0lXRnhRtYegNscWFn4M=;
 b=E7Yz0FzYbhfcfO0KHws0EI0Ju0A2CEiw6drv9vuW+33nkyK6gJss1iq214WF3s3hiE33XoKjRjjqeesN0+SOXiNuhAfUMNFuxx/xeCljGNuObqNEdEJMUCidpyqybT1pmvN8dkicQFQ/FTj0MW7t9LYoXUPhamnCW7aUsCATtwF0JAfc0zCV4LSJVDpiCq5Cyo3/3SpPdDAbow7tTcYRES2cbZgvbNuYFjFOD3HXVOMbZqmQ/75ZyGpSYdFVNJ5rqrWyEWN8YDDuo69bL2PleRteVC9A8hZuaybwcPJ9yO0UlfURZvTcCrEX3d0cVJIRNnsREAtB/yyCapkBsLprTg==
Received: from PR1P264CA0120.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::19)
 by PASP264MB5739.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd:cafe::18) by PR1P264CA0120.outlook.office365.com
 (2603:10a6:102:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 49DE7203FD;
 Tue, 17 Dec 2024 09:32:17 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 7/9] lib: mbedtls: sha256: add support of key derivation
Date: Tue, 17 Dec 2024 09:32:10 +0100
Message-Id: <20241217083212.70330-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PASP264MB5739:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46a23f27-8e8b-4ffa-fb81-08dd1e7550fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4xPvjZUPzZ80Zq3MprP/u4eDZbukm4Pm8mBVNUqSK7Kuj9qPovws0jADeb4U?=
 =?us-ascii?Q?9H1XejryPmPbSMpXLa3HWpZnY90VBAUoJG9v31/5j3ZyxEPnzEVsKnxVBySC?=
 =?us-ascii?Q?Q7wp1VCfM695dcuM+GyAXMeUttf1SLEWYrtoIwHTP9WuHycTAOykc1rrDBvg?=
 =?us-ascii?Q?mkNNF2r7uBrfatjRnOdpSkaG/q1ns/QvnApr6QHx7+Vw3CPwNgwMeitDGeda?=
 =?us-ascii?Q?NeuBi4eTs2N/dMXoHQawvUyC+8haI8QKGCmBb7/gPHfPkN5mJoaG1V5sP12b?=
 =?us-ascii?Q?cYzq3KmZ9K4wBH6absnWXxdsGeqckA9NnIZz2ozz3w/WOiG33FslB40niDVI?=
 =?us-ascii?Q?F2vWo5PqqCcgacfpWxUArioLlYEJ8oi13fCI5ohAYtetucYqyt/8Q2l9YJ1G?=
 =?us-ascii?Q?sBIIjRwlxZ0wOYSmJqBYcD7sqjTNGMcyK+126sY2F4QHMpGw2jiWy2tacRY7?=
 =?us-ascii?Q?uHm6GbkJBl5nDTLvgOsNg3UnehpBqatSS+XpY7AEsigPL79GAqaV9CObl5Wl?=
 =?us-ascii?Q?XRvLWNWVfajh/lS8irpTfsRKlaK74+L8O7MSBDguchAKbSgNT6+p+cb9ttsk?=
 =?us-ascii?Q?aDGYx3qYNZ7xkiFd0LsDi1U+ipr+8xcOPQynxjqu9/XgQlVEMnYXo6vf65YD?=
 =?us-ascii?Q?q86bzQHWksjcty1rw/bJ67ByL+BGmywLsGRPPaP1/kAC1nJ+lny+m26TDtNj?=
 =?us-ascii?Q?kntBJaCmu4XEBWutcBgyTQJPZMDu+R4P2+ahqrG8G8m0+GAC95iKldFixnKN?=
 =?us-ascii?Q?CikygfuwF/5sFbxFJJBw/dJyVC3DGaBGKJbQXDqLNE8SbgnY77vT2ADcrydb?=
 =?us-ascii?Q?D2xQmUc7r1RZd0kXqEWpaW/d4pA3GIVIdNl3B1yHA8cnFJBcBjucjtY0SHBR?=
 =?us-ascii?Q?yIdiM5IDaopcrq1kTx9Yl2mzxT6Sjf5gB6j8b0dLKPwFsv3no64Qt8KgZEZB?=
 =?us-ascii?Q?NJxDpC4u0wcHCrD5YelN5jYk1XJpr6lNpmH2vP4MBmMehHQVnpAFDw6o4fS0?=
 =?us-ascii?Q?vmkewcdxYYmxjGZcCvIfZLbuiB9ar659yVUcuaCGYZwxM7e2x7ynLyqpl2Wx?=
 =?us-ascii?Q?asjPXWB8I7UADVq4A8+YzpsQacubw1fk0mbBaUY/p/cP/yFjhlKVj7RRQTxc?=
 =?us-ascii?Q?x8Y+Ub4Nd2LTRsQAWV4UqsUOd35Sq0ed/6YaIzTqpPCS6LXb4ampabHwOIQA?=
 =?us-ascii?Q?VExAb/V0iwK3SqR0y3vXiDxkrD1A5cySMuGeeatwcPM/aPtw4OSAsiSaTVK3?=
 =?us-ascii?Q?CnVCDAf4TunHel+fYUtwrnt7C1Mq3U3WkUarWOIheUfqJ9gjIcKDOSXHzUtP?=
 =?us-ascii?Q?FbECwb/PMLQZwSKmwLY6anBoH5nsdk5mkWcMpiziuN/a0j65PwRdowab9nY8?=
 =?us-ascii?Q?a0mJBsb0F2GuYmTYraracFxznoealf4sluMpGdApqf0zd4Gom4rtIQ4VLr23?=
 =?us-ascii?Q?IOI+AJnIptZzuV6c6Sbu21Rnn5MIdcJp1j8dIsQSHTSPhdjLmE21S1u4043J?=
 =?us-ascii?Q?EVAMC0x0JEgstcU=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.4773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a23f27-8e8b-4ffa-fb81-08dd1e7550fc
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5739
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

