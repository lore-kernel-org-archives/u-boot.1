Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F460C5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 03:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B604054C;
	Tue, 18 Aug 2026 03:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eE7Fo1MRQtd7; Tue, 18 Aug 2026 03:15:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19AE24062F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787022904;
	bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dCHcdyPDzZ/KBUwHpTUQ/Ky7zsG/qt0omUC+u9BMJ0YAVjQd9dtVzPJaRZVSlgsB5
	 em8qSZByGezYwtFMUhayZ4j2BcMZeHUxrciLm3opXUBnKRg1MUsacbOnZYFbRxSLFe
	 b6PRuhQLhHqHutZfpg/maLEsJKCoNVB2nwrpg/4ENsPhMOW1OuMgnnGFafM3XUE+h/
	 j29zdVktXiPL+pL9gJopPzpbWiamxsjVtSDGPJIUzTtz/sK+KHoZC5RFc0bOJ9dUGg
	 DY+WlTquMyjBop29JgKWI3V0Ah8htc9DOJDxbXMKROxNigzHmC9fsolEnP5FVC/qs2
	 HNZP/qQ0T5Gvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19AE24062F;
	Tue, 18 Aug 2026 03:15:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9FE6322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFFA3607CF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1dbgY1xME0ar for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 03:15:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 992E460763
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 992E460763
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=aTkscGlB
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 992E460763
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlZasTrBHN3nWN80AeJxt/Hrp39AuepTV149hdCo9IbGkwjW079y4xKVjLcHvNBwQ3KebJcfbgcay9AvJLufeCks5VSRGgqAFYwDMLSJmvUh3s6TQ/z43eAQyj4RsT8dDLOu0aQXb6i6GT9YbTXWu+81bnNup4ynYVSxZLH+KQiaYwo2J9Fb2eIBqzS0+34BEFANcxRwIk934bB62h8J/hdQE5sDJYvGQYGEXQGs9lCGHd91oB1kOPqKv6epRa40I0YIlDmP0dlqgKb1bP+JRa5hxjvM3rl03nlshwO75J+3Mj539R4UG5bMow6/wHtu64R2Dn4yMVwrNun6DUdrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
 b=LrtPwPQSNeRGXYspza5JD4Y9hTq3JRurIKHuUScNyazTMeiNI37Vfq3FwUjdgalNaXXzG1HMueMeX2p1WDST/1eDFhUaj17kQ5YiR0nWvShifsdDqrRzZwJg3d/Xd8Ve8ar7UCsvY6PqOy3WUURe/VPZh5QuiYPOmS+oclY3R2dBWZIS9RL2SkundLVx1crkORza972uSFZpyCYMUC0eyFPro7COZ3fqK7VPzj+dqQepmRWrRja4ohdA0fJRciAxwpn00ysULVSHSM+gYxO3I1nzKz1/N+fssYJz1jsIvzQhXb9A7QU4BpeeaDYLjrcea2sML6hsVS48ruu1R1SZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
 b=aTkscGlBJe24WoZT9wgxvSEtKikq+6AWEB+GfDd/2Alz90wmetdkA7HuHGTm/ZzuxkPRPO9qqTiagodvKOCeo7ohzEsDv0zVMTDMNzwcvZjnqon+HVh3/PelvZj4pXQyahkr0NmhqiB+ZF8mY+N7+LCdxOztAvKMoAi0FebdtyeR+Vr5jIvB2Q85ZJ840LEZzgrB/+TqLQd0jmXLSl2la/tMAaddRrfoarBeQa0wOech3SpJLxGLt5L4R+qeBmOleg4vpjpRCa371XTeWn6j1y47SgaGxL0OM/YcaaO+uhcDoVTjiNyZZ8dcYN45Jnvi2EcaRb1RY8fv7mYkHbEYsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI2PR04MB10113.eurprd04.prod.outlook.com (2603:10a6:800:230::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:14:58 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 03:14:58 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 18 Aug 2026 11:18:48 +0800
Subject: [PATCH v4 1/3] net: fsl_enetc_xpcs_phy: Extract common PMA MMD
 init sequence into helper function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-imx95-v1-1-12ef3eea3943@nxp.com>
References: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
In-Reply-To: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:295::7) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI2PR04MB10113:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c97899f-8210-4afa-7382-08defcd6e286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 9puIs5rpnJP1Wp1C0JYi46fgqCRdyE6MynpEcijDgVeBsH4g2bzj2RtFEz9xC5bKcuJxDRAd3gnR3NsWgtlPrNiNaBiTNwde25WB3h/6gXrNnzbaZumCPpTbJxEV7rqnAepBDIXNRb5Vmu22uHBWFV8WJtgAxiCeCtgWY28QIIZBuSyDwOUC6mTS6U7b+lhjXfZIkoKdfVlZ5r1PP/EiYWIKcZvUjoqO5+xrNxdRoWyx4agGQ4ATaKU0LUZen8PnzmklKwO4yeHmqSIxB9+9yneDLK8kapjA/4TReO6X0IDtDrny8MtHNjs/jOZpKavuJmVmnULxJBDHKe3gch9rPuLxBfk+An3SWmRwxgX7TznlUc3vGp3hvpgBQUHbAKKBmjMhwHO4E/U8ZzxDS/h3Z4AZr7HtzJeVIeZkQT6/iyGeY4OhUJnAGFeeTB6f1eC+v/3zFgPLYxNqXK/9IXHkyRETHMLPhCuAtbEbNSGgITiv2Riq3e5tOCfJ9YSTyqt5xocKDTRU4X37fV+lsRmgG/un+1zLoXbit0PwjFNbsqU+HSlg9uhKbH/+4E1iSi011FArEZWKUxsQUs1XUsRuMVxBqkNDEfFBgVo7opwCa4xCkUera3dB3vnx7Ngo3+J8pMHRGjZvrv2fRbSJ8s7kzEHS2KetZw1wFD/VsW7tkVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBGWjU4akd2N1o3b3orYTlmUGVFdlhFclo5R0hXZEVCNWsrR2gyMnl4L1N1?=
 =?utf-8?B?Uko1WWpKclFjaGVKWkx6L01wTEU0TjVsNG9NUVNOQ05iUTNmNkFoM3J1TUti?=
 =?utf-8?B?TWJ5SERlcERhYjh3cUk5YzVqSVhha0FUcnBpN0txTFdjYWJ0cVloYnNwMkl0?=
 =?utf-8?B?M0xsQTV0Y2VJemw3OUs4YlN5eEw5RjRDdVgrYS8rZys0WmF5UVJaeXEzL1RG?=
 =?utf-8?B?cHFHN1M0bmptMkQ4aCt1VWdtOGZJSHR3WE9GTCtielVmTnJiTS9hSDA4K1Ft?=
 =?utf-8?B?UUxMRHF2eit6b2ZYejBWb3JmOGo5bUNiK1BBMEhMRHNMQkh6ZEV2SGE3SWJ1?=
 =?utf-8?B?T1djWk8vMVVVYkkwK0xQY2tWclJsalpienB3dEhCNS9kNVE1TFNDZnI1cE0w?=
 =?utf-8?B?MW1kMzFJYWE4dVZ3Zk9yNE10L0s2Q0lqdU5wSzArWFRuT1VtVTdIL2p3SE5m?=
 =?utf-8?B?U0FFOXAvaUhYTGVHNXhsZW5MUitYRjBGSXdEM3QwUFJWRUwxMjJGeCtyTjVZ?=
 =?utf-8?B?V3VMYXVEOTBzc3R6SWN2dFpzalhxczc4SStHTmF3SzJTYjFoNHFPcThHOElS?=
 =?utf-8?B?RnVueXBWcEN2QUJTekVtaE15ZS9FcWN4dHdGaEx4RzNKT1VmeUxFUEx5SXJk?=
 =?utf-8?B?UVZaSXA5UHhxZGNxb1lRYXZIZzZEb2tOOVFwc2ppZ3dnemZGemJBT3ZGME5v?=
 =?utf-8?B?bnphN3ZTL3dEb1hiQTdQRVY2aW4rRk9iNElXM1ROZ0pSYUgyL1pDa0VsY0V6?=
 =?utf-8?B?V2RGckNTK21UNHFBVVNTYTNHYU80UXVnSGZtZm43YlN3ejlNY3dtUE1RMTFl?=
 =?utf-8?B?ejdZNk1BUlcyWGEwTm4vdXhkQU4wRDJvaEdsek1BcWdJQ0h3WFZhNXhBWXdB?=
 =?utf-8?B?K2JyNEZ5dnc3TmpTc2xSYUFmV0ZvVEdLS0NjaDhCR0hESUlTb2xZRzZNaWxy?=
 =?utf-8?B?NURlZ3Q0YjZCcHJjUVcvdVFXMGowVTlkZTZuZnY1Zk82SU42dUdxREN1MjJB?=
 =?utf-8?B?QlQwVVNBQkU1dllZd1JPdk5zdEVpb1BGN1FLUjBFN1BtUUZrakFuUXpTS0hE?=
 =?utf-8?B?aXZtb0JIQWdFSlptSURZb1hNUHJsb0tvWGZuSkpXTlNlelRVd3NYKzJuTFFz?=
 =?utf-8?B?VVpZQjhZbCtacDd1V3ArUWpiZE9kR2E4OHM2N2NUc3dqbVpNSkNvWDh1Y1hZ?=
 =?utf-8?B?Ti9Nem5sbEFZektPS1A0ZGdpdDBSRWpIaHJOUHcvWjVLZkFwcDZvdEFGbkdx?=
 =?utf-8?B?VVZ6b1lGZDBLSFY1VW1yZDNZalVzT2FKbEZldGY1aVBGSW50Rk4wRUlCd2FD?=
 =?utf-8?B?THpjbjZKalNNNE5ya0lXaEREOEo1N2s1a3hQWitnSlhtWGxtUm9wL1IrNDk5?=
 =?utf-8?B?ZnF1bkxPaGhUVFQ0QXdVbXduVUJTVTVFbnJQdjFHYnpmcXVORWZYY01kcFpX?=
 =?utf-8?B?UzJBQTlPMkpzSGd1VEx1SElzbDhzMEJkeTUzWmpQQW1PUVBDNTJ5ckMzbkdi?=
 =?utf-8?B?QmFWNXRucEU3R0EyVkxJWGsycHR3QW81RGJFUUVyUVB6VStPR1htSitVU29m?=
 =?utf-8?B?MDNBZWQyMStHWUdta25nUHkwWjZnY3JqTjdKOHNMVGJtOXdYeFlBQzZ2bU0w?=
 =?utf-8?B?Z3o3bkpDaHN2ZHdjd0VWdjB2Zm9Ec3dvNVA0d080bk1PYnIyMEs2blFlaTNY?=
 =?utf-8?B?R0xobHV6SXl2ZngyZUgyM2ZnTGdlbjVMSkZxSk93N3lWa0pyMVJzdTJZdm9k?=
 =?utf-8?B?UlNrODJjbUVBZTlFZWo0Ym5jTmgyWmVSbmExZ1NkalRWR3NxVmI3b3c2RnFX?=
 =?utf-8?B?RXVkK2s2dlduQVhnMDU1Ui9xYTlPTjdUdklJYURVNjZuQmVaZ1J2dkdxY3JG?=
 =?utf-8?B?NG1ha1hRVzNZUkxEWFY4eDYwRlVKRjltNnJPSnpkZTJSaTRJcTZ6MUNwTnA0?=
 =?utf-8?B?bk13VWIzc3BNSWFHZm91dkp3OHFIVzlUWGo5MXFRYm8rK3VQbmQ0T0pFRFdt?=
 =?utf-8?B?cHN6cGZveXUyZStJQmRZQW5xRTVBQ1ZSK1MyNHhSZUpxbW1aV3FaTnJHWWxv?=
 =?utf-8?B?K3lNOUx0UEVhSjVPSUFQU1ZxcXl4TVFVZ0lQSzgySzQ0Nm5rZXlOZkR3K2h1?=
 =?utf-8?B?UzM0dUhZSk9mNXRtTHJ5aDZ6clBRMnh4TVBpbGhaT1FGLzNTbHdzdzVvNU9a?=
 =?utf-8?B?WkZ3TW5jNTJvT3dwNUNrUXBIVS9raklkRnBQdmVtZUl6NWR2cXVqSkdYbkw3?=
 =?utf-8?B?Y25iYXdSdGtFQlJselBYcTZVZVJvR3pQdkJZbGRpbWVLZmtKUVl0T0paU1ZM?=
 =?utf-8?B?R1ArODIvWU9UVDhHUGZMcGRRUzBPZnAvVW5LaFlGZkFqMTFCcHVIZXBEOXR3?=
 =?utf-8?Q?CO66hyYngih2eeASs3vdn1iQ1fbST9T2T3C42?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c97899f-8210-4afa-7382-08defcd6e286
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:14:58.7943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3NCOfw3bT8R3+i3XTZlODb3LOvgqqg+P+Z7byYJj4reY7/D3yrFLOseQ8Gq+WZkKit0ALT1QpSlGIS8HwC35K5PhKMAj8eTN+2opsEqNr4xS0URiORZV+/ChqytwjKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10113
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alice Guo <alice.guo@nxp.com>

