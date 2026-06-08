Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7CCD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 12:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A32E83EEF;
	Mon,  8 Jun 2026 14:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZPTB7iR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A92D08466E; Mon,  8 Jun 2026 14:51:29 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17B0807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 14:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1G6OrgWH4IKvLcYbg2RiureNz1lKDwyoUoZLKaGw2l/Qxc/W4/Ywo0BVl9g1ktV8BmF1vegyUWmP8fk/PiUW2nkPN4ITRVPamaclAXpdhO53jnsN97eRnwMh5ZIs4luxbzc6nmMdc1ka1KS24DdWDqn/M2KDBQ3W+BRk5jiCJ8zw079XW+etV2CZXtORnOI43NBUHUPHBQ4wW6f1eaE0+vhCwI6poboEs5YxBwNZNjCT9rBtWRLtITAOFVNxAKLb5LTgWOcVo8T18YpJ//vFMdyrlPUiniu8X4b7rc8y3VQFh0PPP+V2zYfZwMiREC96Zj0Lgc+Og+fH7y9gRX3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCC23DsSfS+j5HXzkNc8NV6o63bGp8a7qfcNFTQXSTM=;
 b=cohz0wp24oBUbyPweC31Q3orCHueX+pY6v9DR088XUDuzL4Q6gydhV7e4Npc1UtZE1M754Jc6i5a2BbZIbYjfMlqtmKNgXZ8im0FcxduOkh0/sl4T7Sw2AI4M1norWfZ5bIXZKJtgnh3Wi5vQTGR5wUtUDYUQuhcxdLlk92KzRqfO8GkbO3zYQ0LJdiGNygXigaNtSdij74fJZCu59ofb78kF2wv58rFd4oFUaMi2MB6MDNTM8Byz1kpizON7kuUC9I3lCmBUJ643985JYXp1pmuVfUJbu41Dkkv/HqQ0V1hY4F3rOAS2sIxocGRsBc5RNDI/228quUQN41kiWfO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCC23DsSfS+j5HXzkNc8NV6o63bGp8a7qfcNFTQXSTM=;
 b=mZPTB7iRZ2lz4qD74dc6c8w2wWI3z3BrXlk5nv41W7fJCzrzsG//yxiiDbw4cGkcb/TD+PYNIdHK8kX9urKHRIYHdCGE01t95pIMsxVwfqhiUtsAtz66Biu7ZKerqKncYzV+vskc5LNpK05PEkuknvIKddhhFTeuUW3J1+RyaUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 12:51:20 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 12:51:20 +0000
