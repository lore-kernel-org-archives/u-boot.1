Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E86F8D76E
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9C38423E;
	Thu, 16 Apr 2026 21:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EuoKEwUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 356548423E; Thu, 16 Apr 2026 21:23:45 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A8480077
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vct530PujSSuSnQO3KBldqxMhV5yexMnvjAcTKQv9SwioVYlphVn/O11jbcpgTW9fGYW5T0RSo4YkBNuvNspj2/ROvgtBFleoFZjmQAI2Yc4m+RwIGccwtRIMCNCc4nXOJonai7T1jZEG2Wn9jdz/kIfHlIS6Jp110luNyMPywg8U+sBd0lbqArhHb8wzVnoM6sA8FuvNiYBpj+fCbGG1tsRdeAjGj/gd+I8b0+71dZNH2vWjQZP0M9+20XZkVT5tKQK6o/1O22XSxfhznzZyDOC3j/G6vLUkbfo/H9+Dj9WUTMmD17WTP3DXGi4Hq3EmZhSkXPciclKpwiJZerFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pdB2uM5kPFojN1zv0Wtj+9z/0WCFEiHcf/w+KPpsyA=;
 b=ILm5SxXQY+4rKKN1jIt6yRKj1e60qAIqQJ3oWeVcj+4MV0hOK6uDiUq4WD2BQ2/7hIYgaa9rkGuZ2z1LL4fVetIMB/hMRBfdhQrWZLRutRaA5mam+7PXpf4QXM68OPLBdxKnopzrlk6yvGeRyXSKAN6Nizv751jFyQ0yCYIce30HYzzWBoyEN24JOlsQDM4GGJjMXQTTN+6LAOwpKRhOP/fz/jWSuw/W2aNsh8RgFAjRWK57ATtQCHtWdBzjJ+NS/yx3fbGZF7GF9HUh/rI44O8Rn8Qst2S5MZb6Jv1Nrw+k59aXtqHowrN0OzwiDT4E9UCiIwKClP9wUT3eZKu5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pdB2uM5kPFojN1zv0Wtj+9z/0WCFEiHcf/w+KPpsyA=;
 b=EuoKEwUPqNjoGnD+EEQCddp6BFh2TLo+91dD0o+eV5ZAJLM7+6eGuAfFMAvC3e5d87iZD/u8gHibmJFFKc3jlSykqSuEBNqzARp8fj5GRPkXLAOD6MYx2MHS5XaKEuTjsOLk4eAjcRvK8noMckJA7ahiDNcQJIYPLbVXpwLr8k8=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 19:23:38 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::52) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 19:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 19:23:36 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 14:23:36 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 14:23:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 14:23:35 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GJNZZH352047;
 Thu, 16 Apr 2026 14:23:35 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2026 14:23:35 -0500
Message-ID: <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
In-Reply-To: <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d9e1b8-023b-447b-4a5f-08de9beda863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: UqdJFeqYLGIulWMdjMOul8ufCGOAJJz1qaDIMU1v8TcEpIMpgKcSysE9fB6xeBTgqThyhQ04LrBg/dNfYKfDSQwqoEW6KFcNniJQo5XSzMahtNXEae8nee9JRpNq4q1G5kTxT1TrkVW4hrSRuVjsGx9TM1gL066h2CDxhakEqiTv6BRy0r8aM+9igZZ4EKlIRpKVYbZgNJEXx02YSV215+oxwxp7f4ViGPbTV3QGniGZCVhuTeJT/0a0g03xJNRasJByIK8IicpMqFTsl7fBTr4gnwUT/S/ZVywUCCjRmTdV0d3uINWPbf8+m0QQ+lNFHNOoxc/AM2hQE3WoaL3xe7RQEcDueSVDBgAYf1Xid16Q9Shyfn7U/LABvI1f4hkDyl36rHTY3rxiEZgiFqaIfarb56cAcCkj9LRHbPwFeRus6/0qLwB2sNbEXqgmCr3vegDUgkDUo56GpsF2sCFwBypUvpTXKVCPBXeAxkqQRqU6QdR3f6UiqMSy6mDEam1ktYPQVifsZF9TF4ZMGF5zhzYsNTCyLuKLoYosZf+JZZnA/iT9cHa1bgBOXBLx5X9eaKhbq76Sf5Q1OkKrvcKNtpQuiCAyslFjk4AYwiwoiGPgOtCrhNOsQBricWSReogLCjDq6gXkMXpdyjywI4na/GgMDETud/JFJuNqnF4if0AlSkxq7Jz2FaZH+cOdPhFilh13H9APRQgIMG1JkNSyWXNy45HWMuHF+ql7pJwi0ZACGvMyv4OxJn+eN8EmxTk5+2cMh9YuMxVcZK0DPpVWaQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dROKveGANVQRr6WgsGrCG9mECdxo4vrQOP7cgruyTf/N2bD7kfelgmci3/mpxHOde33fWOzWYIpm0pBIOxyQjYkdgVB92iMUqjeyFs2EWV5LnbaD3HLW05+KTZhwEzGvbF3wBkfjGBKqMBJ1F093l1m0Ed4syVxNNn1TRhcUFHoSj211/fwQRl6SyipSo1/ILCIixNOYyc7TJ5y6LAidk0Ql7CX+CiltXBwbuM1ZXm/D68K7lk/Mq3TRqUxWr065qhEkw9e1WYZE0+5Y/iCZrS8cfafR6EiUP6hhIkdrduKLRjnei8U5ufCNDzs4+m81+CwpDKOQcEJASS/ig68Qy5ZDSa5sVOznEOd4bjyS4DMiVCEQ7BvkbVWUrqSWmd2RvEGwgrs1gx/Dm7NfnZ/nFxlqGU2XXqvAr3qCszIZQY+9O6xNEKXXvzff+v0DTZz6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:23:36.6511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9e1b8-023b-447b-4a5f-08de9beda863
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
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

