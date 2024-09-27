Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6D6CEBF8A
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47082890BC;
	Fri, 27 Sep 2024 12:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jhHpDn/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A805890BA; Fri, 27 Sep 2024 12:07:37 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CAF8909F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcX0VuNILIqBKI94BxEM3Tcv0Q4lQBV6sHk4gr6Bx3uFYW0QhliiNpNCj0D0lhXP8EaXEvzXJT/+FRY0F5LjLhp6XKvyAU7/d52UvICCmWwsPXWfD8foAFFuoHUca5XIMaaOZN5C14vHDUovSJ389u70j2klYtvIcOu+rmR51YnDwzqh0tItCMoG6sDa+KGTPD6MBA7aTgjD329vnrdTcV/ZaeMtM1FX+yWvIYfkMUHYaU2WLA3jdeKoICiFy24NTTtNvzwFn7OWCjl/sfpIjhvlqourn8xNz7Blqgt90gRw623kILoPtZKJFS7uywlpUS2IFlzvus2H4/+rrVYqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n4Gakf/xC7ZFmg/kGGYgbskyiCV2RhQFj3U3VtmTb4=;
 b=yZP+iF7gICnwRCjXNFT/AAE59M5DzZaYzGjjkdlwSI+Z8O6GDz02/Konu6HdSmEmKf1fblnHRT2RkGUMYktUycjjI+UD6YphOz1NNOGHQ/srUtKKCXTqWjme9nw/po1iik0JODuOvgAlFShr2iL8vDs/JecVDhxXzi+Nc8bYv9DznAGG+GP6ouF5NVlLFlKbdu6BNFJYQf7SYipB8LvOcYYT6Pi/g0xPFpOFxP3T/KP4N1o8//llrod8iit1EamN+AQYgo59HJuLTob9ivM5T4uTY20R9ABKIKu4A4Hhk6L+SYSkG7zztAx/4eSLAufJLLvd5e152qAEJT8GsON0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n4Gakf/xC7ZFmg/kGGYgbskyiCV2RhQFj3U3VtmTb4=;
 b=jhHpDn/mCvBTqGOMOIFTDBxmiLoAKRgKhbtsoBZsedExQn9SzRySaHhkpgUDuojv5AQj/mh+LrCYkXLxNBuMnpHI/DVIX86d9qmNWMl1L1GDGeYuXp8QD8C2b5h2EpMseyb/94zUkDTeK7P4Nu3odqO+ZrKycZEdJq8p8tYDyb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GVXPR04MB10658.eurprd04.prod.outlook.com (2603:10a6:150:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 10:07:31 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Fri, 27 Sep 2024
 10:07:31 +0000
Message-ID: <d48e2192-6cb1-478a-92e0-0f0db5642822@cherry.de>
Date: Fri, 27 Sep 2024 12:07:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: rk3399-roc-pc: Hook sysreset gpio to enable
 full reset
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>,
 Paul Kocialkowski <contact@paulk.fr>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <4304848f-9af5-4991-bfc8-836ccf2abb43@cherry.de> <ZvaAsxlL3GIGyyVL@collins>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ZvaAsxlL3GIGyyVL@collins>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::24) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GVXPR04MB10658:EE_
