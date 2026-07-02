Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C851CC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29299848EB;
	Thu,  2 Jul 2026 13:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Thy964Db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964928056B; Thu,  2 Jul 2026 13:55:46 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C828056B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfCsK3e7/hqW3pOQ9Y5U6tfnG7ZTeezdkKgpWEXwa+M0PMxznCI2c+6FxhnUVtpURApqAGMUButWIansyrD+wjPEM4YF+Ua3RggUB2WZ1bzN5Qf1yXq7c0U4KNRacENz0wft8Q1/MAgdh+3fKGg0lr7HZcVALlrHoJNUx78PWUkVNaYtfINJM4ZiiTT+Pgp/JjeFisRLl4am7ywa0ytRGZmy45ft4O7ZMbtwaRQqLRp4Gmt2v5xkVr7VwJz7usS+45avIr/+IjiIWtkNsvFkZU0oSoESq04ApyuwckeRWN4/CHTkl4y3LtBZolCjstwmsqFYgh942BU+mOMqcBPbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOdzfF1HCPNvNE0Pf6dV38IFoDiB6wr18aqO86UrJaI=;
 b=iR8AItc6riza6jQCMyXFglVv35trOxYitiUK3e48O5iLwKlcBtLHNfHRf6Vo+48x6wOuPmu7CtoctCkZtb2iEmo4PZJS9wulXH1TNAReAeE00rnGVU1fYI0ABHrNKah4jhVvxYgVBaXhsny1b2lfJgyxcDXL36/DsmondgD4VzWNHxPRggQvpnMCsXFGC+vr7QTE6S8gstDouyv4Z2ZyzK/ntptXu87vJljCS2qonepYRLcZNuDYV89G6fh2aiKFcXIMSk5bzem+N7647V9jV4s/l0MGwtfx/R31Jkg76foORdfvtFHeW6lQMwk2d5wnQCDCG5k8gmS84GJvHYDHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOdzfF1HCPNvNE0Pf6dV38IFoDiB6wr18aqO86UrJaI=;
 b=Thy964DbzA3z+LW/SgKeVOgXpD6QbyIqwB+kh+FgHf9c8yBhKC0kqemqpGwWJlwtaaKiUsDIB6e9KXM2yfddPKasfBZST0wVT8CRpzkXLT0G1RwoMQmFL4gde3/mz8VS0QQcf+ZpvHHMPPxZhe5/bXx8Kxx+5wUr7jETrVbBQNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:55:40 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 11:55:40 +0000
