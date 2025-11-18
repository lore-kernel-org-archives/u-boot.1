Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B4CCED240
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 04:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F096583C6E;
	Tue, 18 Nov 2025 05:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EdeBtm+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA14083C6E; Tue, 18 Nov 2025 05:31:23 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0008398D
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BCCCC108767; Tue, 18 Nov 2025 05:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763440280;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6SlJHrSID+NfnI04B9fr1kcxO2auHAXoTWMAalp2oCM=;
 b=EdeBtm+NRH3Mb7weIlyetJReQD4SQJ285Eu0vA6P6tgo/5LJrF6BzKW4zzzu/k/ulDPTqk
 MAlTHL+zhG+06hxjIz+oz0fQ71PeoOgaVsal7Fx41VZorCl1HxEqGzlCHwNe5V3u7vkBbw
 1EuWIEj9BEiJBXEAZG+kDQsFBeOeGGXVlrPG54ugenSHyyheolRG6Jhx0A6B7pIhGT6KJ/
 1oMZeeoRkZvd+otMzN7G0eOoFfSbzBPV3uYB9+kn3WMC/xs0/wQ4odVn9k5F2P1IPiR+7x
 it4TQ1PNiubqvIzONLg48k5Oc0hTH4aXarpUnTwZt6MjZv54Xg9FBUvCj19bFQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH v3 2/6] lib: import sm3 256 hash parts from linux
Date: Tue, 18 Nov 2025 05:30:38 +0100
Message-Id: <20251118043042.27726-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
References: <20251118043042.27726-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Implement SM3_256 Hash algorithm, based on
linux commit f83a4f2a4d8c: ("Merge tag 'erofs-for-6.17-rc6-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs")

Therefore add the needed parts from linux.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
This patch drops a lot of checkpatch warnings, ignored them
as tried to stay as close as possible with linux code.

Changes in v3:
add comments from Ilias
- use sizeof(*sctx) instead of sizeof(struct sm3_context)
- use output[] instead of output[SM3_DIGEST_SIZE] comment from Ilias
  This leaded to CI error:
  +lib/sm3.c:241:50: error: argument 2 of type ‘uint8_t[]’ {aka ‘unsigned char[]’} with mismatched bound [-Werror=array-parameter=]
  +  241 | void sm3_final(struct sm3_context *sctx, uint8_t output[])
  +      |                                          ~~~~~~~~^~~~~~~~
  see:
  https://dev.azure.com/hs0298/hs/_build/results?buildId=192&view=logs&j=182673a4-17b9-5c0c-69ad-98f742450579&t=34b689f8-3e29-5ffe-50ea-32bfe99f47c7&l=334
  so made this change back to v2 state of the series
- seperate linux and U-Boot parts into 2 commits

Changes in v2:
add sm3_hash to header file, so we can use it.

 MAINTAINERS          |   6 ++
 include/u-boot/sm3.h |  27 +++++++
 lib/Kconfig          |   7 ++
 lib/Makefile         |   1 +
 lib/sm3.c            | 187 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 include/u-boot/sm3.h
 create mode 100644 lib/sm3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60772a494a3..e1d79206e50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1686,6 +1686,12 @@ F:	include/slre.h
 F:	lib/slre.c
 F:	test/lib/slre.c
 
+SM3
+M:	Heiko Schocher <hs@nabladev.com>
+S:	Maintained
+F:	include/u-boot/sm3.h
+F:	lib/sm3.c
+
 SMCCC TRNG
 M:	Etienne Carriere <etienne.carriere@linaro.org>
 S:	Maintained
