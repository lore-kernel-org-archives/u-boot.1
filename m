Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13221CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 06:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B0182C84;
	Mon,  8 Sep 2025 08:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CXEdtj9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580FE82CF8; Mon,  8 Sep 2025 08:34:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBBC82AE9
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 08:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty22clOQ7kWDSiJdnvhdwNRVrvkSKiuWxT/tmdbdcLxLtsBU3SUaLOoWGrsaKqqMo+gIMptuYL/W7bU1ZP/V5wkd2ijgJsq0cqSc25LnYQn8bJkw1iuzM0FPROofJ8YpOo1koZoPMOc/uHHDII8AwWJLhLMFoLQoBEtqaPH7fT2Ciw8pLV7CIlnYPkRU68PMakd0P2M7T0QeO5EI+xVv904vHZUqDeAQmhplNuARZC+ozlIfeacl5G4zW8SF0mE9Hr4AyMzhaNz3oRnBM085Dit5MwCnjgKuCohq12AzGS1OBZDlgM11HWLS3YsMa/AKwIT6i7OR6VuQEwTkgtJldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYOZr0MIKIr+I1pnClUWHxD07PfoKiiNAfspUZi3xVg=;
 b=uhK5CH6cEya6C4NtfuogqDSGCEVnUyrjtk/+YJf3B3xQ8dzPOKB3EoVqmeiorj/S/A2g+bZ4oXIx5WABNqj066lgEKSE3yR7kWTGQu2gGyNZ7eFUebeEKeJTH/p78JbzvzEHqKft77uvTJCOZ5L3AUjCTeCeBkUa0FJC5+yTtzv8Gwx0J5zN0LlNcIHZ/HlIDQNwEF0JqDHykEayXmTA9rIUX1z6JEJ7XHm8KaXgDaN0xB3W2UErP3KrfrTBFR7SdLO7v648A/n2CUrwQX99C4QWaJC4Zfpk0Xa2OFmNReMyx60G24E9VzTNdeJzNBmai3yrji+9ZPk5WjTmRGrbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYOZr0MIKIr+I1pnClUWHxD07PfoKiiNAfspUZi3xVg=;
 b=CXEdtj9UGg3OZpiWrZTHcOoFHJsw7kaK+e5yyK+NOhTuOD3POFu7asYEb/kgh9lRydUCGbW3JH67+XuYOaG29/QcRHtcezEGq3lDh8l2Yd6RsPpGWiZHGsk/wIEZvxVMtrR6Jg3Cf3i0UxEe+M4TfszenkLPyUbykCztJlT7D64LToLOiUSoSu+WmHBMTYhAAFNhxocwTEJDtGq8rSgVZ3R3zcfDDS0KXYmHiGaE8cmtEEcsgPEMZuBV26mCaw0gqZfpH6pyyTiAB4CVQYv6lFXAyOTSRBZO1SUvh9sZbDB7LpXN0i2Flk9n/2dQST1uC9REVP0J7IaQ3xfMkfBPgA==
