Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ENYcEuFC;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T0GyPi+u;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T0GyPi+u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4660980CB1;
	Mon, 23 Nov 2026 12:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxyMmMrOYAo1; Mon, 23 Nov 2026 12:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AF6F80DA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795437128;
	b=YWLgYyti3TF88dAumcDcV/xUUWSzw9kLvBIDo0AZthaH1PSVvPNpKlxi/BNJhkXz5UtA
	 SuEfU8TCnq2A6rRcSD+IsMkoI0mRNvtQJebx4LuBGyXA8aIoKXbZv8uFqfI5wkbfEgA67
	 3X1vUUCKksbFzo2JPZbFF7l2t6b30UEZ0fSKiV05+TgwFlCS2nE7AJ4qHBzm19DzFDL3i
	 BR02jjZanMVaVTQPqziRFFUc/1yu+FHlOSQ2OI9ez1TMm2SpLczhylNps5PVcYyF+hG6e
	 s9On4Rg0tQBlX4TZ5Ed1KuFQMZ7J31YPCzy6zjPwk8cTE593FHh/y/BUIQqzcObACeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795437128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=onli/0s4/kN/6Lwqrh4vHgRMiGLL0UuRl2mgEed80uk=;
	b=Ex+bNqOK7vlVwX/rQGikyW15VS2v0++X6OPrjL6nb5UoOJv0sDOsrazsMqHBzNBZO/oJ
	 91wh9bGoUZQ5jh6cpuEDmuqjL3KyHPCZDdwtKsrtlBu66WxMQsvNONz5LuSIBJ3dTakR0
	 fdDq1TegOReQpjSgWl23G0ArKQ/d62+ZxzWkeascXVNigwKX58dxUx6UqXCeqA41WDLmI
	 dkh+RYJM0MazODAb+q5+FuOBRzcHwvTKnVx6DVrRScqMeROpKg7fnYSf5a6sIt8qNILwj
	 NgSgVhGolUWCqnbP7dJiGlJRVHGK2lKpXePnc9U63z1YFsEByXAjstc4kaGVjt3fQXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795437128;
	bh=onli/0s4/kN/6Lwqrh4vHgRMiGLL0UuRl2mgEed80uk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ENYcEuFCYDAGREb4eCq59dv750/w4oEjConSRnSaTeZB4IGJkIBSIxLGlc42Njq/m
	 tmkJxSoBx6fsvbvQ53aEoF+3uAMU2vQAy/0frohjPMgYwWCj27UdiKEFElvOrKYXvs
	 YY8XJLWuWZmVU22h8rd/XGtLgdUUTCj0zc56XSOXnjrCYyxqjLxHde4xu3Kgu0jMCO
	 Rh5qYV+tZPgpqHC7zeny4tREtNvZgEwE9ym2+DE7/93tJjljGAgjtWpPw5MONBimdH
	 XbqPX7CXxxbRNo+hgo34ZKbOI3KFwN/YO7zaU7IeVfnzMZyVr+wFPNmDiWOg2E/ya9
	 Ic8M4+BP+vUOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF6F80DA4;
	Mon, 23 Nov 2026 12:32:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 442D73A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 353CD60760
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qd2YeznMmRo for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 12:32:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71C0F60757
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=T0GyPi+u; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=T0GyPi+u
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71C0F60757
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onli/0s4/kN/6Lwqrh4vHgRMiGLL0UuRl2mgEed80uk=;
 b=T0GyPi+u4fc2riJsc1z1uc9r9oGBAlcyIhAyp1JnFgBIgmiGjU/DMmr+yTMOTQ3ws44VwoV6/DnXTUjRPZNOH7+jJHTUy4hbTS2GRYHUy6GcECo5l96MEG3DSXhTGL/a/Sxk01QZ+qjkmfvOZ/3f+iwslKuzY6w2Gro6+rnDHAc=
