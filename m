Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8240FCDB465
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 03:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A78CE8644E;
	Tue, 17 Oct 2023 05:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xRrQPfPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2197865A2; Tue, 17 Oct 2023 05:17:43 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD1786416
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 05:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBUyp2riTE8G4mLelH6K1hf3PnT6HeCZEmw7LBo441eZCA/BUtwkbw5vE8HHQmHwvMUdI9qLIocCTyMLvtzvgwb4fpuN5eIkWMr0Ro1S3xGUpah6i41i/1bCROLVxiOjZRT6nDgVZeak0LlMvL3ol8UTDIz3/XZL/i4EXm/DzGQjQSURH0uymmOZBMtr2B0y+d/so89I49a80bq1LdxXW5lBi+bvx99J22ScIHtVMpU7sGeGQ88BOp5tHTcYqDqp/cuaMtVpRZeF5w0hptVSlFT6w7p+tsj49haqvPrHdzK1HzY7j21L+ysKbola4Ts7nEogg6bE9BqGEejyDd+oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvKGqXKO+M9DMkIis4WmS16N8LxHZTK173eknDcZt4o=;
 b=bk/Nc1TUfQeLcQXLTIwSiBfExl9QT8nDaJmuPuhAp2iVV8NDa6SV9eGBiQs3CSFvMYAQG/9J5fJMrnZG6bP6uUXdtwSA0QWwZFr0dU63tPpK4b+RdGCPyYz5vTKw8ScFV0yhOs07kyweaqbXvSmNqzHpp6W5y0yDTclrbgQ55tmuhzHyC7htGdKXife2/r8zuz5Kj26Rvghzf8jIpW2gMn1+qSt+92cnKNyPgnKSqjTddypbRh84VBaSCo/uxyVV4Mp4Xzhu5nsyX6c4mULRov3U8GhTRV/2bOa73oTCifbFlEQq+szpT7KgIc7gw6HkB7YBcq+tzUpEhA8UOhiarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvKGqXKO+M9DMkIis4WmS16N8LxHZTK173eknDcZt4o=;
 b=xRrQPfPZCXFcmqRI8jUphKvapJlLiPkaBu6yohOHJil8gcIjTNKFk9Z4RFLucqMsYMgoEdoa3Kk2xMjJ+XJi95nkXBBHgO56Hm+0ltnp7wZP81hUvuAiDvEGYPvWfA+Tpolt68ic7MEFaFQ0A+U6gG/KroLokpM4uMjWNwTKSmE=
