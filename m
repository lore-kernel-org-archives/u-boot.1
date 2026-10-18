Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CE7CCF2D1
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27CEA40966;
	Sun, 18 Oct 2026 08:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDov3J0MwWJ1; Sun, 18 Oct 2026 08:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40D85409DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312537;
	b=aJJZ30tHLDD1qFpWHHrQyx3WR0Lza/fVSrnRCi0FbBT3jV+BgPE8gnZ8oz3++xu8Kquh
	 cdMsywaMprmR8Ehb+UFFvqicU/Y/DYEZPxOrxw8oqAnsCPMMqk0Xb4sby0aZKmt71Vcno
	 7aZg1Ns8rin3JXm8Sial5QS8FQSuRgj284qefwR4IHPfXYxcBS2uI7I3kEgk/wzWsCHim
	 i8J+1Y5pqIoJLef1cQMUj/TzaUv+4MDUm/ZTZxSWpmEWjrjT/xFn2Io3TUGU9SNUYQFgg
	 6h/CpQSguWERcuq/cuSTURdBE8XGy5iiCrB2DQAoFMNKEIyfuxDqYM1weSDqroVKi4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DeApma2uplQJunJNCRhPcjySG9AUPfPJgLBPhzTwBCE=;
	b=gcP83YhxPcLa6BnlnD/ZJxD2tG2iTesrrZvUHr0da+j7Og4UxLQJsdLf3r/IsZTPZ4Oi
	 RB7n/o7KU7sX4KLDkHKXhulCXSyDed1yZxax+SIuuzhGADUv4T/C+46TsAesEIg8KHAcL
	 y5iZTET/RyYOwW5wB8/igdC2geZydVJRi0oj+uPXILb5SqnmUD69vsYKkqXCtCkywxaMb
	 bvyca2+qgdbsX/+kOAqhPIA/qaSLgSyJCWxVGZs2fUSVWEaTXPECQo8J3IlLA+v99rhhj
	 /1ZkWdFJXlW369LMLObavBl14sVHXug88pBdbWUYj2ascvkRotofXmlMnL5+p9PfjqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oZohjzSN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312537;
	bh=DeApma2uplQJunJNCRhPcjySG9AUPfPJgLBPhzTwBCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vg1U1pPmApw0a1dr4EOIu9CyD9Yy/twz4tDmm11LtMxBAAokAA8C7xGbxLhGL5cVm
	 9J0BGETfPph9cfFttOqTwh3jhzONV4BibpPZgSef9HOOuJosttZjCPtaijSpdLjNwq
	 Zb9raa2hzwKbkkd9IXr5b++Gpq/6zFPwwmkHgRWVd3wfYsuRsxcV7GkFAOxYsHQ1v8
	 E/uvgBjh7jLeWYdRhJ66imNHbMcFGSiPdisLLGOOQHX5IWiyWcwk3UReLNeyUiPx5V
	 FTgsSbbYLcCytKx10jf1OjHdqtmEvECeNgEuMVSrR7fwbAWMU250jeYjSr31XQYf58
	 u9d/DKHePFdbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40D85409DF;
	Sun, 18 Oct 2026 08:35:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EEDDD22B
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF55D40958
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCUpAzGRwXzH for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7A1D4091C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312529;
 b=BNes9ljR+JVK3yOQHwq7SdadFzxo1/Sy3hCa3Sl6zC50miC4mT45sz/HphW0kjqYQ2wA
 ELibTsl7LsQKoD+PNSJsVH5fSM4QEC1jI6euNNqmsnRE4Ut0IQMO3h9oUn2Tfv/+FkcD9
 u7A7qtv5+ADa1OJ+qKGDwngmxVIUGf7DSS8MrT1RzwW4MaINccNwRJwOgAbBMiXoC1QD8
 TcV7g9tApdZ0oK08mB2jJpItQ+6IPMlVjwglcVz/jsue+E4hoIK3TjypWpG3aSdZet+3v
 9l18eHaL9FMjTR09q+EeSQqcmhyY33flYDfLAmXgmtWd+t6qfkkqlD+OxsT9ud/YuhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312529;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=DeApma2uplQJunJNCRhPcjySG9AUPfPJgLBPhzTwBCE=;
 b=XOJRB1+hVxUV0DAyH42IQMnpbrXTvakgtHgnmIIwuMuGN5+ScwaDB0aTEx5Bj9wGHjE4
 C6vYfDzO8K+XxW7jMEZExzASdQN3TyDAAjoUBvi4avQ4ONoYFP6KEpiyC+kUATupLStOL
 ug5KqE79DVf628fuY7JVc/Ck3BpGiqtEaxHCfxVCri1uHf+taHWcUo1mLghyUirhRDSNU
 G4l9aejjuPTmHA4nxghQ7c3YrEt+tv4NEoppvJmQ057Djyvg7lcKGaAO83+OZFAJSFIE4
 uYm/MpbPkvQInxfs+mP7BhHtdJ2R17kBLfzvSWjEyZ4f165629d4aM/oQG2X5Y34F8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oZohjzSN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oZohjzSN
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7A1D4091C
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:28 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so8795365e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312526; x=1792917326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DeApma2uplQJunJNCRhPcjySG9AUPfPJgLBPhzTwBCE=;
 b=oZohjzSNdDlPxOH4+mPLS9dL1cxkbHTCntUUL/b9eZr7gL2m80a1MY4BKjyrQuXRzQ
 To6vdhzy0nAfhg49nkbABfyMtztyaDAUbFK/eiYqox8geuo94G9PGPT64vBfoZWMR49w
 OP6Ru0mwRgwvaZ+a8eN9xld1aF94CY4P6LvFYFT4R8m3+sawU4JyvM7bYJ38aB8uys3r
 zVSbKihrtRCJHxOy9OdmPzH8ojxeMt3E1ajreEaQZsIEVxZCg5ix6du26/+HGFiaqVgT
 GKjSxSdWclpPJ5kiCZD69NRMWe0sjYwu0vVr1x/tYjgJdAFFSye4YwECHNMy0q3QqbxD
 EN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312526; x=1792917326;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DeApma2uplQJunJNCRhPcjySG9AUPfPJgLBPhzTwBCE=;
 b=K1dH+qgMPLsOnRN452lVRXb5GawrQ/CxhAvRODo23VtzqkfXnHFWnjwHmfy/XSHUvt
 WeqNlacEBtcwx33QrMv5v6ULtCyUUdOZLng0Uwu8T6Kq13YsschYAvTMyPGy0G2ta7Y4
 7CIFHPdGHXJdU4S6n45xoi3LSmp+igWDDfVOotLVrye8xyWdVs85R0sm36OWs0ZNgktZ
 /55K7LFTjGWq8Ux24eb2o751ktcTEj4GGlxz/reT5hmDi7/oEHcUzyVRELK4JOh17tai
 sjHcoz1OZxadU5A2fpBGqcoJ6vIKCfaBsSZ/CLrOo8Lnsu22LsymZvkpp4NKnX3YvKyt
 POdA==
