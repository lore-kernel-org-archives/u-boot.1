Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C5C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 07:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8232187A8C;
	Fri, 15 Dec 2023 08:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="co+k7+xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AEE8798E; Fri, 15 Dec 2023 08:43:12 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C49887A93
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT7sOaTcHK9V3BfTpQN3zKGmRm8RASHL1Ho8RjiGB260Cb/O8ufLMG74v8FNvHuB6doGHiTpWI6pPzM8u5zuUROAKjn4VngRXC5bDrXdZ0ho2okZiSs82aWVLuy7vKopJVzxaAJ2Weu/ZjZTnwkDcIZlF4efb8Hd3RFr2Dyl/ubs2g0nKNswiVeQVPWC8mJQmwUJ/E/+V1ivOx8b+F0GW6jupu+JAd3LWhIVoa1lOMg03D9AO9CsUAhI1I9XLUhnV7Mdo9mE9cdI+j8+yFJv1jmKxn0muZIErXezcJwaICvQYeTXdUw3znKje1Mj8piMunNlj6YEcpci1e6ae5KASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Oe1hDDEtN6X/+rKHI17EaJyoN9gC++i+Vz9h9/hv+E=;
 b=TBDQChnDJhBtDh3VnqjAgkYEL8tSywKw2fPR7jp9VgXvEglUZjZxtHtWt8dhBuowqtgYU95PGkIOhrMuS29n3PFYGLPFYUsIhjsxfO5i1hRJfyxl4bBzf3R1gY6oGKK66JzlKyx28MlK6AVAthkDNbFGeBdtSFWbRB4GOX9DeT9FsrJ4Hv8QCx7kE+9ETDZK8XHALUD2HSlX00YHFtfCe9Qpz0+Ta7yV8qD+kDW+PxiQhvrnBOUkmeTIrvsubDqWP9bm1dw3pcncmKZIF706r1+Vjhx1gbn2aSBK80KLOOQcDderb72686S8wJyF7KMbztOW/9w7zgOSNdCmWAVVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Oe1hDDEtN6X/+rKHI17EaJyoN9gC++i+Vz9h9/hv+E=;
 b=co+k7+xuObPLDmlVpkq+5uAUL4KQcFhMk+155QXy6zdYB7TJwsRuFDuDQWeetD7vgtT3KGhvioy2CIPjXoZCogWrOs3VHSjRXDppO8kG8jl6DAVMx3q985bv1mYULwe83SdtoqaZAbKuHy7OtEY1jDdhA0pDyHCVH++EueB2MEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 07:43:05 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 07:43:05 +0000
