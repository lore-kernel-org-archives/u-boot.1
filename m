Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CC7F94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4978426E;
	Tue, 21 Apr 2026 23:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Kevc7S+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74BDE842FD; Tue, 21 Apr 2026 23:10:11 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595D7841D6
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZCXj3UeHp5bw8wkzd//ZTgAMezgbUAfyALvqKhqTjaCgUvTOlLBrvf4nJgCfzU6xcq0ROir4KLPIIXqG9wx+tuJBk57M1aQVUFm4/gSizomvYLzitLwyzWW6roQsZ7TG3tLM5tgNlYb5xKGiJHpRphysKulhKRnJwLx0nXZAynQmanh/DHTB01kLqhUOed0b3yuH/naNKLaSHrDzdk0uLxmf47yd+1EYJjxQufAEOv/xVVECI7qSSw4oJsAdSr5oa+rcNlcfryI4KYEpECE4yCL161d/LfLAIgQROL0lGa2GxmKptSEDRoOQCP0C6ModGdst2L8Btzgy5xKuIENxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIl6n/+34g6m6586OZ7bI7Ju89NpjzoxLDkjuaLiYdU=;
 b=gBpi1P8g1UmFsfEnRVYaGXtmNy+0dcja7VSl61Fbd8UZEZ4pgVS22iaN6xQUI05djk56UxhQT9AzjPFwMVlxm2b+ETp92Mrg8EkoPwt8JeKwkF1K6n4rhaUPya6NSs0NVR6Fk2NWrgxsmVD/WnJpVX6v6b0/8zDJs8dJmQetTrg9YJRnABexGP9L0hN6p2WQ4G9jokPWNMSgJXbJbVPVBFMeNfwMt2/bpNeHPcVu32GQm0XaCDpNJU33EY4K481C0j4OG2zA6B/OAU0uiTaxG/XQ/qeGO7rYTsYHeW6VcG4wHbszrjBIIx/Xkwu8CWnBYuFrS1gAv4rENFsWDK3jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIl6n/+34g6m6586OZ7bI7Ju89NpjzoxLDkjuaLiYdU=;
 b=Kevc7S+K612ngHP9oBD9PffurR1G+q/ugqk8v+/rpisIfykHqNY39T0opOxX5TvxRA90f8YfJy3uZhtgwivzOWeJVo1A8oLzNDB9tVbdkjrAA5H8IZwvLvyLxDecF9HrZu8hEng90BVLTUfxqH1XAIcy0lHCIyngNt26qUkBYVfLyEq2Q4nDTgRVygc1XIpOujaOs28RCfscFOC/WMEqJGSTSaj1am97sbr0MllZ/Rpsyz5v7CVYiO5b2GQz1xRvEyXywjDz3XzO2A68hz8ef75VCjLWE0tYAX/EGS6X5Qd7Pecxeg/p2oDT9pgjy53nJMzEIuELosBb5U1qBFg2lg==
Received: from PA7P264CA0300.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::12)
 by PAZP264MB2717.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 21:09:57 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370:cafe::cd) by PA7P264CA0300.outlook.office365.com
 (2603:10a6:102:370::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:57 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id D66CD2014C;
 Tue, 21 Apr 2026 23:09:56 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 02/15] mbedtls: enable support of ecc
