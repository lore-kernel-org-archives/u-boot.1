Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B4EC4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10C387AC7;
	Thu, 14 Dec 2023 18:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CyNESCVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D6887AB3; Thu, 14 Dec 2023 18:05:37 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E053887AD0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2wUwFGnhldiyx9O8peRPJp8ICuki65fCp+L4ORsh3kF8U47lxQ26NTaYv8ZKnXmaD3SaA2cuWzIVkw/oUQBhZF2FHsHJcK71rSFRn0r9hM/kW+YUZfzEOOenTGjCR3VnevDei6tFdrssx1Ob90ypOlfR6QXdXtDzpTRjnYIv2SM2ffUtYSohZxejqqMs9TLkG9Np2PjRd0UrxCPvHuXWQ+w1gESLftSnwJiUcQf7H5A+bs1SsVhefFDNAQJc5u+9C8s1PsD0jUftyZwg9q0GITaX8K1ekqp/IQyY7Z8cBQtNtgk3T1emRzceU8FRdZTenOSTCPahLOAxZ8i6Q0CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQfY2EWzuNmqf94s2t2bQpcZCQB2278CDxvLyvtVXgY=;
 b=DsOljVUVNhbKPF8B1ftfwwjCoBXjCCX0vEBF7OpZp8XpH8+5wPIa93Gg4iC20i4S6eeaQc36RNz6hlN81QQlEpm/yt06OwGmBYIeGUMEg+YE17UnTwMZCW988ca8c3Y64rDOGjSANeeFhMpmy9loPvHmAJWSMSmtbY/LDkWoTWK/g0PfS6tWITDfFDBLDFFoI2PlfPgDYVixMJN3O/Y9q9AQs6YBNUoF3t5WHBND+SmiNHtHM2v1Mw4CrH3cL6hHmvckgnla1iqqUpAd6JBSvbqc1Cw4AzRWu3RHxo9QVt9Ii4G2EAWARfUE9i9bAT1aUnp9b8Ml6tHBIIkFbgF44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQfY2EWzuNmqf94s2t2bQpcZCQB2278CDxvLyvtVXgY=;
 b=CyNESCVnNuYGHl7gpfv9bK4AveQbclrl9ALK8qY21mh+KGJ8P5jCt2+N7eFLeeIaePMA7EwqbP2FW+k1csgJuxLSNfqvuC6cmkg9FZAcNwyoUaLm3GJgEYz9wDPt3griXQfZA+KZqnsWLIBXxA8AdFWc/1M99mmKwInMLbSN3Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 17:05:30 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 17:05:30 +0000
