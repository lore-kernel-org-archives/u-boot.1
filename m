Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCAAE9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C23C83E96;
	Thu, 19 Feb 2026 14:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="O/51g8Sq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1BD83CD3; Thu, 19 Feb 2026 14:26:18 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA8C83DEA
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNzNGILJERcDUrAXSgPMWvJ7u1ccbhn9MWt6jELAUCA5IiUJtmceis1BcQ/MwgaJwt8Ak7v1y0N3R6rITrEG0l8oGsSs9StBz3Gv5Ff9DtZpu8e5U1pdfmOW+aiTvOxaB7Y9WnpaUlDCD7ddr3Yo75xfyB5Wu2AEiRFahloqUgiqfN7ajWP1nn4Er4mUyKPQEMkZvAEfwqoooed6ggInWLM0iyAiiJoCc9+aslSLrnxnPoqA45c4PfWSPVJwlUrGBUSFkW9mwjTy+9x37DsLilEY/YhkSEgOPTcxuxgkTc4vVF7hL7MOwpu4I2k2NLX5LiwwetzjA16XSTh9br7q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z3giD8NjH69kFh01k2Gbfl0i6/58ytVSLuYWqHiiOo=;
 b=B8MC0pLTw2wWrbUKkMHRtfRkBgvXrsAku14RcqjXCTHTviKEEviVeFzoD3HnujhHe9GgSuXXRjdiFEkjSvz7vONBrosAUo1X80OWnS3R30JptnYEbq0bAsvoi7BQCmtAsBqYLEHi7NFyDIueNksdPCwcsxw9MZ6TORE4EzEwDv7WSGFOaiXLrYtv+B1KQtU2nxbyXW4rV4bxhmH1kMsHWzoX3+2N2vEsykQtKRUmLskMyVUSnEJAtbpkTVP+stAXlB6DpB3RWiU1LH/1PKSGPBAdv8rAJKSz4fgDerpQGOG9EK9c2Bk5JFXT+D38rStGWD6MCzKIsAIVeXdQziHEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z3giD8NjH69kFh01k2Gbfl0i6/58ytVSLuYWqHiiOo=;
 b=O/51g8SqHCD81gJAesMp72agX2Nn0sXUCdve1mX4+JHxxkYM3nt9nh9JEEqsg5DZ1j4MI8MPV432nYu+EfHATVlBdEYIRtnalcdNuczELVc+hknY2Pp6/L3BfMv5lPkEzlhBUtZNui1ajmXIqVRkEHOIvULbaeOKmwFhelX8Rh93PHVYhWRY1wPE3v+/majXQHGs7pg8eAu6nCKHmeDf7vmyt4zNrmZsr6YBFwslc69ZuYxLbD9RYFUQ0q7KtSwxu5qFQmTT+AdhGRp3mmp4Mys7P46WbDXQ/aF4PI7yGm2E5WcWjcc8fbf6cc77piXWQ4fHZus2c9n7WNZpUS9jOQ==
Received: from PA7P264CA0479.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::20)
 by PAZP264MB2720.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 13:26:09 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc:cafe::92) by PA7P264CA0479.outlook.office365.com
 (2603:10a6:102:3dc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:09 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A033020159;
 Thu, 19 Feb 2026 14:26:09 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 1/9] mbedtls: enable support of ecc
