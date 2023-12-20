Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39672C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 16:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F03877CD;
	Wed, 20 Dec 2023 17:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcMs1Wul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5ADB877D8; Wed, 20 Dec 2023 17:45:46 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151B08750C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 17:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQyWl8/Noy6Urqn8EhzTDz434kWv4PzEk7KLX4Zg9paRnulMwhATL87Fwaw35uViNIGwqjSPKxT3OlTU/ut7YaQS4rpmmzAZCx2Z1xcuiD3uHoCOspw2XJs+bNyzAOz1S3bl3KzoUnCEQgXlk3X+qY3kNkzP1TxOAA2kYWfruc6XfI2ZsOjkjKaa72yX6WISPxNMkJo/8zZgBHhy4V08s6+j9daQsolXESNrXAzEVK5+u+Iv8V9Tl6lUHLOVMYEuVEavHdwK5D6GvOWPWgR7tfHP4fJyJDFoDFjd8vQ7ch042Dk944NT6Bx6QpmDOgXOg8U5x4rjvoj++HMdjVHppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usiCCyXM4MfB0FpHPxB6zoVEU6iPdxokVF+yRpTK0Gg=;
 b=FR442BP8BV+i4iug921/2Tsl/FfyhbaQXJFTEv3ScuHrDvDlxvfdjUVCXVliWJ40gg1hQVvrRSS31fREC/ijaZ0YTbn0UkI36m1JmhkEaoI6+Plm1J/IhZ4inN70OZnD7QWLiS/7MwP/NifzLaIAO1Qp4cZmK4ptWpygKQ1Ceo260JsaR6QkbAy/HtWYQXzol87EpOOVazRe2Xty6t5M1QgSXnNLxECvBrlsjdS0lhTGLFtNvvwkKlghmiOTUwSCzkLZtwpzsgCS5AZuoYgnhHr5nL25dLtCzpKPdgLk3R9YvbB1bZbwOlJh6CUXlgAFfwhYYyd0oSiNObQSxB6FzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usiCCyXM4MfB0FpHPxB6zoVEU6iPdxokVF+yRpTK0Gg=;
 b=rcMs1WulE+jjlVYu/8MN6yMOXFZsaZymee5ywIfWlMzRwiOlvt/T5Qma9qc7VNi8ZiB6uywFu6DLTPbb7Y+Dd+8U7h7rIhPvqTTHPOyqizOc1A+ydauqXL5hlD0At9PIP+m6BSF2cp/wJFbG1xSF5cgeYJXWQSBXGxVPkD09dTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:45:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 16:45:37 +0000
