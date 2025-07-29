Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB95C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6896C8329B;
	Wed, 30 Jul 2025 07:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="XV0y2jYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE83D83045; Tue, 29 Jul 2025 18:24:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F8D82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf+L8hompFb4yVUTkSDTZVKmjJfEipShhAOO2F2Dd8JtDWrFFn6DQ6/FpD9ST0YHMopA6iGWJ2GlW6yotzI9ptHfpjiTr6F1BqjW0nlmTheOyXCGKMBi9IlAlI788rYY8GsklKD/dPUW+QRG8A0vpO/gmNNP+7fDbLKKyGPkWvhp0rOLGEUBB3uij8O3wt3snRMZ5XoWagWhAi6OOHfCexcwLdQO3Sn7a6aJDfQS3vmJQtl2zh8KZNXRLHu0ZoihExavVQElPrpEjzz3CgxCLusADJuodKsIBMhZ4AumO8uu82NAWGJ85kUm2D4A8iPuljP2XBPrtp4clI3cszq/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7tOvNQ70xarJC8fBttAQLqohl9jWGPEZhbmn+HpQEk=;
 b=n8iBCD5VQE76XvMWwANK78OKN07pC368TF4ahjVXqN2t7BfE9Pb+W4zhLw32gpV1dJFDebcwckzEjOT6RmWE2cxtSJdGKo+1s4RA4SaqbUCkyLsp4N31hdQBpS5KA1G59alvdYKnR5qrvI/aR4XzefwuKNp7hGa9/Q/M4VKfvcl02InZEd4/aMy/5hocydD+kPB6H1D4arVFbpt9he3OLbZbcts204u3tMdOgJt5RxQFgoH58besIkykaoCG+2CtrRy9j2REwbcvRanfc3pNuNQNZ521xI0W7YjIDZE7XcCM9aKjLicNvFW87D6b+mEd0U6vAUFxiwD0lhjJyBjg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7tOvNQ70xarJC8fBttAQLqohl9jWGPEZhbmn+HpQEk=;
 b=XV0y2jYgEPK8rQHcOy+lt2lIPrymouGJyOL4VFGI7+qxlqGx5xPrxIq4DA1pWSz95vspoQTyLV7ukUbzyREoicHW6BYlvnIRhBa968dJ/TDmdyHT+5OZ7dSq9LbYtcXYrSH0StqBHfI+/ngurdRyo150uqrrznkf/nKt1x8jQRZvmjvap9zrVQL+2HD1MJBgkavhg8ZKx2lAxvtoexfB/68Syq59REzGO63h3JHTVdInY4ijw81Hi9nCA2zZlLVa80MmfmpcTYgnHB1DoHVbcT/VkfWklY88uMH7VnqofIs0n/jtP8TzBZodXmrrXOc4ECQqa+QkK4hgu589cNAb2Q==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:24:17 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:24:17 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 08/12] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Topic: [PATCH v3 08/12] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Index: AQHcAKU7iK9HHJHXb0+m511k9Hmdyw==