Date: Thu, 19 Feb 2026 14:25:44 +0100
Message-ID: <20260219132552.1499698-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PAZP264MB2720:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9e35bf6e-2cbe-4f50-1075-08de6fba71da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xaoeBY2TIStRxzrQa/33qaYPEBvK+dMpsjIQ6NbWcf2G/3pgIUUaFxWyIAGM?=
 =?us-ascii?Q?jpLYKU1vYszYv1HpM8CehuUpZjTM2+EyMrJLGIyJmRv8ZlgTbBybc3AH2+Y2?=
 =?us-ascii?Q?WRL7y7iF2FSfXA6gV7h/eg3HaRr9ZLLgvkkhteLakCVBs1oaAoY/4NxyLJ8J?=
 =?us-ascii?Q?SPMCpOqjQx8TexA3+8WAgum8/i970Vn+9YM+qQQnafJi3RDpInxX8EzGH3LI?=
 =?us-ascii?Q?c2C/jRJ3XdE4Xx0EYti8vA6tjPh8jGJ+Mz7BPVDy7QffoMGunrPSG+QrgJ78?=
 =?us-ascii?Q?rAEP/Ov/yA/FCDINSrcEsD0EfMNuQzLc3rd0yWniWMKzY1GFuLQynzM1XHEU?=
 =?us-ascii?Q?CTjSzIMljnCk6mwbQoPe5KrTQsfgb7XDrFK2kzK9mCYiYBN8sTs/y6oIwqwR?=
 =?us-ascii?Q?HoMFaqhTjCn2emq25JQJe1QvxtyqFLaK7udFg0KXRanw3v6Ymxobx3LQRhlO?=
 =?us-ascii?Q?cAGk3Tnx3Ak4+Ntd3/sgvJjwewG1E3N/eGB9kajCafWTNH8HhyI1i3/3F6dn?=
 =?us-ascii?Q?X5EzaYYA1sdRNACJnnk2ZKbXLONXQjPHzWBZbnm6ASogaSXhyzvzmuDHwGUx?=
 =?us-ascii?Q?GE2cswaAAL1QbVrhaBwKUk7325mCGfvlbyfu9yFUBPCQiXUgbZR8o1rEucIZ?=
 =?us-ascii?Q?fPK3LbGCrQBQoTflmzEE1mWW457bi0MoJ/SjHkVxQOaaroMMpE1tcTSwiFBG?=
 =?us-ascii?Q?HV9y7vlWZRePPHd8S5NsP/b5PjM+XLi17oqZ7ro1W3L4DFgbNTfa6HSnKo0d?=
 =?us-ascii?Q?5l8STvVeJxOuZkXPzVf2LXKQEIyxCVnL1bWPQ+4X8vc+KyS+03B2wD9kFy2Q?=
 =?us-ascii?Q?ZaLtUh37YAnKG/QQ3a6cd9CjS7ldpEjgdU/oIgXYJD9PJYgA+/7FlnuUIkZK?=
 =?us-ascii?Q?0flGX9zMucMimb274dIwsCElshuj9Al6n4EDjTmoX6v+6YGSQno+djgHrjgJ?=
 =?us-ascii?Q?Metpap7WxPKbIpPqc0deIRG86cLXrJG3C4Ubj/0wzr4fySENSwYyQ1I7ZU8j?=
 =?us-ascii?Q?fyRg38G1pwN2x5kN7rrigZbGIVJwGRpx6ifsbqzOtXNdVB+XoW93QjFS5sNj?=
 =?us-ascii?Q?Mf53ViGy/BkT6AGcGVdhD5xirpa0IZi+++4NXnJ+r9GdFmqXmOPqsMUcMIBM?=
 =?us-ascii?Q?2ei6k4fLQ0Og4pf5GBn1rSRi09XtwS7GWsFxzB4AElM41Fad4r5sAGkpFNLM?=
 =?us-ascii?Q?zXDxv5GGntpSaCvcYy9vYgiUJTx3CYT5cxuWSDFJLxpRRDlpXzZOzeh2+pB3?=
 =?us-ascii?Q?ARLI9zUM3HN6LrrDD+jEiHH51VMNYYF9Z64glCEC0axFVvOudrzEVu1yz9ol?=
 =?us-ascii?Q?jahIwSHtot7slHEngZOkHejfceBmzZErviFnyB4ZorOGzchdUlOJGkzx0IR3?=
 =?us-ascii?Q?C++1hbv5g1aZN0hJ6tVvf7ue5syEzMjopTB2g0URnVZsvpPYZD9G9Diepekm?=
 =?us-ascii?Q?QQhAemsJz6AbVmBsUosiZ0ONCRelrClBocVRv19v4KaV77itZf3EDnNG4Q3O?=
 =?us-ascii?Q?aKOfQNjE6Meo9X9ukW6uXiSVJIygALbVvYJg0KhxXvZuK4QlcIlBOWZeA2EJ?=
 =?us-ascii?Q?aJFxV9449LvLUZW7ylI7rppFAGIOgGvzMen16jTXlYexq15j7SMxyqSbO/P2?=
 =?us-ascii?Q?zreOdJAsnV17Is4Ulwy32+QwSpXzGUneMOpMEaWolmAKvnnQ31jlcNLNBB2n?=
 =?us-ascii?Q?IMk92A=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k5Rr/HazHqe+94BgiefR+L3fb3Z/DlYMg8bq7rTo645yrjixq2IEWOfM2ESZnQ8nQmuwqirPPzUioPbAXa9xBZxveTje0q/vm2LF0E2YmfXrLgA3EEGHnJhKBiEVriR5xl65BNALhtMjTATAyk9EXlZuVA7od0yuX5ZZoUETZ01z4cHMrHTUwA1QQjbtXVxtOGhc8irTWcbIrM53MHZgicDcm2m63cTk+LtGaEKfdYcT7o+Wbrq0yYK6n2grwFWgniTIjmDbT+FY0BNWlHWNxF5fZuixMwbtMCjXlIAQxb5utAE0ZsjUZP7KoCZCeE85ZF17YqwcVZw/kOYE5u7b9DupOrH//sHq0rPONTRf1J9ecLRt1Snw6Z6PY90LLbkXB8fj1gzeulRvTvY0c/BkYmWlMEkxR6XobHNhouS+Aw0rP4tF37Vo4f+Vl1v3Jigu
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:09.7822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35bf6e-2cbe-4f50-1075-08de6fba71da
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2720
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
index dda3f4dd6e4..7d60bcc52aa 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -89,6 +89,24 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
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

