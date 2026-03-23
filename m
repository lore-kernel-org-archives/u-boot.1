Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECB5F483E1
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 18:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1779984206;
	Mon, 23 Mar 2026 19:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ep3NOds1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2D184206; Mon, 23 Mar 2026 19:39:07 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035BE84180
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 19:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyqtYcEuENyCDRApWeBpC/HbO+cMTy/YmLxdXuIr3GUr7vhU4PUWDF8qn0anogiHmXYRKywfS2UW5BrIB4EspPUuY3Ijv55opvqtCF6+yA6qhdCUK1ASabqQejGUPCuUss78aIGjDnL0enHmNnPCBNh237RLtsDeOXgVKJ5cuf9GiPq2ygvJg/Y9Bu8IkP1antoVbvaOTMU3HKJ7Zx1PjnVIdiGModC8e84X5RGenCztvlAs8jvqYfk/RNPi5FH8fnncx2VOlQvW8kUIeROhUPpKf/vwlz6QB938+zeR2VxOKJbIYIa6nlrTjNqPU2W6tkerjvc/QzZ3WNMTOOMBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YQEvq2llIx/bX9PyAXDiG/RU3acRHYMclAM6B2LhXQ=;
 b=fEHkj+Evxl6nN8pwzxdMExYWO73k61unvJNKpUQxq6vZo+sUhEMaSNX5BlfHU/g9DYpWIrvd80wi42eJX4WxIGyYaJ7d7RJthnsPHvFI3f+4E21xkSh/LZaGd+2s9Mu7X/3SecSzpVElnwtyXx1xjtQO3octtZGaemo4pjI6DKxd+2j/TKh/Bf0hQprzEwtafd0zLZnkB42J4ZKk91cKi9AXA9Pc07neJ2oMqN6RuH4ZtQUzRk9brLUxR5ZOt6FNFgnpejQy6rWKhctWvgphDqqdwkfOeY39Rj2ITxyMqPnp1bm2jrqYkJYfNSF0Xc/T6OiQ+uytDov10EcsEo/rYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YQEvq2llIx/bX9PyAXDiG/RU3acRHYMclAM6B2LhXQ=;
 b=ep3NOds1yUs7nXVOQk2LYHn1mVoNAOh/7COhM/y263/qsXXt0QOO9ShBT6hxNzXyHsM7lwZ/pa57FUBCGuztr7/XuV6ym+2v7kEc5Ru8+56nMGv3YuRiCfHU6UxdCuJ7pCM9zEc7DVlkEwagar6zulHYdh20vAV1UPuqKc4MUBE=
Received: from CH5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610:1f0::20)
 by IA1PR10MB6051.namprd10.prod.outlook.com (2603:10b6:208:388::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 18:38:59 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::64) by CH5PR05CA0015.outlook.office365.com
 (2603:10b6:610:1f0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 18:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 18:38:58 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 13:38:58 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 13:38:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 13:38:57 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62NIcvO0764189;
 Mon, 23 Mar 2026 13:38:57 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Mar 2026 13:38:57 -0500
Message-ID: <DHADPS26EJF5.V1N7K6FCTXCD@ti.com>
CC: <rs@ti.com>, <bb@ti.com>, <nm@ti.com>, <trini@konsulko.com>, <afd@ti.com>, 
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/3] k3-am62-pocketbeagle2: add support for 1GB variant
From: Randolph Sapp <rs@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Andrei Aldea <andrei@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-4-rs@ti.com> <DH7J0W8ZJCDY.27ZGBQPIP4TP5@ti.com>
 <CAOCHtYg3OcqNCP=vNtMDuDauFoUgED0o7t_8vAcPmo3M4Hxzhw@mail.gmail.com>