diff --git a/include/u-boot/sm3.h b/include/u-boot/sm3.h
new file mode 100644
index 00000000000..de16684ca0a
--- /dev/null
+++ b/include/u-boot/sm3.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _SM3_H
+#define _SM3_H
+
+#define SM3_DIGEST_SIZE	32	/* 256 bits */
+#define SM3_BLOCK_SIZE	64	/* 512 bits */
+#define SM3_PAD_UNIT	56	/* 448 bits */
+
+#define SM3_T1		0x79CC4519
+#define SM3_T2		0x7A879D8A
+
+#define SM3_IVA		0x7380166f
+#define SM3_IVB		0x4914b2b9
+#define SM3_IVC		0x172442d7
+#define SM3_IVD		0xda8a0600
+#define SM3_IVE		0xa96f30bc
+#define SM3_IVF		0x163138aa
+#define SM3_IVG		0xe38dee4d
+#define SM3_IVH		0xb0fb0e4e
+
+struct sm3_context {
+	uint32_t state[SM3_DIGEST_SIZE / 4];
+	uint64_t count; /* Message length in bits */
+	uint8_t buffer[SM3_BLOCK_SIZE];
+	int buflen;
+};
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index f5c1731f456..fdfe0bd5042 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -606,6 +606,13 @@ config SHA384
 	  The SHA384 algorithm produces a 384-bit (48-byte) hash value
 	  (digest).
 
+config SM3
+	bool "Enable SM3 support"
+	help
+	  This option enables support of hashing using
+	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012, ISO/IEC 10118-3)
+	  The hash is calculated in software.
+
 config SHA_HW_ACCEL
 	bool "Enable hardware acceleration for SHA hash functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 07702cef7e7..70667f3728c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_$(PHASE_)SHA1_LEGACY) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256) += sha256_common.o
 obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_LEGACY) += sha512.o
