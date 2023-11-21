Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967FEC61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 12:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15914875A9;
	Tue, 21 Nov 2023 13:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbBQFyh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84B187545; Tue, 21 Nov 2023 13:52:22 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0A5863F8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 13:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLLct3+FWzBGoyDFK4FoVCTYbECs5I3mkeXYBJ2oW9gFuiLzPSPL+rMIeCXoih6U7/zyPR9m7cRP/xCWIdYtvhhWVtvEE+Njtay0H8loZqUGtivD7/lmF9l+BzKhHJuUAXqYBCupYNhOvS4xSYVHgIQp4Araury/36EwW0r2iUTkGLKLVW+gE7PUPk3lZfRLC/RsHXYHrOrDmDToPxiFrmXfoNJkE1atT6yblJ6e7hL6Sdj2ZOqaENyYjf762+fIbN54bEmNgQmUmZrRfpKWM76bhN2R5T64CUvi3yRgj+Xa6CI3Qujs1B2pyoqdwTV3eMIP+f9NVx8GExW3C2VaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shuV88HJ9w4zAkTAzEQDpSjmKYpv3doJlYAW5wrdbfU=;
 b=J8C2YpVTRmNJ8OrqE6+MqU8pWRjJnJLOP40GR3JImxJMGo76WDl1wU2OcfqsYyLldydY7J4i7OQWqAyJgPd2UPNQ4xAATpdfd42B9WP3vy5i96dCubya2a77VMjyOmzvuod5ajvYYX6Yma8unQgbwDa0I73NyDoXGdeaAvcm5YplL1WUOnmxGRRh3HoBYPhikL9Axfgl7sZsj/awxtQD5o3DY1BuyA8gEAL2HOlSmbaCbOvm57p0kjqR/Xi8KYcdZAohGzAS8XejMKgVze1/IfUtoGK7KEeeXi7ISf15rIzFwwjl0o9UIWT0trB0p7ZFgD+nBX5oqH7f2jBN7NYXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shuV88HJ9w4zAkTAzEQDpSjmKYpv3doJlYAW5wrdbfU=;
 b=PbBQFyh2ef65fA9/gYoJWyBzeJHuqqRDFLsb/u4WAtqXaabM1+ufNGqxBtLwv1Kdb3U+cHPMLcVmOYjAvYv9iSGBGzhf21nI86KiH3uuAOLfn0k23iCOBZ2xTq7VrCQRIWNTM3IF9xBPu9cUvrcLqRSciEm+AGF1tGO2pUF5amY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30; Tue, 21 Nov
 2023 12:52:15 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 12:52:15 +0000
