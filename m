Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C722BC369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B023A828B3;
	Mon, 28 Apr 2025 12:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="neJF1SQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FCA482893; Mon, 28 Apr 2025 12:38:51 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 463EE8272A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkWqwWb0GUQfPVl4A8t04o/C2MHmN1bbGxn2yfMdTUdFaVSdTb399EYRyjCg483yZATcnoEhZ0aXCFNPhAEMXCFqlHY5E3FiYiPLffPtYWr4SXsy4pB25cxzDs/zEPBIuQBs8i+2Vl+YLOKOGVcelvj+FoAwYOTHNeRbqsNjlXVLkqFzGMBBdVmpZBqOvzSMO7jz4X5jsHKA1hsRRs5xWDA7d35U0OeP1W7snpX6b2W0WwbOWZtyEIW8y69z/qOGe64mT0NHvYlAZrltovMwPdgdOcBngwD5fIF/B5I+C1LAeppcEjiwJkeihBzJtD3lcLs6uWjvtiCjpgjcEt5Ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PncURoVU2uBLb7U0sHGjp2rZ0i2oKIJPjpGwWRU5XQ=;
 b=Bol6UQ6nnC0TJjy79sFRuxBdoDIOwX8R7+RoL9IXeLV+delyTcNMdy2006UU+kBUbYl80An4LUe0zyVvdcMxd1xii5xwrmRK4mT41u3uwrFAAlWQWl9VRovwYrHlpnwssz8iqD6QYmM81Lq//WK8Vt7TmjPLrw7qFBpf8e3PlzOZw4Rj7aPJ5fKt8+c/nf55nWFF9bWCfXRAzcEXjSgEa4L918iRFNNs0+DGobF3dSDLqVY8AJfeXoYKO3fhWPgerpMs40lV/ourOca4kla0O8RZW6DirDXwKoLkMfKpfe2zXwa+2P+b4zuPPXKhsQflC3XarTpxKICzqk9ABDI0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PncURoVU2uBLb7U0sHGjp2rZ0i2oKIJPjpGwWRU5XQ=;
 b=neJF1SQspqmxW7ns1yDVnkpccAeaxqXey7w4BjUvnUk8IBgxwYlccUsfR7N6EkwZXwTbk7unjbYTKgyrqBfDPwC51McXKDfcq6iFcz3QLz78Nf9buw0TIASg1EPxDwYWw+1y9/QdQGB6lyHyCUDiDIG7H+aHpFii4MRWSdbPIL43B88YcZ/wVO1KE1NWTnaUahi2BXIEeu2AD/zpmNibyV/e9lkQGUEmKf3OWI1Fw8Ns85k7yWYhGys/lqMpQe834Nq944GHhDKSTCl5N6EIfzGuMSGeAySnA8GdpML3d3k7oRn/8eOdGsW/uxDw0XHjUrR+/3emS1/o0Jmk7v3lww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:38:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:29 +0800