Message-ID: <17c59f83-d28a-419d-82f0-6be6734e797a@amd.com>
Date: Fri, 15 Dec 2023 08:42:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Content-Language: en-US
To: "Frager, Neal" <neal.frager@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>
References: <20231213134007.2818069-1-neal.frager@amd.com>
 <c2e4c147-9dab-4f11-8721-8f6aa52e3af4@amd.com>
 <CH2PR12MB50043CB2CCF03CFF39ED5768F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
 <a366b338-7e02-42a4-b5ac-b295c37c0dfe@amd.com>
 <CH2PR12MB500405650DD1385734E82341F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CH2PR12MB500405650DD1385734E82341F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 7782bdd4-6471-4da8-1079-08dbfd417900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3d84Tf2Ew8k/E5d4t8KBgbqboAfKUQnWRvLE0aUWt5Vc23Lhm+RaO5lce6MzpFibALKsNX3FyXLxz7ZrGbv+ySprlNjLSr4dcmAXkpFRBhwvlEuqXlERMt+FsIayGYZCBw5Mlfv6KZpzCy5HYtwZS4jv3oq6VAJzvZ1OUWXY4yI5R0f5qhy5dMeXNb9I73SIf0O/oRGidDQIfcoEaRoRv9oVMjh7+znSGw+ZORXuGdNF8xpkI2RfVBdQCvJo3hLdCBjkKA3H7D3iFoJkmiJHINWACLFji0bYZJ/ksipVJYkqavpIbpCH38C8kqDQFqQQRHpeuRtcCWVBZxzfTP4mrjV4KyCaenWMzGu1pKZAHFZ4ONaktudPkGo2ykdU5Q9rOkl+Zl4tu80/d5P/4/5LGjomUQk1uHWrydEXwpb6E/4W957ZFRy4MwMBSPVpIyjfSmS2GKnwyHfO6OEROHGvpuXiNHK4UQh1+2y7XsisP50pSHUsh+UIPkjAmy17kx98yenlbYrH3aC48m4vjHOPpZ6BPCPovukaA52Ai06/L78vlpFntj3koEpCphcDbuy8iq89L5erw3V77Dw6JEJCvmOU7G2vevcRtoj9L4YgYqvoORlF05ynLLlqXoqDjKetBLjSt0KiaX7AQ6nQaqIWug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(2616005)(6506007)(6666004)(53546011)(6512007)(83380400001)(5660300002)(44832011)(4326008)(478600001)(41300700001)(8676002)(2906002)(316002)(8936002)(110136005)(66556008)(66476007)(6486002)(66946007)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNodHF5QUlDWkRNME0waHNHODg1M3JXZm1SdDJXVVpSaTcvM1FQc1FrQ3U2?=
 =?utf-8?B?WVZOMHBWbXFDNFFBTzJ2dEc4bEJUNkhCdFlTQVlIL05TdWdlUlZFS1orZWlI?=
 =?utf-8?B?bzRqUWhQREtUWUEwUkI3anJmYTExSkw1WCtmTEx1N0Y4WkwrZVpya2ZXZ2dS?=
 =?utf-8?B?YzF0M0E0NG9hZCt4NjRHOUpOWEJOdkNVbnJqNEU4TXhZZzNSUVh6cEZmbkxx?=
 =?utf-8?B?RERaVFN4MVJsZHk1dFBTZ3I5Sk1jVzNWUDcyWEdPZjY1YWUyMmZBUGtNQ0c0?=
 =?utf-8?B?VFg1UVVtRnM3SHhZbzZQb0RZRUlvc2xNQVIzQk5WVlMvcHBqSElJM21UZUt1?=
 =?utf-8?B?ZXVxeHRlOUJnaldXNm9DQUVJWTRyYzFKaDd0c2h5VzZwdFJ4cDF4TXR2YUJ0?=
 =?utf-8?B?alppNFlYNHRmWmxXVjU3ZGhhblJjM2RoeWROZFVkRDhJMEdONFhQVnNmdnZV?=
 =?utf-8?B?SUtKa0M0MDIvbXN6TkZLYUdyR3EyZytLb2ZlUHZ1aTdMVVZHM2IxMURURTRv?=
 =?utf-8?B?ZzV2eER6YmZKVlhjL3VPYUF6ZlZrOStiWFRVc293THB4YmFPVjQ4Q0JEMXl5?=
 =?utf-8?B?SldDSTlEQlY2MGNKcTVBSkZlTmN0dWZGdmhzSXZ1OE12cWlvOW8zZmVOdnJ3?=
 =?utf-8?B?VnJKdjc2UWNVcUlSVC9aNkp4V3BTdUNCRXU1Q3RPVzNSYkg3dkRUK2E3dnRi?=
 =?utf-8?B?OFNUMytGWHR6cUc1ZWtTM0RFSkd3S08xRXgzTndDVHdGMUxqaEExbW03RlZP?=
 =?utf-8?B?dEZKZXR4eGNFY2d4TzA2K2Z2MEg0cXp1UUdSR3AvcW50aGs4aFlGQ1Qxbktu?=
 =?utf-8?B?OEloUFVybkMrZEFJUXBsZWpWb1FzN2R0Wk5JR0txY2dBUG5QRmdaYVNKL1dt?=
 =?utf-8?B?aVUxMjNReGRFWXQ3cFFnd3hhVzN1Q0NWS1U4N2dWN3o4SFp0VHgvSmVjekNG?=
 =?utf-8?B?UmlxZ2dLaWRiUVVnMG1pdjVKQ28zT3k5MDRDaEVHQTF5TXFTa1BxdmRwYWZv?=
 =?utf-8?B?UThoL2RzeU5UcjBPbGtqOUlSOGUrV2loL0M2VWcwRDFpdnlzRVVJeHpMOEJp?=
 =?utf-8?B?SjdqN1VpVU9TKzhJa1NoZjdlcElYcHRDaDh5UXcydkxwRmFVeG5FUmNIMmdQ?=
 =?utf-8?B?WTUyanM4c2dhL0ZmaFVHaTFrRlhud1RqSzAwdGVEYWtHckV0NGVKaUdvNmYz?=
 =?utf-8?B?Z0pqRGRzWVhkMlR0MUY2V3RaZThKTTV6M1JnSkNIeHEwR2p2a1ZERWZDMk1D?=
 =?utf-8?B?a1FraWhZVVNhZVlBQVQ2V0VVdzZVZi96VE5NcjVJYlZWcUEyVExPT1ZzTXJ3?=
 =?utf-8?B?a3c5c2R5eVhDUEY0SWFFOEVEKzFXcXcxN254anZzVkJpUURLeEZieEdDNi9H?=
 =?utf-8?B?VWVCSkw2T2pTZ0w1a2pza0lBclBwLzc3aC9YKzFBUlNKdGVFMUdyTVdhb3BM?=
 =?utf-8?B?ZUNXeHNaN3YwalhKM2RudWphQWlkNTV2WmtLbzVhUGMvY0srdjNGbGNXYlQv?=
 =?utf-8?B?UlBaK0F1eXErYktaRU1iY2RvZW1oT0dVM2ZPVVVUbkloQkVaWmUrUlZyRTFG?=
 =?utf-8?B?clpHQjdaSHRmUmxCR2xCR3NHbC9HNDNCdjBRazV3bzBGMmZVL3VJcXFDSHpH?=
 =?utf-8?B?THYyNU0rQTlsVEdSUjltenRSM1FKRGVRVEh0eXUvRUd3dUJCcmduWEhzUFFE?=
 =?utf-8?B?YXV6MmE3YWFOS3lIZFlXT2FGdUFvVVdMb1oyREJWWnBjT0dsTUk1NVRBeFZW?=
 =?utf-8?B?Y3NsSWhxYVcwOGVGcmt3YklyNnVNSjlYUGVqTDhpMUxlcFFUUVF4U3FmQldS?=
 =?utf-8?B?TDhJNU5xN3ZHNDlRTWZCQ3Z2dHJGOEh6OUdNVlAxd0J0SFJPZHFTbXM5Wkov?=
 =?utf-8?B?KzM4eHhuVWNHMzh1L1Znd0szNjdFL2JjQnpKQVVsTjZoazZjbHd1TTlKb2JZ?=
 =?utf-8?B?ZUdSS3BvYitwc1F5REJPOTJ0Z1VJV2VQWnRyRFp6eDRFeDhoWThodDcwNnpi?=
 =?utf-8?B?V0lCTlpkeGxDWmhrUG1GUHZydWZUc0xWSTUvWExEZWc5aTVsL2MySEQreGRL?=
 =?utf-8?B?blcvTGM0YlhOT2dESW8reDcyTDVGM2VXT3I5Smdtc1M1eGltMWZNWm1PeWky?=
 =?utf-8?Q?gKEQntHjz+3QI9ADkXyqbWeFF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7782bdd4-6471-4da8-1079-08dbfd417900
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 07:43:04.9340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+GFi74PM8ipfFkh/8WP5Hnz4iQwy5Xb4H6BK1sJ+NEKO5koXjj+9VhFp3h2uQ8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163
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

