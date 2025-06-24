Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E25C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 475B782F03;
	Tue, 24 Jun 2025 15:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="OuSzZfV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F112B82D17; Tue, 24 Jun 2025 12:28:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16CD82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGcgjh4ZAhlFDX6fhXQ8e5xoED/SUmfl5LWEQFhH/BOLn1mmODzytkHIuYqw3s/0WFEChUDyp9homdBt897ssn0hm6TLvypbAe77E6RCZ0HcXhL1GykX3HNAu+QAaKe3Tz20nWH6Ofl6AxxlZ3Aushnv0IS+fDsWOZwiYAcw2TA/8HiAgE+KTHqsgznISgmLZsOg5+VtQ+CmGwPW6ih0OB8k5J405m77CN7meAvc2Fd9jynj1cyNiSSVTbNbP4HkZyQ4cM/AuuVmltzKp4uNERTmrG+BOwf1y/xbMSwDXH820rC0SqWs8+FV2fs03xM9l8BKBYPqmlvn4blMb2qjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14A6XQMUNxCKA3wVaxFIquJwuGc3vYj1GDRpRkZxqZ8=;
 b=A6q+ZP+Oi9eUzhSd41S/4Cs5Lti/PJVAmLPiZ0Vcyj5rYmwIXCkGgpaFSsXkHSBA1nb2+lZFj192Gn4iwF7zphIHkyLUtjOl+VcPKylmZIDGriCmMu9ufJFFFkB+4cKg+7rhqNFHdBg9lyuo6Aq0QevMDdxeHGCVC+xqkZsMsOsZN1LP+Yf/xR5ArJssKB6T5UMfTCMHAuxAXRHfnGbnzzXU9G++S30IQZG1qRbJ5NCVHTMwjwxVdMmEIvxibRXty05i9e3M2URl2sgyvZ2D72BJgVI9czVr9PZCz3a4EXqwTTyyfA93BpAoJmVGAo9nH0eE3jbAGyD86qrCKSu6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14A6XQMUNxCKA3wVaxFIquJwuGc3vYj1GDRpRkZxqZ8=;
 b=OuSzZfV5r3JqZ01sAcW3xLmxSloxY826MMFB/v1eEgBwauLWE7LZVp3EPn6WQ/94i6AGNEkBTm63VeJB4NsAJ9LZIksP6ehY7VGkLFpzQdxpKfcmabeMwGyXeXMHcbi41CIVF0PFYJiBEBRNt1pjovWfhBe1YRUzTNaQf3J25x0sH8XgbzIrpoj0leRAriSoL7Ql379NYFDQD3iW64lgG3NEEGZ1GP/8D9XUj9I/ydo27Cwbb6Bnwclh1s7KpAuWDh7dE79JulQxnjkrZ16iRrlLYY6izkeP/UYegpk28c3/9TWAMgghGXe/PVlSOgcoRn1vrNaeFeFJucWY+wn5fw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AS1PR09MB5543.eurprd09.prod.outlook.com (2603:10a6:20b:4a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:28:18 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:28:18 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 08/11] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Topic: [PATCH v2 08/11] riscv: p8700: Add Coherence Manager (CM) and
 IOCU support
