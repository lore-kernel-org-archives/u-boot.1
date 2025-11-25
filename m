Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB3D0EE00
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE5584120;
	Tue, 25 Nov 2025 18:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="NOiL4Kyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3200C84120; Tue, 25 Nov 2025 18:23:38 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E771B84112
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvVJ11ykONxB1Ae6Xi6OTpFMYtcBIV3/DTpL/26OH1JSH9qtAwtqgdWIgPVgfylPoqZpstAf4c/tLvvob8yTictXyDwTulo8D9QN28EI5lEDTtEAoje4bMSU+NNDoNlG8fVV2VlXwDm6yJZLhjcA8B4VN90SESgylz9bjK3B58Sb9NZh2l9hj4188aoq+dw4JHYvoNXvM/5f50gtwqWrqyfwSTQoxdJzqunS5XKyjDl3MVV7qmlC9yO05ZCuIEUzPoEArTD5f/CADkahsVLFOtlBxb0Ncqh6GLyNHPZdSY39qI9TqxMpHhsygJQboeC+LAKzu4gO/QULY5ufVFATYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJPzvUG0lSl6VQr1q4mZZVMG9XI0KJPdh89LyihYOsM=;
 b=ZoU6wLUlkKt6trgyvm10iNK0espou4SedXRFW+/4WQHtIlaWs1hpoLSHBqPNkfdgVPuZryLFw48glrwYBAdKtv03B71O0K7uscTtVEPpCt61UUL+n1dntGkl/mmcJeBmekAHyPZJpNyhIEahf0Mw9X684HfWtMPlto1DB6tHxCpUf/B90tVHm+JVGEQxgGWCBcb87+T6eRGde1kvLYBTeQ3QT810vFP0wsHvzGRCMTvG0thgupSWDyOyY0V3AY2ZM04ezRNyfitjg4B30CEvB0PjV4NWCnOiTj/B6krYQzizewpsPABa2DV+cihrCUdZTBr7N5p/3DNiqIp3KBETVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJPzvUG0lSl6VQr1q4mZZVMG9XI0KJPdh89LyihYOsM=;
 b=NOiL4Kyu64PAB9yCiXPUmQ2IHzL0pAHc4+LsEQ2V0OGm3qRLUkXIqJPYsqIS6JSrgNtvycRX45TWfQXk9Iwy9zhMMoty78uB+xWuNDSwhJqSo18yosmqMjjZxiPB4agDv1MnC13mBuaaOwaU+T3m0NuQjBW2kC4u17VObaKQRiZBumqd83IudS/AYLR8xgLKrM/LarnPf7C/bZwJeyXBVwF0UV47bvJV3a4xjiOh6QXhJXvEh2eDOkduO609YYv2qWR6fmUqC2pLvx21m1MpMDtMv1uv/vBpsthHXE17QcjNneJclaKrD+i6KdIkXVBtO09sKcAgKKiF2Dh/wjEpUg==
