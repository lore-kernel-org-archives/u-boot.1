Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BD9F5A8A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 17:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13CCB83C51;
	Mon, 20 Apr 2026 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Lvqb/ZE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E5583BC8; Mon, 20 Apr 2026 19:03:46 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEDA8419E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 19:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emAvBvVzD/pi9AUTx/66tavVqIuIpKcfPDv1aNqyyiCXIOwNl8iyDVntSAjRBGKCwOQ6WvFGKKd4sY9vyzGkVxpIriSYU5GOaa1lHahN0saTDdyXFlF2uHHmhSd4x6Q9T+qAsuVBKEcbJxHMQ/XX5iL8w2FIeLc75uc0YwPAwB78gj3V3MiEOKnvtDcBrrxjzzprO3zEZbhuNh+ur4BzOhdWjwsPqlU0EE1AqrFHleJi41+3KevOn7SM7VSGWbsuPWydWhq5WO9siIg5/EfRGxyQXvYq5b9ZHBrQHucGpdNluc53tt9aZ4Phv1TlhhUbOqqLnmFsbV4a4h514aBzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UoyMkbCw4IwIPSTkUcNZKOVMG2B0Sz4/QpJoX8r2g8=;
 b=aIYlOhbyG8WN8UYOhZ6lJXLphoBO+dwZExJ0gHh77lndzljMpvRQ8GZaHALEOlFXLUnkwx7q09Gp83SdQGrnTn3M1SGgIKlZkmDKWkMvDgP50PP+biuFhiK/b115zbjl69tu48RvEceVEnMqp9V6kqqJedCdArJnkuT0wjXhm7vP8MEMhwBT+JbJFx+Ii6p/ugEWkGQJYYpthLi+qzJxPt7gYhLXRtxHcjtlqhGrTSb5uw9mx+4HDGHVB7wtD3WRFoyM6eWpmCBTUXz6+qfybd6NGWBnfNyH296cDlFz8w6qDT0nI01LfkodyB2mXJYh4nB/V5qDLyQiTVkQoRZ6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoyMkbCw4IwIPSTkUcNZKOVMG2B0Sz4/QpJoX8r2g8=;
 b=Lvqb/ZE4aEz9MZkj0pT8YoyoHydyi+dkcUF1qqq/fjvFqycSyRfiPnjywhDevH95IbN4G2R0jopGj8mTFZRpjQBnJYQbv/YRn6pQkdP7QA59M1nogjx8IfzC6sEHmzDqizy5mHl71eSN/tJXngZjd5AGx77Vzl6aqIvOPu2ydOM=
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by PH3PPF05D8D9487.namprd10.prod.outlook.com (2603:10b6:518:1::784)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 20 Apr
 2026 17:03:33 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::47) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 17:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 17:03:32 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 12:02:52 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 12:02:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 12:02:52 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KH2qLj3005604;
 Mon, 20 Apr 2026 12:02:52 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Apr 2026 12:02:52 -0500
Message-ID: <DHY57GQVGF31.2FBBF7HFSZ5ET@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
 <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
 <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
 <CAC_iWj+BGMYWvLCtfFzN+ngkW6UjSoJJMkGz0FHhyW6KmB=G7A@mail.gmail.com>
 <DHY4W2KEPMLJ.GAWHD1NKHEA2@ti.com>
