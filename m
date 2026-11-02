Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B0606ABA9
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CHqAzUhG;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fO6M6yu4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 807C581100;
	Mon,  2 Nov 2026 16:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UOI0jDHhfWAr; Mon,  2 Nov 2026 16:22:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9F87810E1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793636566;
	b=GWJS3zsOvIBF4gOPz4GOFcuKDRfcp3zsqQ6gA24O1B5zVeQ4zR2Pz3XLDo+ca/i+9tSz
	 SsPruCI+HhipoC0af5TXLtEP2u8GR01/nQKTiI/XCnNW1iD9xk1H8u0L81xxA0L5K9nuc
	 ZdRi/9gCyaoTM5chKWC8/0X9rSyWkp+JgcbFImskMU5fDNUEi7hK2SqyaRLep/HySrIy0
	 XAjN2qbc7Sphn+bCoMwkjfgF6F6fH/659Z2Thm/DjYy9m2ZHj881Ftrmuu4/DmvxWwwlF
	 tMVHCiFAtB7ZIWm1hV1u3aFZ9GfGCg4EaDOGHKakTWvzenJXqrfkI5v1gE3IOXcvG+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rHoIuWpmQMUbswxxmwyNd3Ue5febOlu9X3KBIYk1mD0=;
	b=cI4Lle3/cMxMIK4GmzqShquzskvNAdB2Zl7+Xx1WayABTG7EXwsXQ2XbHmTNWkBQ0ib/
	 f7b80Z/SaWCqH0FbWx37URuD1yNCVZySJ0kn9kiL+AAofU5XC44KQtJRk3Goi7FoMMltD
	 XgskazccdoiiqVVJc0KTCIr3f8AlhQUSSSzyEhb6+urhxVjHPTt6q81zQxZcyq9rjuhAo
	 ZgL7WWGsxGrn8x1HRD6mlgkWkho2zo4T27AJCE+3ahCqczndtBAeWn1lOhWu/wIg8tNq6
	 5J1gXKF97qT25vJSVT5rGjksx7TcOX29my8ZDp1mGHw2ZRwp4n0DoTUsgZciNHTAKYw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636566;
	bh=rHoIuWpmQMUbswxxmwyNd3Ue5febOlu9X3KBIYk1mD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHqAzUhG5O543T5oAdNARv378+YDt61egcTH/cJuG8jlTYZM/9jpTmMuEPdGgZwIY
	 zuoPr6gpx5fKGttF6XI5f0Kb/rC97SPGicIFqSiXp/0oYQEaztDBnFRhNZ2J04T3sB
	 KJEj4QveA28Pt+aCFq1mypXi8AMbR1HJksTxwqAHeUu8+NQLykcYQKx4ihC/vpYGys
	 a5LuEvJrh/013F8WPp3G9w1Xz3GgYH1dyLm8z2Lzncexd24ZdjI63JxdjjVby1QNNB
	 4CIA/DNqUU/vrMXq7JG3SslWelu0d6ygDV+y1XPIe+iHe9ryeAyvlxYiWnxd23RFL2
	 h7FpFnMMIkg6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9F87810E1;
	Mon,  2 Nov 2026 16:22:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E62722AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC7E34006F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSf_Oe6rlHya for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 13:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7F0C140050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793627092;
 b=kkVXzis2o4weKQe7ruCfSsorBfAJbay8A3lUpIHfY3tdDSR17LOdTwB4UPWwF38LkWON
 CZvG8xznUktK6rHrTg+jueIXqBB73IrSAlGBBaeDmPa553rdjMpQ9slU3vpuPMSsDn4RJ
 T9mSvitPtWU6H7wCTk2zeJIyyS7XbJspeg+Tpx2jFdCzK68kqpl92YMQJG3zQOaQBjMHb
 CO74L0u97C/fIk6TJDUhD5wa5n6HZ/cpdxvC5CgKGcdzgT78+A+OaFBSdtWFJkwZOQ5PV
 qPCJhZplxWGYkzZLhWSXAtjqwgL6jesRQVM0MOi2u2g3m1blr963Kd+t6Tf0YW9r7kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793627092;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=rHoIuWpmQMUbswxxmwyNd3Ue5febOlu9X3KBIYk1mD0=;
 b=nxMTlA8WZhcYdU18McvsUtefzqcd24eg+xivFG2AR/q0oUFLXiWebtHtSdIfpKHBb8Xk
 7g6cpFGjKco0PPtGdn7wS6tfDwfDRGeQWuxSL3SCyCZ070P6eChnbUK4mhL7JWmDZBPLp
 bBbH+sUIAz7OcUlGD3tz9xrQxYKbCOX7wwFwzmECirOyI5B/hCChpiBjtxmeQpdoxA1ol
 t7GDaLYPR9EABMTK6XlH2YvhM/I6UWOn1Nm15MmkY8VB7UUB6tcHAYIE98W0Qpt5fcZJU
 GyXTQP0cstQ1BGfAinLfDDTHJtvcCmUNe/JmWEdT6Upc1CL5MYYe2MJogffmObIPFTQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fO6M6yu4;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=fO6M6yu4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F0C140050
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqTJ9sJ214CJW5mbF3jAp0xDrFw3MkmZdZGBhcnp9hqGtj3/Nq32qE3ybw0Eqhi0H0mKV2osBiXrJ8nco0PN80SOTgjWrY/A55mBXRFYCZTRVLSpipYy6a1ixhnTleYMGM1iSiG75vZSPUkzmP+/ptFUJ0qpzryBi8r980uOEbPCxnGQm6bo35RBVigQ0CmQZxK9AqZnbehZGtYXbD0y/yqd0h8sVJbdF2KJce985bUc0qmcCQNEi2MFM8px2+fZqCqo1z8QEZBYQ42pOLl/aCZXJR+neBE+1lZyNlBcFPXtXBZ5HmlNHPNfVsL/rgY5ek3yUZPL4qRAk0juELLARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHoIuWpmQMUbswxxmwyNd3Ue5febOlu9X3KBIYk1mD0=;
 b=B6RAzrDmAgJLNnaoHyKNfHWKYmLzpn6SSMzNgwDIf62FOxK2Xdbepf7FayR6K+97W7Qf4ovkPTHde/0lnxQIgBPUkTv0UWIY6VMtERDl9g4gBjQjvnpqxiiy6203gg6Ve1lw3sy9E+CVxbTF0eKKqHBvdxdGxl5WOkUdyCIGWPu80JF//vFqp15zpw2hrfXnQeguVbkIcIzfhMpWfPjbmX4onT0JjPMMoRzF3MNDrALjtI3HBkyPXenyD7Xlp0k7Y3KoLpqv+zZdmdiIpf0Efu/4IxZtrKih6km0zZvYBw/ZB8yLH6ZkkllAe5FJrdHRn0ipAnabxGt0yUz+yef8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHoIuWpmQMUbswxxmwyNd3Ue5febOlu9X3KBIYk1mD0=;
 b=fO6M6yu4/1s3k269gcrno9v98G1YtsfgWyLl29eIphWY0wsNV9AsKDgAYP19p9HBHJ1X/zEEhyz1kXM6B84DseoByOSOfs14dATRQVrgR6hyhPwvauQpNejWFc1Npuk7nZ24VdEP//2i1VXvx1wOGILijpkdXatINlEWXyYhuFeCuZRBy8Vyxg7nuJ6wRb7yHwR263/LPVQ/KL0xwZjNo9ysp/pRsW1vJCfdDqJvsThGqFCbWXYdMlR/Bdy7rV7/DESoHPxukkT2cb4af/LejRPkLUZllhEIPfckn2YBaHTjEV2fYmDZhBlRvmgyVGA4lNQvq0hmiVqvjfU3DBvdkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by AS8PR04MB7574.eurprd04.prod.outlook.com
 (2603:10a6:20b:299::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:44:47 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:44:47 +0000
From: marouene.boubakri@oss.nxp.com
To: u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Subject: [PATCH 2/2] doc: board: add OpenHW Group CVA6 APU on Digilent Genesys
 2
Date: Mon,  2 Nov 2026 14:58:20 +0100
Message-Id: <20261102135820.640652-3-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
References: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0107.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::13) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|AS8PR04MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: ad21a346-a421-49fa-a947-08df38e775b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261022115727099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Z3xyANSIhgVZJ122oDVbtOsoTdLg1wBZ+k6KuZ7FUT0xTL+FvYFqcF6NJMxdufa0kM0yEfOtJtYjOb64SdOYKSi+za9W8NXeA0PaCzQdNc0Li5Dd9rZRAeX/AHrjYG9fZGFVRcNphG+gNXvFukPIL9wZ6Vd26/Z14oZPJU8+jr3BqxGGCD0l5t0V+Cg6Ni+a1MfOCX/TjThWA7OZwjaRZCkA+gaFDMZbdhC5M4MBjok5dOZk4IzO/iaLdYYfAf1IIYlenRjo/dZKERktZdXnCH8zpUhc8kUvICu8rqBiFZ4/oL1cTAk3jwhVX+3FSpWDwuC+4SDV486qlWMuTjLyflDr1Sv0BV2lHsSki+3or4cR2JWZoZMUDQmR6+4Cjfh23F3IKO2TIxCklLzMJKjjnWMIz4DscD3IlnDkig8w9Ezve6z3kC4NqWO5pS1pSZdtGwDbuO5u+NpPRDCg5X5t7F51p5++ptat/Sk5ZuvASikpkMd13aqyYz/nnLb2B2RSUdEMGIeHkQnFsgizbdIstGZ0IhLqB6UTxpcCnPfEkFwoQyW1jqYiUiDFUvclfHsXlPDNxtbs/DGT4tYCjuv884uitbcaVGPM/aJtJOTXazsSZd3OTCDemgIZxycAHk1fFqdxN68qnzhkUmYKkid9Y55y1RdmS+fb3N/Wr/OZDD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11203.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022115727099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02eCm4cqn17sNOsJe6uvl7sMqaQl9ZhL8Aur0FekH6kS464ZvZGUfjCsYUvz?=
 =?us-ascii?Q?DBT+McYj6152AA1FyWeGubPexiijoGwR2+CHzgiExsydx4y0niD0Ad/I4mY3?=
 =?us-ascii?Q?be92o6OZZRRsQEOW8ramz36DK++BAiWcptW+Gx7eqCyz653KIfSXFvAoUZgk?=
 =?us-ascii?Q?H6hQZDIDK1LbSAxJtjv/bSLvNQtySmPXzBP+hfcZssvhdezAMqDq0TBGHOOH?=
 =?us-ascii?Q?nBmj3lf6v9KiYZuhAdjrHTKOM30z7vlK2ynvMEeE+uyS7f6I4EO5RRIhTmr9?=
 =?us-ascii?Q?/rASTld9rRr1DQtJbGuUVDRaccQ/AqMamIP98xeI5cBuyoTscPOZV99BIJdc?=
 =?us-ascii?Q?KJ8eisBdgD9b2dgfC3L1UcK7lFuPbBEpqFml3gRSptOUDJP+sXNS6yEpJgqS?=
 =?us-ascii?Q?IsolpUZRSJuxEBLltSqGFzP89kkbTKh6GZVrJdlwoguFIaxKRa2Ce2rlGLo+?=
 =?us-ascii?Q?9sMhXPXT0BXRMbVnPXj4F5Ju9hgMSnQuYP3YfHfzEOwJTwwtsuWFUIlukGKN?=
 =?us-ascii?Q?k4ZjFfJ3BGx2ea85V0G+T6C7wXAyrjFCpBTgBmHpHd0Zo7k9WpeLvHO61F1f?=
 =?us-ascii?Q?U/hsFRsoKqot82tZJK6v2HXwAkfavuVJ5I4a6Fa+a8kWn+3X85nkeJovr6ws?=
 =?us-ascii?Q?XDNqpsKPe8+SBcUayEqD/Veia2xqEB48N9oWqgX90lnNc+hB40fjyw698Icz?=
 =?us-ascii?Q?51MaNyHNfk5PAbVoP/FPFyb0v+mYUB23jttNxh3Grk9RAxvVkGQpNyOQv1gX?=
 =?us-ascii?Q?1ez5tM+RGyMj1UE29FN7JI5v8cjeu7ODx0kBOdXItg1tWJ+d/sTAnlphtisG?=
 =?us-ascii?Q?4N59Q2QhN17fTIsbiIiNrWyLCo9YL1MBUH+FkHwH5+gd+3W3TmfoMWoH9z2p?=
 =?us-ascii?Q?RdPhz5CKZPKBi3jQG7evCMKcje83ZsYBg1TCcjTFBxbE1wUF9dOgbYcJwkZW?=
 =?us-ascii?Q?bI/NPs4gPz2jbanEvypCORKuMuJ2l8GBVDpOGFZMEcpa7vi+44cQ89jZ16NR?=
 =?us-ascii?Q?iQDlli1V/WhudhHaDk9AYmIWVnCEy1rqInRxPFvr7X8SUEuiuZzzdVZkc5y1?=
 =?us-ascii?Q?rnhv8FL7vWms7yxFjB/t3bFLOzHVLN5t6Ljw31MRlAdqvoasZMWWJ7jDxUrh?=
 =?us-ascii?Q?da4LYX3pd4DOzxWNdg4UjHAgfFlbcwJ2xr8M4TL28zYdjPL+4WLYM6PvRcom?=
 =?us-ascii?Q?8xye6w8UbW2qu7ZzXl9mPKUE5YWXiIU5fIXuSY/fnX/uzWAsnhLJ4NXJuPd+?=
 =?us-ascii?Q?lQoe1wnRkf77f66UVaEAoLFqtSM0QbmdVkEpQnmqZxWcqRgxewq7N2Aaap0r?=
 =?us-ascii?Q?xJcunTzheCnRvo6z+ZHJ5MUlQ7SRx2XJplIkep6mKPz2oJetfJ/GT+CEv+qh?=
 =?us-ascii?Q?3bWmpPemhT4TPyT0uu5Cjc4FzwAs0BtgW701kxmbQaj5NFp6mSZUcxh0Nzn0?=
 =?us-ascii?Q?8vLaObeD4l30QgjVFJOy29MLLJoWq7yhssofpyOIcDCEG2ZVlIh+6HrI/fOT?=
 =?us-ascii?Q?3HClRDDBAIbDpJxLowZarQIkZFJhDvEA/WCp4xetyP6AaCbr+3wCczpOE6WC?=
 =?us-ascii?Q?t8XLCF77rxSds4Aa8RUnuN/8cJ0yxkR85eIfs5DgcTK/kwylN+qg0v4RxkOH?=
 =?us-ascii?Q?lXTVka/GlLwfPVsKTH1RcaS1ZjIqx94XQbyJsgYH1A0PCLN0Nd7uX1DJLRMo?=
 =?us-ascii?Q?DFXIoh0QLxqSLzyzhh0cz7iK+TAv6QlEaMAMaxZ39rB9uirJKnf4ThJj6SOS?=
 =?us-ascii?Q?KdfRkwQPrMdrXKSvcqE+DxO/56mAHmQtAgyCiGv4HAWhQjpXSiraOsuB3TXG?=