Received: from DU2PR04CA0200.eurprd04.prod.outlook.com (2603:10a6:10:28d::25)
 by DB5P195MB2424.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:48c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 8 Sep
 2025 06:34:17 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::d0) by DU2PR04CA0200.outlook.office365.com
 (2603:10a6:10:28d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 06:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 06:34:17 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 8 Sep 2025 08:33:58 +0200
Subject: [PATCH v3 1/3] phytec-imx8m boards: enable OP-TEE for KASLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-imx8m-optee-enable-v3-1-14bfe249b3c6@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
In-Reply-To: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757313256; l=3462;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=iHptZkW7RTceMReL/1LfSfwGgkwpKPq4V+xx2htqRrc=;
 b=G8cadmqXOWhcol8wC8iJBosI28bqiXTJE/3SRPPKj9hzvIFVPzx0VQOJGags0+MuiY0LZZv0k
 dPv2q9iqaWIDBf3T2kTYMNrMNE+oSgkbyNKWnDmTwo3QzE1oi8vawbc
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|DB5P195MB2424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb293bc-3534-46f9-d7fd-08ddeea1bc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0RqS2dTTTk2b3FtY0tCaFlBZWdXQjdQbEpGRXl5eTh4b1hXM3BTdTZtNEo3?=
 =?utf-8?B?VFBaYis4Vm9maXRuV0duSWpDek4zNXFITXB4dStFMzFpRE1OYnVybGlJSGgy?=
 =?utf-8?B?Z2EwWnd0YWRzYmlnOFl6VUpCZ0NZa3d5ZXFIeVJYSXZtQlJjdTNRWWZCcDh1?=
 =?utf-8?B?dGNtL0NkM29wcHkvWldMaWZPa296SW8xQUFJREt6WUZZelhxVHpreTd2MjRD?=
 =?utf-8?B?MGVySU0vTy9QTnRaRWV5YkhMY1Y2dEMrZVFYRGhIRmxlQWJVNjNBRi9hc1A1?=
 =?utf-8?B?ZUEvalVFZmJvaHFrWjRpWUZ6UDcwNytxRE84am1uNEFTR3NITXhPRFhpU3RM?=
 =?utf-8?B?ZElRcFZzN3VrWG1La0lBSHZ1cnVEZitOamNVVFFUcHhROVlFVHBDUGZkblZm?=
 =?utf-8?B?UDlXc2hWcFNvUm1JMGVMaXAvUCtybDNVbVhvOW5IVDN5OUhCWmk1UE5Cb0RG?=
 =?utf-8?B?cGhsWXRxT2tCMy96cEVEdnlhUjBlaXhVYVVyWk1lRnRhLzNUeDVIdjBGaDBv?=
 =?utf-8?B?MXlYVlN4S0lmblNFWUF5eVNkU2xhMDNKT2tpR3FicnNuU0oxSFBPVXVNNmVa?=
 =?utf-8?B?SGZINXFBdERxejl1dVljUEd2NEJTWHN5UU45MTZIYkEwRzFNZENMLzJlVUpC?=
 =?utf-8?B?eWk4bllObGwyaWh3d3RKeVpxcFFIN2NRWTZITHlKcnNJQWtoM2VCMU1ZMUtV?=
 =?utf-8?B?OGxZdWVHbkpNWWlCSXB0T2FwSUwzOWhGakQ2TU45M1ZHWlcwb01QMHNZbWk5?=
 =?utf-8?B?YW13a1R1aG5uajN3VU41UVAvLzR3UExUTzNyRkhhdVdncHpCR3BjTThMM1J4?=
 =?utf-8?B?RFd5THc3bEpuY2xpR1RUa2ZJeTEwMjJ2MndOZThOdnI1aUdSc3dQcitJTlU4?=
 =?utf-8?B?TTk1aFgxV2M2Q21kNXdhRURJRFdFdmRFNDlUUUpWRU5jUEZZRmk4UWwrMVZZ?=
 =?utf-8?B?aWNpTGlEOWJROWtQd3QrVHlkek1WNTliMVVldjRzRVRMa2RoTU9WRFA4WXJi?=
 =?utf-8?B?M3ZTdzlvb0JZZjY1TjA1dTdLZ2hBc0pvMlhYNnVOVVlUOXpDcHR3VHkxb3kr?=
 =?utf-8?B?aDRoYzRkYkUzL2lzb2N3Y0w5NDluV3BmaHl1NStGdlo0OThPdEpRNjJDam9Z?=
 =?utf-8?B?MUcyTmNkZG5RM0NvREJCZkQwamJUcWQrdmMxalExSTgxZlVlUC94b1huVCtr?=
 =?utf-8?B?QmZGUW9yS01ENXJtTDhJQ2pLK2NWZGtINENpM05lZ3NuNnlTZVQ3NWdlMWJD?=
 =?utf-8?B?NjJEZ21WczdaaEozb3A3a05RVFd0bk5OSHV5TTE2ak5GUDUvaHZXK3pJQm1S?=
 =?utf-8?B?R3hQdXplSmdkWnpQNk5OcnY3d1pITWVOMUsyeXlZOWRWWXBUU1I0RFJmSzU0?=
 =?utf-8?B?bThhQ2lFK2FrQTViR0F4UVUyTUVjemJmVnFoaHJlejhieEl0dVZnTGNHZVRv?=
 =?utf-8?B?Q3JLRUJ3R3N2SjNvMHR1ZlVONDZCUFRjR0g2NTBCWnpqL2lGNDFkYlR3RHlR?=
 =?utf-8?B?YThXR3paQnBlUzJZN2JkRW96c3dlWlFIMzlNOUpLME13My9KMVI3b1pmY24w?=
 =?utf-8?B?S2dVU0tMVTlNZEhQL2lkMVNBR0lzNmxNbmk3bkZVYzJlTFVET2FSWUt0Zlgv?=
 =?utf-8?B?cjdsOHV0VVc3N24xVTUzRFBVSTRFR1B2Wlg0bWo4dzZDZEU5TytTOGorWjI3?=
 =?utf-8?B?M2xIRnh1Y0VyYURDMmllbFhYLzM3Q3BqVHhuVU5FTjkzOWJSUjYzRVY0dkJN?=
 =?utf-8?B?MU5aSWl2M1JqZWVJT3l2VEhqVHFvVENJcndqNllZY3dFNE1EdEhibWlXc1dw?=
 =?utf-8?B?R0paSGtDZ05aWS9ocXpoK1BQYTVQeEtLZDVwbXJDSHhHMllUaFd1bU54Rmwv?=
 =?utf-8?B?QjgvMlNCZmoxK1hUY1haTFQ1V1Q2L1lMUURnbVpnSVZ6T045MlkyZlZlNE9j?=
 =?utf-8?B?WXpabzdYVHZQSzN1TThVNkhMMkg2STJIWGpHeGxaMWNOeVdxWmJrNTZKU1lj?=
 =?utf-8?B?U2dOWnNUTGpjUVMyZlZtZ0ZhMGMzRWlxVWMyd3E1Sys3UUJsVHRpcGFIeUNO?=
 =?utf-8?Q?egkmDd?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:34:17.5755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb293bc-3534-46f9-d7fd-08ddeea1bc84
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2424
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

Enable OP-TEE config and RNG by default.
Set OP-TEE load address to end of 1GiB RAM for phycore-imx8mp and
phycore-imx8mm as the boards support a 1GiB RAM variant (although not
yet upstreamed for phycore-imx8mm).
The imx8mm-phygate-tauri-l board only supports 2GiB, so the default at
the end of 2GiB is sufficient.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 5 ++++-
 configs/phycore-imx8mm_defconfig         | 5 ++++-
 configs/phycore-imx8mp_defconfig         | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 7369c0a05ac98315682127f0e96af7d36c4763d2..6dc95d6d3edbc0b4ed25a66d23f1b65435e01697 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -73,9 +73,9 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -97,11 +97,14 @@ CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 4d6bce26f07f7b90e7c3674f4b9ddcac8d775e1d..4cf4d3972567bcf77d9ee7e2fda707070a778c72 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -82,9 +82,9 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -120,6 +120,7 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
@@ -129,5 +130,7 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 6bd8bcf15daa95966aa973d8a493ebc1f05b14e9..c497f0bcd9131abab0b751ec9cc81194405b1f19 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -153,6 +154,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
@@ -162,6 +164,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y

-- 
2.43.0

