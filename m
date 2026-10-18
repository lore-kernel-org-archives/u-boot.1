Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E815ECCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A82B2606FD;
	Sun, 18 Oct 2026 08:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPDuYceUjGOr; Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A631B606BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312535;
	b=SM6jtQb0bji2odvMmCDCLj+NBQwWPX8TfYEnIJuIFh82cNz5SOWZg/tq9MZJBU7Pnckb
	 Z9otZ3+d3VI22Ye0SGhRSMk7aUAeAeNhf67U8uBLTny/hGvxFsFKLXfnmAfgZPxI6acaH
	 TmWc2stqkSl6/3u6EPQzy3c/ec7jQIw+JAF+l5TaOZAhWcj+sQLWJDrcN4IEO+veOBcNx
	 W6VJ5bB+UZsRV2uFf/LQUc0rJ5ujV79l82w/5j+2HnsLqVCgs6udjJNTCskZkealA1cAk
	 vk7c5VRdi/FBu2SHIBXxZUEfOg9+gp98rYKCNeCore5BzehsQlVHV6VRZNqJWnfkPdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UZjvrrcNW1WisxWZQnYNNpU+C5ws/IyX5SJYa39tor8=;
	b=gx+dtLjO9+7j2Gj78uxHFztvzhRyXLtVVHZ6R91GSYS4ATo+zTEQN75NR7GuFddeRWYg
	 lnPaTdKKkrjL6KqdeSTnjC+SPcZtF45Y+eYSJv17TR/uq3efnp6NavUqbZde+4dyKpGmd
	 eyboZdD8tcIakaskmOcZBSItr5qvLkwrrnIUOgo6dEagz+8SdhlGxlAG1Au4nj/oQRPb2
	 2yMhO87NLpyJNTNOjrmpWSxPPdHbDb+VXhuOkEr325ogXG4SGiu/CZ+LMz2q6FuyHlnk7
	 03oo+IciqzUzMsBnYRTh2Dgpv1rtdCz1v+h1E5NxBQ0kiwV988a+9hPo//fFZ2RCbGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312535;
	bh=UZjvrrcNW1WisxWZQnYNNpU+C5ws/IyX5SJYa39tor8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=afSZ2I7IGGJV03CLk0hNuYmg2/lGS8OaH7A46XOK0imG0F76ZLYA3vIwuM9uGLr36
	 iY4MPaCOxPkbIe8o+EKwFtknYj63iUBo8C2D0viW3dglSMutBQEC3qHSZnI6wqpZ+a
	 63JjgoSLWQJ7ks1GheghftH9Myls15zzyT+CqaYXxANkeptTcgRI+byJyLRJHZpXuM
	 8OEOUJt2jcuOBUmqaoKmNBbAy1dgbRXFPqDIP6BavyBQalRgVZYFLpYdSgYoQXq9GQ
	 HvcZ1BozYO6d9C5EDLAl38ELrpt8NsFbf3PsmdIKcj3ExStPZfICIOBVbKnKYeLlTj
	 yVlsn4Av6Qd+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A631B606BA;
	Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD41A75
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0BF140949
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrZJCg77g6J5 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B1B140856
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312528;
 b=h4WjkTZYrj4CY81ZPn0TT4Dpz8TYbBRJHKVqakP5pjzGKMIjFt/h4BYGV7VHPEl/2vII
 RnFqryI8JzuMo+R82lozgQxbSj+YGLOSVa1C23pmUV/+jTu6MpXk5QZ3m9zOk79Lz6HrI
 sWPUZAqU0/Zzo9YkUj73wV7z/xeTXFCpCcJTOh313spc8Wejaza3C0Zo9/EAh10swG0CU
 ofS2vwYcgV+M7pwLlH04bUR1G47oaSycRZoS//NLRWUvyfd8jaVjr9wSEQA797rTbFi3p
 gRH/FbCOf7KaeUpJkJXko4fAcu72e6b5uI/V2+k7Sg97aZCG8ThVFbNXLBA6ivU7rYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=UZjvrrcNW1WisxWZQnYNNpU+C5ws/IyX5SJYa39tor8=;
 b=ask0aV7IqepSTROUQSXLt9nfaUt7D/lehBQ8k5C3/KPyEmenMsqo9m9UyulvPWPGrfrS
 FXHStSnU39q9qcbYa/TDZ63STPT/hVGOalHKoYZetGcP5Bvso3NUh2mj2cAqd0M3ddZHT
 7hZAlrYR6zy13IsoG22v64WAa6SR6dMQLNAQcJdfOGK9yqoMH/84Aw0X9feM38XYfR+SB
 8QAGwUyGzXMKOi2qjIv3IKYRFBoSXLhwUFz0aX3KMomiTQNnuOz9uGZ6Iya4C1M0ny0hG
 UdOBoNDn97aoPzhJabHL74XbZlUC4iG/N7Mw7dxRQdz/MhEG23WIgqUTfPr+782PZBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FLl+W3ZN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FLl+W3ZN
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B1B140856
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:27 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so7787255e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312525; x=1792917325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UZjvrrcNW1WisxWZQnYNNpU+C5ws/IyX5SJYa39tor8=;
 b=FLl+W3ZNBIxIkwba6y0YMT01Ebuq7JsXC21rgZeQWZP4bNqMtl9V/w4fyM2Vz9U5Xb
 6Lp0wJ743pIiqarOLh4Wc/9xCEbZLkSm8JT62j9X4dBRSpKmS/1pvWCyxj57aiWalBCJ
 XOQ+5UkcH9iVPIYgIM38hCKvdR49VdcJUyCEoyF1nxSOP0qRex0wZAbtCzWVpCKZNDLG
 d0lujxywzqcs/DJ2PgTKUWXp97u2GO0j6zzRJqx9jfdbbWjcDixOdTZKwRXhn+ZM4rCT
 CQ0gtb9KO6CSxpMqAXmvdl9lQSbuQN1ORo7MpLNGjPImjP3H/Px8qmf178U0myd48Ljx
 x4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312525; x=1792917325;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UZjvrrcNW1WisxWZQnYNNpU+C5ws/IyX5SJYa39tor8=;
 b=Afy9kJDneshBexsic0qiuCKVN/7Ke42fNnAIKdL0Rq9vk4ybORm5u0g1mlE4ivI4n8
 UxcVWwfhAsv8MHlnngYqlJyEtsiwc8I/Xo0ztgk7GGsH98QIoBclftDEqzye3DFY5oGu
 BKeOMfr/EHNtWgVESvbl/CnaNUEbDhxb9UnKwe6xRw7k/6Y2wjEubK0ubNtkWp01hcnO
 3m25/6LGaQLtOTA7cdLvUuslrSMWVz7OZijdvLYdrgOzlLbiSZor6VwkMBzhpHe/2WiB
 N3wEiAldLt7so2irGnXQBUJGneFGnHv8Z7LGzWJZEsySWvjWATJ/i9/Xgw6arBSKTiEn
 TSHw==