X-Gm-Message-State: AFq9FYJ9KO/ESrCM99e+Csp9uG07wDE5H7mQFCyHhmA33CzLZrn8t92W
 JuF/Vq5ZEOW2/3RqJlvAk1GqNwUsW2D1hXBrCgM2yHrIKv5Du6MZS2lUvc1xYxZG
X-Gm-Gg: AYBFou3cLH9gt0PwXGuU6vIN7LJCVJJ8RqNELkt6mnay4CCKt1G82hcmJXr2Qm8s/7U
 dz2aSDreJqB5vpZx5vsvqP/YyczPBGa+tOazRLeEDebz+GIlvZwXWzCwlwAqN/hfxdknz/hWYYy
 pBbj4l8DegKJwLCspUcJhgVQtYPolPLLWMlw1DEo+jpQ3ajI/l04wOJTMKf/QPaX8HAtpAOth7T
 fqix2o9VJhkeTa+8BvEcEmop93LZ+90BRu/qlKpzxp9mrwJg6A5MTabnKtkpA3LR8qhbbTZeK1N
 Ke1bCvE2ILQtdhtpcof4gvnT1xeIp16eiWsl+ET9qYNeOMn4Xe/N4WsN69u247bFXeX0+kgEjK5
 wcD9DjiTc3wlPUtX7yjd7OC3QgRNA110NCY+de9RvbFXrKy3dcMqfUzLqWaIkgTPV5p1pRsZtML
 N1iWtal2LA18mjEtyEDSsPlEJYOWB1kpbRx5CLZTzWtP9VyTnJAlMV+tAjsqdbgD7xAMGGQ3v6M
 FDpYwmLowbZ5YF91cEs/KwCub/QXa3xpD9SAOgaIyn6+eIiqVZoW7TSvuZ67dVPRAc8DxYXlxKU
 h23dWF3glwpIE2sTzPgqar5kFLBRtX8Toi/xd5uoYGJZHBv9LZWcxRxZ98E/cemjqCp8XsQmet1
 Cwxm+Q7xlgO1VhQ9HOyvLlsE=
