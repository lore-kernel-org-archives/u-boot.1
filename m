Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43000C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 03:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1E6B607AB;
	Tue, 21 Jul 2026 03:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhP_YLsKoPaU; Tue, 21 Jul 2026 03:11:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFF08607AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784603512;
	bh=IKQIMvizla518/vNeUmZa/6+7+mDny7Az5yD9/hOFL8=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HbTeGd09O5iUFoa/JtS1sWLb79cRldWAvWmYhVCoWkAdez327//ffcPlsrsQ5Z5lM
	 V2La4DJRJKSecrYRhEuFm9RSdA3y7swMMeQnJHQf7bcVtL0WuSgANuejJpL5P6zhEp
	 U0V5bEGDJzCaPTE6E3kXC5dF5JnIwU1JK0HbkIo1s3L8N9hAZhTc8VesrJpGQUmFwx
	 haFaDZJ9/ZT9eYE2jJH1B5x7wm6iDZQRXO1nWia7m1q7RsM15vwfOTScrBk7WdvjpT
	 7u1MImTAO0W4maG2mrRN+UH6N1C3rRsooI1+7EqeiTynPNHHaG4UFGMCTYYUoajvXX
	 3kwoC69DcPT/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFF08607AF;
	Tue, 21 Jul 2026 03:11:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06937EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5109607A9
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIKJ_xb_mdCV for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 03:11:50 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 98C5D605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98C5D605CA
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98C5D605CA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:11:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F832846A5; Tue, 21 Jul 2026 05:11:47 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9DE682991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:11:44 +0200 (CEST)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-495c63c4141so6776424b6e.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784603503; x=1785208303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IKQIMvizla518/vNeUmZa/6+7+mDny7Az5yD9/hOFL8=;
 b=bIQiePl/ug6Mq6yHQDjqz2tNXii9aClJoLc5yBcU1BNLjUud5Bvn0iKDjeGx40JQM9
 3O+YyiCurfS2CYYGJ9cyyDd4wiX4hmvXPJ9NNDC3WdyNKG+IJ0dINgNTSdoy2YWc4buG
 agwSKT+SMEsQqLQSM5KlRCSWVgztmSpUvca1X7FgBpRZfctlvRjOhBNT/giq+3B6EXky
 FSjr1ATcLKL05EPIOxXMw7qhnkH3NRo1gDXp6yhVIXGkK8hauka/dKwugYhT2zkbxfoS
 +z8jsyFkazcBYc4Ahj8xw68NZl1TcJy4hbfnLZn47b9wgas6PQpQe0jUIrtbXf6NhhMi
 z1xQ==
X-Gm-Message-State: AOJu0YztLMnCMcWGWHXUPETR0q/FYGFo7JJTGt/NUcsnw0taYc+nXS4T
 bNcH4AcBo05KGe+oU2zoWSkzsV7oFZqHBxHUtZdQPZyKKcbzFOjR4j7+YDDgTMOxwdv7yQ==
X-Gm-Gg: AfdE7clKaCs3YryM+1tza0HnXRfpPSTtf0eo3uRK/mYJ3z6zhNqQDACQSqKeky0HnrD
 fvp9/tIfvHcJRllYBNPzicD57H6boeLhlurOyrULGiq0G3CEfnA6bRhQZ5Bxdnxj+ULLZ/iH3Jx
 Z2qzwGdTMUZOGjJQDoKbFAyyKjRPX1mPbPWWL5ud12h9Ra/JbzuV3oxqkgCiOVkvbs5t/wL1JjF
 T7C8aYixo573QmX46+dMTSMgOiHxTMIbUqcQUniINz2MVSuxO2kkW3W1xIHt4T5JItfvahYOC0w
 g/Rfx53atbGlfPwsXopB08SvhZZK8asqYnZHJzUd5BlXjUN2oUQQniCRaQi6ZW5AzvCT+Oj4op4
 K1DRll/Nw/J884GdnCnQyjOdYSo2ke3RTNjnX8oLsrj4V4dRZSC31W6xugtwuZXGIaR74q0BrXL
 qeHB9h8X4ouVtRl8L36bf54Cvnbj6c+5iqvORLz5flcf3zyAV6V/b9t+QOcniYiW1Oho5OzlQiG
 K9XbysCfIiTwE4EUwgu1z9i9uWz/2O2wiaQTkfvEjS3MtRuSnYyVMr0imcGlW6QDjI2HSBztNk=
