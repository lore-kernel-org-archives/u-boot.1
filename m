Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BCCC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 07:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A758980283;
	Wed, 22 Jan 2025 08:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VwNUXPVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747418078B; Wed, 22 Jan 2025 08:42:52 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A20A801FB
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoxJr4qvfqvG5Qv0/BdO9tnkmygS9rDjxLD3U2tHh8xoGhhdxNtfHqpN3j9X0mrNw/W65ZF9kEujqMCmavAxwwbxvBAYGGur7o1H1PTyqmwz84Trp2H8MEJzJwAFjozlmwE2vMNmX3WvUt2POQf7+XFuypGohupU3q1Pol1vCC1s0WT12xK85BPDRoFAJGlpWkiGcPNBA75vOBhu1vmvf+6z9+GudqejdSd+kFruiAlgMzCZzxtXZ6WEo8LU8DO9wYhZJ+gUvo7L2LS1ZSWQuK+2nOKe+hcyiLvv5aNZWOBFIWdJmu+YBtYxRUiOVPh3Dzz9SFXHE3l7HFsHN3tAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHK82KwILP9lkx8EvevmOd8W+HrDdpJ6HV1ejm7ye/E=;
 b=H7UyZrnaREC+cFqsyX0kZ2Yf/fJbYzqSKXtr2TrLEGk99wa+yZJvcOfE6i3MLAv7xBdu6M9jfXNtuCi99sHr+iCsPx2yMBEeENX+1Nt4oKmqKU2kZBndEBPvzCMoscPmheCaD8V+BJErdmTi+hfw8PwD1TK115MbIfXGZPRuVk3AiLrR0x6NcH+mggSyzYSwotOiPVMB0+6JdaZqxgopICCZrTqY7o6gbzDFzmq07UEPNmU5+IkAh9DbTm62+/XUg+71EA2CqW99f+hGi1nQPwChrJW4cQcmxcjk1b3DIUDb1FzjBNqI1XobSinjOXdi5+RLQfpwmUW+9s5y9UclTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHK82KwILP9lkx8EvevmOd8W+HrDdpJ6HV1ejm7ye/E=;
 b=VwNUXPVw+hc3XTD1d7iaTy3pjhKbUoHx28QeU17/qSvHcnlfCN31Vjp3Uk5pjWjNspl3DrpqhEur+psc28F/kXCftOaS2ERYWGYxO+Dp+agplTo/q5IkVHfazZVI5HN4M7cAYRIFDAdWaoc6hpPYvBPuZwb38gyHH7TrAIcW+z2Znky2wjTuRw9RiZWIedgjA0iP9AbYWnC41D/Kyi/ieBzMpjo/uJ6wft0Q1jwPlAlLAahGZS8Wu1rDcYz4Nd885mJrPDGMmNRySGdBItyvv8L6waYtEbf9e+7biSv1/i/SfI1oOsBF7eyShSDwf3BgOylEqQDJIIFf4ESYYLYroA==
