Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BAD606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0W8DF6N/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IFawUKkp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AA2040B1A;
	Thu, 19 Nov 2026 13:33:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EKwSoV7koRK4; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 006AE40AF4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095205;
	b=HIQY1eWKJMK/efqJ/0sIzJI7ULh6UkOfx0Sv5ZUkspQ9NIhByMg4OnmRRX1WgUCVmLrf
	 Ht6v95FMqUEmu4olYwgE/ATLRuiOVm3Qrtuf9ndhdXqV0d9i1zbHimACzhAmvh0M0cXHQ
	 WswMq9mGhZs2RxKmw1lKn51tFfje2i7GQbEM5SzJRoTD27mu64kXfspgpXvQ2rD4saUO5
	 QwTaLHLYaxLt7aoedUY2Aep/+HCtRSTM+IHhNIfKnzmIrrh2T+5vdMqqrBE+/KHlXTObU
	 HXH87JmYz+F+t613EPUeKzUHnUNpKtMCYW86LIv+ie6svPdBQbn/tUogJMyqPSoKPVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sgnlR/hnizHAycTmziYDg1wc3jlBoTP2tfJxM8qUsMQ=;
	b=tEad9FQzUvGm1GA5r6i/Gc4oIrz43u9v32RYGjivOhOp9XmjFuYVUDbF34+0bQyJpMQY
	 L19fn3Xq2x8yO/lx3ROj1QCFVenN2zXECOxuLEOHI3vNxjVZayvsBrDBotIdtakD4Cpqa
	 AWG+cLNrDVM+DKcE+V/rpwbBQub4oif8woKU+sEWSf7BsvwuQNTKZypcPnOJx33tsQi1M
	 XvecBt9MoWWj1wc5rxwU8w01UGjD6/U8sjegZnWXY9eF1K7EoEQCtFQc4aTdUfiwCiFVZ
	 YomAaiu9gAGauQ7c6ld6cYuU8jZohxdzU7XQB8BMtW40I4xtptGUQE1hWV7HcQmZOrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095205;
	bh=sgnlR/hnizHAycTmziYDg1wc3jlBoTP2tfJxM8qUsMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0W8DF6N/8//+8W2bwklTX4/dkP+zIjY8PYV7+UF+SiNV+QXb+gq8pD3DTMIcloA6+
	 ljfsBnXsEzqrsPwiZMcNwq0gw6zMuNSykA6NQSQLK9E1xbgr05mqLURD8k54jYhb+3
	 M8sMHLwplrtu2vuxVflnJCt2hHsXlSIiOpLn1UaswT+IosFfy/bcmd4B0nLHDZRjOo
	 VU+qZD/h5VlYh+GdGapILVfpnJdb2+q+hvBdOtkDtu/josKq6S8X987HUMRhmhEUUe
	 sBXhe3kFSpWZiAkM5ww5rZpv0sbJ9vA5PmkeSfvPOgx2yBacokULn4SfhGN8DAY7iq
	 w8MhNPs0P9oyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 006AE40AF4;
	Thu, 19 Nov 2026 13:33:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF8C722B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1D874052F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLb5YTBonjiS for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E62040527
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=IFawUKkp
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E62040527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:19 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2211130f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095197; x=1795699997;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sgnlR/hnizHAycTmziYDg1wc3jlBoTP2tfJxM8qUsMQ=;
 b=IFawUKkpXxtzFOX7JRicXNlAODJjr6K79c06gBIq7Z/DwKnPcbKAvAyhD6bFYTJS7u
 eagGl8qEJ7o0wNMspYxMff5cb5LAYilW64gSfGWFpn8YVFxxeFzY5XPCJKmHFYyRxi9w
 Sean2C52tdZcGEOYicibB0vWg5oOERP9piewmSYUWSOZ5X4cRaODcdvS8TMM5p0h6PtI
 ackod+reCUxVmL/4XkPHNq1ofl0wiwe+PRwRP60QfYrFF+00pWcfpz8v0F7cZuyZHDOt
 UicMGoWH0gCEesqrw9ogeXTNQC+ttv/agIxIL9teTcCYKfKL7Fn87ZHEdQxyGc9C60Bt
 IlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095197; x=1795699997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sgnlR/hnizHAycTmziYDg1wc3jlBoTP2tfJxM8qUsMQ=;
 b=uanqReUcSKICBdwUL3He2WRqjTI3/9bPxJlXcC9WqDaTdk5hAHN9NydWpPq26lo+8c
 NfaddjNmr05mgbmKXYmgRoh0MHpLEe/hgQDjLLW+t4cKQ2rODzq/BPy06+hcHOGnGD9P
 zgYltZT70RP7OmX6AuAKh21exYQxILVP5ve0uH3fRpPrqqOFqy2XnrIs+U8mUeZ5zc0n
 waRwt2IO73RuphsOrHGBEgoCe2loaNPiNrjwhJeWmF/KJPD6jojeQgK+Vxp1Sd2A3st8
 5U/Nu3USwFmBYjln+a1xU91jW1Z8qSvL4Hy3eSvo/CUgpJtgvZGMoCdilH48ofzVUzWd
 +uJw==
