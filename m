Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7159ECAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 06:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8016281E13;
	Thu, 18 Sep 2025 08:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="uAGOAc0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188E68309A; Thu, 18 Sep 2025 08:14:05 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C1B80050
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3bJetwZRQf1YJGbZvf4upxI7HsMcreiOjM5V+AEf1AsHksCndJgcAr8Xuv1ZBKD2ZUu6HXKos+3UzUCVXtBht940MYSS8WM980MDC+HacUaIyLzGzIhkHnmLYro5RjLfBWinISGuLmwVGSgMPeMdF2cHLz7gYIeQV+/u1oQYS6kCUAziRCXZ8ySHzXiLlSNeCL2lU1Hv/4/UKlW44dsPBcOyOuqU6XOkCsvUavKHdX8RxSz1XJ5rQRb0xU/9zgaTmr6zmWCzoYOztFHOw0pbESigzcUkSyLte3NB05XM0u81SEkZk+cKAyuM/L+z+eTaDutzoZn1XZQ8Pd9YSmm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpxVlRVDHrxT1yWIedOXC5glbzAbrcq1G/Ty+N+lfa8=;
 b=UzSGVBHgf1bXzWvjUiJgGqVQExi8k18st35oEKINKxFA4McxPzHUY2IQRDLurssWbfKeWBG1JvUQnKxQ1cANU5c58OAA60Y/4qgp9XQ+ZhRlQBw+EeyzvL6jnBjmofwEfPL1JsGsRBLaj6kJNz5cC030ehogy2AdU0UYL93aeEA9GK/h6M/CPWW5xtlC+no3Grkft4Nt5MqvN19YMC42wMiv69vwuR5tvuAG3udKIxHLT4EfIlMkK+dr1iA+pxU0MUSdKxGwoezpqoxOs+d9fVQWQ3+K2efE6Nbg3YugNX+5RGvXlk8g4jROlWsEGr42AgrH2s/+k2ncaa9SE0zGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpxVlRVDHrxT1yWIedOXC5glbzAbrcq1G/Ty+N+lfa8=;
 b=uAGOAc0erx3cnMofNt+wyZaQkDbCC+atPJueivpojPC6XF+2wHToMNhmpVyU3twP63OeUaZve9T3WCwBafipqlz7wn6pbJRiYsJftOuGLUU6Xc2wIqUFL3HOrC+qgyKgY0o3jddX2jtJbAkrikyuj9InaQMq0BUTjzNMISpGl9Ok1zrd6AKxonFSPEhARcSuQXUHHKJyP5bePFbRO/PsPupDPHNwj/L8zieFOKjWujl61Q598oO1M+byVHt9O9pTnzikn/4+lwVEcNHYS4Tk2BmBplwUzyyyI6eBnvqMh+jsatxzvxOmkYXviI7YeBfs1IExxcccp/reQMsw5rCUqQ==
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by DBAP195MB1065.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:1c1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:13:59 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::47) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 06:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 06:13:59 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 18 Sep
 2025 08:13:58 +0200