Message-ID: <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
Date: Thu, 2 Jul 2026 13:55:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:802:2::23) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: e29a665b-8bb6-4cd3-19e5-08ded830d61f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5TT7ZrMubjGM40vciPHlG5yzZnNykDEZ/DbVj5hh6xH5WuoPFCUVXZ0Up2mLwz4wWAqAbE4zysp3SuV0X50AqFR+82LONk3mCyFrahK7DlnRKh1NG0CeM9yI3QigRUZjEMZURcoSmO8JDpeJbFMH1PL+Ue8oSqrdB+t1ICdydAou2rsSKBdOr9ERWQZeSurN4V9cUZWE+wKPpukOouuMKVVQSB/eL08W+6b0HI0OrSO2xg4TBFrbzMeNrvj120djq2nwmVklqj7UcKnG2p1R6uHz4byrb2sFrtg9sgG+f9bZ41H6QRUZA9aYBXQCPiLVJvuauv7wmS2Gko4XDjGnvMRD9wM6rQYTpY3AurobjOX4PnuSOHgagMqKzjTyok3JN0JbWnYbABWItfFS9ldfhVURmmMmDM3cKaV1VyAFR9G3bvsDaNQl2luIkw0U6JUlM5SH+TWzXoukDBO9P0zeSiaAhHvHY1McCZHSjO7TMNWeRFiLqihTf0l8mZPGasxZkIk1lHiR45+kf/1DobYjRpdudYJ+iLT3K+MY4VU4ZpKiqdu0szMpiOx/vxEb8IQwDB6Ng/Vdg8Vi0esfPsIbKUM7pCKiCG0+hKk+gLvWKgFDbgUrSzJixNovRUCYOwLT/8jCT5X+yySnmMprGI0inuEAPXSXZZHoZd2gRJW8w+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWpTUXVRQytWT3AxcHJrZDJSMDNOR2RCVjNLSnFTYjYrR2lKUU50MzJQTTJZ?=
 =?utf-8?B?eS9wZWwxNmZpL3dFNjNmWERLVVhkS3Q2bGxUMUZmaS9HemZ5U1hWRmh4dXlU?=
 =?utf-8?B?N2h5SkwwK0hhd0VGUHFjdmxiR1NqUmtOdExsSXUyWHJ3YXc0OHFqSUZ2L1Vn?=
 =?utf-8?B?SW5PMjNHUjZkL1Z3WnozOE0wcEw3WkQxR0I1TUl1Q2hmQVA0TnFBVEFPd1pQ?=
 =?utf-8?B?eEdmcGxvaHhqSnJtSFdibEp5clAzSHBTZjM5eXFkL3dlWDFqeHdCdjhIODAy?=
 =?utf-8?B?SWZmOTRrSnpSYXJod01OWDBQZDJXSHNINnVEbWNmRG5VMy9nWTZWWjhhMkda?=
 =?utf-8?B?bGd5clg1cG1jVklhN3RBcVNFZTZEa1dJYUhMN21QZHY5cXBHdGZ6QmVTYXRz?=
 =?utf-8?B?M0dLNzBwL2NkOHk3N2VkOW9kTk1Ud3VKakwyUWVxYUM0MHdKNDJ1K3doRERP?=
 =?utf-8?B?NC9UeUxZSElVVGQvWEJMOGJRUHRVZnRrcVY4dDBFeWZaVEk5eHhIdjFkMmxz?=
 =?utf-8?B?RDNXT0lad2dBZzJZQkI3dTFrWG9kWkpYcXZ0dEF5d1NlanVrU0xqMTBJQ0hG?=
 =?utf-8?B?cEIxNnFoTzV3VEFqUlFFYzFnUVl0UW1zTUNCcGJhS2l0ZFV1TmRMUllUUUt2?=
 =?utf-8?B?R0xGWUpvWG1jclNuN09xL0VXdVgxZ1NTL3lmd09mUWQwdlZpYTVXQW1mUDBs?=
 =?utf-8?B?Yko3cDVaSUlEdnlaZythVVVGZEl2cS94WEVzYWFXdW05cTA5bnNsbCtST2p5?=
 =?utf-8?B?SUViREZSVUh0MVVJdjc5cGl0SnMyK3Z1QlJSTjlHZ3YwUE00MlpnQytmcEor?=
 =?utf-8?B?a05ySERsSzVSWm5GMTcyclNsTVdzbmdaZGd2dmlVd0doU2VmSWlOWkxPdVFP?=
 =?utf-8?B?blJLdytULzV5N3lqZ2cwVi9STWI4NEpPRmI1bGxhTytINmMzM1EwbndVT2pr?=
 =?utf-8?B?K1RhZmxlekJpSDZHOFRobnZ0VWtmYVV5aFdWN0NrR3FyQ1VxdmxZeVk0eGFT?=
 =?utf-8?B?SU5OUnFyc3ZVb0V0RjcvOFJsYlh5a0dudG94MzhyY1VUbndmQlpaTEhnT01v?=
 =?utf-8?B?SXM3Tkp6anRSaW56enlTVW8xYXR2QlpwS1NxeHBTeEs0Uis2dFhveHd2RHRq?=
 =?utf-8?B?NlloS082dWRUUkdKdVVjQmV0TDJFT2NxcXFHalp4VEhkV0V1NWJlUExaMm9B?=
 =?utf-8?B?THhtQURid3RWMDg5b3d2Z1N6amNEUG5WWjBNZWpnK09lVzdaWFdWQ2dCWld3?=
 =?utf-8?B?NkNteUNhT21zbTVKUm1oVVphWkpRbjBFcEF5OU5udEd5MlhKUTJVVXhHVy95?=
 =?utf-8?B?cG5ZOVpYcVpMN2V1cHJ4MkZjN1l6U3BObXJ0UDNwYTFQRzZ5WDVTdzNmZlVK?=
 =?utf-8?B?RThWWXhRUTVkNUR3TCsxSmJjVWxwK3VWWWpZazNod1VFYkZGN2krQWh4ckEy?=
 =?utf-8?B?Wi9TVElubUtTVGNCYXBDUVd5dkEzNTR5YkoyZU5KeFN3N1pESmFRQXJnYWQ3?=
 =?utf-8?B?ZVJERjBkMTJzR0tZckdaRHJDaklSQWVtWnpMdnc3RW9odE1TaTgwaVZGWnFJ?=
 =?utf-8?B?YWROcnRkT0llSTZoK09QMG1OV0tEZmt1aFR6YWdrSlM5dERYWW0zWEphOEcy?=
 =?utf-8?B?Rm5xUkplaERLZDVkMkRDNi9sK3ErR3RqQnpMTDc4OEZXeGlzdG9UTHJQRW5B?=
 =?utf-8?B?M1BRTHowTkMyT1liMUpsMmVZeHprZW80T3NseGxJcVA0Z3BjbGdwSnAxY29T?=
 =?utf-8?B?TUU5ZTl2NGwzUEFiYWUxTmdhcnljN3B4UXZ1aHR6dUcwMHFnN3NpWjU4VVhN?=
 =?utf-8?B?Mm1UY1RocXhpL1k3R1QzZmRmV3JNeGNmd3dXeDN5V2tUME9yTFNZMUpZWG1C?=
 =?utf-8?B?aWhmeGF1MVRpUm4xWU41SW56VEh3emZLbkVJYTdLRVBrQVhHUFRSYnFlcWpU?=
 =?utf-8?B?WlRNNk9kcW92TFNRYnRIVW5WY3JYYmNDZ0E5QkIvcmlaWThiSitmRUtlMkYw?=
 =?utf-8?B?cGIvZFd1VUpwdGVQdjR0czNGNXlaSnhvY21jeWxaZmhERVlLUlNkQkdrbm56?=
 =?utf-8?B?VE5YMmMxN1NJZFpOc1pxZG53Y00zWTFDQ0oyaXNDamt4eFE3KzZGekFjRmpS?=
 =?utf-8?B?Qy9jZGZCV0Nlc25vT0pOSHFvMWZwSG1Od05CNE13Ni9JNjNpR0JDcnJ0RG5U?=
 =?utf-8?B?WmpFQk5LL1JMSGhIOERMUUdqTlFMQndUbmJ6bkhIbWJjNi9VNytjU2hGdmN5?=
 =?utf-8?B?OEF3YklPNWdRN1U0Y1UxdkxBSnBPK251cE84WXppek9sV3Z4anIrSnNuRFBr?=
 =?utf-8?B?Yk12eFRpbDhFcGFXTTFLTkluU3BIamVEK0hXVUpKN1hiTU1rdWdpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29a665b-8bb6-4cd3-19e5-08ded830d61f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:55:39.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8KzHgObBiRzIMeO+i9gcHWZrnEAC+wzo0ad+ZZsBrNK670aodCFY4WvNGHKNH+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
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



