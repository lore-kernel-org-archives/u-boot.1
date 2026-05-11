Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C1DCD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A34847C7;
	Mon, 11 May 2026 09:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CEffLzm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE8F84815; Mon, 11 May 2026 09:23:17 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE2D846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrP60jIgb/t64XUjOLo0QvkrNqzqAaRMJKAZ/otm5OHEGRrJqQ0XqJiKGtpl7P45fMmtJi+z8j94TWUo8WPTRdLrBtmPAwMDqliKvy8nlV2Ks/oqYta1BlexKoooY2V4pFRkR3FuaHKzEEsskBKYGjrqafiW9KzxR7/8HS4GN1I/sGcKW/bFZzzZAYp08dRFRiXwiyzdiWdhM0C8FP1tLveW3rQID1qQCmdN7R7JPHnULzuntXVHhc7znrbYeMFhlAmV4XYg4BWFOcnDsuazyihUNOjYtRW/w/SOjT3jj7Gka5O+wDs4/zKyOi4iVBG5Z1NGE7ZJtB4bpTBeiTqSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxAtWeCoz4KxZz0HNHMFX9xp2wnXUyVaY3eSueNMkf4=;
 b=W/hRcH3re8aWmy94PaWqE/7ZrVlsSOD7UloAga6j8gI4cRnP+XckEKNKA8nx0eu+DdKvIhE1CW3hzkffUxUlpDw8uY1IKpZIVZ96xZz5hYUlwRcTISMX1dwH707LynKdTdOlE3utHTDROVpUXvG/F9SQXATogoXMZ/cKjVpItYgL24pH2baKhDLEyiqnxMelTKkC4IXrJ5jtcJQiSC+60yd/Wc6ZNawLCt7jswSK8b13fEwm4clO9dyEpThiXqHS7eVIYew22U8AtNi3gowAEAbsiJBkSSw5jDP29zbR8PJI+CM1SntnLWp0ndMbJM5fBFWMUBa04De1pgf3CTbcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxAtWeCoz4KxZz0HNHMFX9xp2wnXUyVaY3eSueNMkf4=;
 b=CEffLzm3IoIrc2RQv+vbyp/XcVPf2BFJ43/I/vR9jZmlecBIO9q2GhlpOosKJro885zn1OyhmolthW5QxKRrouJWHkewmRPyl4Py79lxyay/XLYKeQiQpufc3w+M0ld10x9jK0g/uy5teWAAW3ERywrE583XRVOjVYB4JK1o248=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:23:10 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:23:10 +0000
