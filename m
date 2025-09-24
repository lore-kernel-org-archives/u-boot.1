Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022C3CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 07:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F14680107;
	Wed, 24 Sep 2025 09:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CrIVlohf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EAA83335; Wed, 24 Sep 2025 09:42:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D4F800D7
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YID0wUULaMi5koWdO05iM20itPCgpuUnTniQ4A4KGgr6aZIanHF2YpTKdOafxOepzqznR2+QoEe4UIf+aTwACJFowr7h7g9KDV8ZS+9Chk4cIhQCRFai5ZS2y1oQWYzpn42/8qfn84d0c1+VPjxAq/xvgEkvsd2CGju0GrLZ3Tx/NKBdSdbAsgcMOVFhk96PZPbbVTQcX2gEKtL0bOKItvYsBN75hlXF9LPrOIuv6GiIquMGGzKvpVkVupkx2rHCLLtp5uppEtpY22ZbrRSbqIwPS3wk7OPHqoqnzxrHmf4ralda8zoZvrZGFUxAgHG26eisWH8xRoEA4tl472Go6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeDluH2JMXS5BUwj915hifHrIblYAqqFpYlQixBc60U=;
 b=xKzc57ajGjZlt92208ZgC/DH+7QFm2IwtqRqEmJFxoN76GGQbtgzOlEJWbZ6YY0hl8o5CbfmMs5Hu0G1i1DCM3HHDc8HQMDz25XBiCEcX6Zoby/CcjQaMxv8YqdqtgV1UHZbHAFQq8qGrckCuNXkhFWs0oUqBlF2SsEO5NMp9Ne0xAZPIWtzyDy+h/SCeTxEgZFTK3+HOtSQbovCpjauBL4e6cTG+6RTashLCPfl0872BjTcS8PpzHfShz8TbGh9fKsbEve+fN0LULfwfy+Qh3f2cTD47kp8aIdnrqJGwRR+WgZwjhbvEl9xpBtfuOtnDvfqlIyghg90SpoUxyKyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeDluH2JMXS5BUwj915hifHrIblYAqqFpYlQixBc60U=;
 b=CrIVlohfoKLw71/uENUhpy/Vk9wdZHfa8srFDeEvqe98qrzZokHtB6ExEezgceVceJSLVyfHmN6OSnosDfU7fElWtKhhJ9cE7JGxfeNK5V5J+gMbvt2X/y8igMpjxUvTzNiugEzCkYYfowL0ewbxZwaOeBnDU49r9KH0Qa8agdr6V2tYUOxn5hEAo/B9T2qNgPzWKZNudhywqM8xqEuQsvVtKAVFW9lsvMJeJeHhjy5SjHOpZY1KmfIdfR6uGqgIXNg4WMnso39U+WoMDQKwP++9KMDEfYdSguOxdMZw5OFjEJPeBZQEJJcBefDkW/3k4uR3KCfeS/785FGYi6TXMQ==
