Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B959CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370798404D;
	Thu, 28 May 2026 10:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="BhWRq/pc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3393846AA; Thu, 28 May 2026 10:19:27 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B7E846A5
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcIbi32Rv3k7Nl8IMqeVQC63pJCfgjA4PyhFb9vvn5dQlbMAgv/etV87FUpu/gP08Xi7GCbR3D8F3Ozrb672TIfLhElC0NK340yILe+tRomJA+izpIv9sdxn/jnWG/5kvZdr8XcVfr+GDMpy8bY/vq+VJpIFiGeQlmc51Gy7ZtOYbjibAW9QMfDMnIHv0c0vdSUM8aXqtgXX+iLeNxmuKSCa+0oeuyjjlBTS0XV5Z6SFKHalrCFJJllnb0ykkt9EJVV/cpHPUyujQuGF8voH54WWckJLPz1DOMS0qb5a1VqTIU2/gNlRWLiO7799gFyMfmC7Lyi83oCVuUSGTuxciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pw/pzlxaJ5KWT/RF/t4sA8axmrd7RAZ53jnXjlDD70=;
 b=w2kwgZONxZjm/HeI1YFAB25Tedduf12qpISPpWst4xpNkEswJTeUzE3Qcgz5d+a2TjH8Fy7Bu38VGH7FF36OwVbMwfydKQ0fNYp7qJupONlKA+ejLMV3O7Etek0yWZEXW40NYy0L9rTg9phph/0aKLkuSkp6LOF3QwZeTxvxm3p1VAHo6QZTne0c6kgisa7u/1RB2vwUyPtHyO9pndqsXLRPFs3Fln/pQQr/ZjlO9C+ovVKdR8fkeq51A3beS5CzTZG6/Cq9LhJUp6e2m3IrpVeRwhU6WL+OWrJ+ieuuk7MKrFiqIE6FT/qu9/I9H+bbS6cwZcsmf6OPnD/ihV1+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pw/pzlxaJ5KWT/RF/t4sA8axmrd7RAZ53jnXjlDD70=;
 b=BhWRq/pcPTJaw/1JQK/wkJfwTqwjWN76esvH+khb7GVejjMyTV0QbXVYc41sSAYZP5j6DZbYmF8DLnymONMspQBdRrz9+q+9F/N4+u72faY9a8frbF9aaryUhMIHk5Htiq922F/Jf5yjT+64Q+cr4+w9ojgXjm2pZtXrmOjOw5+KGkDJz6ARBBdC5MBez3670Lj92Xsb5yhBKzTygJLVhmeYyn4zxeYv0GEFvWnx6N7xfaW9NA4ZX8883MUiBP/wbWFH+THf1iE7M3bhpA7hL+6b/06b512kOj/jnwwurl1T97jwb7O3NOywF8y8fy1XNU9WYSxhZ9XQ8xFq+rUlKA==
Received: from PA7P264CA0269.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::19)
 by PAYP264MB3487.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:126::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:19:19 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375:cafe::c) by PA7P264CA0269.outlook.office365.com
 (2603:10a6:102:375::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:18 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 92CD820934;
 Thu, 28 May 2026 10:19:18 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 02/15] mbedtls: enable support of ecc
Date: Thu, 28 May 2026 10:19:03 +0200
Message-ID: <20260528081916.11355-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PAYP264MB3487:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf860fed-82bb-4162-5d43-08debc91d086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qTltMuOGkk8bpVoayOqMkp3Prsww6NeKaBsWfPw0wpuHhE14Ur6TSSPYuKKprh4lf/2k7tjVdIWOZFbPlFmq0Ned1OBg8yUPycL9FuV3EpqCiYHBZKmI1HQjzKS0p860cy7XYoSRaTOtTtLcmzKGUWHh44aRGhBtS/X1EbRRPgDA8JS/rCjDlD8cvKplPx16/OOmTcpQaZQQ8gVw6zBTWuYw7WTbxexScd4WZLgTq/D3TiwchPua1Raf6ALP+eoStUTieJjnrdRRttTEZyg+5wtKZQIamWxfEwKfsw6j9CS81agFtutYc7ZoBQgWs+L55aXNoyR9BGPZVc5LycwD6yN3PWdxMJ/GVvF7fzyOr0/E5oOScqNuXv32+RiFXQpTxwx+NyLUoBaasH0E6zcrGvEWgNZG4S6KKrD8EU049tx7401Svv4GkayvCWg1a4ut+nvbmii3ENZ5ZSaKS8CVLxmkbrqIxIEKUp8dqgIaz/kL0Zt7D1xppfBryThRBr8VSUNBAv2zhmo3Umgy2NrEcxLNjIS8MpsVIfiu/Tgh6DixOQMsiFy3evcDa6NZM/PWZJJ2ibp7EvbBZpTp/5XfkBITs1BvGfDlLLMR/vjn0IZ3h/fwilEcTVOsRLURvupZnOIAdI6P5fvOrt13V+azRLLc7Jer79ejL1Fls1W6sRSJTxGc+9fjX7tii/OYBEQy2tt7RVxDSDzn5tIvFwwBKLOe17Q5mnIr22M2qGEPDpM=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jJ0W0FmJDzxnfbJXnsnIp5FfeKkzUp4QR4E3t2/XtwiZ8alZkalRnkUn3bKW5R4URIYEs+W1QkPDoYmVs8KkPW+AVAcPi0J8qG+0JaV8QbuIMQlAO8h25CjddaMUNIRXPw0Wvs2w0uRb8bbs8Ya+8SZ1xNJHKxqo3jD412Qy1BROMYyCt2opQorOtM+pdQzAPc3wjKQ0Xb8w2uRbArxmZVDQorxjWVqn5yUmC5zbm7Qme/3JEtnm1zgX4zE/QgOxkyYm9F6wScta8VMCyOGW/9qbj4vBnEAjZZs/Kq4lGOZnCnvHOzQ/CLR5PTKMv+kEmDMYJHMOUlDlepawMzuxewotmtYopbSmnk1q04IWRjGw1pjg4rxRsZnsesvjWOd7etABSwxzWYFQfQHCYfjb0GoOL/bOTbBuFJwJGU9nNPfF5JRRUWKaP4ZRchQaAeEN
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:18.7458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf860fed-82bb-4162-5d43-08debc91d086
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3487
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

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
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
v7:
- no change

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

