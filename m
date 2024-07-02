Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678B0C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFD888096;
	Tue,  2 Jul 2024 15:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HsEU+Y8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889C888712; Tue,  2 Jul 2024 15:30:49 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B9387CF8
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7241b2fe79so458178666b.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927047; x=1720531847; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yplIHPrFrd+E2vv2AnXg2YetFfTtD3L3FbyS9laYyOY=;
 b=HsEU+Y8YY8LrBcnxaNGrIOXMYlDCk6/DmJldThikWUztEZB32Bhct1JaSf0U/0bZXZ
 SZvmsJi+CC4+e8lTvA/jTi39FcgzsCAz06x43tYY0xAsGKzb6ab424b73frTMPmcHcpr
 ItNc7bV4+kWPn5y/VqC8tpa6+2qMux6B+BLFhABAt5kg/tyJPKewegOK0v6CVarw1M8N
 4tqSjt1HUoju98Z1b2AkpVfG7rs5i5TwOh1HKc2O73dXKdC51Qxou0LrxDtRJFS+cnKN
 xAp1eGXRjwy8bN013vIBe6lYrl09w3Zyx7CtbKpfEAQpYzTWpv6A2VCr5yKoRXW72pBb
 ZnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927047; x=1720531847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yplIHPrFrd+E2vv2AnXg2YetFfTtD3L3FbyS9laYyOY=;
 b=u2qaTYVvf6LbqZTgXwr/5SY0TeObCUgAntPLJNRP/9Ogxd2E4YhUsGye/g5y5vkH7/
 n5Ppbjiz+MWu/Tek7C+08/l8mXIQcTzw57mRa21S3udnwbubzlBDpOvaJrWWQ/7uMXCV
 gkWGktxUNpXeqrp7WTritfQ5IkhCnFyUOt0euU1XhkU6OjVYBRfSwmxBg2L7XJNwIofY
 NfTlFGRXnlzVsHL8NU8qOmpAbUcsLojQ0ZBEklXvBSByI3Gju44gUo6yKwx4sGsjDIYm
 qTKJGF6Ziv1ktGs2hR8iNWC06rJpA23/tlK9vv38q/pmhzocGuSsOckF+cwqEs6/fyLP
 0yOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ruWyZgCukWKn0EDR0yj9H3cFVh94GbM2NZCJjydlROaobXRXeOKlY3EnV3dJYilR5vr4Eb2c0kKBspHtYwhO9HiikQ==
X-Gm-Message-State: AOJu0Yz0cNxCq8t3TxOttPWl3X1D8w+Vf9xnvv6vJcrp8dYOpLjOkUmI
 cLXNMOlY9YprRIkKheKZnG1yg/WmVAqREqBSrvCOwBIKRMN3AJ7Ncoyr/u8blLU=
X-Google-Smtp-Source: AGHT+IFNN1XToQk2TF/BoFlQSyxCa9ipFrWW9TmzPTohlJwGXbxTCmsmW2bzPLzA0IWbjQS9D3WwYQ==
X-Received: by 2002:a17:906:fccc:b0:a72:548a:6f42 with SMTP id
 a640c23a62f3a-a751445451dmr563539866b.18.1719927046780; 
 Tue, 02 Jul 2024 06:30:46 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:42 +0200
Subject: [PATCH v4 02/10] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-2-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
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
 bh=V+42NnDIi/jdM6oXb7A+84TKo7thIq/t0tX3x78iv9c=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEC8YRwMwEayIYvp9j8ek0q1ZmTkQFLV6bUS
 bpWS7ERj3qJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 tkRtD/4r6YadqhQ7ZtTxg6er70+qFn6Q0H+KTO+5uNTf9xzZhRWis0LKeoJfEQ3dfrDnY28Ju0r
 ebDMtEP6cvVt0uB6Cn7YwqKmOn7Gm7Ju7CCVOuKnKI+eDZnya6Jg95nh3pB+1Uk41OGmEev7ODE
 jZwdiPAzDDJaLwFYMWY4KNGYw8+rHb8b9ao1iLVx9t04B/vgJ1zTHbWBXxiKBpqk47uEhYBhSAe
 gFHswmNRaaTaEtMsyeeOfKpO8xlTzRvLH/U5/r+hDJA6voovIUwmGbKI4rBiuM5Eu709/1jWERr
 /6XbmCXZhjfykif0Pb6G03NaMQRrD3SYt5XpX0Y5SjvexY3FTIAlE+hHYTfK52lJsY/0aDC3t2f
 aXnCttx7ECQ9XanufJ/MaR3H/5fdve9IHxjmI8qAI/P1oh31//fr89QNOkIVJESTQU0c9j1ZsEz
 q+YuUM8Jo2B0CKMCnph5X0+yRJFkBmmOpAhyKWVdFbTxV3x3lwK6WMg+DNJccKOPQ9lKBUq9oFJ
 Imjqh2kEufL81iZR8Ce5PuiiGrw4YqwNqgTlUZ5Mnuz7hI/rKiVc/0QEaZRm9aT1qcgV7Q0YFa7
 HM4WIdvuxIvPH8WbYnfaRDsYSCnx/eXdawGS+4FFK9sep2Qk8aezvI6T0Qj7xLcO+BzGJwrCcRA
 eqt+NCjQEtgVhhQ==
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
index 189e6eb31aa1..9aa882d5f882 100644
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

