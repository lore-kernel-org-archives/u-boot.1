Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4AEF436B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 16:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B0184286;
	Fri, 17 Apr 2026 18:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nIQjgswk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302E484286; Fri, 17 Apr 2026 18:54:01 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2A784223
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 18:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFaLltl1MVxZcskKB5C2ZVFUbI0dtWNMONnLZPV6D/mQKI5j7e23odk8vAC6eLN/aM8x6WfpRA7AYn+Q5HyHEzjuBP6ybROsoNm32ipJqH6giMPdwbslQ3eD0KislqJ/jznylUnqiCDisF6sx20CGLjpd3wGYXUsMIMQjIdvtoKiGaAUuReLEWtO0pa97gPv1gHTEbCC0GH8doXiZS1sG9IhlJFYJ27hjFalUl4Uc7oJ1gTzliIpaZcqy9olJN6WirIHNtsluG2fvlrq/lUBBLdEkGNUxL9EVVxPjkzyu9SSPloz1GKrZLW7lMWueQArhp780kNl162D35JgfitDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMTCpJHibFhyCkMMvJw9TYaLTMzOmVjQPBxpHsjpsYk=;
 b=oWbWRe0R13/7ZLupj4wW3vbHC5cBOsbyl92730DVEg330Onvv6CREu+v9+jjJ6UgLjlW6FMVU/4erO89xN1bYVlG4Lf8UY+1kgpsSUawetGp5P053lBS3QVm/6SGpnflS8AGNHYUgpT0UCv80OINR6rxh+8lOlJ1HcVvinmLC0irv3WxDgBGLM4I4jWbN9Iyu3X11JA1ohqp1XhctLY/62+9j0TqHz6tDp4qc0+8QN9NtK1L7FhOAJkbrnMvHHwQDUo/s6LteOXV76kSJifkOFvW5ASfQUVbWhfeFpT1EAUh0jUqPsRpQO8YGbtAX0kgfGgO23/3q+ipMYFc/nsaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMTCpJHibFhyCkMMvJw9TYaLTMzOmVjQPBxpHsjpsYk=;
 b=nIQjgswk6itAnfCn/9kElwvsH8ODy89U1EneIOpcF5AmA0G9s5VSy0kL7BikUwVC1h9L0nTW5AfjqHtyulLj9Ob/35CAYsCnDOs4x84WRudk2eTWaPRUIdVSdiicE44YcHSwIODr8rY0nj7jsS9JYTtHGXULuOVxKpR0PzRsPg4=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 16:53:54 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::73) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 16:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 16:53:53 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 11:53:53 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 11:53:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Apr 2026 11:53:52 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63HGrq2v2300906;
 Fri, 17 Apr 2026 11:53:52 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Apr 2026 11:53:52 -0500
Message-ID: <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
 <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SJ0PR10MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: c84bc454-b9a3-408a-548e-08de9ca1e86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PKPllmMS+jk7k2Jkj8Ud26xk59L8gAbLH0SgNvOUtmP6lXKq1aaceF/FJLNZwvD/ZKYXAIzKu1qMili7dtKEU5LC3P7uurupSkwGWf1fJ/A/+gb7iXUysaNJmvUkxoteSIMu3Lh194Ydsu8LBRb2z7vd9Rd1cgSfYy9FP8tDOi7n694Tdm7pbqS4eAqvLmW8iyM90BrPt9fY6kru6IzTOeqZiLNlyWcvBHWD2HS+aoD7wVPtuaTxsXJla3pD5CzBZt0W0vaDEQ0RHnuJainjRSXC3bIe/BqylfuHzdbcTyKQI3HIiMSohMQO5PG1Cm3UlLpoGOso2sth6Q6hprWSjtwLWj3VMAZWMhuelNW3M+QhP3KMrj1stCYsTQBfpVDfHxMu+Z9dd1dex1qDdGN5tSUkibam5D4Dio+4LGFuoT14hqF8P9B766h9ZccqAtoN6ALwX2ILJuXRdfccfm1ufJCK9OImQNDnT2cAopSqMLuDjZ/tTOSJqtBE0Tr7COfmY7J8A0lXv/r+hSGvOriKDeX9v5jWSi+TsWZ/ZaoiHFN/yuuk0Rp3jLGQ7SvvBWc29/iRg+Fpkoeoq7XBA0sA4sxUlW5cy9ECix6HEOwEf1OmGoHThqVQYci9p3vN1BFO0WERBI4YpoX+ux9rYoc44BVW2cqFB/L6GAd1lcIoih9nJz+eKWGJcLneqU9138gm2UDb7rKWxXeejj58xsQUwAMJfE6HQf4Do7ImMSdTUUt+GU3cPnvybX4HXnzIxtcfy4RK6SGa5S5FGmWo3m1XxQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j6xjx/0nz2SGSrFN+SQlpy6Igl9SgobvVqKrSVfEBSz+a12PPtX1gyFMoPhpcPIlZNQ9EjlvuObl7F/GBwNTvl0moHjrAF6hzvIMhiIMQcR5/PlElzTqgFYkA83pVTAjDdWe8+Y9dQtrrB074stI6NexpeHa1LQOoIL3Z4oEKou0QNmEvCN/8Dzrk+UcBWmaKl2wHwlimdXMuQiZafW+BrdSaF+0xVjZlokZFCrnxAvMsl2XcW1p0CvnE9VHlY0sRvfKT4TjwpJHIZ6a/Jjp/bD0yC2PKn06pr/WlPGuqAAM++WcqKLP2vzICd8M1EQ9jOZ0kDK628fng+D0OndIleROQVw9zX3H5gwQ66Fn2u4wG/D5SPa51vrF2kIktjLF7UiYtGxPU5BiIercjXcrV7NLWcUxOEkO5O+6t6ZjO9cfawGtK7R2L6i2yKNXZLmA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 16:53:53.4899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84bc454-b9a3-408a-548e-08de9ca1e86b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
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

