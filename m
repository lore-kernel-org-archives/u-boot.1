Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32876C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D66831AC;
	Wed, 30 Jul 2025 07:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Gkywx04W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9484583045; Tue, 29 Jul 2025 18:23:50 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A7C82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1JDftZ/IEIHWEaZG2JS2b3LkF/VrcocTbNKhp5SgX7h8oGaMaUzPXq0gTS5gxbMXpOc3T153r4AYq1sa43s5Mjy9YPk2W+tvwBGmBsAfwcIcwNQt4hjBOsep/IhRo6BPan8PhrWidvkTk/imlwrYExQRrUM1//1yP4X7Z3QHAd7juE83TrJVQdMLqU7KPtxOyTsR4AktRk1J/gkOD3XYWD2KvaVMfpXN8L4normv/xxTsu5ZBPzw3gfwEUkSwF6UlEU6B8If1UZe4WofkAVfedD3JRwTsR2yGkKjEKkZzflwh88lxDU3CbKj53mZzYFIq4jzV1/8J2nHTW+1P8r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PiCwAtJrLOfKw3DY1cIKEjB+Tjw60Ka5pL1/28aDGo=;
 b=NXBib4P68QcM5Sqj/O0mdo05I0rVlGsqwGQ0taong00PYkTjVWRNYXH1hXxH9XMcNxfbeHAg++m7FoQjokeSmeVC4HJKJDlz6WHxM6C2+nz0SiYc3yRxKmcMUic06scm3w2r7xrpVZt3LFu2jfZSpRzdWNsnJr22db+Ni67Ah5gIicUTkEDJGkzC7kB2KK+vZbCs0auazYTkCVmrH5fF9+C9MKjON6piOqsMsN13j0WcrEaQCwT840FSe669ZJ6nnmYOerPjhh4UFuGqMCEZNVXgTmKVkDtZLDJQVbGTCyjulXxt7f649BQgyiv9XcgS5MJXQSYTSiAzCGefdUgTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PiCwAtJrLOfKw3DY1cIKEjB+Tjw60Ka5pL1/28aDGo=;
 b=Gkywx04WbZlY85yiqkohmRddOXozFQkvO9T13Y1SRlBOSuu0DsKeENDAjOW2ReI8hGEdSZvMF/CRha/LLeK3tqvTqSjru6egusaUir0EoMr/Cgv29+4aHUWx6CCDXgUvR6XLVeTmTIZMDqXK6yIaeM1BLbU1vf6py86cEGP76OsBO2ADzfMWe5yFOSgWO2nRyrkbamZoBHDqEm397qOObdxx5f4mUv8hNfCwwgrBCkK0ZvXYz1U63xAURKRXN5JdM5e/XUyWPuS6Vym+VG3AJYPzJE+FJ/KPuAMM+nSVbc2/jje0bNrQtBAa/UcBTJXSipDo7Gk9LFAAdxF5QGBDYw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:23:47 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:23:47 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 06/12] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v3 06/12] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHcAKUofPLbJ0bZCEuZlyLHNrHoEg==
