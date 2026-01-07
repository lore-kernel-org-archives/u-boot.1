Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED4CFD625
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA3A83AAC;
	Wed,  7 Jan 2026 13:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="lyHutuwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3216483AB8; Wed,  7 Jan 2026 13:47:34 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AFF839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 13:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.melin@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioH2zXuSrmzRCX7lNKXaGvT22fEFgka2OGvwrJ0HSy9/nZUh3m0tDeM/HCmSS0U4BnFJS1+eh48vyZxzoFpWLqjdBFhn+ix7Z+v1MQ77ejBWQgQQLZSMJZBkzfQqVaNrJfUU5W97CXWPhHZQgxLD1Mby3/7lzs1kO4j0e6jPO0XZqdbh2alPqSNs7Qoer+JzUj0d6Aa7f/zw425CEnPn+ykTyFl9IcrDWg8sqosWvWElGkxOxAckhreU5HTuYQ0XF6If7t7jmILV+KyRv7mLgKIwVTcs8buw8JO38VMrY0hMPdTBlr3lvMcQsZVvh6TJld7VlvQqCJwn3gVryfwCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph/zK6n6EJG83cLzA2jigIC+iuB4+as06fuQSzMfG84=;
 b=a7eyQrG2eHDhPT2KmbfWoMn6+D+C95iKsIR4OkFwTwyBgFlExsHIuCy7d+t8xf2v6Lb5L839W3dbKXDeTaXjEtD1INqAuFobhK1Ga81VLQ+hQqYYE26lMjbnBEcX9/xhDnitFw6MSxZbLqnGOJ3CBq+0NKP2nP1LdirimHhXadfAydSCoCK9e4RjIn/v7i67xPXdhApMoTSkZ4KZ3PTqq7m88UHTYzkubeRgfBQ8LvWY29ssJtbcBUqbmvSgjwDakeLxFCiN6P4S23b3U7RFWqzT3WuRuTTYaW/hf6YzKHX8LqIYZ9ClDGbkoznG04APq02k/O7Nhgix/oJb9fBPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph/zK6n6EJG83cLzA2jigIC+iuB4+as06fuQSzMfG84=;
 b=lyHutuweC473xZEuq5htVMXVkj9ZrOb80wUGZCxSlj+U1iRN1n1w5JbqpT9L8fF0psmC6OWA6EbpGGIGWPE91x26C3fJoDNoUsSYdoJKmJArAD5ixa8JaRFnxPx4rE15aokUl7PmuR5ZbTT9B0DRVM2eSEd66TKJ3g4MInxvM/vsoLbdDzMnBSE7u0xhLwQZveemIn4zFnqZSx1IHkZsBnPM+36dlHlB7LkG4GgfacKQH3W4lxRqcaoxYv/ovSubVWAYqH3VrHJfp7LnBerLAwfgkYQk2u/baVVCTey33khkju9L4ePiKC4o/lRUuv/m4yur5MLSFcX7NG6QGk/lBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI2PR06MB9500.eurprd06.prod.outlook.com (2603:10a6:800:223::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:47:26 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9478.005; Wed, 7 Jan 2026
 12:47:26 +0000
Message-ID: <4ac1de76-9d75-4094-aeb9-c2f413f75ce9@vaisala.com>
Date: Wed, 7 Jan 2026 14:47:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: zynqmp: Add clock framework support with calibration
 fallback
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, michal.simek@amd.com
References: <20260106101247.1381214-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260106101247.1381214-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000452F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::358) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI2PR06MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d48c0fc-389a-49a3-5b65-08de4deae91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZPYnc5L2pva2JRVmsxeVE1SjFSN2RmaW9HRmNJclZZejZWMHkza1R4WUxX?=
 =?utf-8?B?c2R6c2lhSmhLM1pCL29ZN21lOWxiUVA5eXppVmhYNDU1eXliY3NpZ2ExMkMx?=
 =?utf-8?B?czlHMFNhWlZQNHdBcmJ4YTNmcXdOL05NWXJjY1c4R0FvUE9lZGo1VjJkRTBM?=
 =?utf-8?B?czhCZVB6S3hTMmVwajRabmEyOWdkVCtBQmp2TTNWVzdsbXFHeGRqNEo1NVow?=
 =?utf-8?B?aUJPZWF2OWVtMU8vOGh6dWdXRHVjZmh1QklsL1lReTRjcGlzcUdBWWxNazFh?=
 =?utf-8?B?NEJ5UmtsM3ZCWDd6VXRzYml6Rkx4MGtaSElWNEZLejJtcjVPeHJZK1VDRDhC?=
 =?utf-8?B?ajJ2bVF6WEJSU0ZsQ01PNElWYUtXdWo1ZXNYZ0FGUm45b3hqK0pGbE8yWVZF?=
 =?utf-8?B?VG9raTVHZGk0ajR5ZzZidXBjNDNheHFIb3pKbldYN0Jna0l1QWxveExGNFJO?=
 =?utf-8?B?a2lwdVg2S3V1RVVYS3Y2UGxNalcrMjhMbHBHRG1ZamJ0Z092QW1ncXpWaHE2?=
 =?utf-8?B?M004VEtkNVNhNVV0b2pzRFIxWVhBVzR5cG5lTDl6Z0wwWjRNRHpScExMWFA1?=
 =?utf-8?B?TlFRQlZ5SXQ4SDN1cGkzd2t4SG1DZ1IzcXRNM09mSFhRUVJyc3BsdDV0a2sy?=
 =?utf-8?B?cmZmUWNvYUl4QjhHNzJhNGZMMllJVWxnNG9sY0xuM0d0QjE3Z2orQWJyYUlo?=
 =?utf-8?B?REE4WjFNZkpqWHlUbGt1ZGtOMVc1U0luUzJnbkVHV1ZGaG5wM2RXTTlDazJp?=
 =?utf-8?B?VUh3UXFPWG1SZ21ydThFUzkyN3JYQzRBU1VRNjRNQkdKemIxVTQyYWRuU0pF?=
 =?utf-8?B?VG8xUEtncDE0VEdka2ptZVg0bURWaW9hbWh5THhON1I4cXYrVENRYlQyNFEr?=
 =?utf-8?B?dUp5Q290VkdhWnd1NURpYXpqZ3VqaWd0TVVDMDhDTWpLVjZMM2U5WGttdUJT?=
 =?utf-8?B?N21maVUrWGN2bmYraTB3c2l4ekY2OVRwNGFGM0w3VjZTa3phM1FERG5UNHh2?=
 =?utf-8?B?SHBUZXBxTjFpOEVQKzZkOGxEMDlOZkhZY2J3NzVaeGt0bmhSMlVDUjVQOHVS?=
 =?utf-8?B?TW02UnkzbG5qWG91QVUvN0lEZFI4ZTZjRDlEVmd3VE42MVc0ckQ2K2t0Y08v?=
 =?utf-8?B?QnBQMWRUQzN0alhLZm9yWUxwZGFXZExJY3Z0K1hiU0UwSHFobzJhTXNFZHd5?=
 =?utf-8?B?RUlHa0VEOVJxU2phc09ORjF3ZG9XaWJKTG9WdEwwbTlJc09ueTNwK2Z1QTFD?=
 =?utf-8?B?VzQxdkZsMEhNOE5DdnJkUS9FeWttUkMxNFk5VFl3aXVXRk5MUUVIWC9XY1Bn?=
 =?utf-8?B?eVBNNldXRnJPd2svem5oVTkrejNLejBYOGJ2cmR0ZnN1M2JoNDVqYTBqcGNP?=
 =?utf-8?B?RTZ3ZDR6VUVDYUxhcnNsNHdNemtMY1RaNk93NEQySkl5a3FEL2ZnbXFSRlFh?=
 =?utf-8?B?OEs4SjZlWHVXdXFoQkxiM0VWK3NNSEtJVUxTODI3UXJOVlFjalVJVVk2N1Ar?=
 =?utf-8?B?K0RwWTAxLzVhUUlqcWx0S0NCY2x3YXZjaEdUZVVrSWtnTHdSKzFtYUN1bUY5?=
 =?utf-8?B?dk9XRFBoc1ByZjZLQjc2Y3E5V2RPZWhqRzhib3I2UG1qeXh2Q1ZOQUtjNU5Q?=
 =?utf-8?B?bVJjdk0zS0d1Sy9lM0RtUUI1UGhlSUlFcXBlN3pBblNub2c5eVBBeUNqcHBq?=
 =?utf-8?B?WENHbERFYzl4NXdxNDhEbURYSW50UUhJMEYyMDJsdTI0Z2JZdlhGRGhPK1o4?=
 =?utf-8?B?c0ZxaW9DV1AvckJHc1ViZUd3ZjgxSm1hVHNTeFQ2ZWpVQS9wVFRkbW9zQUpS?=
 =?utf-8?B?Z3pYWENCL2ZxWkNSMWNIUzVZamhCWktwNlJuV21aVnUycjRlVnhjVXp5UGoz?=
 =?utf-8?B?bEl1WkVvcXJyTVpiSTNiNGgwNW5QcTVpazdXeGRiSVJYYXhySkw1QUZNOTRa?=
 =?utf-8?Q?LVCz48Lex5Kj5BZNjDvevvK3nXlitlU7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR06MB10365.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXovV1dRMHFsZmJVT0cva0tPSVVBdkZpZlRJTUMxM0VEM0o1WU5sbW5kUWVD?=
 =?utf-8?B?YjJxZXVDZERITGQ2TWlVVmRBQlJtZFMxUzcxTWNuUjVxK08yK2I2MnpiNUps?=
 =?utf-8?B?dWJFMklUMU5BcTN4a1ViRWtHM2xiQ1NxTWFZWWZTVlRTSmhPQzd3UHpaSFZl?=
 =?utf-8?B?ZmVEVXNyRWxwVVFEckswVEZwZ1o4SzAxWU1HbWQ5RmhjVm8rYkpnY3VxWnVm?=
 =?utf-8?B?RVRyTjVQU0RFR1JVOHhUZzRxR1lSaFo4ZWUwOHBzZmpnbjFxMDdGc2ZKZDcy?=
 =?utf-8?B?ODZzRGcxRHk4ZE1KK2dhUGxlMWt6VlNSUER6YjVXckMvYjl2aWVUR29MSjE2?=
 =?utf-8?B?SndyNTlaNmt4Z2RKbWtvS1ZGbW5FZ2Njck45ZWZyekFkRHFPQVZVSXRvdU5B?=
 =?utf-8?B?ODZMRk9WYWphd01ZYlZlaTJoM09IVlQ0RThXM1pvaDluNk8zd1o5eVkyVG44?=
 =?utf-8?B?a1JZZ3UvbWRxcGhlY0Q2QmdqSWd5RW40NFlSMkZuN1NPWDhDTVJhTHQxVGs1?=
 =?utf-8?B?K1kyQU0vUTg3b0hraWFFWm5jM3NXQ0JkQU0vN0hwdDZSYm9oTnp6Q1hXY21a?=
 =?utf-8?B?QU16OHJ3aTdFUGxmbW1vMFJDeFJISGZ6UmxKRHdnYzdTcWNmcEV2NlBZRkUw?=
 =?utf-8?B?M0JhZjJBbnlxVi93Z3VrU3l3YkUyTEszYWQ2UHdROHlNVGFPYlJ2SGZvQ2JK?=
 =?utf-8?B?WHN0aVcvSDFxdGlJMlF6bnkwbHRDdjk3SXJ0Y2NsZnF4anYyVVlUVnNoYVNR?=
 =?utf-8?B?WS8yaGhJeko5MkpBaHl2NUtYYjZQSG5pMDdYY0VaQS84YllNdStiMjhoMC9J?=
 =?utf-8?B?NERtZlFaak1HalBja3h3NmwwTVJwMm1YOGZWOVdNVS9QVjZwOWZTaUZsVXoy?=
 =?utf-8?B?emZUSEZ6NmozdTdYRDJKZ0NrME9PR2EyMUloK0IyOVBPRDFWKzl3VEFqVjlx?=
 =?utf-8?B?TlNkTzExdGRQcEh5Ui9qcTFPcEErQys1Zk8wMWdRRjRvZE16UWRrOVZ0TytI?=
 =?utf-8?B?T2J0cE1yOHJwWU0rLzFaUC9TZG5PSHpkdVhQc3ZORDJUWTNsWlppQ0lNQTl6?=
 =?utf-8?B?MXRjTWVmUkJUNUdNQy9DcXErQ3ZDWFBJWTg5R1A4WEVLeHgrZUlORWdBTGJP?=
 =?utf-8?B?SUEzc3A1TXBicktrRGZCdUNuNkRHVlljazhHa2lUY1FMbitETVVEWXdCQi9M?=
 =?utf-8?B?UzZtZllYTllSZDZ0OGdKRUlxUzhmQ3NaK0FOb1NYWGJUQUtBTEFhOUtTUGlF?=
 =?utf-8?B?WmRaM2FFZ3lFNFUzMlllNktwRHV3RUhqQURObldYcHM2R2JkK2RXU2pBYTNn?=
 =?utf-8?B?MEM3QWFQcm1BZ1UwWHE0cjlHdFluZ25rL1RaWk9XR2NKYmZCdnBVL04xdmZ6?=
 =?utf-8?B?TS9NYXc5KzNFN1RLZnVnVHFxZGpxUUovNjFXQUxTdnZWa2ovNmNsbGNRZkds?=
 =?utf-8?B?Mno4V1QwZFY2NE5DSUlKc0EyaVNCRTh1U1F5bTZoUlEvd3dyNTR5WFNCWjZ3?=
 =?utf-8?B?VGlqako1U2hlR3lZcy9NaXJyMmdWTUQyMHV5dFNuK2h4TVYySzYyNzNDWkdI?=
 =?utf-8?B?LzVFdXpJamFDSHpncGU0RXQ0WnYreXZvUkkxOFdMQzJ1WjArV0ZHWEhESjYx?=
 =?utf-8?B?bmFqS2ZLcDhvTk03cE9MQ3JDd0FkLzNwMXpwUGk3RWppWkJzQjhlT0p2S0VB?=
 =?utf-8?B?b3RkOEZaU1pMcTlMNjdnQTg0emxVakZhbTZEYUt2UzdDWm9zREJLTkpka0ZQ?=
 =?utf-8?B?SUdqYnFRNXdjL0JmelMveE5GdDJISVo0anVhdTNqVWhjUEoxK2VUdmplcDIw?=
 =?utf-8?B?bFhscE8vYlFUL1dFYXV2Q2NXRmZENFlmWGRsMUxVV1Rma3lickc3b2YrUTNO?=
 =?utf-8?B?QWdFdmYvZlIySkorMHJVeFI2QWRjT2FzQXFRaWtTUDZXbTI5Z3hzN1ZReG52?=
 =?utf-8?B?NWwrc3p2ajNNYlZjWmwweGlMZktQUE81UVVIbWNjMzQ4SnhjOHhNUWpxZTZ6?=
 =?utf-8?B?dnJMTjYwZDlmejNQYW1rdktYdnl5RGZIeS9tWktLTU1SeWExVGJENk5uaGR3?=
 =?utf-8?B?SXZHSXI5L2ZyVjBSbFVzMkpIQzZNREFMb3hucFZMaWI1Ums5THZtTDF3dlJO?=
 =?utf-8?B?MUkyU2JQYWtEL3EyYVdVejc4N2Z6Slg4My8yV05QZ1ByVnF2bVlNcEp6RXhI?=
 =?utf-8?B?OTBzaXZOZjNrODVzNUN5Z3Fla0ViY2sxSzl4ZzU2ZjVLSjhwbHlxTVJrbXMx?=
 =?utf-8?B?Zm10bklGS244ZjljTmpqS3pQSXlFdGUzYTRJVnB1WmFiL1hHaVB5Y3VYVzIx?=
 =?utf-8?B?cTBreTdJbWRnN1hFQ2toS2JGc2U3NkFEbyswN2lwWU5aSVlJb2ZOdTlYUGI5?=
 =?utf-8?Q?/3Gk1v4SYLLvLsJM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48c0fc-389a-49a3-5b65-08de4deae91c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:47:26.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQMvpbKR2GirUY23PP/in3ihay42gFZQ1Z0fkufWgfHxYK7ctO9gh875xAXyGHs6McZfxWdtF447X68F0nyy7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9500
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

