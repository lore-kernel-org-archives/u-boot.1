Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E429BCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 14:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D7D8818E;
	Wed, 10 Apr 2024 16:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Miw1j8L3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32FDB88176; Wed, 10 Apr 2024 16:09:19 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1646879A0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2OnWQU/3KCf5dhjGW6GyTEvhE8O50/EqJoCfOXcAxEusn+r2EflOYC0QnpN9oUUqSTWfJM1qxIbVQNUiGDlWLVdXS4nrxZQKv77psqlNxIFVQusGd3tE4gcqF7MFswC67TqcZyQt4dYP1wFBvbd7SESGbx9XLWhgzkLD3EkP3KWEdhsQNoYfnMpchc3kiTQQzlaj2JrV5FTuiml1hfjbcRgK5sBBNBzxwtjosabBSz9byo68xa/JNJ9YPQhlWKjhI9yTxUZJ7pJP4ys6jAikx+eM2XpluxeMUccmL90uhsCvLQ5Obt9ffS9JX6/1uJdYqH0Nvcc2pIxb3uEgINiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WJinGAM+U9LAnlYLr/Fv9MQitJ9Pno9LWIU0tBy8IA=;
 b=oWD8sUa5cTCsFF2Eeeea6cjMB9Cmxjawio13SkyGa7jswkMSs8ZsMXlHRf7R2hDmhAMEZBeb/sxk2AsyG7qnL2ZvNKHFpxtAX9XFbdaPYleTn/XfyetUhPyp6YAUB8TXkV49fSq2E91QQ7sMJfiM2wW4O7FUKfMbfhWQNMiSLzdm0sfRv1SK9m97hSQ0WG8iKzSb2vREdKivxSboBAQjf0Rqvb9Im/wqNIefQdjtwWcog2iUIKkt6NbxR1GLJUNx+QnO80pqDxoO+PnkY3hKhb0GTxoo0W3Ujsaz1kxBDzZ91Di3u8S6Y1es5r62UuapGRE0JITRqvHO5hpo1JUq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WJinGAM+U9LAnlYLr/Fv9MQitJ9Pno9LWIU0tBy8IA=;
 b=Miw1j8L3P5RiyywQ5TCjM8eMCB6SwmDEioQznB8jC9nCVcdKjAe6Ug1tIh/GRWS9sUAH5Xu3RkYMM9R+5FZvlyCUXVW+NX4GLNlw92gy+V8DO414beAMlwGMlVy0za0JATqiWQjlauBAaYdCk7YgVWTZgBrPiMp5+V1kFO8VaYLRhog3pft1Cn0aGfjSTckUJkF3tbVQLEm3rgbIyBoozc1FTqHpfvdEuIf79YpGnadCxiMDv/2U1zSZR3SQvXiHNBIaHV78y0XcZ8awuD5fs+cKifwu7Oen0Hagmukh6DL3IPBvvoN84mXGGr6MLduwI+tgMEVDrL6zkZWMHtE7Ow==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 14:09:14 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 14:09:14 +0000
