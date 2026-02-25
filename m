Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF69F55431
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0C183D17;
	Wed, 25 Feb 2026 01:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kS0nxglB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3877983F1F; Wed, 25 Feb 2026 01:14:40 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A9FB83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5rcOiNiuQRxbDQET8xO9MKBMeeC6kbpZtN03RyHpvdRneiph4NtnfcMcpn8oS8hId55FcRKzT0qVVCOl2rK6IfOYPkq4iD7P0BwgU3z7M1t/EBQArrKsy8n/k9qLmMg4pqjEmidXHfAoy32qCavmkDrXBqJxNa6LmNnyM+CxBTTEsq34BQmJU64lnsi6oeIXUWtXknSHz3Nnga87IIHowrUzZJ0ecUzm25m8xI3G5PljRICePCamk7jGOiaPquVms7UWP2fodevFQpxNkxgWxNCFxICfyhky/J8It/0T8/lqTEmFgwwOSEyxolVSkjD2qJJQr+j2ixkvQ/4McorQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShtP6oXWST9ojb9ukFCTVV9SG7LLRQvZQA/z651/Pb4=;
 b=qpzOp2RgYsio2SM91FjJNTwP/GpcjSuMlJvNbvB+3ncZzCCbGDdfR85o5igV9KjKy99OH5eQLZF++qwpfuE5H+Bt3ZG1aJKVvsmfDiaj6mqA2OrF39rUF8rigu3p+vzi/GmtFcJ00eXoXaXPqZrQ/+2R2mE/px5sO6FHYlqybMeKLpD/Pqufktv8zQQ66ibxcjJfE7Ns9RKespl1wPpbYw4Ew3u34Fnbqimjw+gjTvq0dvgm8c3fhWIJoNqb8HC7HRjr5i3xey39vlS7T+rqAOtG37vg4u3NHv+TOyQZHS4Zd2HUTzBc4VWKe6gT+ox8sN7g/OQTr/3PljxCRGqKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShtP6oXWST9ojb9ukFCTVV9SG7LLRQvZQA/z651/Pb4=;
 b=kS0nxglBiUoHdcCmQFmUInR3pSUjxGRPTTES7yr4i53/KkUa2ZZ68BPH2VIgABPYO5b/WRqILn8+ZkCScnuM1NC27+asSDlhHBGyf5XNx4DhwAoDIaKrVbxcMeT6kTEr8EQUtB15zvp1iIulgV56ev73krUR52Qfkvsza0vDsln8jFtHld0NrDqAjt+29QMb61gubWlIOU0ktIimMo9RLJCPNRsOYeLO/cEWiTuh6I4dpb/w8iW/pD8F32Oxnt8WJoRotbCL8Dl8nKoluoUkwl9Ed6OPsyOuurtXbgV9JrXn5SmPxLxMsK3mLiSZniHE3x0rw1bYbw+d9uCuz1tbbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:34 +0800
