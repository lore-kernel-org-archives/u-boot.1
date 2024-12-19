Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA58E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D5F802B4;
	Thu, 19 Dec 2024 14:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="n0sHDoTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16B580328; Thu, 19 Dec 2024 14:06:01 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3594C801F5
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+nq/Ao+lNfYQ1XgkAhGyGErLON5B/12mWP3Oj3pa+o7KS/XJZ22uRKC+kHk9P6OqKWM3Od5HGD1eWxlWMCgOXuzyDpERuS3iBmx/yLTN9zdO5E4dL5pZgH7F7KYbJFcLgs8a7RObxk04uLF7WU02Xir1vmTDu44WiCCbU6tKRyNPhM4QP3OHxvqXa2GBlzeSOEOaA3B13VhgPedfmeTdCOWJngilh2wyPfm294+M1g86KqP7dTfvPxGW9ZPrW0lXGrAyLHlPwD9ZCsnkMtjATVxDe9PrVuYhMl+rk3atCYJ2vnrmOXyfP8xoCQb0D9WuIneEtQqr6cKwCkMPGuVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo0aUiPoLHg1/3wvAi9MbrLLqiUMZjMmePQwwaaB0XU=;
 b=shsqpX/ijrHCCru0rcqBCpY3KhRjb1MD9b8WR61weg/eqcgFeoRfnNOxKs8bU8/QtguW0tT9DailTI8GqgdST2kkZbj8Rc5S/DANhPl5eEjVlear2euVa1kpeytVf1oL74IrbKe5QeQh0B0CSkyqmI94yBCgSv35s4vsnD3b56TiVGFUw/84GN/11ZXKfvaZCryoOl/H9PpG0QSLtNY7Pa8RObPMJ9p49Gn8i2aUmUv7PkEgatbJEEA3xbOTjf0MDICoczvCHQVm6tEeODZSyCCFyIdnmmDrHf0Bkcvp5KHybH/Jd4VA+8oz/9p577VhMQ8yTOdWilFf3gKrV/7QDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo0aUiPoLHg1/3wvAi9MbrLLqiUMZjMmePQwwaaB0XU=;
 b=n0sHDoTljWl65XxLNIYtDeAcVJ38YkgvePBzFon6KDqrvS3D4WzOSUuLqbFhWp6EiLmiwjpR6JKlNCDn0TxW7gsJhsqvS7IpxBjRuvH9vFcOKGkEgUp+jEEtNdId9h7zyFbiCf6K761GbcTbJXeaja0g+0aEKwekUpeoNgrLNwZ2vF4jD/Bf5IHX7BiXR3eHvDK4x4S9AEd18ZxkKfx/ONz+Te/4aFSyI6gs+ca4bG2sKUwLrfqRfzANCpsDDgV6VYnCXyycnUdhX0NuSRgGlgKf12Xbs2oUqCnRjId/oyTl5JvLuL0vPkNGnvuhtXla1UZ1fBcWW9uCEV/0wFD2CQ==
Received: from PA7P264CA0409.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::26)
 by PR0P264MB2170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 13:05:56 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b:cafe::7b) by PA7P264CA0409.outlook.office365.com
 (2603:10a6:102:39b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 13:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7248A20269;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v7 3/9] mbedtls: enable support of hkdf
