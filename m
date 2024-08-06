Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96362C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B4E8811C;
	Tue,  6 Aug 2024 15:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FiM2ZdDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 506A387F3B; Tue,  6 Aug 2024 15:06:19 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EC58811C
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 15:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfLRJ0Oj+EX+Xe4kcexVQIBNHc+CxKYPPJQkjZuRzxv/8ajb4mcBWTf1kAc0dMpMTRtv6AUv9rTgtGpABCQEPaLImA8SiFr4w0VUhPP7ux60ZWNdt+/0JAEhN9tkegU/qsQJ3U8A/67wFTHQJmObx4LWMBTRsxor73aaqs6yVi8N8Rk1qO+cYDR7vwGYYzlaLRhosxygwQOMXyWVtQ+GpJG5Qk/2Ydl8YpVJhKxqVWq4qUcJf6Xj5d/j6BOxhWWB9QtPQN/xzBPD/MYC7uUvoUyd9cIjqLwM7YN6j1wxxzTvUGo6dxE17ZMPYoZIWLYaamcDSK6ACM4MA3c8Uwh96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmxndbcJ1aG/Sr10lTmIjWbtTX9bXemV1VEnNL3pfks=;
 b=EHoJ+JyiTd6oM5IvHtbvIAM25CwO6b26RKRYOuT0DPKWZSzRQnYjQgS9X2ozHIVP6AMtLRTjsGt5TW0mTIiC7uPKg2buU6oApwiMBn1UlBqb2rsccv1sc5bOLnYhbtnLeFZJgHJw2mDSf45erTMq16JbeIumrni/QITgKaoQw9lgI82GLLaSvM3ZkrkOVJBI8gpL9p+dkBhfk5VOls+uqHs3B3EmZgTOTDQQ1HThNw8lbstvjJgQIGgGSklpb+8UYpMY+puj4t4fEOSsvUi8c/kEKs64bFOzojHQKbSzSEreUfDoeaJbwLeQP4ykGs6l+BsOA62NZuRjoDCFhR3fkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmxndbcJ1aG/Sr10lTmIjWbtTX9bXemV1VEnNL3pfks=;
 b=FiM2ZdDteXQ0G4c8DKCYFVifwpliUlbUsxFcWauniwQpxj6WVZmzFrji4mZxjm/Y+EMhCXSejDuoQ/194oA07KGrdRSCf3iCeYXAHpMqfHRP7adLTG8olRKHs16cGjnAMOERBVGlQ0jWm5GNhHG2kkuAYeB5jprCwDlhkmrtaS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:51:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 12:51:29 +0000
