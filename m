Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA8FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D5B8468A;
	Mon,  4 May 2026 14:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hOo0qjV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AD88468B; Mon,  4 May 2026 14:40:54 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3027E8460C
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzIxEedRBELYDehPdLtudjYm6qSLbrx7PWnhTl9bPLi/QaGHBXYJEwqNKyuWdgA+Gt3TiDVTP2jbxAiIeDDjkRcTFBgpvVh7+zHWe0XR6xGTG7fhw2ivGWcEm5JDlopAuYZaXWOkkXHY/OVw9qXAaAFFNzoBoP1lrXEKNrL0jp7Y88o+X2z3XMgG1RL2ojEhVbzcLDPmIAbKcDhmjWBsY5N7QJgMi6dPbBjnK2nNcsfBVHXMnuS16O4gQ8EEJOSf4NgnjVwwe2dk9bBLfjrPTIqApR/IDuscFIkM/AsGFA1tL3ykbzkcUrWETd1JN7Du0stAQIYJG08arf8HMf1TUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfaak5Amk9qqK8l3Kf3CqjITXED0ReFEqZioEpHDYDA=;
 b=SvbJinvbAi1UCuUWHgbSrdnhztWJYgor5biZJLemmY3RBSoxsgSSPYKIUT0d1agLHRBD4ud75FV4xF7u9VZcyIfBbHUbEx89+cqnrVykDNojrVhIuisyY3zUkhlzzeNwNsLwLH6bd6GjXNbJvJHkQ0PaXEWKgLZ88fYzPD1Fh1KsyMiM9KStjtCkm5jZbjnlAM0Xmx8gLcnOHa1vQqUNxkokDM+h4ZRd5vz6iZUusTTbZeh+xMHIra2B/LPwNxElBShPm+ACF65cW0vNXs5S7I/u+GiiA30PfDMG98BLxmkprPOT6+GHNWutxw8rYogZ6Jos8VSKK8iM6ifIkOePhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfaak5Amk9qqK8l3Kf3CqjITXED0ReFEqZioEpHDYDA=;
 b=hOo0qjV7b+cE6LYWK1DULNOwjukjZBeTknRL3sm+dIIIeYggWzAhtJ9YKTYzdlO1uwSTNUh+wSKjUynZ3h6k0qnutI06FcNsFU5aWZGHkWqC1N5EsD9m5W8Uvn1gxgFEFMY3SQuBz6Ady5jGnEsbOgQv0CoXKcaRkw/rJnq4YAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:40:44 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:40:44 +0000