Date: Tue, 29 Jul 2025 16:23:46 +0000
Message-ID: <20250729162035.209849-7-uros.stajic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 7fb09d7a-384b-4d53-cc81-08ddcebc4b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZcM611GbeJTda9J38XCs4OhKuKuPUPx3wTbH+LxkHDZ4uTj6zx2bpsSvVb?=
 =?iso-8859-1?Q?iOQxRv1QLnN0j4bjbI9VUTs8jhYywZduGFOFdNm3fVQ+0eUWjGsYxgYtRe?=
 =?iso-8859-1?Q?5zweSwjKWTNmSeibNC3t1v2PIDDlzz5WYQw0A3wvt5ZOr4SDFi1OwNzJ4Q?=
 =?iso-8859-1?Q?JEc8q55x1OhAvdTh1VVGgc+KcUZHipFDvLepcAzKRi8CY9xKekW1nEXQKz?=
 =?iso-8859-1?Q?4YEUUZUZVf94PNU/ViapvK0oEzhq28rMTCkgs7ZQPB/iAjDEnWQd/usfyU?=
 =?iso-8859-1?Q?ZZGF7sjmfOMX8jBhpQTaabJbIXqLYetGAsa/8mMPzpw4dA7kZ08D5g/9kf?=
 =?iso-8859-1?Q?W7CNAHF3r7Tpm5S7Jy+ORRwXFm+W9zSVfcWfc3Px2gLAqZbu8jsalW0ene?=
 =?iso-8859-1?Q?9c3UAgmsrIvGYSpn6PKpIiL3Vk918/LOKrNcIfoHRNs46kBjhy2+wzHFqc?=
 =?iso-8859-1?Q?R3ml3lGcumKxUmSRXDVxVmwbGg2PqlyYkzSzES2OaLFkz+ruvhkdpcxEBH?=
 =?iso-8859-1?Q?CuF8v96ooPAD4b+dcMXaOya1nwksmYj3kyhprbv1oR16uOpd/f0jM53wpq?=
 =?iso-8859-1?Q?0cu+4XjoJpROFcDSMQvq0kRnPSndWEogBteuIi6eqBiP+BHXx3GtYQFBNO?=
 =?iso-8859-1?Q?1UaLLzwdLlp90iPD5ndoxzKFuviJwNoRNP/EgE1rJS8VrDeyBAJrkesP3M?=
 =?iso-8859-1?Q?Tih+FkyamGhw7xTpEjqe9toC+Itl+TZItVt9Ou+HHpd/Hhk4vFbG2jSOB3?=
 =?iso-8859-1?Q?YTil6Jp79xFEQB3lqBnDY4sjK+sT3l/q5rRH6n4Zx8ebb/RwAhdIjIJgUI?=
 =?iso-8859-1?Q?ZUivEUFUVjujOppz9cIZEj4S80gU3lEmsnNAIrOHVlVS/me7ncNiSvGuLP?=
 =?iso-8859-1?Q?y5kqZM1axdqDEae6RtK2/Uvgawajq25fYDcMnrkM7CZ11YuaQ1sTvl9Zcn?=
 =?iso-8859-1?Q?Sa05tRbB99rJfNLlI0o8eAIEJgQ++Y/+Fxzp0lgqfRYGySRwAIEP6+RF+8?=
 =?iso-8859-1?Q?bgweWCS3TZLeOx4QjSDtGSI2+mz+W6e/CZJS3vZlhk48fvCg9Qhqd2J72U?=
 =?iso-8859-1?Q?Ha9wpDLP1thuz2cisXuj81DKxfRmgJHtAG/K1WeAgPk+2bspXm+iXYIegP?=
 =?iso-8859-1?Q?DzWgtokTfhSODajflR57g5wOEjtE8NsQOv3AAMSM5SdncpMVk8FVLl31H6?=
 =?iso-8859-1?Q?JoIXFQ/t1EvFrA5JShIrTZEM8ZzjKtSsKvEzWluxup0Ek1gMegOZDcjyeN?=
 =?iso-8859-1?Q?injre/FGcHy7C/O0l9rgcLASZTNsDEiuN8Vt5Rp0GLysXBl9xhgOUwpQ4Y?=
 =?iso-8859-1?Q?HDxxEIjzX5wzknwLqLxXKz91zNEE2vV+++2wZ1HJdhMdNVXoU32mxiJGNY?=
 =?iso-8859-1?Q?Cs3+uXU71VAe1odhWGwAfMyV0UNwkqS/pjs+TuBBapBRzRAliATTLxx+ue?=
 =?iso-8859-1?Q?BOceLH7jhSYUvwXFjd4TcztpCEOPT5XFrW6bxmoA+zYJf//9H6N+q1/p7u?=
 =?iso-8859-1?Q?v58VieTU/ZtpdCKPS2zluGlAu716xStVbyoZHXLelkWg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8WLHJU8eSmukBj4FmeGKeWM0GfZ9QYHTPtNtlkQ/J7BxcXtaOSODnEKvlP?=
 =?iso-8859-1?Q?FK+QbX9NrGgMBbhFOP0wEl1185F7qu9WbUVWJucOs6YGV0CxRanx0HtwbQ?=
 =?iso-8859-1?Q?HDjq/JYmhAmIAmBTLPpEgfB2nG2x9aFMORzjGRwfYcaU0qG/Y1Mp7Qf6b7?=
 =?iso-8859-1?Q?t9aLArI9w6ceZanbM5npxjLcSR9zg3IO34tWqRPcuJQDLNLmt+ekftzAlx?=
 =?iso-8859-1?Q?tjDwAert1sJUxLx7oHKq0xs7P0dZdbpUc/r9/Zu+BsPV0q4cMMICtxpHoT?=
 =?iso-8859-1?Q?4g1UzrCyaQzYLrDt5PrkQTtlNFO4V37MWd2w1Qg1zk85OsTpbq7e6dsxtF?=
 =?iso-8859-1?Q?SSeEx6PTimusXsNLBZTIa0weyBdaK+J8zqXMVpuOj2FXD5J1WZNRQEOxQk?=
 =?iso-8859-1?Q?kgENXehrkjQ+7PdB1jrBOg/BfUQN8f7rYDbdihuraNRdoEL/7AcR1NuHbh?=
 =?iso-8859-1?Q?Xf48sFRdfdE/HANNyCUczRRHWs2n3YwaJ4lnZt25wogVh24Sl2zme2BHjn?=
 =?iso-8859-1?Q?w82CYbwLGS3h0FvRwbS7xHQXf1EvOU+M8hK9tjemgu50RJAuZB7y73kSqe?=
 =?iso-8859-1?Q?GVOLcw0EV7WkWAjEyMlRYrmR8dxEc+e9HVLe7+b6BZdk8qZOPxbCBh2LWq?=
 =?iso-8859-1?Q?hDy6LDX/rZU1DMNZ2q/oe/ciXsyy+NzvQDev5tGDwDx/v494Ubd19G12ep?=
 =?iso-8859-1?Q?n7nTv5WnXry9YTHvuOtnFFlCkUqy52aA8jjHeo0Yn16IDax9at8/ncw7zQ?=
 =?iso-8859-1?Q?XjbqpPAr5KH8zRSJ02SE2477z6inkJRPKv497lvqldALPrw8YR6HGndbA/?=
 =?iso-8859-1?Q?STG95bdH4cjmBq2IEAxG/tyP/J0t3sYZq3cRdUJJvE+oX/R+6o7uu9ShCM?=
 =?iso-8859-1?Q?DUdkqiZZ2mAN5bjIs+JtVmIzE65M6XNKkOC9iFyJ5WOLAZ5VJWXFSwn1EX?=
 =?iso-8859-1?Q?XRr0tcdsW45VzzbJEyMlXb+kmGmTMXRiUWx17h3KxpbhrpJZZJa1W/e+Sz?=
 =?iso-8859-1?Q?mJwgj4H7kUmupDbEAvknuwj6mT9JgApm3rtDOHwuRb51wm3IIk6W4Z/92r?=
 =?iso-8859-1?Q?6D9lBr1AxPMSnVyhOB8icSY7dRhrFIKRNipKIGKwYS1qp+K+lUK/lsfYTo?=
 =?iso-8859-1?Q?Abb1Xa/JlUfNE+QbFeLpLmFxRUPv618cZmaldhnCvj7xtcScZa3OS0tfHE?=
 =?iso-8859-1?Q?B/J+qAQjMDT6HuxqQ2X0eJMIzUnsms/da7EgqKXb9R6RW5UpvCZIcdNrDK?=
 =?iso-8859-1?Q?82Lx2AwlkWV7A3JoIAxtxzRNXG5bSKVOdUdGYpbcRM/KILyWUL74xuad7D?=
 =?iso-8859-1?Q?6PHJB2cZuaBpMBXtIsxtdRkOZqFGihEzlL4FF7YV0UWg5DLge3p9qpAtul?=
 =?iso-8859-1?Q?H506kKCncRRlyQs2qmq/m3WzDmXFoKxkFcJuYEbWOIOq0y67RBvjhixkQe?=
 =?iso-8859-1?Q?dSy6E3F7WhpOvyBhA+5XFkkDza9CjDjtEZbKmDODL9mH5lUHuuWMEv1CtE?=
 =?iso-8859-1?Q?nE0NeaYHcig2AsItsx6MbmukoavTCrhtKbn1jA2/7Ck9BDMVQS1R9s2OEa?=
 =?iso-8859-1?Q?bc5Ui3szCiU2PI+VYRbBa+YNinRBW/zkdvwHSk3A2ZjA+uFeI+9jBMY2UF?=
 =?iso-8859-1?Q?plEiYegDdwkUeSDnFLjdY6eLciWFiWeNhkJVCbP8O8wG54kjOgJXgFCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb09d7a-384b-4d53-cc81-08ddcebc4b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:23:46.9434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzbdYXV1oIrY+gr9zNQjd4vZNE+D5w1mnj6+ZB6VV93VKe7e7BOzf8ZznxE3rjD1Cme4ZvKSr7boA1KHfNrQkLy/8RwswOeXcWW07X16mB4=
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

