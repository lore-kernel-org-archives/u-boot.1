Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE3F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D507D843D4;
	Fri, 17 Apr 2026 14:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="LO6hDpa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C08384214; Fri, 17 Apr 2026 14:27:28 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA26E83FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO7i7JUpK5LJVuNfNF2nn2R0uOujKOl3T5teXlv8oOt/bUENBOyLDVWqqsBWZduVycuDez3fsi0KIbWALfbezpUUiKc5LI3AvsJt2soBELnLE9yqEZjLDsCWF/MAvbo+AE16Ur4CkcDR30TaS5QCJLo+uS9D8j+0cwRU8Ho7off+o0mkbJyB70WPkXF5EN6tMN0bOWNdnnKjhpK0XdRQQDwMcNNkwfTU8g2b+afBCGRtv7cwldGaJf2XKehO+d2K6v9v4JEOh7IxhRNTflEx6YWopI/YLOami7MDTkys2qWevwbRK6Dt7MW3TivLor2Fx+NwNMGLVswNKL1TmYBH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNGrQU56nbbJNJC2too1e7vZFM9oUUAj/ujP6qVBM0o=;
 b=G2JNqCX3MkQplyam2tSGOmNJQ20KnKL9W+oOU4LLYhvvrGa7Qn2qkep8BKa9bl1u2fhX3OL0m8YNtTJiB8XNhpGTy6Lv4wEbaVBUisHz8XQsjhGeZ25+Hs72bFKoEcX7xdHu/5j0r9QZ+SUIBxMQCip84wkOFCLcvfgxV7RAG8689JP8MVoVOj2Hya7YZehEqQXC9LqoRDm7zfuZ5CzncqQiK85IB3BRYZYMOy8Vb22VNrOfyKXxDHBszRKdaIFFt+Zigl/wibeUMqYYSyR3zR8/MYb16H8irlp4SsPW9HM7mMfkeA9Ok4pMl8IghJPw4dYluBoLW3QITi2UJtV2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNGrQU56nbbJNJC2too1e7vZFM9oUUAj/ujP6qVBM0o=;
 b=LO6hDpa6bj7GWHbw9yVNYZcpI4vsal7CJna4tV/JsF6NZr3+fuwQpoAHYUDc5c//S3RehcAdCF/GLyv+r6P8vrVXpRSn6uZg1xnKUWAThwkdDtiRJwGb5oDVtMKF647FqHcyOinYMfn/nqibIUb0LMbVBYdnRN6H62qEAoi5ZoAMKTiOnsJdr7BF2zr41F9v00JB04Z433dBzVLjrVYrEjZb91BD1j8FZ2BgpM5iubVURMddNOcH0sDoCYIACWUmyxu8Ic0mYzG+XmmcSzzpmoApH/qje6yCdrhqnB9fziZicOHHgUdA2IQrkKiC9C0c8v6RGt8olG8Ar+dBdzcI5Q==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DB9PR09MB6059.eurprd09.prod.outlook.com (2603:10a6:10:3d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:27:23 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:27:23 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v7 7/7] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Topic: [PATCH v7 7/7] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Index: AQHczmWLXQc6s/I9+ke6RVNxMaOzeQ==
