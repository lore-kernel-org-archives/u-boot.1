Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B6EC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 09:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC4282CFA;
	Mon, 14 Jul 2025 11:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H+Z6Wb4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF7E82E52; Mon, 14 Jul 2025 11:36:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 981E382B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 11:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEDNEwhU7RG7Y6Mvq1SsBEPGOFjJXJyo7KnUYIj5LbngizxHnO+cT71/tpHPXQNIfBZzyhYo8zob5qy1fJue8Qa1mgff5Kt0fE58jyfW+joOkuF2TrByDV7BA/4rsnbLxvCJRqIY6Y3Ljhyrk8e+TPWq81lkUVacPX3EaiXrWVvUD3jx4erBQEr44ltsT22YZYQo1eIZmoOniD8WiqJFxs9UFzG9iU+xmEmw/d0dQYHjcdjDtCVsyTXrvAPcLvQhAWlHvtrYjvCwKUycFqJp96wUxrtv/X4FpHPOmXWHSQqp7Ho+ZnG0spc8v2EaNh7hNYMpEjfockcHScpFVPU4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDwoO4Ozh05Hj86MSPIjrUciWMsfA1L1ykoypinzbIo=;
 b=X+TJ1TKKhZ7z6fqxLDYNv0NxKxXIXzi1tv+dF5imTNaUvf9lLwLrHBVC7m3n2a57RA6jQePFZ/ov42WgSZotPNZaww5bVaceeOTx1TL/iVYdNK+eRkSx+/hUZDaPZjrcZVHfCmvKhSdc+P5tgsMyYbRxOYl/xahBNFX5X1YLVsrgBS9Ba1mQ7O7QASpVU5IeQVZJde3XeDbza2WJeGl0Njqqf2oq43BRs1EmYaRwcMfPNf1zS8I014dDn7m6GJeiIIlqY54AUOiTn4pLTrIFOwcA04w0jRHC3W5RjgAnoTFzf1E9l5aCNIu5fxwXqUqMZ2gLhsr8pMMHjtR6Gn+FGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDwoO4Ozh05Hj86MSPIjrUciWMsfA1L1ykoypinzbIo=;
 b=H+Z6Wb4HzsPfVgHGQnUQK4aqX/RxzOPZSdT16J179pQEqvIeMS8jXq8gEPJMV+5inHp+UylfoCgF4uhDvYNZUp7y7pvDd7W6zeV6ILJ3mao2xm89qoiG6lhFk48eQT6fwdthVOXQ9xHG8mM6mv3hBRt7st9SG9TvbjDvmcYa2to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 09:36:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:36:01 +0000
