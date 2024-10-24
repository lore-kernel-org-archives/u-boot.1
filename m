Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB8FD0BB66
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3342C8933A;
	Thu, 24 Oct 2024 09:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="QHE/ZYRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5360689335; Thu, 24 Oct 2024 09:04:25 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9F488E0F
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIU4zH5QrymFq1S2B7S/mq+dfLum5HrGUeKQ741Jop77wR/pwXZ/1DDPszYipVk8AEE6UuMFNwbw0sEzFGVBlk3gJOunTGMbTwXQL6kxJTt9Z30eCsxFSih7aFX+7P86UEFNxNAX7VjwCIUiVwFw0xZXN/74Wh16Sv+tfG9bHTF+AgcdQApIHOw2U8cXc8Dhv42B6Kq0gmTqnwoKa5wYw7FQZTYCTi2ASqqY1lJ/BXRTUMYUbPGmu+8bzhMBjBJH5gapRROBLq3YlDavOqJwt+L4MCZOjK7+wYjorbpHwWYSwmEf6sA1hVVSerI+DzYcxxVrzoQ5IHWIS8Y+MM36QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLpr69alcqFh5aj7HDFtIykY3JJKcHHPZlHheAYKSEU=;
 b=mg7ZvsNiNnzRxQBqnh8eGklPPDPGAfBm3Fiy+e1yD6uS6tWUUV5WgVxaOQg9tOQs+pMfvUR79p6BIb17CGi1bv1oYXxCiLslH1UOT42vV5JBJP6qGfunSKPdaVTux4XGGytQdxIJNBF+RX12wMURMMt+86TgdsJ3BXiJ93u9OcsM4mjsamuvVt/PuNLkiv324tU2d6UfMv3UWYq6e2mrZsKWtqIPiVWg+YdzpjBhpyc0gx9bWUGH79/nq40jhy787UkKnQgbAFHziTfPL56m9uepohXTUV1rBmdFKH4X56e18aw4dteKebJlNF7vdgnKXC19toMwWXuCjXUreZXrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLpr69alcqFh5aj7HDFtIykY3JJKcHHPZlHheAYKSEU=;
 b=QHE/ZYRci8aK3m7RWlBArHEB2xlbcRjuDYF6hAGruoask3UjlBGtp0gF9y0jdmIL7jaWwItzj06NfvrlIQTdBJ8cuVU/c8IQskXHJKPoPS+RAl7dDWp0bql8by/dzvNsOkWTt8F1ZnsGfiNaWie1re9eOxXa5xJehZk7wHlk+K0=