Date: Fri, 17 Apr 2026 12:27:23 +0000
Message-ID: <20260417122213.147529-8-uros.stajic@htecgroup.com>
References: <20260417122213.147529-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DB9PR09MB6059:EE_
x-ms-office365-filtering-correlation-id: 19c16975-878a-447a-8d9e-08de9c7cadba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: PJl37gZmgkxqdR2ZJtASKa6Lod7q7CoW17rirTqToPGFNj6XWuQ1dbGG6V+Nf03QO3Le0QmUOBY7FdNcJH7LITl3j0/FNK04VciOz5UZMZsJJUE+KRLszYFU7tQRv9u3LWc8K/Jw43U1cCKXnA57oaNXuX61DfYIGspbiH0CxZdBGSYQPOkHT79auR6BKFlL4Otpmf4VkCclNZ6Cstnp9C/gClb4BsYfwGczHoLFVpjjoVho3aZeIIz30b8wNtkr/kD+wKjGw8yDjj7ycmaVOYJmpd11rTVUL9eW5XYbSw0jO1VEmPWlrttIAlMg2xsjY6QmSKw0x0o8F9MHSyRX1vkuFdrEKBHApkKSFdEsRxTS1SPDVSSBMFZcWW44P2Olf6vuDzY0EG7N4/Gjb/APFPdA+EM+UT8a91vXcKWBEVxGWp+mFBM0b7Gy0pxeGOhPHWe0mLyLYcNUkeG1rr/Jgb+dgM73CagVu358jZVatc5HTOrr+EcCCJDwh1KqAgQ6IQc2EMgS4ta2j+rLfw11D0UCkcqSCcwYDahWGVjJ2d29FSeo0pia35a88k3UebKb8YBJxmPWpcLU2SX4/OVwxF5CMlqMweEPfETmfWjYdNk0Pg4XitBxRHn/KxKW3LyFWBbndnQf3rY8Kbwq0DS89K4nMos/wxt//3qXv0/VYkYarx966u3EztuKSDiS7C46vm0ok8yzEquJmuxB1eCeP3Y29KvW4z//iF8EOVOw+rxku9SGVGcipUHiTm/oCbdU6ko6jx1Tq2pdcisxdZBbsvmLRhzWy6wDIdFEQJUapXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fbGFG6x+IjvH4XBeCQlBBjM+ZOtxIde3zzWgKGIqGSH0OqrViAKOI/SPq3?=
 =?iso-8859-1?Q?7OMdo6Qob/Rf0s1EzTDuFWSJWOhRZVXnhWYlgx1EPSnsKY7eppAEcislr/?=
 =?iso-8859-1?Q?i/4TBCq6X9D/HfsA/Si9qq5YdL6dBtZ3YPRW+C/MDir4TAoc5kABNnpWNg?=
 =?iso-8859-1?Q?XZ8QoT5XpMXlMgsEguTPZT9hSHAjQM7DJa1cyn+AHZJITIY/JcTE6e5Q4e?=
 =?iso-8859-1?Q?Li/grF5FCIQgeG5hFu0G0/5IaGqmuLk/ZfIVQtAY46CIQlErmExRG29LHO?=
 =?iso-8859-1?Q?64LVF5JOHSchWZb3iz8GrymOFsCGWMKJd9bn7tyh5dw2dx0yC+V6JgAJcW?=
 =?iso-8859-1?Q?kx00ApHRGVR4pm5lT3DbWmiJheN2xWqNgBcMT7KoIbxw4KxdAtRsDzagCD?=
 =?iso-8859-1?Q?k8JYoHhxdVfRreirFOiJqBNQIvy8/t/iqvnXcSBM/akCr7bLjkV32dbSzj?=
 =?iso-8859-1?Q?KRpltrDpGzbprEHt6SN+kd3qmblI9cWTPBqDMYiXVZsOJyWAepyCh3pqzl?=
 =?iso-8859-1?Q?/ybhFLky48Sv7nNUU1DZa/EJNQ87kI1xOFrROt8OCcMZrW5FRt3IRwoy9l?=
 =?iso-8859-1?Q?YGnb71Qnu36QcZmQIUU3x0UXWFrosZEy1NqVGQI97jRhfOfZyalzvZsbzp?=
 =?iso-8859-1?Q?+C4yvh+BSzMCWDzPcil1W59wfGOxzAMgfVGWNzZ0w7Le7xHn/xcK5ldtw0?=
 =?iso-8859-1?Q?8L7CchcDIHlLJYKE+pmLascKHSzAx1xtDxUFBV8gsr2WBVFv5bNsbFlZSw?=
 =?iso-8859-1?Q?B4AmrT5MvIciu9nN3SEB1/ZAZ7OGq8Gpo0f5oxqFdzy8Y6KOgZd3ITcHt8?=
 =?iso-8859-1?Q?ghvOOxfpiQKJlsvpKgEwGro9Z/HzO+us4oDRJsBkyhLvEBg6MNQypfw6Hy?=
 =?iso-8859-1?Q?ucrCOEldeJF5DdEKLSjOm2+wdwR1fCFA7roiJulWlGIHpp8rggUEkuRxyr?=
 =?iso-8859-1?Q?XFJR6lN/itrK64RRiK6FSTWXvqVkwZYPDE4RG159Q1t8qJuiNGUSCpJg+z?=
 =?iso-8859-1?Q?IOIU3gVb/gV6h28TSJbGh6iFltKkz43IYir6FmwIOi8kxpBZ08G/BJcCYy?=
 =?iso-8859-1?Q?ncRT7TWBMiWfTkjikLEYVGR5v8o2997uvq4m+QjaBI84+EViM5WPJdN+qe?=
 =?iso-8859-1?Q?xSSnaLoYH/2GtJ+/YoC3jaixAMr8n4QHBU/11iEvEmbkVVHBg+1YLW51lm?=
 =?iso-8859-1?Q?xw0jDvH71G6rZ5sxj1TGMAb/x8xpFsJPMJ+FxPy4UOcUvneWBTv8DLKTdd?=
 =?iso-8859-1?Q?nP4MozbdTZBoUZWyAyOE4160SNy+ze8l3Pd7tgQFEPRencZK2JVn1N+mn7?=
 =?iso-8859-1?Q?Uu/TdESuTLt7fACSIMmzfzwOnURnbK05p/Uv3cDhjCg67pbtnXefaikywn?=
 =?iso-8859-1?Q?2rGTqD0VR7AI83b+pBQm8kKcdLY1o2HvoGCnC7GFvNJ0nJkVsl8P8kJADg?=
 =?iso-8859-1?Q?sMEkNG33s4a7O8AayKK3yJVGQIsRxrlY9k6wtzw/FLMupHnwW7MaVazSeI?=
 =?iso-8859-1?Q?c58GLBKyq4TGo20sik9RfBc7X+yT+hGCWNoawc492UFHXUsXrZaB+ZJG4d?=
 =?iso-8859-1?Q?D8Xw+xypjRWBYk+mQFFy5RrpTPmlaj7CsGRuqIO4Y/0haDRRbUlwhlbAFm?=
 =?iso-8859-1?Q?qtiUYjw2Zq/up8ifbBGldlGCLuHa9CIjtK0o+VL9h6as9JzVhrJ4Dw42J4?=
 =?iso-8859-1?Q?DHSyC8CjEqxF6soMeZtvp9DLMoJ0IwNk2H1XmaBFO/ZKkylrTE7aVxYc08?=
 =?iso-8859-1?Q?sGww428oeWPEcQUrKWp1FHCST0ZZ3F08Ve2DU+gm+3iaMY59DQQW6iMY2m?=
 =?iso-8859-1?Q?/RSN9l0sICXJCdOh/urBI/aA6/nLFog=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c16975-878a-447a-8d9e-08de9c7cadba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:27:23.7454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neE/Exuf1+Cx3dJ3+gbJ18lUjj87k3Bp+JjINCb1IX694kOIRjkajesNvnodk10G6RABS6nvZN4K5rS/7qK85erIbwAVYdRU5O+VvMpZioU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6059
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Add support for Coherence Manager (CM) and IOCU discovery and
configuration on the P8700 platform.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/cpu/p8700/Makefile             |   2 +
 arch/riscv/cpu/p8700/cache.c              |   6 ++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++++++++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 +++++++++++++++++++
 arch/riscv/cpu/p8700/p8700.c              |   2 +
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++++++++++
 arch/riscv/include/asm/arch-p8700/p8700.h |  32 +++++++
 arch/riscv/include/asm/global_data.h      |   4 +
 board/mips/boston-riscv/Makefile          |   1 +
 board/mips/boston-riscv/boston-riscv.c    |  11 +++
 board/mips/boston-riscv/iocu.c            | 102 ++++++++++++++++++++++
 11 files changed, 388 insertions(+)
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 board/mips/boston-riscv/iocu.c

diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
index 04291375a29..45f68bbda3d 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
=20
 obj-y +=3D cache.o
+obj-y +=3D cm.o
+obj-y +=3D cm-iocu.o
 obj-y +=3D cpu.o
 obj-y +=3D dram.o
 obj-y +=3D p8700.o
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
index 06e60156394..1343637eea7 100644
--- a/arch/riscv/cpu/p8700/cache.c
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -48,6 +48,9 @@ static void probe_cache_config(void)
=20
 void flush_dcache_range(unsigned long start, unsigned long end)
 {
+	if (dma_is_coherent())
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
@@ -71,6 +74,9 @@ void flush_dcache_range(unsigned long start, unsigned lon=
g end)
=20
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
+	if (dma_is_coherent())
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
diff --git a/arch/riscv/cpu/p8700/cm-iocu.c b/arch/riscv/cpu/p8700/cm-iocu.=
c
new file mode 100644
index 00000000000..5850647d20f
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm-iocu.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+#include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/arch-p8700/cm.h>
+
+__weak bool plat_iocu_usable(unsigned int cluster, unsigned int iocu)
+{
+	return true;
+}
+
+static int init_cluster_iocus(unsigned int cluster)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	void __iomem *global_gcrs;
+	u32 cfg, num_iocus, num_iocus_usable, local_cluster;
+	int i;
+
+	local_cluster =3D mips_cluster_id();
+
+	global_gcrs =3D mips_cm_base();
+	if (cluster !=3D local_cluster) {
+		// FIXME
+		return 1;
+	}
+
+	cfg =3D __raw_readl(global_gcrs + GCR_CONFIG);
+	num_iocus =3D cfg >> GCR_CONFIG_NUMIOCU_SHIFT;
+	num_iocus &=3D GCR_CONFIG_NUMIOCU_MASK;
+	gd->arch.num_iocus +=3D num_iocus;
+
+	/* Discover how many IOCUs are usable */
+	num_iocus_usable =3D num_iocus;
+	for (i =3D num_iocus - 1; i >=3D 0; i--) {
+		if (!plat_iocu_usable(cluster, i))
+			num_iocus_usable--;
+	}
+	gd->arch.num_iocus_usable +=3D num_iocus_usable;
+
+	/* If the cluster has no usable IOCUs there's nothing to do */
+	if (num_iocus_usable =3D=3D 0) {
+		if (cluster !=3D local_cluster)
+			power_down_cluster(cluster);
+
+		return 0;
+	}
+
+	/* If the IOCUs are in the local cluster we're good to go already */
+	if (cluster =3D=3D local_cluster)
+		return 0;
+
+	/* Ensure that the cluster's L2 cache is initialised */
+	return init_cluster_l2(cluster);
+}
+
+int mips_cm_init_iocus(void)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	unsigned int cluster;
+	int err;
+
+	for (cluster =3D 0; cluster < mips_cm_num_clusters(); cluster++) {
+		err =3D init_cluster_iocus(cluster);
+		if (err) {
+			gd->arch.num_iocus_usable =3D err;
+			return 0;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/cm.c b/arch/riscv/cpu/p8700/cm.c
new file mode 100644
index 00000000000..ce7485c564d
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include <asm/arch-p8700/p8700.h>
+
+static void mips_cpc_init(void)
+{
+}
+
+__weak const struct mmio_region *get_mmio_regions(void)
+{
+	return NULL;
+}
+
+static void p8700_setup_mmio_limits(void)
+{
+	void __iomem *gcrs =3D mips_cm_base();
+	const struct mmio_region *rgn =3D get_mmio_regions();
+	unsigned int num_clusters =3D mips_cm_num_clusters();
+	unsigned int limit =3D MIPS_CM_MMIO_LIMIT / num_clusters;
+	unsigned int i, reg_off;
+
+	if (!rgn)
+		return;
+
+	if (num_clusters !=3D 1) {
+		// FIXME! Need to support multiple clusters.
+		return;
+	}
+
+	reg_off =3D GCR_MMIO0_BOTTOM;
+
+	for (i =3D 0; rgn[i].addr_high; i++) {
+		__raw_writeq(rgn[i].addr_high & GCR_MMIO0_TOP_ADDR,
+			     gcrs + reg_off + (GCR_MMIO0_TOP - GCR_MMIO0_BOTTOM));
+
+		__raw_writeq((rgn[i].addr_low & GCR_MMIO0_BOTTOM_ADDR) |
+			     (rgn[i].port << GCR_MMIO0_BOTTOM_PORT_SHIFT) |
+			     (rgn[i].enable ? GCR_MMIO0_BOTTOM_ENABLE : 0),
+			     gcrs + reg_off);
+		reg_off +=3D GCR_MMIO1_BOTTOM - GCR_MMIO0_BOTTOM;
+	}
+
+	__raw_writel(limit, gcrs + GCR_MMIO_REQ_LIMIT);
+}
+
+int power_up_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int power_down_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int init_cluster_l2(unsigned int cluster)
+{
+	return 0;
+}
+
+int mips_cm_init(void)
+{
+	int err;
+
+	mips_cpc_init();
+
+	err =3D mips_cm_init_iocus();
+	if (err)
+		return err;
+
+	p8700_setup_mmio_limits();
+
+	return 0;
+}
+
+int arch_cpu_init(void)
+{
+	int err;
+
+	err =3D mips_cm_init();
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/p8700.c b/arch/riscv/cpu/p8700/p8700.c
index 41d5547c511..802ec65ffb2 100644
--- a/arch/riscv/cpu/p8700/p8700.c
+++ b/arch/riscv/cpu/p8700/p8700.c
@@ -10,3 +10,5 @@
 __weak void wait_ddr_calib(void) { }
=20
 __weak void setup_pcie_dma_map(void) { }
+
+__weak bool dma_is_coherent(void) { return false; }
diff --git a/arch/riscv/include/asm/arch-p8700/cm.h b/arch/riscv/include/as=
m/arch-p8700/cm.h
new file mode 100644
index 00000000000..ab5ea7385b2
--- /dev/null
+++ b/arch/riscv/include/asm/arch-p8700/cm.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __P8700_CM_H__
+#define __P8700_CM_H__
+
+#include <asm/arch-p8700/p8700.h>
+
+struct mmio_region {
+	phys_addr_t addr_low;
+	phys_addr_t addr_high;
+	unsigned int port : 4;
+	unsigned int enable : 1;
+};
+
+const struct mmio_region *get_mmio_regions(void);
+
+void setup_redirect(unsigned int cluster, unsigned int core,
+		    unsigned int vp, unsigned int block);
+
+int mips_cm_init_iocus(void);
+
+int power_up_cluster(unsigned int cluster);
+int power_down_cluster(unsigned int cluster);
+int init_cluster_l2(unsigned int cluster);
+
+static inline void *mips_cm_base(void)
+{
+	return (void *)CM_BASE;
+}
+
+static inline void *mips_cpc_base(void)
+{
+	return (void *)CPC_BASE;
+}
+
+static inline unsigned int mips_cm_num_clusters(void)
+{
+	u32 cfg;
+
+	cfg =3D __raw_readl(mips_cm_base() + GCR_CONFIG);
+	cfg >>=3D GCR_CONFIG_NUMCLUSTERS_SHIFT;
+	cfg &=3D GCR_CONFIG_NUMCLUSTERS_MASK;
+
+	return cfg;
+}
+
+static inline unsigned int mips_cluster_id(void)
+{
+	u32 temp;
+
+	asm volatile("csrr %0, mhartid" : "=3Dr"(temp));
+	temp >>=3D MHARTID_CLUSTER_SHIFT;
+	temp &=3D MHARTID_CLUSTER_MASK;
+
+	return temp;
+}
+
+#endif /* __P8700_CM_H__ */
diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
index d6cc125d76a..98ce5ba3ffb 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -65,6 +65,10 @@
 #define CM_BASE			CONFIG_RISCV_CM_BASE
 #define CPC_BASE		(CM_BASE + 0x8000)
=20
+/* Block offsets */
+#define GCR_OFF_GLOBAL		0x0000
+#define GCR_OFF_LOCAL		0x2000
+
 /* CPC Block offsets */
 #define CPC_OFF_LOCAL		0x2000
=20
@@ -75,6 +79,33 @@
 #define CPC_Cx_CMD		0x0000
 #define CPC_Cx_CMD_RESET	0x4
=20
+/* GCR_CONFIG */
+#define GCR_CONFIG						0x0000
+#define GCR_REV							0x0030
+#define GCR_CONFIG_NUMCLUSTERS_SHIFT	23
+#define GCR_CONFIG_NUMCLUSTERS_MASK	    0x7f
+#define GCR_CONFIG_NUMIOCU_SHIFT	    8
+#define GCR_CONFIG_NUMIOCU_MASK		    0xf
+#define GCR_CONFIG_NUMCORES_SHIFT	    0
+#define GCR_CONFIG_NUMCORES_MASK	    0xff
+
+/* GCR_REV CM versions */
+#define GCR_REV_CM3			0x0800
+#define GCR_REV_CM3_5		0x0900
+
+#define GCR_MMIO_REQ_LIMIT				0x06f8
+#define GCR_MMIO0_BOTTOM				0x0700
+#define GCR_MMIO0_BOTTOM_ADDR			(0xffffffffull << 16)
+#define GCR_MMIO0_BOTTOM_PORT_SHIFT		2
+#define GCR_MMIO0_BOTTOM_PORT			(0xf << 2)
+#define GCR_MMIO0_BOTTOM_DISABLE_LIMIT	(0x1 << 1)
+#define GCR_MMIO0_BOTTOM_ENABLE			(0x1 << 0)
+#define GCR_MMIO0_TOP					0x0708
+#define GCR_MMIO0_TOP_ADDR				(0xffffffffull << 16)
+#define GCR_MMIO1_BOTTOM				0x0710
+
+#define MIPS_CM_MMIO_LIMIT	4
+
 #define P8700_GCR_C0_COH_EN	0x20f8
 #define P8700_GCR_C1_COH_EN	0x21f8
 #define P8700_GCR_C2_COH_EN	0x22f8
@@ -97,5 +128,6 @@
=20
 void wait_ddr_calib(void);
 void setup_pcie_dma_map(void);
+bool dma_is_coherent(void);
=20
 #endif /* __P8700_H__ */
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/=
global_data.h
index 33f2b5ec5c8..198eacd1e07 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -44,6 +44,10 @@ struct arch_global_data {
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
 	struct resume_data *resume;
+#if CONFIG_IS_ENABLED(P8700_RISCV)
+	int num_iocus;
+	int num_iocus_usable;
+#endif
 };
=20
 #include <asm-generic/global_data.h>
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 0615c677d23..c67c001d4e6 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -4,5 +4,6 @@
=20
 obj-y +=3D boston-riscv.o
 obj-y +=3D checkboard.o
+obj-y +=3D iocu.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/boston-riscv.c b/board/mips/boston-ris=
cv/boston-riscv.c
index f3fd2ec8348..4af918c8c81 100644
--- a/board/mips/boston-riscv/boston-riscv.c
+++ b/board/mips/boston-riscv/boston-riscv.c
@@ -46,3 +46,14 @@ void setup_pcie_dma_map(void)
 	writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE1ADDR);
 	writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE2ADDR);
 }