X-MS-Office365-Filtering-Correlation-Id: c81a56ae-9df7-4672-cd44-08dcdedc3320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUlxbXBiSTVXdEdPS3Zoam1FUGRUNXBraUczRFhBclljZytHTjdYUEhRRnRX?=
 =?utf-8?B?QVZPWXRYclJ3b3ZaQmZiQWYwVmxsbnA1c2N4V2lkZVkyV3BvREZ4cWFYM3F4?=
 =?utf-8?B?YnZmUkRhM21qckp2Mkk1ejVha2NXM2hVTFBpNE9SazJQZzcyOTRSV1YrcUVl?=
 =?utf-8?B?ckJacXdEK2RrQlFBdFRwQ0JJSlNUTTVBK3p3eWNSanEzMGpJY3RQMWl3MnJH?=
 =?utf-8?B?MG5UM0g5Ni9pUjNmRytKL2trbU1PT04rMDJqWndTOHZkOVZkRjU0MnJKbGhs?=
 =?utf-8?B?cmNESTkrZDRqREdvUlJPT29obHdESlFSMnlBNFROM0hzR2Z1bnIvdDJQZUZs?=
 =?utf-8?B?MUx3S0s2YW80b2dBV0kzWmFRek1yUVFueWJGdExjZXRweEl4K2tWQm1FcTFp?=
 =?utf-8?B?SGxIcmRUZ1JzTlQ4bk9lRit2Um9vb2RoZk5JQkkxckdQdFl4cGpUTkphQnFo?=
 =?utf-8?B?b0FxTjZ5UG1nbG11YUx2UU00WklZRGhKQlc3NXB0ckxUcTU0c2JMOTBSV3h6?=
 =?utf-8?B?S0RMMHcwVTJvdmdYdUpKWThwUnBtSS8xUW0xSlY2QTUyT1o0Z1ppQmp3QUxS?=
 =?utf-8?B?UmorSm5KaXNjVDNNSkRlT3BzSTJyQmxNZUc1eCs4RUQ4WHAxTHJSK1dRVGRD?=
 =?utf-8?B?RnBBTXYvUWc1eGprN1JvcmswcVRJZ3NVM2l0R1psRmNaaFgvWmZtQm5Xendv?=
 =?utf-8?B?MUdYempzR3dMV0lLdGdxeEhnazZOVXp6NmJkQ3JsMFpUc001d1RhS0hJWFBj?=
 =?utf-8?B?Uk50Z1RpdXhNK3RGRCtuWVdIc1ZrRitDT2o2REl6dmU5Zy9UM1VMY1F3dy81?=
 =?utf-8?B?T2wrV0pmM2pNdjJ2TVhjdWlSRjZQSzN6VVRFa1Y5SlJZTUQwY3RRQWJScjY4?=
 =?utf-8?B?aGZQNW1LT1k3a1B3aFdXaUxxUldmKzNwNUlkNjFFajdXQU96amVheGlMWGNE?=
 =?utf-8?B?ekx3U05rZzhHSUQ3MlhhMHBZWnpDTVhRU3d5S1NBdW94UmUyMU1VeWp6ZDZ4?=
 =?utf-8?B?VnR0dXNUM29WR3hxemMzZ3JQOEhaMlhrbC9icER5VmYxKzhwR2diMklaMGtn?=
 =?utf-8?B?TDkxVXRYM2RMRyt6YjV5N1hjMG5hYWZlY1YyZytqb2pTS1JaeURhOGdQaUt3?=
 =?utf-8?B?dUFoejJqeUwxeXBKeGVsUHBvZDVOTTFtRndDYk5MSEE5ZC9BVExNM1AzbXc5?=
 =?utf-8?B?ZU10WXZsNmFxdWRBSHQ2ZlIxZEJrZ09USlI0TGdEMlcyTWdSSkEzWmJrZ0l6?=
 =?utf-8?B?LzJZTnZoKzU4YjEvUFZVYW9JeE5FR090L00vNFkrUXA4c25hWDF4a3QxaDJq?=
 =?utf-8?B?cVlUZVNkMFlHcE1CTXRmRHFuTWQ3M1AyNldFaVcwdVlLS2NWdkZKZlEySjR6?=
 =?utf-8?B?dE0rd1RMUDNwUnd1NDV3OXpKRWg4Z2dORTk0eGRGNlluTlNWajFONCt4bU9y?=
 =?utf-8?B?ekhYRlRySWFCR3dqeVBrcEkxdWxqT1FKcWRIZFVYR29HWkRDTTIrUEkyNmJm?=
 =?utf-8?B?TW1WT2FGNTZka3hIbUhKMEhNYlBUaS8rTGlIK2M0T0ROMWFpdGlWcDljdGRy?=
 =?utf-8?B?VjJLZlRvcG9EVERZL2M1YmdnOWhOUmhrMFZzM044SEJIU0hJb3EycXRMb21u?=
 =?utf-8?Q?+FQTdlEb4KeItMyPUonfnVy6FtpMVa2pMDF4XmxhBAi4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FKRm4xYy9STGhuQTdmRXZ2QmJUQnoyY0prbmdHVUFBQlg3T1B5V1hJUVMy?=
 =?utf-8?B?K0JjZll5STNUOGNPQkRJMjUwN282Uk81YzQ0KzFmUkowMlk0RWd2Ny9ONW5k?=
 =?utf-8?B?V0dMdnZFNHVTV0RqN1p5dkFtc0ZFQzdmYjJ5RzJWWE9GWGsvVnl3QmlHeUN3?=
 =?utf-8?B?dUpRYnl0YkpmdkVuMWJlRTBxOWowOVpXWUNNek9DRjJXTmhvNk82ZjBaOGpI?=
 =?utf-8?B?cFVNYm5lamVjdmNwRHk1Ky9kZzBiOEUvYWhZanRjVENQUGxJVGZOZUR0MW5m?=
 =?utf-8?B?Qk9UeFdva3AzM0gxS3VOZzF2RjI4MkFvd2RXVVpRb256S2tjcjExS0VJR0pJ?=
 =?utf-8?B?Q0g2b1RDSDNWeU9WVFFYR29pL1QzTVhrYkJDK0orUzdmVmZWeGJtRnp4WlN0?=
 =?utf-8?B?cWYyM081TS90a3Q1LzhiNm16THpWMi9sWmF5SWZhNmlFQXFrVmxoSzUwTWUw?=
 =?utf-8?B?aFg5bHJFYjJOVnhudWNrbFV2UnVLc3FTVzNIQ0VQcy81V1N4ZTlOU2VoSnBR?=
 =?utf-8?B?ck96WlkyaEFNWlg3cVowR3R0dUg3UGxqRXJVc2RHcjQ0WVo0cHZFTTl1Wkdv?=
 =?utf-8?B?L2daNUREb09xc1oxMGczZ1JNaU1iZmRZSkVyNWdjc1c4MG05RzAvYy9EL01C?=
 =?utf-8?B?cnBpT25oc0hlcE5qbmFLeDgxNEF1aURmSzZjRVVvaFZLdEtsMjFJYWxCbW00?=
 =?utf-8?B?aHhsb0YybU1jcDZiY2pGcEh6em1kVnZaNUZldkVsdWc3V01pUFVKWlhXdnla?=
 =?utf-8?B?MlJLMDhQcmE4RGlGYXZmamhQWHhZZTAwQmFPZEpuT2lDS1VGUi9HOVpNclRW?=
 =?utf-8?B?RFNCMEdkNGJnREpyME1CaE1oRG9KZkk2ZVZCditBdTV3MEJDNjBNUmhvNzUy?=
 =?utf-8?B?UVZtVzE2c0o0UHhnand0ajB4aDJ5eDdWUm85Z01DcDhxV1RIdVl5bGRycmJR?=
 =?utf-8?B?VzFkZHdya2VlODdJakpQS0FhcDhNWWJ5VGdmNlhsQWhNWGVTeWhERFZlT1Yw?=
 =?utf-8?B?VEMzeTR5V0U0eXF3Vkc4VngzenI3dlQwUDh1OHQ1a0kzMHlUVkQyUTMxQWpZ?=
 =?utf-8?B?dndHWW4wM1R5bXhCdWd2UEhPcy93Vi9UbEdSMGIzMmp3NW5odkE3N0lZbjRF?=
 =?utf-8?B?amgvK1Q3bHlpSVhzeGhtNzAzT1N4RnBxZ3pIRWZEdFB2S25OOUhzcjBTNmpa?=
 =?utf-8?B?ZUhPN2FySG1DWjIxNDFKYXNmUVUyNjRoWlZhb0tabThvK1R3SkVac3lBV1Rk?=
 =?utf-8?B?bUxabzFROFE2UGh1RkFNaUdkR1ZUblMxWndOQk5hTkp0N00rUjEyREluNGVE?=
 =?utf-8?B?Zi9PUXVyM2NkdUM4YUp1ZmxFUTZyeWw0dU4xcTNyYVpFK21MWXd3NXZPdTV5?=
 =?utf-8?B?ekc5SmVaamhDYlFjOWd2ejU1RnFUaFlUaXpYWlB0eUwzL2lOMFd4aTZuV0w4?=
 =?utf-8?B?NEFhN2o2eHVEVHh2R2t5R1YyaVFoR2IzYm5SN3E3eTRzZDNwNXRlQjhMUWdS?=
 =?utf-8?B?d2JpNG5jbDMwK2tFWldlVkNlUEpWMnFlbys4MFJLQXMwRkZ6ZU5CSnJsaW5L?=
 =?utf-8?B?WmtkK0s5dXdiUkFoM0tUVmJQTmt6bFNuV0cvTGc1VmdncitEZDJuMXM0MS9H?=
 =?utf-8?B?eE5hYkV1RUJ6MzNVM1V2N3hDUEtTa1FOcHVvbjNVc0paRzBsV3hYcjJSMUZa?=
 =?utf-8?B?VEdxaVk4eklTU2FQbEl2SHh3NkVvT1JoR1lyNTNCdjkzdDh2WElabG1jaHhu?=
 =?utf-8?B?U2wyWENFTkxtMWk2eTRYeFZBdXZBSU8wUXhSQUxhdjVuYUpNVWNqVndET3NN?=
 =?utf-8?B?d0VScDlkZ2x1UEVzSDNMem90TFdYL3ZXc1EwbUdNelp6c2IvNE1pUzRJWE15?=
 =?utf-8?B?UytpTW9LZU5VUnVVZmhBRTJOdE5tUHNLN0JYQUtEWHRJd0IyL1VrK2JKN3pp?=
 =?utf-8?B?bUdBVGZSUlpHRU9uNU1jcnRkS05LNXFhckpSd2xlNElMRW5PRmdmZlhScXJP?=
 =?utf-8?B?eVFxakU1R3dZeFFWbUJkemZrVFRBbW41bXhMOHZhREN6ZkRrWXNnSForVTZT?=
 =?utf-8?B?a29yd0I0WW5JVEVkOEhGTlQ5bytMYUhsNmZ5cE1BYVMrWko1L0wwM0hpVGFD?=
 =?utf-8?B?VkF5VUVPYklEWWhFenJCS0JSbGZSeVU4aUIwKytSN0ZCemR3QXFTSWxpZDZ5?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c81a56ae-9df7-4672-cd44-08dcdedc3320
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 10:07:31.2871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tvDxRVt79aDHBRrfnN/NaiujlNKh4ZXmCW6sJRnRNYQSeO1MsWTtYE2nPTv9hUN7nwDwU2BK+HwGKK2JpxlsJRBr+SbWj3Vkq+b52tcPz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10658
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

