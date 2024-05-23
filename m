Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C26C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43F3885C5;
	Thu, 23 May 2024 16:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Yu+G1elm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1689885C5; Thu, 23 May 2024 16:52:50 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0706.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D8C885A4
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQMxsOfrQdZKG4sGqn3vSDM9oJAzvX0avcuqZBckiKTI20EaQfRhF4rY0ECvVXojo3pDrutr3riE/FvLErLvk8UZIeYI0ggoG2JeeS5Bmcxn4cuv/EW1eZFgWk6Fo6gJGrNFFbv9nQCG1StX+wWwe3LIdwy5G+uKANFBt9JNxzIA73kLhMww946DH8BewApUU0uPwKsYbKe8y13jQ29NQwWJodWeXGKaMf2JxQ0Lpu7wnMldZYOSod1Xe6k3xfCaAiXKVkioUyiTsbl2gInQi7JQkEfaAVlFRvttL2re4KR7d1F27iwsNGIdedF2PwuNoU0l6ZLJSlMwjKh2kHa+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGaFK8uJY7Rljswcyh045B7ZnG1hvdF0TyJwmcDfHAY=;
 b=QTvZOgoPfEAL4s8fxhvBuThwsXh5J+mF3USZZLsye/FndyzTAmJkriUg/GnBOzURg5Qhs10CINkw3J6NwZzAEd/R57htcsliwosYbFFTgD1Zf35MlLhl4RzeNQ69c0Mq8Bswwm7nH0GoC9f2XlV6eu28cCr0za7t0nwgFUPYCziiY9BVSQVt/nw3teNiAg3M7bUbWYqANQ3UDOVHI812xzVsoNRcxevIKxqNC6GD+0ivUu/+XuuxJKOlUqmfC6y6nUHxuwVZlH0/Wkzq+AexAFlRAAC8zc8CDDAe4WTKtY63Ytmng2xJ0QimY8lVo+Ub5F9z0hioo0b/jO+LGBp1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGaFK8uJY7Rljswcyh045B7ZnG1hvdF0TyJwmcDfHAY=;
 b=Yu+G1elm9q680x42mU8cCa5D/D3uvNoDHdeHEcj3weGgzK7DiYmUr7IwE0yWtZ+hWU52Ko6hkH70RiKtuOfOeS0z3jYUDYHn+dOCglMgkmMo5I09ciLEBMWGUgqrrDOqvZJqijEngwoW9ILyeIH60HnsL8zM5k+uPVSwRMlizFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:52:47 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:52:47 +0000
