Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C81CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 13:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0735E87B71;
	Wed, 10 Apr 2024 15:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="fiDFZKIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C78987A4B; Wed, 10 Apr 2024 15:00:00 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE7DD87E7F
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gli2zeUvMUC6dGJ3DW12EVUhgLahGFJGSyDlf9fLsUVHXkDZ7kDp0CsfrUYHTKtntnYjpohGE/d/NZPnGeYEQ9b9Uw3aWOP1vyIapdtysj3jK+e+pTNSzdMjVMGrFavnc4SAOAkTK92KIadi8iCDLQSTLigqnh8RYwH3G/yV1gt7gSIEgpQZDj3yA4EjQhoZ5MU263rOtE6hMGbJ4Gb3TiuppAr4p986OQcKN8PLZ5hi04ZqKs6E1UuKfUbpuvjffCP7HPzTIN9Cid7FXB+mcn5iXS6u6L/BSY6dnFAYaOT3rU7Q3OFjkjUvyBVcTRWT8tUl1AT1HV2m5dXza61Dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isve7MJVinaR9IbiUWW4rf+kHerIoZOT2cQIkAVBF4U=;
 b=S5HldhE+Hq9DTm33tbqiiUkdV1xyGt1wTaT6YrTLVXECNQozc0vt+AFjN7zqTOrZF1NBgtxNMMDNNab/BJVKXLVKd8Jh4K/NFNQFQUBrP93mks/3rHYtcoKgKQjKZm421rngcQhD43izotBym5wx2+OA4h3pan4tzRz94hF92YaLhB3qtXj9vEGBJZ/niRjuFn4i7tiMldnwl4+mhmnbUTv7O4LBU+hEwflf9Vfj7rVhIa5lCS1LmPq95/J1n4z4KuDdH+045yC1DD4E5QEr/16OOUT1+PjT+7gr1/vR+mAxvcvE8psUacMxpJc0Z3ysPUlhQcNAQFrHRSmk+COhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isve7MJVinaR9IbiUWW4rf+kHerIoZOT2cQIkAVBF4U=;
 b=fiDFZKIZ0yV6W9rts2UMNA+auL3U0KDMD0Y6ftsIdEOL4VDOdrqJxh1JOMlpDhHcIsiOc7LX1WHnkRI6LKDmXHWDwEIHRrQggWCacpT22Sztb13LSLYDfHbBL2z5V4dN5yM+pdm2sdegJT3bpmCDEVTB3gwKJQgHSQm4xS856Lc=
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS1PR10MB5413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 12:59:53 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 12:59:53 +0000
Message-ID: <9f0c77bb-a550-46e0-853c-286c6ce896a2@prevas.dk>
Date: Wed, 10 Apr 2024 14:59:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: pca953x_gpio: support optional reset-gpios property
Content-Language: en-US, da
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240410111108.84470-1-rasmus.villemoes@prevas.dk>
 <8b44c94b-6957-4e7f-80ac-2113172fc8cd@theobroma-systems.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <8b44c94b-6957-4e7f-80ac-2113172fc8cd@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0100.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS1PR10MB5413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbGYA1L9jGvsjO4rP5S6nXLVdo1yt2TyNHzFAxFXEV2hoOfw97sHABnCBiORjHwGCAQ7oArEeHN0MCKy4gaHLRkQQ0Mb42Z4z6nAOhZ/QGQWsi4M7LJCW0GUOP98NjnCWfPE4ZCORQttHxDn7k/QyAb7NG6NuS50ajUDt6c27OisvVSFomoFWpzwblfLE5tm4wRtgfEzTy1LiC44WUywR0wjjIDPCf3KcmpH+Gkc6vIP8HKK2wwTadXiD34Hfi/Mws+C/CbZHkREUcfQ4FOtpvfVKBNQtPi5KdR+PRekAB5JTc+Fc6puv+K5T21CoF8GPLE+LewNIdOe82rqXZA/IELYm2XfFs5AA6P/EKxr94VzkPmcGgG6NnqLDvGK3L84ZrLKi0JMOlAjPUM5SrmxV7fbQ2V2IamvG4GrCEWGFrmrjRzzv+6tCOswfW27nLLf9O4okMDNagAQa0zS0SizntDAHP3bYl0BtQLsBerOUKl4UXEn6jBB7gfi/KDrxmb3Uc6WISRx5Mpn5PyXCOYvyZf85rVm6xb/hcrWCo3dVpjkoMpIKX+ZnDL3tjgD/J0GP/Yjpkq9eJzIFYBO+NzeJo7rEb1yEw//+V3wo7LC2T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dlSmd6d2dxMXJ2dlphWTZZOUVMSWZMOVNLdUVHN2hwaVRyY2o2T1J2RG5E?=
 =?utf-8?B?b21CV2RIYjJIV0pTaDl4SWJLbk82Uk9IQ0xScGFEK21Kd1I5aE1vcUdUVGZH?=
 =?utf-8?B?ZkpBTk1paGgvQ2xwamdJaWRVeE8xYXpQMXJtZktqSWcwU0tLRkJhMitpdFhN?=
 =?utf-8?B?RkgxNlo4aVlkejVzTVJyQXVVeUFWMFVOZGNLUnAwOVFGdVVGTmt1K3pSeXpO?=
 =?utf-8?B?KzhaMHFoVEhoamcwcmJHdEhLS2hJb1NyeEoreDZJcTBqVnZ2eWtCQWxLQlh1?=
 =?utf-8?B?VnlwdVFPa0Y5Q0E2b2VoVnFrOVRJQmFHMnhWR0lMdjRzNEtKMUpJQVI5UzlH?=
 =?utf-8?B?eHJTOUE4elFnR0dVUmQvVWhzeXNCTXBOMGcwRUJYbXVaWjdMclhWNTJoOUZZ?=
 =?utf-8?B?NW5mSktQa05nc2llcExWVjYwajNrNXh4VWMzMitQeWo1clhKMmVybi94bU5s?=
 =?utf-8?B?eWJQRlgzRjBtOVF5ZGl3L1hLaTVOeU90WndmMUpXVXFqMFBMUGNEMVpsTmFJ?=
 =?utf-8?B?RldENWpYTWg5aXhZQm1OZUh0dzBtYWkySk1tRVdibXpNWi9WTGtiQm85V3I4?=
 =?utf-8?B?VUh5QnJCWDN1THFZYklNSS9WRURSMGlnanU0NHo2cldiTUpDQkNDKytEVWR5?=
 =?utf-8?B?eEhxU29UK3licjFkU0pkTExNak52LzVlSzJQOCtId0lYbmtNcGxHbFJFWHFz?=
 =?utf-8?B?MGl2V01EWUhubDFjTk1aLzU5Q0ZoVUZYUEU2SkVOV3hMTWYzZ3FOZ0hGOUNO?=
 =?utf-8?B?NEltSEE4d3VsaE5SdTJJejM5eUtXd2I3VlNFa2dEYkJtTGxnbVhtVHc0YzRx?=
 =?utf-8?B?RzJKLzlYN3k2dStiSzE2SXRyRWRnT3VyYkpyczg1eU1KR2ljVlU0blVNdENR?=
 =?utf-8?B?dVR6S0JiTk5NSWtiN1JaQmU0dmdXbVpuR2ozWFIxY3JtakxIcEhabk1PblBM?=
 =?utf-8?B?dG9mTittMzBZdzA4QmVmU1VWMDVuTjJoNlZqOTJNOUJ4Sno4NVlZTTRsKy9Y?=
 =?utf-8?B?Y1NpbG1qbG45R21vNGNtZnlQOHA0VWZVc3JUajJPY3lXZ0ppUFRRWmdRZ3Vh?=
 =?utf-8?B?VTRkR014bTJ2eGNaNXRkOWVKZlduYnZTSWtnVFBqZDJmMGNCRmZuSTVKTmF1?=
 =?utf-8?B?YysySE9Vd3RvREpsbytFYmFLNmtoVVlXOGtmSmVhZ29OQnR5b2p5U051L0gv?=
 =?utf-8?B?VElyUitMdStseWgreVV4dWF3MTBmbjA0WklkWTN2NWFkRC9GMHd0aEhhRW4w?=
 =?utf-8?B?enkrN282NWwzZGRmdGdYRXVlSm92MmtvanFNL01HeDM4YzZpa1YvWCs3Nzk2?=
 =?utf-8?B?aE1Cb1U5TzlMYlVBdnFLK3VadHF5TjdodFVjQlFvT0JXZ0owTWlCbmxOVG1K?=
 =?utf-8?B?cVROUEZiUjZhbmU5VXlIOWhvb2FvbWdhR21JdkJwdWJVaEorRFRBbnRIeWdX?=
 =?utf-8?B?RzVLdkdSaHlTRzVtaEpFelhLVmVFeHZCRUdzYlJNTlJuK0wxNUtGSzFvZnlH?=
 =?utf-8?B?NW15RG9TaE0wcVNLaDBZUmtHeFFLWGJBWlZIRHJ1L0ErTndLWE5hZ2s5WWht?=
 =?utf-8?B?aFdydzRZMGptVzgvZjA5bDZqSjhiL3NXMUtSaVpXUDF1WjBUYWVZa05HMFZu?=
 =?utf-8?B?Q2ZqOHpXVTdyWFlSaythTUF2eTFwbXJaTWNuYWNDV3ZqbkpCdE0zdVlKVW51?=
 =?utf-8?B?QWtjVThEbkRGR0UzSWpzK0VNSG9NN0tjQUkvQkRFZUE4akl3VzVxMjlpMUxX?=
 =?utf-8?B?V1dWTnVEajhHN25rRkVwa0lVZHpuaTBJMDQ1azFOR21aaGlmRjJvMzFFbEgx?=
 =?utf-8?B?TER5Z2RFcGxrYWdabXZ4cjhxeWowS0NpbkJNYjEydUJVaXhvTSs0WnNXendK?=
 =?utf-8?B?ZktXelk4MnM0akl6WDFuc3ZzMEtYRUtaeklvODRycVljaEJuRkFDb2NwTG90?=
 =?utf-8?B?SlQ0bThrYWRyUElsQmJlWExsUC81SFBURUpFcnE3KzVWZTFkZnhuT3lNbFNK?=
 =?utf-8?B?clhrcStMZzdsMDMwSmdEM3hLWGFnNGhodWRkZjd2dWllY3JYdnlLQnhNVjJj?=
 =?utf-8?B?bXYwYU5SWjBXbzA3M1E2bTByamVDWnN0VkZqei9FSzB5Y0RhMkwvQzFiVUJB?=
 =?utf-8?B?R1lESTVHOTY1UkJNQ0NxN2VOd0ViOGRzLzVzWm1XdWVBOUVvaDhyVDBtMDg3?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e83e471-3213-42da-57d8-08dc595e1d1f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 12:59:53.1799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr6ZfggFfKtioeRZ0ChnxWIVYcClAOEWfcU6sOGOjuRG7UkJsJ2wWnKrQX8W4TkP3F3rTvdv0T3TnZb0CUln/NTRq+Q4zdZlzRtxd7XPe1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5413
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

