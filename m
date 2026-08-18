Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF55C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 03:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8723440642;
	Tue, 18 Aug 2026 03:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LGewGyFcCVc; Tue, 18 Aug 2026 03:15:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 353DA40800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787022912;
	bh=mtsqcFM8k050YExxUO6Lz0/2MCaLcX+2t/KGRtKXJbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QsWrMm45ULO47HbTOYGR2GA2wLJ9oF1IrDb10Ma2oYl/b3eLUhzarGNlzQ2CwYIlI
	 WryiWabiqi3KOFttfPbYLosLQtuijTXsv5JbrdUDtTBWISCTy5yMX4yFvZ55FE4L9x
	 YhlAYPkVywvR53Lz7SgYYo4ORXsrvWwGxqbfcsV0iUriKNEKFqHZUWqFDvQne7Ttky
	 JXWepUILANdckknbPDZanUsnpaoTzLJbRAxjZUu9YfPlBotlyesIFxg7ln04RKe3Y5
	 vT1eIi7kGrwNYHrum3X5QeuppI75FDKKgsjVOzyDASkU0txYaBLUP9pqhJqyKgqwaX
	 /gT+jzrPTFn0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 353DA40800;
	Tue, 18 Aug 2026 03:15:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3163E322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1789F40642
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qH26JwtMrS1 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 03:15:10 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A87C94085E
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A87C94085E
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gDEDl8xy
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A87C94085E
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYrqdPKHNaloCqjn7dxP7s0WE+tqvEPoC/SuTSxGIVwGYe98h9TTxA0E3NkbRD9maKKB4ZznH6uqBPY+VJL/Ba7Eyyi7SritMsi7ExW0d3WAvAZ/tbgBsp15r5ZVUZRJAiOhUlJiuGo508iQT/3e+olA0UHUPQjQM4Ks66X6zWp8C2LxOt0EIf5AOogsFqOReBFA+4wnd/5j1UV6BsGkXqS2f2eBsGClpXn4jiQDaPpXpbEsPc/cz0ilNJrc20GbVqJmpbZRPMOAOLwO82hPLQxYDu4Ud0qLzWT6p+8wBvozqE6O+ZXK278pAQROQP1e08DG64snY+7IThFD+S4ZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtsqcFM8k050YExxUO6Lz0/2MCaLcX+2t/KGRtKXJbQ=;
 b=d8xhKq6TDui0TLULzG+e29e+iVKRefzV6n0kdKUQhucV9xb8MGqHyB9B5ZBZfJaJjirMLAazU564XB4AaLOkZG8FU2EMS/gSC+5PtY34JwHr/G/PEGlr2QqiCH6x0hBoTgJVEf6P5cjltB6sxeMH4yee1jGNBv6JRYVlvQRlcqPQuP4rF0YMfm47wZI2lpa2aLfh6NLUJN3Kuv7D8zLT3ZoJME0gbqR8QNe4yMGfjPEbCJZro0YeVOhs5gV+/a4teq829b/+gBgZNJWeU4caTLCWJlzRYDsMCFLryMpIXvXCTlzOIcW5VcuFiKZOLNiRraf+1LX92h0YVxsaxWfkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtsqcFM8k050YExxUO6Lz0/2MCaLcX+2t/KGRtKXJbQ=;
 b=gDEDl8xyxf5XeoIWwQsdPHP3bceCFRpJqqxp39NzlBe8fH42X2ENqm5h7RXD9ksD0fZ0qFxozUMteEsYnth3NGVVWFLLYFYLWxKHH5LQ6KG0hvlmPC6eIlABhSfaF+Zl27akNMtMip8nOWnVowyhhXuTy/VjtxW4vZi0HQlAaJXW+nTzeQqnUuZhf/XnHpZdBro4a7x7x8RjXRlYfOqm7mhl05NHy9AL60ch3kefED7gRBflJ6Wpxa0N/1sWhR/f+Rdu6M4FJIDQkqhwBWdFHfd9mYlDkK1Rc5nGiPmubb0BhAtSfjQDd0pHTc+jGsaYtfAqJ3Pw9yc6WdV7ANcy+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI2PR04MB10113.eurprd04.prod.outlook.com (2603:10a6:800:230::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:15:05 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 03:15:05 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 18 Aug 2026 11:18:49 +0800
Subject: [PATCH v4 2/3] net: fsl_enetc_xpcs_phy: Add SGMII 1G support for
 i.MX95 Ethernet PHY Wrapper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-imx95-v1-2-12ef3eea3943@nxp.com>
References: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
In-Reply-To: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI2PR04MB10113:EE_
X-MS-Office365-Filtering-Correlation-Id: 520a5fdd-f1e1-4353-ed75-08defcd6e63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 9DOAtI/ujyAnIrNtp6bVDaMqa6C/eANIw7e0P+Pkip+Dq4Zg9sI5yvX+h/KLPuGoi2X/MaeFITPM8W6nCj+yWcBL8OcDe5cqfCg/C5BhY8aaMSJptuZ/2MUOAj2+2p8IqQSBOsp2GKb/7aEd7s7/XZSR8pf7Hxv50kwtg6X9zc8fi/sfiz65JOBSvINfzDgailYgIcZxD+PTvDCIt7f48B2o1GXX4bVllX+vgxZAhG1LqARDcIoCJht+56ACG+VogoQfExNJ1Bd4FZeeQ4+giCY4AAQXDkiNmTWC6PA8aPkYOQcJOEi8NT3ZejHZnA+cyedMFqMVHJ+EwC3wsgvLMbTFeIyyxvWlidlsvJwWl5uUvpl4F3gWB7O/3EHY/rvnjNgh1t1VDK36IJwlsylEAI6V4kZ/of1DnTRExoV8FZ4UKHCGgNVInlR1/uB/PXQdyRdkqqs3RHrxVyjJMxR3vrzAZGcbcPwCBEZynj4UEDZ1fbXqzRkqQw4IoMzKJqaxecSOf9gbB/8QD25YO6WJAIoJHXomxi+l+KSHrkrgd1ufq0QBw0GwSbrjT+7PQr1008i94Vj/Hj530RyutvccKQImtheEAbminVD8IFgPetfkbminTtGdoHIhj+zN/P/w/p/Mu3SJgMVEXtg+GmFLq3wuW24zvZPj4dXuSNrMI0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2FMdEs5QkVkSWF5amxEakVzTm53V1h6OUxNNWljb0RGZE1SOG5OdEVyR1RP?=
 =?utf-8?B?N0RmcFpmS1ViUkIzQnNrSnBlWndYb1Nab2VtOXc5MmtqYXlhUGpqUmlSeUY0?=
 =?utf-8?B?SlUra3BUOXhBZ3I0WXV2WmovOVJQZ0htdWpEOTMxaU12NFh4NnZTcytDejc3?=
 =?utf-8?B?N0VZY3pPdW4zVzdtKzVtME5WSjl3SlUyMEIwN0hNV214Nk1MMkVnVGdzSUEx?=
 =?utf-8?B?TmcwdElWMWN4SnlQY0dqNlI1Y3BUN0R1NVo1SFl4VnBnZGpDWVBtWG9idWpV?=
 =?utf-8?B?TE9haThxdXJGeHJxcUJ2cTVOMS9ZelN3Yms5dFllcWY5UWMveTdNZHo3SnAx?=
 =?utf-8?B?K0kybDJ1Umx0eVJRS3hXWVBoeUJtRythUlpqbGl6RHdueDA5cXpuZncvL1d5?=
 =?utf-8?B?SFNKbU11UklQM3krNTBaTFRNVXQ0aVpnRWI1SmRmaDJnZVd3NGNwYmJYTzJm?=
 =?utf-8?B?YWoxN256U2dwSTBSa0RJdzhGZkYyRmNaR3VyMGtsdUpFaXVIeGM1WWxlbVRz?=
 =?utf-8?B?WG1senRxL01BMGZYMFJxS05oWDF3cGMzS3hLR08rQitES2NPTUtyYXorUEtJ?=
 =?utf-8?B?RlF4bzNndTcyTWxoOE1xUXJxa2pUR3NKTnVOcHJJTTFCWVJmVFROQzJrL3lS?=
 =?utf-8?B?dTJyeENxU29oNy9Xd3pYQ2poODBoeVNsbFIyVXVUMEJOY1AvZWYya1Q2Wk9r?=
 =?utf-8?B?VGE4NGN0TFJFeFRXb0wxdzE4NXpVeVJPY1ZQR2doNkZOWU82NXBhTTlQREY0?=
 =?utf-8?B?UTVqb0pqWGROcGs5SHN3ZlJRNW9NYzI5RW5uWnhZQ21SMldibEtMU3R2bmVV?=
 =?utf-8?B?UEo5UXk1cHNiVHBHZGNoNElRWHJMRU9kMmRFU2ZYQ2t6ZTR6d0Q4bUhjRFBr?=
 =?utf-8?B?cnlyU0tGenZFZXFBSExJNHFYbmh4bWwvdi9YWHBMSk9Gb2RSVDluUGpiUDQx?=
 =?utf-8?B?dkQ1enNzS1k2L0E3alQvNFFlbUlQYUV3V1dJM3NYNzkvcGhmSzRNUFNvRDBh?=
 =?utf-8?B?YmJobTM0OW0wMG9XWGI2MGVzM0xZbW1WSzhiY08vZnJiZFRXTjNRaUxnVnNz?=
 =?utf-8?B?dk9scE10d2M0VmY5SHVLbjAreitKbHNwSTBkZk1BOWt3TitJUHFFVHZZMkNv?=
 =?utf-8?B?WUJwM3UrbnNsazV6VUovVk9EN0h3NEExdHNLS1pCWnU3c2ZSa2VTMVBjaTRj?=
 =?utf-8?B?TUpnTFZQbE1TeWhIZVp5Nko4UExYai9FUDg4eCtnemJsWkRBQlh2dG1wTkUz?=
 =?utf-8?B?aU9JN2FqYXQrRXhjZDVaeHMzcW1ZTUVybjYxeDhLMHVwOW01aUppdnRjZW1T?=
 =?utf-8?B?NHgvMlpiU2UrQjJzYmplcklRNjg3bUNFdExJRTVTS1ozMGhCYWd5dGNNd25j?=
 =?utf-8?B?WVorcy9ZNjF4ekxuR3JaQlFkMHJMWE90N3lNamc1TUdFV0J0M1dhYk53Mnd2?=
 =?utf-8?B?MTlTMHZEY05hNDJJS2JCYlIyQjQ1K3ErOEc5MkFGcXhrTEhXbEFkTFFvYm50?=
 =?utf-8?B?WE1ZUVVvU0xwc29sS3p6Sm9wUkpPc1J2QkU1ZGpXY2Z6TGJyS1krdzJRdDAx?=
 =?utf-8?B?VlhUQkV0Mjh1TDFYMjRPMDRVS1hNN2F4ZUJrUVVFRkZHcjBMTUxaSEEwaU83?=
 =?utf-8?B?UmdDUDVxVU9EUnU4NlpQVDdVQXA1dzcxaC84VFh3bmdhU1NNNmN2bzF4MzJK?=
 =?utf-8?B?UVBLNGV0VFF0aDFFZHhoWVBUeDd0ZUVPeStpYUxEMTVpaVJ4RkVXdDZZTDhW?=
 =?utf-8?B?bFVmdjV3dFBLK3ZyN0VwVjBoOW5iTmdHK29kOERRVzF2clVLQ0VVVnVLY0ts?=
 =?utf-8?B?eWc1cmRNTEJrcDA4dW9ZUVZKRUc2RVFsY0F0OWdmRGszKytzRmcvdWhjb0V3?=
 =?utf-8?B?Z2lRNlB4dHBicWdST05nd2FITGVoVUppN1p3VGhGV1lVOGpxTUtmNVJPelI4?=
 =?utf-8?B?UnF3TllPR1d0bjdsamJzU2hZbHRaZGFGMjAwK2J3VU5KVkNYVlRCcnVkOXRz?=
 =?utf-8?B?RmFibE1NMThhZkJNQStqM3kzYWZObm9hdDJqazZrSTBKbkdkSjk0dTFrSHlh?=
 =?utf-8?B?TTlwSm50S1R3OFFhaWp6YmYzTlg4MTljK0FuZ3FIK1lxOGw1WTcvV3pwMzRW?=
 =?utf-8?B?WEtzS3ZsK0lsdisvRzUxMEpxSkswTFZiWkNYZXRudldmUkJFZUorV1ZLMHhK?=
 =?utf-8?B?QVM0cWo3dVpCYjk3bGxOaEl1SDhCUTZBS21tbFg5dUNJZ0VXWWk2a2YvN241?=
 =?utf-8?B?NlllT1BPOGdQTXNSbm53aXh2Z3B6UjUvWVo0OVVTanU0dlZKWVg2NEFxNUt2?=
 =?utf-8?B?eFdnQlNZbktDTXlmekNLbzJsMGp0eHdrR1JzY3FBbGRHZWI4UEpYaEUxL1Y4?=
 =?utf-8?Q?P8X2v1CA/tfXFvRjBMAuifR2G3GUTyFZC7jTF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520a5fdd-f1e1-4353-ed75-08defcd6e63a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:15:05.1959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYw/kAbJ0KLHhRc+xRo9s371qK10FedKWliwFPzgW9jJiSEVINBLrfpnEBjYWEbSSQHgIAnR2tVTFvH2Yn6lEX0ldU7txRRjgVrQ1eaSPV/GJZi2mxkuZfRDG4G96HmD
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

Add support for initializing the i.MX95 ENET_PHY to 1G SGMII mode. The
initialization sequence is implemented according to i.MX95 Reference
Manual Revision: 5 (2026-03-30).

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 521 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 521 insertions(+)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 006a2bd2238..e7fed59a0cd 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -57,6 +57,8 @@
 #define PMA_MP_16G_25G_TX_MISC_CTRL0			0x1007C
 #define PMA_TX_MISC_CTRL0_TX0_MISC_MASK		GENMASK(7, 0)
 #define PMA_TX_MISC_CTRL0_TX0_MISC(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_TX_STS		0x10080
+#define PMA_TX_STS_TX_ACK_0			BIT(0)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL0			0x100A0
 #define PMA_RX_GENCTRL0_RX_DT_EN_0		BIT(8)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL1			0x100A2
@@ -102,6 +104,8 @@
 #define PMA_MP_12G_16G_25G_DFE_TAP_CTRL0		0x100BC
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK	GENMASK(7, 0)
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_RX_STS		0x100C0
+#define PMA_RX_STS_RX_ACK_0			BIT(0)
 #define PMA_MP_16G_RX_CDR_CTRL1				0x100C8
 #define PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0	BIT(0)
 #define PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0	BIT(4)
@@ -198,6 +202,7 @@
 #define MII_CTRL_AN_ENABLE			BIT(12)
 #define MII_CTRL_SS13				BIT(13)
 #define MII_DIG_CTRL1					0x10000
+#define MII_DIG_CTRL1_EN_2_5G_MODE		BIT(2)
 #define MII_DIG_CTRL1_CL37_TMR_OVR_RIDE		BIT(3)
 #define MII_AN_CTRL					0x10002
 #define MII_AN_CTRL_MII_AN_INTR_EN		BIT(0)
@@ -959,6 +964,522 @@ timeout:
 	return -ETIMEDOUT;
 }
 