Message-ID: <0c910216-3434-4ffc-b64f-004ed1a3575c@theobroma-systems.com>
Date: Wed, 10 Apr 2024 16:09:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: pca953x_gpio: support optional reset-gpios property
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240410111108.84470-1-rasmus.villemoes@prevas.dk>
 <8b44c94b-6957-4e7f-80ac-2113172fc8cd@theobroma-systems.com>
 <9f0c77bb-a550-46e0-853c-286c6ce896a2@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <9f0c77bb-a550-46e0-853c-286c6ce896a2@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paqfQOZQY4TEPmpjdg1y+IHu7GhFVOVuUWWUm5ztaRivTiCxpoVdxOM4acPQLpK6Kt+VMHPbKWUNze3I0TouKNkBma5Zt3De31m4ot6K1Y5cYmhTMzjZtPl/rY897tGSv1prWVv0UASfhalq1nWxT/aoGxFdtKHDiRPCNP58Njg23c801U2SYT0w8c/yNUAoCyNcOgaQCrTpagi1Q7PlYDDqdffXz16cYFRAYW+4IATBGWzHNpsKTety+bHTWIVxEwWhyRqFUkj56kSjJm1MbYNw+U0m3/zFjIymDL/h+oVsBggLI1ev6bMCihg22RxSIdF74hmEofZbF5p1bcQx28eQwRY0xxaLMuq7rUUsuzgv9z/VvWByG5MMl/zUos+QQA42ONvOWwHLJ8DQMAmHlTeVVyYNn95cF5RL2ZdIyWNg8y4jwWIn+jY5XyNBjdNmqRAA75W7t7HLnhMB5HjwauOYUQxko8VnxkXgmkDnU2Hr4Ib6MpKsADmRQR+suCJEXryr3CfYMCckzMLBDgQUTpwKBXf0x3nHB36UQ6AI8bJesgY8rPWSZuX+NrmwGHAs1AaQvuXHXFeD1mHRSrXEDnGK53HneaQNKqovTPiCF8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFxT3hZQ1k3RkdZUGdJbTNrYnJQRGVaU1V5WHNSbEZZSXo0RTRYYWtEQ0gz?=
 =?utf-8?B?NWZWc1lPWUVUb1hJL3BFTVNveG1abFM1ZUVGUUtPZFdsNzVSQjRvVEJKU01K?=
 =?utf-8?B?K1hwOVYvQnVkYW9vU1dicWNzMnFUYTVWY2IzRzZYMmpHS09YOEJSWTIwcFY3?=
 =?utf-8?B?ZitqeHNHV016VkVxMDk1UUNFQjF6aU9Ed2xacjVVaS9WUGZPWFpxY2lkdG5F?=
 =?utf-8?B?bUV4YUd0dDdUY25nWjVkQnBZZFdQek51dmV1VnJzUmJUZmRqMy9VV09MNUJM?=
 =?utf-8?B?bEllVU9ZQmNtd1hBNEcwdmYwUW10c2p4dzVudzVsdVhQVGl2Sy9xVk9uV0My?=
 =?utf-8?B?cWwydTM3OVFkdHd1MzVQSkd0bU9Ha2JoaXR3dW1GSGhkSzhDNVF2cVJmRmRE?=
 =?utf-8?B?Z3U5a0w0SUYrTk5ZM0hKbHRMVUhsamVMUXNUcUVGK0wxU2JIQVdMQm9CVkQv?=
 =?utf-8?B?aHVqTFRramZ1Uk94d3JqZStKTWxyKzl4NkhiVHhlb0tPUURFbDdhbVNRazJj?=
 =?utf-8?B?SThGY3ZXZ2VYR0JNQ2Jpay8xc1NHT2FQV0xQb3BUZkhvRlRIZ3YzZG1VZVJB?=
 =?utf-8?B?cU0zZTJBclF5QWpjallpTFpkWjFCbk1jMS9WMno3SnJLaWNwb25tWUtUd2Nu?=
 =?utf-8?B?RUhyVm1wRFJvV0R0RFZqTmYwYjdhZnplUFBkaHFVOG40MnV0RnZtVnNlRzNC?=
 =?utf-8?B?aExjVkFUbEFvdzVTNlBla28vbVBudmNXSmNBQVZ5ajVmR1NwUjZETWdvd1RC?=
 =?utf-8?B?dHpENDlyMkFNZWNLUVEyZi8wQTg5NmpibUVhVFJQMTNydGtZRmlHc3djNGY3?=
 =?utf-8?B?a2h1VTVoNGV4aUlsU0tmb3VxZ2EwNHlObExBNkgvMFFLNS9rSEx5NTVEc0tM?=
 =?utf-8?B?WVlQRnpQemozdkFJem9ZWk1OeS9Yb3RqRHgvT3FrOHZpZDFQcHd4NmNKbjVJ?=
 =?utf-8?B?bEM4aG84SERzZXlaN05HbXdEQmJ1RmhCTDJJRVFQZjZpN0xQeXNnY1A3SHBw?=
 =?utf-8?B?b2tzcTh1Ump0MzIxR1F4bW9tV0l4Uzd6dlUwcEtzQk5IYUg3SVNndi9ZY010?=
 =?utf-8?B?WmxiVGpRZDRRb3FVQmptM0NnalVqUHM2NzB2TlZ3bUxMUzE1dGhLVnVUUWpM?=
 =?utf-8?B?WDlCekJ3OEpjQ1VVSEFrLzdvZkU3N0I1YnpDeG4yZWFkMVlKaTM2K2Q0YkNh?=
 =?utf-8?B?MjNwUGxzT2tZdXJUTWdMc29jM3ZYUWdHYjlvY3djWGRvREppRERNTmFkRlZT?=
 =?utf-8?B?U2VrcWVOdjhnWUhoeVVpRHFYQjlkZGxlN2NtOHRFMU4veDdqZ05odlVyZmpH?=
 =?utf-8?B?UXlKZnY1NXRqaCt5UjNMRVZLdDMvbGpzU3VqMGVsQWJOeHNHbG1ETnllc0Mx?=
 =?utf-8?B?bThnQ0gxek05QTFZVVdIZ1FRZlpCTXJBbGx4NXE2YS9ldGVEQ2MvZEllZFJV?=
 =?utf-8?B?WGRnNlJUR0p4dlJLMWRkL0VrNEpEWTJCRzk2YUhTRXNwNmpSeklXeDNoeGNH?=
 =?utf-8?B?TDlMYW56L2JOQWVSRzRna0tGVThpQ29McUYwdHQ5UVZmREtxNUlYRGk2Nngr?=
 =?utf-8?B?VzRaQklMbktET2FIMU1XUWZESGNWai9jWlF1aEVncmJwOTdQLzRTczV4eFE1?=
 =?utf-8?B?M2lOcnVIVkdycjdUVkZlWnhuMFFEVzFSa2kyd0l0cmJNLzJuN1ZwK2UvSWlr?=
 =?utf-8?B?R1BUalBHTkVKaXI0VHRiR3FrNElIL0h4MFJXTWY0eDk3NkNuSUVOT3o0aHhO?=
 =?utf-8?B?SFgzVCtWS3pGTDFYTTBYRkt5WHRDZ1ZEYzFsaFdMVnZha2Yxdk9FNjFaNnRY?=
 =?utf-8?B?WEtnWHZ0c1Fud1RhVUN1dWZiWGJKdThMZFNPOVhBQ0JwMjlUZWM3QTdPMUx6?=
 =?utf-8?B?VjVlZTV5Z0o0aEFydWZrNzZRVHVvSzNkVkJuSFdXSWc0V1lMc21KSldVeE10?=
 =?utf-8?B?ckR3VVdoOGZ6cVdxKzlDZjN4b2hsR2xwMFBwUVNLems1UmI5cUZVZGZ5VHZO?=
 =?utf-8?B?VXNidkhCSjVTNE91K1pXVHBxaEhxbTJNUVZWbHJYQXoyeEZWWnR4ZktyZjVv?=
 =?utf-8?B?aWcrR3hrblloMTRrMVg4Mmd6ZUUrSHRwZ2pVMURVdUt3WklYbnIxWWxRQmxI?=
 =?utf-8?B?MkJrVGZGeDVaZ0YzOTd5T0IwY1hqZjFVTjhRdnlhSWZWazRpbjVyLzdVUnFN?=
 =?utf-8?B?dkJQZ3NJTEJta2lhR3d2OU5CR3hKOFozS2dLdWZJMDJOa084MXR0UjBSMnJy?=
 =?utf-8?B?T1ZtSDFRMnRzOURsM3JtZWJpa2VnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef0acc4-92ca-45c1-af43-08dc5967ccb9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 14:09:14.3016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NyfSxKIDRlrk8qYjHK0q/wPcewctAVL+bV1ho4utSTtlhxGXEgv/QFSSJTJrjL6wgHYCt91EGFUt046GD/7dO+aOELYTn3UGDbbxWL8JOp9LQk3gztVGUdJdKX7lH1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006
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

