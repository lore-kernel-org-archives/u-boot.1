Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09CAC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253A687C35;
	Wed, 24 Jan 2024 11:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="j3J0GKMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7A38718F; Wed, 24 Jan 2024 11:50:55 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A1F87BF2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfAycvE0m6Na+qZxkA5HQ8pa+txK2jWIrlnaa+BUJy1RH/YrI+XKESowpFzSpqjTy4ZCHJEKSNOoessE2wlh6a7cjuAE3AbNsD0ir/cQ3QARS+CntAehoij65cVB5PKDJdVlhHnwWsWYNk80KpNj5Kni1UDzvJ/CEa0OxvGCVewEVZnsyang5vA/GSHcBYGZj462sHqBZb4e42jFka/CgnNVY7OGtLf1kGvhBzU0j9NL+BQFSOLHQyjtKmTlDSwqwp9MjBsB6vo6EbIo55AAimf85g+TXtT+nJFICcsY1uMpVwuR6q0sQWvLpNxfpCJQVYYxp7FrrG033kF+aIxAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfENzIjsaUwTOwXmc3HE2tL7jOYt2F1MPGfUn1nmOAA=;
 b=egcYaAfFO4Kv6L+xMLE1XVvQy1B/z6gEbZBxxM2p46YP3pkWbvJJd9EEAhAckb5+eW1+RVohlAvCkMth2b/hHVgWcfvz//WJG1fl/4jyI91dRcdNESzxbueoRmsLtJ0A5uEygr829qYcD/UL2Zc+C8Yab7pwRucRJTyvg6uwRErdb5V/NaQd8G3j2LIiOVwBDG8uD12AYfcptXM0Hf8cyRhKy9hQ+3+t/2zL4D+wEP9L2BTkKxze8T9zk82qWNXcuHHECh7TjREA5aJ0rB0HOYgonfo0tkmLrHojnwUgCEGQwuc8D7b5+staWsvYFGGjXwTW/88eUSNVFzgjgQaKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfENzIjsaUwTOwXmc3HE2tL7jOYt2F1MPGfUn1nmOAA=;
 b=j3J0GKMN6+exgal2pMAawDJ5P2qj3hUymomFsNuzXuuMK8tcwVm7rq1493soCCA6kRXlR5B3w0DkWYDyF4rEMny2q1k0w5yqTnfHnybSnO+rx4Yass6hV7tVESs3N3crNKmdJMgjc0uHF0y6K/t/dpHvmQQ4jIZn4ydD5Ey1kp4sGqF83ARkIxE9W6cSI/Wmdv3fc65AH5zSKSnYEb7R+s+pnS/5nDp5898xj3nScwcKZdPcP+s26PX0Az3UQYxtIE78U6p5y3Kfn9NEBPilgcs3yPEVrqXBvFaG8VqrdeSogZTHiO2oCmFTP9EwGUAphwzmnlet8GXzKSVPbRreng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10)
 by PAXPR04MB8426.eurprd04.prod.outlook.com (2603:10a6:102:1ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 10:50:50 +0000
Received: from AM9PR04MB8539.eurprd04.prod.outlook.com
 ([fe80::708e:e38f:c656:8325]) by AM9PR04MB8539.eurprd04.prod.outlook.com
 ([fe80::708e:e38f:c656:8325%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 10:50:49 +0000
Message-ID: <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
Date: Wed, 24 Jan 2024 11:50:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
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
 <agust@denx.de>, =?UTF-8?B?5rSq5oWn5paM?= <hhb@rock-chips.com>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To AM9PR04MB8539.eurprd04.prod.outlook.com
 (2603:10a6:20b:436::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8539:EE_|PAXPR04MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5a30dc-a550-42c8-66ae-08dc1cca53a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCBbk/FeeWkLqmbRpLAwpU15XAbz1AA6bkZgerjthPpzqSadcrMReIMecsstWAu+mhRkbFW8CyIKs9zNts/JXVwcnDeCs0QWOByRobr8WX4GEo/7FUcnWacK6Z4C3Ftk/GOw23hsTW9Rj8F7HPzswuTJAAdiaKojehsNt9J9FPHJWZpXGSUpKIJoGdOx8Oo5c+KCjX3ltINYAlhk5Rwb8tUuqnLBe5fC/FBRevULtY/4UIpI5v1SxxM4JObPdGAb6CFX60RIpcaTWM928PeZHPRVyJnFXdohFVCcm2dhFRSqAXUCqMUgqZEc4QgnvX3vNaQ2BBG/z1Q2UtTT+ayLYrPCvu7SZa1qPRwpnyCpzzvA4Z55BBMDUIwqCOzbeu3T9JpVARkVqod2UgcvxeFcFCPmY1o83KRULMk4H/k6kOPY2V/K0z0p7FBump/wMkUOKNPHRXfPd1WJfKmSe9c+X91se4DBKcF/d2W3edGaXqJXKlMnlxkB9Fzm5TdEOpTvSZmN6EOaumIIspL3++/UafjQd/OJ0DDUytsGUUj0/YInmdkPLD4Y/Hj6ooFMxDZeQiQW5vwgi+vex0x+bj1KIQD3AROFTCJ9Ij6fvj58PHMs9oMMO3/ZQCCsK9Lt3shCKSkCgeXHrUGDf8xVYDuhgExT9s6zm2y257pHQ0mP4SllPjWxZIrEcxLOgaAF1+ZT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8539.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(478600001)(6512007)(53546011)(41300700001)(8676002)(36756003)(6506007)(6666004)(2616005)(66476007)(5660300002)(110136005)(316002)(66556008)(66946007)(4326008)(7416002)(8936002)(2906002)(44832011)(38100700002)(31696002)(966005)(86362001)(921011)(83380400001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ZXTDRRYjNraG5KSUg5WDdtY2pnL21GTWtGT1FHOEl1R2RXeTNLVEtpNDRp?=
 =?utf-8?B?WkU5dGo0WW45V2FxS1VhTXo0YXd3OWhpWkhISDY2cDVLWmN6UUJtbXYvaWJ2?=
 =?utf-8?B?WWFqb0ZvejI0cTNPMk8wTFBmR2t5RDIxRmRrN2JoU2p1cG93Yy81YkxZZTAz?=
 =?utf-8?B?bU80YTRvOE9PRXJwVDA2ZFFoZzUxckdmS0M4TlVxU0FZS0w4SFJzampvTFBF?=
 =?utf-8?B?V1dRYWc0TWc2WGJRTUVuUjZyRFplNVNXSVlFMW5KYVpOWmR5aTRJWkkvNElT?=
 =?utf-8?B?eHFTWVhlSERjS0ZpUVVpbE1ZUW9JZzQzeWY2Uis5MEZYbTZIblM3OXJLVFJF?=
 =?utf-8?B?eFhYbk4rREpMdkpaOGRtand1WU9xdVluM1ovMEM2cFhDQjZucW5ndldwaGln?=
 =?utf-8?B?eXV3cjN4VGVuZ25rK3ZRVVRsaFU2c2JOYkU2QTVXMlRXZlduSVZhN3c3ZWhD?=
 =?utf-8?B?VUZYZGZPSVNWVFRQRUdEZnZRZXlaSDJJTXdxN2Zjckx3TmE1WFRHd2NFUEFy?=
 =?utf-8?B?d1Zid21rU2U4WnFxVnJQVVhPaXg4R1FYTnEzWjhnWW5EZ3JKWWpSbENEWWtt?=
 =?utf-8?B?QTNFM0VSK3FnTm9OSU1OTllNTDc5eXV5dW9QZkNGT1JYbzM2WmJCQnlCRlhh?=
 =?utf-8?B?SE1SQkQ1ekhCMVZFakV0WDB1aWNhOWR4cUVYalE2cUlJL2VXOFFodGFrUXZU?=
 =?utf-8?B?QndRZFZmWWtjUFdud2pnR2V2RU8va1IxZ2M3VGxXSmZxMEI5ZzBZTVg1ME94?=
 =?utf-8?B?cU1WQTQxOU5oS2FYNWlCM3lXNDFEYTNicHcySXVCWXpHdDluNkZ6U0ZkTFFu?=
 =?utf-8?B?Q3daK0NIdUZubmZXU3UrM3h0ZHlheTd1cGY2RWNWVjdTYmJjcE1TQWd2NWk5?=
 =?utf-8?B?VmJqYkdsSUhuZXZhck5WSU43OXU5WWhUS25ibE5WMWdHMTF2TUFUTzZiNjJq?=
 =?utf-8?B?NlRIZkVlM1RzZ21jRmU1WU5Bd0lqcWgwMDlhWmtuQ3pML2l0YU5qbjZmMHI3?=
 =?utf-8?B?Rll3d2lxcENoTldMeU5iM1RaTkJXNWlJbTZ5eUlJb0JtOUpTcHI0ZlMvWVh0?=
 =?utf-8?B?a3hmMUFobFB6RzZkNS9vcE8zSSt4ZVhKWnJHTnpHdE81TXFmclFvRG03aXYv?=
 =?utf-8?B?VjNNcXFwSlJBcjNBeVBGbGFMM3dwMHdUN3N6WjBLMVgzUFIzNVI2VWJLS21D?=
 =?utf-8?B?eXU2eitUeXRoU1JMbXY4ZnRzSXRrV1pqNEV4ZWFacFp0RkwwQ2pxTjdMa3JK?=
 =?utf-8?B?Qkl0NGk1alFRc3J4L0huWHRLUmppQnQzb3ZXSFpXMkZoN3FzMnVieTUzSjU0?=
 =?utf-8?B?VFp1a1hsWFhxZCtoajZ2UVR1bis1ZXNlSThUTi9aY0o4THBxWlB2UEJLQ0Jr?=
 =?utf-8?B?R3EwZlpnTFEzV0Jmc0hWSUhFWHhwWHk0dzBGc0ozK3dqVjFCYi9scHJINmZT?=
 =?utf-8?B?by85MUdFUkdaU21oeFNtb0N2Qy9GVmNEMmRVc1hYc0w1MUE2SEpZS0tIelZT?=
 =?utf-8?B?dGgxYzd5SHIzVkFTR3JDbjFBcXNRSGdxYVJzQWhPSTdNNG1uUDExekI0OG5w?=
 =?utf-8?B?NWpzRExSYURZMXFQYlpCd0FES2VsR0F5QmxJVk9ybENLQzB5K2xBZnhIVTNr?=
 =?utf-8?B?b2l2MEwxek5BVm9KdVptT0pBYU9VS3p3MUdvQ2Z5VktoTnEzbE1nVmhaMnNI?=
 =?utf-8?B?Y0dsQ3F1SG9sL2xEM21IdFJIT1JaSDlUTzhEcC9wajdIVzhaTkdlaE5PT2J6?=
 =?utf-8?B?c2xzQXFwM3RwRCt1WGo0VjR0c1NUa2NKUVVCaEtCT091YWs2MVNLeTRtSDJC?=
 =?utf-8?B?ZDkvQW14WTNyMnFLUUpFYXRPTlN5Tjg5NlE1UENyS29kUHNOY0F6M1dGdWlo?=
 =?utf-8?B?ZDJvcUZYb2ZvbFRiWTZNaU1yVWNtRW9QUkQ5ZVZRWENnMnUrczF4c2RDR0pz?=
 =?utf-8?B?WWp6OElSL0dWU3VMVCtSUzhTNFNydjFCaTF1RktRZ0xac1JGVmFadDdQekRQ?=
 =?utf-8?B?UTJjRTJuOU1HU21oekJySlVIT09iOFl3MFBGM0NaaHYxWVNMMmVMdjFIRGh4?=
 =?utf-8?B?MjM0ZE1YOVFjQlJRMVNZaGsvYUg1YjFGems4NVM5OTBsYkNKalJnQk5zOHBT?=
 =?utf-8?B?M3ZmS1Q1dmdFQkpFeEpGR3pYeUJkTmVjWW82M1RuWWF2NUFBUlJJY2ZMMlNu?=
 =?utf-8?B?ZkJzSnYvd0ZLRmc4c3VESUdJMW9JM2s0bXZDbWk3eHVYeVdwTGhBTk95VXF1?=
 =?utf-8?B?UTg4ZXduWFNKeGtJNGxRZHZzWHNRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5a30dc-a550-42c8-66ae-08dc1cca53a3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8539.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:50:49.4717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqQcNtZkGKyLTCkXAzY+W+2ha8bMIWX3MiOZoYhu5vxSvAZ0JPN9zW6NY86lnKy/FIwbqAnVGFhJvCeerC+o4TJOkqkbsgsdfmrf8OHZjirZSiZdsJ8h3qEPSmBradgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8426
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

Hi Kever,

On 1/24/24 11:19, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/23 22:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
>> work really well.[00] The Linux kernel disables it for all SoCs[01], so
>> U-Boot needs to do the same in order to fix issues related to SD card on
>> RK3588. This autoswitching is enabled (by default) via the force_jtag
>> bitfield in SYS_GRF_SOC_CON6 in the TRM part1.
>>
>> For some reason, when booting from SD card, the BootROM does mux the
>> SDMMC controller in the proper configuration for the RK3588-Jaguar. But
>> when we don't boot from SD card, U-Boot needs to set it up correctly to
>> allow accessing SD cards in that configuration.
> 
> Could you share what's the really issue you met in your board?
> 

I revert the patch and then I have the following when booting from eMMC:

"""
DDR V1.11 f1474cf52f cym 23/05/09-11:02:36
LPDDR4X, 2112MHz
channel[0] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
channel[1] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
channel[2] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
channel[3] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
Manufacturer ID:0x1
CH0 RX Vref:27.1%, TX Vref:21.8%,0.0%
CH1 RX Vref:30.1%, TX Vref:20.8%,0.0%
CH2 RX Vref:27.9%, TX Vref:21.8%,0.0%
CH3 RX Vref:31.4%, TX Vref:19.8%,0.0%
change to F1: 528MHz
change to F2: 1068MHz
change to F3: 1560MHz
change to F0: 2112MHz
out

U-Boot SPL 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
Trying to boot from MMC1
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
INFO:    Preloader serial: 2
NOTICE:  BL31: v2.3():v2.3-589-g3389cfdda:derrick.huang
NOTICE:  BL31: Built : 10:14:29, May  9 2023
INFO:    spec: 0x1
INFO:    ext 32k is not valid
INFO:    ddr: stride-en 4CH
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    valid_cpu_msk=0xff bcore0_rst = 0x0, bcore1_rst = 0x0
INFO:    system boots from cpu-hwid-0
INFO:    idle_st=0x21fff, pd_st=0x11fff9, repair_st=0xfff70001
INFO:    dfs DDR fsp_params[0].freq_mhz= 2112MHz
INFO:    dfs DDR fsp_params[1].freq_mhz= 528MHz
INFO:    dfs DDR fsp_params[2].freq_mhz= 1068MHz
INFO:    dfs DDR fsp_params[3].freq_mhz= 1560MHz
INFO:    BL31: Initialising Exception Handling Framework
INFO:    BL31: Initializing runtime services
WARNING: No OPTEE provided by BL2 boot loader, Booting device without 
OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:   Error initializing runtime service opteed_fast
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0xa00000
INFO:    SPSR = 0x3c9


U-Boot 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)

Model: Theobroma Systems RK3588-SBC Jaguar
DRAM:  4 GiB (effective 3.7 GiB)
Core:  327 devices, 26 uclasses, devicetree: separate
MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
Loading Environment from MMC... *** Warning - bad CRC, using default 
environment

In:    serial@feb50000
Out:   serial@feb50000
Err:   serial@feb50000
Model: Theobroma Systems RK3588-SBC Jaguar
Net:   eth0: ethernet@fe1b0000
Hit any key to stop autoboot:  0
=> mmc dev 1
unable to select a mode
=>
"""

> The SD card will need to enable SD-DET for SD card function int he 
> hardware design,
> 

We do not have an SD-DET on that board, this is not possible (the 
connector doesn't support it).

SDMMC_DET/GPIO0_A4_u signal is pulled low in HW if left floating (the 
state by default since we expose it on an external connector) but we 
plan to let customer use it as a GPIO.

> which is rockchip reference design and followed by most of the customer 
> and boards.
> 
> This feature works in all the rk3588 boards we known, and no need to 
> disable this auto switching.
> 

This is clearly not what people have experienced, c.f. the Linux kernel 
patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/soc/rockchip/grf.c?id=6f6878ec6faf16a5f36761c93da6ea9cf09adb33

Note that jtag_switching has been disabled for all Rockchip SoCs in the 
kernel, for a long long time already, c.f. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/soc/rockchip/grf.c?id=4c58063d4258f6beb4fd5647db6b58f49e337c8f

Cheers,
Quentin
