Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE6BC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 790048077F;
	Wed, 15 Jan 2025 14:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UFDIKxml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE21807AE; Wed, 15 Jan 2025 14:30:29 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B70807B3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTow+5omnTynIXNpiYLSYenRVBuwM8P+iYItH1uo3KbJETHBSqX0MdqYxUgVr0vHwVz2dtbipsgfz4sr9+TDAu7jIjcCcU9y7vpIVucJ4xpiIO/Cm2ElvhMy48TtutpM1ownX+Ng+CWPC982QG3kFaTvRFyA46wXe/Y0hAwwq2MTsfVsmZgHf754fdABLyiSRmzzSYuUsXq/eLtUtqnAbzju2id5up/wZSsWiKUPJ8a+TMxkIgOugejNbGkrSMrxyAn5GMoYnYGtBdXL5eqORFFUxqd2NsqznQUgc76bvtg6PvyWSWGTpUqdbzAMiQ8EKakq4hYhjckqyoqW9Bhbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkbMeqinXiq4z3c3Nul1eP2Yuu23FG/IlUjStSx80RU=;
 b=J2ShNHl6b/Y9vj7WlNDUCC4jCwpzG330yZ2gKYnEnQ+aIOHP638wjxU8YptKhwMTqBgLRc6F3spXEiI+mq9OoW2AkcZViYcg9OczSUZmUsO09D8kNvU1Ew2HxyILXzcL1Dex5BtmRZvMifc8+Waa0fWHFqeQoBGk7gmh65fgOaQRp3Xlb0JLOM2NIVnBjM5BRpgoy3mWmQ74FirE2fW5F0xCp1drlaTZNdOjupyUpNp7TuhS4mfHEFTGeJnSg9SvzrUo8NozW6p8vCmUvrCjr8sNPN1jRYLzvZRUiwq+YvtbWdzzABZbTCRFEZBjYienW1YrRWa0nH0GgUv9eiJtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkbMeqinXiq4z3c3Nul1eP2Yuu23FG/IlUjStSx80RU=;
 b=UFDIKxmlBRxBQnExnAwv5GoN0YzBz/1UakQ4ADWF7iYnvO47accwGQaxfe2Gxht9K7ORlh1combcHSH/4/1oLxjbX3SBD6Ktdp68xrKzcJg84VA4mv5M78NL1bt8sRZLgPWrhASUx2SAwKkwl24YzuyRcpFsSzrlo2KxN5TkrCNVveUjDHjkySY+F+wv9SJAI4UVEoW18fR3XLrKR61sAvnMZ5WaQzsGFvAIBKWaiCr2syOj9hlFflLFH3EYFVgofGTgUtZa6SwXioRgU9m6rKO3qZXG2RNyXEZsCnXP75jLo1E3K8Chb8sAepWBbHA/kgIZpQFZ+fe6LZx5x8N/cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:25 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:06 +0800
