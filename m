Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195B0C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 09:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9428483257;
	Mon, 11 Aug 2025 11:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f57LKQj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D8E832E6; Mon, 11 Aug 2025 11:51:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD48830F4
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 11:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idaLHlEwI3eV+2tf4ZRjVBhly313afoYBaRmesc8WAVRY+CjEkqWnKcIEm17u+lUbjU7Z7og6YjWkQW/G4F0B/7zaY6kiLnnkwZ+njQsIuDN25BuhdMmzEsOt/R1KDFNhNNMyMVCH/natZcktd45iqJ6hmbhsoFngCrHGUuxv2bsw+VT6KZEYV72+gqXz7G5HQEZEhlgBqp9n9Iqddc7V8AuGpdZkfyqapLWZeBNJlhTyBvGm5yKDtZPB3/MGDW0Jl6wut+SlsKf1zQJO07B9O70NvJ6Vy9y6WFjNOQIVhzCoc2RXi2iregTc4Z5jaqy2kQ8kPfebQtGYUMxbd6i+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3LTUTpxpNx2nmA0c9Og1jClWI9xfhbNAlRad/IWY/w=;
 b=P6J7i94SS1G/HaITwuH6zoZMviLT6jC4pw5djr1CS9r4I6Kx67cxT97r42LHjCqaUVvysaAiRbkM0PsqrE+UZfy66Cma3JFJA1uatpVDDTNQo6cuI4DOCCsLK74u1lOX4oLfYrxZkx+99gz2GvIt13Oqt3gOnBsLhsXv8aU/U5LHCg5Regr4kR8338PpXfO0ceHTb/qZOTaWrr4YVBmUEjKmfEP+/+jhje+MLRNKe476o4cuhokXeHWhC8hkj7BmOmVboV8NScjtTs4MlNpZtLKRAsqCIMzBv/yAuUu9mLTasfuvU8qouI34rdbcyNB8AFGeO/iQISwBXGHFjzp3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3LTUTpxpNx2nmA0c9Og1jClWI9xfhbNAlRad/IWY/w=;
 b=f57LKQj6vy+LknyLWkRIVfmvYwAb5Y5oAa0uCaldldxu0GHzB2MOLVIPjKTHRmicyCKfRFoJQafxk9TMT8YvIg7oC2PXjqZd6i1cl/pzV+ctOqoH2D362ZOKlaneoAyRVVgWdW3R2WHQ+52uiqhT9mjSVI2hDCBtdk/JbJtOS44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 09:51:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 09:51:55 +0000
