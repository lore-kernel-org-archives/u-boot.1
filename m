Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF33DC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B4F82D32;
	Tue,  3 Jun 2025 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="ApjYT9Kb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F32882145; Tue,  3 Jun 2025 15:40:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B1C80F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt2Q2WjP3aXDsnRjOGRwsQM9wr9vKbdHaczUis5/OuN/lujMbGMKGreAZQyKwFyrZaj/KARmz7d1g41wDxxvYSFuIofufEWGvPzgDZ1J7KsEjn+Ftsr3nCrzTR+20DP0SQ2txM/mKNsWUQmr99zCSnEhTPc+VWkxYpCijZsDbJiBn1QwVehfTN7fW3wHOZF4U7Tyl9SRXU+77FF4GRMY1IzGqmEFOrv0g86JwmTvjSdy/+siTh5t2FEmdGtYO8fb1duSxDes+BJ6URPsNNjS7cOsdtosl0ShxW5xLE06qP6TcLTqoy9owXz0Bte3ZELOOdZYzVAoAaW0cp8qk2xxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt7fM0sJI7JsjLxiv1qcY7YbeiAzROKffBFvkkkZa5M=;
 b=prgJexDrBra3GvBqRnIzBjAGAJtkdeTFgQyYtNywNK5Aylw92LrttpNh0kwtGxlm4uSthrnq7m+jQUE28jB4n0cKGDVgnM5sAVWTaTjd4dGHZYzKOGCmG9ZjDV/1DVUSsrQ3kOxY9X38iyS+ZvgoOW58vEw5ZiGEC3CaAjTmf+K1aRa4oob4h3iuaSrOaf+GxuFkEgwdBDVuIYd+xtgInNG2hcvbvt2xAwxCfGdqco42W2GjHe+sT4dWX0jXb2zmGZWcaeJ66iNQH3bG2BugbyiAGlfX2QIfrPgRcwLJHVn6Ydk1mrbwEpdDthxrUl7LP66Rw5+7rGDLZdimVK7Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt7fM0sJI7JsjLxiv1qcY7YbeiAzROKffBFvkkkZa5M=;
 b=ApjYT9KbDzl4AcNW5f77AE+1BZeVbWsy60yO9uT2Pngh1WHb+gXlX3PbPrhZynjWATIIBDiHxlYAKfHN9sHpb2ho5cP9wWhSqN7bU4yzIGLLdqa3s9Cpwjuzbq+MOrintQkdufVX+taMT5Cf/7UNaTFSR08Z6opd1BBReNr12U+Rjbd+qy7/1AkcZZDwtEor5fejsMMAwWTtCF1MYE8nyG16mdvHqAN0KyxkNJZGF/Hp72nCf/wRZNw2NKl186R+tzDE2tvjRVe8IjuRiNFn5ZWOJ9/aWiHcq4LCofWiLey/qhaZihncE+QPccLenmII7NnYzdLU2HBGezOtWg4iUA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PA1PR09MB7847.eurprd09.prod.outlook.com (2603:10a6:102:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:39:58 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:39:57 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 07/11] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Topic: [PATCH 07/11] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Index: AQHb1Iz+k9LaGPv7YESDGbT+iVT39A==
