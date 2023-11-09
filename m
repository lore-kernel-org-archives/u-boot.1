Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90869C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 08:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93238700E;
	Thu,  9 Nov 2023 09:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SujR7ky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1216886F6E; Thu,  9 Nov 2023 09:19:26 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27CF8700E
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 09:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvbaF1bq3JMyIKpu5VTXJNQ+ecTelQrVd67+XDpdFF6LML4iRRzvIdn3yv7CczpumEJfml0bpa9tCwjcZqf4xP2L0WYUkrTpNHWmZb+6OCH5/FO7kwqIrPn28HCHRQVrAYfZ2IqIINe7zdScFdbkGFgldWCw0IkdiXd8D8TPUCuv3chJz5x+STNZMK2X0FgnFthalzqoNDzzvalwLoswQYYUeA2HZNb+6xZMkugIlBM9w+9WuBUOvjIeZJ1CmP+kDcUVd953XaqLbAvkmlqBIGB4P6dYKvxU40bBKqFD4JjCUp+0rXouLHHzgi7UYPMzDX6SbQt9gKOfdcsBJD39Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9aAZwgXdQfspuBqrizGKO5bAtDgyXXj7SsJYiLl05M=;
 b=hTPwn4NoTJy9OKrSLdpyb6CyOCbSZ+xR/oZv5ACVJU2XtdivtE77ilnb/p/dQEKVENDGphAna/ROVdtpW9ivHSTRyxqsLA85b7h1GIwdYIDPGVgX6hRYoG7vsaiqorjGuogv8Ht0u3jdYX/h2VjWsii+qd1uh6rgrpyIBJIEJ5GFGSw/p0/gHws27K+xB5/g9xC6lCG7bD1kyfV+kv72QjppnpekMwRKR9GsEW2gcMI5Qmb0uOghTjIJBPcweSheVPNyEVZi7D1v8iw/z+h4ldJlfKu50z60iwKrs1yO7IGGOpubon7g4q5xqtOKl3kmq0TN01lg7D1UzzTiMYh/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9aAZwgXdQfspuBqrizGKO5bAtDgyXXj7SsJYiLl05M=;
 b=1SujR7kyWoQ3snWhM0YDXP9Iu5jX1/9rRPAz/PeHnDeW0USKT3GPTPEd/v8xpFfK3TKXAE2KIX8NUkW4q7vnTT7m3SThUzbZXvXQb+0fXWOt3WA5w/SqGdVExqlTQBUjdBnAMYRzI8cz7cDzjkukACxjJ0qJDQejq61lZF/DLRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 08:19:18 +0000
