Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC00BC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA1A81951;
	Wed, 19 Mar 2025 12:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SK+D24YM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E977081D0B; Wed, 19 Mar 2025 12:59:41 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68C481101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso4165588f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385579; x=1742990379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+gnFfz6TiF4YVdmYKb7ipheEfG8B/qfd4ePWNzngiY=;
 b=SK+D24YMgTVwF3R9U349Fe7iSNlMIJuYLhvf/zE+0b1GIDUq/8mHlkjQQAIMIfblFy
 SQ4G5FwgZwM9C+Zmr0CtgMR2lb3JYt8BbMPbPFPf45g5TM6jdvYbvxHjl9IrGYuzgIf+
 2+IAD4BzZvwvO6hvyr7HrIVc/qtlUv8gNcLvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385579; x=1742990379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+gnFfz6TiF4YVdmYKb7ipheEfG8B/qfd4ePWNzngiY=;
 b=SZinPcuB5h7nHX82RlzspyviD3RUGR/INhDJdbs9HgY0WJGrUctv1P1TgXeV4K7acu
 sCyWPfkQlIysg64iH+84+XZbgx+WFmM5U5GkWRGOQwmkfuy410RTT2GCi5BrprL1J5zn
 g+ryx4ylbbpO6VrnIJveTO57i9Ee48Vv+5dKjMrAB8gBhhimoI5O2HMZXMlZonkC6aOK
 2rSMEZw9iJzjbjEVEWzcS15mqNd1wtZUaRbM6/NYf9cP7UYKNTIW1SOD4z0H0JijZGdl
 PFwMDTWa+nV7jqLjINNFo1ipfBIGoit2ZkrGfFCurL+h+UrMGxR/RsdPmPGRsWigqSde
 LNhw==
X-Gm-Message-State: AOJu0Yz9uiTXL0PZzYrdOhbHdMTRHvf80Q2O7NGhYrREtb6IlMF8fy9G
 KK2P4tLuSDgWICKNXW+e7CHaEzdafRfTmwb0YZCvlOtkDI79BXeEEtpOxYd4FjL9obfOgYee6Vg
 VCg==
X-Gm-Gg: ASbGncsViKwWasvvxDQw08CpDkczZ4FLIen++YfelPOsCJ9TPwwMMWHJIQyUOXL8ZPx
 yS3WHFKaP5aIUEKu9LSVZh14GPGvvXY6bqE3dKmgFXUkP+mKGp0iLB4pnLiCDE1acEEMDKd+uwN
 SassDrUsiKHAeJXH2W/LfrRLyWv6Z/Bby5XSnI/BDj+ZX3Qjji7LScf9BskMXbOnGd+I+YfI4bR
 G4Y3AT+xbp+dDfWvgBzDZRVov6yCsNFxZTtcGQfPAQZuxp+AdNR3FMx74uCPbUrpyIdo4xprBwR
 GI7PEZIuUncjPqP2FrUwVCde8f6zY50qM7pw/qV1ew==
X-Google-Smtp-Source: AGHT+IG9+VKVdEIsm4wD/j0fzvCWZdzYvCmwapdgwXrgd23J5WkCIhCZfP02B/j3+7kKOElSZol5/w==
X-Received: by 2002:a05:6000:1845:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-39973af6f43mr1833529f8f.43.1742385578524; 
 Wed, 19 Mar 2025 04:59:38 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
Date: Wed, 19 Mar 2025 12:59:08 +0100
Message-ID: <20250319115911.2204045-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319115911.2204045-1-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
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

In some cases we want to show a signed value to the user without needing
to use the full printf() implementation. Add a new version of the
simple_itoa() function to handle this.

Update the existing function to use ulong instead of long, to avoid
confusion about which it actually uses.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/vsprintf.h | 14 ++++++++++++++
 lib/vsprintf.c     | 29 +++++++++++++++++++++++++----
 test/lib/str.c     | 17 ++++++++++++++++-
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/vsprintf.h b/include/vsprintf.h
index 9da6ce7cc4d..cd079684572 100644
--- a/include/vsprintf.h
+++ b/include/vsprintf.h
@@ -219,6 +219,20 @@ int vsprintf(char *buf, const char *fmt, va_list args);
  */
 char *simple_itoa(ulong val);
 
