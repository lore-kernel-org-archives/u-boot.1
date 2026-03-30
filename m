Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73941061B28
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB39083E7A;
	Tue, 31 Mar 2026 01:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rCQAZ+w5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AAC83F0A; Tue, 31 Mar 2026 01:57:29 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6F68352B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEGtgyvMfZct1PscbcoshLYfE4jw/uzepDfSuVlZ1ykH3TAS8De/g5emyymlvAb2z93TshRRziNXgYK5udIZsA5+NRGrqXRZp7w12xb5tkZ7yV/4n3rdnARMT9qo9Jswv9qCKhVOcAOizU1uq4UJz07M6nLTaQcwGDXWsEFC9FD4Pzlr/tRm9mizh/Sd9Ub3Ga9U+I3CmCEiZ5dhImZb7qB8vrKdJHVbDu5++TSQ3552SKYKzVaAVW3T6MuDETXtrmcea++7/yeAr1OmTWgKemtDDLUBZzHuxO/2ocYlw4Q+uP6cjwloK7URNeFq2Wg3HxCw5kgk175E7B3MSUa2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcEAbtjGmxu7psCzOKeFoBErYWAJmdmuHlm4KuqokkM=;
 b=h+2krSeHY6hrPezM9dyKvABWeAMIm6j1p78oWtWYZJwRUAZM4Z1mSev6mmHNcX2xxABxMIzYXePjpgZnmbpjjmBx7Fe96qhN4DiRv/9C2pN1W4jC9SdAdgadfax6mFpYP9ULL8Po3BVY3ouuo0cUZNsOqr6pa10ryIN+ltSxrmNzR7RHGfsVpdHoBALVYv+gPZ00AhlAdZ8PhhHsDzRnhzwpRk5m+CHRzQB/L5VJhRxssRoC6uHC2psHS4ZFy3wgjfhQyFwfs/LnwuGxZRgtI9c8OuyrnlZDXrjKk9xuBLkhuk0vJhEvCBLj+jkmmh8iJXsGl4TEVRfcGX88BWqMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcEAbtjGmxu7psCzOKeFoBErYWAJmdmuHlm4KuqokkM=;
 b=rCQAZ+w5FZ4gdfPYIGAZ4CrFM2xot/6FhgLgeuZBMRVWLXFeCHybZVH96DYz9zL5y4HA3lInwLUIayVbi+K6WUTR495VKiShPs9WuZyX8iRnTr/a1pxRKze6vGlN12VlXqDNDnHTj+4Wc5a6mxvbJHd5Vn52uihYcCFOxOVaJn8=