+obj-$(CONFIG_$(PHASE_)SM3) += sm3.o
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
diff --git a/lib/sm3.c b/lib/sm3.c
new file mode 100644
index 00000000000..bb994d187ef
--- /dev/null
+++ b/lib/sm3.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SM3_256 Hash Algorithm Implementation for U-Boot
+ * based on linux implementation:
+ *
+ * f83a4f2a4d8c
+ *  Merge tag 'erofs-for-6.17-rc6-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
+ *
+ * SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and described
+ * at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
+ *
+ * Copyright (c) 2025 Heiko Schocher <hs@nabladev.com>
+ */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <asm/unaligned.h>
+#include <linux/bitops.h>
+
+#include <u-boot/sm3.h>
+#ifndef USE_HOSTCC
+#include <u-boot/schedule.h>
+#endif
+
+static const u32 K[64] = {
+	0x79cc4519, 0xf3988a32, 0xe7311465, 0xce6228cb,
+	0x9cc45197, 0x3988a32f, 0x7311465e, 0xe6228cbc,
+	0xcc451979, 0x988a32f3, 0x311465e7, 0x6228cbce,
+	0xc451979c, 0x88a32f39, 0x11465e73, 0x228cbce6,
+	0x9d8a7a87, 0x3b14f50f, 0x7629ea1e, 0xec53d43c,
+	0xd8a7a879, 0xb14f50f3, 0x629ea1e7, 0xc53d43ce,
+	0x8a7a879d, 0x14f50f3b, 0x29ea1e76, 0x53d43cec,
+	0xa7a879d8, 0x4f50f3b1, 0x9ea1e762, 0x3d43cec5,
+	0x7a879d8a, 0xf50f3b14, 0xea1e7629, 0xd43cec53,
+	0xa879d8a7, 0x50f3b14f, 0xa1e7629e, 0x43cec53d,
+	0x879d8a7a, 0x0f3b14f5, 0x1e7629ea, 0x3cec53d4,
+	0x79d8a7a8, 0xf3b14f50, 0xe7629ea1, 0xcec53d43,
+	0x9d8a7a87, 0x3b14f50f, 0x7629ea1e, 0xec53d43c,
+	0xd8a7a879, 0xb14f50f3, 0x629ea1e7, 0xc53d43ce,
+	0x8a7a879d, 0x14f50f3b, 0x29ea1e76, 0x53d43cec,
+	0xa7a879d8, 0x4f50f3b1, 0x9ea1e762, 0x3d43cec5
+};
+
+/*
+ * Transform the message X which consists of 16 32-bit-words. See
+ * GM/T 004-2012 for details.
+ */
+#define R(i, a, b, c, d, e, f, g, h, t, w1, w2)			\
+	do {							\
+		ss1 = rol32((rol32((a), 12) + (e) + (t)), 7);	\
+		ss2 = ss1 ^ rol32((a), 12);			\
+		d += FF ## i(a, b, c) + ss2 + ((w1) ^ (w2));	\
+		h += GG ## i(e, f, g) + ss1 + (w1);		\
+		b = rol32((b), 9);				\
+		f = rol32((f), 19);				\
+		h = P0((h));					\
+	} while (0)
+
+#define R1(a, b, c, d, e, f, g, h, t, w1, w2) \
+	R(1, a, b, c, d, e, f, g, h, t, w1, w2)
+#define R2(a, b, c, d, e, f, g, h, t, w1, w2) \
+	R(2, a, b, c, d, e, f, g, h, t, w1, w2)
+
+#define FF1(x, y, z)  (x ^ y ^ z)
+#define FF2(x, y, z)  ((x & y) | (x & z) | (y & z))
+
+#define GG1(x, y, z)  FF1(x, y, z)
+#define GG2(x, y, z)  ((x & y) | (~x & z))
+
+/* Message expansion */
+#define P0(x) ((x) ^ rol32((x), 9) ^ rol32((x), 17))
+#define P1(x) ((x) ^ rol32((x), 15) ^ rol32((x), 23))
+#define I(i)  (W[i] = get_unaligned_be32(data + i * 4))
+#define W1(i) (W[i & 0x0f])
+#define W2(i) (W[i & 0x0f] =				\
+		P1(W[i & 0x0f]				\
+			^ W[(i-9) & 0x0f]		\
+			^ rol32(W[(i-3) & 0x0f], 15))	\
+		^ rol32(W[(i-13) & 0x0f], 7)		\
+		^ W[(i-6) & 0x0f])
+
+static void sm3_transform(struct sm3_context *sctx, u8 const *data, u32 W[16])
+{
+	u32 a, b, c, d, e, f, g, h, ss1, ss2;
+
+	a = sctx->state[0];
+	b = sctx->state[1];
+	c = sctx->state[2];
+	d = sctx->state[3];
+	e = sctx->state[4];
+	f = sctx->state[5];
+	g = sctx->state[6];
+	h = sctx->state[7];
+
+	R1(a, b, c, d, e, f, g, h, K[0], I(0), I(4));
+	R1(d, a, b, c, h, e, f, g, K[1], I(1), I(5));
+	R1(c, d, a, b, g, h, e, f, K[2], I(2), I(6));
+	R1(b, c, d, a, f, g, h, e, K[3], I(3), I(7));
+	R1(a, b, c, d, e, f, g, h, K[4], W1(4), I(8));
+	R1(d, a, b, c, h, e, f, g, K[5], W1(5), I(9));
+	R1(c, d, a, b, g, h, e, f, K[6], W1(6), I(10));
+	R1(b, c, d, a, f, g, h, e, K[7], W1(7), I(11));
+	R1(a, b, c, d, e, f, g, h, K[8], W1(8), I(12));
+	R1(d, a, b, c, h, e, f, g, K[9], W1(9), I(13));
+	R1(c, d, a, b, g, h, e, f, K[10], W1(10), I(14));
+	R1(b, c, d, a, f, g, h, e, K[11], W1(11), I(15));
+	R1(a, b, c, d, e, f, g, h, K[12], W1(12), W2(16));
+	R1(d, a, b, c, h, e, f, g, K[13], W1(13), W2(17));
+	R1(c, d, a, b, g, h, e, f, K[14], W1(14), W2(18));
+	R1(b, c, d, a, f, g, h, e, K[15], W1(15), W2(19));
+
+	R2(a, b, c, d, e, f, g, h, K[16], W1(16), W2(20));
+	R2(d, a, b, c, h, e, f, g, K[17], W1(17), W2(21));
+	R2(c, d, a, b, g, h, e, f, K[18], W1(18), W2(22));
+	R2(b, c, d, a, f, g, h, e, K[19], W1(19), W2(23));
+	R2(a, b, c, d, e, f, g, h, K[20], W1(20), W2(24));
+	R2(d, a, b, c, h, e, f, g, K[21], W1(21), W2(25));
+	R2(c, d, a, b, g, h, e, f, K[22], W1(22), W2(26));
+	R2(b, c, d, a, f, g, h, e, K[23], W1(23), W2(27));
+	R2(a, b, c, d, e, f, g, h, K[24], W1(24), W2(28));
+	R2(d, a, b, c, h, e, f, g, K[25], W1(25), W2(29));
+	R2(c, d, a, b, g, h, e, f, K[26], W1(26), W2(30));
+	R2(b, c, d, a, f, g, h, e, K[27], W1(27), W2(31));
+	R2(a, b, c, d, e, f, g, h, K[28], W1(28), W2(32));
+	R2(d, a, b, c, h, e, f, g, K[29], W1(29), W2(33));
+	R2(c, d, a, b, g, h, e, f, K[30], W1(30), W2(34));
+	R2(b, c, d, a, f, g, h, e, K[31], W1(31), W2(35));
+
+	R2(a, b, c, d, e, f, g, h, K[32], W1(32), W2(36));
+	R2(d, a, b, c, h, e, f, g, K[33], W1(33), W2(37));
+	R2(c, d, a, b, g, h, e, f, K[34], W1(34), W2(38));
+	R2(b, c, d, a, f, g, h, e, K[35], W1(35), W2(39));
+	R2(a, b, c, d, e, f, g, h, K[36], W1(36), W2(40));
+	R2(d, a, b, c, h, e, f, g, K[37], W1(37), W2(41));
+	R2(c, d, a, b, g, h, e, f, K[38], W1(38), W2(42));
+	R2(b, c, d, a, f, g, h, e, K[39], W1(39), W2(43));
+	R2(a, b, c, d, e, f, g, h, K[40], W1(40), W2(44));
+	R2(d, a, b, c, h, e, f, g, K[41], W1(41), W2(45));
+	R2(c, d, a, b, g, h, e, f, K[42], W1(42), W2(46));
+	R2(b, c, d, a, f, g, h, e, K[43], W1(43), W2(47));
+	R2(a, b, c, d, e, f, g, h, K[44], W1(44), W2(48));
+	R2(d, a, b, c, h, e, f, g, K[45], W1(45), W2(49));
+	R2(c, d, a, b, g, h, e, f, K[46], W1(46), W2(50));
+	R2(b, c, d, a, f, g, h, e, K[47], W1(47), W2(51));
+
+	R2(a, b, c, d, e, f, g, h, K[48], W1(48), W2(52));
+	R2(d, a, b, c, h, e, f, g, K[49], W1(49), W2(53));
+	R2(c, d, a, b, g, h, e, f, K[50], W1(50), W2(54));
+	R2(b, c, d, a, f, g, h, e, K[51], W1(51), W2(55));
+	R2(a, b, c, d, e, f, g, h, K[52], W1(52), W2(56));
+	R2(d, a, b, c, h, e, f, g, K[53], W1(53), W2(57));
+	R2(c, d, a, b, g, h, e, f, K[54], W1(54), W2(58));
+	R2(b, c, d, a, f, g, h, e, K[55], W1(55), W2(59));
+	R2(a, b, c, d, e, f, g, h, K[56], W1(56), W2(60));
+	R2(d, a, b, c, h, e, f, g, K[57], W1(57), W2(61));
+	R2(c, d, a, b, g, h, e, f, K[58], W1(58), W2(62));
+	R2(b, c, d, a, f, g, h, e, K[59], W1(59), W2(63));
+	R2(a, b, c, d, e, f, g, h, K[60], W1(60), W2(64));
+	R2(d, a, b, c, h, e, f, g, K[61], W1(61), W2(65));
+	R2(c, d, a, b, g, h, e, f, K[62], W1(62), W2(66));
+	R2(b, c, d, a, f, g, h, e, K[63], W1(63), W2(67));
+
+	sctx->state[0] ^= a;
+	sctx->state[1] ^= b;
+	sctx->state[2] ^= c;
+	sctx->state[3] ^= d;
+	sctx->state[4] ^= e;
+	sctx->state[5] ^= f;
+	sctx->state[6] ^= g;
+	sctx->state[7] ^= h;
+}
+#undef R
+#undef R1
+#undef R2
+#undef I
+#undef W1
+#undef W2
+
+static inline void sm3_block(struct sm3_context *sctx,
+		u8 const *data, int blocks, u32 W[16])
+{
+	while (blocks--) {
+		sm3_transform(sctx, data, W);
+		data += SM3_BLOCK_SIZE;
+	}
+}
-- 
2.20.1

