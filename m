Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1FEF94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4400842A4;
	Wed, 22 Apr 2026 00:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VkFRlQ6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0CD842B7; Wed, 22 Apr 2026 00:56:03 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4417C83FED
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjmxhadG7Y/Fn6hnpox2vzz74mpQ46KCnMgTSULnQpY6xvpME9xvSDO038p1EwhnEkFJj4kG2liCUJUdZfe9hTgvL3dYW+XD8A7Ulp42IWC/OBmwC4L2eFr3xEx0PG/1z8QtI7w2yu/VM6Wwesrkne3LyOabjlzJf3cq4G1sTwJp9GXCSbxEQ7ZxLvP4XwqsprMSelPrqzBxALrJEIZC/kpRzc1k+RSx+k2tdOKHnqxS5kmexlOARfdPJeNiZ36ty4m+0abxj7sQbW65rB/aqt8gej0rsDK973qgEEUwG/BWt52uj/I+63dFOa0+hG6jrd0RbGFXtLrHJu91AkQTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiVnj0v8GuGNp97pe+WorlcjiS5mpC/wn7rOX5M5IUQ=;
 b=eBVvZg1SupJ9cPSwrT3jE00rTTIrPyCjHIjFmeI3/+E9Wo55sdbHLPgOyLRIpfgZKMTCEkT/JlT2qhThj20HY1Q4zHZHBXE43CaLIu+zys9pBEOrpmralf8Wl1xKy/HrQoyUSVysS5GZq4Mk2E7Z3oi1XD9XDSdQgVmMRMj2KoZ14z2UY6UsARZGPleshv/HNKDZL/XXHK12mBMpRCi9uVCLYrRQ6IjQ2lMRDkKkKA2jHvUubdMeYaFB8N/+cMIiHzVwk+txLM+vk03IfyLKXxLxNiglkN677F22OGMS0qy3Fp+GS3tFNXBIppGUWblszjekaQIt89bnfhg3SH/4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiVnj0v8GuGNp97pe+WorlcjiS5mpC/wn7rOX5M5IUQ=;
 b=VkFRlQ6S/xqnVkiwAcFNdvVyjgj+sriAhUH41dGgzUw1K6yvZLW2j+v94pnTlBeN1x+NVQTgGFiNnvjmcCHsojkXXYvdlFFj1uwODinklMdImckgBuhDc0pz09ocEQ6s8XZGm0vnie2DPa4FHC+GJ/NIbqEnWQjU8Rnw8KpA3xo=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 22:55:52 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::77) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 22:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Tue, 21 Apr 2026 22:55:52 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 17:55:52 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 17:55:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 17:55:52 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63LMtqNl1071565;
 Tue, 21 Apr 2026 17:55:52 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Apr 2026 17:55:52 -0500
Message-ID: <DHZ7CA8ENGEC.1TQBC71ZOAULX@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv4 2/6] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
From: Randolph Sapp <rs@ti.com>
To: Simon Glass <sjg@chromium.org>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260420192520.1444749-1-rs@ti.com>
 <20260420192520.1444749-3-rs@ti.com>
 <CAFLszTggCLQPaJcRoxhjHOuRM10yW3pr8JjRj+LLA-ZupVOSjg@mail.gmail.com>
 <DHZ6GETQ2Z6C.2EZP9ISNJR0E7@ti.com>
 <CAFLszTi-6pmOYA1F8eZuXtV=Lg5fByTsPCeSBCp65kzw5DAW_g@mail.gmail.com>
