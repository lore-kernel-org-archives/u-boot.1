Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5B6E88D72
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 00:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C9C839A8;
	Sat,  4 Apr 2026 02:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rLtbYo+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919E983B8F; Sat,  4 Apr 2026 02:08:16 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D34280077
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 02:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL/WbUkTU/Oy1aIdSBQnQOGySkNL85GwW5gMtaqpBPCKt0iV2+L4bxnFMOfDqmhkp3ZIzAg9ScqT/O834S5wnVUG6Zepv+xH7TEQ+AAgwjN0vJWOkThgkxPicz08AcvWKSKz2JZtb/DDyon1n2S0Vn8d7hBw6WQR8XMH4DwPTTBjJ/44InvgcOgNaaMuIkPle7JmPDHqmCi21C/NrBbWwjaETXyARmh40M0S1YJ2b7OXR8xJ9gko25ZIStGeuoNXgQrEFRHCUMzt66KowA7JuWXwgMZ2yn0OumO69O70BZMKfgoRM7A7WWzs+mCHxGeBbmQGNfzKNivot1sFlxsDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6SGK2Zo1VDN3sVSZeP/X/iX2HvFv8rhqCRwbrX5AfQ=;
 b=R65kTpvq72lkkXAjBboIz8vbUuozDp/mhuWq+7h7WL0QK0fbB2b0bxCJTwrGMzFfp/FCampZ2ftYJ+W+JU6ei7B+aLqg2HB1ctcO9VZ0/KHsgyr1i8zQrhdlrj3xAI8J9Gxz/WqnXnxWW5G0uyP2SND9XjgxPLQcKcTTbvCa9mHI+GBA589sDxtNqYVF6zHGu2xEH2X05fjSLKsJ2fUW9yGaPH7263p15kbW+XugRbYLF76fwI9TbvudN3ZLGjx7tKjCysRJDGEEY9PFfVei5os4FKxISvy4KOJCLDRBqUmBNk8hQPg+TgvZS5inftiEp2iaiMI2OskyIXVthti5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6SGK2Zo1VDN3sVSZeP/X/iX2HvFv8rhqCRwbrX5AfQ=;
 b=rLtbYo+HcW/XQiB/hjVPihCNmmnBR2IOF3OqnKE95FGXdSklnZW9orPCi5JQyDnUdzNKm7D78Z/CylaX6U5wBqcajk1A+rNLH0xsYsjNdtqC2KWq0OhL1OqdacqdY77xM66pl1p4CetI/xUyilwLK1bN5j3qMVZAlS7hC9nqPC0=
