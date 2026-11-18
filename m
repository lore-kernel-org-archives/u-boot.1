Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D23606A32F
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S+ZebFba;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MYyUl+V0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4030A81091;
	Wed, 18 Nov 2026 05:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sLlr2VbzDRr4; Wed, 18 Nov 2026 05:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F8F081083
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794978975;
	b=laczLuFz9EZyAOPzklofpAVoozMD23Wh54Bd8UpRC98O8X8D4moXhOrE5o90OMl4HKAf
	 WDjIeiQcaZRHn9oSSSnETbnmsVd37KiVdBBIAJAI+RahyRwrxYBLkiJQyEiMOKmOkLg92
	 Yb0GOfMNY3P3WcmCZJxkhwqBnWukYFLHjEdFYxeYxHRrhv1KOCrKun6Eo68WY5WQ2kc/C
	 n6Ea1pBldF1WrT0llB02zxG0Cl6+9JzWzfWjCzRv2ld9U6KP1akzhQMQUqJxqijn7yKZX
	 hs5eHkCcaCdHqSwkkLLCy9i0totKZd4kmUomVwxrFQSV6FArrrMJJHiH4CiXmcAXfrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794978975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ukWNkcNzEHPveo5aPJqxeLVx4NzUHljEIFtvUCMkIAM=;
	b=JsHZ+ZIAGqTKY4KuI+pTW7Q+WMMPpYUk3+1e2ZU7nCG3jF4Uqb2HaX8GpAI/zmMisKBS
	 hJWbJxruqYUW4LYgBNQ6p6Dn+a55AO6mtsDuXtq4iURhr0EWn5QJ1uc7xQUvP6gzOBLRD
	 ULrtmsmP3tlXBhubwHMyf1qTlTUBSrxxjCey0KLDczphtr9XBvCJNpAonYJxLXdvTwS1R
	 zPAnjCKdC9F5xP8oghXqC0JTyYMRNcGvsArJGaDzo0a2Drxc7cggE3Y3wiMsKkwn9+uyz
	 7PnTjuC7yOBmuTo03rdBMY8NVp0PYy/ys3eMwboAAf1kxhLHtQXimRJFcJYCioYz9Gw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794978975;
	bh=ukWNkcNzEHPveo5aPJqxeLVx4NzUHljEIFtvUCMkIAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+ZebFbanj5MUvvAGEkTFkhm9xPtEQdAtdMR9+Os87ER7d11neWTcWjcn2K14yXiw
	 sq0rTcCEhAwW1cS4oZn15cfYihEE2OetPDd9W4uBC1UVWM6eWLw6TBVOFE4REZklhx
	 mG48+XFZ2U+5GXh4DEsQc08lXa6DtBi7DOflxsaf///qCGU3dtLXLFjq89WTdD/fB/
	 m15dQwofTnWo7HU61kXlDDkZtU7qE84ur7JitJY3RusflbbRR4Ggi6EG6role+GObY
	 IyPaGJB3gwYmz84hxOHTNhOyMarD3CV+u58+sCt3kqB7hvnil7xxLw87qxcbYo66DQ
	 ypi4fC0L5KSBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F8F081083;
	Wed, 18 Nov 2026 05:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23E8F1E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 219FA407E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUMJB_bF4AP0 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1DC440812
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MYyUl+V0
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1DC440812
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukWNkcNzEHPveo5aPJqxeLVx4NzUHljEIFtvUCMkIAM=;
 b=MYyUl+V0HpRsnwYdOSrUruVj77AdVMxWMKI2p2AjfL4qZButLaQ7wXlLRD/Oq3SxDEA69PF3KD4z02hjsuYvPDmDLtQyXIv+si0LFsTJOE89DmjjUyDZAvVcvsZJ8Yg3dQfcihK1m7mYnCHBSVf9mX/ziVyiKNv7rFkBBaIkriR020/9qlnCuijdT0cCQwiKTIxJaodFBiM51vXPvs74BEPMB42x2lKWYjKlJcZGjxbhKwh1ee2USf9ap6Q4TqsEFP2t2CWtVByuSZzRvkthdtvMENzSFjKeWVC5QwGWu34aj7ovmud9vRrY6QE+vBubqjsM7XiKabbiuNDfOOKEjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:16:07 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 05:16:07 +0000