In-Reply-To: <CAOCHtYg3OcqNCP=vNtMDuDauFoUgED0o7t_8vAcPmo3M4Hxzhw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA1PR10MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: dc993ca8-aade-46f4-4b1e-08de890b7255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gt5bnQqOIRi1KWsPAlHtvdgGYVrzKnZkYLqSVBJzNx6TqV3MlOQQKmXejgHr80eyYUgMosv6TAf1uN2TilFl3p71akzpJB9U98RZ6/v27A+HQpvnFH2tUjjIc1lbXAos4XDLC5uKlCe9Jx0A4xZCY9ct/9zvpQI/WZ4CjN+KuWzj2xBxj1WjNcTpZGTyqR74DjAkjbnkGxFDzft7xXMwktFUAiD7EL+KTMwpUFBEgnua/0z6vkF0DQNC1fsjF+ZNKol+79cFzi/9z1QVzNBFojn8p6v79gr6dizWlhto3LedoUqfau/yMLi/c8a0tnp485aOtp4FeAhdUqXEYNKA08XlQqVee6eCGC8yISqwesktyYRmsJsHeX6Zw2z5Ym6oLuM3d22C3fEx/2uNaaxmd52DFSeyaUkLhmU8Q4t1ggQ0Sf34d0nnRNBr/YBar8FqAjLP5rLkybTEtB2ecBhXOx5cov9dxRNtGCmyKDi9+2dO8klqJfEHMmvb7Bp58EgORwTcElJOLI4GrhmdOxTIsvAYkbQeDZM/dn+99XOL5wkwA0npd2F0y/gkSXqjIm/CGzFKdVoNt3UVI5zxQprhmgP4dRd9tepCVY9Qzi4QQUAk8HDlqfPsjGNugS+oAKyfeNrwZuMe9aVMrqD9nyPtGOIbzy36M287sZDGK5BnMvUhGrnmxhoTwblMnLJqAn0/Kyd2VNkhj7FAEvvzvtN3Mw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m4F0eTl5Vg/Ml8ucGvt7hBsKbhWzbzrovjdpeselMYYR7p2uZBBADnrriZr8uDtXNk2mas+UlVW5BeoioPDPlv1+H7VK5I//HargzXub3DuGWnucOFpzsmFRCGWwsw8Pl6F+CR5gYHPo9A0exi8VuPkP+rrxWyXA/easWiOe1NX95EHPTo7BIy6Ziv0tdkzJPF+IO4rZ/rLZosZZvd0aMpaZvVSsRe2lU2MGJGf+hBMF9yvsIXc0Por0j+V3RGt5st1Al4Ry4s1X4PX81nE/9IK0p0iQgNgUGAWvNGUZO9uaNuBJsn2Tn3XN+JNoHtDzkBXg4Y1iC9gYhRSrhfGaa3bnO9OI3TXlAqLW8WH/7UndQPsodEhy27rVwSH7ukrZYLw4T4tJzW2V0vlFyXfKJBVtExp6Zcm02y45H813OdixiBn+A9bqRWVmaipOkpQi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:38:58.7999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc993ca8-aade-46f4-4b1e-08de890b7255
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6051
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

On Fri Mar 20, 2026 at 10:26 AM CDT, Robert Nelson wrote:
>> > +
>> > +config POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
>> > +     bool "Set the PocketBeagle 2 RAM size instead of detecting it"
>> > +     default false
>> > +     help
>> > +       RAM size is automatically detected through the device revision=
 stored
>> > +       in EEPROM. This overrides the detection logic with a fixed val=
ue.
>>
>> With the ability to detect the board type via the EEPROM, is there any
>> use to having this option?
>>
>> IMO we should just let the board boot with runtime detection for DDR
>> size everytime. This config option just makes the execution harder to
>> understand while providing minimal value.
>
> Phytec also does that with their boards that detect memory sizes, i
> think Randolph was trying to mirror that kconfig section..

Yeah, I specifically like the option to override the detection logic if use=
rs
have unusual hardware configs or boards that do not follow the loose
identification scheme defined in the automatic fixup path.

