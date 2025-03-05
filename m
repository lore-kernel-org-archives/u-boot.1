Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6972FC282D3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDDA81671;
	Wed,  5 Mar 2025 05:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Dtj3EXw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CBD81658; Wed,  5 Mar 2025 05:59:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B1481436
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJpt9wkZuQFslfwANCilYyX9ZdM+p4N/xaawvRMss+PfyJGqq+TBtEBKhNn5jKUnge1Fda9JCeC075muHE5Tww2ENWN2yGkrqVPSyUSK4YWddnl9WiZ69eTtzuZzP+Cc2URGmVA1p+NSIljjt8rJ/sU4Z6AIEXic7ZGOORI71MAZVoSb0qvJZANjTeiOUIY9AEzmzwPo9h9CyRyli7xW17QBnwgJSVJDKLp83lqIa78GHDHx8DN4zEX4w9NA94EXoKosKdpA0kMYjL9MS4HMURsxGyMbjKNDR6/d120O6/yY752kH2bRZXOxIRb5kUguykt6DVkhD6VwDYAp+heCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RSziHxEU5QlDfbmRDMGGjNRXWkeN5+tPvHrIWLK5jI=;
 b=qv8SHu5wisZq9A9ITY0k47yTNoqLOze/m+Te0G3Ttk8rAKHv4ORUaz+CwLWxq5z4bjS06Vf6Q5O6t4lNZeXQubWYIpj+QP5er4xs/pJXbGsg016SFwNcQpGKhOd3cZmjx17UV2KRy3v2JPugXGVABuwlgrwD2+MVW7CvGnOc4XYo33pl/qSK2G4UqSV3MRMJmscb5jdsL/5fQ9hUAllBDsPf2Zw/T+kOJpUJQGHKG2zh1DXAVBGa/iO4bp0k0EG8SJ6QynfxLBYMQ/iu2fhv/vY1pP3A4HlmikH12ZMsd57XIaY8tpd9XokIUidf2mvyahZ9udp/jdxh44Hj4LKqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RSziHxEU5QlDfbmRDMGGjNRXWkeN5+tPvHrIWLK5jI=;
 b=Dtj3EXw2aHeAMZFHZfxSawc9zQwJ5zfgPHtjIPVyuoycFKHLFH1Y7b4r5yA4fIDYLDP1a6gaaeQfCeBBcGh0nSYAAlzitKYmMbP64/ESRalHGCKGdEgvqF/Q9+W39JYdNdbXG7onNgaH7bIGAobFI0yXRQQvifn2PDffKiPX5dDjrEMZJo5MA0QlfcdthKLuGCxUjLYxKL+yHoG6dPwxO1ZQq5DYrp84He/VkBvYitIaAlOwJNoBZAHzs9PPmQwoGp7mxUmSb0GOGQCCJNVxL7xtr0z02yB//4ZLr8BLUEbsuH26+XdSILbb8dwWKr9fQXSsApbg8NFKAFewP2AtUw==
Received: from CWLP265CA0280.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::28)
 by PA1P195MB2562.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:44b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 04:58:59 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::91) by CWLP265CA0280.outlook.office365.com
 (2603:10a6:401:5c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 04:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:49 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 12/13] arm: dts: k3-am62a-phycore-som-binman: Add SoM overlays
