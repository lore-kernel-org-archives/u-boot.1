Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9DEC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916C688BBA;
	Fri, 19 Jul 2024 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qA2MJlVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A91788BB4; Fri, 19 Jul 2024 14:43:52 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F8E88B98
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52eafa1717bso1412327e87.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393029; x=1721997829; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=06LSf+ZyzKrtlsGlKlD4mrfB2zoy30M7cflm2gOS32s=;
 b=qA2MJlVzuz/1dz4/kf18a9ad8xbyjJ+g4FWKw5tX0XGoC8qC/WzQ4y88WGkThnJzI4
 JWAnTCXtSJR6k/XYegQ6s9Ix0zL+53uj4ugavFD9e8THaMA27hzCWNQ/6dkfQsqweis/
 ohJRGcUA9AMzo1zVgtb1TPr9UYlDvqwKg2p0+lMtqrpduPvkZFH1X5K1JasGJ5E/jes9
 5Rp9qv5ne+SNM2J8UsbbxnayEm8lqtYuwlASCY4jIKMofTvLLblAg9agc6tReZeIQuVD
 018uGjp4xo4sLA/5dRQ8XkOyfyKp9Cv+bPm1w5Ta7mqm8r6wWTLZ4Mon9IYrSATdQUr0
 2YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393029; x=1721997829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06LSf+ZyzKrtlsGlKlD4mrfB2zoy30M7cflm2gOS32s=;
 b=gfxKTiXK6AhFCtzFqeKPDTDZ7uoXsicHwhfAFK8z1kHwBcWgidYfW3H3Z91dk1Zv3T
 c17W1/nUkD4C4vZjID53ng2yrLiY4OK/rxKBjACvMssf864B8LyiX2OhSIY5T7gzAyBn
 MvM5GZcS4CfFSEI0o0+J1zy/0Fpny9ngp3NsBKv+rFY0sImQXlvNg4BT+20LqUaFftJK
 1WH472cC2NDO2u4ZUjMeUAJlSkuJqj7l9lNXcD9tkQRlRDTVTB4qQ2FKKe8rgEKVf7GW
 IO8aif29kGmF+r6kFr3ocqNO44/mER96okBnLsS8y11Jh1AepBoWeroXV9kcW0Z7C3kM
 DKPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWF4vcM10pT2eUV7oP126yxi9g+2Ul3ffYFrFjo71g6N1CK0qoEqGzHR3gmtwZcmWO7GkV/6ndUvknPrefZeZTMU6jhQ==
X-Gm-Message-State: AOJu0YwwDnLYUqZRLPPVb7mYsWx8vmYh961SSq9Dku/5tB/Yi0PTuoBi
 h+xuQJkk+Fo9QJ1P0A7/tw127xAv/90pfB2XwRdXmiRFTzV5GUxBKGUk+vieMS8=
X-Google-Smtp-Source: AGHT+IGW1WciJChxo9KFab9S9cZ7ZDzvNcsXYdL3aaMn5v7ZSbmqs5JXo16SeBYE12BjgOuOdQEN/w==
X-Received: by 2002:a05:6512:3ca2:b0:52e:969c:db8a with SMTP id
 2adb3069b0e04-52ef5874cb2mr1201801e87.44.1721393029096; 
 Fri, 19 Jul 2024 05:43:49 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:42 +0200
Subject: [PATCH v5 02/11] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-2-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5402;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MVJj99WzRHX1hE7msxJdeDXlzUMLrmHd8cNxyX2SDck=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+A9jZ4PYfULAWz7uy5oXXrh2qVWea2sYzjH
 cwYzxDncNmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 tjmGD/46etIjPTLaZeJR6F5hhaZ7b7qBxS6Yc+DjLr5MvmrwQJyq7WEIibVdBnOpIRtfu011cxB
 GfHgy5F+zYG+G/KECpXABpszdAtRkfvVE0IQBGRZK1tbpQNO313j0/ujJ1+S3aLjbEgIdiSEItj
 fNxzuiVVWovry1S42fuB7pYeJFELyIZFp6CjNUR/YX9zdjsc6ImyWTrlkPB9aPY9J5xZ6TzDg03
 ZpZvPQJrdHb9SimujXTGjiVV6qNVF6p3j/uztravhy6jI8AmDG6KcU/Jae1INQ9O3t5iUjmA0id
 XzZZtCuJjY24PT6lLEC20dHWL2jAoKRIfCcg1LMjhiqibqDnl7g5t6IV3fid1mP8l6aT3AKYXNE
 /FFwC9//Y0+9/IGxdg5lrPus0GScxlHzkOqnw0jp025sCIICd9nGdYXCVanotPdBSYrOZrcgUgP
 w4SagtF+efrhlSXFgdVNNg0HLsVvyUP7UBbEuM1kFjp5U2/Juvuv2u/FO8Ea1wNqptUOe/2A21f
 u+kf84spcNDOd/DZbcfjg3fmTXCSYjEEal/OdlP7iZgq4LxR17NJeLIuToxfSIIyfRsaLv2JOam
 ImAB0aYL9/pU0NlqgAwzZqUmBsMen6YvbV76FmqBEm9qCxYtWeaEMA15O+m+6elnH5A6tMk7BnK
 2hiFuOY8/Pd62xw==
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

