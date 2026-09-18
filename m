Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B2C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF0C60DB2;
	Fri, 18 Sep 2026 17:45:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0bXwvHKtx0MF; Fri, 18 Sep 2026 17:45:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C33D60D56
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789753541;
	b=b8ZNFjMbPX8jKawWMil4jKAK67AHISb84ZKAW4YoFqL/9VXuhZq08q4Z99Vwb4rqJf0X
	 OKOJ7sV21/ilAW985ep8QtyGcY8Uiz6nTCu6APZXMdnaJEL4vBsLqRZPQXPh909c68YLz
	 NDoQ7TVQuR5EAUY4ybOL+gtc9PjkDBKeo2sGb2clQ/PM0JwbHc+UHLrtEX/qjNeOJhlix
	 MI4A16BFaqVdj1sLk3M0ybFHm+WMe8iuAsrKNkpDAe9oWCqASXPsGpc71zSVtls0x+Z+A
	 aP+dkjRcl7Xqxf+4KiNxNMYjDtVKxKOBWTJNk1oRmGKWozRBK05f+mNAY1tL+0GW93Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789753541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LfnVBxV5suBLyaHEIU0q6eSUdOZ6oSGnUL9yyQLSBf0=;
	b=kVT6ZPx+MCYj9fkWO/tuUCq8x+LySUqE9kER8/0MMgDQcSNNVx2pwqD4ofslDP8cUsWQ
	 k11OBrrzW9LZzU+tX+vGSKUoiDxx9R6GNuhruZNbzQuTIBcJhCOLHZpAiTYiFIkOjRxz/
	 Pnvh008nBNNU+ZJfJYctnkFhn2kdyy8VyMvPh1q9JY9ZNnwK0AHNkKfzgLJ9GeS2RWZ7O
	 n9bGCYjCJf/NrZfAgBe98xtznIEcO9J/aXU9FXLTzAg1Lv1Ud6mLiy5lZdiw6138QK4yj
	 nAxvUh9qwV1Xk+UIrnKbO3wpjSW0fNs2K85gYOtjv3hFDLFHhzQwl+gynuDS9UPZSaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789753541;
	bh=LfnVBxV5suBLyaHEIU0q6eSUdOZ6oSGnUL9yyQLSBf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNtpJGykA1Ilc2SaXjQUirFptIENIXjc2IU1cz1FXJoQ7WTJhEeJxNyMc2FcyBrWw
	 ex1B3ck2j222/6aZrRwxYSk7GYYGEzRyHYde4NA9YqcJM7Yy0YyV6d3ggIPsKHAXmo
	 DObRjVuQb09vUqXrBLd0B0EW3/jDfr7Tn4v9LdTIdsaWVmI7iVWlybRXh8wcuXNLk6
	 L0+rzzZrntefS9HOBY7AcmmGPliYjsgd6SeDxPoTZjp8BCVe9rr54ew1Zvg3nlLI1p
	 FJlDYRgNAgylmMwJSim/1yV3l7dF2eF+QA7uOYe1wb4AaDydewJfYhRuNt4uzRC8JX
	 J/1mw/ey2gulw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C33D60D56;
	Fri, 18 Sep 2026 17:45:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33895237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30E984054B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhKia8AROAdY for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org ADEC1400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789752163;
 b=oivufQqLHwQE3DmRxoFjcmc88BgsAEC9//n7cQWyjNa+INGF1dSUcXfFqWVDh6GiM8qc
 ObmimG2fFOOG9uLUtz8BJS52MfLN8XMbKBg6QCYx6BPwGWBwIFAFYqLX51mDHRrMhmtnn
 LYDj2lAX3uYcyhZc6S8QXVUh0F0DlaG9isZii2NUU0x/iMjDCsOfmL+2D/l9XXILxUYlH
 265yS/+83cKQFTA8KXW5Ye+5rUA5IWyBdhH/Ei1k3bK6JMLNn1DpMxRv0vl+z0+pZwNow
 utMqi2yrzZ8kgJfobDag/92el+n9O4XLMVBilTjeE0VAI9sL7voO4B2KcjK80Usg7mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789752163;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LfnVBxV5suBLyaHEIU0q6eSUdOZ6oSGnUL9yyQLSBf0=;
 b=hNgmwz79lLl38iMg876rsVdovMyvVr6f/eijcGjqNFYQhv3I3qkiYsLJQlM9goYVpX1k
 nrPQdsNcFAZkkHA8hrIhXdDbkpY85Ooli+0rWiuxBhdWVBSB8KB8B1cqe7J4sVgs0HuyJ
 Dklr8pAVrHoO6Y1TA4/vvN5JOt3YgLjhVJF239wHGyAYmkeLw9PVNTqom7wOx2aPIKxC6
 sW6AQ1NTBF36vxYnCKH9HSmCWfFIbABmQybop3os7iH6SWl85SoixXgTDUDSciHgEVTbH
 4kW2vmmOOOGCBd3J+8GfkT7OCxGzXjH9MmYqj0E34bkG9lgLwfYGcLyUodFzoTMrAPw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=qHhJn6PI; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=BJFdTsag; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=qHhJn6PI; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=BJFdTsag
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADEC1400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789752094;
 x=1790356894; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=LfnVBxV5suBLyaHEIU0q6eSUdOZ6oSGnUL9yyQLSBf0=;
 b=qHhJn6PIq8R3/3pwPNXETIU0Mc3e6lgdN5DgV38v1V5jqvpdCkNza7PrBILmOAXzYMcatRxHb9hBk
 zI0ihoK2lUYKS+10qO+O32767jrJTunu/3You1YUnzdQXmsWMgvUNwJFQrvZkedNYbOTJA6AnmU325
 NkalaZjgstDNtHy8Bn8Hgn2VXrO1g52VdJgz9SWM+KVvCN+E4h7zxrKhAtXLtiKbFK2+rKXyacF+V9
 EREH6NMt+UCvz52G+3VxIzEr1b8Jx6z+88WoTJ0kUE5aDF/Tlmavxn2X4wPc2UShpWPL2n6JteQV6M
 FJX13iILmXI9xCjeIt5E8fNhVZwMJhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789752094;
 x=1790356894; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=LfnVBxV5suBLyaHEIU0q6eSUdOZ6oSGnUL9yyQLSBf0=;
 b=BJFdTsagf3eHE9Dsgn1hx5VZr0e/XloJfOH29za5GBlbNhlwfWuiykNFYCWgRLOdS9PSxAOa1v1k0
 x3jlJG4AA==
