Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9303E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14167895E4;
	Mon,  9 Dec 2024 10:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="cwx7IIIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623C0895E8; Mon,  9 Dec 2024 10:42:05 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C4A89367
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 10:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8zy0wC7PVnji1pfNfblDvBHIr6cTzdrwr0haBzutf0WnUDvFHWeh9UJ7Fr52S5vx+m5JSjB0iPOoRmLUq5UTGDkK2nPXnOJ1ZTe2auG/JNQCwE7hqoOB0BrlXqhQNcPct3ZoBK73fFvw+aPBRXDBgSLG3WUT2i40xH4twzWOk5jGOuZg+GttGTsVj7s0Q6bYSwe/RHO6kro9F3Vjk0t/D5jyEHTzzYU/JDrt7IzBL6nCZO3Fv9WCm6x+T2rHkBxLUetM6stOnJTxYhZI3c8SVEbgYAq0qCqVEE+ePfdiX1Xc1zg1Jn0DcWKi7qgp2vabwR+nKQT9QO5UgxlhDi/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=xCAUGnuQldpqHuucKnrFbEuG8Ykxrgnw21g2WyDbU7flvrCG16owQnmsAH1jdSNW/8tWhkWyoOxLfqtNypxJyfdLWIliwCkGPAzkdRFItqH+kFmjlqyijrxe2oEUiji/TPHIiz1XHrDckQjmr8HdXtRQOd+CuJ50AxWSdhcJMHUsfCJGGKHfIFY927GXHaw/ipqURVKKIXK98RvseY+dMTOuP7yTmM5K3uETW+HMJoFaFaNzN4OLfcNO7kWT9v0gwJwqOo3ekI2y1jDLnfw4LbJDo9XZ4mhrJqjoFVY9KbLc0fkSJZestqHmYFnbM+UVTevAv2EapULDwYSnwus28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=cwx7IIIRRt1glU6fABcMuxxgC5eRBTT/wz465voO2yet/bimWPv6fKp/D3o4coVpcAh2vs89GdOTEMpDFvPERVtwZdy4EoLfak0Yk9Yq9TaliZsX6DfCbu0l338q+AwEYoCsPGa3QrnklbslGmn9+AKCaExRUEzfqCy70muQX3RvJgp3fk6wOvS/xPtWpQbuTPMmz5B5ap393w+Bdoi7Suw8UyNIH3C78lNkan47d7jeUu2cQKTobhyMC1ask59AlTIaTCUCrChkeVZQkUKmAq2brsPHAcNBgSVl3b92exBPCVuO+T/zuw1xiuStaP8GPGx0wtavfObBHXzCDFkOrQ==
Received: from PR1P264CA0131.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::16)
 by PATP264MB5436.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:01 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce:cafe::a0) by PR1P264CA0131.outlook.office365.com
 (2603:10a6:102:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 09:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 9 Dec 2024 09:42:01 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5224B1FE96;
 Mon,  9 Dec 2024 10:42:01 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: raymond.mao+nodisclaimer@linaro.org,
	sjg+nodisclaimer@chromium.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 1/5] mbedtls: enable support of hkdf
