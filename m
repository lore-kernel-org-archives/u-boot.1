Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733EFC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFE683212;
	Fri, 18 Apr 2025 16:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ISZz9SeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37C508321D; Fri, 18 Apr 2025 16:33:06 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C8782A46
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhLYujTbqBTk8XkNi+a2SW6O8hSSbevbpyhD1S4cRMPv+rIFwH2RXZnnJ1u27NZm7hyVH1vFAiBrjzSzTgWVVaIqYUGmKQhYrKlZEY5DgNxdkS248HPYH0UQYF18pQx5kxNkumEAI4OycsgNu4H+zAd+/xuMiR5S8B8yxZ8cdxuLBYmRhpLha39ZNoneFySGFQdjyhRppR0oBjr/gW5HZKVeedFHv2pfpU1E3AD4LabFZics0RLtTjS82U1zZ4mbtqEBd2EEWIpKkGfOt/I5YrPJfEXNDsMdPCZ8Gk8hjYO3Jmt7RBih+uyhV7ebFnaeKbyB9uW8UHSiviD6ymvGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kzWUk7iCVldCgbKfYabnTkAkZHqEvflUk07dNWzuDg=;
 b=VFT4qFQZgZKOBUaHvzPGs/3/sYKN3wox26xqTZ15dMakUmZOKdjINXW5IBYO4Ps+55b8gValh2fROD0uuMep0GBCRY93UoB8lF2mLYhpDzdFAZ0mmG28obNeUAk4Woj8sKMRdo7kGLWK4QDp/X9e3oIfxbkoEJ3768VrdNU/aUky0xMK3Arwb9264jUjZfv3B7rYny+77pDuIIHIOx5hJ1ELVTmguXXheCXGgqpWsyFaHTs8puawIFST5UCG1UumwBTipIakX7ybFVYQvOoCuVbLB0HimBJnHvXB78XPH1oV9/qvWG9ydeRaNYCd8wTWzTN2l03wFfscRPTPModlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kzWUk7iCVldCgbKfYabnTkAkZHqEvflUk07dNWzuDg=;
 b=ISZz9SeFpwDHkLjBYLmeJrIgDny31FSWu2ab2muQVLwthMKoX2daeUatuSlLTz7/8inMJRcSwhM2manhGm7Dol16zcAKtqoHG4vF6YqCeTx9fayaPlSQS3EqNG4QsbOIQOh5H4z9P0tWOTAH2JXr8r+AonGt7RxtYE0AcvWT+E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 18 Apr
 2025 14:32:59 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 14:32:59 +0000
