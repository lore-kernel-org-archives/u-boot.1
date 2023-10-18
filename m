Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AEFCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CC586F2F;
	Wed, 18 Oct 2023 09:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ECRoEABO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967A38669A; Wed, 18 Oct 2023 09:43:37 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0723.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50628863F7
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCeYjVeQ8JgiUgeIxeIj85hU1kLPozoe4cAVFNleHJIqtouhl/C1t8/jDFbhPDs48yznU7/dLpmRPukQxlMIgHTiryGVrCMdRmKrGqGcjxv7fuCqtk++8jfbw3vmpPGzv+rPEy339Ycct7u80m8Mhp3K27NhuBgriikgJxEMwdAptgaw2LU2OcNgHS8iMHKcTm9TJXnTs5ZeNe74ota0dUq//FPAv5tDwBfXAMoYHfOoshqao1Yyt/KKnBuuP3aTKgDUvbJGgKWsCD0uaYaXS9ooHDXetTY2RZI4M3uUw8QAvxUmFyybUPrphXdPKfA4CglMDAqTGjWbi0A4nNRmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IabgCfEO3BZgoc1+89uDDvvu4rCjJ6H0dvd7AmGlVAY=;
 b=UH+JUXD2nJ0X6XZ0QeYjjywoMwVeNZXI1ZwWusJhj+RyLC64d2pcXLb3VWOBYmFw9W0yNCALln5vFuohhorl96Jpy4v2E98h6sJQT+NzNlZ4LoTWEww1MPmlXFcrPprKE9Fg+9LfTX703FQFt7aAAWKUYB/RBl0L6MaOeLhC7uyFCPDB7JZZ3Zl5BOW/zXk54l0c/r4Fdhae2yOJsXDaqGfwUcPoExOIebtz7rd5pBX3rK9ZiGP1wySRwUG3llo5PA2YIhe2YEbASqqsC75u1CYhDy8Ph8bNe1HjhDcylMGfVksXFTjvmC0uRtM7gzsn9XPFG10kJtlZpFc+e1pR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IabgCfEO3BZgoc1+89uDDvvu4rCjJ6H0dvd7AmGlVAY=;
 b=ECRoEABOfmn3+lgYAF6wzm+4lES8L4aJRAA+nfybTXg+EKPC24ClROJzkNr46oHpM6uxZ2Rf5KsBPpZh0KEUjws9AP+Ibc7sM/DWsw3m4l66hM7duCCLOhZ3d63yR0SE87aGZkVhp3R/ZYgJGSuJijhiYDeXF5jipPCE3RnNu9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DBAPR10MB4106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 07:43:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 07:43:33 +0000