Message-ID: <aaa35987-ba52-4db6-aaf6-8fd6f46e4310@amd.com>
Date: Wed, 20 Dec 2023 17:45:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test/py: i2c: Add tests for i2c command
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
 <20231220154637.GA4032343@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231220154637.GA4032343@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH0PR12MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5fa7ab-96da-4157-65ce-08dc017b178c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmPKQ8DeIRNKlvqnD/VH76UU8Kx/jP8kcbtsk3qWb9nWejoXoSZnYBw1FI0xDuFuDChKv+CFz1siqduH5suQb39ZTVyC2wtUUgCdf24IIRE3SeEhKKpQcykuR9UtlvBM7PGOZZNFrCNB4E7CuCws+6/2ZX5h98pMlwZpquLOYrj5Rez4E36W6elaT3Wtz0lSnsj2A8kpQ+7xVgEdsDm7SBB4bFS3orMPAc741GLnh+EBCOBuKJ4Sm9nzJXAreNGmTJcnZJbSDBYLbIL0SnTGg4yyzjD+YEg8xYx0ns+9XFtUtKtP2o0EHfL6fjrJkl37ffrm3jxsKhELkc69/cU8ivOWV/06WjCbWaidNCRHG3bdesJ3YchHlLHI9J4UvPWcQWQ8+Nj1KnLrMEbhzVPM8a5vfg2fzj7dzk0aQJ4/slRtaba6/3NhZu8nwURJOtswZbH2Y2sRxRvl9NebSWfy8LrQgdoMAKWyNk6JZzkaTjy9Uy2Jd5eszBIZ4UGowckHCYFNT8dSZMZVHAwmKALwc9+HGf89jwkU67Ax0l6YuehfX78YgkkTAOLeSUzrjk4Lv+rtSXw8Lx/iDbt4ugM5aLqntdCTqzPTs9FLSiT7XXptRSmgpKdeu0zg1eVb5DCTIKeItYaN1n76vnkd2Jkv9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(38100700002)(53546011)(26005)(6506007)(41300700001)(86362001)(31696002)(36756003)(83380400001)(2616005)(5660300002)(2906002)(6636002)(8936002)(8676002)(4326008)(31686004)(316002)(66946007)(66556008)(66476007)(110136005)(478600001)(6486002)(966005)(6666004)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Y2ZUVwM24xMWhERUg3TE1iZXo1dldIZEpZODNmd1l6b0lBNy9BV2t3UnU4?=
 =?utf-8?B?WDN4R2ZFOUU3ZDZSUVdtbWNKSFMzdDUrL1FPSm0vNW94MjFzVzJnbTZMdVU4?=
 =?utf-8?B?aitGMUlQYU9iYjdGd0xRWXFwV1ZMRnNLTTVTdHFVMXV5VGtyWjYwOXNCM1dZ?=
 =?utf-8?B?WXdsTUc3VzR5Mkd0dVJXbWxtYStGdmpUZWd1N2ZrNFFucnViN1pDTnd3cnNX?=
 =?utf-8?B?VTlmOGF1OW1IbVZXekJCTEo2aTdzemRFTjBkbDRuMjc2VUxlVnBvekdlV0pJ?=
 =?utf-8?B?WTlkNnZCZUIzZE4yYkRuMGE5QTVCQUhmOTQ3VHUvRTVtUUwxcHVnaVZWREs2?=
 =?utf-8?B?S0dTdndZOG1RR2dTQzREYWh1bjdVbDBvWGhUVHh5M01qQkVBcVh6S1FUMFNJ?=
 =?utf-8?B?SmF1Q2V6WHhHb3lPUmt2Vmpma3Q0NFlmOElEU1Z4VGlYeWo1a2FJV1VOS1lt?=
 =?utf-8?B?RHNqbXlSY3d0K0J5ZkgxQXZLQ1NpUU02UVpjZ2wxNzRGdUs4NytRSHpDVkor?=
 =?utf-8?B?dnR6bmVkdERrNzROSG1QTFVOVDk5SExZaUxnZjAvRDVvVkFJRzhYYVdJNHkz?=
 =?utf-8?B?cCtPSnRTYUpIWDdiMG1nTE5uU2d3WlZDOWxQcmp3YU5nM3I2WHNmM2RmQnc4?=
 =?utf-8?B?bG5NQkZoMGV1RTlJT3U3Q1VXMGxmaDVOOXY2MkxDUTIrbVlCRnN1TkdmWE04?=
 =?utf-8?B?aEs0UEh4SWtjaWlzT2p4cmNsQk9QazFoREh3ZElhTlowOWRsRDRqak0yRHlk?=
 =?utf-8?B?SkwyRGJvZEpaUzFqblQ4anJTYU8wV1o4b1FkRTZQRUlIUFhnNVpPMXhxUU1B?=
 =?utf-8?B?OCt4TGNOYWg0Z1FaNTJJTmYzNTkzSEpuaWY2ZFlKSWEwTlhnOTdHNUNGcnZt?=
 =?utf-8?B?RDg1dXYrb2VTMmlLWXAwQ2tkWk5FdFExdDdsQUhjRGgxZmgyS3ZSNDdzWW52?=
 =?utf-8?B?b01BaHRCRUR2TllkMU1ycTRhOEhKS2JKN1YvejJ3SlRBK1VzOHFLdHFHQnVq?=
 =?utf-8?B?RVVxTTVPL1NlSG9EOXBLU2VGRWZYVDZvcCsyejV5RURTRExTelorendQTlB4?=
 =?utf-8?B?NUhNVktrK2FCV0VhbDBtcEtNVFYrME1sTXB1MjZCRmF5OENHT3MvVlZ6QXdY?=
 =?utf-8?B?TGhva2NEWEh2TE9OYkI1UHlQWlFvQmtsa2NWRUNZYmM2c09qYkJSSlVsVWFw?=
 =?utf-8?B?dEVRMWthNmFjV1VBNjM0YWl6YWZLK2YwWjR4OWVCY2h3M0RnOXV4WGoxVWxF?=
 =?utf-8?B?MmR2cXBWdStzdG1OeVpqU3YyR1BvbmVQTTcvdHFURWtWVWVKOGNMRC81aHRI?=
 =?utf-8?B?VUFuY0NISzdGeng1d3VON05UZk1SV1R6bVc5MWJEaGU3dGkrTng4QzA3NUxa?=
 =?utf-8?B?ZUtYOTZObmgyaEtUaW9kUldad3piTlh1QzdxbzVjcHFGbjRlSis5UXZKOTR4?=
 =?utf-8?B?ZWlkeWJ5NUlNN2VFeFNLb3VwYWswV1hEb0pUTm80Nnk5T1lvT253Ly81Vis5?=
 =?utf-8?B?cG1RY21JRFdKUmpETVN6R0k1Z1l0QVl1TG5TdUZyeUFmSmtlZXY2Q0ozWmJl?=
 =?utf-8?B?Sng2cUZMdVpSRlQ5b1I2blUvUHZvU3VpZ200TGI2QUJZVFZ6cnpRRzIyUGM3?=
 =?utf-8?B?L2R2VDl2ZC9CV2hSMHZ6KzhhWVA2MDh0RWM2WENLT3Yxd0c3U1Z5eUk3ZHZs?=
 =?utf-8?B?eGZUdVNaMUlXbDh4bitHSVpXM1B4YlNHbWhIRkFIZndpdGE1bnVQWDR1YkRj?=
 =?utf-8?B?aCtGaU5FcXBwWnl5VExOK3M3ajJZSTVITUtPa2FjWVBlb3dLTHE5c05la2R3?=
 =?utf-8?B?NDJDQlY0c3ljYXpEMkE0RnlhTlgweVpJS0o5N0Ntc2x5bENORnVHQURSWmhz?=
 =?utf-8?B?UjJHQ3Y2WW41aXRBaFlaNHZCc3F3WFNDUS81OURuYnJqZTBQc1FPQ3JoL1d6?=
 =?utf-8?B?Rmpsb0k0cTRoZHJuVEdaYWNHYzJwV1RhOWZnbmNubHhrYktnWUxzeGt1c2dt?=
 =?utf-8?B?VTVOSkRsWURQdUlVZmhMMFBMeG43OEVhQlIzL3NuWTNBQzBGeCtOZHFjdHdS?=
 =?utf-8?B?TWg5a1hVekJWQmJSb1poeXBhZDY1Yk9wNHcwYzBBK0MxLzBnSkRqSC92WWow?=
 =?utf-8?Q?A4Wen2x5FHcw4UDJWMr10cJLk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5fa7ab-96da-4157-65ce-08dc017b178c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:45:37.0462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI+gFgbzn9S2RICp2dZFUChkxmnq9c87/C1brdzs0bOKcBVOiQeVAKvRoaTqBCk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
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



On 12/20/23 16:46, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 05:28:43PM +0530, Love Kumar wrote:
> 
>> Add below test cases for i2c commands:
>> i2c_bus - To show i2c bus info,
>> i2c_dev - To set or show the current bus,
>> i2c_probe - To probe the i2c device,
>> i2c_eeprom - To test i2c eeprom device,
>> i2c_probe_all_buses - To list down all the buses and probes it
>>
>> Signed-off-by: Love Kumar <love.kumar@amd.com>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> ---
>> Changes in v2:
>> - Take the configured eeprom value from env to read back and compare
>> ---
>>   test/py/tests/test_i2c.py | 108 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 108 insertions(+)
>>   create mode 100644 test/py/tests/test_i2c.py
> 
> So this leads to failures in CI on other platforms.  Please put this and
> the other tests through CI:
> https://docs.u-boot.org/en/latest/develop/ci_testing.html

Can you give me link to that gitlab build to see it?
I can push it via my tree but it will be just resource wasting to see errors 
which you have seen already.

Thanks,
Michal
