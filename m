Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2E2C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 17:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816A48786C;
	Wed,  6 Mar 2024 18:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="n+rCUvO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56AE87BA8; Wed,  6 Mar 2024 18:04:10 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484C387150
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 18:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC7hMhkozE+d9Z1LVAgmtpjscbotH5enSkTlQJb+qRuKVIJUfe4z0OSWDMt/7hmsYyaAuqlXqaFiwW2CmHSUoVIJLu2xDYq2J7ad8ugemT7xJgx+3Q41evOyHuuTPg1vapYi9fNtAnnT0s6UG1mZs/RWcNNBO8UhRglFSroYcwbM62inVvCSpOl/qveRE9OXFUCyI+4wJ7Q9TKTCYvS1jCS1UmAFZBQzCS8/6pphLiESH+fHkJB28OFmIyxKnNgp1FMqOzMM8XHR8fk38gXdWvcinSWwILoYdT84C4HITdoZfZeWr/TQYSgTxldCUF6+50gBPdztftXpwbnIGVVLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVyGGI8ocIP9AFfKA52msEGjdTKP6w62tSLbAlfLF/M=;
 b=QRXQ4lFCN6lHNlvYueLGZMX7SPjG0EoCgDYSgJ+o/k6Ftu5QUjZAS2tmFnKMtom9R+cciE2Cq7gaxxELnIKx7TiP35PICDL24E3wPDAGT3KdQIbKIdpjwh0BjdXxy7PydqP7fKzyQIbq5b9dV5f+53qYl4shKRNa1TDa7GBs1lnAjamOTkvMP4NQQi7H9sUiZMl4pzGOu+JAFvxhOpXQW5u8kWWH9w8wKw0jcWlPlMLhaPpp1Rx/AbG2PlZxqcL1XA5gYrfBdR7fc/1Vsg9oZef4shMuQ1SOpEuZ22Vu6CZ8/WuHSnZaQRElhf9hWKw4w2xP47bTsMhhUQyr4lQAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVyGGI8ocIP9AFfKA52msEGjdTKP6w62tSLbAlfLF/M=;
 b=n+rCUvO9JCT9YYSR38rYe1u12BoarSwJzqQ5b2p5ImghUiRqiZSB1dMC+EoSsErUpaGZzyhJyjqHLJCH9D/uyDTBspLYcecR+AbidXoeIKUm65EAH6lfp7lmJPvV+WPw9EqNk0zAGZSBVsvCmOo/WcFqQgPF5cmMzNEs6A9k9e8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PR3PR10MB4031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Wed, 6 Mar
 2024 17:04:05 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cad:3fbb:8707:8ca5]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cad:3fbb:8707:8ca5%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:04:05 +0000