>>
>> > +
>> > +choice
>> > +     prompt "PocketBeagle 2 RAM size"
>> > +     depends on POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
>> > +     default POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
>> > +
>> > +config POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
>> > +     bool "512MB RAM"
>> > +     help
>> > +       Set RAM size fix to 512MB for the PocketBeagle 2.
>> > +
>> > +config POCKETBEAGLE2_AM62X_RAM_SIZE_1GB
>> > +     bool "1GB RAM"
>> > +     help
>> > +       Set RAM size fix to 1GB for the PocketBeagle 2.
>> > +
>> > +endchoice
>> > diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocket=
beagle2/Makefile
>> > index 3d42c160716..dd529fe6d75 100644
>> > --- a/board/beagle/pocketbeagle2/Makefile
>> > +++ b/board/beagle/pocketbeagle2/Makefile
>> > @@ -7,3 +7,5 @@
>> >  #
>> >
>> >  obj-y +=3D pocketbeagle2.o
>> > +obj-${CONFIG_K3_DDRSS} +=3D ../../phytec/common/k3/k3_ddrss_patch.o
>> > +obj-${CONFIG_TI_I2C_BOARD_DETECT} +=3D ../../ti/common/board_detect.o
>> > diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle=
/pocketbeagle2/pocketbeagle2.c
>> > index b6768caa34b..1bfc79350b6 100644
>> > --- a/board/beagle/pocketbeagle2/pocketbeagle2.c
>> > +++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
>> > @@ -15,15 +15,123 @@
>> >  #include <spl.h>
>> >  #include <asm/arch/k3-ddr.h>
>> >
>> > +#include "../../ti/common/board_detect.h"
>> > +#include "pocketbeagle2_ddr.h"
>> > +
>> > +DECLARE_GLOBAL_DATA_PTR;
>> > +
>> > +static int pocketbeagle2_get_ddr_size(void)
>> > +{
>> > +     // check config overrides first
>> > +     if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_FIX)) {
>> > +             if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_512MB=
))
>> > +                     return EEPROM_RAM_SIZE_512MB;
>> > +             if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_1GB))
>> > +                     return EEPROM_RAM_SIZE_1GB;
>> > +     }
>> > +
>> > +#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
>> > +     // dynamically detect the config if we can
>> > +     if (!do_board_detect_am6()) {
>> > +             struct ti_am6_eeprom *ep =3D TI_AM6_EEPROM_DATA;
>> > +
>> > +             if (strlen(ep->name) > 11 && ep->name[0] =3D=3D 'P') {
>> > +                     /*
>> > +                      * POCKETBEAGL2A00 (am6232 512MB)
>> > +                      * POCKETBEAGL2A10 (am625 512MB)
>> > +                      * POCKETBEAGL2A1I (am625 1GB)
>> > +                      */
>> > +                     if (!strncmp(&ep->name[11], "2A1I", 4))
>> > +                             return EEPROM_RAM_SIZE_1GB;
>> > +             }
>> > +     }
>> > +#endif
>> > +
>> > +     return EEPROM_RAM_SIZE_512MB;
>> > +}
>> > +
>> >  int dram_init(void)
>> >  {
>> > -     return fdtdec_setup_mem_size_base();
>> > +     if (!IS_ENABLED(CONFIG_CPU_V7R))
>>
>> I don't have a 1GiB pb2 to test with but I'm assuming the fixed up
>> memory nodes get passed from the R5 SPL to A53 SPL and then finally to
>> U-Boot as part of fixup_memory_node from k3-ddr.c.
>
> @Andrei Aldea ^ can you help ;)
>

Andrei has agreed to give me a board tomorrow so I don't have to test this =
all
through a proxy.