Message-ID: <83bff57b-6d1e-4e31-9286-f32c60d6b052@prevas.dk>
Date: Wed, 18 Oct 2023 09:43:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: commit 83c63f0d118 (led: Move OF "label" property parsing to core)
Content-Language: en-US, da
To: Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
References: <d588fefd-45ec-4642-bf6d-73fcc652591d@prevas.dk>
 <485cdc88-6898-43b9-9079-f9fe58e26848@denx.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <485cdc88-6898-43b9-9079-f9fe58e26848@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0036.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::49) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DBAPR10MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f92415-11d7-4c9f-07e7-08dbcfadee10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JQ1QS5JM4iNtFeOs0kwu+kyA4r6k79R2tS/OqxMiD/ofSopG9zMDtr3oqccYBg2cG70JVLiYIwK6ObJtT/A5nbxEb1aIgCNOWScATYu2rD5f2IM5om01grYVTGPRq1WFJyGMCfH32mKuzkpE1bYL4iPWSh5d+nczPkR30vMD8tPkjRojHs3ay16VC2emWeOi0EDAp/VcWiYLVd8Pqufu0XU13NVJ/I9540WNRhd4is3ki3rsGXs1+PysA2BdAAaiJc5Hfne8U3uBVmKhqDWP6OVXl3rrMfZirDyMTjuWVqxyp4aa2bHVqSpbCeOjsg5bsgeBuupq0F1nyGNlJI6juJ87bX+QJL9+sPBcuX1I05Eb6+nm1GMWg+1KUFln1aiFZIonUlL0J01EBA7kTJFp1P/M8Onl7iLehmstSrS+4hXHmnKhuw7PB0uvN6r326FyqqH1uYGZkgTFGAjwoxRcUnJwHRZZTRJwwGdCA2Cit8MNONmDw2GKM/ZPoWjbqDiuS0uosC10aPlef4KPWQfBaSYATooQ0wCHhdiu83835gQK/qIEKnVehemvMNh/S7rf9lOWN3y8CiOEELlfAmydVSxtstDSYPy+JkxC5kntCFU9QyATSPNVvQYtEaONJYtetU/YG/yhD50FisKU/BjmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39840400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(316002)(66476007)(110136005)(66556008)(6486002)(478600001)(31696002)(2906002)(86362001)(5660300002)(36756003)(8936002)(8976002)(4326008)(8676002)(41300700001)(44832011)(26005)(2616005)(38100700002)(31686004)(6512007)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVabmRNNDU3Z2d4U21qcFNPNXRZWTJlZXhTbEJ3a1FvMkFGdGRkOS9iODY3?=
 =?utf-8?B?UDYzTVk3eDdQOXlzKzdiQ0NNbG4xR0xRazBRT3g0VnlYQnI0VFFHRVhLN2hH?=
 =?utf-8?B?RGJBMmN6b1VrbndVWVlCRW1qM0RyelB4elAzY2UzQmtyYmw2bk9FaGQ2WXRo?=
 =?utf-8?B?VjRkZWxnZE9mZGFxUy91S1hvdWV1Z21VREd3NnRDQjZKSHkvNXVnU1FUQ0g5?=
 =?utf-8?B?cVJaY0duVWhWTm1tNVVzRzJsaUpTcldTUllaOGZpRit0WU5sdGNuN0xUUm9o?=
 =?utf-8?B?MjFSemtHR084MmVjcS82QmNGSC9ON2pKMG1jRjBOeUgvM2xXUGZBL2dXNGlv?=
 =?utf-8?B?UzhLL0kydWQ4NFlvQ2RUUTNhbC85SEUySDRRYjhGTlhKdjU5OGJreS82bXgy?=
 =?utf-8?B?Qi9WMjEycmRLQXB3T0tkVWxwSlFqRldLQWNVRVNUMFJCUzBYMlB5YTFvaW43?=
 =?utf-8?B?V3dMU1pKMEwwVWRvNk90QXVadmdNaXNuM0FieFR2SFdLdjhqYmhheE1DWDBH?=
 =?utf-8?B?VHliN0hsa2R0T0FMdkxYSDdXSEFpck9DeDJ4ZG9GZEh0MGVoODE0WE5kZzJV?=
 =?utf-8?B?QnUxVUNXdnovc3hhcjdKa3lzQXdpY1hvUzE4eFNaQjJiR3NIVXZRd0hVNGxF?=
 =?utf-8?B?VGxiY1lxbUJsUTh1SGplWkNFa1RwNEZndWNWRXplZlJuL1Q0akp6aUo0Tjl6?=
 =?utf-8?B?RTBvWmNRRzlxVWxVZHgxNlNyUE9ZUGtJdzM2MWdRK1dhU0crcStjQ0p6ekNw?=
 =?utf-8?B?MXJwTFpmVHFFQS9JRnNWZHpXZlZleVZPZVZDL2ZsVjhkR0JFOU5NS0d3MWUy?=
 =?utf-8?B?VkFjc3E2Z2RhRjkwUjRJTTFpRE9tbExMTENpL3JuLzk2WFg1NENpRjNhSmxu?=
 =?utf-8?B?TWtSVGdCeUJQeUJiZHRTd3VUVGpmaU8wUEpaQ1Z6a3BDcFpEZGxIcFhOMzZJ?=
 =?utf-8?B?dXVVcnI1WmtoVWZKYWQrSWd0N1VmU2FYVEl1K2FCbVdtT2VKYjl2NDUwSXJr?=
 =?utf-8?B?NndwVFpudEF6ZERQMTVLcFFVYUpFZGlwUDRtZXBZRDdWUTM5UHJLSFk1aXdn?=
 =?utf-8?B?MFJnZWhjOVFKY3dmOU94dE5RU25ueUdXRGcwamJsTVY5dnBxL0R1SVZEYSs0?=
 =?utf-8?B?NE5hVFN3NFFsVE45cDFrVUNqYnlsZUxnM0NhdFA2bjZLbFNiRkZaQUdydTBu?=
 =?utf-8?B?QUNHd2tZOWt5QVR4MUdPbGh2TWFwVGp4Ly9mM0dEeXhRa01Fem14MXZLOGt2?=
 =?utf-8?B?dWozMkpKd2VONFVDNHZWRUhaMjIySVJaOXVPWXl5VGI5OURwU3FpZ1o1eGhr?=
 =?utf-8?B?czhFakxBSmFvMGd0ZnpHK3RrbDEwZ0taWUVNWGRCY2pBNFFGTEg3OFBraHRZ?=
 =?utf-8?B?YkNjdzdkN1V6VVU1TjlnZEIzRkVGM3FHdEtSRjhvWVRxaDd1YnQ3U25KSU5h?=
 =?utf-8?B?TWZJY0ZLNE4rSlVmbzI2OHVuSFh5aEdGdXFMUUxSZGkxWDZuQU44VzBjaEk4?=
 =?utf-8?B?UXMwdjk2bHJidW40VXlQMG9RbThDUzhGdC9lTlpBV1ZZYitIZnZlc3BUVWV0?=
 =?utf-8?B?dm1NTVZsVVk3U25DOVkvR3Q0N0dscWJyYkQ0Snc0dVBHWXNYMkRFNE04MVla?=
 =?utf-8?B?MjFIa21ST0U4TE5PZm1OQS9QSnY1d3hmd0dUV0luZ3FqNUxGMlJHc3lIRUxy?=
 =?utf-8?B?dW1LakhISDJVUThBSnpLVndkOGhrRXBtMVNQb0l1UDk2d3hNdWpQWTVIUlpo?=
 =?utf-8?B?bWVOeXlsOEl5NmNYaWJDblJ5UVI5Nm41SVVjb3ZrWWhsZDJVd1dvVGVtalV6?=
 =?utf-8?B?a3Uvb1FVNTNVTUNYQ0dFU1hHbXpXbXlyU08wT3JNQlFXeTdIUytLam1CWThu?=
 =?utf-8?B?UmRQUjFiYU5KYWx5UldvVHU3V0JudzlaTnhmWDhKeXljcXhwcytJRUM4STF0?=
 =?utf-8?B?bnBoM1dHVlhQdHZ4SGxFMUZmOGxIV0tPMXdOenZIYmFLaUFqV2p4dlBPb3pB?=
 =?utf-8?B?bit0VkNNQnFzTVNQVHNnQVBWa1hmbC9BbGRQcEVEQTRHTGFoTWZGdk9ma3hP?=
 =?utf-8?B?d0Ixa1FFaDdhNWI2cGNGYW5aclVYZWUvZTU0RUJsZllMd1ladzlQY3pBQm80?=
 =?utf-8?B?SjAxcDVnQzZ3UTdhU0FWZXJRaE5jWlM0WjBTRGVDdkhadzRxVVM2VWx3WFZr?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f92415-11d7-4c9f-07e7-08dbcfadee10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:43:33.4299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkoU8DS1RwT4FdLqCQPcGBddCTwKydwTWtQRQ6qcl78s13s5rfDbuXDFfiFr0FLrZyAqh/DSbyDuTEGPEGum24klfau5HvVK1FjAq/6V5+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4106
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