In-Reply-To: <DHY4W2KEPMLJ.GAWHD1NKHEA2@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|PH3PPF05D8D9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9f2462-65a1-49f8-fc5e-08de9efec0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m00xLJeEbNLASagGWLJaLRsJ9LJYqhPa3nIcxQPHUAWjz+cMqAVF0MgXLgLevQj3Yu3tTJbNaMKtT2YHJWX+R7Sqjy1Wfv6ZW3DVxLzFzsfbrW4PYtIwm5AMfr1ZZgtbpUWrpKaH3X6DviprQ+eH/sQUBnTNHT7qVQII0CbbkZ6NrJJmZlvMOCAUFMiliKvSMdPRTW0NT5P4GPlwCzKFyH+dxEW+G91Trrn1dpR1L5mK9yzcpakUOCMdpZUUOdzm46TBzmiYbExDYYdin7II0gya+bcrvGL+u6scP4z3GEk5MIokcsnJRPcdshuha0nV/pp02FrLND8ruaIdLnxU50NZs9mtU++/s6pGXO8molHuNRZ/FbU8rVWzP6raJiqkTeEwK65C5zWykOW9LT6cqibzDcP/rt4ATzk5YUQYMUqsAQZWNn6myZ/v+mHvamqZ8+LryamRUTIu2As5+7K/72VCOgH7A6rfglL0k3ghyE+yW4J56qn5Y9HkGcWdW9dIlpaG7G8GsU5aHUf9rty7SraDF5QDA2rHeqeUcB6YIdjplagwpcDxJtdHP56RaLS86hW04YTZw87yigFJHKvPbWDCHP0rnBJjeXbLNRCuPO1LR3kDXQ8valKSo/nUPPo4Poi4naDj2kqKSk1jdGU+sAvkuziBENgG+MKVeTrQS92wTjLRj6xgv8BPkqNU9LFAFjSGiO1a4kyMUQ+70hDuAX93o+FYIcwWThAaQw12HGqZAezqRlob82t13VJduPpxusL1nsbFa1FpKVHAfGCQgQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 11O2CQLTsrMUBRanByJOBKko+7khOOFUUma0eDQDMOCO9xp/301vqIBYHaSDWL4n/c8ZulbZof1DoJjAw1bk3Wz/ERwSndt/FZg2ziyns2KUcJqO9TQP0KYa86rrv+xfTmWrdAK772BXWXcmlRyIyi1gfxhxnNS9ghXKqobb446+neNDh+7d3ZhNgy1xTvAsjX2VJH+ZRwgyKZqlgs325MCQH0p284vw73Jwjz/hNaDOOC7803VEBumkeNat8XUe1K1MGJnJfyDnKP51Ge6rO+HxDxCSn6vw3TBhGWehvTbB9Qc4jL6ZpdkmgCTOzKmtnhDKWVK5/+eSBgfqGdk7P8r1yGP0zyi1Jj8zYY7XkXxZ8+Ad/JZyxrk6oh4EaDLrifagnk40maxbXevLa7H2TXG9kQwd4xO7gaCytUwXiOZGiKc7cTH+DgHrkeoaOq5B
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:03:32.4019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f2462-65a1-49f8-fc5e-08de9efec0b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF05D8D9487
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

On Mon Apr 20, 2026 at 11:47 AM CDT, Randolph Sapp wrote:
> On Mon Apr 20, 2026 at 9:30 AM CDT, Ilias Apalodimas wrote:
>> On Fri, 17 Apr 2026 at 19:53, Randolph Sapp <rs@ti.com> wrote:
>>>
>>> On Fri Apr 17, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
>>> > On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
>>> >>
>>> >> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
>>> >> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
>>> >> >>
>>> >> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
>>> >> >> > Hi Randolph.
>>> >> >> >
>>> >> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>>> >> >> >>
>>> >> >> >> From: Randolph Sapp <rs@ti.com>
>>> >> >> >>
>>> >> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim=
 them when
>>> >> >> >> parsing a new device tree and properly warn people when a rese=
rvation
>>> >> >> >> overlaps with an existing allocation.
>>> >> >> >
>>> >> >> > The LMB has a set of regions that clearly describe memory in an
>>> >> >> > abstact way, e.g reserved, no overwrite etc.
>>> >> >> > I don't think adding we should open the door for treating reser=
ved
>>> >> >> > memory as special. Can't we apply the same fix without adding a=
 new
>>> >> >> > description?
>>> >> >> >
>>> >> >> > Thanks
>>> >> >> > /Ilias
>>> >> >>
>>> >> >> I did have an initial implementation using a separate allocation =
list for fdt
>>> >> >> regions in LMB. It works, but boy it's much more messy. All alloc=
ations and
>>> >> >> frees had to check both the regular allocation list and the fdt a=
llocation list.
>>> >> >>
>>> >> >> I thought about having the fdt helpers build their own local list=
 separate from
>>> >> >> LMB, but that's also a little messy in that it means we're either=
 double
