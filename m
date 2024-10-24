Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6250CD0BB69
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A746A89347;
	Thu, 24 Oct 2024 09:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="ff2+ILzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7998E88E0F; Thu, 24 Oct 2024 09:04:25 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1560F89327
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW66qXvgOUw5/LsTOrEVzNqaj0f/EDYA3bsgO88RZlfx+2DPC9UnMo8fZfxZu3QziSEIadH3J6VSknpPv431hKe+hZ8zFhHdmVO5CmATLQBU+RP5wLajv0y2nHlN4KHmAO0AlC8FIA0KbJAMUhKsbuv8qSp/KR3zX99DpD7mXfCx0vCi3xrQjTF0XC/G5afdLiMw7pmCnVLmsHEHeuHAFMMEnqgk5t8SX//teVDDM0NMf6UaCi+ByD6VpReVskKVVRQy9WMbwL3XbgaUUj9zyO+Q4QHoCthQvNXLy1BqzL91ppPw6FyNAVzFRm8hW29l5FszzJygjWTE9PFANeLtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txHpmKivzLyYupLo6vXH83j5WUS4VuvuvgeLoZX/KHA=;
 b=Va9kSa//gX9XYYOc6ATQVJxK8aAfKmnfq91C+oKyXVNWn1v/6L3U0s7f8csftvvaZEM9vkoktSWgPqdeAipIdDPsLCJC5TKbhKQ2a0WA2hqZWzFAbmMbvhiDRak4wiF55kl8laPx23pJjS3fSNg5R4YbtwY4eizeqYPIM1syV/BSk3yYKCrcWvo2WpFSu6Hx3D0Rc5birVAo4mB45GP/4LlABAAuAi6azksJmCLxQoAJppxudwtFqPbZ1P01vF+E2OVcaD+CTh3BfDf7zOrX7m8lYbCvnaGg2VfKQBUsxDBsnjuHy3fbXnHFZB/uY6VdHfhJpQZ0lWdxVAdTY4EMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txHpmKivzLyYupLo6vXH83j5WUS4VuvuvgeLoZX/KHA=;
 b=ff2+ILzyObh4+cb0zFqCibDA0CnPvEAwLjKVO8iZ38rUj/njaAYWrYSYTarw+greYJj5FmP1nTU8gkHw1rNT6n/oIWLDcRPwxsPzA3AHLVWLptB6wyjvbjJXLxK8JzFLYnnaAO0iYWBgn14XRV4WJvQ/povq8gMj0l3RFCuGn54=
Received: from AS9PR05CA0353.eurprd05.prod.outlook.com (2603:10a6:20b:490::13)
 by PR3P195MB0992.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 07:04:14 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::6e) by AS9PR05CA0353.outlook.office365.com
 (2603:10a6:20b:490::13) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 09:04:11 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 24 Oct 2024 09:03:38 +0200
