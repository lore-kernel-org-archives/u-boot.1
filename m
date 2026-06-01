Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDDFCD6E57
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69D88498C;
	Mon,  1 Jun 2026 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="fkAhpdK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BEEE848D7; Mon,  1 Jun 2026 15:43:24 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E026384942
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqRa3k4mTCPoKEkAt+cyYfc8O9EoYZa7RZ9oYIIohpJHUiuYsSyE+Wu1ufs3knEKb9lLIsjbuvoufe2fRk1B+waBG9rttRqNf75oUuZriDhawChHr+dR1lsEyoQVK2PVbm7GtwtQC3mx9EVhAQpTT/i5bVWlv19c21x/1GWozJpD+ArRpNdgyHfsNynM/EwxyFfEL9jw7mi+YHOKIDS/p93zh3lijbJYH9U58CzvLK1z1b4E4FVFvAOd6AyhngRSvpWOQSX8X/Lwko6zkwgw7YJFleTNz7aLH0qN5CIWlmEPDUjOj01/7F0KF45eHjH1W/fc94llm+AoFw5QRC53/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbwB27kYhj4rhJReA5Lm8hlwsKCrYg6V1NOWFxQ9lmQ=;
 b=yD7WfeJvU8s1Ju2FmMHcvnTHKD63buakj9oQBFEqGAO4q1CNdN1HgtBZxpyICgkSMM8w7kOwPC7gf1pM26k2n3HN402Vo/y/U1tDEo+5XvX4yekFJsed5tH99dNuUAi775VzexGaLt1e/pEP0anmFsF3vWICDdV901vYRV4+vsZ8B2q2gVio0I/Nawgzp21mv9re9SfjwiZVPJLBHL4bp4PkBV44Taebx7UXZJb4/GSwpuZBEc+Q82Zpvau8mti+dqK915B5TbPSJAffUncueSJTIVsw6ALyC6FlaNcARS4ptbCwg/opuTUxyXZXxCFGiQjPSMlc4Kvge5W2r4tlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbwB27kYhj4rhJReA5Lm8hlwsKCrYg6V1NOWFxQ9lmQ=;
 b=fkAhpdK6bmW4z6yEbzlrpjICEjWShMwzJhe8pKRGtqrE9VJUgRC9neyhiQtty0Zz7RETXLlZc0d3yeYpjrFnjQujEKnl7G5JzbEIP6Wqir3wZ8ZeBxKuBHuxqceAlUTOr8bxawQjI1Hf9XirW954BE4hyBXFmgWijBOi3Ngbq9xVVqqAwxeLr/N8iKatSlCY8xxtoImXg6Y2HHEhjrkCXBQB5EFZfwXAUbD3d4hWiasRRylhu9k8iNrGB+frfH08Li1ZVSB75rpPAILBlD2ukY36Bvftar0slk9FBIqJB/hn5QWM2c7cieyZ+mCQquWq40DdpRpIrlvQwYWP9Qlq7A==
Received: from PAZP264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::19)
 by MR1PPFBA07BFAE9.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::684)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 13:43:15 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239:cafe::a) by PAZP264CA0248.outlook.office365.com
 (2603:10a6:102:239::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 13:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:15 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5FAC720701;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v8 02/15] mbedtls: enable support of ecc
Date: Mon,  1 Jun 2026 15:42:57 +0200
Message-ID: <20260601134310.2452454-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|MR1PPFBA07BFAE9:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42f865d9-8804-4329-8b91-08debfe3bb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3CE4RSeqDeVFSRycY75/4cNXuoarQSdlNIzCz43MOiC08t7ZYDlh64bnCi8SBC5N4KWFodBDzelptwc3nSLBx8JbZiZiahfapTgmPkR89xdP13H8jF0+9TVIPHwZD3gchGK/kNJjHdrNOv54yIhyKzPG+YlMfIYG5+kqrGjNPExLSIs/m0QDqgN1X6oSwc7Gc4YmsKFv7QeRY7CKmx9BOOJ4C+NI46B8jAaT9tlJVBfEiKY7ZSqdoeLxOXUl01p/vHdZtkiU1YRVLOVp5gzYS9qVM4+aiXdWAZBsNl248p251kId7Bm3MzK+hIrEcMusFAag6XoHiHpmGFcHDo8DMt09K4vjqikTmjTaQjz2Yn2s3VqeZtROh/oXAsJLA29Ezx7oud/3I9nLmE4HTsAhtxTpIqmkEax4r7XDNtM9l3TSc/YqjOdKoBFogp+LPhKseCzqlN0cSJlZ/av/infB8SnDxZCztyREjZDN/B2al2pK8nbjv93nixaTTa2pffExCiCHBXoHP5ric5m4v1KWavdCj8Qm3run1x20wQf2wRNqI5FEkP3e+p0a+2rauonHskyNUCsXEP4d6/2ADiblrCeNRfHou5DBChw2hWbuinGb2sdeR68ArMYfsXJvoKivvrOLSDvmfJtYqDkDGxqV+7M6bZWMVdOwz4TTatAIpMOhobEBwNLyEGhFNMBZaijI6kiIntZmU0VglWU6BJKRnaJ6zW3UIxxvjuBT5JUE0vU=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yo1BYq1Eksu/mnJChv+GyflXjitwF9CdGqChFh6AWkJjrioym8ieDN+w9ryteKXvu4He49RcJ8TSnYnSmbj1PbPPFqodfvvtb7dNcHzQi2dqpRzDXIe6S+GFREVjmACcUcJNVMXfQwJRqoiBjd5M5tF9eQCWalrLuaxZ8sGYcaaVxVxInRncv8M+PPkWVDvD3MV/S/O2c64r+443DPj8y6xAmKy4Aa7+PoPSjzPrZryyO+ckgTA93/NupKxMimYy6Pgp5Re+McfcPigb707bvyiJg2aiC9KGLHBniYW8Za2Tk5JFUfAJ1RAmNAI9sofzL1j60VoHDwM0p6LoX7xnpPDRX4JaS0ogsCU6k0g2LXmb0rjbbCALL4KpK4RwvioOgfePeCMsrEOAZG4b6vv/X4w5SUbjishshYAouq49GczD2jq2jbw2jTnIuPyoogOW
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:15.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f865d9-8804-4329-8b91-08debfe3bb60
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFBA07BFAE9
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

Prepares the support of ecdsa signature check
using MbedTLS. It introduces the option ECDSA_MBEDTLS
to enable (or not) the support of ecdsa in MbedTLS.

So now, ecdsa is no longer supported by default in the lib TLS.
To get it, the option ECDSA_MBEDTLS must be enabled.

The option ECDSA_MBEDTLS only enables the ecdsa support
in MbedTLS, it doesn't provide any API to use it for
signature check. It will be done in another commit
by adding the option ECDSA_VERIFY_MBEDTLS.

Two internal options are also added BIGNUM_MBEDTLS
and ECC_MBEDTLS. Those options are used to share code
between different option and avoid duplication.

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
v8:
- enhance the commit message
- use /* */ instead of //

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
index dda3f4dd6e4..d55f31acfda 100644
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
+#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
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
+#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
 
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
 
-- 
2.43.0