Message-ID: <a366b338-7e02-42a4-b5ac-b295c37c0dfe@amd.com>
Date: Thu, 14 Dec 2023 18:05:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Content-Language: en-US
To: "Frager, Neal" <neal.frager@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>
References: <20231213134007.2818069-1-neal.frager@amd.com>
 <c2e4c147-9dab-4f11-8721-8f6aa52e3af4@amd.com>
 <CH2PR12MB50043CB2CCF03CFF39ED5768F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CH2PR12MB50043CB2CCF03CFF39ED5768F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::34) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH0PR12MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0837628f-1f09-4e59-59d9-08dbfcc6e03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yt374XyuX0NfxkA6x/PXyKSY1YQxm8J4kYK1pPBWwk0BxdPa7Gog0E/DYa0vda4NGERlMXB4s9x/puvoAuVt1Q/WxjwBFizFOJLc3c4psIC7Orppf2Fykmr+8swKaLC/WkcdrhV6f1sCPYkmJRJ/nUE3p253sVl9IVzJ3tO8MxAdoO7vas3SIpDzTLiJhi1giZJ6v67z2kPgkuWsSe6c4k2IjMAXhFRrIxQOiMC2hi22iYA606iWKAMOlnUNuwdPgyEwsZOtI0Hg5DL43VL2zRhCja3Oa72az9KLAto572oZgEdwO6eo9ZxLyN2C1eP7xMH9YO1L3NL7VvFHCVh2mxUf1JiGUbRYyPU2MsmCMgusqdxFbwq98TFO39kcse1a0j7auLMhYliNOOnSSOnu6+9qpPiweBELz6+vWkpO8Qse9uBYyBWXPftJlKk7of0Mqg6I4wCv7wZtMkMLQM3v4fuAeGXbZvpp88i7w/HuEPLYLclFzIIrRP2pwcpXHGOsy43ZHkIh2spxP2Alg4fUqo+2xBYyPJFnBBZtA3gQcchhmgCf2BYVeBLcqCc3UyyGyMLk1Ab2FHoykDl9JG42oMdF3k4rQEj8W8talVlWOGxwMIA2ZisEwEtOBP6MT8hQtbzL+/AlW2hWDfMFy02vCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(31696002)(86362001)(36756003)(478600001)(66556008)(6666004)(53546011)(41300700001)(6506007)(66946007)(66476007)(26005)(6512007)(38100700002)(83380400001)(2616005)(2906002)(316002)(110136005)(6486002)(5660300002)(44832011)(4326008)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXdKczdBeEMxZkFJZFZJcE00elVyWjFKRld4bVMyL2Y2ZzJ2YnV0bGpGWkhJ?=
 =?utf-8?B?MWJOaGFUU2Z1WHlvNGJzT1VGTWRiY3IzZy8xNk1uMFhBQnBUQW85RnI5OFJk?=
 =?utf-8?B?eUZnL3Y4cnVzUVRVRXQyUVYrOFNibmhqbXBBZ3EwRjRLbExpUm9MaThVbUJQ?=
 =?utf-8?B?R2FaYUxKK0Rxdkg4R1ptU0JkQzYyMjhJSTZSdS9Ea2d6dDQ5ZmVoTVdQNTZx?=
 =?utf-8?B?a2EwelBOL2RaZzMvbnl0VGx3SWJDZjZ3V1VtMzdlYStidTVXNG1zOTRreEtK?=
 =?utf-8?B?T1NpN091Qkw0Smx2Tm9VTHIyVGFNUSs4M0RlOHdiME9KWDdlSFJwSzdEOXZ5?=
 =?utf-8?B?SGpVN3d6VVB6ZG1KODRKM0dRZnRXWlFObFl0Z3Zic3ZuSExXeG4rVXc5Q2hB?=
 =?utf-8?B?VnIvK21BNytXM0l3dTMxd0tKWjZ6RnlXQXd2RXRYUnkycG42eXFIcUh5OFVZ?=
 =?utf-8?B?K2lOblluRGtGZVNqeUNhT1BqQVRKcjhrTFBhZ3BuUEhZL3p5bGZnaExMRmVS?=
 =?utf-8?B?alZJSzN0MzZpNlhPVDlPckZEMGxhdkFSc0Nsd3V3UVNqNjF1cWZrL3BPR2hk?=
 =?utf-8?B?cDdaZ2xVYmhSQWMwa09waUFWN0ZCeEZzbkk2djRQKzJFcE1pQitXYnJBalp1?=
 =?utf-8?B?VmdmQmlubHdwRWMzTy9ySy9BNjJqTTFqazNwMlpkWUd1UDdlOWxFdUVZUTFO?=
 =?utf-8?B?Z3Yxa3ZFc1htc2lvdWttS0I3NDQ4S1JWWjNlTnlBV2VRWVpLMzgwanpheGxW?=
 =?utf-8?B?SHFJTEROc3dncnZjeGdCTU02UDJRUE9TRTBXZFNXMFVsUEU1NXUvSG1HbURX?=
 =?utf-8?B?VjVma2l4b0s1QUc3RnBHeGNQN2ZwMHFCZ2xaTmh4VElFTTZNU1FySGxmYTFr?=
 =?utf-8?B?SnowbitWWkRTWjI4emIwSndwRGhhRi9XYUtBOHpEclY3OEFuUm00UHpiUGJS?=
 =?utf-8?B?VUtUN0Q5eExCYTNmOHhzVHIyb1RlSUFVaFNsWW1pZHVIVk13ZHdIWkUyVDhx?=
 =?utf-8?B?NHJ3Qmk0NEN2UlFEWFVJcmUwLytGOG43V1RkTTU5WWRNVkpLV0k1b3JNOVRJ?=
 =?utf-8?B?eWowcjdqVlNUS1lvVWdBZXlKL2hBWU8wTUNxbkhPTGxYVThhS1pEdnVFSDVi?=
 =?utf-8?B?aUplMEx6azZBNlQrSmcwR29CK21pb2lGZDE2QU9xaDM4eGVISnVDTnFCUG1X?=
 =?utf-8?B?WllWbStuNkhlU1dmT0F1L01VV0VGWlhiNEQyektjbmhwZjdlR0prY1pWVnYr?=
 =?utf-8?B?TUw0UXczT01EK2VMUmZJdDJMNDR4NU5JcDBTSTJFSDZXV0hUYk5zQ1VrRUtl?=
 =?utf-8?B?Z1ZjaU55dUUzcGtSUVBkeVFBT0ZUL3FKL3hDNmxaZTNOdzFlbE4yR2lnWGhm?=
 =?utf-8?B?OUNiZW00cndtc0d6a09UVEZLSjlQdjNGY1ZmUFV1eUQ4WUdJanN6RXd2dzFU?=
 =?utf-8?B?ZHdOa2VSSERwbEJOS1o3Y3UwcVdVMWVnTUsrRTZjWU15UzlFdUFGMmk3akg2?=
 =?utf-8?B?b3Q5Zm9hTVlQNDhoMHNCR25nSkZyY1I0bG1qRUVjaG1rUmh2czFiTnlVSzZZ?=
 =?utf-8?B?UUx4L01ZblZCVUtsV1BnaDdhNForY1M1T2lpRDNpRFpBbmUyT2hQWUdJUllD?=
 =?utf-8?B?K2hHU3VkWVprZDBZcEl1VDROZW1lZTliS2tvbmdRbWJZeXZLUmErdXcwY3lv?=
 =?utf-8?B?MGI5bHprL05PUVBTRk1XOHF1VEVwQ0ZwRVBNdHQrUHMzK3hjMGI0RytIKy9y?=
 =?utf-8?B?TlhwTnIvdC90bVQ3ajhwc1kzRnVYall0dFU3NXVVRzkzVktna1AxS1hSUDIz?=
 =?utf-8?B?RmZIQUc1aTNCeE1XblRCZ2ZjNTBFckZoamV3WDNtK1FuQW9VWmY1RkpoeU9J?=
 =?utf-8?B?U2JIcXNiajVyazNPSk9mc2kwSHpJcTNTUy9MOXMwWHVaMlFSUVR4cFVZTy8r?=
 =?utf-8?B?NnE5TUlrOWxjL2htcWFPenVQYXFCb00yd2dEa1VsTU4xbUd2YnlvcHFjelVS?=
 =?utf-8?B?L1cwVXNDd09PZlZ3blExV0FQQjJ5Z2Jycy9UK0UyOUJxTHYrdG9vcGFYell4?=
 =?utf-8?B?VnRlaTBTcE0yR2VjeVcxU3ZYWUovZWFWZ2Z2WlU2MWFBb0NzZVdNMkVaRDRE?=
 =?utf-8?Q?PoHGesM82EWjdkWbYncJmBTkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0837628f-1f09-4e59-59d9-08dbfcc6e03d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 17:05:30.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHcOCG2xzy4+wQ1N0dCgrqOZ4egaJiEwgItj//8cXWMr+h1seGhJIDBCzBkhD/F0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
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

