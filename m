Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B50C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 15:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E47B877F5;
	Thu, 14 Dec 2023 16:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cp7zAjFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DA387815; Thu, 14 Dec 2023 16:51:12 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4466087613
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 16:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idL1D4ODXQehsJ2bjPV26tGWJrgYGsPaweCDHyuCibveE8h5R1i6L3rvRn5HAQPz8+fQ+5UB+ZjJAR4OQTdaIowSZO5wB50+Kx1lhbMD1JTZTP00rz2jCM6H8wsiS3AvThV0ZJvIKn7LUutWKEvejj+w/UtT3rbKkDUPnPS6X2DPRS6x8wmkNLvI1h4g4RKUN+vxD2h4GiKYeswAKIaH4yNlkGkmM1LRl92hL9i4B3nTZc7WMdqtuOaalnvJOpUPjvUOr9jh1wcs6qepz5PsHrQwZWBEw782DyKxIHAnBE11oNZYcIZ+ozo2VDjDlg8SoBABSJCC4ixfctiwVVdCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPvuabmhAfyvdkHWKSMGWfgJ+/Q+fQC5mqxRP2Mluxw=;
 b=WEwkwF0pW7MBAbJUv4tMnXGEI3KzBd87ytfoiM6GkHjx9BKticelsQRadOnPx4zytyyUgTJ1x9znN19v4zeKVHtTJ6KJhjo3v/HvM5XGScZJ0xFA8ejfA7p+1pwvfe9rRmLCP1YD6TGUXt0b2lF0DyOxPaOcCxA8lz/bu/h4E45l+RvMODJpm1NOx5yhEHtooyKyoJGmGLQuJgUnhzTWirCXDePL3lLT3XyGITvpsikWGJxOI6VbwlQ3QuER3ZVDcT5Jyzad5p04cDT0SwsJkHtO+XFdQX5UTHcI0HsWBZ4UJCpfg5+R69pN0FhcJhS4kVAuQYwjn9YQB/s0AhN1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPvuabmhAfyvdkHWKSMGWfgJ+/Q+fQC5mqxRP2Mluxw=;
 b=Cp7zAjFR6BeCH5EU/R5rnwo7B/8CFqXkUu5ZlwH+FGB49HMX0SzdVt186+6Bu5oRi6R2sT+ElFwTJHeBqsFIIESmyYGD3ldg/Ta79zQZrdiWN67NnoufcsecYeqOcDiojHLOG/jl+obIpKZYxN80QC2HxAjmrCiYa7XNn5dbmb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:51:03 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:51:03 +0000
