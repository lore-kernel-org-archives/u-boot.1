Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84370C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 005FB87142;
	Fri, 12 Jan 2024 09:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4RJInzG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97FF78792D; Fri, 12 Jan 2024 09:44:12 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905C186D38
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuXa3CqkSdUiH4saAm1eUbfcb7FN96d0cGJsGH5tBe9/XCdKtBzrDd8z0WRSiW5klTRiyB1IXaPBn9BMTajRy2Csl+wyg6dWVaKLAMli59/NtIydwkBC1ogb6WpRmmEbBQNSwJApXQG373AkOuZM1RHE1fBikZAbRvcYoRu+/5NJz2qz03r6kx3g+gka22pc9C9cm3zxoDmlXFwoho6XQC2Hu85dyw+e8ljiAQ35TH2JDPXCX+UiRIlamiedGrjN0P4bsEk2Q7kIN2aCiL+2CybM9PHsXB5BeA3sTH5Jrh+kUSX96OVA9+N7WbPAjXg6RNgbd5snlyMpnFRxzCYOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGeA0S8rM/5NGoqWYS5Lv7w2e54zNYQQcahNyiU/A64=;
 b=AjVR6NCXCMtY0C4HXx0kRiUXl47Hj0rx9UeD7CREGbfllYkIP84INNC9iQFD8p5OFNGX+xV3bEqvjypKjYdwJ1y7hwakRqwjQs7jBEt3vRupBlBw5lI8+N75wI/TYs85byO7qakIyjU5jq/vpC1dGRtPTiejBZ8oB8PaDgK0xkwatlOp+Hee1XEXU2SwXqHKoP2pR3/tG2OsdYxAhFRJq9sYjHxgbyztKobRZn6XiATBzOQL5Z5bzMklc/RhdLSuQLfP2lGSXBVoOxNHS+7Hf19p2FcsFlJmzrYfNWE0vlTsPu6MRi/jYmRTnbyntYz5+ownD/ffddFX0JLIQKadPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGeA0S8rM/5NGoqWYS5Lv7w2e54zNYQQcahNyiU/A64=;
 b=4RJInzG3FgfsGqgj5aLUYmnbUZzO4wu7AyHx8uVlKaSeK9kxC8eQkgjPwAMtGg2P7py4cCbNsSnT5ruN1bgle75+xQOCNccu3MRcG+neSUS8a5fS2qT5Cke258PmIZTqNCKUUM7uhTUmGXlDCAPepOxLOBZZmdwYPE4gMK/4gT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 08:44:06 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 08:44:06 +0000
