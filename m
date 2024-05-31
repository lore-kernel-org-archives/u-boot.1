Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95A8C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF9478878B;
	Fri, 31 May 2024 15:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UYf4xNxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A66882B8; Fri, 31 May 2024 15:50:49 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9808831F
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52b7dc424acso2138758e87.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163447; x=1717768247; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E0SxjaHgoia6tB2dELcQ+S5gH84D9tF+3xpd0qdBlFw=;
 b=UYf4xNxWbaOMGYWYvqO/iQD9lUMpwvc+iOEjmKXP3/YIz2gq+rtjLgslXY+8vRyLya
 VxUJzyYc33WrTLvjHyS+AyVX/d2Vda8jimN0slsZHNjuv4UjQMToAL0swIWXbjeqmDYJ
 Qij3ZxnolaQ3J6ZhyGAn1i8L6y3QpEIKXHutRq+mTNFQhYzNWGQLaxEzUV9vNxyrpMJi
 hUVfxtOADOKp2HL1XxcbVt8mNCpUomCXYWebZZDxSee6act2AiJL6iU7IlEKiJ2Wqqo7
 7ZDLwgdVovlqYERqLN1RVqWMY73q8MqZnxLlwc4oF3jB/XIcOMWzCqyPLu2AMeF7zdww
 hmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163447; x=1717768247;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0SxjaHgoia6tB2dELcQ+S5gH84D9tF+3xpd0qdBlFw=;
 b=LiXrs7vMRMcm4qf/MvbqiJQfrrFyyDUomH897E6zAdftogTYZuVAN7IQA91svqlFbe
 06U43pI2bGgzq7G+P3aUZJm1F1mwGttmusBBogePtHGtB0Uwtw5w21NlWrlamE5Dwk0c
 CPuh8XH806cubprOdlDx9aOszqXr6u4Wba+K3br5RCfKdPlytK4L3lHeVJw40ylaLy/j
 B6Vgfq6FUlvggEiynNDyDR+hxyNLuhLTtnm89dSCHFy4uFgG4/EHrMPFYnIY7N2/XsbM
 02EhpOKas5wSv3Uyw4esnedkcmTeMvWoPM1xh1GTcA0RX8onfQJdmoOyryU4oYbeq6ky
 rhag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVatC5qmZ/0/e1kx0iHdatjqp0YwFaUB3qoXawYdBmoACH8en0QAkKazSWQq6oWBzElmT3+8M0VjJh/h8ZqapXSlTGAZw==
X-Gm-Message-State: AOJu0YxBMklkU4Z93pvJTtP6BW4RlsdB2RU6iPHyXiJrzC2OVNWFytCg
 8H+CVdnHIH6lfmdP7jFmMCW6/Nl7uwGzxnM/fV+V7g3vySsaCg99D3Ups4WbGi4=
X-Google-Smtp-Source: AGHT+IE7GSN0Zy4US1RCvgB+7oBztSRGw3nueDKQBtXt6LgoyekoaKB3Y9I6zjDJgOpcD0BHTlIqQQ==
X-Received: by 2002:a05:6512:4898:b0:516:d692:5e0b with SMTP id
 2adb3069b0e04-52b896cbe90mr1124628e87.54.1717163447039; 
 Fri, 31 May 2024 06:50:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 31 May 2024 15:50:35 +0200
Subject: [PATCH v3 1/7] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4109;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gsSuV5MW3EKgQQRwAD6xb2/96AMgilhrIVh4AHK7v+A=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdWzrTH1Dkf0AlhCZCpXTKQia66NhuWrLFR5Z
 1C8ytWa0Y+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVswAKCRAFgzErGV9k
 tt5xD/0Ri9PSCIxdzdMy0IzAVUAzZ0eJLbFjYb6oyyOIgCJFDflrveF0HgVyVjz4muWPAcmop1r
 Pa0jrzP9fBLG+7R4C326yKM5HXO5bOLENqpQXOPFXXdw9IuERZgKs1gO/hwGTmgmmGp21Z9OSvQ
 q5o1HqZXG8Yegu2hG+g79F7TGqULEsaSWr/lD0T5dRmkWEEVtLuKi5k+FitSZYrJdH3IVzxLqzw
 UAdi06hT79aBJnFG3FjSp9mBNrxdgKrMEyhWu5xRH3o52+irrWj+hlSSx1jYgbzqt4etjCkYGlY
 QvT5ltT9/0QI6S906UITRlmm9F+vSZHgGJ+xQw406nvlleBAQOKcZN9XyasOeETUFDTBd9lreDU
 4WBQ8UwP8MUXPjjIRnis3e/WVZqhP9dGNHfOXmbXWkMmVhTMzDErzn/oHyJnk1GSzObuRxxvvTD
 5lbRfqZkjzbR0h9LHRcpvp6m8Q0udSyGa+53ajphGaYGJRsJ2f6E0y8kNSfFZIsXq3Do8/UzC9D
 p6CZB47JTbvOlA/kmCDpIQtvpBgxla0QOdS0JD80JmJ1QdR/YH3lOY+XuVhcO9v0GPE2zBhoI4m
 9OYSsqRBJ9qDzUAbKzF6KoEsCXK2hF6JxNOG1uG4K9ymNL7D0af+ImfzSUvqom0RCCglaC6yRua
 NCMacR8dTl5U+zw==
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

Add support for generating version 5 UUIDs, these are determistic and work
by hashing a "namespace" UUID together with some unique data. One intended
usecase is to allow for dynamically generate payload UUIDs for UEFI
capsule updates, so that supported boards can have their own UUIDs
without needing to hardcode them.

Tests for this are added in an upcoming patch.

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
index dfa2320ba267..2df0523e717f 100644
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
+		unsigned int len = va_arg(args, size_t);
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