Message-ID: <c681a45f-05e9-4390-950a-861bb762d2a9@cherry.de>
Date: Mon, 11 Aug 2025 11:51:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] board: rockchip: Add Radxa ROCK 4D
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250801210619.2618622-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a7eeaf-0f7e-4187-9752-08ddd8bcb476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wlk0dzFVcm5WYkdrMVBkbm1nS2VYOFJTVzZucjRMNVlQbUUxYldlUGN4dUJQ?=
 =?utf-8?B?cHQ5WHd4OVQ4WTV1TGE1cU00VHpqejVDVDIybnNkRUpCbGxWcDVkb2FvMnhy?=
 =?utf-8?B?ZWc1RzJNbUxFVUZHblJsS3EwNWZMS3RKQkdUc3hiUHUvaHg2RmNPLzI3OEo2?=
 =?utf-8?B?M3NWeXFOY1llWitxWGdXZ3JMSmpqM2JHMGRKOHI2UklyL1REamxOaHIyZDdV?=
 =?utf-8?B?VjNEdk9MVTBXM0ZaaXlpZ3FyRWdmMHBOaWZzUHkrUTF0YkN6K2VvOUxVY2lt?=
 =?utf-8?B?aG9ac3crY0loSGlpWGxDcWlkZUJ1RVlnMWtFTWM0T2NQaGw5ejBZS29aZnZp?=
 =?utf-8?B?eXlwSlpEWVZJb09nS3FWOElNbWt6V2FBeDJHNEh3d1gvNUxKVlpMTW9wQ09q?=
 =?utf-8?B?SDZOK1JpbXZ5WmVobTl3OVRPNU5PdHZxTEpncUFid2o1ZjR3cDZpUnBNNmRJ?=
 =?utf-8?B?YXFnUnhMNWgvaTZzMDVwc3hGVE5zWVJFNVNLN1crTTl2T3p3U3p5NFJtZW9W?=
 =?utf-8?B?ZzlhbWl3RU5pUTdlVEFiU1IxU3FjTTIvR3lJWHYvVEZIYW1WUDNabEI1OFlG?=
 =?utf-8?B?OXFXWmZjajJCcFJUajUvMTVuOTFyc01rSWJIQ0Yzb0tFKzRJekhFdmpSVk45?=
 =?utf-8?B?N3pEcm9KaHZNdm14ZjFhZjh1aFBxQ0JEZ1U3QXJBNVNkNWJpWXBTVnNvL3JU?=
 =?utf-8?B?dUVCbXdZQWY5Zmd4U2RMM2pzMjFqZkdPVFU0K0NXWm1oVXZLcSs1RDdFQ1BR?=
 =?utf-8?B?M0Y0NTRxNGVLbG9EMjRlL05GMmt2NnNpNERjRXBCWjJIY0dzOFBPR0xDekFB?=
 =?utf-8?B?akxXdzlsbEhCWEw1TDZCNW1zMlQ5UmlJUWNTd3Z5NXBtVlBVcW5QWWpRdE9q?=
 =?utf-8?B?TjdOeGEwdWMwcE1UaTJxT09leVZ4STl6dENQM1BtUmp2WTlWdS9zeXg4R2M1?=
 =?utf-8?B?Y2psZVBhd280T0VNQVdjNkZUVzBDRjJBTzlTNVM4RzJGd0VNS3o5eVZiR2h4?=
 =?utf-8?B?RDNDV2lVLytCL1g5VDMxRlNnSVMwdzhZSXhJMDdVK2ZmdDArYWpmdGw2V1BY?=
 =?utf-8?B?cUJBWUdSaTZUdDZUVFpDZS9oa0tWUmYzbytCYlFpRDJsNStGZWhMT3V3ZW90?=
 =?utf-8?B?NHYxV25vbzFZL05CdDhRQytzWE1nUzJEM3E3dHR2WEExUUFPak5kdW01NXhU?=
 =?utf-8?B?SVZoL0NQOFNRQXMrYkZzaEZRbjVxcEovNGRUTkg0NW91cW9KK2U0V2VLazI4?=
 =?utf-8?B?aHZlOFNUYmNkR2d2am1DdUZ6NUE5U0ZzRFBFOXd4aHZwMUxGdTgxZlFEQmRF?=
 =?utf-8?B?K0pqZ2d2RHAwRExrV3krbEQ1cXMrem1MVVh3MENzRm1uckZBc1BxTlJlSmRH?=
 =?utf-8?B?Njd1UC9LVjE2bUFUaHhmMEpkWTdPVnl0eHZBdDhCUWpZeU1jT2FlU2JiSW5t?=
 =?utf-8?B?TXJ0dUdhKzV0WitOYUxGU1ZGczdJdzN5d0l4MFdPNjVRMmVUWGUxb2Y4eEhD?=
 =?utf-8?B?ZXB0cDdGUi9SL3RYWWpadjFFZGJPS1BvVnZJcHQ3OG0ySUE1cUN1Q2hiUjly?=
 =?utf-8?B?Q05rdEdRWlNGYXlHTFVUNkpmanR6b2lQUWtYeUxTZUZZckIvQkU2U050WDBp?=
 =?utf-8?B?YzJlZmtOTEV2TExBRk5HRmNnNmRHQ3lFRHBmZzJZNysxTGhZSER0VjlqZnR1?=
 =?utf-8?B?Zk5FaGJva1N3Y2RQQ1QrcXlSZDdTQkNnc1EyckNoOFcybDFnV2VYRS9MVmFo?=
 =?utf-8?B?cWsrTVQxWHJpTDVzNXNCK001dEFWazI3WUExYTQxVEdBRTloN0NsaEZ4elNn?=
 =?utf-8?B?U2ZrdVc2U0FITHJTYmdMN1dRRll2aTRZYjErSG16RFUrOWhlalVlZCtZSGRN?=
 =?utf-8?B?U1NiL093UkN6UXhSWTVrMnpOQk5wWGFCY3IzWlN5RlI5aXpsczVnNDhkc3p4?=
 =?utf-8?Q?N19GiKMeBTM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhFWHNDeERJQTlhZGRUNlQwbHo3Q3lCREM4SEVCeGEzYm9DVjA0OHhwaHE1?=
 =?utf-8?B?S2FQejc1VWc0emI3WXJla2FtSHBmOG5jbHJqY2FKQkcySkg5Yko1eXdFcm9S?=
 =?utf-8?B?VFBtSjc4alphUTI5YzQrRDdKTWh0TmdEM254VlB6aDQ0SC9sejRocGhuSGJP?=
 =?utf-8?B?ci9ieGoxcXQyV1QwaUh3ek1xZTYyYUdYYzZPY2FyMkJUWHVPR1o2SERUV2E3?=
 =?utf-8?B?aWRwUFZnLzdzanVLcEhwNmh3aEY1cW14REgzaHhWand1anBsY0pNYUJzdnJq?=
 =?utf-8?B?R2JKdGNtWUNlWlQwZmZsNjZnMjhLcGNmRWVoeE9CSmZXL04rZEJoWmRTaXlw?=
 =?utf-8?B?RmFaZFFSWHFiYkFxUEN2UDI2K1IySm9tdjFnTW4wcWZNeVRaTldlWGhKYS84?=
 =?utf-8?B?UnpSMkErcFNFSzVQaFpKdkszcCsydTE4VTFlSTBkRlpXa25XY0Vna3RBUXNW?=
 =?utf-8?B?Y0hRMFU3Y0VqYXVzMjdKZzZiK0hqZXhHQnRBNlkxekhYcmVBZ1NkcDVNQUJi?=
 =?utf-8?B?UU9lRWR1R3YzYkZISG9tK0gxUE5hN3ZHeWZVd21hTlJibDdWYjdGU2FXOHNG?=
 =?utf-8?B?VEVUTjQ3R0NlSFZqSkZzbmxmWDFFd244cW85Y0NGRERUc2wwV1hBZzdzV0NK?=
 =?utf-8?B?enZOWHBhZEFFWnFIQmNDODV0SzV1MFFvd3IyMDMzOVZQU0V2VWhPWDF4OVNJ?=
 =?utf-8?B?OGlpSURlWkpWRUJheFZXektHRnp5bWJyR2ZqajZpaS9KNi9ocG9KTDBMVWNa?=
 =?utf-8?B?eFMrQThOU3pWNWhNUmh5dk5KYXQ4VTkwUWlTQ1ZBZW52Z0FkYm5EdzVaSmhm?=
 =?utf-8?B?TmVLV0ora3R2dFJkbWl6ODR3VGdYZnBCQ2U4QklQQU1Pa09VNTVncU95ekJu?=
 =?utf-8?B?SHhBYTl4VTZOSUlGa2paMUs2UWNHWlZoMWZVdUxPNVpBQTlRSkFtcHErZ0pI?=
 =?utf-8?B?UWdVT0RlS1UzcjRwNXFUL3llWmx4QktZT1hCbzJ5RVV4aGtzWkpkTEtQSE5N?=
 =?utf-8?B?MlhFMzJUMStQWHVkN04vZjdIVHdIVkRXRXBGS3N3R0FETWxkbVRwakZhbEhs?=
 =?utf-8?B?ZHZ1QTVIU2tpN3BUdDNsZ1N1UTZqOGI1UWxCc0ZtTkROL2lERWtrK2x6TmVI?=
 =?utf-8?B?QXVqWXN5VzMzN01tTVAzOVYvbkRJYy9PK3VKSnVMeFZmNFpPUmJqSWVwVmhD?=
 =?utf-8?B?WVJQc1gvMjVMdkhNWVdDd1lPb3NoR051aFVuU3dKN2pSQXdYZ3pFRkFBT25V?=
 =?utf-8?B?anpQMDB0cW43ZmNsQ0pjU0xYbFlXYmZvUS9oWTNiNjN6T3dLc3FHRVNUT0V2?=
 =?utf-8?B?dWRMOGM1SnczV2xSLzk1ZFl5bUwyR2FIajkwUUFKU0R2VWpKUkt4MVprYmhx?=
 =?utf-8?B?K3NMQU8vYVQxdStDRjMyc1Z3WkkyalhrK3VRZmloSzY3TEE3L25xRGJUcHBC?=
 =?utf-8?B?UjVrY0tydlBBdnNKbHZ3SE51dkI5QUhpTExRZFoyOXlJTERjK1RmN1c2WmdN?=
 =?utf-8?B?N05PZTFwZW9SRHcrVTZUWXRycGZZaUZTVEhWQ1ZQT09SV1poUkUvc2pwWDlp?=
 =?utf-8?B?eXNqSEJ3SDVhL2xoeGpsVDRqTm1VZWhhcTUzOU1ybkZJUTJkdGdTL2FjVnBn?=
 =?utf-8?B?eU9XbTZIUzV2czRlaW8xMUNKWlJnZ2xiNmZvWVorOUpaNWJiZE5ZVmF6ZHZr?=
 =?utf-8?B?OWZmSEdHV2pOU3d5NGxxV2JWQjBEdlhrVVpia054SmovM1Vvd0RvOE0yN1BY?=
 =?utf-8?B?dHdYVjBFaVgyQmpYK0d0b3VTV0d6M3M1TUd3MnNBa3QzZk0xM3EwdTZrczhT?=
 =?utf-8?B?SVo0U3V2MTFBa0ZJa3p1dlRrSSt2MmQ4bkR3dE9iN1FIanpBdzlvNS9pWFpC?=
 =?utf-8?B?UldDdlorenFGeGh5THdyVWdPZG9HNHVacGlwc1AxM1MrVHF0eWpaVzIrTkZM?=
 =?utf-8?B?WkVQTldrV0JhU0xFMTFmaFBVRyt5WUJSUGp6NkMvc0p3SlZDd3k1TWpXSUNl?=
 =?utf-8?B?NG1KNFJteXBROVNZUDRiaUg4cFBGcmNTSkllNUpmZVJsV085ZTdpaSs4TEFC?=
 =?utf-8?B?Tjk0M1B0UWRra1NyZVk4cUpkMzg4dkxOU2U0SVVqVUdKWWxhNU1NcVFiQ2VJ?=
 =?utf-8?B?bW82QjNVTVZxY2QwRkJwVFZZNnY3OFZ0b1JIaFdkYXlPUFFndy80cDVUeDZV?=
 =?utf-8?B?c2lHeGpTK3ZyR0p6Qy9NcTZleW5OMlkwVXZwT3A3SkZmK1NmdFVqaTZPOTRJ?=
 =?utf-8?B?RjJMbmFoLzVXTm0wbXY5NVoyaUtBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a7eeaf-0f7e-4187-9752-08ddd8bcb476
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:51:55.0755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvT/q7ZStnJoqAxFACBvUH8VuIxSpR6Ob01cFWZGKwhSyfF3feyufwIpPo1xSSUUC1sNTM5IY+/jxbm8oEV/mq71Y6cLdMyR8G+R2V117aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585
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

Hi Jonas,

On 8/1/25 11:06 PM, Jonas Karlman wrote:
> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
> numerous top-tier functions, features, and expansion options.
> 
> Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
> octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
> powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.
> 
> Features tested on a Radxa ROCK 4D v1.112:
> - SPI Flash boot
> - Ethernet
> 
> ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
> or directly from USB when the MASKROM button is pressed, booting
> directly from SD-card is not possible on these boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Add comment about the reset-gpios prop rename
> ---
>   arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 19 +++++++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>   configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   4 files changed, 94 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>   create mode 100644 configs/rock-4d-rk3576_defconfig
> 
> diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
> new file mode 100644
> index 000000000000..2e882c3cf786
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3576-u-boot.dtsi"
> +
> +/* U-Boot only look for the reset-gpios prop, rename the prop until the Linux
> + * commit cd803da7c033 ("arm64: dts: rockchip: fix PHY handling for ROCK 4D")
> + * lands in dts/upstream to ensure Ethernet can work in U-Boot.
> + */

This commit landed in v6.17-rc1. I assume it's just a matter of 
hours/days before it reaches devicetree-rebasing git repo so that you 
can simply cherry-pick it into U-Boot with tools/update-subtree.sh :)

Cheers,
Quentin
