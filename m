Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59808CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B786D831D3;
	Wed, 27 Aug 2025 09:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B6VZgyBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ED6831D3; Wed, 27 Aug 2025 09:06:53 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D013F83192
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfPk3f56rhDrmN9EBr+uovHsoamnTa0ABk10p2w/CPRqXg+mpiTRijsZuJfOtjw5yWuP8KjMhGoutYH13TVCY4dNWsx8CeRhMoxW6jMrhAT3GASk7Ns9UgcwB/l7Z9hAOwJfo3DSDWZgSilhD9Z4Vky5FZWtovqeHj2h2yEum3YGDNKBDWaqCWzOf9wN/IthKsz7zaF74gdp3C4JgMdpJyaGUVZWlEB6BId5NBTYG431ZNoWGjvDD7Zk/Ljs7Sitwd54yge1I68gSlIL1hpSObt9q1ORJTY7fW4TiH79jWfSlwUSMy/JL61s/aluf+l3p1kQRoKQHsopjbRvnlCJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySQPbuDK7/uSxtaIgHGAXSWobTIjFnGQFguqgttDupQ=;
 b=XxXlFlNSmS53Hu60nP1t5/mItfC0l8ZzG8BFPkC0eTbPYiumiEOw7CGzD+he9S0riUs+CeDM1mtb3q/xlMrVCAOqjchJ3upfPJ9B1EMOXuqoGAdZPQDpwamOQsZsgGL8FHLvdroMHX6ms/2SCPlMpuQfr3oRCnMRO7agrPcoLbPDHN0DcLsC9HX8FJGl1rHG3xFFoNgxzIxuJZZcDB3+XuJqsbx9TzuhRkK7GbTUaHrm+P/bggfMRwKM9iosZXj+o3diKypx5j3QG1P+TbyaeJhFXkCNVGGu4/rzk6/+IPmw5GZdn/f/N1hZALAyQ/HdhPkOOwV4u+XGRX5AGSO56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySQPbuDK7/uSxtaIgHGAXSWobTIjFnGQFguqgttDupQ=;
 b=B6VZgyBrexEKB1ZqBIJ3DbMBj1Mbh2pOuv7x3k7aluGbebJilmQ2hfslMG89Py63PO/anF3EIu+AvWhm6GoHpqx2fZHnFu3pgCl7IwejpFauW5AnqEN+WkjNeu84FR+3ocwSGp8wVXM8wmdeVA/qXPIuDdzXutmJMDrT0LfKou5ZyP3i+hZZl3OINxw0Sr2JiwmBwN5N8fD4Idg5eCBLUMbzW9k/nB16JF0TaSsgsJa+IzT/Hl+j0N/X2f0O/6okf9ramQ6NRgybOoG7PtTLxyg+SH/iOydwC4wSBjAytghMP3VMnvrQvFV+z02DLyzrQFs89B5B1fbKuFruY4Cq3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10101.eurprd04.prod.outlook.com (2603:10a6:800:24a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:06:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:06:49 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 18 Aug 2025 02:01:06 +0800
Subject: [PATCH v4 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
In-Reply-To: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10101:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f105a6-5388-4ca9-e27a-08dde5384a1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2I5UGM1bzkxWklZeG1TZS9vRS9USmpXVi95TWl0cmhyS0lJRWREendEeWg5?=
 =?utf-8?B?TXhEL0hJQWxDQVlRNm9URHlXdHJZRG05M1VIQ3BDMlRTVUtoeE9ZaG84elBR?=
 =?utf-8?B?bXcvYjlnY2lhZFdpajVLTzh2a1EwUGc5OTBWZGh6ektZNll5OVd4MzNCQU9S?=
 =?utf-8?B?Y1hCUWh2TFh4OG8xaEhMRGJHVVY1REQ5TU8zNkVETExOdXZiY2xrdkdRZU9p?=
 =?utf-8?B?Z0NsbmVtWEtnc3llNnhJeGVRTFF1QXZlcE91RDEvYjJIUDV1MEo3VjYvWXJF?=
 =?utf-8?B?bGM0cHhXZytHNDhpbUtvWm90bUdwcCtTNWFLZDduUjh0Y0QwcmR6MU5hSURs?=
 =?utf-8?B?SGRHcGtmV2ZqZWR6aUQyalJtVWdmV3RjdUNrNVgza2x1UzRWZDR2SXdPRGU1?=
 =?utf-8?B?ZkVMZHpZb1psajg5Q3NvbEpvVk9nTkQrbzZRUXpyMWszVkZEcXpxbmlPVEY3?=
 =?utf-8?B?OFdIQzZCK0Q5V295L0pVVExFb0U1VWduOVhBWUFLY3N2NmVYRlRkbFREdFlO?=
 =?utf-8?B?bmtxaVNhdVdtVWtVRVJtUklMNlZNNzJvUjlBRmlUYm9adC9YRnRkZmFoSmRF?=
 =?utf-8?B?UjYrblFib1p1SFBXY1lGVllZV0c3YW9lL1V5WmJKU3FGZFQzVGhvQmhpTmZM?=
 =?utf-8?B?YnYzUHMxemVUeW10b3RucmFVemdlZTJLSHJoY0xoM3FiM3VNR3RucXcyMmo1?=
 =?utf-8?B?blpnbzF1dVdWNndncVl2blZKenVGU1NhMWpXNFlKVTVYWWs4d3lRcVI3TGJ3?=
 =?utf-8?B?SDlsMTFOdlNka2pzVkFVY2E0S0ZxS1BYdk1JZmpld0UrK2U3SDVLSHM1YWpU?=
 =?utf-8?B?RytKQkZsMm1zSGxreGh1Y0FtdXFUVTVDcVROUnBLencwYVNYeitoZ3VBNjYz?=
 =?utf-8?B?Mmh1d2VNV004NnJuQXU0bjllVmdYRHRrWEJCRnNhZVlhL0NxV25HQ091Vnlv?=
 =?utf-8?B?S0dFQU4wTnN0MCsxcGVnU1dVa2xhM2I5ZEQ4aytCOWdZMjFHTXlzd1NQU1J3?=
 =?utf-8?B?UEY0YTZBeVJLT0thRm84ZEdOVldDM0Rqem1odkMzTlVFUkxWZHBmZ0ZVTzJj?=
 =?utf-8?B?UUdPbzlhRVB5WjFqcG9PSm0zMDZJT0xQalVjREVEMlowV2JsR3AzM2JKc0Z3?=
 =?utf-8?B?K0l0Z3cwOW9NeVJYTjR3djFVZFZTUzNRUXBEbW9Bc2hFalRVSVhHWnBiaklU?=
 =?utf-8?B?bmJCN0JqKzZ1Q3VHT3dYTlhTRk5NS2dwaGVob1ptQjYvL1ovL1BZQXdIaWtt?=
 =?utf-8?B?ZlpRRkk1NVVWblBhL0Z4RGFFQ1REQ084ZldBSDlnTnlVSzJ1YkNhWmRPaW5o?=
 =?utf-8?B?ZENoOWNKbTBTTVpFVGIxVDdac3lCNUVZakRnamFRelM1TWhxYmI4OFBLaDV6?=
 =?utf-8?B?WWEvWU9LZjVGcmNFY1Z2RUxPRXlPUzhjNzBqaTdlY0ZNcVJ0QXFRVjlJelJ2?=
 =?utf-8?B?TGxaQ0pnenBkYUx3dXZwYjgwSE1SS3grVzF0aGxMOXJpSi9TSFJTTUhKUDla?=
 =?utf-8?B?dUtkVC92cmxkTFdqUkFOenhkaDdteFBHTm5ZN2ZDOGYxR2I4UFI1TVltVDE4?=
 =?utf-8?B?UWp0cGtVWXUyTGUyQzBrQVc4bVErYlZHR090blVwN3owT0YrL1V3V2tud1gx?=
 =?utf-8?B?bmhhZHFEL2FjRGV3aEkxTGFvWDNYQk4ybXR5aGc1d1dxdHhDemlqTnZpeXk3?=
 =?utf-8?B?TUJuUENHdTE4bTB0bkdRSEkyT1hXb3lqSzYyYmZBQ2VMTkpId3YzMEpxYWdU?=
 =?utf-8?B?UjlRcENxZFFsd2VLbW1MVmZLK1lIRUc5ODUzbWRKNEhNdTRrYVFTQU5LWEsx?=
 =?utf-8?B?K3dOUzJ1cmRwbmNZVml3d3FzbU0wT0g4Ym11eTRSd25IenF2UE5iM3hOWURn?=
 =?utf-8?B?S1JpdDJsY1QrRnhwV3Zrb0ZtUTR4RldQWEQvUDJHdFl5dmw1dllsRUo3QnBK?=
 =?utf-8?B?a1JrRlZma3IxSmlxcFUvWmNUSVJha1JVcTJPRkJNMjZUWlV5c0tERHBacXF3?=
 =?utf-8?B?VHBZb0E2RlhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25Damd4YUZmUGZseDhiVGpab0xSM0RubDN3Q1RPTHBLQWJBd3FMS3pmR0lP?=
 =?utf-8?B?cXRpNUZtbDVCSjFEWVlXYXU3aDdOZUNpWlBpaEZ6WU9RWUtpMnlxM0JrUHlX?=
 =?utf-8?B?TmpCU0pLWFUrYnR3cHhhZk0rVmZES1VKOHlXTDZkamhVSVVVQUEwQ3JORzVs?=
 =?utf-8?B?OUQ3amJYaDVCTnhpUUpPVi9ETUIyYWJNWmNOQk9FRkYzWEJBQXNHenYrdStC?=
 =?utf-8?B?VVUzMEJaT3FqMXpYWk15SjVhc1ExTW51VzUzUHgzVjR3NTVEeUNGaDdXV1d1?=
 =?utf-8?B?UW5zdVU0aGY3YUpnN2tpazFvc3Yyci9BUlVFaUdBQ3hUWExpVllDVFQrSitN?=
 =?utf-8?B?S2pmbHNrdElONWVaUnFTcC94K21WSDIwcmdaWm14VnRGSHdGQWRFdTRpWWpO?=
 =?utf-8?B?TkhteXgyT0l0VWpESE5aQUJpRloyZ1dkeG0zQ0JCZklNbjNzMVFGSjJMSnFk?=
 =?utf-8?B?RlcyR3BtbHV5QzNWNFBTMWNId3l5QUFuSWRZcmRkNjg2RUx6RzR3ZFh3YWpZ?=
 =?utf-8?B?bG1WOHNmcFNUNWVuSmxodSthckJERkVKR0hjSy9RdDB5eVdveHNzQU1Nbzc5?=
 =?utf-8?B?UnFWZ3lDUGpLRU9PaDdFM1JtMkNUMmVOWVArUVpUOGpsbWJrOUxWVXYybWtM?=
 =?utf-8?B?TTVVM1YzNy9SaUJMUmgwVm55NUEvd0d4Q1dGRVhvUEFXcllJWFhjYVFwbmVM?=
 =?utf-8?B?OE1Lbk5ldU1lMWw5RWJMRHJzYSsvWjh4MU50M2hZcTFUMzUwMnBDOEN6ZnJC?=
 =?utf-8?B?T000R2VVU0I0cDlGMTRFVmZ5RWF2enJpdUY1ZDdQOXU0czROYkVMQ2hwVndJ?=
 =?utf-8?B?em41M0YzbnlDeFE4ck8vcTU1c05aSWNML3pMUHJELzU4SzZ6bU5xNkVkSTV5?=
 =?utf-8?B?WWRXK2hneDNTdmFKOXRRT2N2b21kbzBIaG5jWTI4UWVHTURob1ltdUkzZVo2?=
 =?utf-8?B?ZWxLLzNEaUVhK2U5NnZ1czQrL2k5MXh3SHdaZG9ZQ0IxZU1xemx2cjdkWUd0?=
 =?utf-8?B?b1FRMGxpQ2ltNHdteGU4clpYcGlROE1TVGtEeEVZWVFHT3E5NW1GTlFJK01E?=
 =?utf-8?B?QzhnZ2Myc1o4WjlReWpDMU56WkNKdjRDcVhMNDB6T1UvcWU0Q2Jub3BWeUdV?=
 =?utf-8?B?d2lrQmJUbmg5ZEVzODE5aTRycGJzanNIdWNlY2tpYTdsa1RRWlo2K3Z6cFZv?=
 =?utf-8?B?SGxSVUcwbHpGakRWbGduVmI4V0dPZjBib1Y0THJYV3RKazUrS0orSkF5emFz?=
 =?utf-8?B?OHA0eWQwL2lvWmVGQTRYQ3BlOUdCQ002aDZWdUQvNmVTd2VZVVFLczVKN1lp?=
 =?utf-8?B?bVFpeWhoVnlGeG4ra0doaE9EYXVUV1VIaHhzaEJDM1JlV3BEUTU0TFdwalA5?=
 =?utf-8?B?MDJTL29wYXhzWklEa1VMdm9QV2d1WEcybUpvcVllc0t0Z0d0YUptYTJZeWtv?=
 =?utf-8?B?dzhMOGtmcmxJai9RZDBoNTAyMURKck81VGNZK2x2RnBkTnFxbTM3Y3l3MDgr?=
 =?utf-8?B?TGN5SGFOTHNacjlGaVRzanpNWm4rV0cwUGUwaWp0SE9pM3FiTXl2VnpVRWwx?=
 =?utf-8?B?ZEdGVThoMFlycU56MzJSaFFwTVYwRWhqVjlmLy9FeW9ROTErYVBZUGNtS21D?=
 =?utf-8?B?NE9iemEyNUpuVWY4aEpVanZmM1BISWZZd0taNFNxSTVxeG1lZTJ5S0JYYXQw?=
 =?utf-8?B?K21kc1AycGFvWDJSbEJIT1MxYzhRVXF5Zlo2UmN3amF0N3hUSzVmTGRtQkZU?=
 =?utf-8?B?V0pJZ0V3dFhwNDZnYnZNQnVoOEhGNXRoTHpJcGF4R1ZUSkR4Q2RLMU1VTjdj?=
 =?utf-8?B?OFh6V0VSNXdTOTlzd3VDazFJMEtKbWFxQndpWU91Y0szT3cxSHl1MForRkI3?=
 =?utf-8?B?ZUhRNlM5ZHJYVU54cjgrRUwyVjQyV0ZRRitDd3U4a2NKbnB6ZFZYMkgzY0lh?=
 =?utf-8?B?V0xQL0RHQXBiRFlsaHpVTU5ucEc0VXBFZFNEK1ByV3IvWUZ2cG1SODF6NmhQ?=
 =?utf-8?B?cXNvdURLOFl1VHA0UjJvL08zRVhCSW4zN1lzelJjeUtOaGFXT0tydSs3Qnkw?=
 =?utf-8?B?dm4xYXMzemVUMW9BQUI1c0gyUWY2Z3N4SXZBZCtwaHFLTjVmTkMzMkxhRFBl?=
 =?utf-8?Q?uDClaWaZcd0tX/qg4tTIbW7TZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f105a6-5388-4ca9-e27a-08dde5384a1d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:06:48.3361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmFJz5bF/9/jYqLRzulU0lWNmaRy4ojBXdD57QC2Qn2s8R+21oD2oo28LT3KToNAes1i/eujRGJ65QWiFJ4twA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10101
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

To support passing specific commands defined in enum imx8image_cmd to
the imx8image_copy_image() function, this patch introduces a new entry
type nxp-imx9image. This entry generates a plain text data file
containing the relevant commands, enabling flexible configuration during
image creation.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst            | 12 ++++++
 tools/binman/etype/nxp_imx9image.py | 77 +++++++++++++++++++++++++++++++++++++
 tools/binman/ftest.py               |  8 ++++
 tools/binman/test/350_nxp_imx95.dts | 22 +++++++++++
 4 files changed, 119 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 12a39d070e4..8922d6cd070 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1689,6 +1689,18 @@ together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
 
 
 
+.. _etype_nxp_imx9image:
+
+Entry: nxp_imx9image: data file generator and mkimage invocation
+-----------------------------------------------------------------------------
+
+This entry is used to generate a data file that is passed to mkimage with the -n
+option. Each line in this data file represents a command defined in the enum
+imx8image_cmd. The imx8image_copy_image() function parses all commands and
+constructs a .bin file accordingly.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_imx9image.py b/tools/binman/etype/nxp_imx9image.py
new file mode 100644
index 00000000000..e82f82b5129
--- /dev/null
+++ b/tools/binman/etype/nxp_imx9image.py
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+import os
+from binman.etype.mkimage import Entry_mkimage
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_nxp_imx9image(Entry_mkimage):
+    """NXP i.MX9 .bin configuration file generator and mkimage invocation
+
+    Properties arguments:
+        - append: appends the specified blob file as-is
+        - boot-from: indicates the boot device to be used
+        - cntr-version: sets the image container format version
+        - container: indicates that it is a new container
+        - dummy-ddr: specifies the memory address for storing the DDR training
+                     data image
+        - dummy-v2x: specifies the memory address for storing V2X firmware
+        - hold: reserves a specified number of bytes after the previous image
+        - image: defines the option type, image filename, and the memory address
+                 where the image will be stored
+        - soc-type: specifies the target SoC for which the .bin file is generated
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.config_filename = None
+
+    def ReadNode(self):
+        super().ReadNode()
+        cfg_path = fdt_util.GetString(self._node, 'cfg-path')
+        self.config_filename = tools.get_output_filename(cfg_path)
+        accepted_keys = [
+            'append', 'boot-from', 'cntr-version', 'container', 'dummy-ddr',
+            'dummy-v2x', 'hold', 'image', 'soc-type'
+        ]
+
+        with open(self.config_filename, 'w', encoding='utf-8') as f:
+            for prop in self._node.props.values():
+                key = prop.name
+                value = prop.value
+
+                if not any(key.startswith(prefix) for prefix in accepted_keys):
+                    continue
+
+                formatted_key = key.replace('-', '_')
+
+                if key.startswith('image') and isinstance(value, list) and len(value) == 3:
+                    image_path = os.path.join(tools.get_output_dir(), value[1])
+                    value[1] = image_path
+
+                    combined = ' '.join(map(str, value))
+                    f.write(f'image {combined}\n')
+                elif isinstance(value, str):
+                    f.write(f'{formatted_key} {value}\n')
+                elif isinstance(value, bool):
+                    f.write(f'{formatted_key}\n')
+                elif isinstance(value, bytes):
+                    hex_value = hex(int.from_bytes(value, byteorder='big'))
+                    f.write(f'{formatted_key} {hex_value}\n')
+
+    def BuildSectionData(self, required):
+        data, input_fname, uniq = self.collect_contents_to_file(self._entries.values(), 'imx9image')
+
+        outfile = f'imx9image-out.{uniq}'
+        output_fname = tools.get_output_filename(outfile)
+
+        args = [
+            '-d', input_fname, '-n', self.config_filename, '-T', 'imx8image',
+            output_fname
+        ]
+
+        result = self.mkimage.run_cmd(*args)
+        if result is not None and os.path.exists(output_fname):
+            return tools.read_file(output_fname)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a90db3c9351..f0e45c977fd 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7906,6 +7906,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                          len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
                          IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
 
+    def testNxpImx9Image(self):
+        """Test that binman can generate a .bin file"""
+        testdir = tempfile.mkdtemp(prefix='binman.')
+        image_path = os.path.join(testdir, 'image.bin')
+        with open(image_path, 'w') as f:
+            pass
+        self._DoTestFile('350_nxp_imx95.dts', output_dir=testdir)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/350_nxp_imx95.dts b/tools/binman/test/350_nxp_imx95.dts
new file mode 100644
index 00000000000..be7e2c447b0
--- /dev/null
+++ b/tools/binman/test/350_nxp_imx95.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+			type = "nxp-imx9image";
+			cfg-path = "u-boot-container.cfgout";
+			args;
+
+			cntr-version = <2>;
+			boot-from = "sd";
+			soc-type = "IMX9";
+			container;
+			image = "a55", "image.bin", "0x90200000";
+		};
+	};
+};

-- 
2.43.0

