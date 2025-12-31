Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F90EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322BA84119;
	Wed, 31 Dec 2025 18:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FCJw85Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AF484129; Wed, 31 Dec 2025 18:36:59 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DBD84118
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbG4Z8lfEof1Ki/sj+W1dsA1tYqk4THQKGijzKQDR9RnDTtTZPhz6oUNfE4I3XEGMRwTz5yjT5igMd99u/LuCASY7sqEcpLdeY3aowFjASPi7+zCOpCpNJx5Juo5s1jPJ5cMzYWhZl8WlLG27cNS+ypBdGN39Y/5+oWDuX3aItapYHS1nc8G0CQ4YyCAbxW0HE4x5Zoi8GG+5wDLjnSjhasRuSNUqzweyWbl9U/aMROs4G9tDrSE433C6QYUWUBAoa0/StJ7fdqqbX3OEzkDN6kg8TWfhceuiSVbYiG07dr2nkEgg/LqkcDm68gMShtkIPQU/xcU52RGqFEJ1zwwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeOItF0EFokYOcXyeWXC+ZwUOKpHq7xxZJ1lXZI4wQo=;
 b=ZBCMZ2u8+0ar8e+LhgGQRRv31zFtEigJmP8GyLnz5Bxxb2iGLSu2SB7Sy/Y+gXPIIQV8LEc962jSaDmvLb2nGjhNaDQX6q2a+JqhCmr9Cil6TuP4HsWPR7Q/+GcFPfmKiQHXKohdcRZmvNXD6FmoTBokVooeXTjPx+KRUltE+WtVH9iVgMNC5vnVY/TypOMmWNkG+pCPCzg/I8dnrKcLgHeMDKCpI3JSUd/qfRawl+FaZ+jFw9P8jlu1X1FXiO1r6ATJc3oaM7P0f19SCTXb7VFj6l9F1cR0lXge8MTmXZ0Um4IC4EJYWeEy1w5Tx+KYqzEYz87cYIxFzlEZ3MyReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeOItF0EFokYOcXyeWXC+ZwUOKpHq7xxZJ1lXZI4wQo=;
 b=FCJw85RgPpllgPujn0gENsu4ttaCDwj9xpOsUFH6IH70yxqyQN4wXBQsZGAWS+Bc+uM7P7NP3BaUPMDvEIIjuie4ptrAkPqTSZmwMpVlmao7rIQMnF0RKqiBkee5I8wP/QMJ2O/P8/A8QObSNd4JD99Qbcbei4iN++Kn0SkmR2Y=
Received: from BY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:a03:1f4::22)
 by CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:52 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::58) by BY5PR20CA0009.outlook.office365.com
 (2603:10b6:a03:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:50 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:46 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:46 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqu2541396;
 Wed, 31 Dec 2025 11:36:43 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 05/11] arm: dts: k3-binman: Add template for packing HSM
 firmware
