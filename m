Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2F5E7DF08
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 17:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD2983F4C;
	Mon,  2 Feb 2026 18:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pnBWK5wv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB8583F2D; Mon,  2 Feb 2026 18:05:38 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F334783F32
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 18:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWUT4Yo2Bw+yy/tF0NUgU19cPw22x4tQ2ikk0n1iCj1Q1ZFw3X/wZMybRY0Pwbe3ziD8SuAP3Jic2Ef3F8wKsoc1b8aoSW41GPXsJNQ8VVKi4fNCRsBqMPv2xdgdyCjUmLQl5RSCLS7tn3gsjLc8OVdEY+Il9B/cB2rmdjfn2Rzzym6MiFLxauQyUqWQpipG9zGg6H6TinM+dbVh1UncF9ussWcRo2lgXpCHdugDbc2hunIKbEvAFDsEyJ7V6zGgJfx7hysHgWCkX3WJLeNJUV8Qy+6eQzvCtdkw/g5XO/SnDRFT7JuVK/7sMgPEY66oUwWHTIKEvnSqmr0FoWjcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OazUJM/NUp3wm0TDS06DV+v8cYVDQ2EkQESnQTs9UVA=;
 b=iiCse8DSy4ilyMZp/2DSMMaBhzk724G2bsm7rt79+wWfMdIlaPghy/I0me18/UH7bDUPR7cMstC7qkvQk6P0z9JyVVZX71tyurN0mg4Md9LMBSfL6+Bek6IbyzeSl4BTtubTbM6nJtKhCA+Q932d3Qnmz4CU6em/t53yllQIRXB/YiWrKSXfi4mAEMcI+JNUlvLZC9gPI1uclVO8FmTFoQFrOGwKLLQ8xRITXlGbFQMNL5SZmMZf0irgJvCOMVJF7Ii5UxDrOtmjlA6YLWVrSVo52k2YnBRFXPvdjnMVlHY1IQ4YioHRY9C0U42SDVUirJPMLpoUu7dJYMLZmcadug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OazUJM/NUp3wm0TDS06DV+v8cYVDQ2EkQESnQTs9UVA=;
 b=pnBWK5wvIY6sbUmdrxtCGiqey4kJcARb8oHN8kmnVVthKqbf+PzXO53QQGjmlHKE5BanN4Luyx5K4tsxFWJKR2F2ZSuLLfZ65PqKk2jqYRY+yHBt/TEdCwIpwuPdjXZMurkNAVIq/Nsd5h8z9e1huKntEwlUdw1Qf6dqB1tbWW8kfBZEONOrKxgdwn6+Xdsu2UOqYIj9C5JK8rkdl3GLEWXI9ieHYAs9D0BXLD/zGBjPAW2E0HKF8nK2FIxBsi4kUZ3MYO101Q9WMdDEduIHkEDRyg8Nw6QCrDx4qsuOeXvPLCWomff7Mf3iATO2KEtnYs9VG/StzkWJrjbWRupWKQ==
Received: from MR1P264CA0125.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:50::23)
 by MR1P264MB3476.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:31 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50:cafe::ea) by MR1P264CA0125.outlook.office365.com
 (2603:10a6:501:50::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Mon,
 2 Feb 2026 17:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 2 Feb 2026 17:05:30 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id A294A201E0;
 Mon,  2 Feb 2026 18:05:30 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi,
	jonny.green@keytechinc.com,
	raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH 1/4] mbedtls: enable support of ecc
