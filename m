Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB598C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 21:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABF182B45;
	Sat,  7 Jun 2025 23:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AmcwSP8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89ED582A9E; Sat,  7 Jun 2025 23:12:11 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C28182A9E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 23:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so32647115e9.3
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749330728; x=1749935528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pm3l81gOpeKAaJm2xmk4hFixQgIl0YIPDG21WenYQJw=;
 b=AmcwSP8ovHIiO4EGstSJcwc/gybzv+xYNB+O52tT4/fc3f/nQy+WEgvCHYNS9hGX/5
 KmKymSOInv42sJwTQMNoeaYFV/2p3SqX/c4++qC8ehQigsprZ8Vna5tmiTVgySvYcRzF
 eVoGFoNj5jmvv1lupjQ+cd8R/Vyb8h6qOuKbiA4PINQvBjYCR5k6tGiAqvJx7Jyvo37k
 gjo5xfdC4fyUPS7tUJefgW3hYtq9y67uSHZvSEo/aHxbwZStvqu7m3WRanH4Wmqqhm5V
 gIKvDJhJZVboqtlUWSJ2oaeL5vVzEgvj+CTayNZLefDW+2v9qBJ7rM27i6CxLoaX6zt1
 5QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749330728; x=1749935528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pm3l81gOpeKAaJm2xmk4hFixQgIl0YIPDG21WenYQJw=;
 b=ZbWy8TAtS4vKtpaGUr0zi99zp8esNQ9KYLzw0Jyrro7vyhC21bTQGDGM6Ox0ZbPXtf
 kRnWPJ5sV5RpJUXamdw5hwk2Unnvje1ipcUhtRr9EgvDFkJQbSc2x1vYzEhiNkamnCC9
 pAKxRpF6aXVnQhCBqOqmstQJfIMT7ft7nDlg3oiqvxRKAvjowUZMbM0pVsX07uNClO38
 yjeDqmHvSSVBxN0znBXq761eu3E/Ze3setNJfq5jYCaQbQdEfgDSEp91r/s7XbqZ7dcw
 +T3E8y9XxsVAyiBWYaP/vqYSTTne4UgwSy19ut3gHLq0ZDiQancBQagb6V1E0v+5Zo9b
 z00g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmM6sZktJ0uhPCOR0IBT5khyW0MyXDKhPBjmitRGywk4y/PRhC/ula2f3iMZeMFG0GsDBnoE8=@lists.denx.de
X-Gm-Message-State: AOJu0YxTHTYRVepUZAphAFTdVUdOFbV5FHiPzd59fv+3ihizgLtI+Fk4
 0rIDx+aYZaikHQeoxFkuORyUsrmruw2usYZ4WirqmFAr3MuxvsWOsRno
X-Gm-Gg: ASbGncu/w0D8/kmLASdgUN8+JpMG6KZ7vH1oRrOMhdoBGQtUFTXKmCVmd5FkPh0vTvN
 3V2daWrggfUlsfSPQmJXXu9rKUKvksxxb8H2wNSHDKDHwBHHk/F7/91GQBgZOiC2HGRDW9SIgtI
 /d7Mw7OFqLV6kCrb/hZi8p+VOvpnvzqOEEMNV8YQeD3nqLoHRNDET1SY2iLYT31n+Q8Kq0YxFc4
 ysLsp7OaBBxyLmjQ1Y0732ceO7r+BMIrM04ln6R5DxnAEUTp2blKM0F3gUZsHGQKD8pZokgU/yF
 E/EnaIVb/z1lsgaFluzxASRPrXsba/Bl5WMGuMLlP7cu5juFM7hLSb/7RBr7BFYU0AXg0UQXnLK
 LliqSe8iOHvnHFqpMgGxa7VkWPxXdylg=
X-Google-Smtp-Source: AGHT+IHifkXYhh8SdJfL7AtKd+uujU+78tGf1lZVx4QXrEz8AemtYX2HAkmAmMT/rz+xe86UEYa90Q==
X-Received: by 2002:a05:600c:3aca:b0:450:cf01:7310 with SMTP id
 5b1f17b1804b1-452013914bcmr84600255e9.12.1749330728338; 
 Sat, 07 Jun 2025 14:12:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4526e155ce7sm64368245e9.10.2025.06.07.14.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 14:12:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 4/5] linux/bitfield.h: sync <linux/bitfield.h> from Linux
 6.15
