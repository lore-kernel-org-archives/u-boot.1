Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D882C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6E5832BC;
	Wed, 30 Jul 2025 07:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="oz06cvMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B57E82F00; Tue, 29 Jul 2025 18:24:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A725582BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpHiHKr7S2fMoJxnX5fIm10QgAjyupQMCGV7F/9tuJD1ZZoqIpaXrMPZwpEFvH5VRQqqVuSaNTG8W/4hpl1mhD5HwBmcXksycMExhpArRhw1Ha02hEM8rRm2UQaw+AAbAwlz3sdWSD1MmZt184CXK4x71cEGJdRSiS/HalmYvQf5PEFqnhR+6PEtDbY3AEDGhRCYPpvl9qhqOG9vvBJ+YJQDXPu7VxqYocMK1GZgsqSiIN+gEvwYd/gtj0GKamzC6eEtsneNmtkWab7FRRHhiBTCZGf1kJ2555KyNbwU+IcD176yhdLDbpE/cTExzQG6LrkG+La3eMwUjKKf1u+9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVcQQxj4uRwjriwseufxIytnjnoyjEMae3JD0kb3u6o=;
 b=t9oPDpZi1b0ODtZF3fEfyX4NfLO9k/5+jIpaGpjBx2S9Q1rRhHl8oAR9alz4j+0XPga18lsp16D5HW1s6WLQTH2cYSf+D2nQLaMXXlIWaNi8cmtILX/Zbn5pBxBoAHQCJ45MAFGivBkJLV2OtNfJJy6YM48OgdoIHJWA7k378k5vj+qmGBr12XizpX1OP47AUBjYVzlLpaChxMA4hMC3/PmzKdwfFt6tE+3MNqsQds6EQFOEgTS3SCc/3lk6Vj/MhvifP864z9S0QfXtUxtQkt/FIelbMavCymaD26kUl5uOUDYZraB31UMd+gYhYedU7KSSlldS7ZnrZnuWdx+TKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVcQQxj4uRwjriwseufxIytnjnoyjEMae3JD0kb3u6o=;
 b=oz06cvMTSDprWtjBQ2CHtoWuaEd8NZHQjeQPRSmGiT03o6/gNV1p+Kc4yal+v6YnWWFNx4rf/rcDzjNXSc4mSreMGCHyM0TetpqyRAXf22vnX9bfq1PZks7EscYfekVlwKRJc/aUyLoGGiKBSZHm4YRtN7zfRtDOjHLOy4V4+7GDHezoZSgjk5DykCM2fAKW6SfrgGQXnf7jmNAhVm/YYCGhKcBWqVRmYeXeaWDOwHrj0j2Pgpp6ro8vX83nsHoOiaU1DKHXFpWwDMZYr4iK3jnvbAN/aVR/BF9fYn91yfpCWtc5wg0wIdregrusLaoh7L3ozpPpmQrzcPNDJFBhZQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:24:36 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:24:36 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 09/12] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Topic: [PATCH v3 09/12] riscv: p8700: Add Coherence Manager (CM) and
 IOCU support