X-Received: by 2002:a05:600c:4fce:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a1d75ac25cmr102165585e9.1.1792312526312; 
 Sun, 18 Oct 2026 01:35:26 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:25 -0700 (PDT)
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
Subject: [PATCH v2 04/14] powerpc: lib: Add 64-bit division to the private
 libgcc
Date: Sun, 18 Oct 2026 10:35:06 +0200
Message-ID: <20261018083516.49229-5-pepe.schlehofer@gmail.com>
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

On 32-bit PowerPC, GCC lowers '/' and '%' on unsigned 64-bit operands
to calls to __udivdi3() and __umoddi3(). U-Boot's private libgcc lacks
these routines, so turris_1x_sdcard fails to link with
CONFIG_USE_PRIVATE_LIBGCC=y:

  undefined reference to `__udivdi3'

Implement both with a copy of __div64_32() from lib/div64.c whose
divisor is widened to 64 bits. The copy keeps the private libgcc
independent of lib/, which not every xPL phase links.

Build the file without LTO, as ARM does for eabi_compat.o: LTO can
drop these functions before GCC generates the calls that need them.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v2:
- new patch

At -Os the two take 300 bytes, against 1036 and 992 bytes of
_udivdi3.o and _umoddi3.o in Debian's libgcc 14.2.
---
 arch/powerpc/lib/Makefile  |  3 +-
 arch/powerpc/lib/udivdi3.c | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/udivdi3.c

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 90f0e1e5fa9..23e62996701 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -6,7 +6,8 @@
 ## Build a couple of necessary functions into a private libgcc
 ## if the user asked for it
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o \
-				    crtsavres.o
+				    crtsavres.o udivdi3.o
+CFLAGS_REMOVE_udivdi3.o := $(LTO_CFLAGS)
 
 MINIMAL=
 
diff --git a/arch/powerpc/lib/udivdi3.c b/arch/powerpc/lib/udivdi3.c
new file mode 100644
index 00000000000..deb0b5d49e1
--- /dev/null
+++ b/arch/powerpc/lib/udivdi3.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 64-bit unsigned division and modulo for the private libgcc
+ *
+ * GCC calls __udivdi3() and __umoddi3() for '/' and '%' on unsigned 64-bit
+ * operands on 32-bit PowerPC. udivmod64() is __div64_32() from lib/div64.c
+ * with a 64-bit divisor: its shift-and-subtract loop already works on one,
+ * and the step that first divides the high word now only runs when the
+ * divisor fits into 32 bits. Like __div64_32(), the functions are not
+ * instrumented, as tracing code may divide. The source file copyrights are
+ * as follows:
+ *
+ *   Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
+ *
+ *   Based on former do_div() implementation from asm-parisc/div64.h:
+ *	Copyright (C) 1999 Hewlett-Packard Co
+ *	Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
+ */
+
+#include <linux/types.h>
+
+static notrace u64 udivmod64(u64 n, u64 base, u64 *rem)
+{
+	u64 b = base;
+	u64 res, d = 1;
+	u32 high = n >> 32;
+
+	/* Reduce the thing a bit first */
+	res = 0;
+	if (!(base >> 32) && high >= base) {
+		high /= (u32)base;
+		res = (u64)high << 32;
+		n -= (u64)(high * (u32)base) << 32;
+	}
+
+	while ((s64)b > 0 && b < n) {
+		b = b + b;
+		d = d + d;
+	}
+
+	do {
+		if (n >= b) {
+			n -= b;
+			res += d;
+		}
+		b >>= 1;
+		d >>= 1;
+	} while (d);
+
+	*rem = n;
+	return res;
+}
+
+/**
+ * __udivdi3() - divide two 64-bit unsigned integers
+ *
+ * @n:		dividend
+ * @d:		divisor
+ * Return:	quotient
+ */
+notrace u64 __udivdi3(u64 n, u64 d)
+{
+	u64 rem;
+
+	return udivmod64(n, d, &rem);
+}
+
+/**
+ * __umoddi3() - remainder of the division of two 64-bit unsigned integers
+ *
+ * @n:		dividend
+ * @d:		divisor
+ * Return:	remainder
+ */
+notrace u64 __umoddi3(u64 n, u64 d)
+{
+	u64 rem;
+
+	udivmod64(n, d, &rem);
+
+	return rem;
+}
-- 
2.54.0 (Apple Git-157)