Received: from SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::10eb:f44e:608a:ec4]) by SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::10eb:f44e:608a:ec4%7]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 08:19:18 +0000
Message-ID: <81c83a6c-3ee8-4c9d-be75-ed7a6f60e151@amd.com>
Date: Thu, 9 Nov 2023 09:19:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/26] arm: Disable SPL_FS_FAT when it isn't used
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
References: <20231108164858.3497420-1-seanga2@gmail.com>
 <20231108164858.3497420-3-seanga2@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231108164858.3497420-3-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0031.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::20) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0f8f08-c94a-49e8-51dc-08dbe0fc9165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Og51E6PHlEhHcM6N3Dvf488US62P7w8HIhZmIef5JzdlW7jpicB50yaN8m4a7b2ll8rLQgjtWbxlg67AthahUZgBvccwC/l335S/7Jdyuq4fhFbZZDuPyBpiawZU2SlUC/oy8f1jnMWkHFRmnM4ZEuJb0/3X5Mu2KkP1ooKpWGCn2uUFravvypq1jfPlKanXV61q6ojZg0/REpqHksStQebDJgvq2Hsjat0yfqpOlK3ybHtx200L/DG8NkuV+KxI1lBs8AV71VoAYIthpBtc5OB23bCIw1yjunZLzDU96q8aYZUvrJPyBr0bLGwsM5+Wh+DagGwkOqkwEnlcv1aRILJZCBKyk2XShLMca85f2QJvB/mSlz3mY1YgYwy9M782n9yPcOoOwI/MHgGb2nN5Ni/0yozBmvWoT1kfnjel52Q4eXhyPdXUYJPaNuxrsiLsf3/H5JrttQSCr/LqSfLQXDL1nIL9k2zYHTphxC63kO86WqCb2mCfmnrT4BJp4h7fMZf5OxN5hDXFyT+UmPR80ijlr1zfDUUdxcYoqQSMiMsI7koHtJBRU0Qu3ipaCTMqceX9OGDKN7/cwfxhwltIsxjfBGXLXPnWNXKDCLfYP6xmkygymoux+fN+TBZEpsSHPsfSL+/05pVkvOc3m5j+YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4765.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(8676002)(8936002)(4326008)(36756003)(6512007)(5660300002)(6506007)(53546011)(44832011)(86362001)(6666004)(31696002)(2616005)(2906002)(26005)(38100700002)(83380400001)(66556008)(54906003)(66476007)(110136005)(316002)(66946007)(478600001)(6486002)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZEWS9oc1NTaVhSM0dDTCtaQXk0UFFjZFlUaG04UzU2WElVaE4xTXBoKzhD?=
 =?utf-8?B?RnRRLzJpR29tVnlZMlhqaDJTT3gvOFUrYXdDWDJTYk1Bdml6dDFta1puNWds?=
 =?utf-8?B?OUlzZXRrOSszaEpDNm5wNXllcVlkVGd2RHdtZEF3YmVyYjRaVkF3bjlta1ZK?=
 =?utf-8?B?VTl5c21md1VGUjgwZ1JFZUk3N0d3VVowQU9PUWY5RkxMREVlN1RWTDF3SWFx?=
 =?utf-8?B?eGlsU2dCUXhucWZySUF4d3BzZ1hwNDNqYUo5bW41YzhyT1VZaDB1ZE1nOXNT?=
 =?utf-8?B?c2Z5bk9jdTI1TGxoYklJODJNMkx1Uk1ELy9BUVQ5ZlJpQXp1c3gwZjNWYVhE?=
 =?utf-8?B?UVg3NFNwMG11Ym9xdUF6Zi8wazR2SmhaUGluQVl6T0ltZkZaWUJJRCtEaEdO?=
 =?utf-8?B?dFlnTUdpd0U0ZGMzYmYybWJzUExNQU54Nm5rZTNLSzBSankrTjU5cFAzTkhB?=
 =?utf-8?B?RDQzSkhHZVU5aEkyTFFTdjZ2R0hGb09CNzdENDIyL2E4eXV1a3JzbUNIU3VZ?=
 =?utf-8?B?bTVHeTZDMmhqV0hPU25QcEZRa3ZZSGxxdGRkb0YxRHZ6aENEWVdLSXcxbXRa?=
 =?utf-8?B?bE5FSmlBYWNXUDlURjd4VUNuVmRMUkxkVDdVZkhCMHFRUjREK3B0WnlOWXdx?=
 =?utf-8?B?NjR6Yk5qRExUcGQ1d3gvNlkya2dIR3o0N3BBemRZK1lGZktuaGIrSDBxMFpX?=
 =?utf-8?B?bjRWbElvUG9NZnFHcUtWYlMwZmh3bVM3a1JRdnVHdmd2RTVRNXhFQXF0L1E5?=
 =?utf-8?B?MVVWN2diaGNKSGtHdmV6NE5rQ3BSMnNCTFU1VXdOTlhhQ3VHc3dsYXNQdng1?=
 =?utf-8?B?RUFkeFpTSUgyNEoxUVowamtzSE1wcnZNbnJFTkgwTngwV0hrOHRtaHRDelpn?=
 =?utf-8?B?aURjQ2laVG0yWmRwKzdPaEdnS1M4angvUEMrYUsxc0t6OE8wUGRaVHNXdTVl?=
 =?utf-8?B?d0Eza3NEMm5nVnJXekxoL1lxOW9Bd2VqaUxJWUU1WjcyekpjakxRcXI4Vnhn?=
 =?utf-8?B?RnJwS3VFYk5ud3hYODVYQkZMMVF2QTJvZ1gzakdxaWtCWWpGNG1KSjgweDFO?=
 =?utf-8?B?YklDZ1EyMHFRWVBHRWhMV1RPbTl0Mjh5QXR0alRWNkZnVEd1bXkxdXV2dnBH?=
 =?utf-8?B?a2pVZXp3dk1wT1RaTEdvZndXdEwxQkU3YWpZRGtwc0N3R0Zsemd2S2FYRG5T?=
 =?utf-8?B?TXNYQTI3T2tDaktwdndIQnl0bWlZdmVTQnFOTXpKUng5VXFWSk9JQzVEMG1X?=
 =?utf-8?B?ZXc3U2plQkJOTHRBejRycGV6Q3hWTlJYazZwbkRDaWpWOGNmeURublZiV3F4?=
 =?utf-8?B?WUtRM1RHV3duWGJ1VDlENXdNV0xad0UvR1pibExEUUszR2FLSmtCdTFjRFlM?=
 =?utf-8?B?Y2phcXk4Y0ZXTGhhZlVUU2VQV3E2WE9wVGs1Q01GSHg5alBQSGlLKzZZb1pO?=
 =?utf-8?B?UkM5RGRMWG1hdVVIUDN3NTluNU81em9STWFGelJvZzFNRHBDYjFqaVJYUnU0?=
 =?utf-8?B?enZJR1c5M0N5NVpWL0RmNHR3blhEbzJINTF0c0pmQUNONUFSdjEyNDdsdFFD?=
 =?utf-8?B?MHdKdFg4YmZ1OGlLNnVDclNDMFlEc2FkbEFqK3F2bUQxVzRrcHpKV3h3WGFI?=
 =?utf-8?B?S0dNU21FV3hxVUhEcmtzOC9xcVdGU2FscmtLUzR5cER3TjVsa0JlRDZyTmtQ?=
 =?utf-8?B?N25KYVBrOEdqSFRKT0pvQ3BuU3FXckdScVhHbDJSdmIxY1d5bitFdTJ4NE1z?=
 =?utf-8?B?WmNkQmNpdjAwL213WnV4MlZVdG1OZ1BBRjIwUUh5bzlRVWlyUEdjbXJITU53?=
 =?utf-8?B?bENDSmExcFMvVDdKMFJrWC8vSURZTjZVblVZRHFyWTQxT3VKYW1reTBwd2Ir?=
 =?utf-8?B?dzgvN0xsWi9DWjBQQVV5cXkxOEd5Vjh0K0NWUjU0QmtzUUVGOXBZd2xVQUpK?=
 =?utf-8?B?ejhvVm1iNVNteHZpeWdiYTcrWXpHSllMeTFlL0hNWWlMbjhRTm9ibllJS1F1?=
 =?utf-8?B?RzdGSWh5S2tVL2ovenYzdG83d2MwalZMb29WNm1oalhsdk9Lb1FCSlgvenJM?=
 =?utf-8?B?L0RhZ3kyc2V6OUJUZ3VFZXBQdXVoL2RkZHhFSURFZXVwTXVTbW0yM2Y4UERK?=
 =?utf-8?Q?TAa9XtlJ/4dtWG0jcKI6gFPhj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0f8f08-c94a-49e8-51dc-08dbe0fc9165
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:19:18.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4XkadVO5Fn+9zc6ztJXXrMWBsVn+5rFbRZ6IQzTApgQNSI66huTSunC8zdO0xXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
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



