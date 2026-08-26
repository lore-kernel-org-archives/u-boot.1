Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA6EC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 08:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13EB56072A;
	Wed, 26 Aug 2026 08:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TrJYBj4vXskn; Wed, 26 Aug 2026 08:12:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787731958;
	bh=rS1LcSGo0wyzu0XbYTJhcnoel0UlJFLhq/nflktw+mk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0VDNJGHwNh1SqgPZu+yd9Yz6+wCBECeLGO/p4xmYSEZmbfFE2coZ0GFKxsapmfeLk
	 frsIb/rKwCyyidZ93xRPFZW8+7oGw+4JISlr2gbt+9RCXVNUv7znqxr4pO7fREGiCJ
	 dTstHqnkCMc88pHAplJKW/64NXAP1fYQsGbqDkt4ySRwp/DnQg7Vp6FLYg6t8EehOz
	 PcHbJ1ZOpQg+XddxsDFBm4wu4x4rNfB626j7u0dEoKh0Xdi8F3Jo+10karz9tdGh04
	 jjszvjQGWx/IeXzme1Hpsij0KpD4RYDoSsUgvpbu4PnXYhj6JBEYAB+Soc2arOywkS
	 7+q7Chn4y441g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC28E605F3;
	Wed, 26 Aug 2026 08:12:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFC4B2FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B110C40130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uTwdgKWuv8na for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 08:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=FUXkCjf4
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 281324008B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq1+xEy7Ep7qF/GK8GZoNzbUkdfh1WQQ7kByjaWMvFGd9C5S+sN9idVjVFaSN9Lw8EWznn0Bdvllj7QAlVcTvvs9A2YPh+uGZAdQJ/SBMLQM/eq0/J+Vyk/qJVhaGF/pQGKRJUv+V3hOPrkyBC9mpRnQuIh0GPyZbm6HJsMlPSpBAyHpjcpzVexFVYy32dh/XUNWCDLsZ/E51DuuUckkk30qxoM0y0spvq/ZxCgDW/nNZ7UrINBKxM7tAp15rWM0kpGQHj3ukUIhsIG25kedyf1Wb/qzYJeDodgi/ujP5zVzgu7fCY2LYejjmTJr6pDR61c+Fkasunr/eeD+XYKjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS1LcSGo0wyzu0XbYTJhcnoel0UlJFLhq/nflktw+mk=;
 b=GIn/Ja+Q2XZGCQquG13AI6CeipI/fPy70MrgqN7bGYfxL2dRfz44gM4/IW26Qvkh4Me4qhZnkjgU723e3+yzX+RPAd5wtpYZfV+TSxwblHP6izFw3oN9j+n5hvLSwDDKwoo+BEcNvBqrMlJ+e7bUeHmTnHZN2GtGuZ1cQbkNbBK3jsrlDGsAeT1kFR/2SDNX6bhOjnAfwz8pZXKay6mZSkQtmkGfFGpLf+Vklu9ZVUPW9rSu/DSraLxnMTV/Ylz63iTq9Xx8xcaD71R+IV4F45vSSVCVn/uGWmn7wgqn1Acr6wfyr8M3AXp/l6iFZz2PGP+SPZ9G2c7Gsk2XCzEZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS1LcSGo0wyzu0XbYTJhcnoel0UlJFLhq/nflktw+mk=;
 b=FUXkCjf4zDmceSywpZLN9YlmEg5+3/ODePunHbOBpQguGdynevpBbxbZ/1i2pIgeRDraQur+SEeEgP9q0iQkFjs5Kpw1RRP4b879J+cVnJRatH1QH0ejxEbRbVkhzrSt7leKtNL0BJds897n+cLxoS2/opjxsHwMQpphIQWIi9eXgmFxxGOgRoK20VGM13p1W76fBqvTyLK5688nFRvnndJTFYwhswuRIHWkGiAZIi36WhRM/UC3qe3SsqlQOTTk2sHaXOg3xOFjETNTO8LLVd6r42RjBIIBP/bohSnC9uJdMol11iUEXCd4kcMmUXqohmYoWiLKtCY49YzhR1ZnOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AS8PR10MB6391.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 08:12:28 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:12:28 +0000
