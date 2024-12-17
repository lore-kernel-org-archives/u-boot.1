Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAA0E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E826B80241;
	Tue, 17 Dec 2024 22:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="kh//b/Ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600688022B; Tue, 17 Dec 2024 22:36:22 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAA88022E
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omJEjlzu/po06HqIZ7QnDPvzrW/i8hN0q74ajnQeapieDQ7/u0N8LqbJLfYMMsugP+AzZ3T0NzjqPAYScY0qEc5orpZA3AUGqAgPeu4K7RsBo131uWDfxkzSBFrEOamWNq07RoRcKR/ic3WLL7fIcB1rY99ZE2hF8qh5SoNC+BQ74Z0Xb+i9t3k/kdfYdSgb9JABq6rdsdp/3+1s+dBkIETvX2UxkbB4WUwvnNEDwesVtKeaWrvMgNzm9AXS7+fjhxQ54z9Lyd95i6w/gPzsCYPEE56oBfDD72BiJGFKrRyXyiZOcnQ/opAy7en7FJubk6kOwZAGyCwxi7ISor8LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=mXpCG6XfjUmdLPZApb7olGyOusKzIeyQwNsvACXKu1bfkMNTw6lVdcnuXF/FKpZPbtXS1QnPEJMybCKTWtvk901yw/uacTqqQez8Ftys/gYn1FmfYVtdKkB+k+9T0fN5xVi9SpuxIl+ioTHyTdMLUbqU5C5zpi7hvXAJgY1yUxnM1q2SJZYOigU9THFUE98cC3uz0zuForDJHaQDLaPgw/wEADa9/EhUIME8jUIakLeYyL2kruh4gS26L/xoGz7isvgSAXmMGhk15T31oQsOCA3uO7y5AzNu2p3kSMNE5JhInSr90pebBvEf4YfHix0E8hdrosYOEG5xLgnaqNJ7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=kh//b/IjKiV4LkeThDzf4tXYyE09YIgXtEzzOQgBFsE8TlTv6uuOuNKnU4iIqPo8Df/+cxk1pqc5HBiQUZ3G5veihGtcuTinOZCkVwZHbedF1EWJhxYP67hDulPkt7t8bwsB7jnTRg98Q/UwPJHCruYf5EaD97cvxI/k0h8Ivt3IFmk2qJeVvJgpiYlsEoKdttZ9D/uPv1oi70xCMvfjLunnGvMUy63iE2TgOo//ANuRW2wa4yykPjz9yuE5RwzhgTgs9OiPzft/vihvVulnq2YgR7BMapXpEQRM5N5tkodAWWnbbMXoL2awrGPh5zKAMgwuDevDfOQieZkB/rvrHA==
Received: from PR1P264CA0198.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::9)
 by PR1P264MB1950.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 21:36:16 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d:cafe::3c) by PR1P264CA0198.outlook.office365.com
 (2603:10a6:102:34d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:16 +0000
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
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 457F9202E9;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 3/9] mbedtls: enable support of hkdf
Date: Tue, 17 Dec 2024 22:36:07 +0100
Message-Id: <20241217213613.286813-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PR1P264MB1950:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6e0b1db-ef4f-41ea-e941-08dd1ee2d662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WK+lnbK0XI2tgv61uK7MFl7s05QDDReCqO+H9zAquED2yrzx6nRkM+Qd3OoA?=
 =?us-ascii?Q?Hsh9H8+uLPwRYBPippTFZbZToH2+D/bnous9QHFhuxlaH/Odt44+jawbY3Cn?=
 =?us-ascii?Q?0d8mpCEr2y9aQ2IPIXFVJYM7XOwd5j7EtBif9YND7c0Z8nOLyMow6HzDR4Xd?=
 =?us-ascii?Q?Ed+AOB6h8iFg2XF8amuR+hgMbtxAIHLPVS8/XzuwfPEBV8oiDrS3K9gXllzy?=
 =?us-ascii?Q?Igq2j1F2J3FyqeJQ19UuQ9qjuKV7YBpCWAS5UmN8wC49m59PBjZZCb7ubA+d?=
 =?us-ascii?Q?9fzaHQq4ZsD6LlthnTzGF1E/6i//EWkGueDedsnCNazF4rdN9rnXXmLkjI8D?=
 =?us-ascii?Q?BaYAERVGwwClkTvBbQCSQ4ck6DVEOvxy4lC8r6NXStgV0Vs+W536kqTjpusV?=
 =?us-ascii?Q?anPkgu9xJgqa3+1PSSC8is/Lcmh5Xfq+zA/OS7QJieZSZBjNRhJyPi3R29pY?=
 =?us-ascii?Q?RHEsbcKcb9v9un1+5H2t6HrLcGI8WYBRc/RYAvIp6UuG8EYwfYIxDwbovaWj?=
 =?us-ascii?Q?aiztV9cjkosKXBt7chzMXSGDdflVEdwdkigYI9ihlAj28+9ktCFdQd+QOO4f?=
 =?us-ascii?Q?WPkE5T8dG7SGB0oaQXQheOGMnCAKINvST/FCeQKriXrgN0vA460LIRX/xl5O?=
 =?us-ascii?Q?aKlguWRo0HxSF8I5Slllx80K8sxhXjARB+xEmQJj/OOYPxELwFCXPkxha4+7?=
 =?us-ascii?Q?rOTgyIsQmQ9P/Z2waHM6LMiwhBxCjwgvQaxs89KSiv0b8y+0Mx0b5tp6ndLg?=
 =?us-ascii?Q?koQh8oKqJSnVmgBVv8sPgChJEzexZJGXfnXPwEv0vFEd9QRfUKJkA6LLYGR8?=
 =?us-ascii?Q?bo3QHYiluKgN1WNU4nuFzRdwCHbUEOu4P1pW76z/vJgxrdrQ5f34fZMWfrkj?=
 =?us-ascii?Q?0K4GvdHZbSg32k903qAUTAT8njD+L+hCgEhNIZT4VTEEM9eGY2bjon8YXeUn?=
 =?us-ascii?Q?FFSy/BrGCSBuIVZCh6ndAx16ldgjpmyPOaeK3fzfM4VJmeDzulq3Gock8+v0?=
 =?us-ascii?Q?yZsOVnfHsraCwO1WO0/rpZMcizVGdNtESMxknBMoiRhOH/kRUKd/aanQVdjX?=
 =?us-ascii?Q?OnZilcay4/ztlwP2QMOqQhhxTAf+do9xtwbJaPfHsdNc1CJ9ozDuXGB/o2uF?=
 =?us-ascii?Q?jJhn4IwPDteFI8j28EdIpv/wLDZcML5jWHBu819Bct/JbTj0x3hj6zgNoYSp?=
 =?us-ascii?Q?whxlznbfDzBqLDH40tK6LnpAtO+jlL09m5Jc0wfXoV0Ld9WK8PlZArJT1wQG?=
 =?us-ascii?Q?5UTNCDRft6XCoF2rMlpBfYWBTXMA9+om2yeaa3VFzw72ezOwreThFpbzKNHQ?=
 =?us-ascii?Q?c6UIMaadKMUL9Hj7POxJ7PJSgMHtfW/RZhNAgjdNTFZ8yBb+Ipu5iXVsX5Ew?=
 =?us-ascii?Q?nycWzxC/gPyiX6q4CIdwkH5zlSZNWEu7+NLUSNq0K6r7ye8d8DP/aRBxWbzp?=
 =?us-ascii?Q?ss7Itpr2QH1ZJMHziQx2wIu6VyvFFsrW9tGIgxbj5IRnnv6N9bJMI1OG+u0E?=
 =?us-ascii?Q?b8kJ5N1WFuyo9XU=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.4258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e0b1db-ef4f-41ea-e941-08dd1ee2d662
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1950
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

