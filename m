Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D354BC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 09:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B90877D0;
	Mon, 12 Feb 2024 10:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="eivd4SxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB76877D3; Mon, 12 Feb 2024 10:07:44 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C49B874ED
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRZ7yIcSHv/rJvvssFujhuzy71O3yW9gw0aPVdnbVLN1/NNf/Ss4tVpb98ODulJPSy0Ij/InKYnvixrBk/qq5uoxP1xJljM9tzKprnVtdC4DdpeTsHscPhDqZyd14lGCdBc/bt/DiMTTGX49U3V2qUXm6utgBwe7ckvVjEDOX4/yZ0tQx4pVFoBdoUNhy1DkJ9w5RMj6lv+pRrxXXMjB+Lt9hHAHP7VkrpQnqyxtbxJknj5DENBM19ETX97lFI+ak6P7rxvv0KCWfjj6j8PmfKvmwoBOGXP9jkjPzm4GbHIOnpX/zo5APYCVtgywoq0Hv1LUVZYXJhWZF6icc1R32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeABb2zQD7ks/3zYg8LZWAOOITe/o3B/UhpFTdftx+0=;
 b=UwG9g3rT51GGv8NU820JakvPm6Ud9FzOjHsL7ZiFnvS/xvP2t3A1o9DN6GgYZq6dhLzQSyS5NbLeib6Xpp4yo4jq9EhadLkhs9EeGd3j+1JdleBuou+t9btiCteJa/C0NgDDU1WahwTggPzuFfUzjbWRKcJgOVX1LOSoyqRfgvJUDsLhb7uR3sHpE6DSx0csLz8ysVwotL1H7VWkNI4+i7Sosqgoqbz1fDJYBxpPr3wpls2IH1K9n27DvVQMsPdg62YERpEVI4MZexQyYxHATC7wdCNSnDWJCB4DYrRGUjGGRPuVmSBk3FZKGaYvhcugML0YsunRM/SgHrjMFoshUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeABb2zQD7ks/3zYg8LZWAOOITe/o3B/UhpFTdftx+0=;
 b=eivd4SxL+abnfA5Mjp94+oacMRZ+QbQuZhBRnTm6DDKry0bByw13zU1xheKlZ8eTX2LM8EcSK/ZlemwMlDeVa2rhrani7fnxg4PPkBwglnWFydHD4qF9wCzLx2UUdqU3BoZ4Hx9ZdKC8ELTfTG7vmJ+jwKVOjX/ZRKsCfByxAvPtLHsR+7sFrubiKcxKfWa4OXHZKlKtV38bgAMGv0aUxtRVZTVgUaA4Rvh9CkIYdAaMxVNAXUyB3RAZGNa1auuVfi9M5NgE4eNXUE5JwujlvtM5FcN8S6gTXIbl5pRjj38TmXgY7ggZkB9snx0h5EaL3wXKRzjFB1HbGx2Sp7+0PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 09:07:39 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 09:07:39 +0000
