Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CE6CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A75083D39;
	Tue, 18 Nov 2025 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="L6+j/fi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E526283C96; Tue, 18 Nov 2025 05:31:26 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE2F8398D
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 442AE10AECC; Tue, 18 Nov 2025 05:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763440284; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=R2EHAmTI+4AMTFBCS1+oMIiahruE3kIhvizH/EYugJo=;
 b=L6+j/fi72bYzooG9MR4m6QOaKbLrA2aVoGuU4afHaUdu/ufz+ZbwkxJAKEzZ869vjukT9a
 D4aw9VtZUxYyCRTh4nuiY+/oj0cc3uDv5rGWURX03KIVPf7SkR2qWtIRAe2MSKIn4PveAI
 +1rX/lb7Q0UDeNVJIb612SBzFhPzE9FN97Kgmu291NU88HdIHEjKit1Jzo3yyRrAxHCaol
 tEEh8pYC5e2lIZrRA8h4cz029zIxKvbbftqVkY+yXd5IMLJiL0dHEHJ2oNjvQNs50HdgeR
 i02HKmLqMuZrJ0VAhh5PLn2PWr2F54RzlX3body3vISnld15OAjtL+egAyRlQw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
Subject: [PATCH v3 3/6] lib: sm3: implement U-Boot parts
Date: Tue, 18 Nov 2025 05:30:39 +0100
Message-Id: <20251118043042.27726-4-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
References: <20251118043042.27726-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

add the U-Boot specific parts for the SM3 hash
implementation:

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v3:
New in version 3 as Ilias recommended to split linux
and U-boot changes.

 MAINTAINERS          |   1 +
 boot/Kconfig         |   1 +
 cmd/Kconfig          |  15 ++++++
 cmd/Makefile         |   1 +
 cmd/sm3sum.c         |  48 +++++++++++++++++
 common/hash.c        |  42 ++++++++++++++-
 include/u-boot/sm3.h |   8 +++
 lib/sm3.c            | 125 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 cmd/sm3sum.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e1d79206e50..dc62990a090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1689,6 +1689,7 @@ F:	test/lib/slre.c
 SM3
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
+F:	cmd/sm3sum.c
 F:	include/u-boot/sm3.h
 F:	lib/sm3.c
 
diff --git a/boot/Kconfig b/boot/Kconfig
index 85f4d468069..76cc628c9bd 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1042,6 +1042,7 @@ config MEASURED_BOOT
 	select SHA256
 	select SHA384
 	select SHA512
+	select SM3
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5b9c13d85e7..8e3efff2bee 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -264,6 +264,21 @@ config CMD_SBI
 	help
 	  Display information about the SBI implementation.
 
+config CMD_SM3SUM
+	bool "sm3sum"
+	select SM3
+	select HASH
+	help
+	  Compute SM3 checksum.
+	  add SM3 hash functionality
+
+config SM3SUM_VERIFY
+	bool "sm3sum -v"
+	depends on CMD_SM3SUM
+	help
+	  Add for the sm3sum command the -v option
+	  to verify data against an SM3 checksum.
+
 config CMD_SMBIOS
 	bool "smbios"
 	depends on SMBIOS
diff --git a/cmd/Makefile b/cmd/Makefile
index 25479907797..642042cfe00 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -177,6 +177,7 @@ obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_CMD_SETEXPR_FMT) += printf.o
 obj-$(CONFIG_CMD_SPI) += spi.o
 obj-$(CONFIG_CMD_STRINGS) += strings.o
+obj-$(CONFIG_CMD_SM3SUM) += sm3sum.o
 obj-$(CONFIG_CMD_SMBIOS) += smbios.o
 obj-$(CONFIG_CMD_SMC) += smccc.o
 obj-$(CONFIG_CMD_SYSBOOT) += sysboot.o