X-MS-Exchange-AntiSpam-MessageData-1: S9KGu1N7a3rTFQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad21a346-a421-49fa-a947-08df38e775b0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:44:47.4164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sccwpPUrMqvBhne3CtL/TafmkiPHa2xWGgZBWeGfErjOkQtMIM1kqil6RHIiLRtvqSTqvSk8Ztp9Xam5ubaRSL/vakaToa97CngaPIz7rniTHnxdHpTQlzGB2GIiWkwK7busmYqrwljYApIEb8q7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7574
X-Mailman-Approved-At: Mon, 02 Nov 2026 16:22:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

Describe the two boot flows, the memory layout, how to build U-Boot for
the cv64a6 and cv32a6 configurations and how to prepare the SD card.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 doc/board/index.rst                     |   1 +
 doc/board/openhwgroup/cva6_genesys2.rst | 157 ++++++++++++++++++++++++
 doc/board/openhwgroup/index.rst         |   9 ++
 3 files changed, 167 insertions(+)
 create mode 100644 doc/board/openhwgroup/cva6_genesys2.rst
 create mode 100644 doc/board/openhwgroup/index.rst

diff --git a/doc/board/index.rst b/doc/board/index.rst
index cc1d181a8..e307ce53a 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -45,6 +45,7 @@ Board-specific doc
    motorola/index
    nvidia/index
    nxp/index
