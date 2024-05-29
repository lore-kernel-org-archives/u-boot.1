Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78DBC27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5534288633;
	Wed, 29 May 2024 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RCgOfIeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8668B88602; Wed, 29 May 2024 16:49:03 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7C088615
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5788eaf5320so2540053a12.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994141; x=1717598941; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aIIdk8QLdQK/+nMS97Tn+QiBS+LkUYzHnlaYIE+5lNU=;
 b=RCgOfIeGnC2aY5iq+WvIpvg0GDV4lbvg6dSoHBqplEa5z5A1zDiyem2oJIL/ZwXIcp
 PnU9x4Hcq2YQoPehFro6OPJP1LAlYCbQW/xNlL0+OgNx9uE1vYXzPEz9VHXTDBeYraPA
 n5V2jiGgeiJ7ZnfYW3KxSJRhAvLRqm9T4LX6WCp4TEQwblII9cLHYUKpgnNH3StIvbze
 XtX2nEIoDmQVThjGPg9h9QjYrkbrwKxrw1otdAMtaJgBoEmZoMtmRyD/N1wE5WQyJ257
 oDa7FVCKC88SMGQ5Fp0CTsWQE9vp/kYEeB55XEOUgZ5n/MvHLdmHFkAbww1oyI22rgRs
 J6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994141; x=1717598941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIIdk8QLdQK/+nMS97Tn+QiBS+LkUYzHnlaYIE+5lNU=;
 b=eoIZfxG8+15EYsQLFYD7FFytBHWBX4UehnoqwBrReJmkCFJ/O75oRPvyvzSO4XZWsj
 yirIHtwpL3Eiam+HOQGSLEmJ4szR4TYcClU68YRhNbs26FzBfTJZh/GLByOkr3woMdBc
 /mhJyaCrgU9J2p2wST1UhxjeWnMvgGc3SGolaCIBs3P91ZX5bzelzOzlkq2i4lpj0LYh
 XhQfJZvWJEnjBbxbz0AMJqZyr6cxGAcchumH8QfSZkT5YBwnczod0Ib3hKYf2Tu8g4nO
 7YkF/muACw1qCweYKDxmoGbzyRGFKLnLISBz1yd3FjHAAyYB7ycVBNKcyayiZnBE+HeO
 LoUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr5sDYwLDZKHH7pOHAwUgDxbdTZA18YNLDh+taRC7+/ui8fYqO0IEnjsgnJXXJcEoMMToNbqHyEpucazzHAGt3aLlIsw==
X-Gm-Message-State: AOJu0Yy2znWK9Z1RPG0AqE4sJ2bZoEpaqkwkrs+YWSlXswx2afF5aXzP
 enuG7AWFQvQWF1Rr4ljKfKesknDve5N0dg0Alvq0StOJBK01zqWTJ661n9IO62o=
X-Google-Smtp-Source: AGHT+IGPTtxcFxKkrP/onGnNAzwDjweL7Ir8889XWLBJobFEq8A5NdBTd1/JTz1U8+hyABxy+nKExQ==
X-Received: by 2002:a50:d510:0:b0:572:78df:c606 with SMTP id
 4fb4d7f45d1cf-578519a21cbmr11801327a12.26.1716994141013; 
 Wed, 29 May 2024 07:49:01 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:50 +0200
Subject: [PATCH v2 1/7] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=9RwhiMRkxrdJFgF+8gB+nMRGmyBqr6tIjuyyWZp3K0I=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0BZPBk9BhuBAUn5iM0Rg4ymPu5u6Vf5ypt+2
 jI6VjWr8oSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWQAKCRAFgzErGV9k
 ti7zD/4gm9hBUha5E17XOjmHmcur+SbNnOg5h+lq3KzMTIw7Jrwvkq8+Ga1z96MZ8G6fUWmtNxu
 ga1tc27vrz+afUVMR8AnpJkbSyIwBkqWSatEkrT3dAIfUV71d1ohjk0Nz77OxDyvei8hvsroMss
 ffCsumg5v4X2CtEN4WuUw6QDGDLrJmP5gnnMTc9dZVVvxs9H+5QlnnvfqlciMaanIS+mOoR7h2r
 lKAjTFzojJiq3Y72hpfwlw1MJTuvGw/wnXteZ8pIMDDJPzcNTsNAxQtmYQU4s7qyVvE4a3M8XRG
 JBarHBQKrDZeUlr6V6QKVEAYwd5yYS2Mlm3noZ8ArUALI1CmHvUQ/BGNkTXRJCWRjcaY4HUnls4
 BNfchUp0Df3zANonqA0k2b8rVDaYNDCFyJyN0b5wr3csJnZiJjzjMmy6ZZhS3v90DWqr03phfzb
 xBJMatQ81olK/XwVNa93wSPcFZozlZI0a9VOYDIckEM/B1PzqvIaa1lnv9QnmxWZQp4tFaSQo3D
 OzbGbgv62QbQwa9mm6HcasgE2Vmf6XR+ZcrFBW9m0UUmR3aOwYNlzwlqxQsn43LQsfbmeck1k6w
 oSh6DcNylJJIx+kV3xTGjOAUdzjCXyUxx7tY8qYpPiToKP6nRqjgTMsoO3PJVS8x9FdVqU356rv
 5zHwa1W6EWOXuMQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add support for generate version 5 UUIDs, these are determistic and work