Message-ID: <59ed6576-06dd-42bf-8ea2-18de427955a4@kontron.de>
Date: Wed, 26 Aug 2026 10:12:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Marek Vasut <marex@nabladev.com>, Frieder Schrempf <frieder@fris.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
 <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
 <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
 <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
 <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AS8PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6635f7ad-327e-4246-d8f7-08df0349c53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: icYm1RFC/gV+i7IAUaf0sepnJLTpAnrXnkzfwMWWnIyTBlcpOgqsQQWRCpAcWlPC+Cwzppbly/YXSOZhk1HbWhcU2KdvgyaBItEQuzrVtrNKTnijvPNezXEii0QblJeRudSXzXlnhs8fic3/qTijvuHkbVuYYT7BE2zqw+rR1btHf8l+KqCLXQyqgxfbML4JSXiRzDqpxJjAJW5DpGuP1T6nMzW9sbcl/n++m3w8iPdOgVvHhxZxG/NaPSR1Tg2Wjcwga/KvnwrYlwMZhO95gLzav/Asi8FrDxP/vttxu8A5qkZg6wKilajjPoXRFGDdM32uczOf6z0jC8VaVcUsc9/AVJOgPXoprgxZJ748/R1hbA2wfFdVD64qOlzgZOjh991c02dxLvDY04cLQklfWu8LuWJzNUvoBSgKTpMJNg8dwj5BQ6JTFNtp5L/ISqPO9PwWRArMiZsBR+kEb+ymPEei25uGNi7rp/oWBAcA1yYqpKkOhKcz9WuxFyvKjSZSP3AdG7GK79PQcFUM82Y+2IURJQ2KvZlZBWdc+YzruINbWui8CBR96y5fkdaaxFW9R+1Esox1bkIgFcNL3JkqV6XN0lsDfGOsmyLiLYc1piartB1276Ud9Wl19USEodhNj4jAEVNLG+sCv4ry/NT5d0UnBBeVCTJM3IDIST/sxeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THoreVE3dTVPUmY5Q0lheTR2VDdDWE53NWlIRHpmNVdITE1UcVhFMDVUK0Zp?=
 =?utf-8?B?N3dEcUt1ZmYwU1dNRkszZ1NtVS9PNG1jczIwcHBEYTFUK3VEaysxK2YvOWRH?=
 =?utf-8?B?VjBUSnV0dmdyWUgxbFIyOW9nek9qdEZEbVE1bXJuOUlIMlF1c2hwaVFIWUJm?=
 =?utf-8?B?aE1OQnY4dEQ1Uk9UOE9mVEUyRzNsVjBlRkw2SGtqTjJvRDEvREVORFJGZWVl?=
 =?utf-8?B?Yjk5OGRaSTBHZVRKVVhXdDJSOThXNkR2NHRLR0xFbHdUTFdYMDIxN0hBYUtD?=
 =?utf-8?B?V1J2a3Vaemt6WGk4Ykk1UnMxTHNyVEtCU3l1MlhDb1JUbEZrcE9VMUZZbzhH?=
 =?utf-8?B?dWtCRVdYTHZZMi9jcGE1Njd2TjJHS3NWTG8zYm55UUtCam5nTFZrY09qZ2hE?=
 =?utf-8?B?UU9UeDVJcytiV2RMSythWmhMQ1dha0pnWkh2S0RJQnI4elFPbHZEeGJCSVJu?=
 =?utf-8?B?dzRkWXVKczBnSG5hbGdVTUthUHhnNWRsUnNWQm9XRHI4M3J5czhIMHphdkdL?=
 =?utf-8?B?RGs4SmdMNmpJS2hzamFKdUo5eXBTL25URml3eHhzMXdEZURPRXErT1R3aGJq?=
 =?utf-8?B?VVhIdGFPZGNndGw5ZDNaV1Y3bTdUWHZNcW8rVitFZEJGQ3BpcFZaSDY2eUl2?=
 =?utf-8?B?aG10akVFK2dIcVJQR2o4UVNadXlFRUx6Nkh1UEVKN2Q2OG9UL1lraXZ2ak1x?=
 =?utf-8?B?eVFTeCtHZDA2SUR1WUFDRzlXYUtCQ2FmZ052ckh6UW8waXFmaTNDcEFIRGlW?=
 =?utf-8?B?Z0I3WGw3Qmc0OEdtenBrb0U1YWZ1Tm55bnhCREhRdzd1MUdxWkUvYkxZNjdJ?=
 =?utf-8?B?WlF5YzltT1BMMEZ5TGNLSElGRGhjcFFwL3lETkFJU2wyeHErd0dzUlJabTVS?=
 =?utf-8?B?RzFOUGpVOVVXM1kyQS9GZWxjRVNmTHJoRk5MSU54c01ua2E3Z1Y5bldwVEtF?=
 =?utf-8?B?Q1piODV4Z2ZqTE9veFQxZ0E3MlA4b1hRQmVueEpwZjdONmY0MnNva09sWEc2?=
 =?utf-8?B?UnBrZkxSSzVhN29HSGdTU1R4WTRjdTNmeUdUQTMvTU1rdEZiQ2dhYm5yNDVq?=
 =?utf-8?B?WWpBd0d2U2R1Y3g4QVgxWWlyVFVXWjN2aDY0azZGVi9FR3Z5ZktQTWlUbUNI?=
 =?utf-8?B?MldPcVZ1NDZVU3JvZXZwcWovZDV6cXFiMWtrbEhGZ1QxWVVFUlBicDAvS3k4?=
 =?utf-8?B?UGV2am5JT25iMGlXcG1nVFNVYUxDNlM3ZlVMMmRaUHBSVU96TnhYNjhKUnNK?=
 =?utf-8?B?QlQ0bUJGekoyVnRLUTBWaE9HdFhCd1JFYzYyKzRnOEg4akZaaUsrNGdFYlNN?=
 =?utf-8?B?Slc3TjAxZ3kwWEF5OVJqeUpaZGtpL1hRYnhFUTFpcDRQd29WNy95eXN0ZXFI?=
 =?utf-8?B?aVdGUE0xR28rT1ByTEY5ZGY5cTVkSXZOU1FJTG9jMjZnbjJnSVNGMG1FNVlo?=
 =?utf-8?B?TU16emErNFlISUJOYUNpdG9BTmNneUoxUGpWcVFwSmNGVnFCbzY2M1piOXUv?=
 =?utf-8?B?T3JtSDdqNTBKSjdKSTdiVFhULzNaa1hNWWFTT3Z5M2FLR1AyK21TdXVuWEFN?=
 =?utf-8?B?T0RJdzArVlVQVGxhTGRTNWNEcnFhRVU1ZTdNdnR5L3JJUjhTUStYSlpuZGlj?=
 =?utf-8?B?UkhVY2krNDdkK3FGTFo0S0VsSHRhNzNPS2tNUm15eEdUL00zSDVFVFd6ekpV?=
 =?utf-8?B?aWU0RW43MHVoeVpmOTBJTXROVkUxc1U5Yk1NSzgzLzA3V3VZcHJqQW9yTXVj?=
 =?utf-8?B?YXAwbWxGSUpMUnNMT2lSZjJvU2d2M3IyK0J3UVVwNVhUdDNBTUxQZ2dRd0Vv?=
 =?utf-8?B?RGJScnA2cHRhMFBBZXNFZmxMYlFYNzRqNkZrVE95K1hpVE0xVzRMTGFNTS85?=
 =?utf-8?B?NU1RMnUyT3B4VkV6Z3N5TGdpbFVVM2FYTkpIUWRiQ1lJdHJvdSt6Mlp3YWM1?=
 =?utf-8?B?RWlzZmozdnc5LzhTV2pDL3ZiMzVNRnRXMm5XeHFYWFpGcDZrL3piZ3FwRUtj?=
 =?utf-8?B?Z2c4NWt1S1RlUUZWekE2c1VRYXdqTE52Rk11R01OTm9hRnB2eEo4WlBXS3d1?=
 =?utf-8?B?Nm13S0pURTZRbUYrbnBiR3dVZ0E2ZnF4b0JacmRZTUxWUVRzRDYwdnEwblF6?=
 =?utf-8?B?KzM1T2RYMXVvRmF4SnhnemsreXpIaWZQcUV1YkRWVkt1SGtLWUQ1alcyOS9n?=
 =?utf-8?B?NDRQbVlZaENENHFJSHhiTjAyWjk2OWxCNkFuUGxTVVlMQ2E5L0JqaVJUVHk0?=
 =?utf-8?B?VnBEVWwrMThucWUyUklaejBMbC9taFdmVTh0ZHdzSjdHMkN0Nk5UR0RkT2hv?=
 =?utf-8?B?WTA2ZGpDaFFqVVVYMlRNd2gvNkhtQmErd2ZyWTN3R2lkZkxrUHU4NDExN1hi?=
 =?utf-8?Q?/6fKRKuOU0+9XJv8=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6635f7ad-327e-4246-d8f7-08df0349c53a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:12:28.7503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5c1+X46ZO60P3Ti59s9GVbcKsXmnR5hOvsSpGj/S/KX2JpFmq/yyhKa2tbgennhd6CWG9z+ReGqfKvr99lN8XSHDVtjuySCldNYkds+Ymc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6391
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