Date: Tue, 21 Apr 2026 23:09:41 +0200
Message-ID: <20260421210954.1170437-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PAZP264MB2717:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf413db5-2819-4f52-caff-08de9fea5765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: /9qS0c6avfR1P5ro6ZspJOpiGohxhiSs7q6+kxQElI0fLeVgnY62SPuNxeuNovY/3uS1ELgmzaiKnsKnAfVYsMInBSAQds/7sqVOr5C4a7MtzOjFm7NA27S7i3pS9RktUQ6KpxFz0m5mv0CVxN9SwuYvfY5XFspSy2Mw3l5PwTV2JRxyKZWYf10uKUxMIAflm8hLTwoqfKfqGijKHoNU086Fvdm/pbKmTdtwpGC4dQEGVRqWVKVNneBARvYxzqxj7IdFVSQYMXrI6oapctNb6cnG5t11Lch8Djw6rmo4Il8C+Au0lQBPsXL8ZitUfykJKFwYkPTMV/q++647HUVFYnwWIO+N2EsgBoB6ALDeZI9VvUCffoWqsGdIR50EV2Oy6VhWoo6QKddpstVBIM2UfEidMRmOAbsUpFp3xNyxj8BdjPbwQTpuronRwj8V2yVTHkcEmckJsGNkLXlaohaT9gu7oX0wRy5XvtS281MkVDNgMpoIcarRijRDayaUTn3WIwMOoseR3F0SdkKjMS8kRR1fYrbVRAd6jVq5Lv0uONZN0gaR31LMYXTJV7hySNg9rltUcuJzZ+XO90dNna6eCYCWm7ixCN1gVOzUBXyibDTCCTYUsAh5z77xPXHR25zjhGCAOWb+dcuZhsjF4PsITV0KvUbLED9kUZ5C/1L+FTNpK4Ik99BF45XPmsq+nnmM8oMahHRlkvluCxSwoDor/RC7EuLt4q8Ezwy2to53JPkYB+26Jeb8m05tq/hwsxKiqxOLBQm8M0azoKPOzpnHgg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xwvXF5BeEpxFUFxOb3jax34f/C3Q3Fxk2Ktf0o5JO9BCQWf+NE7JBKDi1sO+48aL+vCHxgsJLKELfKhvIOs6fLk3fT/DfPy04CeCa4J6tFs/reFdaLR6teZBl4q/0y7kUDSrzIprsn4w6k+eyaAbuRiPk+LkodQhzlAXePdgvc/0oMVsm0unrtW2aD4wxT3MWoWeL7vbESzybNU4N9eDNvYy1qYxX/G0V19gTxHnFXEJszt/dGThtPv5i7N+eX2clGcMwkbVE+NiXp2rFBbxPvXPzCK70Dq9OSCBQWhCZDoCWPtC2MBceXkwF1s8hVSzsz/Z3BVhG4h1AdpcM0S9dirz2sdzCax21D9Qrzhh9wf15rVGSdGkr6xXISQs4p0Lv/jkWgOvq0AIB5gPh8xFZXzwv9k020x563el2DjpIJfovpHJnR4tLlhVXMDsxKH
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:57.0157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf413db5-2819-4f52-caff-08de9fea5765
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2717
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

 configs/amd_versal2_virt_defconfig       |  3 +++
 configs/qemu_arm64_lwip_defconfig        |  3 +++
 configs/sandbox_defconfig                |  1 +
 configs/starfive_visionfive2_defconfig   |  3 +++
 configs/xilinx_versal_net_virt_defconfig |  3 +++
 configs/xilinx_versal_virt_defconfig     |  3 +++
 configs/xilinx_zynqmp_kria_defconfig     |  3 +++
 configs/xilinx_zynqmp_virt_defconfig     |  3 +++
 lib/ecdsa/Kconfig                        |  1 +
 lib/mbedtls/Kconfig                      | 14 ++++++++++++++
 lib/mbedtls/Makefile                     | 16 +++++++++-------
 lib/mbedtls/mbedtls_def_config.h         | 17 +++++++++++++++++
 12 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 0f4b75c72e1..cbc0789d5b3 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -167,6 +167,9 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 # CONFIG_OPTEE_LIB is not set
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index a974970c3d3..151506eaca2 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -3,6 +3,9 @@
 CONFIG_ARM=y
 CONFIG_ARCH_QEMU=y
 
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
+CONFIG_ECDSA_MBEDTLS=y
 CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_NFS=y
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
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 74a24dfd074..77b3146f6cb 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -156,3 +156,6 @@ CONFIG_USB_GADGET=y
 CONFIG_WDT=y
 CONFIG_WDT_STARFIVE=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 3410b874a04..90c04b98e0d 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -155,4 +155,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index d5d60d7f87d..bd3e368d1b4 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -170,5 +170,8 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 72a4668b448..7a741416685 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -221,6 +221,9 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 1433b63979a..7dd73c48c1b 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -239,6 +239,9 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
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
index 789721ee6cd..e948a8876f6 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -247,6 +247,9 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config BIGNUM_MBEDTLS
+	bool
+
 config ASN1_DECODER_MBEDTLS
 	bool "ASN1 decoder with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
@@ -264,6 +267,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
 	bool "RSA public key parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser.
@@ -292,6 +296,15 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ECDSA_VERIFY
+	select ASN1_DECODER_MBEDTLS if ASN1_DECODER
+	select BIGNUM_MBEDTLS
+	help
+	  This option enables support of ECDSA with the MbedTLS certificate
+	  library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
@@ -300,6 +313,7 @@ config MBEDTLS_LIB_TLS
 	depends on X509_CERTIFICATE_PARSER_MBEDTLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
+	depends on ECDSA_MBEDTLS
 	depends on MBEDTLS_LIB
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..a24c8389744 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -39,13 +39,20 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
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
index dda3f4dd6e4..d1bbcaa0924 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -89,6 +89,23 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
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

