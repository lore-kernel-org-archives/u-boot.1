Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C77CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 10:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E05833AD;
	Thu, 11 Sep 2025 12:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jVMb5jeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CB4833BF; Thu, 11 Sep 2025 12:34:36 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E6883327
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rex5/MsNgx1eQvZsgvPmrYv7oVf935pj7SOOHAJun9oezSV6NTK4NIp9yVY999HR74TQH4wZ0Q0HjJu98jAU+8riA6IjtWi8Aldg685qTU2TCZICdAH/lfX2msI/Xq7ncWObC6Yhh4WWoX0DroJsiUbZIgjuZrUtvLp+2VRX9VSLzaiA6JQn4hsVEDPyk09S9QKBIfymlM842zd95Is13IBLRNtyynPEvsE6EwlQJ20M8ECAVy0ueqWK34ZQw//noKXLNiWec27MI27ITpw7GYfvvpwLvohOwWKC3fExkLC64QX9IY+i5Dw6luTReBWfTVVUMKioOI+H6FFz7jEarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsEgzcS9PyjmbsKi4IQ9n+nVvvnUUQrUY1BpJdmm4xs=;
 b=pldHExyJjekUn35PApBSLn9pZRh5jPVPf8lnARHlCcPqEeOlEU9Y0t0ZDtZfhYPp2o2V74J8UexKK8zQ8kngeYRGqma0qY2okwMuFp5fhrp6NdDLCWPG1eIVwLxnNX1Q7TYgYhto8/itg4U94HQlSMsLr1RXAAbkPow5RElu0bqHoLO2GwxwF1bBXHEDD3dVwusqLetE8xirsF79gHtcOih3YqQdgDFwxwvEANie30nsoiCiMWSWkoIwvW+qarLLtG1tDRq4A0br82JhccIpbT9050rs5sGV9L8+n98Rh33DyIN7jgXXVY3Lr4kNjCfsXAZYMBl6M4qr18ZDLg9rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsEgzcS9PyjmbsKi4IQ9n+nVvvnUUQrUY1BpJdmm4xs=;
 b=jVMb5jeEGLDseMm5YWbGjj/o9xpi7wARewgnGRypcDEUB2oZjICoA5PVFOhcbTPEn0x/m9MJ8NTmrBArPJeIP6IkYFYJuECihcl8tjQ0IwS8Chehc/qIO6gBTv4CtzP4MfakiCMZ9ch9Wm5oCpzppQUY/vBWACIGZ0Yfe4z5WspQDojUkg+z3VDNvVXMd2wNdhV7zQHiW4nYlW/axO6wk+tahYTlq9yWW9sXPvCAh+s9HyvfOiv85WRXZq672VPx0FaiOU3zKY1C4O1/HWZClAq8PpB/jXxyUn7hFwumv/4EAY1oqpzWTDW1n7MfRPIL+apl/itncXOURdsG5iieiA==
