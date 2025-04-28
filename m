Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B653AC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81DD8214B;
	Mon, 28 Apr 2025 12:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wfy4GU61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19ED882145; Mon, 28 Apr 2025 12:38:28 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A913580EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKeE7dOjeu1wiYXY2y3Rg6mB1v7lOf8XimmKt5k75dUL1sfd3Jr5B9vZyDF90NpIqapFBy6IxyQulN+13CFgP8Txa+1XS6et6XjVKJHOf3jrgxN6eZprGlXO0ROJyAlVCZ/qc5rTDhTvMPeu7JwQWnOxdefJ4dD7I831QFh3o2ZPCRIGfKrYTtprZuOfLhnjlSfcUgZjTNAymsVljjVJW0incHMIX9zCINkJLLUJnf9koWmbys7nwuIcq9iL/lcfjw3w56sd6gCHc8E2+ha8UPBpiyWk1WDPrk5i37xo9RFYaX5dUXuT9O5uOMWdvApTAm1ru2GaZqfcUdYBT5ycYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXn9EgIoWx7IIawLSaCSnqegEwcvKnBHfVHlFCVfSHw=;
 b=CXPv2OYGdtBO4ganbnv7gu+R5sN+uLuMUhbXFdygBJgcQRPUONbNDS4AbweKijaHBQKEWXiUMmO9XW28HpXGSHqZGe99piMwrlaISI99igKVFsQJSbnkby0/sAwuWKa/vfNpnxvxdfHpT02yEsg0xz+PsGdMxeci1/mWtHaOmeDxyI8H9ygzrfQEKGyhUmXqBN6FwCu/AYyxn15+Ikee+u4pBIHJSHza52g7Ucz7dqcDA5Te6xzMgt9S1oi8F5GojY4UTNkBdS22IRTxctYbJdyRpnqlwt1V6qtQVYj0zjBDE0+PIkSzrIrVjKv95UaHT7WAPeXiKiFntLF4Wre/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXn9EgIoWx7IIawLSaCSnqegEwcvKnBHfVHlFCVfSHw=;
 b=Wfy4GU61wNYSl/hlVFJqaRqIlaYuWmYVpuIs8DQUh6VW9+Cyzf4zjq6Oe7hio3LlzTWnWVPoTy8a0L0RUekeniIC3My8Fp0Gm4thOO+Z7BWxgrjeyLwALnbYd0jgm6IEfB9x6dZFQHgUz+DswZWFotBCDt4q1rFWWjhqb2+gSIkzNkGVSadHwQDF6xOvLDQVqId0FetSow4/8qK2LuYvZu2qcsGvUryYz+vuyBdPkfNFlPz1t2T3V83UHhUdOhh/2tXlkdN4GsDTP8iGuNTneajoY4evwGcjt3nX+pDEbt1X/uSqKrhErP2g6aBySYmqcFi9X5f2rza/An+33nZndQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:38:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v11 00/21] imx: add i.MX95 support
