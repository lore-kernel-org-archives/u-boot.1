Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9D4C47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 12:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A8D8747A;
	Tue,  2 Jan 2024 13:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHy0CGeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F028770A; Tue,  2 Jan 2024 13:58:23 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC855869F7
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 13:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJGZcZMwtOiaTUb0jmTmFMSI69BaijL6PjWBuIO7Y7dLuX5/L3nd/eXUqpYhi5GBLVvJfhBb/8m0ME2qNwfVaYJDwK3OiXz3AAoqqIicXbgup8gJoAs60dzO85pxJ6J3PGtEBFnmYPuVQqIllhhABwHWCxIsdP/kTWtaZEJZnzfqfCSOj9Blcw2lCxW0AfWeKEX9z72TGYY3lrj6pfW34hv0lTzwvGU2xItCuSXBCHhMlVdotO8NfEuXyLlsV2BYHT4vGfpktJoiL2kY2q3dKXWMoKxan0C/BZuZGPgomOeF/1poORMbL6hZADtPrlndSTKK01HdwcwaUW/EKp0mcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy/Degshj8dwL9nA2PVzv/12T1JFq3gi1RN42l8wm3M=;
 b=RjltgvQ+iLhhm0YWY8SU2jCssvD/qcYBfJUHfnId+HliPR0H9LkfOswWOPBn7aMUQ9WtTC7lvjnT33lX9kJzgsqFvgCkzLLTftUJ7xoBDA1Y8K3CzGROLhOsMrTC5poTPN50zaggULw3nbb6vcjZhkSsQ2xKPqmQtGtOtcI//fklCIECPXkqlavCqZL5AhbSQuk5nV8tzET+eAk0WPGb7Lb2gMVwa6R9IXmPV2emYGk3y6CJr/WRWSNTlWrv+cc9UoRYr5Xj7enKV6pdqDxJuMd82XPDEUsTZPz6B+x39lu7yDhO7rfFdVJ705AjrDkvnxI24ymyHY8ziRBUR9wZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy/Degshj8dwL9nA2PVzv/12T1JFq3gi1RN42l8wm3M=;
 b=GHy0CGeuSbnFp3iF1BD7CgstxY3jDq6oMnqdX0X7CZ59ILQ2X2dmq8mSYU3ZcJzqXD1iwA6gnStP3FNKEQAxdhW783K96zDorruMD4BMWbCY4+LJvM6iF7YFeBpP3ya8nR/bAHCaMJePiL3yMuyinfm0XpuJqAZWtWS73gnaKm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:58:18 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:58:18 +0000
