Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C614C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 12:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9814587545;
	Tue, 21 Nov 2023 13:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIIAf3LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED1987596; Tue, 21 Nov 2023 13:57:42 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C1A87251
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 13:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRwYsLnMwIl1+AlcG90NFd6Zp54RX0EEJgWyuk4As3KgC5j3D37covYOhJyjpZQF9B7iFArRr+En4sA7to6TP5JRcGVYLrOCdpN08c1uFlXYkL5sn6oPGJHBL4NRA21Xx1ReGxcteR6gnxMhG6uYQ/u1ix+8cQsHgmR0t9hFPRpN5v2KDy4zWiuoRRSz1Pi4xJJsrW68Va3VqD0STaylIVqqYab3pQOGvX0JPaPTN/1EcFLV8D1Yksy/010cgoBwUlcC6g99Bbk44Ilc+5zRjc5aPFzto711EJaeOmTc9ZsBdfwME09dXj7Nynb+9TwQ0Mphhqkd3+RChoBpCFt77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82BOidQpEbB7iYdeIvG5LgSpvFqrjlNV/E1r8zLPoJA=;
 b=IctD0ES6Ur7UXTvLmYhkdbdF/Z0DshFe6L3+AfbzxPDsUElM7N4yKC+ySoJDjiuxKfEaFlY2BAIkJMn+cp2WCy1VoRK63CfiIMU2JUKKlHcVWg6leVmjAGb2vcajiGo5vAg0/VpUU0ZvUklYqnDknMBS9BYahj3up6kGjfKZBo1dmyLqu/Lj9qWRoqUJEWASM0rhCoIoS71OHg/Lz0yKnvF9Wg/Y8bZx7bBT6Wpk2OwPl21ib/bR36wXK/453rYHm63kaBjQQZF2CgeSucXLCYVKijYxSjg/k6sYtbkKFiyiFcGIbONvhNJlzljHGQs9gT7q43J3ujiDgk/gQZ0law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82BOidQpEbB7iYdeIvG5LgSpvFqrjlNV/E1r8zLPoJA=;
 b=tIIAf3LUiK+PA/40QKknAQB8Qv71X7PkRt6axCBciT+vtZz3Gn96l4nNpjcM+j85h/oWuAQiuAz3/JHqZsRlgsYMBf8KB3b1HxlsnL8ubu8lGvFICkZp7vWHHQrHHqkyAv9SQy4AZ7u4n06YirTEDZlqYYHvJWVJr8UJy/SR+Q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 12:57:36 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 12:57:36 +0000
Message-ID: <c4058737-f16d-45e3-91a1-543e2c82d60c@amd.com>
Date: Tue, 21 Nov 2023 13:57:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [UBOOT PATCH v3] test/py: net: Add dhcp abort test
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, rfried.dev@gmail.com,
 v.v.mitrofanov@yadro.com, seanedmond@microsoft.com,
 emohandesi@linux.microsoft.com