Received: from SJ0PR13CA0166.namprd13.prod.outlook.com (2603:10b6:a03:2c7::21)
 by DS0PR10MB6126.namprd10.prod.outlook.com (2603:10b6:8:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 23:57:21 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ec) by SJ0PR13CA0166.outlook.office365.com
 (2603:10b6:a03:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 23:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 23:57:20 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 18:57:05 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 18:57:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 18:57:04 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62UNv4hs1217711;
 Mon, 30 Mar 2026 18:57:04 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Mar 2026 18:57:04 -0500
Message-ID: <DHGIV5UK2POR.T98MMILTXQWC@ti.com>
CC: Anshul Dalal <anshuld@ti.com>, <bb@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
From: Randolph Sapp <rs@ti.com>
To: Randolph Sapp <rs@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "Erik
 Welsh" <Erik.Welsh@octavosystems.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com> <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
In-Reply-To: <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|DS0PR10MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8693ad-4f0c-4115-15e5-08de8eb814a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dn/X8L61C7ObdGmoYXkHc1SbFNCfKH8gwafDD2CxfIlsjz5P6l46EmLsXDXGxhHGEd1JyME47S9hI7mzXSJGzWF5mxXg8BBNSThB0b7IKhIEpgEEYGi6x1R/b2EBwirLiL673Q2CWQq04xVaNds1Bmbp0KLCXhnPNPX5pYko5M2eaA4uC8d8Y+kZJPaNE7Ns0PomQG1P8ymJx5ibZALRWW73akjve8mLi8IfqGWUJ36T4Loo15evckc21Q6y/I7BwiQYkL7qYTN7BqitSTtusYPSiDZoEUuhZBQbWeTTTk46PCLj31kMKg68d3R6pb/Z1V9doDg1sc0hMnzmf8vohLllIh8Nh2mQxEAxy4tM6z4GZjtJT993ARdsijzNPIqLfiapHAzohkC/YMomr10YKHe2ajZ7g14cosmFE/0fzAUrHLCtQfV0GqW6uTBgHTsVdLiONvEefNDsKC4/42+KUd9bupqjflk46t/IcHA1GDk3HQFxwqckfWkWai9CILTpSSShW+qfJPLHILudYlFQuipEGW02QoxB/rcPXspjmPLPaEjhZnSPtS7nZbg2ymKX8pKxEX3wwF8iZD2bQSweSL8oQtPtsMknUMJwfmRSgbbmI3FmwSnGVK56B00TZDbnKro5iyn9h9uP1uvVrgugtlefOyyfrqnzqWH+Ft/kLvfwfd2p93C2d3ESKEHGuZzpY6BpjEniA3yALffKaeIzp1cQv8XsKZU6Kzb5AiPYG4c=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SN/Tx6PqMRU6Nxx9mYjtDTqY5iAu/Cr0C/6aqupnla5VYnNKCZv+MGw186UTouFWHSpMBIivM2XvCf2+3f2Qywv4vEQtVjGxORZMJSQOqP/3h9cIQdscCrl1IcVUpAOlYWqazUeSvkFrhMaUmrfWz3MId5g/vdjYfiedbzcB9NmROZkhsAV06mO8q0pOyqn13Cm/dHCABWkdm/Wck43QgbCSGa2IKRWauA4BxjcVGT2Y2TCwpe75eaJzJ6DYfm4TbpL/Nm08f0gOVnlxjasTkhLy6u+isdIgGqZeYADYOv3fcX85pAO9gISBiLClYV5VSfdRorlVdsmwbenUzX53L1bqoO8p4pkfZT+KH0wplrWhq+oJqK0QqSHd0via8odrP+E+3TO/KtaM+zx0dpPb5/I++NsdnPv552OMdXd+xzBe/o5NZIxwKNOLIQF1dy5Z
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 23:57:20.3110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8693ad-4f0c-4115-15e5-08de8eb814a2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6126
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

On Thu Mar 26, 2026 at 6:23 PM CDT, Randolph Sapp wrote:
> On Wed Mar 25, 2026 at 7:34 PM CDT, Randolph Sapp wrote:
>> On Mon Mar 23, 2026 at 2:46 PM CDT, Robert Nelson wrote:
>>> On Mon, Mar 23, 2026 at 2:37=E2=80=AFPM Randolph Sapp <rs@ti.com> wrote=
:
>>>> On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
>>>> >> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
>>>> >> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>>>> >> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>>>> >> >  CONFIG_NR_DRAM_BANKS=3D1
>>>> >> >  CONFIG_SOC_K3_AM625=3Dy
>> [snip]
>>>> >> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
>>>> >> >  CONFIG_EXT4_WRITE=3Dy
>>>> >> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>>>> >> >  CONFIG_LZO=3Dy
>>>> >> > -CONFIG_EFI_SET_TIME=3Dy
>>>> >> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
>>>> >>
>>>> >> Any reason why we are using TOP_HIDE here instead of just moving OP=
TEE
>>>> >> lower in DDR like we do on the 512MiB AM6254atl EVM?
>>>> >
>>>> > Sorry, that is now a legacy setting before OPTEE finally got moved i=
n
>>>> > v2026.01, as this had been developed thru v2025 u-boot releases..
>>>> >
>>>>
>>>> Well, it's worth noting that this change was not done in the usual way=
, and
>>>> involves user interaction during the build beyond selecting a defconfi=
g.
>>>>
>>>> https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-lin=
ux-AM62X/esd/docs/master/linux/Foundational_Components_ATF.html
>>>> https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/ma=
chine/am62xxsip-evm.conf
>>>>
>>>> Robert, are you alright with me making the requested changes?
>>>
>>> I guess as long as we document it. I know the Octavo OSD62-sip @Erik
>>> Welsh  will also be building on both am62xxsip and pocketbeagle2 based
>>> on the 512MB and then larger memory sizes (1G, 2G, etc.).
>>>
>>> Regards,
>>
>> Oh boy, adjusting the memory maps kept getting me out of memory errors i=
n the
>> EFI flow that I knew should not be true. Found something fun: LMB reserv=
ed
>> memory regions do not match EFI reserved memory regions. EFI's
>> efi_carve_out_dt_rsv is setting regions to be more strict that LMB's bas=
e
>> requirements. When this occurs and an allocation runs into this discrepa=
ncy,
>> that allocation and all future allocation requests in the EFI flow will =
begin to
>> fail as they are repeatedly given the same LMB start address in the unap=
proved
>> region.
>>
>> Randolph
>
> Alright, looking into the allocation helpers it seems that
> EFI_CONVENTIONAL_MEMORY can be remapped in efi_allocate_pages so long as =
LMB
> agrees that it's free. This aligns with my understanding of the UEFI spec=
 as
> well. I dumped the EFI memory map and noticed there were 2 fragmented sec=
tions
> of EFI_CONVENTIONAL_MEMORY that it could still use.
>
> Wired up efi_allocate_pages to go to those regions and attempt to allocat=
e from
> there in the even an LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ANY start failing=
. Seems
> to have worked, but now I'm seeing the following reported in the kernel:
>
> [    0.048167] [Firmware Bug]: Unable to handle paging request in EFI run=
time service
> [    0.048246] ------------[ cut here ]------------
> [    0.048249] WARNING: CPU: 0 PID: 1 at /usr/src/kernel/drivers/firmware=
/efi/runtime-wrappers.c:341 __efi_queue_work+0xd4/0x108
> [    0.048270] Modules linked in:
> [    0.048285] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G          I=
         6.18.13-ti-00636-g30182cf3ac7d-dirty #1 PREEMPT=20
> [    0.048296] Tainted: [I]=3DFIRMWARE_WORKAROUND
> [    0.048299] Hardware name: beagle BeagleBoard.org PocketBeagle2/Beagle=
Board.org PocketBeagle2, BIOS 2026.04-rc5-00003-gf1dace477fb8-dirty 04/01/2=
026
> [    0.048305] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    0.048312] pc : __efi_queue_work+0xd4/0x108
> [    0.048318] lr : __efi_queue_work+0xc0/0x108
> [    0.048323] sp : ffff80008003bc80
> [    0.048326] x29: ffff80008003bc80 x28: ffffad05b176bad4 x27: ffffad05b=
16b00ac
> [    0.048336] x26: ffffad05b1622e60 x25: ffffad05b1953000 x24: ffffad05b=
1749050
> [    0.048345] x23: 0000000000000004 x22: ffff80008003bd1e x21: ffff80008=
003bd20
> [    0.048353] x20: ffff80008003bd28 x19: ffffad05b19cd5d8 x18: fffffffff=
ffe2f20
> [    0.048362] x17: 0000000000007000 x16: ffff000001c065a0 x15: 000000000=
0000000
> [    0.048370] x14: 000000000000008a x13: ffff000001cf8090 x12: 000000000=
0000001
> [    0.048379] x11: 00000000000000c0 x10: 00000000000009f0 x9 : ffff80008=
003bad0
> [    0.048387] x8 : ffff000001cf8a50 x7 : 0000000000000001 x6 : 000000000=
0000001
> [    0.048395] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000000=
0000001
> [    0.048403] x2 : 0000000000000000 x1 : 8000000000000015 x0 : 800000000=
0000015
> [    0.048413] Call trace:
> [    0.048417]  __efi_queue_work+0xd4/0x108 (P)
> [    0.048426]  virt_efi_get_next_variable+0x5c/0xac
> [    0.048434]  efisubsys_init+0x148/0x390
> [    0.048444]  do_one_initcall+0x60/0x1d4
> [    0.048457]  kernel_init_freeable+0x248/0x2c4
> [    0.048468]  kernel_init+0x20/0x140
> [    0.048478]  ret_from_fork+0x10/0x20
> [    0.048489] ---[ end trace 0000000000000000 ]---
>
> U-boot itself doesn't report any errors, so I want to assume this is prob=
ably a
> configuration issue regarding something else I've forgotten to add.
>
> Anyone got any quick/obvious comments before I start digging through more=
 of
