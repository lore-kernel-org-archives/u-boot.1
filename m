Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83433CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E43C08809E;
	Wed, 10 Apr 2024 10:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="aUeINTP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377B0880F8; Wed, 10 Apr 2024 10:56:55 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD5687E3E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPflJlLh2ydngpKmQV/FFD41can+xQix0aaQbeJgFwXGxpXWP3pxXdW59vYzeJox8pIhTMmHWtbohX9GUiQVBj3j3UZc+ESQR7DNuYi6LPtP++7VVnJ4hyWRR10MpQJG/uX/P7EfcgWpvG/QRUmPPoqn1sp77odxoQSSXUEVehVyqweGjj1BzLAJbctvqfJ7Q7xVB91GuxjNPafUFnGK6l1Gmo+11K1UoxMUaEtWSMgh9hnjHi9it2I50SEzhpPtulgUG5aFyL5VeGqIxQkAbo0UZCnFEWlRzWqGVkuKrHqzLY9GhKFLFg/HYaswqgHjz6ZudtkDiCH4JREopzNzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxfiCCmIMOlGaxKRvwOivdTC+tzKseeqAsroUtxOi1w=;
 b=Tc/r9oFty9QZPCzmz15y99IYSh3YHqaQq0OKrZ76t3XUbvPORibEB7lTTkaPiQ0YSV9NOL82ar+DtgCi1yUWPIsAvU1Wwq5/nrNs2FukOFGdCJzsoWggKj2CStiB39xzkwJhrybZs9JYKI0cs0pRAzLC6af0FXj1BIljI+J3hpAkkEEfgL4Zde4ICA9NrUBOqJwxiUsyQflx5h+M38zYwfrwH3IYlCK4JKGKS6/8aty//J6sRpt5Z4MnHZGoGUF4AhHooz/uz6RfUKr2yfvJmMXmhY/SIXfripzflEfP2k0pdW/KEpB4byCpVTBYXlqeAjy/R2WBBM3pqVNbsZUelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxfiCCmIMOlGaxKRvwOivdTC+tzKseeqAsroUtxOi1w=;
 b=aUeINTP1+4SiMX/sN8wX6nrs9EN+hbnBWQi4ZN5wauP7ROsy5v9uGXkx3litLKNFWQyX6FNLjjpCA9RlgqsMXjWkWIhFg+3Isfd6BxCiLBc7Qe2p2k2UxdNtu4cgSjSGiYFqldi/XJ/Z1frtvEkinXlbogDQ2xmpgZmSLctP/lq/TeryCnGQG625gyeaoXu6X5xTgpIuo7Pevh+sW+pucyAkfnpVLNhw8wp6AOpD8Honz9D6HsZsheapQyAxW4VPzJD2kqbbnuZ74grvMm/h0YF1/uht5Hcr106zTTmfpJN9jMHf0ADzXBX+wcnoBL5Ky0uiJycHXa8Rc5znpPoM/g==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 08:56:51 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:56:51 +0000