Date: Sat,  7 Jun 2025 23:11:20 +0200
Message-ID: <20250607211133.2005-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607211133.2005-1-ansuelsmth@gmail.com>
References: <20250607211133.2005-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync bitfield.h header with Linux 6.15 version. Mainly is to permit the
introduction of FIELD_PREP_CONST. The bug.h header changed to
build_bug.h doesn't cause any regression as we also ship split header
similar to how it's done with in Linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/bitfield.h | 103 ++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 28 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 7ad02f8cbb9..63928f17322 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -1,21 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2014 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _LINUX_BITFIELD_H
 #define _LINUX_BITFIELD_H
 
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <asm/byteorder.h>
 
 /*
@@ -27,6 +19,9 @@
  *
  * Example:
  *
+ *  #include <linux/bitfield.h>
+ *  #include <linux/bits.h>
+ *
  *  #define REG_FIELD_A  GENMASK(6, 0)
  *  #define REG_FIELD_B  BIT(7)
  *  #define REG_FIELD_C  GENMASK(15, 8)
@@ -49,20 +44,51 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
+#define __scalar_type_to_unsigned_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(unsigned type)0
+
+#define __unsigned_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			char:	(unsigned char)0,			\
+			__scalar_type_to_unsigned_cases(char),		\
+			__scalar_type_to_unsigned_cases(short),		\
+			__scalar_type_to_unsigned_cases(int),		\
+			__scalar_type_to_unsigned_cases(long),		\
+			__scalar_type_to_unsigned_cases(long long),	\
+			default: (x)))
+
+#define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
+
 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
 				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero");	\
+		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
 		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
-				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
+				 ~((_mask) >> __bf_shf(_mask)) &	\
+					(0 + (_val)) : 0,		\
 				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,		\
+		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
+				 __bf_cast_unsigned(_reg, ~0ull),	\
 				 _pfx "type of reg too small for mask"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \
 	})
 
+/**
+ * FIELD_MAX() - produce the maximum value representable by a field
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * FIELD_MAX() returns the maximum value that can be held in the field
+ * specified by @_mask.
+ */
+#define FIELD_MAX(_mask)						\
+	({								\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+	})
+
 /**
  * FIELD_FIT() - check if value fits in the field
  * @_mask: shifted mask defining the field's length and position
@@ -72,7 +98,7 @@
  */
 #define FIELD_FIT(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");	\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
 		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
 	})
 
@@ -90,10 +116,36 @@
 		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
 	})
 
+#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
+
+/**
+ * FIELD_PREP_CONST() - prepare a constant bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_CONST() masks and shifts up the value.  The result should
+ * be combined with other fields of the bitfield using logical OR.
+ *
+ * Unlike FIELD_PREP() this is a constant expression and can therefore
+ * be used in initializers. Error checking is less comfortable for this
+ * version, and non-constant masks cannot be used.
+ */
+#define FIELD_PREP_CONST(_mask, _val)					\
+	(								\
+		/* mask must be non-zero */				\
+		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		/* check if value fits */				\
+		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		/* check if mask is contiguous */			\
+		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
+		/* and create the value */				\
+		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+	)
+
 /**
  * FIELD_GET() - extract a bitfield element
  * @_mask: shifted mask defining the field's length and position
- * @_reg:  32bit value of entire bitfield
+ * @_reg:  value of entire bitfield
  *
  * FIELD_GET() extracts the field specified by @_mask from the
  * bitfield passed in as @_reg by masking and shifting it down.
@@ -108,20 +160,18 @@ extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
 __bad_mask(void);
-
 static __always_inline u64 field_multiplier(u64 field)
 {
 	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
 		__bad_mask();
 	return field & -field;
 }
-
 static __always_inline u64 field_mask(u64 field)
 {
 	return field / field_multiplier(field);
 }
-
-#define ____MAKE_OP(type, base, to, from)				\
+#define field_max(field)	((typeof(field))field_mask(field))
+#define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
 	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
@@ -133,26 +183,23 @@ static __always_inline __##type type##_replace_bits(__##type old,	\
 {									\
 	return (old & ~to(field)) | type##_encode_bits(val, field);	\
 }									\
-static __always_inline void type##p_replace_bits(__##type * p,		\
+static __always_inline void type##p_replace_bits(__##type *p,		\
 					base val, base field)		\
 {									\
 	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
 }									\
 static __always_inline base type##_get_bits(__##type v, base field)	\
 {									\
-	return (from(v) & field) / field_multiplier(field);		\
+	return (from(v) & field)/field_multiplier(field);		\
 }
-
 #define __MAKE_OP(size)							\
-	____MAKE_OP(le##size, u##size, cpu_to_le##size, le##size##_to_cpu) \
-	____MAKE_OP(be##size, u##size, cpu_to_be##size, be##size##_to_cpu) \
-	____MAKE_OP(u##size, u##size, ,)
-
-____MAKE_OP(u8, u8, ,)
+	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
+	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
+	____MAKE_OP(u##size,u##size,,)
+____MAKE_OP(u8,u8,,)
 __MAKE_OP(16)
 __MAKE_OP(32)
 __MAKE_OP(64)
-
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
-- 
2.48.1

