Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DEFC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 06:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDF88033D;
	Tue, 11 Feb 2025 07:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="r7FsGscQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBDC9806FE; Tue, 11 Feb 2025 07:42:26 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D55C80017
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBHJj4a065U+9cI9W0tX9gMbGsctHbHhuztoA/RVd+wkYxAxDM5tZ/KC+gr/AnA4tOiz1EI7Mino2+pey6oNGprVvMU/ofZWG6ZMJmNfphLgDkRgd42sSFMKUSyncE/HYp3Tbt8whxuqAOMOTG99auLPsBNn6T0sGUTqlEzxdoekfszizCMDG/yLU9qS9FN22wJHJAZeHb+AQZLkXnD+YCzQd4JKdvTqdYV/pncXqSf4I2nHczFm1Edwh/t6R+wpzgvn0Uxail7cCpdfbe9ly1yAOPC0aEUQ9juQ/hHxnhge+VOCv+mzbGlHO0rVwF5z4Pr6aqsL/4fySJIrS7aesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b4B2UfWVqXjEB2bxQwrz5xToIIwBREezGccMnNZIQE=;
 b=XhTQRqtYQKy/LU8rvuWl2ghb4S8Be2Xdr1YwkRZkD0TnzxLZehoXLBssGarcUdlHOclcrcm7+xuGqugtT1TkTQfpAMEMqgdnkGn5qcUO3xBy99Laj87X7UNnERzCRq1s0S3q52mobTOpgneNs5htfgkhUsyFjdXcMGoEnjBYv8ZELiHzz/THpEloCrw5EmzegA5MZytEtMbTJH42J3jz9W/UoGwicRAKKrJ84MQ1Ff92mFt3rrz4RxnqzMDJsEALN0zcvFKdkm6aAv9m/bjwZjEl0ufyPJc/5jvS5/LWe6PJdKmlyEJ2KKEgNr7qJPAunwHerbi4+NkjTC4JjL7qog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b4B2UfWVqXjEB2bxQwrz5xToIIwBREezGccMnNZIQE=;
 b=r7FsGscQguttQzuoRwqFAUrnZsncM9WJFp0xX+4UNg6154fgB/Ts6R9o+++2yrHmrKW4eIB+vTyTROq/KJkDlephC/HrPVY+fy/stXbatLwzZCEzKToVQX9E7eeW9KBhqurTP+6sGQoN5m/+qAuaHQ31bNi+In/DK07ruX9cwgi/OlVJEJG2OxmwhLoMG35IJp5Ew4C0q7AAwkjvVVFk5/FrC0dUkRHxS/lDKjeySgHfy5B6Lte5QVUllYEfTS46ZN/XQSjjdgIsUwHaZEqWo0ulBHo3G2mNWCLrQqYarq+pFo5lyqbjb9Vh68YaJDiJg7SHbpRFlYWJXoP+Nwuuqw==
Received: from PR3P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::32)
 by DBAP195MB0907.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 06:42:20 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:102:52:cafe::d5) by PR3P189CA0027.outlook.office365.com
 (2603:10a6:102:52::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:42:20 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 11 Feb
 2025 07:42:20 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 11 Feb
 2025 07:42:17 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <d-gole@ti.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 1/2] arch: arm: dts: k3-am625-phycore-som-binman: Add
 custMpk to overlays
