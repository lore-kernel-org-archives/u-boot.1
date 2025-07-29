Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B081CC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57A2831D6;
	Tue, 29 Jul 2025 18:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eUzYe09i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F52582BA7; Tue, 29 Jul 2025 18:08:10 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC8A83152
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so35308845e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805288; x=1754410088; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FdvkfD40QhuGJ5QakwIHoYzEZ/nfFxwURI/GQfV8frg=;
 b=eUzYe09iqvaz6amIEQAzrBAuVHAysghfqe/WAUQkBxAwB3jkJv6JXZrBDLv8IZbN/4
 0vIZGtf3b/VJGdlzXWce4Ec13uSbL6YzJoT9thyQ8wLNpvCOWyYREEQXLRiYkw4XWhhr
 m9mNLFvOwm+Rd4fOa9QlreJ57JUQBre5H1z11f53GjDLXg4w6MhjtE3KgeutiHcjoMR7
 r9AsvjuZWVXpcTpUpUEStC2H/E2O/tpxoL9kfhPCpLrOGMsISI9o6Im3zE4FZQrcKZGg
 qsfFaGnoWYt/yz12gBl7SKS8J06Jkggojhh1bmNRyVZ+CIUbXsyzIdF3ARKaVf+AU8tk
 ilJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805288; x=1754410088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdvkfD40QhuGJ5QakwIHoYzEZ/nfFxwURI/GQfV8frg=;
 b=uOiDke/Y54F+TnY9O/lDlaQvrJB6OfKLgN2R6v1P5PM8RHEOvS4zOqWnlgD7ONGFyo
 CBQuF+MfMMSCU4oG+kGZPg+wJkrTc52rxMVGjR7leytG1MifvxsQqAetzplZ7YYrt5Fn
 o6irY9z+6C/mNV/WcReSrXsxC208Uab7wnAZLeTWMKnYNgGLf4IVxpJmB6yOWk08oEzA
 edU/nrdNxwEjR0ffpY/926CRwj2QNy9wzmDbCaxaep8X32jKuAfqLtaDOyEiNEjmr7uY
 8QHQndcySFXr+MtQI6Fzpa/hw4fS8mcmi/WMEBwI0JCu9R+2hdrUUQl6zN1Wfyst4JXf
 xs+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwIG0zOTdzXG8tpPSxxvBSkQ/yWx8Lz/cvirqFUHeoVXgaXhv69KFfU297/2zzfijqbR6kiqM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgo5Zie5N4T4kb92Ji/lz2yO3mTxNQcTLnjS6wD4ur8PsoLa6A
 e5DGTCGUlTWKI7DqZa3HSuxTZohlCbBVoURBMD3XaseLS76jIAiOsFouV2Yx2wWJvvg=
X-Gm-Gg: ASbGncvPepmy2BozEQ/LLcA6G4v86kfv884CdwkhYAr+SH4VN5gXO7Qp93CdB2PnGU9
 +eFmbBHxKH65I+8iVLKNBc9SZewsR481O8M7s3kF8/l5cClbsJyCaSNT1jubI5Yf4YBe0UiTZjp
 zEQ2XrvD7wFQrvsOthS3Q+5f8hvdaPlS3YeEzZ5Cx2WdyuhwlgBJI15v9wEtUm2fdI0sqn3IbOi
 0+w6SzBFiG81raGIyeO7poijcO9Ev+V2rijEhzTF3hLAdEPtdpIm3kzYVOcfRww8JoJ2b2KO1nH
 Pbat0RlEa6iNWaubJvnRjh9UjUXtjFReRrmQkmfYMedSLhCHVLuj1XsqRMioelI1URBc93906Wt
 HXFzi6vcrOeQBhPzwJ/KG0p4bXfyPTnbfgb7HyekvP8GEJ5TY8lYxKQwtQeB66XXXqwkCCkgaUB
 DYVG52hytpMfBi+NYeuekw
X-Google-Smtp-Source: AGHT+IEQWv9+xv5GW3bJbn8BP4QhkxK2pDpOHwdSqdknopaI/0kn7m3rEGYEsMoxA5uWI20IFMvosA==
X-Received: by 2002:a05:600c:138e:b0:456:1824:4808 with SMTP id
 5b1f17b1804b1-45892bdf9admr2587535e9.32.1753805287698; 
 Tue, 29 Jul 2025 09:08:07 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:08:06 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:28 +0200
Subject: [PATCH v5 07/10] lib: vsprintf: implement %pS format specifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-7-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=fjkctfZmx7fK/2AEGpNwCbueEtXHSL4gM94bYU1iPnw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHCWkvjoiJlYndYTzBLiZ5xNigL6NsrkNjI9
 reT9YVhTneJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwgAKCRAFgzErGV9k
 tntkD/47IbEVmDduh0lDhc3wQn4KaThfQH2Y16Yj+UIsSSW7xssLdhG8pWOEXGQ/nhOYEIa+i7m
 ApouuBH8hzQ0sA3/MAHGFpQZNyyTSN1lm9z2EHjkwjV7zP22dlo5XMa2qyIx/36L8URF2902GVY
 kl7tBKnk5Qc3Mof4nPQANcasC72LjelosNH7G3U8RGccQ8yKVPQlNi+NA+d1xRXNouSwoH6zTH9
 qvQ6JjGkxDWMZXOBBecS1lAfZvQcWPLT48Womwactof5EXytrWr/aZmqxCa5JiDZ4UDfuRBC8Qz
 0tJjfebXj2fMb9SskSCz9gIBffbnBy/v8ftyYwBmgDGM6yBuMN0IUjSXpbq0Sry1MkRZCSx/iKx
 8NNTbEK0Ht6x0NFyEBkxQZPGcwdopJnO+/P3THkvUpIvu7I2h4MrDD6rS0bDZuXfUknOuDw8fD2
 TFVGOJ52NWkL2gWuzVU93jSFSTZ6b4sMeaKdYYV+E9yvLmRjY94588vxgC1EBq3uEvhFsB0ez8o
 dkPg7fi6UejGFX1u9+vdZp8Hxq4uDqhkfyjvhr75t7e2U1QACD2DZJ1o20g3JxkuZ/TgTK0wl+9
 fA1gmwD925ekrQ8DrP04Q3PuOPt3iIwp3kib6ndPRxMsqKzsJ5BPa/90Jz8s08mr3N7YsSHUj5U
 6xaFbjXKgQuHOdA==
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