+/**
+ * simple_itoa_signed() - convert a signed integer to a string
+ *
+ * This returns a static string containing the decimal representation of the
+ * given value. The returned value may be overwritten by other calls to other
+ * simple... functions, so should be used immediately
+ *
+ * If the value is negative, a minus sign ('-') is prepended
+ *
+ * @val: Value to convert
+ * Return: string containing the signed decimal representation of @val
+ */
+char *simple_itoa_signed(long i);
+
 /**
  * simple_xtoa() - convert an unsigned integer to a hex string
  *
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c7340a047b2..478d445a569 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -845,21 +845,42 @@ int vprintf(const char *fmt, va_list args)
 }
 #endif
 
-static char local_toa[22];
+static char local_toa[23];
 
-char *simple_itoa(ulong i)
+char *simple_itoa_(ulong i, bool use_signed)
 {
-	/* 21 digits plus null terminator, good for 64-bit or smaller ints */
-	char *p = &local_toa[21];
+	/*
+	 * 21 digits plus sign and null terminator, good for 64-bit or smaller
+	 * ints
+	 */
+	char *p = &local_toa[22];
+	bool neg = false;
 
+	if (use_signed && (long)i < 0) {
+		i = -i;
+		neg = true;
+	}
 	*p-- = '\0';
 	do {
 		*p-- = '0' + i % 10;
 		i /= 10;
 	} while (i > 0);
+
+	if (neg)
+		*p-- = '-';
 	return p + 1;
 }
 
+char *simple_itoa(ulong i)
+{
+	return simple_itoa_(i, false);
+}
+
+char *simple_itoa_signed(long i)
+{
+	return simple_itoa_(i, true);
+}
+
 char *simple_xtoa(ulong num)
 {
 	/* 16 digits plus nul terminator, good for 64-bit or smaller ints */
diff --git a/test/lib/str.c b/test/lib/str.c
index e62045318c0..d6d29bbf3eb 100644
--- a/test/lib/str.c
+++ b/test/lib/str.c
@@ -221,14 +221,29 @@ static int str_itoa(struct unit_test_state *uts)
 	ut_asserteq_str("123", simple_itoa(123));
 	ut_asserteq_str("0", simple_itoa(0));
 	ut_asserteq_str("2147483647", simple_itoa(0x7fffffff));
-	ut_asserteq_str("4294967295", simple_itoa(0xffffffff));
+	ut_asserteq_str("2147483647", simple_itoa_signed(0x7fffffff));
+	ut_asserteq_str("2147483648", simple_itoa(0x80000000));
+	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
+		ut_asserteq_str("2147483648", simple_itoa_signed(0x80000000));
+		ut_asserteq_str("4294967295", simple_itoa_signed(0xffffffff));
+	} else {
+		ut_asserteq_str("-2147483648", simple_itoa_signed(0x80000000));
+		ut_asserteq_str("-1", simple_itoa_signed(0xffffffff));
+	}
 
 	/* Use #ifdef here to avoid a compiler warning on 32-bit machines */
 #ifdef CONFIG_PHYS_64BIT
 	if (sizeof(ulong) == 8) {
 		ut_asserteq_str("9223372036854775807",
 				simple_itoa((1UL << 63) - 1));
+		ut_asserteq_str("9223372036854775807",
+				simple_itoa_signed((1UL << 63) - 1));
+		ut_asserteq_str("9223372036854775808",
+				simple_itoa((1UL << 63)));
+		ut_asserteq_str("-9223372036854775808",
+				simple_itoa_signed((1UL << 63)));
 		ut_asserteq_str("18446744073709551615", simple_itoa(-1));
+		ut_asserteq_str("-1", simple_itoa_signed(-1));
 	}
 #endif /* CONFIG_PHYS_64BIT */
 
-- 
2.43.0

