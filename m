Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB22C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A26082BCD;
	Tue, 29 Jul 2025 17:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FMTisRyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C497E831BB; Tue, 29 Jul 2025 17:52:51 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB10E81E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so2798482f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804369; x=1754409169; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FdvkfD40QhuGJ5QakwIHoYzEZ/nfFxwURI/GQfV8frg=;
 b=FMTisRydstMNm1KtiLo199YH//pDDtTmbdgCu+bb2z9aUVOS9zX0wLUn6ZaScTHVZy
 qAhy35Ufa5Ruf7JXJ5Pbzf/EFZgjepmNYr3oEkU83dSdfhTzYG6OBQttT7t+p6K4skBI
 StvBiMWa08Muo7PTm4XZw7QT/4a65OqqicL5qomS0K/4nbDBRuXT0H9mkIYSPv5yitpU
 mmKFKzHQTi2OMWBMTzYVsxRNgxsa1hDxc0SIIxqhJ/RqUubbR0w/sHmypf8O4T1fco5b
 dChn/nsYc7R+rMnjOi8K/QAiJKV4s0b2NZzRMjlmcHzHKeX5H5ZS4BxuKQRgHciB1nZ8
 xomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804369; x=1754409169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdvkfD40QhuGJ5QakwIHoYzEZ/nfFxwURI/GQfV8frg=;
 b=kmxIz1u0EyKgjXRVMGn8dprOBFESYaDIOrvu5+2wlXVMH5hHjKJMo0mL+NSUCehZdF
 LZBzMPbI3wwlPI3SG1gVdjSMmetNmIkzCVt3cagdeohclRP+HVvyH2BUEBXK4Ffz3HmI
 Zq9+0qWcSmAbcosj7bVPahixSZyStXDiv8LKUGVniPUuD0BuN1SiVc/rHWYAouad3q5o
 jxvoafCepWhfhikwP1s4v05/4j3rsdwt/z9fSMA0cNdQ0yBPkMrJoBK64CaIXedzpBNP
 kfkunHXG9BNf9xVw6GY/VP5b4COrheYA992DWI+Vh+vozg82LHBOAYCpaPwF+1i6aeSq
 9mrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpi9+5o6iKsBsSjk0mFVs6CGWnGjqnLt4cfIrRXypvhXBld0rdNHT63rXxnHOzG5GtyGy+amY=@lists.denx.de
X-Gm-Message-State: AOJu0YyR6i49Tdnmc3jF4GwDtW3hIAi+Mm/nIYZt5WrHZ1Dw7ZFCnr35
 OxUz1FZ5tIf+D5ZGothn9zF+ezcFGgxRC2yb6mJ69A8TWEi4na5nksr7M8CkS7CYY078EP1ztgr
 5whn6
X-Gm-Gg: ASbGnctVwE0ugdvRN7SsvKE80Xo2nGVjdPL3nCfm5cqKGdXOjrUGoLgwsDEpQzWD2UZ
 gRx2Vw/woepoM/e1Vrqz9vUO4Wx+34KAFn1waQMWDw/+BaYQoDGNjcqzXD2+WbhTWbkSlo6m9Ut
 FeBB0bHiE1Bb+Hswx4M/bjYFeLqnoYZKfnsxCZuZj68qF+7kZskkoPHKH7cPBTt4PMY2rjQ7I+c
 T1J0I9dh2SiMW+XpdAjRSJfsuQthLXAFEN/Ez4swzD+lBgwflwGaRv+gV2kjzdwlQOzzsCMqGAy
 tF7SYjvB9qdGmCOckyXurwLIE5IQQtRh4P5DRoMgw0ZCzcDM7OEJ1o6ooBIcNY+MMoRXoMaKkFB
 XMsz2Nd+rLjelCX78YFS6rrg24fmqYQ+608wvrvdYcm1baQQnUy8gCMKIukokrLPGw7I4OIzpDE
 RqCX02ctRUQw==
X-Google-Smtp-Source: AGHT+IEFdu6CnVRGzh1usjOio1HAlnnNXa34xb6wr7f0fw8NS7hG9GYZQ47OdIHvMF+AX96WWAyOHQ==
X-Received: by 2002:a05:6000:238a:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3b79500efd4mr138536f8f.44.1753804368853; 
 Tue, 29 Jul 2025 08:52:48 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:48 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:05 +0200
Subject: [PATCH v4 07/10] lib: vsprintf: implement %pS format specifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-7-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4kACRbOXQUOMamjiSFCA/qYQBjmqLPBefRs
 g1diABx+nqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuJAAKCRAFgzErGV9k
 tkh+D/0TTr7XqZdhQn2z2m0fCCqIf6FwFX3cQyMPAi+mwd4GCXonzq/JrvOi2dvjBRsYenM5olD
 ovwb7Sl0t5TaDvL5tmsKPTTXAXVs9aGTrTT3Ws88tvJCmSAV0Xq4dczR3TNeopISV8IL1uyagC9
 MnL9N8NQKFgZUO3D2kCGRmU+t6CoJG9C+u9nFnGEJtBMvdgZdXszgETDiz/Wv2O30fIik3zRr6D
 15HbE05BqZUpADXqIcqQgtV550vuGBPB1FNjeWkQxvqvlXXyiAmldbXHDHUuGe7hhgHIvhMtyGU
 umNVL6c9xt49mOSUKycSoPHxi+otZaB+SFNlNLaJYRWf/ruGoTN2UGg0J8u20yFyrYuycuidUL6
 QxZHgXG4ml6DQgw6BtycD0ExCch5dUq/uwSj0Xq6EH1xxy/WWTy+M1cRb0fkl+UZakqIhftX8N7
 YRR7Emqy3GaMR/AVaAdkiAizhdB82/KhVSgDTZqzulEHUeifPlLkvtb7DRYmpjmMo3zZKJfO81r
 qt8DFytefC2N7Ccsg6KhE2L0PQc4XbuS/JeM6hX3WumRNv7QyeNNyE0R2zTT7wkvRK1twYql4A0
 M7k4hrCpx6R2LdY8JTIuM5IhsFAwaL5xXtNmZKfI+eBMvVTHvHElbnjAn/5TZSjwNmJiqWxjiA5
 R/umwclNTXT85eg==
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

