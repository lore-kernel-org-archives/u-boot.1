Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0938CCCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ECE2836D1;
	Thu, 30 Oct 2025 13:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jXtp60vB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75995836D3; Thu, 30 Oct 2025 13:37:10 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D098331F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8dYAaJ5PPekQSYXLBsJnB06QZhu2i3BdyF4sU54s8EF8MyNop5+orIRCWkHKc8GhOrWiracJPbHJ14ynTiQzUZVyG5Fy5vUDrLCSK5ZqoDBycUwB7xuIkumuKLQb7s0IJz0M3ixeVozQXG/iyjsJRraYdRzcr1Amhu9KHwkrJca3iNYXyw46ISD2rBW4zBDt7O9Ev8nCbqWztIAD1lOAYMDwx/4kZ9eu4iOL9qRtXUXH3AJywAf8TrzKAyqBmJ+2szvfL6LLDcIswfFCNjapKXN8n4PYhmwOXSq20XTnJlYItDAZVAc5+QSxKPcByshDeza+EuNsmdQZLOeIjZ1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYQiV0+uUAZsojuWy4+o0XLH25kRYufNqgdBn0rqu2Q=;
 b=hmL+/IivELZGLZhfurYurimcktrZcKawNSQOlpOz0v7NB7UEVlpQJHoqVfKdJKMKBp1xy3iJ+2tuJ+VUQ/XcM6RBUcWl5DOlT25GFFaxL9RRDLGUBY2XC8+YUQePCL3wrtIw0I4I9LpLyVR8cBso7axUn6qbusq+G8j5H1i1Nzn+Q5Doed7lHeZ4bm9yddBf2hED9y2+n+0Pjojbfv4H0vfRuFny3NFzoVMjWwWGweKmyBpx5xIsPPDIh0S9ndPGDKGBrRsCCGeKWWjK2+WDR4eQPOXjdDsvkh7XoaqjzjeqHcqBsJjLpwjDKkV0e2dhigddKm7pcwyePfad7ILbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYQiV0+uUAZsojuWy4+o0XLH25kRYufNqgdBn0rqu2Q=;
 b=jXtp60vBqyDOUqC3LDeSSdPKSj+XxNIEllXpZY5TR9wB2Aw8XYb45yeBu7xVAptgxrvsJZOmSn3cc4Uk7AFQlRU2zpEsw8e505lSCIozkOhDGcO/ZEg81pfjDRYAo6Ogv23VYUVVy04fxGSsulfcQkaCk13wsa7zx4nomDG/FPc=
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by IA1PR10MB7263.namprd10.prod.outlook.com (2603:10b6:208:3f5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 12:37:03 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::fd) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 12:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 12:37:01 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 07:36:54 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 07:36:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 07:36:54 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UCasqC2197725;
 Thu, 30 Oct 2025 07:36:54 -0500