Date: Wed, 31 Dec 2025 23:06:15 +0530
Message-ID: <20251231173621.1069988-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CY5PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 388828ed-4990-48cb-bd73-08de48932e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nyLV2WNz6cWbJNqjkBFnvLn3+bOfnC/2iHgtXlUmCA3xiwk1QqFGQ1O9vel1?=
 =?us-ascii?Q?Xun79RFSOoseCz5bhTwjE7jeq7pGIKg6eQJ1lkqZkvAj8m8noXodOYjHygju?=
 =?us-ascii?Q?FYsst1iqfHfaJtsY+aJCRGYjCBWQOiFsrsmhcPDAGTGzYMxiQfD/UBp0h6A7?=
 =?us-ascii?Q?TUmTK9XbcCO0DewN5owoC7GN3Padcq5zMQK6G+6KhmQkudILqST9G7xCDgsI?=
 =?us-ascii?Q?89xIaXVeC+lYbWPcbwZELWlej1z/3syfVzw/HLaiULXfK2w1HaGsZfvxjTFt?=
 =?us-ascii?Q?+hpHk4uq4hSx2VUoRqVmbwKP1EPtNjOoUnjdZUo1kur4mpgqDeRat45Jp/X8?=
 =?us-ascii?Q?Inzg0HFsOdiRXB/tJYqmdJQJ7YaV5mhaxGoTM1K6eJ4Kto+hcr37YftXvdoU?=
 =?us-ascii?Q?VOnengpvwOCtdbc13rDMpAVtLBu9Zuz0ywbkC2WRyj042061s2CpRA/PC4dH?=
 =?us-ascii?Q?9LoBa1uXRxOuwC6lo8am0aNoQSS/pEbttJvdf45xdkUOX+ZjA6AwSWh/rZxe?=
 =?us-ascii?Q?IYozecPLi1mYnwVjd8NKPM7H7luiSubza1dsVGKfw0hfLggwdDr35GFsN9+Y?=
 =?us-ascii?Q?Bn3aq08eXFJjD7XhIEOq0zGsAFbIzpUY2RZKJyOyyUH1nzdN5DN8CLTNNi/h?=
 =?us-ascii?Q?tseZp7sN7tz0hkC7AnWA5Z/OisY0fHFZSmYMmvHphF1wOwjbN2rXjF5la/wS?=
 =?us-ascii?Q?5h1jIkVQYJMyelUPn3L9H+Tp51vNXBRatqGFZoMczrMKmVzJzMNuI1EIQlvP?=
 =?us-ascii?Q?J9Eknc2wRyPgl5c9gUmElwuV+zIHv+S93zztvtXC+FTAzWicLwqTxj5fSjNR?=
 =?us-ascii?Q?Jmkn3sqnj6q32hqruBdmeG877n3zQZX4t+vPygD5oqpnvzi3MfFOdyftz/li?=
 =?us-ascii?Q?pcWPJ5tnx/ifOyMZZTVgkui09OxBT1N4SiegdRgkF8S5sibDtJbH7fpMCxjF?=
 =?us-ascii?Q?6Ut2PPzmYOnm9XSz2j9JjSP1XKJXJMws3JMBX660QYLAV4DG0peKDbSJChad?=
 =?us-ascii?Q?RP3/r0q+asIcckgODvDY+TSFrgm1nqU13Hgf6qIhk9whA9O5HXDv5GBbonbN?=
 =?us-ascii?Q?AzVpnMj01SzgK9FfzJUJy7r1/sw/CgRl7gVtX+0Wo0cO/xN6wb5pf1wNmQEq?=
 =?us-ascii?Q?Jihx2dtfo7kkIKUMriMDbT0b4c9oFiDSsvO11xJSc/VQ1JosdCmdIdEkGDzr?=
 =?us-ascii?Q?UmrKvEzKj79hadXffcFpfqJ7TGRQp2yrv0YFtO5g0EPHee9BxHeZGdaJ2hAS?=
 =?us-ascii?Q?3qwcupq9ePtFcWBRFtZMpEQDav44EOHLyG7xsR3l0LLttxyyIttMYMPteoD7?=
 =?us-ascii?Q?JCdI1/G1/7cpI7PRVqiw+PMcAFwANNRbdFIJelDCjuECjXtOefvTKAOm+6Rc?=
 =?us-ascii?Q?V4EpeHfCyDYKF6yaAAIoX9I2Z3ZXjO8L501UAun+II9/bEqfWavnQMkkwzNI?=
 =?us-ascii?Q?dDB/CYq+za8fMiyWwLvI7WfTPGTmfWxTHaIJXU4vadoMgUUeW2UQGsizAf1j?=
 =?us-ascii?Q?1BVCmBeUn5dHLWxbBR5ohPGCrO/HeHUku9Xq7dqB1L53Q930GoSeamsbcw7w?=
 =?us-ascii?Q?6HLP+1WHkniVAYhrZkQobWpjlTxPRhHVcFQ6B74Q?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:50.4830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388828ed-4990-48cb-bd73-08de48932e32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6165
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

The HSM M4 core needs to be booted at R5 SPL stage so that it can be
used for further Authentication and security services. Therefore, the
firmware for the HSM core needs to be packed in tispl.bin fit image so
that it can be used by R5 SPL to boot the HSM core.

Add a template for packing the HSM firmware in tispl.bin. The template
also contains necessary fields which will be populated in the boot
extension and load extension in the x509 certificate for HSM firmware.
This is required as the HSM firmware needs to be signed before invoking
TIFS to authenticate and load the blob to HSM core.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1. Added ti-secure node for signing hsm firmware image in U-Boot.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-4-b-padhi@ti.com/

v2: Changelog:
1. Got rid of 'load' and 'entry' properties. Rely on U-Boot to set it.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-3-b-padhi@ti.com/

 arch/arm/dts/k3-binman.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 761b1730464..de5f2aef30c 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -297,6 +297,26 @@
 					};
 				};
 
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					description = "HSM binary";
+					type = "standalone";
+					compression = "none";
+					os = "hsm";
+
+					ti-secure {
+						content = <&hsm>;
+						keyfile = "custMpk.pem";
+						proc_id = <0x80>;
+						flags_set = <0x04>;
+						flags_clr = <0x00>;
+						reset_vector = <0x00>;
+						dest_addr = <0x43C00000>;
+						auth_type = <0xFD00>;
+					};
+				};
+#endif
+
 				dm {
 					description = "DM binary";
 					type = "firmware";
-- 
2.34.1