Message-ID: <ed09ef74-2723-4add-8d16-a5ffb4bd8ac4@cherry.de>
Date: Fri, 18 Apr 2025 16:32:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <3148f171-8bf5-4412-97d4-684c6c456499@cherry.de>
 <CAM=mAOm1SC_SjkC6AYr4T4ThjAMCTF89wz4SVuwOYaN5vj2H5Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAM=mAOm1SC_SjkC6AYr4T4ThjAMCTF89wz4SVuwOYaN5vj2H5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU2PR04MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 698b40c7-951c-44ed-3dfd-08dd7e85eb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEpuTENFZjFFQnZna1hIU1UvenZPNkl3Ly9ZUW9jZm9sTHcvZDdsSjQ1cnFr?=
 =?utf-8?B?dGxRc0VOVW9UVE9lY0ZZcnl0Z2laSVUyV1J6cDZ2K0FhSFkyMFJYaEVNbm1h?=
 =?utf-8?B?VXFQNU9PcG5peEF6NWNFb1BaMk9aTVhqblNVcDFKQnkvenU1dHdsM3JvQjFl?=
 =?utf-8?B?UkF4OW43dGkyUmZQZVhia3N5STNoSnZCOWI0ajdoZDdvbGZIU2FIblRuZ0lv?=
 =?utf-8?B?ZEdUWE5JVURRV0prV3pjdWVyazVmckFBNUw4YUZYbzRxT21rd0pzT29BQ1Rn?=
 =?utf-8?B?MXFlR29kK0RMaXovWmo3cll3dzFiS0lJbVY2YTFGWGIwbVowZE5YWWt1cCtX?=
 =?utf-8?B?QTVGeVBrOHhtUloweFQyR2ducHpqOXRlUUZMOUdzQnZFT0JqS2dEY0pucEEx?=
 =?utf-8?B?cDdEeHRpeDZKeG40SDdzSnRZT0s5UGxXMTZwbUJXVEJ4bVgreGdGZDVzb3ow?=
 =?utf-8?B?RlkxbXZNd204djJEbmFERElEWXVOVmJsdGcya05vNHZBOGNzaDJOQXBtUDlO?=
 =?utf-8?B?M1YwWXdMeDFzN25DRUMyYjcrTmxYS2h5NktRcVh1ZVpUTlExYWNGWDBpQ3hr?=
 =?utf-8?B?Z0wySnlORzEvUXFLRVB6dXYvYXFDV2padER2bTk1NGpUbnh5M3ljV0pRbUM0?=
 =?utf-8?B?dDVBQ0U3SlpaT0tlWWJGOWwveWw0ejk1byt0NzFYSE9TUDBvdzduMGVFKzEv?=
 =?utf-8?B?L0JMbHpxS1ZXREdkU1dWQnJsbTNnSGt1TDk4OUJKbkwwTkhLM2RzM0FvaDhI?=
 =?utf-8?B?R2Uwc1ZRN1kxWTg1Z0Q0dU5JNFhHcllNQUV2WFdqajFxNkJhVlVWSFUreUxZ?=
 =?utf-8?B?MS96WVEvQktjOTkrTVdJRm90ZE56cWJDbWZUaWZUQ2l4elpZOWVUQmhGWGZk?=
 =?utf-8?B?MVpHWk00T0lma0taZk91TE9WMllIWnJ3UHVPYlhDbVE1QnUzMVE1dENFajZK?=
 =?utf-8?B?Q0w4Zi9xNzliZklGOEhUOEJjSTZiVVV4SEtLZ3k5cytNVzhRZWlmZ1JiNXB0?=
 =?utf-8?B?NkNvWnNLb3dMMjFRazBsbXR0dmRYblpqdVJSNDVIaWFOZHRNU2FPY0lYSzlx?=
 =?utf-8?B?ekRJUjJyK3h3Zmlpc3pNa2dXNCtqeVViczl2aCtVb2cxbmcrMWg0V1JxZ1V3?=
 =?utf-8?B?U21VSHByOGNGcFN4K0FFZ1kwOHJ3SWg4NGgyQktnR1BuSzcraWlENERRSUhh?=
 =?utf-8?B?Qk51L01BOVRMODZwR1RqTlF6ODZSMFJtcWpVRng2VzV3OHNIMjlQUWFxNVRY?=
 =?utf-8?B?bkJLOWdiT0puaDNHTHk0MHU3eGFtdXNBbFFoQnRkVWtqSlRXbWU2VEFpanlC?=
 =?utf-8?B?RnRLSUJINS9xRHYzd241N3o3ZG1VUUlJOXFmZmdOc2ZiN29yTTlXQlhKRXgv?=
 =?utf-8?B?ZDhFWGwybDh1UkJDK2pxQTkrek5NQ2dpUnk2NWdBQ1FKRGQ5bzFvZTc3dXRi?=
 =?utf-8?B?R05XYS84SC9NZlhXVjFSb2I5RDUvSWFsTlVsalhyY2pLazhJQ20wQTRqNEY5?=
 =?utf-8?B?MUZVRzBRZXlPSDRYNGptWFF4NXI1dnF4K09uWFBVRzZnWFRkYlRLVDU3Ky85?=
 =?utf-8?B?Wi95eGtyLzlWVmliNC9qbk9tY0N4djhuSU9ubzdXaGUzMyszdUVQZUwwZzFz?=
 =?utf-8?B?akNUZnhES0cyeTgweS9KQnU1TXF1emRlUVR0N3BJR1l6Y25hQUdhNUlkR2dN?=
 =?utf-8?B?ZFQxV2VpMEYzWGR1NW9CUE1rZlpVQmVvanNLaGlpVFZoYlNndW94WXJVS3RT?=
 =?utf-8?B?ODZqZkJKQkxOZEdvRTZvV2h3ckZnd1NVOEtzL0hWZTg1NjZ2MjVzM0Y5M2NG?=
 =?utf-8?B?c3VPK3FBMzVURHlVQytFQUpQUGFMSW9oTnVQQjFXa0gxNFNUV0RQOFRockFY?=
 =?utf-8?B?SHRObXQ0QkVmczltV3dQeTVNLzU5eHpGb1ExNDlhdjhNMjRZWHk5UDZMRkxX?=
 =?utf-8?Q?L+oHJzJ5RM4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zml5eEw5em54Z3Z1RGU1R0xCMnM3dW12VzNnM0NqTnRnSGF3d3UwVUNDMDBH?=
 =?utf-8?B?bzdrcWRwakcvdXY0SytHWlQvT1lLZXZOSjByeCtZZmtqUzdLRHhUUkpxd0dQ?=
 =?utf-8?B?amxSZjQrYnA5ajVkVEJMejluYldmL2Nsd2xkM1I1WVJ0UUsva092b1NhQ1pH?=
 =?utf-8?B?OUlsT3hLdEw4dmFNa25QemxHZ0xqZ1pvWU56NSt6SXJPdjlwMjdwdU5YTjND?=
 =?utf-8?B?L21uUlh0dHZJdVZFTkdBS2U1ZDR5RDJ0MHJTVHRPVjU3c0l1Vko4NDZ6Rzla?=
 =?utf-8?B?SHdmTUFkVURWWStGbDZSbzZHV05maDJKWFovRG8yR3RETWVDYmZZalorNzFQ?=
 =?utf-8?B?T3o5RTczdDVzKzl5eWY2bmhHL3FjOXJDUkhKaWs0dVVWYW9CVkpqWTM5ZWF3?=
 =?utf-8?B?Tk1RampWUGdGNVREUnk1YnV0RGpMVWpYNm0wOVR4TUFvMWxqM0FwYUhDYXpN?=
 =?utf-8?B?VzRPZkZ6SVEyV0JyU2JlKzN4dUJEaS8rMHM0dUFGWVU0b3dsaDBWRU81TVRB?=
 =?utf-8?B?NnNON2gvSVhrVisvdGROTjMzbzJnZzI0Y1NWajJsZDJQMnI0QWo2SEFpZnFl?=
 =?utf-8?B?dVdKOEQ5cy9jcDFRWWo1NUJXdDVPZk83V1daM1VZeENMam1YZEEwWCtqMHk2?=
 =?utf-8?B?aGxQRE9SMU0vY2FrRXJ4SXJqcEZrRHRkNEViTitxZy94SzNmODBWa2s1ZW1F?=
 =?utf-8?B?VVZyVjZJT3loYjIwVTdNbkt3dUtoaENNN0lrZENweW1VMllwTjlobHRHZVZv?=
 =?utf-8?B?YXY1K3pMblJoZHJaYU5YY2ZEZitqT3R2emhURnVaZnhvamJPWFl2VWp2RFE5?=
 =?utf-8?B?aGFocFk4akF1aTI3RkZRNUZmNG5MdUc3QXQ0eXZTRmxhc2xoYzlQOGMvRTQy?=
 =?utf-8?B?SURsVEswTFgvakZlTUtTNjhjeVdtUG5GakdNMEtXcXJzaW1SMEhacmVsMGdh?=
 =?utf-8?B?S2ZwSWRJSm1DdmE5QmJ4SG5VaFRqOEQ5N3NVZS85ZmZqZFE5d3VZeFVoa0hO?=
 =?utf-8?B?OHJVZlRscXpubkx3VzhwT0tIakF5TGFtM1VpTUtPei9rRFk1NEZJNVNUWmVo?=
 =?utf-8?B?dkp5emNWNU9RQ2p1NVhlY3VLaWlQcXJHR1hzR0tFRjMzVE0vbFM4UEFxMFA4?=
 =?utf-8?B?emdiWEZnOTZLLzFtTnhPOE4xSHV2K3prUmVjZkZFb05leHdxQVp5ZS8wTUxJ?=
 =?utf-8?B?M21ERDN3OE9yTG9RNk5JcG9KTGJkSmhUSVpUVmp4N3c5SkhaYnJzTkw1cTBT?=
 =?utf-8?B?R2h6b0EvREpZODlhWGZNbkZLM0FpelhvRVN5eHFWWklzQ08rZmNqa2k4RmVm?=
 =?utf-8?B?UVVtV0E3aURONnV5YTlGNHFBU1picnpDL0R0NTRtNStVLzQ3eGROS2NwYnNK?=
 =?utf-8?B?eWxwUmZVRjlDTjc2NzFaOERoMWt6eDQwbHAwUXpZa2xNaW43ZytJaXRQbElC?=
 =?utf-8?B?YlFETHhDd3VuTStFc1JZZTQrcTJpczFTYnZTWWxGVGpuUUtPNFd1WVcvQVNi?=
 =?utf-8?B?VnhkdEdsQkl3ZXdtMmswMFc0R0RBM1pTNmVsUU1tSkRFM3R4YXdxWnRZL1ps?=
 =?utf-8?B?S1hKRnNyK1VsbUhsY2FOZzJDRU5JR1dUSjBaTE5mL1UwS2xsNjlTQVZwcGRK?=
 =?utf-8?B?MnBCNGNsRlVEcXEyNFlQeTBFeTE4UXBITzBlc1ZkMm01TkM3ZDdFdmRnd2Rx?=
 =?utf-8?B?dlU5bEphbzRCbm1tcDF3ZkxuRnNMYkhiYnhxZWFRMHBUTWczdEpDMmdDY0FZ?=
 =?utf-8?B?OW1hZXMwQjB2MUZ5UGZwanNkUW5ZSUlKTWpwY2wwa1lmc1NVSEFQMXVpOE4z?=
 =?utf-8?B?c2FFcy93SXMrQmMwbmo2amdMMXppVmZpcCtaTzg0ODQ5RmVIMXNOdVVoODk3?=
 =?utf-8?B?SDYzdW9rRUprdXExM3JsZzYxL002alpJZnZXWkRvUEZ4bFpJbEpmNXdocSsz?=
 =?utf-8?B?T3FzL2FvdjQ4UHBIN2F0b054WC9uSVpsNE1UVnlDWkJiOEFyb3hINzh6NlNu?=
 =?utf-8?B?Z1ZYL3dPTjF4blJ6NGtpb1RONHlCR1ZQTkNqZ3hxMTZFbm8va2pDSFNVV05q?=
 =?utf-8?B?ZExEaGxhbkFIZytTZXRmQ09hM0UyRG5WWFh5eFR3Y3ZDYkJCeHJvTC9KcXpu?=
 =?utf-8?B?UVdVRHNnTXdSTHhiQ1c2ZUkwS29BRUV5N1VFR1lrYTBwcnpnZVRGcWRoYThk?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 698b40c7-951c-44ed-3dfd-08dd7e85eb14
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:32:59.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpGkgOmIQpW1J2xa2NHVA+33Xgu2aVo4Jsryhn9GRVPKbOh+J0hfGP9bDT/kDUHnFDYs11DPQUbvHK5sMm7pVlMsoptRjp68r7ZzyDHPAfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8567
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

