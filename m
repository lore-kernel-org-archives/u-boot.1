Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4E1F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6698784262;
	Fri, 17 Apr 2026 15:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="K4SfqWrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37B084372; Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD20842D2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI2LEY+LyID3p0Wdehz9whbiGS7N1JpotGa0kUFnP3nt3gUsrConx6sEjX9xvcUTj5QofmOhOQbghW3tAg8myr2dRXCa66Yr8xJrb32Qlldg2jCDadvaxsTBMCVf3tdq6/j25nBGTRI+JTTs+eD2wQFUDo9gPuRCR1+8GyHECxFlC/nPI+V5aimSLrUvzew9yR/YQPqsqT+xfEy3rlFD75YOyCKOMbmUm0+BEivESy6gKXL1b1FQQ6cikbEMaZon1wGzYPjcRvSas995w+lpq3i+E5DndPufM1gWbuMnJUW6N2ihyCHy91df8HUv2IdhK19AcZj3wNwKvCykT5obcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHiwgIDhZsQh8CZIab8OGibVBtqLbCQ2Eh5ZrcjTAS4=;
 b=rmpMuBNJ5oFbl++5on6jqgNy0O+JW29VkSVWw0FfCbXeltBQ/LjZn1hC6+jVeoLtkHheoi2vOqgqCUysAwA22a3OIDgSn3JePP4jxM9yn3YJJgsc9usJJJdzt7YpjDcbyqWXpAqkhkaoLUUC0pwA6rn2l7cCj9+ycSyprNXDJGuYXmDL+5jtV5GATY82W2+p8ipRNIGT8+af67akh07dpreeNNlbSJ4Z3j8DrMaY2NbkD63hnPmI5UcNJGicnb2sOhPpVBlGUroCVISOFww11P9OfrA0wiOGvhHXI7OrSvYfYo4jEAJYWZZonePO0ZYkG0dYUIfZ/3IU32E+BR6zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHiwgIDhZsQh8CZIab8OGibVBtqLbCQ2Eh5ZrcjTAS4=;
 b=K4SfqWrTo0kOPPSBRpaBlEW54CPdOfau/0hgqCF42QJftXrFu4FUv9KOXZh8T323qRKkT/XoRrY93AS7TvnzPua/jd+eiqC+LNUQ0ZJ68aQRguFXDn2MgzG8JI4aKNUTywGp85noe+elDANKIBDIHLWWfcYLycgl8BWw4Q5t/JLeFF7rQKOBmFxgRzkVbeAEXFScS6FzOpf4NIDxJ7znMOWcDh/jaqnkDJApb6pdU4u+tIL2uNGvexz6YYqKMSqwUWkL4D1iThjhkdabAu5Y2URxxe6CLklvdIM06m8gun5ca0S3mwjy5F+iUY22TsJeRKq2lSz6wwZbkgWzJnnTvg==
Received: from MR1P264CA0032.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::19)
 by MR0P264MB5032.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f:cafe::5) by MR1P264CA0032.outlook.office365.com
 (2603:10a6:501:2f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:09 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9965520AC1;
 Fri, 17 Apr 2026 15:02:09 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 01/14] mbedtls: enable support of ecc
