Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B810C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 17:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2317D87C2D;
	Thu,  1 Feb 2024 18:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZmVhx2r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 240D7877FB; Thu,  1 Feb 2024 18:47:01 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CD987C2D
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 18:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC2orQ2Lb2zmmGS89HPxfE8Z0BVT4HTFNZetuMK6gk9WlpTRyEpRIM6nhDYS6VOsBT8lC7Un5In9J8+cqmgwhl7VmtMBjkygcNZOveXZwPaN01jb5Di2TMoQM7jHNte1E/17vnucWvLWhQAOqKWRNHltOJfxKv3sKG/3d7SbBqMw20ymwO5AWMAwb5REJdgBZc8HIfitI4bTjiqGzW2ewgYxQq4WADtyxlp+5FtQmKSLAeHy52jsDcm7qLNn321277nFlqBl3RsCzXf7rsiI9pgGXxieKqpUOcokExRuANTL3c5Ee2ICZ8HagpAvOGdaTu9NZIxCYiz5NiHCj9nkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR13rfS/dMSZpDw+JJOT2AkQNTkuOerHUgdCEY5fn8E=;
 b=K576CZc1UCaO+gxBoV+WaXBvF40ULXFUBeu0fF3SgOywEt2Xrzg422YJmsFTEv8QYht1MPr2IjxzrhW2lhiiZAi19glUnp+TbJCjtVrjGiwmAHnL2qnXRnL0LyZoRw8GWSLA+jXzpPKoH18TRkT5xNAR0nTspeDkUUpJDkGRm5Mo34PQEer0MWQL3sq5JVdXFkb0nNXD2pSxjG/J9O1eipUdlQ/G9FT5igV+5AVboa6L1GH0JNEjpz4NVTIjzTO4Agy2J3W/uhPIRbN2UOuCtBbkXFczZPG0mVmuC98Habwlq994o2k7vMo3PPXCKZ766T9wH3ZMjIXxZCYHh3IWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR13rfS/dMSZpDw+JJOT2AkQNTkuOerHUgdCEY5fn8E=;
 b=ZmVhx2r88d79PXOkcNjfAsPHWCKZ0px1uCjpLUX/AKIUIg0ROecgDyVil40n+cbA5ogS86wsgGoQzwiTXjRVm3ESds1AFJYAsULv+c4GL83AX32NKgP10dHhRNeogJdfBzUJN5ZstOKrWYRh7Kb6iQMq9ZMTkFTKQTZh0fT/zxkN94+xL4zl5FBTBHdYKegIVCAbpaSH2IX73IKgLMHvIBmrjduVJIq6HKg4AwTqjywE9eKBAh2413cCFN4qu81Vd7HXWhtmVsChqPhDuhbFOUSmc1JJhds6r74s7jKwSxqAFtQQbwEB0aV/WVZjWb51WPo0RXCqiGKVjWwOawhnEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 17:46:55 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 17:46:55 +0000
