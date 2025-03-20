Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BEC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 10:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0B9A80540;
	Thu, 20 Mar 2025 11:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="eVpU8sKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02557807AE; Thu, 20 Mar 2025 11:25:37 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id 81DAD8001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 11:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1742466313;
 bh=rrVvqxNMRwjI4e+msurqbG28bBSQPZcB6pisRD3Eo08=;
 h=From:To:CC:Subject:Date:From;
 b=eVpU8sKU8exXynffKaXYf1wK5YHqELbCynNDwBf2LLr1harjJ6TWPZChDXM3rXNBl
 9JGW3/9AAA0d7A0Uo5Ezbwmk+njjEU1el7TioBryUoe76q81rN7tY9syRCtg3ioPSX
 FSe0wo9ukvoYLNHO9TBhP/iYBdnf21I5BOgvPvjJE9j8ljWkryVFoqGNQuzPO8z2vH
 fG8HT8iyW/Kadk9eDgz8KiNaPs03o5ut/y3VX6jwzV1SZ2gGXrOcrmbzhQF5ny+VjE
 nTs9AwMK4eZ1TRU7on7hFNeU/eVoN2JA72A+ihiyfF1sxagZPdV9kOx5AFTpwDpvnP
 5RzFJYbBsjxUw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Benedikt Spranger
 <b.spranger@linutronix.de>, Simon Glass <sjg@chromium.org>, John Ogness
 <john.ogness@linutronix.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] tiny-printf: Add support for upper case hex values
Date: Thu, 20 Mar 2025 11:23:46 +0100
Message-ID: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
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

If tiny printf is used with 0x%08X (upper case X) the output is
always 0x00000000. It could be confusing if upper case instead
of lower case is used intentionally or accidentally because the
actual value is not output. To avoid this confusion, tiny printf
is extended to support also the formatting with %X.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tiny-printf.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 0503c17341f..81c51d12f6c 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -13,6 +13,11 @@
 #include <stdarg.h>
 #include <linux/ctype.h>
 
+enum case_style {
+	LOWERCASE = 0,
+	UPPERCASE = 1,
+};
+
 struct printf_info {
 	char *bf;	/* Digit buffer */
 	char zs;	/* non-zero if a digit has been written */
@@ -27,14 +32,19 @@ static void out(struct printf_info *info, char c)
 	*info->bf++ = c;
 }
 
-static void out_dgt(struct printf_info *info, char dgt)
+static void out_dgt_case(struct printf_info *info, char dgt, enum case_style style)
 {
-	out(info, dgt + (dgt < 10 ? '0' : 'a' - 10));
+	out(info, dgt + (dgt < 10 ? '0' : (style ? 'A' : 'a') - 10));
 	info->zs = 1;
 }
 
-static void div_out(struct printf_info *info, unsigned long *num,
-		    unsigned long div)
+static void out_dgt(struct printf_info *info, char dgt)
+{
+	out_dgt_case(info, dgt, LOWERCASE);
+}
+
+static void div_out_case(struct printf_info *info, unsigned long *num,
+			 unsigned long div, enum case_style style)
 {
 	unsigned char dgt = 0;
 
@@ -44,7 +54,13 @@ static void div_out(struct printf_info *info, unsigned long *num,
 	}
 
 	if (info->zs || dgt > 0)
-		out_dgt(info, dgt);
+		out_dgt_case(info, dgt, style);
+}
+
+static void div_out(struct printf_info *info, unsigned long *num,
+		    unsigned long div)
+{
+	div_out_case(info, num, div, LOWERCASE);
 }
 
 #ifdef CONFIG_SPL_NET
@@ -203,6 +219,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 	unsigned long num;
 	char buf[12];
 	unsigned long div;
+	enum case_style style = LOWERCASE;
 
 	while ((ch = *(fmt++))) {
 		if (ch != '%') {
@@ -283,6 +300,8 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				}
 				islong = true;
 				/* no break */
+			case 'X':
+				style = UPPERCASE;
 			case 'x':
 				if (islong) {
 					num = va_arg(va, unsigned long);
@@ -295,7 +314,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 					out_dgt(info, 0);
 				} else {
 					for (; div; div /= 0x10)
-						div_out(info, &num, div);
+						div_out_case(info, &num, div, style);
 				}
 				break;
 			case 'c':
-- 
2.30.2