Message-ID: <eeb6ae16-0578-42e4-8112-be12fd733dc0@cherry.de>
Date: Thu, 23 May 2024 16:52:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/42] mmc: dw_mmc: Extract FIFO init into a separate
 routine
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-6-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa52c1b-df08-4712-9160-08dc7b3802ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWh1YmpjMW5ydXZUeGQ0UjhTS2J4R3lNYlNTTDNQRFhIcVRmYVVZNEh1OE0y?=
 =?utf-8?B?VGV6MEl4MURWV1FwbEJId3RnSGIwTzVkYVFDc1hXMWFJNk93WFpZSGJ4YUpH?=
 =?utf-8?B?QWpUZTFpbEJDZ28zY1NjRmF2bnhsRGk2anptWjExWmY5Mk41dmN4TTVsSFlw?=
 =?utf-8?B?UVZablc4NTFTeUd4ZncyQmw2L25OWXpvbmFOS3JDRTNRcVZpMWp3Mjg4enZU?=
 =?utf-8?B?MjB6OGVMeEdiczZ1N2hWK2RZRUtVTmdvYTJkNVAvZmJ1NGVkRmxyVmYxeE1L?=
 =?utf-8?B?TXo0V21lTVhLVW0xdUxuNVhGY3FabEhZNzNTbURVcDVCNURkVW9uN0ZNUkxP?=
 =?utf-8?B?Q0xLRk1HeGljWDBCK3RubUxRcW5tNEV1Rk9qNU1MdXdqd2xsQ2tNOFdKd3gz?=
 =?utf-8?B?MVFENnJZK1h6SEVNNnhuR2dBa2ZxajdKb01QaGdQNy9HYVB2THlaRExRdUdN?=
 =?utf-8?B?YXJNdEFXaktreC95NUF0WWlUZkVWaFdpVXYwbHRxeDJoUWlYYjNra0prWEdG?=
 =?utf-8?B?eUxHRU1pQTY1UTQza3E3QXYzelN6OHIzYlAvOHhTbkdGUnpvY2VBd0RuZERL?=
 =?utf-8?B?cEZhSzZyV0RLL3dRSklHMDMvYVpvWUJnQTFlL0ZIQkZra3F4bHZXdC96MzhN?=
 =?utf-8?B?SE1NeFZ3bWRiRjJLbE9WcWFaamZiMzJMU0NVMm5TN2ZZVEpwYXlUQWIyNTZ2?=
 =?utf-8?B?a1lsUEpXaDdnUDN6bHo4NTlWcTdEMmdTVW5lUmRJa3A0K2Noc283VU82WVd2?=
 =?utf-8?B?bzgyQXZhdkNnK0c1SjRycmdtbFRSMHU1alpIWjZzOThkZ29EYUU5K2NtUTB2?=
 =?utf-8?B?UWU4OUJtUDRWZU5EbjFsMEpncjduazdhRE1iMzE5b2RLRE1oZ1JxbkhERDhO?=
 =?utf-8?B?UXoweFZZeks5d2dKdGg1cFIzVHA2VmVyL0Rldkt1OUNESkNPdCtZYkdnMXNW?=
 =?utf-8?B?S3AwREczSlA0dWpEeHFDQ05NMWhkRjUrYjNDUGlYa3A1d3R0VDVpQUdEeDE5?=
 =?utf-8?B?bTZML2NsTXZPdlo2UWhKMngzblhETVloNXc0NER0U1NYYWMzUE5lVStTb3A5?=
 =?utf-8?B?VEQzSVpEYXFBTWFyWmdOVWNOWU9CQ1pxSkx2TytJRUdmVmV5bjdYNzY0VlFr?=
 =?utf-8?B?amVMSjZtOVZTaXpyZm4xVmovaitHVFBBY1JWV3ZnbmhVc1EvTStuOEo5NDVK?=
 =?utf-8?B?elEwK3k3SjN2c1VnREEvOXZqQXhubXNSeTlFbGJPQnlHdmdQdG4wSWl1VTFM?=
 =?utf-8?B?L0lKL25SMjd4TGpjeUowRnZhQlRtNUk5SE53R25WcVA3aEhTN3JsZ1JTSXlT?=
 =?utf-8?B?Ymh1NXFKSTkvLy9PZndTNjBtQllLdVhDWDNDUWtva1BBMEVXMVpudFBYNmEv?=
 =?utf-8?B?OEhFK2lCVi8zYy9xZ05JNFl0UmJYYkI2UnorazdNNG9wTDZTUmhJZG1WNmJy?=
 =?utf-8?B?Mk9iRUJzVElranczWGdVTStOV0JFYkR0a3FiZk9ZbTluZ25jN1BJKzgzaUs3?=
 =?utf-8?B?T0hyMjNIc0Q2NEE3VEZCbXdvSDk0WnF5eFc3QUJSZlk5eXJ0SkZ5bVVQVzVU?=
 =?utf-8?B?bmNZeElqSTJMYWdFVlBVdndwTEg1TWRSbGwrWm9WUEhpQ0ZwTmllQTNvYW1v?=
 =?utf-8?B?cWI3eTltNWI1K1E1U090V0RabEhtMlhOdUJod1d2VWZxRXJJaXR2b1I4Q1lG?=
 =?utf-8?B?VVpmOGpyejNEZERPK1ZERW5kNHBZZTgyQ0x0RjdreWIzNnFPWTdLYWZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdxRmZvbmNGaHFGSnpyZFp0dXBwbDFqQzFhMjJYbFZqSG9xUUYreHR4SHNS?=
 =?utf-8?B?ZWhEQlNUdUVocTdHS1YzVHNXZEVOSmw4L1lLeWlEdWZidkZjWmxyeHdQMjNv?=
 =?utf-8?B?YjhqcjlQd2JGUkxiQ1BRKytGUXlEVWpWMXJBdUVrWEc3Yk1wVkQxU3cvNEY5?=
 =?utf-8?B?ZldGNndaMTRhZkZIUHhtUFAzc3hma3dIVHZkbTNodUlSeFRKVkxIdFBIRWkz?=
 =?utf-8?B?YmZSSmxuN3FTb0RLN3hRODR0dGM1ZUdiUWlKZklXVVFsVzdoMm1WS2NDTjJu?=
 =?utf-8?B?MnR3TnM4b1dnMnhPeWRqNkE5V0xqS3R4RXdvQlh1Y0c2dGp3NmYrcy94Z3dx?=
 =?utf-8?B?dTExQzJEWU5kOTVqY0VwWUdyWTV1cHpGUFRSS3Bzb2hTM05DejZ1VWlMQVZH?=
 =?utf-8?B?NnhmNk5KZXdYdmhtTjhaNmF1UmpITjUxMFBTRUdLS3ZuL3dRZnBtbmZFUVdi?=
 =?utf-8?B?M0llL2JBeDc2YmFZeE0rNkEzQWw0dHY4czBvNW1hKzZ0L0ZsTmx5RnNpdE00?=
 =?utf-8?B?SGVCZkFvQXRTRXVrc0hTdFp4WlN1RmhocjRMRG9tQWZvb1BEREhxOG1YYzBD?=
 =?utf-8?B?QWJ3SnhPM2ljMjVPOVI0SVZoM0FNWXRpNWQxL0ZGTVlaQ3N5UDd3OFM2eTAy?=
 =?utf-8?B?VDJNZk9YdXBDeUY3bFpYOFNXeXFQbSthWS9OWk9lWmFjZEJrY2N3MDZFSW5I?=
 =?utf-8?B?cUZZQmc5YUZEQnpVS0pUcHcybmRFU3N6NGZ5ZU5qN2lGWUw4RC9ibWpzeTZv?=
 =?utf-8?B?S3VHZ0xVMXBPdUlXMDhoTG9zVHFmYmtCRjZSTXh5Y1VRT3RwY2JRWnY5TUxE?=
 =?utf-8?B?RUhVSkc4NERyUUI5OHlmRFhiM2FQQm1SZmRYMTJtVjhsV2kyTXR0a3lIcFJ1?=
 =?utf-8?B?SWczQ1FMNlFSWTBnNGVueXBEckMreWc3b21IVWNLNW9DaVRxakRBZFF4ei9n?=
 =?utf-8?B?NzRTQTFzczQ3S2pYeSsxWmJud1J4S0V3ZEY0VVBvcjQzWnhINk9rZVVxeUU0?=
 =?utf-8?B?a29PMGZYbk1kSWpuYTdkYUhWaU5vRnVYWVdNWDhFck5yZVk1VmExSGd4dm0r?=
 =?utf-8?B?M0ZDS3ZaNDZWYWNUL0lpUkNuN21yeEJWVDcyMVFUM1d2MEgzNzR6Q1lXcWFq?=
 =?utf-8?B?RU1NUVV5VWhIdW9Cam9Tcmwrdy9jZ0lzbUhkVE1Lbm5TSFR0VXR0d1kyZ25C?=
 =?utf-8?B?ZS9VYnlTcmVvTG1ZWVo3cU91Nk5mcHM0L2t4SE10UDJZc3lrZGdUU0R2VXMy?=
 =?utf-8?B?ZWU4ZE9zUUcrdlpyL3pYVW40QlZHNEQ3L0lwZ1AvSHZBZnRUWFgxMWh6a0Jt?=
 =?utf-8?B?dGhqdCtYSDFuRHgzYlVlWXhLTXY4akViR0tBaWxlOHZBemcrdjF6bzQ2cUFL?=
 =?utf-8?B?RGFSbmtBTVJReGlvc2VzU1BEbUlFdEZXMjQxM3p5d0djZVRIVVBBNXZxbU81?=
 =?utf-8?B?cGUvdjFVdG5qZmFCSFFuVzNiaUR1SUgxVklkdHFEWnBnREJuYlMzNlIyT0t1?=
 =?utf-8?B?c1RrZkpSVGd5R1NMUmlPQm5nN1p4MjdmZElMYnpTY0tRN3Q5VmJMWHhtUGp6?=
 =?utf-8?B?Qkpmd01jOGlTL0pMVXlQdzE1VXlRaHYyZHVrSmEzYmxneHk3Nmx6UHBhWUVW?=
 =?utf-8?B?RmVPN1BhZ2hnR3AxOVVhTVROY3hTdGJZTXlKZlRwazNYRzBOMWZKYlhmcm8r?=
 =?utf-8?B?UmVPeDBSYjRtbithcGtTN1pwSEJ3bFpjcjF3RDhsNTZBdmdvcU9jMVZuNTZS?=
 =?utf-8?B?RmVodFM5U1dNL0ZkUm5hbHJoY3ZHNFE1NmY3dnlzVjFJdzY4Vm5URDJ0cmNy?=
 =?utf-8?B?NFVrdEg1azFJclRwREdSRDlWQXNDZHBuUGVjMjlXdEVaZjNCOXVZZ1BEWWJt?=
 =?utf-8?B?YkltQUYzd0NYMzAyRnRSb0lHWnVjZkxmUHc5N29Fcy9FY3FhZnd6WStwQU9W?=
 =?utf-8?B?QlNacTQwLysvUGY2S1BHTG4zU2pPeGM0U0FDMEJMZExlUk1sN243TFJ3WTFt?=
 =?utf-8?B?bFJPV2Nkdi9LVWVUR3pRelRHTk96emJKQlJNZkpCSGoxRkkwU1h4aVE2YWdZ?=
 =?utf-8?B?aGc5dXlSeDBvQlhRY2JkcFZOUXJiYjhqWTdmNUJBa0RWdVJFSVphY0ZLVW5B?=
 =?utf-8?B?SFppSkdpTnZHa01OSFlDZXMxSTR0VXI1c0F3QVBFWnZiNWtxNlJxNTFWY1M0?=
 =?utf-8?Q?eucLjb4RkBiePhLnYaCnGCE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa52c1b-df08-4712-9160-08dc7b3802ed
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:52:47.8315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5nncRkn33bMBdTLq1KoRDIv8xrpgkhaZo8FuUhT67GRqThP1rJ2tB6FF3CR97ysMOPTeM9wYVyf9tw0Jm2dBHkaGkD4Tlv3OSw0wiEHX2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
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

Hi Sam,

On 5/23/24 1:30 AM, Sam Protsenko wrote:
> Move FIFO threshold initialization into a separate function to make
> dwmci_init() more readable.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
