Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE860B5079
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aVap8Klm;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=QNulWnZ7;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=vXKjpLJj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67458406AE;
	Mon, 19 Oct 2026 15:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbmCkqS2pwvQ; Mon, 19 Oct 2026 15:27:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74ED9406A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423670;
	b=eS1nBTBgPAMoWCvv3EE+mzTVnKGRDnAVQjHr42J19WTPZgGK204XzmrmQdCDyAXxx/8/
	 3r9CEPZFTScLXqPPY9bUZHVJZDQGd9U9dUJ99hEXvIkRvzLNnULeyk4iFSSckuMc6pKNC
	 0S7tHBq+6+nDZTOYjip9fWKVBZXx6Eb0CwPOhYqBBEaOSXu7v8LY9YIEnZoEovWspxRxm
	 poGEUTNNOYsKDA2oZfeLr0yomVh9Zg6K6NkCwXS/Bm26wNAw9Xv/x+PXhf3n0jU8y6P6q
	 MsG+tJWT8GEgkIJmn99UA7dSse10rFyXyOt7NA1SaUlWCHd4Q9skrvJVo/14Zb7EAfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fnHWYj+xhqeC5hHWC+CRYSMfndm9Nf7jxTD79hfie3s=;
	b=leuviCharQwj3huaoCRGhhF6CauAvW88kAqpnygzwBRZZIHeCpHtoNKQsp3eNcpdkGfC
	 xsStBHrYokdU2r7+ApVnafHUrZSwakgncIcm+KOeCo8TX6ayvUpuERsRuJyEkqwPiMDK/
	 zKaGEkdv6V97CaYwWWj1SqCIULT7kzLNwciV7uqz3AkKaDkEUI40ksW4kxV6PvymFUF6d
	 det3J06XqPpuPzTX4rS3uXaSWTrBeQt1Pi2ySaj9WzgZxZb8KpEPmHy8N4TLYyUFMdDHL
	 2VG1+u6hVlacrS2aX5J39x5LwtQMDhm78r+AiCIBj66bJI+HK0O911TXzn6BIp3ayAw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423670;
	bh=fnHWYj+xhqeC5hHWC+CRYSMfndm9Nf7jxTD79hfie3s=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=aVap8KlmL9jao0Vo8JHbrM//emqOJJOwAJO1Q95tQ+aWAV1xZE3a9DZ5IS9SG5cgK
	 JrmCaAspOWyINHWqsEYGYAClAanHfTXyYH1E7TN6XWchIEjtYTbbRbA2bVJOZhEGzj
	 4LoH7w89NbKXSpRedudCUqniYSthEpkGuk7LR+Yv0t6xS6PSWLV1KnlDnvnHi/g/hL
	 uuZXtX3gjTjJjS7OHXxRfbxqBp26VFO3TquIXM3oWQ6txmVvbGyT0jbOsnvciDcrZp
	 mVD6ctoUYLcjHVWNqitGMq012qc1CYdXngEtP9cPVWFqfKpuMFw1OlsG+5XaPhi2ud
	 O/yiZMcvSfg9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74ED9406A8;
	Mon, 19 Oct 2026 15:27:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 44E3D1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36AD5400F9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-agZKh-l8Is for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0E4DE400B4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423317;
 b=ciO5ynplTg70OtrKFpQiB4cwtTRPMKhV25YO69K8pm2JqFop43EhIPG1caqfINgLhdQX
 UHEHJX20pzBVYi5m5wP8VtCIQEHWOdSRUtXBDPwxNdxzKkaOoH2fezuU407D78RP7R8JS
 w7LlkGHkLDaVmA9rZ67P+QBc8bPFRK0yQ6bCaomydPz4bB6bPnvVjUyOS391BiAaoWL25
 02RJkQnaFPqkVd0A9SXqcRbjSra8KomK/xPFMubfNg82WCc6WaHRogihQ8Qv99B5JWphg
 ImdiK6UiRNeF9Zct7LzM/MtxcPRPb/iqVkqR1v4nfT51/bMSwZRG7WxKrSCv2m/gP0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423317;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=fnHWYj+xhqeC5hHWC+CRYSMfndm9Nf7jxTD79hfie3s=;
 b=Pqs+5ryhzSWrfrgCQbLWeoNrlUEvOOuV4xZNMWdTBT9+fLbebrPreBAh9Asx0e+RaNIx
 tXLKoxyM/WI2LlGqgesG0GGceA3icmB5NRPnVTP+7PXgLyYFZTaspZtzbG9HqqfhPY24G
 n3iy0ClhYnG6/8GbcKzNOwsPxyvUKK+xrkPgf5DuYu82i5m0w/5TaAUZ+FSxLM1eSFtYV
 w/snLmkvk2CQ6udT77CfSDeYGkTVdYf/PbOwQ1IlDZ35dgieaNPcOcM771/CzaRjthoht
 D/B41yqk6xe2xf+GbHWXzs2/0PN1LCQ+63E2de/dXkiL9SCJBDxYCB/5tcX8v7hEntQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=QNulWnZ7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vXKjpLJj; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=QNulWnZ7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=vXKjpLJj
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E4DE400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423301; bh=fnHWYj+xhqeC5hHWC+CRYSM
 fndm9Nf7jxTD79hfie3s=; b=QNulWnZ7ls+0H0c1DtXTgkKVPWhLHvd1IgaUcYJ1oFDdkCufDm
 G+ea9gk4Dkfie92wsmGMjCcL4MxPwAhNCvWFDekbPN+2HMTVGEK8bwskwuVpGIUoCYO6Y5mt6+p
 r7h0ke769zTTdgnvTFm4oTCaMi6Ub1FpTUNkTFr+s8/mQ8zZL3StDF1McHkHV50zVq8hyqanpE2
 P9QEz7YM6+b72YmxhCfMO6yr/3Zk9yuoNHBun35KOnamcsGfvdRYKM8YJowLifrN+U8GsTtGIIw
 +rtE0t1AWEL9SBP7sEtFT0kB1KinMtJtCOV0LzLJ0yHO0laG6/0blU8/R6IrFE3L3sw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423301; bh=fnHWYj+xhqeC5hHWC+CRYSM
 fndm9Nf7jxTD79hfie3s=; b=vXKjpLJjSNFJbCFY1Y3km9INvJXV9W2Y+EDaqj0F+qFonJIWED
 AYm3uBhfyctVeOaM5MjiRgrbgtSbNiKSC3DQ==;