Subject: [PATCH v11 06/21] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-6-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 779e842a-ea1d-47b0-76dc-08dd8640db79
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Umk4SE4wM25XanBjWUxJaUZQYjVsblJUcjNlR0JsSHFLYmM5aDFSSS92c2dH?=
 =?utf-8?B?Q052ZHlvZWxxR3lMaW9OeVM3R1NkWDhVc0g2YzgxTit2MVRwbzJNRUJJbXIz?=
 =?utf-8?B?eFlqblJzWmdDOFdjcGdNN0VtNjViTG9nSDAxaEJBbzF6b3Q2TFI0Skc0eTVa?=
 =?utf-8?B?YUZkNXc1dWo5dnBNbjZMUEhDMWZuY29xb0dGcVZlc1dCRytSeWVuMkEzMDUy?=
 =?utf-8?B?emszelZzcWVjL2NvWjVBazNBTWJoWml3RklMVVA0ZGpoZHowcTU2R3RhSXZT?=
 =?utf-8?B?czNDZEtRTzArMCtVV3hGc2cvRmoyNUY4V1p0dDV2cUxreTEzci9oQi9ZY25R?=
 =?utf-8?B?WlNpcUtYYzQ1bkRsK2JtT2NXV1VpSnQ1WlltMTYwaGROcllwTEFYWTZPa04r?=
 =?utf-8?B?Z1Q3UG1VMHNCRkhOZEpKdWVFbklaOGs5VXBuUjc0Mk9IR1kzVmFMWnF3U0hC?=
 =?utf-8?B?b1ZOR0t0ZkdpRis3ZjFZbzdTNDh3VG1UNS9ZeEw4ZDlleUttMXNNQXdWb05h?=
 =?utf-8?B?SWhCOFE1WVN4cS9CSmp0ZFpzMU1WMFkyZ1U3enNjd3ZKbjU1M0ZRWHRwUWtB?=
 =?utf-8?B?WlFESkc2VXkvOVo3cmJmNmNXbG0vcE1xZkhOYVNqZFBzczRic2lPQjRqd0Zj?=
 =?utf-8?B?TDVBRWxjd0EvWFBDeThlVG9rQnUwZWVDYzVmZ3Uva1pBZ0ZFSmkyaUFHcGFy?=
 =?utf-8?B?cy9FcTFOUm9pcSt6S2VlZXVHcGowMXkxVVgvd1R6d1YyYUVqOWx1ZSs3MzY2?=
 =?utf-8?B?cmNRK0pPeUVTZ3RwNVNkcjJkc3NjZWdjWk1yVllsa0dBM3YzbnA3eTRiOUhs?=
 =?utf-8?B?MzF0QjJKZGl4WFVIU1dteEtRSUhLdW5XZDZ1S0FVK3VYditsZkkyYlZmOEJJ?=
 =?utf-8?B?TlVjNlZaOUprWmtHSWNRTjRnSkZBNmVINjYwZ3M0VUdMcHdtUFBJWHpEU3pn?=
 =?utf-8?B?Z0hnZEgyQktabFVwdnJyU0dOTmxBaWJhUlBoQWNZcFVNRXJoMlYzQ1hIZ3Zx?=
 =?utf-8?B?VElpK1NJU3ZtY0pheHVuRURWaDM0MkJhdEo5M3BvL3VkVUlpbjZJZUhmZGJV?=
 =?utf-8?B?WGxkZlU4WUFGdi9iZjZvQlBmOHZLRjZzNzc4NVB5bllYZDMvcGVaVlhEVWs3?=
 =?utf-8?B?Y1FnOXJYK3o2MU5iby9yYmNrRnRnRGVtbkppMTlSQllnMFNRVExEWCtKaXd1?=
 =?utf-8?B?RVBiMXBGODBaaGpxYVBDeUkva21TSWV4NCsxbDBtMEFRSFFaNlNNTXBIdDlG?=
 =?utf-8?B?V3lZQ2pDMmFMYytSR2JoQ3krTmFNa1IxcGNpVEs0bElxaStYYnV0M2xsRmpU?=
 =?utf-8?B?NzBrclRvcHJlemd2dnA4bk9hLzN5ZENoc0Z4NFlHWlJ5b05sWGpYeTNsUFN4?=
 =?utf-8?B?ZVNWcHFDRENSMTlXelh1bjZtVW1wSEhuTHkzdDBUdjUyTGNTQ2JXY21vK3RT?=
 =?utf-8?B?bVphVHd1TGNITHdINUNHUXZqWXJOS1l1MTR2d2JMLzk1K0QvblpQbytJNGFo?=
 =?utf-8?B?QTRIWmdvSmZTemNNalIvNjZyTDlncXc3RjEvR2hZN2hJV3B4MUtaM3ZrdWo2?=
 =?utf-8?B?OCtnWHloUkNJTXhkR21XQzNZSGdFcHFSVmVOdk5lbEFNMlhhc08yYjU2QllX?=
 =?utf-8?B?b0tqUHBIbzNzcGp5dmRLN0lLWUwwTG83THkvMFRHQkpVd2tHTFF2b3BzQ0x6?=
 =?utf-8?B?dUd1U3lkcGxIU3cwR0dGZThQb1lESHdOaVo1OFJQcWJEd0JWbEhIb1NNaXhJ?=
 =?utf-8?B?djEvSmZhK1lZNGk0TExXelFiMklQVDkzRjQ4eklUTHVvY1FIUllUVWIvR2Zk?=
 =?utf-8?B?Qk05VWpkcUM4N1BLeXFxMXBCSVlTLzZ3NjZvS29WZFd4ckhaMHUxdTROaXc3?=
 =?utf-8?B?bEo3cDNJSlpId25HNENrOUp4dXIrcUo5eTIxVUJ3QjgvdG1POTdDUHVERXJZ?=
 =?utf-8?B?ajNvYXBpUFMrV1BxNGtud3prSjY3SkVvMGdRcmdiamVWRHI1c1NWSldrRFls?=
 =?utf-8?B?VGhXalNIYWtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snh2alRjNWhFZWg3Z05TQkdPM0dSN2w1VTd6eUx3TWM3ZFAzM2lZeSsyeENP?=
 =?utf-8?B?WE9yU1FjeEt5Nm9BUXUvcDJHa1poaDU2Y3k1VEMwRGQwbWVWeXBKVjN0dnU0?=
 =?utf-8?B?L2x3cDJPTlFtQ2dTOFRzWW5jSHJPU0RObGpjdlpvNXB6V2JtR3pwcU5wUVEv?=
 =?utf-8?B?TVVqVHVFSXk0cjRTL1IyYlpRazdVa2w0VWVFaUZhRzFYVUhxVFlVMlBlUE1Y?=
 =?utf-8?B?ZHgrWGd6SmZkbjBPVDZCbkhYVGwyckJsRmN0d3d6bUNmR09kM2VIbVpBa3hq?=
 =?utf-8?B?UjV0NytHRGdMa2NBbEUvT3JoNVRVdjl0Z3N2UzU1RjRTVDlIOWJjZ0pBMmJs?=
 =?utf-8?B?QlQza2dKcGFXY2QrblMxOGp5cnJaVWxLRzBjaUJxRFliZGp6WjNwNks3U1VV?=
 =?utf-8?B?SlBrZDYrc0I0TTgxVUJOaXliK3A0UEVuYU4vbHREd3JuZVc4K1k5Q3dEaXZ5?=
 =?utf-8?B?QjRMQnNZV2cyQnNjU1dJdklXcytnSTMycnhjUUVUNGZObzc5L3hMUTRhVU1X?=
 =?utf-8?B?UjFQOGk5ajQrR2UvRjF1NVZsZG9kbnAvWmFCQjhnR2xTV200bzVKYWU0Q0Zq?=
 =?utf-8?B?N3QxdjRtT3ZsbHdRcUp3UldFN3FrbHBJN0VCQkd2Wk1SbGFCc3EyUHRyOVA1?=
 =?utf-8?B?NVVOVVJJUUZ3bzRGMDl3OUVUSlV3eWd0TU1ITEcvMWgzWlo1a0o0SmhUYkhC?=
 =?utf-8?B?Ylg2Y0ZrYURsUlZjOHFRZTdPaisxa3hyakcxQTdoMXpjdUFQdjlML3V4UStU?=
 =?utf-8?B?Sk9qQ05yQXRnVTA5SEp4S202ak1qaWZRMWFlaVh3ekx2d0dHSUgvZjdES244?=
 =?utf-8?B?WStYS1pPOTQvbUNuM0hGbTB4YXNZOGhpN0dqdW5rSkNQM1FYQm9menZxQkFk?=
 =?utf-8?B?THhiUDR0cHNFNUpUTjE4clVNVFRLUFdkRVFDNkxUOVdjbXRHc1N2aUJsOURY?=
 =?utf-8?B?RkxvSk9MNXRubHhIRHBvN25rc0NoL0dtMTV5eEV0RkVaZFJ4MFF5bzNRSXZ6?=
 =?utf-8?B?WEk3TEMvY1BOYUUzcm8rWTJtSDZEOVVKNDcyRmdFc2FwVUNRV0pSY2JOTVBG?=
 =?utf-8?B?VStUYVd1akM4cVo0WW1rUExSL01WU2RhUnFsR3NvWmp2OFNIclBDeHBMRkNk?=
 =?utf-8?B?UDNmY3VycFJKNDdWbEJxcHAxNW9rY3V6MVZzR3B0aVU2YWpDaXlkRHRqOE9o?=
 =?utf-8?B?elVEYVFBUkdZcGJJQzRhbkQzZUZPV2UwMDF6ZDNjMDlEOUIvWDVLS0lMS21k?=
 =?utf-8?B?akwxamJOQnZEVTRHN202QjA1ejRURmY5bzRqMDZDN2RqVGdKMnFSakc5RmVh?=
 =?utf-8?B?YnV1V1htS1VwZjYzZlc3Qmc3dGlrRVh4YmMrN3dFQTRZa3FwdVRkTFNJZzFQ?=
 =?utf-8?B?ZXVaNStzZnFOS2lXSEFXTitrbmFwdmFmT01jNnVPcTZ1RGZod3MvR2daTUJZ?=
 =?utf-8?B?ZjloMER2R1Jwc2tXMlc4MStsdW4vMGk3amszb3pZcXlKQ2Rad08xb3M1d1BK?=
 =?utf-8?B?NlNaMmxkZE0veFdxNTVERFEvQWJyeWVPUmpvZERwWk5MNzc2UDcyV1I0bVJG?=
 =?utf-8?B?VW1nTnNsekFOeWV0NjVEck4wZ1orbFlqb29tS1FUNFJLZnNSR2R5UW00bE42?=
 =?utf-8?B?WGVJTHFqNkJFRVdtMXh1SVplUmQrTHpLWVZtSkVRVmRzelZzTVJPSHZkSXcz?=
 =?utf-8?B?YkR4WWd6RTkzYk5tMlRzSkJaM3g4aDNZZVlwWTFmUFVpLzdyN1hoNG8vZG1H?=
 =?utf-8?B?WXRtR2FrVGt4SkVmemhqb2w2UVFseDVYMG5TTWIyUTh0TGZyQVBuM0F1MnVY?=
 =?utf-8?B?NDU1eWREbXZCL1FCU3diRStIZnJQNWVxVnBKWE5ySXNQV2RuQWdlM21KK2pq?=
 =?utf-8?B?UGI1bGZHMkZoNnB5b0w4aHdKclQ0QVViTVo0ckc1RVFDRlNWSXRGdG1JUFFo?=
 =?utf-8?B?aERRZ3RDdmtxUml4ZzNRSnRyWG1ienRURFhQVUxyMytKZUdGNVlZZVc2dkVZ?=
 =?utf-8?B?cFMySEdwek85eUI5TDhLbVA0NllzMnp3dUYraHlObkRtWDJGK3hGTk5qSUxy?=
 =?utf-8?B?TzJmcHp0VnVxRE5FaFVJWVJtM3RVV1VscUpxLzlld3BCUm96OHNqK2IwZ0x5?=
 =?utf-8?Q?Kbt0GQc57liXzgRqlvRJ/cGGX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779e842a-ea1d-47b0-76dc-08dd8640db79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:47.6900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8zrfI/XrNnH9Mlm+Z+PiRDX8qlvPztEiOwlIm+jab1v6rt5tATQRuH8kLcJy7Dc5qh8/BAdTw0CSHTMeLYwIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f8..34f272c448c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