X-Received: by 2002:a05:6808:1250:b0:495:adee:29e9 with SMTP id
 5614622812f47-4a4d055ede4mr8969072b6e.41.1784603503451; 
 Mon, 20 Jul 2026 20:11:43 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3d06e08sm8768623b6e.14.2026.07.20.20.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 20:11:41 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v6] crypto: hash: use DM providers from hash command
Date: Mon, 20 Jul 2026 21:11:13 -0600
Message-ID: <20260721031123.1949018-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784603503; x=1785208303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IKQIMvizla518/vNeUmZa/6+7+mDny7Az5yD9/hOFL8=;
 b=X0f+Fy6Ea99MAgFCVpmzbYRhl2m9lNXw4pE42/bRClDjzZ6WfoxZ+Z+J9kAnDFffeF
 eeszPI1Fu3ZVhKwxZ2WiqwBr4atexvj2M293bW8Qifk1i24GOAYWp6XgljhbxNxjtCie
 JdU2Qz/b6dWkq1rPWZqCArmef/I4aGNh7YhsaNSc2tFsyxJP/AXa5Rpep3N6Lzr4O/yk
 Ph8mUd/ra4BVaChFsG2qALzbnWKlPH5YnxjtqF+Q0yPty309PEx9+pWo/weacFuDTTgt
 83AvUoHUEBPd67ZOdavRwpMlKYDfoFE+UQk78JYclNOxa6ugXDd5eKiNfmvUmDMDifOg
 SkfA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X0f+Fy6E
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=james.hilliard1@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="X0f+Fy6E"; 
 dkim-atps=neutral
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
From: James Hilliard via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: James Hilliard <james.hilliard1@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The hash command currently always uses the software implementation for
the selected algorithm, even when driver-model hash providers are
available.

Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices in
order and uses the first provider supporting the requested algorithm.
Continue past unavailable providers and unsupported operations, but
propagate a hard digest failure once a provider accepts the operation.
Remember probe failures so they are not silently hidden by software
fallback when no later provider succeeds.

Use the helper from the hash command and retain its software fallback
when no usable provider is present. Add sandbox tests covering provider
fallback and hard-error propagation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Send as a standalone patch  (suggested by Tom Rini)
  - Drop unrelated hash_digest_wd() indentation changes
    (suggested by Tom Rini)

Changes v3 -> v4:
  - New patch
  - Try all registered hash providers instead of only device zero
  - Add provider-selection and error-propagation tests
  - Reserve -EINVAL for hard errors
  - Use -EOPNOTSUPP for unsupported algorithms
---
 common/hash.c                       |  21 ++++
 drivers/crypto/aspeed/aspeed_hace.c |   2 +-
 drivers/crypto/aspeed/cptra_sha.c   |   2 +-
 drivers/crypto/hash/hash-uclass.c   |  35 +++++++
 include/u-boot/hash.h               |  20 ++++
 test/dm/Makefile                    |   1 +
 test/dm/hash.c                      | 143 ++++++++++++++++++++++++++++
 7 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 test/dm/hash.c

diff --git a/common/hash.c b/common/hash.c
index 71c4bef5826..5cbb4926c1d 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -11,6 +11,7 @@
 
 #ifndef USE_HOSTCC
 #include <command.h>
+#include <dm.h>
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
@@ -20,6 +21,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/errno.h>
+#include <u-boot/hash.h>
 #else
 #include "mkimage.h"
 #include <linux/compiler_attributes.h>
@@ -614,7 +616,26 @@ int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
 			return CMD_RET_FAILURE;
 
 		buf = map_sysmem(addr, len);
+		if (CONFIG_IS_ENABLED(DM_HASH)) {
+			enum HASH_ALGO hash_algo;
+			int ret;
+
+			hash_algo = hash_algo_lookup_by_name(algo_name);
+			if (hash_algo != HASH_ALGO_INVALID) {
+				ret = hash_digest_wd_lookup(hash_algo, buf, len,
+							    output,
+							    algo->chunk_size);
+				if (ret && ret != -ENODEV && ret != -EOPNOTSUPP) {
+					unmap_sysmem(buf);
+					free(output);
+					return CMD_RET_FAILURE;
+				}
+				if (!ret)
+					goto done;
+			}
+		}
 		algo->hash_func_ws(buf, len, output, algo->chunk_size);