Date: Mon, 19 Oct 2026 16:21:41 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_03/14=5D_powerpc=3A_lib=3A_Add_GPR_sa?=
 =?US-ASCII?Q?ve_and_restore_routines_to_the_private_libgcc?=
In-Reply-To: <20261018083516.49229-4-pepe.schlehofer@gmail.com>
Message-ID: <47151803-7622-48DC-BF41-46617FEADE6E@mainlining.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:05 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>When GCC optimizes for size, it branches to libgcc's _restgpr_N_x
>routines to restore non-volatile registers. U-Boot's private libgcc
>lacks these routines, so builds with CONFIG_USE_PRIVATE_LIBGCC=y fail
>to link with Debian's GCC 14.2, for example qemu-ppce500:
>
>  undefined reference to `_restgpr_31_x'
>
>Copy the 32-bit integer register save and restore routines from
>Linux's arch/powerpc/lib/crtsavres.S (v7.3-rc5), following the private
>libgcc's existing approach for shift routines. Put each group of
>routines in its own section so --gc-sections can discard unused
>groups. Linux's CONFIG_CC_OPTIMIZE_FOR_SIZE condition is then not
>needed.
>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>Cc: Marek Behún <kabel@kernel.org>
>---
>Changes in v2:
>- new patch
>
>The routines assemble to the same code as crtsavgpr.o, crtresgpr.o and
>crtresxgpr.o in Debian's libgcc 14.2.
>---
> arch/powerpc/lib/Makefile    |   3 +-
> arch/powerpc/lib/crtsavres.S | 213 +++++++++++++++++++++++++++++++++++
> 2 files changed, 215 insertions(+), 1 deletion(-)
> create mode 100644 arch/powerpc/lib/crtsavres.S

I feel a maintainers entry for this would be good, or could it be covered
under me? (If I end up getting maintainers patch merged)


>
>diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>index a3048975ae7..90f0e1e5fa9 100644
>--- a/arch/powerpc/lib/Makefile
>+++ b/arch/powerpc/lib/Makefile
>@@ -5,7 +5,8 @@
> 
> ## Build a couple of necessary functions into a private libgcc
> ## if the user asked for it
>-lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o
>+lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o \
>+				    crtsavres.o
> 
> MINIMAL=
> 
>diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
>new file mode 100644
>index 00000000000..8c35eedecb6
>--- /dev/null
>+++ b/arch/powerpc/lib/crtsavres.S
>@@ -0,0 +1,213 @@
>+/* SPDX-License-Identifier: GPL-2.0+ */
>+/*
>+ * Out-of-line integer register save and restore routines, which GCC calls
>+ * from function prologues and epilogues when it optimizes for size.
>+ *
>+ * This code was copied from crtsavres.S in arch/powerpc/lib of the Linux
>+ * kernel sources (v7.3-rc5, last changed by commit 699d53f04829
>+ * ("powerpc/vdso32: Fix use of crtsavres for PPC64")): the 32-bit integer
>+ * register routines, without the CONFIG_CC_OPTIMIZE_FOR_SIZE condition.
>+ * Each group of routines is in a section of its own, so that --gc-sections
>+ * drops the groups that nothing calls. The source file copyrights are as
>+ * follows:
>+ *
>+ *   Copyright (C) 1995, 1996, 1998, 2000, 2001 Free Software Foundation, Inc.
>+ *   Copyright 2008 Freescale Semiconductor, Inc.
>+ *   Written By Michael Meissner
>+ *
>+ * Based on gcc/config/rs6000/crtsavres.asm from gcc
>+ */
>+
>+#include <asm/processor.h>
>+
>+/* Routines for saving integer registers, called by the compiler.  */
>+/* Called with r11 pointing to the stack header word of the caller of the */
>+/* function, just beyond the end of the integer save area.  */
>+
>+	.section ".text._savegpr_14","ax",@progbits
>+	.align	2
>+
>+_GLOBAL(_savegpr_14)
>+_GLOBAL(_save32gpr_14)
>+	stw	14,-72(11)	/* save gp registers */
>+_GLOBAL(_savegpr_15)
>+_GLOBAL(_save32gpr_15)
>+	stw	15,-68(11)
>+_GLOBAL(_savegpr_16)
>+_GLOBAL(_save32gpr_16)
>+	stw	16,-64(11)
>+_GLOBAL(_savegpr_17)
>+_GLOBAL(_save32gpr_17)
>+	stw	17,-60(11)
>+_GLOBAL(_savegpr_18)
>+_GLOBAL(_save32gpr_18)
>+	stw	18,-56(11)
>+_GLOBAL(_savegpr_19)
>+_GLOBAL(_save32gpr_19)
>+	stw	19,-52(11)
>+_GLOBAL(_savegpr_20)
>+_GLOBAL(_save32gpr_20)
>+	stw	20,-48(11)
>+_GLOBAL(_savegpr_21)
>+_GLOBAL(_save32gpr_21)
>+	stw	21,-44(11)
>+_GLOBAL(_savegpr_22)
>+_GLOBAL(_save32gpr_22)
>+	stw	22,-40(11)
>+_GLOBAL(_savegpr_23)
>+_GLOBAL(_save32gpr_23)
>+	stw	23,-36(11)
>+_GLOBAL(_savegpr_24)
>+_GLOBAL(_save32gpr_24)
>+	stw	24,-32(11)
>+_GLOBAL(_savegpr_25)
>+_GLOBAL(_save32gpr_25)
>+	stw	25,-28(11)
>+_GLOBAL(_savegpr_26)
>+_GLOBAL(_save32gpr_26)
>+	stw	26,-24(11)
>+_GLOBAL(_savegpr_27)
>+_GLOBAL(_save32gpr_27)
>+	stw	27,-20(11)
>+_GLOBAL(_savegpr_28)
>+_GLOBAL(_save32gpr_28)
>+	stw	28,-16(11)
>+_GLOBAL(_savegpr_29)
>+_GLOBAL(_save32gpr_29)
>+	stw	29,-12(11)
>+_GLOBAL(_savegpr_30)
>+_GLOBAL(_save32gpr_30)
>+	stw	30,-8(11)
>+_GLOBAL(_savegpr_31)
>+_GLOBAL(_save32gpr_31)
>+	stw	31,-4(11)
>+	blr
>+
>+/* Routines for restoring integer registers, called by the compiler.  */
>+/* Called with r11 pointing to the stack header word of the caller of the */
>+/* function, just beyond the end of the integer restore area.  */
>+
>+	.section ".text._restgpr_14","ax",@progbits
>+	.align	2
>+
>+_GLOBAL(_restgpr_14)
>+_GLOBAL(_rest32gpr_14)
>+	lwz	14,-72(11)	/* restore gp registers */
>+_GLOBAL(_restgpr_15)
>+_GLOBAL(_rest32gpr_15)
>+	lwz	15,-68(11)
>+_GLOBAL(_restgpr_16)
>+_GLOBAL(_rest32gpr_16)
>+	lwz	16,-64(11)
>+_GLOBAL(_restgpr_17)
>+_GLOBAL(_rest32gpr_17)
>+	lwz	17,-60(11)
>+_GLOBAL(_restgpr_18)
>+_GLOBAL(_rest32gpr_18)
>+	lwz	18,-56(11)
>+_GLOBAL(_restgpr_19)
>+_GLOBAL(_rest32gpr_19)
>+	lwz	19,-52(11)
>+_GLOBAL(_restgpr_20)
>+_GLOBAL(_rest32gpr_20)
>+	lwz	20,-48(11)
>+_GLOBAL(_restgpr_21)
>+_GLOBAL(_rest32gpr_21)
>+	lwz	21,-44(11)
>+_GLOBAL(_restgpr_22)
>+_GLOBAL(_rest32gpr_22)
>+	lwz	22,-40(11)
>+_GLOBAL(_restgpr_23)
>+_GLOBAL(_rest32gpr_23)
>+	lwz	23,-36(11)
>+_GLOBAL(_restgpr_24)
>+_GLOBAL(_rest32gpr_24)
>+	lwz	24,-32(11)
>+_GLOBAL(_restgpr_25)
>+_GLOBAL(_rest32gpr_25)
>+	lwz	25,-28(11)
>+_GLOBAL(_restgpr_26)
>+_GLOBAL(_rest32gpr_26)
>+	lwz	26,-24(11)
>+_GLOBAL(_restgpr_27)
>+_GLOBAL(_rest32gpr_27)
>+	lwz	27,-20(11)
>+_GLOBAL(_restgpr_28)
>+_GLOBAL(_rest32gpr_28)
>+	lwz	28,-16(11)
>+_GLOBAL(_restgpr_29)
>+_GLOBAL(_rest32gpr_29)
>+	lwz	29,-12(11)
>+_GLOBAL(_restgpr_30)
>+_GLOBAL(_rest32gpr_30)
>+	lwz	30,-8(11)
>+_GLOBAL(_restgpr_31)
>+_GLOBAL(_rest32gpr_31)
>+	lwz	31,-4(11)
>+	blr
>+
>+/* Routines for restoring integer registers, called by the compiler.  */
>+/* Called with r11 pointing to the stack header word of the caller of the */
>+/* function, just beyond the end of the integer restore area.  */
>+
>+	.section ".text._restgpr_14_x","ax",@progbits
>+	.align	2
>+
>+_GLOBAL(_restgpr_14_x)
>+_GLOBAL(_rest32gpr_14_x)
>+	lwz	14,-72(11)	/* restore gp registers */
>+_GLOBAL(_restgpr_15_x)
>+_GLOBAL(_rest32gpr_15_x)
>+	lwz	15,-68(11)
>+_GLOBAL(_restgpr_16_x)
>+_GLOBAL(_rest32gpr_16_x)
>+	lwz	16,-64(11)
>+_GLOBAL(_restgpr_17_x)
>+_GLOBAL(_rest32gpr_17_x)
>+	lwz	17,-60(11)
>+_GLOBAL(_restgpr_18_x)
>+_GLOBAL(_rest32gpr_18_x)
>+	lwz	18,-56(11)
>+_GLOBAL(_restgpr_19_x)
>+_GLOBAL(_rest32gpr_19_x)
>+	lwz	19,-52(11)
>+_GLOBAL(_restgpr_20_x)
>+_GLOBAL(_rest32gpr_20_x)
>+	lwz	20,-48(11)
>+_GLOBAL(_restgpr_21_x)
>+_GLOBAL(_rest32gpr_21_x)
>+	lwz	21,-44(11)
>+_GLOBAL(_restgpr_22_x)
>+_GLOBAL(_rest32gpr_22_x)
>+	lwz	22,-40(11)
>+_GLOBAL(_restgpr_23_x)
>+_GLOBAL(_rest32gpr_23_x)
>+	lwz	23,-36(11)
>+_GLOBAL(_restgpr_24_x)
>+_GLOBAL(_rest32gpr_24_x)
>+	lwz	24,-32(11)
>+_GLOBAL(_restgpr_25_x)
>+_GLOBAL(_rest32gpr_25_x)
>+	lwz	25,-28(11)
>+_GLOBAL(_restgpr_26_x)
>+_GLOBAL(_rest32gpr_26_x)
>+	lwz	26,-24(11)
>+_GLOBAL(_restgpr_27_x)
>+_GLOBAL(_rest32gpr_27_x)
>+	lwz	27,-20(11)
>+_GLOBAL(_restgpr_28_x)
>+_GLOBAL(_rest32gpr_28_x)
>+	lwz	28,-16(11)
>+_GLOBAL(_restgpr_29_x)
>+_GLOBAL(_rest32gpr_29_x)
>+	lwz	29,-12(11)
>+_GLOBAL(_restgpr_30_x)
>+_GLOBAL(_rest32gpr_30_x)
>+	lwz	30,-8(11)
>+_GLOBAL(_restgpr_31_x)
>+_GLOBAL(_rest32gpr_31_x)
>+	lwz	0,4(11)
>+	lwz	31,-4(11)
>+	mtlr	0
>+	mr	1,11
>+	blr
>


Hmm. Makes sense. 

Reviewed-by: Bradley Morgan <brads@mainlining.org>


--- Thanks!
"I'm not a very positive person" - Linus torvalds