Message-ID: <9b2be47d-805b-4cc4-b061-ce1dcc85e501@amd.com>
Date: Tue, 2 Jan 2024 13:58:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] microblaze: dts: Use the normal build rule
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Michal Simek <monstr@monstr.eu>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227082405.2202246-2-sjg@chromium.org>
 <20231227132033.GP2652760@bill-the-cat>
 <CAFLszTjLVv0P2Q-pwEZvBkmHEWYX=Gg=wvPAvKpKFjiYJwPEeA@mail.gmail.com>
 <20231228142614.GE2652760@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231228142614.GE2652760@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 52618d75-551a-46e3-89ad-08dc0b927dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kc3YOkoaNFya8/hc3oQVJdZsLFnP+KCff1ZdJumjinCPDpr5ACWX9Jmf6Qy0L0bxzQzD2/DpfR/8qKo61VH12WFXSDm5XqGYLo6P3+DsZ0z/6akvUgt47NJAdifXGypVoJaC9XUkCIscEGx7IVcSrrPoRIo43c1VWReZps7sq8sl9oKAxDGEQFT98wHyEAJ0Cis/NbFew6Q4mTWGR1ONqdvfdSS/EWqBLvTbH1Aw+9SrHIvVbEEZR4MEWA92apfkIZuSY8GGmBWeIJuf2lp39RO1XkSIX519lJAQewDsy4AztVLt7tI4oIKY4tgsONcPyKY8VkDyLGWGCSME7z0fZW4bbC9LbyLjnc4qXMH2+LYbKCvdm4+UtTvlHx/b7FB/IjroZlUHDOGXqCd2gHyjJNJ3LM/tWRvyAWjEvMetIulwQBn9vjFeUldBsAsYqUVf1fJMjhcQCOzD/LL6gH4SE1POutJZp+4ogBnKvAxJpSvftbKCKjEM5VBIKRReoQm//mQUlaqd5Sj+ExOIwTdAvdA+KcK4khMnaMYmh+WdaDGArPcibsfWITPfUnr0xrZKw5QUpRj8qSqHt+DnsVmd47UiRe2tes9GxgtjlCiXYSXGJmDJFNDh5d1WbogcKBvAFW1ZjBjy/DUNpvARkBPNwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(83380400001)(38100700002)(8676002)(8936002)(5660300002)(44832011)(316002)(54906003)(110136005)(4326008)(2906002)(41300700001)(6666004)(6506007)(6512007)(66946007)(6486002)(66556008)(478600001)(53546011)(66476007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pUbitCalY2MWNKc0FFWjBQUGo4eHZPem1Oc1JKeFNPVW9aRkdHY2NqMmtW?=
 =?utf-8?B?VjBQQm1tdUw5MVZyR3FNMDZmWXpEWGJLSXhnSzZKVW9ia2RJU0Y3N20yWklu?=
 =?utf-8?B?YjZ0djFpcWx6RW9QbWkzZWdSMjdwaTlVMlhZQ2JzZXZZZmJwTEtyMGhlQzFS?=
 =?utf-8?B?WWYzeVgzYUtrSG5RR1RoQmRVQkgwVWlJREZGNkV2cTF2blFYRXJtclJjSy93?=
 =?utf-8?B?Z3FsSjQrRnlEeFl5SXVjMmJHOU1YTTl4MmpMbmU1RFBIV0dnZ2ZWUUtSUi9U?=
 =?utf-8?B?ZTE1MksxcUtuaFpPTDZNRlRCb3k2ZE45dFFhMnM2bHF5YXlyT2ZRZ1NIbFVm?=
 =?utf-8?B?a1hOZElxdTdqaE10L2dLN3U3NEFhdlAvSzRaK1hOTTRXSmRSNTBEaGlVSTlC?=
 =?utf-8?B?aUh6aW00UW90RkM2TldvWGxVaFBJSXMrNHZKZGxVeGkwSTZhdW5FSDR4RkNv?=
 =?utf-8?B?R2NEditJQTh5UDh4K0kzUWwrQi91bFZaelNMTVErTDh5K3BBRDQ3YTNPRGlu?=
 =?utf-8?B?am03ZVhkbUtyWGxzL1R5MFZ3RUFDcmNSWHJDdk1teHZHcXd2czA1c0lIOEYy?=
 =?utf-8?B?RVBNNFIvSTZUeWhsUmZSeldmQjNuS09DUkF6OUxqV0owRnlrU0RIcnMzS25a?=
 =?utf-8?B?Vi9sZjZxNXBpa1BrekRVT2p2NVFUWk5GOURWbStFcXRYSjNDSkZ1b2dRc1ZC?=
 =?utf-8?B?emVhczYvUm11MHNpK3VQa1ROR0tuNkJNRmpnZmpkUkhobTJNU3dGRGFSWUJw?=
 =?utf-8?B?K1R6MFlwaC9ydXY5d1YrWlRwVmxsNXhzc3NDWW9vN3JHbFdKaGNuaWF5cTI2?=
 =?utf-8?B?cWtWRllvL3hnYm9GNmZkUFY2S1VBL2tTM3VPR0R2TzNxWTl4Q0dLYmVzdWZ0?=
 =?utf-8?B?N0lSTDUxNTVFMzVnYkd1c0Rpcy9HNG5Ic0h3Z2phRG5EOW11Ykg0alpodm4w?=
 =?utf-8?B?OFNXNTJvVC9aT1JvZStaMEtjRFlvSGVyUzdIMU9UMVpjbTJtMXQ0ZlkrQUdH?=
 =?utf-8?B?c1hIOC9Ubjhzelh2TjRLNEZXdEZoS2F1K3JmRlFjWk4vQjU0dlA2VzM0Q3FU?=
 =?utf-8?B?UnhGRndyRGg0RWNjTUtRSUwzVWcrR1pjVmVDZGpwRFJrUTloZTA1MUdaQUJR?=
 =?utf-8?B?OTF0ZWRCTFdndGsvQ1IzclZyeFF4SUNOM0FMNUZ0NHh3QTU0TDB5emFDVjdD?=
 =?utf-8?B?UkdsMDJDTmd0akhnOTk2ZWRVVFozQUxWdnVHbW1rVnJFVDA4UlNnTEVPSlpF?=
 =?utf-8?B?THFScEhqRkgySVNoZnlEc09GRmNWL29tZWtDMDVZMmpMVGx1UVBSVnVBclRP?=
 =?utf-8?B?KzYxcEp0ckJ0TUlXS3p3QU5vS3dPY0ZaVUtpNi9MUy9PUXNKcGxYSWVxOGVi?=
 =?utf-8?B?YTlrWURnMXVZbDhWT3JkcTVWbGlPOHZWN2tjdnV6NkUxeGVlVFB5K3ptWFR0?=
 =?utf-8?B?dzZTV1FqaHBiSEFsTlVNWkFUNllQcW0xYnVjM0J2UzAwSDY0b3Z1T3RJR0VF?=
 =?utf-8?B?S1dPb2ZkN0E1QzMveEM4bTFkS1dYamJ1L01XaVNON3d1OGIvSzFOVEhTNmpF?=
 =?utf-8?B?ZHp5SFhXQXVid21uQzRlUHVqVHUxSFdoY21iaHlSbjNSWmR3M0Jub1k0ejdi?=
 =?utf-8?B?UExwNmZkdWlBZ3VWcDlFUzlpQ0wwTCs0QS9UT2swaEErTm0wbVV3UU1aWHgw?=
 =?utf-8?B?WFd1SWpLR2NsMVp6dWdROTdSQklJZldVbmt5MkhoMVMrUU83bXdxUzNKQkRK?=
 =?utf-8?B?cnlmcmpiVkpYQ1pvT2lCam9EVkc2dXNPL0Y4eVcxS2NOOHBQMWR6dTVIb0Q2?=
 =?utf-8?B?YitNcC9MQkVmdkNtcDIvc1FxNWlVUitPN2o4TE0zWHMrTTMwQTRqclh1d2to?=
 =?utf-8?B?bEF4WmlQcVpIZytXcUU3cmk1VDdUVmlRTlJRY2FmYmtwK0hZdUFrdEZsM1hV?=
 =?utf-8?B?QWplVHh4VkJOa2x2dnIxZjNjMWZSZDNEMWYxb1owaUl5SWJubDhnRHdEVk03?=
 =?utf-8?B?b1FIVUJTdWFIeUM5cnFBUWc5TEthWHZQcS94am96WENMUGV6ckZUWWk3WEhD?=
 =?utf-8?B?ZG1YMDl4RGRrWnhxS2pudzE1bXVDYzdTaEtFcDFNai8vWEQwbUl2VExTVFhY?=
 =?utf-8?Q?ziWhvlowPN4IrCrbuSQ08t74Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52618d75-551a-46e3-89ad-08dc0b927dc2
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:58:18.3863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf1rinbzSOT4+Llyv5dZMRW58cQB8U1q3iL8T1PDY8lYHq7rhp8ccwp2hvh+Hkyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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