On 12/14/23 17:30, Frager, Neal wrote:
> Hi Michal,
> 
>> This patch corrects the k24 som clocking configuration such that the serdes
> 
>> Corrects the ...
> 
> Ok.
> 
>> clocks are correctly enabled and the usb0 is configured to use the psgtr
>> refclk2 for usb3 mode.
> 
>> I sort of have no problem with this patch but it should be better described.
>> Pretty much serdes configuration should be called from u-boot because we already
>> have psgtr driver and usb3.0 can be configured out of it.
>> But we can't touch dwc3 driver now that's why the only way to do it is to
>> configure via psu_init.
>> But it should be clear from commit message that it is workaround not really
>> something what should be here.
> 
> I will re-test this without the serdes additions to see if they are
> really necessary.
> 
>> This patch also corrects the configuration of mio pins mio76 and mio77
>> which should be configured as gpio pins.
> 
>> This is definitely fine.
> 
> Good.
> 
>>
>> Signed-off-by: Neal Frager <neal.frager@amd.com>
> 
>> You mentioned that SPL didn't work before. Is it because of incorrect serdes
>> configuration? Because that's sounds weird because you don't need serdes
>> initialization for booting out of qspi. That's why looking for which is that bit
>> which make SPL work on KD240.
> 
> The SPL works.  The issue is the same as I had with the kr260
> board.  The sd card interface is over usb, so unless the usb3
> works correctly, u-boot has no sd card interface and cannot
> find the Linux kernel and file system.
> 
> So what I meant was that I cannot boot up properly
> when starting from the SPL.  This is what this patch is
> meant to fix.

What I have seen on KD240 was that I could get to u-boot prompt. And for that 
you don't need any serdes initialization at all.

For booting OS you need it if you want to use USB3.0.

That's why I want to make it clear what makes kd240 to boot u-boot.
And what makes to access sd over usb to boot OS.

And no issue to add serdes initialization to psu_init to get boot OS part to 
work till someone has time to wire psgtr driver with dwc3 to configure it at run 
time.

Thanks,
Michal
