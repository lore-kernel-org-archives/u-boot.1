Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97703CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E6F83678;
	Fri, 24 Oct 2025 19:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kAdhO+E2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC369837B6; Fri, 24 Oct 2025 19:00:30 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B306A83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugJTK4XRh7+UgAmQmdun/4Jy+oV4hm41QYScitgyiheBqcW8pBeJ7kRJ3TeqfkANYcKAZQSe7LXxkBkG1GCty7J8UmNGymVWchI133fJXQ0QyTMZ8jQa4vC9GAtmjSOitdgZhx6aaXtS1yM2ZTyiFUdW/O9PmjBM2b/qw+K2iRjz4ldkYsLGGXw9K7N0fkvcIFSu595tJYJTOLHH5JbQSaSqueFKQPW09u8tAIcJPv/ensKlY2+vkxYti9tW2TQKzWeGqxJ+mE1HDZ7ILRllxa2zQ8G8SFiEShsvnezmBRgUZk6oJuT1B4xUFkFvC67INlh/CCFdbNSbC9w2dEyouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUfUTO8R1dR6LUo64HybC50L6k5PUeQcTK2KHV7vMwc=;
 b=Go8aZnj/F7umF5cfASEBlcNZp3GohnSB/p5TtedYlWPvgSY/Ps7MpIDABHORiLFqPG6WnXtcyv3P1PoDmK0FLriXYg/2esmqnjemMPUl3nGpSTld879wyOjM8U0AilgsTGbeHLr22bVqx8ceFZkmt5FlHkle2WpObZOBxL+8hykPysQGrQz+rxlscW84+uzrBSeK264BG40ZWl5uvaGad1t2l70+BRI4LTNBm+LjA03tZOFkvixxmo+hDod8Ur19s5kAH241FXSa/7HmJtBksVgJhv+U/UlA93/SHRWRzG4o64nQdNeD6tbkqSX88ca1ncM86E7XAkzyVf4k9V1p2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUfUTO8R1dR6LUo64HybC50L6k5PUeQcTK2KHV7vMwc=;
 b=kAdhO+E2DZXZZWaRPOWPSAiJOpxJjn4SfRKvf8Vwsh5RacfhmIYuxLFj8iL1d71z6W3ElDICN3s4TqYalLMYOijv2UIDB3XYyt9etYV49R7cEX14EA/vboHmcQwsoD3NfMl/IvMGtIBdahKRQ9XFt0fGw3OYlFMz/N1mzZR784s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8688.eurprd04.prod.outlook.com (2603:10a6:102:21f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:00:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:00:27 +0000
Message-ID: <a9ef58c8-aa38-4763-b522-0ae2689e6824@cherry.de>
Date: Fri, 24 Oct 2025 19:00:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] doc: askenv: Reword and remove return value
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251024160557.2317081-1-trini@konsulko.com>
 <20251024160557.2317081-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251024160557.2317081-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: c5693c04-143b-4fee-8cd6-08de131ed4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3BNWDBMU0xqbzBjNW5KSHExN25uZXlVTmpBSWpFbjFnNlNLMDYvSDJTVitG?=
 =?utf-8?B?VCtOamt4TTZvVUJtRlEzUVFGMWRIR1VSei81TkdIcTlRVG5qSFhtT1R4ekFD?=
 =?utf-8?B?a3dtZVU0OHNHU3htaWZTUXBPNWFFRGxuMW1pUCtISVRKVEdHNkJSQnNTN1dt?=
 =?utf-8?B?dEJzWUZaWFhwZlRVbGgzak92MlNiQmhEMkE0akxUQUZkTy91cnFXcjJOQ2Jl?=
 =?utf-8?B?OXFmUFFvbjRHaWIvY3RlVXg5OUxSNkpGaWhZY2oxQnlLS29HMDIwRWVma1o5?=
 =?utf-8?B?dFRDR0RwWWpXWHBGZ1pvcVNJYmtiQkFwTXRSckRqb3ArdXc5R0tXT2J6T0Y2?=
 =?utf-8?B?bGcwZGpIWEo5b3YrRE44eWtETXBCbTlEcUY0VWF2aXlveHF3bHdVSUV1Qmhn?=
 =?utf-8?B?ZTlMeVREUHhCUWY2d3hvTkxQeW1uR1laTzNmZ2t6Y2NKN2RXb1RpSFZKQ3Ur?=
 =?utf-8?B?OWR4VlBkeEZ1QjZOek54THl4OE1DQnJ5eks0bkdHYk5WYmduOHB1VFAxVjVh?=
 =?utf-8?B?RDZmbndoa1ZuVzNPSm9KRzRUSTFvcGU0dDRBbENuQTlXNXlNRzMyVVM5QjBD?=
 =?utf-8?B?SitMYm5RTW85WHJBQUJNYm1iNno0UGJUK05UNE1Jd2pWRFJlS3UwamM1bmY3?=
 =?utf-8?B?a2p4NkZvQ3lBeEYzb2pGRDZCUGJsQ3FqVFVIVTFxWGk0UFFrUThrVzc0MkRw?=
 =?utf-8?B?bnBVTjJleHNXcUJQNUlOMGRDT0c5Y1FBc0Vwbml2ODErU0lxdTczSVd1RG4w?=
 =?utf-8?B?MkdvTjh5bFROS1hOdmZpalQ4SlU5NjFSNmpaSENTMFJWMFc5bUNQTWVzN3JV?=
 =?utf-8?B?ZW9DQzZwTy8wSkJVZ2NCdUtQZTJvRFc5NVNpSTZLNmUycUIyRzRvWVFsTmJZ?=
 =?utf-8?B?cjFXejVOUFVIZ3JHZzFQaTZVTTJWM1ZtZmRxaFFKeExieWpPemcweXVaaVlM?=
 =?utf-8?B?VDBDVWVhN3hJZWpubTBzbklJanUzSzlDL0VQcFYxeUZScGpPSzMrcHJ6UUFY?=
 =?utf-8?B?TDJwZkFiVjE0Rmt6a1VxWEJ6ejFOOHVXTnJPcmVXY2hLQ2hTdVZHV0VYdW1I?=
 =?utf-8?B?STJlMUZNTTVic2RodFJ5aHpaZmpHNmdDREduQXhVR1I4bWpiMXFualA0UFRJ?=
 =?utf-8?B?TlpHL2lQbzVMWndxVUpsZGlWVWpLcWlBZkdVU3hIUlVxZFJwQWlDaWZhRk9r?=
 =?utf-8?B?SkI3YlhMRVNOQ21GTHlKamlEcW5RZ1VtbWNmK0dUSXhrZW1JR3VGR0lFQ2Fw?=
 =?utf-8?B?WTBWZXB0elpsYWswdFJCWS8xT21QYVRXSG9RcHhoeUhrSXQ5NFZjOEVGQjhW?=
 =?utf-8?B?dldvZjBqVFJ6dVFhR1NJQ29OVCtnSS9NWi9rdXhUK0NPRThTSmNyTTlybWV3?=
 =?utf-8?B?RXJBZzd5VFVoR3d3ZXBFY0hwTHdqNFRYUlRYUHo3cWpUQzJXR1g1YzQ1WVUy?=
 =?utf-8?B?cWJvcU9paVU5Ky9kb0lvSzNmbGRuZnUycFVvKzd0Z0QvdkJ0K3NiMGMwUnp6?=
 =?utf-8?B?eFpTc09jRGF4OWRScnRoSXk1dTF2bVdyRTZaTmFFeGh1a01FdFlNblFkQjFu?=
 =?utf-8?B?d0ltekZPT2lTc2RUQWN6NGZwRGdwR2RvWU9UbStPUzRyUHpQVGdpd0ZHWFIw?=
 =?utf-8?B?b1JqQkNLV3hYVXJOUEtuYm9jYXBSb1h1QWY2bUdCajdNWlFlMVo4S0RibHdS?=
 =?utf-8?B?b3hUUWMzd1NWVzlhRk5sUUlPTHdza3BUcGgyUm9ET2pXWXZkMU1UYmRJcGxC?=
 =?utf-8?B?RkRzY2VKNE44VWxRZnU1NFRlOUhISzNVK0p4bGkyQ3oxT244RzZNZFRHT3Nw?=
 =?utf-8?B?bFF2NG9BWjJmTTdKS1pyTXdUeWhVOUxMS29wSVRKVVhROGs5UnhiM3duWnNs?=
 =?utf-8?B?d1RqbmxhVmlhVzU5WjdwejNZK0NoMzkrVWErT215ak5NTjBua3FkQUtzL3pF?=
 =?utf-8?Q?QKv/ZFAA083uzkXXDsB9k3f+L5QIfWUs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFF4cURPVDk3M01GN3J4S1Ezbmx1QzI2cm1GbXhZa1BVeE9aYm54Q3o1cHRG?=
 =?utf-8?B?SXU5NGFjcTZrYnVRMDdKV216M3FqZ2R5LzI0OXZtaU5GWnpqbDlzSVFwekNN?=
 =?utf-8?B?aTNqS29LQmR0OCtTLytPVE41QmV6clZhTWpoUUYrZXAzYktqTWgzUGZUNHdN?=
 =?utf-8?B?c1pqczdnU3FwUFBxK1p2MVkzMWc3T2xwYkVpdWM3U0cyR2Q2c3ZvNmlLdXBl?=
 =?utf-8?B?cHFFbE9TZ1VVY1RqLzJrVDl0cHV5UXZUbDJqeUlVaG1Wc1BCOXFJVUxJVmY5?=
 =?utf-8?B?OThjaUpkOGl4MjgwTDN4NWhpUVV0VVM2djhla2RkZU5BRzdWYlpGMVNjUGxj?=
 =?utf-8?B?Zm42WGpLQVgyK0YxWTdhelgrVDBYMkxUTjVNOXV2N1pGakpmQ05IdHRRdENa?=
 =?utf-8?B?eEM3QlRYYUl5MW0vQXQ0V1FucDQ5NUNsOHVHcmdHNGc0QUJia0UxWHlBVHpN?=
 =?utf-8?B?d0Z1TGtLZ0c1SURwSnlOOHo3ZjlpRnZFcHBEOWsyR2tzVS9JTTZ6eHR2VnB2?=
 =?utf-8?B?Y0ZFTlpXUWhieGJSTjNibDZvc2NkbXh5RmF0bEpEVzZyWUtZcVE2eHhoUXAx?=
 =?utf-8?B?d214b21mbkxCMVBSYnFUVkl0cUtOMW1KSkJudVpnVFQzdC9Jc3ZOR0I5cUdo?=
 =?utf-8?B?aGk0L292UjBZbHh2QU1DR0hITVRYb0IrL281VkZ3NFpSMzgyWFJmTXV3L1lm?=
 =?utf-8?B?SzEyM0pOL1FiZHlobnNZKzM2R0RpRlhVRWJrWnBwWS9qdHpLUWszaWRiTnJh?=
 =?utf-8?B?SkJ6bEY1RUNMdXNmQ3RsbnRjTC93VCt4NXhvcWpaUEdablVGem5vWlBRV0pY?=
 =?utf-8?B?dERNdUhCaWJoKzJzbkVLSkJQZVY1N05sajR6bWozTjN1Snhmb3V0bE1semVJ?=
 =?utf-8?B?TG1Edk5HUWZlWlAvN3BXQkY3VHpLSjJqRGdsZktIMlFpbUhJM0hxWlRXWWVt?=
 =?utf-8?B?Y2tJaWFNMDBLR3JQOWQyVWxLczM5VEh4dmZTSTZKWjg4TVBPdFBCZlp4Q1VC?=
 =?utf-8?B?K04rdVhRSUpWNldpSTQ0TzIxQTg4RUNmK1lVL21oRnh2UzNCS0hjSkYwbEFo?=
 =?utf-8?B?OUZydmdReFl3NDNLVTEzekNkUFFVaFFRK0Z4SnpYNjZZZjRNS0s0b0EwOHp1?=
 =?utf-8?B?ZG5EN1VQdTVaYU0yV1hZaTRyZHFGUll5MTFYbCthSitsUXJGVzF5bU1zb09a?=
 =?utf-8?B?NDZMWk9QVXVXaFM1T2o0RjJhQkV1MzFtNFBCYmxOVDF5amlVR1dUR0R3anAx?=
 =?utf-8?B?K2s0dzNFTzA5M3g4R2FuMXlrK3RFVkpBSXg3VU8za3NZUmxWa1N0dWFCYVNY?=
 =?utf-8?B?LytNbE1lNCtBbGdnaGNwWW11Z1UxU0ZlV3JUdmJRUVlWQjhNNGFtUDBZcVNt?=
 =?utf-8?B?WVB6ZTlHaVpZKzdOSGJraFlZTkhiSlNnM0VBVlVZQXJVMEgwQWZYaHZ5WXZC?=
 =?utf-8?B?U0ZYOU85TXFVWG5aZ0V1ZEFTajZWbVVFUFMrS01vQXFqVXhJK2tXSS9BenhN?=
 =?utf-8?B?WUxpemJTUHZrbkFLTVgycnpMVjlKMng2VUJMeURNMzN2bVVVTnBUNlpYZkNZ?=
 =?utf-8?B?R1hJSURxN2lxZDdjU2NPbldLRXVTWlQzNGg2dmJ1cUVGV2JyeEsyZWhPTzVS?=
 =?utf-8?B?QktJMXpIMlJQYkkzNHhaSXUyS0EvNlVRWkRBVDQvZDVHcEI3WFdFMWEvVlVt?=
 =?utf-8?B?MUxSS21MV3VkMGgxNndTUm1QUE43dUxpVW9yVFFOdjhQNDVxYjVqa2NTc1Mw?=
 =?utf-8?B?ZjY4U3VDZmZoZGRJV0U0a2tBWmhHSnh0alNwWmRjN3M1V2tPZ0d1ZUV6R2ZW?=
 =?utf-8?B?a2k0eUc5UDBOaXhoNlU2d21XTE41ZEo5UXpFQnkzWWp4eEwydXNMamtDekJD?=
 =?utf-8?B?ZEd1QTU1WURxdEhha01mR2ZmaWtpZlVubmVPM1lMVWtxbWVCYy9kdFo1azNI?=
 =?utf-8?B?ZnhLbkN6QjZZY2svZitTaDFDTGRrWjFCNEo5U3JyakZGVVJvVXQ1c0JYSnlE?=
 =?utf-8?B?N3FUSjRHWE5zam45UUpSUGNnUXd3ZjIzMUpnNlBqWEFXUE1QUzBhd29pdk5M?=
 =?utf-8?B?andzVWxhN2JvQlIwSXpaaTl4QitmTTRLUENrK3A0L1NVUy8xTk9DbVlPbHhu?=
 =?utf-8?B?WTRaelh2cDNveFJiaWJSSlQ3cHFZYU1HaTd3cHcvYTFpSm1VMUNObHZEdUx6?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5693c04-143b-4fee-8cd6-08de131ed4f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:00:27.7038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R53wDDXT5X46Dj5LQjJNcluZo7cTK0Y97GqDoJfz6NAGu0fpDlrDJ7bZ3fX2SRJvcE5qXkNhNl1JH4yRH1Px0PXDaLJgXR9+pbJrxUhsogQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8688
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

Hi Tom,

On 10/24/25 6:02 PM, Tom Rini wrote:
> With the addition of general text about how the return value is handled,
> remove the examples from the askenv documentation as they are all normal
> expected results.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
