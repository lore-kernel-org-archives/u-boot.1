Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C84EC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DCC870E4;
	Tue,  7 Nov 2023 13:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vyoo8uj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D52F867F6; Tue,  7 Nov 2023 13:38:57 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0154F870FD
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFXXioge5dG710I06PKjeEdWidt6iK2J7GMivMe5RGGFtf4BF3TB0AfcTMsxb1xfAqltAhxmKQV0r3bvY4DNWlTKw+MWNwfdIqG9s+bkKqijp0758b+jwXp9Gwza29w02IG4wFFki0uhQVbFC5eC59xmZN24Keum/sf99Td4txYOyyNUPgTATuVURBReawxEu1vs33rTw/NaR3jlTYcDArvCGP7EG26HmgaWbePBNLGsMtJTK8cJ8eqDS04OEAzi5/Kx2odVI8V6AJ8TeFa80nx+fUwpfXyt2Ssehzy6M0VmONmUaVIdOLaZLVxlZRwfMN5ss6wM5rOAiC4mo/wwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHYVhboLiJ60J1SY2t4nxc1jT70y0gVln2Avb4TiF/c=;
 b=PyDT/aamLcPrli61BXr6uBJGDLgvdJDaSUjwZw/zU+V4qxojSz43Lvkf9f+dk/gD+llGQ/OE78BMH4qqjjM0LrwJyTH2CLw6xq2s266btkdnChl9cLAxnPsCKR1wV4fsV33ClrErJ+GRRoCu9kEqTVRa2+PNaiO3c8OK1U7HZyOM87JQM1RcwxyjlxZaMSNImWffVM2UdpLF0z0RdRvzsKSObD6VLK8YtJc0ib9srtJEb2oHZzjjrIl0ZgjlRLWmeq4M8MHBKZz8JC9mip7TUyvP4pL9EOIK7bIofvGkPQECgJVCFbuFJ1ilfdym2b0Pqzw1R//S1Pehg+urlYTUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHYVhboLiJ60J1SY2t4nxc1jT70y0gVln2Avb4TiF/c=;
 b=vyoo8uj3XrqcirIkFdYd3LtLGiZNl/BaovntHRmvp79ye2/2lHQBv+XeYNj33OWymue1ThSo7mxYcSJZ0dW08tYYzMemq+JTp79LkzCbsT/iCavXa6pS9OGTy6XiOY7pf02mD66Yg1MNkhcdnyJ+6zpC+jXFtVL0y5AjJ4c3h9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:38:50 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:38:50 +0000