>>> >> >> tracking regions or tying to reach into the guts of LMB to extrac=
t information
>>> >> >> about that existing allocation region.
>>> >> >>
>>> >> >> Maybe that's fine considering LMB already reaches out to kick
>>> >> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartm=
entalized at
>>> >> >> the moment.
>>> >> >>
>>> >> >> I'll revisit the localized reservation list for image-fdt. I'll j=
ust setup some
>>> >> >> goofy linked list to track allocation start and size for the late=
r free. I
>>> >> >> assume we prefer a separate set of lmb_region structs for that li=
st as it's a
>>> >> >> little concerning to pass references to an active LMB region outs=
ide of the LMB
>>> >> >> core.
>>> >> >
>>> >> > Can you explain a bit more when the problem happens? Is it because
>>> >> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows=
? Or
>>> >> > is there another reason?
>>> >> >
>>> >> > Thanks
>>> >> > /Ilias
>>> >>
>>> >> The initial comment explicitly calls out that as the reason they dis=
abled the
>>> >> warning, but it should occur any time a device tree is loaded. Inter=
nal or
>>> >> external.
>>> >>
>>> >
>>> > Yes, but that's requesting to reserve specific address(es) which is
>>> > always the same address ranges unless the DTB changes.  In which case
>>> > you just have to find and free the reserved-ranges. Keeping in mind
>>> > that's rare, you can re-parse the DT with minimal overhead and you
>>> > dont have to keep any metadat stored in LMB or anywhere else. and the
>>> > LMB subsystem is not the place to do that. The EEXIST basically means
>>> > "I've already done that" here so I am trying to understand what can
>>> > trigger this problem.
>>> >
>>> >> That also lead me to believe if one were to load multiple external d=
evice trees
>>> >> that you could theoretically trip an OOM with a bunch of non-overlap=
ping
>>> >> reserved regions. I have yet to test that, but culling old allocatio=
ns seemed
>>> >> practical enough without that PoC.
>>> >
>>> > Yea but that's a user error. You can also load a bigger binary that
>>> > your entire DRAM and trigger an OOM
>>> >
>>> > Thanks
>>> > /Ilias
>>>
>>> The explicit case were I really wish we had this warning was when the u=
-boot
>>> stack was creeping into a FDT reserved region. The FDT reservation natu=
rally
>>> failed with EEXIST. That error is overloaded as is. We have to track th=
e
>>> reservations we successfully create in order to clean them up properly.
>>
>> Ok, I think we might have a similar issue to the EFI subsystem then,
>> were we can unload and replace the DT based on various config options.
>> Why don't we just add a function that read the (existing loaded) DT
>> and free the LMB regions based on the DT info?
>>
>> Cheers
>> /Ilias
>
> I did think about that for a bit. Issue is, we need to make sure that fun=
ction
> gets called in all of the paths this function is expected to be called pr=
ior to
> the device tree being switched out. It's doable, but it's a little less
> foolproof.

It would also have to blindly assume the reservation worked the first time.=
 No
way to know if something else just so happened to reserve that region befor=
e the
device tree. Fingers crossed freeing it won't be a problem.

