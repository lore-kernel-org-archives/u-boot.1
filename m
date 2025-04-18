Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A84C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 10:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A3982CFD;
	Fri, 18 Apr 2025 12:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e4feAEwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A48830A0; Fri, 18 Apr 2025 12:59:38 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82B382CFD
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 12:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85e751cffbeso138779539f.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744973973; x=1745578773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D17CJO8IDH1lUrvy8/D0Fnd+d6/sA0+lWTISHAemp6A=;
 b=e4feAEwejGfQqjTBOKINfvuseZzRhiu/YY9tIf51CO5bvVLWk8hivQM5+jl1uzTE0l
 Zt+BjRRBb05n6ueKOwlreNOAdLBiotYxh9xi+ZveEbJAloPhkHiY8QEuOIeB5ytE956D
 kUN4zcuIu8CPFtq8X0PfnmuztBeEd6kA/NCQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744973973; x=1745578773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D17CJO8IDH1lUrvy8/D0Fnd+d6/sA0+lWTISHAemp6A=;
 b=LRWrxQf11H610wlwQXhzJ/jcal1Tub5NeFVlHg6g8qcqZrfQNyJ8jh9IoZCfLL7ICa
 WBECqaLT0xi3GghG/Zxn51vbKZ9h4fm2lwq68kHZw21Wr4kZJghbVsOsiyUG+IYrhZUN
 mvvCoFgyWOIgJkHMcwy+OSm3qmLBb2oHjDkLxveqRU/6mpLwH1JbMHWAkseHHeGFha0w
 kkEXTz7EIXvgufyCq592qBpbBNAznl+ZF9cRnLX9JryDuTkUOiWm3UCP8mYGr9rBlZh2
 OPFZmcTS/mmY/+kCFWTvqL9ocBCoaJXX5B5GEcqg8YoOARvdvLCJsyOEsazkulGicej1
 joGg==
X-Gm-Message-State: AOJu0YxDFEpdtJIbwp+stgqLdGhU3A3XZpFTA4shliZSr+/7mT5rKZkW
 KEMMYCkWGvsZCvNxY5Gupe2I5a2vW4+6Lnk7nIXyPeRc5dOzK8V1zD8BygjtNmpZZELyTgYtxoo
 =
X-Gm-Gg: ASbGncuB3vmGwqFobU8yKLpyOV1TkOgZd+y/Y2+y923Yt8ZJtQzhUl28zE3oO/EEORH
 AIfiXBqMXFJ4vSndc2XIW/nculTYK4YZRdPTBs53kmCH3BGrb0XtNdDBDRsUIJOHG3KiYKL6XL1
 NkIFVO6THXUMGCGr3RZf+sV+c4AaPWHVV1rYlpmiPa2hhgZEPTUsA2Kb5vjTfw1EcydF/+PanJY
 /K+3aAiPTGPSkS7dDpURAOPicCEriFRNRvgWiphCVecpvCML8aMf/uA1FbWi++I353I7vpTOdIv
 wzGVN7/n9mBH/kaExrXyT9+WdQorr+NMwC23q+slkMa1AQyHhA/0NvzkFlzQ2kg6v2vNSYeOB+E
 dfw==
X-Google-Smtp-Source: AGHT+IGU5yUyB7THMIABq0iB56Z9KM/Hqy0Pez4AkacZOFEuSAug96ll1QKk0/wR5lMK+1NFtz/ZIg==
X-Received: by 2002:a05:6602:3787:b0:85d:b7a3:b84d with SMTP id
 ca18e2360f4ac-861dbede5d2mr196366939f.13.1744973973386; 
 Fri, 18 Apr 2025 03:59:33 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a395765esm380588173.107.2025.04.18.03.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 03:59:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] Bring in linux/overflow.h
