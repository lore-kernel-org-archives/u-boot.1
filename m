Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3642C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C2282EB8;
	Tue, 24 Jun 2025 15:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="IbGuJ2zK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EBC82D17; Tue, 24 Jun 2025 12:28:07 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A4282C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewX9034S9Yljmx2qZJrYfzykGIpmwTiVUDkdvJ0ElIHdU874cUq3jrk3Z+x/a8y6vVDrmzjdu8QpXeqMO7OQRnK1QnTRAPnQbPH6BLE/65/LqxXywTjCfvIGfilH8TK+CgHLMdBdbrWVBZU3dCxEnpMmLdYgT4gQlBneTQxkB3Ah5cwZN0nMShEAbI5YzXK26yju0DSne0L0R9iajsslFJzeUr4w6MTJ83zdev1jFU0sq+yGGNDmxXWM5Zve3npVHHxMFFFB2IQILlElunt3svdsRe988tZaJ0TinQBvq17UaZ8QIcNn8ObTzGKfKbTdeBkAlQWxZ6PgDZa481/Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt7fM0sJI7JsjLxiv1qcY7YbeiAzROKffBFvkkkZa5M=;
 b=hbWgZMp9R1xdmXUcZpvhBAki74h/94EeAOc8it40DxWq/kdGjOmETzfL3yaoI+tMuRGnClE7fyaq/QTc5dnSxciRBD2BbFMOTGS0eePjXdHJwJf3A7d7zNbc//VrIDI6bLVHdH8b7FskyZuq8BuPWKSpZagsafBbMT1AuQL0QIE5O1T+m1cbvmN4TYnZqkhCCBEFOkzHHZBgxowTwBZbiU8yH8ZT5h1Khtk3FZ9k1BHVfXMqiNiwNtZv9kkLlDkAriEweWIdKUxabgOXOP4a8PvEbJB82mYsWCqyYkH7dcYXn94jEmrO4Hm0Q+XTemHBrqJ9xRG7cdSzzXYhBtqBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt7fM0sJI7JsjLxiv1qcY7YbeiAzROKffBFvkkkZa5M=;
 b=IbGuJ2zKK5TyXT1Ojjv5+WVSbJEMGkkCui7KDjj5FMF5EPW4S6DN/UpZSppZEe2fG8ClWHPSpIuxtE9a37JN9UTmpaerMC/4Kz+4dtQ+iHhIQ+y+FLbl+IvwzGVhWBlbO7EHrvF1cTG3AVCltlnZFj6PPhHSNvwVyZFfmHYxOBb7QwghuOpXt4/qCYdcv39PyOkjsrW7V5ikvnADWWi1jGTsfjnBUoNCdHFjBsnUBgO167plMr+rw9SDJs+b2QMyLztI1pEuxw4qagOxoINUNB9eQ4CLUtPU87gbb/vPoMvADZ3b61DgwuE9PexPHyY52vgBSNBDtm8yV+QJsw/xKA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PR3PR09MB5475.eurprd09.prod.outlook.com (2603:10a6:102:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:28:03 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:28:03 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 07/11] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Topic: [PATCH v2 07/11] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Index: AQHb5PKqi3FLvjB0yUeZqNKqkY+E/g==
