Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228FFCCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 14:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BB180107;
	Tue, 21 Oct 2025 16:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pjS4WWUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87367802C1; Tue, 21 Oct 2025 16:34:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18470800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 16:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXy849icQl/P9VrWssG/54om6SzIZXbMDStOOTRD4kFrvGsTjn7ncXmQzCwpbyR/uMFfzatl1dN9GLHoo/+7F6Lu92uKwHPGUnAhJzrtokl9BT5FFqYMbd77pLr6w/Nfih7EFDF4GYBrRD/pPBp0uaOaiGTaIYVxqIrD7u83lRsKhlhlqnXKyVxXnNUGzqUbj+XP6qISp4gnBnl6TMxzWkR++toBYOFiAO2+KV0opJKTM2qO/zhOkIKtKDvTMmksKuK9qyx7Wa30Do+kIaq21IAvmzmCVio2FA9iVxHgkMG5xM+W0z9xEG/XgrtyiV3QiaKJz7e5GDk/SQuiR2G7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+/7FnrkioTSoRHq2QwWfP1gf3+Zu2jaFl7JM+nOYAA=;
 b=puOcRh50gGj20jH8pTqLUoqZ8DiTTFP3sfqmcUA6PHobiWuWKOVfz8nANRBCB6Td2jwdkI/VJvZmiv33MjNZVeq2qeSeChVTK1E719shnl9uYJJ72qCUMBvBmV2Ik+BdPQ39VyZKEB+bQEURfuz/8qMP10WRLKiR5whCBcIOJnOjQarBzkDeSAyHJ5Xc6Td54GzzyY6iFvzvUx6o9dgHRf+iWoEGY2b+zAcklqXxG3URMqe9iID1Ife5PB4Z5JzSoXUYQ4m3OUbUMOwQ6DFeUg8Y+FlGYrfRtYb1mZ1SqjB+hdjqcauxD3n7ga4KA1Oac+DJRJ8SgdSZe5XqJSI0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+/7FnrkioTSoRHq2QwWfP1gf3+Zu2jaFl7JM+nOYAA=;
 b=pjS4WWUPbfA9WN7zlQOXcY8dbzGu/Rx2IB9kajULgqPn7mruwbTbVk8eu1+RwDKG6Zq3A1HuXSXVHkCCe4WFPf9BA2kefoiAf2GIm8noMYgF6EGP0L/AK5W9oWTO4rAjxmuwnT6/3yU+oqm0leM5i8Lu0I3IDM/HmH7Ed0X7DQh43+WDTI77KGGEnOOuvCtSOZNBjIgBbQBGqhrRjJX74tQve0EoU1HwyQMNVDi1oxRo96xAYGhhPzNe6Sun6oJdXgxR4OMCx+98jTC5Gut0wan5FJ354NunhKTtirszA3jwyL6o9yDbK574Etelsz1rnt/h7mGj88bQqa27wlYsQQ==