Date: Fri, 18 Apr 2025 04:59:14 -0600
Message-ID: <20250418105919.1645824-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418105919.1645824-1-sjg@chromium.org>
References: <20250418105919.1645824-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add this file from Linux v6.14 so we can use it to add overflow checks,
rather than using compiler built-ins directly.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Add new patch to bring in linux/overflow.h

 include/linux/overflow.h | 443 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 443 insertions(+)
 create mode 100644 include/linux/overflow.h

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
new file mode 100644
index 00000000000..0c7e3dcfe86
--- /dev/null
+++ b/include/linux/overflow.h
@@ -0,0 +1,443 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+#ifndef __LINUX_OVERFLOW_H
+#define __LINUX_OVERFLOW_H
+
+#include <linux/compiler.h>
+#include <linux/limits.h>
+#include <linux/const.h>
+
+/*
+ * We need to compute the minimum and maximum values representable in a given
+ * type. These macros may also be useful elsewhere. It would seem more obvious
+ * to do something like:
+ *
+ * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
+ * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
+ *
+ * Unfortunately, the middle expressions, strictly speaking, have
+ * undefined behaviour, and at least some versions of gcc warn about
+ * the type_max expression (but not if -fsanitize=undefined is in
+ * effect; in that case, the warning is deferred to runtime...).
+ *
+ * The slightly excessive casting in type_min is to make sure the
+ * macros also produce sensible values for the exotic type _Bool. [The
+ * overflow checkers only almost work for _Bool, but that's
+ * a-feature-not-a-bug, since people shouldn't be doing arithmetic on
+ * _Bools. Besides, the gcc builtins don't allow _Bool* as third
+ * argument.]
+ *
+ * Idea stolen from
+ * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
+ * credit to Christian Biere.
+ */
+#define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
+#define __type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
+#define type_max(t)	__type_max(typeof(t))
+#define __type_min(T) ((T)((T)-type_max(T)-(T)1))
+#define type_min(t)	__type_min(typeof(t))
+
+/*
+ * Avoids triggering -Wtype-limits compilation warning,
+ * while using unsigned data types to check a < 0.
+ */
+#define is_non_negative(a) ((a) > 0 || (a) == 0)
+#define is_negative(a) (!(is_non_negative(a)))
+
+/*
+ * Allows for effectively applying __must_check to a macro so we can have
+ * both the type-agnostic benefits of the macros while also being able to
+ * enforce that the return value is, in fact, checked.
+ */
+static inline bool __must_check __must_check_overflow(bool overflow)
+{
+	return unlikely(overflow);
+}
+
+/**
+ * check_add_overflow() - Calculate addition with overflow checking
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns true on wrap-around, false otherwise.
+ *
+ * *@d holds the results of the attempted addition, regardless of whether
+ * wrap-around occurred.
+ */
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
+
+/**
+ * wrapping_add() - Intentionally perform a wrapping addition
+ * @type: type for result of calculation
+ * @a: first addend
+ * @b: second addend
+ *
+ * Return the potentially wrapped-around addition without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_add(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_add_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
+/**
+ * wrapping_assign_add() - Intentionally perform a wrapping increment assignment
+ * @var: variable to be incremented
+ * @offset: amount to add
+ *
+ * Increments @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_assign_add(var, offset)				\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_add(typeof(var), *__ptr, offset);	\
+	})
+
+/**
+ * check_sub_overflow() - Calculate subtraction with overflow checking
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns true on wrap-around, false otherwise.
+ *
+ * *@d holds the results of the attempted subtraction, regardless of whether
+ * wrap-around occurred.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
+
+/**
+ * wrapping_sub() - Intentionally perform a wrapping subtraction
+ * @type: type for result of calculation
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ *
+ * Return the potentially wrapped-around subtraction without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_sub(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_sub_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
+/**
+ * wrapping_assign_sub() - Intentionally perform a wrapping decrement assign
+ * @var: variable to be decremented
+ * @offset: amount to subtract
+ *
+ * Decrements @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_assign_sub(var, offset)				\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_sub(typeof(var), *__ptr, offset);	\
+	})
+
+/**
+ * check_mul_overflow() - Calculate multiplication with overflow checking
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns true on wrap-around, false otherwise.
+ *
+ * *@d holds the results of the attempted multiplication, regardless of whether
+ * wrap-around occurred.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
+
+/**
+ * wrapping_mul() - Intentionally perform a wrapping multiplication
+ * @type: type for result of calculation
+ * @a: first factor
+ * @b: second factor
+ *
+ * Return the potentially wrapped-around multiplication without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_mul(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_mul_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
+/**
+ * check_shl_overflow() - Calculate a left-shifted value and check overflow
+ * @a: Value to be shifted
+ * @s: How many bits left to shift
+ * @d: Pointer to where to store the result
+ *
+ * Computes *@d = (@a << @s)
+ *
+ * Returns true if '*@d' cannot hold the result or when '@a << @s' doesn't
+ * make sense. Example conditions:
+ *
+ * - '@a << @s' causes bits to be lost when stored in *@d.
+ * - '@s' is garbage (e.g. negative) or so large that the result of
+ *   '@a << @s' is guaranteed to be 0.
+ * - '@a' is negative.
+ * - '@a << @s' sets the sign bit, if any, in '*@d'.
+ *
+ * '*@d' will hold the results of the attempted shift, but is not
+ * considered "safe for use" if true is returned.
+ */
+#define check_shl_overflow(a, s, d) __must_check_overflow(({		\
+	typeof(a) _a = a;						\
+	typeof(s) _s = s;						\
+	typeof(d) _d = d;						\
+	unsigned long long _a_full = _a;				\
+	unsigned int _to_shift =					\
+		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
+	*_d = (_a_full << _to_shift);					\
+	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
+	(*_d >> _to_shift) != _a);					\
+}))
+
+#define __overflows_type_constexpr(x, T) (			\
+	is_unsigned_type(typeof(x)) ?				\
+		(x) > type_max(T) :				\
+	is_unsigned_type(typeof(T)) ?				\
+		(x) < 0 || (x) > type_max(T) :			\
+	(x) < type_min(T) || (x) > type_max(T))
+
+#define __overflows_type(x, T)		({	\
+	typeof(T) v = 0;			\
+	check_add_overflow((x), v, &v);		\
+})
+
+/**
+ * overflows_type - helper for checking the overflows between value, variables,
+ *		    or data type
+ *
+ * @n: source constant value or variable to be checked
+ * @T: destination variable or data type proposed to store @x
+ *
+ * Compares the @x expression for whether or not it can safely fit in
+ * the storage of the type in @T. @x and @T can have different types.
+ * If @x is a constant expression, this will also resolve to a constant
+ * expression.
+ *
+ * Returns: true if overflow can occur, false otherwise.
+ */
+#define overflows_type(n, T)					\
+	__builtin_choose_expr(__is_constexpr(n),		\
+			      __overflows_type_constexpr(n, T),	\
+			      __overflows_type(n, T))
+
+/**
+ * castable_to_type - like __same_type(), but also allows for casted literals
+ *
+ * @n: variable or constant value
+ * @T: variable or data type
+ *
+ * Unlike the __same_type() macro, this allows a constant value as the
+ * first argument. If this value would not overflow into an assignment
+ * of the second argument's type, it returns true. Otherwise, this falls
+ * back to __same_type().
+ */
+#define castable_to_type(n, T)						\
+	__builtin_choose_expr(__is_constexpr(n),			\
+			      !__overflows_type_constexpr(n, T),	\
+			      __same_type(n, T))
+
+/**
+ * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
+ * @factor1: first factor
+ * @factor2: second factor
+ *
+ * Returns: calculate @factor1 * @factor2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
+{
+	size_t bytes;
+
+	if (check_mul_overflow(factor1, factor2, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+/**
+ * size_add() - Calculate size_t addition with saturation at SIZE_MAX
+ * @addend1: first addend
+ * @addend2: second addend
+ *
+ * Returns: calculate @addend1 + @addend2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_add(size_t addend1, size_t addend2)
+{
+	size_t bytes;
+
+	if (check_add_overflow(addend1, addend2, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+/**
+ * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
+ * @minuend: value to subtract from
+ * @subtrahend: value to subtract from @minuend
+ *
+ * Returns: calculate @minuend - @subtrahend, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. For
+ * composition with the size_add() and size_mul() helpers, neither
+ * argument may be SIZE_MAX (or the result with be forced to SIZE_MAX).
+ * The lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
+{
+	size_t bytes;
+
+	if (minuend == SIZE_MAX || subtrahend == SIZE_MAX ||
+	    check_sub_overflow(minuend, subtrahend, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+/**
+ * array_size() - Calculate size of 2-dimensional array.
+ * @a: dimension one
+ * @b: dimension two
+ *
+ * Calculates size of 2-dimensional array: @a * @b.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array_size(a, b)	size_mul(a, b)
+
+/**
+ * array3_size() - Calculate size of 3-dimensional array.
+ * @a: dimension one
+ * @b: dimension two
+ * @c: dimension three
+ *
+ * Calculates size of 3-dimensional array: @a * @b * @c.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
+
+/**
+ * flex_array_size() - Calculate size of a flexible array member
+ *                     within an enclosing structure.
+ * @p: Pointer to the structure.
+ * @member: Name of the flexible array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of a flexible array of @count number of @member
+ * elements, at the end of structure @p.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define flex_array_size(p, member, count)				\
+	__builtin_choose_expr(__is_constexpr(count),			\
+		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
+
+/**
+ * struct_size() - Calculate size of structure with trailing flexible array.
+ * @p: Pointer to the structure.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of memory needed for structure of @p followed by an
+ * array of @count number of @member elements.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size(p, member, count)					\
+	__builtin_choose_expr(__is_constexpr(count),			\
+		sizeof(*(p)) + flex_array_size(p, member, count),	\
+		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
+
+/**
+ * struct_size_t() - Calculate size of structure with trailing flexible array
+ * @type: structure type name.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of memory needed for structure @type followed by an
+ * array of @count number of @member elements. Prefer using struct_size()
+ * when possible instead, to keep calculations associated with a specific
+ * instance variable of type @type.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size_t(type, member, count)					\
+	struct_size((type *)NULL, member, count)
+
+/**
+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass (different) initializer.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ * @initializer: initializer expression (could be empty for no init).
+ */
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
+	_Static_assert(__builtin_constant_p(count),				\
+		       "onstack flex array members require compile-time const count"); \
+	union {									\
+		u8 bytes[struct_size_t(type, member, count)];			\
+		type obj;							\
+	} name##_u initializer;							\
+	type *name = (type *)&name##_u
+
+/**
+ * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member, when it does not have a __counted_by annotation.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @type structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@name) to get compile-time size of it afterwards.
+ */
+#define DEFINE_RAW_FLEX(type, name, member, count)	\
+	_DEFINE_FLEX(type, name, member, count, = {})
+
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @TYPE: structure type name, including "struct" keyword.
+ * @NAME: Name for a variable to define.
+ * @MEMBER: Name of the array member.
+ * @COUNTER: Name of the __counted_by member.
+ * @COUNT: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@NAME) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+
+#endif /* __LINUX_OVERFLOW_H */
-- 
2.43.0

base-commit: 5841e78ed6ebd31b26553003e880be378b232cd9
branch: sec2
