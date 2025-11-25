Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15401D0EE0F
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4682A84119;
	Tue, 25 Nov 2025 18:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="b0Q5kilR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868F9840ED; Tue, 25 Nov 2025 18:23:35 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B63C8410C
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t782SRge9t3DIol/lInT+35QUc1cHo6Fkh435mfVncqyjUKBonAFRdvyrv1/t8+n2o7s16bx3yhGO+WuPjHheiN8gVIk+ELrc3Ae+EJr8oSsgDCFKHu47EwsRUrr4ZLWasVPjEcvufBNEy2bNCnGg2VNEZj96JolFJ2W+ywvlHj0FZJtZvlveakfGr91FW4swswqthNWAcNC6Zea7BPfwy/x1BZlngHt7C9QjDUsvaBas/afdCGGYNFV52KLKm12gJgr6Z9kkSv7YadxiGk61TCnVKFdkMsoUjBxwz0BrPDhaixTMiVeOI8lqRfGNdS8pOj13W5eqrMsS2pyb5eY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdPpaB6Sr0onS+dcoMKrEbyR7U0CxD4SIfsu1puHyHs=;
 b=XblWmYcjnxY4w2RhraPitz5N5/LsjiykrA/mrT5YL9ALP81mFXl3DlkmQaAtGeJiyX6LnrJ3OymQH8aTnszx5AHwyREdWhUDvW3bKOm9wRQy1gGdST9d1XJcF4jLGJ0VwoQ0qUleMJGoKXOQIks/6+G6ua3yh7HtVB3BFj3+5/7k2PF0/7mJbI0wZITpN0Q8O5oJwtCXCWV0IvlCi+RTT/udtMnJ+9H0qXegoRHWnHkEVJiVBf6OHpvB8NK9nJn/Un3sUs4gk5ICCguJ3YZANEoHPOVlaCyhx/uqOOHrMK6xDVcz3ubFP722XWtT819PpuglDo4sqpL60z8dDM4prA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdPpaB6Sr0onS+dcoMKrEbyR7U0CxD4SIfsu1puHyHs=;
 b=b0Q5kilRzskWip94pXbAG44+0S64MXEaxuDry+dcrU3GhG8kfTvHZoJx/FH3Og6tLv349pgzSY+cSG3ynQ6QOZQh5dnpVC0pd0fbl5+LV4HxlRs25aAcRUyrzrp+XvWAgpfbnxR3VtXbmYClczV+o++951xqrGRPM57k2hyYJj/Gw9OfKnJdDgzYu0B0Yku4vPFeyIz3DUbyi7jse5JcnoLmh3zRSmb1yidDBJw+/8/8PUc5giHo4PkW9wd6EAdmTDq6ZeJLdwyVBBkBgV9+KcY76TBZ6i6gKbZ9srsbRwD9T4ddDrsE263AmDvpOJb1f5KMEw7dMdAh4GMSKxkdsg==
Received: from DUZPR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::6) by AS1P195MB1469.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 17:23:29 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::f5) by DUZPR01CA0165.outlook.office365.com
 (2603:10a6:10:4b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 17:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:29 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:28 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 0/6] phytec: imx8: cleanup environments
Date: Tue, 25 Nov 2025 18:23:09 +0100
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3lJWkC/x3MUQqDMAwA0KtIvg20hYJ4lSGSaroGXCwtOkG8+
 8o+38+7oXIRrjB2NxQ+pcquDbbvYEmkb0ZZm8EZ5611Hr+SMSRKivK5hnnZmPTIM+uJMVAYVmM
 ieQ8tyIWjXP/8NT3PD1LWC49sAAAA
