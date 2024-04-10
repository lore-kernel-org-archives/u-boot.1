Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CABFCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33665881AC;
	Wed, 10 Apr 2024 14:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="c8gI6dVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E787787527; Wed, 10 Apr 2024 14:24:54 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F26881B2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLhuEwcyhxzK2IxsfJL2ncUqhU3T28HUOTqkKWH6yitI3MHVA0Z+/l6ZZXRdteFUlf9f2vSIwO/SIFG1gLCNT5CE8lMxaNdBcHFtn1Oa2asS4sHpQlD1q5Naywr+Mr/iCaA1xUdZKIRj+bAA79ZtiYKKzyK/zMi4uYv+fEM1vtk+hngLcsBjtd2aNC46z5YqDghPgNz7OlGU+o4cB4NENUaqnQ3GOz3puhpdrKVsf/jKqZ71F7INGZw8yDn46Lc0j3ba67K/CbPW/7mOZBsPAXsA7+J+gov7CYh4jz6+H/Hceb8ar6+QvvHJ2DWnpuZEfQXG/iVznsC7m2ynFnIoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwcUH2n4MR/FMZnnjbl8FwRLAt9jceOhOEeaBiRrj9E=;
 b=am47zKSOx6gbk2zyCeVfLwY/UCB2T14nz4LlrRUb7W224+owrWdfeOrH+f5jNTFIwt8XZkrjVF8geSKhdlvfGiQbNnnd+k+j4TdIU6pwEH/hIc7fpEcuJZr/7+Ks/CYDk3uENRss31tvLpBbVCJz3su9f+koAjA4feFgymS5lgbuwP1sPxWhM4b8EE8b41/DEtaLtH6QT91DuQEoNhHDwyOprohKhWuwT/WblUgMoxV/FDFvnHrFCV/Z5Fyh5h7nPhZLTvEpPWiXD4xQ7t6hx/x8yoqlIy2UxHH03F9O0+DNK3nYt21G9AQ9iiY2Od3L5KJCqqIm1VVRY73PTYFnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwcUH2n4MR/FMZnnjbl8FwRLAt9jceOhOEeaBiRrj9E=;
 b=c8gI6dVv5fflpccSbyscFV6ObrBkO0Uyyho6DvKx0AwGDoUd5FhuQPU7yoUttBGpUgoUZT+UfOMCGrbk4Wpd9AquSRUsu5Dx8UgdqdcViL2M2t/QUEORFg1FOBiuqlj/jAZj8YITrBbRXd38qcEOFvzD86HIxZ4Ml/tJENYRXbc6dNt7YNmHS6MkAWsAIlUAhIeqfck8GRZHkDFVeG8Zn8L/x5qqQWjxUniy/c5/paW1WXDWfLCMPEGjAgoIK7r3+qeQb2ugDm3c/uVMuis6UuhnXACTvFocM6Kur6JMnapFTqOtu3GjfxfWYwPz7MhO78wLOPD0dBVJgx2T0PEMug==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 12:24:48 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 12:24:48 +0000
