Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75236C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B859C89172;
	Fri, 26 Apr 2024 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bOaXzmwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5738989175; Fri, 26 Apr 2024 16:19:46 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634318916C
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so2289467a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714141184; x=1714745984; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+ScOBSUPYQXRqu9uQCWgEfTwcS0jSDSxjEPh1D2tP14=;
 b=bOaXzmwaA6Tn2tUCGxFLrE9LwxzLE9N6x2f0L8nOaO+JJoAyw0BY5r3D+feUuBGmsh
 1xdVeEtfE4iYplLtLOdC6fgSLsXg6t9SSoGwPd70P5qYl9xGoKFx5aURZ9qw5tRWsnuP
 lUFBs7bFuholotCVjT3U3o0BgKL8PHY2i67qw6/Dp7AAH3z1zSNRHmXNq5YbSI9eho0n
 FW0rdFNFnZWcQVl1+v0HhlZ3dp+XlpAPV2RXzWy6VHKnHUOFS9DcsKCo1jeDmT/lWgx6
 9Tn1Agc2p3eyd2sBR77H9zu3AmGpGoS93iqi+4eRQwePlnRY5rzKvCemeDWNXtXp85bX
 1bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714141184; x=1714745984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ScOBSUPYQXRqu9uQCWgEfTwcS0jSDSxjEPh1D2tP14=;
 b=pRX6+qm0fqC5UD3t+n+8P4FfRx+1Ie1D0HJlD7bFv4uJSA/cG2BAKG+reU8Df/Wltx
 h14iwUR3K61SPHcTHvnRTJupegCY/Mm5A8StCdzlOgEDKgB/uquAs5aumA05dzseju7/
 EhuegEc2hXA5JfPIzXCPnU8QJg4nGwXhtgR+frCUa0njGA6FNSna2lp8pt5Jbhn8fKqf
 QJy43RFXVXs1xXvgpFNmUb9n29W8GrPMZdtYgE4kVob5+e80R+YthzCpPWAaQMgN5jDZ
 ImHextnpuY3rmQ2Xs82glUpAoak8iCo1JOfjyjPtNH/ObJer8e0Hxm04p+MlZAEHikQy
 t+1A==
X-Gm-Message-State: AOJu0YyYQQ3Ct/r5325wwqXWvAJGo7eXT5Hv2xUOeeC2feQPyBU/05lJ
 LHxDEfiywdpG2/Pz+zgE457KCTCv7b+j7MY3MrWIdATUfheJ8+5J5fyO7txFg+k=
X-Google-Smtp-Source: AGHT+IH6K9jn4J6xkGb4k5Mgmze1LwTsSPmoP8vs0zNgTyx2duoR+mAqSbKTS5gmYbTQnZVmCjIl2g==
X-Received: by 2002:a50:a412:0:b0:56e:4676:aa3a with SMTP id
 u18-20020a50a412000000b0056e4676aa3amr1958720edb.16.1714141183721; 
 Fri, 26 Apr 2024 07:19:43 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::9b06])
 by smtp.gmail.com with ESMTPSA id
 ds2-20020a0564021cc200b0057059d26756sm10041182edb.76.2024.04.26.07.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:19:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 26 Apr 2024 16:19:35 +0200
