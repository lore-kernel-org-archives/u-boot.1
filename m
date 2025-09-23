Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977D8CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1821580C93;
	Tue, 23 Sep 2025 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WLL3hvQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600DE833E9; Tue, 23 Sep 2025 15:43:23 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD7880050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnbDAzUK9WYQ4Xok0WPsa6AxUOXG85LBkwldGd2NC/PorjbnBggUkgSlZj/c14Suq5uSQ9dUDDtTEP4PMbgISbeHGTYE5w7LVGXQvgc4/zmJVo5X4ER03sCaFHeu8xxXFvQkZNqpOSxFbx3QiMalzhB+WjgcoVVxx8elcFPHXQ4hL22ZlXFLKnc6UMQ6bbByO0F/2XumuSuuSw1GarWz/etxm1tH48jbnSPunVIdPgAoEB3W4KVXfV9e2q9YcsGWvZw+iRlWorHhMyH+56hdv3TYyazJn3QiNaAVqyY7H/SQbf92ZbG5natIKkfFxjwXWOi9YWWV/t2V1NeaCZxrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o1Mt6Dd4vgEFCReuBTXnBtA9vb+nm7e7jSMD2Zj0Ds=;
 b=YNSOG6W66hQuWcPKLNUJdV2PZGJipwyFyPyHo+38LfHRVZ3vDOTj2CtkVglNoNZBYpOp2SJw7gIJ2UextieuZeACX4gKeFd3W83n+1/FYEjFOyYu0RuiTBOs4VfOpvJ08vXp18hk7JA9EyOLYHFpxwDc8Gm8RLGLdp+xJ1O/PsXzeYjCS8IVdJHf3z+rCzr9N+rjo3gPwCs9NmLtZAwxzFJFbzUvcRLL4e1vk88LyGbdyIjzqKxJna1sM1vw4c7KSoYMZ4kUJd2JP9ECnauqeM45EZU2B8JQMRkG8au2mHReSFDHyN+QjOlTFdymcCHB1REYrmbuBS5OvjI2tTW/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o1Mt6Dd4vgEFCReuBTXnBtA9vb+nm7e7jSMD2Zj0Ds=;
 b=WLL3hvQqj1c2HItNnRJHn0B88MrYlYW4WvnQA1ReNy578TNGaZcHDtbONR7lBU1ZF3D0mEqoWfegYnIaDXEeVXXUHbTL3posaALpkSBhYOQjM4rS8riPZdNKIEcG4UbpQ2LVmuOOsZ2RiKgFZrMbdlLQ3hHmumZFpiPMrXH1PPddgFhaxsmpHyg3ZzbklBGZNPy8IXHpXkrrmAbcfBxPune0O7I4OzjIvAjh1qXWo0/U4PvELaSdHRIgZqmu8BhChw9iHZ/G1njPhy2NCa81r0sGkqMHlNsz6QSalFs8LP5fiBud7dJ+2Yu4tZX4qae8LEpcNYLTB880XGMKrzMf1Q==
