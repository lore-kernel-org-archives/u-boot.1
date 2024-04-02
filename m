Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA5CCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 12:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC23A87873;
	Tue,  2 Apr 2024 14:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gf8m1U9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82371878A1; Tue,  2 Apr 2024 14:41:48 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B4C8772A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 14:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVrePiF8LLyg9/Da9YusS3f0qgBhl7FvAi8l+t9OO6avPbmG9Mu0KQzvTzX8AovFkTnU5dLlJbL/BSUUFdBFb1oJYvkdNWUOnA4Qfna4pxIgpMeCCR9w/j1MbUrYPhDaUsvaDB0V6q2cYeMoO7OoP2+9JvTQ7RMav5+5PvYNmjMrryDPQQHv5SsRIn+S26hXS0FE+ay/ik4O0XaItTu/nJTnc0QUTgGKJfv+KhHThPqSop5QVSFWRHfD1okdlmqWhl7uNRaxSHiMxobta9+9Df5NJ35WLOBOedm+7S1uJrM5JjONJ91T8Jox8Ki7FauXmr5PouY53IYH2WHoVWRDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0BMzi93b9I6BQZjSgF1rLNqTBt4hFDC4z049W50rTM=;
 b=J++mBpa1br9tvSlRe1+oEqEqfj33jRID+5PQO6nrVkXvB5vmrN9/h5ItJrMQL4ywy4waJIC5h0w4KdDjW7Uf/FpWpZvLPed4AA4qY3qv/0LvbwVQ5+NC4YpZTvr2k5lKB8FxsHEV1aW825ADJWImeQrskmX3uta23x85UQ74ORF2+YN0ZjUJ9QoUwziOoyWjhYmF1NPSfSp/CSMr4s5BKufoMYR0T78cJhEhrhGOQBpQvmBGjjI6kegC1v6eE3wIkLgnQ2rEYpRi5eBCrZpLSCy4zPujRSfWGP+P6j+vwAj8tul2eDeFy34nsSyWNnivKbXnEyghg/Znq7J6o27RMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0BMzi93b9I6BQZjSgF1rLNqTBt4hFDC4z049W50rTM=;
 b=Gf8m1U9fXjEvYomepoedxXLHYvDr6H0IayALwQONlwuXqdkM4mbdqt5+va+Y/0cAxp7ZFeYTTsUQgmy7RxO5M8TGMg8tPKLypa9G8Xmy2fmo1nwB9JC1tOkUfSSU/Ft10kX7cv9NnwjQ2BM8AJ+oqKLS8sx7/zySs9A1LnWnt3I=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 12:41:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 12:41:41 +0000
