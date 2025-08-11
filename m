Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B15DC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 09:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908278331B;
	Mon, 11 Aug 2025 11:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Tq6qjKux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126B183321; Mon, 11 Aug 2025 11:59:39 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3F5832FE
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 11:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiykjF2LOsCvneSOGjOI0HzkpVv684Q+nG3jD2T3sOgoT/+rX/asGGNPw7HEUIZ7KkwcInqryzPBR+6hGZzZKx1X3sUFzi22Q2kX2Hin/ci2QcAZRvAPE3tM1QdizJt4AlbE/EbO6lcKqoHS6kX78l4xoGpAac1EIAVXjFVeV04HG7anDMwUufTnmvviRNUG1neWSwb7YU51dJ2bKSmc4HKSD3n7EexSmCUeRkRK6bEno0m1rbfk//ee9Z8pIe7bSAFjkf9RnxEAG53u3djrqYp/oXoTTHXxJ/YeVS9QirQ4YpMg017ssAUdMreCNwUk66MoqxcViSxasElTxyKWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeFOxgHQLN8lvGntxtd3PIDE7EoCibWFTGA7p3nqL5w=;
 b=xa1CBENigkk0qksN7xUodD3RzS/USFC8mSWFYEQu+aInEDjVgsJezLPv5D6AU8zcwdTlFjJFrnJS153p7LUsFUuVFjD/T8B8qh1U/t/ET1rpl4URKO1AwZH90pd/KX6/t8rNtuIEZUU1dyd8AxKp5Xd7ZkXuA10HP16nTz6OtJyqEMtFf3BE2bt3Y5bkxPR++LBkOPlvfJ26y961ow6s0EPLQ1iwglqb5ClOsowfM1ZG2mOXacuUSP3aZT4xXH1uDhAXllBornuHGamDGPtX32Et9VThYPyV7QnRhaxxrOe/pYgFxo6TqJCgjDDfZSE88sme8e6V9NuJobsyOCDgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeFOxgHQLN8lvGntxtd3PIDE7EoCibWFTGA7p3nqL5w=;
 b=Tq6qjKuxeCbR1Nco2hYlWUCYZZqf2Oxlld3wS7AsnmA+bRtShLvnI+8qpk7hu0rzVFLFgrR36XcVOoeKYX5au24zvB3BMc/CrM0AJ5YGOA6QADH00esflL2gon43RYjMvXPX7TOEa3TluyzUdWt7YLWeTu5rlxM0mtcmnyiGW8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 09:59:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 09:59:35 +0000