Subject: [PATCH RFC 1/4] lib: uuid: add UUID v5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-b4-dynamic-uuid-v1-1-e8154e00ec44@linaro.org>
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Hughes <hughsient@gmail.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=aV5bH35ybwlKtxSbQ79Rylaa2GjcuTfETF6uF8NdPD8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmK7f95Pb4O+Gxi2/fjdzoBFfDtT0Psee7c5Op3
 bVlu2DdawmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZiu3/QAKCRAFgzErGV9k
 tieoD/9OGhKSb3Ap+olqSIJenxzlV3rRh41GtDPjmzlvgBMMJsC+NLSnmGCNJdym4fvBfebarkT
 /LjxQ8zAem5eSkEzDkB2eZtSJqt5Pg0z+eNsRkoj5kOurHTTofeATUC4otPjuVFnd+eRcHKn5+T
 dUOf1gpTB8R+fCPJO/whi7AQIdJ9NF7dlxh6eoWUe23BiGElXIII5/jR3sIb8TO2QJZWHLgtVcI
 G62u8VnI28lmR8lzz9vM1F/5oJaYKCmpmIErPYvHAr72/BDKf989L5/jqw/0rDMHMSqgLwPmbUZ
 FW9U4bgBsdho+jmB88Fqc6vH4Q5ly/TemdUCr8fBLulW0BBmctEztLyhRgUmqHyAO9V+1U6yXR1
 MRpKpZlVUsJXJjZ5BgnTy0EYKomk2X+ZXZi7aZy3LaU0J2zl22ewqeldbUh/HJdYjZczEP09Md+
 /OL/OttptCJiaMhd7kBsrI+zAfOvDT3Bt5QRBRvqZ8j1gqQCcQ8tnWHTlnDeb0IjKPQtiEQVeVZ
 UAVB4E31Y6hVN53KSCRUmUwUzJhLVL+9sHy8pC4dQ0qovKefJCdxpIoXY0LPaRPUIltH0gp5Ef1
 dC6utDxdqysLqBCm0jH/DDc4xpxLJ7ZpnImXsZMWmdOiDC6Bup6Gu4EqpTs0rtH4wkM+BcIp46Z
 2a/WIBWn45wE97Q==
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
 include/uuid.h | 16 ++++++++++++++++
 lib/Kconfig    |  8 ++++++++
 lib/uuid.c     | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/uuid.h b/include/uuid.h
index f5a941250f48..229b938d866a 100644
--- a/include/uuid.h
+++ b/include/uuid.h
@@ -142,8 +142,24 @@ void gen_rand_uuid(unsigned char *uuid_bin);
  * @param          - uuid output type: UUID - 0, GUID - 1
  */
 void gen_rand_uuid_str(char *uuid_str, int str_format);
 
+#if CONFIG_IS_ENABLED(UUID_GEN_V5)
+/**
+ * gen_uuid_v5() - generate UUID v5 from namespace and other seed data.
+ *
+ * @namespace:   pointer to UUID namespace salt
+ * @uuid:        pointer to allocated UUID output
+ * @...:         NULL terminated list of seed data as pairs of pointers
+ *               to data and their lengths
+ */
+void gen_uuid_v5(struct uuid *namespace, struct uuid *uuid, ...);
+#else
+static inline void gen_uuid_v5(struct uuid *namespace, struct uuid *uuid, ...)
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
index 2d7d99535e72..e7fda8dc736d 100644
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
@@ -368,8 +369,40 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 		}
 	}
 }
 
+#if CONFIG_IS_ENABLED(UUID_GEN_V5)
+void gen_uuid_v5(struct uuid *namespace, struct uuid *uuid, ...)
+{
+	sha1_context ctx;
+	va_list args;
+	const u8 *data;
+	u8 hash[SHA1_SUM_LEN];
+
+	sha1_starts(&ctx);
+	/* Hash the namespace UUID as salt */
+	sha1_update(&ctx, (char *)namespace, UUID_BIN_LEN);
+	va_start(args, uuid);
+
+	while ((data = va_arg(args, const u8 *)))
+		sha1_update(&ctx, (char *)data, va_arg(args, int));
+
+	va_end(args);
+	sha1_finish(&ctx, hash);
+
+	/* Truncate the hash into output UUID and convert it to big endian */
+	cpu_to_be32_array((u32 *)uuid, (u32 *)hash, 4);
+
+	/* Configure variant/version bits */
+	clrsetbits_be16(&uuid->time_hi_and_version,
+			UUID_VERSION_MASK,
+			5 << UUID_VERSION_SHIFT);
+	clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
+		     UUID_VARIANT_MASK,
+		     UUID_VARIANT << UUID_VARIANT_SHIFT);
+}
+#endif
+
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
 	u32 ptr[4];

-- 
2.44.0

