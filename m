Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C71C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 06:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D8B86F02;
	Mon,  6 Nov 2023 07:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yI+XCy0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269E786F23; Mon,  6 Nov 2023 07:59:17 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B7BE86F02
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 07:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQszG1O/lnE3LIsC1kkdq4ZtCY70jtQZAVRqpaIlEX2XRds2AzWDa0aOnt2g06Q1rPnYhKETvo6UygNYmWPPYCNdV4J+9Os1NEtZcUlAZG8Xc1ooNnTteXgTWrEsu63cwHT7A0k61d8LPsw9sXf3Y0Z2/dCtcLTE2Vsr4NpvcvD1kBkQWV2bZkVbgkZrT7o4LlLBi8Y3i/DfryVbvPmNI0fS1r+x8KQyEJf02UmB7KL2ejreoF4kyiUmfbQ+R1qZ7PbfaACRF8vuJWYrX+MhYigW260OA8cLRWH+mU8oaJW0kcBWlDT1+duVoyYq6QthzKLmZzdUjCZ5xlrUPMPCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/RRypwWUiThJFmGpYn2Qh8XedrjykADEfruDPr5+eU=;
 b=fpiSF9N/QI/Veah6kRf2qyOCainFOdLmRAZfzzsm+Bt35Z11lFe0h46o2DN7kBq9MQD9LZ0L27pMIiAnNKdn+M/s/S7YEJBnlCw5wWiAPWaBk98oYRlDXeDYTDc8//v9ix+uA7ZGfI9Gb3uvwoQoKFNPY6BczodkgOQOc70m1EzbPDCitWpToY46lKMeiRORfynxZTBQqaVW0r07ymcNYBr+rZE9cfOTds+Z5Hced7yFliJTggAfIJxbAyCpds5BF1eExmsDkOIUAdKHHQ4z6xnKFqNtsTXWhu3669JIn+gHchGwnymzZ9sowwzt521gqZq7YiVRFnIm80CPbmKjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/RRypwWUiThJFmGpYn2Qh8XedrjykADEfruDPr5+eU=;
 b=yI+XCy0gAd2c5Vlt/XVyky1FYfus/ZjUGb2MChGD8ZyAamdYju3W3q405yYSnQVNj/SJOdWZu6HA/DpSSQduyEaS6BsmtjS9Au2q0803WFcLcIk2t0HnE1+uG20yKJUUYRqoGDATzUiJlwGN7xPROPQ3fA9ERpCEk06C0n05yNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 06:59:03 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 06:59:02 +0000
