Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B422CEE350
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DD3839AC;
	Tue, 18 Nov 2025 21:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OQrzf+Cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82405835B3; Tue, 18 Nov 2025 21:17:49 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709C183959
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EC77C40CF5; 
 Tue, 18 Nov 2025 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763497066;
 bh=PB/lK4wFE1GlOwWONuA3Dyr9biMI3NNKUl7/RnbRWe0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=OQrzf+Cd7R6ffUvqictZX0RHtxkdHzenvIEWitK2tw1rFh7VfUKLnCZqC3lbz5iko
 P0iZ9mO1meN+Qrz2SwHdx7ljhl0yLpaB2TdpthfrHBXyT+RNtqkNW6AP/0Qvf5Twem
 Gb1ZCFrzGcF3VJP3usSHFKu10cQaElFaWriw7nRwsKEjy0T8s9VXQryzpIyG8gcU4a
 yo+OjQRkZBqhNGXYtdPTi5PX/P14ShgHf0JW/cWxArGfLki8YF9kxO37xiXU/03xfF
 halZ256fp4IpGKNzVkJ3XPd58xaEhpIdfWa9D3Aas1C9d8TQ5NzGyhgBd0O206wrRg
 ZWu1snB0j2Er1WAshfpe+ElhzncCboaU6NmbGNdwy8L2L9mzs6T1AKhJpLWNcAHTLX
 hUaPWJZgThjKGObZsvNT5acGk/EMSt5kgdTsIJ02gNxgGWamBwkb7uDEmoIq4NoD7m
 zN74nCGTDfJ0EIkZLhmrpsTtAZ62ZtiXr/7tvPFAxlrnkuvhIHTAoGuu+o168wCV5n
 AlFrVy3KdX/i1bANJCtHyniReZXMlg1GZxFhU+KpeHiuWHsRZPZwll411/MFK2j4K1
 2eKKav6u6y6SqD68I+LnLH4DXxvWCW0hEWQLjqU/eEK3FmWT56CK1Mx/XvwzZCwlbl
 YDsSx16shp2ny7Rjxo/KXoho=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] test: document ut.h
Date: Tue, 18 Nov 2025 21:17:31 +0100
Message-ID: <20251118201733.67297-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
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

Add missing Sphinx comments in include/test/ut.h

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/test/ut.h | 159 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 132 insertions(+), 27 deletions(-)

diff --git a/include/test/ut.h b/include/test/ut.h
index be5502e03a1..79c11367471 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -130,18 +130,28 @@ int ut_check_console_end(struct unit_test_state *uts);
  *
  * This only supports a byte dump.
  *
