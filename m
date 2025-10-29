Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C1FCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 08:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22A7800D7;
	Wed, 29 Oct 2025 09:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NFRVI73F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D46A80422; Wed, 29 Oct 2025 09:58:40 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d906::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0578003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 09:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcs2kRgbb2fw6roeZ7iR6NAHpEqYV3LHce64clFBh/W6BLsSHHopKsbamnfhxcJ0owXofnvLL9BejNhRdjR8bIiIPh8v/Igj+rOFNZOgTrRLHJXLD32nRxrLFyXtranFXcsMEC5TaxQE2VIYmAFbPuevHKEqsc3tHoKgkNUUDgUFvQew+R9IN/G8Y0RaBvF6+PSiVo19UeDSrXR4lsK9ug36sSkVoG4669/LwjrXECT7aK9rOl/AnJyF/ETXJSkIKDUa4eXG/e0iljprLTcz/7oZSUlZEyRCbgTJA2O3mHzMy1dE3fU6I84pVZeXhMK8h9FTvLZfOMPwTzxtX7jxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMm2pH8LeNkjZ3l6MUZKiDP5Y722b4IPTYgFzikVTC8=;
 b=cUOTPRGeOX/Joc7AMYiZccmPznVxs7N35e75Y7sY7b/onxD3G5t5f0BJV/EQXkepOp0w+aK7yEhmjC9Xu2eE/YF7d4MRbIJOvkCAHVCfySBPnMH+0SngDEzonRhDGE8ihL35us+8C7sCW9UGK7mHCQ673As24YJqrq8841YRH2mCSxlb39q4NXeE0jO48lrUqyCY9GGupIS3ULklcpipX7Bso48rpuQxGR+X/GnQffcZu5mtyp0V21heinP6mfccy8yAQ+g2RuA0v6o1/Ey7c4pyxtwQKe4omQkwsV0FkSUjuIgo5Iez3aiSyVLRaGspRW1wx4GRxT3eIJh+SrLDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmx.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMm2pH8LeNkjZ3l6MUZKiDP5Y722b4IPTYgFzikVTC8=;
 b=NFRVI73F248tME3cwznkZdPUDx6482/nfjGrAeuNfuQAZp0Hv9Tfxi1CNrVBWld3/Ne3g5hcgFZpiq/ooBBPZyr0TiQQgGZCkftG4/MMKPwu/+5L5cos2sTeyOWloRWPre+cxfuRJN8foGKbD1QOvwJHbcTmbjbkPbu15MSJOIs=