Received: from AS9PR05CA0353.eurprd05.prod.outlook.com (2603:10a6:20b:490::13)
 by PR3P195MB0539.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 07:04:13 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::6e) by AS9PR05CA0353.outlook.office365.com
 (2603:10a6:20b:490::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 07:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:04:13 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 24 Oct 2024 09:03:36 +0200
Subject: [PATCH RFC 2/6] arm: dts: imx8mp-phyboard-pollux: add optee load
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-phytec_imx8m_optee-v1-2-fc6b78bf9a9b@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|PR3P195MB0539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aef4494-b223-4ad1-67af-08dcf3fa115b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFpUWmtKRlJBWW9DVjExeU01d1paMFBmS25BMjJNQkQ2eXFGTHZFWDgxQVVK?=
 =?utf-8?B?MldqRzhQUk80d0tsOTBQaGYyY1FQOENrMCtQNlRKV0xOc0NtUDltY3JqTmdL?=
 =?utf-8?B?T3RiQlAwOGt3OGFCWEJOZW1UY0pnNFJxejdLaTdyMjlZVXQxczd6QmRhVFly?=
 =?utf-8?B?aE0rZFJWWE5hNXNDYzNCbFRNbXBkMlEzZGFlb0VOL2VLQTZwblRwY0tYdjNu?=
 =?utf-8?B?ajNpdDg5QmI2anZXOTdjR3FKRWxkenlSZSt6NXJhTXVJNGhhSENBejZOTkVj?=
 =?utf-8?B?Q2UxQmdhdTBUbWFzbzQwWnRYTllsM1RTWnJzSzhUWUZYSlRsT0NiV0lXQ2xl?=
 =?utf-8?B?aGtIcXZKYlFEeERlU1BPcmxoMjhHejZ2NU9aSmhVSTBXdGxPNXZzNVdVeUZl?=
 =?utf-8?B?SzVKUEs1Tklsai94NUc3NzdhZ2JjM1c1b0ZWaVR3bXZOSy9pQktFNmUwYmRE?=
 =?utf-8?B?VFZFbVRoYWtFVjM4NXhERDQ3b3ZsaHhDNlNFQ0hhTVFPQ1JoTHQ1bXNuK2Z3?=
 =?utf-8?B?NHVpN1JkMm1sUkxuckpsM2x5eitZSjVNNEJEYTFoNTBwUkZEbVFiVEZzWjNn?=
 =?utf-8?B?RkJIUnhEa3VtVXJVa3NWbnlUejRvU2VJL09RZVJjS3RFdFJna0RNbnBpbGN2?=
 =?utf-8?B?d3kzanBwL25FeldBLzV6MFBGQm5US29JOWlndkZOQ0hhdnJ5TDVnenJIWkFD?=
 =?utf-8?B?OVFHcGlrT3Z1WVB4RUhtejFtdmNOSllmT2dCbFN3WlQ4Q29wTVovSUhFSkVG?=
 =?utf-8?B?bkdqM09kQTR4ZThhTGM1ZlRVdGRTV0hCaWZBSDBMWldIbFNVelJOQzRHcGxy?=
 =?utf-8?B?c1oyMEhNYUo5b0hEMWtKZTdkNFFPVXVjakVtY2Z6a3RXNFRGL1hhNklXS0Vw?=
 =?utf-8?B?cFM5SUdScTFibWJDMFBmV3djZnpkNVdIaGpCZXJsUi94ZDlKMlgxRjJrK1M4?=
 =?utf-8?B?andla2VMRUw3YVF6QWlraDQ5YWczTjZqR2dmSVZrdUxBaEFSc1ZRQXEzZ0hO?=
 =?utf-8?B?U1l3bGhGY1JpY0R3dkhPN1BwNlNKYmRheTgyVkJqUHNDS2ZzQzczTDE5S0NE?=
 =?utf-8?B?TkxaMXB1OG1JSXMxT2F5aXBMZlExYjFIT25qMGw1dFVIMmJPZ0Z6V3NpM0do?=
 =?utf-8?B?SkVnNS9yTWZrMVd2OFlURWtoZEtXNXhVdXJEMFQrb1RSc2lvZWFZZEJmZFdi?=
 =?utf-8?B?QmNGQUhmdjlSdGM0dEl0SzFRU2IrVi91NFlhWC9kTk1YVDJzZnVyM1ZFM0VQ?=
 =?utf-8?B?N2RCTEkzOHdLbVJHZVVNMHBlTDVTdDhPcFFvd2hENW1Ed2JuRU5tUkJVMkRB?=
 =?utf-8?B?aXdFUXREMmpZVGJrVzE1bXdaSU1kUmptanNhNllvNUpGcHdqY0lIYTk2VzB1?=
 =?utf-8?B?N1FnaE00ald2S0ZwV3ZUdXRpQlpyZFV0SW96OGZvRDRzVkVZK0gzNXNhZG0w?=
 =?utf-8?B?dFpLRStDbk1GaWdaNzlab000SnVBR0hhYnV1UmNRdUNFOGNWTForWGxtZjBw?=
 =?utf-8?B?RkRZL1ZHVnpnQnJodHJOeERTZkxPd1Rkb2UxbW9MS09qU1NFUEJYVnY5cTM0?=
 =?utf-8?B?MXJzWWIzUHVxc1NHeTdiQUlWU1hkWnUwWkZJa3BJTTByMjFLMHlxT2hMMmw0?=
 =?utf-8?B?U2hTV21FNEFhWWtXMWFFRTFMdDhYWHFaR3l2UlQybnQ4NllxWnVyS0FKSHF4?=
 =?utf-8?B?d0JkMDNzdUNyK0NvRFk0M21WM1FZSytVSHNBNlZoZzFjaXpDNlVJamNDYnZX?=
 =?utf-8?B?T0ZRdG1ocDVLWGFCTndtanI2TmIvWHFseW1wYWtVMHdjMWhEci9KSGRtVWlp?=
 =?utf-8?B?SmIxcHdhNlJxcFNiMGQvdkl2TFR4WnlOZnNBZHZzZytDNWovVmpBa09rVTVC?=
 =?utf-8?B?UEVnTS9OOU54cmYxMjFENjVYdk5FTzZKOS8xWXZaMDJwK2c9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:13.7875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aef4494-b223-4ad1-67af-08dcf3fa115b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0539
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

The phyBOARD-Pollux expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index b4efff27a70..2b741322ad7 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -14,6 +14,11 @@
 	};
 };
 
+&tee {
+	entry = <0x56000000>;
+	load = <0x56000000>;
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };

-- 
2.43.0

