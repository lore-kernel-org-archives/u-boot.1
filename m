Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7260CCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 03:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F53E836C1;
	Fri, 17 Oct 2025 05:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="W/vC89ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC8183710; Fri, 17 Oct 2025 05:57:53 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238558367F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 05:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OklhNq3TDSLag53T6bVXbXQlbHR/KyRNmqyVOhLZwF5YFy8ksu4kQTss/PQaJMcVj3PbFb0y8ipUOLfeb8cMywtOwPtaufRxCv43RkPWp2r6O+o7IILnCMAW5e07zKS2+b/JIN5+VZge/ufw/v48vBJza+hxk3rBCWjxnZk55+go4k7p+wPf+lty20WfIU5Mn7uyq3UfH1bhdD4Dpmg2lTxu8Up47KKPnli/rXhEfDF/YdPLOVWkCXiwSTWF7cjYlFfcj8JhQZRBbUd1x26mRSDeTubSX3D8mcs4Y564+G2la3nVKbOm9Jy5HQ/c48TDcYH+2q1h43BsCDw+cqQHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6w21Z9m7DNNBljVlhDFreftiQvg55gOr0sgm1eBT1Q=;
 b=ZkU2zrkcc5JF5z4iqnMuLTJIt4EPHEgAJIeUwjauhcMOWawbGD7eMBEGh4S1MzQsDpLIOiDVtyFSEZ6dpyaC9uQmeCfndDOzJFnOxX/GNQRCD7uxY8V9SHGU2esHgsKu5YBv0LDAwm08Tdnht3kozkXiQZGwlpOhUyQc/5p/zjrHcPatHIX4CBqoU7QS4N2/hLZNc05j6CQyu7ECXphSLr6EiqebdgJFH+8mOCrtxZpJjSIAb9Q3F68eyCWuHqL4UM4l7E4KKJhCG2bdRAqF0LcOohrOZHFSGsaP9bzFf7cJ9sGcrHfTind+qm4P/oJ2dq5TSzHm2daxX4OVvd8Cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6w21Z9m7DNNBljVlhDFreftiQvg55gOr0sgm1eBT1Q=;
 b=W/vC89riRWCJdcxvSOPjN9i/3g/L6e6cOekap8/Gl023tv3IxPRuveWdDy6bXQk5e76VWOxKIvIRyPHJ5tTqBel6ZPA8W+2odi2QdmuO0Qy0/FszWl6JpYEej3QXq3/WB7QpWwUUx793LVi1dv8ybrjGh+yAr0wKrRjxWfEDaEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by TYZPR06MB5663.apcprd06.prod.outlook.com (2603:1096:400:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 03:57:44 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 03:57:44 +0000
From: Victor <vlim@gigadevice.com>
To: u-boot@lists.denx.de, git@amd.com, venkatesh.abbarapu@amd.com,
 dunaev@tecon.ru, han.xu@nxp.com, alice.guo@nxp.com,
 Takahiro.Kuwano@infineon.com, trini@konsulko.com, tudor.ambarus@linaro.org,
 vigneshr@ti.com, jagan@amarulasolutions.com, havish.mutya@amd.com
Cc: vlim@gigadevice.com
Subject: [PATCH V1 0/1] MTD/SPI-NOR: Add new device
Date: Thu, 16 Oct 2025 20:57:18 -0700
Message-Id: <20251017035719.122911-1-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:610:77::15) To SI6PR06MB7813.apcprd06.prod.outlook.com
 (2603:1096:4:26f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7813:EE_|TYZPR06MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: e4226120-df62-4280-996f-08de0d3153b9
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yLBnCFq4ructRGyWh1IoGZ0TVXxHAID8MfbhF0dZiYa3C6NMTQxDZ8A95i8B?=
 =?us-ascii?Q?K+UFXjAsd4CzyTZthSu/2WnGVnedqr1eqOMN+KkL+V+6aL9GezgYU4cpHt2R?=
 =?us-ascii?Q?rrhMVLFFg4wKyGPQYNBChnr1Rtr8KRsXTi1CkbMrQRVhaxAmkfr8e+88X0AK?=
 =?us-ascii?Q?Dsh6JMruWF8cp1vHRVpMXAmwScbV9uLlt8SrtRp++attcJ4ZAF3YXk28rj6I?=
 =?us-ascii?Q?K04U1b0tm5yMzOOqUVyT532JAIIv/CIjV4yB8e/iHqyiWWqMN+Lv+Uu2VAGg?=
 =?us-ascii?Q?Kl16A/zh1LnkYira9Bj20kWFGv+hsV11G7kfjcGxX9pstkzianGVsamAfW0l?=
 =?us-ascii?Q?P5H+2rDY0UY8ldDRUcbn2lEmVMFCnvL3vJr7NaZcZpjJJ/Z/l4uZhKF/R6K2?=
 =?us-ascii?Q?OQgGpdxu2fG+TYFyy8pSQRyXjKZVri5wJGo1ooZNnzMsTnYaxXldlWMh/s6m?=
 =?us-ascii?Q?Yf4vc/MQKvz92ksjk2TGJXKU/3EDBcoHdJ0JymNrR8nWuYAUCZEzxg3DkXNM?=
 =?us-ascii?Q?24hYeZg/w9moHiy7fY1DQy6fW0FYYWDOiBCgLKuNcYNuKHnzFm6BT+tG7Ds2?=
 =?us-ascii?Q?gH16+pIstG9g25tMdJbyRQRHBU0oGxH/tJX4AXLOPUYOz7zO0QabM0tq+Emy?=
 =?us-ascii?Q?PahCMqAPOsmhavUuXEjGNSg6MJeA+h2nX6ZlFIfJgARdYWtIANpPtcz6MjcI?=
 =?us-ascii?Q?0r7VZoOWngUMAbRrTlfjNCWgIvb7AafEZLbVVWRldPCyQtkpLWgF5JRE4aBc?=
 =?us-ascii?Q?f+FrPcICMjO7R1p6+KFL/xn2mS1oml+/9p/AfEsZSG8hDNa1bpsz//FkIx9+?=
 =?us-ascii?Q?AihSqjkS0noNZnwm1PgEXU4cYVpOUxz5f8nz8q5sJHyWza//z5KA7TxOFtFS?=
 =?us-ascii?Q?mKZ4cflyrHCnloKnIBqPYIeJkRAb6mzM7iHegpBmluspaaLqL4395OFJB362?=
 =?us-ascii?Q?idKFjDSLIqqn0NirnBTxRKjCb/MyMVpK0hqrltMJmN3XaOqMTCYY9ZmZ/UpU?=
 =?us-ascii?Q?0j9omW6erM9q/U2ol4d9iFk4RpvFduYi5SCb4yfTlCWGCp2RC7OuqWkrIN2p?=
 =?us-ascii?Q?bosU1JfgpeJ1IUIkOOOEMhgzd8C3eDuRPSeQk1HknrctxL30Y390oBRcr29n?=
 =?us-ascii?Q?lbQ9m3NwSrrbHjRH+MYEwK/F8SoLvFfjrCAvB2QrHvxD2iEhPhi/ETS97zCH?=
 =?us-ascii?Q?/+JRKnv1+Ui3ls2Y9TBOBHQpuo73Ulk9jvCpJY8XQ8hOwKYRVuQ+8OjxlzSS?=
 =?us-ascii?Q?Tp1Jm0x5+F4GQFJOB10slmzk9Z8bjkfn2F64w5yqtDpYYFKPO4Getk7Jf+c0?=
 =?us-ascii?Q?5d87CNzHBXJXSyVBDvFj9Kk2m4a4Vk2qX/CNRSbec8CGjCi4GlnW/HmLNhvn?=
 =?us-ascii?Q?h75VXRMl+NejPNFkfXJkhAnBQ0quBlzbdu35eOPA9C5wCId3DfBr+a3C/Pys?=
 =?us-ascii?Q?54tfgpW79LAl4VexGFo+Kjt+PBtESBJm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uy3VTN/RCG3K8O1hvnQMpiWHUF/PwJaBd+ZEjRsdYZ640Y2qooBWydLOjy4+?=
 =?us-ascii?Q?sQu+I005lO7gt0vbB2WsQ1BDLn0r07hv3Fh/cSrFvDYHIF+ha+zRcYCC1BSf?=
 =?us-ascii?Q?B7Qz1YaG4LLiNY7MUu544H9MNCqpGIRpF16YjOir3z1OLr4Lu/s2zGnABsjh?=
 =?us-ascii?Q?/5UEE1BlawJwHXze9Hq07E9kwzf3FbnzOSrqvsepToiMRk9PsYaJNRxXA8rk?=
 =?us-ascii?Q?TzFpIgaUdtCQ+wulh3Dm23iob0wcMnqhE6bXJNLw8oWEfz0qnY+Ckq4GGJCa?=
 =?us-ascii?Q?DMnCRE/xXA5NYTjuJj9UsNbUQTfPQBwmDvuHmBlCHIMFF2gF+FlXYNVbzEur?=
 =?us-ascii?Q?brZsmL9iRT8EG5EuJN88G/dH+U18PVsZtXJlE4eOLK8R/SHSzmYYmAJVy9Tc?=
 =?us-ascii?Q?qO+8HCgP2d0yBJr20tJzAlUzGuYBGp0ktNnEyyOiDQ3V0D2mmHSRYHybMUlP?=
 =?us-ascii?Q?kXce07OXTwEAUu3uICVvyOtfUhGzq+KYTOHxYxbl+om8balk0/ebkn5t4vd2?=
 =?us-ascii?Q?E1UBJaU4Q18pr1hvZ6kYQiYLfJvfWsjIb5Ln1z6xKNuv2RenjJKpBUmtqdug?=
 =?us-ascii?Q?j22j/VzI/G5JjK2jnJbGXO3KPYr8fzjWhttqZ1ErFPBQKOuTeJdPjYvGbZM8?=
 =?us-ascii?Q?JTtabqxNIjSYAdL8Jl1KficDu/nBiB4CkfnGAZ0IFbvHLAIiCf/sAGMy6d42?=
 =?us-ascii?Q?VG0i4cjNdonN06GILhfSJAE2A2Ux1qfX9oQuQ8z2QKGaqrI980YFJfVrd0yN?=
 =?us-ascii?Q?kPUOLszk1Y/jFXlSSlEAg7YGJWqSSSj02UG28tCHVuElJEhysVEcV1rQxrDO?=
 =?us-ascii?Q?yHKIVj9gzH4HqVnxrSgz4GTNpkWjJyS65QUbcTst+afv/FxsrFK0GH8Y1koI?=
 =?us-ascii?Q?k+JKNDuujAV9P3N9JFwy9Eni7DqxNXLYPtHXH7sUHyoio92+5byD223Il1PZ?=
 =?us-ascii?Q?8BBWCCPz1gLlXhyjEbU0eGsoeNV5Z20X7uMq71x8VfdEnlTNrudaU5kysFEr?=
 =?us-ascii?Q?Ho8Hx1lvLP/VzW8bL5EJDzFURIuDdjHH8EBttd1hw9K2zcg9ruZzqvc/UG+2?=
 =?us-ascii?Q?KcrbGoyKmJuIm61Skuxum5Sn1EkgOHpa7IznQSGkj0+f5k8c7uOVEW/8BPEk?=
 =?us-ascii?Q?3ZauVm0GAeDcrNimhrYhNguy3Ebi90wnNL+sMHEnJ5tP8xWd2pnm0CfU13+G?=
 =?us-ascii?Q?R5ZyyYhigOOLFRrZPHgrYO9eNM1ejWdvK1AmmAxtXtOeGAy5fNTZApSPMYve?=
 =?us-ascii?Q?C9pNDU4SYsr6cx4PoV+teP+UV9IED3bAJ/6R7HCoUhqnM1bmdbLvOWDGbHET?=
 =?us-ascii?Q?2Xj/ZJC8TTpp/5nVAowRzi+0sC9gKdoHSZJWJyXXD/MAt6Rou9PkYWezP36F?=
 =?us-ascii?Q?HbtCz5CrTWFBvh2uahNmvK47ViUwkKjKpvkqYPDW8MePW3RRu2D5lE2bBZSr?=
 =?us-ascii?Q?ZQ+w36YFbEkRfdF5HesLqxT7a4wF6fReM3/QHY4uwxondbpRHZbNKVbEV/XK?=
 =?us-ascii?Q?S2sK3zdlYYQRofq2u0JG/x5gajVHbw3gwnP+FiZLjJiaaddE8KzoPLrG3I0W?=
 =?us-ascii?Q?ZWxEisqDuLgoVWcgL5FRBjLHXa7C4a6bBbwub9u+P7BCgsqkBi6wL/v1EoZG?=
 =?us-ascii?Q?ON1662IcOYdnaey7BlHVbwtHrl+lwgkRacZaN0mV4KIm?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4226120-df62-4280-996f-08de0d3153b9
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 03:57:44.5822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM9febeMY6q5kMqW09tjn7anDa9Jk2+AaQVHxC0F15Mo+Vxm0ixtLmVdt8Vw9Y0sC/bUXwTEngQZrwqFEeIwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5663
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

GD25B512 with ID C8401A
This is a 3V 512Mbit SPI NOR Flash.
Link to the datasheet: 
https://download.gigadevice.com/Datasheet/DS-00975-GD25B512MF-Rev1.1.pdf

Tested on Xilinx Zynq-7000, on Digilent Arty-Z7
This is the test result.

--------------------------------------------------------------------------------
[10/15/2025, 8:46:26 PM]: Program flash with id '0a43e5cf-2f94-46e0-b1de-35692e4c9b52' started.
--------------------------------------------------------------------------------
program_flash -f /home/victorlim/Desktop/vivadoPrj/ZynqP00/xqspips_flash_intr_example/BOOT.bin -offset 0 -flash_type qspi-x4-single -fsbl /home/victorlim/Desktop/vivadoPrj/ZynqP00/platform/zynq_fsbl/build/fsbl.elf -blank_check -verify -url TCP:127.0.0.1:3121
****** Program Flash
****** Program Flash v2025.1 (64-bit)
  **** SW Build 6140146 on Wed May 21 17:37:51 MDT 2025
  **** IP Build 6138677 on Thu May 22 03:10:11 MDT 2025
  **** SharedData Build 6139179 on Tue May 20 17:58:58 MDT 2025
  **** Start of session at: Wed Oct 15 20:46:29 2025
    ** Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
    ** Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.

Connected to hw_server @ TCP:127.0.0.1:3121

Target not specified. Selecting target_id 2 (arm_dap) by default.

Retrieving Flash info...

Initialization done
Using default mini u-boot image file - /media/victorlim/WDC500G/Tools/Xilinx/2025.1/Vitis/data/xicom/cfgmem/uboot/zynq_qspi_x4_single.bin
BOOT_MODE REG = 0x00000000
Downloading FSBL...
Running FSBL...
Finished running FSBL.
READ: ARM_PLL_CFG (0xF8000110) = 0x001772C0
READ: ARM_PLL_CTRL (0xF8000100) = 0x0001A008
READ: ARM_CLK_CTRL (0xF8000120) = 0x1F000200
READ: IO_PLL_CFG (0xF8000118) = 0x001F42C0
READ: IO_PLL_CTRL (0xF8000108) = 0x00014008
Info:  Remapping 256KB of on-chip-memory RAM memory to 0xFFFC0000.
MASKWRITE: addr=0xF8000008, mask=0x0000FFFF, newData=0x0000DF0D
MASKWRITE: addr=0xF8000004, mask=0x0000FFFF, newData=0x0000767B

U-Boot 2025.10-00642-g2ba64e303b27-dirty (Oct 15 2025 - 20:45:29 -0700)

Model: Zynq CSE QSPI SINGLE Board
DRAM:  256 KiB
WARNING: Caches not enabled
Core:  8 devices, 7 uclasses, devicetree: embed
Loading Environment from <NULL>... OK
In:    dcc
Out:   dcc
Err:   dcc
Zynq> sf probe 0 0 0

SF: Detected gd25b512 with page size 256 Bytes, erase size 64 KiB, total 64 MiB
Zynq> Sector size = 65536.
WARNING: [Xicom 50-353] WARNING: Flash Mismatched. If flash programming fails, select the correct Flash and try again.
Selected Flash: qspi-x4-single
Detected Flash: gd25b512
f probe 0 0 0

Performing Erase Operation...
sf erase 0 70000

SF: 458752 bytes @ 0x0 Erased: OK
Zynq> Erase Operation successful.
INFO: [Xicom 50-44] Elapsed time = 1 sec.
Performing Blank Check Operation...
0%...sf read FFFC0000 0 8000

device 0 offset 0x0, size 0x8000
SF: 32768 bytes @ 0x0 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 8000 8000

device 0 offset 0x8000, size 0x8000
SF: 32768 bytes @ 0x8000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 10000 8000

device 0 offset 0x10000, size 0x8000
SF: 32768 bytes @ 0x10000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 18000 8000

device 0 offset 0x18000, size 0x8000
SF: 32768 bytes @ 0x18000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 20000 8000

device 0 offset 0x20000, size 0x8000
SF: 32768 bytes @ 0x20000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 28000 8000

device 0 offset 0x28000, size 0x8000
SF: 32768 bytes @ 0x28000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> 50%...sf read FFFC0000 30000 8000

device 0 offset 0x30000, size 0x8000
SF: 32768 bytes @ 0x30000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 38000 8000

device 0 offset 0x38000, size 0x8000
SF: 32768 bytes @ 0x38000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 40000 8000

device 0 offset 0x40000, size 0x8000
SF: 32768 bytes @ 0x40000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 48000 8000

device 0 offset 0x48000, size 0x8000
SF: 32768 bytes @ 0x48000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 50000 8000

device 0 offset 0x50000, size 0x8000
SF: 32768 bytes @ 0x50000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 58000 8000

device 0 offset 0x58000, size 0x8000
SF: 32768 bytes @ 0x58000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> 100%
sf read FFFC0000 60000 3488

device 0 offset 0x60000, size 0x3488
SF: 13448 bytes @ 0x60000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 3488

Total of 13448 byte(s) were the same
Zynq> INFO: [Xicom 50-44] Elapsed time = 2 sec.
Blank Check Operation successful. The part is blank.
Performing Program Operation...
0%...sf write FFFC0000 0 10000

device 0 offset 0x0, size 0x10000
SF: 65536 bytes @ 0x0 Written: OK
Zynq> sf write FFFC0000 10000 10000

device 0 offset 0x10000, size 0x10000
SF: 65536 bytes @ 0x10000 Written: OK
Zynq> sf write FFFC0000 20000 10000

device 0 offset 0x20000, size 0x10000
SF: 65536 bytes @ 0x20000 Written: OK
Zynq> 50%...sf write FFFC0000 30000 10000

device 0 offset 0x30000, size 0x10000
SF: 65536 bytes @ 0x30000 Written: OK
Zynq> sf write FFFC0000 40000 10000

device 0 offset 0x40000, size 0x10000
SF: 65536 bytes @ 0x40000 Written: OK
Zynq> sf write FFFC0000 50000 10000

device 0 offset 0x50000, size 0x10000
SF: 65536 bytes @ 0x50000 Written: OK
Zynq> 100%
sf write FFFC0000 60000 3488

device 0 offset 0x60000, size 0x3488
SF: 13448 bytes @ 0x60000 Written: OK
Zynq> Program Operation successful.
INFO: [Xicom 50-44] Elapsed time = 2 sec.
Performing Verify Operation...
0%...sf read FFFC0000 0 8000

device 0 offset 0x0, size 0x8000
SF: 32768 bytes @ 0x0 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 8000 8000

device 0 offset 0x8000, size 0x8000
SF: 32768 bytes @ 0x8000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 10000 8000

device 0 offset 0x10000, size 0x8000
SF: 32768 bytes @ 0x10000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 18000 8000

device 0 offset 0x18000, size 0x8000
SF: 32768 bytes @ 0x18000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 20000 8000

device 0 offset 0x20000, size 0x8000
SF: 32768 bytes @ 0x20000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 28000 8000

device 0 offset 0x28000, size 0x8000
SF: 32768 bytes @ 0x28000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> 50%...sf read FFFC0000 30000 8000

device 0 offset 0x30000, size 0x8000
SF: 32768 bytes @ 0x30000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 38000 8000

device 0 offset 0x38000, size 0x8000
SF: 32768 bytes @ 0x38000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 40000 8000

device 0 offset 0x40000, size 0x8000
SF: 32768 bytes @ 0x40000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 48000 8000

device 0 offset 0x48000, size 0x8000
SF: 32768 bytes @ 0x48000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 50000 8000

device 0 offset 0x50000, size 0x8000
SF: 32768 bytes @ 0x50000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> sf read FFFC0000 58000 8000

device 0 offset 0x58000, size 0x8000
SF: 32768 bytes @ 0x58000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 8000

Total of 32768 byte(s) were the same
Zynq> 100%
sf read FFFC0000 60000 3488

device 0 offset 0x60000, size 0x3488
SF: 13448 bytes @ 0x60000 Read: OK
Zynq> cmp.b FFFC0000 FFFC8000 3488

Total of 13448 byte(s) were the same
Zynq> INFO: [Xicom 50-44] Elapsed time = 3 sec.
Verify Operation successful.

Flash Operation Successful

Program flash finished.
--------------------------------------------------------------------------------
[10/15/2025, 8:46:46 PM]: Program flash with id '0a43e5cf-2f94-46e0-b1de-35692e4c9b52' ended.

Victor (1):
  MTD/SPI-NOR: Add new device

 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