Message-ID: <44b5fdb6-147c-48fc-a301-0a60ed8042c4@amd.com>
Date: Fri, 12 Jan 2024 09:43:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xilinx: board: Update the kaslr-seed property
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240112061018.3280962-1-venkatesh.abbarapu@amd.com>
 <20240112061018.3280962-2-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240112061018.3280962-2-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df179c6-bc41-4744-563f-08dc134aa31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOfd8zJ5qmBeFhmyE+v5kGariphK40nbje+prssHCvenDkUFisId1+M6J+LmKh2R+OViAzDzcpLazk0q0E7o6kAYnPWJ6yDmSrE3zt5beIinDJVBrrQxb9G9WWupQ4NUa84rQo9WUjbhPIRQUsv4/48KeRyAlo5SCT1p6RJmHIO2CXQkYhw6eDzKWwdjhZPOwy4c7H6+sB7t2syEPd5KGO0u/ScE7fZb0Yx0he/YtWSUDkxXfGAputn5cFybuxsjJLZtMMlfcEdfmKSINkzNBmN0+KtyV0pC1am+/Mf8cgjdGwNjX0HbxPyBG3JWZ2McScxcHFuNf3tpHR8dnEvgBVnvfmFgRfmGOXJGP/3Fb3EIRgNalygjbIkrpUmC0Pj5Fp9L1k/njHkaKP4Nn6jaDBpswxIxMMQuSrVbdg9A0UnQUgPr00/6vo0wzBG7QXvVbbjMs/8T5z/CEeGJLvlh4CSIKCWJn3sOktBwecGuCPgsC6L4MaMplWCBrp6JTncvC8Gb9ArFRsZSZLGj91To7QcWukiYrbCaGbtU/jKOQjTDfwIQ/D2G3KPyb9+d3b6keTfiwkS08gdy7Xgyd0oiqpAWnri7GvbSalX6WnkuiTjkS0Aay+JilBaNL8Hea4ikY9nv1l23C+tNUQSG3m0iUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6506007)(478600001)(5660300002)(6666004)(15650500001)(31696002)(2616005)(6512007)(86362001)(41300700001)(8936002)(6486002)(66946007)(66556008)(53546011)(66476007)(38100700002)(316002)(26005)(83380400001)(8676002)(36756003)(4326008)(44832011)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VLNFNJTTB1OHlVL1pXaXVuU1kwWkZicFZEUmdOVEpja1l3NlNlKzVZL1FT?=
 =?utf-8?B?cHNzc25SR0llWEtQREhXOU1JazI1U2I2aUNJN21HbE10aVQwUUE4OFo2SHB1?=
 =?utf-8?B?cVEyc2FuVTZNY1BtZEZEN0R6bW1oYTQvSi9ZMHJBNzU3OHdTbUZ2ZlFody9a?=
 =?utf-8?B?TUN3QmdnUGQ5aDBHbkpHa2NoQ3lpNnZBUUJKNDJqQnhyM2ZOSDEwS3BlZG5u?=
 =?utf-8?B?R0J4dUJ4M3M0VHozcmFsc041V3dvTnVWV3FDdG1xUXVXQ1FHZ29Ocy9pcmdj?=
 =?utf-8?B?T004V2NjaE4zTyt5LzYxbis2WTNlL01iL09tV3FOL2huSForSVQ0cHkrZi82?=
 =?utf-8?B?VkpZR3pEL0JDZjV1OGczdXZCL0xIOHBkU284c0NJNUNYandLZmFzSXBjekhu?=
 =?utf-8?B?TWZ6dUVKWTBoc2RhSVZDMmllTEtnQkU0ZkZKUEtVYWZoVXV2REFwbTZ4QTh2?=
 =?utf-8?B?NTkvQmIrRGFOeHFKR081TnY5Zng1UEpmZDAxamxYZzFGV0pNQ2NkaWczUGVY?=
 =?utf-8?B?M0ZkZ2NhUXI5OWdhZnRUZFFLeTFKZWVIL2FNRzlCQWpZTkdWb3MrNXNqNm1Y?=
 =?utf-8?B?UWRjQ3hzbWlQdHozdzVkNjM4RXpIUEo5a0NaVkRzVFdTWEYvejBPM0dyRndG?=
 =?utf-8?B?ZTFzUXFCMFZTRkVDZjVpdU8zbUJJNnBaQ0UxOWtZbWRwenBLYWZvbnR3OHJJ?=
 =?utf-8?B?L3g2OS9GRmp1RzRwMEh3QzRscTF2Um1YN2M2aDFZR1pEM0F0WkpkdmZHdzgz?=
 =?utf-8?B?UURMeSt5Z3c4dVVZOEJLVWJoUU4rZ3gxZ2VTNk9jQmt4dGlqRnpVa2lVc21o?=
 =?utf-8?B?MWgrdDdEQnU2UWlCQzNKZm1NNEtvbXB5QW5QMisyWkJRV1N0ZUhSamMvTnhq?=
 =?utf-8?B?Q0hNcm8vRlgvQXNoOTNlR0JTekZkNEdweXlqUG5LVTZuM0I4N1JYaUc4SGh6?=
 =?utf-8?B?OXhjdnpNWjBtL0xRdStmdHFidDZ4TEcyTnVYZVMwZSs3aC9lSkdNcEJhWUpz?=
 =?utf-8?B?eDFaMWZXQ0FMck00Y1RqeVQ1V1RuS2x2S3BLNk4vT2p1K2svT1VWblhodTdY?=
 =?utf-8?B?c1Z3dXBPa0NSd2d0dlNmUWpMcjZqVWY0Mituc014azROa0hRL1pBSEg2YmJp?=
 =?utf-8?B?aFhjeG1SNU03b1RJaDVhK1NuelpNOE1qdkJtVlpTSFVUbDhlaXJvb1dDTllT?=
 =?utf-8?B?bjM3ZXFlUHVyZWVxOERoYVRUcFh3ZEpQWHNTQXJ5UnpaSHlFd3BTaG5ENWpa?=
 =?utf-8?B?bk9hOTYvclk1TUZFU1BydDlCR1kyajJabmJzclRZOXk5V00wNXZEdFVpRkRE?=
 =?utf-8?B?VWIveEI5NzRVek9JM011UkkrTUNWUnVwMHc5bE5nVU1VUXlCMitIaVhrbE8v?=
 =?utf-8?B?bitNRmlHSWphRnUrR3hWV01iTGQ4NWFVTDZrbVliNEJscjNZYnRpZzN1UFVk?=
 =?utf-8?B?bGJTdzA0NEJTU3VYVitOdWdYYlk2Yi9ITlZKWEpZbWdBRTNid0k2cnNtZlJn?=
 =?utf-8?B?clNSUU9sVnBvMVR0MGY0bXJxcVBwWEJ0U3E5U0tCK1F3dUZyNjB6eCtXSE1m?=
 =?utf-8?B?VVcrY1BYWkN3Z3dsVGtMRENWRk1HUzF4Qi9PaXA5TjVqS0RIcnFocFRRa3dh?=
 =?utf-8?B?bEVXaHFHYzRWTlg2SHlHZWhlKzhhUVI0cHlOQS9Mc0c3b3l1Yk5BQmpacGsx?=
 =?utf-8?B?dzdxWmpIS2YyVWI4anlhajZaaVdoZXhXSlgwWXpxRWRDdkJteTdseEI2ck1J?=
 =?utf-8?B?d0JoMVRVRWRZbEFlZlhLRFc1Z2ZKZnZEd3VqQjdQU2pzQStsakg2eEdhdXVO?=
 =?utf-8?B?SXFMTVZTQm9XOVRNdkMrY0dPSzFrWnFQTHVnQjNFZnpvaURkd2htbm5FZHQv?=
 =?utf-8?B?d2FtYXc4ZnlYc0xSNkxpeEhZeHJmaXQ1clNyaWNTMGFEZTZBcEV1b0sxK0o2?=
 =?utf-8?B?M2dGRE5CYk9FNi9kUzJsa3hwUkdtTjVJZFZlRHNPSWtTYVRXVVI4eU11ZFh4?=
 =?utf-8?B?WmlxQjZnV0c2aFg5aVJBNStqcmVnbk1tVDBxUEU5cDl1YTkyNlNrSDJmNFE1?=
 =?utf-8?B?NXA5STRYYlhqM1lWTFNCY3B6MldkR1NpM0VzOTA4SHVmS2RTbFM5Rlh1LzBt?=
 =?utf-8?Q?B0zyr7xgXQppsnv5CzVeMYmYb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df179c6-bc41-4744-563f-08dc134aa31b
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 08:44:06.6633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjCPwTI1MdsVQ9MBibyUN0wjBVmKMxJ1aNRzh4Ulhyy5LJpWjGNd8cDjmkmQnQrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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