Date: Tue, 24 Jun 2025 10:28:03 +0000
Message-ID: <20250624102449.324410-8-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PR3PR09MB5475:EE_
x-ms-office365-filtering-correlation-id: f5d87e0a-8284-49ac-9d10-08ddb309ccee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zyz226wQyuUx8hKiFHCi3mUZX46AOPHDESplgAJUsva5tbZ5TmFAD4BXNO?=
 =?iso-8859-1?Q?KyuCdT3o+a7JOaDmPPKvGsNcHUPTPOclf4jDiFFZxUebtOSPkpfLI6pHX4?=
 =?iso-8859-1?Q?zJoAVT7y+ZUkZkTqw+yExMwosGrMt+8DOVsrEkXm5YH1ih9NrmpLiPBKAd?=
 =?iso-8859-1?Q?9Q2XZZP7Ao8ZhKSOVpzK7vD5sgCajDmcwt6FtAJznfole/eJ69/GBc0ucK?=
 =?iso-8859-1?Q?43RfF/2gsiZpgIq5IhXDA6KbCUf/t1poYoJLLiu5ooB9DnJLNee8VxbqEJ?=
 =?iso-8859-1?Q?mRRzxgbxw+Iamh4jZchiZY48+HvY2I8k1qgnCx1/XKS7Qd6S8yZ2oJ3DqA?=
 =?iso-8859-1?Q?/is8/0yvby9wPVrT72mqxgeM9R+gwpbS32tgJreCJdccveGheY5Bx62+rk?=
 =?iso-8859-1?Q?sF0K0CnSK6nHyrD7jCcjRRQDJtNN1SeDZQadiig/PkFbx8CUp3rJVWf+5y?=
 =?iso-8859-1?Q?3vaNQES/2EwkwaL4kiH/9WZwnbj/ihEwXQ7mn1QGrZ0eiSulGeMUPe8cMh?=
 =?iso-8859-1?Q?B5X8VdF9b5iobfLYL425fQrol294Z8gMbLWjUCHUP9ww9+Tp99i7zfHWXk?=
 =?iso-8859-1?Q?bmkIaQZi4sKb5HoC4JJ7E+Nm7uhk5hz5wPM0wM2Qn0aK9r07PWNq+uGMh1?=
 =?iso-8859-1?Q?v7bgaXdyKsqq5KzXBoeat3vUdf2K8uQQNCnyvgil/DiUMIJg2949ONNAeV?=
 =?iso-8859-1?Q?/SqxK1FPqlHuRT1+iVscueZtJsgVGGsyGBb7qX82MBMrJphvLDebEtJnOy?=
 =?iso-8859-1?Q?fFo2Ce5pwq3FV4m+6Gkf9KS3HvWd3/WdxgwPEJBmQanmZCT9ddiXhCf9so?=
 =?iso-8859-1?Q?jFjfPkAw7wlGKlDWASSbKOLRR6uW0oeTWQLP2cVseErHlFWQC9SrjvTAqg?=
 =?iso-8859-1?Q?5xgfVZ3W4u6aJQSfMs1iR/RxGTigDvRy2YG3gyXUfthj+Ya6eafD0wrvpl?=
 =?iso-8859-1?Q?j20VggYE/yyAc8Up3630IZkAB5NDRd1z/HhqNPukdGukAGTOa5rMxRyh2d?=
 =?iso-8859-1?Q?cbgCncUxyvB7poki7hU618ax6FZAytUYiAG0W13P4nxeZd7dpW7beWK3QH?=
 =?iso-8859-1?Q?qhdaMnplcyE62m4E4ytXWnzAygm7ORSTk6xeLk5/pglXyV2WwBT/LbRha8?=
 =?iso-8859-1?Q?+lzOTOeZcsri86fvAvV5dNrvmjG2a5EHn9LJpm0ccQgKYMVBuy7ZJ4QoKw?=
 =?iso-8859-1?Q?LPIEnVJksb348uf/1h/BR1Wnks5CUnmPHw1jBL1h267Ii+phFgcrOzWyqD?=
 =?iso-8859-1?Q?8RggjRe7yLS8QG3E/7h5oFRVaz1Zjt9si/5037LCv4OLhiI+RuXM1VLins?=
 =?iso-8859-1?Q?tWndcaootMoNE4nvBsP1aW/dxKO5N9jPVOFPEYls4U8g7dp1m/yAo/vdT+?=
 =?iso-8859-1?Q?qvctejlOcuyPAZhOTlO8L+4g02i7uDO69X1chnxeSAEic6xltOvf/WnkE1?=
 =?iso-8859-1?Q?DVy8bsc0gd8RFsgsdw1V7GwJ1JnQ7ZOoemcaL7VqVsWymV6K90tQw2qnvS?=
 =?iso-8859-1?Q?BuNBeeQRjPHwGmQcp59UDQlu7sOcpejdWM/x2oi/Tg/Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SPLFUP9oQgHoCTVhsLolAA4oVf0JFGs46TN36A1cayuCGxBxQjTU+nnQou?=
 =?iso-8859-1?Q?YAMYyy4VRiDuXFaOPCwbcRaNOI1wJwRvUprlYLbuxNJbckCn9Ne4FGnjmq?=
 =?iso-8859-1?Q?n86uNdRKzrhjiGajzB6MOw2oUtI1afnEP+JRjdnez7tux1c/A4O9QzMNxG?=
 =?iso-8859-1?Q?d2toKNOTmqBMhsLC4Zr1pV1daRA9qo4kCbxvwxKll1w7k4EJO0T/Ncesko?=
 =?iso-8859-1?Q?0r5qPOCJc9NtM2GSh2drj2xMNQfdxFmJNXcOfCtjPJvdMFsp8O3M8GlL7O?=
 =?iso-8859-1?Q?O02F9je7BIFleJONQyX80GPGhiH8kUwvTBjlWxeDu9B9JZasL9qCVIdWHl?=
 =?iso-8859-1?Q?su4BHJeeacRv5PmcPSwfNQQoSgfesYpFuDfQiOrAtKjkWuWxXR0g2HuSa1?=
 =?iso-8859-1?Q?Jb6xPJXucFSiX0AiBiRgg6xrEG+S/+Mwuryq29schcM/eQZlaCYR5CfNR3?=
 =?iso-8859-1?Q?47tBjqE4sLuqxOZV4O3oQNdZnqPQz4A/wwBnlPqv88Z/mFqxVe9V7Dj2c3?=
 =?iso-8859-1?Q?/+yfdufEX3/X9sHXxpRn9+au/qizyTb8xSf1dL7qXKgez2UdYclk3CfzyM?=
 =?iso-8859-1?Q?MHm2b2cZExq+G43m/0cZkQE+9ejRbX9cyq1aYXPiau4vY6AKq4sAjvVmrr?=
 =?iso-8859-1?Q?FUXATIIwLWi5ZlEwtRvqbno8YGLkxsWsidewH9CpPeVVBkFcanSiE3g0pO?=
 =?iso-8859-1?Q?NEHfat92RR5NNoQ+McIChG8kbEClqJu/Xc2MjOfCYzhVXikGazrqLTwpfw?=
 =?iso-8859-1?Q?l6StOIuISULxTrSdG72y+9xDE2Bfpaj1+5+eT2tiPf41JB3ddXbSm99FG9?=
 =?iso-8859-1?Q?06z/JFEZEb7qzony8fBmbRWzxJ6F2rDPCXj4jFPbgNhzMbPQ3fK2tQMnzs?=
 =?iso-8859-1?Q?ALEnmO2C9iBaw0ld0IpLajHV9oxlvp02cX+LVWe8+k2LcJDCwJ0JkqFf7p?=
 =?iso-8859-1?Q?LEk89sV+F7IQLEddapwqIo06ofNfsLayyDGVWQ5e/ko4c7b8/mat1ShnRQ?=
 =?iso-8859-1?Q?bgPsyR9gc2DQmJhKac+2r0cZzPhju/K3l0Phawzp4gyMEa4ZuD8kJd4Joy?=
 =?iso-8859-1?Q?+0EKoaLCkE0jk31b54j24i020EJEgTK3qixEYxJsqTY5QnJHzB7JuoyEQu?=
 =?iso-8859-1?Q?ZxNHS3SgQqKAETcEU1QFwREiAhjuOSeG6KUvm2sMcMNqGdqr4bOPK9mulM?=
 =?iso-8859-1?Q?WxmKkn4mGlQSHnHT6focJAjy8KmIu2ZKJPtx0UG8rC1N+NR+2GgetU1wZ8?=
 =?iso-8859-1?Q?PlHDKjcjKbfAGypoKO6u7+KPBKB0s+J0LB1IM6b5AdgXAHP3QnLuBNGfJK?=
 =?iso-8859-1?Q?zrMc8ilsyISkQhUFLQcUhXJKThCACwoqmRMkbKRUzVUJ60JOwD+50fHhNg?=
 =?iso-8859-1?Q?etzmpLNqCVw1I449uoHidibJhNn+o2ukpXQqCNXnT7NDUvSMwerkiTf0Ma?=
 =?iso-8859-1?Q?jcjdD/KOYi/NUhldJ3Xyb2ynQExVLcaQQMsvQqP+6CJ6sbq2bAfD+hWxkL?=
 =?iso-8859-1?Q?0G34JjiZq7mTxKkIb4jLUAJYw1vw5+7Kfr2nT7N5EIH4PFrMjLrNNB38hr?=
 =?iso-8859-1?Q?Lp8swnm/bEMY7Y0kSDbQhoGWyt53CSYPlIEFt7LcVfkQApd3pKpK+KiZC8?=
 =?iso-8859-1?Q?NwJrREri9frUFU/gaVn1W/ZlTDTaH18BD3W5MJXWMQwAjI/Xrhj7Pw8A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d87e0a-8284-49ac-9d10-08ddb309ccee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:28:03.0444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttAciN0Cbdy1riLPOQACXt2+gbNAwzB+LuR2arUUuq9nLTWn4YkTzSJHxULK+dFL2YRjSE8n3QuqMlyxL2/wf5AHtt81ka4TcjDq1peDlQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB5475
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
index ecdd232da6f..f9fcd20e2ab 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -5,3 +5,4 @@
 obj-y +=3D dram.o
 obj-y +=3D cpu.o
 obj-y +=3D cache.o
+obj-y +=3D emu-amo.o
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