Hi Rasmus,

On 4/10/24 14:59, Rasmus Villemoes wrote:
> On 10/04/2024 14.24, Quentin Schulz wrote:
>> Hi Rasmus,
>>
>>> @@ -321,6 +322,13 @@ static int pca953x_probe(struct udevice *dev)
>>>          driver_data = dev_get_driver_data(dev);
>>>    +    /* If a reset-gpios property is present, take the device out of
>>> reset. */
>>> +    ret = gpio_request_by_name(dev, "reset-gpios", 0, &reset,
>>> GPIOD_IS_OUT);
>>> +    if (ret && ret != -ENOENT) {
>>
>> This seems to differ from the implementation we have for optionally
>> getting gpios by index, c.f.
>> https://elixir.bootlin.com/u-boot/latest/source/drivers/gpio/gpio-uclass.c#L1498
>>
>> """
>> struct gpio_desc *devm_gpiod_get_index(struct udevice *dev, const char *id,
>>                         unsigned int index, int flags)
>> {
>> [...]
>>      rc = gpio_request_by_name(dev, propname, index, desc, flags);
>>
>> end:
>> [...]
>>      if (rc)
>>          return ERR_PTR(rc);
>> [...]
>>      return desc;
>> }
>>
>> struct gpio_desc *devm_gpiod_get_index_optional(struct udevice *dev,
>>                          const char *id,
>>                          unsigned int index,
>>                          int flags)
> 
> Well, that doesn't seem to have a lot of users outside tests? We really
> have way too many APIs for doing the same thing.
> 

It is actually used outside of tests as well:

   #define devm_gpiod_get_optional(dev, id, flags) \
           devm_gpiod_get_index_optional(dev, id, 0, flags)

Then:

"""
$ git grep devm_gpiod_get_optional
drivers/phy/ti/phy-j721e-wiz.c:        wiz->gpio_typec_dir = 
devm_gpiod_get_optional(dev, "typec-dir",
drivers/power/pmic/pca9450.c:                priv->sd_vsel_gpio = 
devm_gpiod_get_optional(dev, "sd-vsel",
drivers/usb/dwc3/dwc3-generic.c:                priv->ulpi_reset = 
devm_gpiod_get_optional(dev->parent, "reset",
"""

It's not THAT many but at least there are a few *real* users :)

Also, I think you actually want to use devm_gpiod_get_optional since 
it's basically just wrapping

"""
gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OUT);
"""

with devres?

-ENOENT seems to happen (at least) if the property reset-gpios isn't 
found, which very much would be the case if it's optional. Now it seems 
-EINVAL could also be returned in some cases... 
https://elixir.bootlin.com/u-boot/latest/source/drivers/core/of_access.c#L669

Now... reading what the kernel does:

https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib-devres.c#L186

checks the return value with
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.h#L189

Soooo... it seems they are doing what you're doing.

So, what I suggest is the following:

1) fix devm_gpiod_get_index_optional

to return desc (which may be a pointer or an ERR_PTR, so users should do 
an IS_ERR(desc) check after call) ONLY when NOT IS_ERR(desc) && 
PTR_ERR(desc) == -ENOENT.

So:

"""
struct gpio_desc *devm_gpiod_get_index_optional(struct udevice *dev,
						const char *id,
						unsigned int index,
						int flags)
{
	struct gpio_desc *desc = devm_gpiod_get_index(dev, id, index, flags);

	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
		return NULL;

	return desc;
}
"""

Maybe some adding some new test also for this new part of the if check?

2) use devm_gpiod_get_optional in your driver

What do you think?

Cheers,
Quentin
