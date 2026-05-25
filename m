Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B129ACD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9820847C8;
	Mon, 25 May 2026 15:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="M85Qo5O6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FDF84855; Mon, 25 May 2026 15:52:53 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212EB84713
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5sWYalOyeIQT+0/FsaFkmGuX0QjqkBIZ3h8FjmMgD9/QcVELq5EAkLP0mk/d23A+4UCRAYby5vP4kMGQ6VoNT03swJsG68Uu9hV8V8Y0mFRTLQYfzJyhwVFbGq4TbjvO5eL+FvKC/4ax7hzJ4fGdjyuNzoK8HSpSzZi2nkHvMaRKsoL2lkTw6UNcnNUIG8qMoWmHD7bAwztxdp+KkLpNyBy4vFP2OV7dtyZ9sRwc/iqv++JfB/ovayunkDIDYKUMJXNcsqLYoVsTSN7LCBD1vWrY6qZ2b8skjLvSl0ESEJYfxF+e/AVjURoCGbEWmBD71s0nhLn0eKWClBzlFvnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3azNjtWUMqii9yLX+CIF65LB5zvFJjck0pCpQcC0zo=;
 b=G/Aa5GQ9iWNdQqJenMXmPpasIs5iJYruJU5EsrtJZRnsxBzCQhelw2id0xZtTuX7A08gPmjZ7/i8JesSHMFpms9jrbs0FbxQ2N/OXWOgewvZHyf3u1ewzj4EJhmz88uL6dKHg5YNHbI6xtRhI1fmsL2TUs0LiEroioLuhsMinPvHLgWVd3YNxSm91cthdFc3cE4H6Ka0eRd9EFBp/yhb6WP8Om3+67Ldp3Da84N/y6C50NuUZk03dj9B27uHdDaHuCm/euzPKCAJ4d00DzNO+bcoUy7PXxe6scKPMs5Zmh40WpvGrdEMSTQVGryWKa1ZELa646gbIXRuvb9fo2eXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3azNjtWUMqii9yLX+CIF65LB5zvFJjck0pCpQcC0zo=;
 b=M85Qo5O6GlTvbRvC1koFXmEeoWXKJ9Frn9q+vX8F8pFkmb5iHvqQqWIfm0rF0PAN7EVvPpWzq+9+VG8K25uELdPTZtaLzWDwgxX0bTbnhAJFunw5kiQVoU5nRXoMY80Lrsn3ME7HScCc+gYyA3RUEEN7GCMRvdJ9xW7alN5HJ8DiqYoyqOZsM0yxkV7acg+Pfh6kmoqTaeZIad99s6CZeo32P2fhFtDpsVPPmb6S6sZxv3GAzF+s1LRosyuMURgt8NY3gfRSlFSbTvHe2WH6KMZmlAJf3Fg8OocC6CDi5WWgzem65J9ihD2keJKRLJGpEG4r9QLTfL2rCP7huzD1Lg==
Received: from PA7P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::16)
 by MR0P264MB6996.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:45 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3:cafe::47) by PA7P264CA0006.outlook.office365.com
 (2603:10a6:102:2d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 004C520410;
 Mon, 25 May 2026 15:52:44 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 02/15] mbedtls: enable support of ecc
Date: Mon, 25 May 2026 15:52:28 +0200
Message-ID: <20260525135241.88348-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|MR0P264MB6996:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34dfd934-02de-4ae2-35af-08deba64e605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Rnv2P1cidD6+r0PhvAT0EA9jUaSqo8zYiUZ3WGUuU8amf+RvfmLf2zp/9sonBeso+xfwYozR99QU0LQ5MabAfELSoSMdb2vyvJm3a6SGt53OS7XISCZI5y6SabRuToffC5aK2mbOpMyqCivJk0Fm2943kgYzS4ZZNsl5p0sBng2N+3jj0uuWUkKjgxB4AbYFlPVOx9RFHHZQUVfU6X5dMQ15JOcsJczOIwWGp6vFEze+8EEZi8NKc7OwItwKMyn9SO6WspzJclEvw+e1uNgaEE5hP5SMwstvXO57xyL6pIB5a6HQLEf1nTARvkRJVMiPsDh9pp2LJ/vC5lg5rR4lt5gJ+fINS1t4ZoE79A6MgiiRMV0ElU8U5gok2jrac4ro0VoSgQzPnZM+5eaTqtglz/UmLSItpHVmO+WerXJJ7BUMhAtgu4AMBLNFxtuofP98feLGEJFX76aitPkzK/t/ipZK5Yqkph3tNwrPHtioG+pe8kxKeUpxSTgXCc52CBSuI4n9GHCrIYGAajLkjsNdVnQRHx6aYDngvePqNrlS3cNyuPIGajriYEpfT1f5/uw/txvG/vSPa2vijnUCkOdfs/nmxUswmNOnfZsDhdjSGvtRYvDxs9avv1OBnkKeIyqV51kbAO1VbsI+DdgZyWy1wWXp4SYD6NQXrlSAWJ9GsG+ndW3XcrkNWL3RKl9e3bn+Bh3Y2bxhgJAX5s+kWqwfDDmwG4/I70Hdr/62obfsyEE=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0opaHWNTnCnVUaGA2wBoCkhXYYMSUpr5oYeQH3/f6Ka/z5hpavx59slotNzGUMahJSqNqNKeRZdLxJwRwdvdILL3wCNWQOeqb9Fn+EfAidynRvpVlqpjRnudwKhCQsDY3GDoExQfdAm27reD/sFmHR/AG/3jRZ0xrTfbyHyadVVegweJF6KWIGVQZZK3PjlzYIwhl6FC995qq6x95xl5lgLeK4zmA6IejG3Cwlwa1mCtZofiRFiMcCI/RIsn1KLFoddjwLVs1oMI+019BefzL0CQ8tKZDH9gwXh5FpPSoPeKezrnLKNjphMfnIWa7slmVy4RpwQbXWMzxiuCKB13A/6JEC3cQ/vsnjxzDJS+czQ4cRyirjd0g82NLm6R0wClF6aceYXwqmqdAhPL8Mxr3qCc6cVTD9vND9WcFE/KNzWDwKAvieGy9ffhJuLpNTLL
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.1312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dfd934-02de-4ae2-35af-08deba64e605
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB6996
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