X-Gm-Message-State: APuU4Z+nW1fkKz9SBVHiaSjIe8mMufyj4Nl4BgqxSfbDPsujYN93GPdy
 FLWVkUHKHzJ1NNawkLkelzM1HY+H046v/7Ja/CrRyc+rSksR1EHdFSnmpzRc2BYA
X-Gm-Gg: AZFdTZe6osNMPbAjrhOQFaXG3j0nPoM2PtRjCbs1HnbeU4AbK4Bj9rdfGh4/+Erf3U0
 X5pTHuAOTY7Rt6ZTzf8SfpF0gN5GXgN3YhVMPNvCdm9++RiSqBgDzAt/yp4a8XpiwiH5H3j9FY3
 sDKhkXJgp+S08gTVGgp/zsRN22B5eCYnlANUas+9DL60bhVmtFB8jt2MF4BPURhmzGoG49EJBZ+
 znXw2u2LlFrchXvimtwG7QS4fAPGASJUvdfKp+u5Qkrc6XnIMs4/HE9jmvBDjHvF9vUs7ZSrG/n
 DAxiizxlUKm0r8VTa+yK4w4ZrswfLAcDDVvxxTKDB3o+Z3sGE/EAFWKhivuFvD04xwErV3XiDo8
 5LIRQgcCJmFadwxS0FSXEIc1pUBTXa5rSY/ZoXW5KZ9t0ZMUFIW39tKrncS4UBxfa/yrIS9E4Db
 MUtntsBO2qfao/RKYUq3eQGJ0LO0Smes7OgfiIekbCvDRhoJuN80MOl2Ok+7awO3TPewSo1n9hG
 skPRJP2MFZR+wDM4IYb7brrlYAqm91q0sDuZ3PCTdSN2Nd+Lq6rFWTd4zUjkEzghJp71oGtHeU3
 +CCi8t/Hq8dTYe++1uOWVM+fsYWOPl7+8phqSSeZ7qIQyvMHOn0TwyRuhiR9p8UzzVja2RjZlKF
 Yy/EmaVWDpolrp4in0Yez8AE46FoCtk0nBpS+UsEKa8Oq9uJbVeXMBkuPUHMMI69vL69JcEfhjk
 m4+NZwNel8tyG1SaWsIm5FAFRUeSXW9DeL0+J0yQFf0e1/mjBHCePW6g==
X-Received: by 2002:a05:6000:4102:b0:48e:3bc4:a367 with SMTP id
 ffacd0b85a97d-4a639ff61aemr10875573f8f.33.1795095196892; 
 Thu, 19 Nov 2026 05:33:16 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:16 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/14] powerpc: lib: Add GPR save and restore routines to
 the private libgcc