Message-ID: <b1468ad3-a7bc-4a41-b9fa-547cdfc376dd@amd.com>
Date: Mon, 8 Jun 2026 14:51:14 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] amd/xilinx patches for v2025.10-rc1 v2
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ace1331-0f72-4fea-387b-08dec55ca37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: feC2PzPvYhfJp4VoumZfrGlA/K3UnZ6vTcZ0GLqb3AK56sbORdFl8Yz6CVkNiLtCTHrv+diR7SC6OFpzgfiIUHijwEBnVqdOzBuzKXwYkVe+4fnot8zeNxj1w3Qfa8zM8nOdBqTFQlTo6R/I4lNEImPHgYzEsQYwteAd/sVW5mMwb5K4eKpDYsVYCiURgq52DRAD6FBiELG7fP0YuEOCy6IG/8SjlYU7wAna7tGPnH419vb7iTQSJiaYGESYhEnRzz7FbaEiaCutMZ8n6hoJr7y6l/C/0aUOUhKRDqzBHI6leC5QQAkZEPN64V2WmRzySZRXa57fsaQgNwpeodqbdeLqk4NUlMq4kSChhKPOq1mxgUS2toJsom9fpDyx1pdG8KR/uREHvj1SvzUdfAI4J7vxAZGgYkOimc4l2xuIzKsTtniDVVOjnhkXkfi+3MnCEz0qkAysh9A28MKLUekvnCklJUBzag6kMSNkpakfINx2c/5NkXtrLm+HvCf/s+QJsSIAzw+y0cgcUGHWzrAmUciUu3yzMQ+r+qxjOr6dvpiSoKe1UxE9VrG0FrbY2T/1fLW/qaBDHKZuVjlj/wXWIbswSqXVIkdTOS97M8/idBWa7KizBhBf4GPwe9g7BaGhpkoLQAH26kok9RaDj2XCuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUt3dzNqdG0yYnBFajhJa3gybjNuc0RQWjE5SmNCWE1URzdjbHlwaVREeDZ0?=
 =?utf-8?B?MHpxYmc2d0FKUjRmS0JmaGdCZXJVZE02V0cwVFY5MmxNcmF5TVNEcEtkZzhx?=
 =?utf-8?B?WmtnSSs1clNTN1N4clFjdTg1R0hPaHViMHpWQS8rOWxyWTBnNnpWN0htMGg2?=
 =?utf-8?B?aWttM2Y1Q0pCUEdNQjgxWnhHaDVoUVFFMlk1TUttSDRqY2pvT042TnNKUnU1?=
 =?utf-8?B?cm5ZcC9sM3NDbEQwL3VjdlZHTG9EbnorU3NrSVZaYThuSnZ0YzZJL1dicmtk?=
 =?utf-8?B?eG1DMXlLUnBkNDY5UGtEOUNqTy9NbkF6L1ZkR09oSFkyOVpzRWV2bG9CRlpU?=
 =?utf-8?B?Zlg2V05vNjZqd042WlNzZ1FpYWwvYVBBdzNiRDJDUGNtdm41aEZUTy93ZTJp?=
 =?utf-8?B?anlncEhSaU9DdmtBMW1Va3FyYmVUOWp6MzFrWVFKalZ6elBvckRtSTRkckZ6?=
 =?utf-8?B?R2tUendCY1JUbEV2RE8ralJTL3VsQXloUFhReVdCY09JL1dicEtJdnlVRS9i?=
 =?utf-8?B?YUZKY2JzZmxZSG5lS0FYcnEreDFyUnh3Zkp4UjhaeW9ZelBsalJUTVFBb21R?=
 =?utf-8?B?MzNuUmVyb2hkWnVQZm5sVDF2c0M0ME5lTHNqckU4UkU1R2Y0SWxOWWo3Wmph?=
 =?utf-8?B?cFdnclRiTlYwRXBndnJ3MWhyVUpQOGR2VmkwaTFUcDZuVzlDQVNWN29rc3k5?=
 =?utf-8?B?Mi9QMURITU1vWGp1T1U0SFZJWkFNZ3NncGQxemh3WHRpS0F0NlY4cWN4cjc3?=
 =?utf-8?B?ZDY4L2l2eVM1dHZhQUZNWDl3MFVaQXRkclMzOEgzKzg3UmI2UFZyRHY1Q1dI?=
 =?utf-8?B?TjFWZXREVE9HZVRNaUhnb3dMaTlVNmk2N1diNFY4TXdpbThPbkIyYlRzTDQr?=
 =?utf-8?B?RUQxYUxBeU5mUHBDMktzeWJFaUVBR3BiUUtCWi9hRzZLOG1xS2xDZWQ3MjU5?=
 =?utf-8?B?OUNXaG1vSi9Ob0M4djRIOGs1VkZEZVMxZkk0R3dZRzdxWnRoZnRnOFJ1eUJ0?=
 =?utf-8?B?dHJuRDlVOUFNeUJ2MjhETkE5SFUzNEp3V0NFSnlxVUJ5T3g3NCtZREZ2WGww?=
 =?utf-8?B?TEFHd2VMZUV2dUhxcDBFRFFYbUJyNTloQ0VkRFN2N2RYM1k1NTVIVGNxRUxK?=
 =?utf-8?B?VlAxSk1MaElHYyttNEU5aWlvYTNKSk9nOGNnSHJhNzV1RG5hZ3Q0ZlV1ZFk4?=
 =?utf-8?B?ZTJOUDBOMkU5bDVIR2ZDay9iaWl3djAyUUVjbk5VQ0JBcVkvUlljK2ZjakRE?=
 =?utf-8?B?K1dkQ0Z5M2pHVy80Q3JMYlVleFVJcGQyVVVrbmJMQitHbTFMQkI5UWExbGdR?=
 =?utf-8?B?UlJNc24rYUsxMTJjSVhEeXhiSEVMTFZUcmtSSHRlMnl6TTYzcXVKcFFoQTBD?=
 =?utf-8?B?Q29ncFFlakhhQnpLUGNBQkFGRHVmNnB0OGVzL3lvOCtuTTlEcVI2cFFTZGg5?=
 =?utf-8?B?ZkFVWEhIdjZSUWF2cStYTUI4YmVsR2NGN2s1N3ZYeWVCVXZ3N3AyV2NmcWxE?=
 =?utf-8?B?RFBYWkhLQkJwZVlGY1ZTbjhtT0ZGNDJZYjJsb3BTOUMwelR1Z3pUSzhMcThy?=
 =?utf-8?B?S1ZZNTBJbldXdURKckY5cVlXWUI0Z01xQjdkNWVmMjlmSUxQelk4K0JGWXNk?=
 =?utf-8?B?eFdXVUtFUkswSjlBM1l6UlJoRVk1TTlvY0VtdnFqem5EQlBzTWt1OG5XN1Fr?=
 =?utf-8?B?cEVuRUpsbk1IcjlOMXJnSkFQVUtGMEk3ai9NMUNoZDV4elJGcHRLd21nelA4?=
 =?utf-8?B?aC9jeVhmY1BVN1FWeGQwNVpxUmJIa3AzUTZDS3lCOFU5Y2dpY2VMaVdTUUR6?=
 =?utf-8?B?UXhHNi9yekhwcUo0bCtCL1J0WjQwbm1rT2lNa0piaGtQb1dxZzhJUFdONGhK?=
 =?utf-8?B?cUpTUENpblYwSVRIYUt3bnB2MzRWeVQ5cDJrUnFQc3lCeHNpdFFYcTVKVnlJ?=
 =?utf-8?B?T0JzaUFSUzYrOHF0aHVNR3pyZXoyODlCK1lTMDYvaE5lUmkrYzM5OEJrMlpU?=
 =?utf-8?B?aEEyNU5WYURhdmpXVytXVGVvc0k3WE45aFpWYWtvVVl2RVNvZEVPVmQ4bDB5?=
 =?utf-8?B?RHlnb1ZjMndEd0V2MitkeXppSVFCaFZRcFRnVlJwUHlydVlrSW9CMDViKzdm?=
 =?utf-8?B?MFNUS1BkMWE4V2FNT0RZb1BaTnJscFpSWHJDSVNoVDY3M0RIV1d4eXovNjVh?=
 =?utf-8?B?NVBJT2hHeHlKcVBKcmhuSUR5d3NKdE1LY0I2Q0htT1cxWUM1QUJ5V2RhcUYx?=
 =?utf-8?B?NGU1L2JMUG8zZlB6cGdUVWdBR2ppb2lFcEd5b3RxTHIzSXhoSERDTHlZVmUx?=
 =?utf-8?B?SVFNd0IyazJ2Rm84QjhlRG5CK1V5KzdPODA0VEp6ZlRvd1ZiRTYwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ace1331-0f72-4fea-387b-08dec55ca37a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 12:51:20.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGx8ggg9emnusQBuyxZtie7WoBEeJXDv4WL1JGFQBN2twLsMuw++RB+SqsPVinV+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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