by hashing a "namespace" UUID together with some unique data. One intended
usecase is to allow for dynamically generate payload UUIDs for UEFI
capsule updates, so that supported boards can have their own UUIDs
without needing to hardcode them.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/uuid.h | 17 +++++++++++++++++
 lib/Kconfig    |  8 ++++++++
 lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/include/uuid.h b/include/uuid.h
index f5a941250f48..539affaa47b9 100644
--- a/include/uuid.h
+++ b/include/uuid.h
@@ -10,8 +10,9 @@
 #ifndef __UUID_H__
 #define __UUID_H__
 
 #include <linux/bitops.h>
+#include <linux/kconfig.h>
 
 /*
  * UUID - Universally Unique IDentifier - 128 bits unique number.
  *        There are 5 versions and one variant of UUID defined by RFC4122
@@ -142,8 +143,24 @@ void gen_rand_uuid(unsigned char *uuid_bin);
  * @param          - uuid output type: UUID - 0, GUID - 1
  */
 void gen_rand_uuid_str(char *uuid_str, int str_format);
 
+#if IS_ENABLED(CONFIG_UUID_GEN_V5)
+/**
+ * gen_uuid_v5() - generate UUID v5 from namespace and other seed data.
+ *
+ * @namespace:   pointer to UUID namespace salt
+ * @uuid:        pointer to allocated UUID output
+ * @...:         NULL terminated list of seed data as pairs of pointers
+ *               to data and their lengths
+ */
+void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...);
+#else
+static inline void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
+{
+}
+#endif
+
 /**
  * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
  * @uuid_str:	pointer to UUID string
  * @uuid_bin:	pointer to allocated array for little endian output [16B]
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa1..2941532f25cf 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -80,8 +80,16 @@ config RANDOM_UUID
 	help
 	  Enable the generation of partitions with random UUIDs if none
 	  are provided.
 
+config UUID_GEN_V5
+	bool "Enable UUID version 5 generation"
+	select LIB_UUID
+	depends on SHA1
+	help
+	  Enable the generation of version 5 UUIDs, these are determistic and
+	  generated from a namespace UUID, and a string (such as a board name).
+
 config SPL_LIB_UUID
 	depends on SPL
 	bool
 
diff --git a/lib/uuid.c b/lib/uuid.c
index dfa2320ba267..6ef006cca1da 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -21,8 +21,9 @@
 #include <part_efi.h>
 #include <malloc.h>
 #include <dm/uclass.h>
 #include <rng.h>
+#include <u-boot/sha1.h>
 
 int uuid_str_valid(const char *uuid)
 {
 	int i, valid;
@@ -368,8 +369,44 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 		}
 	}
 }
 
+#if IS_ENABLED(CONFIG_UUID_GEN_V5)
+void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
+{
+	sha1_context ctx;
+	va_list args;
+	const uint8_t *data;
+	uint8_t hash[SHA1_SUM_LEN];
+	uint32_t tmp;
+
+	sha1_starts(&ctx);
+	/* Hash the namespace UUID as salt */
+	sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
+	va_start(args, uuid);
+
+	while ((data = va_arg(args, const uint8_t *))) {
+		size_t len = va_arg(args, size_t);
+
+		sha1_update(&ctx, data, len);
+	}
+
+	va_end(args);
+	sha1_finish(&ctx, hash);
+
+	/* Truncate the hash into output UUID, it is already big endian */
+	memcpy(uuid, hash, sizeof(*uuid));
+
+	/* Configure variant/version bits */
+	tmp = be32_to_cpu(uuid->time_hi_and_version);
+	tmp = (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
+	uuid->time_hi_and_version = cpu_to_be32(tmp);
+
+	uuid->clock_seq_hi_and_reserved &= UUID_VARIANT_MASK;
+	uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
+}
+#endif
+
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
 	u32 ptr[4];

-- 
2.45.0