Received: from llp-moog.phytec.de (172.25.32.54) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 08:13:58 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 18 Sep 2025 08:13:55 +0200
Subject: [PATCH v5 1/3] phytec-imx8m boards: enable OP-TEE for KASLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-imx8m-optee-enable-v5-1-ecbe0b583b94@phytec.de>
References: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
In-Reply-To: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758176038; l=3511;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=jHa8u+2ni5TvhraGixMjORr4ccernl+mzN1Du0hX9Y8=;
 b=zaCkit5apFmTPEdq9pxnC697qV0vg2fR/ZDYHGXjnmKs9auKMixFTxLcYYSVTQIdSN75eti18
 wj5Av5/SsngAiB+Xgr4d3cLuzRMgbsJzq4JFlAzpjEHbKxGz2FYBBZh
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|DBAP195MB1065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4ced42-fbb0-4549-4f07-08ddf67a8eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1N4YXZHdTZRTUVqbDArbkl1SFRJWkFLZ1Z2VU54bjJuUHNtalBmRms1dUJ6?=
 =?utf-8?B?c283ekdya0EwUHU2bHAvNDU3NWFHQStnL1M2c21UNWhrT28vWEZKa1JTU01W?=
 =?utf-8?B?TStBRVl4bGY5WWNXclNOb0ZtZFFseGcyRDBtNG53U3FHUGtrL2U3cDhHb2hx?=
 =?utf-8?B?U2VOVkhraHc0Yjh3YzRyRVVGN3UxVTdBS3RXbXJ5R1NRb2IxblRtcERlUDUr?=
 =?utf-8?B?aGYxc3JFY0ZWZk4yYldlOFhud2tmQ0orajlkTnBOQVh4UVZHL2Z0OUxEem1K?=
 =?utf-8?B?a1ZjZURKb1VDb05OT2g2dDg5dkpZOXVzVWFjUk12amRtWTFIa3ZsbUNPNDJw?=
 =?utf-8?B?NDZPUGVjbW54TUxEa2hrMlZRcTQ3enJ5R09sWWl5bmtxVXpkY2V2U0JNK2JI?=
 =?utf-8?B?QTlQMk9JdWorMzRSZEFMczkzc3MvdnMvcTVVL2luUnlkaVRRdnZlUUZYK3JG?=
 =?utf-8?B?RklleUVWSmFQYkFEL3I0Sk1qYWZ3RDQxdklySVYwWDdCcTkyL25zVDRYUE1B?=
 =?utf-8?B?QVdXSkRjOVpodHdtZk9EQmlHWGJERFVTZ0JsaTFrZk5Sa2hJYW5GS1dxQlhQ?=
 =?utf-8?B?VEVJT0lTY1hWNVdPSVZ1OVdBOXVJK2pHU2FWZmVxUWZlekZmZk8vZTI4V0Rm?=
 =?utf-8?B?eG5kM2lrL3BzVWQ2dTduOEJwa3hFNldVdzE5R3dReFpxSjAyY01WNkpzMmE4?=
 =?utf-8?B?VWFZem5yVUI1UTcyMzVDa29vNzZCejRLYlA3VE5Iek1oQ2N5VmY5ZXl1dUJR?=
 =?utf-8?B?WEh1MWJkSTF6WExpeURodnIza0s0K0g5R0hXL1cxZm5TK1g3RjBhMFVXb1RC?=
 =?utf-8?B?U3ZzQzNWRkszMTMwK2ZaNENmbWVOQnJoTHI1YmNEaWVRMEwvaUtQQzhad3Nh?=
 =?utf-8?B?WkN5SVJoTWd6M21zTWNzVmdEVWVPaDkwU2hDQ2pUMDk0S0I5ZTBOZXF2Nzh0?=
 =?utf-8?B?TVBWUDZQYmh1ZWVLTmRyc1cwK2MyZ3cyWGQ3eVF3QmdkT3BzTEZHYjY1NDhC?=
 =?utf-8?B?dTRCNjlWK0RuT3psa1FHOWJUeEdhbjk4a2dXTjNVK3Bjb3A3ajBld3dyaE5H?=
 =?utf-8?B?SEw5amoyMFBBWHN5aWlGMkJTalpwbVdkTnFTYWRsV3cwUFBJYnh5NG1LekQv?=
 =?utf-8?B?YysyZzN0bFRaUGpOWmRmRWJVTm8vcDZXeEllSGt6Tkk3bmpBNDEyNHNLbXAr?=
 =?utf-8?B?dEFUQU41UWhjVGc3Z3BxekM3cFpvL21jWFFXdEhnQW5FMDNiQnc4S0lKcFY2?=
 =?utf-8?B?TG5PdHg2eklCbVIxK0RxRk9xakl0VFgyY25rUWNkYlNHdE1TNjc4U3l0T1Vz?=
 =?utf-8?B?OXdiZzdMYVYyVUlmaGRncHA2T2IwZytZNHVITXF1U2g3T3ZVSVdhdXNkb1lY?=
 =?utf-8?B?cnVTdFNKUHZhVjl6UEt2VW5kd0xzMHN3MEpFT24rekxhdUxpT1c2SlYzMDdO?=
 =?utf-8?B?QzlhL0wwWG1CYzk0RW1iZnUyUVMvR2JDN05WNDlEMzlsemJIVEkyY1hjWEVa?=
 =?utf-8?B?alFELzU3UzZmQkM4b25HdU4vekVZdnlLanJkWHR4UnhZcjRSaFVvTm05U0ly?=
 =?utf-8?B?TjMzU0huanFTamRrdU9lUXY2WERWdUNlS3FMTUFiYm9ERkRLMHg2Qklmbjcy?=
 =?utf-8?B?bzNlMC9XcGUwRFo3SDdzaWwwTURMZWhaUkFDOE9uOXZ6elZBZ0U1bEVRQ3Nr?=
 =?utf-8?B?TmZQVXIybXFmbmZ6OEpSbkJ2a0tNNGgwaDI4eDdlNGF4LzdremhpemVLQjJN?=
 =?utf-8?B?clBEb2REZXJuU0d4bzVESEs1enEwOFU3eVZhNmpwQ0FadEVZeDVWNFlMT2RW?=
 =?utf-8?B?MmZHTFNTYWI0d2U1ZHRiMWRJaWR4NVNPWjk2Z2FIU2M1a2lTMVUwMk9DVmZM?=
 =?utf-8?B?SHE3THIweGwyc2grRDdycFVWcENTQnNudkNmcm1tL091ejhyZDZJMU56WXFE?=
 =?utf-8?B?N1BUa0JEc0hpR3llUWo1MkFTMHozaGNSZzg1dWk5dEttaXNNWS9Eckl3K04x?=
 =?utf-8?B?VTZYdUM3UEh1OHljTmhaS3hwUVFzWWlNZDRzcGwrY1pyU29MUUxEUTdWN2w1?=
 =?utf-8?Q?8u57BM?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:13:59.6722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4ced42-fbb0-4549-4f07-08ddf67a8eb9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1065
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

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
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

