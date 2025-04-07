Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB1DC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4048082CF5;
	Mon,  7 Apr 2025 10:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="O2TMlJHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A41E82CFD; Mon,  7 Apr 2025 10:57:59 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 22D7E82CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1744016248;
 bh=po5YlkHscGLKZEXN5yTZVIeXXc5IshF/+Ujw+VcAeJU=;
 h=From:To:CC:Subject:Date:From;
 b=O2TMlJHxlc9hevlc/C+JRi0uXMRpjWwKavHqopuRd5QBBn3n2I9O0fFb+lUZa67s2
 ulc7ISjnaZIIvxcCFwvdonRwnD+dNxYgtc7M1U/6VYZAkg1+7GdTkT/qgtCxQ+NcFI
 HEiig0xkwt5gkeQmIyn4oljU0hDwYFd76oAjcEbVQ+0QLT98QjKxjzzqIvd9CFm8dZ
 y0+R7r0SIsNue9mBgK3YDX6H1i3cQDvuxeBWaI3QnIFYwUP3/p0v49p0/HJ2FvQIaP
 HrsjLDFMTHExUbaoClRSjzta12Lt777gA1ICq3198xcq9EfNp3hHFSneXth8cXGHY7
 OdQ/BxpY0NAOQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Michael Walle
 <mwalle@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut
 <marex@denx.de>, Benedikt Spranger <b.spranger@linutronix.de>, Jerome
 Forissier <jerome.forissier@linaro.org>, John Ogness
 <john.ogness@linutronix.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] tiny-printf: Handle formatting of %p with an extra Kconfig
Date: Mon, 7 Apr 2025 10:56:14 +0200
Message-ID: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
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
Kconfig XPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
has been added. If it is enabled, the output of %pa / %pap should
be correct, and if it is disabled, the pointer formatting is
completely unsupported. In addition to indicate unsupported formatting,
'?' will be output. This allows enabling pointer formatting only
when needed. For SPL_NET and NET_LWIP it is selected by default.
Then it also supports the formatting with %pm, %pM and %pI4.

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
 Kconfig            |  1 +
 common/spl/Kconfig |  1 +
 lib/Kconfig        |  8 ++++++++
 lib/tiny-printf.c  | 45 +++++++++++++++++++--------------------------
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/Kconfig b/Kconfig
index 6379a454166..4d13717294c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -757,6 +757,7 @@ config NET
 
 config NET_LWIP
 	bool "Use lwIP for networking stack"
+	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
 	imply NETDEVICES
 	help
 	  Include networking support based on the lwIP (lightweight IP)
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 94e118f8465..72736dbecf5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1096,6 +1096,7 @@ config SPL_DM_SPI_FLASH
 config SPL_NET
 	bool "Support networking"
 	depends on !NET_LWIP
+	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/lib/Kconfig b/lib/Kconfig
index 1a683dea670..62e28d4a1f3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
 
 	  The supported format specifiers are %c, %s, %u/%d and %x.
 
+config XPL_USE_TINY_PRINTF_POINTER_SUPPORT
+	bool "Extend tiny printf with the pointer formatting %p"
+	depends on SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
+	help
+	  This option enables the formatting of pointers %p. It supports
+	  %p and %pa / %pap. If this option is selected by SPL_NET or NET_LWIP
+	  it also supports the formatting with %pm, %pM and %pI4.
+
 config PANIC_HANG
 	bool "Do not reset the system on fatal error"
 	help
diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 0503c17341f..10db812567a 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -47,7 +47,7 @@ static void div_out(struct printf_info *info, unsigned long *num,
 		out_dgt(info, dgt);
 }
 
-#ifdef CONFIG_SPL_NET
+#if defined(CONFIG_SPL_NET) || defined(CONFIG_NET_LWIP)
 static void string(struct printf_info *info, char *s)
 {
 	char ch;
@@ -141,7 +141,7 @@ static void ip4_addr_string(struct printf_info *info, u8 *addr)
 
 	string(info, ip4_addr);
 }
-#endif
+#endif /* defined(CONFIG_SPL_NET) || defined(CONFIG_NET_LWIP) */
 
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
@@ -157,18 +157,14 @@ static void ip4_addr_string(struct printf_info *info, u8 *addr)
  *       decimal).
  */
 
-static void __maybe_unused pointer(struct printf_info *info, const char *fmt,
-				   void *ptr)
+#if defined(CONFIG_XPL_USE_TINY_PRINTF_POINTER_SUPPORT) || _DEBUG
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
@@ -176,8 +172,7 @@ static void __maybe_unused pointer(struct printf_info *info, const char *fmt,
 			break;
 		}
 		break;
-#endif
-#ifdef CONFIG_SPL_NET
+#if defined(CONFIG_SPL_NET) || defined(CONFIG_NET_LWIP)
 	case 'm':
 		return mac_address_string(info, ptr, false);
 	case 'M':
@@ -189,12 +184,12 @@ static void __maybe_unused pointer(struct printf_info *info, const char *fmt,
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
@@ -268,21 +263,18 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 						div_out(info, &num, div);
 				}
 				break;
+#if defined(CONFIG_XPL_USE_TINY_PRINTF_POINTER_SUPPORT) || _DEBUG
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
-				/* no break */
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
 				if (islong) {
 					num = va_arg(va, unsigned long);
@@ -307,6 +299,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 			case '%':
 				out(info, '%');
 			default:
+				out(info, '?');
 				break;
 			}
 
-- 
2.30.2

