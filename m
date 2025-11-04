Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD7ECCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1EA808AF;
	Tue,  4 Nov 2025 12:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m1expECG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4FAC836D1; Tue,  4 Nov 2025 12:19:52 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazhn15013037.outbound.protection.outlook.com
 [52.102.140.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A507808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfEyDUd+uxTmUZ4xeaGoRDsJWJLqu3aZ2LxDIYY0gm0/PhsXXkeVIolEzVZ+btGwP12hXAs6bhC8ZngSJC554DX78Fji0izoJDbg08YlFJ0M/0EwZ59Ht+D2UYnDS+MyaDQWEz2w/CohwrvkDG98flFBIlNINqaAZuD+HZkumpCuQfbwf8iPJe9TXpSoTjyXtPeEvfM6A8w58oRi3vwX8xOjJX67sWHWkjJnU45iYaWnLsovz+myae8RsFgBVxjLRRKa/LVIzbsdwCAM7xml5I2W0Rhi05XtWmDJLVq5P4hs1XK3be+H1w/8ub8C96kYLPEaKzvXf3a3NVO0gnwLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2jLdg9O9enMPpVzM9QAiY6WPepFepHevnHw1vmPrsk=;
 b=rzXgMgyuMKGxaLtwYuWSm41g+KG+jw5U21QeqgN4cB6cDmWbPh3TwPAkLLwyQq81c/jggzbphnbPphIIQ13DGvL8OAJ1weaOUdHgt4b3EsVp+bl0scEyjBkp4+qyj5bnNr7lo5KBRaCRawkFhpa+R9OxS4UhjWxxGSlsnD2NyaNZB7VOEljZTNRvqKHdr0yMen/ZK4T9c96gZ9BjMJLfwBWRNJ9zgfsCY1qZE11W9CGPNVeXbymbtM0gPwFyFJiB7mUW8V6HHuuGvUT7/qBqbXyBkdC424CG2aLUcSIAjgPj+2SqgmgAem/D6wTnRcwKnj2H6QQAl3ozWBlzB8RKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2jLdg9O9enMPpVzM9QAiY6WPepFepHevnHw1vmPrsk=;
 b=m1expECG2CCQBaqGB+QbR0Thz6BvYljRAjMLh0iEYkf01FnjscdElIYLtc37hIy3mCzt11OfG1KEsUiWn4rfSdzfPysxnc7m7pY+qB+XxLVBCTztmtZXWYgZlGzstjU4UA4WeiHz3ad9qaN391G+9JKxvi7xHS0foNEI7pyFI9M=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by DM3PPF40B0653BC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 11:19:45 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::9f) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 11:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 11:19:45 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 05:19:44 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 05:19:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 05:19:44 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4BJgUn1821295;
 Tue, 4 Nov 2025 05:19:43 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Tue, 4 Nov 2025 16:49:31 +0530
