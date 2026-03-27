Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200C10F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD0B841CD;
	Fri, 27 Mar 2026 17:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="NNEsLa7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD48F83EB3; Fri, 27 Mar 2026 15:14:19 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF71E81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8QctoLqVEBzh7mRutZCKIad7a6PuN6PqSLa6vRP6A4g1bkDeuOYY+T4fu02G2UDZwUPY4GmtEth+kz2smgxydrktiJcmwji6nEipU2HDqpH4QM1DO+jxOUTUHrw1R5QSF+BOT4DqmOdVO4/j7hvUElbUDlGXzTRe60SfZ6MMSV8RnO6c7FmmIybw1/cpwb7Mb94OX+Y1HDQS76Zgwf5bP/v8wcjpCjcGMy7qSuNK13iYEBnKdBlJqkcwOsU8jH+DJ67HBhoG5v1lo+Cq5iFR+fCwJ5YEajiMtPRED5/R7AzWFhF/aP8v2pzx04UE7Tfgs1qxlIhc3SepPH988eQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVHLHuscOBTaMKr+g9xdfmDdsm3bER3UNV7HEyVzays=;
 b=yB+TAEQAJzwPdFecMzmpZl+yfrevLMyNRhE7lP15/fQcnhjG2+B72X0zLxRZMbqBcUxoPka2QO77KfBt3i1WkuSirk/wQBc6/TnX2uplLHJqMEiJZ6a14JqDFTahNbuOWSXf0aEpEBT0aWFL8LcJfPyF+l78ctOz2ognDdbq8TcbUu1BcsOVgfFIN8Y2xldZHvfzblo4SorSDlfCtOl1hH5IQHKp57uGxdr9XX84xh+jAZgpXMAZaGF+JT6cnvqQb+zCNJ6iwVc+q18r2m5/pCz72GPsfnQD5QUAwVgukzkTn2HpVgtuzAMu+/Mn9PxmkT2bJDcQecNydTbazWkfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVHLHuscOBTaMKr+g9xdfmDdsm3bER3UNV7HEyVzays=;
 b=NNEsLa7xY93wvKiQl4ZmmE0zJwwv0PfMeTsjehdwT8tWWcllRZgNCYgx8TKPBtyvuBslsInPl5kgCgF5L+X7D6Nvhvg8fiD4ggJvCMXMO2K9VR6WOgGhdqunuu8SdQg7Pb/Av8UZZgEMOtnRq0LoyS70O5JnwoeSXB7vOyPX0B4ckx2/u97Oql3CD7/AA4Msf9ngSluQbJgjr+3Z4D7GJOHN6HGSp0ItJfvfHcAhYQ29WNb5lgb+HSAOVf4OJOrVr/s9ZwyfrthSVfEnxKNcgkFWt5MAI/zMS/AqX82Fn4ru7fpMxh1Rw68BDLrOeMlYXVwTFXbYOXG0rc3DXHkQMA==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by VI2PR09MB8564.eurprd09.prod.outlook.com (2603:10a6:800:328::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 14:14:14 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 14:14:14 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v6 5/7] riscv: Add syscon driver for MIPS GIC block
