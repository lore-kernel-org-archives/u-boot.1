Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD7EC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 10:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E1282B6B;
	Wed, 30 Apr 2025 12:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="M15Zawho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864B68283E; Wed, 30 Apr 2025 12:37:43 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 by phobos.denx.de (Postfix) with ESMTP id 8510C82B78
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1746009429;
 bh=YOMAhfOVy1lbRdWJyvpLGFXcQjOrvke9e4AgnwLX9QY=;
 h=From:To:CC:Subject:Date:From;
 b=M15Zawho7lt03VeBi/jcMqZrA25hDzcFl2zpqyglvCjbwiC972URLEgFAvDCry0P7
 EAoJkC+43/a4CWYurjSWjA6rM1QcfZfEFzqMRN6fFhm9WQNGNHaYf1A3aSb4BcpZWf
 66PM4AO8kunVRbUYmmfwBL0VXsii3/UXbS4zjh4oaoRxT/Q6JPSqHmPsYMWV9OyrJm
 qJsDMhMiz8s6OgUkyKHfXfmEQoDu6+aB4W+1sAOVbKkNtGMj1SUGTVvNZauSgf7GdA
 IBDa6IP5iBUJF2oxO6VtP6IgIARJwBSa8gU9S8+6f0mhOtyb+AsGz85FF98qCy47fy
 yb/SDOc3k4eSA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Michael Walle
 <mwalle@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut
 <marex@denx.de>, Benedikt Spranger <b.spranger@linutronix.de>, Jerome
 Forissier <jerome.forissier@linaro.org>, John Ogness
 <john.ogness@linutronix.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH V3] tiny-printf: Handle formatting of %p with an extra Kconfig
Date: Wed, 30 Apr 2025 12:35:48 +0200
Message-ID: <20250430103548.4162289-1-cniedermaier@dh-electronics.com>
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
when needed. For SPL_NET and NET_LWIP it is selected by default.
Then it also supports the formatting with %pm, %pM and %pI4.

In summery this level of %p support for tiny printf is possible now:

1) The standard tiny printf won't have support for pointer formatting.
   So it doesn't print misleading values for %pa, instead '?' will be
   output:
   %p   => ?
   %pa  => ?a
   %pap => ?ap

2) If SPL_USE_TINY_PRINTF_POINTER_SUPPORT is enabled or DEBUG is defined
   tiny printf supports formatting %p and %pa / %pap.

3) If SPL_NET or NET_LWIP is enabled the support of pointers is extended
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
---
 Kconfig            |  1 +
 common/spl/Kconfig |  1 +
 lib/Kconfig        |  8 +++++++
 lib/tiny-printf.c  | 52 +++++++++++++++++++++++-----------------------
 4 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/Kconfig b/Kconfig
index 51358633762..b8eec3fc931 100644
--- a/Kconfig
+++ b/Kconfig
@@ -774,6 +774,7 @@ config NET
 
 config NET_LWIP
 	bool "Use lwIP for networking stack"
+	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
 	imply NETDEVICES
 	help
 	  Include networking support based on the lwIP (lightweight IP)
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index b076f49ac00..b89e0c9b4d4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1116,6 +1116,7 @@ config SPL_DM_SPI_FLASH
 config SPL_NET
 	bool "Support networking"
 	depends on !NET_LWIP
+	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/lib/Kconfig b/lib/Kconfig
index b2aecd8a49e..e17396701c2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
 
 	  The supported format specifiers are %c, %s, %u/%d and %x.
 
+config SPL_USE_TINY_PRINTF_POINTER_SUPPORT
+	bool "Extend tiny printf with the pointer formatting %p"
+	depends on SPL_USE_TINY_PRINTF
+	help
+	  This option enables the formatting of pointers %p. It supports
+	  %p and %pa / %pap. If this option is selected by SPL_NET or NET_LWIP
+	  it also supports the formatting with %pm, %pM and %pI4.
+
 config PANIC_HANG
 	bool "Do not reset the system on fatal error"
 	help
diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 2a7a4d286c0..6bbf8fb42a5 100644
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

