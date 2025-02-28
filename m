Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4D4C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032F3811C5;
	Fri, 28 Feb 2025 11:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VhjzY3cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530878141A; Fri, 28 Feb 2025 11:55:46 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09837812BF
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab/I0znJLKFOMssplb8/qNP+u1tEgd26OPtpmoInJsqu0F4vty9plUIK0oJzd5GD/iCtHeZXFYZmsUU50g9svvQLVv4sKUMfRk+HcfqTVpNiPEk/GzfOOpYtqpN8UEBZ51Zxtih5cvbi1uHv+Ea3xGPHoeFIgyY/IwUJpteW6HC+RVW9iLNAO1w8V310yL0ln1Z+7yxcsh+i7pKH2LktiKZkkyCus0yT4xPvQhkMRb8qySMu7eP/2jVSJbIp256/xYb38HS2jKY8TNd93r2TRS/X7Sa5TG8YNL8iDdfGtrvo8OThFubjspLvakEocnJSmmuk/a07cDuRmkaHI2M19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xi8MuDhLGVFg0JiponF+k0w004M87lfioaslT3yRK4=;
 b=GL/0W9kH1HEB1i1h0zrJaWA55pvkJF6L3Lq5OpQ7uShSai+vKx1fzUOMcrlxiesLB2FqOh5r2RTB8dwg2nl+ccAKEVUKCQxeWmfSNbqGBsTV4LjkRjV5oGXxYOS6s1avAzeqheD1fXr8ByQfGi87hhNRuFj5DHx8uoVfd6X7PIScJ3TLAKk3ls0bUvOQ/K54cgLHJtdGYlUIffGvXSqqHhs6qNpSDRBs9M1tlZlHoIYBNbFrUuIGeGx2fydQCn1x6zcvV1iojAMR8xQmrsgouybY/5dz5gkk4dUKDvRIWz3SxE+YZl0wEut4vtHWKg0sPPaakiSzXi6zw06NPf/wsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xi8MuDhLGVFg0JiponF+k0w004M87lfioaslT3yRK4=;
 b=VhjzY3cmaDGNe9wmDU68vMd69/YS4+MX00ibV6e55vBzaQldmPvD+qwjL5Kmi82gkD72WN5g1M/yEnOKyWMFm28RGQPpjQYQxYy4sXmpPrJSi0sCJJplTrcQXcKDlmufqlgKaegxhAVRJDBlbjI98/nTzeqNE+OX6zoVpYrb7I9xPGXdCAsByBsqUvt7zHxKCWh0zerRAAoReIbKH5+QrvRhr4FtUwrvr9YZx8STgS0KKLThGV359opVWQ2O5Ym1NsD9F8QFsfvAAEyjpk81UY+3AAmBA3Cb89WbIoIz2WtBqe9JN6qz1H+tMxsPDaLJv1jIwX4N7r+sS+c4XXKFAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:07 +0800