On 17/10/2023 17.33, Marek Vasut wrote:
> On 10/17/23 15:29, Rasmus Villemoes wrote:

>> static int led_gpio_bind(struct udevice *parent)
>> {
...
>>         ret = device_bind_driver_to_node(parent, "gpio_led",
>>                          ofnode_get_name(node),
>>                          node, &dev);
>>
>> static int bcm6753_led_bind(struct udevice *parent)
>> {
>>
...
>>         ret = device_bind_driver_to_node(parent, "bcm6753-led",
>>                          ofnode_get_name(node),
>>                          node, &dev);
>>
>> and that string can, if I'm not mistaken, be gotten from
>> parent->driver->name.
> 
> Which string ? The "bcm6753-led" is driver name , so that would have to
> be parametrized.

Exactly. The only difference between the two examples (apart from the
scope of the variables) is the driver name, but I think a
generic_led_bind() could just do this inside the loop:

  device_bind_driver_to_node(parent, parent->driver->name,
                          ofnode_get_name(node),
                          node, &dev);

and with that we could have most, if not all, existing .bind methods
assigned directly to generic_led_bind(), we don't even need one-line
wrapper functions in each driver passing that string explicitly.
> Make sure you test the 'led' command. The LEDs might be bound, but not
> probed (so label parsing in LED probe would be too late), and if I
> recall it right, the label parsing has to be in post-bind for the labels
> to correctly show in the 'led' command listing.

It's the led command I'm testing with (with my "new" driver for the
lp5562), and where I see the problems. Currently, the top node also gets
listed in "led list" as led-controller@30 (it's an i2c device), but
probe of that device fails because the logic in the .probe method thinks
this is a subnode (the pattern is the same as in e.g. cortina_led_probe).

Since I'm simply copying the pattern from existing drivers, I'm pretty
sure those other drivers are also currently broken (see also the fixups
I mentioned).

> I am all for generic_led_bind() .

I'll try to write some real patches.

Rasmus