Received: from DU7P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::29)
 by DU0P195MB1841.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:43:16 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::8e) by DU7P195CA0006.outlook.office365.com
 (2603:10a6:10:54d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 13:43:16 +0000
Received: from [172.25.51.48] (172.25.32.133) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 15:43:15 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 23 Sep 2025 15:43:09 +0200
Subject: [PATCH v2] bootstd: make it possible to use tftp for netboot with
 standardboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250923-ip_dyn_bootstd-v2-1-eb59a788e647@phytec.de>
X-B4-Tracking: v=1; b=H4sIAOyj0mgC/3WMwQ6DIBAFf8XsuTRAsain/kdjTIWl7kUIEFJj/
 PdS7z28w7xkZoeEkTDB0OwQsVAiv1aQlwbM8lrfyMhWBslly3shGIXJbus0e59TtszO5tbV3Xv
 loEohoqPPGXyOlRdK2cft7Bfxe/+mimCCaeW0ark2RnSPsGwZzdUijMdxfAFVXN1mrAAAAA==
X-Change-ID: 20250911-ip_dyn_bootstd-dbc38bc3694f
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758634995; l=4625;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=Lncw2iSkEpGV9Tq7KRIDaDCM/vVYemRG9XhpZbPM6B0=;
 b=Twj+rF4De/X03cyLm84gS72h5z+sRzr7+z7NredzshLreMnU31LKoIPiqqPDYwFTjWrC0oWRb
 TRp/BT/uvXHAsYsjQ6fcWRx+U9HtlxM2LfVa4eGaxR6fkrtgn4ANOvb
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.32.133]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|DU0P195MB1841:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bd9e73-b05b-477c-faeb-08ddfaa72616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGU3Vm9Jd21MMGdiUUVRdHZmNHJ5SXNJTWpxOFdNNUJjazRUZ2h6dkZVZHRK?=
 =?utf-8?B?VDMwd25XUDNObVFWMzEvL0MvM0tPRkIxWDE3YnFTRHVUaFp0QlNzeGIvTFJl?=
 =?utf-8?B?cm9Hd2E1NHpzU2NLLy93N3VmS3U0VmZDSFQ1UUZRQWVjSWVtVWlWdTdQQkZx?=
 =?utf-8?B?Tm1lOUpZMElDMlhMTnFVT2VqNCtvQSt0RFFBeDZVaFJJMU1nQ0UxSG1hSnU4?=
 =?utf-8?B?OTRFTTI2OGRJeElZVytjVHdYQTE4R00zRjltN2lwVzUyREJ0OFZ2MDlMZ1hS?=
 =?utf-8?B?RVJLVm9kOTRZNGJxejRpQzVaQ3Nsd3JJWStJbnJ6T09vcEprejVnMXZWYi8z?=
 =?utf-8?B?Q2VqYkxWaFRvQ05FcXhJRk5WajJhT3lpZSsyRmw0MDVZRTYxMWJ5TWhkd0Ni?=
 =?utf-8?B?SE4va1J3SjRVbmVzTUpwYmRMRmtlS3ZSNGpobm84ejMvdmpmZFNBUDNBRXJh?=
 =?utf-8?B?bTQvTTczbzZiSWRWSmRmcU81ZkFrL3o1UXZBQ014by81TXAvR2dzR3RsZGpD?=
 =?utf-8?B?MnBsUFBINWI1ZlNCVitubytHMjBhUGNqYk5PUXNyVldvQnZjYlZBNi9MU2xs?=
 =?utf-8?B?ZzFQdmh0b3pPdnFhV2YrWFpkSGNFUDRhR0RsenNKdE5LNWF5dE4wUGEvcVd5?=
 =?utf-8?B?TjBHMmZDajlSTXZaNHJYajNEUEtjci92SGcvdU5JeEg0b1E0Nk15YTRyVVlX?=
 =?utf-8?B?ZnpMbnQ0SUtjcG1tdjZZTzdVOVliSzJ5NythNXdwY3Vsd05MOUF2c3ZLYzhz?=
 =?utf-8?B?c2RUNnJuNU9yN1hYTlduUnY5S2I1dzVMVVQ1SWd6SlBiMEowUnRGRml4WWZ1?=
 =?utf-8?B?ZkJ5d3JKTHFXeC9ORHVGOHJ1NTdKRzRtdjIzbkpkbUJOcG5HTHNia0tKeTEr?=
 =?utf-8?B?QS95TDZCWmZCZFF1WXJGalYzUWlXOWRkaUFZN0FMVDByNUc1TGFrU0FmUElC?=
 =?utf-8?B?RGR5aytUVDlydlI4RFVZN3c5aVVETGxTdHBtYWpWOXhhcER0L1pKc3Y1TUlz?=
 =?utf-8?B?Z2VYWm8wRitleEVWbm1KR25VTWJxOVBGZnViNVVaa2NQNzhtVW1BcFQrdGlv?=
 =?utf-8?B?aXkyYmJqVGtkTmFQTUF6UG9YWldmc3RQRENZZWZpT0gzcXlRdThFa1dxR2ZD?=
 =?utf-8?B?UlN1SGpvQVZuSURhSVp5RjUxOHYwZ2VZQ3phWElIOXVtK2h5aTQrVG1TQzAx?=
 =?utf-8?B?VVY1dThFL3ZTSUZyUkYraFUxUmNNUmJld2F6ejR1RlpxdUd0UXZYcmY3bjBR?=
 =?utf-8?B?NmJBTTBsUGpHZi80T09tR3JuWXY3YmZjdXB2TTE3MDhDcmxyL05WcTZydDA4?=
 =?utf-8?B?ZTBDcHJiS0hHYUI5aTJxQzJnMXQxUExnUUF0aTcxSmcvdVB6bFZtK3lOMmxR?=
 =?utf-8?B?clh0R1BuaEhzSlZKYzlxNGpWcXprOGJFTGpncG90dGJGWmRKMzdVZk1CY0pi?=
 =?utf-8?B?MFlZQ3dCSjI4dG5zRnZyZHVGejlwTGFnWkRQNXhaSUpybnd2cGQ1UmQ1THoz?=
 =?utf-8?B?Z1pDMEk5eE5xSXJydGMxZ0RuQkdlc3NPWW5FS1FjSDVJTTZ3MHFBcHJuODZE?=
 =?utf-8?B?dzNBUDcyVTZQWW5IUUJrdGtsQXFRVXdKbm9QMDlOM0ZSc0hISmhDWERQeWxp?=
 =?utf-8?B?MzQzeFRKT1JmTW1WVEI4cjlOeUZBYzdCdk93VllmZXdxVm5RWjFCOElsM1o3?=
 =?utf-8?B?OEFVTG53NFFJc1FoZ29jVkFJMkJIeGg2anlWMnhHUnppSEkwN0FIZ2ZHWDV1?=
 =?utf-8?B?b0lKeEQ3K1J5Z0pTdnBRc3dWYldYaFlxUHlDRUtZcWVxQ0xiMmpzSk5jY2M2?=
 =?utf-8?B?NjlYc0JrM2FFRXZQTEphT0JOVy9nVS83S2tUZlIvRTJwcjlPM0NvRk14eGhl?=
 =?utf-8?B?MUFmV2RPOVVtMWFwOXNJQmZKRUdwb1oxRDlPY0JOUjdOQWMvNjhtUWhNZTJR?=
 =?utf-8?B?ME9BVE9NaklvL3FtWWNMeWdYVFhsZ3VPVUlYQm9tVVNINzI3Z3dNOEVYOFR4?=
 =?utf-8?B?T3pEdzZ1Nmg0WlBTK1BZU0ZmdVM1YlJ2RjZxQ3VrRktBTXY3T3JCYlpMdENj?=
 =?utf-8?B?ZVFqQ25FcHVvdGd4dWVSOEw2dHg0M05LVCtqZz09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:43:16.1282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd9e73-b05b-477c-faeb-08ddfaa72616
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1841
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
Changes in v2:
- fix build error when CONFIG_CMD_TFTPBOOT is not activated
- Link to v1: https://lore.kernel.org/r/20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de
---
 boot/bootmeth_script.c           |  8 ++++++++
 cmd/net.c                        | 18 ++++++++++++++++++
 doc/develop/bootstd/overview.rst |  4 ++++
 doc/develop/bootstd/script.rst   |  6 ++++--
 include/net-common.h             |  8 ++++++++
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 020cb8a7aec0..fd15b1ac1a20 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -129,7 +129,15 @@ static int script_read_bootflow_net(struct bootflow *bflow)
 	if (!fname)
 		return log_msg_ret("dhc", -EINVAL);
 
+#ifdef CONFIG_CMD_TFTPBOOT
+	if (env_get_yesno("ip_dyn") == 0)
+		ret = tftpb_run(addr, fname);
+	else
+		ret = dhcp_run(addr, fname, true);
+#else
 	ret = dhcp_run(addr, fname, true);
+#endif /* CONFIG_CMD_TFTPBOOT */
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