Received: from DU2PR04CA0322.eurprd04.prod.outlook.com (2603:10a6:10:2b5::27)
 by GV2PPF4E9D6E92A.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::8cd)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:34:29 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::82) by DU2PR04CA0322.outlook.office365.com
 (2603:10a6:10:2b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Thu,
 11 Sep 2025 10:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 10:34:28 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 11 Sep
 2025 12:34:27 +0200
Received: from [192.168.3.10] (172.25.39.126) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 11 Sep
 2025 12:34:27 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Thu, 11 Sep 2025 12:34:07 +0200
Subject: [PATCH] bootstd: make it possible to use tftp for netboot with
 standardboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de>
X-B4-Tracking: v=1; b=H4sIAJ6lwmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0ND3cyC+JTKvPik/PyS4pIU3ZSkZGMLIDazNElTAmoqKEpNy6wAGxg
 dW1sLABB+k7hgAAAA
X-Change-ID: 20250911-ip_dyn_bootstd-dbc38bc3694f
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757586867; l=4376;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=kwCm6uRubAANTFH4AWgz+8xqusNn3IffzgH7VKnsXgk=;
 b=v+RV7g711VFCSYAveWyfvSvt/rJ7DXU7TCRSYUqg8ttHZXZ6X9B4EZfpppxJFXeoF3k4a25WK
 0oWZ0P8x588AcIW5I5Q2a088xW99TwVJcN+C1PFym+wbmZWW0JW47NL
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|GV2PPF4E9D6E92A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6844d4b9-91d8-43cf-d0d8-08ddf11ec957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGs2dWFHQStmS3lwZTNJQjlwZVFoQVVldXdQZmQ2TGp2ZkRPTlhzbkFMMFNm?=
 =?utf-8?B?eTJqRU1YazBPMGtSL2JYM3d6T3E0bGp4MHVQT3A4Y05OcXF3bElaRXA3Z2t2?=
 =?utf-8?B?QW93dzZQT3UydkprRW8vMVh6V2doV2NHNnp4RkNCMUhyZm1IdzVyZUVQekVZ?=
 =?utf-8?B?aUdYS2ttWjFBTnF3Q2NiWmVLYUU1Z0dEZGZKcUtSU3pDS1V1aFdFcUovQmM5?=
 =?utf-8?B?RkxzNUVZUDNoK3FkSDNaTWJ3Sml4Qi9YVVArOGZxdXl2d2pQUjY2ZmlJaUtC?=
 =?utf-8?B?ZEpDaDZlYVNna1puL0ZpemhxV2w3ZXRRTzRYZk5rZTZjR3drVkdGU0E0V1gx?=
 =?utf-8?B?KytDUW5TOUUxRXBIbWladVU1N1ZEWDEvN0YxWjhJVXlnb1l5S3ZocVV1WWdz?=
 =?utf-8?B?Q2NIQk9OR09aNW9KR1NwNld0czNIK1FGaEdZc3Y2MlFQNzUxVVQyNmJnMEdB?=
 =?utf-8?B?YkJwMVJtWEcyOWNpTXlhemQzajFoWXpZNlVGUW0wcWd4aCtpVGdzRGttUmhw?=
 =?utf-8?B?RjQ3Z2J4NjFyRkF2bk02bndqemt4SXdBRXJBZ3JUM3VjT0gyNy9LaHg5eXEw?=
 =?utf-8?B?aGJIQm9EVjRQTDhmOWNVdzRVVFdFOVhEdzJIVVdkeTdsZVgvSWlMdlBhcUFC?=
 =?utf-8?B?NHlJT3hOSUhBWkM0OGxUNy9OMnUwTTl1VjZsS2FpYmpxWi9VekJrbjNvZ1NC?=
 =?utf-8?B?SXlKR3NPY29zaG9BVzRVVFY3c0dIQXhrYjlscHgzcTJhY21OWGpKNTVhcS92?=
 =?utf-8?B?R09tc0VRbTF2VWtrb3ppbElzbWNRc3I1ZG5WNExZZzlndFJJSjBmK2I4Vnhv?=
 =?utf-8?B?dVZpMFAwR2tBT014NUdWZHlnNkxoa00yV2hiM0VURURMZWdwRkpyWjQxOS9P?=
 =?utf-8?B?emlOYnE4WnVzUU5VUzhrcGpINkFDREN4bU1iNDUyOTJpRHZVSDJyb2lmbllH?=
 =?utf-8?B?aE92SlUxVGRnbXZCOXhnYytFWlZoSURJSXI2NWcwQ2VIbGROb1Fya3F0a1di?=
 =?utf-8?B?dWVrS0RQSG1UcGFDV3hvMCtjeE40R09vcEp1VlI0bzZqN1dzQ1pqL2Z3WnhB?=
 =?utf-8?B?UUxrcWtlME0rbFdiMTVDRWJEaThGdnZkd0pDTFRyWEY2aHVtYTlHYkhDOUVW?=
 =?utf-8?B?SC9WZXpBOGNteTEvVEtyTDducklqSU16VVMrb1BXTGlNaG02Vm8xL3hRSFpP?=
 =?utf-8?B?WTJEb295dkdCRkJhZmlPYVZUM2F5RjZhOGYrVERCN3lreUZpTGo3Ky92Ujd5?=
 =?utf-8?B?Sk1BVUFOWjJBWFhiQzVRNzZ2bHlCNzNFK1pSazFJc1p4aThRL1VISkt2Zk56?=
 =?utf-8?B?UXRORGlFK0hBMlZNVnVxMlNkMFBWUTJBQUdERHljeThBQWN1NDRuUllNTlRF?=
 =?utf-8?B?VGllbllZTmFHYldwU0FXb0RadCtDU0pkOVB5ZkpFdkJzZUNqUGtjbVdqekNn?=
 =?utf-8?B?NW1xR002a0RaN1lwdE5DVUlVdU04VDVFYWkyN1ZxcFgxWDlsYS8ydTR6c1V2?=
 =?utf-8?B?Yzc1ZDVlQVJueXU5TzVjVVBieDFkTEpGd05iQk5MakNXaFNoRHpPeEN4c0g4?=
 =?utf-8?B?NUxhNkt0SnJwUWRjb2FTd2NjcUNCNGEyYUdISk11OXkzQW9VM3RQOTlBb3gv?=
 =?utf-8?B?SnoxalBkSlNUQ05LSEd5b0p5cExhTkVlSkVqVUdBOXM2cmVVK0VGaXMxMWNs?=
 =?utf-8?B?V2huNEFJdHlrZDE3ZVFrTFFaemZ4MWlod3hML3drVS9xMGd4ZTI5YVNpbHd2?=
 =?utf-8?B?OUNVaFlCNEhmcmhZeGIvOFhYVHdJQmNjeGE5ZE54ZUhHamxNRG4ySXduNkRL?=
 =?utf-8?B?eUxQNEZaR0ZhelV0c1JuNCtkeTVGd0VmUTFlU3V1Y1VXK05XWXArcVpLNHd0?=
 =?utf-8?B?STkvbUZlWFNHUVdFb0R6b1liaU9nc29kQVZJNCtCeE1YMU9CL2I0SHJDbFVP?=
 =?utf-8?B?TitkVDJ6UTRWb3gwaDJtVGVxVFUvZy9qak5NZzhBbUNtYWcrWkdkQUx1UjVR?=
 =?utf-8?B?VmFNNWI4M3I0NlpBRHE3RFNDN1BCRDVXVTZjamlINU5pUVIyeXNUTzJyUHBU?=
 =?utf-8?Q?d+MChZ?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:34:28.5055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6844d4b9-91d8-43cf-d0d8-08ddf11ec957
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF4E9D6E92A
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
 boot/bootmeth_script.c           |  6 +++++-
 cmd/net.c                        | 18 ++++++++++++++++++
 doc/develop/bootstd/overview.rst |  4 ++++
 doc/develop/bootstd/script.rst   |  6 ++++--
 include/net-common.h             |  8 ++++++++
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 020cb8a7aec0..09aa062fe485 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -129,7 +129,11 @@ static int script_read_bootflow_net(struct bootflow *bflow)
 	if (!fname)
 		return log_msg_ret("dhc", -EINVAL);
 
-	ret = dhcp_run(addr, fname, true);
+	if (env_get_yesno("ip_dyn") == 0)
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