Subject: [PATCH v4 19/20] doc: imx: add document for i.MX95 Image Container
 Format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-imx95-v1-19-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=10717;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=yNSmOx1VIf46vhNBUf7C+CSIuhFYxpwRjAR9HBrclxA=;
 b=qBnTyIHQXJst/EBNW7Irc88/nNTbY5WhAjim6hcx+U5sIwUNGfO3Z3IrBvhiqGieqfw4kriBj
 2hHA7T/hwRTCtxZVZ7YR95I3GLhBMk5HQ20eiPWHYAfYMlC42E8OsvJ
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: b9679040-deeb-4c75-f289-08dd3568c4cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGNiNDNCeXZReEM1YjFpbnJETnNHK2FTSVkweWVvc0FmZUlOTVZuZUI5ZjZl?=
 =?utf-8?B?SGNPcVhIdWZCdExLVnAyRnh0OUdRNy9ldDRvRldzNy82WC9udWtBZFZhdlFB?=
 =?utf-8?B?YWx4Smp2alo5cE13QnJDcWVWMDRSai9IcTdXdjNKK3dLS2pYdUdLNVJaQ21R?=
 =?utf-8?B?aTYwK3RiTzJaMGJJb09GNHM1aU55VHlMdTVpWWxyRmUwWDZVRlBZTGhEd2xr?=
 =?utf-8?B?clUzeE14dkk2MG0xK0NpS2xLeUU2UG1naTlwNjNIamVDRkxSaHM2aGE3YnNH?=
 =?utf-8?B?TDBIN1lHWWdqSjQ4ZFVMUHNUM0lETDM2RWJtYWg5MTgreERoc0lJamZVZzA3?=
 =?utf-8?B?QkIzU1V1QWpoU0xXYSs0WHF3L1Z2WHhOUXY0WG41S0dxOVNjMUloeWREQ2J2?=
 =?utf-8?B?SkN5NFYydDFUbnVmcW96MmwxbzFta1dwcHNZMXVJMC81VE9JOHFuejdydkl2?=
 =?utf-8?B?RmYxR012QVVWUnlxYndvdG1xQS9UcERWSlp5NjFyRnNsY3pKUEsvWDkwOU1u?=
 =?utf-8?B?U2hIc1kxOTJ6MWZqVFdhRFM0MGJIQ0RsWVZ5dUUvbHo2bWtsY0VZNUFQczJq?=
 =?utf-8?B?cXB4ajhIVFduZ3JTRjRPWmI4VVdHeWtTVjNyNVYyUU51MW9TZWFybyttSkFl?=
 =?utf-8?B?TldZejhSMnFweVYwQm91LzlvWTY5a0c3L05RWjlRdFNLbTA3RzhsVDg3U1Ro?=
 =?utf-8?B?OWxGKzQ2a2lrYkRIM2pIeVdHakFaY3ZwN3hUWCtsbi9heHlzNDZDS0dvZlN4?=
 =?utf-8?B?UWZKSkF3WWRyc21sbU9jNmJ5VGIyS3NtVUFSZDRkbVRqQXp0clBzNC8rWkp0?=
 =?utf-8?B?UDBFVkhNdnp2eHVjUGY0NVpaQVFrSTJkeTl5U1JVazFYMUpsOU9HbDR5cVpy?=
 =?utf-8?B?YmNRRUtaMnZxL2gzeE9BV1daT1ZVNlRBYVFQTEZ1VUdnU1E2TFZBTm1wZGVh?=
 =?utf-8?B?N0lqU25NR251NE5YTkZBQ3dSUmZmMC9tbGl4TjFkaWI5MW5tMXA5NHJlRjAx?=
 =?utf-8?B?V3pXVjVGdFpoNVhuektQUUVCRlp3OEVWR2FjS0tkb3NTeWJzd0xhWVAyVlVH?=
 =?utf-8?B?aTZqNkhrc2pITWtwTlpBUEVNSkJSZ3J0RlE4dVZ0ZU1nTlZmZzBFQ1cwMGhK?=
 =?utf-8?B?ci94Z3FWbGYzRUxqY29ZV0NOejA4RDFqYXI2MXk5UndRYThWcTIya0MrUklJ?=
 =?utf-8?B?WlJWUFNVcUw0RTlHaTNnb0VvbkR1Nzh2NmV4WGJVWTM0VnZWUXlqT0hsOTMw?=
 =?utf-8?B?RW5sMEdYNnhSMmNLNnNxdHlib1JXdlptems3c2FRSUlkK0ZjaWY0aURWWU5P?=
 =?utf-8?B?dnhhbGMzbDNHMmRnZ1dRMXIzOEhiUkhueWdBdXlHZC91NVl2ZloyLzEyUWlF?=
 =?utf-8?B?aGpwSXhqK0s0T25DaXh1UVRhNmVwbGszTDZjOEVJdkI1MnA5U3VOdVlYYUpi?=
 =?utf-8?B?ZHcxSnlWNkJ5dmxLeWd4elp0U3ZoMHFRblFxL1p6OG8wVXBMRzg5dmp4T1R6?=
 =?utf-8?B?TlM3WGpHeUVQRlNDTFB5a3RBL2J1V1NXN2tPeXBKbHVEdXhqRzhhVTJTSC9y?=
 =?utf-8?B?d3Nob2lrSHo2cVRkcVV0VWNOVVBROSsvVHc2SUhEMVJXMVM0ZkNXZ2xtbHRy?=
 =?utf-8?B?VWNESGVVcVFyYTBSRWFobE9QTEk3SzlndDYrRUF5ZG5rVjZkdE1xa1FhVzBQ?=
 =?utf-8?B?UExuRklxVlhqQldNcCtwTHRiSURWM053YytUcE1MVVVSNG1LdktnVmc3bnc4?=
 =?utf-8?B?eWd2MituZVg0SlFLb0ROOWgrSWx2MWdTTlBMTFRwZ1pmWGRKcUFJVktxMXdX?=
 =?utf-8?B?cUdseCs5dTdJaVlxRHQyRFNMNVpLNVpKNzMrQVkwbXVncU9IbEZLTlJIL1ZG?=
 =?utf-8?B?MzZweExMUGZGMi83NmhpTHB2Z2hHMGpQbmtYZkI4NGRnSFhDbE5zaWoyR0d3?=
 =?utf-8?Q?uVPJl+ILo0K1yz322RIraLaoaKLKXbD+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNNY1phd1RIR0R4UCtoNG5KOEY3S3QrRWJpNEt4RmxWN3BiR01IOHhYSEVP?=
 =?utf-8?B?YXlURC9HOUpoNXJZSFlQSkgrZHFNdHJjY3FSY1AyQ1JIdEc3bEVSUUVIcGNs?=
 =?utf-8?B?REo5TFVpRlBvN04yRlhOM2pLNnUxRnFTb3dBdU0wUG0yQmFjUmpRUkhVWXQr?=
 =?utf-8?B?N1VMZXBqeXA2WUE4TVdFdGN2ZU52ZkZ6ZDZXWW1EU2IyWnBrSWZaSFRybGFF?=
 =?utf-8?B?cTEvU2RvL1d5NUJXVGFHSGxLUi9BZm9lbHZwNVVJZ0N6UG1WUE45R081a0dv?=
 =?utf-8?B?Y09rS3RJRXpmUW1OdVYrUW9rbkJYZDBqZFdxNTNQREJycEdBWTBLNm54YU4y?=
 =?utf-8?B?S0s5SklSUCtWWDVBQ0IzZ2hIbVlwZHhmSk13d0JkV0JBSk92bjUyWDUyZ1pw?=
 =?utf-8?B?M2ZFcUdidnJ5U24zRU1WL04yOFNPc0tFUFFnVE40eXFGQ3JTYmdvZlBPTWF4?=
 =?utf-8?B?MktWOWoxWithaEhGb3lWUnVyVy8ySkk5VFJKZkliaFlPbnd2YXViaHBhZEl1?=
 =?utf-8?B?NmFUVGIwaVdNSVd0ck00NGpqRHA2dGNkcUtPSFMrWmJmV1RLZ0JRMzBMZEYv?=
 =?utf-8?B?ckpjMFVJUVJEamFybjVTcysydFlZRW9HZHk5b1JNdDM4dmZhZE1EQkNkYmxJ?=
 =?utf-8?B?VHkyRW82VjhONDdVK09xOVpWWnJYc0FJZ3R4N3dQWnBwa1BmeDdCM3hXWkxw?=
 =?utf-8?B?L3ZvYmFNb21VbzJZMEQxZXNzQ3JUb0RKYVVWL2E3RjhKbmJsNXRwd1oxT2g0?=
 =?utf-8?B?M3U3N1E1cVB2QWdka2NiZXlQaUhEQW90clIrV2oyZ04xbmJQZS9ZZGVVUUZm?=
 =?utf-8?B?SjQyeHlvRHF1bVhpbUZTVkl6dlFMQVhPTEN1a1JjMVFrSkQxSm5yRDd5OXdU?=
 =?utf-8?B?Tm85Q0xFRm1peDNvZmswR2I1WkVLUEdHK1dCb3FTd1FyRThwWTRkUlcvdWJy?=
 =?utf-8?B?SlFPYXRvNm5kOEZ2YmRDSzk1ZG1uNGp6Q2ZCYWptMHhtK3VTTE9aWlhCVmVi?=
 =?utf-8?B?RXhDb0NITjRJNXNoR2M5ZTBIUkNJN0JyRlk0cFFidmtYS0cvajQ2Zmhsa09o?=
 =?utf-8?B?K3g3aFVWMDdKSXFXMUYwWEVVUlpaRVNjVFZ5M2s5a3FmMjhGL3g5ZTJJblRn?=
 =?utf-8?B?bW56a1hBM0lBMW5KTXcxSGdtNTRuK2lFL0xPRGJZcW5CU2lkTDB6MjZyY2ZV?=
 =?utf-8?B?ZWZEd0E2RkhsREEwcW5aSEt0ZWY5R1Y5dEpPTjFTeEpRZDVaZUxjZHZRZFZv?=
 =?utf-8?B?azhCQk1lNUI1Y0xCZi9GNS9xTnV3aXFUYzJGU25ZeHN4RGpYRDQvcTNMVFRC?=
 =?utf-8?B?Qnp0UDRhSGQ4OGFWdHQ1WFkzVGgrR1lUYWxrZHNaNUFXa1h3eUpMVEJSaENH?=
 =?utf-8?B?T0ZqT1VnVTFTYjdFNnBCTlpmUXhRbUh6eEJLSzkwOW8vZXArQjhLQlc4R0pm?=
 =?utf-8?B?WmpSSTNONjdLOExFYU5PZldnYmJ4ZGZ6ZUdGVG5JbUZhN3Bzb0s4SHRBZDA0?=
 =?utf-8?B?d0d6VktIVGVjdDJWYzAwZnRYU1FZdytyM0RCbDlHMVk0RVhYOUhsQkVEQmdW?=
 =?utf-8?B?R0RDZEIvcVRuTTdyUjhTRnJBd0JON0RDZ1VzeWVvdFQ4OW9RMHZKUXZ2Nkxv?=
 =?utf-8?B?b1ByaTN5RjZDNm9HQi91TS9LWWRqTmF0WngzblRTSlR3MDhsZzRUcUt0M013?=
 =?utf-8?B?MUZnQVo1TGppK3FrRXY2NENEZ1BUendhRE5jSlhaaDNSRFhLTWtWMTRFZjZI?=
 =?utf-8?B?SEdwUmhuT3FPZk0zQ2x1WjVxcTlrWEg1MktIOEpQbE15ZnlNZ1JyOEdNYTRx?=
 =?utf-8?B?eUU2ZGloSEx6NkZwakFHQ1k2U2tpeUxPRElOOUdkQytCbi9jMTBrbDVOcmh1?=
 =?utf-8?B?cjVPdHJvV0NhU2l0UkxrN0p1aHFudU9uN2tpbDcrY09WVEQxdXV2dWNKVGdy?=
 =?utf-8?B?TzZHUk1COTNYamJyRDF5bldmM1laaGxPV1I1R1pPNVZ0dDdSVXNTZnlaRVJF?=
 =?utf-8?B?MUkwRnJKUVhxRjB0cGVoQk1jcUtkZEs5NU5tdXZDUzZ6UTFSUjdDY0dMNldY?=
 =?utf-8?B?WGIxY0toRWptZC8vRXJNcVhmT0lCWkNwUXdaNGcxOTlDMjlUU0pWcWUxendF?=
 =?utf-8?Q?TrsZVdu4f+B9RRZduObjoJytC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9679040-deeb-4c75-f289-08dd3568c4cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:25.2342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0YR6HLPi2RxTJxEXehdpOJXsNaAeDAwCbm0e3dBUXJhRNWnKCJakahWLSE/xkLboFo+rWv7TG047J2TvcYrpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
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

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 0000000000000000000000000000000000000000..2ad573450697ae344d8703f43d050ddd1fef7a85
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Conatiner |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Conatiner     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+

-- 
2.34.1

