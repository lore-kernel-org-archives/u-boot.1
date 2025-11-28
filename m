Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B825D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7451C83BB1;
	Fri, 28 Nov 2025 17:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FxH2dAPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2084D83BC4; Fri, 28 Nov 2025 17:39:08 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D79883B8F
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcX8ApE3oIwMB44tnfl6fMoGjq+iiq9s6O8O7tLcIZtHCn/B3O7rcRFFSN0yg0LZtyZftA4Cd7CMtOa+TcaCh7YNNyMzzaE5+gNFuZ3pzLMEGQJP0R516nJUztNOkwEOyrjjoyYTJxMvfTsbBiN20EwmJWTwa2j+/Tjf4aXnIMf8AJI/sGYgo22SO/AQ3sfu2ReSmR+g4DravJaTq38mM8Jh/GoOL4FFDEpYIN6juIzGi6U51Mtpdf/2D+MFR1ozQRcj0o0aKAMKHnD6EbHtR37RgDW+ufpSuKEooq8IajLTB4L/jxVIj8JqFYJz1WCIWHhIiXbogU2g4FYVhxnYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGB/9XYNucsgraI/lOj1DlPlBkwafK753BEulHJAazo=;
 b=OUoLE0lzYHBgucKm1DB7d36WhevQ8eL+4fC6eBCLWn02OxnXYdZn8mBnZF8JdLTlM441IQozXWCX7eyeRyiUXEJ5QdwYI+tWlhsww3DwiC7b+OspT31MfOnhF4PJdbWkoM8Ajy9Fe7QE2Kbswil7vQUvmI6HrU+U5kLn5gAOioRutdfOpwk1e6SIcBcoguVq8Y31AB/ZiB7iBmy2i90OXAbu2qt5j1V1ecvaqWLTm/NbvfPCuth/3DENYC2VXpOLCruB6mSJUoUai89s95NvplLjvQCGZix0y1rBJLGXVpceeg6gApRTqkmh0PlV8Kv4HTErwRndGwjEYpRKu9+XYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGB/9XYNucsgraI/lOj1DlPlBkwafK753BEulHJAazo=;
 b=FxH2dAPlhjjrLTu4uHwOK9vyemQGbvA7fQLhfMBDGPNSrxFPeCEQoa3odHnC7GMPmkV4NhnWchv9NIgXGAx/FScgSt9Inc2YOQUTf+89nJrMEC3VvkPixk0bfYR+eYu4Dx09rtXdTqo3WfE5t5mo3uASGepBjmh6CqfI1l9jIv2/pDu8TstCwlCJLop65gEUk/9lQN7Hje6K6GblLRvEpiFf4WwO8ZXYZZpCZcq6A/llrqB1kIN+enRmgkRaqbnRkvkXyj6UnKcTS+eMyQiZj6YPV6g17WTUmacXoOAyIgNy9bjSmortCB08GnWLT1DezRem0Q+BjVd7aCHdraAHIA==