Hi Neal,

On 12/14/23 18:11, Frager, Neal wrote:
> Hi Michal,
> 
>>
>>> This patch corrects the k24 som clocking configuration such that the serdes
>>
>>> Corrects the ...
>>
>> Ok.
>>
>>> clocks are correctly enabled and the usb0 is configured to use the psgtr
>>> refclk2 for usb3 mode.
>>
>>> I sort of have no problem with this patch but it should be better described.
>>> Pretty much serdes configuration should be called from u-boot because we already
>>> have psgtr driver and usb3.0 can be configured out of it.
>>> But we can't touch dwc3 driver now that's why the only way to do it is to
>>> configure via psu_init.
>>> But it should be clear from commit message that it is workaround not really
>>> something what should be here.
>>
>> I will re-test this without the serdes additions to see if they are
>> really necessary.
>>
>>> This patch also corrects the configuration of mio pins mio76 and mio77
>>> which should be configured as gpio pins.
>>
>>> This is definitely fine.
>>
>> Good.
>>
>>>
>>> Signed-off-by: Neal Frager <neal.frager@amd.com>
>>
>>> You mentioned that SPL didn't work before. Is it because of incorrect serdes
>>> configuration? Because that's sounds weird because you don't need serdes
>>> initialization for booting out of qspi. That's why looking for which is that bit
>>> which make SPL work on KD240.
>>
>> The SPL works.  The issue is the same as I had with the kr260
>> board.  The sd card interface is over usb, so unless the usb3
>> works correctly, u-boot has no sd card interface and cannot
>> find the Linux kernel and file system.
>>
>> So what I meant was that I cannot boot up properly
>> when starting from the SPL.  This is what this patch is
>> meant to fix.
> 
>> What I have seen on KD240 was that I could get to u-boot prompt. And for that
>> you don't need any serdes initialization at all.
> 
> Yes, agreed.  I can get to u-boot prompt too without
> any additional patches.

ok. Good.

> 
>> For booting OS you need it if you want to use USB3.0.
> 
> And for the kd240, sd card requires usb3.0 also.
> 
>> That's why I want to make it clear what makes kd240 to boot u-boot.
>> And what makes to access sd over usb to boot OS.
> 
> Understood.  The issue I am trying to solve is enabling
> sd over usb to boot OS.

good.

> 
>> And no issue to add serdes initialization to psu_init to get boot OS part to
>> work till someone has time to wire psgtr driver with dwc3 to configure it at run
>> time.
> 
> Is someone currently working on wiring psgtr driver with dwc3?

I don't think so.

> 
> If this were to happen soon, than this psu_init_gpl.c patch
> would become unnecessary.

I will take some time to get there that's why it is fine to enable serdes lines 
via psu_init. You can put k24 to kv260/kr260 carrier cards but that's not normal 
mode of operations that's why it shouldn't be a problem.
Maybe it is nice to test it to see but definitely not requirement.

Thanks,
Michal

