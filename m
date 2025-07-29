Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09017C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19CE83152;
	Tue, 29 Jul 2025 17:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tbgtn/kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B9BF829E7; Tue, 29 Jul 2025 17:50:38 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B858313B
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b78d729bb8so1132720f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804235; x=1754409035; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FdvkfD40QhuGJ5QakwIHoYzEZ/nfFxwURI/GQfV8frg=;
 b=tbgtn/kcJw26/s6f2zkzCAaVrpEbRfvkzvwFXclqbkSE9ZrLqVuagK9L/KFlwmL3wA
 w7ZsIWiXGIToWlQsB3ZpW6MGGLyzvPAOzOnRjbJsRSTXXOsp4VTWsPZj6iwVYWsPiIqD
 3PQlZlp8+UHM8ZYgg7HGX5t/ZEcF+3LAc6nCS3cvtsIHHY4TIpd4iSot5MqMHtIBRY/d
 IPjDHJUf07fdJx2rn3eR1BGAxOYfPtMlo4A0UjemrbH4+haAH+lQb0BhTgnsA//fvwSS
 dl1KiERdjoMzUEA4F3dMynCA3/WLHw040elHQGkgqi0Zde7K+SyxGeX6u7B1mrYuVloz
 C2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804236; x=1754409036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdvkfD40QhuGJ5QakwIHoYzEZ/nfFxwURI/GQfV8frg=;
 b=Ewa/srUl+mhwb5vY7k73AE5MCeTEBPm0bWQvYRF0dYAQ3sgQ15uXoj5lz9li6/ZpXR
 poeFkntMevHCvhfX2y5QdH16ZTrzK361ACxrBSiN0KRJqIrFZeCGrqM8iRIz/pCuEFCV
 f0TbhLJY476iahhFMAzqGsNDQOF6kgi9BusZO9UF/bGVxbzP4Sd/2vlmfNr7tJW4PmIH
 zM8Cq6N43rz2jitYboD1mSEy9SpxiXwVuDAgXGkwi4I5Ept6cV4lUD9I1L2Vb8+t5/2l
 cYf+LMG2acp49NRoRIYInPz+euUwPjmjQalfdbAKmIpiATmpO43fdierQ2HDkUCjilWu
 0Zpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW30UzesocMdmF99+OW0bRzjje9ezxrQxkOHpSKkkztDFItjpm+bTPBXNZdX9G3TSo8hcW6KI=@lists.denx.de
X-Gm-Message-State: AOJu0YwEde40SquJlyNwyoOGdb8Jh8fiV6oePx9DYP/XUzLG3gIEnNOf
 yMpV4tWxh3M92hOesFVPPdVA1zYnCzMxkQHWe7ZGvkE2a64uQkHHS7CGAOrMceTfAuJJtrwRj6X
 P9u2s
X-Gm-Gg: ASbGncvx1UGcU3zXCqDL198/fxXspF12I4CbNbWC3QYmhUsawHPeByJQvaYrw+onlgb
 wjr8f8obbdqmRkb5IBo0lElgOdYDDPgFwEH9t/6nJntge195g/r+rIFxUxB191lJVhCIeTlvQPJ
 wiSJz2eVd0h9qILw9SpNvbBmKcI7TdyqWIPXDvynHhpOdDuatJncst/BezDx5MqX7nwj38c2WTP
 oqxTIfFnNo7F2xncvyWJ4r3GNH+jqcz0B7vB/I94ccL5mOtN6pYfzgoSU3M9qBi+8W5JAXjqSfo
 r4V8JDteG6W2p64n5ersYBAjDitlswv/2RdEzZxPrDbDIOy8gfiiQlyXii/FEPn9lRICuy1gTT/
 X4y/faXg5byqmf76+6UecusiitShDi8R83PZdQEHafqlrOY0XJFA2HACT6/pmCh71k/3ODEUU8B
 bT/OrBknXMEg==
X-Google-Smtp-Source: AGHT+IGlGU+534xiuZFHelhmcNYliGBN7t4BjBWxu55iUSKNZAyyvIeW4klIam3gAMe3lD4ESUIOqA==
X-Received: by 2002:a05:6000:4203:b0:3a4:e502:81e1 with SMTP id
 ffacd0b85a97d-3b7950188bdmr117173f8f.52.1753804235552; 
 Tue, 29 Jul 2025 08:50:35 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:34 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:05 +0200
