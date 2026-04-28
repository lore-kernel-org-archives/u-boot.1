Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3BDFF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21964842A2;
	Tue, 28 Apr 2026 05:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UBb56Rkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B62D842D7; Tue, 28 Apr 2026 05:44:17 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF548429E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpDWpqWWcorPbwvxuUv/raB2MVFAQfTl7V49AlFgeUBX1XBGnQqvklG0oQ2dUcsBtKZOk/gASqfV7SbpTLycwTTRKo0IsADjetePMvxFcPUV1jUxungJrkStugbBx6KMwhyUGgDxCx7YWRypei8XwAxVg6TgYwIzsA0dUc41gpEhWwzOzjzKDE88NnmrYEYDWrTmePhXDv3zNg7MsxgAkRff0HxypIdF6aMazAD9y0JE2MQ86XZRIdJ7UfANN2p9wWLhRoXWszsydualV4j0aM7DrYAYH5YbkqwgkPsbQtQ4QMevU7NVFbZ6RLWnMa7CJ2LjbQsKx4Occb3zcfMEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D98ifgyaGBUoS7vRixjlNupe5ZXXsI6aPxFtpEpbt8=;
 b=SEhJ3TryEG9kh3G5iFskjEz21LNZb6ODbRoNjqqmSUwJQNK9fJAcHVf2UGUpxxCX5PWHN38ARyKrkTEVFUPhmetoB1trOIU3pyTW83jaWIw4Xk1pqwmT6/Jo6HVsfy3H5iZdE7s+S5+1GVtQjiVAZgT0VuW7+iZWRoxBQlBDkIp2rUfyK8n4iC3W2My3dGLDRBuW1rgnzB2B5Pu+rNKURCAzlGr6C56Nx/K0GoFRsUHJH+MN8EJtzCHm9DrncnHpUJzwtkztwwMEVyjmo52do8z/WfXiE5qFdHgHhH7XZv0lIWUxnlfMXvxktbUFvZZq8WivLQPcpEge4u9URpfFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D98ifgyaGBUoS7vRixjlNupe5ZXXsI6aPxFtpEpbt8=;
 b=UBb56Rkx6H9HSvUTI90DcbUgWbdF7D9h+5c2SIW+pGpymyjXhtZ7qEG+DN2lX54PYmB102r7WtDTpz/9shpLA7VRwUBQPtEfSR71IulKMi1CGeoXWmGYZGFMCIUKfMXPMK0R062VvJ+l86RoK+3awYdkTH0FFORfntJHA/YL2w5eXaJAIRBfC+h00wkycVTEFhwTigadRKG44gE+nPaR4d7ZVDSVzJuuTgrtqdti4v5h1U8nL1LVoWkZVuTCZfg6t3SdjHMx2ACu7bkRvL/x7RY0M+ijmJcnwXQuaHA7FF27QOuuNS9QyVN2UairzG84hL+t5bZWYlD0Z1KZaE7NZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH2PR03MB5271.namprd03.prod.outlook.com (2603:10b6:610:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:44:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 03:44:10 +0000
Message-ID: <d66ac683-af83-473f-9e75-f6f3a317280b@altera.com>
Date: Tue, 28 Apr 2026 11:44:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
 <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwkrp37jF-8FNZ=dJw=xfwq-gAPockLwKkK71sutfiE62w@mail.gmail.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <CAOf5uwkrp37jF-8FNZ=dJw=xfwq-gAPockLwKkK71sutfiE62w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH2PR03MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b009fc-a25f-41f3-09ce-08dea4d8682d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: yJBx7SdpModyoPRBGKKrDDK9eMET9BQ3tYohgpn7RFENTUkUqrDaJNlUkwjrIhObhO1EFwhfl1kFm00mE2MNNrRaH35MsQyNGET0UnLNTNF1/Ckc6mBVb0VxD6mefJbu+2WiaPA1glGmMON0jWGcCOz1iloKSRc4iLYGXkwXvnvVoNfrKirM9TsqYYLp8aRNvf7QVd+oBCmCQl0R8a29XbhRKSIosnMIMqufXANvjchnPjOxkpPEBfmJJcOIQNgDibsJ2/NZOklbSlS6rkouDhNi30n2NzcRA/H6bFtmzFVLUYUzqkjXw1ykvk+hvYmWJJydJAinAP8b/hW9MAxr/CaD7evqd/56bKJF7AE1R1M+WUA8aEB6doZ4jpG2hb+8TdKwwmu0nzIaYzpNT0EBlP3CctOH1mSwkAvhDewiyA73iPz+HaN+01nKyekTmZxUoIeSeZU1djQZuB2kHCe9mm4e4NazozQYFjGUvLVtixLBThsFDAD/+/w38RrmkNEpZ6IFMhYM9ZhuQBnwuHf0M7Mu8IIxvtmWJmmVmsMfydUj6/AisrUF/PPWsb8zsLXzrgBHRo9/TZ9OWa47HHZxcQLN1Su4ZI9J9pEKVilLxwx/cYU78WXo3CCFL32RgEY/XboPPSpndSETJAZfQFmr9JxxroRPi04nd8133v2rilCsyfi2vVX1frtep71YhXq4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(55112099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEk5QUFFY2Fad3BNbnFDeWp1M1NvNVdBMUF6VzhmUmtnN2dBdXRsZVpvb0xS?=
 =?utf-8?B?ZE05QkVYRFVMMmFoUVVIOVhRUTh6bVdrQWp2VVN6cVk3eHhqUTBnZExqUlR3?=
 =?utf-8?B?ZVUwZnRObFl0SEpZaXVLUXloejhKbzJEYUVudW94RnVqU2NlRTVVKzVGdkl4?=
 =?utf-8?B?Tk4wa0RwcEFEZ1lOeEVpdUhWVzdqOVRCVEI5cUVQZ1lpbGV1bE1mMFRvZVQx?=
 =?utf-8?B?OHRWaytuT0JHcFpNWDFON0pIdDZqdW90ZEVmUWtCTCtqUUZpNWpGc1QzMWRn?=
 =?utf-8?B?T3V6a0ovZ243SEVTdDRNVHd2QVJLY3JOQWI2UE5Fd0xpNlBhekdjRXdxOUlw?=
 =?utf-8?B?enJpRDRldHlySmxOcHlzdHM5Q2wrMVIwV0QvN3dXZlJHaXB4bEwxYjdYOUI0?=
 =?utf-8?B?OXJVSUtKdkZ3ZHJSMnJlTloyVFVMTVVTQUswVEN2em1NQ3NyNDBsVkV2bXRR?=
 =?utf-8?B?RmdSQmhvd3VVbGFmam5NMVpBMzJadmNZekpZNzVvSFkrd2JDcEN5RUI3MFBk?=
 =?utf-8?B?THZsTUFHbEprWVRmM0lGTi9uaDhqMml5azBZTEszSFVmcXpXRHV4d2lxT0ZL?=
 =?utf-8?B?Y2dwblZ1S0xGTGpGK3U1eDB3SllRMW9iYnlvSy9LcGwxTit1UTVac1hRT0pt?=
 =?utf-8?B?NGV5VnFnV3FBQjQ4SXBqMFBKeENiOGhxNDZIK0ljSzRycFByd2h6VE5CNDc2?=
 =?utf-8?B?OW15cXN4dFhBTHducis1L1NYZ3hpd1ZlWUZlTzZ2ak1aVlg2K1JuVDZHcVVD?=
 =?utf-8?B?NkdTeENxQlUxUzV1Z2JvT2RJUlNwSFBPaEdFYVJMc2lOS3krUHZRd1llb3c4?=
 =?utf-8?B?MThoVW5RWUMvN0FWcVN0TXF1dzlWZTEyNDd3OEJManI4cjRsR0JYNFQ1eGNF?=
 =?utf-8?B?dCtGUDJFTE5vMFl0SkFCUDlYNHA3bWFybFZhbUczZ2hobzI0SlZMTCtTN0xn?=
 =?utf-8?B?cndkdHJZTjk5RUVmRWUzOExPcjlqbzUyK1JWMksrUE1pSUl6cndpQnkrSmVG?=
 =?utf-8?B?V1c5NjdLcERVZ0JPa25DNzFLSTd1OUNoSjBqcG9HT0xLeUIzSm13eHN0QUd2?=
 =?utf-8?B?ZTc4ZDBYTmNicHNWSjhyS0pDaGt0enNrbkFDTjVKVWpJTDJxaldCcHNPR0Jp?=
 =?utf-8?B?a1dRQjdZcmlxY3RkQyszUVIwSDgyN0crMTZmRnduRjlOUTc4MmFva25WOVoz?=
 =?utf-8?B?WFM0V1dkQUFWSjhqMDhhcHZOclIzay9CMUZWL3ZQS0JKYW9oZnhRTTlzWXN2?=
 =?utf-8?B?OVBpS25jVnBUN3Qyemk3TkxqRzQzODdRK3VaczBJbU1vUlZKeTM2UXpnN0JL?=
 =?utf-8?B?NUhoWWZzMFlOaU5GcE8rdjZYTGlhU3VibEUxVm5mSnJRMkRLN3pXSi91aDZQ?=
 =?utf-8?B?cXJRaTI0OC91NG50M3J0a2lXZW9jOGU5blNGNGp3Zmo5b2tyaERzVHFPNzFa?=
 =?utf-8?B?MzZPckNaTkR4ZnNRTmMxcE5ScE1Ga3Bwb2JZMkZEa0NPOHg1VVEyQzB5V2VE?=
 =?utf-8?B?QjlFcGNneWZLeXRnVHJKWVVldkVQS0k3eEZvR0RrVk9VeUxPZ1pLdGNhR1Rx?=
 =?utf-8?B?bnRYTDNiNU1SY2kzeU4vMWVROURtQmpVZlhzK3YvZkJIWUVYb0RDU0c0NmZz?=
 =?utf-8?B?dk43aXRwSnNhMms0bDloNmpyb0piOU52VmxzN0ZpR2o5aU1TeHp4aHcyZ2pJ?=
 =?utf-8?B?NURQcGowK2o2TXhsR3J5dU5mencveEdoS1ZlbkwzclZoNm1QdE94RmErNEZI?=
 =?utf-8?B?QnM0Z1Bid0VhYXJKQXlFTGZNTjkrcWxqQUpyOWc0WFQ0eTFMSGp0T2dFN2s5?=
 =?utf-8?B?c3pyRWUyOU83WTQ3T01kTXVtbkFRZXZjeWo4bmVDM1g0UlpOdCs5amhNZGZI?=
 =?utf-8?B?TXM3RWJYOHp3VndjbGFEZW5pNFVXU1FtY0gwbWpValhldm1sYVVlQ1c2ZmlT?=
 =?utf-8?B?TnhpWXJyT3AwaktHZTd0NEFtbmk2WVRyVEtObmZla0xUVkVrZFliZ1ZJSUZi?=
 =?utf-8?B?bnB0RWpDdjFSOEtwWnRXeXhueE1xb2FYNmRQbFJyd3Vpa21kM21wM1A4N1hC?=
 =?utf-8?B?N3p3bWpUQXo3QlVMRWVUSzJON2NQRTBmSHFNU3krNUVuUytGQitSeElBVzVk?=
 =?utf-8?B?amtPRlgwUE10cjUxcHd4L242azEzd2thNDhWSjV6TWZPQkhOTzRVOU9NWE9r?=
 =?utf-8?B?Y0o2a01SVGJmY3F5L2ZSc0h0S2RDZ0k5NTllajNwbTU0cm1oTFQxeEw3eTVs?=
 =?utf-8?B?MitTUnFFc3dQVm1sWEZvOS96MW16T0hlc08xdXB2WEVMUUd0UHNRbndrRzBw?=
 =?utf-8?B?Zk5UcEVhTjdrc3hJc2NyQzI2bm9jZlpOd3drVkRYMWpPdU9nUFBkb1k3RzBK?=
 =?utf-8?Q?sDbskW5WweJYycE8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b009fc-a25f-41f3-09ce-08dea4d8682d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:44:10.5298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwUyi0ZD6m5sTqKyx74jtG5xmoLwhObGkrfx5bMSeLadzozWOSMZcMShCIYhGqY4y2PmSj+QcWPM00Kf3UmlKKN5sc7oTsJjBdw8jDyYDAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5271
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

Hi Michael,

On 7/4/2026 3:15 pm, Michael Nazzareno Trimarchi wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hi DINESH
>
> Your series is here, I will have time this week.
>
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-07042026
>
> I need to take care of other patches too. I have some Easter stops to
> address, and I also have other patches from Bootlin to finish
> reviewing and others to queue this week
>
> Michael
>
> On Tue, Apr 7, 2026 at 8:41 AM MANIYAM, DINESH
> <dinesh.maniyam@altera.com> wrote:
>> Hi Michael,
>>
>>> Hi
>>>
>>> Yes I have two series on my queue, I I will work on them this week.
>>>
>>> Michael
>>>
>>> Michael Nazzareno Trimarchi
>>> Co-Founder & Chief Executive Officer
>>> M. +39 347 913 2170
>>> michael@amarulasolutions.com
>>> __________________________________
>>>
>>> Amarula Solutions BV
>>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>>> T. +31 (0)85 111 9172
>>> info@amarulasolutions.com
>>> www.amarulasolutions.com
>> Any update on these 2 series?
>>
>> Regards,
>> Dinesh
>> ________________________________
>> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
>> Sent: Thursday, 26 March 2026 1:57 pm
>> To: MANIYAM, DINESH <dinesh.maniyam@altera.com>
>> Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>; Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genoud <richard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>; Miquel Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boon.khai.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>
>> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND dependencies
>>
>>
>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>
>> Hi
>>
>> Yes I have two series on my queue, I I will work on them this week.
>>
>> Michael
>>
>> Michael Nazzareno Trimarchi
>> Co-Founder & Chief Executive Officer
>> M. +39 347 913 2170
>> michael@amarulasolutions.com
>> __________________________________
>>
>> Amarula Solutions BV
>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>> T. +31 (0)85 111 9172
>> info@amarulasolutions.com
>> www.amarulasolutions.com
>>
>> Il gio 26 mar 2026, 03:57 MANIYAM, DINESH <dinesh.maniyam@altera.com> ha scritto:
>>
>> Hi Michael,
>>
>>
>> ________________________________
>> From: Tom Rini
>> Sent: Wednesday, March 4, 2026 10:39 PM
>> To: MANIYAM, DINESH
>> Cc: u-boot@lists.denx.de; Marek Vasut; Simon Goldschmidt; Dario Binacchi; Michael Trimarchi; Richard Genoud; James Hilliard; Miquel Raynal; Chee, Tien Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI, ALIF ZAKUAN
>> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND dependencies
>>
>> On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wrote:
>>
>>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>>
>>> Fix and align Kconfig dependencies for Cadence NAND in SPL.
>>> Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
>>> non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
>>> keeps SPL Cadence NAND support self-contained.
>>>
>>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>
>> --
>> Tom
>>
>> This patch has been reviewed by Tom Rini.
>> When you have a chance, could you please take a look?
>> If there are no further concerns, I’d appreciate your consideration for merging.
>> Thanks for your time.
>>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
>
> Any update on these patches, do you able to merge it?
>
> Regards
> Dinesh
