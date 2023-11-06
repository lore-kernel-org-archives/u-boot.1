Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62544C4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32D3869CA;
	Mon,  6 Nov 2023 15:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVdWnATX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0DE85C98; Mon,  6 Nov 2023 15:27:09 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008168708C
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru60Lf8rxTWOf/Imu68xBu8Diu8ijHS6Z5YQV2T0i6hj2OeAiBzQBP3otqZ+csLCqsKqlxavxMTXeAN5fqdaE3DN4o1UeBMj6KkBGEyUJRcTcH9pGMdHYzmgmS4+X1EchdPIk5nHGrZhniQAB7DkS1h0C7XSFodUu4fjsPGUQgkN3LtD3HrNE1O2ki2CnUXPKcn0/1hCobMAsTeUgnN6Cw0agxPwncV9/Bj4mRHpskehGQZtOAmNAZ68u7aga5Ws1aUNe1spxEoG9OdkgrD1uhYQD6hqM15HQviNTK/o45xOOryjW9ulXcY/xixPbJaVDUT/s8E1sjBEc/D8fLplYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbYd/WFV6677KgOv1JW20T9SKHaAsJ188MvMJSv64eQ=;
 b=jEHqsOQDBFn+bAQg9d/OgffYgeSzJCVpkJMGSNILTSz+8BpD58WAhFriFG2cY+IoOi9wwU0pM2r5jtsSjy+JISmGWYpETKmy2Ds8OYvnoj9BVUuyJ55na4jDJ6rzUJueqVKhUUHGGWmFWo0viFSjplOwWcDhlzGl4XtccIP8L6ac7AVMdUERxgTYDBAjZxLR2oJEzklOzDu3dSubgCQq/CoRaIfI247SpvHc+wTIBn9uhAk5POzdQx86e+2vhZuUA83BlxxodVvnDaFxTdm6mgk62xk0Np9w7bjzxLnYOgRt+mK46CGQmzrxoshaDy8niYV0RgOJPrHHUAOushvfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbYd/WFV6677KgOv1JW20T9SKHaAsJ188MvMJSv64eQ=;
 b=oVdWnATXK39hn7sX3yqAu07x/gfbp/hQxIVq8Zr63kkuOVwunX+VNkJJitg+zQraJ8BYSzVnF5J9topIvF9FyOnQtgz1bCrf7JjesTRvWfxBLuMTQ/kyiswz0hAacDGeF4K1ErRcC8PXghyXBD+3lhPHO2nL7nBuJGk2QGkz1J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 14:27:02 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 14:27:02 +0000