Date: Tue, 3 Jun 2025 13:39:57 +0000
Message-ID: <20250603133744.278790-8-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PA1PR09MB7847:EE_
x-ms-office365-filtering-correlation-id: b7a968f4-4266-4d5c-2f64-08dda2a42158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3M4E7KPhVgF28uJ5VtJ6O6j196oMZnsenqX9/xf4pJ15PyAjl6r2hlOJ0k?=
 =?iso-8859-1?Q?M6vRuZE5ytGCEKZKIKorNEpXCBxTwifXP+qdbAzt+7N1pKaUEwgyMcxrNz?=
 =?iso-8859-1?Q?TNiyGpQIrz4jRFR2ttaReKWQ6c3WYqtIDC6fV9ZD686FM4BJo9R1TS/vp+?=
 =?iso-8859-1?Q?P2ddtWnRmHKjcI/wyk+b0M8V2HFmi5/Q69VFyLT1AcnFqvifKf2KbVqDEy?=
 =?iso-8859-1?Q?nMTlF+1rSpAAttej7SygPwhn1rLgnYG3jPsiIuSU8qAcEvNF+dL5vZGun+?=
 =?iso-8859-1?Q?Po+e71JMvOoWQXVy77cKRB7e0Ul0hnA84B2WuvShz007qPzxWbOKwUkwJ0?=
 =?iso-8859-1?Q?2ixxoFKsFReFrxTByfUeb4cjOHl2i/7xh67B3Z6mAZHk9fWrJXmeV8XhXp?=
 =?iso-8859-1?Q?UJO25phvEnfFTrE0MJ1QwNWWxWNiTVA8PxGQpDoYSZiWssoBbGywPE99bf?=
 =?iso-8859-1?Q?Wr17oSViCy/BAba27HoECbnk326qUKd9VyEt5v9t72PHTDm6JYCDkIZu9p?=
 =?iso-8859-1?Q?E37m76zjcFp3JRhno4K36pFw3M9WVrGJFRcbV054ysytsKAwBistk6UmR2?=
 =?iso-8859-1?Q?4POeIWyoNAsLoTDmdiROhHI/jOpvsQhhcxdZEIf0MGxTXiiY8junNJ52bd?=
 =?iso-8859-1?Q?6+eRVCFs8RLG989bzEte6qwnqUnu+uePis5xUVudWAL/gvMzBcIKnxP77c?=
 =?iso-8859-1?Q?k3Uk0tm2n9AeSugjFBj2ZUBhEviijZdwUd91pVPTjutXZguAiwECG28jvn?=
 =?iso-8859-1?Q?AijGl9hU8X0RC6GmJCQbmCY5SzQ/qz017Gex+iKTLxjK44r4FuNQA6lNoW?=
 =?iso-8859-1?Q?nyw/qvOeyZxTZgtip1cJ4YKz/XZPp/pjBAJqep59NXUFqWVUZApGDM9uak?=
 =?iso-8859-1?Q?m4O4qS3W3Jt4Jmp6oE+Jz0OMQIDSLZWEwUOulTm/KzFfs8csFNuASFS5xg?=
 =?iso-8859-1?Q?NiwQArqkpYeEEZ2KuKKBN6QNPlCaFxVlX+UmmiF+J335enICqQQcNR0snu?=
 =?iso-8859-1?Q?OaaSRqpLDEGRVmrTJSmx6OJKfYdRh0UkcawSZ0qBv8B+QL4BokjM59pnkE?=
 =?iso-8859-1?Q?nP/1F04LE+h+DLlOAr7mepMWs2aCRnNF8eDkkv2UJf1DClE9fM3M6IQJMk?=
 =?iso-8859-1?Q?VWte4qVeBieeBv5fx5fkTHpOkrsWkqDP1UvP86gaHhIUVfP3IGocUgN/Cw?=
 =?iso-8859-1?Q?E3SgAyk2SzYppm7zu+AQbKcKCwISlLY9z6HFQtOX4Lgl9eRAstZ/SEUJft?=
 =?iso-8859-1?Q?oTearkjn6n6ft7fwO8f+MC60lz6s0oriu2rzXz8YI7YtooMoq8bPRoAbox?=
 =?iso-8859-1?Q?jCtqgy19TtkGWNORP5F4C9Mywx2lrkfrh4yObcCxXGxZmAgEPqzK0ZzD5w?=
 =?iso-8859-1?Q?HWV2nwtiDzr8rTLs98cGYxHpC3OYtZgzBYxvKX2cKBSKpvFgACQkRGHv+x?=
 =?iso-8859-1?Q?KfPGX1O7Emw8fQJJrL3oBf76zyC8RclWw3ocJaDsEsLpJtbVODvtjIVI8c?=
 =?iso-8859-1?Q?S4gzSBMTjmbZME5wv5UTA71W8CinVIcRvJB9ztYKKw3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ipr3B9Ebqp/FNiCMDcsaNXe6ZNcG4YtIIbpPikxVJHXwijCz9nVwnfH8k1?=
 =?iso-8859-1?Q?P7jCazncDS7Fsx0rWN9nshXI1nab1x30auVEf0NSIxjQSEP40wxKSO1I4l?=
 =?iso-8859-1?Q?Tj3jyevtkbpIyH2Q6RHZdSH9LusVbqfCL9n9HSG7UcyFQmT6YEwx4p0kUd?=
 =?iso-8859-1?Q?adKj00V4Ofauzt8wUsOu/NLwXZc2Prv5Dl3c63DVBhrEPX3ih6pbO3AmxB?=
 =?iso-8859-1?Q?v5qRZ1YZDOuznVPkilw7FbEnk468N94vhqTOqWk7DoIv5Q7keVATdOAtef?=
 =?iso-8859-1?Q?1Q9Ri+d1MqdSzmUEotVMPwpUnpb40rVTdvaeylBdE9C/tpMaiPtADdDE84?=
 =?iso-8859-1?Q?vzgxEdWoDsniX/FKTZTU/rFgByyGhIswP6AB+utfpegFUlAj3f28/tz15R?=
 =?iso-8859-1?Q?xyjjjsWTMY2Ija8eyId95R9nQzt6HVE7qBV14j4xEKaM5PqXPRmFqIExgt?=
 =?iso-8859-1?Q?bxxTt5j1PnOjfnoG6HHlwc2XVWJibBIQGPPo1ViTa6Kjf6HIe06wXOHaXA?=
 =?iso-8859-1?Q?qYdbpeBV3FF4CXy0WAFzZEIVUOKPwJbCJ5l/UKOytnA1ritwQpKXL4I3Cr?=
 =?iso-8859-1?Q?Ft+fZdq++i4x4XnvD+TUJ5mNu32I5obWFtFUs/j0mnVpvN8p5BimphT/4q?=
 =?iso-8859-1?Q?z1gJB3Hu1G/PRoZXaOQVs+TXHHZ8RQRrsfjWg2V1zoqSoEfPrEwLh8AAqj?=
 =?iso-8859-1?Q?5VHvRZBSx7FKQaC5qb8o0W1tvp4cJsZAdPxMkketNQYiMK6pisBGRwsnDF?=
 =?iso-8859-1?Q?RGzXkBJu5BmUFKuEvjuvj0JmnsKFpZ35KyY3Pnp/ZzQKWJuGc7mIVFigiR?=
 =?iso-8859-1?Q?eshjBQ/F0W7LplOv4qyU1vTYaK2gF444GfOx4fIziyYVdQnxyZ6sbLCOos?=
 =?iso-8859-1?Q?+4hB50z6kR7xlKU35i6zrPySF547EFmI2xsMM4mqDSCvnHJKyZ4RLRqvyo?=
 =?iso-8859-1?Q?XZ5MV3oQTeCl3JeBsVySSMv1BLLW9XCSojRhmeUoBvwTB0ARzH8zE5tIcJ?=
 =?iso-8859-1?Q?EO/vipZcejoxgCFYyzmPibaO9BpSVpzRJeebnj6lwVk9jhi7wmmbgllr7D?=
 =?iso-8859-1?Q?eCbJZrJVCv3jjnSRNZ2pLy3GPIM9VBg86W/22x/AYDpw+gtURe69hYo+i5?=
 =?iso-8859-1?Q?nZcmhIN+5omN3X5yyhmim5FIoHBQsknj3RYOtUpT/agtaKDP7OEeOn+JE/?=
 =?iso-8859-1?Q?FcfMwsZ2WYvYuL0gydyDflYS6vrh58PGnq3H5lgwcGQMw9UU4gF6SmFdIh?=
 =?iso-8859-1?Q?lKip6TcftnJ0dGEx9mYrgI6NBSSk6ZD71dUl5+Igsl3COJg4qq9aooOPZ5?=
 =?iso-8859-1?Q?BsrwcCH7meLOU6V8XD/s0Vuk7AS0My/IBDbB+XJ0s7oPausmYP6JH8IZsv?=
 =?iso-8859-1?Q?hMXnb5qjTDNImDDvi1IzXr/pJFLLwjVcoCAF36BGgtdz2deSoQ2Hgks1WY?=
 =?iso-8859-1?Q?lZ5c0kOcTb5wKORaiELuefssxohFHijdB51hAA1nqoz/i7qPFL0OmRpS5V?=
 =?iso-8859-1?Q?yeEVWvGh7rIYO5oKSQC2143PKWN2ro2OXfdM9HXZFezRPomXByumvGE884?=
 =?iso-8859-1?Q?ohVUnRfOF20sFU+D5mgx2WR4lzX+EvE2Etda2M3azGX7rG+ORDjDRE+ryw?=
 =?iso-8859-1?Q?fays6SPgd9Fvq4JxNr6RDbtijujULG+wdexFWDX44Zr+M7lbHKwYqV8g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a968f4-4266-4d5c-2f64-08dda2a42158
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:39:57.3647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GE2OeEn/U1hD+TkwqifUkvE4SEvqaMyYu5e4zFi9Vmc1z7sm3QVc/NQ9muU5iR5qWAsj3v0C2Nu6bbO/nalOPvF0v6htJpyR54duD1lRLj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7847
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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