Thread-Topic: [PATCH v6 5/7] riscv: Add syscon driver for MIPS GIC block
Thread-Index: AQHcvfP9tVMTCB6j4kiQIX06gSbUDw==
Date: Fri, 27 Mar 2026 14:14:14 +0000
Message-ID: <20260327141029.628483-6-uros.stajic@htecgroup.com>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260327141029.628483-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|VI2PR09MB8564:EE_
x-ms-office365-filtering-correlation-id: 43e988dc-3a97-43d3-fad2-08de8c0b2020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Y39gMxZT1gwHUtLG9HsjGfoK6PmoYdJWs0h2tN9necMiUo2LJ4KqqCXtBfxEKlI6P30gBK3m/e7OpEFdKCLGY+F/wloqpK1FUy0iBr6aOhYPpYXT/dtP4tHI8eo86NoQi/ox8J1zM6JiouBWSNvC2wz/RQyYsz1rhRgvAioJFt4TQZHbRgR+sIz2WR4LLS6o/7gdU579VyaF8+Ln+Mf6VS7f3Nlthf8REyrjXyy8XF7zo+MT8NmazFZiQpwu0VLmmtsQJsFAR1geVgsJH6I5hHEVfKdbugKmK/ORKqXHiSx6JpI798BoH7m70TtHqA8zF26nkWQdWlCAKteKSwYvCuXkqg6ywMqcnk5guMT+uecELTzhKpL7i1ZDZ2kZM3QcscooUOoivNmm1qkscVQjwIKlC/Ui1V4Hd0f3MzYXXGOXRIrrDTZVlsG4UM2clLj+XuyK0hItlgVcOHRUiZTirqsbMDtcY4ofJXYNhOYN4xsOgxpmgUD6rxjJ3L/rPNQzT9P8ms1j+hjHFavWExY5yMXnowQ/mo85Q/cZqon/4SvZZCvyDTtRE49/KfYJvwWs86ZD3pXfeKowLQ7J6ykgB0MdAw5qeisJMMTP8ozH4afolfdoflPpvJDtswFen1lgjPIQjGNa8TiSz+9QBQ+jxGDltDi1w2lM1PLiJgvUcXfqWLqxiTzq2q5MCrHIK+2xGUMp7pl962Roqm8YfbpEPHEqFCBKgPQuSz/8ELGBP/djKSV+pL+kgSfxNR7LiM9uIPWbEr/6ceiJHAcPYc8uB/mo+19QzU6+DAD4g2o1/T4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nXwTYI3MlnBdXZF8mJuaGXcbu+QXJ5oHCxUb4w6xtSVT7EOh2Jf257OG5L?=
 =?iso-8859-1?Q?82gbPHt3rUYVZbws4fhM24VMFODVEu2MqqXIWayrchV88e0XHj5jcHPrVk?=
 =?iso-8859-1?Q?DfyGagywCThQOWEAYUycpSlxQ/zuYB0uNgpFYlMiFK42pmILs9VDSEFRPB?=
 =?iso-8859-1?Q?chso8GSXS5GLaXbL0HFKptpHZwCAykKMQNvO7cEUBiXP+XlsDNncxvjF7r?=
 =?iso-8859-1?Q?KgvCseU0RDZEBWypUuPqqDW0VX8nyfs3uYdHUX5Ql/5ETkr5MP8/hb/aP+?=
 =?iso-8859-1?Q?o0i00HE9KNzTmePOHFckDacBZH08u7BDLAcrLL1M34ihxZaP43Smq6hQeD?=
 =?iso-8859-1?Q?4B3dzos3eaptlPEGj0GKjji1tB2bOm7if8AtpX+ke8jryLh6WD6WHiMNcC?=
 =?iso-8859-1?Q?2dmdyb8a2rnBxMkhVdHsI3TppzZNT9row7AoiHrTHsCg6dQXpJ+3QP43Y1?=
 =?iso-8859-1?Q?29gaoeSytqiGC1xbH97b2lcBwceaDe1foUdIIwR3w02h1Lbsk830OTXkdC?=
 =?iso-8859-1?Q?uRfUVcxj6RKbkF5g/PI5wT1jtQKo2L1dqQ6I3fNkUeOM1EqUGxRKQb2M/o?=
 =?iso-8859-1?Q?TaTBEOfsHoHwpj/cG/ax9EepsNQ+HY/qv4F3g4KwYOBNj2UMlWrB11Jmde?=
 =?iso-8859-1?Q?kbwN3WBKv5hP+LtLnnTIuPzwKB3W0nHLEg2bghqaEGKdnEl3a7zdx79RgG?=
 =?iso-8859-1?Q?dRmKgGwipm3yi+J+5xB0m5F9hi89u/aPtdS9dXGjTZrACjohF0yHMOH1Fe?=
 =?iso-8859-1?Q?V5Ye5ByIyRbA4ZkAx6/IYZpE8AAVjCkfuIotofzHsXqtSFaONjcqB1SQqb?=
 =?iso-8859-1?Q?7BICrV9nX7quoGC2MquFNGRjfB7DiJxVReKbRhV5vBufVV9o1huU07BPvs?=
 =?iso-8859-1?Q?BlbbIT+n4avjYXFnAv4gLGPbWFgHNydWwwn7t63L+RM26JVyRBe/J7tk1w?=
 =?iso-8859-1?Q?2R8rhHk4NCeXKy45Ch0LiYLSdGPTze67iHPx1qeMvM8XDlJpm3Nhr1WlKq?=
 =?iso-8859-1?Q?QLyIHiCVeK4W5jrQaYdCF2tjXfbkvDPgy1r3ba3nIzH0VIbXWQSE/BcGKy?=
 =?iso-8859-1?Q?V6W6BFHYz8rx/br8DbkO4qzbBdH1jm+B3FvR3zqObgyOTapgHJfzrxbTkL?=
 =?iso-8859-1?Q?EpHFiZ2G5QUuCmhbgGPv3KgGJDwSI6QhNpVp8Fvtvd5tJbkgE27Y3wx/wa?=
 =?iso-8859-1?Q?Oomg8MbO0e1mUGrhg/k7EIwCknv5+0r3XpP/D+eXgoWvVjk9h9Nix2VeDG?=
 =?iso-8859-1?Q?NyrysMLk5/6vGKmRedF4tz5C2hXW3JEGsMtjBL9ss3/RM5e21y1t8aa8qA?=
 =?iso-8859-1?Q?0s0eqg/uo4zCuHWutBfPkurtZ/G7hsi3LO3L5Vw5SE+eC9IliXgdNfOvt/?=
 =?iso-8859-1?Q?FAsxw/f3vEDyJomkK689DXgfURrsfVlpXmFHs/R2pR2gVKpgMn2uih3PCk?=
 =?iso-8859-1?Q?9O2YExl8qtDH7lco6dje9uiEUDRdLkDs1FsCJ0SBXTh7u/GgcG6rdTEd6X?=
 =?iso-8859-1?Q?yHzKfWrXGT1vbLbrM7tQoDLm4pkQvsnHpgDxX3+8F9Ng8bGAzxDFrUyQ1A?=
 =?iso-8859-1?Q?v0izYsBf5gTmArXeLY9C3uecTQC9s0/8zOOZS9eZsWbLyyJRYVdEn2pHh2?=
 =?iso-8859-1?Q?PRzTKERIoZ8CN+I9g8X88NiIVz9MTlzBucMCpCkGgXD8bYoF+YxMauPXrV?=
 =?iso-8859-1?Q?Dwz39gzJDPkcqbBHerwAQyZORS/aKYfKtaKtCRz31owjet9OUDprifKSb8?=
 =?iso-8859-1?Q?2j19Q2nxX+5cVBWHF83F/WKY6OPYcxE5kdq7BbTuOiq4IoXN0d3zpnpEKR?=
 =?iso-8859-1?Q?+1xkGt5Gf8+PBuwZeM9kJV1nMJ5Hde8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e988dc-3a97-43d3-fad2-08de8c0b2020
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 14:14:14.4355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O4617Qyth53hJXJ6meQmV7ZFbLviuYTmVCeuStpRtgbw5j2E+kQluXQwoEqCjZrK+B4ptWCxIlmUzDYRR/6HOv2vLNOhKxvJMlpNMdIC6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB8564
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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

