Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74C60B5065
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YeT4aI/5;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=iTav5vT9;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=jKmBiz4O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B345D605D2;
	Mon, 19 Oct 2026 15:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-Bv-sQSWLkd; Mon, 19 Oct 2026 15:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E29F860662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423658;
	b=cOEMYD9RO19IgRY4YR5YsMOiFnS1si+DmzxifL2Mzp78EAM5QbKW0LvaSBpQU628Nu9V
	 Bls9h9yJp1AKAag+RY28WGWrXp+uvLXYREGUwT8SpexbGAQDYE8b8GhXEiggVJyfj48L6
	 s6m8BaOWENHcfzrX6NrTk2I0uUxFzrRX4BJ66N7ZeEgxRMklYGLFK5AxvigexMzVq5LDs
	 LIboZTl59QqIsyUWVdFSx8pmdT7CZxD1HXdwdGFijelprSmJDi09F4g1lI0cC3s2bp5p0
	 wDOehVkek+CQTCxtVwcCFro4uP2PTWrvNOt0E4hFRYGkcjudtM/y80lXGbdsLYI/T0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ds5fAfGD1lIRs3/eZZubJvQ1vwqEeUfACZ+6wGJy7nM=;
	b=scWmQBy6UATJR0/5mFNgcPWoYZbv85HVvEVXrtSLUKJdo/NmVseFZfubA2k9gXzHIVWN
	 c+HpHhBes5nYXcXcWyhpfPtkVwNitPRa+oPETjSENF+JlDJKGEFXwoEdNXokJvIP3IKa3
	 /PTBCtgjA+q7JVwg8JA9hLr/vmZY5JJPk3FII+39ndqnQO0jAF3r4OQtOWmaVAIxYA1ov
	 e8u6b3s4MLtaQdRcZaRONjMjDYRT0csyk5hGbiCmdVS3t8DxbQVo8rz/oGP3lHC9ZT9kv
	 1oQ5RI6J2zrxueGfr7ZlUIcj1Atff06IRLUsoLFhirGT505sJIyz6LmKL7lE5DDFQvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423658;
	bh=Ds5fAfGD1lIRs3/eZZubJvQ1vwqEeUfACZ+6wGJy7nM=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=YeT4aI/5f+3/0zsdjeIytIp6kR0dtaUcADEQh0TOcVC1Xzlkln00+uQXfm+0Bidvv
	 OS71skJ7hbPuUm7y1EHsLWhbtdsHw887BkBow2ZHKWVhMKbThjYnPavQ27aDbI5t8n
	 9bOWeqEExhoZf9pCWU9yTDp6CtPukmQEptP3FegEi6tYFt1iP+jCXSVNjP22Ef5KSp
	 dv1WBQCXt50Ehpd409RvAJaxayy9T7Jqh36B76tJ0Jp+71AbiVb9hpvI0j6p6BACS+
	 wiH4o6Fdl7R2MEwa9BMvDucibUrZL5AwBE9ajyvjHravRimEY+Xnz7HiQRdluyQ93W
	 PwHqg0DEE+ybg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E29F860662;
	Mon, 19 Oct 2026 15:27:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FE771E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7167B4061F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8CxGL1GdDynd for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36F504060A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423112;
 b=NbBUVOCwLHtjbAjRnc04ANnryiM+8qc/UC72bHMLhECoygwQXG1QI+Z5AtZ3KD0BlCC7
 kAyAlGsX1v+88zoTZwJDii2NWpluOraqi9/kZywpZI2gKdkP3oMRmYLVOOwXpSPxUmJrE
 0eL8kfQBFctrpFPBxx3Gm0VM4/M2bUkjJqD6f0kMC5m3PM17bVpw2PIKhS08SYxbKIYJc
 v4LvV1l14t7apn0sEA+L9Uf3kix+RqVfee/XkpBCJnyP5H6QDGYNa6QDed/ksHczXneyR
 Phk1ckuIp5p8ueCSazuM/qqqRu+awM3g2u+0zAlwwbVDY+wR+m/OisF7xdzGoDMNseA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423112;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=Ds5fAfGD1lIRs3/eZZubJvQ1vwqEeUfACZ+6wGJy7nM=;
 b=OSjIGAcfqvl6YW5wuBT2eeUxtksN6yTk3vQ+XxoeWHOvjdZmihDbH4BBkkCRN9jAhoNA
 C0IMMUIXt80ceeLsX8ak/JNwBzysmKBoRpFR9TlpBLvhZykdEpfS9TAhQOdHdeIpVsTiM
 egmDYbAp5QhgeUhYe2C7OHYkLyRkKf4q1Jih3v3Rk0jR2J8XlMBaJtP8Nyp9MWVXTN2KG
 xvpGpG9RvOXyvvhae92mCnoc+1xcZ+bV60cXK2wcKLFe2Fg+EVB89f2ls7xZS/7jWOWt/
 y3YSNPS/U9qsqRcRmKLCQ/SJwYsAVW4WOv3USTUYcJmgVqMj1AOPgUMy1nvtogrxiQA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=iTav5vT9; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=jKmBiz4O; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=iTav5vT9; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=jKmBiz4O
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36F504060A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423070; bh=Ds5fAfGD1lIRs3/eZZubJvQ
 1vwqEeUfACZ+6wGJy7nM=; b=iTav5vT9ftxA1D0BonwcKq0s9tKTKlF8pp7W2IZv0ca6Abg8MP
 gDZNGyh0AVKYJvtV5M8YOEtZ8vJZon8ltP9vi0e391IFaNF/JIs+6lcXFVnkQJt8w7UAhdLW/SA
 nrKMpY8e/U7T9hWFCJkTQBc4jst2XTaBtQPhA5m5dV+Kvt1y/eiE1DuaZcJGb38nsturgwKuV5n
 K+VExblIPhYcasxUCOf6q7jHAzvQ4TRKKkmTTaUDSE2bMhad5YOBX118iMG1lUMV//UANR24CAC
 PfeF7aW345V1W3/gVgihF6enV12/e/sHPSE8RfksIWs7wZwbM7Ol4Cb7x1DGjPtVp+g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423070; bh=Ds5fAfGD1lIRs3/eZZubJvQ
 1vwqEeUfACZ+6wGJy7nM=; b=jKmBiz4ODYfmxEY3GQIZ3Rj3E1k2PjuEnlFRRIKxt6YQIp19LU
 TdPY20RWCblz3fYOFzf8SV0y0O+ZlbPUQBBQ==;