In addition, move the common bit twiddling code from gen_ran_uuid into a
separate function and rewrite it not to use clrsetbits (which is not
available when building as part of host tools).

Tests for this are added in an upcoming patch.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/uuid.h | 17 +++++++++++++++--
 lib/Kconfig    |  1 +
 lib/uuid.c     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/uuid.h b/include/uuid.h
index f5a941250f48..1f4fa103b5e9 100644
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
@@ -45,10 +46,10 @@
  * where x is a hexadecimal character. Fields are separated by '-'s.
  * When converting to a binary UUID, le means the field should be converted
  * to little endian and be means it should be converted to big endian.
  *
- * UUID is also used as GUID (Globally Unique Identifier) with the same binary
- * format but it differs in string format like below.
+ * UUID is also used as GUID (Globally Unique Identifier) with the same format
+ * but with some fields stored in little endian.
  *
  * GUID:
  * 0        9    14   19   24
  * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
@@ -142,8 +143,20 @@ void gen_rand_uuid(unsigned char *uuid_bin);
  * @param          - uuid output type: UUID - 0, GUID - 1
  */
 void gen_rand_uuid_str(char *uuid_str, int str_format);
 
+struct efi_guid;
+
+/**
+ * gen_v5_guid() - generate little endian v5 GUID from namespace and other seed data.
+ *
+ * @namespace:   pointer to UUID namespace salt
+ * @guid:        pointer to allocated GUID output
+ * @...:         NULL terminated list of seed data as pairs of pointers
+ *               to data and their lengths
+ */
+void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...);
+
 /**
  * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
  * @uuid_str:	pointer to UUID string
  * @uuid_bin:	pointer to allocated array for little endian output [16B]
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a1207..5a48c016d2c5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -72,8 +72,9 @@ config HAVE_PRIVATE_LIBGCC
 	bool
 
 config LIB_UUID
 	bool
+	select SHA1
 
 config RANDOM_UUID
 	bool "GPT Random UUID generation"
 	select LIB_UUID
diff --git a/lib/uuid.c b/lib/uuid.c
index dfa2320ba267..7d0a8273d157 100644
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
@@ -368,8 +369,57 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 		}
 	}
 }
 
+static void configure_uuid(struct uuid *uuid, unsigned char version)
+{
+	uint16_t tmp;
+
+	/* Configure variant/version bits */
+	tmp = be16_to_cpu(uuid->time_hi_and_version);
+	tmp = (tmp & ~UUID_VERSION_MASK) | (version << UUID_VERSION_SHIFT);
+	uuid->time_hi_and_version = cpu_to_be16(tmp);
+
+	uuid->clock_seq_hi_and_reserved &= ~UUID_VARIANT_MASK;
+	uuid->clock_seq_hi_and_reserved |= (UUID_VARIANT << UUID_VARIANT_SHIFT);
+}
+
+void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...)
+{
+	sha1_context ctx;
+	va_list args;
+	const uint8_t *data;
+	uint32_t *tmp32;
+	uint16_t *tmp16;
+	uint8_t hash[SHA1_SUM_LEN];
+
+	sha1_starts(&ctx);
+	/* Hash the namespace UUID as salt */
+	sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
+	va_start(args, guid);
+
+	while ((data = va_arg(args, const uint8_t *))) {
+		unsigned int len = va_arg(args, size_t);
+		sha1_update(&ctx, data, len);
+	}
+
+	va_end(args);
+	sha1_finish(&ctx, hash);
+
+	/* Truncate the hash into output UUID, it is already big endian */
+	memcpy(guid, hash, sizeof(*guid));
+
+	configure_uuid((struct uuid *)guid, 5);
+
+	/* Make little endian */
+	tmp32 = (uint32_t *)&guid->b[0];
+	*tmp32 = be32_to_cpu(*tmp32);
+	tmp16 = (uint16_t *)&guid->b[4];
+	*tmp16 = be16_to_cpu(*tmp16);
+	tmp16 = (uint16_t *)&guid->b[6];
+	*tmp16 = be16_to_cpu(*tmp16);
+}
+
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
 	u32 ptr[4];
@@ -394,15 +444,9 @@ void gen_rand_uuid(unsigned char *uuid_bin)
 	/* Set all fields randomly */
 	for (i = 0; i < 4; i++)
 		ptr[i] = rand();
 
-	clrsetbits_be16(&uuid->time_hi_and_version,
-			UUID_VERSION_MASK,
-			UUID_VERSION << UUID_VERSION_SHIFT);
-
-	clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
-		     UUID_VARIANT_MASK,
-		     UUID_VARIANT << UUID_VARIANT_SHIFT);
+	configure_uuid(uuid, UUID_VERSION);
 
 	memcpy(uuid_bin, uuid, 16);
 }
 

-- 
2.45.2