On 7/2/26 12:07, Ilias Apalodimas wrote:
> Hi Michal
> 
> On Thu, 2 Jul 2026 at 12:10, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 7/2/26 10:03, Ilias Apalodimas wrote:
>>> On Thu, 2 Jul 2026 at 10:49, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/2/26 09:41, Ilias Apalodimas wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>> On systems with FWU enabled but without the required DT changes the FWU
>>>>>> metadata device is not found and fwu_boottime_checks() returns an error.
>>>>>> Being an initcall, that non-zero return aborts the boot flow
>>>>>>
>>>>>> Return 0 instead so the boot continues. The preceding log_err() still
>>>>>> tells the user that the FWU device could not be found.
>>>>>
>>>>> Won't that affect the board later on? E.g When you do capsule updates,
>>>>> updating the metadata will fail
>>>>
>>>> Do you mean on systems without mdata?
>>>
>>> Yes. if the config is enabled it will make the capsule update code
>>> searching and updating metadata.
>>
>> fwu mdata backend is not enabled hence not used. fwu just returns 0 in dump.
>> Updating metadata will never call any backend.
> 
> The prints below are just from fwu and efidebug for the ESRT table.
> Those will work.
> But what happens if you try to run a capsule update?
> Eg. efi_capsule_update_firmware() will call
> fwu_plat_get_update_index() which will fail,. no ?

it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().

versal2> efidebug capsule update -v 0x40000000
Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
Capsule flags: 0x18000
Capsule header size: 0x1c
Capsule image size: 0x41434
FWU checks failed. Cannot start update
Cannot handle a capsule at 0000000040000000

Thanks,
Michal

