Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF27C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8BA882CA4;
	Tue, 15 Jul 2025 08:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZW2zzBan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB3A82F8E; Tue, 15 Jul 2025 08:40:56 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33398277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyJBdYY8mbQXShdMPBOck3kIeVumCN8/bJDrPx9+AaWBpAeMYYKKbIRjxlxJkneSXojcjtCEBjGqTBqCBIkJUW6vBdKT1kUpzfNiuc2ysgOfK2uzmIg3uFZnAdS6Le73OAAmWotInnXi07VyumA9ypPAsnOnwvHZVhn6SP5sOa91G821c+3J104jr0ZgywrBpaH4mZtdVfRkSH9q04VvwNDMypls3zLPyk0VdJbSjsUaNofKnfszP0Gk3ui5k/npCm3okeVPligpzvn7Zoy8TM1p5PgjZZLfODgJhxE3hrIEn4Nqsr2d5nxDbieaEzf8QyXCAu/jnhNaLSZmymRWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZgqbAx/HL/26jJyIX/ITsX/m1n0deyQcERhrTUa9Qw=;
 b=yjBMjAUzMc9Oesdqa4LV+3mDtxbqMJ5+hNgfvR02enHLKU08+cq6bxki+mm32AeKHIQaCvs9SlwIk7MKDllq3nIGjFXR9a9XbvPR5xPuBZNogYILYbaBfqVZ4jGZoypwgQZoIzW7bwizdqGMDRemEIX8kocFcuigXCK1evx1aSrgfofj8+iBMZDhL/QyjznBRUK6kVVT6oIuHW1IKwVBelb7cFai86lzlOPFPr/ijc52bksnTwS2MPhKaMr58VzTUFEqr3/6k0wqsmqh0934boWyqVRSbPaK3CLQ2q+GB62x04ZqtSZ+xr3AaEzGznhHUBjdVopTdS3vjCHmJ5orkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZgqbAx/HL/26jJyIX/ITsX/m1n0deyQcERhrTUa9Qw=;
 b=ZW2zzBanvLch3DPAU/l4aMkiiIMOOi3iQho+jBtMJ+AOR5yaH9TbgOjKHD9HW/bG90qB24JBbSldLrdIuLpFZy1p9El0QTA8X/xCoRF6r8RJGxJYd+pI4gpWyvXJdceTNnHXPgshREYO9lPgKbvtIcvNpUugKx1OWmoC7zxZSfbcvk6tqMamN248Nm7iNPcfe3Hf9ejUNmE0RdkHGr77Fo040H8RWtUjUzbYjrlLKQ3VlU/Ui3tv2tkhDlm0sWZFKpjuq/e0ma/CkxRUy3sEQysm4E21f9yuEZuzqbu/faqauLZjxQe55NvQ16iCDLnbXue/FHat02JV3YQbrVgutA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:40:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:40:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v2 0/4] imx: add i.MX95 b0 support