Subject: [PATCH RFC 4/6] arm: dts: imx8mm-phyboard-polis: add optee load
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-phytec_imx8m_optee-v1-4-fc6b78bf9a9b@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|PR3P195MB0992:EE_
X-MS-Office365-Filtering-Correlation-Id: 258cd8e6-2f6a-444e-4dee-08dcf3fa11e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGg1WW1tVTJvdngzQ3FOMDdWUGRpdVk1ZXFkR3M0MU9QY0VlK0Z6SDdpVVpw?=
 =?utf-8?B?cEY4TVBMUDQxUVZpaXQwcEswUXZYMEt5KzBxWXZJclJ2VDZPTGRwY0E1bUNn?=
 =?utf-8?B?MkVBZUFCWSsrZTEySm5nK0ZFNExpalYvejhacVB0OFhsZTI0VW15Z3RWRXpG?=
 =?utf-8?B?emlvaDkrdzY2cXlMMWNoSUljU0RKYitOUTBnYWR1K1o4emdZSWtCaUNRWTVw?=
 =?utf-8?B?TjRmVldLdy8ySXZxSUFsZng3eGZvMERxQnVOS3JMY3dGaVVOeERPV0hsVWhj?=
 =?utf-8?B?UDh2VXBXNU5KdDNmN21EeHJUV3N5NDJwNmxTdUZVbVdxUW44cHBTOXoxeFFj?=
 =?utf-8?B?UCs5andLcDFpTWhWbzNXOVFUdXRWZW51aEI5ZTBTWUJCbFdZTVBLNk1ZaGVG?=
 =?utf-8?B?L1hxTzBTVWQvY0ppeHhmWDFGMVk3U29ZUVJ4WFQ5VW9raTdGdXNKQWltbDFu?=
 =?utf-8?B?RjNoMERTV1VLSWlYRStMU3BRSGplb1EvUVFSRys4eG50Z2hRTVhhUzl4Vkhp?=
 =?utf-8?B?WDExQUhQejR5VDZKTXRMc3lZajhFWVI3S2lrYXJqWkdxeXlMWS9nTmFkQmF0?=
 =?utf-8?B?dHJlNUVMZ3dsa1RTZlEvU0VyL2dPN0dXSWt1N3pscXlFcVFjdEZuMmZTUHNn?=
 =?utf-8?B?RXJIRVRkN0JGa00yZjJlbDBJVkQyS2F1M01rcWJvaWw5cnpaWE1tbHFmTzBB?=
 =?utf-8?B?WVV2R2tXZWsxVWxrbkkzcUxVQVVzZWRDbE15ZStHL0E0elFuYS9EbjlXK2Zv?=
 =?utf-8?B?blVwT3hqWnZYZEtFYlNOSmtvOVZPc3lnVU9mNGo2aXN6S1I2alVBajJ4Z0pT?=
 =?utf-8?B?dmI2NklHQ0I5cmE4N2w5VEsvdUtZUmlNcmkxZ2xodi9Zc3U3MUlpREFkZWJW?=
 =?utf-8?B?bG85Um44U1VXYVcrbVlQZFZBR2Vma0FJV0tKMDExN3dtcEsrY3FoSkNTZndl?=
 =?utf-8?B?NDU3aHJEOERuSHJmZ2RQS01SRUIwSnFxWm5VN1UzeSsvVzgyVzlScUxYbjBt?=
 =?utf-8?B?N0hrZXpEd1BRVDZqVVZZNlk0T1g4bEkxMEZnajdobzJESHMwZ1MxRmw0K1VL?=
 =?utf-8?B?VGtQcUFxWHRDOFIyZ3VaT1locjZaK2xpZkljdnQ3elpKanFoY1JRQXNwcXZK?=
 =?utf-8?B?YmZWU0hwN1Z2TmdvaGlPVmtWZ1MyOUxLTEJpamhHSmhXbm5mdzFQaTRQNU9q?=
 =?utf-8?B?dGY0dWhiUklZT3g0VDJka09GcWw2VHorSCszMWx5SndSUFBJZW5HUkl1Y052?=
 =?utf-8?B?bVBXbnc5NzNIVW1KY0hTdTYwbWU0YmZyK0thS0Z2QlJQQlVPRXR6TVRoZ3k1?=
 =?utf-8?B?NENmeWZLYzUzalVWUmtXcyt0U2tqWXVFN0dTNUtTMWgxU2ZVcGdmakdHMWt5?=
 =?utf-8?B?UWVzMXYrbjl1bE1uZ09TMVlSeDVMUG1MMHFRVEpoWDhJZ0xNc1VGSnJ4OU51?=
 =?utf-8?B?ZWsrMmN0dUFwQ2R4YngxckRNZHJ2Nmk1WEtJdFlDYUNrekNZVCtCRjZiYmZq?=
 =?utf-8?B?bjNHbW8zYVlDdk50Vk1FbHJMVmFZR2s0NHRoN2h0M3JpS1JqZUJOMUVkcWh1?=
 =?utf-8?B?WDJTL1JFSUJQKzdma0FDcDJKRDg5YnQ0Rm1KOTBaU3RrMmVxNXBtSlJQY1hQ?=
 =?utf-8?B?WDhxQ3NiSXZQMUozUHc2NXBlMG0ySmYvV0FXaEdoMTJzbXQzSGgxYjVNU2tC?=
 =?utf-8?B?VjNBZ3hvbFJha3FOVnVmZTNqRUQ4ZUZJMlZEMmhuTEw2ZExpSGxBRFUwUFZQ?=
 =?utf-8?B?ZTNTcWZEcmJabDdZRGZUQWZBUFlKbUVRWXFZK1REbHd2RWNjTzh5djYydUF4?=
 =?utf-8?B?RzJTU0xnZTM3L3JWVkI0SVlWUFJRZUZhdnF2VHpzenJUaDk4YnNSYnJQZDVH?=
 =?utf-8?B?WUxTT1ZVWitxMlRVWlhSV2pNbGtndCtaNW8wWWc4enl5MWc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:14.6938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258cd8e6-2f6a-444e-4dee-08dcf3fa11e3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0992
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

The phyBOARD-Polis i.MX 8M Mini expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 516e52e1f5d..837e0c76a60 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -14,6 +14,11 @@
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

