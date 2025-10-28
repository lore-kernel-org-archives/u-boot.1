Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3520ECCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6901E82A9E;
	Tue, 28 Oct 2025 15:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YplSqmxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5E82E34; Tue, 28 Oct 2025 15:46:16 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BECC80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnzLCkES2Akabf5OEdmWPO9rzBzlGPCF/MSge146WyAuLR7rCDmizHO8eUlpWlxbm41mrrmFnwbbp0sfVPOTfRv5czBPkcBcV9OdKieLtXerKzuyKADfsMVHd4n3Q4zY2v71fd79pZfkTr7kHzLRuRvlccAN4RIp0Rye8Ai2gz80ou6mzc+T0Lgwcs0GKeU+2iQbj4GsdZz4bjN3Lzj5as8LpB9LcIMxdrs7/zoe1crZP/xdS0DW3HlMs1j2LIa41MnDHJsPP1O0/rjNTVXt6mlf81rP34YcFCnRJ9dSO/yeUIzCvulHcnIZ1KhazO0V6qzRIV6+5ICYvZyFdVM28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiryyTGcztGOnGQgcYpAxM9qy6EEu2KeuKTJdUzIUWs=;
 b=Zt/i5pw+LVRv6hXCrWHwbfVTVLwg4+ffmyjU6gxWCfuvglidfqO4uSV3/4qnlG06NbyxCWCwIkQTYOKzsuJrTaN0axlcM2AK6FgcEhbzYljZYfq1dvPW4gMszrgXV7j6cdbWAKYby+LSwW7v8JvUGtBsQN8ohLQ7zda8bjYaoKkQPJOR1+OsBAtsRq+zXlPww2OAIBGo1BnwtMZNGvVVd05xozk+caJu6bCBMmS2sOXonqW4JDqqfGwgZlXamkqSjEfftBygnkMzuI3IBZNR7jxKDqVKhTzy+O+RiV2mAMtKnZsoMKS8/L0Mq1SyBb01/gFwXP1d5BhV+rr5CAtitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiryyTGcztGOnGQgcYpAxM9qy6EEu2KeuKTJdUzIUWs=;
 b=YplSqmxiOnpeveG5Juy41ZTgrmik/MZy5dkcqWqum6tdxIpzaU5OY2AUn5HcKpPOjt5CtgsCR/4pE+xqk1HToQ7zSb8Bir6IbhQg0Sn4l6zZi+u8LGm1s3pezplODnXGBEXHZq4N5hhpyVTyCuax11et4cZ1jGN4DkmEfeBJNgNY++I3nkOQrwbAHfg3MGZwUfFp75X2E1UHRveyrkkoYvg5HUX5LRsW06BuYnn3co9rOtpxpJv8OKGafbdX2y6QVBYZzNav2Xcnvs4iCEgMZzNpDpL47E6W4/geZJRitp0hnH0Th2Puzg84zocBd9F0jJzJNy9rjn9G0rGQso+Fvg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:46:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 14:46:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo
 <alice.guo@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: RE: [PATCH 3/4] clk: scmi: Postpone clock name resolution
Thread-Topic: [PATCH 3/4] clk: scmi: Postpone clock name resolution
Thread-Index: AQHcR7ztdaUxXrr650iCYJBvlRnrPbTXdGOAgAAgH4CAAA8AIA==
Date: Tue, 28 Oct 2025 14:46:09 +0000
Message-ID: <PAXPR04MB8459DB7C2C20279674B49C9788FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
 <20251028115645.GA9371@nxa18884-linux.ap.freescale.net>
 <4b42a07c-5660-46e7-ab53-572a3eb11a2f@mailbox.org>