Message-ID: <a9587b7f-95fa-472c-af5a-8f45d606666d@cherry.de>
Date: Mon, 14 Jul 2025 11:36:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add support for rk3588 MNT Reform2
To: Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250630102524.127970-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250630102524.127970-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 19266e08-6688-4d4a-c925-08ddc2b9d8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnhtRllNOXVsbm0wUXgzWkI4SVRQRkt0VWg3U2IrVlN5ekFTc3ordXBKeUZ0?=
 =?utf-8?B?cGo4ZW5YWUd6TGo3aWFGc3dPSDVwTndPcVROVzEreFF2MkIxWXpIYXFVWXlq?=
 =?utf-8?B?Q3ppYUZyeGsrbjRPZDdtK0FyWlFLNi9sYlpDY1NuNi9EbTlBYmt5RzVEazdO?=
 =?utf-8?B?N2J0RDc1alV0MUkyb0ovQ0JtNGcyTmRKT20xVjJPLzI0Nmx6Z2xrRGpEdkk2?=
 =?utf-8?B?K21HekcyaE9QQU9hYkluTzJPQVoweS8vS3FvQzcwRXREQ0QxZEdzSGdId0d1?=
 =?utf-8?B?UVA1TmNUMTFaSVl0WXNpMC83RlFDd29LSFNJOVk0Rk9wckpWY3ZaUDdxcll6?=
 =?utf-8?B?T3kycEY4dHBMRlBQbGJTNWNoaEdBdWtaNDE3WnRMdjZoVFYvdmZBZmQ1QTdC?=
 =?utf-8?B?WHRiT3RrTDY4SlRCYkU0QS9Ia2pwOG1TL1RKT20zbGZzMlF6akRJQ0QzejBY?=
 =?utf-8?B?QTVONFBZcDY0Y2kwUGNZUTJqR0QyWm9peFNrT3lORTc5d0NjcW85NnoxRTcv?=
 =?utf-8?B?YmVsOUNZUTQydmZadEo2K0t4R3NtS1NrdGY4cFpoeWhTSlZpNTJDa21tV3Uy?=
 =?utf-8?B?MENZS2M3NVY3RDdmRjVua0l1SExCb0lpTEhhcUJkdytBd0FtcVVtNXdkT0tY?=
 =?utf-8?B?USt2SDBqRlpWSWRyUWI3MUhnTHdYeFVkYWlFWjcyZFpoYlpNV0dHamhtTDFK?=
 =?utf-8?B?OG1pU1NmUW5JaC9ZSlpnc3JvOHlLSVFsSWhGRElzelhCakhUZW1OcEJzR2Y5?=
 =?utf-8?B?S0NoOVc1bEZrUmR6VTJqRmpqU0wxMWtHNFVCWlpiK3lMUWluUGs3aE1FQ0dP?=
 =?utf-8?B?ZktUYmJJY3FnRUFFNFZGbHFva2ZVSHlNb2hkNVo2QkJaTjRESnVncTNpMzBz?=
 =?utf-8?B?b2IycHM1ZFQ2cE54Q1FLL21tcUs5aWJPQkZER3E4Y05mcWtCVk1QU3NEdG1T?=
 =?utf-8?B?MlFEN0dqR09zSFlTQ2pydEw5WUFpelN5VVJzWUZiRlN3OXpIZ0dPejc5L3RM?=
 =?utf-8?B?QWl4ajd5emxZaGMxOWh0cHpXS05ReTZrQ09SSzJLK1RvNEIvL2x6Mk5uajZv?=
 =?utf-8?B?VXcyenE1R0hWWkt5ZnBQNWZmUEZYYkc4bzZ0QnhGVlViR2UxZWVnQmdpeHZw?=
 =?utf-8?B?RXErMUVYZnpNbk12UjF5UEE0ZXpyaWgzbjhYUHYrbVhvYlp4MDFjckJYNExV?=
 =?utf-8?B?N3N5RUtiS3FITnY4ZGgyV1p3M09JQlQ3U0xBbmNsbTRDWWFzU1FvaEVIQ0Jj?=
 =?utf-8?B?QmcxT05nY2pTWmxORk9WVDJNcldoam8vQ3UrMFpFOXYrUG1RUDdWQVRXV3E3?=
 =?utf-8?B?SXdpU0dqWHVUQlFhaTd5aURLQlB2UjRnbmxpbi9BQkw3aFl0V2RmcTc1ZVRn?=
 =?utf-8?B?UDFnUzBuUFcxOHk1NGc1azNtdHcwbEtJK3p4UHpJZW1xSU8rQkZLTXRKU3Q2?=
 =?utf-8?B?Q005MXpnK3pmcU9wYVRHRGdIQkI3VW1NdXQ0NDJVOWQyZERyZDg0SEhPS0ps?=
 =?utf-8?B?QlhnaGloeXhZcU1FbVZJQlBoNUVEZDRDRE9XWFJoaTBETmhkOFZMaWptTFpM?=
 =?utf-8?B?Y0RVQ042MnBET1pvWmdWS3U2eG4zWkRmRkhkWGVPMTc4aUN6djVISGowYzll?=
 =?utf-8?B?S3JoWnc4MWt3T2owSFRjNElEMzI3a0IwdTdodVEwSXQzY0t5Uzkvb0JQdTRO?=
 =?utf-8?B?SmJ4Y3NzbHRyWmQ4cmcwdTZUZnNlZVIxU3JYeUJ6M0pKWVE5SnM4clRzZVFR?=
 =?utf-8?B?aS96SUFFdUhhc1Y0aTZETXF2clh0SUFXckl2dUZ0UU92aDY1RTJUaGFkTXFT?=
 =?utf-8?B?YVNyTHZzVjh1NmlwRXJZSnNMK0NsMVJtZTJOZm90V0xnQjlyRU1DTEUxejNR?=
 =?utf-8?B?dVJPejh5VXVSNWw0TFFGSk9yWUs5VDlnRk9QOUtoanlld09zQlRBaEkzcVdh?=
 =?utf-8?Q?dQX5qyNZ/SA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZUeTFncXRmbmN6c2o4MkxlcHpMeWRlZGpjeGJ4NlVSRUFrVjF2cllCK0tj?=
 =?utf-8?B?NnFRRXRZRGV5NWdqQjRibjY4eXl4TGtVcXZVOHp6bzB5MWRwMW42dEd2Y0pM?=
 =?utf-8?B?WXp2NGovaFZzZjBVUGtJL2ptb3NHdU0wc2xLZUprcm9DbVlxaVVvc2NBSGx1?=
 =?utf-8?B?TjZoOC82YjdoSlJoZ3NaZXpubzhNU1VxMlFHVUxhd2NIUXJtQi91RG5BbFNN?=
 =?utf-8?B?V1c5S202c2tIRkJTU1BnQWNoeFpWdTMvdGpsZ0hOb0pjM0lsVkhrMG56eTkr?=
 =?utf-8?B?aUlXTGZoV3Zqbmx3cUV4TUJ6UEQ2dFpDODNIaTAyc282ZmxRUkc3TEZlalBP?=
 =?utf-8?B?Smx0YlVVSndUTlBuTks5OWU2TDZJZkRxK1h0dkhITWtrMzdSNE9RRitWaVVH?=
 =?utf-8?B?QkJLV0puOUJFYjR4OVFCZFlpNUJsS2RJL0cxbjg1ZXN1U29KNDAwN0dSc0Na?=
 =?utf-8?B?eUJCSEllODUzQktYTXVBMDRDdnZRY091UlE0eVp3M25jZmlKTXNzaDVFOWpw?=
 =?utf-8?B?ei8zb1B6bXNIeERZN1ErR1FDOVNKQU9IVmgvOWFsSEYrU2c2bGJ3cC9TSkMy?=
 =?utf-8?B?dHplRkhodFUrem9kNHYrR1ZXcVZkTS9XLzcyN3NyUGNtd3NJS0Q2S0xCY1RK?=
 =?utf-8?B?Z2lCajRISTNRWWg4eTFLUmkyVGgyWHRDcTNxYTdrQW1sOXJCNVJEL2NUeGIv?=
 =?utf-8?B?SEF6aEN6S0RTNHhQYWhUOEhlRGRmeitUOXhxdFlLNllralpZRGtTelI3MkZG?=
 =?utf-8?B?VjI0VHVjUVh1TkloZ0xvY3d6RzFzeTFNYlA0OFVyOWRMYlZxZUJzTEtpREZU?=
 =?utf-8?B?anNOei8wSVZ0YUFYOVFoNGtUUlBldXRZRmYySDlYeGd4ZHJDMmc0ZERKcS9k?=
 =?utf-8?B?enk1SWhTOWpyQlJJWHhsSUZ0NnJHSmdSSURSdEt1NG8zRTJUeGZqOUdIYW40?=
 =?utf-8?B?NnVSWTlodHJyOFR0STdNanl6akwwaTJqcUtkOCtaRkhpbzk5VTQwajNScU9V?=
 =?utf-8?B?bi8xd1EyUzRuRVNOMHZaV01WKzhCZFAvc1NkRGZVbkJsOXBhR0xYbmVzSEVv?=
 =?utf-8?B?KzVrUDVIdms2Y2dzcHVKWDBYUDFRckZDdm1odjFwMGZFKzY1LzdmK3NUcU5W?=
 =?utf-8?B?RTJ2OFUzaVd3OUsvcUpSVERmbXhFR0orYmJUd3lWOXJsWFF3MjYralZyblcx?=
 =?utf-8?B?MFBZL2hZYVAwSDZpbFNrVEY2VXpCTUNWWS8yNUQzWjhETmxkOGlCVGc2N2c2?=
 =?utf-8?B?OGMwbUo2ajNvUmw4dmJ5dTVmRHZGTmRXaHBmdEIwTXRwRGs5Zml4Z3hDbW1O?=
 =?utf-8?B?WFU0K3ByMldKSkwzVUV6dzcvNVNoWDFVamZrbG56d3VkREptTWZ0VDV4Wm9p?=
 =?utf-8?B?bkNjVWg2bG1GMTBPUSt5R1BhUlFqeFlTQ0ZDc2U3SEpHcVcyTUl5c2hyN0Na?=
 =?utf-8?B?WGZ2NzhldzVJbmxCS0xQZzB5cnZRdEh5SGhqS2g0NzlpZFRpZytSSjhIZko1?=
 =?utf-8?B?azFFRTdaVmt3S3RsN1F5UmNQSUtRUTlLS25FNXZaV3dwQjRHZHg3cGVIZGlV?=
 =?utf-8?B?YU1vQ25wMUgwV3o3bXJNZlVkNXRXYjQ3N3Jub3I2cDhWVmN6cDBTMXVqcERj?=
 =?utf-8?B?b0puOVZSUHMwOEg0ejhqTjBoTk52bFkwMitweUZJNzRqVlVNckJMMlVmVUJr?=
 =?utf-8?B?RGZma3h0dEFpS1NiZkxQRlBQL1ZXSnNZL0RIUEdqdjU2NDBtaHBGS3V5Qy96?=
 =?utf-8?B?MkJpOEp0bWJBWGQ1WEVneVAyN0trTys4QTAvZWxYd0dDbGFUWW1aNjRUd2dr?=
 =?utf-8?B?SlBIemR0UUpxcTZrbEFmZ0VOWE5WdVBQOTl1L1lBSElvdkdySkhad1l1WGhW?=
 =?utf-8?B?WWNHTG01MzR2TEw5WW5tVXIzRGNmb0l0Z3Q2SjFCQW5lbGtlQkxUQk50bkxZ?=
 =?utf-8?B?TnBRenYzWUJHQXNHLzdYYkVTM09uVTArVjZQOEZpcDI2b0YvQjMzQVMrSmM2?=
 =?utf-8?B?WVJKZG4wdkpQTTYyRDI5STdlbkJPb3UrOFVRVjlVZHp3YTFTbDliaTNoTVI1?=
 =?utf-8?B?a2FzSkZvZmZBa1cvTXNYZkR6Rm9UOWx4VUI5MGx2OVVhMWVITjZoc09VZUlI?=
 =?utf-8?B?RnA2QlRCaGFIWUIyUWNPejlJMEYyM2Zmc0FKdlIvTFhPbHhtQjlYY1h2SVFn?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19266e08-6688-4d4a-c925-08ddc2b9d8b4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:36:01.8706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ViVP896oNZcK1iIU4KfsQlnq54305e0jRXpnyCNCSLGBFbnMwT4sL5mgIs+YPJaq9ShmjXHQE6zDzAsLhCX02ms15AZWH/NbdrWtU8YqUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668
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