+static int imx95_xpcs_phy_mplla_configuration_sgmii(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 2 Config MPLL for SGMII */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val = u16_replace_bits(val, 0x6, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val &= ~PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0x14, PMA_MPLLA_CTRL2_MPLLA_DIV_MULT_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_CLK_SEL;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL4, 0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val &= ~PMA_MPLLA_CTRL5_MPLLA_SSC_SPD_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0);
+	val = u16_replace_bits(val, 0x20, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val = u16_replace_bits(val, 0x5, PMA_TX_GENCTRL1_VBOOST_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(0xA035);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0);
+	val = u16_replace_bits(val, 0x11, PMA_MISC_CTRL0_RX_VREF_CTRL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0, val);
+
+	val = PMA_MISC_CTRL2_SUP_MISC(1);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_MISC_CTRL2, val);
+
+	val = PMA_VCO_CAL_REF0_VCO_REF_LD_0(0x2a);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_VCO_CAL_REF0, val);
+
+	val = PMA_VCO_CAL_LD0_VCO_LD_VAL_0(0x540);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_VCO_CAL_LD0, val);
+
+	val = PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_PPM_CTRL0, val);
+
+	/* 3 Configure LANE0 for SGMII */
+	val = PMA_TX_MISC_CTRL0_TX0_MISC(0x0);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_TX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_TX_RATE_CTRL_TX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_VBOOST_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_TX_BOOST_CTRL_TX0_IBOOST(0xf);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_BOOST_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_RX_RATE_CTRL_RX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_RX_EQ_CTRL0_CTLE_POLE_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x12, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL3_LOS_TRSHLD_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x16);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL);
+	val &= ~PMA_RX_CDR_CTRL_CDR_SSC_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val &= ~PMA_RX_GENCTRL3_LOS_LFPS_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4);
+	val |= PMA_RX_GENCTRL4_RX_DFE_BYP_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL);
+	val = u16_replace_bits(val, 0x0, PMA_RX_ATTN_CTRL_RX0_EQ_ATT_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA1_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA2_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val = u16_replace_bits(val, 0x1, PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_TERM_ACDC_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val &= ~PMA_RX_EQ_CTRL5_RX_ADPT_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x3, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	/* 4 Configure XPCS for 1G SGMII */
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_CTRL2),
+		   PCS_CTRL2_PCS_TYPE_SEL(0x1));
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val |= MII_CTRL_SS6;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val &= ~PMA_RX_EQ_CTRL4_CONT_ADAPT_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x6, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x6);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x0, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val &= ~PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	/* 4.1 Assert soft reset */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+	val |= PCS_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1), val);
+
+	/* 4.2 Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_SRAM);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	/* Assert SRAM external loading done */
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0),
+		       GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
+
+	/* 4.3 Poll for vendor-specific soft reset */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_DIG_CTRL1_VR_RST);
+
+	/* 4.4 Assert TX0 clock is active and stable */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_SUPRESS_LOS_DET;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_RX_DT_EN_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
+{
+	ulong begin;
+	u16 val;
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	if (an)
+		val |= MII_CTRL_AN_ENABLE;
+	else
+		val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
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
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val &= ~PMA_POWER_STATE_CTRL_TX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val |= PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
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
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	int ret;
+
+	xpcs_phy_reg_lock(dev);
+
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		return ret;
+
+	ret = imx95_xpcs_phy_mplla_configuration_sgmii(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_2(dev, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	if (is_imx95())
+		return imx95_xpcs_phy_sgmii_1g_config(dev);
+
+	dev_dbg(dev, "SGMII 1G config skipped\n");
+	return -ENODEV;
+}
+
 u32 xpcs_phy_get_id(struct udevice *dev)
 {
 	int ret;

-- 
2.34.1