Date: Thu, 19 Nov 2026 14:32:59 +0100
Message-ID: <20261119133310.22732-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When GCC optimizes for size, it branches to libgcc's _restgpr_N_x
routines to restore non-volatile registers. U-Boot's private libgcc
lacks these routines, so builds with CONFIG_USE_PRIVATE_LIBGCC=y fail
to link with Debian's GCC 14.2, for example qemu-ppce500:

  undefined reference to `_restgpr_31_x'

Copy the 32-bit integer register save and restore routines from
Linux's arch/powerpc/lib/crtsavres.S (v7.3-rc5), following the private
libgcc's existing approach for shift routines. Put each group of
routines in its own section so --gc-sections can discard unused
groups. Linux's CONFIG_CC_OPTIMIZE_FOR_SIZE condition is then not
needed.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Marek Behún <kabel@kernel.org>
---
(no changes since v2)

Changes in v2:
- new patch

The routines assemble to the same code as crtsavgpr.o, crtresgpr.o and
crtresxgpr.o in Debian's libgcc 14.2.
---
 arch/powerpc/lib/Makefile    |   3 +-
 arch/powerpc/lib/crtsavres.S | 213 +++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/crtsavres.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a3048975ae7..90f0e1e5fa9 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -5,7 +5,8 @@
 
 ## Build a couple of necessary functions into a private libgcc
 ## if the user asked for it
-lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o
+lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o \
+				    crtsavres.o
 
 MINIMAL=
 
diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
new file mode 100644
index 00000000000..8c35eedecb6
--- /dev/null
+++ b/arch/powerpc/lib/crtsavres.S
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Out-of-line integer register save and restore routines, which GCC calls
+ * from function prologues and epilogues when it optimizes for size.
+ *
+ * This code was copied from crtsavres.S in arch/powerpc/lib of the Linux
+ * kernel sources (v7.3-rc5, last changed by commit 699d53f04829
+ * ("powerpc/vdso32: Fix use of crtsavres for PPC64")): the 32-bit integer
+ * register routines, without the CONFIG_CC_OPTIMIZE_FOR_SIZE condition.
+ * Each group of routines is in a section of its own, so that --gc-sections
+ * drops the groups that nothing calls. The source file copyrights are as
+ * follows:
+ *
+ *   Copyright (C) 1995, 1996, 1998, 2000, 2001 Free Software Foundation, Inc.
+ *   Copyright 2008 Freescale Semiconductor, Inc.
+ *   Written By Michael Meissner
+ *
+ * Based on gcc/config/rs6000/crtsavres.asm from gcc
+ */
+
+#include <asm/processor.h>
+
+/* Routines for saving integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer save area.  */
+
+	.section ".text._savegpr_14","ax",@progbits
+	.align	2
+
+_GLOBAL(_savegpr_14)
+_GLOBAL(_save32gpr_14)
+	stw	14,-72(11)	/* save gp registers */
+_GLOBAL(_savegpr_15)
+_GLOBAL(_save32gpr_15)
+	stw	15,-68(11)
+_GLOBAL(_savegpr_16)
+_GLOBAL(_save32gpr_16)
+	stw	16,-64(11)
+_GLOBAL(_savegpr_17)
+_GLOBAL(_save32gpr_17)
+	stw	17,-60(11)
+_GLOBAL(_savegpr_18)
+_GLOBAL(_save32gpr_18)
+	stw	18,-56(11)
+_GLOBAL(_savegpr_19)
+_GLOBAL(_save32gpr_19)
+	stw	19,-52(11)
+_GLOBAL(_savegpr_20)
+_GLOBAL(_save32gpr_20)
+	stw	20,-48(11)
+_GLOBAL(_savegpr_21)
+_GLOBAL(_save32gpr_21)
+	stw	21,-44(11)
+_GLOBAL(_savegpr_22)
+_GLOBAL(_save32gpr_22)
+	stw	22,-40(11)
+_GLOBAL(_savegpr_23)
+_GLOBAL(_save32gpr_23)
+	stw	23,-36(11)
+_GLOBAL(_savegpr_24)
+_GLOBAL(_save32gpr_24)
+	stw	24,-32(11)
+_GLOBAL(_savegpr_25)
+_GLOBAL(_save32gpr_25)
+	stw	25,-28(11)
+_GLOBAL(_savegpr_26)
+_GLOBAL(_save32gpr_26)
+	stw	26,-24(11)
+_GLOBAL(_savegpr_27)
+_GLOBAL(_save32gpr_27)
+	stw	27,-20(11)
+_GLOBAL(_savegpr_28)
+_GLOBAL(_save32gpr_28)
+	stw	28,-16(11)
+_GLOBAL(_savegpr_29)
+_GLOBAL(_save32gpr_29)
+	stw	29,-12(11)
+_GLOBAL(_savegpr_30)
+_GLOBAL(_save32gpr_30)
+	stw	30,-8(11)
+_GLOBAL(_savegpr_31)
+_GLOBAL(_save32gpr_31)
+	stw	31,-4(11)
+	blr
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+
+	.section ".text._restgpr_14","ax",@progbits
+	.align	2
+
+_GLOBAL(_restgpr_14)
+_GLOBAL(_rest32gpr_14)
+	lwz	14,-72(11)	/* restore gp registers */
+_GLOBAL(_restgpr_15)
+_GLOBAL(_rest32gpr_15)
+	lwz	15,-68(11)
+_GLOBAL(_restgpr_16)
+_GLOBAL(_rest32gpr_16)
+	lwz	16,-64(11)
+_GLOBAL(_restgpr_17)
+_GLOBAL(_rest32gpr_17)
+	lwz	17,-60(11)
+_GLOBAL(_restgpr_18)
+_GLOBAL(_rest32gpr_18)
+	lwz	18,-56(11)
+_GLOBAL(_restgpr_19)
+_GLOBAL(_rest32gpr_19)
+	lwz	19,-52(11)
+_GLOBAL(_restgpr_20)
+_GLOBAL(_rest32gpr_20)
+	lwz	20,-48(11)
+_GLOBAL(_restgpr_21)
+_GLOBAL(_rest32gpr_21)
+	lwz	21,-44(11)
+_GLOBAL(_restgpr_22)
+_GLOBAL(_rest32gpr_22)
+	lwz	22,-40(11)
+_GLOBAL(_restgpr_23)
+_GLOBAL(_rest32gpr_23)
+	lwz	23,-36(11)
+_GLOBAL(_restgpr_24)
+_GLOBAL(_rest32gpr_24)
+	lwz	24,-32(11)
+_GLOBAL(_restgpr_25)
+_GLOBAL(_rest32gpr_25)
+	lwz	25,-28(11)
+_GLOBAL(_restgpr_26)
+_GLOBAL(_rest32gpr_26)
+	lwz	26,-24(11)
+_GLOBAL(_restgpr_27)
+_GLOBAL(_rest32gpr_27)
+	lwz	27,-20(11)
+_GLOBAL(_restgpr_28)
+_GLOBAL(_rest32gpr_28)
+	lwz	28,-16(11)
+_GLOBAL(_restgpr_29)
+_GLOBAL(_rest32gpr_29)
+	lwz	29,-12(11)
+_GLOBAL(_restgpr_30)
+_GLOBAL(_rest32gpr_30)
+	lwz	30,-8(11)
+_GLOBAL(_restgpr_31)
+_GLOBAL(_rest32gpr_31)
+	lwz	31,-4(11)
+	blr
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+
+	.section ".text._restgpr_14_x","ax",@progbits
+	.align	2
+
+_GLOBAL(_restgpr_14_x)
+_GLOBAL(_rest32gpr_14_x)
+	lwz	14,-72(11)	/* restore gp registers */
+_GLOBAL(_restgpr_15_x)
+_GLOBAL(_rest32gpr_15_x)
+	lwz	15,-68(11)
+_GLOBAL(_restgpr_16_x)
+_GLOBAL(_rest32gpr_16_x)
+	lwz	16,-64(11)
+_GLOBAL(_restgpr_17_x)
+_GLOBAL(_rest32gpr_17_x)
+	lwz	17,-60(11)
+_GLOBAL(_restgpr_18_x)
+_GLOBAL(_rest32gpr_18_x)
+	lwz	18,-56(11)
+_GLOBAL(_restgpr_19_x)
+_GLOBAL(_rest32gpr_19_x)
+	lwz	19,-52(11)
+_GLOBAL(_restgpr_20_x)
+_GLOBAL(_rest32gpr_20_x)
+	lwz	20,-48(11)
+_GLOBAL(_restgpr_21_x)
+_GLOBAL(_rest32gpr_21_x)
+	lwz	21,-44(11)
+_GLOBAL(_restgpr_22_x)
+_GLOBAL(_rest32gpr_22_x)
+	lwz	22,-40(11)
+_GLOBAL(_restgpr_23_x)
+_GLOBAL(_rest32gpr_23_x)
+	lwz	23,-36(11)
+_GLOBAL(_restgpr_24_x)
+_GLOBAL(_rest32gpr_24_x)
+	lwz	24,-32(11)
+_GLOBAL(_restgpr_25_x)
+_GLOBAL(_rest32gpr_25_x)
+	lwz	25,-28(11)
+_GLOBAL(_restgpr_26_x)
+_GLOBAL(_rest32gpr_26_x)
+	lwz	26,-24(11)
+_GLOBAL(_restgpr_27_x)
+_GLOBAL(_rest32gpr_27_x)
+	lwz	27,-20(11)
+_GLOBAL(_restgpr_28_x)
+_GLOBAL(_rest32gpr_28_x)
+	lwz	28,-16(11)
+_GLOBAL(_restgpr_29_x)
+_GLOBAL(_rest32gpr_29_x)
+	lwz	29,-12(11)
+_GLOBAL(_restgpr_30_x)
+_GLOBAL(_rest32gpr_30_x)
+	lwz	30,-8(11)
+_GLOBAL(_restgpr_31_x)
+_GLOBAL(_rest32gpr_31_x)
+	lwz	0,4(11)
+	lwz	31,-4(11)
+	mtlr	0
+	mr	1,11
+	blr
-- 
2.54.0 (Apple Git-157)

