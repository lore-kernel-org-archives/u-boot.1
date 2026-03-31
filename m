Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35046FF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F08840BE;
	Tue, 31 Mar 2026 12:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="lBV+Dgm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880DB8407B; Tue, 31 Mar 2026 12:00:57 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FDA8403D
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUI85OWPBQ7XUoxbZgot80krgjQ/ADfLmcEsGyitafrsJOvV4zI7nxPxaYjsGzSMhJlqtUF+Ynaw8Dc/066kKaf+WsiTTNErurCLus4GFUHBb4tojrbNYmrW0K5K/5Tl9vdM6edAPSY0Qu/exrRRGOQyRktDLZnRUFYiSCYPt9kRP6I2fcJfWNo3fpE6G0HwGfrJeIld+1lRYakEYQlejmPBISU9EA1FId41CGheE6S2cvUrKFRBRmeID4ZM+NVEW0istb81MN2GNTXUvxX9GdskFrtphPxCMqFyOBU2hZJmYn/wHdHGAhY9yLR6nl8dnnV9HIIc7cm3dD0CxeKQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLOg1B9Keon0ZtfJqPU+ORSOP6GeT9/pCTaBwl2wG88=;
 b=CDMSlOpDv4LnwPaSOC6DHqTLPjjZqJKPUZ0Q6OKFHn8m9s7hU6Q53B0247nPFR+nd3VZc9T6/8Xb5kHeI6O8dqbC2tGFBjTryDO/5+iio179LXfpceNTalGGhiGqp0u2cVQ/6bdYD7tbP/+jUVrK2Ljm28iL0CtjBjwu7HRtsfCobQcozjKr3mGU/oE9eAZcupG/wyuk4YRK0++o0876U8kzvgRpsiBv0VX/2dlYthuHk69DAHp0f/oeEHG/TfyyAy0P+oE9mhHnK3gMuIVdyJqAjHg9XiKfS3BVTiPR++CuTJdP+LwC6LDS5WShypFetegZNlXv217vjN2V+FDgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLOg1B9Keon0ZtfJqPU+ORSOP6GeT9/pCTaBwl2wG88=;
 b=lBV+Dgm0pgDdBZ9Shqf3pVVNHf0JBE9MJFMXpWTxt7opC834M24xzzPqvuhGe/a5rzjoK7rXDzmjb+2CxuqIw5QfGaCUHM9JenFu+U8688bRUsuO4tBWdDADfbSoSgz6Yk5bL9x5UXlosEN42DpKEGk3043eZ7CipXv0ms2pyjm0y4pJmkqT+fynvXtjydsXmrt73JUNgwsZG1duI2DybbLfD6bJtKaAZ3UM1dnqHD4m+4MyrD3rPImTsn8Sq0RMH5/XUnXlZ8zbES4Q4ybAbyGEVSbomwD6B22BEjatbDd8ZdLqPtt7kdmywLny0IZRbIr4mV5vqTr1zunlmxlcyQ==
Received: from PAZP264CA0191.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::12)
 by PA0P264MB6817.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:55a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:00:52 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236:cafe::c4) by PAZP264CA0191.outlook.office365.com
 (2603:10a6:102:236::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:52 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 714D4202EB;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 01/15] mbedtls: enable support of ecc
