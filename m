Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051BCCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0A586EDB;
	Tue, 17 Oct 2023 15:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qpb/dArJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB26886EF1; Tue, 17 Oct 2023 15:51:37 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359DA865D0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPbny1VwRkudvKzUVhkYcjVOdKJyz7JrW2nTVQNaHMJFbmGO6p/vJwtPP8cejP/27oz2jwUHe94INQBtsi/5dVXCwwTciafkdDYzD/4wa1dBwE0oyokl1xdBtlOjsG1pp0gWf1I9M3h/u8JLXbS9SXZlBWHSqrDsESIuk+CZvtywuGKT4SjsNf3djDyVf3E7R4ODiQqswTDLMn17e1nU9tD8tCOPUhAW9Gx6HHqzRXArAqHhed9eWTKsdDjGRDI0RzaEb62i4CRFfHQuAC+GdUhm7qLnbVRfXE4KGP+u4BfgLY1pfe86sKU6f/oBGTtZuxAcEatheIEDH6yxsF/X6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVJ15H9ASg94MhfYZtg6TEtT/3Z52ORUCjPKZg/drhM=;
 b=dFkTCrS/FXqojRWfbhSEfRnlyyCGmGvnOAGu10z5UHPJGEfrpbIo7wWwNl/tWoomW5KgG7c1WTssyyc7SrvhSKgaDSNbAftrR3UyrxQvMb91Fy//dOcPGmHTYXH14Df0fNyumb2xUFhbLZ/78AKOqfTaFKUXMomEAOAVNPaggDdCUlxtO2pm4QfKpm8tRNv65wSscBmlcsu6reybS5ymNNNhmiCApoWu3uiBbElcSeD8XI+BFB9XqeOQZ/zaxlJhcsGwJWc21se6g2B+cUTjNtCAMowqtaFYaRvJhnYM9OUq/n1Bqu7ipdN46Kk/r/4bQ/NqSwk2zJlJOPbBsVWCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVJ15H9ASg94MhfYZtg6TEtT/3Z52ORUCjPKZg/drhM=;
 b=Qpb/dArJHurXLJ3jwsy6+Ts7mcG6f5JF/E5ysC0dDapfnJPGx65yZftsqstWpYmaEyAsuJ6/z//3MvXpJ3FxbN2UXkPKIhN7XLRzXsz+Jx4pdQStkZfBMfFmP9s6+XdK8gSOkeWrc8I27nAViuI8eRgmohQoKQGE5FE6vjenQ3E=