X-Change-ID: 20251125-wip-bhahn-imx8_cleanup_env-fbab8d00fa55
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=1746;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=C/+9KEPQHDjzs21IVXLQR6R4uN39FYPXQRfug1dOf14=;
 b=xuBHCUayq92l4K4yvAFuBBCFyzUNoqKfqTHX9DeWlNANGBRjJ+tRx2quBZ+eTOIoqSjpeXY9N
 sBouq5NzETSCBh2mT69ba/PlVMiajSYKq25u1l/gG1JSJrFKHB7gUDf
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AS1P195MB1469:EE_
X-MS-Office365-Filtering-Correlation-Id: 044c0ddf-b6c5-4157-c21c-08de2c4759ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHlzWHNTd3NNeTR5Y1YwbG5mZG9VRDlqdUN2WXJmNlFsOEQrejdjdG5pNVpV?=
 =?utf-8?B?MTdSblo2ZWhHMlBYbDR4S3hjOVBlaUtMSjJYVFZXdE5RRmpBVURyL3IzTGJ3?=
 =?utf-8?B?ZzJUSmFSVm5UUlJRcG5zMFlsd1htY1Roc0hpZHl2Q0dyaUVOK2N3TlVKb1o1?=
 =?utf-8?B?cnBvQk1vL1ZTMFQ3VTZ2SjJHN2lhMGJEY0lZNmR0L2RVWFUrcXNGQWYzN1pp?=
 =?utf-8?B?ZlNlWVZ1SEZaMHBSb2ljeXpOWG5JSWsza281TktWZjRyLzJ1S0VQL1Bwbld2?=
 =?utf-8?B?N2EyREhrKzVLVUNtQ2FxRm11WVg0YklBRGxDN3k3dTlFLytvc2xvRGNSWlI2?=
 =?utf-8?B?T0haenNoZ0diVTZ1OXp5d0xwemQ2K0VGSUNMbWxsT1hDMjdXd0dnZ0hGOUNn?=
 =?utf-8?B?V0YvUmx0QVNFVzFjL0RWNEREVkN3d2c2OGgzS3ZJNGVMQVdqS1kySWs5bTcw?=
 =?utf-8?B?UlkxQXo4a1M4Ym5OTkpGM0JzYllhVFBsWEg1OUhCNE1HNGwva3FjZ0g4SXVu?=
 =?utf-8?B?b3JscjYyMDlsaE4ycVV3VmkrUXlmUVNUMHR1UHZHOG9DdElWd0ZtRk93ZDE0?=
 =?utf-8?B?aVpBd3BPMkozMGpTUy9pbE81cGhqOWFUVnIwR2o2OTM3V2UwWEdRMlE4YTFo?=
 =?utf-8?B?L2xwMkppMmRrQWFEMmN4bkJKUWUyT2FiSGZMRFp0RlA4ZUROY3pSZkpqRjBG?=
 =?utf-8?B?ZFRuemxiQXJiYmdHbDBpZ0xWWnRLYk4zYlVZTXlUbXhaYmN4aUQzVkd6a3Ix?=
 =?utf-8?B?Mnd2L0Y4d2dZdG15L2k4TXhSSENENHVQaE9wWEtPS04zaE55cVR5cEFLTC92?=
 =?utf-8?B?UzRWM0ZjN0VNNHpnK1JpY0YrR3l6NzhHRzRUZFpwVGltWnBoQTRUUGNCT0d3?=
 =?utf-8?B?anhhcWJHdzRZK28wS1gxVG1tTzhSN0h0VitGZ3Z5ZDZDL3RKNXQyV3FaMlky?=
 =?utf-8?B?V1QwWjluNFl2RjhHdFIyOW5WSGdzSlpqYkgzN1d5WkhxOEsvQ2NGU1dpOE5H?=
 =?utf-8?B?Q3RhSU1SZlBUQ1F0TnJPSjRReFVaQ1dYTGQzVkdGMnh1WnZVZXV1VVRERnl4?=
 =?utf-8?B?a2s4REk4YjhQRFBJVUFCckpsSFVRcnBEMUNpREtFODFVS0RLTHpZa0pHWi9p?=
 =?utf-8?B?REZpSTNSZGlob1F2TTl5QUlhcmhpYlpDYnNRN1VMOXkzKytFYllmV0NrMHN6?=
 =?utf-8?B?eDlPRjBqSmZBajI2MGNkWHJjekRRQmdXSU8yS2Z6dVhLUTNpSHBUeFR1bk9D?=
 =?utf-8?B?NmhkZWxINm4yNVA4b1RSQjhYN3lPQjRrdndSRUx2R2daRjZWc2xpc3cxQStI?=
 =?utf-8?B?c1ArOWxEV2lEbkpJdlBYSXBMd3hFRTFqTXhzdkFmNUdFb3NPYkV3dEFYQzV0?=
 =?utf-8?B?RWJqV2YybnRnVVp2dUlQNnNGY3dzTWxNSUo2L1BDN1NPcFRrdTNITEVUYTI2?=
 =?utf-8?B?eHpUS2RMdjdNcm8zUWRLN2I0bjQwNG8rOGxWK0RLZnV5R2ZtUUhJZUJmaXpN?=
 =?utf-8?B?QWVVUlh6R2lwUjFQQWQvWVNrTlFTYXR0bU5uNmVraElpdjBmdkJjUXNuL1J4?=
 =?utf-8?B?QTUweU44U1lpNUlXOFU0b1JTVUhiOTJlNmQwRFkvNlhoZEEvM3RUMzVDbWIv?=
 =?utf-8?B?MnUxYVFWRDQxMTAwanNjQk91bUtqa0NneW4xSGhmNFY0Tm4zS0x3R1VpSUhS?=
 =?utf-8?B?dldsS0JTcFkrcUdLT09DbHIvbU1MN3NlTC9WbUZ5MFhRRGxYYS9nQndzVGZr?=
 =?utf-8?B?UTJhRTFlcUVxWFdqQzM4enVLa2dUNEpQaDRONXhHMEtxMXJpNEI3ZnFRVDZE?=
 =?utf-8?B?OVdvbmkrY1FuVGFpdUp0TENVOWxYQUhvdTZZb1BMWjJpOTV6VGhIRFF2emZG?=
 =?utf-8?B?dVZmd3lPYlZMaHlnYUI0aVUxMTZTcmNlS21DUG5BUnd2K2hmaHFGTFluQTlF?=
 =?utf-8?B?UFlUQVJMU2ZmN2RqampEdWs4S1lEWDk4eXZiMHBPUzlybWl0WWZGRWdVTEoy?=
 =?utf-8?B?Z3U0dXVLeFd2WEJNeERCOU1wL2l5V1kxdzFwYzBOU0M3aURhUTFJSmJiOXRB?=
 =?utf-8?B?SWt1M1FOTjl3SUpZK0kraDVlUVd3UzE1YlYwL1dxME1FU2hvSFNjeGNDUDMx?=
 =?utf-8?Q?e9f0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:29.3514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044c0ddf-b6c5-4157-c21c-08de2c4759ce
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1469
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

