Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568A5C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 09:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8326683046;
	Mon,  7 Jul 2025 11:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBWDJcx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67838304D; Mon,  7 Jul 2025 11:27:21 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842E683043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 11:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWcCIYrWh18e2R9XQn9zUwhArtUuo6P1tsMyXTDbC41naKG/kXRBslWb2ZwxIPkh4LGG6b4Uk9oKT/yxaBvIUv3Er70VQkhEFMaQwFKZdIq5jxymHzq6Wil9PETc8P2PzpZpW1qwOlXsGl335PXrvxhtzocV3HA/4Rsh23qvjJxmCaNHplidkIhQk+mT3dud0qHZMRrxCuQy5CcQ8Xk9JhPAvoS6+u21CHGNKbtZ6DIt1MzPP2h8FUGRfrklvRk2RiC6FH4sn9pJ0vXX5aCN9hJYdhSk6A9V9ulwXZqd8sgD32lDfMbkfqO3h82fyaAdmOrkuxMG7QhqWvAvOZ+z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL5ociZJwhiiRUr14+03WBjcuEV2Dwnzy7Hwg0V4qn0=;
 b=uQO1MHCHmhnTR7H3X3wewWIYyHd07CvqOObiVt7ZDOWeNPv0RWt1UVwJyylsNTygCv53QSBvHu1mwWA72d0bhPT89MLlhQEi39TqhwFh02O0NuWmYxLBBVPq0sMOBju/Z6l8arv/LOVQ2M1CueFQj/rPuxeiawnoSI+l8LqffqZ8xs7mrPVG68azUSF5HMSizmVFgOG9lGFi2DJx+dejp/+DB7kFz1RWKY5P/7x7t/GiXVgekO3ooSbK3N+H4ETmaLxKj++nkRCiXHRwRy/3UH+T/kgDXjXwDsOhfxAyX8jsz5d7IBmxRyPQGSAcB2+zlqkuZiysKjjk/GiJK0QgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL5ociZJwhiiRUr14+03WBjcuEV2Dwnzy7Hwg0V4qn0=;
 b=PBWDJcx9KZ54MqmTYDIcsWUwZiiL67kQSA7UWP4aiCcla7Y3R8oquWOJW+f69rYqFrZR9CQO64QRhNxPp+c6LYYB+kY8dUALoHQmNCf2q+rIlWN1Lf+FYEZLLreCwzBS3q1zSbFF2XrFKKJcd7hVw53h2mXrbY10GXdghf0kegE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PPF52B16157D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 7 Jul
 2025 09:27:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 09:27:15 +0000