Date: Thu, 30 Oct 2025 07:36:54 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, 
 Etienne Carriere <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>, <kamlesh@ti.com>, <d-gole@ti.com>
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
Message-ID: <20251030123654.zp2abxrfdgex3rq2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <68e5af37-1511-4720-9172-751d5b788c39@mailbox.org>
 <2a3421c8-b7af-4c6e-91c5-cbd08c9f3dd5@mailbox.org>
 <DDUP3J37VKJU.3G90BDVOTBJSI@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DDUP3J37VKJU.3G90BDVOTBJSI@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA1PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 92097fa8-3248-48eb-99c8-08de17b1064a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|7416014|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTFyalNnK0p0QnNuWkI0TjZuczduQld2V1RodElEZ2tud0EwOVV4dXd6Y0dL?=
 =?utf-8?B?ZVNqZjJKTGJDaGMyUnk1ZE43d0krLzc3M0xvT2pEbzJoUXlJZXo0Y3M3NGVN?=
 =?utf-8?B?MTdSZzJOTzB6NGhJdEgwYUcxUWFLMnR6UXNZSFJBU0tuZXJ3RUZsQmF6TE5Y?=
 =?utf-8?B?anhSb3JrVllFSTJkV1dBaU5FanRRT2QxVHFON3h2RGdxOVhIMDBHOE54RzY1?=
 =?utf-8?B?VDRYWG5JQ1BiMmlZUjVkYWVqRXhxclNZTnZZTVFsdlZGN0FjOEVDdDBRcFEz?=
 =?utf-8?B?NEFmckRHai9RdVk3N1RFdDlGOHhVenRQZ0Y5a21yKzI5TkNIUzRkZVlvR2lX?=
 =?utf-8?B?Z0VrUUM3SitOR0lRWFlUODZnUkIwS3o5OVp6OG9MYi9WUFUxazFKS3hwM1R4?=
 =?utf-8?B?dHJwNGdmejlBckZlMkc3M3BsL2RoVjFIbU5IeTVLcmllZW9hQis2ZHhreFRH?=
 =?utf-8?B?TnpuSHU3M1lXeUpTNDFjVWU3VG05ZlUyelc5TUE1cEo0RXAxYXVPS1I1MWJY?=
 =?utf-8?B?WlVEOHlLd2ZEZEZ3S2dqaW03TWpVbFd3Zy83cWlSdlo5WE1TZXkvWDBoaHRL?=
 =?utf-8?B?VXFZT3FXUVc0c1dTRExaWkxKejVWcHVtZERBcWpjQ2h0U21qMCsxYng2ZXds?=
 =?utf-8?B?R1BlOGhDcVdUZERrMnREV1hCLzRvYUsxYzdzdW81ZXJoeU1GZUxTQzBQaGZY?=
 =?utf-8?B?ZW1sdzR1cUhmeklucFBkV1NuK1lvSHdCMkV0SGNYV1dTWGtadnhWRk1zWG4r?=
 =?utf-8?B?MGVHL0xGM0lORzZnUElwOFgyaHc0dE9yOEVOZ2MvUCs1a0J4RkdiazRiNUVP?=
 =?utf-8?B?cUUzdWZyemVMVzk2T1BrZk1ZRXRHU3ZqUDBuOHVEMUlkKzc0WTYzdlQ4V1Bk?=
 =?utf-8?B?Ti9EU0MzaUpOZ0p2cFhZczB1OUE1bkRQQnZqeTVEcEJaSVIvdGl6MVJuWTJ6?=
 =?utf-8?B?cytqL3lWVHVGbDhIdUNRQWJKQzZ5QjgyWU5xMXg4NnhsYW9tZklpbGErWjdl?=
 =?utf-8?B?Umx2SVRhVUUxSzN5a21HTjZGNTJBYnZpNndlVHBuZkJZZStLZGxTSnA4bEho?=
 =?utf-8?B?NzBNTmhDMmdZWjF2L0lLTDE3YmxGOWlUOG9TNEdRYkI3VVFQaWhIMjZZY0Fz?=
 =?utf-8?B?cXB4cmVjc1RvUmtnVmxzdnNpQ0s3dnlaUWtVbWIrQ2FJZ2dtRWt4ZVBSWGdm?=
 =?utf-8?B?UmdyMTQvZVdvanIrcitGQ0RFazNDOU11VTVaM0hlN0dUV3pabHI2dis5NWtJ?=
 =?utf-8?B?U0M1a0NidUF2dWZiVmgxNnBLN1R4bjMvd1EwWWh1U0NsMTBOd0RGMUp4Vy9X?=
 =?utf-8?B?NGxMV0QrUmRINDBxeG14MVRHR3BjVTVPMnhRUytYSElPM05YZnM4Z0lmNmpo?=
 =?utf-8?B?bkRpWGpBcWgxMlNIelg0d09qbTNjWGs3aWFiTVJvaElmZEtZUlJNeHQzbFhP?=
 =?utf-8?B?Y1dPUlJpejdWcFh6K0JBcHg4WjFtVllxaTdzNjlrK3RJM0Zka0NmdUIxUWpt?=
 =?utf-8?B?S3g2eUVjb0xVdlAza2hDWFA4a0FRSTY1TG1DZWVJc3Nzc3VtZEYzaUJobzZM?=
 =?utf-8?B?NkV4R3kwK0lMRWwwcExFNFJMb0hUaGQzYzh4U1BCN2hhSnhnM1NZZkNEbllS?=
 =?utf-8?B?a2dhUTZqOWJlVkN4SkhWRDU0cUtiY0wvWUNKSE9VczRROGNsd0xqQ2ZwaDlE?=
 =?utf-8?B?QzBrTHg2NFZyZ1hEbVl1WkFPZVp2L1R4REU5dlFZblZJU3d1eUhPb2M5WlFE?=
 =?utf-8?B?MlkvZHd5cW80QUJ1c3c3Y2QzZkVFbTBoQzhnUFBOZkgrQnBIdTdwSC9nVkZV?=
 =?utf-8?B?eTJDc09kbTR1dTVmcjNENDA2TEUreFVZc2NjQk9uVVdwK29IcU9PeURYSUtE?=
 =?utf-8?B?MVZFSVl1SUxXMG9UQllXSDJXd0trZU0zd3dBMm02VDBLSEdjODNpZ1VycjBP?=
 =?utf-8?B?Zlg5Vy9XV2FRUmh5Z1FUSloyOXhrY3kzVkZhcGl0YnNxTkdVdHRrakd2aGgz?=
 =?utf-8?B?N1hOSml3cWFEd2xBdEtObzBtR1hKWmtTbzgvZFlYSmVnUTVIVWdZWnBEQXlM?=
 =?utf-8?B?VjFUa3dCWW5aMlQ3Yi81Q3hyUXNVeWIrVHU4OXNqYmJyN2Nudm95alR0d1dY?=
 =?utf-8?Q?zUAQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(7416014)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 12:37:01.4081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92097fa8-3248-48eb-99c8-08de17b1064a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7263
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