Message-ID: <81ee7f0e-9ad0-427a-90ae-8ae862cb0b9e@amd.com>
Date: Mon, 4 May 2026 14:40:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com
References: <cover.1777551598.git.michal.simek@amd.com>
 <7c16f629d85dba0118f8d67831adb8f167bdb8f1.1777551598.git.michal.simek@amd.com>
 <CAFLszTgN0=H_5qRfeqzB0V-fOeXYfV-xJ4upGSB4W5tGnaZ51Q@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTgN0=H_5qRfeqzB0V-fOeXYfV-xJ4upGSB4W5tGnaZ51Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: 895ce76f-3ef4-4a55-98a9-08dea9da5bfa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: E8oBOxwKDFw8skiT9KMo5r6AVTmXOYmFSF9pMOfviVh3/RXGc/d/LeZOwbEZa6LvU2NlrDto/69fE0SrX1ggS7x17GlVY39azKAHQNCbHujMShSLl4v4Sn9N2CEUf1lFFWOIR2/9aNTue0Ou0+GbqryvxOaC7d92Qc4LJRUvtjw4EfKoXe37C75g6VGA234hDFdlckYYpyQMJ+2klRUSILOp5n4q4e1aMXFhHhrJ/CCk8TBvr6h+h3ypd2wrShOQKd3J4rEbKFw+WOp0WORMixweMZLhQNIRobxlSWz6wvi3M5vl5AvnWsjOU5pEhldZhBOTHAxI2jjksZ8+E5Zk+INRWjkNxSLsTaL5HNxMhYk0EVqRhGZEiMriKCaEL2nUTdMLycYe/kN2aBR7OrJ1DR/qtycKsUgmTa0lJ+QFPxXbJhBNO/xJvwPaEevAw8yJGYC/3LQNZOzEvmRLCA51c0j+Ij5kUG8qZldW2OP90xXC2Nhs343+LlnU6uWhhHcl6hIOVfjoRx3oaeF4tBOT99GOdyeil1QqEPvRSCjCff7L4uWm22P6MQMC9EZHtOkJh+sUu6USUPLx6ZA5apZSx+iQHBNruWCmMhpHSPxXkTwecmWRYUqEiVN1a2nTCryTR3Bn8iIL7JXn9xGyS+3Soze8OeV2U+fvV2luxJ6OPVrTECrssfEVwg8PVQDMuHyj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxLcGlhbzdiTGhQN25uYXFzVkdUNFE5QWJGWlVNTmV6NW90ZDI4d0tjOXpp?=
 =?utf-8?B?bXdTSVpjeHpkSnc2T2hiNWVqdWZBN25FLzExK3Jpb0tGVnVlUFZyZmY2UWpl?=
 =?utf-8?B?ekpKbGc5c2FVWkozWW1XdUkwUUlaYjAyenN5ZmlHL3VnMzc3NlpJbnRJa2dx?=
 =?utf-8?B?aDJWUUx6clgzbkpoWXNzQVFBSkVTaENid1RlN1lEZEVBRDFaN3RVQzlsa0tv?=
 =?utf-8?B?aUhmaWNXMXJtZlVReU9XblhVQ1NydU5NRkk5K3RyR3NBVFNDYndwRFNPU0Fw?=
 =?utf-8?B?U1E1amlJMENYdFRvOHZYdng1SVNkTWlkczZQRnJaRVhFa1JtSVFqcDF6bUZQ?=
 =?utf-8?B?RXIyTm9iRU5lWGxLaFIvSW9lU0dMZUxjekdENExOOXJlUW1NOTJhVFBMaXp6?=
 =?utf-8?B?NUE0dlZJNzVHcUxqQWdvV1U3Q3FXL0tlaTJJMXoyT2FuN3ZKZG1aOThWbDQz?=
 =?utf-8?B?dTBLcHFEYldDSVdrNEEzZUlrbkpKcHl6Zks2UExrdm9uNGNIdE8yYko2Vnc5?=
 =?utf-8?B?ZVpkd1JMQXJCa1NKNm5BRDl1R1lYb3JBYTNtR2ZDVHJ0WUwzTkhIbFJDK2Fi?=
 =?utf-8?B?d0lEOVBEZ3hPdjVYcHZpUVpwTmxVMDJROFU5STR6VFAxMGtPaSswOHhYSnVE?=
 =?utf-8?B?S015VUlPb29QSFAwNW5ObFhrcXF6V21zUEFvbFNCdWkrYTkrT3ZWNTY3MUFp?=
 =?utf-8?B?Uk9ma1NIMmdtSERNcytEUno1amRPVnk0RkFQTWd4Um5zVkVNOUlzTEdJbFZM?=
 =?utf-8?B?M1V1eDlIRHN0cjd1ckZXNzY3NFpxeEh2RXNrRVFYVjBnNFROZ1ZMUjQybVB3?=
 =?utf-8?B?QnMyQlkxYVltVm1UQk5VQkRtcExPMllPODhKZjFhL2NJWkxqcUwwcTFuaUNH?=
 =?utf-8?B?MDdCcmdzS2FHcHh6SWVnMytFZjYwbmhrZVFYZTVIdExhV1Mvc1I5R0VOVThV?=
 =?utf-8?B?MGx6S3BMazVMcFk4ekF2bEI5VWlnK0xneU5hS0FrMlBBMVVMblFYT2R1Nmxl?=
 =?utf-8?B?a2VyV2F6UCtLN2xqUE4wK3ZKN2FaRVBaZVpLM1E5KzRKaUthWFRqUDBRand6?=
 =?utf-8?B?dVVNNWNXdHFVNHhCVklLVkQ3SzJmTG80WGhFZjkwK0VaZ0hJRTlPNGxHM0Q4?=
 =?utf-8?B?Z1k5SnJCNkY1VWhHbmVzeWpkV25BVHhYVTZOQWV6Wk16OUQ5c2lDRFJyNllW?=
 =?utf-8?B?YzhzMGxMbzF1NzcyWjlVTlMyKzd1NUpScXdwdXFuc29pMnpaemtyL1d0bkEx?=
 =?utf-8?B?U2JZUDIwSmkwdDZpQklMNXowMXZtR3IrbkxMM1dwakZjeXRXV3hpeDBKTjlh?=
 =?utf-8?B?cGkvMGRRMTdpelovTzN4SmI1ZHM3Z0dpYUFPSnViRDZHS0d1NUx1MEVrSkdS?=
 =?utf-8?B?R3AxSjMrMDdyVWoxZDJ6dWt6YTREazQ3ZWd6VDliZHRYYmZ0Z0ZaTFZuTEI1?=
 =?utf-8?B?b1QvSzZwMWIwa0xxSU1tczV5WSs3S1FlQmdoMDVYQVllalNHRjVhMTc5Tk1X?=
 =?utf-8?B?UVhiRFU0RU1QYTIwOXlwOG1Vd0Yxbk4xNVZQQ3RWRllGeVZSQU1hMFJlc1Ux?=
 =?utf-8?B?MC9oTEFLNERyalpuNk5vWlNLc3VqQ0RZdTRBVzFRUEQ0ZkFpVElRb3loTS80?=
 =?utf-8?B?Zkxvc0N5ZEFvaXlDVzA3T3NUMXI3UUM4Z2piYXlFV1gwSUJZdUtQa281L2Q1?=
 =?utf-8?B?L1NPSFVaNXBjYmVXWlREU1hSQ1hDQXVoQm9aV2tpblJlUGdqY2hLbkFVM2JZ?=
 =?utf-8?B?VGZ5MitFSXVUaXZkdHhKcHdrSkFLWXhNVEhNdWxrODEyUXMvU25STjN2S2Yz?=
 =?utf-8?B?MXJYYk10cWJyTVJWUjUrT2VDWFZWcldXM1hwTDBiRERnUVlOeVNRbnIycUxQ?=
 =?utf-8?B?MjljVTV1NVh1aDZvRzFDa05vKzBOb2ZmN0lhMlZFSVdZQy9lUDlubFU2UGhL?=
 =?utf-8?B?NFZKb0hESmgvQzBSUzNJS0VHZzMwVExWMDFzK21yTnc4UDMxL3ViNU1xaTBQ?=
 =?utf-8?B?NjZMbVB3Snk1L2FjQXJMeG5YU3M1S1ZXa0xBZ1I4Y09JOUMzc2crZ3U2TVdI?=
 =?utf-8?B?WTZaWjQ4TGFKM1IxaEdVRTJ4NTJGWHF4MXRsOTltcy80Ym52dmhqRXczL3F6?=
 =?utf-8?B?ZmdjMU54YXZycjJCRFpMVDc2TEliL3B1dStzckoyeWFGUUhzVTdjV3o5Vjdu?=
 =?utf-8?B?aDdRTTZwSmdKT1Q1Z3pDYi8wVis0MWhVRVdyYnBxNi9STTVkb2kxb3Axc0Er?=
 =?utf-8?B?OERRbHIzaEc3eE5YZ2hyc2xjZ2J4WHNaV1NYNk5yNXZaejNYMk4zRFhZazV1?=
 =?utf-8?B?WUNQTEZGVnRhdlFIQmNaQzV3dENNV3A3TUZQRXE3S1dDeEFLTGJwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895ce76f-3ef4-4a55-98a9-08dea9da5bfa
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 12:40:44.5442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axtxldeS4tnYRB7hRaa/j9ZAC9AufYvlijX1o7MdWKLomAvpR3ejBCLoPEzGbTdx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076
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



