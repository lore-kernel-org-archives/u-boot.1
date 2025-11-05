Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67353CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 15:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD88383A32;
	Wed,  5 Nov 2025 16:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cVtKZ4/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7077E83A8A; Wed,  5 Nov 2025 16:27:15 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489DD83A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 16:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reatmon@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLITDzw3IXM6nVBKZLGG3kp0x3cNyGGY2cF8bPL3WMwvyz78P4IdJj6+xcHqzHFl0MJDWPxzD7LiviAdHCXYXXvjBXDjHSGYuxDP65/qxO+A9PnLuTGiTr9soDRzkbl9cHuovQ5Exl+U7brkxSmA0XlMPXoDVB96RUrj61xj7I8jArdyweF70CuZsMLbNOQHk0FyBl+bor7sYdlxoOhb6G9y0kO3/vZLXAjjiGie8Gg92nnUBfdtcPkhL6af1vfZ29MWWIiqK37SFQ+zXViWEdzUJQKbpbaNs4zHQMK4n6YSAI4v/qCX/+K6hPaFFWO7yyKdKSpNXoO0VBxul1OEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ugKST/1ljfItKhtLAlfuNGrHekakRHBSLE89GmbEvM=;
 b=DFWtBtqD75BwsnDFfnVNEH9T3rt5TvBZcRhPygPdZ9Ei4bx4ltDQeHJFz/uY1OU8nspM9R9JRBxgbhkxKa5biGeD4WqHYRfNtNZe9mAdUsgZkcqlxyn6g+lbcCwA9YW6XP5Z/591oYkjnMNVL08crWkJH4kyv9Oc0tD/M28volpu58SdnspmwVry/H7ei7jniz4P8tM1JcrrRuWCbq9dPaQhWAAtFP2xPsZ/oLI2sQhjQ7EzZPB8CtvxO4syLAL91hDubsAELFh1qfoE/WCyvlyUgPXSXIXlLSbG1JuV/2nPjJzN5sABN54CBdOL3S9L/0WGEgd9ZgDBiBqh12tH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=disroot.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ugKST/1ljfItKhtLAlfuNGrHekakRHBSLE89GmbEvM=;
 b=cVtKZ4/10qjQi0CwBaS/wgK4YunIg4XQxwgUc+ErrwhBA319zZHCcbhw8XKIOwv+UYSa6cWyH9rCzLVjSQwRNE30w/23DWaj6BRKX08qdxhEVRn4hXmtzGZ1u+QkEWvyU6DSCLoR7qLPb4MI1TxSvzTCIRRxhM7YpvshzkZb+SA=