On October 29, 2025 thus sayeth Anshul Dalal:
> On Tue Oct 28, 2025 at 8:46 PM IST, Marek Vasut wrote:
> > On 10/28/25 3:37 PM, Marek Vasut wrote:
> >> On 10/28/25 9:25 AM, Peng Fan wrote:
> >> 
> >> Hello Peng,
> >> 
> >>>> Subject: [PATCH] firmware: scmi: Drop
> >>>> mmu_set_region_dcache_behaviour() misuse
> >>>>
> >>>> MMU region cache behavior configuration for SCMI/SMT mailboxes is
> >>>> platform specific. Even on ARM systems, the mailbox memory may not
> >>>> even be located in any cacheable MMU region and may instead reside
> >>>> in some SRAM. Remove this non-generic cache behavior configuration
> >>>> code from generic code path.
> >>>>
> >>>> It is unlikely that any platform is affected by this change if it did
> >>>> configure its MMU regions correctly on start up. Platforms which might
> >>>> be affected are i.MX94/95 and STM32MP.
> >>>>
> >>>
> >>> If the memory is mapped before running SCMI stuff, it is ok.
> >>> But if memory is dynamic mapped at run time, there might be issue.
> >> 
> >> I wonder ... should ARM/ARM64 define CONFIG_HAVE_ARCH_IOREMAP and 
> >> implement actual ioremap() function which changes these cacheable 
> >> properties accordingly ?
> >> 
> >>> I saw TI platforms has some changes to use dynamic mappings,
> >>> I have not read the details, TBH.
> >> 
> >> Can we put the TI people on CC here ?
> >
> > +CC Anshul
> 
> This change shouldn't affect any current TI platforms since we don't
> make use of SCMI on K3 devices.
> 
> I'll CC folks working on upcoming devices in case they have any
> thoughts.
> 
> +CC Dhruva, Bryan, Kamlesh

It's my expectation is the shared buffer would always be in some 
internal SRAM which shouldn't need to be mapped. Not only does it keep 
the buffer secure on platforms that care about that but it also speeds 
up the access latencies between the different binaries.

IMHO it makes sense to rip this out and let the few architectures that 
need to do some MMU maintenance do it themselves.

~Bryan
