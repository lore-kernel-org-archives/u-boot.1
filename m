Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6CEC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C04388BE6;
	Fri,  9 Aug 2024 02:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xW1UebO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06CA88BD1; Fri,  9 Aug 2024 02:56:35 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C91C88B9F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a9185e1c0so152608666b.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164993; x=1723769793; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=egA3xRpkyqDRzibem82Wk57TPGhBhb+v8n5ItP4pcqI=;
 b=xW1UebO/JBG4AdfdjR4AtTm6dd3zWNJ002we3lHyhUAONKAid7DD8QzEgkNUTv6PJt
 F8cq7jYBKBEIOgw7irovxBV3TIplY2Bl5LNECERqFkk0E//klevnWvk+1ifCSOHKlvui
 zROieo9EerTqlcnS6vI+le0tZCHA+b3ABjYpTdNtM0tStRFspzjXwymR7Li4N/5Q84lg
 ydkvTvjKJzeiq/cXfEDQTR2dtxfUVtJmNOKCFRR3fu2WqTXjH9DegQWHvKP9zeaBhAWG
 ZQndTzPrcIWRAuJYd5EvE7MILl0e/xtiXMh8mnDQbsu9n/41ZpNEIsis8c70C5JrRtVd
 QB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164993; x=1723769793;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egA3xRpkyqDRzibem82Wk57TPGhBhb+v8n5ItP4pcqI=;
 b=HcgEEbtnnN+KJRlc7Ui5c666cO6AltoLIgkHVFJPDEQl22xO8Q+Gu4OgOWoYEgxjWm
 eId3YzElp27BUMAQOxlwm+qwYWz9XYjBwhR2VhKezfvZUyJykEKNqdSioeHHRsfFmtTq
 tsgOVCP9sDJf1UZ5y808VHiV3yUo6c4pQSKh9dmqsD/vaejmdSNxOIRxRs3jNGgD1Kzb
 hiF2Wp4WsGwEXc6pZ3jXLpz3MPGeeOT/6dy5bOC9hwi71ON/PdXitzxzgJNeoArLkUM8
 Z+qEeoWgjkeq4ryuj8wlgxR26cX6ExsnSbD6qnIbaNNPhkNLdPjjfSt6sNg6G/12kKDg
 ylXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTjX1v4+g2A76zqgGkuR8MchlsYp308JCF6nsCZiW8CdcEgQOal5usCgJpeZtJmoZAzyLQORCsjVtJbdxkTTo6KVXSbw==
X-Gm-Message-State: AOJu0Ywx8TpqyFzTWfM3+t45mmKfkEF9FsUK2gAlwJCjcl9p0WziVrax
 Wda9RPikBHyQFzzRrWkW3KmwjsFzyoWzHbf+7xFcWlTrYqjRtKP6BMrvdAW4wVE=
X-Google-Smtp-Source: AGHT+IFenvWTCrvCRzU+/7trLcVi3K/Ou4s6atiXa9SVK6JwE6dytr+r5x8j9c/wRBri4oiJMdtp5Q==
X-Received: by 2002:a17:907:8690:b0:a7a:847d:63b7 with SMTP id
 a640c23a62f3a-a80aa67b2eamr92366b.59.1723164992847; 
 Thu, 08 Aug 2024 17:56:32 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:21 +0200
Subject: [PATCH v7 02/11] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-2-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk8UE9IZvJrFc+fG2gpznFdOyqNTWDT2SVJ7
 jfKYMjw3ZmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 tmXqD/9d6aQss7/Kl9KwDShdduArvb90ka2+nX49xpsvlEUosNMCcidS189kHUx/fEJTem9rMF0
 grujOsXiJGCFj5a8nrdxIH6k3iwSqSGPt9BjreKw48tBfw4CQxHvMy5x0YgLUVbwXsnI5b5wrp/
 P1mA4JE1/s48NrCkcSApGGVHdM1M1MO86alJrYCGF7kOuhTNlMGOI1SrlrjWAtYPkFV3ASYHeqj
 C50amPorCojAiS7DGD1/zHQsR+vAVQz8H0wrzXv+Le22idUqlv//cJNoS7k2y5L9kZHMBuuUk2o
 uLRz3SAj0gAz1hu/eGLm0bDEn6+l9Nc+XvzIPCvg39hJbrKN++AqsSlKbZ72n3UfmL4c8UH/Fta
 gIe29IZJLoMbipfv3tX63ndxPr3P/ATzrqa0hGvUXopZUZ3bY4g0nyqSriOyKGYHYMeuU3EBFtV
 m/XGMlD56nw5BHcOfYhcVENIOqSgHV/3djPtX6hLBsT87wwTwgodDnKRiIb0vn7aOUNYPbYZbOU
 Y5u6ixE/ax3hW+06q1SrIFCLQEtHTPb/sDqJKySL4GKZ+sSQW29XHM+3uj5Il8kl8v5z5+KeYt6
 heOtI043mlkGbKANvKtm0JY5AD9OOyGPyQEMPjFmraSBLPbdEdUMeucFvcJS+jbWI9ee0N/EVya
 ZwtwHNe1BL23ALQ==
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