On 10/04/2024 14.24, Quentin Schulz wrote:
> Hi Rasmus,
> 
>> @@ -321,6 +322,13 @@ static int pca953x_probe(struct udevice *dev)
>>         driver_data = dev_get_driver_data(dev);
>>   +    /* If a reset-gpios property is present, take the device out of
>> reset. */
>> +    ret = gpio_request_by_name(dev, "reset-gpios", 0, &reset,
>> GPIOD_IS_OUT);
>> +    if (ret && ret != -ENOENT) {
> 
> This seems to differ from the implementation we have for optionally
> getting gpios by index, c.f.
> https://elixir.bootlin.com/u-boot/latest/source/drivers/gpio/gpio-uclass.c#L1498
> 
> """
> struct gpio_desc *devm_gpiod_get_index(struct udevice *dev, const char *id,
>                        unsigned int index, int flags)
> {
> [...]
>     rc = gpio_request_by_name(dev, propname, index, desc, flags);
> 
> end:
> [...]
>     if (rc)
>         return ERR_PTR(rc);
> [...]
>     return desc;
> }
> 
> struct gpio_desc *devm_gpiod_get_index_optional(struct udevice *dev,
>                         const char *id,
>                         unsigned int index,
>                         int flags)

Well, that doesn't seem to have a lot of users outside tests? We really
have way too many APIs for doing the same thing.

I copied the logic from some other driver that also had an optional
reset-gpios and checked for -ENOENT, so I assumed that was the right
thing to do.

> {
>     struct gpio_desc *desc = devm_gpiod_get_index(dev, id, index, flags);
> 
>     if (IS_ERR(desc))
>         return NULL;
> 
>     return desc;
> }
> """
> 
> It seems we only need to check whether rc is non-zero, but it doesn't
> check that it's not ENOENT. I think we would benefit from having the
> same logic here.

What are you proposing exactly? That devm_gpiod_get_index_optional()
starts propagating errors which are not -ENOENT? That would make sense,
but requires that callers check three-ways (NULL, IS_ERR or valid), not
just two-ways. Dunno.

> Also, maybe we need a devm_gpio_get_by_name_optional implementation in
> the subsystem so we don't have to reimplement it in drivers that want to
> use this?

Maybe, but as I said, we already have too many helpers implemented in
terms of each other with drivers using some random one even if there
happens to be another helper that "helpfully" plugs in a 0 for the index
or whatnot.

I'm unsure just exactly what I should do from here?

Rasmus