Received: from AS4P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::9)
 by VI1P195MB0574.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:42:01 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::f0) by AS4P250CA0008.outlook.office365.com
 (2603:10a6:20b:5df::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 07:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 07:42:00 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 09:42:00 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 24 Sep 2025 09:41:41 +0200
Subject: [PATCH v3] bootstd: make it possible to use tftp for netboot with
 standardboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
X-B4-Tracking: v=1; b=H4sIALSg02gC/3WMwQqDMBAFf6XsuSkmRhN76n+UIpqsdS9GkhAq4
 r83ehJKD+8wD2ZWCOgJA9wvK3hMFMhNGcrrBczYTW9kZDODKERVNJwzmlu7TG3vXAzRMtubUuf
 VjRwgS7PHgT5H8PnKPFKIzi9HP/H9/ZtKnHGm5KBkVShjuH7M4xLR3CzCnkripIvyRxdZx75qO
 qU11lKd9W3bvs+AZuvrAAAA
X-Change-ID: 20250911-ip_dyn_bootstd-dbc38bc3694f
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758699720; l=4720;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=Eo0ed3iO07+PNpAwhv/YThGq7TCIJKS9uzx6bA7nFz8=;
 b=CDyNH9+eNzG4zDQhVnqKB0RovTnEHeQda8zmjG+Br5r7MqRss9dAiZAXAnJDqPirqSDSN110N
 Z9qeTFqnov6Ba9rfSLCgFdtResM8zvJU4PD0SXRYsgWpdP0UZ6lxsVv
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|VI1P195MB0574:EE_
X-MS-Office365-Filtering-Correlation-Id: af761511-6543-4846-782d-08ddfb3dd8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEpqdVgvbkVDMHVRYU1GSXFqZEc4NXJzT0gzcDg2WmVubW96NmhTVjN2aHdL?=
 =?utf-8?B?REx0Z1VGbCtkWFlZaExJZGdMb0Jwd3NjSDVwMTF0bkxyM1g5MnVvSldGOFky?=
 =?utf-8?B?aEhRYWdpelVlZ2g1ZlJGMVRVTWpEMjluRW81bks0ZmZ1Z014MnoyeTFrcExr?=
 =?utf-8?B?dlVUbkVxQmhmbURzNzdnbG5ta1E5OHk4OFk1TTNralJsTnlsOVRMZkFxQmd3?=
 =?utf-8?B?cDh5YlZWalNsOGdieVZMa0hGN21teHNUemFxd0o3Mm5FZWxySllBaE9NTy9I?=
 =?utf-8?B?Smx2M2cvbzN6cjVPcEltVjEvNGVkNjJZemNpdStQQ2J2dWl2dnR2a2N5dFpO?=
 =?utf-8?B?aXBmWDZVRmx0NldBRHp4VXlLcHVOdkI3WXYwZHpKenA1RDhZU3VkSm45UHdq?=
 =?utf-8?B?Q2ptTjE0djROVi93T2ZjT0FJZWNsWGZ0WW5Zc1JPa0xiMEdLSEhudVluT1c4?=
 =?utf-8?B?K1FzMGhaemhZWVFyNm56b2pmZjVwaDRSekRDNWgxajRuY0JuK3JvTno3ODlR?=
 =?utf-8?B?L1UxWENLa281MG5zbnV3ZmhrcXF5U1VZblFvMFA5UUtWa3VtbE1nM0wyQU5W?=
 =?utf-8?B?Y0FMNzludjFZMTZ5Z0MvV3hpZmsyeUUvTkxPUjFqWmZXT3BQTzZjR0VrQnBF?=
 =?utf-8?B?VDQwcGpZbFNidjR5dWppTkxPckZRMjVMZmkvQXE4TGh6K2o4bWNsT2VkZktx?=
 =?utf-8?B?NVMxTW5ZY0UzcDdGT2dZekZYd1hLWS9vTy9qcUpURjkxZ3ZiYWhMRkJvamd4?=
 =?utf-8?B?am41bEFXdEJLdjI4RWRVQ1FFY3VKTE16SVNPTEcxQWZBV3Vkd1QyS25sRFpr?=
 =?utf-8?B?N1RkZWpHQ243TjdBd0NJRkdTdEo3ZVNqeTBkWXN0U1E4L2RKU1ZhRUxaR1kw?=
 =?utf-8?B?c3VDVHNpQ2pZUUM5dnNQQUUrcGZhWWV5UTJjUmlYZElVcW5Hdy9ZamFvYTNI?=
 =?utf-8?B?VDkraThUK3ZadWtlZEJUTjBBZ3NXdVRTUjJIcnpUYnRMaDNYdVkyQ1BuNjRs?=
 =?utf-8?B?cjlwZlQvdkpCZzEwbnZFZWFabGx2ZzBsa3VqZWVvSWNSNFFYVzRkcldnTzJU?=
 =?utf-8?B?bGhZV2I4ZDE5Mk8vaFRZcmgwSkJhaTFYcXNlOVAwQ3JIQmtDcmJLWWVpdnBa?=
 =?utf-8?B?OHZwWDVYcU85T01sY3c1OWQ2QmdCcWYzTStTSlIxUEhOa01qalpkcnBJbllj?=
 =?utf-8?B?ZHRZakFmcE9ub3pGeEVzQ0h0UXI1WWZBaDU4c2tjNExJY1F0b1lCeVl3U2ow?=
 =?utf-8?B?Kzl3WGppRGY1ODdiREdGUEdKTXZ3ak9HUkNWRmtUSUFHTDloWWY5Y1E2MVBq?=
 =?utf-8?B?OTl2VkpKKzE2ZTRvcGsrbU1Jc3VaUngxeTJaaE5rZVNyQzVPclhxeWQ3UzJB?=
 =?utf-8?B?dlh6OW1pZ2FObWRXRTMzdHdIU3Y5Q2ticm8zUHorUVpBczc0d1k5eVJnZUI3?=
 =?utf-8?B?YTNRSmFaOGF1blFKUEpmQVFDZzQ3aGM4SWx6UlNabEpxUUF6YVQ1SkZsUlgr?=
 =?utf-8?B?bzZoNUR1S3UweTNBNkQ4NVdBVmJyV3ZGMkovMjFiSE1zZ3RXankyMTZSd0h4?=
 =?utf-8?B?YmZKRzRBNkNpMTlyeUJjaEJNZDlSUTFoOHJFZkpzVncrQWZXeG9lQVVuNU0x?=
 =?utf-8?B?TldXWVRUMy9KeGRhRzVPdk1RUS9NUFIyaVJYYUwyUkxKREhIYnkyZkhQTjdv?=
 =?utf-8?B?YkVXVGpRdkc4aDhYQW1raVRPR2NOc2pFVEsvaElsNGdzVUNWTlVyTUxDQzFz?=
 =?utf-8?B?S1NJd1lMN01NY1BpSkFRU3NtV2hYRnFScmFIT3ZzSzNPVGJpMXFneENEbDY5?=
 =?utf-8?B?ZFJiQzB3eXIyRUpZN3FNcTR4RWQwMkZjejBzV1R3ajZrZ1NVTTQ3bUc0dGg5?=
 =?utf-8?B?TEoyQUVtNnI2bHFFcE9wVmlwR0xqbjM3aVZXbzA3ajAvRForMGQyOGxsTnJD?=
 =?utf-8?B?ZEpvalFsSzBBT05TV0tOY2MrM2YyTzRNUmN5TEhHV083Y0JOLzVVWjlmSEdk?=
 =?utf-8?B?MzYyeWlneDlBPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:42:00.7567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af761511-6543-4846-782d-08ddfb3dd8f4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0574
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

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v3:
- code styling update
- Link to v2: https://lore.kernel.org/r/20250923-ip_dyn_bootstd-v2-1-eb59a788e647@phytec.de

Changes in v2:
- fix build error when CONFIG_CMD_TFTPBOOT is not activated
- Link to v1: https://lore.kernel.org/r/20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de
---
 boot/bootmeth_script.c           |  6 +++++-
 cmd/net.c                        | 18 ++++++++++++++++++
 doc/develop/bootstd/overview.rst |  4 ++++
 doc/develop/bootstd/script.rst   |  6 ++++--
 include/net-common.h             |  8 ++++++++
 5 files changed, 39 insertions(+), 3 deletions(-)

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
 
diff --git a/cmd/net.c b/cmd/net.c
index 886735ea14f6..5992b9c5d734 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -49,6 +49,24 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
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
 #if IS_ENABLED(CONFIG_IPV6)
 U_BOOT_CMD(
 	tftpboot,	4,	1,	do_tftpb,
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
index 1112af381a98..a2776fe71fad 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -479,6 +479,14 @@ int net_loop(enum proto_t protocol);
  */
 int dhcp_run(ulong addr, const char *fname, bool autoload);
 
+/**
+ * tftpb_run() - Run TFTP on the current ethernet device
+ *
+ * @addr: Address to load the file into
+ * @fname: Filename of file to load (NULL to use the default filename)
+ * @return 0 if OK, -ENOENT if ant file was not found
+ */
+int tftpb_run(ulong addr, const char *fname);
 
 /**
  * do_ping - Run the ping command

---
base-commit: 1a7882de8c859467ce931ed23761db1e391aeaff
change-id: 20250911-ip_dyn_bootstd-dbc38bc3694f

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