Message-ID: <5e58112b-d1e0-4d40-b589-9b3235fd24ad@amd.com>
Date: Mon, 11 May 2026 09:23:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: versalpl: Fix unaligned buffer handling
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Padmarao.Begari@amd.com
References: <20260507113359.3665220-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260507113359.3665220-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 3931ca0d-a326-41f9-515d-08deaf2e2787
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 2Wc9iC/xye99Ysg4VKci+rtzif0f+O9Al3hTHasD+ooQrOrTXTFuzad02727craGqCTmuKuje2HO7hReJKpYPBrBGjNWZj+XX1Tvp35inxjpmiY1CTNQQx7q4FCrcui+3wVxGginwymV33UR3cj9HbrMv3Wakt8hGFMXujgpRbEAj5CCdyY5swTt2yJ/075RkZfPGtPOAFeCNY/HVVLsVcN0KhxD+0j75hgwHpnnpIl3YbLns/yXYfm7dOCqa5rnUbRcIC8ZgQmffDk82ONNO2HffEtzsbszh/ZqySALiODj852eR3KAryg8uioDKPrL2qdGL+bXcW4GrwUoEOL/CcXbgmnIhC/FC+i159JfA7ZboQZdsXpedB+RjvSm7PTAaKJpwd5rfJznssTU1LUWMM+PTtE01dvYAvzi7NK2QqP3I64/pZD4W6C4JmlNtC7qSFHTIfF+xeHupLpV8Fa8j7h7Z0oOhS80yoAvScX5RttVa/L6fno2aydrFo7jf8HVxcy4C4Bpvg51MJugMoG47yZdbAeo7zy8/hYtg0M37dIUtsuLHSxOdNgywNTiuvmWUpAv0vreZXm80m2Gld7oX5lZepDk/zs35U4O33sYh6uGHqgd4HVSZKcEFxg2A3SUzqiLrjqP+E9q0qDa6I6JtUOhxxLzFVld/Z7rXHsOXY0iuFl84KL+I7GkoeQ2uTQr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c21oRWNnOEVpTmtLaGUxUEZVakl6UTZsZWllcldnUzJDdEZ3V0dhTm1Md3c2?=
 =?utf-8?B?K092dWZuaHEvbFdTcEIxWHpHMGN4ZjNwL0tlYlA3Q290UGh6U2RoWjRaTnI5?=
 =?utf-8?B?bjBadmNzeUhtL1FyUVdicjhkQlZyakkzbFJNY1B3d3VuSFcyTGIyOFQxWk1G?=
 =?utf-8?B?b0lXeWx2Rk55SkN1VEZWeXJBRGtQUml0c2xuK09QTXdvV3dwSjdSV3B4M3A3?=
 =?utf-8?B?VXI2TmlnUlc3ZHVmeVhjT2RQR0VQL0llRCtWTDR3MmpDQlJKMW85SnVOdG4r?=
 =?utf-8?B?ZTBNTzQ2NUtkWnJtVGd0R3JJbzc1U2ZnTkNQTWpGK2VGR2d2aFl0cFdmZDVx?=
 =?utf-8?B?c05xWjQwWG5BaHptZ1Jla0hPWXFERkZtWW5URHFBTTRJd3QzM2JjTUFvc0ZZ?=
 =?utf-8?B?REpwa0EyVmtVUmg0T2cwRjdsZHRROWpoWGhnWVhzSFFlNUpaTTR6Rm5FcUVq?=
 =?utf-8?B?V3RhSjNOQlZ6MEQ2ckxZNkhIV2xPMGtBUlFnS2d2RVRTQk95M0RKOXN1YXlU?=
 =?utf-8?B?Z3VqOUxLbUFDRER6YTU5SDJTSzgyUmhQclB2L3lDZitjOWFqUFN4UVVLaklM?=
 =?utf-8?B?RHRwQVljZDNTWG5zeDBacGV3aEZka3pyRWJwYVlHais5bHUxSnVWbURIL3p1?=
 =?utf-8?B?REFGL0dRL2k0Q1c5R3NsUExnZ0RiMkZoZHk2MjBVUFl2NWQyQmJhR2VYbnVU?=
 =?utf-8?B?ZFRrZkRhOEgvbmZ2TnNHbm1qTVdweEV1Z0gxRE13Zm0rZk1qckIrSVFqRnRE?=
 =?utf-8?B?MkppYmUvbFV2d2Z4dVBjcHd1MVdOa3pqbEU0NzdNL3F1Q0Vld2VXcE91N3pr?=
 =?utf-8?B?ZWo0WXN3dmpZKy85WVBJRXB0MjdaSjdjWnBRc294Yzh4NFNuSWJoakRZVDND?=
 =?utf-8?B?eEZZcEwxMVcwc1o2dVlZY2VJd2xxSnh1MXBoRTAvZ3J5OXUreGFoTzVYd0s0?=
 =?utf-8?B?R3h1RnVEQXNMMmtHUFdSMzBiM3ZWa3pXbU9SUjQxcnJYMW5KWEJEdG0xak9Y?=
 =?utf-8?B?d09ZTE5jUjFTY1dpbmpWc1hBcFBqQTNtbGY0NjJNbnN0b3U1ekg1MUxPdjdY?=
 =?utf-8?B?eG1VOGVQUGpuODlNck9GY3FNMGFVem5DYU9XZGQ4RTE4R2c4VjdrWVJFb0ln?=
 =?utf-8?B?eHFXMEg1NHQvdTlKbk1wRjhFQmRscjR1R3VwVkVnK0lUa1pWVEJ6ckRyNnFw?=
 =?utf-8?B?dTRJNWZRSjNwUC9GQ1NhbkthU1ltTGxKMUNodVlzb1VPUE4wUWxIKzBZU0ph?=
 =?utf-8?B?WTJPV056UW1xV0FmSVgxYTRUSC9GMG96cFlVbVM4OTZldjZDL3l3dGJsd3Er?=
 =?utf-8?B?d0szeGlSOXk0WlBEWXJxNkZ6cXIvYU1Udjd1Rk91WjJTSkxPVnU3eHlaanIy?=
 =?utf-8?B?dnN2VllXdWlrK2tLcUtWQnBQU25JQmhVUi9QOU84S0tPSnJxWjRKd29kVmpK?=
 =?utf-8?B?azl4cWNDSFY1RUhPQ3lDVmZPdktnWDIrTGNYYjNVbzd6b1hEYnJvbUx1OUhM?=
 =?utf-8?B?OWUxVk5CT0NYMUY3ZUVreFR0WXJzcld3OGFTVkEySkJHUU1vazlKREEybnhQ?=
 =?utf-8?B?L0t2MW5SbWNZUm1mQTJzMGlRU3h6MENrUjR1dUdrR0tPci96SGZ3NDFuMGhj?=
 =?utf-8?B?d2Q5R2FJNUdRSlFNcy9hQU4wSE9hZjBaNlU5Z1RUc05WUk13WitMVC9aRG5C?=
 =?utf-8?B?RVdMaWdkVlJHSWRnVU9zVHpJWEtxbmZ6UENzeVpKSlFvUG5GZW5SYUd1SEho?=
 =?utf-8?B?cm5pYjltV3pyNlp0YVBocGppcXdkL3VkZ1JUTjhwbWZDRXdWRGppTmZTQlIx?=
 =?utf-8?B?bUVFQWtVWXE2ODBDK2xqdEVISDdIeWphZ2RURUk4SGhzb0toTzhJemhJQXpD?=
 =?utf-8?B?dWZRR252VmZxdVBhTXNBRHN3Q0xBdmV3SkxSeS9NNWZTS2tsMTNlcm9BV3ho?=
 =?utf-8?B?KzZxOHFiSC9OWndqYTdUb1R3dkgyelovcGlqTnNSUWtBbmFEa1g0RTRsNU95?=
 =?utf-8?B?UVovakJ4QktrWWViak1mcmcwRldoN0M3R2hlcW0wMGhxRGVSVi9FVms3Tkg2?=
 =?utf-8?B?M3N3azVuV2hTR25ZSzBvQ241QkwxbmtpYTM2Tm90c0w4Y3hrMkNXVzNoZzZw?=
 =?utf-8?B?MGdoTUcwMHhDQllsZ2podWhUMldLVjdYWEErbHNqeWVuaXd4cUl6SlRXaTNC?=
 =?utf-8?B?QzYzYktqb01yVlliVk4wQW8wK3ZwWGNJZkZGWVdKcG5XdWVXQkRPN2xjOXhX?=
 =?utf-8?B?RXFRVG13TmM5OHYyTnUzaCtaclQ4SnE0RGQrUStadjF5dWJJSlhmOVFpVVFi?=
 =?utf-8?B?dHdpY20yeHFTS3lEV1hyYUUwSnZSSGFUZEVxTmNXNnBBb0J3UXN5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3931ca0d-a326-41f9-515d-08deaf2e2787
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:23:10.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkBRIoYv8PIf9vZBTroCVa9q+OFeG1zLHzSwuC+OfOEFYbrxIFqYcQxk9RWhrF9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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



