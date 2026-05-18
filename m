Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DCBCD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 12:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1275083EF9;
	Mon, 18 May 2026 14:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IVPyfhyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF3C84150; Mon, 18 May 2026 14:00:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A0D803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXCBe5voKeikBaUtyTiU3Qz/mYNbP7PcVqFrvE8/rKHZOM8sDYfPj+ZWh/SiPs0fwvRwAQk4JRfni9w1AzUXX7DW3wFOoARW300KZuNMLyb4xDTHMhyCj0bXyexVAQKst1zN7U25kdVzjNC6317s/gcg7cxtWL0+myOgphVcMOI/t0Txd4KW4+QNcNACEZ0ADWpzaCIfymrV2kc3DoZOEzzKI+jYXV0XuHtggJTOyNUMhYat9c66mr+VLHimHZ7Mlze06MA4NbXp7bTcU/+9HAJazp3wWwzmMrIpR6koYPj6HjewbKhcG9MN7jqCua56QCbLX4aSheHNP9fgzykfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFeSR1vNBHAeHYlr9ZeOr5JOhh1fzx5qAUNCDyCNrPU=;
 b=lmUuG/MExcpRko2IFJi4tmyhSddd7F1tEzBEwteV9n65J7sXjTHrIkS9zwMHivQduTxnFoyciK9+HvGp6Ma5N1ScZTgah8P4Q8GahwxVdyge+kUsO+QVLSYsGhIUW89JZz9MdJtB0CZJ0FQOZ0mgt1WRdr+iMwfV3/du2Ms/fp76PA8yNCtVS2rfT01gtE9qnvH+oMiJhYoXI6tK9LE8AEHo71Z/VuicpA2CnOTNnEAWLK3aaXAsgfdMyj8OM51Eb72DkfR7UvU0OKswBfJEyJmyS3tyjFjHcnykIhOijZV1VPBvzElDaiLo6sgM9tjYs98aN2mBwZISbJ6Dfuc7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFeSR1vNBHAeHYlr9ZeOr5JOhh1fzx5qAUNCDyCNrPU=;
 b=IVPyfhydZpqECR5Hbg3ve3OyMngwGxKJKOspVRXzoeqKoQMBoAtOvS60IbIsjiea2gdGVH9Dj9cmjKBdRR3TK09hQczw9yjGEixxuc3OCg19+POpoNDaaJR6olqmEHsh/jEAqxza3e+oIOhVHnG+Ntpa96kWe5JOdnVnl2FLAuRP+2CS6QqxAsi+lUYVLwV0KM/BMsieTDU5gH+Epi/q7F9oYte7tJwCobVdg+Djyb2ZfY1Hg0KrCQWG9qt1aaXc7vgN8K7o61a+oOKhyXTMJDHepohhGE+Fryx2DZSN2LFH/hgvRrhU2bVjspF2EdNfcGxC2Jgy5d8HtCcTQ7NLRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by VI1PR04MB7136.eurprd04.prod.outlook.com
 (2603:10a6:800:122::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:00:12 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 12:00:12 +0000
Message-ID: <93fcc50e-76c7-4894-a39d-485013ef3b00@oss.nxp.com>
Date: Mon, 18 May 2026 20:00:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix power on/off delay issue
To: Peng Fan <peng.fan@oss.nxp.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Ye Li <ye.li@nxp.com>, jh80.chung@samsung.com, peng.fan@nxp.com,
 festevam@gmail.com, uboot-imx@nxp.com, u-boot@lists.denx.de
References: <20260511074953.3777767-1-ye.li@nxp.com>
 <c60ea578-30e9-49c2-8d45-0731b9fd74b0@kwiboo.se>
 <32618820-7e62-44d0-bbbd-da90be7327de@kwiboo.se>
 <agcojGdjiWq8B25L@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <agcojGdjiWq8B25L@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::35) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|VI1PR04MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 820addef-b04a-4a44-9482-08deb4d503e3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|19092799006|366016|376014|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: rs7ma0QJG1K7I2HCx6VU38i7vQcJjqMKVF2uuNXSYKOSL8vCJK+gB39nKuvLfoJkKgfbN2xe0KcWsXo2hiUSBczAG4Ur3DN4SSgN+r0xTqJQyu170ojz6Ze8Ni4qhzynpCfr8NWUvz2LRaBETp1lfc3otUVncgVimJvzNvPc8wRIAGV/02bOi6FT+ZwztS60SlR5ypQvIRJLFrULPOg71vcR8FFGgmilUWIH8CAMtTkuhskCVCeZ/15HsVhH6fnMMaGMSWWaWYrsF/pK5vEUXmhuAik3tK7k8HbCIqX5Hw9ZBtiD5oODGTXmqhAIk2td/JlrlkZGQ0FU45rpIVud+zkSPIJqTsUO0khj6q29Bby7F1a5N30E5CCFcyxuDtLAW6SWHKhptDc8WrLPw+9EODkr9uAJ2vGmcchfsmtczkuw/yc95UBU7ddP1q6Q8NL+dm3E4LnmCu9bU6VnomihEKIq4ESA4oHbjhWzEvPVaYrUAX4J1wJ8IavnAgB6DKVgM3MTgIWOzyH6zZV5OFnMX89TjQi/nALx3u70JRp4B79bgQWbpaBTds8R7kpy9XCvK7MHv2CsGjY8AIqQ5tpleGsu5wGCB4PicL0n7K2iCgax6m/uJpFo5F1Uxn+Zr+NOeGgGqwX74+3jwMI8JrzzEj34QUJDfm944l92xUedH9c59Relo17aIx33T+bA/llN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(19092799006)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnRZazh3ZW92bHd6dGtKWVo0cUN4T2hRdlZWNUs2NWtzR2p5M0txaVJmaU5W?=
 =?utf-8?B?OTNMRDk0VVV3RHN5WlRzMHZCQ0NFTWI0dm9xQ1hNdVY3bWpyRE9vL21Uc2to?=
 =?utf-8?B?NHpkY0NFKzRBYnhacEp0QzRlRTV4MDlYUFN4Z3hpRU50SS9INVViYU1SNjU4?=
 =?utf-8?B?ZlJGTXVQSDN4Wm5GWXhuakg0NVVDLzNvVnNJb3Bnek5WUlF4VG9RZTFlSnlW?=
 =?utf-8?B?ODJwUkcwd0Q2SlBtZm1aU3dxVU5oTjBScmpQTEd2MnJkcC9DekljZGR1a0RX?=
 =?utf-8?B?WEdmaFJUNkhudll1UUFYcGl0UkpmUzExMzZHdUVvSlFhaXA3WlpOZnp1ekRZ?=
 =?utf-8?B?WlVXamZjY1NmekFzK2Y1Mm1VbERmSjhYRHhRLy9UdHprajh0dWlIWWdZVHQ4?=
 =?utf-8?B?RUw1bzk3OVY3aU5NWXRtS1JFcE9UZnU3TE8rZEEzTy8zYXRRLzRIcUNBVXlQ?=
 =?utf-8?B?YkdZVFplZk1WamEreGZOTDlvcG9najh0NW8yOFhiZUo2S1lOT25iWThlanhi?=
 =?utf-8?B?Q3JSZnlqSnI4d1hLdDBMeVRVbS82NGlLOFBzYlA1RUoveWxTVk1xcGduWWZy?=
 =?utf-8?B?M2p1RTZCRGQ1WVlJd2NBNEpZMENJKzBOUk9iR1gzOFNsTkpscTVCQWtpcE85?=
 =?utf-8?B?c1RRcUVPRm4wNnplOTQ5UmUwQzdWWUdQeG1ReUZEU1VNUnl3bjdScjZkV2NW?=
 =?utf-8?B?R2Y0SjFaR3p2N1hsSExTN01kVzhIL21UeUtUTFd4ZkJaWk01NVhyRDJrenZW?=
 =?utf-8?B?VWk2UWhoT0xJbW02L1NhcFV4czArcnhnVzAvZEwwdVhQNmJVbTVpaWRqOWQx?=
 =?utf-8?B?K1RZL283L0lmR1N4aWFNSG45SjJNZHg1WlpkYjk4aXZ4NVVXa0VIeE4yMkU5?=
 =?utf-8?B?ZW1XWnlZVm4rZURwM3UxTFc5ME1EaFAveC9wSnBGOWMveXFMeXhETXd3NDJs?=
 =?utf-8?B?bXQ2MUROMEUyN3ltR0s2VzNLUDJ6eENrbXBWVCt1YkdaWUFrWmFuR0hzcDN4?=
 =?utf-8?B?SGg4akI3dXJHeno4em81b0dmN3BqVUtXN2hsdkJQRE9ndllZSDhCeFpUeUNK?=
 =?utf-8?B?WSs5YjVWS3B5VE1LK3poT1pCcWYzdkRjQzJ4T1FDY09uZ0VNcmxOMnZ1SGhV?=
 =?utf-8?B?QzkvV3RiU1U0MVJuZGQzNWlyaUlRVllyaElYMm5ZOHU2TFAzVm5QUlJ1TFBF?=
 =?utf-8?B?bW5PL3BvbThvanVoRzBTN3F2c3p1dWh6SmlXYnhHRW4xYVFKVms2ZE53QlZn?=
 =?utf-8?B?NTFKeGZVbEFoOXJHYkUzck9SSUtXNDBNYksvbVBEVWhPSmJpaXJSQjRIaldp?=
 =?utf-8?B?YkRGK3NFWWk2YitBNXJmQ3BHRTI5RnQySW5ybWcrWlFta09RajZ5cm5zd1ZP?=
 =?utf-8?B?TG51VE5pdjBVVHZNc2kzOFFERnJHdW1FMGlNbXFwZFhaQTFNNVp6VkRtYW9N?=
 =?utf-8?B?YUkzTlJ1M2FtOVplU2hMMjJGR01FZk14NHZFdUxocE5jTUNCWHliNXI2azZn?=
 =?utf-8?B?MWR3K1Y0S201RXo2cGE1NEc2ais0cGtGdy9NcURZYVBBQXFXVGNyZ2YxelM5?=
 =?utf-8?B?TzBWc2xGY1FDUGQrWXpNOVdndDRnWkw3aEZwdUQ1b3FYc0EwdWptQWtPSzdi?=
 =?utf-8?B?YjVFTmcza1hmMTI1czZFM1oybTk3TzF5NlBRcWtZQUxIN0VJOTFFUnNtV1Zl?=
 =?utf-8?B?R1ZMYnVzRjlRQ2luNG8rSi9kOU5kU2FrTXVNYzBxZWp4cmMrUG9kME01bWQx?=
 =?utf-8?B?dk15bVdxMHhFS2d5UHdNZzlvdzBhKzJNQU5DQVplN2M0eHNYc1k1cVZSZWtN?=
 =?utf-8?B?ZGxCVkZacXhEK3VQN2YvelhFd0FkbXh5N2VUc1VvcFpGM3dNVTlURE5BZnFo?=
 =?utf-8?B?TU1zQTNRNDA5VU9qNmdnYVdFN0ViT1RuVDdlZUppNEFyM3dOZ3oycHphU2tK?=
 =?utf-8?B?YWxiV29tcGpMcDFpQzgrNlNocmw3dDRSTitnc1hlUWE0VG0vOWNkSFFCaGxH?=
 =?utf-8?B?YXA3RFVleGsvcmxOeExEUFVHejVyY3ZpTFhrVUNDOU9Cc3psWGhaMVVTQy83?=
 =?utf-8?B?VU1YY0E3bnE1eERVZW1TN01SOHdlTVpsOEJzeW43WEJqQTF1SElwbTNxazJJ?=
 =?utf-8?B?Z29VVTFZRTdSVDNrY0hISFNzWEdlYzg5U2NPOFJFYUJ5SVlnbUNmYlI3azE1?=
 =?utf-8?B?V0F1QmFzUG85MnVpZVYySzgxTmpaQmxINUcvNklvK3ZLQTJqWktPWkFaYThN?=
 =?utf-8?B?SXNYQXUwbHhWQ1Zjbi9hbkpNZkxURWt2ZDBwLzN1eVoxQVE2blBWZmp4ejdW?=
 =?utf-8?Q?K3YKUKwhWHk9F5W+0+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820addef-b04a-4a44-9482-08deb4d503e3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:00:12.2011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE/92qtTnzLlS0nZQHXscVQPV2R5/bjDEHuY9hsCZrKi5RiZLx5lddR6KPF/jA5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7136
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