Extract steps 1.6-1.13 of PMA MMD initialization from
xpcs_phy_usxgmii_pma_config() into xpcs_phy_common_init_seq_1() to
improve code reusability.

No functional changes.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 179 +++++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 82 deletions(-)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 4039690223d..006a2bd2238 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -261,6 +261,99 @@ int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
 }
 
+static int xpcs_phy_common_init_seq_1(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 1.6 Turn off C37 auto-negotiation */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* 1.7 Assert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.8 Wait for more than 1us */
+	udelay(5);
+
+	/* 1.9 Deassert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.10 Power down MPLL */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* 1.11 Change RX0 power state to P2 */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 1.12 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 1.13 Poll for acknlowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
 int xpcs_phy_usxgmii_init_seq_2(struct udevice *dev)
 {
 	ulong begin;
@@ -436,93 +529,15 @@ timeout:
 
 int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
+	int ret;
 	ulong begin;
 	u16 val;
 
 	xpcs_phy_reg_lock(dev);
 
-	/* 1.6 Turn off C37 auto-negotiation */
-	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
-	val &= ~MII_CTRL_AN_ENABLE;
-	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
-
-	/* 1.7 Assert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val |= PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val |= PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.8 Wait for more than 1us */
-	udelay(5);
-
-	/* 1.9 Deassert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.10 Power down MPLLA */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
-	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	/* 1.11 Change RX0 power state to P2 */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
-	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
-
-	/* TODO: check if it is needed */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	/* 1.12 Assert request of transmit and receive */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-	val |= PMA_TX_GENCTRL2_TX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-	val |= PMA_RX_GENCTRL2_RX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
-
-	/* 1.13 Poll for acknlowledge */
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
-
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		goto timeout;
 
 	/* 2 Config MPLL for 10G XGMII */
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);

-- 
2.34.1

