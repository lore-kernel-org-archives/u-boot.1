Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399B7C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 21:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D358885D0;
	Fri, 17 May 2024 23:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Rj2TUgOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06AD885D7; Fri, 17 May 2024 23:11:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD99885A0
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 23:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715980276; x=1716585076; i=xypron.glpk@gmx.de;
 bh=YRibmcHrCNbzW6vj7pl8ER57V13gxYa0c773hTbX+6k=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Rj2TUgOIjvPppKYyPB0KsAZMJ/m48OsX4D1JMffCcFXoeCmEv+5QVm7W9UarfS+r
 V4imKSyh4SWqokbkKmg4ZfKKFifGNS2dHnsXYYgpAi2Nn+BQNC4/O4euCDSis/OWu
 PKPpWqd7m2SS3GCXyi4UUn4RCWVFfXqMl0A2CFesmY2jLkmIscxO5N12PjSOL/W4l
 Mj9DMc+m8lzblY1WZxzj0w4o/8oy+fS9C85yUHPf0vjKooaibY9qWfYJfOQflEj1B
 Dhg59JTUWH6ZxlAmkqKD8yamhz9pV4yfecwzjyX4C5FEqirWPsck5Ka92eI+jhzQI
 JD9aLFOQpRuChfIPWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.1.211.73]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1sSEIk1g50-00x454; Fri, 17
 May 2024 23:11:16 +0200
Date: Fri, 17 May 2024 23:11:15 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
CC: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/7] MIPS: Implement setjmp
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517-mips-efi-v1-1-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-1-79096e3ca3b3@flygoat.com>
Message-ID: <2283C936-E570-4015-92F2-06433E3FD506@gmx.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:sVX3hg0uIT143dcauUtq0d3hFX4/h1tVgRpvXQ1/UOrxeSV3Re8
 uSi4vqU1SgkMq3enqrHCHwHw43Wo+gyzr7sLq+UWnbcMU7MtFKVpIvFtX1dZ8uCCAcsl004
 pUjNzItKYYfguihua15nwx0gp2tTBuFWK9l7+KZI78CNF9dysqceZ4s7Tn9xH6cwZXEBkhE
 uovcH78abJA3RBgqtimhw==
UI-OutboundReport: notjunk:1;M01:P0:utI7heV2mw0=;yBpimh2NRbQ7GjlVUZiOKICR1V0
 y9eukGlBwwcRA+ECF+6mVP2mBf5EoLFiHyPHgou3nYLKrnNDfQJyaeRGK9mhiSb4xFYCl1Ai2
 7QMFGhV+XFaSZxyEo7p+4yvv5SP0svuq8HQf9k0h1rxNdNQ/UrMleBYmE1l00yaZtfJj04T3C
 UVYYmCJNfesFxD8O2/Su1/8cr+0BI7kUcHkbgAk0+oyXvXlF0+W6er0Z2oRU4NCgPkCrXp2qi
 WIZZJItgrNjl0y0ccG0tezsUfYFnI8eq810ivvWrBE58K8cQm1e2JtzbThIhfeaZYUHhDOLvB
 pNtDJk3ryWoJHfJ+1np1bevpaVfDxmD1jxn/crvKQcA8DYR78b3W7q38I1T8KFr1QeuMhD5cj
 k5Lvw4NC2mz/n48kiF6VL7zvrhkrd2LuUaG0jI+hQr2B3hQNzqGJo1H6wOLZQJi3GaiDNpthQ
 wbWQpJcV4FGGK7UkrWX4AJuAe3JeoMtGKAGWi2vJtQ25aYdmzLrn/K5Dozqvp+pyorpKAaVXD
 YVxxy7RGe2XqTSa3kno0hnTBywmM1pkD2/bLTkreJ8qucAjeiAWgwJIxRktp7rxEjJa5IHeFJ
 AMAsKLUNCy64VDVKm1EHyaIRRAm8axsFex/q79DKg3EvjUYRV5XZBkZBGuCJHWf64l+oW0F2w
 haPlzEJR+v5Gks+5JwUO5KUh7DVIpBBlXfk6I8zJaLs0p9YoEDEnVozgiHjZHMn2ycRWHk85l
 aNe2LX6c73nF2T+o0E64uRu0dlvW6htQGH21Z42XQrFwgZQ8YekUwC53+52LfwPV2UubHfwxL
 ZlwNsG2/df8NZc1lqO/GamYY0C+Qb3zZesq6WPHh2G064=
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