Message-ID: <a3267f5d-38ca-4c1b-b04f-581e645e2db0@amd.com>
Date: Tue, 7 Nov 2023 13:38:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xilinx: Enable SPI_FLASH_MTD by default
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <b3c4a3eddb71aab9535b034380d0dbae770828d4.1698837725.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b3c4a3eddb71aab9535b034380d0dbae770828d4.1698837725.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: f81e4c99-2f32-4619-6e56-08dbdf8e7e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBRxmMBAc99SRBfj5MCm8fMaGYeV1X8Nz/PPXR6BzcQKynXXsufcKsW6J71LRUEyum8YRHs4bwt0PDS+Hf8OkNwbTcHqKe2Dpj0AFnWuKx3aAXCab4L0q//1zNUl0/FtqYy4JbCe9cQ06nZbJdRuc19axrzzv0oY/fGHGPUO0GPelcfqnmcn8bRrZ7N+utnlXCMA6W1CMgmsm8Tq/Vt2FXyBgCzx5qvZtcqMJTvCtigNa+67zx1OO81d8qYzbPdPp1mcdmVB+W93biEwjIsbFBUMAGgzbxRx0LTQ1ZxrXASuwxsy6VLhjYlVUC0IoGEnwszSvSfCkk4tvvkGGhi5SbLuo+Vl9Q8VS97a50qk470lbIurzQNr0fWHinyOomDDDlfpmv0L4xusa/CgLCb/OyrP7iakEW/f26DMBbuymrAE+WMWZEPKUBomWmD+tg9AJ6zz9lMK1ZPsnA7Iiyz1la4XjLR/MU/dVWMmAEnpc4wT+/CEbfV3EppXyZ8LmtoDgIFmyIavir2Cb7Soq7qRbNJdvAIpJ0WgdRWoOhtoH5q0ZbQTJHYgKoNPHaRBpra9BtLWBSfN5yg/Ydta5YioBA4rnMJsM+CGu4PrJEmCmNopY7k7cDn2PnJ+RLb8UtG0hhnkUu6V5rAvTpl+FdhZgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4744005)(2906002)(41300700001)(316002)(478600001)(66946007)(66476007)(38100700002)(8936002)(8676002)(66556008)(36756003)(6486002)(31686004)(5660300002)(86362001)(31696002)(44832011)(83380400001)(2616005)(6666004)(6506007)(26005)(53546011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1wMHdnK2dWWUd6cWFFSGZCelRLT0tKK0IrNXl0SXk4eEFFbEpjb2RUeEd3?=
 =?utf-8?B?VzBTaDRxeDhDVG9lWk9hSG5OeElITzZTTXlsYmMydmFnR1pBWENBUFRVQmRY?=
 =?utf-8?B?OUIvN1NxOWtrQXJIbXNhb0ViTGlpSmZBYS8ybVNGMnZtcEUxbyt3S3kwZTFj?=
 =?utf-8?B?SFNVajdiNnI2TDVjNnFxNXljZG1HWi9JSTJ0WVZPTTBFM0ZSY0RYdU5TajBl?=
 =?utf-8?B?QXVNV2R6VkNFN3czVDFNTVA2QXIvRDhxRHVmeDBHZWdpMWNkejVIMk84ejJY?=
 =?utf-8?B?aDNTYndnYm9SK2xkSVFvU0dTWStJSHJLYUh5SkdmOHEvbjdNZzIwSnJBTjhB?=
 =?utf-8?B?bkp5WnVUOU1tWVFEUTArbVMwL293VGQ1bktSWFNhOXhEKytiZGZ4S0dvQ2o0?=
 =?utf-8?B?WDdhS21FQlp5bFArQlhnRlhWa3ZsdU9wbldubDkyQkxNbndrSFhHaHRVNkZO?=
 =?utf-8?B?OEY5eFU1L1RENVQ0OC9HbVdaNmRyZ1I0TUg3blhUUEVHeEQvQXhIQ3FkNmZT?=
 =?utf-8?B?YzNOTHZZa09HWmdJWmNOdFZBOHB1c2xIYUZ0K2d3ckUva3VqSHhCR1RJYnhH?=
 =?utf-8?B?WWlJcVhWR1BUVnNiS051S21KNXNTb2hPTE40a2UrdnE5ZmxzdHF1UGU4aVpD?=
 =?utf-8?B?WG1iV0tPUlVxbFRZSGZuOGRMZzJ6cnlVdUhjMDM0RlNsOGFtcnE3cEpEb2c2?=
 =?utf-8?B?cFVUUmtBSStmN3NkeVZ2QVpnUVVQbTdTVENIWUE1Q1lsVjR1bTZvV2NBaTVk?=
 =?utf-8?B?RVk0NWRuRGpJaHlQdkRGc1RYWTFJeFU1c2MxaU0wd1FPMkZwY3RScHVlKzBM?=
 =?utf-8?B?Vkx5ekpMVUh6d2h4NHV3dDIyVEUxaHNRLzdVN0dpWGNQVjdlTytmdENoZitx?=
 =?utf-8?B?clFXR0hkR0JraVBST3IwUXZWaWl5ZVhyc2NnNlUxQURabU1sU3pJV0N4eDhG?=
 =?utf-8?B?R3RSVUVpdUEvSHF2SjhDVFRxWTV1UnQwdHhkbVFkSU5hS3ZpRC9lV0tjM2ln?=
 =?utf-8?B?OVRKeTBiQ1pJTFlsOHJYRytGZ0s2UUV1aDRyNTk2ZWUyWmVkT3ZXRUpzSVFG?=
 =?utf-8?B?MHRvT2JUWlhQdWV0U0FhbXF5Mjdpc1JtUk45aHRDTSttMWNWbWJBV3NEQ0t6?=
 =?utf-8?B?RG9aNnlhRlMvSlZMWEMyb0lNWjJNcHFFaHE0bHBUeFMxODI0MXlMS2hINVh0?=
 =?utf-8?B?ODIrNVRIQjZMM0NHeFJUd2I5eXBjKy9uUzgyMnhSYjNVaHkwZDFtZldEZjFs?=
 =?utf-8?B?TXNGUE9MN21ndkE3UzAvSFBSdXpHNUQ0Tk1ha1BYS0M4TnB5Tm1QNEhvQ3JK?=
 =?utf-8?B?MXBqMkpPRk8zMVhCaWo0UlFWb2d6aHRwUVpiUUpmNWsvYXp5QUNSR0o1dEl2?=
 =?utf-8?B?SlFiZEt6cUtSN0hMOUoxT0NKVHYwZzR1L2RycjV1N3E5M3dPN01vUWZFWFgr?=
 =?utf-8?B?SjhLelJMVTZGbHltOWRrRjdrbE5hb3A0eWtaako2azNNUEd5djVJd0cwQVpF?=
 =?utf-8?B?SDNlRFNjamZFTkhEejJQOVNHOHBVMjh0VHhmc3BKOEM1SklkRTR1Yk5VVlZr?=
 =?utf-8?B?VnRLaUdpRE1RTVVERnlZZno0ZXpPOWlzU255bTlyeHlWSkZrN0wzcjNRSnVO?=
 =?utf-8?B?YVczTTUvNEdVVlpMU1JLWWtOV0hSeWM3dzEvTmNiQVlNc3FlYitEM29iMUVS?=
 =?utf-8?B?SDBkWjRqcHhSaUtFd29LdStrK3JYVEYwV2xxV1djWWpUZXEyTERnK2xzVDhP?=
 =?utf-8?B?VXlsU2FhRGRrMFR3WnZHRWdEdXdQSEpBNU5wMjR4NlBWQ0I4UVdydytQekND?=
 =?utf-8?B?SFZvWGIvSitCUFZDSmdHRWtnSkozR0Vza2hwVW1TRUpRZDdyRW5sYmF4Z3pV?=
 =?utf-8?B?NFdzT2c0d25vN2RXU2s3TkdUNkE4Zm11OWF5SVVFL1pkcGhXYXRLZWJhbUVV?=
 =?utf-8?B?MDZ3cU9abVptTEdiWktsQ2R5TE9wSE1NQUxQQ3doaHRDOW5nNzV3UExwTklR?=
 =?utf-8?B?V2ZGeERJcGpOMnVpeHlrNzlMekZORGRUVkVBL2RQeUlOVW1wWUdsbXhMYXF1?=
 =?utf-8?B?TFpXUURmOGhYT1p1YlZXODFyMTUvbjZ0cUFRM0hEaElYdGtWemZjRS9mU0F0?=
 =?utf-8?Q?+RJpXZ80iFFnSO+MZ/Lh2ufzr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81e4c99-2f32-4619-6e56-08dbdf8e7e2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:38:50.0993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm/l/ijJrOfFBIlgxe9QpMIRicFxiogGYXTismnh8xFBzQxt4j2TwJxcjg4+a/Yc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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



On 11/1/23 12:22, Michal Simek wrote:
> Provide access to qspi flash layout via mtd command.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynq_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index 6145af62b511..c3ee9beaef25 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -127,6 +127,7 @@ CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_SST=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_SPI_FLASH_MTD=y
>   CONFIG_PHY_MARVELL=y
>   CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y

Applied.
M