Subject: [PATCH 08/10] pinctrl: nxp: imx93: Support print pin muxing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-8-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e95975-4a9c-44f3-25ef-08de7402dbf5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHN0VmVCNG05NUhnMkR6d1c3THVUVW9QdmthT2EyMGhIbVZDaXdEWEpMWWMr?=
 =?utf-8?B?RVdaeElPa1FhTWhGNmFkaUNuMTB2Sk0wV25DQ3B6SW4rR210SnZKMisrc0h3?=
 =?utf-8?B?a0p0T2hrWm9aRm05STl4MXRTZFdaM3NtRXJzaU5nZkN4eWtyalpCWVJac2JJ?=
 =?utf-8?B?K0NranVzUkJWMTRIa3VNYkpWRmN4SzIrUGlUUjdzb0FVdVJqNmRRWWl5bFQ0?=
 =?utf-8?B?Q0p1LzM5WWIySTI5RUFiUWhvSWtqWWhGNG5PcUM1RGZSQ2RwcHpwU3BHZWwv?=
 =?utf-8?B?NnB0UGZSV2hDVFVYYnJIR2dPbmtYTWZWNk91TnJyTnRsNnQ5TGNraVJ0a2Ix?=
 =?utf-8?B?by81cTM0N1UxY0JMMWR5eUU1TVZsZkh0T3hmM0F2MU1QLzBNWk9RQU5saEc2?=
 =?utf-8?B?ZVAxNlpha1B3WWlCUm1iY2dTUk4yQ3U1Tmt1NTA4OUNuRUQ0Q0JqSEdRWkIw?=
 =?utf-8?B?bm1JV2x5RGRHcmJvMEhsNDg5V3puK2VsdjM2YUtORFNna1ZTaEZXV2J1bjhE?=
 =?utf-8?B?d3lsME1mVlVnZ080TTJDS0pQMDhOWU8zU3N5ZUc1YkdMVXh4L2FLZmhJaXNv?=
 =?utf-8?B?Mjd1TkRZQVp4dnJzNm1Hc3V5UFR5UVJhWS9nVTZnOTAzWHl0YnpDQ1BvQ2Mz?=
 =?utf-8?B?SERHYmZ4NzZNM3VDQmpMM1RqdlhwclREU080Qzd6S3hrSHkyOVNOb01vcGQw?=
 =?utf-8?B?WTdnYUF4Z1pyNWJQYUhuSXZmc3dDVFdkbFRPVXJOUUw4VnlIS2VoakNUWVN5?=
 =?utf-8?B?bDZrUkVZYjVLakVha29kbVBheTdLNjlVRGFza1QvVnlQK1lDZEQ3KzVYMXUw?=
 =?utf-8?B?ZGNJRnJ3NGdKVEZZU3dSU2krZm5QN29NcFV0aWN0UkRTckREUGFseUVHdzdi?=
 =?utf-8?B?S01BNkVibFkreHQwWUV5NG5wZ2hWaTJIckdta0txZ3ExRDJDVE51VDhhZGJi?=
 =?utf-8?B?Z2l0WmNTVGNJVXNwZXhWMnoreXlNbk4rdXAycEFtc3NjcVhkR095K3dUVGwx?=
 =?utf-8?B?aHVabkpXcGNrRE5oWXdBWTJseldpam9RTTdKMHpwL0Q1TC9oenVvSG1abnZI?=
 =?utf-8?B?YURIYUZiNHFtbk9tQ1RpTmVYOU9Sd08yYm5JYjQrb2d5OGMwc0p2NFcvTGNo?=
 =?utf-8?B?YmlXOWVmZlc5UUlteXlFMjJCenZXRzlrUTAray9OdVBwVS9OU1dWcE5RQjVn?=
 =?utf-8?B?VjY2Q0lOTDhvTm9ldU5vaFErSi9kcGNmMDR2b05GeVQzaVZUbUZqdjJCaVk5?=
 =?utf-8?B?eHJTYjVpbUtEVHArQUU0a2grdkgrVmVmQXRSaCt2Mzk2bklkRjRUYkdaR2hK?=
 =?utf-8?B?ZVBMckpOT0dOZFU2OEtoemwwaUdVVmdmVklDam9zMVIwRXFZUlQ5bVJnU1VE?=
 =?utf-8?B?SUdab2gwMnh0LzhoM1laaVh0SHNocGs3bU5JY1Zrc2k5d3o1UThMaUdVZG12?=
 =?utf-8?B?bUgyYytBQmd0alMvV0hMZGU1Y2N4RC9JNHdKQXVOeEJ1bUY2TE4yU0VrblJn?=
 =?utf-8?B?N3ZNMTFPT3dhRDRTTjMxeStYaWI2VjNHaG1ScTh5MnRmTmJqYnN0YWs4ZG5z?=
 =?utf-8?B?N3lCVWp1emdLbm9xS0c4WjdzdEJkNEgvTmtmT2lSRVFHRm5NaW1kMWlYUVFm?=
 =?utf-8?B?TUk0OVZFUmlSbThTY0RMenlrRC9hN3g0SXZxSjlFYnMvOUh6SnBrNFdhOFl3?=
 =?utf-8?B?bmVqS0NxWXR2UmRBRG5VSDV2ZW43YmUwUzE3NDhjc1hZL2YrMEtmYVlDQm40?=
 =?utf-8?B?aVQybkR3NHR2bmxoZ1YzNHBOaHBxVEFtNVpTNVZuUi9MTzVqMTdRTFFWa0h6?=
 =?utf-8?B?WFQ5b1dEOGdtRWppd1I3bXZuZVdRUGhyVjB4MnFJZHJaUDV6aFQ3Vk5IYVBl?=
 =?utf-8?B?OTZwdFVXZ3Q4aU84QWFGWTdXd1MyY1VjdW85NGsvTTJCdUFZcEpqWUREaitC?=
 =?utf-8?B?SUtsRk5NUG5xMmZvQWdvYjI2SFBUekdYczFsczlTTVlmSXVWVEwxMmVVaERH?=
 =?utf-8?B?by9SbUpqSXFQblRmbFNwNEk4Vm13U0tPL2Y2WGV3bkNJYkc1Y1hJUUxydXhw?=
 =?utf-8?B?T1RHejNXSDlrenROQSthNjBmbHpEdDRlSVVhbGFROHh0RUdYcHN0cENVUnVD?=
 =?utf-8?B?RVM0KzVSMGlYVi9UcGRpdFNKMTZ3TWR0eWFVMVY2UGVEVURpR0xBNlZ2U3By?=
 =?utf-8?Q?84lFtve7+41ofiI9hZ8IGnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdWME1pQjY5MzJBWm9zNGF5TDBKdEtOUDZad1FWamNSSVJKUHlPMndYUWM4?=
 =?utf-8?B?WXlHZzc0aW9DWWJJTlBreXZaVWZxNExGelJJbFdMcEJwbU52L2pjazZ4V3lP?=
 =?utf-8?B?TWNiV0M5U2dvSHdlZ0V6VUFVblRqQ0k2VnNKdWtCVDRmQ2xRTjl4ZE9od3E2?=
 =?utf-8?B?b2J2YlhadDh2cUh0VU1EWUhuT2kwczhCNDVteWRVQzZYQW55SThtTjhDTkdp?=
 =?utf-8?B?U3JPampXM3RYakVjaHF5cGMzQURmVEhQb0Z3eCt3clhmUFNMVWRvRlI5MnpB?=
 =?utf-8?B?RFE2TGY3K2puaXNqc1VwdXpUTEVmTGR6OFRsTnZkY3I2WWJENm1nRVI1Zjd6?=
 =?utf-8?B?RlhST0dqd0Z5R0V0U2NlSlVQcDlvNVdwTmV3VHR3aEp5TGZyUlJLSTRZMUlR?=
 =?utf-8?B?anJlMXlCMWZ0RVNiUU8zbjh4cmtsMjBPN1ZGaWF4RkxEeCt6T2hwS25IREhI?=
 =?utf-8?B?THpOMVU4M2tGbjBkVldzWDBSVW13aUFWc3lENVVULzRmVWpETmp1NUJyWGVk?=
 =?utf-8?B?aGVIelAwN1lVQzNaWW1lejJYdUFCdGNJSHowaWZoMnErV2JYeFBMUWhDSDN3?=
 =?utf-8?B?aU93MWszUEFhRVJKK1dlN1ArRTk2OHRDcW81M1RHL29scktCV0lNYklZUnhY?=
 =?utf-8?B?akx6WmQwWElwQklTdWVvL3ZPNzZFZkFSMFlHS3ZaY2VxTGQ0UTVOWGhHLzh3?=
 =?utf-8?B?czN4UkVtU1l2SEViNndveDlEUHRJUmtuR3V6SGlGYUhKT3RqSEk3QUREdklw?=
 =?utf-8?B?ayt1SUNCVDFENzNNcm1BV3UreGZleEZFK09ybDIvdm05N1crZDJwaFRSaFdr?=
 =?utf-8?B?NzdMVnRPaEFTVlRZTUV6UHlJK1k1NTdITTdxWFJVYXNFTUdWbTRoeGlPeGhE?=
 =?utf-8?B?bHdodFdscjRiZWQ0ZzhCYXl1cHlFell3dUVuRWxERGZiUjJyRXFaSkNJOFQz?=
 =?utf-8?B?Qlk4Umh6WTZNN1l0L3FocE92TVdCdXJlcitmR1NRZmpRMnJ3RGpVZ1MvajN6?=
 =?utf-8?B?Q1dTV1FUY2ZYdlFqUnRHYm1ZWDdsVjk3YXo2ZXpENWNwb0ZaU2twQ1lYNXJ1?=
 =?utf-8?B?M2JqT3VnL2t2NGprb0Y2Mk9WRDNYbXdNdzJyeHB1aGYxSVQvMjBPRkdFUUhy?=
 =?utf-8?B?Ym5HamMvR2luUkV0Q1Z1M3pCTGdOUHg2N2pNcWYzWVVwOHBOblRrQWs0YUN5?=
 =?utf-8?B?UzdYdGdXTnRna3JBWFN2OC83a0JrbmVCTU1HeUY4bGYzQ3o1OUxjUFhScXZL?=
 =?utf-8?B?bFR0SkhScXhnNjZ3bnpGRklVU28vY0dPcTczUzcvcVhwMlFrL3JBMkdWcC80?=
 =?utf-8?B?OWZxU3gwelE1UzRwYitGVGNZK3I0aEhVYnlGSFdyanlQR2ZYZFBISnVheHQz?=
 =?utf-8?B?NmN4enI4bDBxcGJqbVRTN2J0WlpXb2xPNXVZSnNTN3FhbUQvR1pPYllFakFJ?=
 =?utf-8?B?TWhNN1ZyWjNwNUlLRzVYTjlWQ1h2SDFMdjlDdmtxR3RmVWJTNnNLRGNGN3RQ?=
 =?utf-8?B?b0ZYaWpZTWJ5UXFHZi9abUZRTmhFT3hkTzRvMGNlMytSVG5Zd2lOUkpaK0No?=
 =?utf-8?B?VG1DazJpUGI0K2ppR2JraExyNjlIQWpZRStWMElWQ1VwdXJ6V2pUbGZNeUU4?=
 =?utf-8?B?L1JXMHREUTdOR2xlRkFmV3VwSU9ERUVxdEdyYkh5cGIwd2F5Q3Ntd1RHOHpH?=
 =?utf-8?B?YlFCMTBTR0R2RjlPS0xRd0lRd3lOa3cySnRMOXZhcjV1TE1RdTlSSjRmdEFy?=
 =?utf-8?B?M0g4SEJ3M1hveGdzUENrdUxZN0RBb3JxbzRmMW9FcVU4U2xUWU1talhJU0lF?=
 =?utf-8?B?SXJUbmZ1K0ZnUmdtZFNBdml0a1RkVHZMNHNQbC9xOEFQdmh4NzVFeUpkcTB0?=
 =?utf-8?B?RGYwOFlTeENqQWtkaTNCYi8xeWRVOFd2d0M1Z1ZLQ3dWemR6TC9DdlhaSVV4?=
 =?utf-8?B?cFBIK0dXaXBOMHJ2ZUJzV1N6ZFVvOVQ3S04vWnBIOGEzODltYkZOemxzZWZj?=
 =?utf-8?B?dFVIaklJWWwrbUZHZVpTU0NybnI1U0tudndnbW92c0VxR2plWER4dFpudTFt?=
 =?utf-8?B?S3ZrdzRYc3dzb3hqcUJjWFJla3p3WFhCZ1loMXlESjdWQTlaOU1BM0VUYmdW?=
 =?utf-8?B?c0lLYTVTdmFhdmN5ZGhIUjJpRXlPTUhqbThGL3Y1UnBBQS96eDVHWmhMZ2Zr?=
 =?utf-8?B?YUN6N1VOQUo0UEN4L0hBREJuVnRKVW9VOGZKL3p5WXVXb3ZMeUdhbTZrUlB4?=
 =?utf-8?B?ZUlMbGxMbnBCLzQ5dHZsM01YeW5WQ05JUFdJeS9iaFJUK1huMzlCbk1MYVJ6?=
 =?utf-8?B?NDJ0TVlVQ0JiTTVCbk9URDFscU5RaWU1T0tlVlZWM1MvVkZMSnJYQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e95975-4a9c-44f3-25ef-08de7402dbf5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:36.3449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l24Qwhc6eMYyyaxw6iUE3ovGA7cWoMPQWimvQQANlHG9JQzzCy4S8dwsiVO1XnTI+4BI5Kr2PO0pq7JudEWKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

