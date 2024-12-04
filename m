Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E71EE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 17:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F99F89738;
	Wed,  4 Dec 2024 18:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pQfbdkaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B35D89433; Wed,  4 Dec 2024 18:54:45 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508B689467
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  4 Dec 2024 18:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfWsOvy+jMmylfA5oH59KrhT1oz/0ntred2vrr0Pxvdx7vbJF0NzZocTNXClwp+TO33m0X5R6/h8tnaIySGL0mibASZ+sSztxYb8W8+wvBWPQp5O73LUgVZby6KhXp8nU8p3pFUiTPuOCzqKUyesq62qog8DVLStN26hOLeyqVuo0nOKQbhiemRIczftkt+GM8CV4cpse6Q/4Evxf6MzdWvRgdlpnjtu5VY4DpBmhkYVp3rWgac6J/6nq2X34295W6sU7iNqI2a3rClVXFfV4V0va6VFJh6wVFCSfClYn6FJ7xo1v815/VniZ3SZGeSSpvG0U6i5euS+UDMqacnwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1L4oKkHHpfRM43tPp13k9qXHh68qAEw/7yuiLLYYR8=;
 b=SQFJfLNLDyz8BR+xb9ffM/skUOBmdx2EeBJcgoEksF+qG0AsG1jcNdq/KRkiS0wCcE2C6Ep5N0pB9E+lXx5xBKiGRNteryw9z/rcICp87jOezuJF4Vr6TbqmrNgIo0uoTnSAdOQ/wQuwgimMPVm3Ub6YKMQZ+L481SPUREKE+Z4890KRwRDiYGRI2KBDgTf7/n+gCIGXTTC6bCqxekSL/bTy0yvCApUNAVrbvoRYLE3VHRRnhMyEUyXS+fdjPoEOGByMJb3MHKDaXHxwxXGSMUdotfkXJrRtd1Tm00lrZ4r1cINbxNVta7+vOtq2qRs9yeNkUiN8tW1Yy3M7w8rWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1L4oKkHHpfRM43tPp13k9qXHh68qAEw/7yuiLLYYR8=;
 b=pQfbdkaDmUwqH83el2rafErILRjL4/9CAM7tCT/frzSfNmumTq7oA6l7blr+PYphRZIccnqkImGMwKOQnnufFeeJeHMOlWXujnNssuy1Mo1HBcmIUGcHTkrVXvB1PjGIS1i9XN3Ki4jlQlIPQBnoGnFBfzeMeh2Cd2hv7fzsvAbXwPWe5KrEn4CuKT9ELNvSQxZa5SaW81OmoHB5HA6P7wocLUZQAMBKZqwJDyu0f4XccSQAuKro/UvUxXvGZPQUmoDm2Iudlk+g0h1qkoDfKJq5HCAP8DA/O65Bzen6j5Ddlh7NdfJl2IDEap08H/UB3AQJVSzfwDlZ5pizwGaZeg==
Received: from MR1P264CA0022.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::9) by
 MR0P264MB5404.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:48::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Wed, 4 Dec 2024 17:54:40 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f:cafe::e2) by MR1P264CA0022.outlook.office365.com
 (2603:10a6:501:2f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Wed,
 4 Dec 2024 17:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:54:40 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.75.209])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6F10620182;
 Wed,  4 Dec 2024 18:54:40 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 1/5] mbedtls: enable support of hkdf