Am 17=2E Mai 2024 18:32:52 MESZ schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>Implement setjmp with o32/n64 ABI's standard stack frame=2E
>Note that those two ABIs slightly disagreed on placement of
>registers so they are being implemented in two different
>files=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> arch/mips/include/asm/setjmp=2Eh | 36 +++++++++++++++++++++++++++
> arch/mips/lib/Makefile         |  2 ++
> arch/mips/lib/setjmp32=2ES       | 51 ++++++++++++++++++++++++++++++++++=
++++
> arch/mips/lib/setjmp64=2ES       | 56 ++++++++++++++++++++++++++++++++++=
++++++++
> 4 files changed, 145 insertions(+)
>
>diff --git a/arch/mips/include/asm/setjmp=2Eh b/arch/mips/include/asm/set=
jmp=2Eh
>new file mode 100644
>index 000000000000=2E=2Eafa2ffb007e6
>--- /dev/null
>+++ b/arch/mips/include/asm/setjmp=2Eh
>@@ -0,0 +1,36 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ * Copyright (c) 2024 Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>+ */
>+
>+#ifndef _SETJMP_H_
>+#define _SETJMP_H_	1
>+
>+/*
>+ * This really should be opaque, but the EFI implementation wrongly
>+ * assumes that a 'struct jmp_buf_data' is defined=2E
>+ */
>+#if __mips =3D=3D 64
>+struct jmp_buf_data {
>+	unsigned long ra;
>+	unsigned long sp;
>+	unsigned long fp;
>+	unsigned long gp;
>+	unsigned long s_regs[8];	/* s0 - s7 */
>+};
>+#else
>+struct jmp_buf_data {
>+	unsigned long ra;
>+	unsigned long sp;
>+	unsigned long s_regs[8];	/* s0 - s7 */
>+	unsigned long fp;
>+	unsigned long gp;
>+};

As the jumpbuffer is only used inside U-Boot we should be able to use the =
same register sequence independant of the bitness=2E

Best regards

Heinrich

