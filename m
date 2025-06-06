Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF0C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2AD82998;
	Fri,  6 Jun 2025 09:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+4RR1Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFEB82AAA; Fri,  6 Jun 2025 09:22:09 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243E881FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so1480124f8f.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749194526; x=1749799326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pm3l81gOpeKAaJm2xmk4hFixQgIl0YIPDG21WenYQJw=;
 b=P+4RR1JfnWIpth06S8RdHwOD6qcD6Sydo5Ra5rsritzlSUp1sZ/27XHpKWCICNNb6G
 HyYvhzLeInQ26keiIbJND3NZhFz8MOt/aevsEOtfUV/oqwdDe0jccssUsW7bikmysb9C
 pGfwgrNKoryzp5xOcRX62lIXQCV/aMr3Rz/cIU/ZlzQbLO3p9gw2EPswM7cG1Ag4NXyk
 JJxlX5y1R0l6hXddX1vpIk/n17jdMHvrtM4c+rHsYvPl311+hqNV+yQ3h19wkiT/Q37K
 eccaOAGwuchOz9N8ZgUx+tMU1t6Z64MYXCyePSYpc8r+9Pmwlo0J61YJaMx2/rYiMKW5
 Cdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194526; x=1749799326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pm3l81gOpeKAaJm2xmk4hFixQgIl0YIPDG21WenYQJw=;
 b=ssoHWHODmG+puxf6irkQZfYiAIpP9aFLuzVxisj/e6PeJyLgnbjZyqn5yIytaFoRjL
 ++1/it3UXq9vYQ/zkBATWJTUDF6NMU7bTYKsrwa80FIsI8bzhlr96ieGDJuVpp92ufhJ
 ji4KWoMpuTEd8CmpB0I3ZORUW2F0hXLmS5T3yGJUFEhs0l6PcwN604c+kcReHpCKxmtV
 /qMRlx7KpYI/jaYtMPsce43/yJUzAjgrJVECly/vODQ9HEcAYGwAzszue012d9qvpFD3
 v79yQCieP889puDMNrET1Ry4RbvY0oqpmiRri0tvfC3LSDsaHFwLCFQWwa/BQe9ojCri
 Vkiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeoi8pRr/SMHobopUeJudC/iEUxk5crUHHmfolmJ3P/6dnB59piImYptGVuGUVASUp5qesfBo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz46eGDZLxXZZN2hijszBUF815nH4tLxTsLzEVwCGJ2qRONxPz0
 BsaIzEeumcVnyT8IPDRtmvbGVJjUgd1RTG824hF9wpKlnVrmTL5DXkz9boegWg==
X-Gm-Gg: ASbGncuKzOJBm9Hd5Dm/uUL45ZPkGIvCo+uY0djZgxFoopUnZs7mDc7Nh6KWOmfgX0J
 MsyaIBh22GhXLp2XQn9cqY7B8Im+Xo36VicONTrv2zVvplV/5KoeFqaxCsgJsZu0pELSf9QX4/T
 DOal3oumG7ZStKa4QdSpw7mGKvkS0QX5dOvrqSZdYJI6BczLKYJiiw6rhz7goGe/k688N93VQyw
 riSdJIhFuZMxQCf1YJS63CMYxpgI5mGvIv/TI2PVE2cRQGJmJiSWO09BS/Ppq2q6B/hLcpAlsCA
 EgVBYsD2blW3oPAcPvYxJ3R5aDs2JCb4oCyj0wt7nIBkyPujm62cffgcIsz3cog0Zkti91OzUf/
 99UsP/2dcU/RV8oT6GThdr+LNNkfp7kM=
X-Google-Smtp-Source: AGHT+IEX9sFK1UAmBu12SV7jC5eaabkG2J3hzqqTsleieB0CDk5nIlKc6LMjadmM17Lx3lGn5MH+9g==
X-Received: by 2002:a05:6000:1a8d:b0:3a4:f379:65b6 with SMTP id
 ffacd0b85a97d-3a531ce8c77mr1909574f8f.46.1749194526216; 
 Fri, 06 Jun 2025 00:22:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm14666295e9.37.2025.06.06.00.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:05 -0700 (PDT)
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
Subject: [PATCH v3 1/5] linux/bitfield.h: sync <linux/bitfield.h> from Linux
 6.15
Date: Fri,  6 Jun 2025 09:21:30 +0200
Message-ID: <20250606072140.18824-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606072140.18824-1-ansuelsmth@gmail.com>
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
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