Received: from DUZPR01CA0183.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::21) by PR3P195MB0508.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:24::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 17:23:32 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::56) by DUZPR01CA0183.outlook.office365.com
 (2603:10a6:10:4b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 17:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:32 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:30 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 25 Nov 2025 18:23:14 +0100
Subject: [PATCH 5/6] phytec: use fdtoverlay_addr_r
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-5-414829c01b4b@phytec.de>
References: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
In-Reply-To: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=1562;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=AwmAzCKPCUTQbZOWqWS5WrEkIZcfAcAgqr0cuK3P5ls=;
 b=M4pRj/kRyiaBVXFp6cjd/5PcHlBAU/OIMGDS1dx+8lCtUJ7khTHTRPKKPO9EN4DCsfBIDBUun
 APqLUhUbT/wAHhO4DAqWpWcufcMdfpHPtianxkgL1eoDOBFX22sV2GC
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|PR3P195MB0508:EE_
X-MS-Office365-Filtering-Correlation-Id: c774523e-50fb-4c4d-0609-08de2c475bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cklGTWdhQ0lmZDRJdzM0em1pNDZLQWpmamRRWHliRGtoenpNdzZmWnplRWR0?=
 =?utf-8?B?dFBSNC83UWk2UEhRL1VCdEN1K3R4cGFNR1A1dytPeXl5R2lxZjhyTGVRakhV?=
 =?utf-8?B?N0kzQWFjQzcxMmd6OUc2UzFRYkFyQjlzWE5ieGNBa2ZuNTY0VHJDQUhKUUN6?=
 =?utf-8?B?UEhLMHRydWFJNjhPQnQvYjNDYkpLemorb3gxOUhNWE5tYjV1YzBEaGxqOGQr?=
 =?utf-8?B?NHRFQWpGSnZVK0hhVHdpdGE1YmJFYVpXSFBqamcrVmlpM1IvVGJtVmg2bDFx?=
 =?utf-8?B?VXJkckVkUnJXS3VhNzFGRVZYNGgwVkR3RFZWQWpLcTBjRDZrTDNvbnBReUFW?=
 =?utf-8?B?SDNpMEJZTVhTT2tPUVNnKzJhQmRZRTFHVnEyVVd3ZTBMbUtaQTY4S202dVpa?=
 =?utf-8?B?OGJMaUUrR1JRL2h2TDFucDV4Vy8wbmRvV3VOWlQxc1Q1Mk1DcXFuQXlhTWdH?=
 =?utf-8?B?VElnZng3a0M4Z091WWRhYTlMdnJPRDdHZjJ3R2krd1ZtL0FBREpvRmptZHdO?=
 =?utf-8?B?SFpKTWJDNStNRGRUdGk1TDAyZFlnZkdZMDhnMVgwZGxPVW4vYnp5VjZOTVRw?=
 =?utf-8?B?RHpBNW0rZ05lRUhoUFE5T1k5STQ5WFVyT0FuVEcwN1R6K1RqY0hOUXFFM2l5?=
 =?utf-8?B?cTFmNUxST3hWQkhSOHF1aXRvTStVMGd4MXNnWDNQczNpSmJTcFZ2dEZxNFBC?=
 =?utf-8?B?bXVRSU5TTGltSG9penc2RDhpaEJGTzlRa3RoelNBeW5EU3Zsc2JHekkwZ3Rj?=
 =?utf-8?B?Ui9sR1JqMDZHeVhVQmc4YjhGdlBzWU90ZlBrajhLcjNrSXkrbXM3dVFLNlJV?=
 =?utf-8?B?NkFWSUc5RzVTUXNNNXpmWTBDQzRzLzV5YXZaUzFvcWxuNUJxd0RaTFJiS0pZ?=
 =?utf-8?B?Uk16dGpxMUlibXVHenRXVWI2aDcrMjBmbTRWVTdGbW8yVVBXVldHbUZqLzlo?=
 =?utf-8?B?WWJPeU9LN2dXYmdmd2QvMUtxRTJFMU1pVGpPNW91QTRYMjRlVlJ1b0YxWEYw?=
 =?utf-8?B?NWdVbW8zVjZ4dllZNzdtL1JtajZFeHBsT3A5bXZQdnpYNnlHSG1OQmV0Zmcz?=
 =?utf-8?B?NWd4bW5UK0VKVW14ZGlQR3ZEOVJZdzFJem1MODNyY0FjWkVvUy9jQWhSSkMx?=
 =?utf-8?B?MEhvdXk5bjNhM0tMU0QvbE56Y2Z4RXVtMkQyTWJGSHdBZE83c0ZDRGJlVzFk?=
 =?utf-8?B?amoyRC8zY211bjh3bHprSzZJZzVBVXdScWxLcTlpVG5XbUtYZGdhaUZDUm5L?=
 =?utf-8?B?cjhzTHRWNEVMYzJkdzdWQWFEd29IdEJwaUdiZzlGVDllZ29BY0VZRHlBclpp?=
 =?utf-8?B?ZHJwVm9PbHRRa3BtVFRxQVV0L1owUFdWOXBjMmQxMm5vV1ZRb1l6MS9ORFdT?=
 =?utf-8?B?eWpHQkJDczNpSWRTMThWelRwb2hnVW5sblFnSFdyeEFVblU5WGMyd1RGNkZH?=
 =?utf-8?B?bkFEc0h3cUxlMU5DY3pkMkRkUFU1L044NGs2aFZHdi9kVkovby9TWks2MGFJ?=
 =?utf-8?B?R0NpKzFtSzd3SVp6bjNGUGdRYUdkeDdFdG9UbWxvL3dSOEoxcEZzWThvdytu?=
 =?utf-8?B?RjdiMEFuRVdXK0JJdlRFRzYrbmNoMlNzaGNYcEhwZUJVaUsraWxrT0pvaXI5?=
 =?utf-8?B?TnVNL0E4SU5kQlhQazZ2dnErODNKcGtGdG16WDVBK2VvaDlrK3RsWU84Vkt5?=
 =?utf-8?B?anJBa3Vod0dpSTRxckhJQmJmZG81L2pnV3VoUGVUVEk3ZkIwR1RTZVpPNVFR?=
 =?utf-8?B?WkdzakowWWg4ZHQ0Yk9Rc3BhaHNHVnI2NXpGY054aEFSc3hydmRXTkRCREcw?=
 =?utf-8?B?UGJ3a2p6TzdrQksydzlaMWpYMTBlUmdyZVZGR2s4T3Qxd2NJdWZjVU94NHBm?=
 =?utf-8?B?dno1RFdxaHgxbWd3Tm9LNDJIdVMxaGlwYXU2bHFIcXlwbkkzMkJFelgwcUp5?=
 =?utf-8?B?UTlUbkNwbGQ3R2xPMk5XZFE3czN0R042TEJtVHdMTmowN09ZOHBrUjBlT3Va?=
 =?utf-8?B?eSt3ZG9sR3B6NkxWNFllenlidnhMekdiYzExQkRBUFV0U2RYK3FlN2tUdkVl?=
 =?utf-8?B?SU5uRzRpa1VDOXA0N2NabE1sNks0eGt1ZzR4SGd1NHN3NmVncGI2Z0UrTGd0?=
 =?utf-8?Q?6F9M=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:32.5051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c774523e-50fb-4c4d-0609-08de2c475bb0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0508
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

fdtoverlay_addr_r is the correct variable name according to standardboot
documentation and already used for phycore_imx8mp.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 2 +-
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
index 5fe49e2a375b..b9f0b2fb8ccc 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
@@ -3,7 +3,7 @@ console=ttymxc3,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
-fdt_overlay_addr_r=0x404a0000
+fdtoverlay_addr_r=0x404a0000
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index bb444d182939..4bf017a20baf 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -3,7 +3,7 @@ console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
-fdt_overlay_addr_r=0x404a0000
+fdtoverlay_addr_r=0x404a0000
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000

-- 
2.43.0