Received: from SA9PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:21::12)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Tue, 17 Oct
 2023 03:17:37 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::98) by SA9PR13CA0007.outlook.office365.com
 (2603:10b6:806:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 03:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 03:17:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 22:17:27 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 22:17:26 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Introduce kria SOM defconfig
Date: Tue, 17 Oct 2023 08:47:19 +0530
Message-ID: <20231017031719.27168-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: e2eb5617-b2f1-4f89-8491-08dbcebf9c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FRW5IysvWZvciAXV9zyQAFkKBDv6NyfwbAdXIMXfB1p0xNNj5FdoduaE8vt6O8iRYXCKwntEuPgCh6mC/z7iDlYp0Uba8yZqK63mTloMH/WaR8ToiDOEihRfFEG/RMoFhzl6ICtmVqUlQpGupfchFmRx95t2gR7ZVpSNl+D3gKA7B5gWk6Q8BJzkHuqYP4fNaXfvgvkZbTrx0L2iaYcoKCWHKMv0CkYHCphm6z8IEGVR7/Roa0zfKM9HqxnfsSLsRXBAZFfI7p3AW2PJh7HCvtNsbr77RArt0u1Xszex2u3En9TzgSlAbdjqSIHX8Qt67C7Jb0h/RmzCQgCRhoDv/VpFUV6tsgnv8nZiiU+um1VCxWDd5X+md7LzM8famN3e7T0vXw63r/L15UX2GAHKc394C4YiqIWfQwvpTdJq8znS/ovcjvjJoVxl30HsiBb+rx9SwTddR1eGa+Yx+rF2RmnrNbvmJ7kWtLkm2a7pn0fWTFS5aQJtwTm0SUTagT/ICjICUIuJz/t6xXLo3kE6hVIO8pqFsVRaC1fKE/qaNL7wjXBzC1A0uwk4SfFE9nK5vRNO7qMkMLLek0XO0k+yuHMx0ruLgfVAR4iYDfQApsBjJr1SP716BlthbdLioXrkWa3UcWjcQjp+IEe6Ak0U5Mm32gUtMQQmayF4NzwJV6mmPvxuYEJNUGREZzfeMpeootfH+fzBd44vPT83Zs5T3rqZgqQREFNELciCz8DersI1dGyhpEptnsosljzc2quAFvWRNQJzbM8PzOTAT0xPW4mCPouy+RymTuxsVU2Csc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(316002)(26005)(36860700001)(6916009)(82740400003)(1076003)(70206006)(54906003)(8676002)(356005)(40480700001)(8936002)(4326008)(70586007)(30864003)(36756003)(336012)(2906002)(426003)(6666004)(83380400001)(107886003)(86362001)(47076005)(41300700001)(5660300002)(81166007)(478600001)(36900700001)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:17:36.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eb5617-b2f1-4f89-8491-08dbcebf9c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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

Enable the initial kria SOM specific configurations like pinctrl,
pinconf etc. Also add the environment file. 

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/zynqmp/zynqmp_kria.env  |  71 +++++++++
 configs/xilinx_zynqmp_kria_defconfig | 230 +++++++++++++++++++++++++++
 2 files changed, 301 insertions(+)
 create mode 100644 board/xilinx/zynqmp/zynqmp_kria.env
 create mode 100644 configs/xilinx_zynqmp_kria_defconfig

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
new file mode 100644
index 0000000000..916ac2df14
--- /dev/null
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -0,0 +1,71 @@
+autoload=no
+baudrate=115200
+boot_a_script=load ${devtype} ${devnum}:${distro_bootpart} ${scriptaddr} ${prefix}${script}; source ${scriptaddr}
+boot_efi_binary=if fdt addr ${fdt_addr_r}; then bootefi bootmgr ${fdt_addr_r};else bootefi bootmgr ${fdtcontroladdr};fi;load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/bootaa64.efi; if fdt addr ${fdt_addr_r}; then bootefi ${kernel_addr_r} ${fdt_addr_r};else bootefi ${kernel_addr_r} ${fdtcontroladdr};fi
+boot_extlinux=sysboot ${devtype} ${devnum}:${distro_bootpart} any ${scriptaddr} ${prefix}${boot_syslinux_conf}
+boot_net_usb_start=usb start
+boot_prefixes=/ /boot/
+boot_script_dhcp=boot.scr.uimg
+boot_scripts=boot.scr.uimg boot.scr
+boot_syslinux_conf=extlinux/extlinux.conf
+bootcmd_dhcp=run boot_net_usb_start; if dhcp ${scriptaddr} ${boot_script_dhcp}; then source ${scriptaddr}; fi;setenv efi_fdtfile ${fdtfile}; setenv efi_old_vci ${bootp_vci};setenv efi_old_arch ${bootp_arch};setenv bootp_vci PXEClient:Arch:00011:UNDI:003000;setenv bootp_arch 0xb;if dhcp ${kernel_addr_r}; then tftpboot ${fdt_addr_r} dtb/${efi_fdtfile};if fdt addr ${fdt_addr_r}; then bootefi ${kernel_addr_r} ${fdt_addr_r}; else bootefi ${kernel_addr_r} ${fdtcontroladdr};fi;fi;setenv bootp_vci ${efi_old_vci};setenv bootp_arch ${efi_old_arch};setenv efi_fdtfile;setenv efi_old_arch;setenv efi_old_vci;
+bootcmd_jtag=echo JTAG: Trying to boot script at ${scriptaddr} && source ${scriptaddr}; echo JTAG: SCRIPT FAILED: continuing...;
+bootcmd_mmc0=devnum=0; run mmc_boot
+bootcmd_mmc1=devnum=1; run mmc_boot
+bootcmd_pxe=run boot_net_usb_start; dhcp; if pxe get; then pxe boot; fi
+bootcmd_usb0=devnum=0; run usb_boot
+bootcmd_usb1=devnum=1; run usb_boot
+bootcmd_usb2=devnum=2; run usb_boot
+bootcmd_usb3=devnum=3; run usb_boot
+bootdelay=2
+bootfstype=fat
+bootm_low=0
+bootm_size=80000000
+distro_bootcmd=scsi_need_init=; for target in ${boot_targets}; do run bootcmd_${target}; done
+efi_dtb_prefixes=/ /dtb/ /dtb/current/
+fdt_addr_r=0x40000000
+fdt_high=0x10000000
+fileaddr=0x18000000
+initrd_high=0x79000000
+kernel_addr_r=0x18000000
+load_efi_dtb=load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${prefix}${efi_fdtfile}
+mmc_boot=if mmc dev ${devnum}; then devtype=mmc; run scan_dev_for_boot_part; fi
+pxefile_addr_r=0x10000000
+ramdisk_addr_r=0x02100000
+scan_dev_for_boot=echo Scanning ${devtype} ${devnum}:${distro_bootpart}...; for prefix in ${boot_prefixes}; do run scan_dev_for_extlinux; run scan_dev_for_scripts; done;run scan_dev_for_efi;
+scan_dev_for_boot_part=part list ${devtype} ${devnum} -bootable devplist; env exists devplist || setenv devplist 1; for distro_bootpart in ${devplist}; do if fstype ${devtype} ${devnum}:${distro_bootpart} bootfstype; then run scan_dev_for_boot; fi; done; setenv devplist
+scan_dev_for_efi=setenv efi_fdtfile ${fdtfile}; for prefix in ${efi_dtb_prefixes}; do if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${efi_fdtfile}; then run load_efi_dtb; fi;done;if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/bootaa64.efi; then echo Found EFI removable media binary efi/boot/bootaa64.efi; run boot_efi_binary; echo EFI LOAD FAILED: continuing...; fi; setenv efi_fdtfile
+scan_dev_for_extlinux=if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${boot_syslinux_conf}; then echo Found ${prefix}${boot_syslinux_conf}; run boot_extlinux; echo SCRIPT FAILED: continuing...; fi
+scan_dev_for_scripts=for script in ${boot_scripts}; do if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${script}; then echo Found U-Boot script ${prefix}${script}; run boot_a_script; echo SCRIPT FAILED: continuing...; fi; done
+script_offset_f=0x3e80000
+script_size_f=0x80000
+scriptaddr=0x20000000
+usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boot_part; fi
+preboot=setenv boot_targets; setenv modeboot; cls; run board_setup
+
+# SOM specific boot methods
+som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; fi;"
+som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
+
+k26_starter=SMK-K26-XCL2G
+k24_starter=SMK-K24-XCL2G
+bootcmd=setenv model $board_name && if setexpr model gsub .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter* $k26_starter; then run som_cc_boot; else run som_mmc_boot; run som_cc_boot; fi
+
+usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
+
+# usb hub init
+kv260_setup=i2c dev 1 && run usb_hub_init
+# usb hub init
+kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
+# usb hub init with enabling PM nodes for ...
+kd240_setup=i2c dev 0 && run usb_hub_init; run pm-cfg-snd
+
+
+board_setup=\
+if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
+if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
+if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;
+
+pm-cfg-snd=run pm-config
+
+pm-config=if test ${card1_name} = SCK-KD-G; then zynqmp pmufw node 33; zynqmp pmufw node 47; fi
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
new file mode 100644
index 0000000000..486ed14c3a
--- /dev/null
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -0,0 +1,230 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_ZYNQMP=y
+CONFIG_TEXT_BASE=0x8000000
+CONFIG_SYS_MALLOC_LEN=0x4040000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
+CONFIG_SPL_STACK_R_ADDR=0x18000000
+CONFIG_SPL_SIZE_LIMIT=0x2a000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x0
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x222000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_CMD_FRU=y
+CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_ENV_ADDR=0x2200000
+CONFIG_AHCI=y
+CONFIG_SYS_MEMTEST_START=0x00000000
+CONFIG_SYS_MEMTEST_END=0x00001000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_DEVICE_NULLDEV=y
+CONFIG_BOARD_EARLY_INIT_R=y
+CONFIG_CLOCKS=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0xfffffffc
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20000000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
+CONFIG_SPL_FS_LOAD_ARGS_NAME=""
+CONFIG_SPL_FPGA=y
+CONFIG_SPL_OS_BOOT=y
+CONFIG_SYS_SPL_ARGS_ADDR=0x8000000
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xF80000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_PBSIZE=2073
+CONFIG_SYS_BOOTM_LEN=0x6400000
+CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_SHA1SUM=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FPGA_LOADBP=y
+CONFIG_CMD_FPGA_LOADP=y
+CONFIG_CMD_FPGA_LOAD_SECURE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SDRAM=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_BOOTP_MAY_FAIL=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_SMC=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_SQUASHFS=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_MTDPARTS_SPREAD=y
+CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
+CONFIG_CMD_UBI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_BOARD=y
+CONFIG_OF_LIST=""
+CONFIG_DTB_RESELECT=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
+CONFIG_ENV_SOURCE_FILE="zynqmp_kria"
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_NETCONSOLE=y
+CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SATA=y
+CONFIG_SCSI_AHCI=y
+CONFIG_SATA_CEVA=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_CLK_ZYNQMP=y
+CONFIG_DFU_TFTP=y
+CONFIG_DFU_TIMEOUT=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
+CONFIG_DMA=y
+CONFIG_XILINX_DPDMA=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_FPGA_XILINX=y
+CONFIG_FPGA_ZYNQMPPL=y
+CONFIG_GPIO_HOG=y
+CONFIG_XILINX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SLG7XL45106_I2C_GPO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_CADENCE=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ZYNQ=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SPI_FLASH_BAR=y
+CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ADIN=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_XILINX_GMII2RGMII=y
+CONFIG_PHY_FIXED=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_XILINX_AXIEMAC=y
+CONFIG_ZYNQ_GEM=y
+CONFIG_PHY=y
+CONFIG_PHY_XILINX_ZYNQMP=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_ZYNQMP_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_CADENCE_TTC=y
+CONFIG_DM_RESET=y
+CONFIG_RESET_ZYNQMP=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_RTC_ZYNQMP=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
+CONFIG_ARM_DCC=y
+CONFIG_XILINX_UARTLITE=y
+CONFIG_ZYNQ_SERIAL=y
+CONFIG_SOC_XILINX_ZYNQMP=y
+CONFIG_SPI=y
+CONFIG_ZYNQ_SPI=y
+CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TPM2_TIS_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Xilinx"
+CONFIG_USB_GADGET_VENDOR_NUM=0x03FD
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
+CONFIG_USB_ETHER=y
+CONFIG_USB_ETH_CDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_COPY=y
+CONFIG_I2C_EDID=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_PANIC_HANG=y
+CONFIG_TPM=y
+CONFIG_SPL_GZIP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.17.1