Date: Mon, 19 Oct 2026 16:17:50 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_04/14=5D_powerpc=3A_lib=3A_Add?=
 =?US-ASCII?Q?_64-bit_division_to_the_private_libgcc?=
In-Reply-To: <20261018083516.49229-5-pepe.schlehofer@gmail.com>
Message-ID: <3CB2A762-EDFD-4258-A4C4-73082EBF4DAB@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:06 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>On 32-bit PowerPC, GCC lowers '/' and '%' on unsigned 64-bit operands
>to calls to __udivdi3() and __umoddi3(). U-Boot's private libgcc lacks
>these routines, so turris_1x_sdcard fails to link with
>CONFIG_USE_PRIVATE_LIBGCC=y:
>
>  undefined reference to `__udivdi3'
>
>Implement both with a copy of __div64_32() from lib/div64.c whose
>divisor is widened to 64 bits. The copy keeps the private libgcc
>independent of lib/, which not every xPL phase links.
>
>Build the file without LTO, as ARM does for eabi_compat.o: LTO can
>drop these functions before GCC generates the calls that need them.
>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Marek Behún <kabel@kernel.org>

I see. Let's crack on and review thid

>---
>Changes in v2:
>- new patch
>
>At -Os the two take 300 bytes, against 1036 and 992 bytes of
>_udivdi3.o and _umoddi3.o in Debian's libgcc 14.2.
>---
> arch/powerpc/lib/Makefile  |  3 +-
> arch/powerpc/lib/udivdi3.c | 82 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 84 insertions(+), 1 deletion(-)
> create mode 100644 arch/powerpc/lib/udivdi3.c
>
>diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>index 90f0e1e5fa9..23e62996701 100644
>--- a/arch/powerpc/lib/Makefile
>+++ b/arch/powerpc/lib/Makefile
>@@ -6,7 +6,8 @@
> ## Build a couple of necessary functions into a private libgcc
> ## if the user asked for it
> lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o \
>-				    crtsavres.o
>+				    crtsavres.o udivdi3.o
>+CFLAGS_REMOVE_udivdi3.o := $(LTO_CFLAGS)
> 
> MINIMAL=
> 
>diff --git a/arch/powerpc/lib/udivdi3.c b/arch/powerpc/lib/udivdi3.c
>new file mode 100644
>index 00000000000..deb0b5d49e1
>--- /dev/null
>+++ b/arch/powerpc/lib/udivdi3.c
>@@ -0,0 +1,82 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * 64-bit unsigned division and modulo for the private libgcc
>+ *
>+ * GCC calls __udivdi3() and __umoddi3() for '/' and '%' on unsigned 64-bit
>+ * operands on 32-bit PowerPC. udivmod64() is __div64_32() from lib/div64.c
>+ * with a 64-bit divisor: its shift-and-subtract loop already works on one,
>+ * and the step that first divides the high word now only runs when the
>+ * divisor fits into 32 bits. Like __div64_32(), the functions are not
>+ * instrumented, as tracing code may divide. The source file copyrights are
>+ * as follows:
>+ *
>+ *   Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>

What's your source? Maybe cite it?

>+ *
>+ *   Based on former do_div() implementation from asm-parisc/div64.h:
>+ *	Copyright (C) 1999 Hewlett-Packard Co
>+ *	Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
>+ */
>+
>+#include <linux/types.h>
>+
>+static notrace u64 udivmod64(u64 n, u64 base, u64 *rem)
>+{
>+	u64 b = base;
>+	u64 res, d = 1;
>+	u32 high = n >> 32;
>+
>+	/* Reduce the thing a bit first */

Could we clarify that better?

>+	res = 0;
>+	if (!(base >> 32) && high >= base) {
>+		high /= (u32)base;
>+		res = (u64)high << 32;
>+		n -= (u64)(high * (u32)base) << 32;
>+	}
>+
>+	while ((s64)b > 0 && b < n) {
>+		b = b + b;
>+		d = d + d;
>+	}
>+
>+	do {
>+		if (n >= b) {
>+			n -= b;
>+			res += d;
>+		}
>+		b >>= 1;
>+		d >>= 1;
>+	} while (d);
>+
>+	*rem = n;
>+	return res;
>+}
>+
>+/**
>+ * __udivdi3() - divide two 64-bit unsigned integers
>+ *
>+ * @n:		dividend
>+ * @d:		divisor
>+ * Return:	quotient
>+ */
>+notrace u64 __udivdi3(u64 n, u64 d)
>+{
>+	u64 rem;
>+
>+	return udivmod64(n, d, &rem);
>+}
>+
>+/**
>+ * __umoddi3() - remainder of the division of two 64-bit unsigned integers
>+ *
>+ * @n:		dividend
>+ * @d:		divisor
>+ * Return:	remainder
>+ */
>+notrace u64 __umoddi3(u64 n, u64 d)
>+{
>+	u64 rem;
>+
>+	udivmod64(n, d, &rem);
>+
>+	return rem;
>+}
>


Ok, the code looks *sane* to me, I'd be comfortable adding 

Reviewed-by: Bradley Morgan <brads@mainlining.org>

/shrug 

--- Thanks!
"I'm not a very positive person" - Linus torvalds