Date: Wed, 5 Mar 2025 05:58:37 +0100
Message-ID: <20250305045838.3614661-13-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PA1P195MB2562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfabccd-3ab7-4582-afec-08dd5ba2711a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CWvc8Wuy1MAD4dAZpwQDXBHLHuPKRg5EWzqGegaFz4X4shB8iYH5gk3PsTtj?=
 =?us-ascii?Q?FmjW/smOlPA1P2a0L8lDyl0PPyoZYEm99fIzIJO+PmMiDFOm4wf7/jPkEuFx?=
 =?us-ascii?Q?dqIUqu0EymKB+kjbBwoSB1W2bln6oPx0ES2krYbwvmg2MmxQ4osKJ3jgYjNf?=
 =?us-ascii?Q?88+TYdI+E1k6Ar1H/qGlMYbkZQow/14V28agMRHaQMS/ehOo2mE8y0TSit3P?=
 =?us-ascii?Q?3VlzF4CYipB0bjRYN8dpcOxgmBI0mROit73G5n9IacpyRaIrwhfqyjMYR6tX?=
 =?us-ascii?Q?rMfVopU5kcbP5zUNeidN8GGWwyvkB+L414JUwE/sIYkBZReoQEovEDiihr+u?=
 =?us-ascii?Q?8qy4DHAH8YKbZNMan1UcCE+yApWuKvNqvVQ+BDEKvdbkq5mwX9QE5lzsmc7O?=
 =?us-ascii?Q?f5rJy3FZIBdGU/lWbKizfAr8oHPM+3hbtBMn1n7qivxRf0j7oAYsrixjaDY/?=
 =?us-ascii?Q?nfS5MZaRMKysV2uZiuwH2Pk349+vkzBHAqlfHdsMiaQdWedfLKB7jTQf4wLD?=
 =?us-ascii?Q?5Y2VGX0JMWwWnixzz1K3xLgP1USrIkT8pOfVzYynBcCWGxJtBjYXo7Mi96d6?=
 =?us-ascii?Q?4+lV4jx3qW3spUm+qNFPNFM5xvDaltsWSrfukyzQhiCQMjqHExQXhPi6qvZ3?=
 =?us-ascii?Q?rgJtmkikVUA6faBkw21nd3wmerIrBs7hJLUzL7irSdIv+BJFcy4SlP9mhKo5?=
 =?us-ascii?Q?FCJUkEBy8OsgsgBRLlyKGExcA8CWAElcyqL5lk19Yil28501EzYstjUxTJ8A?=
 =?us-ascii?Q?QOonpsAgkvjkHRRT/FVcwOGTCe0vRRAo8gZy4pYu1RA18WeQ6VqsdAnulOvN?=
 =?us-ascii?Q?j8PKV0ac3yPG5+YNYLzjSqP2E5lhh/UyaHGFbYYYmxp7ceZFosed0BtU84lb?=
 =?us-ascii?Q?KrLt8qJxG7ddFtotneuJBxOBixxxkEh175trlyyF7NCBl61XGYL1oh8G7V8h?=
 =?us-ascii?Q?KxjNx1vd97WCJGJ89XXI3m/Iqw/kIbkrnSZADAV/8FeUDsHvs6ivPEJ9Wsxe?=
 =?us-ascii?Q?Gr9VYLuQvOlCeuxvDUd41IFHPyOhUUJq7wDATANuwrFpD0OB3ZdfG8lL4Mn+?=
 =?us-ascii?Q?YaPI8TMlB4+PZzmg1EhK0sOwvdW2STiNM+Mrz00JmRDqEkURGVnLe7v+Jmir?=
 =?us-ascii?Q?psavoirP2AiNTaNfNBKOeUz0Oh1kL+cF3EyBENow62/8urqLYVItflckzlAS?=
 =?us-ascii?Q?celSQtrwk9vAS6HOttb4CyjH4KDGXZp559BngTZW2JaOqYKWx6JWxTo48O9h?=
 =?us-ascii?Q?5rAno+aVyLc86cVpWKygtYY6p0pUJEs8SQd/D9KFWwLr50ME+qW89Dd1xILL?=
 =?us-ascii?Q?x8pCp/EGLGVAR4xQA4+zVdSVcDW+nOvcua4J6BsCRKP3zkiFngvB/sfv4cEw?=
 =?us-ascii?Q?3S5ehsefqWokt4XE/mMvUq7fX+BBTL9ZQR4H6f5HuMFVWaEM0t2KkLGvbFH+?=
 =?us-ascii?Q?IkPFo9YY2qGHtPOaGXeIA3jUnRgXQi03AMj76dp3WFSaSepTIIpRjDRbmYt+?=
 =?us-ascii?Q?cnGX9JGV4eoXLgw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:59.6413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfabccd-3ab7-4582-afec-08dd5ba2711a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P195MB2562
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

Include SoM dt-overlays that handle variants of our SoMs into
u-boot's FIT image.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 66 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 7a5b14da719..325702ed6e0 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -320,6 +320,66 @@
 					description = "U-Boot for AM62Ax board";
 				};
 
+				som-no-rtc {
+					description = "k3-am6xx-phycore-disable-rtc";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F000000>;
+					arch = "arm";
+					ti-secure {
+						content = <&am6xx_phycore_disable_rtc_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_rtc_dtbo: blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
+					};
+				};
+
+				som-no-spi {
+					description = "k3-am6xx-phycore-disable-spi-nor";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F001000>;
+					arch = "arm";
+					ti-secure {
+						content = <&am6xx_phycore_disable_spi_not_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
+					};
+				};
+
+				som-no-eth {
+					description = "k3-am6xx-phycore-disable-eth-phy";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F002000>;
+					arch = "arm";
+					ti-secure {
+						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
+					};
+				};
+
+				som-qspi {
+					description = "k3-am6xx-phycore-qspi-nor";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F003000>;
+					arch = "arm";
+					ti-secure {
+						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
+					};
+				};
+
 				fdt-0 {
 					description = "k3-am62a7-phyboard-lyra-rdk";
 					type = "flat_dt";
@@ -344,7 +404,11 @@
 				conf-0 {
 					description = "k3-am62a7-phyboard-lyra-rdk";
 					firmware = "uboot";
-					loadables = "uboot";
+					loadables = "uboot",
+						    "som-no-rtc",
+						    "som-no-spi",
+						    "som-no-eth",
+						    "som-qspi";
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