Message-ID: <8b44c94b-6957-4e7f-80ac-2113172fc8cd@theobroma-systems.com>
Date: Wed, 10 Apr 2024 14:24:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: pca953x_gpio: support optional reset-gpios property
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240410111108.84470-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240410111108.84470-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB6944:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wd8OUI2hAYU5FGI+ffhIdOkpUFOiJbmxb0IHfdIeI11ro7drYdjoXXSlvsBfIzFCZlM65WmytBYd7eOuzbXzFlwcsx6tuWxHqY5447nAbou6qZP/swAWgWnk9V6KGC7tME8h8rAoW8erhCxTR3GwRhqcBas58yo1qj49JfnySEBVbJ8XqwK7mgl3Q7kwbmL/zgSmiQkw+d/dz/B1GuRauAXOY6mLF0l6azxohs2by5IZi4j15PaI2eLcHkjf5g3h8W7wyUV57+ct7OtIVwDkKYk3wIbn54NL9N2LfR9HKc9Y3GTlRPmjzTkN9LXwAVnDaWrJth8smNrX6AXeQ39oRb0NZYDTQhGP2OGlAKDjC7RoFoFrzSHE1S91luGxKNAs93dNFnEiWcJuBYgI6wRFVDRwX2IdjIyHE5/ddv4W7CVZuDhrA4TfbO9Ob9HhwWYL/XWr6r0FfIxVlZt8souDUVspLjoTDLm1spZS1CA2Ela9JsW4rsPGQ5zQBgI3t+pT5RTPf/JKETkf2pRdWj1XiWBhjkeYwhTPe+xf2BvT7stqaVGLSBoQjuydBpZnSobgQcZB0iy3k5pzVWc54tDTNriPUB9tqkPXdPPuufcSrho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RJNTZTNDJJVE5CMDFrMHJGTE96WTdTTTZIK1NWdlVjMnkzcHJMd25hZmsz?=
 =?utf-8?B?d0N2di9RZnN4ZHErWEpzb1BVaWV3NkFDNUdTNXZVMk81Rk9RQW5jV0FKU0lR?=
 =?utf-8?B?SFBVbnZzeDhaS1BFZ3dCbm84eVFGVGF6YkZPUDhUOXQ5cGRnVUk4RzBHV1NB?=
 =?utf-8?B?QVZHSmVkWjdQM1VGN2RlTnR5OGFIT1laclVSU05XZkdRMWZKdW1HUktrTzJI?=
 =?utf-8?B?RnFoVWxFaVd4YjQ5eFBNS2h6a2lNaXM5eFl4NEFQZnJoaFgyUjVhdzljNVJR?=
 =?utf-8?B?Q0cwN0tKTmZOdkJsNHRUQWxZNEJGZHVRdnQ3VTZOUzFGMXg1UmVuMnd1OTAw?=
 =?utf-8?B?MnpJc1VJOC9MSk5uNFZDWXA2a2YxWjB4ZjFYbGl1b2J3Q1BJZkRZMGpZazhJ?=
 =?utf-8?B?dmpJT1VCWUxQSmo0MWsvN3BaZ0xpWEhzMTFBRG9SODlMZFB4Wlk1TkgzSzhU?=
 =?utf-8?B?OXg4UjVZck1pV0o0WDRNczg5VmtBaXBGQjBZdEN0MDdHUCt1Mk1uaGNwcEZW?=
 =?utf-8?B?dXlrZkJuYUZiR2tsS3YxUTRuWWhDZmhWZVU1a1owdWhxa1NtRzNKT0x4dDcx?=
 =?utf-8?B?MVcrTUs2OStCR2htbUM0dm04NTFtN2NWYVJHNDhMbHpOQlE2emM4dGtEVzdQ?=
 =?utf-8?B?N3BkN0VWN0szMWFXczdNV2xBLy81VHlkR3hkamI4aENLVzJINldQeEM3RDBn?=
 =?utf-8?B?SjlORDE0dVlJN0N4TWVGK0pHSnNwTERKcWV2dGt5Yy81c3lUN2hXS2dDSXcr?=
 =?utf-8?B?eWhLRjQzMjYva0N0NERUNTZjaytTMjlJTmx5MytYV0dDVmUrbkVwem9XbjRV?=
 =?utf-8?B?anpCalRtRmtRTzFjaDVwLzFxdjgrbnpWY05KN1JqZnFrc3JkemltWndFN2s3?=
 =?utf-8?B?RVFNQnB6aUdKMzBGanJSTUNjdGVHbDNyQXVBeGp5aHlKZUtUS05mZTJCUlpa?=
 =?utf-8?B?NWZVOGVzRE9MekJCSCtlOHRPOEw0UHJ1SWZjU2dEUG1ubnkvZVhDN2MyTCtS?=
 =?utf-8?B?MW05N0F6d0dBTGswbEdDVUd5NzY1eFRhZTFnS3kxVXVUNERBWm5NMTBxWmg5?=
 =?utf-8?B?TFBScHdTRDQ5czFGUUtkMk1KSFpBY3l5bWhyQ1N3cjZWUG5OSVlVWHhFUlR2?=
 =?utf-8?B?T1lyVXZtOUkrVDdSNXluaFJHQzRhaC81OEpOcitFSTFWVUdqd24wWEthQ041?=
 =?utf-8?B?YzJiVGxiN0drZFc5Mk9qK1lBNG5qNWRQM01uK2tha3V5WVB0UmF2bTY2eDJJ?=
 =?utf-8?B?VlFPYzdWQldsT0krUzh2aHV3aHVHanVmZmhVM3Y1M3RtVmZxM1QvenZ4elpo?=
 =?utf-8?B?dEUvNm5tbnZCT1VyNTQ4dFA3QzZETjZKR0pmdWx5V21Sd01qbk4vREZCUTVm?=
 =?utf-8?B?SUE4cDZHV0RsYlpoYXFZbXo1NnQ4cmxjRlp2KzExR2V4WEhzK2kycFNQRzhI?=
 =?utf-8?B?OGtVSXdoTjlTRW5BazBjR3dYbTFiWUJjNGtPek0vdmxPQVExalhnelN5aXZt?=
 =?utf-8?B?WlMvWkRJVDJsYkZtTlJDZm9xM1pYNTJtL3NhYVc0VXVyRWlSZi9qdWVIMmZL?=
 =?utf-8?B?V1lSZ2hxU2hkV3VNZmdnN1cxZncwcDl3RTBYbVB0TjdXOUZHN1NoeC9saG16?=
 =?utf-8?B?Zm1kd0k3eVMwNHVNaUd1QzFOVkNyQWRXT3VPZSsyYWJKK2hpZVNZaHpiblZP?=
 =?utf-8?B?cHp1bkpCVnNlWmdqMUlkVVlMYVJHT3ZTOEVzU1RuM1g2UmNKWkd5aEVaQmJJ?=
 =?utf-8?B?TVg3dWRPZ29pMjlzMElmTzJqZ0tzN1Yzc24reUxucVhFaU1vc0VEbjVTQzRx?=
 =?utf-8?B?VmU0eTRWTkJBRW1HcmhrS0l3cWFtS0s4cjZ4bTdqbU1BNTV2anBvRWpHYjVO?=
 =?utf-8?B?N0ZOcEoyQ3FEUTc4YytRSGUzTEhRdGFJb0lRUEQxRXFpckdpb3BmTGYyZ2Jy?=
 =?utf-8?B?VWtDRmZQSHc3YXpZQndEQ1FwRGRMY3JyWjMyb1FiOFNWK3dlejR1Y0RLRmpj?=
 =?utf-8?B?S0ZtVkY3OG54eFdXVHZuWlBjaHVLUHVDSXUyczdPS2pITnpiNFNBNTJJemFl?=
 =?utf-8?B?d1ZOT3pST1c0TTBiclk5QVEvVmwrbDhaWkJyV0tpd2xlNENJWC8vMFdNdEtU?=
 =?utf-8?B?Q0lwSnBTNjRCYlhpVEpHMTFZdXVMVjM0RUliN1gzQ2tvN2ZmNWUxVW16aDFl?=
 =?utf-8?B?eE9qaDRMWXNPZ2pBeUtmWWFKVjJEZE5mWTcwdS9RbVVjQnNFZlpsMHVtMjJT?=
 =?utf-8?B?Y3VGejFqb1pKWFF6NzRGTnJLYlNBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc688b6-6e9a-453d-e8f6-08dc59593696
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 12:24:48.3642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00siGWlCyLJ7br6OD6T1fzVeme0y0jWNB03hh8/F0aygJxaqNf0QvUBGk+8G27aB2pdLR8PdpToEOmFGZFQa+ygvl9tqFgD6bpgzzyZP8SGjAMhSScF2oDB10pprC7cI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
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

