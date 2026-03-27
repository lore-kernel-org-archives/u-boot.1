Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E31D10F2843
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 15:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E7D183C14;
	Fri, 27 Mar 2026 16:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ribcz1Wy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DA383C5E; Fri, 27 Mar 2026 16:34:27 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353E68394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP3DfmT/yhyW6UW+qBYlrN6b6c2nStqSmlQDQiCFg53Zidmc8Cs10P+812gFBNl/elg7XSD0Vax8dpcfAGDW0Ddr7SfRSwvG/KI4sVQkoJJCN7VD1PyasS162QnSrzHbF3EsWYHe5KXLvUyXUa3tlkXV1DK8aaxa/JhTXkfCraqC3Rbcwdt3jy/+oG7Oy8kM1qP2VfrA05XoUYnBBmZ07I7fHXwssCni1qoJGLaUYKEYTBIQ4iq8S04T16pP91SjnPMp3XpIcl5Lmh7Z2/u+zH4O6Mhjyc0UBOSQl9fEsuL4T9ZVCFCTacDEWMAlujndht7XgNasR5bgKWb0xRY6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDRIvry8YmOMyMY3+hFVIH83y40j7W8AmFewC+b/kmw=;
 b=SflSY+ME9YjKVEcUAo7AKibCDAVFOZgwlnzgKhRydJOzHxsj5Meuv8WV2hAcMPSy4JB0l+K6jLWMtlOqT3+moQjGMKvrvSsOYIOi9vwemofd6BCycQWZdya0w5cZx5FQJSyDLm1kEgGLWv+bAaaxkPzu1YfEqay/TcTiiQircbxBQCyv9ebKeDbup86aOzGxEhZ3+28/bu/J9jGfKao4SU9lXq0AhWL2OlIqpHm8783Mw3XoE5RIB7tCglkWs3UTSmDsS0AiDwXUoeTHDvUR+nnm+5ib0v18l9IgKjwrBktFGCwLilQTGo2iYNR8BxyJ2NhF++KBPEKaV1tEieHxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDRIvry8YmOMyMY3+hFVIH83y40j7W8AmFewC+b/kmw=;
 b=ribcz1WybkQXnXihtAPF1BawEfYvEcsImvMq0QOrGaTluXxEzH5q56NJTDHyPtCprmQ+e9YBSLRm8NEP3BPLQIQb1hTFAehYLvN2bT3N6+pogWLIWVC9Lc1sKXU/F64/e97+ttnq2YGP2NzrHrOi+HY5Pymx72hGcoxC9qavS6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 27 Mar
 2026 15:34:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 15:34:18 +0000