Hi,

On 06/01/2026 12:12, Pranav Tilak wrote:
> [Some people who received this message don't often get email from pranav.vinaytilak@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add support for reading RTC clock from device tree using clock
> framework also update the default calibration value to 0x7FFF
> as per RTC specifications.
> Falls back to 'calibration' property if clock unavailable, and uses
> default calibration if neither is present. Only writes calibration when
> hardware register reads zero.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  drivers/rtc/zynqmp_rtc.c | 51 ++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
> index 15122a04838..83d66aa1aaa 100644
> --- a/drivers/rtc/zynqmp_rtc.c
> +++ b/drivers/rtc/zynqmp_rtc.c
> @@ -8,23 +8,27 @@
>  #include <dm.h>
>  #include <rtc.h>
>  #include <asm/io.h>
> +#include <clk.h>
> +#include <dm/device_compat.h>
> 
>  /* RTC Registers */
>  #define RTC_SET_TM_WR          0x00
>  #define RTC_SET_TM_RD          0x04
>  #define RTC_CALIB_WR           0x08
> +#define RTC_CALIB_RD           0x0C
>  #define RTC_CUR_TM             0x10
>  #define RTC_INT_STS            0x20
>  #define RTC_CTRL               0x40
> 
>  #define RTC_INT_SEC            BIT(0)
>  #define RTC_BATT_EN            BIT(31)
> -#define RTC_CALIB_DEF          0x198233
> +#define RTC_CALIB_DEF          0x7FFF
> +#define RTC_FREQ_MAX           0x10000
>  #define RTC_CALIB_MASK         0x1FFFFF
> 
>  struct zynqmp_rtc_priv {
>         fdt_addr_t      base;
> -       unsigned int    calibval;
> +       unsigned long   clk_freq;

Using calibval as variable name might actually be better here as the
value corresponds to register value, and not the actual frequency.

>  };
> 
>  static int zynqmp_rtc_get(struct udevice *dev, struct rtc_time *tm)
> @@ -70,13 +74,6 @@ static int zynqmp_rtc_set(struct udevice *dev, const struct rtc_time *tm)
>                  */
>                 new_time = rtc_mktime(tm) + 1;
> 
> -       /*
> -        * Writing into calibration register will clear the Tick Counter and
> -        * force the next second to be signaled exactly in 1 second period
> -        */
> -       priv->calibval &= RTC_CALIB_MASK;
> -       writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>         writel(new_time, priv->base + RTC_SET_TM_WR);
> 
>         /*
> @@ -107,15 +104,6 @@ static int zynqmp_rtc_init(struct udevice *dev)
>         rtc_ctrl |= RTC_BATT_EN;
>         writel(rtc_ctrl, priv->base + RTC_CTRL);
> 
> -       /*
> -        * Based on crystal freq of 33.330 KHz
> -        * set the seconds counter and enable, set fractions counter
> -        * to default value suggested as per design spec
> -        * to correct RTC delay in frequency over period of time.
> -        */
> -       priv->calibval &= RTC_CALIB_MASK;
> -       writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>         return 0;
>  }
> 
> @@ -128,8 +116,31 @@ static int zynqmp_rtc_probe(struct udevice *dev)
>         if (priv->base == FDT_ADDR_T_NONE)
>                 return -EINVAL;
> 
> -       priv->calibval = dev_read_u32_default(dev, "calibration",
> -                                             RTC_CALIB_DEF);
> +       ret = readl(priv->base + RTC_CALIB_RD);
> +       if (!ret) {
> +               struct clk rtc_clk;
> +
> +               /* Get the RTC clock rate */
> +               ret = clk_get_by_name_optional(dev, "rtc", &rtc_clk);
> +               if (!ret) {
In case the rtc clock reference is missing, this will still return 0. I
think in this case idea was to read the calibration devicetree value
instead?

> +                       priv->clk_freq = clk_get_rate(&rtc_clk);
> +                       /* Use clock frequency if valid, fallback to calibration value */
> +                       if (priv->clk_freq > 0 && priv->clk_freq <= RTC_FREQ_MAX) {
> +                               priv->clk_freq = priv->clk_freq - 1;
> +                       } else {
> +                               dev_warn(dev, "Invalid frequency 0x%lx, using default to 0x%x\n",
> +                                        priv->clk_freq, RTC_CALIB_DEF);
In case the frequency is invalid, that is a user error and it should
IMHO be treated as error, and bail out here.

Thanks,
Tomas

> +                               priv->clk_freq = RTC_CALIB_DEF;
> +                       }
> +               } else {
> +                       priv->clk_freq = dev_read_u32_default(dev, "calibration",
> +                                                             RTC_CALIB_DEF);
> +               }
> +
> +               writel(priv->clk_freq, (priv->base + RTC_CALIB_WR));
> +       } else {
> +               priv->clk_freq = ret & RTC_CALIB_MASK;
> +       }
> 
>         ret = zynqmp_rtc_init(dev);
> 
> --
> 2.34.1
> 