diff --git a/cmd/sm3sum.c b/cmd/sm3sum.c
new file mode 100644
index 00000000000..9044a322e22
--- /dev/null
+++ b/cmd/sm3sum.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2025
+ * Heiko Schocher, Nabladev Software Engineering, hs@nabladev.com
+ *
+ * based on code from cmd/md5sum.c
+ */
+
+#include <command.h>
+#include <env.h>
+#include <hash.h>
+
+static int do_sm3sum(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	int flags = HASH_FLAG_ENV;
+	int ac;
+	char *const *av;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	av = argv + 1;
+	ac = argc - 1;
+	if (IS_ENABLED(CONFIG_SM3SUM_VERIFY) && strcmp(*av, "-v") == 0) {
+		flags |= HASH_FLAG_VERIFY;
+		av++;
+		ac--;
+	}
+
+	return hash_command("sm3_256", flags, cmdtp, flag, ac, av);
+}
+
+#if IS_ENABLED(CONFIG_SM3SUM_VERIFY)
+U_BOOT_CMD(sm3sum, 5, 1, do_sm3sum,
+	   "compute SM3 message digest",
+	   "address count [[*]sum]\n"
+	   "  - compute SM3 message digest [save to sum]\n"
+	   "sm3sum -v address count [*]sum\n"
+	   "  - verify sm3sum of memory area"
+);
+#else
+U_BOOT_CMD(sm3sum, 4, 1, do_sm3sum,
+	   "compute SM3 message digest",
+	   "address count [[*]sum]\n"
+	   "  - compute SM3 message digest [save to sum]"
+);
+#endif /* IS_ENABLED(CONFIG_SM3SUM_VERIFY) */
diff --git a/common/hash.c b/common/hash.c
index 0c45992d5c7..71c4bef5826 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -34,6 +34,7 @@
 #include <u-boot/sha256.h>
 #include <u-boot/sha512.h>
 #include <u-boot/md5.h>