On 5/7/26 13:33, Pranav Tilak wrote:
> When fpga load is called with a misaligned buffer address, the
> versal_align_dma_buffer() function shifts the pointer forward to the
> next aligned boundary and uses memcpy() to copy the data. Since the
> destination is ahead of the source and the regions overlap, memcpy()
> produces undefined behavior; in practice U-Boot's generic memcpy()
> copies forward, repeating the first ARCH_DMA_MINALIGN-aligned chunk
> throughout the buffer.
> 
> Replace memcpy() with memmove() which correctly handles overlapping
> regions by copying backwards when the destination is ahead of the
> source.
> 
> Fixes: 26e054c943a7 ("arm64: versal: fpga: Add PL bit stream load support")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   drivers/fpga/versalpl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
> index 630d1ecfea3..3cb56cc0dc9 100644
> --- a/drivers/fpga/versalpl.c
> +++ b/drivers/fpga/versalpl.c
> @@ -17,7 +17,7 @@ static ulong versal_align_dma_buffer(ulong *buf, u32 len)
>   
>   	if ((ulong)buf != ALIGN((ulong)buf, ARCH_DMA_MINALIGN)) {
>   		new_buf = (ulong *)ALIGN((ulong)buf, ARCH_DMA_MINALIGN);
> -		memcpy(new_buf, buf, len);
> +		memmove(new_buf, buf, len);
>   		buf = new_buf;
>   	}
>   

Applied.
M
