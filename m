Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E48CDB481
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FF28460E;
	Wed, 24 Jun 2026 16:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mNYg65eE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C4B84671; Wed, 24 Jun 2026 16:15:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB5380398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bubiIKhoV5yAhwQCvF5JtFdDIk+hnoVrt7982tu8v0xuUTf701TlHyp/wJnOoZrcP3YJmz/6UiVovjfnS7mOTErXLGlD+6uV7nckQsHw6nScxrzpFdVrfDwovM16R4lZNi4fVudIb/9j4LoxQRD/AeAYP0RzvYz9Ixtn2H76iQ7IyhHRAtXu815KswlEnROSpo5z4KuT0f46KmnJj1s3SRD5aVqqxz8MJZj/EB7rSrlXSUjqqxIaxx0Ex9Cokf3qDJM+kxXbESmgPiLc495RlZeve0v9Mb2MpUUDOTc50PnQroe/khZ1fGQBTJA5hRrKWHs+5AYRzXj+0ZpDTWTklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqIO2KFlOby/nZMhWSulTZaNMurjcKZmNoKWokAP2Ak=;
 b=Xt885R2zD/gN6L5AW27I0F4wYfInlxl2xjrrs0W+AQMpLrrfJDiMC7SdJ5k+rpsjXfw+deqxjnVfEmNQt7fQ2lNFsfvknw+PwixZggyu+50yDAIeYOtLlgvGj5RLSY2CfcYLoYbb5mwZvNUK3fASeTPWSwZbWAZpoWAtkr8UpH04YysXc3WHASLtczAEQ6NnKOfCVkGQV37RNegDWix2yodNofjfw8ZGoslBMurafc6ekDJF2SEGlk+Gnd63y/MQvNGq6jFFTXZq9doRnqDjD1ekxGqP/XJscP32IwfMpd07Tgw2kU3IF0i3h0Is476gU5pRNIF33stI5IPtmR1ZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqIO2KFlOby/nZMhWSulTZaNMurjcKZmNoKWokAP2Ak=;
 b=mNYg65eEKw6zgEdAqQ38sxaGG0Re0Wy60T7bnUc0rDOT0eISTOKNcIP+Ad8Vveq3o5Yayj0DyHYchiUVBNqFbWbGRgdz2NBXfqt50wx9mb+PafqFanRJTIvZsBq4WgDxOxPRnkzvxnJ5syd1jpQmyRZdXA+50tWJ+P6QNmfvfeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8987.eurprd04.prod.outlook.com (2603:10a6:20b:40a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:15:45 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 14:15:45 +0000
Message-ID: <14653d07-924c-46bc-9d3a-f1681e85053b@cherry.de>
Date: Wed, 24 Jun 2026 16:15:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: onboard-hub: Add support for Corechips SL6341 USB
 2.0/3.0 hub controller
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
References: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 4264aaa6-d6cd-49f5-5dc4-08ded1fb14d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|4133799003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: vDb8lXyIs09o0IDOAfVK6k1SSNIa/T4G10/SFcHCUcWSFpS46DzJYMC0uspsJYinowc3I4DHLKgHv0Ub+jRF7tRf60UptfQLY1h129iSp29bg637i6uRBex7QRDqwUFbMI2ve80u4CJ3SuEppeno00tLrOZiYmYjz1RrniC+zQGik0Hat1KEYiLIdY7ajAvWXkofJ/chDsmAVCp0FaSo9LhK1dsrqWHWaxaQQaZ8J5JFJ2OYLaf6L8huyG9Ycka92cBdfA9AbEGX/ZAzpYAjnfPfqtiPaDlNgsyqrlOLAwWMWokzjgbw4SLgplnw0Rvh3wN1z5vOi77TzuavaQr7AS+ONqpOTNWgRo+8QoClyum3K11HCc5yuAsZF/QCAKajOUce6lymLfI3kExwI+JOd9AqYxgiCmHjccDTPhZrZ9/uBV5UmV1STb/3w4Sr6apLzKXgtGRFoDdMIzeg8O/InFLC9bc+bYu8j/CDdGen4rhVFZ2NMqNj5gxEsEaSseXHSm2409c6uMEsM/VCuNvPC1D5Cfa5IgyGYpvQP3Tr9Vak+UmXvdxUxeuaIFHqDtTh8bSzZfVcmypRH1Gfm3S/GiSaCkRDdL4+PXUx1ouywRroE69KAe/9AycaLeiqtiRFZcph/eh95EzjmKQah4KQQR5+1fdDcJO9RmH8zsmOPtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(4133799003)(11063799006)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RMTW5KNlh2UXhkUjExb1lPSUx0Ly81a25GMFowb3BSUm1XOWlUeCtjZ0ow?=
 =?utf-8?B?MUUxWUgzUFp4b0hYblhjRWZESk1CRkQvY3ZMeTdzYVR5YlE4K29GU1lmZEJR?=
 =?utf-8?B?eExCQjVCeU5SUHIyZlByV2NYaVVncWw4Rk83d2ttSnZYYWlROXRwK3VGMGJk?=
 =?utf-8?B?bkwxU1pZWGI0SnBTdjFHMVNzQlFjWU43WVprK3FneE41a1cwVStTQXFuMzgr?=
 =?utf-8?B?ZWxSVUpmazhxTzJOZ1BuVURsK09sM0FtUGpFdW5FTXhkaEVjK1JmeHBnTWcv?=
 =?utf-8?B?Yk82YTJ2MnlJVk8zS0Fkc0puSm54eHljM01ERVp0R1VaYzBDbGUweUJqaHB1?=
 =?utf-8?B?QUtBSzFMbWpNbGJuekVYSkYycit5RWFCWWQybnBxLzkxd21sRHlvK1UxWm5s?=
 =?utf-8?B?NEhtMGhnU1BEb3c4Q2VtT3lnVExTK3Rkcm5sK3dGemdaSnhwNk56ZDJuTnRT?=
 =?utf-8?B?VmVOT3l3WFVEWE9VTnhXVktHZXRvUHh5WXFLYWRRQUJGRWVVUlQ4bmU5ZUUx?=
 =?utf-8?B?RVlaUDhTZnliVG5aMnRzeEtlY2xpbmdSRUNYeGZOaDdiUU5WZkxQQWdQeTVR?=
 =?utf-8?B?TElPTFNXS0tObDhBK2xCejFZaU1EZ2VTUDN2MHE3RFkyUDV1MWJ0cndYS1VN?=
 =?utf-8?B?VnR5Z3g5cVB0ZkgwYU05VnBQZTdCaFZmU2YrVHRlZE9wT0crY1ppSUxteEJN?=
 =?utf-8?B?Mk5VMk1uOWUvMDZVNUxGZUpNTW04RWxuTWYzeHRoVEgyY28wQUJwLzV2T1Y3?=
 =?utf-8?B?ZGZHR1Q0a21DN3F3SGxOOE93aU5NbXdPNjh1TDNpYlF4N2NjSmhlWlZram5w?=
 =?utf-8?B?Ly9HOWoxbzJqK0tYd21xQk9XK2ZuaXN4Sit5YTlvN3paUkJQUzg5WkhTVUp5?=
 =?utf-8?B?eVVpNGxxY0l3RnNSVkVKSWZ5aDRnWEhPSHo3STNKZlg5TDV6YVg3SWs4ci9r?=
 =?utf-8?B?bWw0RXN5UHU3TnNKWVBuYnpFOVhMNUdNYXVMVFlEVVd2Rk5IcCtQNUxYNU8y?=
 =?utf-8?B?bXh1TlNNK2RlMzZNUVpLNktXSVNNQk1LR3ZTbjdJWW5rVVlCczVaWHRKRkgz?=
 =?utf-8?B?YkFLWCsrd3R2eFRjbVQxamhWcUY2dEtFMnRyT1RUZklZb2pqTXZkNFpZcWta?=
 =?utf-8?B?K3BORmRCTEZvTHVJSERybW5LbTM5eHUrdjRsWFg3VU9YM2dvQ2ErN011Ymxy?=
 =?utf-8?B?a01ZeTU0SEtFODBSemR0bm15ZlJ3eVcrMzBEVHZ0dVJsN25mdHI3dDh6U1NJ?=
 =?utf-8?B?UFJuQ0ZPbTNhZndGZ3lONGRNcG1tTU54R1I4WVEvK0xYTXZPZUxTUE0zdWJj?=
 =?utf-8?B?TTJuSFUrMHR2MW1jTGZsL09lb3FlZ2ZFbWdoYzFJa2F3djZJQzR1a05XY2du?=
 =?utf-8?B?L0NwQVUxMmpOazZiTnR1T21hTlRNV2FBSU5La05pQlRRa2s1NTJaNThoKzFJ?=
 =?utf-8?B?NlltalRrZGFKdW1XdEFZdDVuL051R25qV1dzR0xDQ0FCcStmaEJ4NE13aVJq?=
 =?utf-8?B?RzBuNjBnY2ZQQytVNi84RXhtSmRTUWhKb2s1cm54YjJRdWxqZ1dRU2pNdmNh?=
 =?utf-8?B?RElJdDhJVGFIVWEyWGI1TS9RNGVPMFp3TFowUm5NOTd2akZNTGtGY2k4cGd5?=
 =?utf-8?B?L3FSaEhqK3YrUExZVSthMXQwRFR3WFo2QXpneGNlbVFCbjdDSmg2QUFSZkxQ?=
 =?utf-8?B?Kzk0YTFPVVF1RzJaKzB6Z1dZck1jZmhRNThDbmNyeG5iKzFkalFvcldNSUpF?=
 =?utf-8?B?ZDd6dm1kRXpUb25uRFF6a3FzZzNKVGJkV1ZTWi85clF6NVM3OVJ0WGd1Q3Z3?=
 =?utf-8?B?UGkyT1ovY001T1lkNTlxV0g1TlJ0UUxkSEJYazFGOVBRWnphR05vajRVdlVM?=
 =?utf-8?B?Yk1xUlVEUmNIMis4aktDK00yMWpFb3lJOW5uWGNyMnVLVE5XN20xU3A0aURj?=
 =?utf-8?B?NWhyeE1GczU0SlpVVTU1My9SOFlnT1FyV010NlZGK2Z0YkVDVWFmL2JVZjF4?=
 =?utf-8?B?bW56VjhPY3VKOGk5aEFjOXRYQUtSOCtWYU00OHpBN3lkcTFJZWFaY2tFVFJ3?=
 =?utf-8?B?Ukg5bG5RY0xRTUdXMGZTcXdBOThlcXFOVTNvbFUzWDNReVNhQmMwSDRTcDJB?=
 =?utf-8?B?TzVmelA4R0c1MERPN0xjSkxMbWdtRXNuSVJROWhJSzdRU2tVUVcyMm1ZWXE0?=
 =?utf-8?B?TnQ1OVltS3E3Q2lDcWtSallXQzg2TVNxbU5ZODJ4STdwc2M5azZZalpKejQy?=
 =?utf-8?B?dUVVVlJ2Y25QTk9McGRHWFo3UHdFRzdROGtORDhGdWkyY282R3FMTW90ZkJQ?=
 =?utf-8?B?U1ZYWk1jc1hPYVAxZDlieWZtbmRHV0tpOXBPMnpQZXpuZ2FsbUovZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4264aaa6-d6cd-49f5-5dc4-08ded1fb14d0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:15:45.0334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEMA0qFVPa9OgGgC9L3B21FZ2yKPjyNLSQ2lm5K93zGCal/YNzW6K2kizZLmGtYH0vFHqWIbDf/fupnWmY7cMVzovIDjRBGUpnnBBWn0Nvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8987
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

Hi Alexey, Tom,

On 5/12/26 3:55 PM, Alexey Charkov wrote:
> Corechips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
> requires external 1V1 power and can optionally use external 3V3 power
> (or alternatively it has a 5V->3V3 LDO built in to derive 3V3 power from
> VBUS). It also exposes a reset pin.
> 
> Device tree bindings are merged for upstream release with Linux 7.1 as
> commit bfcb86e58f3a ("dt-bindings: usb: Add Corechips SL6341 USB2.0/3.0
> hub controller") [1]
> 
> Link: https://github.com/torvalds/linux/commit/bfcb86e58f3a58d05b95970d81b94cb011982780 [1]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v2:
> - Fixed the comment to correctly indicate the USB 3.0 entry
> - Added an upstream commit reference for the DT binding
> - V for volts in captials (commit message, thanks Marek)
> - Reordered the compatibles by lexical order, not hex order (thanks Marek)
> - Link to v1: https://lore.kernel.org/r/20260512-sl6341-v1-1-2819ac19e050@flipper.net
> ---
>   common/usb_onboard_hub.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6fc34489a98f..0684f7bfd479 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	return ret;
>   }
>   
> +static const struct onboard_hub_data corechips_sl6341_data = {
> +	.reset_us = 10000,
> +	.num_supplies = 2,
> +	.supply_names = { "vdd1v1-supply", "vdd3v3-supply" },
> +};
> +
>   static const struct onboard_hub_data usb2514_data = {
>   	.power_on_delay_us = 500,
>   	.reset_us = 1,
> @@ -285,7 +291,13 @@ static const struct onboard_hub_data usbhx3_data = {
>   
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
> -	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> +	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */

Would be nice to have an additional newline after the opening curly 
bracket to avoid this unnecessary chunk in the diff next time we add 
support for yet another USB hub. It's also a bit surprising to add it 
first in the list instead of last, but eh, nothing too important.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

@Tom, can you take this for next please?

Cheers,
Quentin