On Fri Apr 17, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
>> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
>> >>
>> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
>> >> > Hi Randolph.
>> >> >
>> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>> >> >>
>> >> >> From: Randolph Sapp <rs@ti.com>
>> >> >>
>> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim the=
m when
>> >> >> parsing a new device tree and properly warn people when a reservat=
ion
>> >> >> overlaps with an existing allocation.
>> >> >
>> >> > The LMB has a set of regions that clearly describe memory in an
>> >> > abstact way, e.g reserved, no overwrite etc.
>> >> > I don't think adding we should open the door for treating reserved
>> >> > memory as special. Can't we apply the same fix without adding a new
>> >> > description?
>> >> >
>> >> > Thanks
>> >> > /Ilias
>> >>
>> >> I did have an initial implementation using a separate allocation list=
 for fdt
>> >> regions in LMB. It works, but boy it's much more messy. All allocatio=
ns and
>> >> frees had to check both the regular allocation list and the fdt alloc=
ation list.
>> >>
>> >> I thought about having the fdt helpers build their own local list sep=
arate from
>> >> LMB, but that's also a little messy in that it means we're either dou=
ble
>> >> tracking regions or tying to reach into the guts of LMB to extract in=
formation
>> >> about that existing allocation region.
>> >>
>> >> Maybe that's fine considering LMB already reaches out to kick
>> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmenta=
lized at
>> >> the moment.
>> >>
>> >> I'll revisit the localized reservation list for image-fdt. I'll just =
setup some
>> >> goofy linked list to track allocation start and size for the later fr=
ee. I
>> >> assume we prefer a separate set of lmb_region structs for that list a=
s it's a
>> >> little concerning to pass references to an active LMB region outside =
of the LMB
>> >> core.
>> >
>> > Can you explain a bit more when the problem happens? Is it because
>> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
>> > is there another reason?
>> >
>> > Thanks
>> > /Ilias
>>
>> The initial comment explicitly calls out that as the reason they disable=
d the
>> warning, but it should occur any time a device tree is loaded. Internal =
or
>> external.
>>
>
> Yes, but that's requesting to reserve specific address(es) which is
> always the same address ranges unless the DTB changes.  In which case
> you just have to find and free the reserved-ranges. Keeping in mind
> that's rare, you can re-parse the DT with minimal overhead and you
> dont have to keep any metadat stored in LMB or anywhere else. and the
> LMB subsystem is not the place to do that. The EEXIST basically means
> "I've already done that" here so I am trying to understand what can
> trigger this problem.
>
>> That also lead me to believe if one were to load multiple external devic=
e trees
>> that you could theoretically trip an OOM with a bunch of non-overlapping
>> reserved regions. I have yet to test that, but culling old allocations s=
eemed
>> practical enough without that PoC.
>
> Yea but that's a user error. You can also load a bigger binary that
> your entire DRAM and trigger an OOM
>
> Thanks
> /Ilias

The explicit case were I really wish we had this warning was when the u-boo=
t
stack was creeping into a FDT reserved region. The FDT reservation naturall=
y
failed with EEXIST. That error is overloaded as is. We have to track the
reservations we successfully create in order to clean them up properly.