Subject: [PATCH v3 07/10] lib: vsprintf: implement %pS format specifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-7-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=fjkctfZmx7fK/2AEGpNwCbueEtXHSL4gM94bYU1iPnw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2qdzYv7Ciy4mJTurQfnwmkkQ4gKmAD2bHHH
 rlyCe54Je6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqgAKCRAFgzErGV9k
 tsBoD/9kfJG/ZmoS84jiUEkNssHjm+lqtnx9kUbp+e6kK2Fk430rS0BtsLpcaY9PhRxJUrBg4OH
 sLcxgZpjM6SR7KHfa5YIaNZxC5z3wiJJx1BHfchZKKGIDlhPG20euizt3ngtedXPxng78gM2zXc
 ze5W0lkjsSLBH846ybcn9xDU/WcoZ4TYKDGvEgnKQ7GHouWkTdK5fUmBAqnmNmcTYRRt51EjE13
 Q1h5DuEKJf8DJO9h1j3SX2ztC2aWCLPez7TkBbqf9Zuuyh1B/cLXGHAsMr7ZH+rHJTOT4MUlMpB
 y9FFIbaQHhhXKfAAUEmZj+a0572a0T2oqul4TJ1bYpcnQR27TIg66dUm9pLlyR4TVn1lgSvRAYe
 ujATDpESG2zXo5Y8VK1WxSHbfjk1oDjBi0mkl+zssyTAWVQAEv+Ew6XJfM8KwcQZsNxDrAPe2wi
 3/vBTtgs2EEtAKy0wbIjANj+C4zE1i5BQtzfrFbxrjBz4n4pMbVoGwQ2FBrkNxjhjtet4ocK1zn
 DTWAxnfbX32+W7BhdEa3lx6VGx7kr26ctIzuYym+hIiV7PZ7vwcFJ/O3F0JfYmAqu0ekzleJsR/
 FpkCCqYiybw0uV77LA/l/KWXposYFDaKYiDhKwP/Fkpe/GsT4peLizeRf5xgRRWcgyH2IlYTKLQ
 KgWdU0HlJ04SRLw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

%pS is a kernel extension for printing the name and offset of a symbol.
This is useful for function pointers/callbacks especially. When symbol
lookup is enabled this can make for much easier debugging of driver ops
and other places.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 lib/vsprintf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c7340a047b2e9385b9366d90e1363c99882db398..11cc3e6c0e9abd0440b76219b0d56056345ddd7f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -24,8 +24,9 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <symbols.h>
 
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
 
@@ -437,8 +438,25 @@ static char *uuid_string(char *buf, char *end, u8 *addr, int field_width,
 	return string(buf, end, uuid, field_width, precision, flags);
 }
 #endif
 
+/*
+ * Given an address, print the symbol name and offset to the address.
+ */
+static char *ptr_symbol(phys_addr_t addr, char *buf, char *end,
+			int field_width, int precision, int flags)
+{
+	unsigned long offset;
+	char namebuf[KSYM_NAME_LEN + 1] = { 0 };
+
+	symbol_lookup(addr, NULL, &offset, namebuf);
+
+	strlcat(namebuf, "+0x", KSYM_NAME_LEN + 1);
+
+	buf = string(buf, end, namebuf, field_width, precision, flags);
+	return number(buf, end, offset, 16, field_width, precision, flags);
+}
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
  * specifiers.
@@ -450,8 +468,9 @@ static char *uuid_string(char *buf, char *end, u8 *addr, int field_width,
  * - 'I' [46] for IPv4/IPv6 addresses printed in the usual way (dot-separated
  *       decimal for v4 and colon separated network-order 16 bit hex for v6)
  * - 'i' [46] for 'raw' IPv4/IPv6 addresses, IPv6 omits the colons, IPv4 is
  *       currently the same
+ * - 'S' for a symbol address, it prints the symbol name and offset
  */
 static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		int field_width, int precision, int flags)
 {
@@ -502,8 +521,14 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			return ip4_addr_string(buf, end, ptr, field_width,
 					       precision, flags);
 		flags &= ~SPECIAL;
 		break;
+	case 'S':
+		if (IS_ENABLED(CONFIG_SYMBOL_LOOKUP))
+			return ptr_symbol((phys_addr_t)ptr, buf, end,
+					  field_width, precision, flags);
+		flags |= SPECIAL;
+		break;
 #ifdef CONFIG_LIB_UUID
 	case 'U':
 		return uuid_string(buf, end, ptr, field_width, precision,
 				   flags, fmt);

-- 
2.50.0