Date: Mon, 28 Apr 2025 18:37:23 +0800
Message-Id: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGNaD2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyML3czcCktTXYM0Y8Pk5BQTI0tjSyWg2oKi1LTMCrA50UplhoZKsbW
 1ABRKDYZcAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: 540787a7-f8aa-4951-a88c-08dd8640cc6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2tXQ3NtaGhHUmZMUnYxR0hoM0liaGlsWTRhbEdtOVJpOUlLYXZaMnFXRW5q?=
 =?utf-8?B?QUh2c21mVGpKMElQOHRNT1h2VnV1bzk4Y3JTczNleVhFUnMya3NLT1hmYlBN?=
 =?utf-8?B?VWFxZXE5NHVKRWk1eGRRak1qVXVrQkE1Z1VpM0R6d2I1a2dKdVkyYUxxdzdh?=
 =?utf-8?B?ZEprZTVyYmtHTlprSUpJSkdyWlhoRXJ2TjQ0WWZqL0ZqSXNiTENPckI3eEVy?=
 =?utf-8?B?L0xXQzVUbWRzMXhmSVU3T1FCTzBPejNtMnVoVTA1cm0xdzhWN08zczl1QWd5?=
 =?utf-8?B?aVY4MDlHQTZueVg3WUxpRFJZbjFIREtxd3Q2eFlvTGxQaDJMOC9nUlZqNndY?=
 =?utf-8?B?R2hIOEQ5VE5SWVppZVZQZURHeVJCZVl3dnB3Z2xvMlNmbGhWWjBQeHZ4eVRL?=
 =?utf-8?B?cGZqOUxFRGpET2svb1M4ZHBoaFhRbWpObnJBbVFFcW4vWGhoandqb1g1Rk9x?=
 =?utf-8?B?RittbHNCOUFRNzhFUlpHL3YxeHNYaStITmcyNlRsZkc1R3F4MksrRFlTVHU0?=
 =?utf-8?B?eEE0ZkYwR1hsWHpDRXBvTUpHNlJ1QVJUZTVUQlJ4RkFIUkIybGJWajlCbnFI?=
 =?utf-8?B?dEJqSW9DTDRQQ1ozODVtNE9WOGZ4cHpaWmxtWnJkS0c3QjhEU3VHbVBXTlJo?=
 =?utf-8?B?dlZxQ0s0eFVyT05MSXJHM1JpV1Z4MWd4b21pUnhYRE4vRjA3WFNhREp6WDF3?=
 =?utf-8?B?SGx3UmplK0wwTWNPSFY0ZkNFUnNTbkFxMTRWOFVDTXo0c3paR3d4VDU2M2dW?=
 =?utf-8?B?L3RxcUJUSUJoM0hPbEhuUVR0ZHFBUk1CS3hxWlllcU5XazZDMTIrcDN4VTRK?=
 =?utf-8?B?N3RxeEVrZThxYyt5Y2E0ekZGOE1LNW5LMkQxeUJlRHpYRnRjSGQxa1o4TmZB?=
 =?utf-8?B?eCtGWTh5MUFXVFFsMjdtMnRlY2xyVlp4NUNHOXJ0bm5hL2Q3dW9lOTc2VC9n?=
 =?utf-8?B?T0pWQnVnTVk3VmgyMC84L0VzYlkvM0lsRExPbFhHZ0RnME1vSVVhTjJRc2lq?=
 =?utf-8?B?SUdDUFZmN0ZCMWYyWWxSQ1pZa2Nyc29pOEVBSVQvbWtIV2ZReUJQeTRNNE55?=
 =?utf-8?B?QkJ5M002WncyZmVucXROQUlHVHcyWlFMS1JiSU5ITGxqUnBIZExKU1JUaFIw?=
 =?utf-8?B?WllVdUo0U1VmcW42OXVSazIxZVhRdTlqSjlxaHN3YUtnMVVLbHR1RmJheEc5?=
 =?utf-8?B?UHhmU0dVZ2M4ZTBmeVozd3l4cklXWTB4K3RSVVRnaXFJdVBpQS9TM01XQVR0?=
 =?utf-8?B?TTFCNjVlQitNM2ZHSVlwTlpLdTgxMEFyZUExbU5iQmdhTWVza1I0RFpSekcw?=
 =?utf-8?B?dWhSS1ViQkhKYjJ2WE8vR0lsU0FtQXZIVXJ1K3FPc2JYNytEMDFxSWFUOFJT?=
 =?utf-8?B?cE00QitId1NSK0g1dWxDMmRzVitLekwzRGVoaVpXSVBhak9YcVAvcWlCVi9J?=
 =?utf-8?B?M3pEa0dmV2JHUFliQVpDaGtkNVlpU0dvYXc3czFsMGdOTGV6K1VkbmlNZzE4?=
 =?utf-8?B?TTQzNWx0UWp2bzNXRkF4ek1pcHREblNoTHRmcTAzazZwUnlWek40Z2NETFA0?=
 =?utf-8?B?ejMwNUM5aEZZZTVVQk5XTlhmMVlSTTAxRDl4RUw4RTd6UUJYMm03ZDUyemNF?=
 =?utf-8?B?UzJscm5qQUY3QlJscEY0L0ExM2w3a1JLbkhZMmVyMGVLUUdXeGpyNDFqWUc3?=
 =?utf-8?B?TUs4T1BsaDY3NDlNKzlEOWJNL3NISzZPT1I3eER3MGN1TXVtNmJ2d2tIK3pl?=
 =?utf-8?B?dWw1dCtMclc3UlVBaVUwdndiU1hsbFpsdlhxcUFmRUZMT1U0aGV2WkVtblQ4?=
 =?utf-8?B?OUFCczlOdFRFZ3BoSkVJNUZSemU4Y3NlVCtyd3kyNFBER0tXZ0gvL3llMzdQ?=
 =?utf-8?B?TjRxYzFHMnVLWUI3ZzNDcG84eXlBVjVGbkdFVEdYRzk1QzZBWHRtV1ZxN0ww?=
 =?utf-8?B?Ymh2MEpNKy9nU2FNVksvdjZVV1dIZXd3c0JFaHJ5Z2xZRjFma09IaTBXSTdo?=
 =?utf-8?B?Y1RGeFhIejB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01OdFJJblBwdmZtOGhJUlBqQWQ3eUV5UzhoSDh5U3Jkc1R0VDlnbkJ1aWJE?=
 =?utf-8?B?TCs0bG9pU2J4VHJYRzdQOGZzU1BkRUtsOForejNuMXd1RUxzbnVZZUxia0Q0?=
 =?utf-8?B?SEhiTDFJR1ZUdUVYOEVjcnd4emphTVJxOWxwb0lSTjBMY2taZGVGSlRwa21z?=
 =?utf-8?B?Q2V2cTRYdDFHa1RMaWw1b0JwNFhyTUR6V01sWi9PUlc5TDNaVDdwYUFJaGo5?=
 =?utf-8?B?L2V4TmhHWFBTQmxBeDVaYVB3T09BNCtGVSs2Wjk4ODdhK1l0MVFZUkZOSUpI?=
 =?utf-8?B?TGlRSkVhTW1LMDlnYjlYRGlTbHhwTnNDR2xQdkNkTFFWRkFnYlkzYUsrbjg2?=
 =?utf-8?B?Ukl4WEVYY0VpVGhKWGkyRTJhZGZqbitRelA5UlBkTSt2NzdYN0l0eEFkLzY5?=
 =?utf-8?B?NGdnTmpNWkNZaUdtQk1wV3R1SnBRNkFBVkY0UlZlSlJzdlpMYnNUZ2pycVFq?=
 =?utf-8?B?V1hJQ3hPTXRZTXp0a1gvZ3JJUjF3YmJpZjFhek9qMG9RYW01R0FXODJUV2hZ?=
 =?utf-8?B?b2hhZmd1M0IwZTZ5TVpIbnJBcWk5MmE2UTZvYzh1eUd5dTZsQ0MzdHRaSXJw?=
 =?utf-8?B?STFjWXR2MUFhR2d3L0w2SXcvdVh6Q1c5L2t0UW1PYnl1aWg0eERJNW9WZmps?=
 =?utf-8?B?UTdKWXg4VXdyR01XWThpQjVmR2FNZGFQaitSRWJaQXJUNGhheHlvdTQzY21W?=
 =?utf-8?B?MkVQMEs2VkFMN3hXQWxDdmlJY2s4QVhVbGN1bkdJNFpxQ2V3d2Y3VENCNWZL?=
 =?utf-8?B?ZTBSeUNyUjdEYkwxak1mTWJ4N3htbkhCbE9JSUtNWWpJaVBWN1ZlenBaWDhJ?=
 =?utf-8?B?TnZsWldNb0FYVGo3dXFZQlU1SFJIWGw0MngwSU50amRFVU8wQldySUNrR05J?=
 =?utf-8?B?ZHd1bkNEdmFEQm55T29UeWpPeThBK2FQZk9BK0t3OGMrMks4eDlHek0xenJw?=
 =?utf-8?B?MTBVc1JCY1JseDA5eStacnRPRnBSTnVFV3lYcmdOZ2JYWUNpU3JGTkZZR21z?=
 =?utf-8?B?eTlQN2xEZ2pjS2VZV3h0R1d0bmpTeEZVaTBGWjVNYzRXRjFQQUQvRmR2MGkr?=
 =?utf-8?B?WEtWRFFMdDQzdnlTaVJUSU5mRFJjUjdZdmpES1B4UjNwb25tekQ4d0EyTUMz?=
 =?utf-8?B?anFZN25XZ2JKSXpVU0lOVk83UGtrQzZGaGxVWW5pSU0rYUtMM21xSExKVVZj?=
 =?utf-8?B?YWszSFM0Y1hRM2xUYTdWR3NLQk53endhMnhxQ2V5ZlhMc1hUWUZjSVo0YzFL?=
 =?utf-8?B?UWxHUHBHbk5YQTVmQk9XM1pEemNsL01uUXcrVm9hUUt0dFZCeWhQaWhWQ1BI?=
 =?utf-8?B?a0p4Z3FKUFQ1SS9SUlZVTDkzdXNMS2ZsbTdNRUVZQTZPUmoyeFQvczN3ZkJJ?=
 =?utf-8?B?VWlyVFVuMGlsckZaU3E4bVFSdGRrVmdpUmlRMS9qZWFzeFFLZEtOT1R2MHR3?=
 =?utf-8?B?UzNQekxCTENDczBqRWRvSkt2T1BURkVJQjRUc1c3ZW5rSlJ4VndERWcwU1pi?=
 =?utf-8?B?UGRyY1BSY1AzYUo1blpmU2huOGovY2Q4emVCRkpGQlNzVCt1eFpVSXhnZ0ts?=
 =?utf-8?B?WEtva1hzYm5ERk5Na1lwUG15T1psNjZ2aHc0R3MreWxjbUZCMndDdythdlQ0?=
 =?utf-8?B?by9PZllnbWY0V0U1ci8xWkY5RG9nNmpoMTRlVk44dlpqY0s3ZHFVbDFvMzBn?=
 =?utf-8?B?VGtMTjgrZTRBbTNyaExvT3dkc1MzbUhCR1phT1YzeGVzWjNaR0Z0WGlWb1RQ?=
 =?utf-8?B?d2FoY3JMblUxdDdqOVJPMDRFTkNhZGc4YStGUGtLWnJSZlFNZVVnMFlYcXlk?=
 =?utf-8?B?VlBSZnBYMC9YOFZXeWdYMTJpWmhBVDdQL011ZTBrM1RzaC90NUorMzMweGpU?=
 =?utf-8?B?VFBReUZqOFJoZi9mMFJRM3M5NUtnRnc0TnhoZzIyOEplTGtZSGxsK0VKaE9K?=
 =?utf-8?B?cmFGMzRXdHN5RnZtTERHMkd0d2kzN0hVTDh0Y1BHZ0RHS0dhUFBoNWdHY21P?=
 =?utf-8?B?WDJCVWxtOEp6bWRPWERBanJsOEQwblZUaEhMVjJwMjN0RFNPUWRpemppOWdM?=
 =?utf-8?B?M1BNNW5lek9icVdlOVlOa0hkMUdCZWc0QVIzNm5GMVVkQk5uVHRZeVJ0WTFO?=
 =?utf-8?Q?ZutSLSxjUw54GUYe4m9IW1TEd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540787a7-f8aa-4951-a88c-08dd8640cc6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:22.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efIKcxkv+J42WLxScKAS1RCC2SAR6De3gHuLaK8/uNE9P9UHyPdGrl+uVNFwMqTSjysmAxJ4Rd0mqbIxY4gXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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

