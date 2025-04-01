Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E381C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA0E820B3;
	Wed,  2 Apr 2025 00:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ui9o7GVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A239081FEE; Wed,  2 Apr 2025 00:59:05 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A485280584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72bd828f18dso1806402a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743548337; x=1744153137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzJQzhUuP6Nf9zJL3LzpVcvKPsFCNm/R/ZhjekrfvTk=;
 b=ui9o7GVg9W8zQzCPS4//XSMY2u1SnTsbfoJwNIRU9+AHHB3Up3L/lMpTU9SLYyWK2H
 uSMFaLRYB17Gtfr5Dg8Vl2XYJY/Ck8WUJdooYG/PjQfPJmj4twqyFu5aEXACgd/Gs4w4
 Lo97Lwj/NMUI8A+YXYz6Xcqmzg1XB9Fv4UgTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743548337; x=1744153137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzJQzhUuP6Nf9zJL3LzpVcvKPsFCNm/R/ZhjekrfvTk=;
 b=bhjml9uoeY4b7NEF2SCVJbrCUUHAnXpWokuNp6fZh4ApWkxFyA58GXTiZNTeKtCGA/
 vcVZ+uoqx1L8db2XeOAs8LqLWFqJ5OKVRwXElOIJCVCM7Ys+uEF64cOGrFUBQ22N2kB5
 Ou3YjroPr2/fZ4scfhfHQWjB1RUcOX/7g96D3Wkbb2ZHdXwke3UIuWEYTi0Ioh01YMuk
 xxug32pcTzDV9I5LUrIbcnk3MXOQPhsp6YJnxyTtlmmkuhdacvVhWNC8bJm5JP0XXQKb
 eiIYddLCcSXAMO5soxUnX421ChZxyv5CgYo2p/nA2uUUsMfKv7hGjvCalb2aY4l0ne0G
 2l6w==
X-Gm-Message-State: AOJu0YwyiYo96UsKlqz67DyiI8X15+139cBQPIlX5P2+LIf6dTX/muh/
 Jh6joZE+hJ7UEDg83F6bMurLKF6/x7uk0Yw7AmpalFEiyZt02uNQ3hfaOSiTl4FgmhcXOsJ3Btc
 1
X-Gm-Gg: ASbGncuqnkELxsObDPvbfnyT2RaACnhLzXYEoaDJHyy8VSYhBs1Lk8HkGVhcTTKo1bQ
 sxjhE4ESNceizNh85RL1GbNtTOGXR99X6qbXRba6wteTWW6lS0Ux2Sg7J4lMTvs1P81TCQjj7iH
 RBPoFnWpL6jBsAbm5hTgJCEt3NHF4wauCQx2JzrK8W7upV0GEx0vdp4cYshby9x62prAsq9+ntO
 JN2fkraYhBhHMtAN3MWcgAEoLyQ0ZDprGwHQZsT5EetevoF/pgDF44hOclbKHc/T138Siu8mejB
 hlAuZWYzVLwkbYJXa2mtpyuKXNUUCQTjhD1ificlo6O+bOG/13G1LY4m3e72I+VV1Hp7rZzRuP+
 p2n4lXuaR
X-Google-Smtp-Source: AGHT+IEkfjZwAj72p+tBf71MS+LIsHwzLw2Gxs205uavk6C6UKmjrD7IV4VMM/jGsvW/45Rbh+O7wQ==
X-Received: by 2002:a05:6808:1524:b0:3f9:43dd:a054 with SMTP id
 5614622812f47-3ff0f5f4c6dmr9433157b6e.34.1743548337305; 
 Tue, 01 Apr 2025 15:58:57 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a3f3e52sm2528791fac.6.2025.04.01.15.58.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:58:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v3 2/3] doc/develop/codingstyle.rst: Add a section on
 conditional compilation
Date: Tue,  1 Apr 2025 16:55:24 -0600
Message-ID: <20250401225851.1125678-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401225851.1125678-1-trini@konsulko.com>
References: <20250401225851.1125678-1-trini@konsulko.com>
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

In order to make a start on explaining how and when to use certain
macros, we need to document their usage somewhere. As a first step, take
section 21 of the v6.13 Linux Kernel coding-style document on
conditional compilation, verbatim, and add it to our documentation.
Further rewording to be clearer about U-Boot will be done next.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Reword the commit message to be clearer about where this comes from.

Changes in v2:
- New patch.
---
 doc/develop/codingstyle.rst | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index fa3cd6aec82e..7211e4e4eed1 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -154,6 +154,54 @@ See `here
 <https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation>`_
 for style.
 
+Conditional Compilation
+-----------------------
+
+Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
+files; doing so makes code harder to read and logic harder to follow.  Instead,
+use such conditionals in a header file defining functions for use in those .c
+files, providing no-op stub versions in the #else case, and then call those
+functions unconditionally from .c files.  The compiler will avoid generating
+any code for the stub calls, producing identical results, but the logic will
+remain easy to follow.
+
+Prefer to compile out entire functions, rather than portions of functions or
+portions of expressions.  Rather than putting an ifdef in an expression, factor
+out part or all of the expression into a separate helper function and apply the
+conditional to that function.
+
+If you have a function or variable which may potentially go unused in a
+particular configuration, and the compiler would warn about its definition
+going unused, mark the definition as __maybe_unused rather than wrapping it in
+a preprocessor conditional.  (However, if a function or variable *always* goes
+unused, delete it.)
+
+Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
+symbol into a C boolean expression, and use it in a normal C conditional:
+
+.. code-block:: c
+
+	if (IS_ENABLED(CONFIG_SOMETHING)) {
+		...
+	}
+
+The compiler will constant-fold the conditional away, and include or exclude
+the block of code just as with an #ifdef, so this will not add any runtime
+overhead.  However, this approach still allows the C compiler to see the code
+inside the block, and check it for correctness (syntax, types, symbol
+references, etc).  Thus, you still have to use an #ifdef if the code inside the
+block references symbols that will not exist if the condition is not met.
+
+At the end of any non-trivial #if or #ifdef block (more than a few lines),
+place a comment after the #endif on the same line, noting the conditional
+expression used.  For instance:
+
+.. code-block:: c
+
+	#ifdef CONFIG_SOMETHING
+	...
+	#endif /* CONFIG_SOMETHING */
+
 Driver model
 ------------
 
-- 
2.43.0