Date: Tue, 29 Jul 2025 16:24:17 +0000
Message-ID: <20250729162035.209849-9-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB8338:EE_
x-ms-office365-filtering-correlation-id: 23336362-85f8-47d7-42ce-08ddcebc5dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sXdmM+5GSalY1Fu6mUk9INC/qh94Sf2WK+XTMZUmWXy3dZl1FvgxPNyG1T?=
 =?iso-8859-1?Q?0045KO0wSgm6fNwNhhJnFMjc4+/hcG0KXcoSZPYk+/KanfoHy5Doyd43lj?=
 =?iso-8859-1?Q?0u831DBtRiyDASZL/a7M65QgwKIBvGH0bZQz/NyQbPMYe6Ne8FKCleXY9C?=
 =?iso-8859-1?Q?jxQdNOM0SsPgA/XV07ygBmW144eunWiA+LhiYXKdNmLbBM1JmOY58CRbMu?=
 =?iso-8859-1?Q?kpdY5DJ41vzKNzeeK/pi59irIbH11q0ogfz3SDeKj9Hdxp8G3/aGqqOuFF?=
 =?iso-8859-1?Q?1ZO5avHd0ZMVhvFrbjgMOhoSZLfLuGMalW8HUofSocJ+IacwG/GH2ftLJ8?=
 =?iso-8859-1?Q?8JTabOKQz5Q7XE2CZ8QjpRo4AlyjAr10niGAKzbDTKuXVS+PK8oqG9c1ov?=
 =?iso-8859-1?Q?ivlIItYOLlx1DubOvY/ywawmCkk3QKvSwtGlEeu07AfhQ9u2zABbDN00/X?=
 =?iso-8859-1?Q?xG2AVqge5Z4BoscPOe9/MMPbWjdEmyOboujSUIU8OefLOrStn6Hql6il38?=
 =?iso-8859-1?Q?doaLAK3aMU/Jpgvf/PIIsAGn+iXFSBFL/4+JRCzWx3wx7YzI3Q+C2nP/gM?=
 =?iso-8859-1?Q?cdZOAPwWo5mtOn7Tenu/Ak49aWIZvG/BCFtRLDA27WfUu7QKJ2bJYtzupY?=
 =?iso-8859-1?Q?lnm5XxpUrg9ZhVyA8x4FuvuXiS3Eq8YP5PELIXw3x2vaBXLXvLeE6Wtui8?=
 =?iso-8859-1?Q?XQ7HSXKC/Cjg8CEcrcRZOasNuHFnQ1TqkQ+/X7R74qlglwwGT5bo4GMeYS?=
 =?iso-8859-1?Q?mi8Sub91tCGxkx+DLEZxODJbKWWeleI+3IOqcPLRxRQRoDNBVdXMgFFmdD?=
 =?iso-8859-1?Q?gZAuXguzfBItM7z0IeNy6H8glqW62gjvEfN+rHdg4JsAzHZXGoSkTJxQew?=
 =?iso-8859-1?Q?y7p252XC9vQczyrMTb57awuwitQ3B62fQon66ur1NRi82Qzcw69FfhxWBO?=
 =?iso-8859-1?Q?hx3NH/xBnmLVQZu75Ag/6tz0HcFwdr/VACBlwgfHSDcIs2JY/hTHxlsfCU?=
 =?iso-8859-1?Q?hXpU4ygh1agh6Jnyt9Y0rpwqAS6TEmIyOxPRlICtxodDF2zyeJBwNNrzEl?=
 =?iso-8859-1?Q?nF2adbDiN+AMzTJvd/9M+95WRbRE/v23G4vWRQ8RQTlJ7YUQ+Zvd0o24Hk?=
 =?iso-8859-1?Q?0dfHii3Cro/pfgvUzHrIEezUMZBjqhpHZBlXajP8U8C8B4QnedK/Y9g8AC?=
 =?iso-8859-1?Q?dH/6dmlsFQ3Gbncm2m++h3pIEcgWb/Z1p3BgpRairF780hyol1fDuONyNL?=
 =?iso-8859-1?Q?xSZFPwLmAFf1YhwIVE7qemAKGS8R8mWxRsoe3hEhg/jHWpxyNgN8rG/jvZ?=
 =?iso-8859-1?Q?dQAu69U0WAMVK+h0dY9vXJUHqC2aR0XMYnoGcIMezSWZ/eXQJLcx7QfEDy?=
 =?iso-8859-1?Q?H86LD3jOxF1Rn9dU/QjxwFrli4TnBV3aBHDS51JNiri1gfv6nK676S5eeB?=
 =?iso-8859-1?Q?zu+cMM5RB5Kaoljk6HTFtpCuXWOpMCGIcCMWYvoxBvY+63/vmRzR95m/pR?=
 =?iso-8859-1?Q?dDSJZ+rXZREatzSmCfPXybJ2PXBEwbCpPiSsbF1zCzAA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ifP5vqmultDUmvjXJG+TybnkBr7NVIIjMpeQFq7h6YVth78COJUOrTuVh8?=
 =?iso-8859-1?Q?zrMNT41p683EXILPo/mMBN/wxlyQmfUPlmcAd8/obgse0xy8kkFhPDcEV+?=
 =?iso-8859-1?Q?O+PxKanuSQfNiyUC5VkWX80NBnR2Ioeqouy5ElSpFCC4BpaIUkK7TLkxgZ?=
 =?iso-8859-1?Q?PDdjkGcRUIlnpbf7Yg6Ck03jcbgVzY8oMuxGSf0Skh04YTr8KnZf/yIRap?=
 =?iso-8859-1?Q?FdS/rlyjg4SGLfZOMuDsRU315Nlupej+SC/qXpRxDkL6d8tv5W3lV/gTpW?=
 =?iso-8859-1?Q?nKfNGbQgU/cIHQw01bxOT6ks2ol5YfgaePLwITTHhhela8MTtwJKKIWAqN?=
 =?iso-8859-1?Q?KYuNJ9GRZqzqFg1KE9PelEQgg76OZFhJl7MHCEGU0F8hrcl3vs7jhJoSWe?=
 =?iso-8859-1?Q?SQ7oHCFjg5kA09iT2A1ezmgoKQZMVYJZ1dOepM2YGjEmOXGvAvo65NsdQ7?=
 =?iso-8859-1?Q?221EsH3dNw1a6ja0Ea13Lt7XTb/vRrIaIx0OxGnaUhWH9lemLW08jLKIFx?=
 =?iso-8859-1?Q?lEeSmdVyNG4Wuqq71rzInVzsh3snlZEpcQTnHEzAHzxgv2Pg8jRBJp35xp?=
 =?iso-8859-1?Q?TKbxAhwX8WruHjPRLXa9yLJrZVu9ZaKKSKeel51oXpER+GCLopjveURFgv?=
 =?iso-8859-1?Q?4ixHpBwDfFvLR2X42Ye5K0Y+5fyW11QpZjlOhZ6uwlleCB4vtIFyT+2wvo?=
 =?iso-8859-1?Q?HdOO/1Wnw9t2KttIDaQ98sQc9teBnpgeM5e2j1oNvx+Q695dIFjL8tLCfd?=
 =?iso-8859-1?Q?8EGGBSpzBaS29PW3LPBwAyhBKE/NTFkm566f7dmzCqfHZQSuC13oQDCqzb?=
 =?iso-8859-1?Q?AU5orCr1weB6hbSHy88PvlZjh9kPIkRdfPQFaUl92uNpm8HvPoXrmEAybB?=
 =?iso-8859-1?Q?YKq8AHG0w1iqWs9pHEgb2itOzOAiFTleCOao1V9Wmm365pgKSiQ1udDUoB?=
 =?iso-8859-1?Q?Zvh0RTJ+2ePVzT3348lxssIJQtGPio9QWiZj3vY8x4g80vj0rUXszW8m5E?=
 =?iso-8859-1?Q?NteX8loyEclY4E6KbJryIPKcfnIYNfldhEB3xltWJoFx/h3pG36Pit5ND7?=
 =?iso-8859-1?Q?Zx7RQLhXbalqAoRn2C5Adn3dhSqxv2HX8mZcYvh+GygIDL6H4ADWOV0sxH?=
 =?iso-8859-1?Q?MFTGas867wVH3qkHgZ2ZsaoZiAPZPxSojSE+nNoL9jgbyCNkNUt5GeliXr?=
 =?iso-8859-1?Q?ab0PMVPzgcxqApWBQuIwJ+VCBMXTJBUeLAWW7joUjrRaYl2YNn9G/L2U52?=
 =?iso-8859-1?Q?wVUJ3Fq9THaEH2jDl2fng2ya/vWsdSxx9i7dZixRjUZdqnL7X3+5/DukYl?=
 =?iso-8859-1?Q?fGS+Q9pAq/RUUG7oZzdOMUsLSte1RY5GbeZv3HNm55J+Vd9glWeKdjs8jL?=
 =?iso-8859-1?Q?5yqwNVzXiPnDd/bebU/tgwELM5CmU/Tt0Rm4EYGXm3mSaEHmDShu6CRG5O?=
 =?iso-8859-1?Q?v8JTk0vRTkE4uoPmZqp1sXSyoumUFQs0UMmthONhH37kc/SG3lpsI6BoRk?=
 =?iso-8859-1?Q?OClE2cKRA10hUiyvjuK2MkjRFDtBktQ0BSMXK7yQ7eFJONTRy2d+Jy/Co1?=
 =?iso-8859-1?Q?HqfOKaa0Lg1Q2n+v9zs0XUW7R0nhc9n1+Qtuu5eHiONzuylFaD0KnJW3tU?=
 =?iso-8859-1?Q?Gg+cghQEjn3Ef7VH0cejgKj9s1wP7ObEkC3r6MXhgf0bNhfyZo2HFpWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23336362-85f8-47d7-42ce-08ddcebc5dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:24:17.7037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcWap4ZWJH8Ow3ReI82e+mz5dRtKL/mg/tgnGDfEBxOPr391S+qh1JUCHhUkkq32fsYBmjjqbPAj5a4l0y6nFYD2/oIzJw1vykrmf1mpS+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8338
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