On 5/4/26 14:17, Simon Glass wrote:
> Hi Michal,
> 
> On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
>> reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
>>
>> Add DM test coverage for the new reset_reset() and reset_reset_bulk()
>> API functions. The tests exercise the assert + deassert fallback path
>> since the sandbox reset driver does not implement the rst_reset op.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> arch/sandbox/include/asm/reset.h   |  2 ++
>>   drivers/reset/sandbox-reset-test.c | 14 ++++++++++
>>   test/dm/reset.c                    | 53 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 69 insertions(+)
> 
>> diff --git a/test/dm/reset.c b/test/dm/reset.c
>> @@ -120,6 +120,59 @@ static int dm_test_reset_devm(struct unit_test_state *uts)
>> +     ut_assertok(sandbox_reset_test_assert(dev_test));
>> +     ut_asserteq(1, sandbox_reset_query(dev_reset, TEST_RESET_ID));
>> +
>> +     ut_assertok(sandbox_reset_test_reset(dev_test));
>> +     ut_asserteq(0, sandbox_reset_query(dev_reset, TEST_RESET_ID));
> 
> This only checks the final state, i.e. a broken reset_reset() that
> skips the assert step would still pass, since the line was already
> asserted manually before the call. Please can you extend the sandbox
> driver to track the assert phase (a sticky 'was_asserted' flag or a
> transition counter) so the test confirms both halves of the pulse
> actually happen? Same for dm_test_reset_reset_bulk()
> 
>> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
>> @@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
>> +int sandbox_reset_test_reset(struct udevice *dev)
>> +{
>> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
>> +
>> +     return reset_reset(sbrt->ctlp);
>> +}
> 
> Re your commit message, better to implement rst_reset for sandbox, so
> that we keep the coverage up.

Will look.

M
