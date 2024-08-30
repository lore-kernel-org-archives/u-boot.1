Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE85CA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C3588C20;
	Fri, 30 Aug 2024 14:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rrBNaTAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF7088BDE; Fri, 30 Aug 2024 14:34:40 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1151E88BBC
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-371b2e95c34so1043765f8f.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021277; x=1725626077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wWcgvpeFi5VpCZSZBuDE81Oi1RID+Jh+SdhJoMRzmwE=;
 b=rrBNaTAUbH3vwjC0PPrtp1GMbFor3z0bXse5smlGQpty4xGmLz0D+3opKXDjVIHZTz
 tUnocictD74Upo13M8ZC6iCDOqZjRrCf+uRGsQAfHNR7CkZkF1B0J/B1PPS3HOkxZOZt
 Ai602ejJHJQMM1BqszGDs6lomyvFTZfhmdV0eX/cpaT0YB6kXAl2IDitGWiAGbEO0iad
 GAFy3t/U9msYZ2+iyVbgtRRXnJ3RMB1WNcbXm1HuRuNbGjNIjOvrzmrDwhyNX8AmsXsk
 Vxre/iYpJw/bpCLowZuErAepGq6utVi0F7S5cIki8lxRPKwQivf6n+xpSSfXxVm2XAlC
 /L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021277; x=1725626077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWcgvpeFi5VpCZSZBuDE81Oi1RID+Jh+SdhJoMRzmwE=;
 b=kG1AjfxwFWCsk9HgbGqZHi3Q180usB/BDo9hof0UbKDt3RM9nO5Gkg+SK3MuNvFzSm
 rJbAWptAzyiZTDZqNde20/SkVGAYVTSGXVH3zpMHqQOsbsixdvqHOQvdw+ZYayBe2XN+
 qagUpu/M2UVEoSQ2TLdB5u7MGsl7gByPZiNTi5DoNdOUSWQFxssXlwrO2m/JV8BNFusI
 6RXoh40u2Wmzyr373sXmMnrOMtzbKv6WxDQSRw8tRSLhsrR1BMbEdAiANsJFuqF7A+8y
 znGdoqcg+YRJsZDUd8IXu3zz5W8xfl61mW/KjzoTHKXpGyLvaoRwIOglosuy/UqlNjPu
 YcFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsw7H6/LATJ4r0eFO5XJDBAgCWGvpNFGmoO/rUo+M/lsXsWB3R9SOoPRzNsB0Hbb2kzBODIE0=@lists.denx.de
X-Gm-Message-State: AOJu0YxAtICC2lX7L53bGq8cHUpvd0ml94x6mE8iXe3yxVfHnlDKfiOk
 YJxSFxP9GR6VSEtZoAoG0bNEbf98EcNZns0VVznsgG+SPTuWVqnszI4dOdnS3wo=
X-Google-Smtp-Source: AGHT+IG5jNnAtowUl9WLamprEZ5+2S56Ai0zjKIJzSun4TnvOrKt2SVqD55CngjJ5invIPGnasZ8Gw==
X-Received: by 2002:a05:6000:e44:b0:368:3789:1b6 with SMTP id
 ffacd0b85a97d-3749b589779mr4319696f8f.47.1725021277264; 
 Fri, 30 Aug 2024 05:34:37 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:32 +0100
Subject: [PATCH v8 02/11] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-2-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5505;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=UyWycvTmTLWqQjiIAg+pJ3mFYfmr6TmwDDOF4d8Bxlo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxZhg78vWBx7WiInWPwNeJDREosCOaS2I3Ix
 73vC29YJKCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WQAKCRAFgzErGV9k
 trB0D/48XCGfYau39U+sJQTq9GywwfWIvWPP/bEPODIq0kDE192cTIfFFgNXAh1Ldv/EeM+Wx17
 76srF4w5HwrkxkjyoMrnqB9IN6UcGNB2f+99q0bKkag3UX3ahxyf6tWpDKpafjij4eyMOyGxzCi
 9yC87X8mdMMMc80GzatH5ZW4iMHfjt87QaaDD/LHnQAIb4vkn43bE60IS3yJl5z+cfcMVQywJIR
 kaJymzxA+QpPIfKb5mTMyg6IB2/zh257LIssJNBw7FRnjcdQmqclMmI7M2EruQBIVTA+47l2Ugq
 zyTqmjrn3z2HC2FUCCWksAAr2yRdGrpsiEGV3YQPx6JKsKvsVhUpl8Ze1Z76/HCrIj+OwQRtIRD
 CSlWXGTBOnECR4TxFeV79Lcj3ITOjcoGSmMu4BYCYu8Y4LRyB7tiCO5gKC1ZABE4eWoZJS0K6P8
 xOWV7sDZra39IIgp9WcYI4goYgGSQCG6C44HuBL7VqmeRXUHNlnQFx5BansaI37OVZtA4VtT+TQ
 vLz3ZLK+TBEXF7F5sF89qCxMIAgynSpVHlxgHmPRgU3c83wNDwLnAFv+9A6UyKDnmUzd2shYN4w
 IIZ4Iv7RG6XDD1n0XONpKE3ymbohy5d8HJkZVzVG9Zlabas4+t1UDxWC8FOhKe5B3aQzoqYcCmf
 6H4JOgdMA47U/Gg==
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/uuid.h | 17 +++++++++++++++--
 lib/Kconfig    |  1 +
 lib/uuid.c     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 68 insertions(+), 9 deletions(-)

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
index dfa2320ba267..c9dfdf007a18 100644
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
@@ -368,8 +369,58 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
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
+
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
@@ -394,15 +445,9 @@ void gen_rand_uuid(unsigned char *uuid_bin)
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