Message-ID: <3f8a042d-72f8-45c7-9d3d-f278f209311e@amd.com>
Date: Fri, 27 Mar 2026 16:34:10 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-07-rc1 v2
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0224.eurprd07.prod.outlook.com
 (2603:10a6:802:58::27) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d2e2e9-0de1-421c-d9a8-08de8c164f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: jHH+v9bFxdBA8aRyYO4kYh3y/I1NdNAvEOlYELLzr3NfKNwHwiC7L7rK0MdY7qxb/4a2292B5xmn8Lk5aShq5W26IKomfo3ch1Re139sTt0sAIrnJ15rlCLW5aINHt/NC6aqgeV+qO9q0PnMJh7CItbbLfQLxF3/LY4s8r9R5bljQnfF7jmySU8GbbWXV4rrCD2C/E+0EN1j+dIgsSA8jF1rabIOVs4YN4RxMtjV2C8X4i2Sa/fNG0bTZSuUk1nj7sHQgOOkegf+xdoH6UlhprwxGUBgLIYY8SIrEG6IWvVER5IpHOljwkuiy7eVNNk1rfr787ZrWTh2+BAWj3GCEGqCawys/4P/NOByn/05A0CPy0CwUAAGl+R6g4s+ztiiMzIFgP+2mg0vhUGfpfZ89mkgYWGVKOlxOzmoOeofbzMewZumJEK1DWf42ypy6lz1qNSn8k9yGbHAzSXQx2mcS34kugQuxzbSeuTwuI9b3g4XJMBUkQ+F589zyiuGTIBf0aKywBKJXV9L7nTgpnNjtbQ1kE14uya+b2rwjWqk7K3b41u+pwER+1GS0MCzeITMpND/lSgP4+Vj6XIoqctKcpek8BuC60Ht80aw47hymgYiGd+VPxWaq8IHwL4fSofnu/2rfMdyREXdAwl+JnCYBeEZx7MZMgQ6fV50udW4V4BKmOjI+mWRkEbEPR/n0Sdh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlNSaDZOVHIweGtEMHRMNk1uSU1pRmVpblVFc3lvWTFaRzIwQVZsTTBWeS9l?=
 =?utf-8?B?RFljOGxHNTQwUWMvaGZPQWhSb0l6WWpMY2FGNHBRVnNGRFpTaUppa2RJak5R?=
 =?utf-8?B?ZGd0Nm02Wis4REcvSnFhZytMdmdMdENIUGNVVFNkb0h4eURrZXdpZytpRmVv?=
 =?utf-8?B?V0ljN3E3RVFBalpwdko2WHNSR0tJMDI5dVp4cERZNElUak9JNVBwZUhKcjho?=
 =?utf-8?B?TmhkWkRsaVFCUEVIOHIvRXF4Um4xSlVXU2I0TExZNDdQa2hzZmJGMEl0Si83?=
 =?utf-8?B?bUVqZVlHZy8zMWpaMlE3dHN1VEhZMmJCRUt3S04vVFJyN1JqSUxOeWN6WTNH?=
 =?utf-8?B?OEc0NW9JMDA1a3dXQ0lTUEdaTmZuekVEWFpOYzhkZE1pd2E1WHRFWitjZ0pN?=
 =?utf-8?B?QzZMRXUwTHZQRFdtZ2dDY2tzVDFxOTZxSUR1a0RNa0lGNXM2TTBjbWFKN25p?=
 =?utf-8?B?V081VmJSU2huUzNWWGJqY041dzl2cVd3WEgvay91Rit0QnczcnBnZ2s1YzZs?=
 =?utf-8?B?VXVzc3dWWE43VklVQmo4Mk1rU3p5OWN6dS9DYnd3YlNPNXU1c2NvWWhNbWNL?=
 =?utf-8?B?MGFPL1hLZU52ZlhTam54UjREK053UFYyOGZuMmdwRGFDRFp5VHl0ZUw4UEtj?=
 =?utf-8?B?aTgxUjNvMUNsYmNXN3g3dEpvQXFhcXdCVFpyWVpZd3JveGdXV2lYc2R4MCtu?=
 =?utf-8?B?U1pKRE5SVExvYmRSSjZ2QlhNOE0yaWlyZHBSQ1JCa0JvT2c4cmQrWDNGTG9M?=
 =?utf-8?B?WjVHc3M3WDcrZVZYOWE3SnU1MjhRRGdvcW5wQkJNVCtFQmVPMkxMSHp0VWpL?=
 =?utf-8?B?V2YyWFBnRFZWcldvVUxOSFR1SlFvNUZpeHNkQzBnM05pMnZlSWxZd1JnMlA4?=
 =?utf-8?B?U2twa2JBWEtKTzNUd0hvRkpjYmFZRlBSWFNmc3NmQjVGbkZCNGFpQWdXZ0Jh?=
 =?utf-8?B?RXJJck42Y2pHL0IxRElQcWFLYTFjNk9hbzFPa3hYNG42YkVhcUhGRjdvd3R1?=
 =?utf-8?B?d2JlQWt1aW9NejZXa2RqS0dGUU94alBLMXVxYUgzZCtZWXQzNjVQcURtSkRL?=
 =?utf-8?B?cDRZZlduQVVlTFdtT251YjNUL0kxRkpYSDc4THM1MXNqNmwwNS9IK0tld3N6?=
 =?utf-8?B?dUZ2OTQrc0NvQVQ4Y1ZOOGlhaXpGREdncW1QRDVSK25WOFI4OU1CdUR5djU0?=
 =?utf-8?B?MnpOdUs4Y0RQbXkzQW4vRGQrYmpxbkdTM0I0ZWlrQmV5T3hpUXJhT21sZVB0?=
 =?utf-8?B?SEd6ZnRHZGV4QkhpUHQrMTBKZG9Pa2I5ZmRpQ3NDUmJVbHB1MU9EY0kybTVI?=
 =?utf-8?B?MXd2bmNUVGZWb1JrRmtLd1N4L29lbXo0cm9hQTRDUnh5bGlmZ2NBL0dSWnpP?=
 =?utf-8?B?T0d4NzRvN25xQS9IN2RCUXVkSWV3ZzNVSXNwRFUvTUhXNXg1UkV6OTBxZWRh?=
 =?utf-8?B?cEx6SGxNaGlTZTVrdnN5eENseGxuWUtjYkw4Z1ZhUWhzeE9mdzkzTFdnMTRu?=
 =?utf-8?B?a1JhUldYUWhoOGQ2L2dGc29ObFVLbUZyL1A2VGV0M25MK3NXZWw1MXNpYTRD?=
 =?utf-8?B?ZjJRaFV5TEp1VE5VeXN1M1F4LzZtdkE3d1hveisveXNoeDNPRnRQM2l4RFlH?=
 =?utf-8?B?c3JIR3hDTFFZbGw0MW9XTTdJWGZ0RFR0SEo1NHZwVWl5MDdYRjlmS1hlSzhH?=
 =?utf-8?B?eHdwclJOR29YdTJIMkFRSXB6ZmlLVXpNK2E2bFBHUlQ0Um5McVlMYUZ4Qmgv?=
 =?utf-8?B?VUZqeHlKUU1TVm5vUXJ4MzZac2xlNUZKQnRWWkYzUnNDWVA1enp3Vy9HSk9m?=
 =?utf-8?B?eDdIc21XSTY3QVBuamIweno4dldDWjAzVU9BbmxQRXJjaXptM3hVMU56TVFi?=
 =?utf-8?B?TmVwMGF6VzZQZEFmc2d3S1dvRUJ4VGQrOTFaN2ZuRHc1QVZQNWt5dXpNcFZW?=
 =?utf-8?B?Njl3Y2ZlZ21PRmI5em40VDFBZjBmenBIZi9kYVdmZWZSQTgzSGFpd1VYZVNH?=
 =?utf-8?B?WVJlOUJpR2ptcnFKTHRyakxDYlBSM0plQ1o3SFl0V2RsUTkrN1VNb0xwWmZM?=
 =?utf-8?B?S2FMYmZlYmo5dCswMVczVkd0YUIwSldTTUhyNlFGVHlQcmJXMWkzVjZKTWdU?=
 =?utf-8?B?enBQNElqWmpDZzkxY0tld2s4QlY4aGY4d01lTFlvMU9OY21CWFpkc2tMbzlT?=
 =?utf-8?B?R0EwN1c4eElpMkM1dGJjd0FDYkpEWVN3b2dDNzNBeEl3bDdoZkRXbXNwT3ly?=
 =?utf-8?B?c2xHazN5ejhQTXNsbG1SeW1EQWtwb3VsNkxMR2cyM24zMjRtRVVobTFJdWh6?=
 =?utf-8?B?VlFUY3VTRzBtaUNHWExYUlc1bUZiYVU5VGtOcVpWdFpqcURRampXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d2e2e9-0de1-421c-d9a8-08de8c164f38
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 15:34:18.1380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1I48dZ/nYEZ6C9/pW8/ThYnknvGhzil16gOZkr1EYbeHoLVGh3HwRTlaGdu4eO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