Date: Tue, 31 Mar 2026 12:00:33 +0200
Message-ID: <20260331100047.34618-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PA0P264MB6817:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 075f7e32-63f1-4475-98cc-08de8f0c64c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z2wNO/8qgRyqpP51HlMRD5pdUdP3dsmCBeYykTUUrQ2HLkbmsMQZCMAsq6vuATLLw4x69jN4k21jRBuPhyFL4MYUAsvSpA6sQwYOZF48B5uHHkjPQZ5ZfYi5qgJxX/wVxn4Im98ujNIkY3RzKXj2lIQD56lVgeVoik2OQzYVuC3cOqBuFltzgxxegpdmVIGiCCI2iYU1QUXYWn4188EwHjKCJYtzyX0b6TIMFnyiWKbLOGh1qrKE9p2N64sXlj9O51M2apRDcRzDjhBuRP18u4XKBQ/R/S4MOYCHp+VmtrUjCbF0w6ZBubKEHMAFBHrTRvf2gKvr3iyFl2Tgf8jX7RC6B0kv2FR/tjzaTpq3z/EfcrXTkTi/j1/X49dV29F3UUwgwhKC5HK5Jiu7zLgMwxoIVmxizdKAwEvtnc85EsiHK3flVj1C0TFyRi65egKyZFDdrXfjIlZmXMO3ZaD9sTnZYIbpspVvDWnHEUgv2TI5a5lCMhFRscTma1xSEqc0N3apmSZhdgnsqkDCpUNyw4WF6EuAGpg/zuOWbIEUiAybDzWXJb0Y6V68+x3cIWN4orFSR/f8dMUtorVBghSOoXwt6GLFyFP+TqLbljvyML4HyVyY5xhM4AWcEQUf6gTfNWGdfbqHe/rVbN6P4siuVV5JzE/dsJpBjN6WYsWdUkIR9vWJatkfclDAmWOS1bNjWZ/IzpSuGO6kpeFemgpzbYb7T78RKA7UpkQzhx0bFhO8htmpvnAwfeDkpRoGxfzT9JDmeiEqvb1RIg4JbVUJHg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GUNF3LWn4KkwiNuhcgPxJ3d90HQj7GI8h3mTgfsceKeY6PhnZuDBZQgZBlK8HMzZyT440GSXq0F5Ab02RXQI2VIg5d+s9qLZGQYIdDHf99P7gYEtjdEou1OtuizcdvCvdy/0OQx0eCIF7QGG48671cDG8aZchsp05bOfXj2NLxnBkFxQOOjDwXNlTOw7PMcjEuSPLXeT0bUhkYaZQUp+vukDsimzxDx3O2N/OqxGlkJNJNQgAI1VTOQ6xMjrXqYMTG2U3hUHLu0j+h1U2Ey6tn/VEIYOuTzfnhN0Nalh5rcgPweJsbFIL0C9q6Xee48+ROY/y+Jo3OFGG/jF5G4XnTHb5kcgG8N751ZBfzwIzMVexIMXTBqsTQBiIHuQbrEXNLe73hwOMvYU1rACHPa7abjzbGgHGLvI1IgM/A4ubIMO8JnhwoAYFsungscl8oOR
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:52.5884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075f7e32-63f1-4475-98cc-08de8f0c64c7
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB6817
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

 configs/amd_versal2_virt_defconfig       |  1 +
 configs/qemu_arm64_lwip_defconfig        |  1 +
 configs/starfive_visionfive2_defconfig   |  1 +
 configs/xilinx_versal_net_virt_defconfig |  1 +
 configs/xilinx_versal_virt_defconfig     |  1 +
 configs/xilinx_zynqmp_kria_defconfig     |  1 +
 configs/xilinx_zynqmp_virt_defconfig     |  1 +
 lib/mbedtls/Kconfig                      | 16 ++++++++++++++++
 lib/mbedtls/Makefile                     | 16 +++++++++-------
 lib/mbedtls/mbedtls_def_config.h         | 18 ++++++++++++++++++
 10 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 0344089030c..702bf28405d 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -164,6 +164,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA=y
 CONFIG_TPM=y
 # CONFIG_OPTEE_LIB is not set
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index a974970c3d3..ab6302b67eb 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -11,3 +11,4 @@ CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
 CONFIG_WGET_CACERT=y
+CONFIG_ECDSA=y
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index a754134a313..508bd465704 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -156,3 +156,4 @@ CONFIG_USB_GADGET=y
 CONFIG_WDT=y
 CONFIG_WDT_STARFIVE=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 323b5606566..8b760beab03 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -154,4 +154,5 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA=y
 CONFIG_TPM=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 652121e27a0..6dd8620cf51 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -168,5 +168,6 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA=y
 CONFIG_TPM=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 8ad05e37189..d23452e96d0 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -219,6 +219,7 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index bb79ddf989e..01370a215d4 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -237,6 +237,7 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..8bf8809198f 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -242,11 +242,16 @@ config MBEDTLS_LIB_X509
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
+	select ECDSA_MBEDTLS if ECDSA
 	help
 	  Enable MbedTLS certificate libraries.
 
 if MBEDTLS_LIB_X509
 
+config BIGNUM_MBEDTLS
+	bool
+	default n
+
 config ASN1_DECODER_MBEDTLS
 	bool "ASN1 decoder with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
@@ -264,6 +269,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
 	bool "RSA public key parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser.
@@ -292,6 +298,15 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509
+	select ASN1_DECODER
+	select BIGNUM_MBEDTLS
+	help
+	  This option enables support of ECDSA with the MbedTLS certificate
+	  library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
@@ -301,6 +316,7 @@ config MBEDTLS_LIB_TLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
 	depends on MBEDTLS_LIB
+	depends on ECDSA_MBEDTLS
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
 	  in wget
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..5433e17cc64 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -39,13 +39,14 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
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
@@ -57,6 +58,12 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pkcs7.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o
 
 #mbedTLS TLS support
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
@@ -64,7 +71,6 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/mps_reader.o \
 	$(MBEDTLS_LIB_DIR)/mps_trace.o \
 	$(MBEDTLS_LIB_DIR)/net_sockets.o \
-	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
 	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
 	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
 	$(MBEDTLS_LIB_DIR)/ssl_client.o \
@@ -82,8 +88,4 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/cipher.o \
 	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
 	$(MBEDTLS_LIB_DIR)/ecdh.o \
-	$(MBEDTLS_LIB_DIR)/ecdsa.o \
-	$(MBEDTLS_LIB_DIR)/ecp.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
 	$(MBEDTLS_LIB_DIR)/gcm.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index dda3f4dd6e4..0c8449afe6a 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -89,6 +89,24 @@
 #define MBEDTLS_ASN1_WRITE_C
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
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
-- 
2.43.0