Received: from AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::17)
 by AS8P195MB1632.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 14:34:24 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::31) by AS4PR10CA0027.outlook.office365.com
 (2603:10a6:20b:5d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 14:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 14:34:24 +0000
Received: from [172.25.51.48] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 21 Oct
 2025 16:34:23 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 21 Oct 2025 16:34:17 +0200
Subject: [PATCH v4] bootstd: make it possible to use tftp for netboot with
 standardboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251021-ip_dyn_bootstd-v4-1-1452ad40ab0c@phytec.de>
X-B4-Tracking: v=1; b=H4sIAOiZ92gC/3XMSwqDMBSF4a2UjJtiHubRUfdRipjkpmZiJBGpi
 HtvdCSVDu7gXPj+BWVIATK6XxaUYAo5xL4Mfr0g27X9G3BwZSNa0brShOAwNG7uGxPjmEeHnbF
 MlROae1TQkMCHzx58vsruQh5jmvf+RLbv39REMMGSe8nrSlpL1GPo5hHszQHaUhM9cMpOnBYOp
 tatVAoEl7+cHTk/cVa4F1IJbhRppT7ydV2/MhjqnCoBAAA=
X-Change-ID: 20250911-ip_dyn_bootstd-dbc38bc3694f
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761057263; l=5046;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=UvoQX2Y0xWc2Fmv/AaQIsUhaVLi6wqeiY1LLysEe28k=;
 b=27NQyDzCQGviL0TxFbdL/MGbzM3u+JjMzTOVYz44a0XWH0kruY5ZW5Pfmd1AKwuQvfSu33SZ4
 zmHlxDMENKGAP1mWB5w0HUJ2U2v0BGv3Mo6XoeBUBiij6g34dRmuzhg
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AS8P195MB1632:EE_
X-MS-Office365-Filtering-Correlation-Id: 571c0d66-765e-4faf-53f3-08de10aeee3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWtkUllnVGxvTFRrZWE2cXp1eWJzZzczd3F2UTlONU9yengrMXdCVE9aOFZh?=
 =?utf-8?B?aytHVEw1U1ZaNzVUWjFYSy95T2VMQzdTOCtaZi91K3ZmckZ2dXFWTm1VQmlt?=
 =?utf-8?B?NnczbDlxa04rWGhCUXBDV1JjYjhGL01vY2c0M1lKQTFUMklSN2lXMnFsQy9v?=
 =?utf-8?B?THViOGc1QzhXVVpwWEYyenpWN3l4ZEhXVUlIblpOb1hiRWFvVlpWSlZmSzhQ?=
 =?utf-8?B?MFhRcjVPanFiMnd2d2U4VXE1clNZU3pFUmVtaE40UCtqczBPclpQY0drODRp?=
 =?utf-8?B?b1dORFlnVFZGTS9Da2pOazVIMlVQcnhNa01ycHRTSG5nNm11S1hpakFYeTR5?=
 =?utf-8?B?NGk3UGFacGkwUFNiYVhEcXRBU3hsVUVrN1luK1JSVERhc2R3N25sRGtKdlU3?=
 =?utf-8?B?cmtyQnhmN1hzNmZTcFg3M1E1STNRbVBUNmlMMk8zeVdGa0NveUFrL0JOUExL?=
 =?utf-8?B?S1F6cDZ3S3Q1SHZ4dU1DT3FtNVRLY0pvOFJPSXAydko5NFJWNjR6TDZxVUFk?=
 =?utf-8?B?WTdneTNIRzNBYU4rQnhselEvK21aWWEyeE1IYmlNMWtReER2eHRwY1BCMGhG?=
 =?utf-8?B?Tm5sSGtscVFBSnNRWW5zdmpYK1MzOTFURDMzcEdoRHFCSGo5c2g4dEZBMXdk?=
 =?utf-8?B?aHVYZ2s1eWVzRnFSNUZqNERiQ2lzSE82dk1zMFg4U1FSb1hpZUN1U2U3bnlN?=
 =?utf-8?B?NFlIWjVWRGNFUkVIOFZSTUNXSUg4Vy9vc0tsTm9ZbzJKQ1RUeWFvd1RvQ0lw?=
 =?utf-8?B?Y3dxcDdFUzMyUDAwMWlCbElxMHJMNW1aV0kwOW1EVWhLck5jWEJWaDRUY1c0?=
 =?utf-8?B?TTFjOERWRXRSR2xrbEloSU1ITlI4U3BtNUVUc1MxOS9pbG1nSlp2dzh3d21o?=
 =?utf-8?B?TUUzVEdHYTl1aElTbWJFSHlhTHNhMExYL0ZsOUlwQnc3Q2xiTTEyOWJkNEo3?=
 =?utf-8?B?Tlc2eHFaa3pXUi8rVGlNMFp0ZzNiMElreEY4cEVGS0hVYTVFeDczZHlPVEI4?=
 =?utf-8?B?Y3ppNzRPOFdQM0xxSlVvWElJS1ZMR0N0UlhvNDZhNzY1V0VTMXpLOFRGQTlN?=
 =?utf-8?B?TjVBaHM0c1FMOHNnaWo4OFlOcDREZi9mcWg4SHQ2eUJVWXpkRmtQbXVEd3lJ?=
 =?utf-8?B?ZUlIWVVrMnBZUUw5Y2ZvM1NMN2Y4ZTg4bnJDYi9saWFpdDlSZFRUZVdoK3RP?=
 =?utf-8?B?MWRoVk5iSldtMUt5NHREaUhpZTh2ZXpIRkVxVUo1SVd2eXdqcTRGNFRGYWJn?=
 =?utf-8?B?bUN4bkpreFoxQWRSZ0lGL1hmU3NvbmlrNEpObUVBb2hkK1FkWUtOS1F1QXRv?=
 =?utf-8?B?YlV1cG1NSDZ0NUw3Q3BNb3cyQklsS2tmZlR2QWZmeWJKaFI4MFBleGsvU0dB?=
 =?utf-8?B?Q0VlZy92bkl4aFI5YlpCWnVrRlRFQVAwOEVRdHNNY1llV0plK2o5VlZjY1g1?=
 =?utf-8?B?bHZ4QlYxWHRqZ3FPUVNvRklEUVVCYXhjYkZZYUhBZVJVYlI5RWFKNnZ2NDBB?=
 =?utf-8?B?MCtidVZmM3BYcUN3QmdWSHY0VDFKVS9NRWJZaDd2RFpWbDFMaUt3M0JhZGdw?=
 =?utf-8?B?eDdSU3Q3UHRtQ2F5Y01HRk5JUkV1ZVRpalRwN0xucU9yaHhNUFZPQ0ZWbytF?=
 =?utf-8?B?b2JEYmRFZHVyVzN3ZG1PR3VVZjhwL09odGFLb3UwWlJHcWYrUE81cmFEQ1pk?=
 =?utf-8?B?aFZ2cXMxTVAvb0dKOEpsY2c2L1ZKVWpIUDdSMEFvWk85Y1R3ZEtYaGpQQ0ky?=
 =?utf-8?B?QVY4OEdLZTZ4OXZWYis1cmxJdEh4WDBBVDJZcVZlc3VUandCWU9WT2VXeitv?=
 =?utf-8?B?S2FQbHQ0MXhsMGtsR2lCUGdmVmgxTmQ5a1k1Y1RjdytQazM1MGVabE9FWm03?=
 =?utf-8?B?ZEZHTzBTNlQreVM1R1k0WVJ1SS9lWDcxc0xWQm1MdWtMY3gwUUxoNUVBTmtk?=
 =?utf-8?B?NkJDNlZrcVNySmlKb2RPZU1nWXFQSXp1UFV6N2lqOWFBOEZQRFVxWXduUit2?=
 =?utf-8?B?TlF2dk9WZjh4eUVvcUhWQTJoZVJVNSswSlkzS2QzUi9BU3JLREpwY2FWV2NQ?=
 =?utf-8?B?RHRPYjI4ZFJHbUNNYi9hZlFjY3JmTW41byt3ZzJLNXdnU0tuUStuaFB5Z2Zu?=
 =?utf-8?Q?+WGE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:34:24.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571c0d66-765e-4faf-53f3-08de10aeee3d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1632
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

Add the option to load the bootscript with the tftp command (static IP)
instead of the dhcp command (dynamic IP). For this a new function
tftpb_run similar to dhcp_run, is needed. The selection of which command
to use can be done with the ip_dyn environment variable, which can be
set to yes or no. The ip_dyn variable was chosen as it is already in use
on the imx platforms.
Also edit the bootstd doc.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v4:
- moved tftpb_run to net-common
- depends on: https://lore.kernel.org/u-boot/20251009123034.2441110-1-jerome.forissier@linaro.org/
- Link to v3: https://lore.kernel.org/r/20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de

Changes in v3:
- code styling update
- Link to v2: https://lore.kernel.org/r/20250923-ip_dyn_bootstd-v2-1-eb59a788e647@phytec.de

Changes in v2:
- fix build error when CONFIG_CMD_TFTPBOOT is not activated
- Link to v1: https://lore.kernel.org/r/20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de
---
 boot/bootmeth_script.c           |  6 +++++-
 doc/develop/bootstd/overview.rst |  4 ++++
 doc/develop/bootstd/script.rst   |  6 ++++--
 include/net-common.h             |  9 +++++++++
 net/net-common.c                 | 21 +++++++++++++++++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 020cb8a7aec0..cd50977cc404 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -129,7 +129,11 @@ static int script_read_bootflow_net(struct bootflow *bflow)
 	if (!fname)
 		return log_msg_ret("dhc", -EINVAL);
 
-	ret = dhcp_run(addr, fname, true);
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT) && env_get_yesno("ip_dyn") == 0)
+		ret = tftpb_run(addr, fname);
+	else
+		ret = dhcp_run(addr, fname, true);
+
 	if (ret)
 		return log_msg_ret("dhc", ret);
 
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 0a2373595755..f94b73ad4d2c 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -261,6 +261,10 @@ fdt_addr_r
 fdtoverlay_addr_r (needed if overlays are used)
     Address at which to load the overlay for the FDT, e.g. 0x02000000
 
