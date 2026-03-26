Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B4610AB82E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E4E83DA7;
	Fri, 27 Mar 2026 00:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ln0RFQ4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF9283DBF; Fri, 27 Mar 2026 00:23:32 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD7B81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7AvvqoeaTEDjsqOy9z1uWr2E4HfS+1nv/e5RfQGcPAtfrtLHY2nztObcuaXxg+aR4q2VY5jS6oN4tbO1DZiDeceQqI2EXTXa5xygUOZc/eq79fCmWuatoxgZNqmGJcXvOOYFQz35EWlToAKfbgUrIual1g8JDBV+d+fQYroTlUxjlLL/+z2r0jUb2S4zDUANpN+N0+i3S5cGGlahA3ET02Ik09APNaljBWS/jD4A4iFzaTTVzzlrjrATKErCh8i06dXzstmpN33UwVOhWCt+Ppz1+wulf7fniQpGhaFfO31RKcDP7Ta/a74u8gEX7/cdL1O9Hqmo0lBXXwGgFbNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baG9LjdjJHEZwqOs6cQ4Jgb7QIG9qEY1LyyzoRDWaNk=;
 b=fMuR6GOelDBjtCwKGwfwtANCZx4NRflncp5lg/wm50XHVyp9VrT3wkcxbhbzWkDmKkyvSOmWAlaoGSaOkkhwM9iqX/i1WaCGNMovBbSk0QHny+yYTRp1OAhdSGgH0SWV9JHiS23JJcKVL5pCB4I/DqRwZjt6Fah0gMfI+7tpm9g9eUfLr7e5BKv2/btgfEb3G3dv238QuIN3comDdkLN47CHsXvlxG+pE3ZtuUuT440zaZU42fPPzzmygah1TwJurympLCkrUy/rzytb9CTTM59bJILHVSXTYZBYXt86qo35pE3KPylI2MXYfHwUG0/FOwCSqlwjtkK+nFAB9tZWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baG9LjdjJHEZwqOs6cQ4Jgb7QIG9qEY1LyyzoRDWaNk=;
 b=ln0RFQ4TAm9X2WRIwp5b97/r54/diuVUvei917wDmyUuSyXUbVc4wYwrCl2BtaqZBswVXOXBLbCydkHcFfCQdeVnVvC+VALU9O7IyPIRpUBglB66i5wRdMDNy6YUlPsqLYZHj/tAJcYPUCfc7e6RqhFc3U1ube7NpZUB6ZvgSiI=