please pull these patches to your next branch.

Thanks,
Michal

The following changes since commit eb00c710508d09b2a3b9aca75dd18280f1304703:

   Merge patch series "bootm: Clean up arch-specific, pre-OS clean-up" 
(2026-03-18 18:36:50 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.07-rc1-v2

for you to fetch changes up to fcc50761f3d0518c4d1693f75d2e79ad7b108355:

   cpu: microblaze: Fix unmet direct dependencies for XILINX_MICROBLAZE0_PVR 
(2026-03-27 14:49:32 +0100)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.07-rc1 v2

Kconfig:
- Correct XILINX_TIMER entry
- Rework TARGET_MICROBLAZE_GENERIC
- Fix CPU_MICROBLAZE PVR logic
- Remove non existing SPL_BINMAN_FDT

i2c:
- Wire pca9848 support

spi/cadence-qspi:
- Disable DAC mode
- Do reset pulse

net/gem:
- Disable broadcast packets
- Clear TXSR transfer complete
- Add support for dma-coherent

versal2:
- Enable GIC600 support
- Fix UFS distro boot wiring

----------------------------------------------------------------
Heinrich Schuchardt (1):
       board/BuR/zynq: don't select non-existent SPL_BINMAN_FDT

Michal Simek (5):
       i2c: muxes: pca954x: Add support for pca9848
       xilinx: Enable GPIO delay driver on Versal platforms
       net: zynq_gem: Disable broadcast packets
       net: zynq_gem: Add support for dma-coherent flag
       cpu: microblaze: Fix unmet direct dependencies for XILINX_MICROBLAZE0_PVR

Padmarao Begari (4):
       arm64: versal2: Enable GIC600 support
       spi: cadence_qspi: pulse controller reset at probe
       net: zynq_gem: clear TXSR transfer complete
       arm64: versal2: Fix UFS boot command sequence

Tom Rini (2):
       timer: Correct Kconfig entry for XILINX_TIMER
       microblaze: Rework TARGET_MICROBLAZE_GENERIC implementation

Venkatesh Yadav Abbarapu (1):
       spi: cadence_qspi: Disable the DAC mode in indirect read

  arch/arm/mach-versal2/Kconfig        |  3 ++
  arch/microblaze/Kconfig              | 10 ++----
  board/BuR/zynq/Kconfig               |  1 -
  configs/amd_versal2_virt_defconfig   |  1 +
  configs/xilinx_versal_virt_defconfig |  1 +
  drivers/cpu/Kconfig                  |  3 +-
  drivers/i2c/muxes/pca954x.c          |  6 ++++
  drivers/net/zynq_gem.c               | 34 ++++++++++++++------
  drivers/spi/cadence_ospi_versal.c    |  7 ++++
  drivers/spi/cadence_qspi.c           | 20 ++++++++++--
  drivers/timer/Kconfig                |  2 +-
  include/configs/amd_versal2.h        |  3 +-
  12 files changed, 68 insertions(+), 23 deletions(-)