Message-ID: <7fe20558-6af1-46cb-bbfe-af308e3ce279@amd.com>
Date: Tue, 2 Apr 2024 14:41:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240331232859.727769-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240331232859.727769-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:803:14::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7218:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuwDTZf3z7zUXXkalbqk5H+G+yylypzDRuN/CUZQvOcnmcyAvQCgYR5yTQo5U5DR+5VBX/pkMYcE5YzM886RnaXScX2rMPSAvu4hil1ZwWGYAg/gIFtg47HG1HuA1ITB4Y2gZ5f4IG5xCYPjEWGM0BHnfJdjqhVTKEkINHvd7lYv+jO9xiLlC0/fhddehhx+IG8qNT8M/TyKG9F31dVw9lZ4sLXS03dq/3qsmJPRlCNLrHTYRgmpPYeF55TmGX1DkXn/ewT11Hdn5DJ64K2B3dI+5YnZccsUc89iZhWn3X2KTge+YYmmVfU8EtUqa4QTezn7eBNu0G+fXuPNGf1WoaxRqgDPp1VL4K7DkLzKxI7O6uldnTMBGFwoz5saQPQfEViPjolui+vFvIw6hgfrktsMlzVBF1q57qUNCOjTUNCVGWdR+/JK8RBXYD7DdtBcBIsjs0JO/iOTTvg9eedwDfBkuFKLNPH1ymj0sHqFdP7RtQOuDRUUBwEqcMSUsXjKqoUKrHSTo+dTFizQuT8E2mhi6QnGHDl1eYuW7asVCvhYeDeeYpaU1dE8TNPeO1Mek6Wslkqo4aFg1yVXzt5okUieG/xa3ngsw7nGipgTX/79/PSV06J+WHS5lSBm9stNrQlF0loZE3erzBv6hLiT9OYTI1MGhEL0crmlaFWEcrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUQ1MlZWTDg1eG9EdVN0Rkg4dGVRa1lkejB5c3pFa2dSa3c2OXBabXJCdmcw?=
 =?utf-8?B?U1FVM290c1Y5YmNJZ24velVBNFJFNjhhQ015bThsVGpUTzBFN1JMZ1NVMHI2?=
 =?utf-8?B?S0NsU3lpMUVMUEpvMnRJODRMR3NrOTlxeW9lWUZVMUZLaTFhWTZtWFNqcDMx?=
 =?utf-8?B?TnFsanNldjRrck5sd0QzNThIc2lFd2svV3pCZjlEU1VpdFh0eVNSYkNOUmxS?=
 =?utf-8?B?U0REYXd2OTA1MDNoK0h2d1k0QU8yUkhJM3BMMXpqTndWM0ZnT1pVN00rQno1?=
 =?utf-8?B?VjhyMHpwVG8zcnJuVXM2K3VCdlJNSEM2WHpGeGpMQjN6aXNKUmJWT1RKZmRq?=
 =?utf-8?B?d01KWUdHMzFabmJPSDV5RXRoSExVOG9oSWJkTVdiNXBxMEp1TGx0eDFnTUgz?=
 =?utf-8?B?U2VRdHBNZ08wL3IvYVZEYW1NTHRibjhaaHEvWG1oMTZTNUZxNk16VnlsSG1J?=
 =?utf-8?B?MGpBdFZadGoza215NG5ybVNuYkRvamRIVnhMeWpWY0lSVUpyR2RQQitpMlBq?=
 =?utf-8?B?NjBZRjBRbGpHNC9ibzBac3ZndTFrZVJYVDBPZC9BMndNNEF0ZVZma1hvaWRI?=
 =?utf-8?B?bDRLQmJWVFNTRzlCVlBXVzRwUUZQV3NyR1JSYWU1MGhQMnp5QkI3VHM0V2Fa?=
 =?utf-8?B?dHNBWUlSTHNUL2NPMjM5YlhkWlpWY1hrMDYxT2xjVFNmd0lqQ3JtSEgwejJS?=
 =?utf-8?B?RWdHcEVaczZTYWY3bzNjczdTaEp0UndRTkFtdFFlZFBzTWZQZHh1QkpzUmVL?=
 =?utf-8?B?eUdrWnduSDNGK0VwZ0cyQnA3dnpRZjVQNysyd1NvMWR5MTN1QkpOY3ZJZ1lW?=
 =?utf-8?B?Zzh3STdGTmsxU3FOOWplVVZPcjg5VWtIQXF5WGo5VXR0YThPS1hxNEdPREdY?=
 =?utf-8?B?VG14OVp6VTNwSjBRWE1nYVBBa2VPd0p0Tzlua0JuRmtCcWdlOC9XSnhnQnhu?=
 =?utf-8?B?THhqUm91OHFVZHc0SFM4R1p1eTdXdTQ3MzBPVDdMQ0htcXpmbnpXN1JCOXdT?=
 =?utf-8?B?Y0gxK0I0RG9VZld1RlQzQ3pia05hREQ1UGEvRFhTUFNhWXNadCtucXRzMGJj?=
 =?utf-8?B?TlBmQjlVVzRnSTJVVHViaXUxeVNMN2pUc3gvcTZpazlMbzBib0diclYvTHdp?=
 =?utf-8?B?QlY1T1BaS05UMzNDbFl3OG9rMW1DVzdiUzlQVXhEWXVvdi9YRkhSQm45Wmxl?=
 =?utf-8?B?Qjdxd0d5WjVtZmlmU21jTkNQeDc4WG9venMvVUM2L0x1SXJLUkZOemNMRkdr?=
 =?utf-8?B?K2x1bjN1UEhvY1kzRnVlbitEdXh0RjNDakN3VDJnb1FYSFF2U0tLaTBxUFVL?=
 =?utf-8?B?MHNockU2eGgvNWdlZ2dnNnVwRk1mQm5GaEtXZ2lQSG1wOGk3WjVKMVo2cUZI?=
 =?utf-8?B?QnB5SHpPaVpJZng0UEd1ZEVpdjBidjhSTHc0ZittekNnNW40eCs1eEorM1pv?=
 =?utf-8?B?TllibmFBUGpyWXVQMUUvanFHMXRRNmpwMFpKRFQ5RHhEdzRqNjR0TWpnWU5u?=
 =?utf-8?B?L2pSb2VmZFBKaW95Y3JVby83T25lU09rOW5DUXhkaVNIVmE4aUduanlSdnlZ?=
 =?utf-8?B?Y0QrUFZFNVdIcy92K3loa2MvMVIxUDdBcS9lcCtkL3lnRmNEekJmTzBMcSts?=
 =?utf-8?B?QzU0aG11TVQ5eVVWMWVqalYybXVFZzJWQ1pIVk4zU1h1aUZCaW9LWE1hbTQr?=
 =?utf-8?B?VnRVRktEOFUwc0RBUVpTQzZhNUJ3NkxhMEhRSlRJSHN2RW9YcE5BRzNWb25C?=
 =?utf-8?B?UWVRZzN0TXQ1NUh6c2lnQnFWc0pVa1c1SWZTMDE0c016K0tNWEd3ZVFoalF3?=
 =?utf-8?B?UFN2cFhBQit2Z1pDSE4wSVJZNW5neWlFeFFkMjlFMmY2dVFzcjNXN1ZpWW4y?=
 =?utf-8?B?L0duVUE3RUNDdVZWZEZJbjljbWtGa1FoKzFGUytlSENkMlFIeDFwNDlFTENL?=
 =?utf-8?B?ZktVL1hqZjYybmFLa1BOZnRQdiswQ05vRmJWVWtiSEVXTmswN2RRMWpOdHdN?=
 =?utf-8?B?UE13TUs0eFhnNDhOdGNLdFNkV2FtRlMvN284TlVzT2UzNVV0aUZwSms4L0M5?=
 =?utf-8?B?UXpCMGZ3Q0FsMGkzMTJObFBteWVBQkNUYlFFM3gwOHNiNDdaUE1DcFJvb21G?=
 =?utf-8?Q?21t/nssRdox8sGRec4GfT3bz7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d088113-b3bf-4a91-8c39-08dc53123f2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 12:41:41.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpzXPD+sef9+jQyQWK8epM+G+HE6RFYOFfomzWgTolBCy1JEPJ9LC1McM4sFV0tC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
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



On 4/1/24 01:28, James Hilliard wrote:
> There are situations where we may want to let U-Boot modify the FDT
> nand partitions for the kernel, such as when supporting multiple
> sizes of NAND chips.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - move partition fixups to board/xilinx/common/board.c
> ---
>   board/xilinx/common/board.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 9641ed307b..20a6f00e45 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -12,6 +12,7 @@
>   #include <env.h>
>   #include <image.h>
>   #include <init.h>
> +#include <jffs2/load_kernel.h>

What is this header used for?

>   #include <lmb.h>
>   #include <log.h>
>   #include <asm/global_data.h>
> @@ -20,6 +21,7 @@
>   #include <i2c.h>
>   #include <linux/sizes.h>
>   #include <malloc.h>
> +#include <mtd_node.h>
>   #include "board.h"
>   #include <dm.h>
>   #include <i2c_eeprom.h>
> @@ -693,6 +695,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	u8 buf[MAX_RAND_SIZE];
>   	int nodeoffset, ret;
>   
> +	static const struct node_info nodes[] = {
> +		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
> +	};
> +
> +	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
> +		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> +
>   	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>   		debug("No RNG device\n");
>   		return 0;

M