Date: Mon,  2 Feb 2026 18:03:04 +0100
Message-ID: <20260202170307.217200-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MR1P264MB3476:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1f4fa4b-ee1c-4722-7380-08de627d457b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQqL9ERE2GUrGp4+ZQcJx/QWn/N13mQ9vl6aEnOFpQq8b+s4oVwJMt0l3zju?=
 =?us-ascii?Q?Y2Ck1vxVLV5QLvhUoddyjbM+jOVXlaFVCg2LRVCGnYiqGRtx2F/f06wcJXIg?=
 =?us-ascii?Q?jEfx0UHyEQYWjwIPknbF2Y1dtz580dXOEUava6YFuKWIOhtogVl1rcveRKF5?=
 =?us-ascii?Q?zyJ1FfWMdRRjGJOreYA8ZKciwD1xb1J746MNdorfOM+19ELJud/rR1e/W5RI?=
 =?us-ascii?Q?QyOdyWQicOQc0kr9fCPKEtVWaKpSB+3ohHTTS5COtclf0v7WNni21/+Lrw03?=
 =?us-ascii?Q?bnkqj/hkjUu/GJgEyhmUcUkdl3+opIBWJ/6kKf/fEfgXXVkTva47LSn08Vz1?=
 =?us-ascii?Q?DviWI/W7ranazcBJKdN8ZYEjiIV7/GFfQwUnJ/tEDbo6kVGj5022FYfoCVxI?=
 =?us-ascii?Q?zTwR0jA6B6GD8CAp7qLjfCPOvNbCkYCcQMZ3uoul5oKBHlc9lGJNxci72trs?=
 =?us-ascii?Q?czzsvGZj27O1I7AzR9kh21KF0JRLtnyctNS8JpekMAvl1qU+Hmq41VdkTvRi?=
 =?us-ascii?Q?VsfL40NxdNQ4Pf1GPHpL+XB6CXfcHbaI5qQ2g6iBKQ5pyoOmwHouXDQt8Fkp?=
 =?us-ascii?Q?ZYvrmaKpm5wbuo13cbyLixSWkQ1oqsbWb27ULX1VJA+VmNfEpAi0rKm+dLUC?=
 =?us-ascii?Q?zrJIEvvgsuN1hxdn6+7xhNw0UaB30O/l5MwcRIUUUqJ8oaETPqiAyzwrj+PC?=
 =?us-ascii?Q?9KbQtyUs3yAEnuW21d7brGW7qBCJ5DKMFzBIskDcI2LRJp+fMAPUEAYBDlKh?=
 =?us-ascii?Q?vdlhkFznZzo6HB7WCawggGqT4sCDMnYfhZkVTZSfVTpo/x+yEnptBxG6Pz3V?=
 =?us-ascii?Q?eHlWBxw2nlT/zaCw45IoYlQAYRtk+TonnDE6rPq3pMDsrMUMFQLnynBZDiH5?=
 =?us-ascii?Q?5icXOk7sl9BMvRtmc0+2Q6TCwDLwuIZzUM0MS6dyHBMkUhmdZlkfYEIdJ23E?=
 =?us-ascii?Q?xJjHbDxaJt7B5HxVxR3nHXxNAkZxI3BApMS2yxjslx+kwWdZ5/bDmjwfU8lO?=
 =?us-ascii?Q?XuOy5Uf+w+mkTPUv5EVjJ5iZlDav0EYdeSvHYASZrFVEaCiWcPd3S4J5quW/?=
 =?us-ascii?Q?wB+VWASCzRakUv91GRh5lrc5V6Tk4t/2nZkazEfJjdG3W4by0dkSiIndwbcx?=
 =?us-ascii?Q?ioR2TO7XSpgjORCEpsQOGFVpfo93aWK9/s4jhgbUji4x1pbqgX1rmw+zNOSX?=
 =?us-ascii?Q?hmg6Xs+aT5NGFSg7DiJuJBFsV1cX5qIs5Nb6fYD7731Ps/0On9NuaJHDEO6U?=
 =?us-ascii?Q?AagXy34onyt3GG+xB2kZ1N9cWbOth/7YRWTyzN9ob9Cqe6EVYd4XfbznR1ub?=
 =?us-ascii?Q?XP+nvubLfaHzmLMu43gGQnFtBszCrO5gAElOHGBI61ZqdAJcX284FsOlxfsn?=
 =?us-ascii?Q?JQh5NWTrxWy6pGOlNdsKjRNr44b9Zptz2heq6cd5BZXaeAcVeLQ99N4n4cV2?=
 =?us-ascii?Q?7AxepFrhJrro9S52b0ecx9462OgrPIDGBOVvoDRLVKftF7/LNH6lA9qIleum?=
 =?us-ascii?Q?KLz12UqxoLNU9AOeETaVcq/x9dEdH+/PTRlBO1LVNO/PwAogDICHeG1VkhQ4?=
 =?us-ascii?Q?dLbopwv6yb+UWTSLE9SEn3nyoDiumzWgg4Vrif+LvYyrtA1AdbU3usbH3SzZ?=
 =?us-ascii?Q?QRY7k9H4678SLM04lGd42V/POBeWjAzBqiuwUrfTLrJ05nZOMz+iJnfMpZJc?=
 =?us-ascii?Q?jGfLEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SBryuEyX2pwQ7VhhIu9z4xZwUttlfsSLGw2D+NkbiGWbgwVzbEV2bT5tuDRmHxxGlWgn/Ue4Ui/JIRVc9ozMkt5p2p/SeatA7C2Yhns6b0rMoS5puO3hhhDlFU3IjbFNK3xTi5B0pQTnMrXzGsZ1MmUEQgnh6m6trT2L58TZnLBoeUNggaMHwCXaSlR0tSP68eUj2/xrA/DWL3HKeHOrbKoGyUZyLswFk0qLBrQ8WjBWDl53FOOBpKOB0OFTDb74aJbjZEJX2x3r1pvwo2Z320E8AXi4uL8W/yoLzcheuTHVycqJbRR2I+AUTyObcWY45doeGrPtMqayrFvr4hzKAC2dntW3NbQ44WHe5L26VEZQyo1WPngfCFimgi6xJ4VKXSBbG8ONxGVi9M8eKOmUC7gBJElm/To8Khzy57ZauX7ySdQ1R1czSZo68y0ZfX8r
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:30.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f4fa4b-ee1c-4722-7380-08de627d457b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3476
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
 lib/mbedtls/Kconfig              |  8 ++++++++
 lib/mbedtls/Makefile             |  7 +++++++
 lib/mbedtls/mbedtls_def_config.h | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..90c007df850 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -157,6 +157,7 @@ config MBEDTLS_LIB_CRYPTO
 	select SHA256_MBEDTLS if SHA256
 	select SHA512_MBEDTLS if SHA512
 	select SHA384_MBEDTLS if SHA384
+	select ECDSA_MBEDTLS if ECDSA
 	help
 	  Enable MbedTLS native crypto libraries.
 	  Mutually incompatible with MBEDTLS_LIB_HASHING_ALT.
@@ -231,6 +232,13 @@ config HKDF_MBEDTLS
 	  This option enables support of key derivation using HKDF algorithm
 	  with MbedTLS crypto library.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && ECDSA
+	help
+	  This option enables support of ECDSA with the MbedTLS crypto
+	  library.
+
 endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..54a893609cf 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -35,6 +35,11 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha512.o
 mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/hkdf.o
+mbedtls_lib_crypto-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o
 
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
@@ -52,6 +57,8 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pk.o \
 	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
 	$(MBEDTLS_LIB_DIR)/pkparse.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crl.o \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index dda3f4dd6e4..8f366c744a5 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -60,6 +60,24 @@
 #define MBEDTLS_HKDF_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA)
+#define MBEDTLS_ECDSA_C
+#define MBEDTLS_ECP_C
+#define MBEDTLS_BIGNUM_C
+#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
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
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
-- 
2.43.0