From: Peng Fan <peng.fan@nxp.com>

Add support for printing pin names and current mux configuration on
i.MX93 when CMD_PINMUX is enabled.

 - A full pin descriptor table for i.MX93 pads.
 - Implementation of get_pins_count(), get_pin_name(), and
   get_pin_muxing() in the i.MX9 pinctrl driver.

There is no good way to add real mux names, so just dump the function ID
from the mux register.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx9.c  |  49 ++++++++
 drivers/pinctrl/nxp/pinctrl-imx93.c | 228 ++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx9.c b/drivers/pinctrl/nxp/pinctrl-imx9.c
index 39bcdeaa753..7e570c6b249 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx9.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx9.c
@@ -4,7 +4,11 @@
  */
 
 #include <dm/device.h>
+#include <dm/device_compat.h>
 #include <dm/pinctrl.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <asm/io.h>
 
 #include "pinctrl-imx.h"
 
@@ -18,7 +22,52 @@ static const struct udevice_id imx9_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+#if CONFIG_IS_ENABLED(CMD_PINMUX)
+
+#if IS_ENABLED(CONFIG_IMX93)
+#include "pinctrl-imx93.c"
+#endif
+
+static int imx9_get_pins_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(imx9_pinctrl_pads);
+}
+
+static const char *imx9_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	/* sanity checking */
+	if (selector != imx9_pinctrl_pads[selector].number) {
+		dev_err(dev,
+			"selector(%u) not match with imx9_pinctrl_pads[selector].number(%u)\n",
+			selector, imx9_pinctrl_pads[selector].number);
+		return NULL;
+	}
+
+	return imx9_pinctrl_pads[selector].name;
+}
+
+static int imx9_get_pin_muxing(struct udevice *dev, unsigned int selector,
+				char *buf, int size)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct imx_pinctrl_soc_info *info = priv->info;
+	u32 mux_reg = selector << 2;
+	u32 mux_mode = readl(info->base + mux_reg);
+	u32 sion = mux_mode >> 4;
+
+	snprintf(buf, size, "Function(%d) SION(%d) at: 0x%p", mux_mode & 0x7, sion,
+		 info->base + mux_reg);
+
+	return 0;
+}
+#endif
+
 static const struct pinctrl_ops imx9_pinctrl_ops = {
+#if CONFIG_IS_ENABLED(CMD_PINMUX)
+	.get_pin_name = imx9_get_pin_name,
+	.get_pins_count = imx9_get_pins_count,
+	.get_pin_muxing = imx9_get_pin_muxing,
+#endif
 	.set_state = imx_pinctrl_set_state_mmio,
 };
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
new file mode 100644
index 00000000000..d13969856f6
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "pinctrl-imx.h"
+
+enum imx93_pads {
+	DAP_TDI = 0,
+	DAP_TMS_SWDIO = 1,
+	DAP_TCLK_SWCLK = 2,
+	DAP_TDO_TRACESWO = 3,
+	GPIO_IO00 = 4,
+	GPIO_IO01 = 5,
+	GPIO_IO02 = 6,
+	GPIO_IO03 = 7,
+	GPIO_IO04 = 8,
+	GPIO_IO05 = 9,
+	GPIO_IO06 = 10,
+	GPIO_IO07 = 11,
+	GPIO_IO08 = 12,
+	GPIO_IO09 = 13,
+	GPIO_IO10 = 14,
+	GPIO_IO11 = 15,
+	GPIO_IO12 = 16,
+	GPIO_IO13 = 17,
+	GPIO_IO14 = 18,
+	GPIO_IO15 = 19,
+	GPIO_IO16 = 20,
+	GPIO_IO17 = 21,
+	GPIO_IO18 = 22,
+	GPIO_IO19 = 23,
+	GPIO_IO20 = 24,
+	GPIO_IO21 = 25,
+	GPIO_IO22 = 26,
+	GPIO_IO23 = 27,
+	GPIO_IO24 = 28,
+	GPIO_IO25 = 29,
+	GPIO_IO26 = 30,
+	GPIO_IO27 = 31,
+	GPIO_IO28 = 32,
+	GPIO_IO29 = 33,
+	CCM_CLKO1 = 34,
+	CCM_CLKO2 = 35,
+	CCM_CLKO3 = 36,
+	CCM_CLKO4 = 37,
+	ENET1_MDC = 38,
+	ENET1_MDIO = 39,
+	ENET1_TD3 = 40,
+	ENET1_TD2 = 41,
+	ENET1_TD1 = 42,
+	ENET1_TD0 = 43,
+	ENET1_TX_CTL = 44,
+	ENET1_TXC = 45,
+	ENET1_RX_CTL = 46,
+	ENET1_RXC = 47,
+	ENET1_RD0 = 48,
+	ENET1_RD1 = 49,
+	ENET1_RD2 = 50,
+	ENET1_RD3 = 51,
+	ENET2_MDC = 52,
+	ENET2_MDIO = 53,
+	ENET2_TD3 = 54,
+	ENET2_TD2 = 55,
+	ENET2_TD1 = 56,
+	ENET2_TD0 = 57,
+	ENET2_TX_CTL = 58,
+	ENET2_TXC = 59,
+	ENET2_RX_CTL = 60,
+	ENET2_RXC = 61,
+	ENET2_RD0 = 62,
+	ENET2_RD1 = 63,
+	ENET2_RD2 = 64,
+	ENET2_RD3 = 65,
+	SD1_CLK = 66,
+	SD1_CMD = 67,
+	SD1_DATA0 = 68,
+	SD1_DATA1 = 69,
+	SD1_DATA2 = 70,
+	SD1_DATA3 = 71,
+	SD1_DATA4 = 72,
+	SD1_DATA5 = 73,
+	SD1_DATA6 = 74,
+	SD1_DATA7 = 75,
+	SD1_STROBE = 76,
+	SD2_VSELECT = 77,
+	SD3_CLK = 78,
+	SD3_CMD = 79,
+	SD3_DATA0 = 80,
+	SD3_DATA1 = 81,
+	SD3_DATA2 = 82,
+	SD3_DATA3 = 83,
+	SD2_CD_B = 84,
+	SD2_CLK = 85,
+	SD2_CMD = 86,
+	SD2_DATA0 = 87,
+	SD2_DATA1 = 88,
+	SD2_DATA2 = 89,
+	SD2_DATA3 = 90,
+	SD2_RESET_B = 91,
+	I2C1_SCL = 92,
+	I2C1_SDA = 93,
+	I2C2_SCL = 94,
+	I2C2_SDA = 95,
+	UART1_RXD = 96,
+	UART1_TXD = 97,
+	UART2_RXD = 98,
+	UART2_TXD = 99,
+	PDM_CLK = 100,
+	PDM_BIT_STREAM0 = 101,
+	PDM_BIT_STREAM1 = 102,
+	SAI1_TXFS = 103,
+	SAI1_TXC = 104,
+	SAI1_TXD0 = 105,
+	SAI1_RXD0 = 106,
+	WDOG_ANY  = 107,
+};
+
+static const struct imx_pinctrl_pin_desc imx9_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(DAP_TDI),
+	IMX_PINCTRL_PIN(DAP_TMS_SWDIO),
+	IMX_PINCTRL_PIN(DAP_TCLK_SWCLK),
+	IMX_PINCTRL_PIN(DAP_TDO_TRACESWO),
+	IMX_PINCTRL_PIN(GPIO_IO00),
+	IMX_PINCTRL_PIN(GPIO_IO01),
+	IMX_PINCTRL_PIN(GPIO_IO02),
+	IMX_PINCTRL_PIN(GPIO_IO03),
+	IMX_PINCTRL_PIN(GPIO_IO04),
+	IMX_PINCTRL_PIN(GPIO_IO05),
+	IMX_PINCTRL_PIN(GPIO_IO06),
+	IMX_PINCTRL_PIN(GPIO_IO07),
+	IMX_PINCTRL_PIN(GPIO_IO08),
+	IMX_PINCTRL_PIN(GPIO_IO09),
+	IMX_PINCTRL_PIN(GPIO_IO10),
+	IMX_PINCTRL_PIN(GPIO_IO11),
+	IMX_PINCTRL_PIN(GPIO_IO12),
+	IMX_PINCTRL_PIN(GPIO_IO13),
+	IMX_PINCTRL_PIN(GPIO_IO14),
+	IMX_PINCTRL_PIN(GPIO_IO15),
+	IMX_PINCTRL_PIN(GPIO_IO16),
+	IMX_PINCTRL_PIN(GPIO_IO17),
+	IMX_PINCTRL_PIN(GPIO_IO18),
+	IMX_PINCTRL_PIN(GPIO_IO19),
+	IMX_PINCTRL_PIN(GPIO_IO20),
+	IMX_PINCTRL_PIN(GPIO_IO21),
+	IMX_PINCTRL_PIN(GPIO_IO22),
+	IMX_PINCTRL_PIN(GPIO_IO23),
+	IMX_PINCTRL_PIN(GPIO_IO24),
+	IMX_PINCTRL_PIN(GPIO_IO25),
+	IMX_PINCTRL_PIN(GPIO_IO26),
+	IMX_PINCTRL_PIN(GPIO_IO27),
+	IMX_PINCTRL_PIN(GPIO_IO28),
+	IMX_PINCTRL_PIN(GPIO_IO29),
+	IMX_PINCTRL_PIN(CCM_CLKO1),
+	IMX_PINCTRL_PIN(CCM_CLKO2),
+	IMX_PINCTRL_PIN(CCM_CLKO3),
+	IMX_PINCTRL_PIN(CCM_CLKO4),
+	IMX_PINCTRL_PIN(ENET1_MDC),
+	IMX_PINCTRL_PIN(ENET1_MDIO),
+	IMX_PINCTRL_PIN(ENET1_TD3),
+	IMX_PINCTRL_PIN(ENET1_TD2),
+	IMX_PINCTRL_PIN(ENET1_TD1),
+	IMX_PINCTRL_PIN(ENET1_TD0),
+	IMX_PINCTRL_PIN(ENET1_TX_CTL),
+	IMX_PINCTRL_PIN(ENET1_TXC),
+	IMX_PINCTRL_PIN(ENET1_RX_CTL),
+	IMX_PINCTRL_PIN(ENET1_RXC),
+	IMX_PINCTRL_PIN(ENET1_RD0),
+	IMX_PINCTRL_PIN(ENET1_RD1),
+	IMX_PINCTRL_PIN(ENET1_RD2),
+	IMX_PINCTRL_PIN(ENET1_RD3),
+	IMX_PINCTRL_PIN(ENET2_MDC),
+	IMX_PINCTRL_PIN(ENET2_MDIO),
+	IMX_PINCTRL_PIN(ENET2_TD3),
+	IMX_PINCTRL_PIN(ENET2_TD2),
+	IMX_PINCTRL_PIN(ENET2_TD1),
+	IMX_PINCTRL_PIN(ENET2_TD0),
+	IMX_PINCTRL_PIN(ENET2_TX_CTL),
+	IMX_PINCTRL_PIN(ENET2_TXC),
+	IMX_PINCTRL_PIN(ENET2_RX_CTL),
+	IMX_PINCTRL_PIN(ENET2_RXC),
+	IMX_PINCTRL_PIN(ENET2_RD0),
+	IMX_PINCTRL_PIN(ENET2_RD1),
+	IMX_PINCTRL_PIN(ENET2_RD2),
+	IMX_PINCTRL_PIN(ENET2_RD3),
+	IMX_PINCTRL_PIN(SD1_CLK),
+	IMX_PINCTRL_PIN(SD1_CMD),
+	IMX_PINCTRL_PIN(SD1_DATA0),
+	IMX_PINCTRL_PIN(SD1_DATA1),
+	IMX_PINCTRL_PIN(SD1_DATA2),
+	IMX_PINCTRL_PIN(SD1_DATA3),
+	IMX_PINCTRL_PIN(SD1_DATA4),
+	IMX_PINCTRL_PIN(SD1_DATA5),
+	IMX_PINCTRL_PIN(SD1_DATA6),
+	IMX_PINCTRL_PIN(SD1_DATA7),
+	IMX_PINCTRL_PIN(SD1_STROBE),
+	IMX_PINCTRL_PIN(SD2_VSELECT),
+	IMX_PINCTRL_PIN(SD3_CLK),
+	IMX_PINCTRL_PIN(SD3_CMD),
+	IMX_PINCTRL_PIN(SD3_DATA0),
+	IMX_PINCTRL_PIN(SD3_DATA1),
+	IMX_PINCTRL_PIN(SD3_DATA2),
+	IMX_PINCTRL_PIN(SD3_DATA3),
+	IMX_PINCTRL_PIN(SD2_CD_B),
+	IMX_PINCTRL_PIN(SD2_CLK),
+	IMX_PINCTRL_PIN(SD2_CMD),
+	IMX_PINCTRL_PIN(SD2_DATA0),
+	IMX_PINCTRL_PIN(SD2_DATA1),
+	IMX_PINCTRL_PIN(SD2_DATA2),
+	IMX_PINCTRL_PIN(SD2_DATA3),
+	IMX_PINCTRL_PIN(SD2_RESET_B),
+	IMX_PINCTRL_PIN(I2C1_SCL),
+	IMX_PINCTRL_PIN(I2C1_SDA),
+	IMX_PINCTRL_PIN(I2C2_SCL),
+	IMX_PINCTRL_PIN(I2C2_SDA),
+	IMX_PINCTRL_PIN(UART1_RXD),
+	IMX_PINCTRL_PIN(UART1_TXD),
+	IMX_PINCTRL_PIN(UART2_RXD),
+	IMX_PINCTRL_PIN(UART2_TXD),
+	IMX_PINCTRL_PIN(PDM_CLK),
+	IMX_PINCTRL_PIN(PDM_BIT_STREAM0),
+	IMX_PINCTRL_PIN(PDM_BIT_STREAM1),
+	IMX_PINCTRL_PIN(SAI1_TXFS),
+	IMX_PINCTRL_PIN(SAI1_TXC),
+	IMX_PINCTRL_PIN(SAI1_TXD0),
+	IMX_PINCTRL_PIN(SAI1_RXD0),
+	IMX_PINCTRL_PIN(WDOG_ANY),
+};

-- 
2.51.0