Subject: [PATCH v6 16/20] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-16-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: e72ff0f1-b6b6-4251-9b56-08dd57e6705d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVZ0ZU9uUllxdkNSQVJJV3NQUFBIbGRhZE8reWRIUHMrUVp3ZDJialQvL3pG?=
 =?utf-8?B?bVJvNURXblZBbjFqbkhsbmxoVFNHSXE1dm1lblR4ZSszQlRCRTVZV2ZlY0h0?=
 =?utf-8?B?NXZ5NU5xcXg5Z1Z3WUJ1TGpHcWNXM0JkVDNBdjRMVWJoa3pYZTYwM1diam1O?=
 =?utf-8?B?K1hRQzF5ZklHczhSaytXUUtlQmU2cEE5UUhuUHBQNUpCblVYa0FnWk1oWmhk?=
 =?utf-8?B?UHFXa1RJb1VabkN6bmVzaW5vSWxjRktkRUNUR2pTR3VRbXFiZitqcit5cGMr?=
 =?utf-8?B?UVI0YWhKR0NsSFRtcUIza0xLSlVVY1JvMG9wVzZ6WHAxUUgvcE9ONEZ3NmlB?=
 =?utf-8?B?dHFwMTVISGVDWDRDL0R4dG03OUV5a2RUZFdDNC9ZWTh1SHpGWjlQSGdwWGJ5?=
 =?utf-8?B?dERIalhTT2JMT0o1NWZWeVBpNEF6MWI1dCtrZTkwWUg0T0thNE9VQ2ZhdEJR?=
 =?utf-8?B?WHZxeE94K01JaWJXVTdrZzBKTXVLMjR5cnp3ZFVHWms1ZVZnU3RNV1ZYWlhK?=
 =?utf-8?B?c0FNNDQrbnpDTUxlL1oyb3VGVWw4TVEyYWZZWDFVRTFaTjdOYzRjU3cxdmtu?=
 =?utf-8?B?TEdObEtCTkhxVXVlUUE3WWtUM1JSeDFzL21ydEw2cmRWZldPbVR5ZTA0TVNh?=
 =?utf-8?B?MDNIVlpxL0RqRUVmb2YwZGJCTkFkMjhQMkVram5pek8wb2wwYUxPRDE3RlVC?=
 =?utf-8?B?WCtIYjNxY3pDRm1Wa0RZZXZUcnc2MDVwL1BOVE16UW1DU05JT3JFRTh3VnJ3?=
 =?utf-8?B?YUJWeTJpT1pld2FzSHNSS1lXN0toSWR5YW5aTy95UnZxcExBYVY0L09HWHlq?=
 =?utf-8?B?dHo0WVZYQVR0cU41MFFDSjJpQjA5LzMydm53WWQrbTlkcVhrVTdNTTRtdzJL?=
 =?utf-8?B?UmxGVHIxMjV0R3Z2czluOXhIM0ZKZTV0RmFoWjNtc1JjUUw3bzNuTjltYkpu?=
 =?utf-8?B?dlRwOUgrc25wNURRNFBrcmVlT0Z3TkpTeUIyNGZNZDJPUE51RGduWm94enRE?=
 =?utf-8?B?d1BwWnVUa3FKTVlpMTAzRyt2Q2VOVWtTOFlXSW4zeXZ6TFArVlpVb1N5d1lY?=
 =?utf-8?B?M0xIcXVSRzBTY3lCYWtrMVkvUmwxdjlEMU1RZFVXTE0vZXNJUmNtL083a0hw?=
 =?utf-8?B?aVplMVhSWUFiTUxvT283VmE2WWo5NnNXUDZLeE13REtYRVVyS05qYTJqWENE?=
 =?utf-8?B?VXRxQllvUVVEVUV2Z3k0YXVBMlUvWXVhcEVIZWNnODA2Y2tBR05VK0lWYjJG?=
 =?utf-8?B?dURVcmJmbkFVS1VFSUk2WU92a0Z4VmYyakxLYm1sSDNQT3NuSUwxUVFmZUdx?=
 =?utf-8?B?a2l0Vkd3R0VwRVdDcnNsQmFBanFJQVdMcE81VmcvSmQ3RXBsczkzbE9aQUYy?=
 =?utf-8?B?Z1g4ZVB4SnVLR1o0TXMwNGJoUXdYQ25VU3RvQmxzRk1Ed20zYXp0WE03MFdm?=
 =?utf-8?B?QXJ6NWkwVlNQZzU3bGJWbFpvdDlENFBmUFdGYjBFRW9sMzVHalNVVERIYUwr?=
 =?utf-8?B?cXJUTHF2UkU0bitQS3plRVlDTFZHZVhNVkJIbS90QXhXbTZLNk8xaGVUNGVh?=
 =?utf-8?B?Z2h2Z2FEUG1RanFiQ3NqV2dRUGdqWkFaRzRWdHFPQkpZc3ZDL3dPanFHQ2lX?=
 =?utf-8?B?ZjBPNjV5WTZCMFR1NGVhc2tuYWI5SUpreWJSelRXenZtZFl3NkJLNStWUlVx?=
 =?utf-8?B?aFpUN3N3cTJsMEJTaHBvNHRLb252MzAvZlFuSkV6Q1NKM2R1SUJ4bEtQWFlP?=
 =?utf-8?B?cFdDZ2ZodnlTcTUxOEFKaDA1YkRxTlJwdnBLYmJVbkpaaERLL3NsaVRlQXhL?=
 =?utf-8?B?NmpHYWFzWGFoallmemRDeHN0Z2g0NlNrL2NzM08wTElORXk3dHM0OVhvYWli?=
 =?utf-8?B?UWU5NThHTDhkYTcxM1BvdzlMS1VPQjQzbVUveUlhVEt3MDM4dHBzYXlLRFpQ?=
 =?utf-8?B?OXNCUTg0MUppYnE5SjkrN0VvL3VIWUM4RUJMbStadTl5UDZFUW1Tc3BSZnlF?=
 =?utf-8?B?bTlNSWpkQVRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk94bW5VdUs5WS9aY2d2eE54NFdmbzMzQ1kzMjc3OXlyNjhkV09pUFpKc2lK?=
 =?utf-8?B?ZzJONnRQL2orL2t1VW5qY1ltdFZOaWpRQTBHbHVOQktiWTZXeER0cWxYT3pZ?=
 =?utf-8?B?bTV6bUtUT1g4bitlL29wd1ZIdDgvNzFkNjRSN2paRkkwUmJHR1VuZC9MQzNw?=
 =?utf-8?B?c2pUV00yMDgvL2FIdzlFaUlXL0c0VFdsaG5JM01KUUFBeFF5bXAyNCtSNzRy?=
 =?utf-8?B?RkVCM0IxbXo0TTZmK0x0QjBJZDgrSVhOMExxcjRVeUlnVkRGK0lEdGlYTEZK?=
 =?utf-8?B?MnhvMG5NRnY1bVJpWkRLcWF3aU9kUWdaUE0zOEtDaEprejljcHRVak1sWVBS?=
 =?utf-8?B?dGtrMG9jcHhmakdsL1lDaE8rM0o0cjg0T2JTbW1RbXhNNk1JZmkrS3ZsMTBl?=
 =?utf-8?B?cFVKaGRwTm9ET1J4MG83SVZ6aTBvVGlPQ01BdkVNMjBLRjhoQ3l5UU9GdHMy?=
 =?utf-8?B?NnViRWZWZ0IrRExDSkd2WlFwZjdCYy8xOGhkaW5HOWw3LzB2dThSUXZyMG5J?=
 =?utf-8?B?WFBTTWhkZzNLamZpZ1FBRlN1MU91bFl5SVZkMlhqRnQ0U0FsTXNSSVhDdEVo?=
 =?utf-8?B?QVIwOHk0bkpSRmxseU9XOGpVdEo1dDJZK3lHOVdMMWpjbm5UUHZZdUhDRnFM?=
 =?utf-8?B?REc3WFVyVmJTM2dXbzUyZUVWUUgybldXNnlMNWRWUHdFSjF3ckVVa1psS1FW?=
 =?utf-8?B?WWRwTjIwTlJWUzJscVVtSy8rU2l4a2UxUFJzeVNXVThpUEdPaERJRGFReEFE?=
 =?utf-8?B?aEtIalVHbHVGQy9BMXoyWktDSjNsT1BXUzlCWW1pU21sL2ZPSEpDUGt2SHZw?=
 =?utf-8?B?dGx3YnBuMFRBMFRWbHpGSXRkeFZZaVQ3QWtyd3pYN2pKVmY1bzI0UDFIU0tt?=
 =?utf-8?B?ZGJTZHNTYU85aXFFTW0xZWx1QmRTOEdDYUtoVWhGeHhNR2xKejVSRS8zMGp5?=
 =?utf-8?B?bHBVRGh6SlFtanZidVdWS3NxZVE1WHFRS0ZmWUt4U2RRekMzWi9qVXo3c3I1?=
 =?utf-8?B?VVloMUpocGVCWEhtYjRRUU9xZUwzSTd3R21UUXI4ODdiOEdQcjZiYWVIazcx?=
 =?utf-8?B?Nm8xRnN3YkNKQlpXVnljcTdCaWcyN0wxMjdCbER0ZDBReFdMeFZWSHN1MFpm?=
 =?utf-8?B?d1QvRjkzbG1lYVV3SEhPZy9OTklmNy9Ia2U3WlVkYTJmd1pwMS9RS0o0TU9Q?=
 =?utf-8?B?eThGWVNvKzZ2cFBBOXZXMnk2R3VXemZ1bExUL3BMeEdQenV4SGx1K3U0Qm5U?=
 =?utf-8?B?RTEwRmhkQUtlWkRDVjNwM2ljempmWWFvL2NjdkxWa3ZEclB6NVNtbUxpVjFU?=
 =?utf-8?B?WVJ3Mkg0N0JZOUV6Mjc0YkphWHRuQllwV3VlZWFVdGNwczdxOWhNbG40cWRO?=
 =?utf-8?B?WXRtcXNNMjdLY0tIMk9Sb2pNQXVock5iL0plbjFxdGxDVHpIZ0xTclJxMlhh?=
 =?utf-8?B?a1hDZkt1ZjJJUjBFS1gyZUVhNXh3Vko0cGtKSlhjRCtEL2JzYzZRUnA2dW1p?=
 =?utf-8?B?dGIveHJmM0hzdlkvUEJ4bG5jb1V4STdoZlJQcXNScDZuVFc2eEhrZnFZbUUz?=
 =?utf-8?B?WWJ2Umx2Ty9VWnlzdTVtSFRtQXl4Rm1wV0JwcVBwaTVrbGRkYlZYT01kNzV5?=
 =?utf-8?B?bDB2M1BqK3FCTUlWcDZYRmpyZ3JUU2ozZDYyMGFjdXczNHE3VkljeTJWcStT?=
 =?utf-8?B?SE1sbHp4V0xhbk4rcWhQMDJGbG1LM0k0NUphYWc0S2xHUUpTczYyVVAvUDR3?=
 =?utf-8?B?S2dvZWNRd0hpTVJuaHorVEtsd3U0M0M3QmltTWs1Z0Z1RzJsNUl2czNmZ0gy?=
 =?utf-8?B?bGhFWVBXM09KSTlOSnZrd0gxYUVmUWVXaUc0Umx4UWRsQXkrdEtneGtaOXpI?=
 =?utf-8?B?VHBjUGNwaE14a2lNbHBKelp5bno3QllnQVlMa3hhTWdTazF2ckN5MFA4Mi9M?=
 =?utf-8?B?bFEwb3Zhb0poL1lmTy94MDV3cFR3Z25pL1VubUxkTHFIbWZSNWlzaFFJdjF2?=
 =?utf-8?B?NHNjQXhVdjVNOFRVaDRZS3M2dk9SSEFNQWhKSWlYQ2pGWEQxcjdsYVFtcSt3?=
 =?utf-8?B?NGlIS0ljelhkYjFaWC9vYmJLSjBsMWx1aDNaaU9vS1YrUTMvcjRtYzlCU3l6?=
 =?utf-8?Q?ABh0gQRKauxLbK5lWCaBzEdcL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72ff0f1-b6b6-4251-9b56-08dd57e6705d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:39.7124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx9TAyI9IpC1XVYGbhTUwxUrSPrpAS2mxwZjNr8Gr5We0gxMq997YRm0k1AFnro25j8/O8zU4iC9IpPcQcPmHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 143 +++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   8 +++
 3 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb5..b48e2b0396 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 15510d3e71..9c4b431745 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
 	{-1,                    "",                     "",	              },
 };
 
@@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
 	{-1,		"",			"",		},
 };
 
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -548,6 +577,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -557,7 +587,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -579,6 +611,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -686,6 +741,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -708,15 +772,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -725,7 +800,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -733,19 +808,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -837,6 +920,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -860,7 +944,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -869,6 +953,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -891,6 +976,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -962,11 +1071,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -979,6 +1092,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -999,7 +1113,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1030,7 +1145,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19..6523d1a0ad 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.43.0