From: Chao-ying Fu <cfu@mips.com>

Add a UCLASS_SYSCON driver with DT match for the MIPS GIC block, so it
can be accessed via syscon/regmap.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                  | 11 +++++++
 arch/riscv/lib/Makefile             |  1 +
 arch/riscv/lib/mips_gic.c           | 47 +++++++++++++++++++++++++++++
 board/mips/boston-riscv/MAINTAINERS |  1 +
 4 files changed, 60 insertions(+)
 create mode 100644 arch/riscv/lib/mips_gic.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d27e999340..60ce302a34d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -408,6 +408,17 @@ config SIFIVE_CACHE
 	help
 	  This enables the operations to configure SiFive cache
=20
+config MIPS_GIC
+	bool
+	depends on RISCV_MMODE || SPL_RISCV_MMODE
+	select REGMAP
+	select SYSCON
+	select SPL_REGMAP if SPL
+	select SPL_SYSCON if SPL
+	help
+	  The MIPS GIC block holds memory-mapped control and status registers
+	  associated with software and timer interrupts.
+
 config ANDES_PLICSW
 	bool
 	depends on RISCV_MMODE || SPL_RISCV_MMODE
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index a527b3e9ae3..f0f5e40a20b 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SYS_CACHE_THEAD_CMO) +=3D thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) +=3D aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) +=3D andes_plicsw.o
+obj-$(CONFIG_MIPS_GIC) +=3D mips_gic.o
 else
 obj-$(CONFIG_SBI) +=3D sbi.o
 obj-$(CONFIG_SBI_IPI) +=3D sbi_ipi.o
diff --git a/arch/riscv/lib/mips_gic.c b/arch/riscv/lib/mips_gic.c
new file mode 100644
index 00000000000..7d761c58e74
--- /dev/null
+++ b/arch/riscv/lib/mips_gic.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ *
+ * U-Boot syscon driver for MIPS GIC.
+ */
+
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/syscon.h>
+#include <linux/err.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int riscv_init_ipi(void)
+{
+	return 0;
+}
+
+int riscv_send_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_clear_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_get_ipi(int hart, int *pending)
+{
+	return 0;
+}
+
+static const struct udevice_id mips_gic_ids[] =3D {
+	{ .compatible =3D "mips,gic0", .data =3D RISCV_SYSCON_PLICSW },
+	{ }
+};
+
+U_BOOT_DRIVER(mips_gic) =3D {
+	.name		=3D "mips_gic",
+	.id		=3D UCLASS_SYSCON,
+	.of_match	=3D mips_gic_ids,
+	.flags		=3D DM_FLAG_PRE_RELOC,
+};
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index 8b95f53ab32..47f2dd180b7 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -8,3 +8,4 @@ F:	arch/riscv/include/asm/arch-p8700/
 F:	configs/boston-p8700_defconfig
 F:	arch/riscv/dts/boston-p8700.dts
 F:	drivers/gpio/eg20t-gpio.c
+F:	arch/riscv/lib/mips_gic.c
--=20
2.34.1