+   openhwgroup/index
    openpiton/index
    ouya/index
    pegatron/index
diff --git a/doc/board/openhwgroup/cva6_genesys2.rst b/doc/board/openhwgroup/cva6_genesys2.rst
new file mode 100644
index 000000000..6709c368e
--- /dev/null
+++ b/doc/board/openhwgroup/cva6_genesys2.rst
@@ -0,0 +1,157 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+CVA6 APU on Digilent Genesys 2
+==============================
+
+CVA6 is an application class RISC-V core maintained by the OpenHW Group. The
+CVA6 APU is the FPGA SoC built around it in the CVA6 repository
+(https://github.com/openhwgroup/cva6, ``corev_apu/fpga``). It targets the
+Digilent Genesys 2 board and provides a CLINT, a PLIC, a 16550 UART, a Xilinx
+SPI controller connected to the SD card slot, a Xilinx GPIO block driving the
+LEDs and a lowRISC Ethernet controller.
+
+Two configurations of the core are supported:
+
+* ``cv64a6``: 64-bit core, ``rv64imafdc``, Sv39 MMU, 1 GiB of DDR3
+* ``cv32a6``: 32-bit core, ``rv32ima``, Sv32 MMU, 128 MiB of DDR3
+
+Boot flow
+---------
+
+The boot ROM of the CVA6 APU parses the GPT of the SD card, copies the first
+partition to DRAM at 0x80000000 and jumps to it. Two boot flows are
+supported from there, selected by the defconfig.
+
+With the ``*_spl_defconfig`` variants, the first partition holds the U-Boot
+SPL::
+
+    Boot ROM -> U-Boot SPL (M-mode) -> OpenSBI (fw_dynamic) -> U-Boot (S-mode) -> Linux
+
+The SPL loads ``u-boot.itb`` from the FAT file system on the second partition
+of the SD card. This FIT image is generated by binman and contains OpenSBI
+``fw_dynamic``, U-Boot proper and the device tree. The SPL runs OpenSBI,
+which in turn starts U-Boot proper in S-mode with the device tree taken
+from the FIT.
+
+Memory layout::
+
+    0x80000000  U-Boot SPL
+    0x80100000  OpenSBI fw_dynamic
+    0x80400000  U-Boot proper
+    0x81000000  SPL BSS and malloc pool
+
+With the plain ``*_defconfig`` variants, the first partition holds OpenSBI
+``fw_payload`` with U-Boot proper embedded as its payload::
+
+    Boot ROM -> OpenSBI (fw_payload) -> U-Boot (S-mode) -> Linux
+
+U-Boot is then entered at 0x80200000 (cv64a6) or 0x80400000 (cv32a6) and
+uses the device tree handed over by OpenSBI, which is the one the boot ROM
+provides.
+
+Building
+--------
+
+SPL variant
+~~~~~~~~~~~
+
+Build OpenSBI for the generic platform first and point ``OPENSBI`` at the
+resulting ``fw_dynamic.bin``:
+
+.. code-block:: bash
+
+    cd <opensbi>
+    make CROSS_COMPILE=riscv64-linux-gnu- PLATFORM=generic
+    export OPENSBI=<opensbi>/build/platform/generic/firmware/fw_dynamic.bin
+
+Then build U-Boot for the 64-bit core:
+
+.. code-block:: bash
+
+    make openhwgroup_cv64a6_genesys2_spl_defconfig
+    make CROSS_COMPILE=riscv64-linux-gnu-
+
+or for the 32-bit core, with a 32-bit OpenSBI build:
+
+.. code-block:: bash
+
+    make openhwgroup_cv32a6_genesys2_spl_defconfig
+    make CROSS_COMPILE=riscv32-linux-gnu-
+
+This produces ``spl/u-boot-spl.bin`` and ``u-boot.itb``.
+
+OpenSBI payload variant
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Build U-Boot proper alone:
+
+.. code-block:: bash
+
+    make openhwgroup_cv64a6_genesys2_defconfig
+    make CROSS_COMPILE=riscv64-linux-gnu-
+
+or ``openhwgroup_cv32a6_genesys2_defconfig`` with a 32-bit toolchain. Then
+build OpenSBI ``fw_payload`` with ``u-boot.bin`` as the payload:
+
+.. code-block:: bash
+
+    cd <opensbi>
+    make CROSS_COMPILE=riscv64-linux-gnu- PLATFORM=generic \
+        FW_PAYLOAD_PATH=<u-boot>/u-boot.bin
+
+The default payload offsets (0x200000 for RV64, 0x400000 for RV32) match
+``CONFIG_TEXT_BASE`` of the two defconfigs. The resulting
+``fw_payload.bin`` is written to the first partition instead of the SPL.
+
+Flashing
+--------
+
+Create a GPT partition table on the SD card with:
+
+1. a raw partition starting at 1 MiB holding ``spl/u-boot-spl.bin``, or
+   OpenSBI ``fw_payload.bin`` with the U-Boot payload
+2. a FAT partition holding ``u-boot.itb`` (SPL variant only), the kernel
+   image, the device tree and an ``extlinux/extlinux.conf`` for the standard
+   boot flow
+3. the root file system
+
+For example:
+
+.. code-block:: bash
+
+    sgdisk --clear \
+        --new=1:2048:4095 --change-name=1:spl \
+        --new=2:4096:69631 --typecode=2:0700 --change-name=2:boot \
+        --new=3:69632:0 --typecode=3:8300 --change-name=3:rootfs \
+        /dev/sdX
+    dd if=spl/u-boot-spl.bin of=/dev/sdX1
+    mkfs.vfat /dev/sdX2
+    mount /dev/sdX2 /mnt
+    cp u-boot.itb Image cv64a6-genesys2.dtb /mnt
+    mkdir -p /mnt/extlinux
+
+With the following ``/mnt/extlinux/extlinux.conf``::
+
+    label linux
+        kernel /Image
+        fdt /cv64a6-genesys2.dtb
+        append root=/dev/mmcblk0p3 rootwait console=ttyS0,115200
+
+Booting
+-------
+
+Connect to the Genesys 2 UART at 115200 baud and power on the board. The SPL
+banner is followed by the OpenSBI banner and the U-Boot prompt::
+
+    U-Boot SPL 2026.10 (Nov 01 2026 - 12:00:00 +0000)
+    Trying to boot from MMC1
+
+    OpenSBI v1.9
+    ...
+    U-Boot 2026.10 (Nov 01 2026 - 12:00:00 +0000)
+
+    CPU:   rv64imafdc_zicsr_zifencei
+    Model: OpenHW Group CVA6 cv64a6 on Digilent Genesys 2
+    DRAM:  1 GiB
+    ...
+    =>
diff --git a/doc/board/openhwgroup/index.rst b/doc/board/openhwgroup/index.rst
new file mode 100644
index 000000000..fe70360e1
--- /dev/null
+++ b/doc/board/openhwgroup/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+OpenHW Group
+============
+
+.. toctree::
+   :maxdepth: 2
+
+   cva6_genesys2
-- 
2.43.0