>>
>> >>
>> >> >>
>> >> >> If we don't at least warn the user of these reservation failures,
>> >> >> there's a chance that this region could be freed and reallocated f=
or
>> >> >> something important later.
>> >> >>
>> >> >> This useful warning mechanism was broken in:
>> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fd=
t_reserve_region()")
>> >> >>
>> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >> >> ---
>> >> >>  boot/image-fdt.c |  5 ++++-
>> >> >>  include/lmb.h    | 14 ++++++++++++++
>> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
>> >> >>
>> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> >> >> index a3a4fb8b558..0f5857f24d2 100644
>> >> >> --- a/boot/image-fdt.c
>> >> >> +++ b/boot/image-fdt.c
>> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u6=
4 size, u32 flags)
>> >> >>  {
>> >> >>         long ret;
>> >> >>         phys_addr_t rsv_addr;
>> >> >> +       flags |=3D LMB_FDT;
>> >> >>
>> >> >>         rsv_addr =3D (phys_addr_t)addr;
>> >> >>         ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, si=
ze, flags);
>> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u6=
4 size, u32 flags)
>> >> >>                 debug("   reserving fdt memory region: addr=3D%llx=
 size=3D%llx flags=3D%x\n",
>> >> >>                       (unsigned long long)addr,
>> >> >>                       (unsigned long long)size, flags);
>> >> >> -       } else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>> >> >> +       } else if (ret !=3D -EINVAL) {
>> >> >>                 puts("ERROR: reserving fdt memory region failed ")=
;
>> >> >>                 printf("(addr=3D%llx size=3D%llx flags=3D%x)\n",
>> >> >>                        (unsigned long long)addr,
>> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_bl=
ob)
>> >> >>         if (fdt_check_header(fdt_blob) !=3D 0)
>> >> >>                 return;
>> >> >>
>> >> >> +       lmb_free_fdt_regions();
>> >> >> +
>> >> >>         /* process memreserve sections */
>> >> >>         total =3D fdt_num_mem_rsv(fdt_blob);
>> >> >>         for (i =3D 0; i < total; i++) {
>> >> >> diff --git a/include/lmb.h b/include/lmb.h
>> >> >> index 427d701bc30..c6a1fc1ca47 100644
>> >> >> --- a/include/lmb.h
>> >> >> +++ b/include/lmb.h
>> >> >> @@ -51,6 +51,15 @@
>> >> >>   */
>> >> >>  #define LMB_NONOTIFY BIT(3)
>> >> >>
>> >> >> +/**
>> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions=
()
>> >> >> + *
>> >> >> + * LMB Memory region attribute flag to indicate that the region w=
ill be
>> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree=
 reservations
>> >> >> + * to be cleaned up and tracked more granularly.
>> >> >> + */
>> >> >> +#define LMB_FDT BIT(4)
>> >> >> +
>> >> >>  /**
>> >> >>   * enum lmb_mem_type - type of memory allocation request
>> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of=
 memory
>> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, =
phys_size_t size, ulong align);
>> >> >>   */
>> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_=
t size);
>> >> >>
>> >> >> +/**
>> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved =
regions
>> >> >> + */
>> >> >> +void lmb_free_fdt_regions(void);
>> >> >> +
>> >> >>  #endif /* __KERNEL__ */
>> >> >>
>> >> >>  #endif /* _LINUX_LMB_H */
>> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
>> >> >> index 8f12c6ad8e5..7ecc548d831 100644
>> >> >> --- a/lib/lmb.c
>> >> >> +++ b/lib/lmb.c
>> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t=
 addr, phys_size_t size,
>> >> >>
>> >> >>  static void lmb_print_region_flags(u32 flags)
>> >> >>  {
>> >> >> -       const char * const flag_str[] =3D { "none", "no-map", "no-=
overwrite",
>> >> >> -                                         "no-notify" };
>> >> >> -       unsigned int pflags =3D flags &
>> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_N=
ONOTIFY);
>> >> >> +       const char *const flag_str[] =3D { "none", "no-map", "no-o=
verwrite",
>> >> >> +                                        "no-notify", "fdt" };
>> >> >> +       unsigned int pflags =3D
>> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIF=
Y | LMB_FDT);
>> >> >>
>> >> >>         if (flags !=3D pflags) {
>> >> >>                 printf("invalid %#x\n", flags);
>> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t s=
ize, u32 flags)
>> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, =
flags);
>> >> >>  }
>> >> >>
>> >> >> +void lmb_free_fdt_regions(void)
>> >> >> +{
>> >> >> +       struct alist *lmb_rgn_lst =3D &lmb.used_mem;
>> >> >> +       struct lmb_region *rgn =3D lmb_rgn_lst->data;
>> >> >> +       long ret;
>> >> >> +       int i =3D 0;
>> >> >> +
>> >> >> +       while (i < lmb_rgn_lst->count) {
>> >> >> +               phys_addr_t base =3D rgn[i].base;
>> >> >> +               phys_size_t size =3D rgn[i].size;
>> >> >> +               u32 flags =3D rgn[i].flags;
>> >> >> +
>> >> >> +               if (flags & LMB_FDT) {
>> >> >> +                       ret =3D lmb_free(base, size, flags);
>> >> >> +                       if (ret < 0) {
>> >> >> +                               printf("Unable to free FDT memory =
at 0x%08lx\n",
>> >> >> +                                      (ulong)base);
>> >> >> +                               i++;
>> >> >> +                       }
>> >> >> +               } else {
>> >> >> +                       i++;
>> >> >> +               }
>> >> >> +       }
>> >> >> +}
>> >> >> +
>> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>> >> >>                            phys_addr_t *addr, u32 flags)
>> >> >>  {
>> >> >> --
>> >> >> 2.53.0
>> >> >>
>> >>
>>