In-Reply-To: <CAFLszTi-6pmOYA1F8eZuXtV=Lg5fByTsPCeSBCp65kzw5DAW_g@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: cd00aba6-f8ac-4165-83e0-08de9ff923e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: z33mqpTMRuF+PSvTdBRwBDZychD3KouN65eOUAxhoVYo9Eedgjz4HcbYXV/VtSqkwQB0X4KIoffL+upvOk86i+xds4qIBHYmXc4PL3Yo7AGjleJ7xuIOK9qrqFy0V6UxBm2ifE7a3uuFQeSwlVC8Hf9sSKVTOdMpi7o8Bu2u7YbZ/gCndoeQx0p46QlWxh532y6c3LrfCRrzcTQV1PZkbwJ/UxbmMvFX7DY2X/Adwm0YRNB/JhigDKSpS5PV3rZIwnTzjwwDb8GwPPzr4k3WHWqYZGhXA7tQ9mtgcGllADMLXX0dLCF9wxtp2h9ApT26NDdSfUGn6yJrEwmHeWDISSevirrqcWuSbhrqIKZCC1L/A0EO050y+3+SDgiPg3LXgqVU9iaNsEmOy6dPqyZZ4LxeXgxF8qGqRbravervbTdpSoxih5X28toAA06V9+ZJgLgGTtVU+5OoU8KUfCmd79vaDCzZjB7+INXlhlplVgdG3SsIzrc5CSrDLfgtOohVE0nPAttQdjkeGXPw0Cx5vutQl4neVess2LAai1hzMz7AfcMJ8stqTb0B6smIRuWsPVvGV4XVE77iFexgPxpNtjoIEIGzfdVqEDtAk0yZM8rcqEnb7BR8UfBjhYSU0PuJlOkEozG1fnf9wITQkghjI7R7BcaNp7Xfmvz+5tN3nv7BcbEMLIX5JQWa4M0y26UPYIVdmTSj//T1b9dUfSIsUQK9nUCkMUf+wwP5Ah8ks0ouNPYOphhgLNsltzStCmaTviMtn58a8mMYJS6mEN3orA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S3Ii4TwpAwOGlC9I/14TbJvpHN5Dz+g3rp6gbePK/7dnJ28hQoPpHfXtwZd4R4E3AyQHn5auA6bdffplZgudloIP3iZauyk0MWgMOFQ5XVizfCkl9sjp7I7FTW/1f4iGFhnXAZs9qHhK4Oay+iIZlgaG6RUPC+UlhdTBFME0F+1AElDxpPnWRdhsKemBYI9e7IO/yeQhKpysJPjJjQiIWTBSMJ8nJ+S0v21zvXfIDKYeqGr08J+9faSjLe4vnA7bgKH1T3aFPCaOU+tR1GDDtond0NpJSbYHf286SJG6qrPCIwo4jce8FczHFax9DKHq17OhpjaXywYnWpbkyhbV8sk9y88MiIY+nqYsZAHfCsobFjLet+3pbQkhJX3k1xG+zMC0l3R2R95CAXn1K59aVNvl/a0FTiqMu2+AXaWIkZIXxY6wbl9OyEk3aL3z5xBl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 22:55:52.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd00aba6-f8ac-4165-83e0-08de9ff923e5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
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

On Tue Apr 21, 2026 at 5:54 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On Wed, 22 Apr 2026 at 10:14, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Tue Apr 21, 2026 at 3:40 PM CDT, Simon Glass wrote:
>> > Hi Randolph,
>> >
>> > On 2026-04-20T19:25:18, Randolph Sapp <rs@ti.com> wrote:
>> >> boot_fdt_add_mem_rsv_regions: free old dtb reservations
>> >>
>> >> Add a free flag and an initial call to free allocations covered by th=
e
>> >> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regio=
ns
>> >> occur before the transition to the new device tree, thus we can acces=
s
>> >> the currently active device tree through the global data pointer.
>> >>
>> >> This allows us to clearly indicate to the user when a device tree
>> >> reservation fails. How we handle this can still use some improvement.
>> >> Right now we'll keep the default behavior and try to boot anyway.
>> >>
>> >> This functionality was broken in:
>> >> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reser=
ve_region()")
>> >>
>> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >>
>> >> arch/mips/lib/bootm.c |  2 +-
>> >>  boot/bootm.c          |  2 +-
>> >>  boot/bootm_os.c       |  2 +-
>> >>  boot/image-board.c    |  2 +-
>> >>  boot/image-fdt.c      | 57 +++++++++++++++++++++++++++++++++++------=
----------
>> >>  include/image.h       |  2 +-
>> >>  lib/lmb.c             |  2 +-
>> >>  7 files changed, 45 insertions(+), 24 deletions(-)
>> >
>> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> >> @@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt=
(ulong fdt_addr)
>> >> +static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags, b=
ool free)
>> >>  {
>> >> -     long ret;
>> >> +     int ret;
>> >
>> > nit: perhaps keep this one 'long' since lmb_free() returns long ?
>> >
>> > Regards,
>> > Simon
>>
>> Ugh, yeah though it should only return 0, -EEXIST, or -1 since that's al=
l
>> lmb_add_region_flags returns. I'm not going to ask why that's the case.
>
> Ah yes, I suppose it could be changed to return an int.
>
> Regards,
> Simon

I'll leave that for later cleanup considering I've still got to get the
pocketbeagle2 series submitted after this stuff.