>> Could somebody confirm if this is indeed the correct flow? I wanted to
>> see if both A53 SPL and U-Boot receive the correct memory size as part
>> of their DT.
>
> Sadly while developing this, the DT memory values were not passed
> between the R5 SPL and the A53 SPL ( and thus A53 main )..
>
> After thinking about this routine since I came up with it last month,
> it might be better to do 2 device-tree's...  So with 512MB default
> path, for 1GB, patch ddr timing in R5/SPL and force 1GB device tree.
> Then A53/SPL (and main) would have the correct memory size..
>
> Currently, we read the eeprom 3 times, R5 SPL, A53 SPL and A53 main..
> (but we only need it really twice, R5 SPL (ddr patch) and the A53 main
> (device-tree values patching..)
>
>
>>
>> > +             return fdtdec_setup_mem_size_base();
>> > +
>> > +     return 0;
>> >  }
>> >
>> > +// logic after this block assumes that there is only 1 DRAM bank curr=
ently
>> > +#if CONFIG_NR_DRAM_BANKS !=3D 1
>> > +#error Unsupported number of DRAM banks!
>> > +#endif
>> > +
>> >  int dram_init_banksize(void)
>> >  {
>> > -     return fdtdec_setup_memory_banksize();
>> > +     u8 ram_size;
>> > +
>> > +     if (!IS_ENABLED(CONFIG_CPU_V7R))
>> > +             return fdtdec_setup_memory_banksize();
>> > +
>> > +     memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]));
>> > +
>> > +     ram_size =3D pocketbeagle2_get_ddr_size();
>> > +     switch (ram_size) {
>> > +     case EEPROM_RAM_SIZE_1GB:
>> > +             gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
>> > +             gd->bd->bi_dram[0].size =3D 0x40000000;
>> > +             gd->ram_size =3D 0x40000000;
>> > +             break;
>> > +     case EEPROM_RAM_SIZE_512MB:
>> > +     default:
>> > +             gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
>> > +             gd->bd->bi_dram[0].size =3D 0x20000000;
>> > +             gd->ram_size =3D 0x20000000;
>>
>> We can make use of SZ_512M and SZ_1G macros here.
>>
>> > +             break;
>> > +     }
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +#if IS_ENABLED(CONFIG_K3_DDRSS)
>> > +static int update_ddrss_timings(void)
>> > +{
>> > +     int ret =3D 0;
>> > +     u8 ram_size =3D 0;
>>
>> Having a u8 of "ram_size" is confusing, we should  make it explict that
>> it's an index into pocketbeagle2_ddrss_data.

I assume you just want some explicit typedef for this then? Or was your com=
ment
more about the naming?

>> > +     struct ddrss *ddr_patch =3D NULL;
>> > +     void *fdt =3D (void *)gd->fdt_blob;
>> > +
>> > +     ram_size =3D pocketbeagle2_get_ddr_size();
>> > +     ddr_patch =3D &pocketbeagle2_ddrss_data[ram_size];
>> > +
>> > +     if (!ddr_patch)
>> > +             return ret;
>> > +
>> > +     ret =3D fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
>> > +     if (ret) {
>> > +             printf("Failed to apply ddrs timings patch: %d\n", ret);
>> > +             return ret;
>> > +     }
>> > +
>> > +     return ret;
>> > +}
>> > +
>> > +int do_board_detect(void)
>> > +{
>> > +     void *fdt =3D (void *)gd->fdt_blob;
>> > +     u64 start[] =3D {gd->bd->bi_dram[0].start};
>> > +     u64 size[] =3D {gd->bd->bi_dram[0].size};
>> > +     int ret;
>> > +
>>
>> Nit: formatting (done with clang-format)
>>
>>         -       u64 start[] =3D {gd->bd->bi_dram[0].start};
>>         -       u64 size[] =3D {gd->bd->bi_dram[0].size};
>>         +       u64 start[] =3D { gd->bd->bi_dram[0].start };
>>         +       u64 size[] =3D { gd->bd->bi_dram[0].size };
>>                 ...
>>         -       snprintf(fdtfile, sizeof(fdtfile), "%s.dtb", CONFIG_DEFA=
ULT_DEVICE_TREE);
>>         +       snprintf(fdtfile, sizeof(fdtfile), "%s.dtb",
>>         +                CONFIG_DEFAULT_DEVICE_TREE);
>>
>>
>> > +     dram_init();
>> > +     dram_init_banksize();
>> > +
>> > +     ret =3D fdt_fixup_memory_banks(fdt, start, size, 1);
>> > +     if (ret) {
>> > +             printf("Failed to fixup memory banks: %d\n", ret);
>> > +             return ret;
>> > +     }
>> > +
>> > +     return update_ddrss_timings();
>> >  }
>> > +#endif /* CONFIG_K3_DDRSS */
>> >
>> >  #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
>> >  int board_late_init(void)
>> > diff --git a/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h b/board/be=
agle/pocketbeagle2/pocketbeagle2_ddr.h
>> > new file mode 100644
>> > index 00000000000..6d248ce6dfa
>> > --- /dev/null
>> > +++ b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
>> > @@ -0,0 +1,50 @@
>> > +/* SPDX-License-Identifier: GPL-2.0+ */
>> > +/*
>> > + * DDR override logic for AM625 PocketBeagle 2
>> > + * https://www.beagleboard.org/boards/pocketbeagle-2
>> > + *
>> > + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti=
.com/
>> > + */
>> > +
>> > +#ifndef __POCKETBEAGLE2_DDR_H
>> > +#define __POCKETBEAGLE2_DDR_H
>> > +
>> > +#include "../../phytec/common/k3/k3_ddrss_patch.h"
>> > +
>> > +enum {
>> > +     EEPROM_RAM_SIZE_512MB =3D 0,
>> > +     EEPROM_RAM_SIZE_1GB =3D 1
>> > +};
>> > +
>> > +struct ddr_reg ddr_1gb_ctl_regs[] =3D {
>> > +     { 317, 0x00000101 },
>> > +     { 318, 0x1FFF0000 },
>> > +};
>> > +
>> > +struct ddr_reg ddr_1gb_pi_regs[] =3D {
>> > +     { 77, 0x04010100 },
>> > +};
>> > +
>> > +struct ddrss pocketbeagle2_ddrss_data[] =3D {
>> > +     // default configuration
>> > +     [EEPROM_RAM_SIZE_512MB] =3D {
>> > +             .ctl_regs =3D NULL,
>> > +             .ctl_regs_num =3D 0,
>> > +             .pi_regs =3D NULL,
>> > +             .pi_regs_num =3D 0,
>> > +             .phy_regs =3D NULL,
>> > +             .phy_regs_num =3D 0,
>> > +     },
>> > +
>> > +     // industrial configuration
>> > +     [EEPROM_RAM_SIZE_1GB] =3D {
>> > +             .ctl_regs =3D &ddr_1gb_ctl_regs[0],
>> > +             .ctl_regs_num =3D ARRAY_SIZE(ddr_1gb_ctl_regs),
>> > +             .pi_regs =3D &ddr_1gb_pi_regs[0],
>> > +             .pi_regs_num =3D ARRAY_SIZE(ddr_1gb_pi_regs),
>> > +             .phy_regs =3D NULL,
>> > +             .phy_regs_num =3D 0,
>> > +     },
>> > +};
>> > +
>> > +#endif /* __POCKETBEAGLE2_DDR_H */
>> > diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_po=
cketbeagle2_r5_defconfig
>> > index e863204cfef..d72f78b932c 100644
>> > --- a/configs/am62_pocketbeagle2_r5_defconfig
>> > +++ b/configs/am62_pocketbeagle2_r5_defconfig
>> > @@ -14,7 +14,7 @@ CONFIG_DM_GPIO=3Dy
>> >  CONFIG_SPL_DM_SPI=3Dy
>> >  CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am62-r5-pocketbeagle2"
>> >  CONFIG_DM_RESET=3Dy
>> > -CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x7000
>> > +CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x8000
>> >  CONFIG_SPL_MMC=3Dy
>> >  CONFIG_SPL_SERIAL=3Dy
>> >  CONFIG_SPL_DRIVERS_MISC=3Dy
>> > @@ -42,6 +42,7 @@ CONFIG_SPL_SYS_MALLOC=3Dy
>> >  CONFIG_SPL_EARLY_BSS=3Dy
>> >  CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
>> >  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x400
>> > +CONFIG_SPL_I2C=3Dy
>> >  CONFIG_SPL_DM_MAILBOX=3Dy
>> >  CONFIG_SPL_DM_RESET=3Dy
>> >  CONFIG_SPL_POWER_DOMAIN=3Dy
>> > @@ -73,6 +74,8 @@ CONFIG_SPL_CLK_K3_PLL=3Dy
>> >  CONFIG_SPL_CLK_K3=3Dy
>> >  CONFIG_TI_SCI_PROTOCOL=3Dy
>> >  CONFIG_DA8XX_GPIO=3Dy
>> > +CONFIG_DM_I2C=3Dy
>> > +CONFIG_SYS_I2C_OMAP24XX=3Dy
>> >  CONFIG_DM_MAILBOX=3Dy
>> >  CONFIG_K3_SEC_PROXY=3Dy
>> >  CONFIG_SPL_MISC=3Dy
>>