Date: Fri, 17 Apr 2026 15:01:51 +0200
Message-ID: <20260417130204.49896-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|MR0P264MB5032:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c53c674-987c-43a6-2cfe-08de9c81892a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yodjJX63BCwT+V7Q88uhllg4V/RRVeZ9yNwJsBe28rdepZRHUDlysFJdMuLKe9I8yzCmKZLCcNzxZ8J2khOGgxttDxvNmeCiwUOoCSSuc82zXrnKMyZoTfiTw5lFLGHEVPAH2yBF/krdvNdASaU1x0VYbg42tnAGmXNx5UUKKuJFoAVehmXK5mwejeO7sMPcVchuoqGRO1ktTlwAC35xeDHszUqks8fYQUE55oMBAo/aDeNZJu9Ia89T2EHVvyx1RXADl1L/qidKgxFR5aa/Tc9D3TlrnXa/y2aX4vCu88NIC0oWRXj2LBDFlq/AxipdK+gUF2ggj9q3xGpjBe94z5Ii0GEpOWe8U9VMhkde4JyeBDkbWmVPFrQopOfH3wcnpEmQtjWc0GdzEMZLJynNFwFRCrR7gA4DmJftlwRpL/H7UNAI4R7VqIOj9LrVN5iFvoyFbo1apob75Jzyw9hqUwsuVkxSxv27JbcsPPUGaXNHnJrDjBJhxQ+IIu6peBBvxWL4oxhDPFjsV3acb5Glx2peFV0Z3VZd0Vm0eNM7OW5Tf2W1f3S8oyAJKBTX2LFeTfKsxZs+fbt7B4yMV81QP0Z9DDd29/5pMFsTb8LZObwk3O+0SbKl6TNLxWhTsEsh50/g1bwBNpSm4U9oDJLqnmXdk9wx534S0hDgaSSZlFvYdoBsvG8blkO0ICphV8z2E9ydqOBJ6ASU+GWAJfHvUoixdN7swGcEnmtLx9M6KHd6bK0aayOpAD/ujI69HdDwpcuJBMPXJ7VOw4j7fK50FQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GMFahesIvEeNaKKafPHGliNqLVgjuGSb4eoOvnd3yssmqMfc2oYmY/zS9mgngnkSIJODR7AwJgO9GV6pA9LbiVVtP2Ho/UhUIntQq4EIjQDQ9Vokn1z9IvJiIqF0/Itsi77YotiflOpcTDQwGPnjHKYa2vE+HCu4TiNSmPz9ld0HLAaCiaWcxZ4R7D3UflW0A/akcfGWJOoVwh1339taTZfNT/l811Rb02Qy+sU0xz24m0Sg4XvxXjTISHBZzfSTzHl0XfTPmqabOQqYfx+bL/eg87l+uDr0g9yhZnft0aaMn606Sz2b1XXRaV9BBVqV1JWRE/MpWNd4eS0Vi+/gKda5orf6gp9w/BnNCg3GTDeiOxsAgGll337NSTL/OOqy4Ag2TmypwPCfuCU3gsKJfawn1Geyo2DWA2bH5sSn0QI0MdJRqfrBC7lv9hfEoWz5
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:09.8476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c53c674-987c-43a6-2cfe-08de9c81892a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5032
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

 configs/sandbox_defconfig        |  1 +
 lib/ecdsa/Kconfig                |  1 +
 lib/mbedtls/Kconfig              | 14 ++++++++++++++
 lib/mbedtls/Makefile             | 17 +++++++++--------
 lib/mbedtls/mbedtls_def_config.h | 17 +++++++++++++++++
 5 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f26295103f1..15831dd7e04 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -391,6 +391,7 @@ CONFIG_PANIC_HANG=y
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
index 789721ee6cd..cfc47152fc5 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -247,6 +247,10 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config BIGNUM_MBEDTLS
+	bool
+	default n
+
 config ASN1_DECODER_MBEDTLS
 	bool "ASN1 decoder with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
@@ -264,6 +268,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
 	bool "RSA public key parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser.
@@ -292,6 +297,15 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ECDSA_VERIFY
+	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
+	help
+	  This option enables support of ECDSA with the MbedTLS certificate
+	  library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..aa1ca6d196b 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -38,14 +38,20 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
-mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
+mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o
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
@@ -64,7 +70,6 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/mps_reader.o \
 	$(MBEDTLS_LIB_DIR)/mps_trace.o \
 	$(MBEDTLS_LIB_DIR)/net_sockets.o \
-	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
 	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
 	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
 	$(MBEDTLS_LIB_DIR)/ssl_client.o \
@@ -82,8 +87,4 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/cipher.o \
 	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
 	$(MBEDTLS_LIB_DIR)/ecdh.o \
-	$(MBEDTLS_LIB_DIR)/ecdsa.o \
-	$(MBEDTLS_LIB_DIR)/ecp.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
 	$(MBEDTLS_LIB_DIR)/gcm.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index dda3f4dd6e4..239215ecf85 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -89,6 +89,23 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA)
+#define MBEDTLS_ECDSA_C
+#define MBEDTLS_ECP_C
+#define MBEDTLS_BIGNUM_C
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
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
-- 
2.43.0