Message-ID: <1c24b5e3-880b-4abf-97ec-3908a0b2eab8@kontron.de>
Date: Wed, 6 Mar 2024 18:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Introduce mtdblock device
Content-Language: en-US, de-DE
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "bmeng@tinylab.org"
 <bmeng@tinylab.org>, "tobias@waldekranz.com" <tobias@waldekranz.com>,
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>,
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 kernel <kernel@sberdevices.ru>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <985f8309-7622-40fe-9352-36cdf7853556@kontron.de>
 <20220922220252.2r5ldxs626lqiwos@cab-wsm-0029881.sigma.sbrf.ru>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20220922220252.2r5ldxs626lqiwos@cab-wsm-0029881.sigma.sbrf.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PR3PR10MB4031:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c8193d-15fe-4f06-44dc-08dc3dff6e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxY9hRbiOu90vzTiNMrlLqufJYIoxsfV2bFq2gCrlFBF7SJ9sg1HNX29oF7QAEI5G/AR5AmyNBIXBnxhKu+5BCVlJHy3VODCXRbSFiA2CJFG+s/G7aG2Wf5jM/pksi3TWAW4PJcmVEOJz+i9ARpWbOb6AE6/NX03eJHqJkQiCA9YtmAZeO79bat8reJ0KcWOGH3mPQ8BkxAFl6rp3XTnJSDm3LaBdet9tBS0IWkzqn8tT5dnCfyYgEMGfNXMvVofrx4X4DcK9oJIFjqll9hT0ubw6tZih0pgTmGNVzaKk2JtgxvC5b1wHBsf2ZbXMgfKLa8Tdad/vfilZ09PTIcLHls3IWr/wt1nNQAwMWXZbP3nn4G/io081f24psZHdEk5UBKSdHh6Q3M6dA4wATxST/hbkmJ8gqd5Pjr3q40RM9DrQcm0aOTEjSuMJPbtPsV+G9kdWjQe/B5jbte1xiGN2XnYlnN8ZmRH1FhwhXm9yPepymM+93+ACA6xiaLIT1NuUF1HM+JCMuII7Jk+Brg4XteqGQOLjJmpgPA6DjlGH8QZpJc3XVDGPcuJk/qT4qsaM0185sRokDOcHIRmOTpdVOIFLiIHKmPRGRbcaW1fgP/FSekrIKtu8g0B0ZcnBAah4YHolpZibhlKCP7moz5hMUNdeuHhlAU8zWPYTMpgurI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHo0SS91L3BZc3R4K2NTc05BaUJ6dmNyTjBJTWhKSFlPNUtCQmlFRHgrZ0NR?=
 =?utf-8?B?RFpNRVVFRTlrMGkyTEg3UDEwdDlmd1BCaDB6d1ZnNFliK05EVFdmNng4cXd1?=
 =?utf-8?B?cGhqOE5TOVRDTmZvZGRndWZwVGp6MFZaTXk3eS9FYks5QVdqeDZuc3R4RnR1?=
 =?utf-8?B?cE9qUHBpZXgzaWRiSk81bnkrbE5GYmUzZ1oyN3VTdTRDTXRCNkYweWovL05G?=
 =?utf-8?B?bjJ0V2lBZFJld1NxZzBtamJJNVBYWk1qbzdjZGhpdGNqZXJZSml3cGMwUlJu?=
 =?utf-8?B?TkFRc200SkE5bWVRNldjUHZ1L2JvQnh1Sy9VWGF4WlJDZlFoRDZFVWh5eHFD?=
 =?utf-8?B?a3puRDNaVDI1Q2dLL20rR0Y3S3dGUnQrdTFtT1FqdWVsMC90a3ZWWUVybnlR?=
 =?utf-8?B?Rm4vUEtjRGw2Mk0xUlFPenRicmhzR0p1dUNRWERCOVIrV1Zoc0lVcWYxeFpq?=
 =?utf-8?B?VGwramtWdEFJcGlxTzZ1cFhzSGtWM3NzTSt4WVVDQllhWWZQSzhkQTkwaUhR?=
 =?utf-8?B?cXNhY0dMYXUwQ21KTE1ZQUhIekVBZk1LSEN2Yy83WldzU0F6N01UdUp5RUs2?=
 =?utf-8?B?UmFaeUY0cEx2N2hFY2xMMWxqNTJJUTNQc0JJNXhUYnFvbDJacmFlMm5sSmpQ?=
 =?utf-8?B?MjFXRTViVjRRNEtOU0NSTms1M0N0TDJFc0hiaVJ6OEkwcTVOMkFHRWNNMUFa?=
 =?utf-8?B?ZU1NNlZ6ekw4YkZldnlOOXRFcFg0OTMvc09UYXdaTEdrQWI4TTc1R2M4V1hr?=
 =?utf-8?B?c0NodVozRVBUT1Ivbk11TXphQUNGMDlLcjl6V1NETHdQS2JpRTY1UVQzZStD?=
 =?utf-8?B?NmZqMzZValY2TUE1dEkyOGI0aHdWK3hYNFRWVmZQNXhJYjI3UDN0ZmxnKzJ2?=
 =?utf-8?B?TTN2NmxXdEU1WXovaUx4MkhOUTlyWkJubVVaOFlxWWxmL1VHRjZQMmhPWW1K?=
 =?utf-8?B?azJ3Y0c3UE0xaUxEMmVhTlkrSENqL0NCRHlxL1p1Vm1PMk5ld2hFZFhqbWhz?=
 =?utf-8?B?Q0QyWjJtK0lSRjJlQWZyZTFqaEJaS2E1T0FLZ2lPa050MXBFTTFUMTMvM1ZK?=
 =?utf-8?B?UFl2anRMY3hLTklOTFovSHNTVThsWlhpQlBtcjZodWo4bGsyYjVLeldScW9t?=
 =?utf-8?B?M0h1eXpvaWVnbXVtQjZBSHlES2NpR3dmbzIwVnNsR3pkbGltN0RLVTJjWkdx?=
 =?utf-8?B?ck5nM3NjMkl5dXN3ZzViOXFCbjRVVmE2VnlrYWpNbWFMWTZlMStMR2NZeHlq?=
 =?utf-8?B?d3lZY3FTRTl5Qk4yWUhLRGphc1kySGRjSTNEZ2xzMFg2azd3Y1JlRXVma0wy?=
 =?utf-8?B?dkN0M3BMbXFzK2g0VGRGWEg3ald5cWlDcjNRbUR1MXNCTVJ2c1ZMRzRvOVAr?=
 =?utf-8?B?bnYrVTZZa3gwWU15d0h2R1RST0E2b3lBRk1pT0wxbENVVkZ2LzFwdTZWNldN?=
 =?utf-8?B?UXRKdUMvR1IwVzBuU3Q3LzhvVUxtYzkxYmhBWWhKR2tlVXVqNUtHZnQxdm9m?=
 =?utf-8?B?ZVRoTit3eXUrUFJORG14N0lOa0Z6aWlHd2JIVVQrdWpTcFVQc056NlBQUnBH?=
 =?utf-8?B?bWMvWXVmRmpleTYvbDFORzlsb3R4eFlURU9GZ2NQOHlVVHdHbnl0K2RaZnFK?=
 =?utf-8?B?MW83WXphWHBoTzQya2MwR0JUSnl6eGpzdlplSVRReHpnRmtpZ3RNbWR3MTJO?=
 =?utf-8?B?UCs1aEx5VlMwcHJqTVRuTWRTWW1FNTJnMlIwMmk2RG05UDZ5UTBRRHF0VFBv?=
 =?utf-8?B?NjVCc0RhT0VZN2lYSldKTlo3YlQzdUVYbDJreTU3aHJwS3piZWUwT2RtMkhB?=
 =?utf-8?B?bFBDVDlIUE96VkU4SkJEMFphbjEwVUxYSFNoSVd4SWFLaFdHbVNKb0RaU09s?=
 =?utf-8?B?MXM0STVPMUpzYTV4Uk9raXg4eTJtWU5RbXNaZXo5ckdQbTVDQUlMOWdrVTlG?=
 =?utf-8?B?YldYWE9sU0hIQWxIcTFydk1XRTdReWUwaTRjTTBFVEJyaTdkSVgyNU5hV0pS?=
 =?utf-8?B?emNVaXZQaHBWUkVNVld5YnF4LzBlUXhQRTlvNnVYUEtqa05zY24vd080ZVRo?=
 =?utf-8?B?SXVFWnFMRzdZNXVTRUNHTUhtbVZDbmtvNnYvbVBRV3VaSGhYdWtTOVRnYzlR?=
 =?utf-8?B?VFQ1TGVkWTZrSXlEZ1RTV1lqMDRTajQ3WlpJL0RGN0gzSlFjOHlwYzlHcXNZ?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c8193d-15fe-4f06-44dc-08dc3dff6e46
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:04:05.7270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DulbGu8KFJrfjaxsQ/A9hxdZn1Vy05syzW2StRGKVKdTgKPjPsdMuPX9ocTOMXP1PTpqnxMEqiG2xAcYzncby44An8Vihq5qoVebaOqH5/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4031
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