Date: Wed,  4 Dec 2024 18:54:33 +0100
Message-Id: <20241204175437.185449-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204175437.185449-1-philippe.reynes@softathome.com>
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR0P264MB5404:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b31d92e5-b8c9-406c-c716-08dd148cba25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GMjosFjVYQ+q+r3m8fWwse7U3E5d/1E3yyW8X3ZN5udMPVgGLa7YT4OEIcUu?=
 =?us-ascii?Q?kB6mQNc4DV/qoae8ALj553wUmqoNpBuMcRt1sXsM66TARrpR3JAMeps0nEcN?=
 =?us-ascii?Q?6NT9lycLWLxz/k/kqYRG12MemPvZSrJE6SPVhnc4c3mlXuj2UmyeyD2f22ms?=
 =?us-ascii?Q?fjm56nDiDWc1AjOJrdCgjhKbJR9rIIizmB+D+igYam7Rgz6NIeXS4TSpuKLG?=
 =?us-ascii?Q?dyCxx98Ux1K+rJWBCkl96JymyNGjyPRGzpOYltiqC8bf628oofAqoQsK5GT2?=
 =?us-ascii?Q?su1NujF+uYBfit2xqvaVGOfnUiNC4++IXalKSwUXKthUtqNs0zrH3VNzvdFO?=
 =?us-ascii?Q?bjT05kIvCpdGZaUYZLcpQl9EvVdjBXd0GUQ95gniFOUGqZMIIJf3DOaKIRB8?=
 =?us-ascii?Q?hSqAmRg6fgzDCmE8Vsl4dZJCKRMlf0Rw2hZgNhTnkdQMiwHKPr7LGqIDng09?=
 =?us-ascii?Q?Vs/Y/XUnTPdiXoT0OsomG3iprzOapiZFKMu6/A4dl/AGbxEJkQGX6/J6IlQn?=
 =?us-ascii?Q?Y03ut2H15Km/1vceRgGqI6oNv0MjOADR17j27nLHSqOjX+nB98y0kAuEO4or?=
 =?us-ascii?Q?IL438IK4t06WhjBlEl+jDGuyu/0bscomQJ/ttpci9rR5yJE3UkvaXfJjFMyI?=
 =?us-ascii?Q?lpQ5TQCsS3o5UfNTYRc4BJhu0+njY26lwf3E/rCIfqf4dFlze4nv6XX+gInK?=
 =?us-ascii?Q?DVLVc6NqIvKlWOR509Nbe8zXyN2+s0jSwnTzn9XioTGCvwkUTIC88RArICMI?=
 =?us-ascii?Q?JqNrRj+pWNI0i6Tm7yax+ZNkhmRFYAdmwUSgf1uTPQhg8nRQrcUQ/ZNs6SJ4?=
 =?us-ascii?Q?+I49g+7zBcdzhaxcEw20lh1AJaAYoD+2EzATzFxscU1ZIp8KXBSADxYa0PEk?=
 =?us-ascii?Q?w43CivxoLiB2iBX8ONaVZZdnIVW1f3Fe3hvEOMZ/+vV7wwK5LbP6NbydVkrm?=
 =?us-ascii?Q?8BI202RlcR1Su7O3tcaHSWj582uiMUD/iHzK0Wyj79ybhGOtqbHvKe1uWsKS?=
 =?us-ascii?Q?RwcMNL41co6vDoidptThI3Z4MpPnri0tSLYxW0ddsaQJAxvalGYlT47GqC3c?=
 =?us-ascii?Q?FChUOiZ5NZHBnEi9vVx2W6s0v8I/JADJnounykoDHHe4Lt0D2uZdbXw+pHiu?=
 =?us-ascii?Q?SbJtjCI4KrKDzZiy6ad2TwDcUMHqQGJitQ7H/xFExmgRCOUo5ATfhp/sGedm?=
 =?us-ascii?Q?8r/fvT/G2eOqc4pXhFB7xDAdehbuqVCBUN16ZWyU4EmXRyNb+cxdakn17csg?=
 =?us-ascii?Q?xdd4AEby6E454HwXG+QPoTxK4VFr8XBsTpH0UyO+s8/4G5GHpPfQX8Z42lYQ?=
 =?us-ascii?Q?sSJAeAXsICKvWqnGZjI+5/3nEFBW6Gf3mq2QBl1mH8HBcbFEz+X1s9kdbFlz?=
 =?us-ascii?Q?aSgXizU/6tqGrd6b+JYy9hE6qVupoDH+JVj4Xp77jsEN/s2CKFv1pVbw+Rjq?=
 =?us-ascii?Q?4J8UGi8mzc7yPkIT7TBVz2USyvZaRaqA?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:54:40.6712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31d92e5-b8c9-406c-c716-08dd148cba25
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5404
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
index d27f017d084..cce0134d527 100644
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