References: <a02d523a004e6c42c666dd0d90ace8cc44cbcee7.1699951058.git.love.kumar@amd.com>
 <20231116154817.GR6601@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231116154817.GR6601@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef2711b-87d0-46d0-a26d-08dbea916f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt25f3cTZI5bc3Du05yCb9pHYqypU2yKbx3kez9tPyAeEeDszO3WVDGDtrSNbzu6/YNZf4JOvt9ON5VVM/XVlWYfIg2eV+SGU+pGDU5UQ/40mMFR5J7cbF1iuzc1F8Vy+qiNbw0x4jsLculgDY0wAD04zH/mUYvr0LSyNXKlTBcxtAaKbs+4sJEjcp5rJyfjo0buTn5ONTD8rDNoW3uRgGq2uF+eyI31D8OqGWmef5MJFgbpg9Y3SeUuZdFpddrsu/IX4mM1JwEbwXuqjFhFOjg3nNqmlgJJaHjadk2In7QtVxA8DrKgEqREEfBo+RBmLHJ1p9NI+8HrXUuTSXwKzdvmm22eYCSTGYeDNC9vvbehQo4wp0ZmV4IjWQs39XAUl5m4oSILyPh1lWFG9xaQ2RXyBUOGjjwpud8xTZZKS6EOIQ2MZIQ7EvyOv7wiJ+or5iPzN1mmS8J/xgjgkkLOlPBV0ySg12i76DmL0zh71t8x5yQi6G+SVtZE1NDc+1M2Ac/2UYT/MzVQUhKH3c9uKPQZ2V7xmhWfPrrrPHyXm7e7wRIOYEr9JefeH0PuHC561nl4e1rYFFAtDtAWbvnYU47J/UtHpAaIxPNiSD7M4igurKTe/1jkWiqwMtH7LII6eOE5rjd38elKpas4ZYFXvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(53546011)(6512007)(26005)(41300700001)(8936002)(8676002)(4326008)(38100700002)(2906002)(44832011)(5660300002)(478600001)(6486002)(6506007)(6666004)(110136005)(6636002)(66946007)(66556008)(66476007)(316002)(36756003)(31696002)(86362001)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWNSdzZ0VG4xNDNtK0haM0FEVDcyOGw1ZlJtWjlUV1NWdG12YURpbm5kU1VV?=
 =?utf-8?B?NWt1S0hIdU8ydGdrR2VLdGZNT2tOa1ZaWnFhL0duNEoyV0NUQTRweElaVHVO?=
 =?utf-8?B?eklWajFpYTRrV3pLdkU2bDVyVzMvWjJjUkFZR1U5bzVRQW1aU0duU1FPR1Mw?=
 =?utf-8?B?bVJWb3lkeUlIN1dRNWJHemNEaG8xMHVWSUd6WTdkenphQTJjNlNxWWhCYStO?=
 =?utf-8?B?N0l6RWszbncvMEhWUjVsbzRuMmhKNEtuZzkra2F6M0syT3hSYXQ0RDN1QitK?=
 =?utf-8?B?ZEVmR0I4SDN0SmlId2FOSVVWdGpKRUdpcnpKdFczeTFzNHdGS3JUZElFSWJL?=
 =?utf-8?B?dUJjSHNmUEh6aHR2aXBKN2dsMGRMNWd3LzI0cFpCS0JRcFNDdWEzTEF5VmRC?=
 =?utf-8?B?S0IyUGFUTzF0ejFEaCt6eVhQYW91MFlnQkMzQTIvbjNCL29kWitNTmFGSk1C?=
 =?utf-8?B?RUFwYzZ4dVZvR3JEa3huYU9BT0FpdFc2aWhnVDdxancxL1pJSFpNYTNHbkV3?=
 =?utf-8?B?UzlsTXQ3MXpsTTIrRm9mU3dGQklGcjd3dk9aTW4vamVyRy9xUDBGc3NMNXgz?=
 =?utf-8?B?WlVIbUtVbzFGdGM1eXRqaFRTOGtYdjdUQVpTOGxyR1BvSGYvVlBXSkhCQkVj?=
 =?utf-8?B?dnRFbFlYMUgvUm1YVzhWMTBqTDR3TWRXZWIxUkJGUFFBRVB1OG1RZnBGZFVN?=
 =?utf-8?B?a1A5V1I3UW9ETENxZHk0ZEVQTzJQVEZpRzNrNHdrMUgweHhveTFscVZDbjhF?=
 =?utf-8?B?RkxUM2lhTWhETDZoSmtvN0dsSjdZOXVUU3hxM0J1VnpQQXBCZ2hsdXV5OEVL?=
 =?utf-8?B?QVhSc2tOVEk0R2phOEU3RXh3SlZwcjhvTVRhMHRONlVyZ2k3UzU0Yy84S0dV?=
 =?utf-8?B?SUdIL2pPQ3NGYTJweDJVOWp0YlVYL2ZCVGJxNnlSSE9XSTZUV2kwcVFBWlg2?=
 =?utf-8?B?ZTlqbDgyQTA0K1RmaVMyRWVKKzM4cXliNnk2ejNtbnFoQVBxaFZxb2VzQVVF?=
 =?utf-8?B?ZWZ2dzJhVi9pcjlMOExER3dIendkU0VJU2NxTlF1RytneDJSU3Jub3g1NDlG?=
 =?utf-8?B?NjlLUGtxYk94Wi9LUStJUHQxZjFFS0RoWEx6Rk5OSkcyT2NIZTd4MUZwTHlG?=
 =?utf-8?B?eGUwZi9JTWRidWFYUlRWYU8wTGFaNFZFRjhPNmF1NmY5MTRBZE8rNzFIY2Nz?=
 =?utf-8?B?SzN0ekNVQ0lwUmxGbktTeEtDOHMvblFWMGxMWDNXZmViVmlVSitNbTAyU2VK?=
 =?utf-8?B?eW1ZQU1STllzb1FLU1d4UmU5Q1NiaGdlUWFvakQwV0FNL1dMWlNBL2RPVml6?=
 =?utf-8?B?azNHeEIxQnBseGRuZ2wzcVdCSnZYaGJpMloyRStPQXBaU1hkeEYvQ0lYSkc5?=
 =?utf-8?B?Yk00TzFQeUVGNFlDRWZmbUVtTkcxM2pzaWZqMHAweTIxdVkrVUYrcTFacjlX?=
 =?utf-8?B?bnZ2dEtDbVl6NTRDRVVaZWNjWHF6YmdGRzZPU3J0WUlsSFpRQVlBeFdmRDBD?=
 =?utf-8?B?STN2VktrZkZHUEJoM0w5Vmg1cGVhcUQ0NDJTVGdmRitqaTNSRk8yWitaQnkz?=
 =?utf-8?B?RTh1QytCQ1NYRzR4em9McG5mbFlyenY3b2ZlVUVySVRCWEVmT0dEREZvYnF6?=
 =?utf-8?B?eFF6RTBzQitJUjJVSHRlTkN5YUkzMXViY1FoRnp2NG9ybiswS2VaVUF3bks0?=
 =?utf-8?B?ZkN3YkV6L3NpN3lNNThsQkk1TC9mMXczL2xrUWRxLzk0aFlQV3Q4KzI1QklJ?=
 =?utf-8?B?bXNHVkM4OXJLcmNzYnBwT2JTRCtITEdxM2t6bnpmQmdiM0F4TlRsQ3B3Z24x?=
 =?utf-8?B?UzBSQVhaN1Z4OHRsWkhTaUlyTU4rSkUzbXExWGhwSnh3OE8xaStjWWwzTW9D?=
 =?utf-8?B?aEE1SFpGa3JMTHpVMUUvR3Z4TlVTbDNXNklWVlFaTWdObnJZbXdzNCtoa0Jm?=
 =?utf-8?B?MFMwamNxMkhjQU5lNjAwd2ROUWVPZ05QUGlpeEhrQml5NG5xdW14ZXc5K1cv?=
 =?utf-8?B?T2FsTmcwRC9hd3g4K0gyWnZXNjR1cEdBWmhsOElUTUVoWS9HY1dsaExiRkdj?=
 =?utf-8?B?d1BvMlI2T21mQWRiTE1HQ1JhL0hSU2tTM2crRVcxam1MUVgzK004a1JPeGlj?=
 =?utf-8?Q?ju4AxDHyolVX8DLqagJLuOTAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef2711b-87d0-46d0-a26d-08dbea916f3b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 12:57:36.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdghFlDeHXKFaCe3FN/s6u49D/WYeA2BbdRVd0RfVJ3GsLQvtfGwR0Cr9c+Z+LrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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



On 11/16/23 16:48, Tom Rini wrote:
> On Tue, Nov 14, 2023 at 02:09:01PM +0530, Love Kumar wrote:
> 
>> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
>> prompt and validate the abort status.
>>
>> Signed-off-by: Love Kumar <love.kumar@amd.com>
>> ---
>> Changes in v2:
>>   - Mark CMD_MII command dependency
>>
>> Changes in v3:
>>   - Skip the test if PHY device not present
>> ---
>>   test/py/tests/test_net.py | 47 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
> 
> Can you try this on a Raspberry Pi, or other platform as well? With this
> applied the problem I see now is that the next network test, ping, then
> fails because we don't have network configuration now.
> 

Obviously we don't have any RPi available for test but I can imagine that phy 
stops to work when require additional setting. Because the patch itself just 
reset phy itself without doing any additional setting.
I told to Love to permit this test only when variable enables it and I can also 
imagine that after this test reboot should be called to continue with next test.

Thanks,
Michal