Hi Alexey,

On 01.03.24 14:42, Alexey Romanov wrote:
> Hi Frieder,
> 
> On Thu, Feb 29, 2024 at 09:51:04AM +0100, Frieder Schrempf wrote:
>> Hi Alexey,
>>
>> On 27.02.24 11:04, Alexey Romanov wrote:
>>> Hello!
>>>
>>> This series adds support for the mtdblock device, which
>>> allows to read/write data block by block. For example,
>>> it can now be used for BCB or Android AB command:
>>>
>>>   $ bcb load mtd 0 part_name
>>>
>>> Tested only on SPI NAND, so bind is made only for
>>> SPI NAND drivers.
>>
>> I don't know much about Android, but as far as I understand you are
>> trying to store dynamic, boot-related information on the MTD device.
>>
>> This might be acceptable if the underlying device is a NOR flash, but
>> for any type of NAND device it sounds like a rather bad idea.
>>
>> NAND devices need some kind of FTL (flash translation layer) in order to
>> work reliably. Using a block filesystem directly on the NAND MTD device
>> will cause problems as soon as any bad blocks or bit flips occur.
>>
>> People are therefore discouraged to use mtdblock on NAND and in the
>> kernel there is even a warning if you try to mount a NAND mtdblock
>> partition.
> 
> You are completely right. But, unfortunately, these are legacy ones that
> need to be supported. On some boards this approach was chosen a long
> time ago and mistakenly, so I think we need to support this for NAND.
> 
>>
>> Maybe you should reconsider this and look into how to use UBIFS as a
>> FTL. On the other hand I'm not quite sure if the UBIFS layer in U-Boot
>> is really stable and maintained. So this might not be a good idea either.
> 
> Yeah, on our new boards we switched to using UBI, and we already have 
> an implementation UBI block device for U-Boot. Will send this to
> mailing list in the near future.
> 
>>
>> Anyway, I'm against implementing mtdblock for SPI NAND (or any other NAND).
> 
> Maybe we'll just add warning like it's done in the Linux?

If we really need this, then yes, please add a warning that is printed
to the console.

Thanks
Frieder