This patch adds software emulation for atomic memory operations (AMO)
instructions that may not be supported in hardware.

The `emu-amo.s` file provides assembly implementations of the
aforementioned operations. Corresponding handler logic is integrated
into the illegal instruction trap to catch and emulate unsupported
AMO* instructions at runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/cpu/p8700/Makefile  |   1 +
 arch/riscv/cpu/p8700/emu-amo.S | 254 ++++++++++++++++++++++++++++
 arch/riscv/lib/interrupts.c    | 299 +++++++++++++++++++++++++++++++++
 include/interrupt.h            |  19 +++
 4 files changed, 573 insertions(+)
 create mode 100644 arch/riscv/cpu/p8700/emu-amo.S

diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
index 4dfbddc5cba..22f96401640 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -5,5 +5,6 @@
 obj-y +=3D cache.o
 obj-y +=3D cpu.o
 obj-y +=3D dram.o
+obj-y +=3D emu-amo.o
=20
 obj-$(CONFIG_P8700_RISCV) +=3D p8700_platform_setup.o
diff --git a/arch/riscv/cpu/p8700/emu-amo.S b/arch/riscv/cpu/p8700/emu-amo.=
S
new file mode 100644
index 00000000000..b7005339939
--- /dev/null
+++ b/arch/riscv/cpu/p8700/emu-amo.S
@@ -0,0 +1,254 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+        .text
+
+        .align 3
+	.globl	atomic_swap_w
+atomic_swap_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a1,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_swap_d
+atomic_swap_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a1,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_add_w
+atomic_add_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	addw	a3,a5,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_add_d
+atomic_add_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	add	a3,a5,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_and_w
+atomic_and_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	and	a3,a5,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_and_d
+atomic_and_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	and	a3,a5,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_or_w
+atomic_or_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	or	a3,a5,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_or_d
+atomic_or_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	or	a3,a5,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_xor_w
+atomic_xor_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	xor	a3,a5,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_xor_d
+atomic_xor_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	xor	a3,a5,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_max_w
+atomic_max_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bge	a5,a1,1f
+	mv	a3,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_max_d
+atomic_max_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bge	a5,a1,1f
+	mv	a3,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_maxu_w
+atomic_maxu_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bgeu	a5,a1,1f
+	mv	a3,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_maxu_d
+atomic_maxu_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bgeu	a5,a1,1f
+	mv	a3,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_min_w
+atomic_min_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bge	a1,a5,1f
+	mv	a3,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_min_d
+atomic_min_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bge	a1,a5,1f
+	mv	a3,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_minu_w
+atomic_minu_w:
+	lw	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bgeu	a1,a5,1f
+	mv	a3,a1
+1:	lr.w	a5,(a4)
+	bne	a5,a0,2b
+	sc.w	a6,a3,(a4)
+	bnez	a6,1b
+	ret
+
+        .align 3
+	.globl	atomic_minu_d
+atomic_minu_d:
+	ld	a5,0(a0)
+	mv	a4,a0
+2:	mv	a0,a5
+	mv	a3,a5
+	bgeu	a1,a5,1f
+	mv	a3,a1
+1:	lr.d	a5,(a4)
+	bne	a5,a0,2b
+	sc.d	a6,a3,(a4)
+	bnez	a6,1b
+	ret
diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index ef1056eeb6f..906916c762f 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -22,6 +22,36 @@
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
+#define ILLEGAL_INSTRUCTION 2
+#define AMO_MASK 0xf800707f
+#define AQRL_MASK 0x06000000
+#define AQRL_SHIFT 25
+#define RS2_MASK 0x01f00000
+#define RS2_SHIFT 20
+#define RS1_MASK 0x000f8000
+#define RS1_SHIFT 15
+#define RD_MASK 0x00000f80
+#define RD_SHIFT 7
+
+#define AMOADD_D_MATCH 0x0000302f
+#define AMOADD_W_MATCH 0x0000202f
+#define AMOAND_D_MATCH 0x6000302f
+#define AMOAND_W_MATCH 0x6000202f
+#define AMOMAX_D_MATCH 0xa000302f
+#define AMOMAX_W_MATCH 0xa000202f
+#define AMOMAXU_D_MATCH 0xe000302f
+#define AMOMAXU_W_MATCH 0xe000202f
+#define AMOMIN_D_MATCH 0x8000302f
+#define AMOMIN_W_MATCH 0x8000202f
+#define AMOMINU_D_MATCH 0xc000302f
+#define AMOMINU_W_MATCH 0xc000202f
+#define AMOOR_D_MATCH 0x4000302f
+#define AMOOR_W_MATCH 0x4000202f
+#define AMOSWAP_D_MATCH 0x0800302f
+#define AMOSWAP_W_MATCH 0x0800202f
+#define AMOXOR_D_MATCH 0x2000302f
+#define AMOXOR_W_MATCH 0x2000202f
+
 void set_resume(struct resume_data *data)
 {
 	gd->arch.resume =3D data;
@@ -115,6 +145,184 @@ static void show_code(ulong epc)
 		printf("%04x%s", pos[i], i + 1 =3D=3D len ? ")\n" : " ");
 }
