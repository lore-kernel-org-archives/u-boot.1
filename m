Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D323C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 11:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBEAB822D7;
	Thu,  8 May 2025 13:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Vj1TdD2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254668283E; Thu,  8 May 2025 13:58:14 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id C81E082153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1746705459;
 bh=1UJ4HmagFS6eVb0AOdsR+VXBPOr6XdUJaUqtoJ932wY=;
 h=From:To:CC:Subject:Date:From;
 b=Vj1TdD2tcIZBvW9vCnKGyjCeXbzy5hXvsPGwHV8yl4QrnjNZ8JvAMfhIfrytdDmeE
 Mm7eLJTmnjIQ4E9uGko3MQsrMx110acrifBsmGo0JDwI1vKGa4QjUU92fvqEHrwaZ/
 kFXiaXse/9zdrSg4sJvpKZp6bTT1qfsd5U7heXtQLu2ld5t2E3C5KPbsT3zkwi4Q7/
 srdWEpFZ+tyEHJXebqS+94B8byAFvuwCBZiyTVuoS0u7Vrl2jpHdBjXxqUpE8eAi3d
 FNTrI3rtwxAxgQW2MW+vhNTWUuFrCs0a9oZ27id7eoZPHuw2XhZkNoA45PIEjv0r4I
 O3Ffdad47wxMQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Michael Walle
 <mwalle@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut
 <marex@denx.de>, Benedikt Spranger <b.spranger@linutronix.de>, Jerome
 Forissier <jerome.forissier@linaro.org>, John Ogness
 <john.ogness@linutronix.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH V4] tiny-printf: Handle formatting of %p with an extra Kconfig
Date: Thu, 8 May 2025 13:57:25 +0200
Message-ID: <20250508115725.18929-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The formatting with %pa / %pap behaves like %x, which results in an
incorrect value being output. To improve this, a new fine-tuning
Kconfig SPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
has been added. If it is enabled, the output of %pa / %pap should
be correct, and if it is disabled, the pointer formatting is
completely unsupported. In addition to indicate unsupported formatting,
'?' will be output. This allows enabling pointer formatting only
when needed. For SPL_NET it is selected by default. Then it also
supports the formatting with %pm, %pM and %pI4.

In summery this level of %p support for tiny printf is possible now:

1) The standard tiny printf won't have support for pointer formatting.
   So it doesn't print misleading values for %pa, instead '?' will be
   output:
   %p   => ?
   %pa  => ?a
   %pap => ?ap

2) If SPL_USE_TINY_PRINTF_POINTER_SUPPORT is enabled or DEBUG is defined
   tiny printf supports formatting %p and %pa / %pap.

3) If SPL_NET is enabled the support of pointers is extended
   for %pm, %pM and %pI4.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
V2: - Rebase on current master
    - Extend commit message
    - Restrict use to SPL
    - Rename Kconfig to SPL_USE_TINY_PRINTF_POINTER_SUPPORT
    - Replace _DEBUG with defined(DEBUG)
    - Output '?' if %pm, %pM and %pI4 isn't available
    - Add break on case '%'
V3: - Add missing output '?' for the default case
V4: - Remove NET_LWIP support from tiny printf because SPL doesn't support lwIP
---
 common/spl/Kconfig |  1 +
 lib/Kconfig        |  8 ++++++++
 lib/tiny-printf.c  | 48 +++++++++++++++++++++++-----------------------
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0bc96d0a781..49dd0c1cb0e 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1122,6 +1122,7 @@ config SPL_DM_SPI_FLASH
 config SPL_NET
 	bool "Support networking"
 	depends on !NET_LWIP
+	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/lib/Kconfig b/lib/Kconfig
index b2aecd8a49e..cdf8f7ee0e8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
 
 	  The supported format specifiers are %c, %s, %u/%d and %x.
 
+config SPL_USE_TINY_PRINTF_POINTER_SUPPORT
+	bool "Extend tiny printf with the pointer formatting %p"
+	depends on SPL_USE_TINY_PRINTF
+	help
+	  This option enables the formatting of pointers %p. It supports
+	  %p and %pa / %pap. If this option is selected by SPL_NET
+	  it also supports the formatting with %pm, %pM and %pI4.
+
 config PANIC_HANG
 	bool "Do not reset the system on fatal error"
 	help
diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 2a7a4d286c0..411ae6189f2 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -141,7 +141,7 @@ static void ip4_addr_string(struct printf_info *info, u8 *addr)
 
 	string(info, ip4_addr);
 }
-#endif
+#endif /* CONFIG_SPL_NET */
 
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
@@ -157,18 +157,14 @@ static void ip4_addr_string(struct printf_info *info, u8 *addr)
  *       decimal).
  */
 
-static void __maybe_unused pointer(struct printf_info *info, const char *fmt,
-				   void *ptr)
+#if defined(CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT) || defined(DEBUG)
+static void pointer(struct printf_info *info, const char *fmt, void *ptr)
 {
-#ifdef DEBUG
 	unsigned long num = (uintptr_t)ptr;
 	unsigned long div;
-#endif
 
 	switch (*fmt) {
-#ifdef DEBUG
 	case 'a':
-
 		switch (fmt[1]) {
 		case 'p':
 		default:
@@ -176,7 +172,6 @@ static void __maybe_unused pointer(struct printf_info *info, const char *fmt,
 			break;
 		}
 		break;
-#endif
 #ifdef CONFIG_SPL_NET
 	case 'm':
 		return mac_address_string(info, ptr, false);
@@ -185,16 +180,22 @@ static void __maybe_unused pointer(struct printf_info *info, const char *fmt,
 	case 'I':
 		if (fmt[1] == '4')
 			return ip4_addr_string(info, ptr);
+#else
+	case 'm':
+	case 'M':
+	case 'I':
+		out(info, '?');
+		return;
 #endif
 	default:
 		break;
 	}
-#ifdef DEBUG
+
 	div = 1UL << (sizeof(long) * 8 - 4);
 	for (; div; div /= 0x10)
 		div_out(info, &num, div);
-#endif
 }
+#endif
 
 static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 {
@@ -269,21 +270,18 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 						div_out(info, &num, div);
 				}
 				break;
+#if defined(CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT) || defined(DEBUG)
 			case 'p':
-				if (CONFIG_IS_ENABLED(NET) ||
-				    CONFIG_IS_ENABLED(NET_LWIP) || _DEBUG) {
-					pointer(info, fmt, va_arg(va, void *));
-					/*
-					 * Skip this because it pulls in _ctype which is
-					 * 256 bytes, and we don't generally implement
-					 * pointer anyway
-					 */
-					while (isalnum(fmt[0]))
-						fmt++;
-					break;
-				}
-				islong = true;
-				fallthrough;
+				pointer(info, fmt, va_arg(va, void *));
+				/*
+				 * Skip this because it pulls in _ctype which is
+				 * 256 bytes, and we don't generally implement
+				 * pointer anyway
+				 */
+				while (isalnum(fmt[0]))
+					fmt++;
+				break;
+#endif
 			case 'x':
 			case 'X':
 				if (islong) {
@@ -310,7 +308,9 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				break;
 			case '%':
 				out(info, '%');
+				break;
 			default:
+				out(info, '?');
 				break;
 			}
 
-- 
2.30.2