Add optional PHY reset support via GPIO defined in the device tree.

Improve robustness by handling probe errors and falling back to the
environment-provided MAC address if no hardware MAC is found.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig |  4 ++++
 drivers/net/pch_gbe.c           | 37 +++++++++++++++++++++++++++++++--
 drivers/net/pch_gbe.h           |  1 +
 net/eth-uclass.c                |  2 ++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 68c5fc50489..4d55d96603e 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -40,4 +40,8 @@ config PHY_REALTEK
     bool
     default y
=20
+config TFTP_FILE_NAME_MAX_LEN
+    int "Maximum length of TFTP file name"
+    default 256
+
 endif
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index adeca3d040d..dea8ab828ac 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -7,6 +7,7 @@
=20
 #include <cpu_func.h>
 #include <dm.h>
+#include <env.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
@@ -15,6 +16,7 @@
 #include <miiphy.h>
 #include <linux/delay.h>
 #include "pch_gbe.h"
+#include <asm/gpio.h>
=20
 #if !defined(CONFIG_PHYLIB)
 # error "PCH Gigabit Ethernet driver requires PHYLIB - missing CONFIG_PHYL=
IB"
@@ -33,6 +35,13 @@ static void pch_gbe_mac_read(struct pch_gbe_regs *mac_re=
gs, u8 *addr)
 	macid_lo =3D readl(&mac_regs->mac_adr[0].low) & 0xffff;
 	debug("pch_gbe: macid_hi %#x macid_lo %#x\n", macid_hi, macid_lo);