Received: from GVYP280CA0026.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::29)
 by DB9PR08MB6505.eurprd08.prod.outlook.com (2603:10a6:10:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 12:31:53 +0000
Received: from CPH1EPF0000051A.eurprd04.prod.outlook.com
 (2603:10a6:150:f9:cafe::3c) by GVYP280CA0026.outlook.office365.com
 (2603:10a6:150:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 12:31:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000051A.mail.protection.outlook.com (10.167.241.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 12:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onli/0s4/kN/6Lwqrh4vHgRMiGLL0UuRl2mgEed80uk=;
 b=T0GyPi+u4fc2riJsc1z1uc9r9oGBAlcyIhAyp1JnFgBIgmiGjU/DMmr+yTMOTQ3ws44VwoV6/DnXTUjRPZNOH7+jJHTUy4hbTS2GRYHUy6GcECo5l96MEG3DSXhTGL/a/Sxk01QZ+qjkmfvOZ/3f+iwslKuzY6w2Gro6+rnDHAc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB11752.eurprd08.prod.outlook.com
 (2603:10a6:800:314::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 12:31:18 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 12:31:18 +0000
Message-ID: <e4e021c4-af32-48fd-9891-454f36ba0242@arm.com>
Date: Mon, 23 Nov 2026 13:31:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] net: lwip: configure IPv6 on the shared network
 interface
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Velkov <iav@iav.lv>, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Murtaza Munaim <murtaza@saramena.us>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Drew Kluemke <ankluemk@microsoft.com>, nd <nd@arm.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
 <20261111-submit-lwip-ipv6-v1-v1-6-eb0ee8f8da1a@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-6-eb0ee8f8da1a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CT2P275CA0132.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:21::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB11752:EE_|CPH1EPF0000051A:EE_|DB9PR08MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 915c44de-2b0b-4a2b-bdd6-08df495dc0e8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|261009223027099003|6133799003|18002099003|22082099003|3023799007|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: DNH8s77/mJzMKcw21rDaxAmpyTBw5kkzzQljJwrGA4X/7jPfWDRQSrCnsr1FZuUg/sjy8/nRerrO4Djt4UddWVRJFv6lauBReLwCZDBfGf6P14Y3GevzXRIcPdEMYochaXp7RdSZZBf5ZcHAnaxQ9gYCrj5Bq+G30O7CEDDmzGNrPyXgNtE7hHfD38j2N424Z70SQRKr6bjOPbgD/SQBDWCI+yd5ODaiLmsQLdOgBvMoFhQDbTwjPgxlEFx8M9iG6mnaYB/42DbTMKzY5UcL5HDGyoDDWjQX/dwyA68fscOPotHzoRKDBcn4m3wrXlmUIK05+4yaf+ZAjHtKVTMAzCeFCZhNBM/BY10x4E7AedXaPT+mnMJwZFE91TPFw1T3vWd7ki3LA9/CWFEIGHgWW+LUHim0QC6LMO3GGvskZVlN4kWGOW+ssaiq1XcMrtbwm6RGUTyU0NPe4O0Li0FN58ABP9AwsVV0EQ/4GSnIJB/N6WcMCEg5vPIWTmribAA73B0yC6Ef37Rl8Z/4GMrnyEZw3dUsDoor6CGcUtnldLkjsJM8nXTjVpXFuPronFEQtP85vQjVgn44OjN9B3drATPJ/y30Ev6uyQ2zQI9zuavDnXogGwJPKCHrvd5nk7fwn5DJt7bEO3DHKh05hgEr6ZnVJfHI3+/GJSFV0ftDnxI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(261009223027099003)(6133799003)(18002099003)(22082099003)(3023799007)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: MGy7TiJRdpHt81XHpLlV2y5/0u9XL47cX3LSYwyCbysp4Olwr7X1e+16RQw2m1B1Ppr1Fqkno/Z8YYTESKmqIB7swHXRpGChzur+2OWYDQQvyq5gU7eo4oEQMHmpss+Muv0UHf+wixQk/YuHllonQgQygRtxI36e29qTKqYriGr3I4pcl7wjv9vSSDgPDPYF1c/g6mOxodoPrR4J++H/bCbTW1DpTUKEuybsLBhgxQpyidP5L8M+RhVdS5LTZqMlGBqG4fn/cPViZe806YG0erPdEnajiKAKV1mYQtVu4NPcnJtjzh6/rLpLbERiBSbWwBEvvKHTkItpiqpt9ZQnnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11752
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 71e33446-40fc-408b-4efb-08df495dac58
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|14060799003|35042699022|82310400026|1800799024|376014|7416014|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: cW8L+pjYPpGy6jc0xMGRRbrBhXrAh63PcnqYeDWZR1l9oZzddNM8xg0KA8kk2wUou7/Tbg/ZgVNVcjr1WV6f8IBrI6dTkXy4FI0B207VnCtKFy1nC73saHiK+wZQeiGZOVsMeDtK6ADEZPbNHaCs6Lezlwc2yuU+PjF6BS+EFAJal7qVMysM4IzRmYR42uFmzGIjT0FtMLJ+962yHbRggrtM/d0jA8+2FzCbfa1BP3Sksg6CrIInwoSBMLVs4ChFa/7cJw810YuniXP2L4PjiaaBZvKRnNbcpER/R8juwmeb6UtCg7X4UhcrGIYgSRPkMHE1ziMVLH3m+DDUWhjmr9Y7euEUuiWuZaCFCGIz2mmPV3fpUb8AVy2mP9+qPDlYnbzGnScA6q6+r6e2D6R65sgmF/Pwt1LC4UsPr+1WzhDjcRWHw8Rpx3QyV9aoU4Mgx2CXxVko0wHCJYzK8gQD8jWNqpMVVSWrsHzxhtN4vTRulcDfw5aWScH3ptoFyT5gEfkJrPF+mC3PyDSDaDfZcH+ISeNLxvnDChIgp7DTnNyB8G2/GyoDWeGIKQVxY3qs3wLRRfHg5eZfPITd85bA4q1FmHDkD09dDm6x2jGLtWJ/kI5jg2OWYhCx0GswrMOLlSPr4XPzfdDdxqETHDHWUETQjDWhfHN6upS0kx/5IBPdXNuSm7kYlTLjbivZSQQ3aWLK1uhdom8kOyOisVcsrg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(7416014)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULvVI97hNTYzjJDOJJ2xoEkq3A/L0LwqbMdOtI7OPQJuhRUTCthN5yBZ89S0LL1dG733rCd9ZoOaLEjLvKF4Aqi6IBLINXrR+JlQuJHbdmuC5E35iyOno6Ceg8zj5mZXbs3wHhOqJxvsvzjhWqFtCkpVWjCvYsJruxN6xsZPdPVHqdUAmssgwXSVeg3CwuOihRdnOyBZuI3TDtal4IkqTPkj2VfFK1GPXEPNue2vtYRZgVvzuF5UgCjBIAhF0Bk7oO2oeZ+OuD48fYj3cNz/qRvKOMyMdEhW0pyvwsI7tYhutSe/CX9Iz2aTSTpMv0Eg8dtxa4EO7d2Siqyi2Haet8dFJOK9DtZYVFz3xiCMlnk/js002dBEzNc96JDZVgbp39OcitSht6sSn6rS/TcIo6Xq1DolS10jo013Yqyg4zHyiMXpR5pCQZ7XVzKGvstR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:31:52.5679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915c44de-2b0b-4a2b-bdd6-08df495dc0e8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6505
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 21:11, James Hilliard wrote:
> Enable the bundled IPv6 stack through CONFIG_IPV6. Configure it lazily
> when an IPv6 client starts, preserving the IPv4 configuration used by
> other clients on the same interface.
> 
> Generate a link-local address from the Ethernet address, or use ip6addr
> for a static address with an optional prefix length. Validate complete
> IPv6 groups and compression, and bound decimal fields before arithmetic
> can overflow. Install multicast filters and wait for duplicate address
> detection before sending traffic. Support an explicit gatewayip6 and
> optional router discovery with SLAAC.
> Use the configured static prefix when selecting an on-link next hop.
> Select a usable source before reporting DAD conflicts, so a duplicate
> global address does not disable link-local traffic or another valid
> address.
> 
> Retain configuration and learned neighbors while the interface is shared.
> Age finite address, prefix and router lifetimes by elapsed time before
> checking readiness or polling. Cyclic timers skip missed callbacks, so
> one decrement per callback would retain expired configuration after an
> idle prompt or another command stops polling. Separate lifetime aging
> from DAD and neighbor probes to avoid replaying those protocol timers.
> Preserve static and infinite lifetimes. Reject environment changes while
> the IPv6 configuration is in use, and discard it on final release.
> Provide a nonblocking readiness check as well as interruptible address
> and route preparation bounded to 15 seconds.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  cmd/Kconfig                          |  14 +-
>  include/net-lwip.h                   |  10 ++
>  lib/lwip/lwip/src/core/ipv6/ip6.c    |  14 +-
>  lib/lwip/lwip/src/core/ipv6/nd6.c    | 214 +++++++++++-----------
>  lib/lwip/lwip/src/include/lwip/nd6.h |   1 +
>  lib/lwip/u-boot/lwip-hooks.h         |  28 +++
>  lib/lwip/u-boot/lwipopts.h           |  10 +-
>  net/Kconfig                          |   4 +-
>  net/lwip/net-lwip.c                  | 334 +++++++++++++++++++++++++++++++++++
>  test/dm/eth.c                        |   4 +-
>  10 files changed, 514 insertions(+), 119 deletions(-)
> 

[...]

> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 60fcf9b3225..9205698d9ba 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c

[...]

> +int net_lwip_ip6_aton(const char *text, ip6_addr_t *addr)
> +{
> +	const char *p = text;
> +	unsigned int groups = 0;
> +	bool compressed = false;
> +
> +	/* Validate groups and compression before using lwIP's permissive parser. */
> +	if (*p == ':') {
> +		if (*++p != ':')
> +			return -EINVAL;
> +		compressed = true;
> +		p++;
> +	}
> +	while (*p) {
> +		const char *start = p;
> +
> +		while (isxdigit(*p))
> +			p++;
> +		if (p == start || p - start > 4 || ++groups > 8)
> +			return -EINVAL;
> +		if (!*p)
> +			break;
> +		if (*p++ != ':')
> +			return -EINVAL;
> +		if (*p == ':') {
> +			if (compressed)
> +				return -EINVAL;
> +			compressed = true;
> +			p++;
> +		} else if (!*p) {
> +			return -EINVAL;
> +		}
> +	}

This rejects valid IPv4-embedded IPv6 addresses such as 2001:db8::192.0.2.1.
This representation is permitted by lwIP's ip6addr_aton(). This is fine as a
step towards enabling IPv6 with lwIP, and I intend to apply the whole series
as-is, but a follow-up patch would be welcome.

> +	if (compressed ? groups >= 8 : groups != 8)
> +		return -EINVAL;
> +	if (!ip6addr_aton(text, addr) || ip6_addr_isany(addr) ||
> +	    ip6_addr_ismulticast(addr) || ip6_addr_isloopback(addr) ||
> +	    ip6_addr_isipv4mappedipv6(addr) || ip6_addr_isipv4compat(addr))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
[...]

Thanks,
-- 
Jerome