Date: Tue, 08 Jul 2025 04:42:52 +0800
Message-Id: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwxbGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3czcCkvTJAPdVEOjRENjU1MjM1MLJaDqgqLUtMwKsEnRSmVGSrG
 1tQCApBNwXQAAAA==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: ce414091-64a2-4547-fb64-08ddc36a8b1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDIrYzZPR1FRelgra21iNGZ6VExRWDZ1ZXZSWENWNWMwQVkrUnA4dHNKbk1v?=
 =?utf-8?B?dEtBQkNwelhmdndCTDBOU3ZxWFUrZFlaUnpxbkdlQmNsTzU5WFZzZ1NNcTlh?=
 =?utf-8?B?VW9tSys3SmVCWFI1R1lOcnZ3YnVsOHFVTDBBTVo0Q3RvSkNMUTZiTVgrMEND?=
 =?utf-8?B?RU5VYVoxME9zUU9EOXhiVUtrYWE2Ri8vOEk3ZGprRENuVUUxQS9TZGlEREZ5?=
 =?utf-8?B?azRnV25GZzBTUDA1OFYyNUM5Zy8zUmtKaXhZWnl4ZXFoMEQxRUFpTGZvUFpZ?=
 =?utf-8?B?QmhMMXF1L1dtWnN1OWRKQlBRNkllM2N4OFVIaENPcHlhbHo1TWtiaTAxeXJW?=
 =?utf-8?B?dTNiMjk5ekFUZmhsVUtGLzNkZ3pMa2s1TllrUUZ6bTJuVVpSYm80RWVXaVhx?=
 =?utf-8?B?ZXNDWkUzdFhPWHhGdHJKcExxOWJ6d1JmOGNyYU1kejdnK1ErMmJPWkRpVzlp?=
 =?utf-8?B?MXFWNzA5UzMxUDhlTXFYQlNyY24wRWdzZ291NGJWcW1nMTk3Qy85RThTS0t6?=
 =?utf-8?B?ZTdsdlV3Mmg5TkFla2pIclJSUnhIRTRsZmlLNGpkRytvRFhVVDdxMnlzSDh1?=
 =?utf-8?B?SitWTitLVWVwMFlrdjlFMWhQa09NbURHVXMvSUl4b09iS0dpbnBjNFErVkV0?=
 =?utf-8?B?NGtzekl4NFVXRjUxdzBrNGVrYzR2S0d0SHZGdVk3b2U3d2MzUGxLSWNVNlFw?=
 =?utf-8?B?dTI4SWduTmpXT0tNNXgzTERSbFdEWHRBNEZNUGxSRFFEWnFhOXE3STk5NDRp?=
 =?utf-8?B?UCtILzJrWjFHQzVHRTEwS2NyMFdNaVVEQU1HRHhVWHg2QStDcXZqSWk0Y2ZB?=
 =?utf-8?B?dXpCVlJHYWUrbmpqa0ZpU0p1bXB3N1RaZTJ4b21UMXV2OHpZYTRYN01uSms5?=
 =?utf-8?B?NzJtQWtjWlVhaWQzYm1oaU1CdWI3MEhZRWJjSU9UMWY5YTBPVmdad0RXcHdl?=
 =?utf-8?B?OGY2YUNGUEdoWW1Ya0JuZDhxRVU0bVJUY1IvQnZCdmxLNm5pbDZFLzg1Rkg4?=
 =?utf-8?B?TWY4UDVoc0NxaE8yK3cxSjJNUlVRNnhBYll3OGhDZ2FGd0k1MkRaL09iMFov?=
 =?utf-8?B?RHpGVUkxQUdBbHh0SFJ2OENlQkpyMWgrc2ZrMExXdm5TZUJKNmtiTmtaR093?=
 =?utf-8?B?ekx6S0YwWmdUNjc2QlFtTEttbDJZenBEeTRPMnNFVkhHNS94WWJzc05ycHNw?=
 =?utf-8?B?ejBMOHZzQVpha3AvcjVhS3p0NFpwVjRFWXh5YW52eFdzQ1lYcFhJOGJtYU45?=
 =?utf-8?B?WUZuekFuSnc4SGlNNVRXN0VndXhjb3hENDlXSHY5MXNISm4wcjRKODN3NFUw?=
 =?utf-8?B?OFNrVkVqMW5BWFRZZXdhTDN5ZG5sVDYyNG14bkMyZmpaanJEMjh2TCtER1pa?=
 =?utf-8?B?SDFITnhjTUI5OGZQbE9qWWtOek9ucWwxOThvelBuMzFlRGNETmpwa285eUl2?=
 =?utf-8?B?VnoxT1lYVFpudUxlL1BUR092QVdMM1Y4dWc2VjJROG0vR0RyUXA1U3BDMTVl?=
 =?utf-8?B?MGFFVHFpcTJmekhjTm04UDNQcG1uUm1HT2lTT2p5N2daRFNVVDQ5eHRNQ3I2?=
 =?utf-8?B?QXp4L2dlVWwrRENhc0xheUprM3cxZ3E2UWVpbjZiZmx0QklLZE5scmVvT0Ny?=
 =?utf-8?B?VkdkNzhpOE9sVmdzb0xkVFdtQlY0TUpXQ1dtTkJGejVXWUNma2t2SU1YOUxx?=
 =?utf-8?B?SjBYd0MzRzBzYjJIYS9nY2lhSkdsU2JaSWFuRjFxdFdhQTE0MUY1cWxKd2p3?=
 =?utf-8?B?ak94Q3Z2UWVSM0tQQ1ZNalFGMGtmQTRmakxROW1OWEFDWDh6WjhXS2lETkhu?=
 =?utf-8?B?SHVmNUpYSVhOdVhJM0l5WnJ2aUppWEFJSGFGZ05FZ2hIQ3h4SU9sQnE5T1Jn?=
 =?utf-8?B?dnAxSEljaVoxSEVYWGRjVnlYeFEyL3VUcXdaZ1h6OFZiMWVTVWZDOUhIQVQz?=
 =?utf-8?B?YSs4SlZ3cS9OZ0h5SlpJUjU0K3JSNXVxdjFzbkhCeGp0OUEwWWhDOXNDS3lr?=
 =?utf-8?B?Ulo3VVA1MTB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVCYXc2b0U3U3EwQm9vVmdNZDJmbEhvM21ZTEJwY0RTakxrTy9TbjFwMmtm?=
 =?utf-8?B?a1ZxaXNySHJpblFhSDNDeFJwWnpuK1BoUENDQ3Radk5qSXJYbW0yUTdVN2c4?=
 =?utf-8?B?aE92bndCZ0hQYk9DVVhvbXRyb2Rxdyt2a3VtM2tudEc5RWlVY0ZoeUR5eE93?=
 =?utf-8?B?UnduWm14b1htMGtIcG1aMkgvazU4YmFoQ0pZMmlSWjV0UDVOTzR5aUdjb0xO?=
 =?utf-8?B?TXh0NUNqMTEwU2JDUWJvb1dHZkhRQVJiVDJHdnVmWXRjQzk0QjRCaytWMGc1?=
 =?utf-8?B?R1I4eVZYWmU3Y2s0MUh0NHhIWUI5SUNVRnE1dDRoeS96ZWlKWmpReHdhZnVk?=
 =?utf-8?B?OXhQSWNSTmE5djU4RmJkYzZZRjU4RDBjRktiTzZ4WWpkNFpWWERSZ0xxUHYw?=
 =?utf-8?B?alhJZGkyYk1JNU5GRDJtTjFCOGwzZE55WEgvTHJDWVNtdW5WK281dms1ZWx3?=
 =?utf-8?B?YXJ5WVVwMW96ZUxUM21uR2hKN1dDU3dDdW9Ua1hiVmwyZ01YWkpEdTMrdTJp?=
 =?utf-8?B?Q3crSkwzeVdoVFIvYTE2TkxweWlseERSUDI0eGo2ZHVzYURIM1ozM2NFUVha?=
 =?utf-8?B?YUFBK1BCWVJhTC9XaGFGQ0FDekhQaDh2ZmNlUTR4eng3Mm4rSTEyN3JEbjlO?=
 =?utf-8?B?UnNtRUw4dFdpZzJTTXRkNDN1dXZ0ZXFNekJzSWR5OFNkUXBQMHlyMkZzaDd4?=
 =?utf-8?B?QUJRKzBBRnE3ZmxwWjM4T2RGa3YydVJTdWJiMlFtMkpZeTJqSlNHZUdObmx3?=
 =?utf-8?B?bktTMXN1L3VFeWV2S1gzV1dZcWZGaTQ0ZXc2cmFmUTVmaEtyL09BK0pOd00y?=
 =?utf-8?B?QVZONEh6SWtmWC8wc0Q1ZnU0NmxESjVlWS9LRWtRa1BwcHBlenNLT29nU0JJ?=
 =?utf-8?B?MWRmZUJMbUwvMXpETkNJRno1OXRjWEIzYVc0U1V3S3ZRZHJSWWtjcEp0YnV5?=
 =?utf-8?B?YnAwK3FrZXg3SjBUN25TUHdxSysrWGYvZXk1Zi93dWExMWxLcTkrdTc0bzNr?=
 =?utf-8?B?dXYrMmQyb1lmelRBSjYwaFBpREV6UmRESnhoTmNsNDI3VUkvUG92bzdlWGFP?=
 =?utf-8?B?VFpLQTBOdzVIenFHZXdIbEpQTFNGcjNOWDBrVnVERmxRdU50R1NEQ3BFYm93?=
 =?utf-8?B?MU56RzRHVGRJRVo0NlFHUHRBcXpQcVdBdk05M2ZBYStHZDFJRlRyQ2JkWHdy?=
 =?utf-8?B?V2MzVi8rck1YR0Q4Y0VFQVU1cW1Ja2xwbnJTNjV1a21qWFZzQk1QbWJVQ3BD?=
 =?utf-8?B?L2xNQitSSktXTkZBTEVVQ0tjVm1DQlJ6OE96QnQ1TnI1UWJOa3NIeHJ5T3Yx?=
 =?utf-8?B?dkR6MmR3dzVoVy8xV2JXZXduaGgzSTVsZ0xGNzBRNmVqU0k3eHpIL2tvMVlq?=
 =?utf-8?B?azc0Qmt0V0FoUEh1QXprTGlmUjdJTlhESG1DRVJ4V3pqenR0NmI1OW15RDNN?=
 =?utf-8?B?anJrOFlxRno0cDlCN2xoVXJKcmxlZmY2d3QwMHVoZEdvaktPQVhCUEJxYTUx?=
 =?utf-8?B?ZnFpUEhBTHhvRml0N3hJbGJ5U0RwQjFaUkpSTW8ydHV6bHNqdUdnNjdkbE1X?=
 =?utf-8?B?MDRtRXpBZkE3RXptT0FRSklvVkpmZWxUd2ZMMWRQODd6a1diaG9Tdy9xUjJ2?=
 =?utf-8?B?NXZyUGxGVVZoZzZMUWxZYlR2eTVZRjd1c2hweFhRdHJTcGhCa0NqTW9iTWx0?=
 =?utf-8?B?MjRuWmxoUXExTUR3S25kZUV2UG8wRVdYa3lYZXpiTGtqQWVCRXZkNktzeEJZ?=
 =?utf-8?B?OWFvWWhjbHBFL0hLSGZ4Tzh3eEpCd0IvaWdaZWVKWlhFTi9HamhsQzRRYThX?=
 =?utf-8?B?YkxMUHRlZDVxdWJYakphUXY3LzluL21QNEgyTW8yWUJSajA0WVdzeXoxSzZE?=
 =?utf-8?B?TTNpTTdrdEtnRmltbTdoNGFnRm45TUNRZTRJT2Mxc2M4NFNrNHViY2NveFk3?=
 =?utf-8?B?NWVSd1pEME9VSnBOemsxZUh5RGhSa3o0OXRhM29vWEJueTRDOTBiRkU0R2lK?=
 =?utf-8?B?SDNaR3FYcVpxalhyQXFEVDMwUW5BNXQ3U1dKeTAvc2txNmp5d2J2VloyNi9X?=
 =?utf-8?B?MGJSaTd4b29oVDR4a0ZQMlJJZ3NTYU4rbEtGcVNmNUZGMUgvaTN1VTlxbnVk?=
 =?utf-8?Q?Xs2Gpv6hwvLhNcyzTC43jIbvM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce414091-64a2-4547-fb64-08ddc36a8b1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:40:52.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEvntV2x+Se2qRO3KCvtpMxvVywgfpjyXCHCRfvAytPJk65YOvhCCV5J4SN5Cb5MjOexPiqosmC/TEipoVE4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      tools: imx8image: Add 2 new commands CMD_CNTR_VERSION and CMD_DUMMY_DDR
      imx95_evk: Add i.MX95 B0 support

Ye Li (2):
      arm: imx: Update ELE get_info structure for i.MX94
      spl: imx: Add support for new PQC container

 arch/arm/dts/imx95-u-boot.dtsi            |  8 ++---
 arch/arm/include/asm/mach-imx/ele_api.h   |  2 ++
 arch/arm/mach-imx/image-container.c       |  2 +-
 arch/arm/mach-imx/imx9/Kconfig            |  1 +
 arch/arm/mach-imx/imx9/scmi/container.cfg |  1 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  5 +--
 common/spl/Kconfig                        |  7 ++++
 doc/board/nxp/imx95_evk.rst               | 12 +++----
 include/imx8image.h                       |  6 ++++
 include/imx_container.h                   | 11 ++++++
 tools/imx8image.c                         | 57 ++++++++++++++++++++++++-------
 11 files changed, 86 insertions(+), 26 deletions(-)
---
base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
change-id: 20250708-imx95b0-e12a13552658

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