Date: Mon,  9 Dec 2024 10:41:55 +0100
Message-Id: <20241209094159.8355-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209094159.8355-1-philippe.reynes@softathome.com>
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PATP264MB5436:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59dfa6a1-5e58-4e47-40eb-08dd1835bb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YrSyu2Xl6mKJV3hDy/OU3xQ18826PjGRX9G3YF2FULVqfrjBfGZjC3eRNzcI?=
 =?us-ascii?Q?V4lz3set77qfzPPfdQFQ4nxN/b6mleZYSB2H2eF30pUOS8Dowe1qQ1QfUgEW?=
 =?us-ascii?Q?F82rn94zWoQP5bnGHMB2kSR5F5uh8aEKUhTL4RLO4yFuiHS+vQ3ny3xHpzy2?=
 =?us-ascii?Q?zdsgbTTeAlXLVYJhrQNOr+thyT4sbWh8cJuA9D2Vv3xe7qnF4m1GpDffygIA?=
 =?us-ascii?Q?8Oo2Rp7nz6p9PmWHn0WzJnGzPX1+vSpcZRiwfDaENwfR8N5wYH/G2N9b6jBO?=
 =?us-ascii?Q?2BUZUV2wz7qieECIi0Aqnni9y8zAgwebpnuWe4E28oAAnSHuATgaC1BEKhf5?=
 =?us-ascii?Q?tquV6JZFQXnPXzTsXMX//c5ulbZUzIFrBzE89l6JdcROnoJk0XsjJTQzzBFc?=
 =?us-ascii?Q?hvMa25ZfhGw8vEXoq+eEk6DdkC9WyKD+ylP4Ut9dIKvffok1ksERnxsZ3zB3?=
 =?us-ascii?Q?/ZmvapCIOiu6pSSNqaq6d1vkpqCkl9LmIZLModzuYlRPV1d3sMzDvum2fgC8?=
 =?us-ascii?Q?ZqZUec+5PXqNicbE1Zm+kAp1gDyxUihUHQoDYfSyywl3tkcedBL9UB4zzjbW?=
 =?us-ascii?Q?seV0oa/RWLPZ+8cjcp03H3JCpw4oe9rESPuIbwPqde/7TOYsiFKE4RxjVfqJ?=
 =?us-ascii?Q?PbmPlr8mH03rdnHnBUQHW05bMkDfjPYHIrU8XxkHt+HtLFAzEdSNWeYOP40i?=
 =?us-ascii?Q?4joDWR56g7Knj8H5BDYvfXnQlaKTb5FxbKIb7CnLNWdzC6HmCSXbiqnEf47A?=
 =?us-ascii?Q?QoOHTwdHyXbwOtxY7uvMOtlHjauHnvyE9OnpbwUDW84NEcQ+4xgVgFXky4m6?=
 =?us-ascii?Q?dXb2gp9sqmkrULMQ3zV/CLz/rr94ZRgiH9Ma1nMq+f9yIgniI5FNQeZpn51l?=
 =?us-ascii?Q?d4AGpb8xB4Y0R9W4jfLOMUeIscXgrv3HV7oikT26z9+LMLrooa/Pft/I+qDP?=
 =?us-ascii?Q?JJCzkEkSXcvhjPmDOBYy3Csj7bNfEPChNM4ok16sesfLqCP51VJi2n5Fk70k?=
 =?us-ascii?Q?FPy10j5VOYJRSYT65oZtC+2KYonnTajPl+2vLOK84VQVBLM5le2EZ7j30JPo?=
 =?us-ascii?Q?b3pvsoq3pLzAbzWGIEVX6dsZD57Bt2F/eyDKoinmNAHQNxErgUZVx79W5y6I?=
 =?us-ascii?Q?CvhyD/c4bc2XS+qCLPVDKvKBlzT7504CYI4cqwWrkexInaB9uIb5+1xwmOGn?=
 =?us-ascii?Q?NAf7uSI3AgQpJSBmXD2YzLg4r5wy/ta72TbfIFzPtvddlm3WGEbKUq/ojhue?=
 =?us-ascii?Q?6nuPTNtd4m2xL2OyEujCG13ov5w4UookPsFkKmzMxKDYHB52s/lpZkoMQYaj?=
 =?us-ascii?Q?nFWQv/ESlUI2wwJnlhzpWXnv4wZaMeNc+Y2ROXt6zwIsF3XXFbMdicuqP/Ri?=
 =?us-ascii?Q?92SRj2SSGGNK4g0fnxyO+8IY0v1CGcjqOqn6Kt/wVdGd7HNMIAd8/fGI+tk0?=
 =?us-ascii?Q?TUQ6iNW/Bwx2/Qi2NgVm//IgsnQiiL14?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:01.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dfa6a1-5e58-4e47-40eb-08dd1835bb89
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5436
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