Hi Peter,

On 6/30/25 12:25 PM, Peter Robinson wrote:
> Add support for MNT Reform2, it works as a carrier board
> with a Firefly iCore-3588Q SoM.
> 
> Specification:
> - Rockchip RK3588
> - LPDDR5X 16/32 GB
> - eMMC 128/256 GB
> - HDMI Type A out x 1
> - USB 3.0 Host x 1
> - USB-C 3.0 with DisplayPort AltMode
> - PCIE M.2 E Key for Wireless connection
> - PCIE M.2 M Key for NVME connection
> - DSI to eDP panel
> - 1Gb Ethernet w/ Microchip KSZ9310 PHY
> 
> Tested using Fedora boot on USB stick and eMMC.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>   arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi | 14 ++++
>   board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
>   configs/mnt-reform2-rk3588_defconfig        | 87 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst             |  1 +
>   4 files changed, 108 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>   create mode 100644 configs/mnt-reform2-rk3588_defconfig
> 
> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> new file mode 100644
> index 00000000000..d54220a3271
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;

This is the same as the one in rk3588s-u-boot.dtsi so I think it can be 
omitted?

> +	};
> +};
> +
> +&fspim2_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

I couldn't see where fspim2_pins is used for this board, are you sure 
this is correct? I don't see sfc node being enabled.

> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 1232f05a387..24cf13c3c48 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -29,6 +29,12 @@ F:	configs/generic-rk3588_defconfig
>   F:	arch/arm/dts/rk3588-generic.dts
>   F:	arch/arm/dts/rk3588-generic-u-boot.dtsi
>   
> +MNT-REFORM2-RK3588
> +M:	Peter Robinson <pbrobinson@gmail.com>
> +S:	Maintained
> +F:	configs/mnt-reform2-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> +
>   ORANGEPI-5-RK3588
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
> new file mode 100644
> index 00000000000..e76c714b03d
> --- /dev/null
> +++ b/configs/mnt-reform2-rk3588_defconfig
> @@ -0,0 +1,87 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"

Shouldn't that end with .dtb?

> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y

Mmmm CONFIG_SYS_I2C_ROCKCHIP=y appearing twice smells like hand-edited 
defconfig, can you run make savedefconfig on it and use that output in 
the patch?

> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHYLIB=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y

I am not sure this setup actually has an SPI flash? At least couldn't 
find it in the device tree in upstream Linux's Rockchip maintainer tree 
for 6.17.

Cheers,
Quentin
