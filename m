Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E7DCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 11:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEC5838C7;
	Fri, 31 Oct 2025 12:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tCLnTkt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4905B838CC; Fri, 31 Oct 2025 12:43:34 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 653098331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDaIyo1RAsUYe0yr1PN7RFfXGgZfmaxaj5ZC06vo1O/Fa25TgWuaB3Ju9qg+qBChxopUmINZTISD+BtcQ3xKmCRYf/cpo+NZ7atgtHbJb5XhzkYb5ZQL4YARY+Djkccmt9Kd7YZAOqaTGIdCPEIB5fCj1OZAatHWLhASelyswC1vgqPIvZ9k+rwlMYbDoCDXpYkKrVJXzhnS1RAIBC6rxrJozIUtJv+7+uIo1qqr1/FUwQtBvrvp96higXOYoo6vvdOkjkeWRUrtv29wcke+JDMmAU/Xia5bjIoDREEY9iSs/KstIbDQ9dxMQJ6FBuJ8CwoWHYeR4jMD4g629Y9ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RQpnmoeG7dak2UG7qVmXIgouQ75AeyETNpBoknLokU=;
 b=qxZxt48r2RaidhcngPI1uMhpP5PTeywzd6EviG8U6MwKgt+R7UT2LfeTJvpDCKG+7bwQJCPqAqTA82hCxtnwJn+EdxwsRrJGEKB16LIMdR6Pb+sNpuOztO/XBYg/oeLAbPu5ntGOQVynEyqQo1pKsQUttSTq4d0EXGVjgofta6TNdQKgR7twgzDl4mEZwL+rfstGsD8aNOlJr6BOAWbfa5vfcCzJHrg2ydQtCxUZ3He2BoDzEJqEj50Hd/2yKdkcoxWdHNxjcYqdB3nHC/ZFm1GxCW4Mpbunn1ycaKhwoneQE55RfJRXH53FmozNqDuWacPlI9e+QGWAce97RsU0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmx.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RQpnmoeG7dak2UG7qVmXIgouQ75AeyETNpBoknLokU=;
 b=tCLnTkt9tG6IgoqpYiAwKyfYbxG7Om4x35zfj7CkOHXJ/E/2A+6qVhHtU6ErbanAJAuJOorv8hmWFqftYSPe/dqR5jOQj/w4nsxQlYZdHq82SxPaaW8ZE5jghXJM/VTbF3Hp8Rj+pNOS1RevW1i9v78N/9paQicohDGqCWTMwLQ=
