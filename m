Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CC606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KQ4TzmbI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtwvdPYn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7954B60D9C;
	Thu, 19 Nov 2026 13:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiWirWDQJWIG; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8EE7660D98
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095206;
	b=oQDp9lbBeqZzihyS7uMFU7y2AWjm+ORj1mF1H0Es0os7VZtlZvaBNaHaTugc8iDPw4BV
	 XmmQgJpJTlX1YfhoBApcQuU7jf4+iyRUDwqDF5O3HzVGF1GH6ucg9q1UkmIsRhGJpT82U
	 3npaaUSjhzNGtpQgqsO67Q6Dd+hIQGIxj0SJ6J88nyDmCTIWyeuEX9Xcj+YabFXC8J831
	 cxR/1H0jTCiys7UkhGNzE7kWlnth1DDXXcrS8RWDws5PF7ybQsYzQYSmY7/X6GFewnjdc
	 xBVaPNEIkKBCtJOsCILugS+UP+RarW+19LPnbY/FjSrClO6D2QKt35ViUMm4KJ4G2IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XDGb0kUIFNsFm85NXbqcnyavopIOvttAPRlrnlw0b/g=;
	b=ggFLWJdvzPbCgqD06pOt+EgFlnOwKbfJ2LSJL+cfng4oaEfylUsA2kYWPZjlg+8hQdTq
	 vRTCbTQaTdtUNh+56yoKSGNCN6AN9MYwJtYV/G1L6koqNI04WwGVHrqcAyCnvoOcgH2DN
	 G65Xpk/95/WP3UMRWApfCtTohKo0YsqtrlLiDMF9Gp/3ZUqu7aNIJk65lRp3PvAGkBqd6
	 m2w0LW6ElqVEZGlDi82+0UQlsAJ4eH+8/t9QvPZmwOSIIkoELN18x0A/B/IehXmRweV6l
	 zr2F9A6QOz0cH5j5gMIzdekyBZXYaGHDYyWChRm+UcICBhgUTiT8tjYRMcx2g/iuB1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtwvdPYn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095206;
	bh=XDGb0kUIFNsFm85NXbqcnyavopIOvttAPRlrnlw0b/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KQ4TzmbIsoG4PDIZkWKRmuMvyMYaymqadLIq92VJICmHm9rJvdE71Xm/FkdQcb3Yx
	 Gy+CEttWwke3erMoMkGQ+1mQ+kipM2x7F9YJcBnFVznwKAhted6RBQ9mBw1w8/1EhA
	 zPUr6K786XJEJBx1XbIQZA5i8MMEw2YH9LDnH4sGQNmmtDaWDFkzXJLJHrK/VOKjcu
	 /U22DwFzHKZKhozPna+qijrXLjmdS0O9DyH/dxmDFWimjxwzxqO/baAMOqAVGUuJ9/
	 Oavj2sYIedMiwJqvZB9evVkS/Ku+bu7wpDc+BZaGc6Q8wGr7jS5s6OIkLkJf9nb7iC
	 zTIk1f72VT63w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EE7660D98;
	Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F061B9F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D04D860D84
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcaA7Drr5XtQ for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8BD760ADF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QtwvdPYn
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8BD760ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso20192865e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095198; x=1795699998;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XDGb0kUIFNsFm85NXbqcnyavopIOvttAPRlrnlw0b/g=;
 b=QtwvdPYnuMcObKq7uo850fDOfuq79cJNJNMQTUI4zvv3jfE8yYXdAFnv/FyV1TscEZ
 x7UCzT6q0G/Vv8/SXILXN9Sln+bpXHhNgs91fEaHbjqKGCAZ/WRpdRLooTrMQTkhf/HW
 /YMCkbBNuNnB+bafFCyxoKpCV1nyg1XfvJMF4MbSItGE8PDKe+kq7QqtXeNWQNtsRnzH
 HAEa8YBBN+17IzTEyq87iu8h5p5BVSoJifD6VfXKqyDBtf2/JGJl55dbMCyHatrv1UAv
 KlMPItGHqHsrsE39GDOvBI05JXm3VVqoWWOQoT2ugJwupE76EAnzADX4Jbb/EFM44plM
 Gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095198; x=1795699998;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XDGb0kUIFNsFm85NXbqcnyavopIOvttAPRlrnlw0b/g=;
 b=gBeAl+wQyGIKaLVzKGp2fjiXLCNuEdiVO9qpQ5awnj971qfWeTTJuVstJOpmQrQoP0
 DuzoGOE0z/pm8ThNPascCGBoCc3sJzY+1FwsryMT/qeyVYjMzoONpS7vIlX0yFjlBEmm
 CuBDmrlfD8al+iteldfGtXNAmkYiKiViA50Y5ddqfSbUQK+C5+q23MPJtDAVoEcHR+3j
 85MDWjGPsS7hiaTV22W+WQq29IuQJJZ5BPttKs6cBYEaFJ4iSFWdJYOSv2rYKGTicWNX
 1BDLgpNZFYRTnhniR51Hk3p/0PFMPIVVq0+4lHJROv5JUZuiEQ9eD5QEfAeEx6Y1vGOi
 OadA==