+done:
 		unmap_sysmem(buf);
 
 		/* Try to avoid code bloat when verify is not needed */
diff --git a/drivers/crypto/aspeed/aspeed_hace.c b/drivers/crypto/aspeed/aspeed_hace.c
index 22b5008a296..2469f53472f 100644
--- a/drivers/crypto/aspeed/aspeed_hace.c
+++ b/drivers/crypto/aspeed/aspeed_hace.c
@@ -160,7 +160,7 @@ static int aspeed_hace_init(struct udevice *dev, enum HASH_ALGO algo, void **ctx
 free_n_out:
 	free(hace_ctx);
 
-	return -EINVAL;
+	return -EOPNOTSUPP;
 }
 
 static int aspeed_hace_update(struct udevice *dev, void *ctx, const void *ibuf, uint32_t ilen)
diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
index f57778e160d..0dc00f306f1 100644
--- a/drivers/crypto/aspeed/cptra_sha.c
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -68,7 +68,7 @@ static int cptra_sha_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 		cs_ctx->dgst_len = 64;
 		break;
 	default:
-		rc = -EINVAL;
+		rc = -EOPNOTSUPP;
 		goto free_n_out;
 	};
 
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index 5d9f1e0d59b..ffca19af2de 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -84,6 +84,41 @@ int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 	return ops->hash_digest_wd(dev, algo, ibuf, ilen, obuf, chunk_sz);
 }
 
+static bool hash_op_unsupported(int ret)
+{
+	return ret == -ENOSYS || ret == -EOPNOTSUPP;
+}
+
+int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
+			  const u32 ilen, void *obuf, u32 chunk_sz)
+{
+	struct udevice *dev;
+	int first_probe_err = 0;
+	bool found = false;
+	int ret;
+
+	for (ret = uclass_first_device_check(UCLASS_HASH, &dev); dev;
+	     ret = uclass_next_device_check(&dev)) {
+		found = true;
+		if (ret) {
+			if (!first_probe_err)
+				first_probe_err = ret;
+			continue;
+		}
+
+		ret = hash_digest_wd(dev, algo, ibuf, ilen, obuf, chunk_sz);
+		if (!ret)
+			return 0;
+		if (!hash_op_unsupported(ret))
+			return ret;
+	}
+
+	if (first_probe_err)
+		return first_probe_err;
+
+	return found ? -EOPNOTSUPP : -ENODEV;
+}
+
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 {
 	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
diff --git a/include/u-boot/hash.h b/include/u-boot/hash.h
index f9d47a99a77..7dba66047f5 100644
--- a/include/u-boot/hash.h
+++ b/include/u-boot/hash.h
@@ -19,6 +19,8 @@ enum HASH_ALGO {
 	HASH_ALGO_INVALID = 0xffffffff,
 };
 
+struct udevice;
+
 /* general APIs for hash algo information */
 enum HASH_ALGO hash_algo_lookup_by_name(const char *name);
 ssize_t hash_algo_digest_size(enum HASH_ALGO algo);
@@ -31,6 +33,24 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO algo,
 int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 		   const void *ibuf, const uint32_t ilen,
 		   void *obuf, uint32_t chunk_sz);
+/**
+ * hash_digest_wd_lookup() - Hash with the first provider supporting an algorithm
+ *
+ * Probe each hash device in order and use the first one which supports the
+ * requested algorithm. Probe failures are remembered while later providers are
+ * tried. Once a provider accepts an operation, hard failures are returned
+ * without trying another provider.
+ *
+ * @algo: Hash algorithm
+ * @ibuf: Input buffer
+ * @ilen: Input buffer length
+ * @obuf: Output buffer
+ * @chunk_sz: Watchdog scheduling interval
+ * Return: 0 on success, -ENODEV if there are no providers, -EOPNOTSUPP if no
+ * provider supports @algo, or another negative error from a provider
+ */
+int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
+			  const u32 ilen, void *obuf, u32 chunk_sz);
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 int hash_update(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 int hash_finish(struct udevice *dev, void *ctx, void *obuf);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 76aa1fff9ba..fb3e6a7008f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_DMA) += dma.o
 obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi_host.o
 obj-$(CONFIG_DM_DSA) += dsa.o
 obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
