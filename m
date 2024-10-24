Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30867D0BB66
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2EA88E63;
	Thu, 24 Oct 2024 09:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="AVIPONLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B4788D97; Thu, 24 Oct 2024 09:04:23 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7873188E63
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrAV6J6EHB+2SSQcXBhx5+eWZdjljo41g1IkIxL+7efU/OgKEoKavv1NdhFEqzq4xsEj57qs2B1NSjr6aeVrfQL3047NzchepOt+gdvnc0fjUNW8LpUxm7YkLpEfGLV9h9jqQRNy5+KzTuIXLu6ynaZa4ajN2/+YLliLDRQiWKhVdUfbXQFEWQYT0rJ7lb9aU0hSnzuGvFIFNbkMWis6yzzdrzHlEWsAFb4Y2Nfa9hhH/nViEAOkGf/MzWHebLmlPDj0dzMQRMS0SnzSlvwXHHodNS5ntfPzK76iPs7zDRiOIaGj4oLkjs0RawW025pxtFcJT5OgTP/hkz+WUJ8pMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hp4nqlNqRLVMY+oCcOSD7Bgxu/kb6L9HkY7dr45pfE=;
 b=eKNYVJoOGz8r+42DpNNdtkMQdHaqxJSZ6gM+UGA5BSWhHIB7mhxXqndcLsMaJZu1Wl5G1M8r+KS3Q1e/tfnEWfhJkXuuOoUu3JW9urGfHMcyB0sP13MYqDhcx5qC/Fx6yzpHZZkfBs5513XUvT5XD2hV7cPq0shQDYe18Cq24f1rdf4HzhurmYj6cJ2jGAT0ouT7LzNrZMUs///JZuVWrG6omJXruFF9e7ogLJjyHxuihXHRGCOWVxt/2gsjf8i7YnbTf2hZ3i8OVHmhzmH6Ay65DCMi7usFiQROb/H06lXUY9zwXoRSWxriN/MRDRcsumMP4Pp6KOPeVm9ZowDkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hp4nqlNqRLVMY+oCcOSD7Bgxu/kb6L9HkY7dr45pfE=;
 b=AVIPONLzsavxPzdofhAYCslyxsr8RCQ0jyAxNMQN31mRw+EMgyCMexHl51e7QQRbxvuR42ONpUfis60/rch8JSvSsc7YrQg7ejsm8FDbb2yM5WGOqS5t0WjW4gLkmfCFQhMdWE3C5aSU69PBeTrjuFPYJB4/kVSg73QdomQ/Dbo=