Date: Mon, 10 Feb 2025 22:42:04 -0800
Message-ID: <20250211064205.45087-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|DBAP195MB0907:EE_
X-MS-Office365-Filtering-Correlation-Id: 70339ce8-be6a-4353-c666-08dd4a673bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m1nmwqz87D938Ibh3WteJshAu19w1LnlGQhX3NVnDPJvUtZ6EALFJQ9hYlUg?=
 =?us-ascii?Q?pAnRewvw8n8hQ3qMj2Vu176pj+srQcC2j55Ekh/GkP03cb160Vnw1DrW6dYZ?=
 =?us-ascii?Q?RzokZLwiT48MUKE61CsfOfs2lauOG8jHejbms3SpK2PBnYIIBT6tVbTi6vXV?=
 =?us-ascii?Q?qJ3JZrIDLCbtg96+wcUXG0DWcXUVMwtOMt6ySpWCmpk4ALB/Jy91ug+z9e9F?=
 =?us-ascii?Q?WcV3yVBX7n0CDSsyXtAdWD3rah2s0RdkYln43hsMnLg10XGzaWf5XbPWypEA?=
 =?us-ascii?Q?q/F2rV46Z+U6wbk40AhmzfJIc/C78dV7k8QNPb/aljJYb9ySImnTV/trNJx2?=
 =?us-ascii?Q?1u9DcIuT501kz9JAMu5jIbL8ebu1wP+JpYhhZ5xixGYCD4siVb/6PX6Ob8JB?=
 =?us-ascii?Q?rTNl5ksJGbLUUNfeMeiLhqobmUP23MP32jbcyP48Hzkc4nxEJYbApKP379y9?=
 =?us-ascii?Q?XwGHtQBMqQgF87dk0ytccuNcZuinHQlZ0kabo4k9oW3sWo43vfmDAOYzNCGQ?=
 =?us-ascii?Q?l0j8B3jgUS3M6XvKhLbpX+N2Ae2roQq6+Y0PF3g2q4EfoEhnlUD80LNsTPQx?=
 =?us-ascii?Q?/KKBHDaeKO7QoJwH738/7ABq8YT0S7Lw1yHfwxBz8X/1ywdpb6hjhdSwTwNJ?=
 =?us-ascii?Q?R6evJNP3OyDoBQkqUtP5Ljo/GQffaJ3HtoW1TPniP9gvngUptSHGEe4OhaSU?=
 =?us-ascii?Q?+bBpx3sVjz7yO/m0Od57HRPn/3SS6YNFu3FDy8DFnJ7u83GlIlqdFNQH70X4?=
 =?us-ascii?Q?TAHqD9V5lqaxt3A9zDVJhSIp15ER2DnK6UUkJyZo/nzA3C+lzYSuSP3AJOrb?=
 =?us-ascii?Q?9KgfMjcC4kVq9PKZHKbEDPuDCz3MVvl2ZbQGCC0OXVBAk4sTvB0EeoSVFcjo?=
 =?us-ascii?Q?IXHgH+iHd9TWcI31R5oQNGYJ2IB8FHEQuemRK061XSg2LNHIv0GFPuGEdPBf?=
 =?us-ascii?Q?qjdhcDk6f4lpkpRgmd+tFmekkridSzucOkiySfn5kyxQcTxbo/O5HSEuPEpQ?=
 =?us-ascii?Q?LTDpuapFUy3zCmtSgBwigbF31kx4aq9uTjvAFISI2oHzUTHFv5fmH6/W7j2N?=
 =?us-ascii?Q?TnGoNKatwxgTAw+Ltel3nNciHpJNLzDceNCGo8V3bCOcuDOn9w3wfIHSIFMP?=
 =?us-ascii?Q?xHESfQfNi5fzHHqhbR9/pWoBSFYmoumeG991kWrjlQ4lJ7ET/GSTP/qre5oZ?=
 =?us-ascii?Q?Pt1He/iEKyaiSjvdp+PC5fFbPi0CXrWdm0T/4fy93WgMlCbnM7UA/Pj0s1kk?=
 =?us-ascii?Q?W2GQku/4vZlN3SM8HBvM6EzApFpQS9n+DLZ2CDzENbosXGYNVrN9D8rzh97R?=
 =?us-ascii?Q?BLFXLDi5MXCcDbm2bQxxPdCZ9vYgmPMMpY2/BvyqA+TQfTBvjzRUYQR22+LF?=
 =?us-ascii?Q?BFDBoOq/nTE86tEPwYyFgrvpGGd+rX/0FWZmPpgef1uaJFR18EuVE9/RwGI6?=
 =?us-ascii?Q?nBI70w/c4kYJuM05Kmxk6gXsktXZJJJWWJyOCsO8ugzXVcQO+zP8gWlhVCJu?=
 =?us-ascii?Q?HIzNNevBExuMYnE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:42:20.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70339ce8-be6a-4353-c666-08dd4a673bf4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0907
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

There are some device-tree overlays with missing entries for the
keyfile. Add them to sign all images in the U-Boot FIT image.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
  v2: Removed keyfile definitions which are already defined in k3-binman.dtsi

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 31456d23167..4a65427e877 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -321,8 +321,11 @@
 					compression = "none";
 					load = <0x8F000000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_rtc_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_rtc_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
 					};
 				};
@@ -333,8 +336,11 @@
 					compression = "none";
 					load = <0x8F001000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_spi_not_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
 					};
 				};
@@ -345,8 +351,11 @@
 					compression = "none";
 					load = <0x8F002000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
 					};
 				};
@@ -357,8 +366,11 @@
 					compression = "none";
 					load = <0x8F003000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
 					};
 				};
-- 
2.25.1