The state of the environments are different for imx8 boards. Some boards
have more and some have less features. Cleanup the environment and bring
all phytec imx8 boards to the same level. This includes:
- remove unused variables
- modify variables for use with ampliphy-boot bootscripts
- set bootdevices, bootmeths in devicetree for standardboot
- let standardboot set bootcmd
- sort env variables alphabetically

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Benjamin Hahn (6):
      phytec: change preferred bootdevice dynamically
      phytec: adapt env to ampliphy-boot bootscripts for imx8 boards
      phytec: add emmc_dev and sd_dev env vars for imx8 boards
      phytec: set bootdevices and bootmeths in devicetree for imx8 boards
      phytec: use fdtoverlay_addr_r
      phytec: sort .env files alphabetically for imx8 boards

 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi   | 16 ++++++++++++++++
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi      | 16 ++++++++++++++++
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi  | 20 ++++++++++++++++++++
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 14 ++++++--------
 board/phytec/phycore_imx8mm/phycore-imx8mm.c         |  2 ++
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 14 ++++++++------
 board/phytec/phycore_imx8mp/phycore-imx8mp.c         |  5 ++++-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env       | 16 +++-------------
 configs/phycore-imx8mp_defconfig                     |  1 -
 9 files changed, 75 insertions(+), 29 deletions(-)
---
base-commit: 2d7eee5a55472f885474168acd3295d47a559755
change-id: 20251125-wip-bhahn-imx8_cleanup_env-fbab8d00fa55

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

