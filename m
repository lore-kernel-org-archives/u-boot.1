Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F85AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C5688BA4;
	Thu,  8 Aug 2024 18:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H6hFPADo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB31088BA5; Thu,  8 Aug 2024 18:21:58 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CA388AF8
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a3b866ebc9so1332346a12.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134116; x=1723738916; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=egA3xRpkyqDRzibem82Wk57TPGhBhb+v8n5ItP4pcqI=;
 b=H6hFPADoGz8mvIIQtmVZsR9UuR5UL/t8blLEjul3+cOlRoQ8V5nP3SZoAly5Mcv9nY
 ZRIGO1oHFW1JCTofRDW30vP+BENyd5OkyUqttDTgHbBHvHi4oPSPeOo0SG1ModwXo5Xi
 HlfcanMBImvt21JC9N4zPeMSqnmHpfZW71XnVez+X6zAtN0b4FBBVX36AveVzbZgCP97
 K/Xy7fEjen+lZHWoGEOkNjp8jK5Gjy+7+ez+37i/Xig5i2q6DqYrCJ9x6As2e5TIw2dT
 Icf7MVHEMBeWgPpVV7YvxDUGMHiDbdZooV4rwOjlMpo1bqpkLE9DPblUyKDbSzgoOgm+
 jSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134116; x=1723738916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egA3xRpkyqDRzibem82Wk57TPGhBhb+v8n5ItP4pcqI=;
 b=PgS4IW7CyBAyF+dSutaO44BnnY85JucqHJkWe0pKG824bas3RMC/y3vm5CGchYhFb6
 8VGphnowlyIhYo9YfkODVWweaLkiEkdu2f3wjnumCqsqZwirXAlagzGp7YLyk4bKioBZ
 aOImDBXq3g93UVWDiZRuE9b1ZsehkPyqqvgR8pdZ3FKc+lpzC30q5vCpZYJh92Ct4Z7R
 z2gyii36NNx8O9FazzJ+OsHSnFTJCnlVmoYYjqXoia+gnxDdyB/qUD0fRxxsyLq/Chan
 Mz8jdNBpo5Sid5py/bc8y9YS7jW42xU1EnA1f2IP9BajrP1eErqUMDwmU+nzsDtSEee6
 ZJ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1HXAnTTXwPiye9mcASYOpg6Da4mcIxL70ozYVQUcLOV9Wbizrv2lfSOeg/s5rHf44hZitJaXCi6bGJv02LgrOEz2G7A==
X-Gm-Message-State: AOJu0YzHKGBYL2R2ju4HrZf6OfAMXYJD5UaiGsXqy2yo4VFSj/VoCgqi
 fbhdVF+wCfviUZBvjBWZ4eOE1z9inJMgsfIa/sVrS2Tni6vNePUtzAWGlB4WJDQ=
X-Google-Smtp-Source: AGHT+IGgyWkmXse/7cV9sGl2j0arOLN98cJfHOV5EJTP2xvxQDsDD6aX9hkleS8Zj4xA0S9X2yz1gQ==
X-Received: by 2002:a05:6402:234c:b0:5a1:7362:91d9 with SMTP id
 4fb4d7f45d1cf-5bbb233eefcmr2292387a12.22.1723134115654; 
 Thu, 08 Aug 2024 09:21:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:49 +0200
Subject: [PATCH v6 02/11] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-2-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5441;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=JSqqjukXOTthTri0V10jRsBkn3907XaleehDt877lBY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCeGgXM1hOPfbxx57PJhY+Q+RekZFcHA8AMp
 dIRWCU9NIuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwngAKCRAFgzErGV9k
 tthoD/9kg77QJoYAtLLW1PQ9a1pRHhqzKaszwxMB58GCvRLQISfTDmhjYnHAJlvPArUcMJeDM8p
 ZE1VMnM5LQ4KDtjMqpDycQIwyTyNyMmTLljA5f4Ah0hSM6j0S1QZ+J1qIc5+oIK1D4c2y3Tvv95
 l/LEuAiVowywh5WdZMKd7iBxg8pUfU4nsMC6hLLNKg1bt23F+TaaAFHEOXXhVu03uIk5n2stsp7
 4N15JyaSzJa6hjH8ljU/6r1mxNLPQpviTwc+yPt6q5qv3IgH66+mbGYkG8GtBeA1NZ7OlE6Jmj4
 mdnv2vL+/7rZfjk6hOauJtFyvjtkqGpXSiS8GCPuieLf3O9ALAXTdP5URnNUMDP+gDDVfhFfE1c
 p5DlNwD4K365eKPnw3LwuihD9MmXYUZrUkrR0QDjvBRiuIMV3o7sA8Vr1RX9UUdq3iOng5YMeh8
 xUfqSrkgjvhXRACBiywQKetFnUC3jjvw/FASomBIuav1pKtdV0BR9Y/EBdQaLC6ynIW3j1bQAev
 so9/5bZdgrHy7L2MYA9BMKHXJOwUzOj8YDLumlKH5cvpvIYJS0lZrERMVOhH1rFGRcip9eJvBat
 oAvr/xNThIVeWyGoXvG2BtNV/APOJlkqYfhzW18yazwjFQti73qiiSpILk1qB8+Ibm13Wru4lqy
 35Qg84OPVFc5PkA==
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
index dfa2320ba267..24b5881600fd 100644
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
+	*tmp32 = cpu_to_le32(be32_to_cpu(*tmp32));
+	tmp16 = (uint16_t *)&guid->b[4];
+	*tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
+	tmp16 = (uint16_t *)&guid->b[6];
+	*tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
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
2.46.0