On 20.08.26 17:25, Marek Vasut wrote:
> On 8/20/26 4:25 PM, Frieder Schrempf wrote:
>> On 20.08.26 10:05, Marek Vasut wrote:
>>> On 8/20/26 8:34 AM, Frieder Schrempf wrote:
>>>> On 19.08.26 14:47, Marek Vasut wrote:
>>>>> On 8/19/26 12:10 PM, Frieder Schrempf wrote:
>>>>>> On 19.08.26 12:04, Marek Vasut wrote:
>>>>>>> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>>>>>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>>>>>
>>>>>>>> In some cases we need to call ddr_init() multiple times to try
>>>>>>>> different configurations.
>>>>>>>
>>>>>>> What different configurations ? Details please ?
>>>>>>
>>>>>> The detection of different DDR types/sizes on our SoMs has always
>>>>>> been
>>>>>> based on trying the init and seeing if it succeeds, falling back
>>>>>> to the
>>>>>> smaller sizes on failure. See here [1].
>>>>> Could you maybe bring the interface up in some minimal 400 MTps or 100
>>>>> MTps configuration and then read out the MR ID registers from the DRAM
>>>>> to discern which DRAM configuration is present on your SoM? This would
>>>>> be the ideal generic way of doing this, and it would be reliable since
>>>>> the IDs are stable and surely indicate which DRAM chip and how big it
>>>>> is.
>>>>
>>>> No, unfortunately this doesn't work. We already tried. The MR ID can't
>>>> be used as we have single and dual rank setups that report the same ID.
>>>> We have no way of knowing how many dies are connected unless we try it.
>>>
>>> Is the controller unable to interact with each rank separately ? I would
>>> expect in single rank setup, that read of MR ID from one rank would pass
>>> and from the other rank it would fail ?
>>
>> I'm not sure, but even if it would work, it would require several
>> separate init attempts only to read the IDs
> 
> Why ? Init the bus in slowest mode with widest bus settings, then try
> MRRD on all available DRAM chips, then figure out which ones report
> valid IDs and which ones fail the MRd .

As far as I can see this doesn't work. If we use the widest bus setting
(CsPresent=0x3) on a single rank module, the training fails and the DDR
remains in a state where the MR read doesn't work yet.

So, actually the training failure is what already tells us that there is
a single rank DDR and that's exactly what our current code does: first
init with the dual rank config and if that fails, fall back to single rank.

> 
>> , so I'm not sure if there is
>> any benefit.
> 
> Generic solution that surely works and does not guess the DRAM size.
> 
>> Also I'm not seeing anyone doing this kind of thing. It
>> might be worth looking at, but my primary goal now is to land patch 1 of
>> this series in order to fix the regression.
> 
> What regression ? (I was not CCed on that)
> 
> You can (=should) send bugfixes separately.

Right, I dropped everything but the bugfix in v3 and will continue this
separately.