Message-ID: <b60d9dfe-cc17-46b4-8fa8-dffdb8651812@amd.com>
Date: Thu, 14 Dec 2023 16:50:53 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] xilinx patches for v2024.04-rc1
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0223.eurprd07.prod.outlook.com
 (2603:10a6:802:58::26) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: e146798c-371a-4c1f-6811-08dbfcbc7991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGa4zk8B3zgQe4hRhUO0BDDPBF2N8oClsmEil3oQVX8TTiAVx+zEsdIXVjmklj+GUO+OioN/0WL04flRpFrU+cWAo3Xd6BLvz0zLQT2nWk5HbAty3wP+wjCtM/8Ik506PnB5W9gehNkr0raCdy2FK2Uy0muTU+c13w/oxc0MuvNeH+yb0qyhYQ85W7VzAYCp+RxJE6Ci0JmE5Q8qdzRc/IT4CsRJ0OK1jDqCthjLpDialjZry81YSGXxzAl8ricSKMEmUu3azU61bZjTgSm2WGW1GqMkXHNOODMUVzPoSEa4D9gsQLOWZhTlubsULxKuihv7xvP5i70TunUAxjTLJ6z4MRCvSRCubMEwrE7N+UfQdFkGnWa2bwR7dmX/ljZUurF+lzRTg/XmkB7iRT103PV2KGBIVti8hC3racbpagj7RK+lDK1xIN0CndjhHWY4TpskjyECTQ77Y7UjF8mCx0dKPm80szlcAJzlYwbhgpBNGKcCww0jJOFgSTznfa213qUzXD2L7pj0rGrxeJmfmcnkVZyhCdc/UJqfYIaGKs0b5YmP2K5L6USapzX4OPj2mGeXhtD0eLJcjdBBBxLSTYnAus5BfSUb1iR4PSpgHYV8jGoHyE285zm/VmrSMoQFtlfw4viwhHA0GZmm1vLIQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(8936002)(8676002)(41300700001)(6666004)(83380400001)(44832011)(2906002)(66946007)(66556008)(66476007)(6916009)(38100700002)(316002)(5660300002)(4326008)(6486002)(86362001)(478600001)(31696002)(2616005)(4001150100001)(36756003)(6512007)(6506007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURyWFdha016Q3pOYVdJNURUSTFjdG5obFBDT0tGSWlMUEFZOHlmVmQxU2ov?=
 =?utf-8?B?M2hRN294c0RBb1hWdTRYTmJvTXFtR0phb2xVUDh2QWZWb3N2aiswQjZtWnBv?=
 =?utf-8?B?WUt2REJkUlZZbEZNWkEvNGQ4d3lzZGZmc0FESU1LSThWL01KbFkyTGgzSHdw?=
 =?utf-8?B?SE9kN3Z4UTJwRHFGU01kTU5vQmpXb2x1UitobEhSTkdxMGVzZ3EweWFBRGNp?=
 =?utf-8?B?N3I2dUlzNGJ4OE1EcGZsaHdNcjAzVlpYazhMYXB6c01tdGxCZjMzOFpOZHoy?=
 =?utf-8?B?UDd2VEJGaWJvOXY3TlFsMjZHcFArNVpuYm51d295U1dzcmg0ZEMvQk9qQnhU?=
 =?utf-8?B?UjBBZmIvaEx0YUt5VXdpcHA1SnFxS2FCVVptc0pabWdxS1hHaGtweGdDT1gx?=
 =?utf-8?B?dm5jZkV5a0xLNU5wNUxhd0I2aWVhUTVSNzQ3UXUxOU5ISGgvMjBiYWlsMC9a?=
 =?utf-8?B?bU9VMzRIalRJZjB0eHQyQjZoc3R1d3ZXcDc1WWhnc2pRRXlsYmQ3WmJyV2FK?=
 =?utf-8?B?ME42WWlPSXZFSW9Rd1VINkRoa2lYUWdoS2VmejNoVWduS2dHVmhCUm92NVZr?=
 =?utf-8?B?YUx6SGxFMGZTYkVjbTcwK1Q4bENSaHRaVFQwVFJhV0NSUy93UGlUMkFmNy9l?=
 =?utf-8?B?dk5kVDgwWTk2RlV6bFRtVWt4TzNJYWs5MmIzdm1CTEpJNXBKMWVQVmpUeXNi?=
 =?utf-8?B?SU10NERNYWZ6ZU42eFo1aU8vMWE3K09CcDd5c0VXbGcvODRCL2pubG5pY0N0?=
 =?utf-8?B?bmY1dzN2dlhIRjNLWWFtZFRjclNiVG4xYXRIV3h0bXpKRDVtU1FzemZLWExt?=
 =?utf-8?B?ckQvNmNVMWp1MkMwamhoaGtMTkFYRjJMaitNWnRnU3dGOEFzR0tGTzFWclFS?=
 =?utf-8?B?b284OVB0cGRZUDFOZkpCMHg5TmpRQmFSMEVsdGVaa21uZTVDRlFONjNzMXk2?=
 =?utf-8?B?bUpRN1o5QWk4czFmOGxiKzFvWE5DK0lBeE9Yc0NmS1dOMWR3WGhlUVBEYVpz?=
 =?utf-8?B?UEZRUitwS2tFYmdvRWFTaVh0OWRlb3Zta1N1eFJyY1RDRlRrRzhPS3c0MmFV?=
 =?utf-8?B?OTdGd094S21PdmwwRWx3WEVqbXhjRFF5T0s5SzlTKzFQalNPZ1YrdjRVVjBt?=
 =?utf-8?B?eXl0emdNZVhoWHNiOVFETjVWU053ZEplOFlIdDY4QXhjQXl0dzZoWWdlbXFr?=
 =?utf-8?B?ai9nN0JScWE4ZVNNRnE4SUNmL2xvZldOOCs5cUErVXZwZEsvQi9oZDIvbWNX?=
 =?utf-8?B?bTVPbGJjU1YzNnNNNHFXcWc2cW9ySW90enBmR1VOMzllem1tbTExc3FpM1lS?=
 =?utf-8?B?eXVVWHFiYkNSYnhzWTV2TThKSzZBaHNDN1FEcGEwQ1FlalVJSW1ONmpBSnpR?=
 =?utf-8?B?UGE5SDlKQmVneWJXMVRmSW16K1NNT1hPU2s0RHR3OEVRbTJEb2xsRUtSRUZT?=
 =?utf-8?B?bW5WcFNQamQrOUNHbWg2Y0txSW5SSWZPdDZ0VFl0NDFuWXBnNTQ3bmVxVVhN?=
 =?utf-8?B?T09UYVpocmdUWGd3cWVZSC9RZkxoOC9QN3pxRVNYbEkwbnBCUTlMREMxTWRp?=
 =?utf-8?B?RTRqZXlSUFJZaXlGT29hNE5JU1ZMTU9oUnhtUW8wd3VSbFJXWkMzcWtacEZL?=
 =?utf-8?B?cmZXMjJvR0ViRStjQXZaajRUdHZZOHZjMzFTVnRHYmpRaGUxUUN6RGI0eHpw?=
 =?utf-8?B?emhRNng0c0syZDlYTWRIMHg5TDBzVlFHaU50cXNoSmNoclNHaHovdWZXTHph?=
 =?utf-8?B?UEdVdHdVQm41c2syR2ZWdVFlUTRQa0RsRWZQSDJYMTJ5dlZvRFgzWDBzT3oy?=
 =?utf-8?B?TjYvaFo4elREeDdQVkN2OTZuQzRMTTF2Vmk4RTRjbXdpNDlOdFF4MWtSajlQ?=
 =?utf-8?B?RHVrREFkTHhBeWVKTnRvQ3BvNGcyYTh0S1hrOUdIRmU2a3Iyb1JPNFVjYnhV?=
 =?utf-8?B?M2ozK3Iva1hBT2hKQ0JEaGxzNDl2RmN0V2VCdGhZOXp1V2hkRjdPZFFVOHRF?=
 =?utf-8?B?RmxlME1hMHRmdG8wNk54STg3clFYNmtPYzJZYllzTEM5Vkgvdm9wa3hLelBv?=
 =?utf-8?B?RHpFSDYzRk96dWNnRFFjREJYL0Q5T3I3enJqdEdSRmNmVUVROU1FOStmUXJh?=
 =?utf-8?Q?yEHiRzKlxnKXtFly32tob8p1G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e146798c-371a-4c1f-6811-08dbfcbc7991
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:51:02.9488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+aNtxTnycGox9hgrVnImSYQOCX/7M/KM4+neaFeB3wc1SCPNeZXB6KDaA3VFFwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

Hi Tom,

please pull these patches to your next branch. There is nothing controversial 
from my point of view. The biggest change is to create new kria defconfig to 
target couple of boards based on ZynqMP. There is going to be work related to 
binman to start to composing boot images and especially FIT image with dtb+dtbo 
together. That's why I am expecting more patches to come for 2024.04 but I want 
to clean my queue now to get these patches for testing.

Thanks,
Michal


he following changes since commit be4a5f7c35685d228b3abc398a8d86c434274de5:

   test: bdinfo: Handle systems without getopt (2023-12-10 10:08:30 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.04-rc1

for you to fetch changes up to 4f340244b974d52c48e01cb845cfe8315f7e5764:

   clk: zynqmp: enable topsw_lsbus clock (2023-12-13 16:48:15 +0100)

----------------------------------------------------------------
Xilinx changes for v2024.04-rc1

zynqmp:
- Introduce Kria specific defconfig
- Calculate SPI image location based on boot offset
- DT updates

zynqmp-clk:
- Fix topsw_lsbus_clock for DP

axi-enet:
- Support older DT binding

mailbox:
- Add support for multiple mailboxes

pcie-xilinx:
- Covert driver to newer interface
- Enable MMIO region

zynq:
- dfu updates
- Enable capsule update for Antminer S9
- DT updates

xilinx_spi:
- Add new xfer callback and support runtime fifo depth discovery

----------------------------------------------------------------
Mayuresh Chitale (6):
       net: axi_emac: Use reg property for DMA registers
       pci: xilinx: Fix "reg" not found error
       pci: xilinx: Enable MMIO region
       drivers: xilinx_spi: Use udevice in start_tranfer
       drivers: xilinx_spi: Add xfer callback
       drivers: xilinx_spi: Probe fifo_depth at runtime

Michal Simek (6):
       arm64: zynqmp: Do not expose usbhub nodes
       arm64: zynqmp: Remove description for 8T49N240
       xilinx: zynq: Generate dfu for SPI only when enabled
       xilinx: zynq: Enable capsule update for Antminer S9
       arm64: zynqmp: Add multiboot support for SPL/SPI offset calculation
       ARM: zynq: Remove deprecated device_type property

Tanmay Shah (4):
       mailbox: zynqmp: support smc calls to TF-A
       mailbox: add el3 support only for zynqmp platform
       mailbox: zynqmp: support mulitple mboxes via device-tree
       dts: zynqmp: add missing destination mailbox compatible

Venkatesh Yadav Abbarapu (2):
       arm64: zynqmp: Introduce kria SOM defconfig
       clk: zynqmp: enable topsw_lsbus clock

  arch/arm/dts/zynq-cc108.dts             |   1 -
  arch/arm/dts/zynq-syzygy-hub.dts        |   1 -
  arch/arm/dts/zynq-zc702.dts             |   1 -
  arch/arm/dts/zynq-zc706.dts             |   1 -
  arch/arm/dts/zynq-zc770-xm010.dts       |   1 -
  arch/arm/dts/zynq-zc770-xm013.dts       |   1 -
  arch/arm/dts/zynq-zed.dts               |   1 -
  arch/arm/dts/zynq-zybo-z7.dts           |   1 -
  arch/arm/dts/zynq-zybo.dts              |   1 -
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts |   8 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts |  10 +-
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso  |   3 +-
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso  |   3 +-
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso  |   3 +-
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso  |   2 +
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso  |   3 +-
  arch/arm/dts/zynqmp.dtsi                |   1 +
  board/xilinx/zynq/board.c               |   2 +
  board/xilinx/zynqmp/zynqmp.c            |  15 ++
  board/xilinx/zynqmp/zynqmp_kria.env     |  66 ++++++
  configs/bitmain_antminer_s9_defconfig   |  12 +-
  configs/xilinx_zynqmp_kria_defconfig    | 227 ++++++++++++++++++++
  drivers/clk/clk_zynqmp.c                |   1 +
  drivers/firmware/firmware-zynqmp.c      |  22 ++
  drivers/mailbox/zynqmp-ipi.c            | 159 ++++++++++++--
  drivers/net/xilinx_axi_emac.c           |   9 +-
  drivers/pci/pcie_xilinx.c               |  37 ++--
  drivers/spi/xilinx_spi.c                |  68 ++++--
  28 files changed, 578 insertions(+), 82 deletions(-)
  create mode 100644 board/xilinx/zynqmp/zynqmp_kria.env
  create mode 100644 configs/xilinx_zynqmp_kria_defconfig