Subject: [PATCH v4 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-b4-scmi-v1-v4-2-51f101a6f8c3@ti.com>
References: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
In-Reply-To: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Maxim Kochetkov
 <fido_max@inbox.ru>, <d-gole@ti.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762255178; l=3005;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=w6pDJ2fgCJZ0+qyNiLFLb6komlvGYfboNq6xskhLHbU=;
 b=ewth+F5J8DdcUlMo1QBkTZJO9FozgNylUXp82bQhbVMiRoWbhKttxJSgLSWd2sFdI5NzIAFAW
 au8PmXJ5eIKDD/9e/LBXVvYZok9ko+WD15Mm2LYU7ZWQHlIR6UCciui
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM3PPF40B0653BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 39126910-f59d-4d7e-8784-08de1b940ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1pKeHRxUlJKMU5VQ3ZOSGpTRHlHMDUrWm9XTUlYYloxc2FEZU0xOUdKRVpT?=
 =?utf-8?B?eWFMcTdHYUtuS2g2NGhNM2psU0tYZ3hkTmczNS9Sd3lyNHFvYVVzdUN6VzNK?=
 =?utf-8?B?cFFJNFNaYmJHQkRQWm82c0c3Q1U4aWZndmxSOFgxQUJKUXM0b25Hd2tieWJX?=
 =?utf-8?B?M1JPbWRydzZkWGQ4SHJRajV5L01ubXBscmVvRGNXY1VZR1dZd0VaNk9sL1Fn?=
 =?utf-8?B?UHlyUWUrSjJGZUJ2NTdQRzZlaVVOOHNWR21FVlhHQmQ3MEJEaENMN2ljL2l4?=
 =?utf-8?B?ekRNN0xqL091ZGVTU2NsSHRoMTZpV29oY0N0ZzdqUXBDejkxYzV3UE1qUkFS?=
 =?utf-8?B?K3NmeUxHTVJ3NEZzekFOL0xHbjdzd2ROWmdRZC8zMjA5RVR2ZXBFMXRlNmpj?=
 =?utf-8?B?K0hrR1k1OEhUdEZsOUxaY1JSS2o3RnBQUmUwTHdqSXpPWmQrNXRCanJzdDhu?=
 =?utf-8?B?TDdMOXZGUWp3UFFXYlNmRG9sQ3NGV0tMcHhqdWQrNFdBV1BnTFNaT2NrYjl5?=
 =?utf-8?B?V1U1dll2akpHVnpQR3Zvb2VZdjVsZnloZTVyZVFxKzZuZUp0UHRBamYzc2tr?=
 =?utf-8?B?OUEwbHZ1NnhraFNFcC82bVMxZXI2aW5XNC9Yc2puUk1ielg4MEJzSVRIN2k5?=
 =?utf-8?B?ZzJXVFdvZXl5L1d4WHNsazZWUmlzQkhZdE43c3ZqclI2MUJ2K0NQOHN6aFlG?=
 =?utf-8?B?RG1jcStKaFhHOUdvUEJsL1ltLzY1TTRVTXgwQVBrN1Y3ZzBoemMxQnZiMmtj?=
 =?utf-8?B?SERQQ2NzdEs5c0RWNlZvVjkvb0Z2VnBwdDFxMjdSZXZCbGpPOE5rUTVMdTky?=
 =?utf-8?B?NHRwWkgwUFNIYStCQ3Nvd1NTMzNwQ0F5K0Y0QWNEdmtMK2Rxbjk1dCs0ZVNR?=
 =?utf-8?B?YzVsZ3hXbkJXRGhJT3REZTZKbjdUaUUyL3lMcC9kaC9BMHNNc2lQc1JDU2Q0?=
 =?utf-8?B?dXFxSHJuNnNTVzBOaVRROW16M0FPbHZvOUtqRkhUa0J2VXJVb0dNdDZEeWwv?=
 =?utf-8?B?QlNKNENUQ3hzdHFOWWpma3JBeTNkbnNpeUZkQVRabVpxbnBsNGFrTmdSdHc0?=
 =?utf-8?B?RTN5bzFUWjZkZ2p4NEh4Z0Y3Q0UxVWNVQmNucXVnUXZNMWtQVmZRYitYa0x5?=
 =?utf-8?B?K0VLcHU0SUFJMk1HRzBmdFhmR0hDaFZHSG5OU3NFMzV3RGRlVmdpS3pRWUJw?=
 =?utf-8?B?WEkxcUxpbGl4LzVMWUVVRGdDTGVJTDNpNXVNT3ZBWVRhQ0lOV2V1bUFZZXE5?=
 =?utf-8?B?V1paS0ZnNEhIYnFwWjg1YmlvTlJINHEzM1VEUnNGTllCQVVjaXE4T0RWWjZ0?=
 =?utf-8?B?OS83eU1rdGxLK3VyZVlicUJWZjJvNDhZbnhUV2Vncys1Tmc2M2VQZUk1c0g1?=
 =?utf-8?B?VFh2eXVkdnNBUzdMRk9LYVpiRzJGSU5QR0hOV1pJdTJmN2YxWG1rNmN6MldV?=
 =?utf-8?B?ck1Pc2lKYmxZWklwRUt4b29EMHRtZklrZmtpR0h0eTFOZ1VOZWVacnovVVNp?=
 =?utf-8?B?S2RrTlZsY3Z0NStDQ0RMcDUwK05iK0J5cVc2Y3lZaUpNVW5PY08rK3VwSWo3?=
 =?utf-8?B?dFdQY053NEVQRENDWW1MOUNwYUtTWDhrTkhnNDN3L2FBcGhvcVVrZkw5ODQz?=
 =?utf-8?B?UDdZejl0TjY5eEtTRGRHWUhqcExFNThpM0lVQzZBRmM1MWpreCtZRzhzNkNI?=
 =?utf-8?B?QnVVYVpvNlZmSkxGK0NQY2J3K05IUnVBelA2bFo5UzRBVzZaeWJwU1UzdGdm?=
 =?utf-8?B?QnFWOVZtUjNzR2d6T0dTMFF6YjYxNzRydm1na21DRmExOFlOdklYTmxNVFVa?=
 =?utf-8?B?eXozcC9Lc1QvUURaOGQ3VlRkTVVXdFFheDUzMUZ6dEVzWktZVys1VTQ5Rlhs?=
 =?utf-8?B?Tk11ZHdERGF3SUswczlCWFFETUJDci9TMHpuTnZqQzlHWExDZ3hYYXdmL2wr?=
 =?utf-8?B?MGdoUHlRcGVkQ0w4RWl1anorRjhmZGR1TVNvLzNJdWxwVEJObmcxUC9ReFNE?=
 =?utf-8?B?b25YRE1IWWgyNmZ4Y2RPbjk3ZFA3YTNHNHVkZi9TQVNPMjVHbTNsU1M4R1or?=
 =?utf-8?B?TXRqVE9MTkRmeXNZb3VPaENxVkVtZWFDT0pEYmtkZ0lmTGJGcCtTSEs3eS9Z?=
 =?utf-8?Q?Pl08=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:19:45.0858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39126910-f59d-4d7e-8784-08de1b940ee4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF40B0653BC
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

Clock version 3.0 specified in ARM SCMI Platform design document
v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET and
CLOCK_CONFIG_GET. Add support for that.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 drivers/clk/clk_scmi.c   | 52 +++++++++++++++++++++++++++++++++++++++-------------
 include/scmi_protocols.h |  6 ++++++
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 83ea7bb4286..6d47cc6cd01 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -131,19 +131,45 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clk_state_in in = {
-		.clock_id = clk_get_id(clk),
-		.attributes = enable,
-	};
+	struct scmi_clock_priv *priv;
 	struct scmi_clk_state_out out;
-	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
-					  SCMI_CLOCK_CONFIG_SET,
-					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, &msg);
-	if (ret)
-		return ret;
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		/* CCF: version info is in parent device */
+		priv = dev_get_priv(clk->dev->parent);
+	} else {
+		/* Non-CCF: version info is in current device */
+		priv = dev_get_priv(clk->dev);
+	}
+
+	if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
+		struct scmi_clk_state_in_v2 in = {
+			.clock_id = clk->id,
+			.attributes = enable,
+			.extended_config_val = 0,
+		};
+		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+						  SCMI_CLOCK_CONFIG_SET,
+						  in, out);
+
+		ret = devm_scmi_process_msg(clk->dev, &msg);
+		if (ret)
+			return ret;
+
+	} else {
+		struct scmi_clk_state_in in = {
+			.clock_id = clk->id,
+			.attributes = enable,
+		};
+		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+						  SCMI_CLOCK_CONFIG_SET,
+						  in, out);
+
+		ret = devm_scmi_process_msg(clk->dev, &msg);
+		if (ret)
+			return ret;
+	}
 
 	return scmi_to_linux_errno(out.status);
 }
@@ -275,12 +301,12 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (!CONFIG_IS_ENABLED(CLK_CCF))
-		return 0;
-
 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
 					    &priv->version);
 
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return 0;
+
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 762a1032c37..a4d1a4c80c8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -807,6 +807,12 @@ struct scmi_clk_state_in {
 	u32 attributes;
 };
 
+struct scmi_clk_state_in_v2 {
+	u32 clock_id;
+	u32 attributes;
+	u32 extended_config_val;
+};
+
 /**
  * struct scmi_clk_state_out - Response payload for CLOCK_CONFIG_SET command
  * @status:	SCMI command status

-- 
2.34.1