Received: from CH2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:610:4c::30)
 by MN2PR10MB4253.namprd10.prod.outlook.com (2603:10b6:208:1d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:27:10 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::f4) by CH2PR10CA0020.outlook.office365.com
 (2603:10b6:610:4c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 15:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:27:10 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:27:07 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:27:07 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 09:27:07 -0600
Received: from [10.249.37.202] ([10.249.37.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5FR7Vj3874463;
 Wed, 5 Nov 2025 09:27:07 -0600
Message-ID: <b52acd73-e065-4b5b-9606-f0aa2a64bffa@ti.com>
Date: Wed, 5 Nov 2025 09:27:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
To: Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, <ilias.apalodimas@linaro.org>,
 <bb@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>, <ziyao@disroot.org>
References: <20251105102316.1713954-1-n-francis@ti.com>
 <20251105144205.GM6688@bill-the-cat>
 <c41d068b-0672-4125-90ff-d68471b4c379@ti.com>
 <20251105151949.GN6688@bill-the-cat>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <20251105151949.GN6688@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN2PR10MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: fed9e524-9ae8-4abe-aefa-08de1c7fc9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy80SlJuTnhsbTRRc3JOVWdCcitVMVQxSjFyVnoySVhWbFlhWlNkTmhxNzJX?=
 =?utf-8?B?WmlwVlk0dEZpbTVUYTFpVHlWeGZUU3RibVFpTGFiSGVzUFUrWkJJOU5YQkJD?=
 =?utf-8?B?TmsrRitScnd6QW5mZko3Tjgzd0JCaXR4a1JsczBUYS9aRGtrSWVqbDdJUG9C?=
 =?utf-8?B?R0ZBQlA3OHpZN3d2d0xrT281NkdZdFdNT3VWQmtGWHJoQ2hWQ3l1ekJ5SVhv?=
 =?utf-8?B?ZnZhaWdYTnZXZTI2YjFNQVFSc3E0MlIyM2haNEYyOG1jQTdJczQvSWlzRWdn?=
 =?utf-8?B?a1YxU2VHc1hHR2QwMmZKRE9QRnlDVlJVQTdGd1lJdituR1drSFRnUUpzazhT?=
 =?utf-8?B?YVVEM2lDWHhkQitWRVB4S2x2ZjZ6VDFTN2E0eG9SRTlQUHNOVElnUDJoUmI2?=
 =?utf-8?B?L29VREhsaWgwb1NhZ2xNYmRNV1p1UWlPNTJQeGsvZmVSOE1CZVlyODIwZ3Qr?=
 =?utf-8?B?V2ZoTXlYSlNTR3QrVHltSWpLdmtVU1dxcHZHeFVMMEt1NnkyRHFlSklMdVEy?=
 =?utf-8?B?RzZGNWx5VFdhbDUwWkZTVGR2T2JvakVZQ1YzTWxwMDVNSE8vY0svSTk3T2RX?=
 =?utf-8?B?bmpDcFBiMFpZdkZxeGZtMU1PM1ozSWxweEkwZVdvWEJySGhQUzRHRW82OUpo?=
 =?utf-8?B?VWt0U3ExUzJLWWNidTFkN1REaFJmQkdEWmNkYWtzRnhBUm5YRUtIZENpVStj?=
 =?utf-8?B?dWk3cnZJcERISnFESE9CZlBnMWRwVThyTUE3NGZNSy83V1FGRXF3bWNqYk9Y?=
 =?utf-8?B?bnhDTUVzak1yQ290ZitXUEtwcGRJT053Nyswd3RDdlNiTmlwaWk1ME1kSHZ0?=
 =?utf-8?B?TXpPNWZQcWNVR2tKZFZHVEJsNmEyZDdHOXZTd1BWUkQyRHhBd2paNThDSi9F?=
 =?utf-8?B?K0xRUlBqbWtqR1hRT1YyRUkwZG5yaUtWYmlKeUMrakViRjJyUG9SU1FWU1A1?=
 =?utf-8?B?ZG83YXdSSGw3N3FXc0NlcTR0VE8xUXFwZEtvMlB5d1Q5WGZQbkJabW9oZkdU?=
 =?utf-8?B?SllzOXhhaHZjcHp6NEhHam1ZYkRyVm9ucUdaQU0xaHE2ZzMvcmhWZS9MVVJG?=
 =?utf-8?B?VHVUcE5pQkxzY0xXUkl4QXhmNURuZGtHVFUzMWVHNUpGRDM4NWlPNHppdWRv?=
 =?utf-8?B?b0NtMDIrb0xLSXFIbUhhUmVRVE84V0VRaENjYVdUQlZuRFJLOWZKRnhDTTRy?=
 =?utf-8?B?Mlh5WkFSaGovTmllVmg1YU50WW5BMVJsWW9VQVFQZzhJR0hFWUh2T2xXS1hs?=
 =?utf-8?B?R3F3SUFVVVJZSWJ3NE1oWlUyaTdiM0xxZVVZdDZKeC9NSlFmcFIwVWE3VzJs?=
 =?utf-8?B?NmlkeFVhT0htdmNtMENsdS9zakdKZzNmQ0tVSURSbjEzazlQc0NUOGdMQkZ0?=
 =?utf-8?B?NDJKbGcyYUw1a1prK1ZmU0VuMGtxS1Z0V2h3M3haS2tRakFvc1o4eThMdG9Z?=
 =?utf-8?B?QWtySDNnOEJ3K29CWTlhdzJYbXZKbUYyNXFaeEgveFdKZlV0clpYWGVBQ1Uw?=
 =?utf-8?B?WGp4TkVLQ3N3YW9HOVhOT21Ec0Z5KzZlQVJzK1Z3TlV3cktJUTlweFVPQlNq?=
 =?utf-8?B?UzJUdUk5a0RCYzBZZW01d2tXZjRNWS9ES1NsUCt2RVVycHpJZ08yRWxHM1FP?=
 =?utf-8?B?KzRsQzRQQWJjRXovSVp6bzc0YUR3U3gxRzh6MTNLQkpUYm9CNENjSFVqZWQ0?=
 =?utf-8?B?bmVFbXFCbjdaWXo3ejhMZUJ1S0tsVWdvajljSzRsTkk4VDJMdkQxZ0paSjE1?=
 =?utf-8?B?b1BHZ2drbVBEbDRhWE9FVnZUQU80Z1d2ZXFYM1BhRnp0SUs1Yll1M2tGc3NH?=
 =?utf-8?B?d1g5cVhCRi9HVkFFaUw4cHhtS1lJSGJjTnM3eGkxcUU3dVIrVGw4cnZRTGpG?=
 =?utf-8?B?a1hHVzlLL3lEYXdoZ3MrdG80Mm00Z0NQa3NaNWxoLzJ0a3RJNTdrVk4yOGJ5?=
 =?utf-8?B?RXFOWW1EeUpQSHZMRkhIc1Z1WXlZTnowa1NSN3djbDlIOWx4VjF4cTJKbVda?=
 =?utf-8?B?UFdzVUM3elNnNzlIdTBlY2Z2OUVJOUNSUkYzU0UzYkRrdFZIUXpqNE9DRUNy?=
 =?utf-8?B?SHNQZkExdithRUZVaXZRM2ZXWFdLK1dRdUVOQVFqZjh3VUlQSHJKZ1YrSFJI?=
 =?utf-8?Q?XDoI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:27:10.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed9e524-9ae8-4abe-aefa-08de1c7fc9d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4253
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



On 11/5/2025 9:19 AM, Tom Rini wrote:
> On Wed, Nov 05, 2025 at 09:13:15AM -0600, Ryan Eatmon wrote:
>>
>>
>> On 11/5/2025 8:42 AM, Tom Rini wrote:
>>> On Wed, Nov 05, 2025 at 03:53:16PM +0530, Neha Malcom Francis wrote:
>>>
>>>> Add support for fetching config fragments and defconfigs out-of-tree using
>>>> CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.
>>>>
>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>> ---
>>>>    scripts/kconfig/Makefile | 10 +++++++++-
>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> Isn't this what scripts/kconfig/merge_config.sh is for? No, you can't
>>> just do "make foo_defconfig bar.config" directly, but your tooling that
>>> knows about outside fragments can merge foo_defconfig with
>>> /somewhere/bar.config directly.
>>
>> The problem is the Yocto recipes.  There is a somewhat fixed manner in which
>> the recipe is setup and optionally adding steps is way more invasive than
>> just adding an option to the make command.
> 
> The merge_config.sh tool came from the OpenEmbedded community pushing
> things up to the kernel, so this sounds like a problem to resolve in the
> u-boot recipes/classes, and not something to change here. Feel free to
> loop me in on patches / discussions over on the appropriate list(s)
> there, thanks.

There was a recent patch to the uboot classes in yocto that allow for 
passing extra options to the make command line in for uboot.  This is 
intended not for "primary" platform configs, but for multiple alternate 
testing configs that can be built at the same time as the primary. 
Effectively, the code loops over the multiple configs in different build 
directories and configures/compiles uboot multiple times and then names 
all of the output files uniquely.

That flow has been in Yocto for a very long time and is, again, somewhat 
rigid in what it can allow for changing for each of the variant builds. 
It was designed to build different defconfigs which is what we are 
trying to do here.  But since we do not want to store the defconfigs for 
all of these variants in the uboot source itself, we need to be able to 
tell uboot that the config is in a different location other than in the 
uboot source.  Hence the most straight forward solution was a variable 
on the make to allow for specifying where to look for the out of tree 
defconfigs.

-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS
