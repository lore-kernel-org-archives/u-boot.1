Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F392C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD6B869F7;
	Mon, 15 Jan 2024 10:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NZpiMEJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB3F86DEE; Mon, 15 Jan 2024 10:29:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 680BC86DC3
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLxlmi/L8pJioTxkAro7uLpCNXHhQNRrr9VWv7EftMoTcRlEtAsBeHm1Ov3hK37ZpMXV4q3n1AFXLlmS9uMwEaWmx7dE0++GWZnbGI1S68UIZpGI8cSZCoqs2oY/LXfRKeHFkA4ZsCHtT8xsH8Yg0FttN1aObipXEibavNayqXqN/dtx+2FK6tpgA+8pkv44FZPk/CW/lYYXwh+a+jZ4+9f8KOkYHxZ7kEMLPGf7HYhEg++7M2NoIKxtkGdDgSuHkzB6j0aRYARryvKIMpW3fqxrQGwrORyMzT+sr6EoMj76PGiQgR8I5FlKapTTXns7TBMyBWDo8NzvXnA4KqqdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tqCjnKOyReJn5cOIY8C6kf62XGBx62qXB6Q58fTz3o=;
 b=V+WrnxmADtyWBID3WXkoUQ7MzXnhyqiEu888hZgYftr6Mc5tb6nS9TykyomV59mMcwC4pIu7LOd4sxUWNGwu63ugcEeEfx6E6bjCSNtPgRG0PqcIjqsmK/BMQvit8BZu/qJFWg0q8fKgnzY4DG1u/akT1MTEZZsZOIVUqZnqN0siSB1iS0IZC5rDUhVW0wC4cOVjj9wL0kQyWHl8JL1WnWHSineq9asR5kMX+XL7MwhMnjKY+VrzWNyePZ4EHV7aiGcYxbscoaEdmKIZFW2F2AYmPERp55dTJ2Gp3K+4+HzadDKzGTaNO+wAI9k2qoIZ7JLCpwiWhR3adyZTrqkhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tqCjnKOyReJn5cOIY8C6kf62XGBx62qXB6Q58fTz3o=;
 b=NZpiMEJnpo2YS1QuT/vagVJ/DjWEdxw1ZX7bfFud1YDnGNV7u59PoKrRMYD6XLi2EnRHv/EwAieoqmLx/qCNVXMXkcTzki3eg0f6OjQWwXWzYXk/P/Vi7W4AThsQzyJiDn9u/U/JdoSsw6qBySk8v50y9OqBZwQbCnTFO0L9n5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 09:29:33 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:29:33 +0000
