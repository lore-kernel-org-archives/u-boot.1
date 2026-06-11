Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34ECD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 11:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36B8839A8;
	Thu, 11 Jun 2026 13:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJVqbncC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4094F83FEC; Thu, 11 Jun 2026 13:31:32 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2101838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaCcVhOigMHPMb02yJUrXa3qCUQlkgMZE2inxEOtxh6SqECGjs4Ob4Q0nlcjqLasN72P7ZbzJudScjd4Kmu7U2MyGTQ3Wq81B6NY4ju7rAX8GcIGDyS794ECyp22wG8eXCKzXdUY9Knaz/nyqgKiydvX3lLF+TDKRhFaXF29Ti72+RNswU8MOn5YAgf2NRBB/fSmsxKH7dgDsoYN/Dsd3QFh+SsfXm03giMfJinoacVp3egF2BCJCC5nG/of9gyVD7/9jk8lFvq4bxZ7D4VQ50PaHgCm7m8Ir/PTz+2VnnhXSwvVjYGqlOpzEGiqvBz/M15y75fjf9G0Iq9FUyLE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlNmKJq3TSc6+/WMZj2+4WYjltNrR1XPF3lcMfxcrX4=;
 b=bzVSTcZnFHvXRgZHpDtf2HPBBsPU+jcymgTGTErFi0RW4hgjgZ2mJqUIRkct0B+vYexnHiUBx037a4aKoHAvCyR01za0/XLtc+70j7uULuE+aOHj1c/SocpvVOuUOg8AxFVOxqsHSQy047xy3AhLi3rSZ1NkemXZ2VH4tXpPMNEPiZP3GZFCjJ/RKOo/siEz66EnmPgS+9SoadVtutqTk+IP8OlHezPcRsEx2CUCQHZEADHNnMWBpuquUKybrzwetHhB27NzMyHOP1CnCjt2iWFts5S5euISQKHqOGov3vV+EJisfEY7PAPEfRq7P3HSEvm3EA5p4rtiaJxbMBMj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlNmKJq3TSc6+/WMZj2+4WYjltNrR1XPF3lcMfxcrX4=;
 b=wJVqbncCjLFEa+X4rv7L40O7f/F7WlaUvISPz8FSacVqoFz2SCZpI0KJ1Vd7LWgzNwT7Y+15phUeQbzX3SYi4vFYFCmH64SAcwGUIWrASfdaaa8FjjG7RntEC8d1R3r7NKTcJOjqbSzk0QXQauzKEGD9kkfGCN5/ZN11o5BwgQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BN7PPF28614436A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 11:31:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 11:31:26 +0000