Date: Wed, 18 Nov 2026 13:12:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] firmware: scmi: sandbox: Fix SCMI reset domain ID
Message-ID: <av0zsfeHqAPC7BZW@nxa18884-linux-1.ap.freescale.net>
References: <20261116110539.3394297-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116110539.3394297-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f601eb-2024-4c01-39ac-08df45330ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|7416014|366016|376014|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: fsICVlg4EIqu6o3Z2Iqzk96dOGsi2uzguupiNL6uPf9fOTFK5vl05TeLGJGi6wYBUB1+OJFtztH52wyriBrpl2+gssibZdWThtAeGXenlDW1JqfqP6W5RZqj8QFyrOJbEhCT+HuTA4Siv7fQWO0qHI6KeC7tKRnw8ejiZxXBfhmJ3YOjjiLPEJKqQkvf4fzuiLyZ1qIVknPsuB6pvdAk9gd9dRMPgcsXGcPWpWadBSwv7nPlmHXtiUeq/I+jlabTf3nuH5gzSg8iszDRGZQTHoYsg0jg/APMXqjAJJB+7Y/0DQfbFG985osBSfWm24GaYffyREgef74VKxPvxpPrtV6g7CjabtxYHXspAgN5GP/RQAp+XiUe7MoRD6SpIUGavsnDCXilQUPhQbJJfqnzz9YC++dNyQG61aUWTsR+gB9AoP8EUXNbGHmlE7IxrI/gwcMV7nyyxas6m/wAyZvTQGNe+60nZdyEQP91Nu2N0isy21Z3GZHJ96QFM/EGFeSvIUJ3U3ZrYrf7yrhFR9al33a5jkKPWJeU+KE1C/DMvUI0d7Kzn0LiJOcrWVWErDfwlYFySp2pGBbsR7HOjfobBaIiOyYO2KPpQBpcm3D5DdIWX3V+EhKTwSAbIaJBV/YD36zoNR2D3drqUwMCUeTuGlsAIDC4nCAVKL2eRHyO4zA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(7416014)(366016)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LO5ngkPIEF/jkblGaDuUVRzmhA/BZ4MtA/NfRRzRhKM7gGBpWpK9yw06wdhC?=
 =?us-ascii?Q?1TsylUpB7JAB0iKGU1FsY98Brk7oSBRyAXPOQGtsVmvi809msYQM2+ikNwW9?=
 =?us-ascii?Q?zLULjsis23QWD4KHES6EWySSb9qf7V9iFczZ0VKdEmMIhErEq/IRzTvxWtt9?=
 =?us-ascii?Q?CywcZZCHTSTmcma3tYjR6JMxJ1zzVOzBvKu8q0JXjmMUVFcqMYdroy1X8O43?=
 =?us-ascii?Q?BZKSqNWqEHIGXOk4BdR2+0CYFxht+qWNRoSleJKccJNVivNN7Gt7uAQEJlJs?=
 =?us-ascii?Q?5XPOADXxf+7iQL22X/QqVDI6HSV9EsiOid/jDvowmA1te20Veqf1p59RecB4?=
 =?us-ascii?Q?dEDqLnU4otLsIpocWdy2a3qn9rEqWLSYqtTdQZjwC1bmU/9StHgv2wDzT0Bi?=
 =?us-ascii?Q?hpJen8/ysVeqxyJDVaUp9luAk7F94HoRHhtiaJnlw504c0GA2P6FnM6njwm+?=
 =?us-ascii?Q?T/gbGMypwQsDZN60nCfplCHsF6b4dqSiJipr4bWY2JzkU+phNebyAZlvnGL4?=
 =?us-ascii?Q?86n/XlbhJEgRc+/MiEap/922qk6Fk1/bVkHEgxjfjNA1StEZ15thAPC3UGJm?=
 =?us-ascii?Q?3qtv3Ldj6oNTaVcSesnsVXBk2Wmk9JTH8eVbpoR0q2fW3TYrqKQlzHAhSWcW?=
 =?us-ascii?Q?cKdoD9zxxcMIJxVEVMhB3GfAxxLqGiZK5BEExqzUs0QwDb2LWOD5Jdb1o18z?=
 =?us-ascii?Q?UQHSzIJsau2Y/OT84FY4E+lEnXwIRhIIR2i/GE07cpB4X57xkCbUGrkWm/rB?=
 =?us-ascii?Q?pQtJzleJw1g9XPV07ZSvzbm6bRgm6ZYoA5EIMRlnlR6lNA1O7EMANVP2L4Hx?=
 =?us-ascii?Q?s5GTXCDEQh2jsVY7GxgY93y+clb68TKnUhoKEQ0P7iu7zuO6z9hDAxn8MCUE?=
 =?us-ascii?Q?hj4jlQFVtolnjotNlhn8g6dxa258QBFFm988KmyXYt7f4X2xe2tfuQWLObk0?=
 =?us-ascii?Q?j7IqkQDdlgapwqRILhx60XmJ4rsxYe65HXrgUkmyuKjjWvu6pdRizFI4SED6?=
 =?us-ascii?Q?Pb8d/ttpNrNbR50RQdHAO47YfN9MlIkPnNeNNhmIzfpn2E4n+SbAl5KHxnBd?=
 =?us-ascii?Q?Vx3GJfZzMw0GsgxJFv9WtdUFvQZp14WBcQlVT+GQQRVBp+b/iIdkBxmTm6oy?=
 =?us-ascii?Q?zpgsdmrIYg8Cbj3hhLaN/OfOj3p/CH78eycw1y2HlHT29rlDA6fwdtQi9c4E?=
 =?us-ascii?Q?7qQ2175EbfXpnNvriM2fkZPI0Y9u3dOi7n5m77L9blXy+vEGrb+smVvW4Kih?=
 =?us-ascii?Q?bUGWgpyIwZz7yTQ1kusirkoeIWYYkM25GCd+FK6OMp9MWutjHZNMnb59QJVi?=
 =?us-ascii?Q?fPA55mUg9dLFk983Jecq8WP6T5qQOHd5GcR6jmmhlS4xwVBCsMAiEErmNsnk?=
 =?us-ascii?Q?ZoJEf4i8dyWjyQbwkrfD3QBhaLDiVDXHGujXAWZfXLSA3bDxv+B9YIKaErjj?=
 =?us-ascii?Q?6rAC9Eu38LCI0jcR1M1+BjVqxCjBzeZjlQ5dalIoL0LyQ+bhn9nCu6LhlbHK?=
 =?us-ascii?Q?XPC0IH6xru5L54Beqx5wnrOkdO270nmn+BQEdEzOPRAhVXdAa3WxFs39Z2BA?=
 =?us-ascii?Q?kmdXEcfH8fWYSkCDjtOUylGrKlt6apu1yoEZCtZYqkIMt6McwRow4H8RiYf3?=
 =?us-ascii?Q?bFMk0pHy1ehtPgZqm78xnu/bejSKgOe8qyDTwyJpfERYtcxrH11XIu3kKG8E?=
 =?us-ascii?Q?NQe3smjc86HJEbK9be96O93G4rlsJOKWDre0RoevfQpkNdQBqVC7xpje8b9w?=
 =?us-ascii?Q?z8avS9pkfb1DnW4Up4H+OnX+O3LXTXOEcJ6U0gRuHY8BhBESdWnK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f601eb-2024-4c01-39ac-08df45330ca9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:16:06.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyrnXH7umJ6vTjFSSVHyoVUmpyRonnoUjQEhCf3NMl/OPh//mCTmoTEnO4IjvTM0Q+KPVIWPHdNPxORuuZzPmJjATGBnyqcXNMy0uqfU4u7OH1/KPPy63tqphf6ZVZFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:05:27PM +0100, Marek Vasut wrote:
>ARM SCMI specification DEN0056F 4.0 chapter 3.8.1 Reset domain
>management protocol background states:
>"
>Protocol commands take integer identifiers to identify the reset
>domain they apply to. The identifiers are sequential and start
>from 0.
>"
>Set the first reset domain ID to 0 to match specification requirement.
>
>Fixes: c0dd177a9986 ("firmware: smci: sandbox test for SCMI reset controllers")
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