On 12/28/23 15:26, Tom Rini wrote:
> On Thu, Dec 28, 2023 at 01:37:49PM +0000, Simon Glass wrote:
>> Hi Tom,
>>
>> On Wed, Dec 27, 2023 at 1:20 PM Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Wed, Dec 27, 2023 at 08:23:57AM +0000, Simon Glass wrote:
>>>> Build devicetree files using the normal SoC-generic rule. For
>>>> microblaze there is actually only one SoC and one board.
>>>>
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>
>>>>   arch/microblaze/dts/Makefile | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
>>>> index 427a8f9aaca..adc76ddf21f 100644
>>>> --- a/arch/microblaze/dts/Makefile
>>>> +++ b/arch/microblaze/dts/Makefile
>>>> @@ -1,6 +1,6 @@
>>>>   # SPDX-License-Identifier: GPL-2.0+
>>>>
>>>> -dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
>>>> +dtb-$(CONFIG_MICROBLAZE) += microblaze-generic.dtb
>>>>
>>>>   include $(srctree)/scripts/Makefile.dts
>>>
>>> This (and nios2 and perhaps a few other arches) show that it would be
>>> easier to just drop the dts- line as it adds nothing over what
>>> scripts/Makefile.dts gives us.
>>
>> For consistency I like to see a rule for each .dtb in the directory.
> 
> Yes, and for consistency I'd like to see Makefiles be as minimal as
> required.
> 
>>> I wonder how this will interact with
>>> OF_UPSTREAM and how it compares with arch/microblaze/boot/dts/system.dts
>>> in the linux kernel.
>>
>> I don't see any interaction. Perhaps the maintainer can move this to
>> OF_UPSTREAM?
> 
> Well, that's the big question here, how exactly does microblaze work
> with device trees? The U-Boot one is basically empty. I think we're both
> going to be waiting on Michal now :)

U-Boot and Linux DT is just for reference. There is no really golden DT to use. 
Every design is different and I am fine with completely remove their content but 
I would like to keep just one empty DT as we have now in u-boot.
The reason is that when you have your own design and you want to test it quickly 
you can just cp your new file over microblaze-generic.dts with existing makefile 
rule and build u-boot with OF embed and just test it.

In Linux there is very old DT and I should likely remove it completely. It 
targets designed which were used a lot of years ago and definitely not passing 
any dt schema validation.

Thanks,
Michal