Message-ID: <be86153b-d9e9-4861-ac10-6da6f60e64c9@amd.com>
Date: Mon, 6 Nov 2023 07:58:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/25] arm: Disable SPL_FS_FAT when it isn't used
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-3-seanga2@gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231106022603.3405551-3-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0118.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::47) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fcbce6-77c7-4729-1bc9-08dbde95dbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQy4fL6QLht9lipIdYXTKCGkIBaFBImXQ0pM/LuzRkmSmqnBG65L4GE1zRJNYOQs/Duq2QralSemDgpKlhDm+lILA6ifUIG9i73tCr1DLfTesCSg9GE6lEPt1EppDSswq76oOJnBYXLF633dhx6LtSZLqftJk5uIsEKYDrruhPkLdiK2Ob8726HUrtJR44ap3V231yJ63iqrZWNxJhPi9AlUVtS/VRiz4JhvVhmEry0pPS2CwIgd7+t3TpT784QORhqOECdq3ehA2RFvAqUBb0dIlNsGu/Wuo2+pwHf5C8njD3tj5NSKOMfpQJ5xdTI4S1Lbc0ATlGe2QZVXIkUXW4YW5nIfWjGqXj55ACiJN/56a/9Hnv92tdXq1aQ1/ZHiDIt5JCNbUrsDUzP0xVLKZeCTqg3vPGqRtx3Bof6C4tt8ZnBsMLfdAKrYopIJfKkKbPYOH2vR7L70PDqn/gC4kqVko0jnl8alwVQ4/4kZItapAwYf/Scz0kFyZ10RIQJLKDgnio8NkRop8ymn2Nq68P7liOZig5zHLc383B0w/6Ol2yvktxnK+l5qTxAUlm7IoWfWf/wieLaMWoEKJYm5nOQyUT2IsZAtoqitM0dZXuHpElZTFMU5sPnZ8y4hVvrqVOaf4aqheh2CxsnGSzhegw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(83380400001)(53546011)(6512007)(66946007)(110136005)(2616005)(26005)(478600001)(6506007)(8936002)(8676002)(4326008)(66556008)(54906003)(66476007)(316002)(44832011)(6666004)(6486002)(5660300002)(7416002)(41300700001)(38100700002)(31696002)(86362001)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXF4UHpJNTErTURaTGIxY0dsMEZMbnlva2I2eDBHWGhCU1FVallQQ0dBd2VW?=
 =?utf-8?B?KzM5R3FUVyt6YmEvNmVWOWFtTHVRWktCZWxRMzhDZCtjeDBvYzMraWNKNjlj?=
 =?utf-8?B?ZWVYRytyMlZzd2Y1MWdLeXAzY0lhdUV5UnZyZWlrTmZ0UDVMM2NHSHQyYUx3?=
 =?utf-8?B?bWp3Ny9ad09pSmhxRW5iTWo5R2pXbFlrMEUwWlNGdmIrTU91TVl2R1dKWkhH?=
 =?utf-8?B?R3hsU2Q2bEpYdW9idktud202Z2pPRCtUMStRTWJPTnl4ZzFSS25uZW4rZkE1?=
 =?utf-8?B?VFR0SXBrUlB4V0k0NDZ3dzkrMXpYdDFoRUFXbDByS09HTlF2amREV01nckpO?=
 =?utf-8?B?U3drZklzQnVOdExGZVRhQTFLZUl6RHlZR1lJNUxVQTBYNzdpNmxza3BBbDJn?=
 =?utf-8?B?dHdQUXVnVmNwSjZlQmRqQTR2OVZCaGxISUVOOVViS1dUWjAyOERzWjNjUWxB?=
 =?utf-8?B?bzNuYis3UlI0VytZS21CMzNxMkl5U0pRcVBQV3hTd1J0emhWV25DL0tobjBy?=
 =?utf-8?B?MjZHRmVobkRTckJPYThiLzlYYjRJdFNaY2hzTitnN0I2VjdRNFVkSDhnK0tB?=
 =?utf-8?B?QndZQzR4dW9XeUFpaEVDTGR0RlROVStPMzFPOXhxeVJUTHp4RlgrN2xqdXIz?=
 =?utf-8?B?cXpwYkZPeFZObnJZeHdHVUw2UHV3dDZqOVVCa1dRRHZtbk5DTFFsVG9hTzRM?=
 =?utf-8?B?Q0QzMHk2dXNZbUxnUk5rOWpmTUNjMzRvdzRoeHo4KzdEb2dRREhzQVQ2bDBQ?=
 =?utf-8?B?cDhDRkVSb21wa29lTEVtQm11elZZNVFWMzNvbnBUQndLQm9oTkpWK3V6VDlQ?=
 =?utf-8?B?eGJiNVpjMlF6bHcya2FKZ1FTc28yUEsrS0RtRms3OWhUMDJiOG1kVUZxaEJq?=
 =?utf-8?B?UFFuMnFLWU1KSTZ6cThKWnkzQ2w0Mjg3REdsN2g1VG1RUnptcm9QMElNQmNL?=
 =?utf-8?B?RlRvT01WcEg1bzlvM2lHV0NYeGhzYVRSSG8xSDMvbjBZdnBEQ1JiYjJVSjAw?=
 =?utf-8?B?T3dNTGxMWTRkSUhiVzJBakNaSXFnV1M1aG4yL2xoV0wrMEVhRVNHYTE0ZXpU?=
 =?utf-8?B?b245cVFINEovbHNpQ2ZPd3p4NWF2R2x0WjF6R3ZxemJkVXM1TVZOU1F2T1N1?=
 =?utf-8?B?ZURyOEd1L3FPTVpzTEZaaG44NDlrc3VLa1dKdnVUblMxRlV2TzJza2xDL1hr?=
 =?utf-8?B?M1pKejAvbUNSNVIxb1FiNjcwSE1mb1ZOMHhGV2xxaE9SMmZwUTE2UkdvdWV4?=
 =?utf-8?B?cFFtV3dXTWs1Smk2WWdoazAvNG91emRuZUk1T000bzgyWlZwSnFRTUpqVWN3?=
 =?utf-8?B?cGY1amRxZWQwQnh3WFVMR2R4ajJiYmNYTElWR003eTlXSDRMWExYdlVYckN6?=
 =?utf-8?B?dTMwbkNvRGxFMXJEdEI4SE5YOTVUTEdtQ3FESlJVVVlYVUdyT1N2clVVM215?=
 =?utf-8?B?elpYNk82Um5Ga3IyR1R5aXI0M3VYOEovK1VnVUlsc2xENlA5VFJ1UEpVdXh5?=
 =?utf-8?B?Q0R2WEpEYXF3UlNuajh2V2dJR1FhanhjSWpQcDk3cDdTRDdFLzRxekk3eFg4?=
 =?utf-8?B?VXBZL29JaUswVVRKSGNOS0Y2MUh1MytqaWJndTdPS2hMUlRqa25US0pjalA3?=
 =?utf-8?B?eDVlVmlpK3d5QU1uMHgvS3A3ZzRaNVdtc0pVOE53REFmMC9BamEvREQ4YnAr?=
 =?utf-8?B?S3dPanNHNDhzZjBZakFLN3JOSStVUDFMZGp2WlNaUUo3eThnZXFoSGJGV3Rm?=
 =?utf-8?B?c0QyRGoxQWRnQThub29nRTZGNE5KdFlCaVlEaERvZ3EyMVNKUnBOVW0wcGJ2?=
 =?utf-8?B?UkpkTjFyQ2dJVGZPZDQ5Z0p0SGQ4RUxralA5Y3dhTzFKMmFQcGU0UFR6VE9T?=
 =?utf-8?B?YTErSnhwTjRxS0J5OXBoZTIvOWdPdWNpTWFaT002bEJaaDhQWGx3SXBIV21T?=
 =?utf-8?B?TmFNOW5mMEErU0d6Mm56NFFHUXhGeWNXRGRIYitFTlVIVjBJTVlQbzQ3K244?=
 =?utf-8?B?ZHZGeEJ2UTYreThqVG9JYzVrK3BlUm5IKzMyak1oSXlFM1NLWms5TFFLeGRR?=
 =?utf-8?B?eE84d3ErVklQam9iU2YzUVZnMEwrcnVLR3JiamVua0xzd3JvWlloOS9nM2I5?=
 =?utf-8?Q?dR6fWFalcXcGzj8e0q5boHmLz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fcbce6-77c7-4729-1bc9-08dbde95dbe3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 06:59:02.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFymsJSvTwkyqzvoQdewLr8qvGi8Pr1GVpRWMjQB1mfDeTKsgoUnJ2If1gEKZHzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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