Thread-Index: AQHb5PKz1F+MfNcYjEuCMJPY/6jBIA==
Date: Tue, 24 Jun 2025 10:28:17 +0000
Message-ID: <20250624102449.324410-9-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AS1PR09MB5543:EE_
x-ms-office365-filtering-correlation-id: 7642fb26-1105-4fc3-414a-08ddb309d5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wgmOEPIUi+lrQ1jD22OPqgF49wMgn8ZGiSu54wrwVfd+ZDg26RSPBp7YHs?=
 =?iso-8859-1?Q?0B7PmXl+5tHl1LzeTmjCLDVybaNeFI1+4HsK0kdZ9zAXkTP3wd2C+Tl5x7?=
 =?iso-8859-1?Q?M9xgI/L0xUwWzZ1VMDAbfoJ8hKck+CI41Vt+lZ8tLx/c6A4olXuowAhDI2?=
 =?iso-8859-1?Q?kdWwr+h8CrE0mZ/ke8PPgInRmKNv46CoCOA8OtfSikbC/GOxyJIilZXXy3?=
 =?iso-8859-1?Q?143tGsaeX6+9GYn+lnBbKlqnj0XXXxN/YD4rGu5HIqUJM13vfChQuulCSm?=
 =?iso-8859-1?Q?gyjSxOiR3oB4DgXrWJYOMGOyjhh6JSMlClLyjapjkfR1snCTgCXbKbNuuO?=
 =?iso-8859-1?Q?H+CBph1V9ShWHWfxZr4tBQCdSI+hQApkDsKlFkuBJbcGLsu3qgC7Tavnx/?=
 =?iso-8859-1?Q?go/35VwAEb2bA6iuqDX5xmgVKcMKz4YjfWnSRsseBnbqx7h4YkoXOU++Ck?=
 =?iso-8859-1?Q?EY6DNv7WCUnMTDeGflsoMohiYyPjG9dxqp8KTd25S65e/icXncJxIN3d0Z?=
 =?iso-8859-1?Q?Ik0sCBxYWwsd1iPj8hPg3uB+Aatt7n4URmShMOydR+unu6fJhxjuO1dQpI?=
 =?iso-8859-1?Q?fLjc05Klt9hxdVHfgzA8/NwSmhB4mDU4Gp06RkcBJxmFxmwATuc4oLZ8z1?=
 =?iso-8859-1?Q?XFYT5n9SVrXfgbKHVqbpv7qK8x9bovSTqm4E+UQZVikiZxWb0EOdgRAQaE?=
 =?iso-8859-1?Q?AYcR972pdTYKGOnF0uvLXuTN62q/+i31phACTW5B3/Yw5fNudpxUuLtMxB?=
 =?iso-8859-1?Q?rCLqPGFCgCoxxFIqPis5M9pWAvvkmN7p+JxwDAlqSfCqAI3H8848BeQvYU?=
 =?iso-8859-1?Q?mjMLboQxPCy/xLQhwe8kVBIaJVd/rqyvxslTq8DydG0pDEYu6PzjAyfJIL?=
 =?iso-8859-1?Q?nHaqBLq+sdQH4eAcBqz3S7w84dCYvi/RGhKnqqFyoIJiPnkHdGFgALNLzK?=
 =?iso-8859-1?Q?6LM63AVUsL2Wnp8btQt/TC+yOIXTq+szg65L4KssDFScnwsHe5A8mLSaww?=
 =?iso-8859-1?Q?FuuEspPc3hGmTa40M3NDejdl6CKb5Hr+JBwbbcVFblsz4aIjWyiZj432h9?=
 =?iso-8859-1?Q?TbPEgejQjxtHisT2pItzNMlbWX6tGT5nJ0L7YS1R6KrjPz/jKgLzomiRVR?=
 =?iso-8859-1?Q?73E+s5j1yTR1ZG8SzFu4DCdrXnHHDQacytB09WaEB6US8r8i+pUexl7FtI?=
 =?iso-8859-1?Q?Ixe0HcpCJbpDGddsrUzb189ZN3BnXn8jvEWtaYcwfz45CPvZ80+2/kdJgK?=
 =?iso-8859-1?Q?QGECPWSknBXZ2ws7b8QwgW5MW/JHhZ3E3LyWvvAvnSlz0YCftV7EMTWJeK?=
 =?iso-8859-1?Q?ryULPyI7v8nLezMOieYS7R5tafpCQQxI4LD5/oA5JYBUn3fn1LVoFgRZUH?=
 =?iso-8859-1?Q?yPLtWiwSRErTOtK3Vpxjp0zZYYalWh/qA19UADCHIUb8Xo1AywDNCheEZ0?=
 =?iso-8859-1?Q?OkAOWGISn2RFupAPUUupdt3CeINnveS+uHUD6osBPe2KsamlmaXvj9owvm?=
 =?iso-8859-1?Q?xd/riwbeQDNrIJ/bF6uTd81tgQExtnygyJnFZ6GSsMig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lRJrqI8f87lb+jwcyEjC74w5jsq7XkmY+Kj6uzil/QctqGNiD15otbEldz?=
 =?iso-8859-1?Q?wE4sPhzZOLw6VAInVodXSviiTVGOVmC3Xz6tgdIwSlfe+kj/1bfU4SRC6W?=
 =?iso-8859-1?Q?XxGujveHUvQfbJwi1AW56vG9JYd07vdPsq0q3hmGLQbG9BT+ii2sQ9FYWg?=
 =?iso-8859-1?Q?tZVK4Fc6RuEKHTQFlURsN8F9SLkNREYWladdqmhtKCIrVjVxv9k5vB6Oer?=
 =?iso-8859-1?Q?BV+QpZzvl6iaBIIaxf5nQOjDQI8nmx82ZD5AhRMGwIdNRZylxbZTu8XI3h?=
 =?iso-8859-1?Q?bvirK5K03JRM6E/ELNRqTQRS1CUByumT4bWPrs7Mbo044B0BBOuAgP7EDc?=
 =?iso-8859-1?Q?BVvaroACnVs+2AHskaItzdSzGJvS4Sp06dRUbA/Yj9D561Rf9h55XztGPU?=
 =?iso-8859-1?Q?OdR5Ukb1pdBaMw5+oUC1qydqEOdjTGM04sIGk0T7JZvRGWbdpBFs/2dC9E?=
 =?iso-8859-1?Q?hvFDzLeDpVFu0k3RMOmCEtZ9q4ox+qSTMxW2lrz9PN5zM53KPP08ifupo4?=
 =?iso-8859-1?Q?JvfaJQMp1tBIK/hNAi+o54LJNkHGSVvT8bg2CA/VU44APz+ArkKfboG9jI?=
 =?iso-8859-1?Q?0AUBGNmCwBInvUqJuYvUaXMGQOfoYyNABH/0Yaa/FrQxLC7QLzmz6+ApkB?=
 =?iso-8859-1?Q?AljCnS0ukW4EOZ0g45rgoqECeWvnIbi7cbp9diwrAPyTwNCxWDAv1db622?=
 =?iso-8859-1?Q?as0sBAlkmZVeCVViGFI1QeaYDWDvl32qv9OzoKsHrT8dyCxO+E/XqS8qNT?=
 =?iso-8859-1?Q?lw28RKyrWJE6qhxbzWE+RlWTmvK10KhZtCmiYEQFKn36JLeMEN02Gdp2+m?=
 =?iso-8859-1?Q?YISxGiMBwJjoqq0KWYi9viOP1kqUM9bA7ZwgOI1ZnzicKZJZ3E4Ly1ElQz?=
 =?iso-8859-1?Q?iAhFaKvy6SDYM171AxrfilLxNssvy9FB/7ygU7YiIeO4eSzS0HDgPCYcWG?=
 =?iso-8859-1?Q?vTIq+XiJvLbLr8wYe/cGBCS8DQMWffElMUqojco7uz3FLff1imjI/xklsm?=
 =?iso-8859-1?Q?pGuo4lF9BzzjhNraVNvm28XuKxP4xQee9Fjwepd9im+4f6lQI674y4IaKP?=
 =?iso-8859-1?Q?2/6szerZ9hv5HEhjFRQq3mGbBTsnKKoGl3SrOuWALDsDJkS7HGxWe5muir?=
 =?iso-8859-1?Q?RdQfhH3SXnHVf4SYhU3jFawoCz5IQHQCH3EZJskBNODS+CgulV/K0gIiYN?=
 =?iso-8859-1?Q?g+3V9aZ67VexgtZeKmR/LVaZiRx4Wurj0Lthd1tJqQaHknBASvYdlRDxEc?=
 =?iso-8859-1?Q?knwM0bMlGdufAzAWeT6dQW4C7QTM8ByC7VB5gLiV3oDqbbTb8BJz0maqpY?=
 =?iso-8859-1?Q?zefrnkq4OVFA9TU5v0Nu8wPQ0Ia6uJNzi4+8co6zavFSMzFPxhRXBQvKSU?=
 =?iso-8859-1?Q?vGqtJ8YUtebuD9GDtJQHXgsGZo+R41D2c/VNagz1Lnw6S5B7b2KkgPZrgd?=
 =?iso-8859-1?Q?lctznZTCC5f9L/Ejm7HoNz+CXzFzNZlsJp53X86K7Bi8a6fcCMEwIV8z2P?=
 =?iso-8859-1?Q?bNZ59j64jQgPBqwOjU5GSRfOyx1vbS+3U0HCMkcgUrEWaFH8b2Y5OWhV2s?=
 =?iso-8859-1?Q?2l7SamjaO+9JlCSNb+Fk+Y1C8TOQzpUb9MUVQ3VWkkpo+yLzetXEqT9o6G?=
 =?iso-8859-1?Q?kwQyOsRRV7DQFLvEIxjRETjmMl9C8rm/w8h47+4Yxg67tVVv5cYscnUQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642fb26-1105-4fc3-414a-08ddb309d5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:28:17.8749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6jeAQc8fwVjXTFXBp9xHQwGU4r7zX70GIjV6thxrwm/XD7/PI5zIk5nDuDU0aJfyYw1j+9aszQ2JSa4+ZooQHTAwqubxtpD7h0EI6/w8I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5543
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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
 arch/riscv/cpu/p8700/cache.c              |  10 +++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++++++++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 +++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++++++++++
 arch/riscv/include/asm/arch-p8700/p8700.h |  31 +++++++
 arch/riscv/include/asm/global_data.h      |   2 +
 arch/riscv/include/asm/io.h               |  86 ++++++++++++++++++
 board/mips/boston-riscv/Makefile          |   1 +
 board/mips/boston-riscv/iocu.c            | 104 ++++++++++++++++++++++
 10 files changed, 464 insertions(+)
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 board/mips/boston-riscv/iocu.c

diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
index f9fcd20e2ab..3c93a703d84 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -6,3 +6,5 @@ obj-y +=3D dram.o
 obj-y +=3D cpu.o
 obj-y +=3D cache.o
 obj-y +=3D emu-amo.o
+obj-y +=3D cm.o
+obj-y +=3D cm-iocu.o
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
index 27641035d80..e9297d9881b 100644
--- a/arch/riscv/cpu/p8700/cache.c
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -37,6 +37,11 @@ static void probe_cache_config(void)
=20
 void flush_dcache_range(unsigned long start, unsigned long end)
 {
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (gd->flags & GD_FLG_COHERENT_DMA)
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
@@ -56,6 +61,11 @@ void flush_dcache_range(unsigned long start, unsigned lo=
ng end)
=20
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (gd->flags & GD_FLG_COHERENT_DMA)
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
index 5ca9b4b9497..6c47de9a633 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -65,6 +65,10 @@
 #define CM_BASE			0x16100000
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
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/=
global_data.h
index 47b5e2cfc8f..7dbd164f154 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -44,6 +44,8 @@ struct arch_global_data {
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
 	struct resume_data *resume;
+	int num_iocus;
+	int num_iocus_usable;
 };
=20
 #include <asm-generic/global_data.h>
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index da165858034..fb79d0a8d32 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -15,6 +15,91 @@ static inline void sync(void)
 {
 }
=20
+/*
+ * Generic virtual read/write.  Note that we don't support half-word
+ * read/writes.  We define __arch_*[bl] here, and leave __arch_*w
+ * to the architecture specific code.
+ */
+
+#if CONFIG_P8700_RISCV
+#ifdef CONFIG_ARCH_MAP_SYSMEM
+static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
+{
+	if (paddr < PHYS_SDRAM_0_SIZE + PHYS_SDRAM_1_SIZE)
+		paddr =3D paddr | 0x40000000;
+	return (void *)(uintptr_t)paddr;
+}
+
+static inline void *unmap_sysmem(const void *vaddr)
+{
+	phys_addr_t paddr =3D (phys_addr_t)vaddr;
+
+	paddr =3D paddr & ~0x40000000;
+	return (void *)(uintptr_t)paddr;
+}
+
+static inline phys_addr_t map_to_sysmem(const void *ptr)
+{
+	return (phys_addr_t)(uintptr_t)ptr;
+}
+#endif
+
+static inline unsigned char __arch_getb(const volatile void __iomem *mem)
+{
+	unsigned char value;
+
+	asm volatile("lbu %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline unsigned short __arch_getw(const volatile void __iomem *mem)
+{
+	unsigned short value;
+
+	asm volatile("lhu %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline unsigned int __arch_getl(const volatile void __iomem *mem)
+{
+	unsigned int value;
+
+	asm volatile("lw %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline unsigned long long __arch_getq(const volatile void __iomem *=
mem)
+{
+	unsigned long long value;
+
+	asm volatile("ld %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline void __arch_putb(unsigned char value, volatile void __iomem =
*mem)
+{
+	asm volatile("sb %0,0(%1)"::"r"(value), "r"(mem));
+}
+
+static inline void __arch_putw(unsigned short value, volatile void __iomem=
 *mem)
+{
+	asm volatile("sh %0,0(%1)"::"r"(value), "r"(mem));
+}
+
+static inline void __arch_putl(unsigned int value, volatile void __iomem *=
mem)
+{
+	asm volatile("sw %0,0(%1)"::"r"(value), "r"(mem));
+}
+
+static inline void __arch_putq(unsigned int value, volatile void __iomem *=
mem)
+{
+	asm volatile("sd %0,0(%1)"::"r"(value), "r"(mem));
+}
+#else
 #define __arch_getb(a)			(*(volatile unsigned char *)(a))
 #define __arch_getw(a)			(*(volatile unsigned short *)(a))
 #define __arch_getl(a)			(*(volatile unsigned int *)(a))
@@ -24,6 +109,7 @@ static inline void sync(void)
 #define __arch_putw(v, a)		(*(volatile unsigned short *)(a) =3D (v))
 #define __arch_putl(v, a)		(*(volatile unsigned int *)(a) =3D (v))
 #define __arch_putq(v, a)		(*(volatile unsigned long long *)(a) =3D (v))
+#endif
=20
 #define __raw_writeb(v, a)		__arch_putb(v, a)
 #define __raw_writew(v, a)		__arch_putw(v, a)
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 9032e2ad6bb..007f68287bd 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -5,4 +5,5 @@
 obj-y +=3D checkboard.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D boston-riscv.o
+obj-y +=3D iocu.o
 obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/iocu.c b/board/mips/boston-riscv/iocu.=
c
new file mode 100644
index 00000000000..8478670f350
--- /dev/null
+++ b/board/mips/boston-riscv/iocu.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <dm.h>
+#include <env_callback.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include "boston-regs.h"
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
+	/* Record that I/O is coherent */
+	gd->flags |=3D GD_FLG_COHERENT_DMA;
+
+	printf("I/O:   Coherent\n");
+	return 0;
+
+noncoherent:
+	/* Map all PCIe DMA access to its default, non-IOCU, target */
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	/* Record that I/O is not coherent */
+	gd->flags &=3D ~GD_FLG_COHERENT_DMA;
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
+int misc_init_f(void)
+{
+	return set_io_coherent(env_get_yesno("io.coherent") !=3D 0);
+}
--=20
2.34.1