In-Reply-To: <4b42a07c-5660-46e7-ab53-572a3eb11a2f@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9709:EE_
x-ms-office365-filtering-correlation-id: 7393662b-35c6-4b4d-79dc-08de1630bbbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SkprczlqN1dTeDRMa0E2Q2I3ckRaLzhZTWowNU1ITGVwOEExK05MdzBzZmhO?=
 =?utf-8?B?UldENXBuTys0QStxSkRMSkxFUGtrYk9WNDBzSmU4amU3TnJxNExGWjhNbHpB?=
 =?utf-8?B?V1hSTzN5K1I3WXlaYnNKTnE5cUZvRFE5SXRVajdZZzBUNy9pZW9IdzJqdGxU?=
 =?utf-8?B?c05qMG4zTkxJUHhMeFNHMktpNHJXUlJDcHE3MGtBVCs1WDF0YlhDUEFJMjNw?=
 =?utf-8?B?Q2xnNWQrcFVDYWdjOTFMTWc1OEpCUVJIamt6YVlkdTg3d2NLT2FKUUpGMHpH?=
 =?utf-8?B?ZGtwdzczMzB5bVAxMTV3bnNJK1pHdUhwR0txYW9PK3IzSXJKWFc5TEJrS3I2?=
 =?utf-8?B?djZnNHhXemdiRDJXZDZMTjA2ZEV1b0cyZFZXemxHUkZBc0VycHVibUVpK21P?=
 =?utf-8?B?WFRjaGw5MmhsTjMwNGM2MEQ4ZmgyeVpvRjdVUjdseDZRdmM5OE5CVHFCcUla?=
 =?utf-8?B?RERXNUpFV203dHIrRnFJVlM3RDQvMDUxWWQwbHIzNkJKMXZueUU0d1lJU0xj?=
 =?utf-8?B?ZVhRTnZoOGlZTXAybEdWNEVRbmkzSkVwbXNGZXlUYktvZmRFM1pWRGZieDFU?=
 =?utf-8?B?R2VSYUhwd1BmVzBjMlNZSFBNU2x5S0V6L09MeVc3Qkx4WXp0U3VRaExiMFps?=
 =?utf-8?B?bERsb3kwWmtkR2VHVUt6eURDMXpLanQwRlJmcXNXL0F2YjgzeW8vQjlvcXlO?=
 =?utf-8?B?eW8xM0k4VkdhRjN6NitzYjg2cURYM0UyVUlwcGxlaG5jOU5FTVlnQWZzd3Bx?=
 =?utf-8?B?MmVUTTF1WFQyajliMUMreUgvZTM1akhRajRvejZESWduYzFOeDdwREpDY2Y5?=
 =?utf-8?B?NTUybUZ6WFN2cWNzVTJjL0VlVzcrekxDVUI0ejlUR1lSKzh4cnozZkxPWEhC?=
 =?utf-8?B?UVNzc3UwQlhrV0xhS3JNUHNHK05nN0dFSlBQQVI3dnh2dUp5eStld0xQdFAw?=
 =?utf-8?B?d3M0aWlzMWVoM2tVdzd3ZUpjTCt5OXppUWthenBBb0c4ZkE0T2JQNDF0OXdl?=
 =?utf-8?B?VVlwamtnVHBremIzcDhmcmFFbG8vSHdaKzlwRUtPdlF2dHZuVlJMM3MxZDNF?=
 =?utf-8?B?UHFoN2R5UFFTVlc2LzlHRWNrKzNwTmJ3bkVidzV1cS9BNHdSTmptVzFCVmJ3?=
 =?utf-8?B?TW9DOXJRMWJLa3BsTlZZQzVFaEZBQWh1a3c5UVl2cmFSUU54aTJEb0pTTElo?=
 =?utf-8?B?eUxjUXE4UXhyMnFtSG5UdFpZSzZxUGYxN3VENEptL0NIaTRCS3JEeWYwK2xC?=
 =?utf-8?B?cnFHMGtJaWZnbnErUnN0bkkvZkpYZUYrbERpTVlFN0xRQTBudUxtTC9EaFJQ?=
 =?utf-8?B?Slpjb3Z1VWd1UGxpdVJjMUtzMjcrQlJVWGYxaS9PK0R4b1VabTg5KzFtRmtv?=
 =?utf-8?B?ZjRxQWxHTDdRMVcrYk9oVmVVK3BDZGhvYUYxNFl1S3IyQUpWelo2MWtBOE1w?=
 =?utf-8?B?UURreFhvNlFQSXRERE1zb2dTeFE1UEJBN0V3ai9rTzl0SUo5MjF5blBjZXF5?=
 =?utf-8?B?Qkloalgvbm43a2FNVm5XUTFSV0JVNnRSU2x3ZlZPRmVkeW9yaFpjSmVWVFBp?=
 =?utf-8?B?SHVxaUpVaC9pY3lrZGZjRlBBS2xUVS9kL2ZSVktycGR1cUhsbTBURFA1QW9O?=
 =?utf-8?B?a0U2VWNUN3llODRiL1ZtR2xtTDZaaXZJWG9LS0dkbTVEd2dTTG5GYVk3TjJ3?=
 =?utf-8?B?dFM1QjFaMFFuR0EvUWtGQzlFalZkMWs1WWZjdHMzMCtxUGRvQTR5UHJXQ3ZQ?=
 =?utf-8?B?VnhjcDlWVUw2alA5V3pJaUYwK0JDQndHcGRUWGhoNUlZSEpsdGJTZHRpSFlO?=
 =?utf-8?B?WG9CMkFtQzlldjM0TmxCbk5ROXIxV0VRZ0JRbEVZaVlDdGx5eUN4K2phdGdV?=
 =?utf-8?B?NE1mRStuZkF5aG4rRVhIcXgvOVZ6ZkQzYkV2STdmVmJBdjNkcG02ODhiNTNY?=
 =?utf-8?B?dXF4YkdjMHkyYmxka1pBb0JNN1Uzb0hKNFZoQ2c3aWNkMzh4LzY4dDJ2bXpR?=
 =?utf-8?B?eFltU1EvNmRDS1I1QmpTK3djemZrc25PenVFSmtjNVhnZHVhbm4rQW5tdC95?=
 =?utf-8?Q?4QXz/W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm5mdmROVUx0YVRKeXZYWVdnRjJvQmV0Z2ZCbXplMldXQUFsYXpiOFRFQVFO?=
 =?utf-8?B?U3ZVVTNOQVhmQ3RVSy8vc1NNUlNBeUx4VzRxZHpLamZESW85bkhWV3ZvaDlY?=
 =?utf-8?B?SkRJaGNCa3MrS1I2K1c3M05BU2pkdmpiQzYrTUdDZ2dtQ2FmcFltajY5eHpq?=
 =?utf-8?B?NEwwcGxTMDQ5OUhFUnhTM2Y4ZFVPNTV6R3g0QXJraFRZdTRhMzRGNDFTVnJS?=
 =?utf-8?B?d2tNMzNPNDlpQUFMVHlFdENNN2hJd21IRDFwSFdHNGYyeTZNb0oyRmRWR3hx?=
 =?utf-8?B?dFBMRCtQK2kvUFM3b1ljQXJXY09hYnBLUGM4WERtWEFWczluV3lJMzdYWHVG?=
 =?utf-8?B?clpaRHlWV0RTTzFoTFlOc2pWazRCY0hHSVp5WE9lWkk2V1ZqdzZxMVprY0lw?=
 =?utf-8?B?ZTd2UWQxR1pJUTBlbUIzT2VOc2ZHb3YvbkdFa09FTUxKbVUzWEFCd0pmb21w?=
 =?utf-8?B?bEt4RVRYZWhmYi9xVXQ4a0RnSGRNVHFiNTkyUFVQSXhwbW9ad0wxUE5qYm5j?=
 =?utf-8?B?VzBoTjJaRWVrdnZYV3hxdzVFaGJlR1V0YmlET0creUt5bVRnL0VVOFBCbW94?=
 =?utf-8?B?b0RwZDNRTGl1NkNFaVo5alBMOUw1d3RNeGF6WFA2TmdQTlZGNkF1WEdRNWlt?=
 =?utf-8?B?T1g5VGFMRnl5WGljRGJ3SVN5V01STlkyY2NYUklJWlNQZGcrSWIyTjJaSGNh?=
 =?utf-8?B?K2dMcTl2Q0xqeHhZc1RVTEh2YUlHZmlDdWVSdEJLWm9BSlN4OE1lQy9iQlN3?=
 =?utf-8?B?WnRrczhqbnVrcmFBd2M2azE2MVVNaHhCVDRhdkk0ejMzYnQxU3JRcDhOdklr?=
 =?utf-8?B?ZmNybkY0OVk5VkZkWktYdGNXMzFiaXZFVFloaHJmOHVPLzFQNmhmVW5OOE5n?=
 =?utf-8?B?N1RoalNZNDM4NWhxNWlLN01ZNHlYMVFPUnJENjloMmtRTEdGZ2hHQ2tuTkFY?=
 =?utf-8?B?aTVGcGdpOGpSdndQQVM0Z3dQSEJUNitJc0RTWGl1dEtRVTIwM1RWTElsQzd2?=
 =?utf-8?B?UnQxekxLMTRpRmpjeGdhTU02S1I5WnBCZ2tIUlZ2Ty9XYVExYmJCbUJIL1J3?=
 =?utf-8?B?SlpoRTN4SktCK2NRNFZaR1Q1VUhFUU5YVG85Y3d0NS9KTUgwYzl1dE83ZG5v?=
 =?utf-8?B?Z1JRWGdCcmpEdUcyaW5qRldwWTIvRjdnajRUM0RabjhlaFJVb2NxOVFrL0JN?=
 =?utf-8?B?M1ZkVWYxUmFZTjdTN09YbXdLMlpQTVVHQWtGZ3BERHZNOG5BVmltSEtTc0lW?=
 =?utf-8?B?TkZaUVZyK1hIcDU3ZFhHTEtFNVExT0FXR0VyRTdaVGhCVFR2ZnVtOVVZZ0Y1?=
 =?utf-8?B?Vk56QTUvd2J4SWIwaFVlZ0xxVVR1RkVqMXdOMU13SjBEVWxjTHB0MGNkSzNO?=
 =?utf-8?B?QTZ6TjBVUjhXbkhrVGtJbC9ZaThQcCtPeEVpWVd3SW04anBzMjR5OUFhRkp0?=
 =?utf-8?B?cjZwbGQzQ0Y5NFRFYlQ2NGRtYi9jMmwwc3pnS3Fvc1Z5Y28vUW5BbTcvczlG?=
 =?utf-8?B?aGJFMXdmTlJpemVoR01xdDNRcTd0VEg4MUdpdFVqT2lLZDhZRVAyQWNyUFJQ?=
 =?utf-8?B?Q1VNYW9jTFZ1ZzQrTmhLblcvL1lPcGNhUm1YY3pCY1FOMjVjUzRjRldBQ3h0?=
 =?utf-8?B?UjAzZklPbytFbEQ3M2d5SzJXMllvNHZLbWJROXVLdXNmTVlIeTl0QjdTS2Vo?=
 =?utf-8?B?N0N1QTJQSUROa2Q5WjZrb2w1c2U0Yk9yNC9veEtuM2NLWmpQVDhkRFdrN2pD?=
 =?utf-8?B?Z091OG1pMFkwWWlON0xNMG5zZkdGbTRUR3NOMWVwcVpST3dkNnlaVWh6WUZm?=
 =?utf-8?B?Wi90YkpQYUU3SHJ5K3lyR3VHUUh1Myt2OTkvTzZySk1MV2FvTWJPZDNVeitV?=
 =?utf-8?B?VzBrUm5jOUhCVjV2NkdIcjB2LzNyMjNqcWc4OUVXeHN1WFFHRDhCNFJpbnda?=
 =?utf-8?B?d1BUZTY1b2ozcFg3SU9BMjYrMGo0aXoxMmRsYW1sV0ZnbU9SNEV1OVlLS0xu?=
 =?utf-8?B?dXVwKzVyTWtIeXJ4dmt2T3R1TDR0M2pnc1o0SEkyeTZDQS9UMVdMekFvVk85?=
 =?utf-8?B?WnRxSFNVbm5iNjVYeGV1MW1NRXkwUDBGcnBEZTBCN1gxYWFmaDd5eHRWTGtV?=
 =?utf-8?Q?ElPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7393662b-35c6-4b4d-79dc-08de1630bbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:46:09.6668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12u5NA2m+NFm3hxig/yf9aNW9d+TLfO027xcdC5yechxeOevmiyzWG3lnt/m6wq2Vxumshr08g0BdAv2d3hONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9709
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gY2xrOiBzY21pOiBQb3N0cG9uZSBjbG9jayBuYW1l
IHJlc29sdXRpb24NCj4gDQo+ID4NCj4gPiBUaGVyZSBpcyBzdGlsbCBzY21pX2Nsa19nZXRfYXR0
aWJ1dGUgZm9yIGVhY2ggY2xvY2suIEluIGNvbW1pdCBsb2csDQo+ID4geW91IG1lbnRpb25lZCB0
aGlzIHRha2VzIGxvdCB0aW1lIHRvIGNvbXBsZXRlLiBJIG1heSBtaXNzIHNvbWV0aGluZywNCj4g
PiB3aGF0IGlzIGltcHJvdmVkIGluIHRoaXMgY2hhbmdlPw0KPiBUaGF0IHNjbWlfY2xrX2dldF9h
dHRyaWJ1dGUoKSBpcyBmaW5hbGx5IGRlZmVycmVkIGluIDQvNCAsIHdoaWNoIGltcHJvdmVzDQo+
IHRoYXQgLiBJIHRyaWVkIHRvIGtlZXAgdGhlIHBhdGNoc2V0IHJldmlld2FibGUsIHNvIEkgc3Bs
aXQgdGhlIHJld29yayBpbnRvDQo+IG11bHRpcGxlIHBhdGNoZXMuDQoNClllYWguIEkgc2VlIGFm
dGVyIGdpdmUgYSBsb29rIGF0IHBhdGNoIDQuDQoNClRoYW5rcw0KUGVuZw0KDQo=
