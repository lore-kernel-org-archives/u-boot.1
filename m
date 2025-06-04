Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F784C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 17:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F99801BE;
	Wed,  4 Jun 2025 19:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKigS6ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F99807B1; Wed,  4 Jun 2025 19:03:14 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7697A8006D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 19:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so30777f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749056592; x=1749661392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1IzZmYiUQdVgVm1Kibt5L1vYz6otECFUZwX72EWv6do=;
 b=fKigS6ZH22l/mxGKq7ael8h1bjS+/9pHikuxS+hm6XXGIKMO8l6HmKWwAzyW4RhNGa
 wSZdRuQRRC3SeWXjKg9pQZbhvbhnHkNMsKl40GbsGkW+2KsRbdkoI0/AX7dyNy2nJEgt
 anffjEh1T8DXi3j32YcIlUcRGSN6GPGj1g6mNQFVYoDjBhiW50gvYoQR1dAE9ABm6avZ
 7uWxEXCygdM4ClTl5YJoWv9vzzdgFtBy1dEc065AOelDmAEUN0oa9gqJ3C5dJA0uu4zD
 sjyr5ePpD9pDXthbIZihXCYiRz4x7HvYvtzk2VN/sQ8D1UzxazzXBAOxk8D5hjwc1taT
 Fu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749056592; x=1749661392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1IzZmYiUQdVgVm1Kibt5L1vYz6otECFUZwX72EWv6do=;
 b=rFoh8dNPaVs7apAJUX9v62Coi0oHV4TLzJvEZiHE8eTbnLJjyCo9yLTvD8pTVJ9xdf
 8xYjeXJvbdqWQqshMbpNkWEuZIumWVi8UZkcRQhULYi5EW5XWIx8/Pxkh4BOPi8OxrJy
 wyI0l/FBgmSz62C6eSBtlOZGXW4Te4i607HFBuKp6gOeQrRpXSvtKOGjffXZRk7wpA34
 avwei6R/49rgCb7NQzzEaTY25ZbNyKHQcdOa6thKR05y3t6wc72Po0N4g9Hw2XFGj5u0
 XlF49LBPScfqk99d9lv3dUT1uOpLA6r+sNTHCKnaYRXkHDF0p5cC7Gl3yU4RpKgIQ0eR
 pOlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX97+1QCOKeW1vfn+xNlqoh1IhLb1cIFcQoEWL1YpnpB24vbEcLydaPr1KTFVwdlevZo4E5qhA=@lists.denx.de
X-Gm-Message-State: AOJu0YxVLmCYEOnhi415Zq7qb9LMeFb13lAUjDG7UILElUAUheVbxr2Y
 ZBccOyXcNMbXhvBGKdVS5mcSNfEH7uHWiq+xHHDxRvt5HWfyk8e2D88r
X-Gm-Gg: ASbGnctS9elgsJ+tm2ddLsPteJmgDt+1+5GNFOd6HHUlFY0pVB7D26RuO+A0djHgU5p
 2Zi8UvJJOAQ5bSYPs0yvxwQWsQP+8UcBApUl+XZeqPd0CsxzMuCEcJC0FEhmGXVxGI/htifr2uN
 lptlNw/Vb45zNNKgYKZqqKTwj12/JSvlgMsUcNoX9+/e3chm9lUC/N6iPMqUxtlCmbt+vbs1/1A
 M0DXy77aZg3rEuPEfrEdGak7knpaxV3nJonjHczOQMpafvEebwBm3bE9YrZ6zlTr2daXDa3RjDG
 d8LNtXLHioOSM3pqygo8sD7EN8wUbF+W5LKumpdkFy8ZszHlNyupWNZv+IByDdVZSROHW+Hogzn
 brJDr60GIYY2j8xMWpHRE
X-Google-Smtp-Source: AGHT+IHPJPMT2RHH9YIpJ2utbNvERDWJeFJhXa04fGErCzbzOCRdQ7kB4JUbjMFUn5wiAlTmwEGMMQ==
X-Received: by 2002:a05:6000:2912:b0:3a4:eda1:6c3b with SMTP id
 ffacd0b85a97d-3a51d96df64mr3122352f8f.45.1749056591391; 
 Wed, 04 Jun 2025 10:03:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a13fasm22608825f8f.98.2025.06.04.10.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:03:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/2] linux/bitfield.h: sync <linux/bitfield.h> from Linux
 6.15
Date: Wed,  4 Jun 2025 19:02:38 +0200
Message-ID: <20250604170246.5354-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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
Changes v2:
- Copy the full file instead of cherry-pick Changes

This is being CI tested on [1]. Locally compile and works on
my build system.

[1] https://github.com/u-boot/u-boot/pull/777

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