Message-ID: <8fec34b8-8d04-40ba-baca-5394762a4d27@theobroma-systems.com>
Date: Wed, 10 Apr 2024 10:56:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
 <9b62bbedf2c6d52b76a8ce1ce57dd35d@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <9b62bbedf2c6d52b76a8ce1ce57dd35d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM0PR04MB7074:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+0I2TqAQs3ezHAG/QAGtgEPbldpOscHCnr6Agl3jb6foHhzTchbNCjQlfewv/ltyNmm8+9KmXmP6rtIiZHSvzKxzN8b46KIFj+3zRJAjKXXXfwp0BCDWyEHmZizFwtYq+Cupbm0pih51vHNsBkEaxn56OgkNzADNALHNUnNIx2O0bEWAFwTaLuoN/T77N/8AgBoZCcMZbOVr1XwGRw6sJq40a7UfkiXu7cOv8yJr3uFjxlDhXg2myEF6QtUdZz18+Q0H7MGWzw9KIzGLHW287CW7dmfb0b4n71uYZ7jCuK6qWnWAH84VA17mJiBbVMXV7+fY1qaqqk9IW+Vzt+D+M8aiK/FAs+5MKUc1U8Ymiguyev6fHqhaEk1jIGlS5mGVohjBliT42KaMtZlvaczmcpARzjw2tvPEHpJ9bCp/tf+mnFJHTqa7fcAKa+uwOp4PkOx/9cLBrSjoidQ3xpRW1nFYGqH2fgGcK3CZRywdUwZrX5ct0axi5hGHNku2DHC+Tw1Z0bvazZs0M3vFEzrDmxgshDaZQwl3r1LxkPsLscibCKi7d7zvc9RdeH0xsh3x/pZlB8XcYyL03FHqyWGZBtCVharrwX36nLCXLlTwZNK2EU1UYTjulKvmt+8lBCQgaDl7B4S8ZByhbGh75YO4K1XJzOCB3WYMxb+SZNLlcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE5nVHF5RmkyMUpBMHozdHJoYS9USk5jbzRkRnRkR2xlS2ZxbndDUWxhSjdW?=
 =?utf-8?B?QXQzbHplMjBZT1VGaWpSZ3huMXJUK2x0SUJRK1hOdG9HYUR6dDFTYmo3N1JV?=
 =?utf-8?B?Uk1zdFlFSWcyTm9ja3E2bnlJT2RYeHFWZHVWUmFVK3NvZDkyTndOSXR6Um1F?=
 =?utf-8?B?RndacUhoeUlYNXUySzUrVDR5U2dralNscFB0aDB0eklxRWVvRzBRbEw5SS9L?=
 =?utf-8?B?Z2xaK0JMTk04ZnB3aWt4SlZsQmNMNy9MTlR5Sks3cG9aME1jemlPMWJmRGMz?=
 =?utf-8?B?WUQvVzIzRnBvcGtJWUJKNHVFSTVGWG1GdXlTUUZFVjJhUElzSy84WHVhaDRM?=
 =?utf-8?B?QkR5eDhuYUExc0ZSUjZ2QndNZldvd2xKSElWZVJqZ0tTdHNTY0JuZGMvM3Bi?=
 =?utf-8?B?czkyVkczb3ZvZzR0WHZYR2orSXZpM0NyY1IrYlE1aGhFaCtDM29oSE9vY3Y4?=
 =?utf-8?B?S0ZRZWRsTlNOVitsTWR4MVdxdG53Mi9oUVhKaE5vWUc0d3V3RnV4THFFZFJn?=
 =?utf-8?B?Y3RZWFRRcUJRZklpVE9NekJuQzF4UnJMRVkzVDE3Wk9qK3V1cW4yZlhNQ04r?=
 =?utf-8?B?WG40Ni9UNW43VVI2cUhsemlSL0FCS2hhcHJvYjJzUEE0RmFNOTFoRzIzOEIz?=
 =?utf-8?B?bGNjNUs2TGtycmJMRDBqOFFieHN4NXlHamFXOHc5WXJNVlBQb2QvdEVKY1pG?=
 =?utf-8?B?QVJWUmprMEs4NHBmb0Y4Z2c1WG1zSS9qZEVGemVzd09JSHpaUEhudHNuNkg4?=
 =?utf-8?B?TXp4bHlIVEtJei85N010NjJOcjhSVVlzR1dqc1RsSnRIRGk0cDFSdU93dTlJ?=
 =?utf-8?B?MzJpRzlyQUZDdGR3RVg0SjFQYUhKUUxNN3NMR2hvUjJrT3kvZTFpNGQzaW1r?=
 =?utf-8?B?ZHdqRkJuWnJTeVNpSTZ1K2hjbVFIQXZGclB5Q3lXcG9qc2doUWg5d0tOeVY3?=
 =?utf-8?B?K2hXTnQ1djFDZUF4M0x4eldLL0p2V3g5ckovc3NFY3RMUWNjTVJDeXhnZHRV?=
 =?utf-8?B?V1licC9TVVpGenVBUHg0K1dDZ25Vb1JXeTdYZWRONGxwRUhjWHJpWnRsMjZ4?=
 =?utf-8?B?dU03N3Z4ZWZTMFFKY0p0RU5OemtSaDYyanNSbUZHaG9hOXlITGRROWNvQnh5?=
 =?utf-8?B?dHA1ZXAzaU9rSDQwUEcvcEw1T0VQZnp1UFVsN3lCQjg5cWtFUGsxWjV1SkYy?=
 =?utf-8?B?RWwzWTNMUWZtN1VYaGRxd0lsa0pQY3RKakNaZlJ1d2tQbTNpVXc0cDdqZnJs?=
 =?utf-8?B?QzlBTXRMNGp2TzllODYxZUhSdGVZbjFGeXFpa0pTckRQajZoR0RWQ2pIeTlz?=
 =?utf-8?B?SmtOeVUvSnMwYTN2YVdpU3BSYkJwMnhaSnd3RzlIRklUMEprYXQ5eWpBbmFI?=
 =?utf-8?B?THAvVmRIZ1ZmNFhHL1lNa3pBSnQzY2ZIREk0TWJFMTRIMnJ0MGpEYmFaL3B6?=
 =?utf-8?B?VEs3RGRha3hFM1FQR2YzVi9wZENCeFI0enpKVnovZG16TEY5VThGb1RXSHpr?=
 =?utf-8?B?WEc0a2N5NjRsaFUrL1RXNWdYVHZ6UW96TWVCbUR0NXpHNlpsSU9GTkEwcVhj?=
 =?utf-8?B?R3h3ejY0anlEaHFzdHpzZTNiM3dGdTlCTEd5M3o5Y1ZIZ01XZzl2bHlRZUpV?=
 =?utf-8?B?Vm1JcGhlZHV1T3ZqQnZPV3pYYWljSUliYnBMRWFSYVBJTUF2Rk9DUUVnSWJu?=
 =?utf-8?B?WXRRWjRpU1F3Qy9YUnB3QlRqMFYvNnEwMjVlaXptTjZjSVBPdVlETENkK2Iw?=
 =?utf-8?B?RXlrSXBDNHFrOERnZGc4U3JaVWovc2R4ZkFKZmp3dmV3R1VaaVpPRitscmRT?=
 =?utf-8?B?U2hOSngxWUJKeWNZMHN6WDJORWZtMVNzVzcwUUZaMHlZS2g0L2l5LzgwS01Z?=
 =?utf-8?B?RUtsaEF6Rk0wdXdpQVFvU25pZGYxUzF3WGRKTE5KK2hLZklMUnM4Uk54SjFV?=
 =?utf-8?B?Qk95UFRyRGNaU0VCQWRmckd3ZTJRRDQ1S2lTeWpEankraVNNUXlORFZJNXRs?=
 =?utf-8?B?djJJT2JGTEo5RmxVU3ZWOGorbkgyeGkvb1FrbytLenE4aFIvSVRJQzVsa2dN?=
 =?utf-8?B?ek5WTzAzdlYzYjFDU3V0WkJPbkNRTllWQU9iWm1IaHdOL3lYbVdwbCtFQW5S?=
 =?utf-8?B?V3RNK1NRWEhUWkFnQTBRV0Y0SWYrN0oyZUNSdStKVG9wa2NhODBGaXJoOG1W?=
 =?utf-8?B?Y0VaV0w3Y3FRYkxTR3g3VXpscDZ4cjJxZ3pYQm5HZ05veFZ3TDdNZStKM3VK?=
 =?utf-8?B?eGVPS2NIYjBNU2YxL1poWGQrTk9BPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e7ece5-4ef0-4515-6c7e-08dc593c29d1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:56:51.7163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSPYfoRJaNLPDOmzvE0XHwFaw9pk9aY5ze7N24+fuIq9u31hvwDsa175OywMC2clwX2jhvXPqUKkt+/ZIVJcelzi4M7/CujQ5uN7hb3jSCh0kBh/EHkY1Smw8F641RCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
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