Hi Jonas, Peng,

On 5/15/2026 10:07 PM, Peng Fan wrote:
> On Mon, May 11, 2026 at 03:10:16PM +0200, Jonas Karlman wrote:
>> Hi again,
>>
>> On 5/11/2026 10:30 AM, Jonas Karlman wrote:
>>> Hi,
>>>
>>> On 5/11/2026 9:49 AM, Ye Li wrote:
>>>> SD initialization failure happens with some UHS-I SD cards on
>>>> iMX8MM/iMX93/iMX91 EVK after
>>>> commit 4fcba5d556b4 ("regulator: implement basic reference counter").
>>>> When sending operation condition to SD card, the OCR does not return
>>>> correct status. The root cause is regulator on/off delay is missed
>>>> in MMC power cycle with above commit, so SD card is not completely
>>>> power off.
>>>>
>>>> When SD startup, the sequence of MMC power cycle is:
>>>> mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
>>>> -> mmc_power_on
>>>>
>>>> Before above commit, as a fixed regulator, the GPIO is set as:
>>>>    GPIO inactive (in mmc_power_init) ->
>>>>    GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
>>>>    udelay(2000) ->
>>>>    GPIO active (in mmc_power_on)
>>>>
>>>> After the commit:
>>>>    GPIO inactive (in mmc_power_init) ->
>>>>    enable_count is 0, regulator_set_enable returns -EALREADY immediately,
>>>>        so GPIO is inactive but No off-on-delay-us (in mmc_power_off) ->
>>
>> If the regulator is off at boot-on then this is working as intended.
>>
>> However, if probing the regulator turns it off and that requires a
>> off-on-delay-us delay, maybe you are missing a regulator-boot-on
>> property to indicate that the regulator is on at boot/reset. That should
>> also align the enable count with boot-on state of the regulator.