Received: from MW4PR03CA0236.namprd03.prod.outlook.com (2603:10b6:303:b9::31)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:43:27 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::f2) by MW4PR03CA0236.outlook.office365.com
 (2603:10b6:303:b9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Fri,
 31 Oct 2025 11:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:43:26 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 06:43:23 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 06:43:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 06:43:23 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VBhLhR3847795;
 Fri, 31 Oct 2025 06:43:22 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 31 Oct 2025 17:13:21 +0530
Message-ID: <DDWHBO3NYVG1.2GFO0LYSSGZYF@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
Subject: Re: [REGRESSION] Re: [PATCH v11 00/11] Add support for dynamic MMU
 configuration
From: Anshul Dalal <anshuld@ti.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Anshul Dalal
 <anshuld@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
 <trini@konsulko.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251017131540.3636067-1-anshuld@ti.com>
 <20251027165225.GA71553@francesco-nb> <DDTOEZHOH4OK.1ZQ850D6UHD0Z@ti.com>
 <7401dee0-7ac6-4280-a934-0881dfbb1b6c@gmail.com>
 <DDUOKBSB2Q29.17CMLWGWUOD48@ti.com>
 <071bbf2d-0cbd-4359-abfa-b020b5d32ef5@gmail.com>
In-Reply-To: <071bbf2d-0cbd-4359-abfa-b020b5d32ef5@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|BN0PR10MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f4d966-cf87-400d-7f6b-08de1872b48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|34020700016|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEVsY2RmVGVMTnNjTEdMeDloUFBoRDVVVmZDV1g4MDRzWGk0UHBaY0NCbXVJ?=
 =?utf-8?B?WnplZGcwSVFUQi9QRGE1cGhKZ1JKUUNibTZ5U2I4VVptMmNmNmF2aHlXUW9Q?=
 =?utf-8?B?SFhzZnVObEtLLzlvMEw1Z2hWV21RakxRbDJXTExNenJSMnRzTjQ2bkhYb09K?=
 =?utf-8?B?VEV1azVMbityaitkVS9RVm0wZWFmNUlQQVU4a1VnYmhmdjkvWmV3dys0NUYv?=
 =?utf-8?B?OFBUNkRmZTVsbG9FV2xySTJCT3F4cGZocG0wT2ZadjNxVGxwQWF0SHpJSGJ2?=
 =?utf-8?B?bVpQTzRJbEJBTGg0TjM4QkZ6NENsTlFuRTZ1Mm1UNTlxNGs3Y0ZxS2NlRjZ0?=
 =?utf-8?B?WEl1QVFldWkrekdMZWttdmRlNzVzN0FKWklTYkM2bG9KS2tvUzB1K1lscFVy?=
 =?utf-8?B?d0x0UEFFQm00WnVFK21uZ0JORUljNGlVR0JzbjlQUGZmWDRaR1ZVd29obFFW?=
 =?utf-8?B?ZDBZQTBaZno3c2kvNkRCdEtOQ0szd3V0WXZ2VitlRGk1NE9NMFV3cGM4L2tY?=
 =?utf-8?B?UFNWYmNoUXVLbDE2UlFDTTNWMjRHTmdrT2V2Rk1LaHZ0S29HemEwbXNMbGdw?=
 =?utf-8?B?ek42OThKRHhyeUVNaHV1dVpvNjdxTVFhOTJXSUJFbFlMZFhDbERsdVRKQUln?=
 =?utf-8?B?UkNWVlNRZzAwSHBFdHFWZHp2UWplTnVxVlFzdm5hbkNYeDBtZkJIcmthaGR3?=
 =?utf-8?B?c2JOa0JtbHJmbVh6U2p2Yyt6VTg2YXpudlg5dFNuU2FOZFNVbWI1VHpKazZG?=
 =?utf-8?B?cHFSQ3FqVHIzaXpFT2lpdFh6UXRMajlPSUovdHF1dVJ0ZGwzUlgvNU50OXJE?=
 =?utf-8?B?YVdUL3c2RWdnY1ROdFU4SXZKZjFkdjY5QlA2a2Mxbk9PSk0vMUZ2emNsK0FK?=
 =?utf-8?B?RDNGY3hOMlBuU2tNYlBWczJVbDRvbVVNWFI3SmhvV2NpRm83WEVlSXViVUpL?=
 =?utf-8?B?QkdUK0cybnlzaDVDUnVLZ3prdDdXdlhkWkdhNm1pUHAzWEdpdGs3UWphak5L?=
 =?utf-8?B?aGNDOG5Ra3Jsbmcvbnh0T05QMWdWWEs2aXlUUEI5bmNZREpLTm0wajJRRzdq?=
 =?utf-8?B?N0VJSkQvL1hEODlVWGd0bUVxa0p4SkdwL016M082YWI5U05BZjQrTFRXVXZn?=
 =?utf-8?B?bTd3VXFuRjJSRHhJMzF2S1NMY2NhcEhoUDFGaEVzU3ZaeVUyM3FFMXB0cVIx?=
 =?utf-8?B?QjBwN2N0L2JNV25rOFd3Ymwva1JZN1ZQRzI2eGdvQS9Md3BoM2FobmZENTlQ?=
 =?utf-8?B?aG94dUViejZ3eHZ0TE0rMkxsamhMbEhhRE1iN3dNRFJvSWgrMkhEODcvZEta?=
 =?utf-8?B?b3Q1VDFNSlJIVWV1UGtOY28yczZUN1BZb3BNc3dtUmowWXk2Y1c0YitkeE5E?=
 =?utf-8?B?Y1J5VDlyZmlxcTRSejNwMXRYQmZ1YTBOcmNDNzhqeSswWGFuekRSQUY4S2Fi?=
 =?utf-8?B?eEk5QjF5TXBXcDE3TU5ZM1gzYSsxdk1ZVXN5eDlvNVFFakRvaHMvcmtGb0tB?=
 =?utf-8?B?QUMvZWJqV2F4SVRDR1ZMQU5LdWlnM1JVQ1U2aVg3OVJwUUVUMFFxL3duQ0ZZ?=
 =?utf-8?B?b3NLZGFSbDdETEc0cDJUTCtGZ01oT0NoZHF0dGFsMk8ybUVTR3J2YzJGeXJQ?=
 =?utf-8?B?bmRQUWxDT1orTlVRRlVYckdvZDdCK0twNXZmVUpQQVQxcXJPd1c0VThFTDd2?=
 =?utf-8?B?d2trc1ZneEdJQ3VTOUo4Tis1WFI5RkdzdXdtUlpMU05FNnNyNHR4emNHa0l6?=
 =?utf-8?B?RzFnYzk4aDFPdDR1NENOODkyWlhuaE5YYzVUREo4NEYyeEFjcGREMGlkZXJW?=
 =?utf-8?B?Z0FTV2dqbnVVeU1WNjlPRVFOM3c5T0c0bzFGWVF0Qkc1QmtSWDVPOWZXci9G?=
 =?utf-8?B?a1BEL0wrZ0RFRjdlYkJqYXRXUW1yMXAwa2hWNGVKbUowRW0zVGRtRWtsQndR?=
 =?utf-8?B?Y1R0SjBXTVpvQS9IL0dxT09CWU9RZlpuRS9UQjhrbzc2OHR2WWVUeXRFMTRu?=
 =?utf-8?B?azdXQzBORUIwaEE2YzdpZ0xTSVpIZGNkU0VZazI0TW9icW1wYXRCZnZ5Y2Ny?=
 =?utf-8?B?ZU5FMzUra2tjN2pKK1NaNENqQjJOTUF2dXhUS0hXZnIyalA0U0tZVzNTZm9m?=
 =?utf-8?Q?XDoc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(34020700016)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:43:26.6466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f4d966-cf87-400d-7f6b-08de1872b48c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
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

On Fri Oct 31, 2025 at 4:30 PM IST, Emanuele Ghidoli wrote:
>
>
> On 29/10/2025 09:58, Anshul Dalal wrote:
>> On Tue Oct 28, 2025 at 10:26 PM IST, Emanuele Ghidoli wrote:
>>> On 28/10/2025 05:38, Anshul Dalal wrote:
>>>> Hi Francesco,
>>>>
>>>> On Mon Oct 27, 2025 at 10:22 PM IST, Francesco Dolcini wrote:
>>>>> Hello Anshul,
>>>>>
>>>>> On Fri, Oct 17, 2025 at 06:45:22PM +0530, Anshul Dalal wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> In U-Boot, TI only provides a single memory map for all k3 platforms=
, this
>>>>>> does not scale for devices where atf and optee lie outside the range=
 0x80000000
>>>>>> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
>>>>>>
>>>>>> There are also issues for devices with < 2GiB of memory (eg am62SiP =
with 512MiB
>>>>>> of RAM) as the maximum size for the first DRAM bank is hardcoded to =
2GiB in the
>>>>>> current memory map. Furthermore the second DRAM bank is mapped even =
for devices
>>>>>> that only have a single bank.
>>>>>>
>>>>>> Therefore this patch set adds the required functionality to create t=
he MMU table
>>>>>> at runtime based on the device-tree.
>>>>>>
>>>>>> The patch set has been build tested on all effected platforms but bo=
ot-tested
>>>>>> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platf=
orms.
>>>>>>
>>>>>> The following effected boards have not been boot tested:
>>>>>>  - verdin-am62
>>>>>
>>>>> it seems that this series introduce a regression on verdin-am62, I ha=
ve
>>>>> not done a bi-sect yet, but we run daily build of U-Boot master and t=
he
>>>>> regressions seems to have started when this patch series was
>>>>> merged.
>>>>>
>>>>> On verdin-am62 we detect the RAM size at run-time, see
>>>>> board/toradex/verdin-am62/verdin-am62.c:dram_init(), and now we alway=
s
>>>>> get 2GiB even for modules with only 512MB or 1024MB of memory.
>>>>>
>>>>
>>>> This patch series modified the behavior of enable_caches to configure =
the
>>>> memory map of the device as per the device-tree instead of using a
>>>> static map for all of K3.
>>>>
>>>> The issue with verdin-am62 seems to be that while you do properly
>>>> configure gd->ram_size in your dram_init, the '/memory' node of the
>>>> device-tree remains unchanged with the outdated 2GiB size.
>>>>
>>>> You could try updating the fdt's memory size to the correct value in
>>>> dram_init and see if that fixes the problem.
>>>>
>>>> Regards,
>>>> Anshul
>>> Hello Anshul,
>>>
>>> I was bisecting the series, and I can confirm that the commit "mach-k3:=
 map
>>> all banks using mem_map_from_dram_banks" introduces the regression.
>>>
>>> Given that initcall_run_f() calls dram_init_banksize(), and after reloc=
ation
>>> board_init_r() calls enable_caches() (call stack: board_init_r() ->
>>> initcall_run_r() -> initr_caches() -> enable_caches()), I would expect =
that
>>> enable_caches() should not override the bank sizes previously configure=
d.
>>> Currently, however, enable_caches() introduces this side effect.
>>>
>>> Wouldn=E2=80=99t it make more sense to call fdtdec_setup_memory_banksiz=
e() in the
>>> default dram_init_banksize() (in arch/arm/mach-k3/k3-ddr.c) and avoid c=
alling
>>> it again in mem_map_from_dram_banks()?
>>>
>>=20
>> We could follow that order too but that would makes a call to
>> mem_map_from_dram_banks dependent on gd->bd->di_dram being correctly
>> populated. I had assumed whoever calls mem_map_from_dram_banks had made
>> sure to properly fixup the memory node of the fdt.
>>=20
>> Given that it seems like the root cause of the problem is with the
>> U-Boot's device-tree not having the correct memory node, we could add a
>> call to fixup_memory_node (arch/arm/mach-k3/k3-ddr.c) from A53 SPL to
>> ensure the memory can be queried stright from the device-tree once we do
>> get to U-Boot proper.
>>=20
>> 	--- a/board/toradex/verdin-am62/verdin-am62.c
>> 	+++ b/board/toradex/verdin-am62/verdin-am62.c
>> 	@@ -46,6 +46,13 @@ int dram_init_banksize(void)
>> 		return ret;
>> 	 }
>>=20
>> 	+#ifdef CONFIG_XPL_BUILD
>> 	+void spl_perform_board_fiups(struct spl_image_info *spl_image)
>> 	+{
>> 	+       fixup_memory_node(spl_image);
>> 	+}
>> 	+#endif
>> 	+
>> 	 /*
>> 	  * Avoid relocated U-Boot clash with Linux reserved-memory on 512 MB S=
oM
>> 	  */
>>=20
>>=20
>> If you could get to U-Boot prompt with the above diff, could you
>> share the output of the 'meminfo' command with the following configs
>> added:
>> 	CONFIG_CMD_MEMINFO=3Dy
>> 	CONFIG_CMD_MEMINFO_MAP=3Dy
>>=20
>> Though so far, I have been unsuccessful in my attempts to reproduce a
>> boot failure on our own 512MiB platforms (AM62x SiP). Could you share
>> the boot logs with '#define DEBUG' in common/board_r.c, common/board_f.c
>> and mach-k3/common.c to help further narrow down the issue.
>>=20
>> Regards,
>> Anshul
>
> Hello Anshul,
> let me try to rephrase.
>
> The enable_caches() function is not only enabling caches, but also updati=
ng
> the memory map.
> It is not expected from the point of view of the caller and this side eff=
ect
> introduces a regression on our U-Boot, since the memory banks are already
> configured in dram_init().

Hi Emanuele,

Ah, I see your point. In that case mem_map_from_dram_banks should only
rely on the gd with dram_init and dram_init_banksize taking care of
configuring gd properly.

I'll send a fix as per your suggestion (moving
fdtdec_setup_memory_banksize to the default dram_init_banksize) shortly.

Regards,
Anshul

>
> I understand that updating the device tree, as you proposed, could work a=
round
> the issue, but that does not really fix the root cause.
> Having a function perform unexpected operations is the best way to introd=
uce
> regressions now and bugs in the future.
>
> We should either revert the patch or properly fix the issue.
>
> Regards,
> Emanuele