=20
+static ulong get_reg(struct pt_regs *regs, int reg_num)
+{
+	switch (reg_num) {
+	case 0:
+		return 0;
+	case 1:
+		return regs->ra;
+	case 2:
+		return regs->sp;
+	case 3:
+		return regs->gp;
+	case 4:
+		return regs->tp;
+	case 5:
+		return regs->t0;
+	case 6:
+		return regs->t1;
+	case 7:
+		return regs->t2;
+	case 8:
+		return regs->s0;
+	case 9:
+		return regs->s1;
+	case 10:
+		return regs->a0;
+	case 11:
+		return regs->a1;
+	case 12:
+		return regs->a2;
+	case 13:
+		return regs->a3;
+	case 14:
+		return regs->a4;
+	case 15:
+		return regs->a5;
+	case 16:
+		return regs->a6;
+	case 17:
+		return regs->a7;
+	case 18:
+		return regs->s2;
+	case 19:
+		return regs->s3;
+	case 20:
+		return regs->s4;
+	case 21:
+		return regs->s5;
+	case 22:
+		return regs->s6;
+	case 23:
+		return regs->s7;
+	case 24:
+		return regs->s8;
+	case 25:
+		return regs->s9;
+	case 26:
+		return regs->s10;
+	case 27:
+		return regs->s11;
+	case 28:
+		return regs->t3;
+	case 29:
+		return regs->t4;
+	case 30:
+		return regs->t5;
+	case 31:
+		return regs->t6;
+	default:
+		printf("Error reg_num=3D%d for %s\n", reg_num, __func__);
+		break;
+	}
+	return 0;
+}
+
+static void set_reg(struct pt_regs *regs, int reg_num, ulong reg_value)
+{
+	switch (reg_num) {
+	case 0:
+		break;
+	case 1:
+		regs->ra =3D reg_value;
+		break;
+	case 2:
+		regs->sp =3D reg_value;
+		break;
+	case 3:
+		regs->gp =3D reg_value;
+		break;
+	case 4:
+		regs->tp =3D reg_value;
+		break;
+	case 5:
+		regs->t0 =3D reg_value;
+		break;
+	case 6:
+		regs->t1 =3D reg_value;
+		break;
+	case 7:
+		regs->t2 =3D reg_value;
+		break;
+	case 8:
+		regs->s0 =3D reg_value;
+		break;
+	case 9:
+		regs->s1 =3D reg_value;
+		break;
+	case 10:
+		regs->a0 =3D reg_value;
+		break;
+	case 11:
+		regs->a1 =3D reg_value;
+		break;
+	case 12:
+		regs->a2 =3D reg_value;
+		break;
+	case 13:
+		regs->a3 =3D reg_value;
+		break;
+	case 14:
+		regs->a4 =3D reg_value;
+		break;
+	case 15:
+		regs->a5 =3D reg_value;
+		break;
+	case 16:
+		regs->a6 =3D reg_value;
+		break;
+	case 17:
+		regs->a7 =3D reg_value;
+		break;
+	case 18:
+		regs->s2 =3D reg_value;
+		break;
+	case 19:
+		regs->s3 =3D reg_value;
+		break;
+	case 20:
+		regs->s4 =3D reg_value;
+		break;
+	case 21:
+		regs->s5 =3D reg_value;
+		break;
+	case 22:
+		regs->s6 =3D reg_value;
+		break;
+	case 23:
+		regs->s7 =3D reg_value;
+		break;
+	case 24:
+		regs->s8 =3D reg_value;
+		break;
+	case 25:
+		regs->s9 =3D reg_value;
+		break;
+	case 26:
+		regs->s10 =3D reg_value;
+		break;
+	case 27:
+		regs->s11 =3D reg_value;
+		break;
+	case 28:
+		regs->t3 =3D reg_value;
+		break;
+	case 29:
+		regs->t4 =3D reg_value;
+		break;
+	case 30:
+		regs->t5 =3D reg_value;
+		break;
+	case 31:
+		regs->t6 =3D reg_value;
+		break;
+	default:
+		printf("Error reg_num=3D%d for %s\n", reg_num, __func__);
+		break;
+	}
+}
+
 static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *=