Date: Thu, 19 Dec 2024 14:05:48 +0100
Message-Id: <20241219130554.49825-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PR0P264MB2170:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 75e74d1b-6738-43a3-85e4-08dd202de05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?amMQ9sZ/b6b7rxXIQOfrB6xhS4WaFIUiRuC+u2y9cS4WxpV6bnyv4edWV+Zf?=
 =?us-ascii?Q?8bqmgdLzFMbqMo5fTfLBOlJEy1YHWADQGNgDBz6d9pV3vMX3DUyQF2w3zwiE?=
 =?us-ascii?Q?5iyi807gDZIipI5PQ2S/sFRUi9gi27MQRIgr3sYS/2KsyOcrygMCvo/faxW2?=
 =?us-ascii?Q?UQnKgi/x9bEZWxdeQZmVfeN/3CkjqsfJhAdU+KqhU9KFQM2tUCrr6xqGwewH?=
 =?us-ascii?Q?O33cYxmGq5MJ7eS13KTyPyFh6/UDUvI8GKn6lJYGnUTYX39ywKhj+MQptZMp?=
 =?us-ascii?Q?t7Cc6+L8n1awDF9DkFUoKlvuJhWCmEXmjQ5ypq8qddRZZ8Y8JHy8vbiHqMw4?=
 =?us-ascii?Q?wjxvU/dpJQpZkOsILoBH4rgJRUfLpzVVLtupQPi9ueXEVt4YYOcUPlOPRHLY?=
 =?us-ascii?Q?FHd7T/hKaj2aqMgedAQ+7ufWlRFYgd77D09qkivqugu6xsZroxuL7rTIXETm?=
 =?us-ascii?Q?6GbkZDAQGauFVWemYmxxD6zXeVBRcK61Pn3dm8LRCYsjyn0DBsWsglW8ABDd?=
 =?us-ascii?Q?l95Sv9Zhhzlo89hVU6TffPnbe4ukS9AaP2VBvc/5gvfl+lV+0kYYhizntlEu?=
 =?us-ascii?Q?hgeffMrReWvSd0n5u9fMmqTYMuYb/aFPdNYEHlzYJAyVKH0DvsiFOLUzgWHS?=
 =?us-ascii?Q?3IuLWPukSPIzMB6DTXfOWQOliHJ1hXutOphxqDKPHtrs4eTzm7oMJDnhnS7Z?=
 =?us-ascii?Q?dnsc/bkK4j/LBoJ2DSq1U/IaJ5YKKhYFw9vgVGWK2WqsUdcc+gDcW0K+7hQY?=
 =?us-ascii?Q?TJF+MLQ+2l2aV0+ifT2mHev+uC5pVwOJWKoMwqdDVj9D+b/0GQ6bJhEGfxbV?=
 =?us-ascii?Q?SNAIgG3WGTwW1Qdr96NFvwCrH3ayxm329HfXc9CXNv7m7nWcxjE+NmudKeAL?=
 =?us-ascii?Q?0sdqcFtGI6Y35FgjdV6d1aTmm98AMXcCFMPwEBaNheOEVOh6G2KojzGaRPuz?=
 =?us-ascii?Q?N9AmduEArCjCnUB8R/4I4ib6MpVXqaNFe4zPl+F914U0vI6Tra7lOM/+YM9R?=
 =?us-ascii?Q?5G87CYlpUyNRtwVZuYCC2KVywOMkecg5MqMUnswSzwXTlfL6ICQM7NedtmgV?=
 =?us-ascii?Q?FdmNMPXMNZxiMLndoLcXqlkDjx5uo9a7cf0+dZUF2BDP4Ii5xsD1bfLNZ13N?=
 =?us-ascii?Q?7fTtYMUYMpTe/okgQaWOVb3gFpSa0KjtnqeT8Bb26aOUnf7x3CMD+z8k6gSc?=
 =?us-ascii?Q?aHsyaVwkKeK3Y+8xO5CZSqyFDypVVzNEx6zlMN5gQnyywEua/HVdkA+xx5e3?=
 =?us-ascii?Q?AiuQAugJkAXjqaMnYRKLWeqxgEffQteDWy4gUNV8qZNFwoZhX7nodd49rrRX?=
 =?us-ascii?Q?up3pf6svOkdW7iJ2sm6m7UGqBHPZrGRUImyS0qMNvHeLfzFL+LGccDlgYS9m?=
 =?us-ascii?Q?M6Z8YYZofq42iy9tpgZl+U7Sv2vzRCK5B0Jy4yA+wAjkGJitRsfeAcJ6RWHB?=
 =?us-ascii?Q?2dqJxwvbaxpmXpjeVQbPSXKiZSh0qvBk37VmMD8HVmaSg7NAAywuA0Aj2kc8?=
 =?us-ascii?Q?m3fzvgkV1LWy4/Y=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.5786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e74d1b-6738-43a3-85e4-08dd202de05c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2170
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

Reviewed-by: Raymond Mao <raymond.mao@linaro.org>
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