please pull these changes to your tree. (Apologize that it is marked as v2.
I have created v1 2 weeks ago but it failed in CI that's why I didn't send it 
out and then created new tag not to do force push).

Thanks,
Michal


The following changes since commit 9e87893c24d1f21350e69bc222e6a3214c933b3b:

   Merge tag 'u-boot-imx-next-20260605' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2026-06-05 
11:37:51 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.10-rc1-v2

for you to fetch changes up to 8efa173b389e5cef6eece991351442baea0264fd:

   reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE (2026-06-08 
10:50:06 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.10-rc1 v2

zynqmp:
- Clean up USB gadget configuration

mbv:
- Reduce SPL size

versal:
- Add support for A/B capsule update

versal2:
- Add support for A/B capsule update

reset:
- Introduce reset_reset_bulk() generic interface
- zynqmp: Implement reset_reset_bulk() interface

spi:
- cadence: Switch to reset_reset_bulk() interface

----------------------------------------------------------------
Michal Simek (7):
       xilinx: mbv: Disable AVAILABLE_HARTS
       xilinx: mbv: Allow compiler to optimize inlining in SPL
       reset: Add reset_reset() and reset_reset_bulk() API
       reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
       reset: sandbox: Cover reset_reset() fallback with second sandbox provider
       spi: cadence: Use reset_reset_bulk() for proper reset cycling
       reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE

Padmarao Begari (7):
       arm64: xilinx: Add PMC PGGS3 and PGGS4 registers
       firmware: zynqmp: Add PMC PGGS register read API
       board: xilinx: Add capsule and FWU support
       board: amd: Add capsule and FWU support
       board: xilinx: Add FWU boot index support
       configs: xilinx: Enable DFU MTD support
       configs: amd: Enable capsule update and DFU support

Pranav Sanwal (2):
       configs: zynqmp: Enable USB gadget download support
       board: zynqmp: Remove hardcoded USB ethernet initialization

  arch/arm/mach-versal/include/mach/hardware.h  |   3 +
  arch/arm/mach-versal2/include/mach/hardware.h |   3 +
  arch/sandbox/dts/test.dts                     |  10 +-
  arch/sandbox/include/asm/reset.h              |   3 +
  board/amd/versal2/board.c                     | 131 +++++++++++++++++++-
  board/xilinx/common/board.c                   |  73 +++++++++++
  board/xilinx/versal/board.c                   |  42 ++++++-
  board/xilinx/zynqmp/zynqmp.c                  |   4 -
  configs/amd_versal2_virt_defconfig            |  15 ++-
  configs/xilinx_mbv32_defconfig                |   2 +
  configs/xilinx_versal_virt_defconfig          |   2 +
  configs/xilinx_zynqmp_virt_defconfig          |   1 +
  drivers/firmware/firmware-zynqmp.c            |  54 +++++++-
  drivers/reset/reset-uclass.c                  |  34 +++++
  drivers/reset/reset-zynqmp.c                  |  11 ++
  drivers/reset/sandbox-reset-test.c            |  14 +++
  drivers/reset/sandbox-reset.c                 |  58 +++++++++
  drivers/spi/cadence_qspi.c                    |  16 +--
  include/configs/amd_versal2.h                 |   5 +
  include/reset-uclass.h                        |  19 +++
  include/reset.h                               |  49 ++++++++
  include/zynqmp_firmware.h                     |   4 +
  test/dm/reset.c                               | 107 ++++++++++++++++
  23 files changed, 637 insertions(+), 23 deletions(-)