Message-ID: <4489aa5b-9bd1-415f-9bcd-32b8250e0024@theobroma-systems.com>
Date: Thu, 1 Feb 2024 18:46:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] rockchip: pine64: pinebook: migrate to
 rockchip_early_misc_init_r
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-6-1eec1c34953c@theobroma-systems.com>
 <86f059d7-c2db-4b23-bc50-0317c70efdae@rock-chips.com>
 <ef680bb049878ca5b97a2a257c918db2@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <ef680bb049878ca5b97a2a257c918db2@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa0b072-b816-47c7-9e50-08dc234dc7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cL5FHFb7YkOmsKlqbKpjkmgr9gqZpBtzS6lqtE1syTsOnRH8dkHXKU1I+co8pl4sFcwGeCk9Mr9gmZeS6e0d6BFR4Sb4jdU9ZrNn+bJV7zYJZV3mDkk/TU5qM2mmT9v7eUsUUhmPWgS+1yu71Cb7TezKhT8EXJ8En3rKIla5L6TaYQF2wTFUxx6ql7Dj8/Upo1UEgpEKOfBgcKq63kLRE1L2zEbuiSIafpIHyJ+KEmwOLMiUQUhP6qqUURgzKUEiYZi7mMptMiKE6GC9CHwLOoK47Drw2UNutaz2aCAzEzcaPxI1Jl0fd7weMPkwt7NAw3GXqLxBLELeY7KENmNSxLAskAgIRkmP4amw90z6DqIGOUdf++RKwzCttTmPrc1rvaiXOI9o2Y9Yfmf75vZgv8iIlBWD6UhLomkpqCbRI30Z0L7POmIuD3rDpbjPodHX3Pkt78wzd8qmT1M0EJgKax/KvccF/WJ0OoL7O12wvaBOpDURcLE4Ee2SdrTMZp6/H78P1YFp10PaGowGFfa/vq3XastPjeunw1P9bzdf0mvqhJH5KvyV8m/A9N5Cek5OHgcgHgKGCYh3e0tSRbIPsjv8FOH7v1b35CZDuiMXagpTbuRHm7gmdJDtd43bCv9chkBE2RavBE8TB9NcJq+Jg830DGShp1BZUqIx11cf9hSrg1V8obKPzJA0MeazcPQp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39850400004)(346002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(38100700002)(36756003)(31696002)(86362001)(8936002)(53546011)(8676002)(316002)(6506007)(478600001)(6486002)(66946007)(66556008)(54906003)(966005)(4326008)(5660300002)(7416002)(2906002)(26005)(6512007)(2616005)(6666004)(110136005)(66476007)(44832011)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3U5M1V3akdsU2UwVno5RTVURkFkMWpObE1oMXRrUDY3bzgzNHRvZ3hIS1M2?=
 =?utf-8?B?UjVNTEpSMzNjR3pBSm12S2RZTEx6UExkbjUrM2hsdG16YWR6clgrYXFBRlpt?=
 =?utf-8?B?QTFlS0lmYXZGaWlLbElNMUFaRnh3T0FiK3l0MFl1R0NxUjYyOTlxblpKTGhP?=
 =?utf-8?B?eE1kQ0RxcE1pa1BLUXM1RlJ2NUoyRnIwRm1vQ1VnMFRLOGJtbXNJc3l0dkNK?=
 =?utf-8?B?bmIrbFdxdVg4N2NkNElQZE43RGtLTmhibGxQazgzV1YzWG5udkN6MWoxMEFn?=
 =?utf-8?B?VUFFV0o0MkdvcGNENm9PNktySno4a2FSZGhSRHpHbzJaeVdMTkRSQlBrTk1E?=
 =?utf-8?B?SytSeTNpbmgwSnZhTnE1NHAyVkMvN0NkVkt5cnBQOThmRzR3MlFJZ0l6alQ5?=
 =?utf-8?B?Q3p5dFFVcy9HYmpUUGtwVVplL200OFMzaVpNVW1sQklzeWVmWTN3V3NQUzFo?=
 =?utf-8?B?QXFuQ0lhMEtsVVdYNEkvSjhyQnM1QURYYjBzSDRTa2JQeWFBZUZtUkxhTG83?=
 =?utf-8?B?dWt0MWdLTytqZkNrMGVOck1QbU42dnVEMXdXRkltSXdseVlPd3dpMjh3b0E0?=
 =?utf-8?B?S0t2QmM4QjhuRlhLTTFjOGFTUHY4MUdKc1Y4UEJTSjliWWUvYXRvWkFDbFlX?=
 =?utf-8?B?cm9pVHBuVjU0SXp1U0dXTTNmOUUxaFB4cGlUQWlDMDh5d2taeTdTUG5LMEll?=
 =?utf-8?B?TEcyYTRjOHBHdzVxTnBvdUY5MmluTGxRQitBdVRZaHdLb0hPMStuVEliM1d2?=
 =?utf-8?B?VlQxRjF6T3YrdFl5NFpER2J4NFVVaVRKWit4aCtIS1I3MmMvallNRzJueHNX?=
 =?utf-8?B?TzN1NGw0dkVlMjVmRWsyQ1RCalViU0QwVFNON1U0anBHOGgxZk41c29BZ0dI?=
 =?utf-8?B?czQxOTVPS21DUDJxbmFEOXA1SmtobWZ5Mkgvd2RiQXdHQ0MvOXZTYTJxaXdZ?=
 =?utf-8?B?L0FNOGxxMHpwb3lKSWc2ZG9UUmxLcXFqSzhSdFp0V2gzaGtPSytjNUpDbksy?=
 =?utf-8?B?NC82ZlpLaDRwRzlKZC9pWFBQdnk2cjFQWlVoT29rR3hNRVVPc3dVcW96UGFm?=
 =?utf-8?B?dVdZRU9hd29uMXc3UU9PeVhDUGxuL3AzckYrNVd6VmlZeWhYTlFLalV3K2dP?=
 =?utf-8?B?WU9xTmRKK1BGWHdIZXJiN3FGQlVYbFBJVWEvbjBsdklRanh5eVFhRlJtZjY1?=
 =?utf-8?B?bzNrL2V2MHIvMzJqdlNYc1RSMGFUYU5ZZWhyZHI1OWpFTW94TFRCaEd5R0p3?=
 =?utf-8?B?dDhxd2t3MjdtZjlONHZIdGZZTXlUMTdHREVQQjlnSk1SV1RVc3VLTXk4SWJw?=
 =?utf-8?B?ODMrck9TTW5nbkY5UlNvYklvWDNDLytFVUk2TG5LMXNrNnZoRXp4NUtZRDY0?=
 =?utf-8?B?cUZZSlZ5c1I1empmZjlBL012ZWRGT0JuV3RFSStlOFUrbEFhY2ZUYkd1NWc5?=
 =?utf-8?B?bVhyZVRNRmk4cm5vTXZlMFA3dkVsSEZHZjdYR2txMXd4SDROdlJuSDJjWDV1?=
 =?utf-8?B?Y3VHYXZLK2IrWm9nckVIcmI4ZjNTTEZTNTBPa2pwQzljQ2JIbGJSeUlQdkJV?=
 =?utf-8?B?MGVMU1d6NFY0S0k3TFIwZFRld0xLdXNVd2k5VnE4WFVDQ1I5YmtUdkxIeEEy?=
 =?utf-8?B?OENkWnpIZEtTNHRER0ZFd3djWlRjWER3V1RmK2hxUlNPY0s3Z1BSaS9KWkxx?=
 =?utf-8?B?R0k5dmhjZlJEVVBZWHEvTTRQdFZERHFBRjhtYlljTWI4YkNpQTB5N1d2VGdr?=
 =?utf-8?B?NC9iMzQyeTRHWUpjcWsxaUlKb1VHNWhRTjQrRzJ0bDlTM1VVU3d3ekFDLzVX?=
 =?utf-8?B?eGw1eUVCTVcxZzFtSVhibjQwQ0FXN1V6enFjbmcyY0pyWjNsanJHa3Y5T1hu?=
 =?utf-8?B?VzArbHFTM3c4eVYrazgyRHBJVDM2eW5YQVlOVnkrS21ISE5UT0JHRWw5WU1r?=
 =?utf-8?B?ZFVOM2p1K1U4NGdoQjE3SHh3eVRudXpKNE8yWkVTM0t2Y25MbUErcXIwU2VT?=
 =?utf-8?B?WEMvazVmZGcxODZGYS9IVDlCZko1RjNzeHk2QkN1TmlmdkFOcE0yNFdlYUZ2?=
 =?utf-8?B?WlhpckFoN3dSd0VqRXlTaGFxLytQOWZxcndnTmViOW1mRWt0RWlPVXd1VzVM?=
 =?utf-8?B?dXBJQXBITXlBOGcxZExNdklLZHR3ZGxtbmVNVXd4QkE4NzA2Nzh6S0xSU0RF?=
 =?utf-8?Q?JXw6yBJdhnUxhMb8wNzb2Q0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa0b072-b816-47c7-9e50-08dc234dc7df
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:46:55.5099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHFf1MYV3faiRjUOSQLwWrSrcPnQ6DswCfgBklTnxkwIoTjnKZKSGMVLnr8BErgldQ++wKEil02gX6oriG6P52fnqcuBU/9AI4S+rxXc+eVI4x9YwF9Pf5Ak2uUxRSeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394
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

On 2/1/24 05:02, Dragan Simic wrote:
> [Some people who received this message don't often get email from 
> dsimic@manjaro.org. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello Kever and Quentin,
> 
> On 2024-02-01 03:48, Kever Yang wrote:
>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> Compared to the original misc_init_r from Rockchip mach code,
>>> setup_iodomain() is added and rockchip_setup_macaddr() is not called.
>>>
>>> It is assumed adding rockchip_setup_macaddr() back is fine.
>>> Let's use rockchip_early_misc_init_r instead of reimplementing the
>>> whole
>>> misc_init_r from Rockchip (the side effect being that
>>> rockchip_setup_macaddr() is back).
> 
> We might actually introduce some issues with this change.  I'll get
> back later with a more detailed explanation, together with a proposed
> fix, after I check it all in detail.
> 
> This applies to some other patches in this series as well.
> 

I assume this is specifically about the migration to 
rockchip_early_misc_init_r?

What's the issue? And for which devices?

I don't really need this patch, it's just to avoid code duplication in a 
later patch but I'd rather not have this block this patch series. We can 
always revisit this in a separate patch series which can take as long as 
we want.

Cheers,
Quentin