Message-ID: <d36d8742-3345-46ae-9e8d-1c9ed1c49525@amd.com>
Date: Thu, 11 Jun 2026 13:31:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mkimage: allow zynqmpbif to use a register
 initialization file
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>, u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260605135747.1814307-1-erich.e.hoover@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260605135747.1814307-1-erich.e.hoover@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0e8206-9f2f-4185-ff9a-08dec7acf941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: i2Ixu9JROTLPlWlnE1vatw66beTitZcp6zDHPr3Q2gNXftb9Y3toodteRMSyK/090KWjbijl5W3Y2MRQ5c6PVRtM0aFK+6Hy/xxMP5UuWdkrls28k9NtxRBDG3iHDketP+29PEg0wAUPX/MEWNAsV/ydHuKmKfnlpZXKPv2Z2DfTkZXqOrOdrsCxyVW1aq4JCjlKBZdxA8LmSNi+px8BebqjrWtkAvE1jAUWZOQxBWmI15Kjgk+8Lx8AcIQ0JViZUMvIZMGcmV3o1c+7VQ5UFpA+qk/Vm3i0Stua+4gZ8tSVrTS9etPEk4z4fjEUZC4kxiVLIE+l813Xs5VJqd1+haOrIHV3lIdrCDDSxD6LrGDEQK+RdwM+SnIBM6CrjT1PyvWUKRDBupJIFgf4yt2et+5UQsAea2lYvSddfrjMlP4IDpFYi6qEmTNccA6kZNLHfc5JlIl1GNAvk8vs2KiULvWH9NlwKQ+wY+gv4GNoiCpbgJH2rxqMR1PPYRSU9JXm5Y0CipQsFnLKi8ScVo/IaovYEhf8oR1Nyn6XNhP+NptT3zPZ5N6huNOhZdjELoFExjz5s58IhZqPYHt/x3YK7wCfk3Syhz7VC2eXH0O9blAQ2CVfQXsh52yABFd22D/BWVm8GhQk+wY0uWCuB89Ws8S4Wa4QY8BUmWSgKLAwXzZ7EYnGDEA+ZRYXCXyDX0FgHCLXE06/V2+Co8LeDM/QfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtGcnVJN3lBKzZtNnc3VlVNT1gwYWJPUHQ5eEd6SHZzVFdBS1ZuQ1ptZlhv?=
 =?utf-8?B?YXJKREhIaVp2QkdCY1U4eXlpVUluejk3VHBWLzBsNStPenBZY1VHcmd6Ukt1?=
 =?utf-8?B?QnBuZCtyNWk0SDFnZ2dmWENVSGtXNHB4a3BOUWdOL3NESmRycVU2WURVYUVu?=
 =?utf-8?B?RFVVUXVkQlQyTUxMcElZaStlUnpJa0h0NUJmd0k2WGVEZUdtK2Z4bkxITnV1?=
 =?utf-8?B?anM1b0NjRDB6SGNHNDV4YVlGTnV5aEVVSEgvUWlxY0w0UzBFdEI4dksvcjRt?=
 =?utf-8?B?eVZiK2pBNVpMNFRWTmNLaGpmc1ZRNDFRMGI5SFIwQ3JLVG1oV2dVRCs5ZVkv?=
 =?utf-8?B?Z2tUTm5OL2Q2VGRPNmZKTGlObG4zcklhOTFtNC9mUG0zNVl3MFJZck90Zmdn?=
 =?utf-8?B?dFpQWXRjRVF2NDRLZUZvVlAyRU4vSFVvRnhuZmc3bjVkektrUEJBWmh5dzZk?=
 =?utf-8?B?VHVuVzVwWkIyQktOcXVCWkIwOWJFNFR4ZTd5VGpCME1yNUp4OEhuTGZYK2w1?=
 =?utf-8?B?VE1pLzl6eXo3Mk1QRlRDZmwvSmgxeWJXekl6OVZmUUgzSVp1ak5saC9Kdm9G?=
 =?utf-8?B?akUrZXF4OEkzanBKWGhscXU1RFRVMTFYQUx6L3l4WENKbXBubGRpUXRiSE4x?=
 =?utf-8?B?b0JSSUYrT2VLQzVwc3FIUmF2U3J0RnMrNkg0bFpXa29RS1p1NnY2L3BWanpm?=
 =?utf-8?B?ZW42YjZPaHBTcTZyRkxqOGd0OW9FNng5amdjS3d0eDhJK0JMTzZsQklDZHVP?=
 =?utf-8?B?eStwcS9GN2tCVkcrbWIxblZmTW9Ddm9Da3MydUtXU0g5QUVLSm9sSkZ2SGhw?=
 =?utf-8?B?MjJ3MXZVbzFaSnRZeVgzbzhoUm5lYWRRSTFISzlBU3dJcFkvN1E1NWl4SDly?=
 =?utf-8?B?enNYZlJoTitZNHdKM2ZPeVdqYVhUZGY4b29BZ2h6VGVtSDJGRjFEc3ZsaFAy?=
 =?utf-8?B?bFliRy9lc3lsVFBGSGtQa21WNTMwT2JGOTJ4NGNtN0tJVjFIY1lOa01zQkNr?=
 =?utf-8?B?dEYrQzhQb29FT0RHa0Y4TldEY1NGQzhPNkxURmdXMStkdmlrVUxCU081TmpN?=
 =?utf-8?B?SkkvYjFyVWlNZ1J3NzFNaVo2bm5vZHRUc2huYXQ0RDVLWlJ2NUVyRWVNM1Jz?=
 =?utf-8?B?dzNBSjFCeTlsT3cxOWlSMER2MGJkeFVqNXNYeGlTWlhDeS9WT0lJQk9qVDhJ?=
 =?utf-8?B?SzhSVHRWa3pzYnZUeWptUndoVVcvMlBRd3dsbUkwdmlYaDFHVWV6V1BNQVk2?=
 =?utf-8?B?N0JOVEc3a2VkTUlmcHJ0ZnQxaDdkc0NXZ0NWTkF0M0RNVmsrMlZ2eUhEUzlz?=
 =?utf-8?B?cnlXaW5IR2s4RzVoZ2RqNUZyQVBDYlhPdGQ4QWU0aHdmYmdQSkpQSytsNmdU?=
 =?utf-8?B?YzRqZm5XM2ZabkoxMXpqd2VCczh0MTRmdSt6NjVKNHhuMmxzT3Z2ckVQMjVh?=
 =?utf-8?B?WUlINGdlb0QwQWtCK1BWKytSUUNzSU1BaGwxcWJYQzY3WDVSazY3VGV3ZCtr?=
 =?utf-8?B?L1lINDVmRXQ4d0JqUkRzdmtNMnF4WG9kWTh3K1NFRHdid21iZVVyQURkb2R5?=
 =?utf-8?B?NXhEdkxWaFBzYkdZSC93L1ZmK2NIZHRZUmRwelNPSTJkdjF2SzE2ZEo3V1RU?=
 =?utf-8?B?U0ZXRnNxUm10K1FnS3RFWUJmM3JqMEVlVFF5ZENFbnV0NXpKdFN1NXZBVUFB?=
 =?utf-8?B?MzF5Q0c2ODBaS3ZSRXZ4emtvNzhxbXI2eTdDNXpWK3NRTCtWdU1GMTluQ29l?=
 =?utf-8?B?TFgyb3NtNXN6RmNORzdLcjN1UWt6RTdSMTRUS242d2Rwa2lBWEdyT2JKNEtn?=
 =?utf-8?B?eGp2MlFDVnY2OS8vZVBZRlVLUTI3ajlMb1U1aHVObXhidFdLN0U1cGwwSFMr?=
 =?utf-8?B?QmFYbzJuRy9reURnQ09lRmdVeDNvWXNnK1VWR2UxSGhaQU0rREtJZ1liNGc2?=
 =?utf-8?B?WTZGa2NTQk4wbzg0VEg5SG04Z3A3emxIN21vU2tja2tUSXlBeGlVdkJVSitM?=
 =?utf-8?B?SmVOcEx4a0Q3eGw2djBUMnRZdlVZY2NDT1Q3UEhGaU5EZUZsbEhmbG5xMjQ4?=
 =?utf-8?B?ZnVxZ2V1WjNlQTRFK2JyQzZqSmtNVG5FbGt2eEJaVWRxR1hUbHFGZ0FlZjhJ?=
 =?utf-8?B?ZGJmM2wxbG41TzA5VW0xam03K3pvaWdnakxmbGxNajQ3OW5PUW9nMXo3WklM?=
 =?utf-8?B?NnZCUlRTQWc4cTJqV3NQRHBTdThzQXEzQjkwbFkzbzU0QmlSVW1vQTZWcFdL?=
 =?utf-8?B?cmY1M3pSbGxsNldRTTVWbmhFOGJkTDE2czRvdzN5NmhnamdQVTZETGVDTHpq?=
 =?utf-8?B?THZVek40ZkIvQ3IvWVMxbU1Rak1LRmtyM3hzd2h5WWF0eFl2Q245QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0e8206-9f2f-4185-ff9a-08dec7acf941
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:31:26.4612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBGdEpVKdhYt1iaZvVcVdUsGB48eVjoMDOSPJgoMFfgST/48t9ZwHvpm+Fop7L9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A
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