Hi Dragan,

On 4/9/24 21:28, Dragan Simic wrote:

[...]

> Let's keep in mind that the troublesome DT properties describe the
> capabilities of the MMC controller and the board, not the capabilities
> of the MMC storage device.  As we know, eMMC devices provide automatic
> detection capabilities, to allow the host to determine its supported
> modes, and match them with the ones the host is configured to support.
> It's all described in the JEDEC standards.
> 

So why do we have those properties specified in board DTSes instead of 
in the SoC DTSI? Logic would want us to have this defined in one place 
only. I assume the issue is that even if the eMMC chip itself says it 
supports HS400 but the HW routing or some other issue make it impossible 
to use, we need a way to disable it from the DT for that board?

> Having that in mind, I find the approach in the Linux kernel rather
> reasonable, because I highly doubt that some MMC controllers support,
> for example, HS400 without supporting DDR52, or HS400 without supporting
> DDR52.  A reasonable approach for an MMC IP block is to make it capable
> of supporting all the speeds below its highest supported speed, to make
> itself capable of supporting more, if not all, MMC storage devices.
> 

That's true for the IP block which is self-contained in the SoC, but 
it's forgetting about the other part, the eMMC chip/card. It depends on 
the HW routing, where mistakes/limitations can happen. And I don't think 
we have a mechanism today to disable the modes set in the MMC controller 
for a given MMC card from DT (aside from /delete-property/ in board files).

> In fact, I'll probably go ahead and submit a Linux kernel patch that
> updates the descriptions in the binding, to hopefully eliminate any
> ambiguities like these.  I hope you agree.

I for sure do not have enough knowledge in MMC to argue more than I just 
did, so having people with more experience/knowledge have a look at this 
would make sense, let's see what they have to say :)

Cheers,
Quentin