On 11/8/23 17:48, Sean Anderson wrote:
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
> Changes in v7:
> - Disable FS_FAT for the zynq(mp) boards as well, as suggested by Michal
> 
> Changes in v6:
> - New
> 
>   configs/am335x_evm_spiboot_defconfig      | 2 +-
>   configs/am65x_evm_r5_usbdfu_defconfig     | 1 -
>   configs/xilinx_zynqmp_mini_qspi_defconfig | 3 ++-
>   configs/zynq_cse_nand_defconfig           | 2 ++
>   configs/zynq_cse_nor_defconfig            | 2 ++
>   configs/zynq_cse_qspi_defconfig           | 2 ++
>   6 files changed, 9 insertions(+), 3 deletions(-)
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
> index a1adfb9e5d1..b044743474d 100644
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
> @@ -89,7 +91,6 @@ CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_ARM_DCC=y
>   CONFIG_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> -# CONFIG_FAT_WRITE is not set
>   CONFIG_PANIC_HANG=y
>   # CONFIG_GZIP is not set
>   # CONFIG_LMB is not set
> diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
> index 19f653f40d0..2eb45e1242e 100644
> --- a/configs/zynq_cse_nand_defconfig
> +++ b/configs/zynq_cse_nand_defconfig
> @@ -13,6 +13,8 @@ CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-nand"
>   CONFIG_SPL_STACK_R_ADDR=0x200000
>   CONFIG_SPL_STACK=0xfffffe00
>   CONFIG_SPL=y
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
>   CONFIG_SYS_LOAD_ADDR=0x0
>   CONFIG_REMAKE_ELF=y
>   CONFIG_SYS_CUSTOM_LDSCRIPT=y
> diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
> index 64df1f0b83e..c5a28f28b9d 100644
> --- a/configs/zynq_cse_nor_defconfig
> +++ b/configs/zynq_cse_nor_defconfig
> @@ -13,6 +13,8 @@ CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-nor"
>   CONFIG_SPL_STACK_R_ADDR=0x200000
>   CONFIG_SPL_STACK=0xfffffe00
>   CONFIG_SPL=y
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
>   CONFIG_SYS_LOAD_ADDR=0x0
>   CONFIG_REMAKE_ELF=y
>   CONFIG_SYS_CUSTOM_LDSCRIPT=y
> diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
> index 9368fb4ffbc..9a2770af20e 100644
> --- a/configs/zynq_cse_qspi_defconfig
> +++ b/configs/zynq_cse_qspi_defconfig
> @@ -16,6 +16,8 @@ CONFIG_SPL_STACK=0xfffffe00
>   CONFIG_SPL=y
>   CONFIG_DEBUG_UART_BASE=0x0
>   CONFIG_DEBUG_UART_CLOCK=0
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
>   # CONFIG_ZYNQ_DDRC_INIT is not set
>   # CONFIG_CMD_ZYNQ is not set
>   CONFIG_SYS_LOAD_ADDR=0x0

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