On 4/10/24 13:11, Rasmus Villemoes wrote:
> The DT bindings for the pca953x family has an optional reset-gpios
> property. If present, ensure that the device is taken out of reset
> before attempting to read from it.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   drivers/gpio/pca953x_gpio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
> index b0c66d18317..24b0732f89a 100644
> --- a/drivers/gpio/pca953x_gpio.c
> +++ b/drivers/gpio/pca953x_gpio.c
> @@ -306,6 +306,7 @@ static int pca953x_probe(struct udevice *dev)
>   	struct pca953x_info *info = dev_get_plat(dev);
>   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
>   	char name[32], label[8], *str;
> +	struct gpio_desc reset;
>   	int addr;
>   	ulong driver_data;
>   	int ret;
> @@ -321,6 +322,13 @@ static int pca953x_probe(struct udevice *dev)
>   
>   	driver_data = dev_get_driver_data(dev);
>   
> +	/* If a reset-gpios property is present, take the device out of reset. */
> +	ret = gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OUT);
> +	if (ret && ret != -ENOENT) {

This seems to differ from the implementation we have for optionally 
getting gpios by index, c.f. 
https://elixir.bootlin.com/u-boot/latest/source/drivers/gpio/gpio-uclass.c#L1498

"""
struct gpio_desc *devm_gpiod_get_index(struct udevice *dev, const char *id,
				       unsigned int index, int flags)
{
[...]
	rc = gpio_request_by_name(dev, propname, index, desc, flags);

end:
[...]
	if (rc)
		return ERR_PTR(rc);
[...]
	return desc;
}

struct gpio_desc *devm_gpiod_get_index_optional(struct udevice *dev,
						const char *id,
						unsigned int index,
						int flags)
{
	struct gpio_desc *desc = devm_gpiod_get_index(dev, id, index, flags);

	if (IS_ERR(desc))
		return NULL;

	return desc;
}
"""

It seems we only need to check whether rc is non-zero, but it doesn't 
check that it's not ENOENT. I think we would benefit from having the 
same logic here.

Also, maybe we need a devm_gpio_get_by_name_optional implementation in 
the subsystem so we don't have to reimplement it in drivers that want to 
use this?

Cheers,
Quentin