Changes for v11:
 - update spl_imx_container.c according to comments from Lothar Waßmann

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (12):
      firmware: scmi: support to manage SCMI protocol drivers with a linker-genetated array
      firmware: scmi: use scmi_proto_driver_get() function to get SCMI protocol driver
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi_agent: add SCMI pin control protocol support
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      cpu: imx95: add i.MX95 support
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support
      doc: imx: add document for i.MX95 Image Container Format
      Makefile: add some files to CLEAN_FILES

Peng Fan (4):
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code

Ye Li (5):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx: container: add V2X container support for i.MX95
      imx95_evk: add i.MX95 19x19 EVK board basic support

 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 +++
 arch/arm/dts/imx95-u-boot.dtsi                | 188 +++++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   6 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           | 119 +++-
 arch/arm/mach-imx/imx9/Kconfig                |  15 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           |  70 +++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 749 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 ++++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++
 board/freescale/imx95_evk/spl.c               |  69 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  38 +-
 configs/imx95_19x19_evk_defconfig             | 152 ++++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 204 ++++++-
 drivers/cpu/imx8_cpu.c                        |   2 +
 drivers/firmware/scmi/base.c                  |  24 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  50 +-
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c        | 165 ++++++
 drivers/power/domain/scmi-power-domain.c      |   8 +
 drivers/power/regulator/scmi_regulator.c      |   8 +
 drivers/reset/reset-scmi.c                    |   8 +
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |  17 +
 include/scmi_protocols.h                      | 104 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  29 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 147 ++++-
 tools/imx9_image.sh                           |   8 +
 52 files changed, 2947 insertions(+), 100 deletions(-)
---
base-commit: 62ea9c329a0d013993bae538c55dfea06e4551bd
change-id: 20250428-imx95-0f31ccd42939

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