Received: from CH2PR14CA0035.namprd14.prod.outlook.com (2603:10b6:610:56::15)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sat, 4 Apr
 2026 00:08:09 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::55) by CH2PR14CA0035.outlook.office365.com
 (2603:10b6:610:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Sat,
 4 Apr 2026 00:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Sat, 4 Apr 2026 00:08:07 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 19:08:06 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 19:08:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Apr 2026 19:08:06 -0500
Received: from localhost ([10.249.32.65])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 634086R9707898;
 Fri, 3 Apr 2026 19:08:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 3 Apr 2026 19:08:06 -0500
Message-ID: <DHJXLS85SGO8.7U7T6E8CCW6P@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi_memory: backfill EFI_CONVENTIONAL_MEMORY
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-6-rs@ti.com>
 <CAC_iWjKbeph+3M=GDy3_KeprSaUTVd3375O3Ny9GPV14XNBUgg@mail.gmail.com>
 <DHIUKA2JVA4H.V11Z7EF0I1A1@ti.com> <DHIXO2TK649C.JAGU2F3IZ91S@ti.com>
 <CAC_iWjK=Fx80=Zh73f01oLvQETd8qiuqWyVXCDDpQcwC=BDdtQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK=Fx80=Zh73f01oLvQETd8qiuqWyVXCDDpQcwC=BDdtQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: bc172765-10bd-4079-3342-08de91de4018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vKpZwTw2qQwcgrJEr8ArITQgXblHJpzEroIg4WPI2NKUH1SkYzbOGAShqSl+5DqENxkkBLWqBLiYgn4VieXUz6spv4EQniM/+BPGLrQtvm8DVwHkaxmpYiDFg4bar1tspgZ8v5EddCcd1AsUIc402+WihP+JRIK9m/Mnr1WraqL41nQ1EcTBokgad8iA+IMgPwIINIex2SWkLI+fwtmJ5/v0ohzotwWn+Ax7dRtmRfw6csdVEeBa0V2XMknMpvE/+CW/bcZYBZlIs5u2Q/cUQ5WDyOm1WAqAh9rznhlzYuOHeTPVpgMCpQV66WBq6dfspx3kTCktIkyY3LQfQ8MvN9w324blirMRP92f0cH9hTyFIFib5GLPvRw4qvYViTT7mqYEdsDJfg0m5dyadRa54jdpY4XVMMxue0taStR8wSXwmz3EH92MESdCLIJbkGI6XfM48vSHu++Ns4kE1OEZOcEGfNaNPoUa2v8u9ZeYl6e8yPGH6YbB0DPoaMKmrM+34+BYqhjp9L639lq/sIxDsIElLds9aElik5kaybeI+auH2dJCVtpScsKcSRJh+oKl3p2XY1HwW5IRJixQg2Q20LQZtnh7VotWNS1AN65SKnEBz/bzsURwOb3m7zyYrKShmk43ba/PP0WxT6iEMwmHgZ0MODU7/TgeNvsiiU4FjWr0ihzD6WLv+1nzOJsa+CZ8ZLDNpp2ZUiV5xr3AeRQZr3n7h5kSn9UpksI5A1dlOmIErBNd+5ix28tatrUPfVsbapF7U38DiEFUwy8g5xICDg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +8XuXeHm5E8mmnl/+RUwW/OWETcO68JrQjrBfHowRrf4cVSOmX1qg5NMaxNiuD1csNMW2cY03vcGn2canUXW1E89IzNyGA1p9hU3m+1wInAIGj6DQ/6Fg3K1GA8YWE4b2d/xvJmDc9plXHGAaEt+Wblf29IfVyd1KMmCkXQhfTZhlA3yWJ0e8DT1/GQRphB00sqiAqxUVzJ+kJG/jeWDST51yBH5SmBr5dFtbFmt84KZ4IrrYPcq+HIWQElyeFUjYLcw/lteoDAa1VPUgQkjEb3ryY+2ixnICAL6+xfbpB2SUYv06rkG3FH3fc3ZVTql2b1hOIQHagPE6Glu588c4v6+yqJHZ+EYh3kEMtCZ0sdWBWmfCzZcaHjIUZxaknPZl8pQGx2pShCIWflbY4JBVzg7AtekxBTT/P4Fcd/FLkD7TaS5lsdoGMANHE/i6ji4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 00:08:07.6235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc172765-10bd-4079-3342-08de91de4018
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
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

On Fri Apr 3, 2026 at 12:28 AM CDT, Ilias Apalodimas wrote:
> [...]
>
>> >>
>> >>> +}
>> >>> +
>> >>>  /**
>> >>>   * efi_allocate_pages - allocate memory pages
>> >>>   *
>> >>> @@ -507,10 +528,20 @@ efi_status_t efi_allocate_pages(enum efi_alloc=
ate_type type,
>> >>>         /* Reserve that map in our memory maps */
>> >>>         ret =3D efi_update_memory_map(efi_addr, pages, memory_type, =
true, false);
>> >>
>> >> In theory the lmb and the EFI maps are in sync. I haven't checked
>> >> close enough yet, but do you have cases where lmb_alloc worked and
>> >> updating the efi memory map failed?
>> >
>> > Fair point. Now that I've fixed the FDT warning I should probably chec=
k if I can
>> > actually reproduce the issue that actually required this.
>>
>> Yeah, this patch isn't necessary anymore. I suppose it should be dropped=
 as it
>> would potentially mask any discrepancies between the two maps.
>
> Yea and if we really need a similar fix in the future, it's best if we
> put in the lmb core code.
>
>>
>> Out of curiosity, is there any plan to merge the EFI and LMB allocators =
more in
>> the future, or is the current layering scheme the furthest we want to go=
?
>
> We do, but havent due to lack of time. It's been a while since I
> discussed this with Heinrich but iirc the only thing missing is for
> lmb to be aware of the memory flags EFI expects.
>
> /Ilias

I mean, trimming the last x bits off of the LMB allocation flag value to st=
ore
the current EFI enum is a little bit of a hack, but honestly it'll allow th=
e
current allocation coalescence logic to continue to work as-is. It would ju=
st
need helpers to store and retrieve the enum type for the code that actually
cares about the EFI memory types. I could look into doing that if you guys =
think
that's a valid approach, or if you've got other ideas.

>>
>> >>>         if (ret !=3D EFI_SUCCESS) {
>> >>> -               /* Map would overlap, bail out */
>> >>> +               /* Map would overlap, try something else */
>> >>>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>> >>>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
>> >>> -               return  EFI_OUT_OF_RESOURCES;
>> >>> +
>> >>> +               /* See if there is any EFI_CONVENTIONAL_MEMORY alloc=
ations */
>> >>> +               if (type !=3D EFI_ALLOCATE_ADDRESS) {
>> >>
>> >> Can you please inverse this. It's going to reduce the identation.
>> >> if (type =3D=3D EFI_ALLOCATE_ADDRESS)
>> >>> +                       *memory =3D efi_get_conventional_start(pages=
);
>> >>> +                       if (*memory !=3D 0)
>> >>
>> >> Same here
>> >>
>> >>> +                               return efi_allocate_pages(EFI_ALLOCA=
TE_ADDRESS,
>> >>> +                                                         memory_typ=
e, pages,
>> >>> +                                                         memory);
>> >>> +               }
>> >>> +
>> >>> +               return EFI_OUT_OF_RESOURCES;
>> >>>         }
>> >>>
>> >>>         *memory =3D efi_addr;
>> >>> --
>> >>> 2.53.0
>> >>>
>> >>
>> >> Thanks
>> >> /Ilias
>>