Thread-Index: AQHcAKVGLTciiZylu0yFj9TzjUY10w==
Date: Tue, 29 Jul 2025 16:24:36 +0000
Message-ID: <20250729162035.209849-10-uros.stajic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: a5109448-b028-467e-3935-08ddcebc68e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ia15HQPAxOXMMb0hdCPd3HL6ZbBtzN1V7Jj2NHNtaZBsllBdhy+Rkxixvo?=
 =?iso-8859-1?Q?MFzPB2CDiIsxPkBb9v+Cu8HUpsYPt8+kRZ31XAUQvYejKLdXnKk4b7VAQ8?=
 =?iso-8859-1?Q?7FdTN5UyNkTVyRjzfpdJfBE4P6BDlCCgNTDlwBSbj96pElgH+7Qo/VMJZ1?=
 =?iso-8859-1?Q?Pp+JGZD7jcnwgwKkT6sVXUK7DflLUPTgix9S2eVOOh4rpk/SjRBr829aqy?=
 =?iso-8859-1?Q?NHxOxcsXtIa/h+EljIda53NDK4oCwSVkMTgV64dfGY5IVZUpYGyZzQn5sm?=
 =?iso-8859-1?Q?mwycu5aFsgsSrzQzg4w78KGa7R4O9y+8kNPwPgO82EcSxBxDQt+tVQ4oZ/?=
 =?iso-8859-1?Q?xLjSw/R0M2R1mtl2z5kR0cR+v652VU7cGNLjM9Cw9ZHw8LuQo7dkGyuKAa?=
 =?iso-8859-1?Q?nspdbae/2ksMFujO4tJ7xm1jGYOrruPP2zzSOWrgdzxMoe95+OJgy/kfRZ?=
 =?iso-8859-1?Q?/XXmowkMnk7hfdaCo9TqcB9z45inKvyst2GS7gtkpCxYtVh9ja27ZqZZs+?=
 =?iso-8859-1?Q?BzxhRoW1Y5Ph3sZ0rUPkfpoZpAWWTRvULOeCXQ5SELV3eiI1Z/hFYcPsbl?=
 =?iso-8859-1?Q?OiAofvo+tQi61cwm6YGDj6npGohDPWvZC9/JRKVI3RJeadRposX9ZOu4nZ?=
 =?iso-8859-1?Q?/bpmQExn5JxKtOXqCEiTrI0vjxeohna50EawhjkWVz7F3ZtSl4Lrjr0Jq4?=
 =?iso-8859-1?Q?Nk31J6ZF6u/uOEmE95HxvT4VYUtcnDblCSB+yWebCV/Ug9LkAm99T5RuGJ?=
 =?iso-8859-1?Q?WbXVW2DxCX5Pbr70nX2Ca1+r8ycyFNYBdID6UfgkJWI38sN5WLY+JlQQ5x?=
 =?iso-8859-1?Q?ziMceM4xi9m447ddV0B/hvaqbalwdIF2qr8IOJVslImg67lyk67bS9s5Cy?=
 =?iso-8859-1?Q?fNXu1bT802BguQQQpT8i9Ci0Uce13xFCfb8m3WIwg++3L+a3j/y+3kUSMo?=
 =?iso-8859-1?Q?FRKFqOGykJQlwJm/TtXw95+ixx+OvYJuXOqqkM/EFIjK8yPl2vVlfHuV8F?=
 =?iso-8859-1?Q?ahg6QvC3iAAqzW5YLWXOE7oxKpDksWJA/PvvbPV0uBer8PtG5uBYlQ9IbN?=
 =?iso-8859-1?Q?KAUr6NRUtsfrvCpV4YSXF99fOSt+A1d/eZLgaewz6a9Z4Jhc1xUZ3+ONtH?=
 =?iso-8859-1?Q?Qv+C3H09dXP1nk94LNZY+6FBpIgjVY4PwbtggABOFoY6O3A/gwfeuCwL2Q?=
 =?iso-8859-1?Q?a5DfqE3J5rvf7DjvCqWFNUwVBnpq0OaWS358Y1LbZHAzccjXkj2SJRSWti?=
 =?iso-8859-1?Q?qvuCvjRowyMJMXkojWZGlStM8pDnmCGOjIitLlxu+0Te5UY9ZZ0za7r8iR?=
 =?iso-8859-1?Q?0sEXXbxDBmj0bcQIV83FG5mfsLqBvRdNRYc7UIflXw9scC0h+J3KEaV6Hk?=
 =?iso-8859-1?Q?l1mYVR29uAkd9Jcf5C9sqBCUs7uI5w3Dm6GJsbc0lm+rCP0dd2ujOcz0Bd?=
 =?iso-8859-1?Q?ThSOGodAZ1zKbs5Bw/tLhsNikZqoF6B3ertzXOyAVMDHr7tIoikevViT/t?=
 =?iso-8859-1?Q?MwDAdWH+LKyzVTHxCsMnAeT6vb9EuMgBI5WoclCEhSgg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SaA7mWZr2kIGLlPwt7QMAo9WqSkN471gnio4HRn2FKDCgrRV/nZajOcuiN?=
 =?iso-8859-1?Q?m6gEfUTzOyKnDo237JNozRQVgHE/+ZvIZCmVYHY8u7XMsZC4Qzvo1zhlQW?=
 =?iso-8859-1?Q?BHGOnk0jfFVPSlQGf77kFIvjVxmevMfBuidNDlGyQ36nE7Mv6pmeRmyh6/?=
 =?iso-8859-1?Q?ogeZs7i+sYqrtjtLiNTMdxa5eZn9grTILC1JaiIXyssJCfUAgALhRggupx?=
 =?iso-8859-1?Q?mKBcVwUOZ29G6hlCvnSW1+FNQtVocyhxEn/bIk/GsNL7WfDLZYBCO+urq1?=
 =?iso-8859-1?Q?if75ytlvf8Ham+AnhTy+/Nj4VzocU0+9ku0dawlJv7kpEgCZ2UEhpGCLIB?=
 =?iso-8859-1?Q?9K6NomtqA4jy9BQdbPBAhzjjwspNcIrRZo0y8xUmPVLiiWIjgJRRSViFoX?=
 =?iso-8859-1?Q?YHOun0qdMUpTuowK0faFVzuXYk5MYmAgLcUqGN/7cp/0QKIk+rDOwSNGa+?=
 =?iso-8859-1?Q?hAn9dluSvVGeRCpAEzXWROAOtr7xpHaH5Oz5sNXg4PSI43KumVKDR+Ns0T?=
 =?iso-8859-1?Q?Hco4Sf3x8DKIFfXSlwK3jZGn1FQHDsmT+G3PL/b4RzAwlW3scNWvCU9EYj?=
 =?iso-8859-1?Q?q8LU9Y82pf/makepi580RJES22X0Ign7CQ7cPAhCyuIh9e+RJ6zhHC5/Mp?=
 =?iso-8859-1?Q?HSUJazpnbmEfjwlGdDkXXMctS6s02T3fe5D+OPxAps4AgJAVPFPZPOkCnf?=
 =?iso-8859-1?Q?yEBXckTTkuZObHD6J5mxnfmWIBVzMBFJ1tk+Cb6weDBJFV/iznnhVjnXa/?=
 =?iso-8859-1?Q?UqkK+kMycN9ceUo1hv1bMqP2WvPyUf6F68U2l6vl061mjCVP4nItSNEJPH?=
 =?iso-8859-1?Q?w9m/dwQEcq8P4Ivv3UGmBvxkBH0zizBplU1Wc/+h/ZgQCNUgRvePlpAMcP?=
 =?iso-8859-1?Q?7uvVSLZWhNkMN4O9std58I7dfSymAhGem1uyymRvauYm1eMD7B02qjC7zY?=
 =?iso-8859-1?Q?YjCD6HPn4WW6ZsV19choFeUP4q1vu+ng0FDDEb0wM9JHYtaZaivifRhoSV?=
 =?iso-8859-1?Q?htNSlDdfclHyQwhYMbs1sIMcwGUhlNUz/OaoUejcqgTNEa3sz2QNcZ3mmG?=
 =?iso-8859-1?Q?70Zbz4zAdB9RlDwFgvyNUM4iMikyExwjI7zNC8dEOWSf+jto3Mdcie6UCK?=
 =?iso-8859-1?Q?Sw8KXkptVumUfSb8C0IH03Spm+DzGW2Lj1/qxpjOq3YViIzqyqYTGSmj6W?=
 =?iso-8859-1?Q?mIGsj7haVDd/Q+NTc/C2/HEECeuM3L15wXj3TbxYL/yJtvlKVXGHno3a6c?=
 =?iso-8859-1?Q?gw/NTDnU5xSSEZ82kZGIJUhtUvlysnPG82Jd5LdWU4+OSX51VoNBdU7E05?=
 =?iso-8859-1?Q?npQ6amZpmkwBNQWrO3QriFgLwr6C25JlpVaEO0EmbXok01lb6dZR4ZSI6x?=
 =?iso-8859-1?Q?c/6+nICP/3flgnj19cmQWezp5Dg7AF6f4QoFl9RdxUJpgdTJIIAvjRFRTp?=
 =?iso-8859-1?Q?9ZIcos3NQm6rDke2e/a3SKtZT1HMoCp3iy2ZOCFq0cA1PZx8yyWl5eIP2O?=
 =?iso-8859-1?Q?uaoWB5G3VPdUaKThjjEDoEhDGobUN4AtyONQXRftOmU5ri523Pj8gu04qv?=
 =?iso-8859-1?Q?KTS+fT1k7lBcRTuwYv8h5irGeb91ydNt+nN847NQaOBF/KacSAxLwk/V92?=
 =?iso-8859-1?Q?Nepkxk8UPCL3co5CIRdeyaHjjOzLvO65Te1H3X7ahGNfe60C4+GpLtGA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5109448-b028-467e-3935-08ddcebc68e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:24:36.4893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wax2/3MAgGtibGWQidrWAxzky9lkv+g4kgSOxzflM9SMCK7c1lcz6718GOkP3dhnCPY+N/YaesDXl2MrbGijmqgPih9ajSkVxT93n1gqZAM=
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
index 22f96401640..ed45f3f77e1 100644
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
 obj-y +=3D emu-amo.o
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
index 7559c688321..b465b4090bb 100644
--- a/arch/riscv/cpu/p8700/cache.c
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -48,6 +48,11 @@ static void probe_cache_config(void)
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
@@ -71,6 +76,11 @@ void flush_dcache_range(unsigned long start, unsigned lo=
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
index 33f2b5ec5c8..fce2f2bb77d 100644
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