Message-ID: <b0df7872-9980-47d2-909d-8e8352a4d5bc@amd.com>
Date: Mon, 6 Nov 2023 15:26:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: Introduce kria SOM defconfig
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20231101053426.14685-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231101053426.14685-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fccff89-a03c-46cd-93f7-08dbded47184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBedZ4Kn6XA1cAnUBzHa7SnKYCG41Uwi2n/G8LummpK+gtfL6+f3Fn/4gNQmnS+jqVGQ6rRwLUdxrJSAxymKQNtaQj1uBVISDlVakZ8aypyJrgYNmJ598mpnRw5weF8U+L3cJlJLQFlvt4X7y8n2UNHFtfZ7ZL9+tVa+ckPLR4pUJbXNejhnPf9NXTRrJjbLCNTQpn1l2mfdhX214Bs7u7Ysahb55Zh2f9MBQ3JZpCMcKgcY2fEcWk2pmO9wsJKbEZckJrohjj3XJDLwUYdp31MVviJyt6ShERtZ2EpoaynEGQ6PmQucMM3MMSiITxR3pNIXou141QbFxQu6mq9DAx8gSIGpWZ6S9QTOS/XG4DRPmWwRfhtrnXu5TanSlA9MG2e6GN1MRcbwdDwGgP767ihQrMvv4sMVzrChPqeMJF6WQGIlgEDgrdOkmslJr3tXdzXdBoMSQRjYGoDG+MIy4MB6olksMyOLfs/r8q/+/D5Hggv41KRyvw9fpjmlolXhdRZ1Kbst/9y48khXQLRLG60OyNru4Qy/2OtXhM9hWrg8+6ma8JSdHEvn3qSenGOVFn9euLUx7fXWFKOzXOuwv6vI3YV9lZMlro1ezwTWrsU9sKdJcpn9+6n+t/Pff3nSK5W6IjZc/lu6Uyr+WiknxNmQRRFbSISWTQe23r8tbQm2iZRuqa6Yp86XHPp/8P63
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(83380400001)(53546011)(6512007)(66946007)(2616005)(26005)(478600001)(6506007)(8936002)(8676002)(4326008)(66556008)(66476007)(316002)(44832011)(6666004)(6486002)(5660300002)(41300700001)(38100700002)(30864003)(86362001)(31696002)(2906002)(36756003)(45980500001)(43740500002)(139555002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VpdjUxeHhucmxZdENibllxRWRpa05uaVVFWlFQSmhzY2xqb3hDZG9mVklP?=
 =?utf-8?B?UGlVSHhCbHJsZm00RUo2ZU91SnBkNnFLNkE3Tld0aGd0ZDRKNUI4dGc5aHBY?=
 =?utf-8?B?UTFzSTU0dmNpTjhocFJFZDc0eENqekpyYU5DVVd3T3VUN09Vem55c0g3ODZt?=
 =?utf-8?B?K0V0bm9ZMFlSNEw4SlVhaUJRZTVYUzFOcVNRdFcrWVAvOW8zRVB6SzErWW84?=
 =?utf-8?B?YUFXVTVLZjV3VVFYamduMjA5MWVMdW9uYTBrVkp5UTkvaGVENEo1akhMcWp4?=
 =?utf-8?B?RlVzbVBJTjlpcFovRlBhc3JPL1Z4NWUzTjZ6d0RQOGV2UE45SXZxR2VSQy9Y?=
 =?utf-8?B?WFRoeUwxSVFsWjQyMktTczZZKzcwRDdhZGVsa3ZIV2JUWXJGYjZ0SklrcGlK?=
 =?utf-8?B?WjFHL3l0ZG1EYWpPMDBBZ3ZnVURSMGh1bnBPV1pDYU1Sa0hQanpTb1dLbzNN?=
 =?utf-8?B?cHYwVFpSN3RXazRCTUpWLzBrOVNhTzgzb01rNEllWnhsL1BYSHhXZzdhaVRv?=
 =?utf-8?B?cnh5bTMySTJ1TWp0TmVOYmpSZUZSNnAvNGlUMHcrckUzU0ZtdENUL0l0ZTA1?=
 =?utf-8?B?Y2UzVlNSRm55TUpTd0JLV1JCc0p0NjhFSFZWSURZUmZFT3hQY2FIQTZXRG04?=
 =?utf-8?B?cms1a2cwTzBuZVAyaGI3M1VPd01GTGoxbk16RVN5bzI3NVZQNDhpdW15Z0Q3?=
 =?utf-8?B?OFlmRmpweUZZWUd3UGhCMGRGV2hKeGEwT05LMmk4K3BxTkR2azhmaXRKUkRu?=
 =?utf-8?B?WE95TmthaWFpUHB1Uk54ci85Q3RvMVRWTGNWKytaUXY3ZW9qRHhtUzBUblM1?=
 =?utf-8?B?RE9JOWZNNzVnV1RjREpLUnBFbk9tSmVuWVhnNFJSaGVUL3NmVm02dk5Bbkh6?=
 =?utf-8?B?cFdVY25ad3dYbXNoNmlObFJQbkY4YlphREl5NW90KzdyYVlHUk8vdDhNWCtQ?=
 =?utf-8?B?YWRFUWJVajM5WFhXTDhieDh4bTRZOElRQ0k0YnRpRG43RTh3bCtqK0JVSS9u?=
 =?utf-8?B?VTZGMjhNYkJIcEtnMDRoWlVNaTRBeGJtQkp4WmRQTDVjMzVFN3QvZkVyZEFD?=
 =?utf-8?B?NStROEhnUWlsWnhMdzhIT0lDVDBYVTZkZnZqaWpwcDBlRmszYit1elZYeHRH?=
 =?utf-8?B?b3NxTkwrRUlSRC80bGtoNTBuL0QwYTl0Q2kwNitKTkg4TDB1MUIzbnZIUGRZ?=
 =?utf-8?B?WEVVN3k4TkM2elhlRCtVK0h4UnhoV3huOENybTFwdTVVM0thYnVpbW9lWDFK?=
 =?utf-8?B?OUMrSnR0bUoxQWNBckUxYStTaTdmTm5tVTRpY3oyaGE1Z3ZkSG5MV3dUZ3Yx?=
 =?utf-8?B?b2hqVDNDTUxoQjQ5MEJpYkdEb3F4R2lTbzVPNTN6MTNoZHVXN1kxenlMenlZ?=
 =?utf-8?B?VUJVdUROZWJrSklyWndxRzU4RTVOV3ZVZnZJQUJWS0RWU3lweVlVWWJQSFZq?=
 =?utf-8?B?YzlyVW9lMGJvYUVERC9wdWlSaWUyTUNqUm5wRWtkR25hQVRkeEZKYTN4d1Zq?=
 =?utf-8?B?bjcwbHZpUFM5WVZWMVBuSEJ0akJEenhsdWpYSFJuZ2U3azhlVFJRWDMzdnBB?=
 =?utf-8?B?K3BHbTVuVlN3cGlRRVJkeW96OHlFWE56SWFQaTBFWi9vOTJVYng5UEpMMGZY?=
 =?utf-8?B?OE5vSExQUS9VK2luUjExYWNpQ1BGK0ZCSUJHRURWOFAxRTlrSDB2TnM3SGd0?=
 =?utf-8?B?UFo1d2RtcGQ0RVpvL1FEMmdUUjVTM1o3eWNuR3dYdlZ3allTRUtpekhBd21F?=
 =?utf-8?B?MElDcVV5Sm9QVjdBUlRYWE9HOC9nSkZlWEJha0svMDQrdFkyK041Y2hneFM1?=
 =?utf-8?B?V29XVlQxRTBsbEpvTENmRDU1bkJzb1ZCaE1JSEsvV0hNakk3WWZHY205V2sw?=
 =?utf-8?B?TGQzaE5IWlRTWkRpM090RUNxK1JnbEZkUEFreldKV0pwSmlSUzNMSVdxNE03?=
 =?utf-8?B?WFNMaGdpNlNoek1lbExYZXVld0YyR21teCtNN3JRbHcxejJQWDg5NUpidjJh?=
 =?utf-8?B?dmxCaXhEMWdVbys0Q29RVTc5YzdDa2Y4MFpQQnh2dC83Vnp2UXlxbzRnMDIr?=
 =?utf-8?B?Vmw0OTdoazREaG1ia1F0cnhjcWJ5MnZ2QVpIbVlhRjR1bXhMMnFMbDhQNVFl?=
 =?utf-8?Q?KAIH4VnFo/3pjSeUaiTwZhAi6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fccff89-a03c-46cd-93f7-08dbded47184
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 14:27:02.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVbI/ee2sCIv+I26nhGcn5NOVRZb00cp2wQVLAIdvjsN3gkiZ4tApA+ntFSx3tY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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



On 11/1/23 06:34, Venkatesh Yadav Abbarapu wrote:
> Enable the initial kria SOM specific configurations like pinctrl,
> pinconf etc. Also add the environment file.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Updated the CONFIG_ENV_OFFSET_REDUND
> - Updated the CONFIG_SF_DEFAULT_SPEED to 30000000
> - Enabled the CONFIG_VIDEO_ZYNQMP_DPSUB
> - Fixed minor changes in zynqmp_kria.env
> ---
>   board/xilinx/zynqmp/zynqmp_kria.env  |  67 ++++++++
>   configs/xilinx_zynqmp_kria_defconfig | 227 +++++++++++++++++++++++++++
>   2 files changed, 294 insertions(+)
>   create mode 100644 board/xilinx/zynqmp/zynqmp_kria.env
>   create mode 100644 configs/xilinx_zynqmp_kria_defconfig
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> new file mode 100644
> index 0000000000..9140694d41
> --- /dev/null
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -0,0 +1,67 @@
> +autoload=no
> +baudrate=115200
> +boot_a_script=load ${devtype} ${devnum}:${distro_bootpart} ${scriptaddr} ${prefix}${script}; source ${scriptaddr}
> +boot_efi_binary=if fdt addr ${fdt_addr_r}; then bootefi bootmgr ${fdt_addr_r};else bootefi bootmgr ${fdtcontroladdr};fi;load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/bootaa64.efi; if fdt addr ${fdt_addr_r}; then bootefi ${kernel_addr_r} ${fdt_addr_r};else bootefi ${kernel_addr_r} ${fdtcontroladdr};fi
> +boot_extlinux=sysboot ${devtype} ${devnum}:${distro_bootpart} any ${scriptaddr} ${prefix}${boot_syslinux_conf}
> +boot_net_usb_start=usb start
> +boot_prefixes=/ /boot/
> +boot_script_dhcp=boot.scr.uimg
> +boot_scripts=boot.scr.uimg boot.scr
> +boot_syslinux_conf=extlinux/extlinux.conf
> +bootcmd_dhcp=run boot_net_usb_start; if dhcp ${scriptaddr} ${boot_script_dhcp}; then source ${scriptaddr}; fi;setenv efi_fdtfile ${fdtfile}; setenv efi_old_vci ${bootp_vci};setenv efi_old_arch ${bootp_arch};setenv bootp_vci PXEClient:Arch:00011:UNDI:003000;setenv bootp_arch 0xb;if dhcp ${kernel_addr_r}; then tftpboot ${fdt_addr_r} dtb/${efi_fdtfile};if fdt addr ${fdt_addr_r}; then bootefi ${kernel_addr_r} ${fdt_addr_r}; else bootefi ${kernel_addr_r} ${fdtcontroladdr};fi;fi;setenv bootp_vci ${efi_old_vci};setenv bootp_arch ${efi_old_arch};setenv efi_fdtfile;setenv efi_old_arch;setenv efi_old_vci;
> +bootcmd_jtag=echo JTAG: Trying to boot script at ${scriptaddr} && source ${scriptaddr}; echo JTAG: SCRIPT FAILED: continuing...;
> +bootcmd_mmc0=devnum=0; run mmc_boot
> +bootcmd_mmc1=devnum=1; run mmc_boot
> +bootcmd_pxe=run boot_net_usb_start; dhcp; if pxe get; then pxe boot; fi
> +bootcmd_usb0=devnum=0; run usb_boot
> +bootcmd_usb1=devnum=1; run usb_boot
> +bootcmd_usb2=devnum=2; run usb_boot
> +bootcmd_usb3=devnum=3; run usb_boot
> +bootdelay=2
> +bootfstype=fat
> +bootm_low=0
> +bootm_size=0x80000000
> +distro_bootcmd=scsi_need_init=; for target in ${boot_targets}; do run bootcmd_${target}; done
> +efi_dtb_prefixes=/ /dtb/ /dtb/current/
> +fdt_addr_r=0x40000000
> +fdt_high=0x10000000
> +fileaddr=0x18000000
> +initrd_high=0x79000000
> +kernel_addr_r=0x18000000
> +load_efi_dtb=load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${prefix}${efi_fdtfile}
> +mmc_boot=if mmc dev ${devnum}; then devtype=mmc; run scan_dev_for_boot_part; fi
> +pxefile_addr_r=0x10000000
> +ramdisk_addr_r=0x02100000
> +scan_dev_for_boot=echo Scanning ${devtype} ${devnum}:${distro_bootpart}...; for prefix in ${boot_prefixes}; do run scan_dev_for_extlinux; run scan_dev_for_scripts; done;run scan_dev_for_efi;
> +scan_dev_for_boot_part=part list ${devtype} ${devnum} -bootable devplist; env exists devplist || setenv devplist 1; for distro_bootpart in ${devplist}; do if fstype ${devtype} ${devnum}:${distro_bootpart} bootfstype; then run scan_dev_for_boot; fi; done; setenv devplist
> +scan_dev_for_efi=setenv efi_fdtfile ${fdtfile}; for prefix in ${efi_dtb_prefixes}; do if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${efi_fdtfile}; then run load_efi_dtb; fi;done;if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/bootaa64.efi; then echo Found EFI removable media binary efi/boot/bootaa64.efi; run boot_efi_binary; echo EFI LOAD FAILED: continuing...; fi; setenv efi_fdtfile
> +scan_dev_for_extlinux=if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${boot_syslinux_conf}; then echo Found ${prefix}${boot_syslinux_conf}; run boot_extlinux; echo SCRIPT FAILED: continuing...; fi
> +scan_dev_for_scripts=for script in ${boot_scripts}; do if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${script}; then echo Found U-Boot script ${prefix}${script}; run boot_a_script; echo SCRIPT FAILED: continuing...; fi; done
> +script_offset_f=0x3e80000
> +script_size_f=0x80000
> +scriptaddr=0x20000000
> +usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boot_part; fi
> +preboot=setenv boot_targets; setenv modeboot; run board_setup
> +
> +# SOM specific boot methods
> +som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; fi;"
> +som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
> +
> +k26_starter=SMK-K26-XCL2G
> +k24_starter=SMK-K24-XCL2G
> +bootcmd=setenv model $board_name && if setexpr model gsub .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter* $k26_starter; then run som_cc_boot; else run som_mmc_boot; run som_cc_boot; fi
> +
> +usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
> +
> +# usb hub init
> +kv260_setup=i2c dev 1 && run usb_hub_init
> +# usb hub init
> +kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
> +# usb hub init with enabling PM nodes for ...
> +kd240_setup=i2c dev 0 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
> +
> +board_setup=\
> +if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
> +if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
> +if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;
> +
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> new file mode 100644
> index 0000000000..68232cbadd
> --- /dev/null
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -0,0 +1,227 @@
> +CONFIG_ARM=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_ARCH_ZYNQMP=y
> +CONFIG_TEXT_BASE=0x8000000
> +CONFIG_SYS_MALLOC_LEN=0x4040000
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_ENV_SOURCE_FILE="zynqmp_kria"
> +CONFIG_SF_DEFAULT_SPEED=30000000
> +CONFIG_ENV_SIZE=0x20000


CONFIG_ENV_OFFSET=0x2200000


> +CONFIG_ENV_SECT_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_STACK_R_ADDR=0x18000000
> +CONFIG_SPL_STACK=0xfffffffc
> +CONFIG_SPL_SIZE_LIMIT=0x2a000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x2220000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_CMD_FRU=y
> +CONFIG_SYS_LOAD_ADDR=0x8000000
> +CONFIG_ENV_ADDR=0x2200000
> +CONFIG_AHCI=y
> +CONFIG_SYS_MEMTEST_START=0x00000000
> +CONFIG_SYS_MEMTEST_END=0x00001000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
> +CONFIG_DISTRO_DEFAULTS=y
> +# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
> +CONFIG_USE_PREBOOT=y
> +CONFIG_BOARD_EARLY_INIT_R=y
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
> +CONFIG_SPL_FS_LOAD_ARGS_NAME=""
> +CONFIG_SPL_FPGA=y
> +CONFIG_SPL_OS_BOOT=y
> +CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xF80000

please change this to

CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000

> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_SYS_MAXARGS=64
> +CONFIG_SYS_PBSIZE=2073
> +CONFIG_SYS_BOOTM_LEN=0x6400000
> +CONFIG_CMD_BOOTMENU=y
> +CONFIG_CMD_GREPENV=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MEMTEST=y
> +CONFIG_SYS_ALT_MEMTEST=y
> +CONFIG_CMD_SHA1SUM=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_FPGA_LOADBP=y
> +CONFIG_CMD_FPGA_LOADP=y
> +CONFIG_CMD_FPGA_LOAD_SECURE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_PWM=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_SDRAM=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_BOOTP_BOOTFILESIZE=y
> +CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_BMP=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_RTC=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_GETTIME=y
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_KASLRSEED=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_SMC=y
> +CONFIG_CMD_TPM=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_SQUASHFS=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_CMD_MTDPARTS_SPREAD=y
> +CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
> +CONFIG_CMD_UBI=y
> +CONFIG_PARTITION_TYPE_GUID=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_BOARD=y
> +CONFIG_OF_LIST=""
> +CONFIG_DTB_RESELECT=y
> +CONFIG_MULTI_DTB_FIT=y
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_FAT=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_ENV_SPI_MAX_HZ=1000000

remove this line completely. We should be on 30MHz instead.

> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_NETCONSOLE=y
> +CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SATA=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_SATA_CEVA=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_CLK_ZYNQMP=y
> +CONFIG_DFU_TFTP=y
> +CONFIG_DFU_TIMEOUT=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_MTD=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
> +CONFIG_DMA=y
> +CONFIG_XILINX_DPDMA=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQMPPL=y
> +CONFIG_GPIO_HOG=y
> +CONFIG_XILINX_GPIO=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_SLG7XL45106_I2C_GPO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_BAR=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_ADIN=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_PHY_XILINX_GMII2RGMII=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_XILINX_AXIEMAC=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_PHY=y
> +CONFIG_PHY_XILINX_ZYNQMP=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_ZYNQMP_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_PWM=y
> +CONFIG_PWM_CADENCE_TTC=y
> +CONFIG_RESET_ZYNQMP=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_EMULATION=y
> +CONFIG_RTC_ZYNQMP=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_ARM_DCC=y
> +CONFIG_XILINX_UARTLITE=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_SOC_XILINX_ZYNQMP=y
> +CONFIG_SPI=y
> +CONFIG_ZYNQ_SPI=y
> +CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_CMD_POWEROFF=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_TPM2_TIS_SPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Xilinx"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x03FD
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
> +CONFIG_USB_ETHER=y
> +CONFIG_USB_ETH_CDC=y
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_LOGO is not set
> +CONFIG_VIDEO_COPY=y
> +CONFIG_I2C_EDID=y
> +CONFIG_VIDEO_ZYNQMP_DPSUB=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_VIRTIO_NET=y
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_PANIC_HANG=y
> +CONFIG_TPM=y
> +CONFIG_SPL_GZIP=y
> +CONFIG_EFI_SET_TIME=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Thanks,
Michal