=20
+	if (!macid_lo && !macid_hi) {
+		if (eth_env_get_enetaddr("ethaddr", addr))
+			return;
+
+		printf("No MAC found in either EG20T H/W or environment");
+	}
+
 	addr[0] =3D (u8)(macid_hi & 0xff);
 	addr[1] =3D (u8)((macid_hi >> 8) & 0xff);
 	addr[2] =3D (u8)((macid_hi >> 16) & 0xff);
@@ -74,6 +83,14 @@ static int pch_gbe_reset(struct udevice *dev)
 	priv->rx_idx =3D 0;
 	priv->tx_idx =3D 0;
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset)) {
+		/* Reset the PHY */
+		dm_gpio_set_value(&priv->gpio_phy_reset, 1);
+		udelay(15000);
+		dm_gpio_set_value(&priv->gpio_phy_reset, 0);
+		udelay(5000);
+	}
+
 	writel(PCH_GBE_ALL_RST, &mac_regs->reset);
=20
 	/*
@@ -450,6 +467,11 @@ static int pch_gbe_probe(struct udevice *dev)
 	plat->iobase =3D (ulong)iobase;
 	priv->mac_regs =3D (struct pch_gbe_regs *)iobase;
=20
+	err =3D gpio_request_by_name(dev, "phy-reset-gpios", 0,
+				   &priv->gpio_phy_reset, GPIOD_IS_OUT);
+	if (err && (err !=3D -ENOENT))
+		return err;
+
 	/* Read MAC address from SROM and initialize dev->enetaddr with it */
 	pch_gbe_mac_read(priv->mac_regs, plat->enetaddr);
=20
@@ -459,9 +481,17 @@ static int pch_gbe_probe(struct udevice *dev)
=20
 	err =3D pch_gbe_reset(dev);
 	if (err)
-		return err;
+		goto out_err;
+
+	err =3D pch_gbe_phy_init(dev);
+	if (err)
+		goto out_err;
=20
-	return pch_gbe_phy_init(dev);
+	return 0;
+out_err:
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+	return err;
 }
=20
 static int pch_gbe_remove(struct udevice *dev)
@@ -472,6 +502,9 @@ static int pch_gbe_remove(struct udevice *dev)
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+
 	return 0;
 }
=20
diff --git a/drivers/net/pch_gbe.h b/drivers/net/pch_gbe.h
index 7e0fdbfd5a3..dcbb94094bc 100644
--- a/drivers/net/pch_gbe.h
+++ b/drivers/net/pch_gbe.h
@@ -292,6 +292,7 @@ struct pch_gbe_priv {
 	struct udevice *dev;
 	int rx_idx;
 	int tx_idx;
+	struct gpio_desc gpio_phy_reset;
 };
=20
 #endif /* _PCH_GBE_H_ */
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index a233912fd8e..f9f24305fb3 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -463,6 +463,8 @@ int eth_rx(void)
 			break;
 		if (!eth_is_active(current))
 			break;
+		if (net_state =3D=3D NETLOOP_FAIL)
+			break;
 	}
 	if (ret =3D=3D -EAGAIN)
 		ret =3D 0;
--=20
2.34.1