Received: from SJ0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:33b::11)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 23:23:22 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d9) by SJ0PR05CA0006.outlook.office365.com
 (2603:10b6:a03:33b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Thu,
 26 Mar 2026 23:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 23:23:21 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 18:23:20 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 18:23:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 18:23:20 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62QNNKsF2457722;
 Thu, 26 Mar 2026 18:23:20 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Mar 2026 18:23:20 -0500
Message-ID: <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
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
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
In-Reply-To: <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 6387e2bf-6019-4635-0e37-08de8b8eabff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: u1vt6DmDM4aeNYe5IkQCj6dwmAj+hSl+kl2+mAFGfJwNnjurjLUWjv2EKSwYTg4cjlgh+onOfFWIYye8mQD7D5UEqOQUqHqJP28rPN1BBFbkjV2mvHQXX4BHlmzHGt2g6TDT8h2Z6iAAelQlADpeqGxgtK9IzLhF4ky9NfKwx9e2H9WmwmG487wW4eGJHP15dFSxK9P2zBnC4sZGowZJ3kkuvHx7WnxMTI3lYzPFFkKUTh9Toj8AiRiwbusHsKQb3lap5qQaMgffY54jVfjksLRNSS/a2ZusMoGezodtSb+C9EuSphjiqFzWWBBqAX2QoS0diwt+GNrVNcBDmfjF9ZxXMSPl3YerlckfxF3rXI8TgwQFuL+q9rwcobZk2TuSyMX/gv4PexTj+tJ1o86Z3hXtyEbPqR/ckl6aeXStkI6PD+gVBQWnZkUz7pRj7qlweUPG+faIUrQiQvQj8uQPHKcTlvBVO+P0sB6th9nLvjbysQErg7pJ0WnmW5+uYIZWohR4/OE3mAi8E/aG29OM9nkH2u18HznR26rDUHZXVNzVMCCUFBBvzaJRUgnT2AJBcb9ctEJArxAgA/m8k909+7xEuzbs8gqBJForZD4NF4cEJ4He6+J0nv9gw5WjEOJh3HbZCT3CCkVrgAw4+WAUBD9/eHI1IlSdMFYErgeSGcQCwefxPyQKaMLeh0vYgmSYUly4qBG1rrZT686ip83IPvrM5jhUuA049sCbWsy9NJ8=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bfmX5OjHiiQwUG6Fc13BdQzTAZj1ZqO+jHYS11+3pDagRxjSKchXo4OclnEEgfIFRlcfVGZ6zVmbo3w2h1vdyUouPxopktc5VAH4HEZofOVV5ulVjIOVLdhfUTS9c9UIIrMx6VwJ3mY2wrKyMBZz1TJwYWLjr5+bTAQ12h1Vi8hhWlLtQp82Gpan/NiIO0mxkX6TsSNEl2CDLiP/sHrrGQvnwwTXY2IPT3smXqZ+nFZ1ndqUsgBvCCeIx6YElUKPyyG4jMHaPnMa/cTocI3geW6DLJVCxEnkNjBK2KQXTlC4IG1DkG4qtVUZu8vg/2uWUyv89BWGw4pdsH/DwMNiLs12iq2SLynj0AbN8A4a+mgU7JNUDJsExRvimMVGuLWDvujquVQAP+l6RqyRWX1/v1kh87xv2HCqBoApa9lMwOZTDEqhhQ3U44BVnexy7C/r
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 23:23:21.9132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6387e2bf-6019-4635-0e37-08de8b8eabff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
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

On Wed Mar 25, 2026 at 7:34 PM CDT, Randolph Sapp wrote:
> On Mon Mar 23, 2026 at 2:46 PM CDT, Robert Nelson wrote:
>> On Mon, Mar 23, 2026 at 2:37=E2=80=AFPM Randolph Sapp <rs@ti.com> wrote:
>>> On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
>>> >> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
>>> >> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>>> >> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>>> >> >  CONFIG_NR_DRAM_BANKS=3D1
>>> >> >  CONFIG_SOC_K3_AM625=3Dy
> [snip]
>>> >> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
>>> >> >  CONFIG_EXT4_WRITE=3Dy
>>> >> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>>> >> >  CONFIG_LZO=3Dy
>>> >> > -CONFIG_EFI_SET_TIME=3Dy
>>> >> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
>>> >>
>>> >> Any reason why we are using TOP_HIDE here instead of just moving OPT=
EE
>>> >> lower in DDR like we do on the 512MiB AM6254atl EVM?
>>> >
>>> > Sorry, that is now a legacy setting before OPTEE finally got moved in
>>> > v2026.01, as this had been developed thru v2025 u-boot releases..
>>> >
>>>
>>> Well, it's worth noting that this change was not done in the usual way,=
 and
>>> involves user interaction during the build beyond selecting a defconfig=
.
>>>
>>> https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-linu=
x-AM62X/esd/docs/master/linux/Foundational_Components_ATF.html
>>> https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/mac=
hine/am62xxsip-evm.conf
>>>
>>> Robert, are you alright with me making the requested changes?
>>
>> I guess as long as we document it. I know the Octavo OSD62-sip @Erik
>> Welsh  will also be building on both am62xxsip and pocketbeagle2 based
>> on the 512MB and then larger memory sizes (1G, 2G, etc.).
>>
>> Regards,
>
> Oh boy, adjusting the memory maps kept getting me out of memory errors in=
 the
> EFI flow that I knew should not be true. Found something fun: LMB reserve=
d
> memory regions do not match EFI reserved memory regions. EFI's
> efi_carve_out_dt_rsv is setting regions to be more strict that LMB's base
> requirements. When this occurs and an allocation runs into this discrepan=
cy,
> that allocation and all future allocation requests in the EFI flow will b=
egin to
> fail as they are repeatedly given the same LMB start address in the unapp=
roved
> region.
>
> Randolph

Alright, looking into the allocation helpers it seems that
EFI_CONVENTIONAL_MEMORY can be remapped in efi_allocate_pages so long as LM=
B
agrees that it's free. This aligns with my understanding of the UEFI spec a=
s
well. I dumped the EFI memory map and noticed there were 2 fragmented secti=
ons
of EFI_CONVENTIONAL_MEMORY that it could still use.

Wired up efi_allocate_pages to go to those regions and attempt to allocate =
from
there in the even an LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ANY start failing. =
Seems
to have worked, but now I'm seeing the following reported in the kernel:

[    0.048167] [Firmware Bug]: Unable to handle paging request in EFI runti=
me service
[    0.048246] ------------[ cut here ]------------
[    0.048249] WARNING: CPU: 0 PID: 1 at /usr/src/kernel/drivers/firmware/e=
fi/runtime-wrappers.c:341 __efi_queue_work+0xd4/0x108
[    0.048270] Modules linked in:
[    0.048285] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G          I  =
       6.18.13-ti-00636-g30182cf3ac7d-dirty #1 PREEMPT=20
[    0.048296] Tainted: [I]=3DFIRMWARE_WORKAROUND
[    0.048299] Hardware name: beagle BeagleBoard.org PocketBeagle2/BeagleBo=
ard.org PocketBeagle2, BIOS 2026.04-rc5-00003-gf1dace477fb8-dirty 04/01/202=
6
[    0.048305] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    0.048312] pc : __efi_queue_work+0xd4/0x108
[    0.048318] lr : __efi_queue_work+0xc0/0x108
[    0.048323] sp : ffff80008003bc80
[    0.048326] x29: ffff80008003bc80 x28: ffffad05b176bad4 x27: ffffad05b16=
b00ac
[    0.048336] x26: ffffad05b1622e60 x25: ffffad05b1953000 x24: ffffad05b17=
49050
[    0.048345] x23: 0000000000000004 x22: ffff80008003bd1e x21: ffff8000800=
3bd20
[    0.048353] x20: ffff80008003bd28 x19: ffffad05b19cd5d8 x18: fffffffffff=
e2f20
[    0.048362] x17: 0000000000007000 x16: ffff000001c065a0 x15: 00000000000=
00000
[    0.048370] x14: 000000000000008a x13: ffff000001cf8090 x12: 00000000000=
00001
[    0.048379] x11: 00000000000000c0 x10: 00000000000009f0 x9 : ffff8000800=
3bad0
[    0.048387] x8 : ffff000001cf8a50 x7 : 0000000000000001 x6 : 00000000000=
00001
[    0.048395] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000=
00001
[    0.048403] x2 : 0000000000000000 x1 : 8000000000000015 x0 : 80000000000=
00015
[    0.048413] Call trace:
[    0.048417]  __efi_queue_work+0xd4/0x108 (P)
[    0.048426]  virt_efi_get_next_variable+0x5c/0xac
[    0.048434]  efisubsys_init+0x148/0x390
[    0.048444]  do_one_initcall+0x60/0x1d4
[    0.048457]  kernel_init_freeable+0x248/0x2c4
[    0.048468]  kernel_init+0x20/0x140
[    0.048478]  ret_from_fork+0x10/0x20
[    0.048489] ---[ end trace 0000000000000000 ]---

U-boot itself doesn't report any errors, so I want to assume this is probab=
ly a
configuration issue regarding something else I've forgotten to add.

Anyone got any quick/obvious comments before I start digging through more o=
f
that? Was my assumption about EFI_CONVENTIONAL_MEMORY incorrect? Is this, a=
s
unlikely as I think it is, actually just a known issue right now?