Received: from CWLP123CA0252.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::21)
 by AS8P195MB1319.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 16:39:01 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::17) by CWLP123CA0252.outlook.office365.com
 (2603:10a6:400:19e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 16:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:39:01 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:39:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 28 Nov 2025 17:38:44 +0100
Subject: [PATCH v2 4/6] phytec: change preferred bootdevice dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-4-93ebfd1591c7@phytec.de>
References: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
In-Reply-To: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=4237;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=1ZrUC/ZfB03Y1jCDnd52lCheGdeiPtdWqjRcIASFhJg=;
 b=qfI7jeAWuM5FgqOVdUioIsPmDiyK7OqC3OcRhlz+mH7VBV16yuHgF1acb5QaAFMQU4Ovbo95E
 WVcrZOjm8h1CtzMI06InmCqAtlwkX/yylWE3dQHtfvmw/KXecrfDMkQ
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AS8P195MB1319:EE_
X-MS-Office365-Filtering-Correlation-Id: 5112ceb3-04b9-4f47-6d2e-08de2e9ca2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2xCcXdsVHhsUk4yQ1ZZTVJHSTQ4eVVwVlRHbTZ4WjhyeXJMMXF6M1pwcHJx?=
 =?utf-8?B?YUFUQ210d2V6T3VaV1ZMc2Y3clppSHd3R3ZFWW9NTldTOHROakV6VjRoNWg2?=
 =?utf-8?B?dVhXNlN3dnhyUUZWUDN6bkFxSG9pRll0bk5kc1ZmSkl3WkN0bkxiZkRUNThk?=
 =?utf-8?B?NmdySTV1cHBtTjdxVll5NmlHZVJPMDRhRDZvVFRvUjlQWWp5c3YyY2picjZV?=
 =?utf-8?B?U1hwQWpqUCs4dkdWdDNXWkh2QkhBQ2hibTBNQUVkYTVNazlndndibkFzMWdG?=
 =?utf-8?B?NnBKb2dJcGkxRm9ueHdNV3l3ZXhYMkk1NEdUaFZRMUVHNmlZR2tBV2hYRnJS?=
 =?utf-8?B?RlhWZkhZZmhNYnZJTENjbUFGSFp5UGdGZ25vdGJROWJIek9KUXNmc1JjYUg0?=
 =?utf-8?B?WHpDRUxhUkRSTFlNWitMK21WWHZ5dXZkdUJsK0hkVEl6VmJpL2ZzMllsK0Ri?=
 =?utf-8?B?aFc3N2FQRXBrS2hhenFPMXVqRU8yamFPc1ZzTDVXQjV6bEtJNWxCQUdoN3FD?=
 =?utf-8?B?dllWL25sMUhvSVE1cjlOd2d1ejNyL1doZjBvUGswR2k2N1lUajh3ekxQZDNK?=
 =?utf-8?B?Q0xobjBXdGhWeDM5QXM1aHdJQ2ZXSUk4UDREWVY4aHFNcnlzME9aeCszUDJX?=
 =?utf-8?B?eGFCOTNrZE1ERjlXQldiT1FUNEQ0OGtBdWRwb3Nkb2dkbGdnT1IwVnRYczBG?=
 =?utf-8?B?VGdHMUdWZU9jS3BxTE04YUpveHVuZ0gyV09keGNPaTRHd1BOZGN0VzVCKzFk?=
 =?utf-8?B?bWQ0ZjJqUmJJRkZUdUZua0NqQjhtZXRqTWR1eUJKVzYxWEprQWdVaDh6c1Fw?=
 =?utf-8?B?Y1lPeXN1T3VQM0NjdnpSMnF5aElicXlvb2FLdVplRTRKWmk2Q2owRVpaSmRS?=
 =?utf-8?B?d0ZiSzVQcUdNaWhYaG5FTWV2YkVvYXRKQUlKLzJOY2NSUVl1ZWh6QjRoK2NX?=
 =?utf-8?B?Nmh5ZkxrbXpIRFozb2U4VEpvMkJxS1BLaEFQQVRyN2NrK3FiQjE0dUJPcFpD?=
 =?utf-8?B?bUpveGZHRjViK1VSWGloK1VuQURNT2ZMaEdyMkJ0NEMydWw4T1VQdmFTK2Z0?=
 =?utf-8?B?NjVuSGExd0Q5aEszVUl0TFYvM0V5L2NuUGxQT3VoNGhFRElkWHQ4UVRkOEhH?=
 =?utf-8?B?cThwZ00xcHIzWEhRcU95R3hwcEVVNHdldG5LSTd6eDcvMDBVdCtqRlBaY2F6?=
 =?utf-8?B?WTFtMVdLVStTUzdrNFF5cVJXeGp0QlFRWHp3a256YklBVTROU3pnYzVZaytO?=
 =?utf-8?B?bG9wMnVsRnFZR0diTlpDKzQzV3V0SlI0bGoxcStjZDBzdG9WeWFUSmNzYmpF?=
 =?utf-8?B?cGRxR04yQkpoTEFFWkV6QStFVEJ1MllwYXd1a0lxd25VMHd5OFJKN05oMGh3?=
 =?utf-8?B?TjdQSVUzYjU2a0drNVd6U3p5c3cxMk8xYXhrSUtMeFNXK3VDNkJ4cmhjUDdH?=
 =?utf-8?B?T3BsSG5idVFxM1piSWNMTDF2emRqbnI5RnA2VWpOU2pIZjFoY21pd0cwSzBh?=
 =?utf-8?B?SWxvdVd5S2VkcTZyL1BqczZ4aFcyMEViZGx3dHcvaFZjdnJ5V1NCL092TUJZ?=
 =?utf-8?B?NFdOVzVnK0VtNkI4cWRPeHorMmFmWVlBakRNMTJOR0JXcUt1SFZ6TGVpN3lm?=
 =?utf-8?B?YmE0ZkdCeWdHeVJvVFJSWXF1bklSRFFRNGVUR2dTaytlK1o1bEpoTkduNGg3?=
 =?utf-8?B?WTd5Y0JUOXZGUG4yMFlCZmdWdzBLbEFCL1ZNYUhObGdqYzViaWwvVEd3VGxn?=
 =?utf-8?B?VEJIVVNBQzRjUUJSQ3pCVFZnVzlXeVljZzhBYUJaQ0tjZ1FqYmQ0UUJvMDlr?=
 =?utf-8?B?V2JMUm1BTWNrMmIrNnFJTi9HS0ppOEQ2dmxTUEpFTlBjVkFGeUo4ZXhmcnRJ?=
 =?utf-8?B?QnNsVDNrVURORFlRMlRWTGVyQzlUZFFwMWdIWWIzcmtwZThsbnlydHhMNFJW?=
 =?utf-8?B?Rmo3Wkt4aENJZEI5RnJLWlZCU2tqQ3VZS3hiMFNROXBoWmtEc1VDZklnckQ1?=
 =?utf-8?B?bUJnK3ZPazlLK1hzVFZiZmxxaTdSWUtsSDl1YnN5bkQxL0J2dlgwS3FYWGla?=
 =?utf-8?B?Z3ltaDVKVDZEZmREc3JVLzJwVTFTNEVvUWJiQi9nTUtuNmNmVC85bkF1NFhI?=
 =?utf-8?Q?yM3k=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:39:01.6103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5112ceb3-04b9-4f47-6d2e-08de2e9ca2ee
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1319
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

We want to change the bootdevice dynamically, so that when booting
U-Boot from sdcard, kernel is also preferably booted from sdcard by
default. If the user decides to set their own bootorder, this should not
be overwritten. This was already implemented for imx8mp-libra-fpsc
board, but as we set the default value for boot_targets in devicetree
now, the env_get_default will return NULL. Also env_get might return
NULL when boot_targets is not set. A string compare with NULL is unsafe
and should be avoided. To fix this we only change the env value if the
variable was not set before (NULL), as this is the new default value.
In any other case the user has changed the value so it will not be
overwritten.
Also let standardboot set bootcmd automatically. For this
CONFIG_USE_BOOTCOMMAND needs to be activated.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c | 2 +-
 board/phytec/phycore_imx8mm/phycore-imx8mm.c       | 2 ++
 board/phytec/phycore_imx8mp/phycore-imx8mp.c       | 5 ++++-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env     | 6 ------
 configs/phycore-imx8mp_defconfig                   | 1 -
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
index ffa21da1b343..dbbcbec18cd9 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
@@ -60,7 +60,7 @@ int board_late_init(void)
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
-		if (!strcmp(env_get("boot_targets"), env_get_default("boot_targets")))
+		if (!env_get("boot_targets"))
 			env_set("boot_targets", "mmc1 mmc2 ethernet");
 		break;
 	case MMC3_BOOT:
diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
index 06cffbca3a69..f6ae0bf03087 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -41,6 +41,8 @@ int board_late_init(void)
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
+		if (!env_get("boot_targets"))
+			env_set("boot_targets", "mmc1 mmc2 ethernet");
 		break;
 	case MMC3_BOOT:
 		env_set_ulong("mmcdev", 2);
diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index bf2d5ce01fa5..b345dc7c9856 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -76,13 +76,16 @@ int board_late_init(void)
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
+		if (!env_get("boot_targets"))
+			env_set("boot_targets", "mmc1 mmc2 usb ethernet");
 		break;
 	case MMC3_BOOT:
 		env_set_ulong("mmcdev", 2);
 		break;
 	case USB_BOOT:
 		printf("Detect USB boot. Will enter fastboot mode!\n");
-		env_set_ulong("dofastboot", 1);
+		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
+			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
 		break;
 	default:
 		break;
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index f825c7bc61ff..c339c315c308 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,11 +1,5 @@
-bootcmd=
-	if test ${dofastboot} = 1; then
-		fastboot 0;
-	fi;
-	bootflow scan -lb;
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200
-dofastboot=0
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index c497f0bcd913..2fcf7db9e5c8 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -38,7 +38,6 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_FDT_FIXUP_PARTITIONS=y
-# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074

-- 
2.43.0