Hi Paul,

On 9/27/24 11:53 AM, Paul Kocialkowski wrote:
> Hi Quentin,
> 
> Thanks for looking into this!
> 
> Le Fri 27 Sep 24, 11:25, Quentin Schulz a écrit :
>> I'm not entirely sure on whose side the issue is, but I didn't receive your
>> mails, either from the U-Boot mailing list or directly from the Cc field. I
>> however could find the patch on lore.kernel.org... and I also received yours
>> and Dragan's exchange on patch 4 (but not the patch itself). Any chance you
>> received something from my mail server? Does anyone in Cc of this mail
>> actually received the mail?
> 
> No automatic reply from your mail server and the logs look good on my side,
> with a 250 result on all sent patches. Strange indeed...
> 
>>> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
>>> index aecf7dbe383c..883d399a06a3 100644
>>> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
>>> @@ -7,6 +7,10 @@
>>>    #include "rk3399-sdram-lpddr4-100.dtsi"
>>>    / {
>>> +	config {
>>> +		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
>>
>> I think this is the wrong pin to use.
>>
>> The routing of GPIO1_A6 is similar on RK3399 Puma and Pine64 RockPro64, but
>> it differs massively for the Firefly Roc PC.
>>
>> However, a similar routing is done for GPIO1_A5 on the Firefly, I believe
>> that one is more appropriate. What do you think?
> 
> I just double-checked the schematics (ROC_3399_PC), looking at signal OTP_OUT_H
> which is definitely connected to GPIO1_A6 (P26).
> 
> Also it clearly resets the board when toggled and solves the MMC reset issue
> I was having on this exact board, so I'm rather confident that it's the right
> one to use :)
> 

At least we're on the same page for using OTP_OUT_H, but it's routed to 
GPIO1_A5 on the schematics I found:

https://www.t-firefly.com/download/Firefly-RK3399/hardware/Firefly-RK3399_V10/Firefly-RK3399_V10_SCH_(2017-2-8).pdf

Mmmmmm seems like I was looking at the wrong schematics?
https://en.t-firefly.com/doc/download/page/id/51.html does route 
GPIO1_A6 to the OTP_OUT_H signal..
https://en.t-firefly.com/doc/download/page/id/78.html
https://en.t-firefly.com/doc/download/page/id/127.html

So, the Roc PC, Roc PC Plus and Roc PC Pro all seem to have a similar 
routing for this pin, therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