Received: from DB6PR0301CA0072.eurprd03.prod.outlook.com (2603:10a6:6:30::19)
 by AS8P195MB1630.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:52f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 07:42:45 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::55) by DB6PR0301CA0072.outlook.office365.com
 (2603:10a6:6:30::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 07:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 07:42:45 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 22 Jan
 2025 08:42:44 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 22 Jan
 2025 08:42:44 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 22 Jan 2025 08:42:02 +0100
Subject: [PATCH] arm: dts: imx8m*-u-boot: remove optional from tee-os entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250122-optee_guard_fixup-v1-1-032bc2de09ba@phytec.de>
X-B4-Tracking: v=1; b=H4sIAEmhkGcC/x2MQQqAIBAAvyJ7TtCNiPpKhEhutRcVzQikvycdh
 2GmQqbElGEWFRLdnDn4BroTsJ3WHyTZNQZUOCiNKEO8iMxRbHJm56dE6XpFo9MTKm2hdTFRE/9
 zWd/3A1L3FOpjAAAA
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Yashwanth Varakala
 <y.varakala@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|AS8P195MB1630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0febd5af-12a5-4de8-b322-08dd3ab85c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnhMQ2Z5MENOOEZQbmw4anJKSHA3K3RvakZXb3V1UUNSa3NFdFBQeEhZSDc3?=
 =?utf-8?B?R2NGZlBrVmdodnBnckFBbHRYdUhEbm9GUGt1cWpBSzdSS1hXRDE5VGp1MWVy?=
 =?utf-8?B?ZkpLSUoyWWQzZXVjKzVmNEdCR1F1dUszNlU0QktMOEN3bHgxdTRuYmV6TXI4?=
 =?utf-8?B?bE0rRVlNWVpFUlZha3FUZVh0ZG4rNEhWUEdaUDFYYjRVMmpaZmxxOWJNTFRn?=
 =?utf-8?B?d3QvcTFtMEhEeGQ5T3JnRDRVeWFSbHpmeHc3Sk5LN1RGbGZxQ3E4SGFZN3hI?=
 =?utf-8?B?SE52TFRWbkNQLzFDSHh1aGhtckVPaitwUHVFc0ExTFpGMjMxb1dENXkwN0tx?=
 =?utf-8?B?S21mM1VIVGRtV2lMczdjWUZtK2hNT2psajQzVklvU3AxQ2dpU0hZL3lyUVQ4?=
 =?utf-8?B?anVWV3ZtWWZxQmZ4SU00SHZvSndmVUNtUnRaUW9pUlpUb2Rnb3h6ODFkbW1M?=
 =?utf-8?B?b1VQdmdyNG5XWEF1MEdqczA3OW9BMHJ6Ykw4QmF5R2htaXlzMG82cUhLYzV4?=
 =?utf-8?B?cmk2QVR0QzJZV1ZMcmFRd25Dem0yOENVemgzOHFJbWxseEp1bkVFdGJxM3NH?=
 =?utf-8?B?QkNhaytDaWQ5eVJLYmVLTS9HelByczBrdERaRkltUEx4aEFQNVczaTRUc3ZI?=
 =?utf-8?B?QVhrMmpBdTlCMkRMYXZrK1k2ZU9rOHlZVTRxbWVDd2RDOHgyMGIydEt6MWty?=
 =?utf-8?B?VlZyUTdjUnk3MHU5Q0hCYThLMk43Yjh0elNPcHMveXE0dy9LV0p5eURzMnVj?=
 =?utf-8?B?eldyZ1pzUmFGdTYwRFZyQTFTTXlPa0RBS0s0S1ZGTTlwMHFyRzZaUzNNUGNS?=
 =?utf-8?B?dTlCT3dUSlNvaVlxNDJLTVJNK0paVXM1YmdxTlVtS2pDUkh1ZWlpWWd6UUdj?=
 =?utf-8?B?VVNnM3NxSEJFR2FBRHUvSGwzNWV6UjNoNndCbmNCbnVsUWVYWDltOXlqTHhk?=
 =?utf-8?B?dXlHNEExSTl5RW9Hd3NpeUo5dUYxQ1dYYUQxTmtLeTA0aE9CQ0R1cS9uOGc4?=
 =?utf-8?B?L2NEM3JyWmY0NTlGM1JFZkxNdVd3TXpMOS9PUG4yMVJ4TFVEa0E3Mjh2Tm1w?=
 =?utf-8?B?RE5PMURtNWE5c3A2ZG9ybXNMV3VmRFpPMkltTFZaVzlWVjBiK0hpMktEQ1gw?=
 =?utf-8?B?ZDQxaE80V0NWc0hEK1ROajBHcGRCdXpFK0dvc1lqcUp6QU1NYjNVb2xSQ29r?=
 =?utf-8?B?ZVc0MlBRTUQ1Z2FSdVZZK2RYNUJOQy91VXZsRitmRHFYZkVpN0RrL0hZWEpY?=
 =?utf-8?B?N2JmMzAyS1BsbG5Xd0x6ZEo2UzJOcmZSMm1wWEF2OFg0N1RYY0psMUE4d0Ji?=
 =?utf-8?B?YXNzRkZvcWpoSE96b2VFWCswaTJDQlp6eDgvZDJKQzVYNkNzSXdyTXVBOE9Q?=
 =?utf-8?B?RUJZWHpUUXBHSFh5UktzTVZLdXZCQ2o3S2dYT2QrMXJlcHdKdFJBMlJVV3dv?=
 =?utf-8?B?Tmd5alJ5TW9xR0dST2dPKzcrS0tMQUpzbDZmSlZFcU1TeHBmcTBBbUhtRjVJ?=
 =?utf-8?B?cXNEQUNqUDVOOGwydDdneTRvcGRLM0M4OUhyMktCRTJLLzRvWW04Z2x0eTNE?=
 =?utf-8?B?eHVEWWVWVUNoYUZ5SStNaVZ2bFo1RzF3MGpiT2lkeFJQdUdWNXhnbGhwMW1o?=
 =?utf-8?B?TkRITG9xYUZ5QmE5SmNhOUtDMGYrRXdzbDdMY2tiZXh1WVc3MXQ5bmk3SXlL?=
 =?utf-8?B?TDFRaEJxQjVYM2dBeVlQODY1TUVpMjNyUW56MnBySnlmQ0J6azY5TWRxT2tk?=
 =?utf-8?B?bWVMeU1uZkZ2NjZCNXN3VmpiU3JzSEpuelA0alBPSlZCZkh0SzhkM0xMM1li?=
 =?utf-8?B?dkZpY0ViZHFPYkM2WHdYeE1MWGlRTnRSNWdnYjc1K1VpUjZza3lpMEdhZDQr?=
 =?utf-8?B?K2dRblR3SXM5WVJuZkZ4K2pZVHBaczdzUFR2dmlrM0lXS1k4Rm1KekVUSy9i?=
 =?utf-8?B?WGhJVnQ1bk5Wei8xOWxkV0g5TnpuaUVIZ05tOUpHVk5GOUk0ZWJPWjZnR2Rt?=
 =?utf-8?Q?49mtlZHBu5M8QPcPvzu6P8dVkEP/uo=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 07:42:45.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0febd5af-12a5-4de8-b322-08dd3ab85c41
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1630
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

tee-os node is guarded by CONFIG_OPTEE. Since OPTEE adds driver support
for OP-TEE, the binary should then be packaged in the bootable image.
Remove the optional property to enforce this requirement.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 1 -
 arch/arm/dts/imx8mn-u-boot.dtsi | 1 -
 arch/arm/dts/imx8mp-u-boot.dtsi | 1 -
 arch/arm/dts/imx8mq-u-boot.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 8608fa004fd..abb3aa5b635 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -176,7 +176,6 @@
 
 						tee-os {
 							filename = "tee.bin";
-							optional;
 						};
 					};
 #endif
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index bf2bb0f17c7..96a6df94c6c 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -252,7 +252,6 @@
 
 						tee-os {
 							filename = "tee.bin";
-							optional;
 						};
 					};
 #endif
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 9e590c3bba0..6de9ab5d37c 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -197,7 +197,6 @@
 
 						tee-os {
 							filename = "tee.bin";
-							optional;
 						};
 					};
 #endif
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 458657fc474..8a536b16e8f 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -156,7 +156,6 @@
 
 						tee-os {
 							filename = "tee.bin";
-							optional;
 						};
 					};
 #endif

---
base-commit: e38a490810af76169f7cf1d298966ea9ba3c005b
change-id: 20250122-optee_guard_fixup-d30e7d19201a

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