On 11/6/23 03:25, Sean Anderson wrote:
> Several boards enable SPL_FS_FAT and SPL_LIBDISK_SUPPORT when they can't be
> used (as there is no block device support enabled). Disable these configs.
> The list of boards was generated with the following command:
> 
>      $ tools/qconfig.py -f SPL SPL_FS_FAT ~SPL_MMC ~SPL_BLK_FS ~SPL_SATA \
>                            ~SPL_USB_STORAGE ~ENV_IS_IN_FAT ~EFI
> 
> LIBDISK was left enabled for the am* boards, since it seems to result in
> actual size reduction, indicating that partitions are being used for
> something.
> 
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> (no changes since v1)
> 
>   configs/am335x_evm_spiboot_defconfig      | 2 +-
>   configs/am65x_evm_r5_usbdfu_defconfig     | 1 -
>   configs/xilinx_zynqmp_mini_qspi_defconfig | 3 +++
>   configs/zynq_cse_nand_defconfig           | 3 +++
>   configs/zynq_cse_nor_defconfig            | 3 +++
>   configs/zynq_cse_qspi_defconfig           | 3 +++
>   6 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
> index b5b11fb62c8..fff5265e56a 100644
> --- a/configs/am335x_evm_spiboot_defconfig
> +++ b/configs/am335x_evm_spiboot_defconfig
> @@ -13,6 +13,7 @@ CONFIG_CLOCK_SYNTHESIZER=y
>   # CONFIG_OF_LIBFDT_OVERLAY is not set
>   # CONFIG_SPL_MMC is not set
>   CONFIG_SPL=y
> +# CONFIG_SPL_FS_FAT is not set
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_TIMESTAMP=y
> @@ -27,7 +28,6 @@ CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
>   CONFIG_SPL_FIT_IMAGE_TINY=y
>   # CONFIG_SPL_FS_EXT4 is not set
> -CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>   CONFIG_SPL_MTD=y
>   # CONFIG_SPL_NAND_SUPPORT is not set
>   CONFIG_SPL_DM_SPI_FLASH=y
> diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
> index f610b2dd94e..6b0bb120d10 100644
> --- a/configs/am65x_evm_r5_usbdfu_defconfig
> +++ b/configs/am65x_evm_r5_usbdfu_defconfig
> @@ -21,7 +21,6 @@ CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_SPL_STACK_R_ADDR=0x82000000
>   CONFIG_SPL_SIZE_LIMIT=0x7ec00
>   CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
> -CONFIG_SPL_FS_FAT=y
>   CONFIG_SPL_LIBDISK_SUPPORT=y
>   # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>   CONFIG_SPL_LOAD_FIT=y
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
> index a1adfb9e5d1..8b92e1c7358 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -11,6 +11,8 @@ CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-qspi"
>   CONFIG_SPL_STACK=0xfffffffc
>   CONFIG_SPL=y
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   CONFIG_ZYNQMP_NO_DDR=y
>   # CONFIG_PSCI_RESET is not set
> @@ -89,6 +91,7 @@ CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_ARM_DCC=y
>   CONFIG_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_FS_FAT=y

This can be also removed and also for zynq_cse boards below.
There is no need to have FAT support.

Thanks,
Michal