- * @total_bytes: Size of the expected dump in bytes`
- * Return: 0 if OK (looks like a dump and the length matches), other value on
- *	error
+ * @uts:		Test state
+ * @total_bytes:	Size of the expected dump in bytes
+ * Return:		0 if OK (looks like a dump and the length matches),
+ *			other value on error
  */
 int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 
-/* Report a failure, with printf() string */
+/**
+ * ut_report() - Report a failure, with printf() string
+ *
+ * @fmt:	format string
+ * @args:	arguments to be printed
+ */
 #define ut_reportf(fmt, args...)					\
 	ut_failf(uts, __FILE__, __LINE__, __func__, "report",		\
 		 fmt, ##args)
 
-/* Assert that a condition is non-zero */
+/**
+ * ut_assert() - Assert that a condition is true (not 0)
+ *
+ * @cond:	condition
+ */
 #define ut_assert(cond) ({						\
 	int __ret = 0;							\
 									\
@@ -152,7 +162,13 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that a condition is non-zero, with printf() string */
+/**
+ * ut_assertf() - Assert that a condition is true with printf string
+ *
+ * @cond:	condition
+ * @fmt:	format string
+ * @args:	arguments to be printed
+ */
 #define ut_assertf(cond, fmt, args...) ({				\
 	int __ret = 0;							\
 									\
@@ -164,7 +180,12 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that two int expressions are equal */
+/**
+ * ut_asserteq() - Assert that two int32 expressions are equal
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
+ */
 #define ut_asserteq(expr1, expr2) ({					\
 	unsigned int _val1 = (expr1), _val2 = (expr2);			\
 	int __ret = 0;							\
@@ -179,7 +200,12 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that two 64 int expressions are equal */
+/**
+ * ut_asserteq_64() - Assert that two int64 expressions are equal
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
+ */
 #define ut_asserteq_64(expr1, expr2) ({					\
 	u64 _val1 = (expr1), _val2 = (expr2);				\
 	int __ret = 0;							\
@@ -197,7 +223,12 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that two string expressions are equal */
+/**
+ * ut_asserteq_str() - Assert that two string expressions are equal
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
+ */
 #define ut_asserteq_str(expr1, expr2) ({				\
 	const char *_val1 = (expr1), *_val2 = (expr2);			\
 	int __ret = 0;							\
@@ -211,9 +242,12 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/*
- * Assert that two string expressions are equal, up to length of the
- * first
+/**
+ * ut_asserteq_strn() - Assert that two string expressions are equal
+ *                      up to the length of the first expression
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
  */
 #define ut_asserteq_strn(expr1, expr2) ({				\
 	const char *_val1 = (expr1), *_val2 = (expr2);			\
@@ -230,7 +264,13 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that two memory areas are equal */
+/**
+ * ut_asserteq_mem() - Assert that two memory areas are equal
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
+ * @len:	length of the memory areas
+ */
 #define ut_asserteq_mem(expr1, expr2, len) ({				\
 	const u8 *_val1 = (u8 *)(expr1), *_val2 = (u8 *)(expr2);	\
 	const uint __len = len;						\
@@ -250,7 +290,12 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that two pointers are equal */
+/**
+ * ut_asserteq_ptr() - Assert that two string pointers are equal
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
+ */
 #define ut_asserteq_ptr(expr1, expr2) ({				\
 	const void *_val1 = (expr1), *_val2 = (expr2);			\
 	int __ret = 0;							\
@@ -264,7 +309,13 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that two addresses (converted from pointers) are equal */
+/**
+ * ut_asserteq_addr() - Assert that two addresses (converted from pointers)
+ *			are equal
+ *
+ * @expr1:	expected value
+ * @expr2:	actual value
+ */
 #define ut_asserteq_addr(expr1, expr2) ({				\
 	ulong _val1 = map_to_sysmem(expr1);				\
 	ulong _val2 = map_to_sysmem(expr2);				\
@@ -279,7 +330,11 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that a pointer is NULL */
+/**
+ * ut_assertnull() - Assert that a pointer is NULL
+ *
+ * @expr:	pointer
+ */
 #define ut_assertnull(expr) ({						\
 	const void *_val = (expr);					\
 	int __ret = 0;							\
@@ -293,7 +348,11 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that a pointer is not NULL */
+/**
+ * ut_assertnonnull() - Assert that a pointer is not NULL
+ *
+ * @expr:	pointer
+ */
 #define ut_assertnonnull(expr) ({					\
 	const void *_val = (expr);					\
 	int __ret = 0;							\
@@ -307,7 +366,11 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that a pointer is not an error pointer */
+/**
+ * ut_assertok_ptr() - Assert that a pointer is not an error pointer
+ *
+ * @expr:	pointer
+ */
 #define ut_assertok_ptr(expr) ({					\
 	const void *_val = (expr);					\
 	int __ret = 0;							\
@@ -322,10 +385,19 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that an operation succeeds (returns 0) */
+/**
+ * ut_assertok() - Assert that an operation succeeds (returns 0)
+ *
+ * @cond:	expression
+ */
 #define ut_assertok(cond)	ut_asserteq(0, cond)
 
-/* Assert that the next console output line matches */
+/**
+ * ut_assert_nextline() - Assert that the next console output line matches
+ *
+ * @fmt:	format string
+ * @args:	print arguments
+ */
 #define ut_assert_nextline(fmt, args...) ({				\
 	int __ret = 0;							\
 									\
@@ -338,7 +410,13 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that the next console output line matches up to the length */
+/**
+ * ut_assert_nextlinen() - Assert that the next console output line matches
+ *			   up to the length of the expected string.
+ *
+ * @fmt:	format string
+ * @args:	print arguments
+ */
 #define ut_assert_nextlinen(fmt, args...) ({				\
 	int __ret = 0;							\
 									\
@@ -351,7 +429,10 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that there is a 'next' console output line, and skip it */
+/**
+ * ut_assert_skipline() - Assert that there is a 'next' console output line,
+ *			  and skip it
+ */
 #define ut_assert_skipline() ({						\
 	int __ret = 0;							\
 									\
@@ -363,7 +444,13 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that a following console output line matches */
+/**
+ * ut_assert_skip_to_line() - Assert that a following console output line
+ *			      matches
+ *
+ * @fmt:	format string
+ * @args:	print arguments
+ */
 #define ut_assert_skip_to_line(fmt, args...) ({				\
 	int __ret = 0;							\
 									\
@@ -376,7 +463,13 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that a following console output line matches */
+/**
+ * ut_assert_skip_to_linen() - Assert that a following console output line
+ *			       matches up to the length of the expected string
+ *
+ * @fmt:	format string
+ * @args:	print arguments
+ */
 #define ut_assert_skip_to_linen(fmt, args...) ({				\
 	int __ret = 0;							\
 									\
@@ -389,7 +482,9 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that there is no more console output */
+/**
+ * ut_assert_console_end() - Assert that there is no more console output
+ */
 #define ut_assert_console_end() ({					\
 	int __ret = 0;							\
 									\
@@ -402,7 +497,12 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that the next lines are print_buffer() dump at an address */
+/**
+ * ut_assert_nextlines_are_dump - Assert that the next lines are print_buffer()
+ *				  dump at an address
+ *
+ * @total_bytes:	Size of the expected dump in bytes
+ */
 #define ut_assert_nextlines_are_dump(total_bytes) ({			\
 	int __ret = 0;							\
 									\
@@ -416,7 +516,10 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	__ret;								\
 })
 
-/* Assert that the next console output line is empty */
+/**
+ * ut_assert_nextline_empty() - Assert that the next console output line is
+ *				empty
+ */
 #define ut_assert_nextline_empty()					\
 	ut_assert_nextline("%s", "")
 
@@ -451,6 +554,8 @@ void ut_silence_console(struct unit_test_state *uts);
  *
  * This restarts console output again and turns off console recording. This
  * happens on all boards, including sandbox.
+ *
+ * @uts:	Test state
  */
 void ut_unsilence_console(struct unit_test_state *uts);
 
-- 
2.51.0