Message-ID: <0c176699-aca4-4ef3-a148-a752e94f71d0@amd.com>
Date: Mon, 15 Jan 2024 10:29:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Remove multiple blank lines from DTSes
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Simon Glass <sjg@chromium.org>
References: <6aaa9fa91c88ca3d3e5645d66a795ec09b8cec61.1704708642.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6aaa9fa91c88ca3d3e5645d66a795ec09b8cec61.1704708642.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af12fad-b584-4235-63eb-08dc15ac7b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtcAgzuPtp/zFsNoJ5/1ods4YEMrW0nbwGBdxK6doxsvTgo0HgWvFaht4dniwTyeNVgbMdLuUG+7ssH+o6PjJpRilPPpETyLNR0MHqLs624js+3OwdBvvvJuW2DuRHeethab69OMon6sxR5ysoOhVSdIgn6UEFrvmE7orULIwSi929YPOeJgiEhZTUxRwGfTusBA4qMb3xGZAOh4YEkFfWSOjKprcnefjWMIicbVKev/hzZn6DzVN7avd5Zn4+8LzkaSN4nSbr3gM6Yx9Z5+B9xZA8INzx2Tzue8Q1QwGxYKFYgMgK4cY+Tj2KosNjVrCof+mmjatTPFkWdSPpWRUtJ0/RDr/skxGxRYgpZPdLCrKzN7y68969QWRrwI/fWPgL40327CTNVQsHjNoeTCzFxD2wIjSp1E7+GvzTWEo7A4XeaNAGAlT3du6HcaLH5V6FzdSydXXg/aD8H6FsWDURZ4uTsiaMIOtsSojblEUS88sd4fQcpL4ReK4iFoID4oLl9K8Z6RLzBdnnyGsKwtRRVWQCAdv2cSUMWQukSaVbCNHZQhBlnyME7c62HtKhKfbtco+dD428yv2VvL3tgwH4En6FTwm8GU1thsuaoYEDW5v6J0iDJDWaEUFDj+YytnyimjtZlh1ug8SciMNm7Liw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(26005)(53546011)(31696002)(6506007)(6512007)(83380400001)(8676002)(41300700001)(86362001)(44832011)(4326008)(316002)(5660300002)(2906002)(8936002)(6486002)(66556008)(36756003)(66946007)(66476007)(478600001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JyQmY2SVEvRmdDbWdXenpLc244U3hqNzY3L0FQWnZCRVRQU3dPWnBWUmVs?=
 =?utf-8?B?MUNxMkhhN1l2OVhrZnV1a0tZak4wOXhJSUtGNEsxbk1wb3F1ODB5K2dPTCs5?=
 =?utf-8?B?MDl0S21zQWRlOVdIMXBQMHk3SkNLN0wyWWtHbU11WWhXdXZzRnNDd0xJRVB3?=
 =?utf-8?B?QmRRM0Fqd3pvVExPRDFvS09qN05uT0xxUzI4dGRidWJDU3JOY0FaN1RlNTd6?=
 =?utf-8?B?Q1YyTlJTNVY5WXB3OEFZSWVKMHdBNnVzN05tbGJkelNIcWdaSFp1VEJVVDJF?=
 =?utf-8?B?WEF2QVNUem1Ka0V1OExkdUVUV2pRMzlWSkw1QmNwS3NVdkV6REgyTVU2QnlQ?=
 =?utf-8?B?S0JiajJNaGhwci9EajhzTHZFd0dYSXA4bCtqUTl4cDRva1ZtdzFHTjNxNjVI?=
 =?utf-8?B?QUVqYzFoZ1dtUHdzaEVNYW9sendjU1AzLzFMQnlpMTRjbVdoQnlCcVh5RXp1?=
 =?utf-8?B?QXRvS2c5Q1B1T2dhVlhjT2FiNjFHdGs0bnNtOGJuOGtKNjQ5RG5aWG92d09q?=
 =?utf-8?B?TUpxVEFLRXovS3U5MXRrNkduQXl2OVBNTkd6eE9WL014dnJ5dFNBd2lMRzdr?=
 =?utf-8?B?aUNQc0xsVlZOZUpidTh2OFIzKzV3Uks3Y3BMM0ZvNjlVQmErcHhYOUNnNDdx?=
 =?utf-8?B?bVR5VEN5RGVpZFFYNWdIV0VBZ0UrS2tsV1MrVVJpeUxtc1lZOG10UlRXOU1z?=
 =?utf-8?B?ZDdaY1BnUUVJUDlyWjAxM3hrSW9QQWZkVXlqMERxa3llaVZKNm4zNnQ4MWdj?=
 =?utf-8?B?bUl1VlBJc21jWEg0YlZHditYWllRVGhmZlh5V1FNeHZlRzE2L1dSd2kweWJ6?=
 =?utf-8?B?cDF0SkxpbnQybG9rRGZnbHFKYmxRQm15cmhRUFNDM2M5aGpvVWUzRTZvMTlh?=
 =?utf-8?B?NStLR1lmdGxaeUhrcDM5Rm9zcmoyTU51YnlUSVlZeEtObmJZWVE4UFlCQVNL?=
 =?utf-8?B?MW1pcVdnRHhBNXpZYmlVdUFGYzFoTWE4Zk9SRXo5N0JWam4xV1ZkdGU5TUxN?=
 =?utf-8?B?S21oLzZFYkdmVU9XSEtpdEZnK0JDTnlpWUdxM3RvMndxTmNDUWxBd0tXN1c3?=
 =?utf-8?B?TERjTXlCblpCUmpZK3AyZVNzMnI4LysvMldETnpNMmFwVnN6amFqbkdWUUky?=
 =?utf-8?B?dyswUlM5MnYvaFNvL0tSZlcvRmdoeUFQQ2krK1BhckdhYktGUGNJZUc1MU5o?=
 =?utf-8?B?Mk9uNHBrWGxVNk5ucVhRVUxuejM5aVRWaGREYUJEQ09BMHJmd3liSWswcW9H?=
 =?utf-8?B?TUJ6dTM3N1BzL0lqUnJOR05SMG9wOS82c3VqSnI3WXpkSnFSeXFNaTRUbmtG?=
 =?utf-8?B?VlJjayszWTRRWGZ3R2ozYnFlR2xzS2Nrdzg0YU9aVEFVeEl2aUF1d2hhU2ZI?=
 =?utf-8?B?R3FFTk8wUW5heUIzUEYxUHhnVHAyMS93M2tLNk5QRnpHTDFlQ3lzbytDbUNp?=
 =?utf-8?B?VUI1cVREL0RWdnEvYkx0RGo1cnBiK0xEOEg5NEd4QkVrK2ladG9QOWNtbUxr?=
 =?utf-8?B?RldEclk2Z2d2dFJ1Z2tNbDRBZHdNOEFkRWJCUG9aUCtRaFo2TXVIR2psekJN?=
 =?utf-8?B?WkoveWNQT1p2SGxiZmFIVkloanFZbkt0Z0R6dDBuT2lKa0wyZUJHdzA2cmw3?=
 =?utf-8?B?OFhsQ3VmcnVXSjI1M2NFbWNaK0NJYVZoakM2YXlQYlZUODlqSEFGMjYxU0d3?=
 =?utf-8?B?ZlVKRGZrSWljSWVLZ01XcStlMXNraE9JUHA0S0YrOUpBeWMwUTVXczZYdlhi?=
 =?utf-8?B?Zjl6b3g5ek41dHVRWjJjY2F3SWZuUzhyMzVjakEzcnNaOTFId3N5M01wSEJp?=
 =?utf-8?B?Mkhoek1CSDNULzlrNXJySEZ3cjFwR3FWQVp6R1BITXBaTDRmOTBaZ1M2UHNt?=
 =?utf-8?B?NGRhdFJkTDd3UHJydHIyWEZaSDlHZTUyWldGR04wbFdmVFp5enAyWlEwMzNq?=
 =?utf-8?B?RDlsNnNRVXRVV01KY04vdjI5M00xNElqKy9IRnRtdU5pUlQ2Z09DSnlFZkxx?=
 =?utf-8?B?aHVLaVJkVlRCcDJ6dWt5YklVT1dhZVZrd2pVbks5WURDV1NxMkZSK1plYUV6?=
 =?utf-8?B?ZmIwVTVFUlBjZ1VPdCtSVDR4TnZtaXFKRkFmbGxYQmg3UWFOQ1gweldRZ1Fu?=
 =?utf-8?Q?D2MHyQVwB9C5ATExa/9274U5G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af12fad-b584-4235-63eb-08dc15ac7b66
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:29:33.0540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uckNVVP8iXFxyyVosrJQCHTBG9RRp26EDxaqQr/4cdWrAf/tddiepVkswEc9+qBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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



On 1/8/24 11:10, Michal Simek wrote:
> There is no reason to have multiple blank lines in DTS files that's why
> remove them.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-dlc21-revA.dts      | 1 -
>   arch/arm/dts/zynqmp-sc-vpk120-revB.dtso | 1 -
>   arch/arm/dts/zynqmp-sc-vpk180-revA.dtso | 1 -
>   arch/arm/dts/zynqmp-sc-vpk180-revB.dtso | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
> index f737004d7943..b28dab0003ac 100644
> --- a/arch/arm/dts/zynqmp-dlc21-revA.dts
> +++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
> @@ -155,7 +155,6 @@
>   	/* u138 - TUSB320IRWBR - for USB-C */
>   };
>   
> -
>   &usb0 {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
> index 750bc39139cc..853d9817dd2a 100644
> --- a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
> @@ -13,7 +13,6 @@
>   /dts-v1/;
>   /plugin/;
>   
> -
>   &{/} {
>   	compatible = "xlnx,zynqmp-sc-vpk120-revB", "xlnx,zynqmp-vpk120-revB",
>   		     "xlnx,zynqmp-vpk120", "xlnx,zynqmp";
> diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
> index 551341f31bd1..18625933ad3d 100644
> --- a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
> @@ -13,7 +13,6 @@
>   /dts-v1/;
>   /plugin/;
>   
> -
>   &{/} {
>   	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-vpk180-revA",
>   		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
> diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
> index e70eb4dc9478..3990d053c351 100644
> --- a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
> @@ -13,7 +13,6 @@
>   /dts-v1/;
>   /plugin/;
>   
> -
>   &{/} {
>   	compatible = "xlnx,zynqmp-sc-vpk180-revB", "xlnx,zynqmp-vpk180-revB",
>   		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";


Applied.
M