On 1/12/24 07:10, Venkatesh Yadav Abbarapu wrote:
> Create a ft_board_setup() api that gets called as part
> of bootm/booti before jumping to kernel. In this
> ft_board_setup() callback that will inspect the DTB
> and insert the device tree blob with the "kaslr-seed" property.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/common/board.c | 59 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 12a877c715..985a3825e6 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -682,3 +682,62 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return reg + size;
>   }
>   #endif
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	size_t n = 0x8;

this is pretty much macro not variable.

> +	struct udevice *dev;
> +	u64 *buf;
> +	int nodeoffset;
> +	int ret;

put it on the same line.

> +
> +	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> +		debug("No RNG device\n");
> +		return 0;
> +	}
> +
> +	buf = malloc(n);
> +	if (!buf) {
> +		debug("Out of memory\n");
> +		return 0;
> +	}

Does it really make sense to call malloc and complicate error part just for 8bytes?
You can simply create array/variable on stack for it instead and it would be 
simpler and faster.



> +
> +	if (dm_rng_read(dev, buf, n)) {
> +		debug("Reading RNG failed\n");
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	if (!blob) {
> +		debug("No FDT memory address configured. Please configure\n"
> +		      "the FDT address via \"fdt addr <address>\" command.\n"
> +		      "Aborting!\n");
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	ret = fdt_check_header(blob);
> +	if (ret < 0) {
> +		printf("fdt_chosen: %s\n", fdt_strerror(ret));

this error is weird. Can you make it more understandable?

> +		goto end;
> +	}
> +
> +	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> +	if (nodeoffset < 0) {
> +		printf("Reading chosen node failed\n");

here too. You get this error in boot and you have no idea where this is coming 
from.

There is going to be error printed from code like
"ERROR: board-specific fdt fixup failed"

Maybe it should be enough to simply move all these messages under debug just in 
case and let code which calls this function to handle it.

> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> +	if (ret < 0) {
> +		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> +		goto end;
> +	}
> +end:
> +	free(buf);
> +
> +	return ret;
> +}
> +#endif

M