Received: from AS9PR05CA0336.eurprd05.prod.outlook.com (2603:10a6:20b:490::28)
 by GV1P195MB2657.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1f4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:04:14 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::be) by AS9PR05CA0336.outlook.office365.com
 (2603:10a6:20b:490::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 07:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:04:14 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 24 Oct 2024 09:03:37 +0200
Subject: [PATCH RFC 3/6] arm: dts: imx8mm-phygate-tauri-l: add optee load
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-phytec_imx8m_optee-v1-3-fc6b78bf9a9b@phytec.de>
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
In-Reply-To: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "Simon
 Glass" <sjg@chromium.org>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.62]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|GV1P195MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b84f85-c810-48e3-b473-08dcf3fa1188
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aENjd0FLVnMvWEd0NHhQRitTRHY4VTdSM3lTcXM4QnQxc2RJZGVraUM2bjll?=
 =?utf-8?B?TnhkTzNDMFUwb3ozZnp6ZTE4Z2ZWeE5FTG5mWWFVNnFLL0I0QVRCMHlWSUJI?=
 =?utf-8?B?M1J6djNuNFU4Rit0SUg4SUlLMi8vazNSdVB5STdRa0JxN2Y2T1VhYzAvSVQx?=
 =?utf-8?B?K1ZFc3hDaFozSTNDZ3R4WkxUTTRpWDZpNDlqNk5TYUU4Vm1CREpDcE1KNlpy?=
 =?utf-8?B?VHRvNlRhTWtqbmtweEkxMWU3V0VKOEVVeDFRdzRVdUt4U3MyUStGK1hYS2tW?=
 =?utf-8?B?SjRaQ2JLeGJVYXd1cnZCdHNuUGpOZ2U5dXJCUWlSRzAvbkl5SmZVaHpoV2Zn?=
 =?utf-8?B?ZEhNQ1orUXk4bUQxWi9TMVE3YXJGRGt0S1QvUmFsZUcwVUhtbWplYXJ4cUEw?=
 =?utf-8?B?MDQvVWJSWDZpNTVaNVUxYnBvVVo5Q3pjbS9xTnpJSWdJblNEVXdia1BLWllw?=
 =?utf-8?B?bFQrU0t3RUUya1RpejAyQURGSXFjQWpqVmhiYzJRb3Vjem1QbnRXZCtkNzkv?=
 =?utf-8?B?QWd2OHNKdndYK3VSZ1IwQ004dzJUVnBDK2Irblg3cVFhSmdYQlJOT21PMm1y?=
 =?utf-8?B?VkJJWUxzcm5kempXSGtGL1lqb05oUDE2emdPczZLdVgyOGtYNW9HQUp3YmF2?=
 =?utf-8?B?ZXBNWEZMRk1PckRTSXJYb1JEc1hUcTh2SVpQbXpSK3IyMEEyMWNOZXgwZ1Vm?=
 =?utf-8?B?cndOY1BpNmszSGgxL1VRclVZY3dCMFR4UzI4NDY4MU4zbVpBV2R3a3BsbE1q?=
 =?utf-8?B?RE1uVzRjWDdwWUN2UnZsbDgxUFExYmNQdmpRZnBNKzBhN09nYkkwRnZiOE5G?=
 =?utf-8?B?ZnB6MlZWZlhEeVd4WFRzWURMeHBQRnhkSWwrdDZHNUpnMStmdlJoQ1NoUytO?=
 =?utf-8?B?RVJHYXRkZjJBd3BiS2g2SmR6V29XQ3dIQnpSOTVuamFIVTBRWlVDMHhDYXlz?=
 =?utf-8?B?dUJ6b2xpVVV6Z0hBL2tuSjNmM0xHN3hkZmlqK2tEZ2dhQ2hZVzFtcHlhMUt1?=
 =?utf-8?B?T2lUa1lnTTVzOWxrUExrcldMZmtBYUh2eE9mU3FuMmVVZGY4NFdzTGxENE55?=
 =?utf-8?B?eGVPRitYTWt0WXhIek53L1pUWmUwNVZzcGdISytld1I0Y0tPZk9qM09VdzZ6?=
 =?utf-8?B?UUFvWE1WZWdYZjQveEY5V3g5dEUvNzJXbnp0WXlVdU9ZQ2xyRGRpMW40ekcx?=
 =?utf-8?B?K3lFa2ZBcTNCVlZOSFBXUlVLNktJcmp3UjB1eUVGRnZrM2w3UmQ4OG1aUUo3?=
 =?utf-8?B?MGtXcE4zVGhXU3BYeC9pN3dDYzNMRTZMMUgwWitpZlFrZUhSaitodnpVNUU5?=
 =?utf-8?B?QTYyaklNa2xlNXpFWEZiUDhSVWgyWjA0WG5MNzJTR1JGeFdkQkY2RVI0QjE0?=
 =?utf-8?B?NnFLUkVNQi9HejNQQVh4M0NIWHhzUWI1YzJDK2J4QnhLeUJqV0RNRW9wQjhP?=
 =?utf-8?B?UWJ4ZWQ1UmlveGJLdFl2YUN5T3Ztc1dub09EbTc2cGZGNVU4Z3FoeVUvR0ZK?=
 =?utf-8?B?V2ZNRWVxb3MxUGdOR3owWmdjZTZUREt3anBOL2xGTFhXc1BkVUxhMjFuNW8r?=
 =?utf-8?B?WThEb1dEb1FldysvUDZONUxkK21QTHZEMjUxRDVwTXdzazlSR21SRjg4Ykdx?=
 =?utf-8?B?YW9PcjU3eEhPclZ0SlIvSGFTNWdScnNlaDM1Y25rM24yTi9xU2wvRUdIWGFV?=
 =?utf-8?B?QzdjWTVDTncxdm00cnI2c2NOb2pQREtMRGx6bHJvZ1B6NHNHSDNrakl2Ny9t?=
 =?utf-8?B?c2RwOFVZRDI3UzBLZkw1TzlaS2tFZ3FrdVNKaDZ2VXlvazRRSXUwNWtNM0xZ?=
 =?utf-8?B?UDkrdTVLKytQbmZFd1JaZGhhQnRkcW9kUVRKaUpjcWtNWjZrRmwyVitFSDVs?=
 =?utf-8?B?ZURrUDNrWkJlUTI2QTdZZHEzdGlLdHFYK0RQUDlPSXhZUmc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:14.1000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b84f85-c810-48e3-b473-08dcf3fa1188
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2657
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

The phyGATE-Tauri-L expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
index f59f119374f..a25bec7f498 100644
--- a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
@@ -13,6 +13,11 @@
 	};
 };
 
+&tee {
+	entry = <0x56000000>;
+	load = <0x56000000>;
+};
+
 &pinctrl_uart3 {
 	bootph-pre-ram;
 };

-- 
2.43.0