Message-ID: <479896de-259d-4ea7-a5df-b2cf65210a7e@amd.com>
Date: Tue, 21 Nov 2023 13:52:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add multiboot support for SPL/SPI offset
 calculation
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <93903a53ad9358ae69991558b787f574797effbe.1699619666.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <93903a53ad9358ae69991558b787f574797effbe.1699619666.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0209.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::30) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e86ec0-3948-427a-21a9-08dbea90afb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Q0Yk51y76iB45O5l/w3M6akNgZLA1ioULlob1OppEH8uiFELlcmPLL5K10h5BQLvo5NT1I+JKpwhN9jKFZEeDw2HU1CFKw41PFmch+qgZBndaQC4eJ+KOhw940t4C2oNFt5pggvmmtwmziG33jTab6NvVEqNp2645ErmwQ8SlFB5aZrlSBiQ6T2zGUtahkP5SQ0vGX/GGb9IcuUbJrd7dS6YMSNfD5huz1IoopFpzA9XKQTk8BSOZT4UJPysD2mSjUGbqSyyiGI2SrKtAxW/NVD7cbzNip2u7cDm4tubzDvuUlzNcHOgqAm4KCzsnsS/cTG7orxbEjfQ8lcE97O452+Pp3EiOpM3zaCi5r8DD6tMuH5d+R4IJiTdzfd+Jw6ZpbZEQrpQdZQsLFMJb3HPqd25bsjlVYjW9G3vR3UqNXkfNKnZolXmU8/EDKC0QzKsWdmiMpgcu/fvhQyuHQ9y4QRkbaVYMsodp5TJFhSwKonjrinq60wSbGWPaNvT/vSar1jvmIJLJ1xzVC2EyboLLuI86gL9zoeK6n1On2yOckN3py9Ep0eGDYJRR4sxu4g5IqKd3F8BXg2g/na89hRlvoqOXj5vPL3XiaeOeeSive2JVJDxQYmcpD5NlTgXDYaP94LneeJ4SyhPCk+5wBWkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(53546011)(2616005)(6506007)(2906002)(6512007)(26005)(6486002)(478600001)(44832011)(31696002)(86362001)(36756003)(8676002)(8936002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(316002)(6666004)(31686004)(38100700002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFGL0d1UFJ5d0NKY2VPT2ZMLy8wVG5yYVJuZHJGTVBMTWoweUZDRERFY2x4?=
 =?utf-8?B?dzF1UFRlMWtiOFZGLzNEUC9tcTZHS1hYZlJpb0tVc0haVnpxKy94M21tMzBv?=
 =?utf-8?B?OHpHMmhQMHlQT0dNVVpiVDRDZ3JyeXIzbjdKMER1OU1kVytRa05XZlRBLyt5?=
 =?utf-8?B?dkVIOHNkU05adS9Wa0pPN3pLb2h0ZFJ1b1dMM3BRNUYrcjB2UUpGVmtaaTJo?=
 =?utf-8?B?WTk3MlBKT3EwYmV1WlJ5OHM1eFI1TUlkUU5iVjBJR1RCV2tucWxwdllabERp?=
 =?utf-8?B?dU1FRHl6ajQweWZIb2g2L2R0MWJnRzJUZlV1ZWdCZnZWMUovK3p5QWo4ZGFr?=
 =?utf-8?B?L0hmSlVZZ2h0STFXU0xqUDdyM0YvZW9tejVFaDlrYTR3ajI3bXNUQVhpUFNS?=
 =?utf-8?B?STI2aUE1bHVHcE1mQXdSUHJzaHhuQUJVMVJFOXhLNGo5Vm5XN3Z3L0xzanBE?=
 =?utf-8?B?ODdDK0o4c0lLcHlWb3E2Ty9aOVpKdUNyNVZrRGJ1NmN4Y0trWG1FQTQ5QzQx?=
 =?utf-8?B?OXFVZTE2Qmt2V1B4dXRmVmE0K1VTQy9VRllDalBSd2Y2Y2d0UWhyamYzdjF5?=
 =?utf-8?B?SWY5RDVhWWp2RkxrWjJvSjNBWkI5QWlVbkd2b1dxdFoxallSb3dBRmpmd1BZ?=
 =?utf-8?B?ajRNVnlUc3g1MGV5UUZqazRNaHN4Y0huUS9rYTkrdmE2Vno1c1NvaTZjTHgr?=
 =?utf-8?B?MU4rUHhUNk53WmQ5aGp0SktXRzdjaUg0dmtkK3dBT0tTRlB1Tm9lcXR0NXRv?=
 =?utf-8?B?eCtJY2RtWUdOWGVjejBwMDJGMi9BVEVQYnBZcTRBSEg0MkZTcnVWUE9WNG9w?=
 =?utf-8?B?U2swNDExZTI3a3EwOE1YUlFWWmZGWVNsd01hd2pVN1NTc3pZRDUrTE9WK2Jw?=
 =?utf-8?B?bDFJT3JidnAwbVlRSVpSZ3UxZVQyeUw1TWROem1iV0cwcUdYb1RIOEVpeUt1?=
 =?utf-8?B?S1BxeEQrMjRmWElvbEw3WGRJYXdDWEYyTTBySjRZSHhYeE4rS2JqZnVlRlh3?=
 =?utf-8?B?NU1FVjBxMGVxa25jQXBXVEZkSzhqbE1Pc1hrMjZoTHZYUUkwaHZXSjB0aWxK?=
 =?utf-8?B?MWQwUUM4WlpqdE9WWVE5ZGxtL3JqNjhWaWxKOUJRa2hLNUNVREU4NC95c0Zv?=
 =?utf-8?B?SmpBeENUckIwZUJKT0Nzei9TQllqU05sYUFpRWwyelZoZjVEMHZ5N012eHpT?=
 =?utf-8?B?czRvWVk0K2FUTEl3TkM3bjhpdTAxVHlvL0FUQVhLK2grVkNOd0E4M2FvU3ZC?=
 =?utf-8?B?R1JKVFRDWU9hWGp3cE1xK1JYSlhYUE9GVEtvSEVuRHlWK0M0bVZIQWx2Mmts?=
 =?utf-8?B?YnYvWWZUSUpEbmV3TUN3Q3N0RVJIakxBL0VFdUlHUDZzME9URDNNTS9ZZUxJ?=
 =?utf-8?B?dlM1WkRFVzZVV2FPM0ppdllrdjBybXBESXpnZ1ZaVGtmZDcrN1J6RnQxdWdP?=
 =?utf-8?B?U2dWanZSV0c1Um9hcnY2ZnBselUwelUrdEo5OFZlQVg3WmdROVMxNGwxNVB6?=
 =?utf-8?B?M3BJK25JeXhSc3FoYXovZTRTSENYaGpCMmFFL1lLMDRhOFRqS21BRlJGcGI1?=
 =?utf-8?B?K0tueEdLMzVLbFJTc0p6ZHZLL2ZMdzJNUkdrYXZaUWV6ZVowbTE1TDdpVDlC?=
 =?utf-8?B?RW9EaUF1MFEra2FQaU93RkFMTHpJZkJFTEY5SWdJeDlLMWR6TlNtalNrM2xn?=
 =?utf-8?B?c0crd2JqcXExSFZoOGFNRTQ3RGFXU3V5Q0MxOTc5THd5QkFhWG9pWURxZ0Ju?=
 =?utf-8?B?VkJSYlQyZDQ1Q0piTC9nSVR6M25ic3lReUlxNzRCbFRWTkVGMFNSeENKbHR0?=
 =?utf-8?B?T0dvUVpTTThhUnpReHBtNHJTTmR5MTVLNGZpajR2ZHJGdTQ0MEdEclhDdkVt?=
 =?utf-8?B?dm5iakZQVHM5VWFKR0d1RlQvbnlZRDg4UWVKaE0zOTk1aUpsc0FqVi9SWCtq?=
 =?utf-8?B?Ym5nQzFaKzh2aGJ2RjRzVCtwU2JyREh2RjFCU2pYbWQ3RndtRmpSUUNnNkZw?=
 =?utf-8?B?S3kxVjBMNkFacWtORUtSK3lDT3U5UXZmYW1lYjR1N20wS1ppZDZmdVBSZWZU?=
 =?utf-8?B?NU50bk5PYVA3cTBmUHhVVVVGTUFZR0I1NDBMdS9LaFJhMXVPRGhDd2lDaXFQ?=
 =?utf-8?Q?bbjAacZsWn5weoWTXmwHPcueU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e86ec0-3948-427a-21a9-08dbea90afb5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 12:52:14.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6So3h33sEjAJ33userFJ6RdJad1xsAsX1GUoECXFv6aK2nRIaIxTQisGQZV5mdXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
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



On 11/10/23 13:34, Michal Simek wrote:
> In case of A/B update systems there should be an option to load the same
> binary/binaries to different location and they should work.
> Before this patch boot.bin with U-Boot SPL can be added to whatever 32k
> offset in SPI and SPL finds u-boot.itb at CONFIG_SYS_SPI_U_BOOT_OFFS
> offset. In case of A/B update systems that means that SPL is at different
> locations but it still points to the same u-boot.itb which is not correct.
> That's why include multiboot value to offset calculation to be able to
> point to image from the same base.
> It doesn't affect any current system which starts from 0 offset.
> 
> This patch also change Kria defconfig which uses A/B setup. Partition
> A starts at multiboot 64, partition B at multiboot 496.
> 
> And also print message about used SPI offset which is useful for all cases.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c         | 15 +++++++++++++++
>   configs/xilinx_zynqmp_kria_defconfig |  2 +-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index f16280308483..59feaaf6f32f 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -681,3 +681,18 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	puts("DFU alt info setting: done\n");
>   }
>   #endif
> +
> +#if defined(CONFIG_SPL_SPI_LOAD)
> +unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
> +{
> +	u32 offset;
> +	int multiboot = multi_boot();
> +
> +	offset = multiboot * SZ_32K;
> +	offset += CONFIG_SYS_SPI_U_BOOT_OFFS;
> +
> +	log_info("SPI offset:\t0x%x\n", offset);
> +
> +	return offset;
> +}
> +#endif
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index daedf1de01ea..a20df1a4072f 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -48,7 +48,7 @@ CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
>   CONFIG_SPL_RAM_SUPPORT=y
>   CONFIG_SPL_RAM_DEVICE=y
>   CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_SYS_MAXARGS=64

Applied.
M