X-Gm-Message-State: AFq9FYI+molwucPiD0jImB8uyOYrDgQGAEuCIVTTGb8HCXucI3/h2Fo0
 jJu3YVV61MXGdsUoGdYoJkvJsma1NF6sBYS1KJKqhJFeIoujw67M33UGzqWxda+j
X-Gm-Gg: AYBFou2ow6iFULyZdMp++3dILRjK28ZmjcjmC0yXyZaj1FXeQIjCZ9V0FCuwe/2mE75
 VjFd5q8pM+uKiyEbQdIhFBhRGvydRRsxIS5w9gs2faMFLJABUeu+uiOPa9QbeOAv/AnDpQk78iG
 TKXSyE04JtOQcBI82a9Ovzslzv4wYqITX3+RwvGSoascp1aE9LnJ+0Uo8z3r83PNDuT9cXWaKzG
 p81Cpcj/6nLokBYdQD5yvpnmVy24eFJqtbKZvRZkehRPVLIqX5ffaIKT99y+mTKn3J49B+E1GEF
 UoJ54KL4Z4pytl8JIfVXvw7D1q4RzDN3UEF1k9/t7oWtTN9zc9OCcWE5TyEJVzsz/R19DCcQ9SV
 kowTDS+pscgtVHMOL32dzKpq4NtReOGAsibKprWkdzYf9r3tVpfe0AXl1ewnbBJNtZxyx+OtxpB
 qMXj1PS3wAMjvT+dEft5CkyYzYYnx4CyF87zBtD+Wg40PUHraE2DM0xcHcCrWW243fC7IvX75iy
 45V3yiP0bauEMXonjrAm1JbbgTXqn03+5daEJvK5vp331WyfV+6iAlJmltacRaoljj18solO4wq
 rLBF0bPRKoSVDGZcPhR6skeAxWFiA5h3KqN9j1dOC2H43HRd4gVHKIsw8LB5LN32HhagkQ3jMlf
 XxBUdIFR9h2E00tm0Go08frY=
X-Received: by 2002:a05:600c:8b0a:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4a1dbdf1a18mr68191455e9.2.1792312525104; 
 Sun, 18 Oct 2026 01:35:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:24 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/14] powerpc: lib: Add GPR save and restore routines to
 the private libgcc
Date: Sun, 18 Oct 2026 10:35:05 +0200
Message-ID: <20261018083516.49229-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
Cc: Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Marek Behún <kabel@kernel.org>
---
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

