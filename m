Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C02ACA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 07:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D0F830A0;
	Wed, 10 Sep 2025 09:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eEt3thx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51D78319C; Wed, 10 Sep 2025 09:12:46 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3B182B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 09:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B87AE3F7C6; 
 Wed, 10 Sep 2025 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1757488364;
 bh=mcQu+NWX1hZpq0QWgeIUKOaVRyyBy7ksrYbEDYtKr5M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=eEt3thx2/A5m/JR18bKwRlklL7UemcvdS9EeVs1Ax6fEff1cNYcITHM/DiIdkTGrV
 4KaPi/F/Y/UJ1y1sSoCWMvTLhPMgbbu/pvDvpjGobyFoqk8Cj47pnTxe+PrhPonuHI
 3zSfCQ1QuZUEzStTsu3bG5yHc0NTGUYj/P87NYsRe8Vt8kwvk77Hfe+TOOtnpXCVDq
 laGQpwynTRxWrKmCXknPknhfJ+BaVVCgrXWnW00y0uCVAIVCcAzAYlUtTVDcUl7LSG
 BSawWskkPbPH8CIE/hFjhv4IEQ5lXbpkNsKXmtcV+DA+tG8QO6jHb8W9tUMAhc/d06
 pqDTyXvI4hkAw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: Tidy up comments for vsprintf functions
Date: Wed, 10 Sep 2025 09:12:39 +0200
Message-ID: <20250910071239.27198-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

From: Simon Glass <sjg@chromium.org>

Some of the functions in this file do not follow the normal style. Fix
this so that things are more consistent.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/vsprintf.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/vsprintf.h b/include/vsprintf.h
index 9da6ce7cc4d..3cb335515e4 100644
--- a/include/vsprintf.h
+++ b/include/vsprintf.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 
 /**
- * simple_strtoul - convert a string to an unsigned long
+ * simple_strtoul() - convert a string to an unsigned long
  *
  * @cp: The string to be converted
  * @endp: Updated to point to the first character not converted
@@ -32,7 +32,7 @@
 ulong simple_strtoul(const char *cp, char **endp, unsigned int base);
 
 /**
- * hex_strtoul - convert a string in hex to an unsigned long
+ * hex_strtoul() - convert a string in hex to an unsigned long
  *
  * @cp: The string to be converted
  * @endp: Updated to point to the first character not converted
@@ -45,7 +45,7 @@ ulong simple_strtoul(const char *cp, char **endp, unsigned int base);
 unsigned long hextoul(const char *cp, char **endp);
 
 /**
- * hex_strtoull - convert a string in hex to an unsigned long long
+ * hex_strtoull() - convert a string in hex to an unsigned long long
  *
  * @cp: The string to be converted
  * @endp: Updated to point to the first character not converted
@@ -58,7 +58,7 @@ unsigned long hextoul(const char *cp, char **endp);
 unsigned long long hextoull(const char *cp, char **endp);
 
 /**
- * dec_strtoul - convert a string in decimal to an unsigned long
+ * dec_strtoul() - convert a string in decimal to an unsigned long
  *
  * @cp: The string to be converted
  * @endp: Updated to point to the first character not converted
@@ -71,7 +71,7 @@ unsigned long long hextoull(const char *cp, char **endp);
 unsigned long dectoul(const char *cp, char **endp);
 
 /**
- * strict_strtoul - convert a string to an unsigned long strictly
+ * strict_strtoul() - convert a string to an unsigned long strictly
  * @cp: The string to be converted
  * @base: The number base to use (0 for the default)
  * @res: The converted result value
@@ -100,6 +100,7 @@ unsigned long dectoul(const char *cp, char **endp);
  *
  */
 int strict_strtoul(const char *cp, unsigned int base, unsigned long *res);
+
 unsigned long long simple_strtoull(const char *cp, char **endp,
 					unsigned int base);
 long simple_strtol(const char *cp, char **endp, unsigned int base);
@@ -178,7 +179,7 @@ void panic(const char *fmt, ...)
 void panic_str(const char *str) __attribute__ ((noreturn));
 
 /**
- * Format a string and place it in a buffer
+ * sprintf() - Format a string and place it in a buffer
  *
  * @buf: The buffer to place the result into
  * @fmt: The format string to use
@@ -193,7 +194,7 @@ int sprintf(char *buf, const char *fmt, ...)
 		__attribute__ ((format (__printf__, 2, 3)));
 
 /**
- * Format a string and place it in a buffer (va_list version)
+ * vsprintf() - Format a string and place it in a buffer (va_list version)
  *
  * @buf: The buffer to place the result into
  * @fmt: The format string to use
@@ -232,7 +233,7 @@ char *simple_itoa(ulong val);
 char *simple_xtoa(ulong num);
 
 /**
- * Format a string and place it in a buffer
+ * scnprintf() - Format a string and place it in a buffer
  *
  * @buf: The buffer to place the result into
  * @size: The size of the buffer, including the trailing null space
@@ -248,7 +249,7 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 		__attribute__ ((format (__printf__, 3, 4)));
 
 /**
- * Format a string and place it in a buffer (base function)
+ * vsnprintf() - Format a string and place it in a buffer (base function)
  *
  * @buf: The buffer to place the result into
  * @size: The size of the buffer, including the trailing null space
@@ -273,7 +274,7 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 
 /**
- * Format a string and place it in a buffer (va_list version)
+ * vscnprintf() - Format a string and place it in a buffer (va_list version)
  *
  * @buf: The buffer to place the result into
  * @size: The size of the buffer, including the trailing null space
@@ -349,7 +350,7 @@ const char **str_to_list(const char *instr);
 void str_free_list(const char **ptr);
 
 /**
- * vsscanf - Unformat a buffer into a list of arguments
+ * vsscanf() - Unformat a buffer into a list of arguments
  * @inp: input buffer
  * @fmt0: format of buffer
  * @ap: arguments
@@ -357,7 +358,7 @@ void str_free_list(const char **ptr);
 int vsscanf(const char *inp, char const *fmt0, va_list ap);
 
 /**
- * sscanf - Unformat a buffer into a list of arguments
+ * sscanf() - Unformat a buffer into a list of arguments
  * @buf:	input buffer
  * @fmt:	formatting of buffer
  * @...:	resulting arguments
-- 
2.51.0