Received: from CYZPR17CA0008.namprd17.prod.outlook.com (2603:10b6:930:8c::17)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Tue, 17 Oct
 2023 13:51:31 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::2) by CYZPR17CA0008.outlook.office365.com
 (2603:10b6:930:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 13:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 13:51:30 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 08:51:29 -0500
Message-ID: <a903bd39-5e30-49b9-b852-675ee55d8b23@amd.com>
Date: Tue, 17 Oct 2023 15:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Introduce kria SOM defconfig
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <git@xilinx.com>
References: <20231017031719.27168-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231017031719.27168-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bc0f77-d718-43d3-f04e-08dbcf182aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPWITs73K53gkp4pnH1pfBGwCC6RjRRwqnuDF2c0nwpbZANwMNpqMm+5x9s/ETvWRlubBCKnmo7I96wl+CoRZW9tlXZxsreERGmWvOt/Fm8oPpEZks1fMEjasKQzHHr/eBEZ3BCm5MKa6/2ECYGeDPzFUiV8+94TvX0K6bo9eD//F+CVHc2rJp/VNDnFZpIfib1SSm5DrqEQGbTZwJ8/G0cLHacyhEgp98rgvay1Ua1MxIGjE8xgTa00G9u2vfiTpL08Gu72JMQIFmE3/SYF4S6xSZBY6IduO1yK+6VLMC4yofP3J388E1o/KSLYlolQri2bV9MVMR9ojNl2YBIm4Ep4kJ382PNZ8jOLz+/1+rTVpk0nL/Nbot1gdaN8LXHaVHoc+UrjzOyyJhCmbpo0BGZrCjyLD29alF3nwLqYVvkUPlAznFjvk6Stz4KxfOD6v9cR7uEZe8t47zKr7WMMBhQtncjgNmhNO7yazBwgyf/NacrBhvZJp+f+aS6r3fB2UiXqkzmngk+f/5pz9ZE3pI/RUgcBMosOwVEwsy336DBCf4t2ygfeOFrnPAvl5IZwccAyXRFqBhzpT7YEBALnyOiksZYYhkc1AJ8JBgXzOVQUyJFx7MoT9K3wEow0HYf8LoMjQG3nmm0rVIBCCIGurue2b1nz/ismZqeFHPUrS1SuurM03ak7q9peToom6NgdJO5IoThRrQoF3j6pWP3vJEboWShLD4HL2Eo8p1z7I+l4k+BjKFG1nzyS8Bk8wWkY/ZG7fiRvUyXQQUIJ1TS5CoAiW317PCeEVgJj+cNM1bl/OB/p29VLiwMANGpaWgxFcM9NXztQAOU1zuam0tNiEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(70586007)(110136005)(70206006)(6666004)(478600001)(53546011)(426003)(16576012)(316002)(16526019)(2616005)(107886003)(336012)(36756003)(26005)(2906002)(31696002)(41300700001)(8676002)(4326008)(8936002)(30864003)(5660300002)(356005)(44832011)(86362001)(47076005)(83380400001)(82740400003)(36860700001)(81166007)(40460700003)(40480700001)(31686004)(43740500002)(36900700001)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:51:30.8430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bc0f77-d718-43d3-f04e-08dbcf182aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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



On 10/17/23 05:17, Venkatesh Yadav Abbarapu wrote:
> Enable the initial kria SOM specific configurations like pinctrl,
> pinconf etc. Also add the environment file.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp_kria.env  |  71 +++++++++
>   configs/xilinx_zynqmp_kria_defconfig | 230 +++++++++++++++++++++++++++
>   2 files changed, 301 insertions(+)
>   create mode 100644 board/xilinx/zynqmp/zynqmp_kria.env
>   create mode 100644 configs/xilinx_zynqmp_kria_defconfig
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> new file mode 100644
> index 0000000000..916ac2df14
> --- /dev/null
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -0,0 +1,71 @@
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
> +bootm_size=80000000

0x prefix please

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
> +preboot=setenv boot_targets; setenv modeboot; cls; run board_setup

please remove "cls" from this.

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
> +kd240_setup=i2c dev 0 && run usb_hub_init; run pm-cfg-snd
> +
> +

one newline is enoguht.

> +board_setup=\
> +if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
> +if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
> +if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;
> +
> +pm-cfg-snd=run pm-config
> +
> +pm-config=if test ${card1_name} = SCK-KD-G; then zynqmp pmufw node 33; zynqmp pmufw node 47; fi

This test is done already as the part of board_setup for KD. That's why just 
define it like this

kd240_setup=i2c dev 0 && run usb_hub_init; zynqmp pmufw node 33; zynqmp pmufw 
node 47;


and remove pm-cf-snd, pm-config variables.


> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> new file mode 100644
> index 0000000000..486ed14c3a
> --- /dev/null
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -0,0 +1,230 @@
> +CONFIG_ARM=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_ARCH_ZYNQMP=y
> +CONFIG_TEXT_BASE=0x8000000
> +CONFIG_SYS_MALLOC_LEN=0x4040000
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_ENV_SECT_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
> +CONFIG_SPL_STACK_R_ADDR=0x18000000
> +CONFIG_SPL_SIZE_LIMIT=0x2a000
> +CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x0
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x222000

This is actually 0x2220000

> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_CMD_FRU=y
> +CONFIG_SYS_LOAD_ADDR=0x8000000
> +CONFIG_ENV_ADDR=0x2200000
> +CONFIG_AHCI=y
> +CONFIG_SYS_MEMTEST_START=0x00000000
> +CONFIG_SYS_MEMTEST_END=0x00001000
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
> +# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_DEVICE_NULLDEV=y

we are not using this option that's why please remove it.

> +CONFIG_BOARD_EARLY_INIT_R=y
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=0xfffffffc
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SYS_SPL_MALLOC=y
> +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
> +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20000000
> +CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
> +CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
> +CONFIG_SPL_FS_LOAD_ARGS_NAME=""
> +CONFIG_SPL_FPGA=y
> +CONFIG_SPL_OS_BOOT=y

please disable this option. It is not needed.

> +CONFIG_SYS_SPL_ARGS_ADDR=0x8000000

This has been renamed recently that's why please resync this defconfig.

> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xF80000
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
> +CONFIG_ENV_SOURCE_FILE="zynqmp_kria"
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_FAT=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
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
> +CONFIG_DM_RESET=y
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
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_VIRTIO_NET=y
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_PANIC_HANG=y
> +CONFIG_TPM=y
> +CONFIG_SPL_GZIP=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_EFI_SET_TIME=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Based on my testing I am missing
CONFIG_SF_DEFAULT_SPEED=30000000

And I am missing enabling
CONFIG_VIDEO_ZYNQMP_DPSUB=y

When we have driver for DP ported to Kria we can get cls call back.
As of now it just send some chars to terminal to reset.

Thanks,
Michal