On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
> Hi Randolph.
>
> On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
>> parsing a new device tree and properly warn people when a reservation
>> overlaps with an existing allocation.
>
> The LMB has a set of regions that clearly describe memory in an
> abstact way, e.g reserved, no overwrite etc.
> I don't think adding we should open the door for treating reserved
> memory as special. Can't we apply the same fix without adding a new
> description?
>
> Thanks
> /Ilias

I did have an initial implementation using a separate allocation list for f=
dt
regions in LMB. It works, but boy it's much more messy. All allocations and
frees had to check both the regular allocation list and the fdt allocation =
list.

I thought about having the fdt helpers build their own local list separate =
from
LMB, but that's also a little messy in that it means we're either double
tracking regions or tying to reach into the guts of LMB to extract informat=
ion
about that existing allocation region.

Maybe that's fine considering LMB already reaches out to kick
boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentalized =
at
the moment.

I'll revisit the localized reservation list for image-fdt. I'll just setup =
some
goofy linked list to track allocation start and size for the later free. I
assume we prefer a separate set of lmb_region structs for that list as it's=
 a
little concerning to pass references to an active LMB region outside of the=
 LMB
core.

>>
>> If we don't at least warn the user of these reservation failures,
>> there's a chance that this region could be freed and reallocated for
>> something important later.
>>
>> This useful warning mechanism was broken in:
>> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_rese=
rve_region()")
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  boot/image-fdt.c |  5 ++++-
>>  include/lmb.h    | 14 ++++++++++++++
>>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>>  3 files changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index a3a4fb8b558..0f5857f24d2 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size=
, u32 flags)
>>  {
>>         long ret;
>>         phys_addr_t rsv_addr;
>> +       flags |=3D LMB_FDT;
>>
>>         rsv_addr =3D (phys_addr_t)addr;
>>         ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, fl=
ags);
>> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size=
, u32 flags)
>>                 debug("   reserving fdt memory region: addr=3D%llx size=
=3D%llx flags=3D%x\n",
>>                       (unsigned long long)addr,
>>                       (unsigned long long)size, flags);
>> -       } else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>> +       } else if (ret !=3D -EINVAL) {
>>                 puts("ERROR: reserving fdt memory region failed ");
>>                 printf("(addr=3D%llx size=3D%llx flags=3D%x)\n",
>>                        (unsigned long long)addr,
>> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>>         if (fdt_check_header(fdt_blob) !=3D 0)
>>                 return;
>>
>> +       lmb_free_fdt_regions();
>> +
>>         /* process memreserve sections */
>>         total =3D fdt_num_mem_rsv(fdt_blob);
>>         for (i =3D 0; i < total; i++) {
>> diff --git a/include/lmb.h b/include/lmb.h
>> index 427d701bc30..c6a1fc1ca47 100644
>> --- a/include/lmb.h
>> +++ b/include/lmb.h
>> @@ -51,6 +51,15 @@
>>   */
>>  #define LMB_NONOTIFY BIT(3)
>>
>> +/**
>> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
>> + *
>> + * LMB Memory region attribute flag to indicate that the region will be
>> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reser=
vations
>> + * to be cleaned up and tracked more granularly.
>> + */
>> +#define LMB_FDT BIT(4)
>> +
>>  /**
>>   * enum lmb_mem_type - type of memory allocation request
>>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memor=
y
>> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_s=
ize_t size, ulong align);
>>   */
>>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size=
);
>>
>> +/**
>> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved region=
s
>> + */
>> +void lmb_free_fdt_regions(void);
>> +
>>  #endif /* __KERNEL__ */
>>
>>  #endif /* _LINUX_LMB_H */
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 8f12c6ad8e5..7ecc548d831 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr,=
 phys_size_t size,
>>
>>  static void lmb_print_region_flags(u32 flags)
>>  {
>> -       const char * const flag_str[] =3D { "none", "no-map", "no-overwr=
ite",
>> -                                         "no-notify" };
>> -       unsigned int pflags =3D flags &
>> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIF=
Y);
>> +       const char *const flag_str[] =3D { "none", "no-map", "no-overwri=
te",
>> +                                        "no-notify", "fdt" };
>> +       unsigned int pflags =3D
>> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LM=
B_FDT);
>>
>>         if (flags !=3D pflags) {
>>                 printf("invalid %#x\n", flags);
>> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u=
32 flags)
>>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags)=
;
>>  }
>>
>> +void lmb_free_fdt_regions(void)
>> +{
>> +       struct alist *lmb_rgn_lst =3D &lmb.used_mem;
>> +       struct lmb_region *rgn =3D lmb_rgn_lst->data;
>> +       long ret;
>> +       int i =3D 0;
>> +
>> +       while (i < lmb_rgn_lst->count) {
>> +               phys_addr_t base =3D rgn[i].base;
>> +               phys_size_t size =3D rgn[i].size;
>> +               u32 flags =3D rgn[i].flags;
>> +
>> +               if (flags & LMB_FDT) {
>> +                       ret =3D lmb_free(base, size, flags);
>> +                       if (ret < 0) {
>> +                               printf("Unable to free FDT memory at 0x%=
08lx\n",
>> +                                      (ulong)base);
>> +                               i++;
>> +                       }
>> +               } else {
>> +                       i++;
>> +               }
>> +       }
>> +}
>> +
>>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>>                            phys_addr_t *addr, u32 flags)
>>  {
>> --
>> 2.53.0
>>