> I'll play around with that idea a little more, as it's certainly better f=
or
> low-mem applications. My localized tracking patch is here if anyone's cur=
ious
> about that implementation:
>
> https://github.com/StaticRocket/u-boot/commit/d0d86e065c9a3588977f4bebf6f=
d783936de0c82
>
>>>
>>> >>
>>> >> >>
>>> >> >> >>
>>> >> >> >> If we don't at least warn the user of these reservation failur=
es,
>>> >> >> >> there's a chance that this region could be freed and reallocat=
ed for
>>> >> >> >> something important later.
>>> >> >> >>
>>> >> >> >> This useful warning mechanism was broken in:
>>> >> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boo=
t_fdt_reserve_region()")
>>> >> >> >>
>>> >> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>>> >> >> >> ---
>>> >> >> >>  boot/image-fdt.c |  5 ++++-
>>> >> >> >>  include/lmb.h    | 14 ++++++++++++++
>>> >> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>>> >> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
>>> >> >> >>
>>> >> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>> >> >> >> index a3a4fb8b558..0f5857f24d2 100644
>>> >> >> >> --- a/boot/image-fdt.c
>>> >> >> >> +++ b/boot/image-fdt.c
>>> >> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr=
, u64 size, u32 flags)
>>> >> >> >>  {
>>> >> >> >>         long ret;
>>> >> >> >>         phys_addr_t rsv_addr;
>>> >> >> >> +       flags |=3D LMB_FDT;
>>> >> >> >>
>>> >> >> >>         rsv_addr =3D (phys_addr_t)addr;
>>> >> >> >>         ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr=
, size, flags);
>>> >> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr=
, u64 size, u32 flags)
>>> >> >> >>                 debug("   reserving fdt memory region: addr=3D=
%llx size=3D%llx flags=3D%x\n",
>>> >> >> >>                       (unsigned long long)addr,
>>> >> >> >>                       (unsigned long long)size, flags);
>>> >> >> >> -       } else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>>> >> >> >> +       } else if (ret !=3D -EINVAL) {
>>> >> >> >>                 puts("ERROR: reserving fdt memory region faile=
d ");
>>> >> >> >>                 printf("(addr=3D%llx size=3D%llx flags=3D%x)\n=
",
>>> >> >> >>                        (unsigned long long)addr,
>>> >> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fd=
t_blob)
>>> >> >> >>         if (fdt_check_header(fdt_blob) !=3D 0)
>>> >> >> >>                 return;
>>> >> >> >>
>>> >> >> >> +       lmb_free_fdt_regions();
>>> >> >> >> +
>>> >> >> >>         /* process memreserve sections */
>>> >> >> >>         total =3D fdt_num_mem_rsv(fdt_blob);
>>> >> >> >>         for (i =3D 0; i < total; i++) {
>>> >> >> >> diff --git a/include/lmb.h b/include/lmb.h
>>> >> >> >> index 427d701bc30..c6a1fc1ca47 100644
>>> >> >> >> --- a/include/lmb.h
>>> >> >> >> +++ b/include/lmb.h
>>> >> >> >> @@ -51,6 +51,15 @@
>>> >> >> >>   */
>>> >> >> >>  #define LMB_NONOTIFY BIT(3)
>>> >> >> >>
>>> >> >> >> +/**
>>> >> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_reg=
ions()
>>> >> >> >> + *
>>> >> >> >> + * LMB Memory region attribute flag to indicate that the regi=
on will be
>>> >> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device =
tree reservations
>>> >> >> >> + * to be cleaned up and tracked more granularly.
>>> >> >> >> + */
>>> >> >> >> +#define LMB_FDT BIT(4)
>>> >> >> >> +
>>> >> >> >>  /**
>>> >> >> >>   * enum lmb_mem_type - type of memory allocation request
>>> >> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular regio=
n of memory
>>> >> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_l=
mb, phys_size_t size, ulong align);
>>> >> >> >>   */
>>> >> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_s=
ize_t size);
>>> >> >> >>
>>> >> >> >> +/**
>>> >> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reser=
ved regions
>>> >> >> >> + */
>>> >> >> >> +void lmb_free_fdt_regions(void);
>>> >> >> >> +
>>> >> >> >>  #endif /* __KERNEL__ */
>>> >> >> >>
>>> >> >> >>  #endif /* _LINUX_LMB_H */
>>> >> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
>>> >> >> >> index 8f12c6ad8e5..7ecc548d831 100644
>>> >> >> >> --- a/lib/lmb.c
>>> >> >> >> +++ b/lib/lmb.c
>>> >> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_ad=
dr_t addr, phys_size_t size,
>>> >> >> >>
>>> >> >> >>  static void lmb_print_region_flags(u32 flags)
>>> >> >> >>  {
>>> >> >> >> -       const char * const flag_str[] =3D { "none", "no-map", =
"no-overwrite",
>>> >> >> >> -                                         "no-notify" };
>>> >> >> >> -       unsigned int pflags =3D flags &
>>> >> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | L=
MB_NONOTIFY);
>>> >> >> >> +       const char *const flag_str[] =3D { "none", "no-map", "=
no-overwrite",
>>> >> >> >> +                                        "no-notify", "fdt" };
>>> >> >> >> +       unsigned int pflags =3D
>>> >> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NON=
OTIFY | LMB_FDT);
>>> >> >> >>
>>> >> >> >>         if (flags !=3D pflags) {
>>> >> >> >>                 printf("invalid %#x\n", flags);
>>> >> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size=
_t size, u32 flags)
>>> >> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FR=
EE, flags);
>>> >> >> >>  }
>>> >> >> >>
>>> >> >> >> +void lmb_free_fdt_regions(void)
>>> >> >> >> +{
>>> >> >> >> +       struct alist *lmb_rgn_lst =3D &lmb.used_mem;
>>> >> >> >> +       struct lmb_region *rgn =3D lmb_rgn_lst->data;
>>> >> >> >> +       long ret;
>>> >> >> >> +       int i =3D 0;
>>> >> >> >> +
>>> >> >> >> +       while (i < lmb_rgn_lst->count) {
>>> >> >> >> +               phys_addr_t base =3D rgn[i].base;
>>> >> >> >> +               phys_size_t size =3D rgn[i].size;
>>> >> >> >> +               u32 flags =3D rgn[i].flags;
>>> >> >> >> +
>>> >> >> >> +               if (flags & LMB_FDT) {
>>> >> >> >> +                       ret =3D lmb_free(base, size, flags);
>>> >> >> >> +                       if (ret < 0) {
>>> >> >> >> +                               printf("Unable to free FDT mem=
ory at 0x%08lx\n",
>>> >> >> >> +                                      (ulong)base);
>>> >> >> >> +                               i++;
>>> >> >> >> +                       }
>>> >> >> >> +               } else {
>>> >> >> >> +                       i++;
>>> >> >> >> +               }
>>> >> >> >> +       }
>>> >> >> >> +}
>>> >> >> >> +
>>> >> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>>> >> >> >>                            phys_addr_t *addr, u32 flags)
>>> >> >> >>  {
>>> >> >> >> --
>>> >> >> >> 2.53.0
>>> >> >> >>
>>> >> >>
>>> >>
>>>