>+#endif
>+
>+typedef struct jmp_buf_data jmp_buf[1];
>+
>+int setjmp(jmp_buf jmp);
>+void longjmp(jmp_buf jmp, int ret);
>+
>+#endif /* _SETJMP_H_ */
>diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
>index 1621cc9a1ff9=2E=2Ee36dfd0547b5 100644
>--- a/arch/mips/lib/Makefile
>+++ b/arch/mips/lib/Makefile
>@@ -10,6 +10,8 @@ obj-y	+=3D reloc=2Eo
> obj-y	+=3D stack=2Eo
> obj-y	+=3D traps=2Eo
>=20
>+obj-$(CONFIG_32BIT) +=3D setjmp32=2Eo
>+obj-$(CONFIG_64BIT) +=3D setjmp64=2Eo
> obj-$(CONFIG_CMD_BOOTM) +=3D bootm=2Eo
> obj-$(CONFIG_CMD_GO) +=3D boot=2Eo
> obj-$(CONFIG_SPL_BUILD) +=3D spl=2Eo
>diff --git a/arch/mips/lib/setjmp32=2ES b/arch/mips/lib/setjmp32=2ES
>new file mode 100644
>index 000000000000=2E=2E4a2661d29249
>--- /dev/null
>+++ b/arch/mips/lib/setjmp32=2ES
>@@ -0,0 +1,51 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ * Copyright (c) 2024 Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>+ */
>+
>+#include <linux/linkage=2Eh>
>+#include <asm/regdef=2Eh>
>+
>+=2Epushsection =2Etext=2Esetjmp, "ax"
>+ENTRY(setjmp)
>+	sw      ra,  0(a0)
>+	sw      sp,  4(a0)
>+	sw      s0,  8(a0)
>+	sw      s1, 12(a0)
>+	sw      s2, 16(a0)
>+	sw      s3, 20(a0)
>+	sw      s4, 24(a0)
>+	sw      s5, 28(a0)
>+	sw      s6, 32(a0)
>+	sw      s7, 36(a0)
>+	sw      fp, 40(a0)
>+	sw      gp, 44(a0)
>+
>+	move	v0, zero
>+	jr	ra
>+ENDPROC(setjmp)
>+=2Epopsection
>+
>+=2Epushsection =2Etext=2Elongjmp, "ax"
>+ENTRY(longjmp)
>+	lw      ra,  0(a0)
>+	lw      sp,  4(a0)
>+	lw      s0,  8(a0)
>+	lw      s1, 12(a0)
>+	lw      s2, 16(a0)
>+	lw      s3, 20(a0)
>+	lw      s4, 24(a0)
>+	lw      s5, 28(a0)
>+	lw      s6, 32(a0)
>+	lw      s7, 36(a0)
>+	lw      fp, 40(a0)
>+	lw      gp, 44(a0)
>+
>+	beqz	a1, 1f
>+	move	v0, a1
>+	jr	ra
>+1:
>+	li	v0, 1
>+	jr	ra
>+ENDPROC(longjmp)
>+=2Epopsection
>diff --git a/arch/mips/lib/setjmp64=2ES b/arch/mips/lib/setjmp64=2ES
>new file mode 100644
>index 000000000000=2E=2E6f615bb10014
>--- /dev/null
>+++ b/arch/mips/lib/setjmp64=2ES
>@@ -0,0 +1,56 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ * Copyright (c) 2006 - 2008, Intel Corporation=2E All rights reserved=
=2E
>+ * Copyright (c) 2017 Lemote Co=2ELtd
>+ * 	Author: Heiher <r@hev=2Ecc>
>+ * Copyright (c) 2024 Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>+ */
>+
>+#include <linux/linkage=2Eh>
>+#include <asm/regdef=2Eh>
>+
>+=2Epushsection =2Etext=2Esetjmp, "ax"
>+ENTRY(setjmp)
>+	sd	ra, 0x00(a0)
>+	sd	sp, 0x08(a0)
>+	sd	fp, 0x10(a0)
>+	sd	gp, 0x18(a0)
>+
>+	sd	s0, 0x20(a0)
>+	sd	s1, 0x28(a0)
>+	sd	s2, 0x30(a0)
>+	sd	s3, 0x38(a0)
>+	sd	s4, 0x40(a0)
>+	sd	s5, 0x48(a0)
>+	sd	s6, 0x50(a0)
>+	sd	s7, 0x58(a0)
>+
>+	move	v0, zero
>+	jr	ra
>+ENDPROC(setjmp)
>+=2Epopsection
>+
>+=2Epushsection =2Etext=2Elongjmp, "ax"
>+ENTRY(longjmp)
>+	ld	ra, 0x00(a0)
>+	ld	sp, 0x08(a0)
>+	ld	fp, 0x10(a0)
>+	ld	gp, 0x18(a0)
>+
>+	ld	s0, 0x20(a0)
>+	ld	s1, 0x28(a0)
>+	ld	s2, 0x30(a0)
>+	ld	s3, 0x38(a0)
>+	ld	s4, 0x40(a0)
>+	ld	s5, 0x48(a0)
>+	ld	s6, 0x50(a0)
>+	ld	s7, 0x58(a0)
>+
>+	beqz	a1, 1f
>+	move	v0, a1
>+	jr	ra
>+1:
>+	li	v0, 1
>+	jr	ra
>+ENDPROC(longjmp)
>+=2Epopsection
>