regs)
 {
 	static const char * const exception_code[] =3D {
@@ -140,6 +348,97 @@ static void _exit_trap(ulong code, ulong epc, ulong tv=
al, struct pt_regs *regs)
 		gd->arch.resume->code =3D code;
 		longjmp(gd->arch.resume->jump, 1);
 	}
+	if (IS_ENABLED(CONFIG_P8700_RISCV) && code =3D=3D ILLEGAL_INSTRUCTION) {
+		// Fetch one 16-bit op at a time to deal with 16-bit alignment.
+		// FIXME! For the big-endian mode, we need to swap bytes.
+		unsigned short op0 =3D *(unsigned short *)epc;
+		unsigned short op1 =3D *((unsigned short *)epc + 1);
+		unsigned int opcode =3D (op1 << 16) | op0;
+		//int aqrl =3D (opcode & AQRL_MASK) >> AQRL_SHIFT;
+		int rs2 =3D (opcode & RS2_MASK) >> RS2_SHIFT;
+		int rs1 =3D (opcode & RS1_MASK) >> RS1_SHIFT;
+		int rd =3D (opcode & RD_MASK) >> RD_SHIFT;
+		ulong rs2_value =3D get_reg(regs, rs2);
+		ulong rs1_value =3D get_reg(regs, rs1);
+		ulong rd_value =3D 0;
+
+		switch (opcode & AMO_MASK) {
+		case AMOADD_D_MATCH:
+			rd_value =3D atomic_add_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOADD_W_MATCH:
+			rd_value =3D atomic_add_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOAND_D_MATCH:
+			rd_value =3D atomic_and_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOAND_W_MATCH:
+			rd_value =3D atomic_and_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMAX_D_MATCH:
+			rd_value =3D atomic_max_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMAX_W_MATCH:
+			rd_value =3D atomic_max_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMAXU_D_MATCH:
+			rd_value =3D atomic_maxu_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMAXU_W_MATCH:
+			rd_value =3D atomic_maxu_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMIN_D_MATCH:
+			rd_value =3D atomic_min_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMIN_W_MATCH:
+			rd_value =3D atomic_min_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMINU_D_MATCH:
+			rd_value =3D atomic_minu_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOMINU_W_MATCH:
+			rd_value =3D atomic_minu_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOOR_D_MATCH:
+			rd_value =3D atomic_or_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOOR_W_MATCH:
+			rd_value =3D atomic_or_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOSWAP_D_MATCH:
+			rd_value =3D atomic_swap_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOSWAP_W_MATCH:
+			rd_value =3D atomic_swap_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOXOR_D_MATCH:
+			rd_value =3D atomic_xor_d(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		case AMOXOR_W_MATCH:
+			rd_value =3D atomic_xor_w(rs1_value, rs2_value);
+			set_reg(regs, rd, rd_value);
+
+		default:
+			break;
+		}
+	}
=20
 	if (code < ARRAY_SIZE(exception_code))
 		printf("Unhandled exception: %s\n", exception_code[code]);
diff --git a/include/interrupt.h b/include/interrupt.h
index 6ea28b54a56..5fc983afccb 100644
--- a/include/interrupt.h
+++ b/include/interrupt.h
@@ -43,3 +43,22 @@ struct resume_data {
  * Return:	0 before an exception, 1 after an exception occurred
  */
 void set_resume(struct resume_data *data);
+
+ulong atomic_swap_w(ulong val, ulong addr);
+ulong atomic_swap_d(ulong val, ulong addr);
+ulong atomic_add_w(ulong val, ulong addr);
+ulong atomic_add_d(ulong val, ulong addr);
+ulong atomic_and_w(ulong val, ulong addr);
+ulong atomic_and_d(ulong val, ulong addr);
+ulong atomic_or_w(ulong val, ulong addr);
+ulong atomic_or_d(ulong val, ulong addr);
+ulong atomic_xor_w(ulong val, ulong addr);
+ulong atomic_xor_d(ulong val, ulong addr);
+ulong atomic_max_w(ulong val, ulong addr);
+ulong atomic_max_d(ulong val, ulong addr);
+ulong atomic_maxu_w(ulong val, ulong addr);
+ulong atomic_maxu_d(ulong val, ulong addr);
+ulong atomic_min_w(ulong val, ulong addr);
+ulong atomic_min_d(ulong val, ulong addr);
+ulong atomic_minu_w(ulong val, ulong addr);
+ulong atomic_minu_d(ulong val, ulong addr);
--=20
2.34.1