X-HalOne-ID: 6375f5bd-b385-11f1-aa3a-6d49bcc6f3f8
Received: from xps-13.www.tendawifi.com (unknown [41.251.77.168])
 by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 6375f5bd-b385-11f1-aa3a-6d49bcc6f3f8;
 Fri, 18 Sep 2026 17:21:32 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, mkorpershoek@kernel.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com,
 Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: [PATCH 1/4] crypto: add SHAKE128 and SHAKE256 support
Date: Fri, 18 Sep 2026 18:21:24 +0100
Message-ID: <20260918172127.66014-2-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 17:45:38 +0000
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

Add generic incremental and one-shot SHAKE interfaces backed by
Keccak-f[1600].

Adapt the implementation from the Linux SHA-3 library introduced by
commit 0593447248044ab609b43b947d0e198c887ac281. Retain its
provenance and licensing.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 include/crypto/sha3.h | 353 ++++++++++++++++++++++++++++++++++++++
 lib/crypto/sha3.c     | 382 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 735 insertions(+)
 create mode 100644 include/crypto/sha3.h
 create mode 100644 lib/crypto/sha3.c

diff --git a/include/crypto/sha3.h b/include/crypto/sha3.h
new file mode 100644
index 00000000000..70d6474e098
--- /dev/null
+++ b/include/crypto/sha3.h
@@ -0,0 +1,353 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common values for SHA-3 algorithms
+ *
+ * Based on Linux include/crypto/sha3.h
+ * at commit:
+ * https://git.kernel.org/linus/f1799d17285ca99243328cd92133a9f84ee3a593
+ *
+ * Ported to U-Boot by Ayoub Zaki <ayoub.zaki@embetrix.com>
+ */
+#ifndef __CRYPTO_SHA3_H__
+#define __CRYPTO_SHA3_H__
+
+#include <compiler.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#define SHA3_224_DIGEST_SIZE	(224 / 8)
+#define SHA3_224_BLOCK_SIZE	(200 - 2 * SHA3_224_DIGEST_SIZE)
+#define SHA3_224_EXPORT_SIZE	SHA3_STATE_SIZE + SHA3_224_BLOCK_SIZE + 1
+
+#define SHA3_256_DIGEST_SIZE	(256 / 8)
+#define SHA3_256_BLOCK_SIZE	(200 - 2 * SHA3_256_DIGEST_SIZE)
+#define SHA3_256_EXPORT_SIZE	SHA3_STATE_SIZE + SHA3_256_BLOCK_SIZE + 1
+
+#define SHA3_384_DIGEST_SIZE	(384 / 8)
+#define SHA3_384_BLOCK_SIZE	(200 - 2 * SHA3_384_DIGEST_SIZE)
+#define SHA3_384_EXPORT_SIZE	SHA3_STATE_SIZE + SHA3_384_BLOCK_SIZE + 1
+
+#define SHA3_512_DIGEST_SIZE	(512 / 8)
+#define SHA3_512_BLOCK_SIZE	(200 - 2 * SHA3_512_DIGEST_SIZE)
+#define SHA3_512_EXPORT_SIZE	SHA3_STATE_SIZE + SHA3_512_BLOCK_SIZE + 1
+
+/*
+ * SHAKE128 and SHAKE256 actually have variable output size, but this is used to
+ * calculate the block size (rate) analogously to the above.
+ */
+#define SHAKE128_DEFAULT_SIZE	(128 / 8)
+#define SHAKE128_BLOCK_SIZE	(200 - 2 * SHAKE128_DEFAULT_SIZE)
+#define SHAKE256_DEFAULT_SIZE	(256 / 8)
+#define SHAKE256_BLOCK_SIZE	(200 - 2 * SHAKE256_DEFAULT_SIZE)
+
+#define SHA3_STATE_SIZE		200
+
+/*
+ * State for the Keccak-f[1600] permutation: 25 64-bit words.
+ *
+ * We usually keep the state words as little-endian, to make absorbing and
+ * squeezing easier.  (It means that absorbing and squeezing can just treat the
+ * state as a byte array.)  The state words are converted to native-endian only
+ * temporarily by implementations of the permutation that need native-endian
+ * words.  Of course, that conversion is a no-op on little-endian machines.
+ */
+struct sha3_state {
+	union {
+		__le64 words[SHA3_STATE_SIZE / 8];
+		u8 bytes[SHA3_STATE_SIZE];
+
+		u64 native_words[SHA3_STATE_SIZE / 8]; /* see comment above */
+	};
+};
+
+/* Internal context, shared by the digests (SHA3-*) and the XOFs (SHAKE*) */
+struct __sha3_ctx {
+	struct sha3_state state;
+	u8 digest_size;		/* Digests only: the digest size in bytes */
+	u8 block_size;		/* Block size in bytes */
+	u8 absorb_offset;	/* Index of next state byte to absorb into */
+	u8 squeeze_offset;	/* XOFs only: index of next state byte to extract */
+};
+
+void __sha3_update(struct __sha3_ctx *ctx, const u8 *in, size_t in_len);
+
+/**
+ * struct sha3_ctx - Context for SHA3-224, SHA3-256, SHA3-384, or SHA3-512
+ * @ctx: private
+ */
+struct sha3_ctx {
+	struct __sha3_ctx ctx;
+};
+
+/**
+ * sha3_zeroize_ctx() - Zeroize a SHA-3 context
+ * @ctx: The context to zeroize
+ *
+ * This is already called by sha3_final().  Call this explicitly when abandoning
+ * a context without calling sha3_final().
+ */
+static inline void sha3_zeroize_ctx(struct sha3_ctx *ctx)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	barrier_data(ctx);
+}
+
+/**
+ * struct shake_ctx - Context for SHAKE128 or SHAKE256
+ * @ctx: private
+ */
+struct shake_ctx {
+	struct __sha3_ctx ctx;
+};
+
+/**
+ * shake_zeroize_ctx() - Zeroize a SHAKE context
+ * @ctx: The context to zeroize
+ *
+ * Call this after the last squeeze.
+ */
+static inline void shake_zeroize_ctx(struct shake_ctx *ctx)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	barrier_data(ctx);
+}
+
+/**
+ * sha3_224_init() - Initialize a context for SHA3-224
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-224 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_224_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_224_DIGEST_SIZE,
+		.ctx.block_size = SHA3_224_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_256_init() - Initialize a context for SHA3-256
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-256 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_256_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_256_DIGEST_SIZE,
+		.ctx.block_size = SHA3_256_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_384_init() - Initialize a context for SHA3-384
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-384 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_384_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_384_DIGEST_SIZE,
+		.ctx.block_size = SHA3_384_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_512_init() - Initialize a context for SHA3-512
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-512 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_512_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_512_DIGEST_SIZE,
+		.ctx.block_size = SHA3_512_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_update() - Update a SHA-3 digest context with input data
+ * @ctx: The context to update; must have been initialized
+ * @in: The input data
+ * @in_len: Length of the input data in bytes
+ *
+ * This can be called any number of times to add data to a SHA3-224, SHA3-256,
+ * SHA3-384, or SHA3-512 digest (depending on which init function was called).
+ *
+ * Context: Any context.
+ */
+static inline void sha3_update(struct sha3_ctx *ctx,
+			       const u8 *in, size_t in_len)
+{
+	__sha3_update(&ctx->ctx, in, in_len);
+}
+
+/**
+ * sha3_final() - Finish computing a SHA-3 message digest
+ * @ctx: The context to finalize; must have been initialized
+ * @out: (output) The resulting SHA3-224, SHA3-256, SHA3-384, or SHA3-512
+ *	 message digest, matching the init function that was called.  Note that
+ *	 the size differs for each one; see SHA3_*_DIGEST_SIZE.
+ *
+ * After finishing, this zeroizes @ctx.  So the caller does not need to do it.
+ *
+ * Context: Any context.
+ */
+void sha3_final(struct sha3_ctx *ctx, u8 *out);
+
+/**
+ * shake128_init() - Initialize a context for SHAKE128
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHAKE128 extendable-output function (XOF) computation.
+ *
+ * Context: Any context.
+ */
+static inline void shake128_init(struct shake_ctx *ctx)
+{
+	*ctx = (struct shake_ctx){
+		.ctx.block_size = SHAKE128_BLOCK_SIZE,
+	};
+}
+
+/**
+ * shake256_init() - Initialize a context for SHAKE256
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHAKE256 extendable-output function (XOF) computation.
+ *
+ * Context: Any context.
+ */
+static inline void shake256_init(struct shake_ctx *ctx)
+{
+	*ctx = (struct shake_ctx){
+		.ctx.block_size = SHAKE256_BLOCK_SIZE,
+	};
+}
+
+/**
+ * shake_update() - Update a SHAKE context with input data
+ * @ctx: The context to update; must have been initialized
+ * @in: The input data
+ * @in_len: Length of the input data in bytes
+ *
+ * This can be called any number of times to add more input data to SHAKE128 or
+ * SHAKE256.  This cannot be called after squeezing has begun.
+ *
+ * Context: Any context.
+ */
+static inline void shake_update(struct shake_ctx *ctx,
+				const u8 *in, size_t in_len)
+{
+	__sha3_update(&ctx->ctx, in, in_len);
+}
+
+/**
+ * shake_squeeze() - Generate output from SHAKE128 or SHAKE256
+ * @ctx: The context to squeeze; must have been initialized
+ * @out: Where to write the resulting output data
+ * @out_len: The amount of data to extract to @out in bytes
+ *
+ * This may be called multiple times.  A number of consecutive squeezes laid
+ * end-to-end will yield the same output as one big squeeze generating the same
+ * total amount of output.  More input cannot be provided after squeezing has
+ * begun.  After the last squeeze, call shake_zeroize_ctx().
+ *
+ * Context: Any context.
+ */
+void shake_squeeze(struct shake_ctx *ctx, u8 *out, size_t out_len);
+
+/**
+ * sha3_224() - Compute SHA3-224 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-224 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_224(const u8 *in, size_t in_len, u8 out[SHA3_224_DIGEST_SIZE]);
+
+/**
+ * sha3_256() - Compute SHA3-256 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-256 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_256(const u8 *in, size_t in_len, u8 out[SHA3_256_DIGEST_SIZE]);
+
+/**
+ * sha3_384() - Compute SHA3-384 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-384 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_384(const u8 *in, size_t in_len, u8 out[SHA3_384_DIGEST_SIZE]);
+
+/**
+ * sha3_512() - Compute SHA3-512 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-512 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_512(const u8 *in, size_t in_len, u8 out[SHA3_512_DIGEST_SIZE]);
+
+/**
+ * shake128() - Compute SHAKE128 in one shot
+ * @in: The input data to be used
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the output will be stored
+ * @out_len: Length of the output to produce in bytes
+ *
+ * Convenience function that computes SHAKE128 in one shot.  Use this instead of
+ * the incremental API if you're able to provide all the input at once as well
+ * as receive all the output at once.  All output lengths are supported.
+ *
+ * Context: Any context.
+ */
+void shake128(const u8 *in, size_t in_len, u8 *out, size_t out_len);
+
+/**
+ * shake256() - Compute SHAKE256 in one shot
+ * @in: The input data to be used
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the output will be stored
+ * @out_len: Length of the output to produce in bytes
+ *
+ * Convenience function that computes SHAKE256 in one shot.  Use this instead of
+ * the incremental API if you're able to provide all the input at once as well
+ * as receive all the output at once.  All output lengths are supported.
+ *
+ * Context: Any context.
+ */
+void shake256(const u8 *in, size_t in_len, u8 *out, size_t out_len);
+
+#endif /* __CRYPTO_SHA3_H__ */
diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
new file mode 100644
index 00000000000..5bd6732dcd5
--- /dev/null
+++ b/lib/crypto/sha3.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-3, as specified in
+ * https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
+ *
+ * SHA-3 code by Jeff Garzik <jeff@garzik.org>
+ *               Ard Biesheuvel <ard.biesheuvel@linaro.org>
+ *               David Howells <dhowells@redhat.com>
+ *
+ * Based on Linux lib/crypto/sha3.c
+ * at commit:
+ * https://git.kernel.org/linus/0354d3c1f1b8628e60eceb304b6d2ef75eea6f41
+ *
+ * Ported to U-Boot by Ayoub Zaki <ayoub.zaki@embetrix.com>
+ */
+
+#include <asm/unaligned.h>
+#include <compiler.h>
+#include <crypto/sha3.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+
+static void sha3_xor(u8 *dst, const u8 *src, size_t len)
+{
+	while (len--)
+		*dst++ ^= *src++;
+}
+
+static inline u64 sha3_rol64(u64 value, unsigned int shift)
+{
+	return (value << shift) | (value >> (64 - shift));
+}
+
+#define rol64(value, shift) sha3_rol64((value), (shift))
+
+/*
+ * On some 32-bit architectures, such as h8300, GCC ends up using over 1 KB of
+ * stack if the round calculation gets inlined into the loop in
+ * sha3_keccakf_generic().  On the other hand, on 64-bit architectures with
+ * plenty of [64-bit wide] general purpose registers, not inlining it severely
+ * hurts performance.  So let's use 64-bitness as a heuristic to decide whether
+ * to inline or not.
+ */
+#ifdef CONFIG_64BIT
+#define SHA3_INLINE inline
+#else
+#define SHA3_INLINE noinline
+#endif
+
+#define SHA3_KECCAK_ROUNDS 24
+
+static const u64 sha3_keccakf_rndc[SHA3_KECCAK_ROUNDS] = {
+	0x0000000000000001ULL, 0x0000000000008082ULL, 0x800000000000808aULL,
+	0x8000000080008000ULL, 0x000000000000808bULL, 0x0000000080000001ULL,
+	0x8000000080008081ULL, 0x8000000000008009ULL, 0x000000000000008aULL,
+	0x0000000000000088ULL, 0x0000000080008009ULL, 0x000000008000000aULL,
+	0x000000008000808bULL, 0x800000000000008bULL, 0x8000000000008089ULL,
+	0x8000000000008003ULL, 0x8000000000008002ULL, 0x8000000000000080ULL,
+	0x000000000000800aULL, 0x800000008000000aULL, 0x8000000080008081ULL,
+	0x8000000000008080ULL, 0x0000000080000001ULL, 0x8000000080008008ULL
+};
+
+/*
+ * Perform a single round of Keccak mixing.
+ */
+static SHA3_INLINE void sha3_keccakf_one_round_generic(u64 st[25], int round)
+{
+	u64 t[5], tt, bc[5];
+
+	/* Theta */
+	bc[0] = st[0] ^ st[5] ^ st[10] ^ st[15] ^ st[20];
+	bc[1] = st[1] ^ st[6] ^ st[11] ^ st[16] ^ st[21];
+	bc[2] = st[2] ^ st[7] ^ st[12] ^ st[17] ^ st[22];
+	bc[3] = st[3] ^ st[8] ^ st[13] ^ st[18] ^ st[23];
+	bc[4] = st[4] ^ st[9] ^ st[14] ^ st[19] ^ st[24];
+
+	t[0] = bc[4] ^ rol64(bc[1], 1);
+	t[1] = bc[0] ^ rol64(bc[2], 1);
+	t[2] = bc[1] ^ rol64(bc[3], 1);
+	t[3] = bc[2] ^ rol64(bc[4], 1);
+	t[4] = bc[3] ^ rol64(bc[0], 1);
+
+	st[0] ^= t[0];
+
+	/* Rho Pi */
+	tt = st[1];
+	st[1] = rol64(st[6] ^ t[1], 44);
+	st[6] = rol64(st[9] ^ t[4], 20);
+	st[9] = rol64(st[22] ^ t[2], 61);
+	st[22] = rol64(st[14] ^ t[4], 39);
+	st[14] = rol64(st[20] ^ t[0], 18);
+	st[20] = rol64(st[2] ^ t[2], 62);
+	st[2] = rol64(st[12] ^ t[2], 43);
+	st[12] = rol64(st[13] ^ t[3], 25);
+	st[13] = rol64(st[19] ^ t[4], 8);
+	st[19] = rol64(st[23] ^ t[3], 56);
+	st[23] = rol64(st[15] ^ t[0], 41);
+	st[15] = rol64(st[4] ^ t[4], 27);
+	st[4] = rol64(st[24] ^ t[4], 14);
+	st[24] = rol64(st[21] ^ t[1], 2);
+	st[21] = rol64(st[8] ^ t[3], 55);
+	st[8] = rol64(st[16] ^ t[1], 45);
+	st[16] = rol64(st[5] ^ t[0], 36);
+	st[5] = rol64(st[3] ^ t[3], 28);
+	st[3] = rol64(st[18] ^ t[3], 21);
+	st[18] = rol64(st[17] ^ t[2], 15);
+	st[17] = rol64(st[11] ^ t[1], 10);
+	st[11] = rol64(st[7] ^ t[2], 6);
+	st[7] = rol64(st[10] ^ t[0], 3);
+	st[10] = rol64(tt ^ t[1], 1);
+
+	/* Chi */
+	bc[0] = ~st[1] & st[2];
+	bc[1] = ~st[2] & st[3];
+	bc[2] = ~st[3] & st[4];
+	bc[3] = ~st[4] & st[0];
+	bc[4] = ~st[0] & st[1];
+	st[0] ^= bc[0];
+	st[1] ^= bc[1];
+	st[2] ^= bc[2];
+	st[3] ^= bc[3];
+	st[4] ^= bc[4];
+
+	bc[0] = ~st[6] & st[7];
+	bc[1] = ~st[7] & st[8];
+	bc[2] = ~st[8] & st[9];
+	bc[3] = ~st[9] & st[5];
+	bc[4] = ~st[5] & st[6];
+	st[5] ^= bc[0];
+	st[6] ^= bc[1];
+	st[7] ^= bc[2];
+	st[8] ^= bc[3];
+	st[9] ^= bc[4];
+
+	bc[0] = ~st[11] & st[12];
+	bc[1] = ~st[12] & st[13];
+	bc[2] = ~st[13] & st[14];
+	bc[3] = ~st[14] & st[10];
+	bc[4] = ~st[10] & st[11];
+	st[10] ^= bc[0];
+	st[11] ^= bc[1];
+	st[12] ^= bc[2];
+	st[13] ^= bc[3];
+	st[14] ^= bc[4];
+
+	bc[0] = ~st[16] & st[17];
+	bc[1] = ~st[17] & st[18];
+	bc[2] = ~st[18] & st[19];
+	bc[3] = ~st[19] & st[15];
+	bc[4] = ~st[15] & st[16];
+	st[15] ^= bc[0];
+	st[16] ^= bc[1];
+	st[17] ^= bc[2];
+	st[18] ^= bc[3];
+	st[19] ^= bc[4];
+
+	bc[0] = ~st[21] & st[22];
+	bc[1] = ~st[22] & st[23];
+	bc[2] = ~st[23] & st[24];
+	bc[3] = ~st[24] & st[20];
+	bc[4] = ~st[20] & st[21];
+	st[20] ^= bc[0];
+	st[21] ^= bc[1];
+	st[22] ^= bc[2];
+	st[23] ^= bc[3];
+	st[24] ^= bc[4];
+
+	/* Iota */
+	st[0] ^= sha3_keccakf_rndc[round];
+}
+
+/* Generic implementation of the Keccak-f[1600] permutation */
+static void sha3_keccakf_generic(struct sha3_state *state)
+{
+	/*
+	 * Temporarily convert the state words from little-endian to native-
+	 * endian so that they can be operated on.  Note that on little-endian
+	 * machines this conversion is a no-op and is optimized out.
+	 */
+
+	for (int i = 0; i < ARRAY_SIZE(state->words); i++)
+		state->native_words[i] = le64_to_cpu(state->words[i]);
+
+	for (int round = 0; round < SHA3_KECCAK_ROUNDS; round++)
+		sha3_keccakf_one_round_generic(state->native_words, round);
+
+	for (int i = 0; i < ARRAY_SIZE(state->words); i++)
+		state->words[i] = cpu_to_le64(state->native_words[i]);
+}
+
+/*
+ * Generic implementation of absorbing the given nonzero number of full blocks
+ * into the sponge function Keccak[r=8*block_size, c=1600-8*block_size].
+ */
+static void __maybe_unused
+sha3_absorb_blocks_generic(struct sha3_state *state, const u8 *data,
+			   size_t nblocks, size_t block_size)
+{
+	do {
+		for (size_t i = 0; i < block_size; i += 8)
+			state->words[i / 8] ^= get_unaligned((__le64 *)&data[i]);
+		sha3_keccakf_generic(state);
+		data += block_size;
+	} while (--nblocks);
+}
+
+#define sha3_keccakf		sha3_keccakf_generic
+#define sha3_absorb_blocks	sha3_absorb_blocks_generic
+
+void __sha3_update(struct __sha3_ctx *ctx, const u8 *in, size_t in_len)
+{
+	const size_t block_size = ctx->block_size;
+	size_t absorb_offset = ctx->absorb_offset;
+
+	/* Warn if squeezing has already begun. */
+	if (absorb_offset >= block_size)
+		return;
+
+	if (absorb_offset && absorb_offset + in_len >= block_size) {
+		sha3_xor(&ctx->state.bytes[absorb_offset], in,
+			 block_size - absorb_offset);
+		in += block_size - absorb_offset;
+		in_len -= block_size - absorb_offset;
+		sha3_keccakf(&ctx->state);
+		absorb_offset = 0;
+	}
+
+	if (in_len >= block_size) {
+		size_t nblocks = in_len / block_size;
+
+		sha3_absorb_blocks(&ctx->state, in, nblocks, block_size);
+		in += nblocks * block_size;
+		in_len -= nblocks * block_size;
+	}
+
+	if (in_len) {
+		sha3_xor(&ctx->state.bytes[absorb_offset], in, in_len);
+		absorb_offset += in_len;
+	}
+	ctx->absorb_offset = absorb_offset;
+}
+
+void sha3_final(struct sha3_ctx *sha3_ctx, u8 *out)
+{
+	struct __sha3_ctx *ctx = &sha3_ctx->ctx;
+
+	ctx->state.bytes[ctx->absorb_offset] ^= 0x06;
+	ctx->state.bytes[ctx->block_size - 1] ^= 0x80;
+	sha3_keccakf(&ctx->state);
+	memcpy(out, ctx->state.bytes, ctx->digest_size);
+	sha3_zeroize_ctx(sha3_ctx);
+}
+
+void shake_squeeze(struct shake_ctx *shake_ctx, u8 *out, size_t out_len)
+{
+	struct __sha3_ctx *ctx = &shake_ctx->ctx;
+	const size_t block_size = ctx->block_size;
+	size_t squeeze_offset = ctx->squeeze_offset;
+
+	if (ctx->absorb_offset < block_size) {
+		/* First squeeze: */
+
+		/* Add the domain separation suffix and padding. */
+		ctx->state.bytes[ctx->absorb_offset] ^= 0x1f;
+		ctx->state.bytes[block_size - 1] ^= 0x80;
+
+		/* Indicate that squeezing has begun. */
+		ctx->absorb_offset = block_size;
+
+		/*
+		 * Indicate that no output is pending yet, i.e. sha3_keccakf()
+		 * will need to be called before the first copy.
+		 */
+		squeeze_offset = block_size;
+	}
+	while (out_len) {
+		if (squeeze_offset == block_size) {
+			sha3_keccakf(&ctx->state);
+			squeeze_offset = 0;
+		}
+		size_t copy = min(out_len, block_size - squeeze_offset);
+
+		memcpy(out, &ctx->state.bytes[squeeze_offset], copy);
+		out += copy;
+		out_len -= copy;
+		squeeze_offset += copy;
+	}
+	ctx->squeeze_offset = squeeze_offset;
+}
+
+#ifndef sha3_224_arch
+static inline bool sha3_224_arch(const u8 *in, size_t in_len,
+				 u8 out[SHA3_224_DIGEST_SIZE])
+{
+	return false;
+}
+#endif
+#ifndef sha3_256_arch
+static inline bool sha3_256_arch(const u8 *in, size_t in_len,
+				 u8 out[SHA3_256_DIGEST_SIZE])
+{
+	return false;
+}
+#endif
+#ifndef sha3_384_arch
+static inline bool sha3_384_arch(const u8 *in, size_t in_len,
+				 u8 out[SHA3_384_DIGEST_SIZE])
+{
+	return false;
+}
+#endif
+#ifndef sha3_512_arch
+static inline bool sha3_512_arch(const u8 *in, size_t in_len,
+				 u8 out[SHA3_512_DIGEST_SIZE])
+{
+	return false;
+}
+#endif
+
+void sha3_224(const u8 *in, size_t in_len, u8 out[SHA3_224_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	if (sha3_224_arch(in, in_len, out))
+		return;
+	sha3_224_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+
+void sha3_256(const u8 *in, size_t in_len, u8 out[SHA3_256_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	if (sha3_256_arch(in, in_len, out))
+		return;
+	sha3_256_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+
+void sha3_384(const u8 *in, size_t in_len, u8 out[SHA3_384_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	if (sha3_384_arch(in, in_len, out))
+		return;
+	sha3_384_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+
+void sha3_512(const u8 *in, size_t in_len, u8 out[SHA3_512_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	if (sha3_512_arch(in, in_len, out))
+		return;
+	sha3_512_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+
+void shake128(const u8 *in, size_t in_len, u8 *out, size_t out_len)
+{
+	struct shake_ctx ctx;
+
+	shake128_init(&ctx);
+	shake_update(&ctx, in, in_len);
+	shake_squeeze(&ctx, out, out_len);
+	shake_zeroize_ctx(&ctx);
+}
+
+void shake256(const u8 *in, size_t in_len, u8 *out, size_t out_len)
+{
+	struct shake_ctx ctx;
+
+	shake256_init(&ctx);
+	shake_update(&ctx, in, in_len);
+	shake_squeeze(&ctx, out, out_len);
+	shake_zeroize_ctx(&ctx);
+}
-- 
2.43.0