Hi Heinrich,

On 4/18/25 4:17 PM, Heinrich Schuchardt wrote:
> Quentin Schulz <quentin.schulz@cherry.de> schrieb am Fr., 18. Apr. 2025,
> 15:52:
> 
>> Hi Simon,
>>
>> On 4/18/25 1:39 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de>
>> wrote:
>>>>
>>>> Hi Heinrich,
>>>>
>>>> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
>>>>> Currently we are no able to build with configuration fragments in our
>> CI.
>>>>> With this patch buildman gets a new argument --fragments for passing a
>>>>> comma separated list of configuration fragments to add to the board
>>>>> defconfigs, e.g.
>>>>>
>>>>>        tools/buildman/buildman \
>>>>>        -o build \
>>>>>        -k qemu-riscv64_smode \
>>>>>        --fragments acpi.config
>>>>>
>>>>
>>>> What about using:
>>>>
>>>> --fragment acpi.config --fragment fragment2.config
>>
> 
> Why should we type so much?
> 
> --fragments fragment1.config,fragment2.config is shorter.
> 
> 

What was suggested by Simon after is:

--fragment acpi --fragment fragment2

vs

--fragments acpi.config,fragment2.config

Shorter :) (until we have more fragments, and then the added --fragment 
is an issue :)

But also because I like to use argparse features instead of reinventing 
the wheel, but that's also not a big issue :)

>>> Another idea would be to also allow specifying the fragment name
>>> without the '.config' suffix. Less to type.
>>>
> 
> 
> We can follow all those ideas in future patches. But first let us see the

No, this is user interface, we want to change it as little as possible. 
I don't think it makes sense to support --fragments 
fragment.config,fragment2.config now to then switch to --fragment 
fragment --fragment fragment2 later on, if that's what we want.

Cheers,
Quentin