+obj-$(CONFIG_DM_HASH) += hash.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
 obj-$(CONFIG_DM_ETH) += eth.o
 obj-$(CONFIG_EXTCON) += extcon.o
diff --git a/test/dm/hash.c b/test/dm/hash.c
new file mode 100644
index 00000000000..fe949e33de5
--- /dev/null
+++ b/test/dm/hash.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for driver-model hash-provider selection
+ *
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <dm/test.h>
+#include <dm/uclass-internal.h>
+#include <u-boot/hash.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int unsupported_calls;
+static int success_calls;
+static int hard_error_calls;
+
+static int hash_test_unsupported(struct udevice *dev, enum HASH_ALGO algo,
+				 const void *ibuf, const uint32_t ilen,
+				 void *obuf, uint32_t chunk_sz)
+{
+	unsupported_calls++;
+
+	return -EOPNOTSUPP;
+}
+
+static int hash_test_success(struct udevice *dev, enum HASH_ALGO algo,
+			     const void *ibuf, const uint32_t ilen,
+			     void *obuf, uint32_t chunk_sz)
+{
+	success_calls++;
+	memset(obuf, 0x5a, hash_algo_digest_size(algo));
+
+	return 0;
+}
+
+static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO algo,
+				const void *ibuf, const uint32_t ilen,
+				void *obuf, uint32_t chunk_sz)
+{
+	hard_error_calls++;
+
+	return -EINVAL;
+}
+
+static const struct hash_ops hash_test_unsupported_ops = {
+	.hash_digest_wd = hash_test_unsupported,
+};
+
+static const struct hash_ops hash_test_success_ops = {
+	.hash_digest_wd = hash_test_success,
+};
+
+static const struct hash_ops hash_test_hard_error_ops = {
+	.hash_digest_wd = hash_test_hard_error,
+};
+
+U_BOOT_DRIVER(hash_test_unsupported_drv) = {
+	.name = "hash_test_unsupported",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_unsupported_ops,
+};
+
+U_BOOT_DRIVER(hash_test_success_drv) = {
+	.name = "hash_test_success",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_success_ops,
+};
+
+U_BOOT_DRIVER(hash_test_hard_error_drv) = {
+	.name = "hash_test_hard_error",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_hard_error_ops,
+};
+
+static int hash_test_unbind_all(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	for (;;) {
+		ret = uclass_find_first_device(UCLASS_HASH, &dev);
+		if (ret || !dev)
+			return ret;
+		if (device_active(dev)) {
+			ret = device_remove(dev, DM_REMOVE_NORMAL);
+			if (ret)
+				return ret;
+		}
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+}
+
+static int hash_test_bind(const struct driver *drv, const char *name)
+{
+	struct udevice *dev;
+
+	return device_bind(dm_root(), drv, name, 0, ofnode_null(), &dev);
+}
+
+static int dm_test_hash_provider_selection(struct unit_test_state *uts)
+{
+	u8 digest[32];
+	int ret;
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_unsupported_drv),
+				   "hash-unsupported"));
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_success_drv),
+				   "hash-success"));
+
+	unsupported_calls = 0;
+	success_calls = 0;
+	memset(digest, 0, sizeof(digest));
+	ret = hash_digest_wd_lookup(HASH_ALGO_SHA256, "test", 4, digest, 4);
+	ut_assertok(ret);
+	ut_asserteq(1, unsupported_calls);
+	ut_asserteq(1, success_calls);
+	for (int i = 0; i < sizeof(digest); i++)
+		ut_asserteq(0x5a, digest[i]);
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_hard_error_drv),
+				   "hash-hard-error"));
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_success_drv),
+				   "hash-success"));
+
+	hard_error_calls = 0;
+	success_calls = 0;
+	ret = hash_digest_wd_lookup(HASH_ALGO_SHA256, "test", 4, digest, 4);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_calls);
+	ut_asserteq(0, success_calls);
+
+	return 0;
+}
+
+DM_TEST(dm_test_hash_provider_selection, UTF_SCAN_FDT);
-- 
2.53.0