+ip_dyn
+    Use dynamic IP (dhcp) or static IP (tftp) for loading the bootscript over
+    ethernet. Default is dhcp. e.g. no
+
 kernel_addr_r
     Address at which to load the kernel, e.g. 0x02080000
 
diff --git a/doc/develop/bootstd/script.rst b/doc/develop/bootstd/script.rst
index 47f3684b86b9..3b19c22726ff 100644
--- a/doc/develop/bootstd/script.rst
+++ b/doc/develop/bootstd/script.rst
@@ -12,8 +12,10 @@ list of prefixes (``{"/", "/boot"}`` by default) and can be adjust with the
 `filename-prefixes` property in the bootstd device.
 
 For a network device, the filename is obtained from the `boot_script_dhcp`
-environment variable and the file is read using tftp. It must be in the
-top-level directory of the tftp server.
+environment variable. By setting the `ip_dyn` environment variable it can be
+decided if dynamic ip (dhcp command) or static ip (tftp command) is used for
+reading the file. By default dhcp is used. The file must be in the top-level
+directory of the tftp server.
 
 In either case (file or network), the bootmeth searches for the file and creates
 a bootflow if found. The bootmeth searches for "boot.scr.uimg" first, then
diff --git a/include/net-common.h b/include/net-common.h
index 78d98e5bba07..f5cff3e7c0c5 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -490,6 +490,15 @@ int dhcp_run(ulong addr, const char *fname, bool autoload);
  */
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
+/**
+ * tftpb_run() - Run TFTP on the current ethernet device
+ *
+ * @addr: Address to load the file into
+ * @fname: Filename of file to load (NULL to use the default filename)
+ * @return 0 if OK, -ENOENT if ant file was not found
+ */
+int tftpb_run(ulong addr, const char *fname);
+
 /**
  * do_ping - Run the ping command
  *
diff --git a/net/net-common.c b/net/net-common.c
index 442b05975581..c68e19fc03e6 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -83,3 +83,24 @@ int dhcp_run(ulong addr, const char *fname, bool autoload)
 	return 0;
 }
 #endif
+
+#if defined(CONFIG_CMD_TFTPBOOT)
+int tftpb_run(ulong addr, const char *fname)
+{
+	char *tftp_argv[] = {"tftpboot", NULL, (char *)fname, NULL};
+	struct cmd_tbl cmdtp = {};      /* dummy */
+	char file_addr[17] = {0};
+
+	log_debug("addr=%lx, fname=%s\n", addr, fname);
+	sprintf(file_addr, "%lx", addr);
+	tftp_argv[1] = file_addr;
+
+	int result = do_tftpb(&cmdtp, 0, fname ? 3 : 2, tftp_argv);
+
+	if (result)
+		return log_msg_ret("res", -ENOENT);
+
+	return 0;
+}
+
+#endif

---
base-commit: 69dc9a31831436dd850a4870b3c43e1af66b832a
change-id: 20250911-ip_dyn_bootstd-dbc38bc3694f

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