Message-ID: <5b93c142-45f4-4d4c-a97b-b3641325d451@cherry.de>
Date: Tue, 6 Aug 2024 14:51:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: px30/rk3326: Use soc dtsi files from
 dts/upstream
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240725094609.3113632-1-jonas@kwiboo.se>
 <20240725094609.3113632-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240725094609.3113632-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd2add0-5856-4f00-6173-08dcb6167db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTBHNnN5VXNDVnN4THBTZUFuQUhWOUMxY3FrMDJqYUk2N096aFFwSWV1dHpT?=
 =?utf-8?B?U0lEazlDMC9DeHNpeUdqeEF6ck1DSmc2SmRWZ0tJRUJYUGZLaVBJWWRMV01a?=
 =?utf-8?B?M2RtejFwV2tWQ2liM1pJbFhYYkR3MW1oTHh4b3gyZmhSNk5WYXY4aVIxSXpG?=
 =?utf-8?B?MkxNb3A5aE1jeU1xTC8zem5qek00WTg0NlVkeUQwV3pQaXVrMEt6eFBwenZD?=
 =?utf-8?B?Y05GRTNZR3VnMXI4K3REcG10bFF6T3pYQWhzc3hLNHpFQ1dnSUJ2TXR3UzlS?=
 =?utf-8?B?Nko1bUxHYlpHclFQbVBuMVYyek9tRXdSOUdYZ2lEUzdxWERCVEowT1dQRGVo?=
 =?utf-8?B?aFdtVk12M0pDWFJ5bFdpR1ZQQjk1U0s5UDRJSTM2ZkQ3dEMzUldFUmxPY1VX?=
 =?utf-8?B?bCtjME9CZEtIZHhucjlWTnFIbGIzWWJ4Y1JueUhvZm9YZTRFU0ZkR0dZRE5v?=
 =?utf-8?B?cjlZcW03elhiemRmVWFGYjk4MUx1N3IzRG96aGk2czc0OEFGeW1Vb2tHdjhp?=
 =?utf-8?B?N05oNW9SS3FtblRNdDBTenMzQitVZXlFdjd2bkRmQ05BSDFQZExIazNrNEk2?=
 =?utf-8?B?Z3RoOG5jQkJLdjVJemlja1dsOTVZMy9wQTZJMk9GU1dyNXZZNS83UzQ0ZGpm?=
 =?utf-8?B?blRoeGNFcGJtK25maFAwcUZWSkhGZ2JpL3p5V0hGMGVYVEFFRjJGMlRmQ25Q?=
 =?utf-8?B?VVhrVC92T0VDTGVJM3hOa0MxdmFWeVQ4TW9pVDFaY3h5UHY0WXd0VGJnMHY2?=
 =?utf-8?B?T1pBeFllemdnT3ZSR0tOOVJoYTdLVjB5dmphdVNyS2FHVG42QnVNMjNreHk4?=
 =?utf-8?B?RXd4UjZBNjRsNFVSeWVkNmdoNjNLeCtSRkdzbXBaODh2WGFrQWxRdFQybjZ3?=
 =?utf-8?B?aVc3NnV3S1lwSjVDcklpNEdvTXRUclNOUHYvTEg3K09KWU5XSDBFcUFHcFp6?=
 =?utf-8?B?OCtDaW9vK0tWL1BtaksxSzVScE9qVU01ODVtaE0xcVU2OUsxeTNWUDgvYjU1?=
 =?utf-8?B?UWRwSjFBdUl1KzFBaytBMS85YURjWm5uNWFKUG1abjdrRzRqOFg3VlYveHZo?=
 =?utf-8?B?NU9ubEJ1amxHR2FqSnMvMXE4RWxBQWlpaERZcGZNRkgxTXNQZjc2U1dtRW1H?=
 =?utf-8?B?RVpzMlRVbWh6bHo1VEV0Vi9RZ3JyZDJpY3FDK2IyNG16VEhDQ3RJTWVXVWJV?=
 =?utf-8?B?aTFsTFVkSFMwY1hyV3NSd29JTVJtZHk5MkxWcVFhNytqdkVFTC9Qd0xuaFNP?=
 =?utf-8?B?T1ZGaW5zMU1EUGt6LzFoQnZwS2NPa3o5NE9VaTJaQ0VyMUN4bXppYmtwSzdQ?=
 =?utf-8?B?elFHV3BIQ1dzS1RtNm5rS3JHWjZhT3MrdEYvUHVTT3RhTzEvdlgyZkNpbUpu?=
 =?utf-8?B?a3NtT2ZJcjZZSDMwTkkrU040cWVKSDdGN1NzZDZNT2ZwRXlLNElndlIva2ll?=
 =?utf-8?B?empMdGZ0NGxueGdlSzRzVkRZWjZnNW11cW4zZ3RsOE1HSXFqZ1FFbldEVmIr?=
 =?utf-8?B?UzU0V2pqVldsRCt5SzVWVHZJWVVpMHNVM0I0WHJXYnBSeENsbVFoclYwSWN3?=
 =?utf-8?B?ejhSOUZTZjJVTG1uTHA1SERnb1VjRFZIY2dwbzcxZTREVk9nakJjNnRzcEV4?=
 =?utf-8?B?M2RMQmZkY1FlajJJTmQydTVDK1ZVRWtubTdQT09BTjdwRkNuWTFPR2ZoZVdC?=
 =?utf-8?B?RThpcS93czlZQnlPRy9tcHNlZGptVDRTME5STHNUcmkzTjlXbkZxcjVjbHg5?=
 =?utf-8?B?Q3M3TDFwRHJDcUcvNi9lTG44R0c3ZXhPSUd1Ui82YXhBSG1qWUVmYkRwU2k1?=
 =?utf-8?B?WUZ4ZElNcnBURmdsaGVsQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmU4cHNWdlFWMThPcGt1M1VlYUZEZUJkNkRuZkdnNFRqRG9QU1YrZk03T2RG?=
 =?utf-8?B?NlN3bkl3dk1iektjellsQSthV1FQUGwvYzZkd3RIWmxnbFp1Nk8wL0dYS2NQ?=
 =?utf-8?B?dDBLM1hqcFhlbGgzb2VtK3VKbEVuWjR3MHRvOEJ0V0hSL1Rpa1o2RVMzMkJy?=
 =?utf-8?B?M0VmSG0zOGhDMm45WnpkNE8yU1g3MTRrWlFGM2RzRFhaSGM4TVNVdGhKU0hN?=
 =?utf-8?B?N1h3UVhqaWFRQk5FcUFBblZ6ZmVFaGlha201eTQ2Rjh2YUloMjdYTm11Q3NR?=
 =?utf-8?B?TUZXZVpJOE00Wk1qd2lXanJ2Y1B6RDRueG8ySTJXWE44amc3OGM5R2RyYThG?=
 =?utf-8?B?K29CYXhSeUVQSlBWQThMRWN1b3dPaXZXUndBcDZDbGo3NzByYzhnRVJpMjFa?=
 =?utf-8?B?dktpRS9sOGh5bXE4V29OY1lSRlBRTzd3c2VyeVQxOHRLdXU0MHhiOFZpVWZ0?=
 =?utf-8?B?SWU4UFVzNjZpRDFDcnRlM1dyVnFZN3l1VkVjUERyZnZOYTlZSmJvaEVqbElt?=
 =?utf-8?B?bkVFTVpIREMwc0g3M3R1NUZXSGp3NmZIVDdNa200VkgrMUF1aVk4RVV0eHRH?=
 =?utf-8?B?UERraVNVVGQ5SEoxdTY0UVFrTzUwaUtxeEVSSC9ibzVtajd5TGNNcDVQdXds?=
 =?utf-8?B?dGo2NW5uU21OcTl5cG85ek1kbks0M2dxM3dhNGRoUmFOR21LQ3lXWCtsdHhq?=
 =?utf-8?B?bmVSUjVnSFhQdGpxU3VDbTh3WXIzM2tIOXFjdWgwdTFDY0lvQ2ZLZjl1MkIy?=
 =?utf-8?B?SmlnQ0hZNU1UaFpLUXVyVUgydkJzcmdFMVdQU29Ea25RVXB4Sk9oUzQrenJx?=
 =?utf-8?B?Rmx2Y0ZtMXpiVncweTBHQW9SWCs3U0tSZnFIL3hsM1lhV3ozbXNMOHpQZnd5?=
 =?utf-8?B?UHY5MSsweHo5UklQNW95TGhkRnBYRXJaR3NuUnNkTlQxZm4zaGJrL2VLNTRU?=
 =?utf-8?B?aEZCS3g1bVIwVHZFMFU3QjhMRE1CdTdDYXlpSlc1aCtaQzVxekNrc05aOW84?=
 =?utf-8?B?R0c1VFVXdnM3NTVoeW1RNGQrY1pSbGpydU9ZMk4yTjMyaUxFeXpRSzJuRlFp?=
 =?utf-8?B?dE82VW8wSGpldjBlMlFrRDBValIxY2p2NWFyMGZKRTBBTzdYeXpkUnZVbkRy?=
 =?utf-8?B?Vk9ySzRNbk9KZ1FKUDVUelNMQWc4b2NqeHpHNmp2azlHVXFuYkUycTZNeG9v?=
 =?utf-8?B?Qmw3anpZUS9CZmdaZXBRRlFRVzVSZHJJTkZVT1BRdXJVQXhaclFUaXZNVHFV?=
 =?utf-8?B?aXZhYy84UjllcUlBVkVtVTVUN0FVM1RENzdaeGJ5R2crU0ZMdERDV0ZJZ1I1?=
 =?utf-8?B?R3V4QzVWTXFQTkpDQ1JjMVVCd0luS1Y4a05sait5VHZ3OUV3MUpyVXJsYlhP?=
 =?utf-8?B?VFJLT0g2S3ZKQ2NrQ2REYWpaN1NCN1p5UDVsZHJUQ1M4VG00L2xoMmlncEFt?=
 =?utf-8?B?dk03Kzh4Z3dEM21STFFjbkdaQXkreW5QMDNodlFvczJhWGFVR3ovazJHZVpI?=
 =?utf-8?B?WnhVNEFVbG84UWZoMWRFZnpNd0d6a1JqMGdEbWRqL0h3aThFSms0Z0xDU1lZ?=
 =?utf-8?B?Ni93c1BPVzZiY2k5c0UrMHZQU2FNWm5IME1sRURTTWFKQytEZlBiRkVTTVNG?=
 =?utf-8?B?eGxpcXQ2VGYxYnV1MjEwU0RHTzBKLzFQRitvRUxrQzQ3cUNUN2hMYnJvb0Rw?=
 =?utf-8?B?aEVzc29LZkRBbVdQUE80QVBXSDY5MUk4WlpoNFkrNSs0YWduV3ViSlVBQVBF?=
 =?utf-8?B?WEJoTjRSNm9Qd3VQamJEVzkyYzU3b3Q2Y2pXY3pzWmFsYUxQWDlkWWlLRGhi?=
 =?utf-8?B?bElKc1I3VGtFU1ZaeWowMGVJbUJXMmNPTEpsZE0zT2d3amwzZjQ1ZUFmNUQx?=
 =?utf-8?B?bm9oU2FZSTJWMTk2VnhLa2RUWnhzVDlpYjdsY3dHWHN0UTBGL1N1eDQyMU5o?=
 =?utf-8?B?WW5KMy9iZ2U2MFVYc1lOenFBeXVXV1BNRkZaN0xyZnAxS0QwbmdGZ09oNXpa?=
 =?utf-8?B?QURMQjd2NExMaG9iUGVXZ1J5dTR5YzdaNm5PM2hjcURkYk1nV1BUUVd6WVRV?=
 =?utf-8?B?R1A0MXhqcDk2VkxhV1ZteUFtQTY2TUFEdksxcDBOcGZtYW9WeVg3cTVoMWRE?=
 =?utf-8?B?VUd0WTNtRWF6OStQQjUyUmpYSzVWeWk1ejJvNnVPZGxZYTVRc3JlR0FIeWQx?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd2add0-5856-4f00-6173-08dcb6167db4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:51:29.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDRlfA9IQU61hGZQ7uRnzeobkKSBAZAUEZSU6FSkURbYUYcxFFCjaC8j8+qxH+dAXSFOgAiO4voUw204wMl2K/v6xqJMjTZRICpKlHVQPP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226
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

On 7/25/24 11:46 AM, Jonas Karlman wrote:
> The commit f087f7fd277d ("rockchip: px30/rk3326: migrate to
> OF_UPSTREAM") migrated px30/rk3326 boards to use OF_UPSTREAM, however
> the soc dtsi and dt-bindings files remained.
> 
> Remove the remaining px30/rk3326 soc dtsi and dt-bindings to ensure the
> files from dts/upstream is used.
> 
> The gpio-ranges props is moved to u-boot.dtsi files and a ethernet0
> alias is added to px30-firefly, they are missing in the dts/upstream
> files. No changes are expected with this.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

@Kever, I see you were the one who contributed PX30 Firefly support in 
U-Boot and RK3399 Firefly in the kernel, is there any plan to support 
PX30 Firefly in upstream Linux kernel so we can move to upstream DTS for 
that board as well?

Thanks!
Quentin