This regulator is on at boot-on. But there is no regulator-boot-on used 
in kernel upstream dts. This will require to add it specifically for u-boot.
>>
>> Looking at the kernel the off-on-delay-us is applied before a regulator
>> is enabled, not after it is disabled like in U-Boot. Maybe U-Boot should
>> do something similar, in simplest form always udelay off-on-delay-us
>> before the regulator is enabled.

Agree, moving off-on-delay-us before regulator is enabled should work. I 
will use it in v2.

> 
> Yeah. Something below should work(Not tested).
> 
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index 85af8d599ad..7bf25f6a176 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -68,6 +68,9 @@ int regulator_common_set_enable(const struct udevice *dev,
>   	      dev->name, enable, plat->startup_delay_us,
>   	      dm_gpio_is_valid(&plat->gpio));
>   
> +	if (enable && plat->off_on_delay_us)
> +		udelay(plat->off_on_delay_us);
> +

Thanks for the patch. But I think off_on_delay_us should locate just 
before calling dm_gpio_set_value. Will send it in v2.

Best regards,
Ye Li

>   	/* Enable GPIO is optional */
>   	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&plat->gpio)) {
>   		/* If previously enabled, increase count */
> @@ -97,9 +100,6 @@ int regulator_common_set_enable(const struct udevice *dev,
>   		if (enable && plat->startup_delay_us)
>   			udelay(plat->startup_delay_us);
>   
> -		if (!enable && plat->off_on_delay_us)
> -			udelay(plat->off_on_delay_us);
> -
>   		if (enable)
>   			plat->enable_count++;
>   		else
> 
> Regards
> Peng.
> 
>>
>>>>    udelay(2000) ->
>>>>    GPIO active (in mmc_power_on)
>>>>
>>>> Add the on/off delay and startup delay after GPIO request in
>>>> regulator_common_of_to_plat which is called in regulator device probing.
>>>> So in mmc_power_init, after GPIO is set to default inactive, the
>>>> off-on-delay-us is applied.
>>>>
>>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>>> ---
>>>>   drivers/power/regulator/regulator_common.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>>>> index 85af8d599ad..158284a3309 100644
>>>> --- a/drivers/power/regulator/regulator_common.c
>>>> +++ b/drivers/power/regulator/regulator_common.c
>>>> @@ -46,6 +46,12 @@ int regulator_common_of_to_plat(struct udevice *dev,
>>>>   			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>>>>   	}
>>>>   
>>>> +	if ((flags & GPIOD_IS_OUT_ACTIVE) && plat->startup_delay_us)
>>>> +		udelay(plat->startup_delay_us);
>>>> +
>>>> +	if (!(flags & GPIOD_IS_OUT_ACTIVE) && plat->off_on_delay_us)
>>>> +		udelay(plat->off_on_delay_us);
>>>
>>> regulator_common_of_to_plat() is for parsing the values, no udelay()
>>> should be applied here.
>>>
>>> regulator_common_set_enable() applies udelay() when the regulator is
>>> enabled.
>>
>> Or disabled.
>>
>>>
>>> Does your regulator .get_enable() ops not being called or does it not
>>> implement its own udelay() based on parsed values?
>>
>> I meant set_enable() here :-)
>>
>> Regards,
>> Jonas
>>
>>>
>>> Regards,
>>> Jonas
>>>
>>>> +
>>>>   	return 0;
>>>>   }
>>>>   
>>>
>>
>>