Enables the support of ecc in mbedtls.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- move ecdsa to MBEDTLS_LIB_X509
- enhance depencendies
v3:
- do not use _MBEDTLS in mbedtls_def_config.h
v4:
- do not select ECDSA on some configs
- remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
- change dependencies for ECDSA configs
v5:
- MBEDTLS_LIB_TLS depends en ECDSA_MBEDTLS
- update some configs according to previous change
- build of ecdsa is conditionned by ECDSA_MBEDTLS
v6:
- fix dependencies for ecdsa and ecc on mbedtls
- ecdsa is no longer mandatory for tls

 configs/sandbox_defconfig        |  1 +
 lib/ecdsa/Kconfig                |  1 +
 lib/mbedtls/Kconfig              | 17 +++++++++++++
 lib/mbedtls/Makefile             | 17 +++++++------
 lib/mbedtls/mbedtls_def_config.h | 41 +++++++++++++++++++++-----------
 5 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..03c35429bc6 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -381,6 +381,7 @@ CONFIG_PANIC_HANG=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
+CONFIG_ECDSA_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index ca13b6bfa1f..dac8bcf23dd 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -1,6 +1,7 @@
 config ECDSA
 	bool "Enable ECDSA support"
 	depends on DM
+	select ASN1_DECODER
 	help
 	  This enables the ECDSA (elliptic curve signature) algorithm for FIT
 	  image verification in U-Boot. The ECDSA algorithm is implemented
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..e019f17d6bd 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -247,6 +247,12 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config BIGNUM_MBEDTLS
+	bool
+
+config ECC_MBEDTLS
+	bool
+
 config ASN1_DECODER_MBEDTLS
 	bool "ASN1 decoder with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
@@ -264,6 +270,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
 	bool "RSA public key parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser.
@@ -292,6 +299,15 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
+	select ECC_MBEDTLS
+	help
+	  This option enables support of ECDSA with the MbedTLS certificate
+	  library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
@@ -301,6 +317,7 @@ config MBEDTLS_LIB_TLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
 	depends on MBEDTLS_LIB
+	select ECC_MBEDTLS
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
 	  in wget
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..0c86c90d15a 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -39,13 +39,21 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECC_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/bignum.o \
+	$(MBEDTLS_LIB_DIR)/bignum_core.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
-	$(MBEDTLS_LIB_DIR)/bignum.o \
-	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
@@ -64,7 +72,6 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/mps_reader.o \
 	$(MBEDTLS_LIB_DIR)/mps_trace.o \
 	$(MBEDTLS_LIB_DIR)/net_sockets.o \
-	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
 	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
 	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
 	$(MBEDTLS_LIB_DIR)/ssl_client.o \
@@ -82,8 +89,4 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/cipher.o \
 	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
 	$(MBEDTLS_LIB_DIR)/ecdh.o \
-	$(MBEDTLS_LIB_DIR)/ecdsa.o \
-	$(MBEDTLS_LIB_DIR)/ecp.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
 	$(MBEDTLS_LIB_DIR)/gcm.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index dda3f4dd6e4..92e68e5d726 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -62,6 +62,25 @@
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 
+#if CONFIG_IS_ENABLED(BIGNUM_MBEDTLS)
+#define MBEDTLS_BIGNUM_C
+#endif
+
+#if CONFIG_IS_ENABLED(ECC_MBEDTLS)
+#define MBEDTLS_ECP_C
+#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
+#define MBEDTLS_ECP_DP_BP256R1_ENABLED
+#define MBEDTLS_ECP_DP_BP384R1_ENABLED
+#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+#endif
+
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_X509_USE_C
 #define MBEDTLS_X509_CRT_PARSE_C
@@ -74,7 +93,6 @@
 #endif
 
 #if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
-#define MBEDTLS_BIGNUM_C
 #define MBEDTLS_RSA_C
 #define MBEDTLS_PKCS1_V15
 #endif
@@ -89,6 +107,10 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
+#define MBEDTLS_ECDSA_C
+#endif
+
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
@@ -122,7 +144,9 @@
 
 /* ECDSA */
 #if CONFIG_IS_ENABLED(ASN1_DECODER)
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_ECDSA_C
+#endif // #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_ECP_C
 #define MBEDTLS_ECDH_C
 #endif
@@ -130,24 +154,13 @@
 #define MBEDTLS_HMAC_DRBG_C
 
 #define MBEDTLS_CAN_ECDH
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_PK_CAN_ECDSA_SIGN
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
 #define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
 #endif
-
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_BP256R1_ENABLED
-#define MBEDTLS_ECP_DP_BP384R1_ENABLED
-#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+#endif // #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
 
-- 
2.43.0