X-Gm-Message-State: APuU4Z8s8qVcUqs4vZL9JUFKd1Sj2Nl7+iUYU+rqp1VvVTYlYJKAMJZE
 tTqnk81R3XuSuvS1tDsPIsG0uC4eQP+dIfFFCpyHZzRBcb3dgSuxgxlu2e8WhXzn
X-Gm-Gg: AYBFou3l1BSr6Ft8XXQ7sl5RLvpfetj5m6pIqh+zQr6a+CUwuV7VSk9R+UGesF23qCW
 racoqervSaILcPIl/utiiEeX3QHBEbf+hzihNWWaq3Sq6hckhbpDQTBdJFPvr6V32mHHi0PiBGl
 ls7+vlZrKhbjR9wZ/gc49PYWQhxe65XScclJ/lnJD9qs69l/cIDux+9Kp3J3TdYrAY0ZZrSXBPF
 aUlc+2M0H9KBwPxf+HqkaC29B/vYQShDvcSRZv2Y/q2fGfYlxUOQ0tzqP+vlNfvMTk4efIa26AH
 Q67VRJQEPlsF84WrnN+/aF5gnv9j6B7H4RTKISPV/x7X1wBW3xAgdJXI/MeOLRogfxHVGd1Urpl
 Hsz0X/A4EbZyKGbj7SmbBKDoJPycrFksM9eCP0QiKhRBAZG9xt50661Rb1w8C/sfx29ixUsDGtq
 ypRv81c4WbJpOqyX/kNnPJgLwjpBxTAPfJYUw5rARYRkvVzkDvAiH7FihzVb54LHChlerqKeDJu
 Zq76lB9JhqDWTQSxei0hMP/VWe6VroGM7AOpUyfYjkNi6c0nqdkhNMlLPM5NrjNm59yUHpuK6VW
 KL/sZIlq6OJ3F86xxBzFHx+MBo4pSsgx/wNo9glPpWypqbF/C+XmUrW10XFjGCsk3mkQCzsDApH
 e2HJ38GgB7g6inY8HkH6CqqvD/WSEskVkX4M7YXRzrEqv0kS8XFALXg1HGmi3lkOtIokdY4izrl
 3EUa3nWsy4BqmKdhvgOmKeGmpk4sE4V32tD0hUhJzIROjdfAkfXRMO
X-Received: by 2002:a05:600c:6092:b0:4bb:5f95:c014 with SMTP id
 5b1f17b1804b1-4bb7da1efc6mr109468595e9.19.1795095198109; 
 Thu, 19 Nov 2026 05:33:18 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:17 -0800 (PST)
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
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 04/14] powerpc: lib: Add 64-bit division to the private
 libgcc
Date: Thu, 19 Nov 2026 14:33:00 +0100
Message-ID: <20261119133310.22732-5-pepe.schlehofer@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v3:
- name lib/div64.c as the source of udivmod64() more clearly
- explain in the comment why the high word is only divided first when
  the divisor fits into 32 bits

Changes in v2:
- new patch

At -Os the two take 300 bytes, against 1036 and 992 bytes of
_udivdi3.o and _umoddi3.o in Debian's libgcc 14.2.
---
 arch/powerpc/lib/Makefile  |  3 +-
 arch/powerpc/lib/udivdi3.c | 85 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
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
index 00000000000..4b02c61bcba
--- /dev/null
+++ b/arch/powerpc/lib/udivdi3.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 64-bit unsigned division and modulo for the private libgcc
+ *
+ * GCC calls __udivdi3() and __umoddi3() for '/' and '%' on unsigned 64-bit
+ * operands on 32-bit PowerPC.
+ *
+ * udivmod64() is a copy of __div64_32() from lib/div64.c, changed to take a
+ * 64-bit divisor. Its shift-and-subtract loop already works with one. Like
+ * __div64_32(), the functions are not instrumented, as tracing code may
+ * divide. The copyright notices below are those of lib/div64.c.
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
+	/*
+	 * Divide the high word first, as __div64_32() does. This is a 32-bit
+	 * division, so it is only valid when the divisor fits into 32 bits.
+	 */
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