Received: from DM6PR06CA0059.namprd06.prod.outlook.com (2603:10b6:5:54::36) by
 CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 08:58:34 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::40) by DM6PR06CA0059.outlook.office365.com
 (2603:10b6:5:54::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:58:32 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:58:29 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:58:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:58:29 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T8wSpS3769773;
 Wed, 29 Oct 2025 03:58:29 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Oct 2025 14:28:27 +0530
Message-ID: <DDUOKBSB2Q29.17CMLWGWUOD48@ti.com>
Subject: Re: [REGRESSION] Re: [PATCH v11 00/11] Add support for dynamic MMU
 configuration
From: Anshul Dalal <anshuld@ti.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Anshul Dalal
 <anshuld@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
 <trini@konsulko.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251017131540.3636067-1-anshuld@ti.com>
 <20251027165225.GA71553@francesco-nb> <DDTOEZHOH4OK.1ZQ850D6UHD0Z@ti.com>
 <7401dee0-7ac6-4280-a934-0881dfbb1b6c@gmail.com>
In-Reply-To: <7401dee0-7ac6-4280-a934-0881dfbb1b6c@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc5bd93-c90b-4afc-323e-08de16c9566c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWFFb05SR1pSSDNMOTRHbE5WWHJ0dGZpRlE0bGt1MXQ1cWlXamtRTmFlSG15?=
 =?utf-8?B?YS9rSDJCWWZ5b3h1VG43bllsS201TjVDby9XQ2Erd1hDejFMOFg5OFdreGpv?=
 =?utf-8?B?UmZJN3o4eWszTXp1andHYU4zWUphOHdOT0NoanVFMXYyYktvRzdRbGFHUnJ0?=
 =?utf-8?B?VWFNck5OcjhPNm1Qb3IwamY1WWR0QUg3Uk96WnFTaVdJYzZ1aFlDRGpSVFRE?=
 =?utf-8?B?MEhlYzFwVUZFOHN6Rk12UWdLaXgyMmVGTkFrMVNaRlI1Rys3b21FSWF1Si91?=
 =?utf-8?B?Mm1DaHBMWHhjQkUwalMvcjZrQXRKbVk1Y3dIeE9lYWozakl6UDJMeWRHNTJw?=
 =?utf-8?B?cW1qU0lpNndibmlMb2wydHRuTW5XUHhOTHYxSGJoNTdpVEtIT1JRa1llTitk?=
 =?utf-8?B?b2pZRlFOS0NQcEEyT1gxdjV6c2lrL0UxYXhObkJKaTlteVpFeXNSUW9CRUFt?=
 =?utf-8?B?YkgvRG9OUjB4bzZHYWgydXVNVm1kU1NXTUthZWF5dVVwK2ZOMTJRUTB5TGRt?=
 =?utf-8?B?eWJvZzBTOWhkUHhnNzV1bFBlSkhqT2U2b3FZeDRNTm56TDhlT1o3VEVYZUcw?=
 =?utf-8?B?elplaHZQa2ZoS2VaQ2pMUDZsc0c1clhUUEYyNEUrRmhJazZGV0VweUxtcVE4?=
 =?utf-8?B?UnRpQ0c4NnBtZlVDR2tCQTdQQXZVOWNuRlp2REt4OVN3NyswMUdXWDJqeXlP?=
 =?utf-8?B?YnBUbG1ZL2R2ckp2ZENLTGRSMmJ2Qld6T2haNlo1d1dNUU1TMWpFSGxSa1E4?=
 =?utf-8?B?R2lDQW9QTUZiSUFsamMwNVVEaUpoNHk3ZlNxbS9NcTlxRnU0RVl1VUhLMFhW?=
 =?utf-8?B?aWMzdlNpUFNLeFUxSHU0NlpISHRUeHRnN1hRNUJDRnovUWxBN0JyUEJwc3F0?=
 =?utf-8?B?VkJFaDJqbjRoVjl2eVdrejNIb2cyeVVncE16blp1VnNIUVJmSFJnekdzbGty?=
 =?utf-8?B?ZzRiMU9oRVpPME80S09YMHVUT1I3ekU1dHRRL1NvckE2RHh6NHlzYk9yOUtE?=
 =?utf-8?B?aUNzSWs5eDA5YTN5Z2ZOM0FoZStjaDdsRUJNZTNoUUkzSXk4WWZlMXU1TXNn?=
 =?utf-8?B?RUV5b3A4S0Vpc3BFc2RBQUxBU1N5MHl5SlNzOTh0UmRzSERBRGtadDB2L2xp?=
 =?utf-8?B?SFE1Z0hSY2dGaXpndC9zQXhjUnlIZUVOa3RjNEUwcXQ2Q25jSXJORU5ReTh6?=
 =?utf-8?B?VzBKTTkzcnVTcHo1bzJqbzFxdVhXM08vWTNDQUh5RTRkUjQ4WTUrK2ZYSE5O?=
 =?utf-8?B?ZXVRMVNWSjhQVzRwSllwODR2Y3VQcXQrbkpmbGNhWGZwN2kzZExqZTdZdVVy?=
 =?utf-8?B?M2p3dW5scGt3azlCbnVRZGF2S0NRVEQ4T3RPOVJLMmtmN2xxY0RYa1cwckxX?=
 =?utf-8?B?bWZidFZtQjhrSHQzMG8yMjEyUlB6bWxSVzQ4aUF2N2hPZkNjK24rVDY0WEg0?=
 =?utf-8?B?dEtRV1U4TnBBaWhVUVdxeVBUKytZaGRDUFpwb293Vm5mUmk0ZUNTUkt0NjlU?=
 =?utf-8?B?YWc1a3dDZGhDL1AybkpPSXhVNzh5TmFPMDZiT1hZbmpYUmh2QnNPWVhZajVr?=
 =?utf-8?B?M1R5VktlSXZFV2JjbGdxR0UwN1JuWHBFejdSTFBTQVRCelRoRnpGL0Fmc2Nn?=
 =?utf-8?B?Z0FXQVRTRlVyOEUzMEV4dm45MkpOQW1XanRpU2lEUmdNM25FWDk1TUZ1K3o5?=
 =?utf-8?B?dWMyQ2Nac3ErUkcxaC85TDJaUkRqKzlKemIwQUN0dlV3dkxqMW10djBQM3R3?=
 =?utf-8?B?cTlmRjA4Yzc2alFSLzhiSEN0MFkxVVY2cVVkbllQM09QN21VWG5HWTJRNzlN?=
 =?utf-8?B?SHlBVHl6enQva0NZVnZEeGJjdVJFdTBHZ2lUeXRjeVhwdzZBWTFkNnNYRHZj?=
 =?utf-8?B?eUFRcmh5aXQyc3FOekNxOGpSZkVsQUhSN3dpcnVBVXptdm1BN0Y3ZFEreXNo?=
 =?utf-8?B?NTFGMjI5bFdaYVpOWUlHTW5yMWlXM0l2clpnR3hlNWQvYkh4K2hsUW9BNHFJ?=
 =?utf-8?B?aUNXL1BIVFUyaTVGeUxMdGQ1WGhjakhxcjVlYUFDeUVQaVBCUWg2djFPcXRK?=
 =?utf-8?B?YWp4NmJwTmw1SnlSQzQzTG9BaENSZjRLMTUvYmk5clljVW9HNERURHFibzFT?=
 =?utf-8?Q?CIj8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(34020700016)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:58:32.6508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc5bd93-c90b-4afc-323e-08de16c9566c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
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

On Tue Oct 28, 2025 at 10:26 PM IST, Emanuele Ghidoli wrote:
> On 28/10/2025 05:38, Anshul Dalal wrote:
>> Hi Francesco,
>>=20
>> On Mon Oct 27, 2025 at 10:22 PM IST, Francesco Dolcini wrote:
>>> Hello Anshul,
>>>
>>> On Fri, Oct 17, 2025 at 06:45:22PM +0530, Anshul Dalal wrote:
>>>> Hi all,
>>>>
>>>> In U-Boot, TI only provides a single memory map for all k3 platforms, =
this
>>>> does not scale for devices where atf and optee lie outside the range 0=
x80000000
>>>> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
>>>>
>>>> There are also issues for devices with < 2GiB of memory (eg am62SiP wi=
th 512MiB
>>>> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2G=
iB in the
>>>> current memory map. Furthermore the second DRAM bank is mapped even fo=
r devices
>>>> that only have a single bank.
>>>>
>>>> Therefore this patch set adds the required functionality to create the=
 MMU table
>>>> at runtime based on the device-tree.
>>>>
>>>> The patch set has been build tested on all effected platforms but boot=
-tested
>>>> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platfor=
ms.
>>>>
>>>> The following effected boards have not been boot tested:
>>>>  - verdin-am62
>>>
>>> it seems that this series introduce a regression on verdin-am62, I have
>>> not done a bi-sect yet, but we run daily build of U-Boot master and the
>>> regressions seems to have started when this patch series was
>>> merged.
>>>
>>> On verdin-am62 we detect the RAM size at run-time, see
>>> board/toradex/verdin-am62/verdin-am62.c:dram_init(), and now we always
>>> get 2GiB even for modules with only 512MB or 1024MB of memory.
>>>
>>=20
>> This patch series modified the behavior of enable_caches to configure th=
e
>> memory map of the device as per the device-tree instead of using a
>> static map for all of K3.
>>=20
>> The issue with verdin-am62 seems to be that while you do properly
>> configure gd->ram_size in your dram_init, the '/memory' node of the
>> device-tree remains unchanged with the outdated 2GiB size.
>>=20
>> You could try updating the fdt's memory size to the correct value in
>> dram_init and see if that fixes the problem.
>>=20
>> Regards,
>> Anshul
> Hello Anshul,
>
> I was bisecting the series, and I can confirm that the commit "mach-k3: m=
ap
> all banks using mem_map_from_dram_banks" introduces the regression.
>
> Given that initcall_run_f() calls dram_init_banksize(), and after relocat=
ion
> board_init_r() calls enable_caches() (call stack: board_init_r() ->
> initcall_run_r() -> initr_caches() -> enable_caches()), I would expect th=
at
> enable_caches() should not override the bank sizes previously configured.
> Currently, however, enable_caches() introduces this side effect.
>
> Wouldn=E2=80=99t it make more sense to call fdtdec_setup_memory_banksize(=
) in the
> default dram_init_banksize() (in arch/arm/mach-k3/k3-ddr.c) and avoid cal=
ling
> it again in mem_map_from_dram_banks()?
>

We could follow that order too but that would makes a call to
mem_map_from_dram_banks dependent on gd->bd->di_dram being correctly
populated. I had assumed whoever calls mem_map_from_dram_banks had made
sure to properly fixup the memory node of the fdt.

Given that it seems like the root cause of the problem is with the
U-Boot's device-tree not having the correct memory node, we could add a
call to fixup_memory_node (arch/arm/mach-k3/k3-ddr.c) from A53 SPL to
ensure the memory can be queried stright from the device-tree once we do
get to U-Boot proper.

	--- a/board/toradex/verdin-am62/verdin-am62.c
	+++ b/board/toradex/verdin-am62/verdin-am62.c
	@@ -46,6 +46,13 @@ int dram_init_banksize(void)
		return ret;
	 }

	+#ifdef CONFIG_XPL_BUILD
	+void spl_perform_board_fiups(struct spl_image_info *spl_image)
	+{
	+       fixup_memory_node(spl_image);
	+}
	+#endif
	+
	 /*
	  * Avoid relocated U-Boot clash with Linux reserved-memory on 512 MB SoM
	  */


If you could get to U-Boot prompt with the above diff, could you
share the output of the 'meminfo' command with the following configs
added:
	CONFIG_CMD_MEMINFO=3Dy
	CONFIG_CMD_MEMINFO_MAP=3Dy

Though so far, I have been unsuccessful in my attempts to reproduce a
boot failure on our own 512MiB platforms (AM62x SiP). Could you share
the boot logs with '#define DEBUG' in common/board_r.c, common/board_f.c
and mach-k3/common.c to help further narrow down the issue.

Regards,
Anshul