Message-ID: <a22ea144-ada6-4520-a7fd-43380f526ee4@cherry.de>
Date: Mon, 11 Aug 2025 11:59:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rockchip: rk3576: Add SPI Flash boot support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250801210619.2618622-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 22239e69-d309-4db5-7c28-08ddd8bdc693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHhMdXp6MndCRzhiSWJzNlZmR2VpSHZZek9zemJRbktaeklUUmp6NmJqWm5k?=
 =?utf-8?B?dnRLVjQ5SjBweXgvUm9NcGpveVNHNzZYK1dMRWNudVpYVkhvQUJSMW1QUitR?=
 =?utf-8?B?cklBWSt5YUtBZm1iVjZ4ZThqQ1g2M25uQXo1c3dYbmIxQUE1Ty9OWk1JM1VB?=
 =?utf-8?B?WXNpdG1XbFNWcTZ2ZVZaT3FhOG43UGQvVG05WmMyOEdRSjV0bXMyQ0s4Qmhq?=
 =?utf-8?B?NzhxNmxKckd6VUtMcHJWbjFURElYdytGZDNkQnhBbkVtM052UmMrbTVsbGtu?=
 =?utf-8?B?b2ZGa3JERk1GUThaZm5NSnBlaENMN3Y1RVhxWHVuRWtuVTFtOXF1V1diOW5P?=
 =?utf-8?B?VENkdFBuUFJuZnV1ajRmbUVwY3ltdjZ5TG8wSHFIb3craDZpSnVqZjh2NkRi?=
 =?utf-8?B?SzFSUDRmMEFoM1RJMFUrV00vRERGOFlnR05GTXJ1VG1FTDU0SmlrU3l1VzVm?=
 =?utf-8?B?SVJrczUrSmthS2c0MmVhNWsvT3ZRdi9wZ3ZuQXVrY0NMckNqaVo2OEFReTdH?=
 =?utf-8?B?U3RBaTgvazRVQjJTS0VtTWUxTm9NK0g1UTl1cHZTRHROMjVtdmJmOCt0MXRX?=
 =?utf-8?B?RjlWNnJta2ZuMElkYWdJOWkwQlIrUWJvZStQbzl3dHRyNUJwa3BGOWZ3OHdL?=
 =?utf-8?B?WDUxS25KOGNLdEpBcmJHZXYvbVVBWFpGRGNNN0hsVGI4R1FTeG1xUjBEV1NQ?=
 =?utf-8?B?UFo2YTN4M3hpdEtDaXVVM29QeFpteXdKNkEvT3J1S0tsQlhsSVVqNDEvR2s4?=
 =?utf-8?B?RWlaaU1tb2xuaTRzM0w3Y0xKWTlJR1JyY0oyblJhTTlwT2tjN3BJblB3RG1K?=
 =?utf-8?B?dm00ZlRHZkVUMVVqZmpFMXFwZTgzTE1IYzIxeVE2MW1qL251TjkvMnNsRi9l?=
 =?utf-8?B?THRHTktEVGlJdnBVY2J5eHdQbG5YcFdKSGVjQmR0bWZZTVBQU1RkVjJIWEFv?=
 =?utf-8?B?cS9MUkg3dGtJeS9oVFFTZ0M4Y3g0NWJwRUFpcDJjUUdMTHN0eU5FQklMNWVG?=
 =?utf-8?B?ZHpiaFBDOTNkdzJMMG1XSzFGSmhBdDJMckdKalR1Vjk0cWU4T0xLK1FHY2Er?=
 =?utf-8?B?bHdYcjVIMEErSHAwWGRveGdmTmVSYXlKQnlXNXpFNjltUVEzd2EyZFk1dVpX?=
 =?utf-8?B?SnZXWHNndG5MTGs3azJXTkZSVkRVMUZ2cVpldVM3dzI1dzJOalVyeDBpYmcy?=
 =?utf-8?B?eWlDdmFNS1VXaGFNZDRDUjdZalBvS0pNNW5PRmM3VVNSSG5UMC8yZVc5eEVz?=
 =?utf-8?B?UWtXMXdBR1BldHlHWTQrSWRZUGh4aTY4ZEFvZ1dSMGZlVjhFR2dNNDJ4b3Q4?=
 =?utf-8?B?QUhvT0JoeTlORUZEZ0Eyejd0QUs5SlRFL2VvaDFpdEh1cjA1VGRlM0xQRk4v?=
 =?utf-8?B?N1RSRXVGaGxYaTI3SEE3TGxaYmZkall5QXBTTkNBUlVKQ3VyRlRWQUtub0RM?=
 =?utf-8?B?dE80S0hmZkd0ZHdaQ2oyRHQrWTh2MnBISEliWUNyeVBsVTIzOGZrbXZSWmpE?=
 =?utf-8?B?bnAySU15SEVFRFdZYnF0Q0JtbUVDbDZUY2l6OS9vSEhkUlI1Tm9pWkRldGdu?=
 =?utf-8?B?UE9jRyt6Y1J4QllDdEd5T215V3EyWGdkaFkvTFlsQlRFa2FWV1p4eXdCOVJF?=
 =?utf-8?B?SXpwRkpGMjZVS1NzcFV2eVVvRmc1bUdnTmQ2WnVLK1R5QUFUbHdiYkR5Z2F5?=
 =?utf-8?B?bmJBMmc0UVpCVmdBT0VJbEE0dDJkcWJDaWQzbVNsL3N4T1VnSTFmQkt3d3FV?=
 =?utf-8?B?allTd0ljaG1MM3lTTkMrazErOTJlZzdTSzYwMElOVlJneG5UY3U0a3ZxdG9C?=
 =?utf-8?B?cU00QVNqODQ3L1FVWHRrdDdSWFh3bmVzSVgrT0pwb2Nwc3Z6YmVzS0FyVlZG?=
 =?utf-8?B?ZWl5SjEvbG5xMWkrNnFzQkpGdHllYU5ocVpDeU1zU2w4N0JLdlo4TDMwaXc1?=
 =?utf-8?Q?zG2IVeb4FUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlGVktLT21DMGtoL0MyR2s2cTlkWFU5ekRsZzRWZGVGblFYQzJIK0VEUlF3?=
 =?utf-8?B?M01rSVhBcnpmQ3VJU25tMkppci9zTGZJU2pNUlZJalpCaytnaGtZV1M1UFhQ?=
 =?utf-8?B?eTZmVzJqbG1jK2lvYklDeFRZNHZiNGNCVlFxWlAreWtoNXVaNHI2aXl5QW9l?=
 =?utf-8?B?SFVQakJSZ1pIenc2a2Vib0VCYnR2YTVyNjhLS2FnQzI3dHVWZmk4QzR1aDBJ?=
 =?utf-8?B?dFM4V1lYYkM3MUVxV1NEcHNRYjViUUxJc2s0ZUJGQ240alJqY2tKQUF2ekJZ?=
 =?utf-8?B?Vk11MnJoaUN4VUtDdGNCMjVqVkZCWWN6K1Z2QjJaVzNiNUpDME5EbStHWkd1?=
 =?utf-8?B?aTJKcDF3VVluMkRtRC9TZHIvbFM2dWIrcWVnSmNHTzVKS3ZqaXhjVXFJbWhp?=
 =?utf-8?B?Z3E1dXNVYUQ4ZVArU09HZ2diWmdBUWtFMnRva3hYWnJ2emJhck5RWEduMENN?=
 =?utf-8?B?NFMxZEhJQjg5WUF3N1QwYjdiWlc2TncrVDV3TkNwSGt2dEpyMnVYRTAxUkUx?=
 =?utf-8?B?K1NhTkdpbGN6YTFoblJta1U3NlhmWmhCQ0tHMng4bHRpWGxxb2IrOHZURERI?=
 =?utf-8?B?Qnk3dWJ5WldFSjBTcXJIdGYwYm0xd3hxeXlhd3BFWWtiYk0yemQ3M2dtTGZ6?=
 =?utf-8?B?ZDBUOHdOcC9CVVVvTTdocmpyR0NZSzFVRG4wa2NtSkFyejFaL0hxVVZ5d3l6?=
 =?utf-8?B?TFhhZ1VTellrWWo4bk9JWlR6amNCZlA3NXZpM05PbE1HaHlhQ1FWRFhBc0tQ?=
 =?utf-8?B?cndDN2EwZE5nRVVlZXpKcDV3TnhmcUNxdnFjT3RDQkxYRFRlWnNEOXRxYmxw?=
 =?utf-8?B?VHUxZjFJOHhzOGd4cVFabms5SDUzZlhiOE9ZVW9rVDdNczRNeVJDWWt1YWt4?=
 =?utf-8?B?ZlZodWVzekFUQ1lPNitUYlo1ZEpoOTYvRFVaa25vYlhXc3dKbjBtSWZxZWhi?=
 =?utf-8?B?Y2ZOOVdTS05rOVZHdGcxNFZPdmN3WkRINTZIT1l1TmFYT3p5bTZyOEdab1Q0?=
 =?utf-8?B?TkRYeEZrdUREZTg2Um1wWmVQTlVhN0p5cmJKMlRudnE5QjJLeUtVLzdFRHBG?=
 =?utf-8?B?c3pHNE84ekt3aFBTamVXOXRFbzV0NGRMZFg2TURONUx4RmRCY01pcStxT2VW?=
 =?utf-8?B?YkVkc3pmbjBGc0k3MHZ1UzVZeXJad3lQYm16L1dxSVA5S0lXOWNpUVM3ak5k?=
 =?utf-8?B?NFI5cTIrL1BtTHZlSitnaEF0b1dXYjRlazMrdFVQRktidk9ETG5ubXBLTHNR?=
 =?utf-8?B?YWhuM01NRWtDU0FPNkdEYjZkSW9ab1RRcStVc2ZNS282TjF6ODNOdTlUUFRw?=
 =?utf-8?B?WG1YeEs5SDZoRjBtT3RGZXh0NENKUXp4enpqTVVwQzFDUEhydG9XUzA3Q0VD?=
 =?utf-8?B?UlUydGxhSG9RbXAyMTVOTkhCNWFpbmRhZEQ5NkR2cndpM0NyNExWcmRQVnNE?=
 =?utf-8?B?RndrTmxqVHNZUkdTakxDenZhbzMwdHdwNkZ1RWpIVnJ5WDI5V0p3M2g0TU5w?=
 =?utf-8?B?cnJ0bGZjNW5QRVgycTZCNGV3VlhKMy90KytCRTcwMFRjL0NLK3paK0xHQVJ6?=
 =?utf-8?B?Y21hbDdBdVg4SXVOd0FQdWhqZkRQY2tjOEZaYVB4Qkd2T2ZSaEJsVDFEaEhx?=
 =?utf-8?B?WDBxL01RRGhIRWZoanB5eHljejhqR0ZiMm9DNDd2UUZLTXFLMmZqZlZ1WWxU?=
 =?utf-8?B?T0pEYmx0Q1k2dy9iVEgrRW9ZNUxQWHY4NU5YVzN4cThtNEMrbWZSQ1RUOUlO?=
 =?utf-8?B?U3pySnZTOFk3UHZKZlE0RDNXNWVQTy83Wmp2SU9Vc3h3UFFBUWgxZmhXcU9n?=
 =?utf-8?B?N0lyRlN5dmJXMHY5TWFmR2JwWWtBMkt3TWFGSmtscWNKUlFNQWJtOGorY2lB?=
 =?utf-8?B?ZGFOeloyWWtvUDBSNjdHRnZrN3FxN1lMa21IYUo5ZHc3amEzM2VjNE1YanI2?=
 =?utf-8?B?VkFqTCtWSkQ1dldoS0FlUGQ3WXg5anNEWHF0Mmc2bG1OM0xvVkYyOGFEcCtX?=
 =?utf-8?B?cnU0aURmVFl0VWtlVkpnMXlObWZ0L2liakZGZE0vQ2NIUmhweG1QazJVVjJ1?=
 =?utf-8?B?MWlHTFlhbElZK2R0MnBVd1dVY3R6VVk2ekx6RFdCbFRyakFWOSs0MzNRU3ov?=
 =?utf-8?B?WnR6MU85bjEvSzhaajBGLzc4NGJ2bWVBbHlnMmxJK2RWWUlCSnlzc3NOdHNZ?=
 =?utf-8?B?dDlxcnFhdW9HdFFZa2pqQ2JmRSs5WkdqSCs1bEEwZUtWQkdVNVVrR2tJc1h4?=
 =?utf-8?B?a3Fna09tcnJEeDRablI5bFpHdnN3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 22239e69-d309-4db5-7c28-08ddd8bdc693
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:59:35.1010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl993KozBgl1YI3bDf8pk32kiboXP20yeF6qZLok9iK4WR0/f/3BU4TrJcgIum5txNOcceBkGNS1ET9ZFzU82/psoVgGVOnheJXzSiERpr4=
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
> The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
> differs slightly compared to prior SoCs:
> 
> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
> - Booting from sfc1 M0 has not been tested (no board using this config).
> - Booting from USB report a new bootsource id 0x81.
> 
> Add a RK3576 specific read_brom_bootsource_id() function to help decode
> the new bootsource id values and the required boot_devices mapping of
> sfc0 and sfc1 to help support booting from SPI flash on RK3576.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index fb5a107f47d9..c7ed09e03eec 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -6,6 +6,11 @@
>   #include "rockchip-u-boot.dtsi"
>   
>   / {
> +	aliases {
> +		spi5 = &sfc0;
> +		spi6 = &sfc1;
> +	};
> +
>   	chosen {
>   		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>   	};
> @@ -16,6 +21,17 @@
>   	};
>   };
>   
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;

Is this a requirement of the SoC or just a default?

E.g. on my RK3399 I can flash at offset 0 u-boot-rockchip-spi.bin and 
it'll happily boot. Is it still the same on RK3576 but you preferred to 
have a similar offset than for eMMC/SD (and/or have space to store a 
partition table before?)

> +		};
> +	};
> +};
> +#endif

Not a blocker for this patch but I think it would make sense to invert 
the logic globally now so that we don't need to have to do this for 
every new Rockchip SoC we'll support.

Have -T rksd in rockchip-u-boot.dtsi and all SoCs that have an SPI 
controller and do not override this property would have -T rkspi set in 
their SoC DTSI, e.g. rk3399-u-boot.dtsi would now get

+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
+		};
+	};
+};
+#endif

Cheers,
Quentin