Message-ID: <57b676ae-84d6-4459-92f6-f9096536def3@amd.com>
Date: Mon, 7 Jul 2025 11:27:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drivers: fpga/firmware: add Kconfig dependencies
To: vtpieter@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
References: <20250705205710.792370-1-vtpieter@gmail.com>
 <20250705205710.792370-3-vtpieter@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250705205710.792370-3-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1e3487-5970-44c9-05ba-08ddbd387633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlFaTmlheGZFMTJWKzhDNEdEOHpFcEJibzcrQ0lGaXNjUEh2SXEwTVdvL0xC?=
 =?utf-8?B?UlA0Y28xZ3R5clRtc1lyN25OL1NwbkVrckc3U3NKUFdGWWVoNW9ydkgvZGRY?=
 =?utf-8?B?dlQxV3R3NFduOXVyMSt6Zll6NDNrUVBORDdJYWYvN0dxOE1NQnk5L3V6Tms1?=
 =?utf-8?B?Mm5nRVdxUlluenpreXNYVTVURFkxckMrYkFRNmVidThDWjgrQjFiOVgvbkhN?=
 =?utf-8?B?Ni9zWHQyaDVpZUxwenUwei9IVnFIN1VRZm1QbjVrdWhyeTNaMFBVbmtENGg1?=
 =?utf-8?B?aitsbjcvdEdJWXozS1B4eGZ3ZWFPdEJZd0I2OEF2Y2ZCZWZXWW1xcUhuRU5j?=
 =?utf-8?B?MXRUcmJWU05vam9tK0dSTmU0aUh6ZUFGTmpYWUtJUWRhT3A4bTF5Ty9hbTEz?=
 =?utf-8?B?YzdPemcxNkFseXZhQkVKYjlpUGJNektsRFA1cFZTdmk2QlZvYUxzTWMvYW9K?=
 =?utf-8?B?OXFNeEpGclo1dkFOM00yd3FJcW1zaHROMTVMSzkzK1JvS29UUkxOTFJ0dU82?=
 =?utf-8?B?WGZjVVh1QUxJeEJzektROThoTUFEQ2pYYkhkOHh2VkRLelhyUVJSd0c1UW5U?=
 =?utf-8?B?K0dmY0dpVFdja0RZRU1aRzh2akVya1hjbFdWazdLTWFqckxMQndiS1M1cmJ1?=
 =?utf-8?B?ZkxCc1c2amFwWDZqeWszcHhuVjR3WGdIalVQZ3RKanNqZjlKZWJUNlRmRWNF?=
 =?utf-8?B?bVZaNDA0R2p1ejc1MTVaakt5RHZsaXFuQjFBNXJpVmJQckkzRkJUU3ZaeTJh?=
 =?utf-8?B?b2Z0VXRKSUpqa3lCTFgyN0ZVN2hDNU9QdGk3eWlUSWsxcDJjdDM5R3E0SmQ3?=
 =?utf-8?B?QTNGMitZU1hhRVZvbVRnNE1PWERDL3RTRm93R0NSQWVpbldTT1FwaWU3NUVX?=
 =?utf-8?B?ZEpkSWJic2R3c1dLbXdac1lVK2NkcmVubkZIREtiOFVTL2RsNWhvZGtVQ3dL?=
 =?utf-8?B?Y3BiREd3a2VZMy9kOXFrQVh2TElVaHRDU3hSMmcyS3BxbUVSK0xSZFVuQ3p1?=
 =?utf-8?B?MXMzK3BBckg0dGxON1N5d1Y5NE9lTGg2RHlOWFJueWtsMTlBbmNiMy9PRzBX?=
 =?utf-8?B?aGNWVEdoaE53Q1IyV3dJZ3BCVVQ2TnM1Q2xjdlFkcTZuU1poNVZybWRqVncw?=
 =?utf-8?B?enJVdUpEU3VTMUtLRVllWFcxNTcxNEJFRU0zbEJOOGc2VTkzamlSUDl0ZFNG?=
 =?utf-8?B?dTJQZlA4bmxKTHE3Kzl0c3B3SUJtQk1Td1pYbTUrMktjV05NQWxQNU9zNWZG?=
 =?utf-8?B?OEdjbmhFdisvNHZZVllvc29LcHJaNUVMT29oZ3hQeFM3ZS92WDNQR1N4bHk5?=
 =?utf-8?B?SEp2c0RieHJUQ2R1Smx1MlU0eThHUmszdFBaQ2hhVXpDQTM0YWZ0RTZ0aGZU?=
 =?utf-8?B?THpRSkxNUE1ic2lWY1lrZ3ZraWpJajQvMzVFKzhXWWNJVDQ1NmMvcmJZc3gz?=
 =?utf-8?B?YnpsYlpxeFp2VnQyYUZDUE5XaWFXalY1dndyNnFXZlhsbG1BcXlkZWRlYWor?=
 =?utf-8?B?TEFXRjUzZ1hmVHdxTXpKdzhjTytKbWlXNjZ6RE9jK1p1S1E3Q1hjRnYrNDA5?=
 =?utf-8?B?Z3kyY3ZkU3NLYVJqUnZpd1QzTTlxYmxIV1p2ZTltZ203S3Iwa0UzNnlVKzR4?=
 =?utf-8?B?ZHRhRnU0QXMrcUpqWEVWUm1wZHY0b1BNaEFYLzVSMDZuU2RhTHVWczVUTkpk?=
 =?utf-8?B?YXY0emM1aGJLenZPOWp0cEZXaFNKdDFLaDhLbS9WNEtDclplcHRLSXBCVFNi?=
 =?utf-8?B?UGgxeVd6Szl0RVpoQXlSMnM1VTNBZitLK0FLQzc5RFlLdjJ4QVhPbWlqZlFV?=
 =?utf-8?B?WTJVMFB3SU4zSnJHNlNqVmJwbDV6dTBSVG9wT201V3pEZlIwRkdOUGl4SCts?=
 =?utf-8?B?UE5iMnE3Um16bGViZHV1cmVkK29NR2RvVDFjNStiZEpwbk5jY0x3UTJKV2Nu?=
 =?utf-8?Q?71jCyhArH98=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtOcnlCYmFUakJyaDRLRVNpN0Q1cG9xei9nd0hkczNOYm9CSEJLQTVIS24w?=
 =?utf-8?B?enJSLzBHVjY3ZjRNdjNseEQzcGI0RWt3RU0wcEFxWWpHclRkd3ZyRDE2c0Jl?=
 =?utf-8?B?aU1sVFRYZGlOWWRpWGJYd1BzYnp5MlhEK0JzODE5R2xFRTFyMTdPYXlOd1Fj?=
 =?utf-8?B?ZWd6bURzSzVyNWdkTnZMWVdwdVdSOXJzTG9XRUNUVy8wM0Q0cUhnMnB3Ukk0?=
 =?utf-8?B?TEh6d015REhpVENWYmE4Q0RrWWJNb3BPZEdNYTB4eVhYRThUK0c2TE1rKzFm?=
 =?utf-8?B?ZUc5OXFlNCtCUG5mUzNyVHZwencvZ3JLeHhiMFRCT2hUVzkyNEZ6OCsvNklC?=
 =?utf-8?B?L3duSkp3cE44WnRQb1VHWUFnaDdCWGZ5N0wyTHZsSGx5WHYxWlZERmJ0bm1H?=
 =?utf-8?B?ZkFKUjJ0MGc1bmgvdDV1cW1uYlFSTXg1ZFQrY2Z2ZjFBaUY4eXBtNitXWkx5?=
 =?utf-8?B?Y0dNaEVGRjVvcmhLSHNDQXBPSEdkdXQxWjRlU2NsVmZxaFhWejVRMWlNQUNG?=
 =?utf-8?B?cmJ0K3hLT3g2bEdiUEVsOUdsc3pqK01xemxXb2p1RGdBa01vc2l2ZFlmb3F4?=
 =?utf-8?B?YTlvMWFQRU8rb1VSTDhCSlFoaEE2U3lyTlo2WmUzS0crVEJXdHJKdVZnY1Yy?=
 =?utf-8?B?WWZieUlWdmpvVnB5em9vNElBbnVIdC9KZVlRYXpVOVNyUXhLWC8vM3c4em9R?=
 =?utf-8?B?MGphN2llQWp3aENnRElSbTQvZXc3c04wWjRIWmFGZEF1Qitnd3NqNDQ0WkZq?=
 =?utf-8?B?b2JCN2d1L3N1NFNrbDFBMEIyR2hySVhQT0lKM2UvZk1uMnpFbmIwSVczdThW?=
 =?utf-8?B?Y0U2cm1zL0ZEYS9pcHptOTFsUTVwditLZXg0cjVnRmxhbGhxcHkyb2xMdzh3?=
 =?utf-8?B?V1QvQXkzRUpRSUQvUWR1ZzdkWkVPeFh1Z3lKR0I3aXVYaHZrME95TStKb1pP?=
 =?utf-8?B?TGQxaDMrN3JkWEtiOUh5c2VIQ240aEY3eHpwWlhubVdxQmxSWmgwdnZOaU1o?=
 =?utf-8?B?dHI5dkJFMUZXZXBKWVlydVhZeFFPcDZCVUlZdk1oUUhQMzNpQ0FPRi9ralVW?=
 =?utf-8?B?TnJQWXlPT0Vib2NQblJNSlZyYkY4TVpFWGExczRMTzRIVy9TWEcwUEcwMU1K?=
 =?utf-8?B?cjh1K3Z3eHBsd3hMTWFkZ2hBeDdScDhyaGhyc2JpMEJ6eFlJMzhjUFJNdnM3?=
 =?utf-8?B?RDNOWk95eVE4MTVManJ3dUFoMUgyR093U1NlWmlRR05NajdCMUtHcytJYlhB?=
 =?utf-8?B?cmlsVkFsbHZ4V3hpODY5TEVVdlVkcnUxWGZBbVdnSExaNFI2d3FtYWhteFlh?=
 =?utf-8?B?eE9pUnRnVDJFVHdtVnh2RTVqQWk3TWU2OU8waG16YkJnS056UVFHTkYwRTU1?=
 =?utf-8?B?b2VtMXExdGxubHNyTG1QNjRHUWJPQzFJclBhMmdNcGVtQ3d5aHBoNWlGaHJB?=
 =?utf-8?B?MmpMZHNERWlkN2ozZktyK1JhNERXNnhKbjdMSmdkS29NV25zL3ZOYkRkT0lM?=
 =?utf-8?B?S0RoWTduZXlXRGxqU1RPZWdMQmFQaTFhbnJIeW52MVhOUHk2a3IyUjF5ZWVq?=
 =?utf-8?B?TU5JSW5aRzZxeTBJZU5raWI1NXF4TGF4VExlZHpEdVZETU9mQWdQcTRxdUxL?=
 =?utf-8?B?U2Q3RnNrWkFYMCs4ODNQTisvLytWWmdza0dVZXhHcGpSdUswQWwybENkY0Qw?=
 =?utf-8?B?S1FYcVJ4ZStqRE16N0lHOEVLakxWdjJMMExEdWtscno2OTJxZFg1ZjlobHpO?=
 =?utf-8?B?WUIzZ0JrcitnOWlvbTlNS3hTdC9FdnJYenFKajR0b0Y1aGpQOUpXSmdtOFdG?=
 =?utf-8?B?TXFTMlJteEtZT25jRzcwZnk1UmZUelQ1V25TcUtMSVNhQUtValpMNHgyK2Zp?=
 =?utf-8?B?bG9Xczl1bW0yQzR3OWp5L3phaEJrUklWUVoxWWVMUFRzTHgzeHRwV1RxL2Mw?=
 =?utf-8?B?eUZncWVKSXJyT2tFM2pLMWJKNHQ0YThxUDVMbXFDcTVTT1N1dGMvRXJwVFRL?=
 =?utf-8?B?UXZqb0ZFQy8yS1paeHh1Y2JmOFU3MExQMS9ydzJIbG5SbGVKaGxSaUpOTy9R?=
 =?utf-8?B?R0JvTUxSWGtkc2FWVUt1eW0zMldjVkFMWjRRTTVRMUFWV1lkbUFxTmRSTEVo?=
 =?utf-8?Q?hNaml5/Nn/6XTbMoi78Ia8IDG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1e3487-5970-44c9-05ba-08ddbd387633
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:27:15.7742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7ODLxEHon5SNwSXHxHoqVdSDZxEramH1ZHrR8/18j6t2lQUifSFfl4/c1hXaDRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D
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



On 7/5/25 22:57, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> FPGA_SOCFPGA requires ARCH_SOCFPGA cause socfpga.c contains
> arch/arm/mach-socfpga/* include macros.
> 
> ZYNQMP_FIRMWARE requires ARCH_ZYNQMP cause firmware-zynqmp.c contains
> arch/arm/mach-zynqmp/* include macros.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>   drivers/firmware/Kconfig | 1 +
>   drivers/fpga/Kconfig     | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 8789b1ea141..f3302d34354 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -29,6 +29,7 @@ config TI_SCI_PROTOCOL
>   
>   config ZYNQMP_FIRMWARE
>   	bool "ZynqMP Firmware interface"
> +	depends on ARCH_ZYNQMP

This has been already fixed by
https://lore.kernel.org/all/20250702010410.18828-1-trini@konsulko.com/

M