Message-ID: <2c095115-8685-48e2-9d91-a23f04c1c9e7@theobroma-systems.com>
Date: Mon, 12 Feb 2024 10:07:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: rockchip: Clarify the rkspi image format further
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, massimo.pegorer+oss@gmail.com
References: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::43) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM7PR04MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 281b7a41-ebc4-46c1-441a-08dc2baa0fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AZRJJd1qvDTeOBnSk9w7AVaUw8KD48QMpz+CuaNOTFPTY20I8BEvDPFEFu31kYXKZKIHgB3L4rLKht5os6KG9lEXB5jo+gjc2XsGkNpOLuUoOrZQfik6O/sfdVPdBY5bIO1MIYeg9sWH+0eq1HuREhAZmdQaqoVQhlOB+Us2OEBSScUKyRRg5geIBv9JVe295ZiArECy1TbNzQsHB87wfxUKJED7fpBItGc15Rod1FJ0Krt0DqXeZj224yiEM3HSOd8RFLMgIPw0o5gt+qMMyM1UYmYE8B1lLblOBEdz+u7+3P/LK22UJk9zwOpnxRlyheopAmBoy6b+W0gDQs1uiit2qEbOxC67GiU/+3fDevDY5JoHFksr9VWiFCFDkaFbx6Uhkaa4luJhPgkXBNqnbBR9mwJU3ZM+OPomANe69ahFZ6PsUQAV4fM8Yyqb7kcxERhmzDUvZOp/28PG53bL1CA897nZgRFWXsZem0P8YZdAk5FoeJzu6hT/3UX/fAKycVetWFpCVuxC4dD/VY+7Gp5IFzEctGv4MzJQU1dqQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39840400004)(230273577357003)(230473577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(6512007)(478600001)(6486002)(966005)(41300700001)(8936002)(8676002)(4326008)(5660300002)(44832011)(2906002)(6506007)(53546011)(6666004)(66946007)(66476007)(66556008)(316002)(83380400001)(2616005)(31696002)(86362001)(38100700002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZ6a0hrMkpoanBDS2VTa3MxRy9TRitGME1NTXZ6dDM0RXloNjJGUmRINWMy?=
 =?utf-8?B?SVcxY012ZklDbnd2aERWU2ZCVm9YV3I5UWN2b0dLaElqY1h1WTR5djVDRDR5?=
 =?utf-8?B?ZndrNTJ6Q1RoU0JyRVFzdkRERTJJNGpYTHBXb2U0dUh6MnJxd2F3blhCRWJx?=
 =?utf-8?B?elYrVXh1WWtnY0JmUkNFeWgxdE9DZnBsT3Zhek5VdzM0azczTkh1VWd1NGpq?=
 =?utf-8?B?WTFKWjB3OGp3bktWOER2SWNhSHBSd0o3WWd4bjMvTXI3ZUdZdSs2bG5jMzRm?=
 =?utf-8?B?VExySHIzZGVobHZHSWF3Y1FJeThGWGV1MzZVUUVDc2RwVjFkaTRVWFgrNTcr?=
 =?utf-8?B?aCt1MXRxbDNhSlFnWWI5cHVPOWFRV0RheEZtQU51USs0RUdCRUx2OUVSWTE1?=
 =?utf-8?B?dDl6cGhHWXRoK2hNUzRSVVo0UVlTaUNldUpMR3o2TzVkeHh4SmFpYmt3c1Yz?=
 =?utf-8?B?dTZMNVo4UGhYWU04YnZkeEFpUnpFTHBGVXp6MTVqM0JMR1ZISHhrVU5OTzhU?=
 =?utf-8?B?QUpCMWY3TUFEZkJFVE9pSXdZUjZ1OWJrNjRhZUtPdUtqZ0pxYWg2UklRYjdm?=
 =?utf-8?B?ZEFRamlHSFk5MnZuQVFxN3g2WGV1d1hnLzdVTlpBMU91VjJvY0dQL0JRTENO?=
 =?utf-8?B?eEY5WEJCQUw2a0FRNmR2T2FuTjFWNHd5ZVpuTGorWnlBVmhZVGZuZnJpeGo1?=
 =?utf-8?B?RU4yN3ZibmZrUzh2R3UzS0Zqb2c1WDdlbW1iQldYWHFGTzdRNkdnWENneG91?=
 =?utf-8?B?U0Y5d2RtbytUVWU2RkNSeDRzNUJ6dHhHcCt3eVMrbmNwRkZiQ0h6R3Y3aG9o?=
 =?utf-8?B?MzJpR0tWVkI2eXdUSmo2UCtHeUNYTWkrUHZpT1ZBZlRERndLSFVjS3ZlZkJh?=
 =?utf-8?B?TGFHdzY1QU1zaC9NZGZ5WWE5R3UyUGRnMzIySEtoUVFnUGFDcUFEbVo4anlY?=
 =?utf-8?B?TmtqQnlRSFMwbExYVXU0OURiOUsrOHRubFZNR0Z1UjZtVDhXSjZWOXN6ajlJ?=
 =?utf-8?B?V1VOd2JIcEF5eXBsVU9LTGlaMlZZSzYyREV1L2ozN0lSRXVOQlhpeE1ub0xP?=
 =?utf-8?B?Rk5iWWdCMU1rcTlGeUZ0b2F3NmtCcEh4RnF6MUV1ZUNSV2lBYXNoUitkQllM?=
 =?utf-8?B?dDF5SzRnRFdSUzdYRXEyOEgreGtVRVRyWlpuMnBVOFFvSWphVnFuczViSVZV?=
 =?utf-8?B?VHhuZjlZMDJKWkhOT2tnaUkwTVVpZ2EvV0dLR0hjK1BvSUN5c09wQ0hCekdN?=
 =?utf-8?B?dWpLYWRwYzdnRHo2K2drc29PWThGWkNveXR1TG5PVzBTWVJMdXNLTWZFRFZn?=
 =?utf-8?B?Q3VFN3RnT2JkSFJPck1oQmlqaFR1clM3MHFFYnMybTdwQ290bTR0N3ZKY3NS?=
 =?utf-8?B?UXJKMXdKT0t0cnU0RmsvWEE3Y1B6eHlQcnpBaTdHOE0rbWcwaXJWdDVENi9P?=
 =?utf-8?B?VFY3YVJmQkNERkNCMmxOVzFQOU1EQ2pyQzJUOFF6QmhKSWRzRUFSN0hzSWFp?=
 =?utf-8?B?djVKcGdEdnloc1BySWNrTTM1VlpMOXNBM002Sm52MmRrcGc2cDJoajNGcUpq?=
 =?utf-8?B?ZG55WlZOWGxHQmM5UVJqa1RwOEo3OVlKZWNTR2JKTldURGh5UnltME5DYmtG?=
 =?utf-8?B?QUxwWEx2d0w4cmZKL3g4dWs0OTkvQ21oanJaOHpVRGNzeFBvall0UXV0V3d2?=
 =?utf-8?B?Ujh0K0h1N09SeU5rZXR4VWFkUjlveU4xNmN2RGNqdDgxVE1Pa2hrNi9HMDVt?=
 =?utf-8?B?NVpsSnY5cFAxV3ZXTVNqWjdRV05QZlJBS1gvQnYvMk54cVE2dklnTzNWS2xN?=
 =?utf-8?B?d2FyOUNJc0pTRDRuZ2xBRUtNcHJkd2NyeGFJQjErLzFGQy9ObXAxSWRiTWlM?=
 =?utf-8?B?WmRsbGdBb3JRUUJsaXFDNnFiazZMUHpOZHpCdnFmMTJxWnNtLzEzc0kzMzhH?=
 =?utf-8?B?d0Jia2wvOWxYd3ZUdjRHZVFkUDJtS1hiOFNNOXRYNzh5WjREOWpJek9ERDl4?=
 =?utf-8?B?eXB2WkdkYlFXRmYrdnBTZ1k3TjUvdlRRQzRRZUttbE00NmMzZnpmRHBEUXR3?=
 =?utf-8?B?MDlwdDlvY0FNd3k5WDl4eFNDbS9VRGlKblR6OVRWMjBHYVZveU5UajNycXRN?=
 =?utf-8?B?OXJLOXlTZGpRbGhKVXh6c1hhb1ZaeG5uazA4RjYrOG1wa01SSlZTbk1CcENp?=
 =?utf-8?B?MlNIOTNYeGkvaGpidWdVd05JSE04YlZvSjdtMGlGTTE1c1FBaFkzZit0elpU?=
 =?utf-8?B?N0x3a2w3QkpzTGVkWlRtOWdYcjlnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281b7a41-ebc4-46c1-441a-08dc2baa0fd5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:07:39.1210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R27aoaHpOPM6xfN0FEX31G+OeiwWbr6i1aAyrR2b2O+0hPlTTkiObZLqILrvLNo+K8nwBnyj8zYmyeBpevaHWSRznPMqrceSjjs5Jf1q8N9CjfAaAAxDmBfsB7VS+pPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904
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

Hi all,

On 2/10/24 19:18, Dragan Simic wrote:
> [You don't often get email from dsimic@manjaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> As discussed on the U-Boot mailing list, [1][2] only some Rockchip SoCs
> suffer from a bug in their BROMs that requires a specific format for their
> SPI images, which was the reason for the rkspi format to be introduced.
> 
> Improve the description of the rkspi format a bit to mention this, for
> future reference and to make understanding it easier.
> 
> [1] https://lore.kernel.org/u-boot/c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se/
> [2] https://lore.kernel.org/u-boot/CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com/
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   doc/README.rockchip | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/README.rockchip b/doc/README.rockchip
> index 84caff8a24d3..e0c5c395ec6a 100644
> --- a/doc/README.rockchip
> +++ b/doc/README.rockchip
> @@ -649,7 +649,12 @@ sector is used. The header is the same as with rksd and the maximum size is
>   also 32KB (before spreading). The image should be written to the start of
>   SPI flash.
> 
> -See above for instructions on how to write a SPI image.
> +Only the BROMs of some Rockchip SoCs, such as the RK3399, suffer from a bug
> +that mandates the above-described data spreading, thus requiring the rkspi
> +format to be used for their SPI images. Rockchip SoCs that don't suffer
> +from this bug use the rksd format for their SPI images.
> +

Then I would suggest we move

"""
args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
"""

from arch/arm/dts/rockchip-u-boot.dtsi

to the SoCs -u-boot.dtsi that are impacted?

e.g.

"""
#ifdef CONFIG_SPL
&binman {
#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
     simple-bin-image {
         mkimage {
             args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
         };
     };
#endif
};
#endif
"""

in arch/arm/dts/rockchip/rk3399-u-boot.dtsi

and have "rksd" in rockchip-u-boot.dtsi instead?

We can then document this rkspi type specifically for those SoCs.

Because this kinda means we're currently virtually inflating the size of 
the TPL/SPL on non-impacted SoCs for no reason whatsoever.

Cheers,
Quentin