On 6/5/26 15:57, Erich E. Hoover wrote:
> The ZynqMP Boot Image Format allows specifying the register
> initialization file with the "[init]" attribute.  Since this
> feature is already supported by the "zynqmpimage" backend, this
> commit leverages that existing capability to add support for the
> "[init]" attribute in the zynqmpbif backend:
> https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/init
> 
> We are using this feature, in combination with other zynqmpbif

imperative mood.

> options, like so:
> ===
> image : {
>       [init] fsbl.int

please use different name then fsbl because fsbl is not doing this programming.
That's done by bootrom itself.

Topic board is defining it like this.
board/topic/zynq/zynq-topic-miamiplus/ps7_regs.txt

but that's for zynq

Actually I think would be good to recap format because origin format
is different compare to what it is used by bootgen right now.

https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/Initialization-Pairs-and-INT-File-Attribute


>       [bootloader] fsbl.elf
>       [pmufw_image] pmufw.elf
>       [destination_cpu=none] fsbl.tcl
>       [destination_cpu=a53-0, exception_level=el-3] bl31.elf
>       [destination_cpu=a53-0, exception_level=el-2, load=0x08000000,
> startup=0x08000000] u-boot.bin
> }
> ===
> 
> Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
> ---
>   tools/zynqmpbif.c   | 16 ++++++++++++++--
>   tools/zynqmpimage.c |  4 ++--
>   tools/zynqmpimage.h |  2 ++
>   3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
> index 82ce0ac1a52..546b9e4fd9d 100644
> --- a/tools/zynqmpbif.c
> +++ b/tools/zynqmpbif.c
> @@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line, struct bif_entry *bf)
>   }
>   
>   static const struct bif_flags bif_flags[] = {
> +	{ "init", BIF_FLAG_INIT },
>   	{ "fsbl_config", BIF_FLAG_FSBL_CONFIG },
>   	{ "trustzone", BIF_FLAG_TZ },
>   	{ "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
> @@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t len, size_t *offset)
>   	return 0;
>   }
>   
> -static int bif_init(void)
> +static int bif_initialize(void)

What's the reason for this rename? I don't think you should rename it because it 
is just distracting.

Anyway I have tested this patch and output looks reasonable. I would obviously 
prefer to add more features there (like ignoring comments) or unify the format
but that's out of the purpose of this patch.

Thanks,
Michal