> that? Was my assumption about EFI_CONVENTIONAL_MEMORY incorrect? Is this,=
 as
> unlikely as I think it is, actually just a known issue right now?

Ugh, that took longer than it should have. Alright, what I did would have b=
een
correct if there weren't a few issues with other things. Primarily, this me=
mory
map for the am6254atl. The U-Boot stack overlaps 2 regions we carve out in
device tree. LMB doesn't actually inform the user of this, and just keeps
trucking, thinking that the general u-boot reservation will be good enough.

Eventually, when some of the stack can be reclaimed, we will put some usefu=
l
things in these regions that were never properly reserved.

What was driving me crazy was that the efiboot selftest reported that every=
thing
was okay except for the device tree region. Fun, what could have changed th=
at?
Well, that's just efi_carve_out_dt_rsv going back and trying to enforce thi=
ngs
LMB never did.

Somehow we got it perfectly where copy_fdt would place the device tree squa=
rely
in a region that was reserved by the device tree itself. Anything else woul=
dn't
have been exposed to the user.

So, I assume that kernel warning is actually a result of some EFI regions b=
eing
reclaimed by efi_carve_out_dt_rsv and the runtime blowing up because what i=
t
thought was a valid address is now in some reserved region.

I've checked and am6254atl is also not able to reserve the
wkup_r5fss0_core0_memory_region (0x9db00000) at startup due to the u-boot s=
tack
size. A ram top value of 0xa0000000 doesn't work with these reservations.

Adjusting the CONFIG_STACK_SIZE won't help here, as it u-boot naturally ext=
ends
into the wkup_r5fss0_core0_memory_region on it's own. I was seeing a stack =
size
of 0x22184c0 locally at the time reservations were being setup.