+
+bool dma_is_coherent(void)
+{
+	u32 pcie0_off =3D readl((void __iomem *)BOSTON_PLAT_NOCPCIE0ADDR);
+	u32 pcie1_off =3D readl((void __iomem *)BOSTON_PLAT_NOCPCIE1ADDR);
+	u32 pcie2_off =3D readl((void __iomem *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	return pcie0_off =3D=3D BOSTON_IOCU_NOC_OFFSET &&
+	       pcie1_off =3D=3D BOSTON_IOCU_NOC_OFFSET &&
+	       pcie2_off =3D=3D BOSTON_IOCU_NOC_OFFSET;
+}
diff --git a/board/mips/boston-riscv/iocu.c b/board/mips/boston-riscv/iocu.=
c
new file mode 100644
index 00000000000..807f09804a3
--- /dev/null
+++ b/board/mips/boston-riscv/iocu.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include "boston-regs.h"
+#include <dm.h>
+#include <env_callback.h>
+#include <event.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+
+static const struct mmio_region mmio_regions[] =3D {
+	{ 0x10000000, 0x160f0000, .enable =3D 1 },
+	{ 0x17ff0000, 0x17ff0000, .enable =3D 1 },
+	{ 0 },
+};
+
+const struct mmio_region *get_mmio_regions(void)
+{
+	return mmio_regions;
+}
+
+static int set_io_coherent(bool coherent)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (!coherent) {
+		printf("I/O:   Non-Coherent (Forced by environment)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable < 0) {
+		printf("I/O:   Non-Coherent (IOCU init error %d)\n",
+		       gd->arch.num_iocus_usable);
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus =3D=3D 0) {
+		printf("I/O:   Non-Coherent (No IOCU)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable =3D=3D 0) {
+		printf("I/O:   Non-Coherent (IOCU not connected)\n");
+		goto noncoherent;
+	}
+
+	/*
+	 * We have some number of connected IOCUs. Map all PCIe DMA access to
+	 * hit the IOCU by offsetting the addresses as they pass from the PCIe
+	 * controller to the NoC.
+	 */
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	printf("I/O:   Coherent\n");
+	return 0;
+
+noncoherent:
+	/* Map all PCIe DMA access to its default, non-IOCU, target */
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+=09
+	return 0;
+}
+
+static int on_io_coherent(const char *name, const char *value,
+			  enum env_op op, int flags)
+{
+	switch (op) {
+	case env_op_create:
+	case env_op_overwrite:
+		if (!strcmp(value, "0")) {
+			set_io_coherent(false);
+		} else if (!strcmp(value, "1")) {
+			set_io_coherent(true);
+		} else {
+			printf("### io.coherent must equal 0 or 1\n");
+			return -EINVAL;
+		}
+		return 0;
+
+	case env_op_delete:
+		set_io_coherent(true);
+		return 0;
+
+	default:
+		return 0;
+	}
+}
+
+U_BOOT_ENV_CALLBACK(io_coherent, on_io_coherent);
+
+static int p8700_misc_init_f(void)
+{
+	return set_io_coherent(env_get_yesno("io.coherent") !=3D 0);
+}
+
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, p8700_misc_init_f);
--=20
2.34.1