+#include <u-boot/sm3.h>
 
 static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
 {
@@ -143,6 +144,34 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+static int __maybe_unused hash_init_sm3(struct hash_algo *algo, void **ctxp)
+{
+	struct sm3_context *ctx = malloc(sizeof(struct sm3_context));
+
+	sm3_init(ctx);
+	*ctxp = ctx;
+	return 0;
+}
+
+static int __maybe_unused hash_update_sm3(struct hash_algo *algo, void *ctx,
+					  const void *buf, uint size,
+					  int is_last)
+{
+	sm3_update((struct sm3_context *)ctx, buf, size);
+	return 0;
+}
+
+static int __maybe_unused hash_finish_sm3(struct hash_algo *algo, void *ctx,
+					  void *dest_buf, int size)
+{
+	if (size < algo->digest_size)
+		return -1;
+
+	sm3_final((struct sm3_context *)ctx, dest_buf);
+	free(ctx);
+	return 0;
+}
+
 static int __maybe_unused hash_init_crc16_ccitt(struct hash_algo *algo,
 						void **ctxp)
 {
@@ -298,6 +327,17 @@ static struct hash_algo hash_algo[] = {
 #endif
 	},
 #endif
+#if CONFIG_IS_ENABLED(SM3)
+	{
+		.name		= "sm3_256",
+		.digest_size	= SM3_DIGEST_SIZE,
+		.chunk_size	= SM3_BLOCK_SIZE,
+		.hash_func_ws	= sm3_csum_wd,
+		.hash_init	= hash_init_sm3,
+		.hash_update	= hash_update_sm3,
+		.hash_finish	= hash_finish_sm3,
+	},
+#endif
 #if CONFIG_IS_ENABLED(CRC16)
 	{
 		.name		= "crc16-ccitt",
@@ -334,7 +374,7 @@ static struct hash_algo hash_algo[] = {
 #if CONFIG_IS_ENABLED(SHA256) || IS_ENABLED(CONFIG_CMD_SHA1SUM) || \
 	CONFIG_IS_ENABLED(CRC32_VERIFY) || IS_ENABLED(CONFIG_CMD_HASH) || \
 	CONFIG_IS_ENABLED(SHA384) || CONFIG_IS_ENABLED(SHA512) || \
-	IS_ENABLED(CONFIG_CMD_MD5SUM)
+	IS_ENABLED(CONFIG_CMD_MD5SUM) || CONFIG_IS_ENABLED(SM3)
 #define multi_hash()	1
 #else
 #define multi_hash()	0
diff --git a/include/u-boot/sm3.h b/include/u-boot/sm3.h
index de16684ca0a..b4ead96c776 100644
--- a/include/u-boot/sm3.h
+++ b/include/u-boot/sm3.h
@@ -24,4 +24,12 @@ struct sm3_context {
 	uint8_t buffer[SM3_BLOCK_SIZE];
 	int buflen;
 };
+
+void sm3_init(struct sm3_context *sctx);
+void sm3_update(struct sm3_context *sctx, const uint8_t *input, size_t ilen);
+void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE]);
+void sm3_hash(const uint8_t *input, size_t ilen, uint8_t output[SM3_DIGEST_SIZE]);
+
+void sm3_csum_wd(const unsigned char *input, uint32_t len,
+		 unsigned char *output, unsigned int chunk_sz);
 #endif
diff --git a/lib/sm3.c b/lib/sm3.c
index bb994d187ef..2a4e825481d 100644
--- a/lib/sm3.c
+++ b/lib/sm3.c
@@ -185,3 +185,128 @@ static inline void sm3_block(struct sm3_context *sctx,
 		data += SM3_BLOCK_SIZE;
 	}
 }
+
+void sm3_init(struct sm3_context *sctx)
+{
+	memset(sctx, 0, sizeof(*sctx));
+
+	/* Load initial values */
+	sctx->state[0] = SM3_IVA;
+	sctx->state[1] = SM3_IVB;
+	sctx->state[2] = SM3_IVC;
+	sctx->state[3] = SM3_IVD;
+	sctx->state[4] = SM3_IVE;
+	sctx->state[5] = SM3_IVF;
+	sctx->state[6] = SM3_IVG;
+	sctx->state[7] = SM3_IVH;
+	sctx->count = 0;
+}
+
+void sm3_update(struct sm3_context *sctx, const uint8_t *input, size_t ilen)
+{
+	unsigned int partial = sctx->count % SM3_BLOCK_SIZE;
+	u32 W[16];
+
+	sctx->count += ilen;
+
+	if ((partial + ilen) >= SM3_BLOCK_SIZE) {
+		int blocks;
+
+		if (partial) {
+			int p = SM3_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buffer + partial, input, p);
+			input += p;
+			ilen -= p;
+
+			sm3_block(sctx, sctx->buffer, 1, W);
+		}
+
+		blocks = ilen / SM3_BLOCK_SIZE;
+		ilen %= SM3_BLOCK_SIZE;
+
+		if (blocks) {
+			sm3_block(sctx, input, blocks, W);
+			input += blocks * SM3_BLOCK_SIZE;
+		}
+
+		memset(W, 0, sizeof(W));
+
+		partial = 0;
+	}
+	if (ilen)
+		memcpy(sctx->buffer + partial, input, ilen);
+}
+
+void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE])
+{
+	const int bit_offset = SM3_BLOCK_SIZE - sizeof(u64);
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)&output[0];
+	unsigned int partial = sctx->count % SM3_BLOCK_SIZE;
+	u32 W[16];
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);
+		partial = 0;
+
+		sm3_block(sctx, sctx->buffer, 1, W);
+	}
+
+	memset(sctx->buffer + partial, 0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	sm3_block(sctx, sctx->buffer, 1, W);
+
+	for (i = 0; i < 8; i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	/* Zeroize sensitive information. */
+	memset(W, 0, sizeof(W));
+	memset(sctx, 0, sizeof(*sctx));
+}
+
+/**
+ * sm3_hash - Calculate SM3 hash of input data
+ * @input: Input data
+ * @ilen: Input data length in bytes
+ * @output: Output buffer for hash (32 bytes)
+ */
+void sm3_hash(const uint8_t *input, size_t ilen, uint8_t output[SM3_DIGEST_SIZE])
+{
+	struct sm3_context sctx;
+
+	sm3_init(&sctx);
+	sm3_update(&sctx, input, ilen);
+	sm3_final(&sctx, output);
+}
+
+/**
+ * sm3_csum_wd - Calculate SM3 checksum on memory region using watchdog
+ * @addr: Starting address
+ * @len: Length in bytes
+ * @output: Output buffer for checksum (32 bytes)
+ * @flags: Flags for watchdog behavior
+ *
+ * This is the U-Boot API entry function for SM3 hash calculation
+ */
+void sm3_csum_wd(const unsigned char *input, uint32_t len,
+		 unsigned char *output, unsigned int chunk_sz)
+{
+	struct sm3_context ctx;
+	uint32_t chunk;
+
+	sm3_init(&ctx);
+
+	/* Process data in chunks, kicking watchdog between chunks */
+	while (len > 0) {
+		chunk = (len > chunk_sz) ? chunk_sz : len;
+		sm3_update(&ctx, input, chunk);
+		input += chunk;
+		len -= chunk;
+
+		schedule();
+	}
+	sm3_final(&ctx, output);
+}
-- 
2.20.1

