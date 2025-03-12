Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034BFC282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 01:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D4080F9C;
	Wed, 12 Mar 2025 02:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JuZDr0Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6108141D; Wed, 12 Mar 2025 02:01:25 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3E380FB9
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 02:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c04df48a5bso548708285a.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741741227; x=1742346027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GOplxEMRDmX7sPJSO17yQKhev0C8k1TccJ98w06iWv4=;
 b=JuZDr0Nflrkn2scuzMET6t1S5y+l9z6/IEHuHHjqZb9oarY0q0hDXlTTUuTWopQ+PY
 8aTS75qKZGfsn6UAVo6UT4f+Sn75jjSMUi6TlTlhbiM5PbZqkOvQpNZtuhfC9lYzZuin
 +k8iBJfH95oZlw480J4uWpQTW2GdsNcmJNAas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741741227; x=1742346027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOplxEMRDmX7sPJSO17yQKhev0C8k1TccJ98w06iWv4=;
 b=lt5Q2BNlblqbFpHRnV+7m+0Zd9ocLYQe3/Oy0FMcBJzJjp9LUZhm6x9a42NTpcvryr
 Pt2fio+TzSJv0ExCRg65OEBJRC+Tm2fqipZgOGRbr5m/Hv3wBFu6gWXUMoDIUL6HKxf/
 LjhO+EWHqBRo8h9DP+Su9/ME5QPLu7Bx4Qjt1YKiOjQemR6k7q//lIW4y/ogbsJASXFI
 drUpULeS2C5TpH+wj1/ra/wzXUK3RrUaqPZ8rKE7JcgAD4WX9my0PaFNWTOF8+KvPPgw
 TXpTJd5i/uDYNGsJUCnms/yfeFBrWzdS2awL0mpXYtkiET5yfgvjLY4a1GDGCPxB+0tq
 wTAg==
X-Gm-Message-State: AOJu0Ywr+hUSp+7p2qqT99nsOLjjCjDWy4Jo0d4AdGF40Wgf81BqZhTY
 uAakJwvGwuWaLNxMuR8rI99pNE/0WIkRyIgexngqhBGo2AYKRw39aqvWLq2u4ggfG691xoWwgUM
 p
X-Gm-Gg: ASbGnctuddlkrV0kIPx+NDKDyLFtDzXUHARrQqFUNMvJiaGX5PGv28B0GQv2lgKP/1u
 loZvcovL/5BO2Ldtn64f4vXCnUM9BzWX32KkYfaUvbiiJSza4ySohmXN/NXNxgVVyIl4cKo2lJy
 +L0N8y+sIJ7g+rBMfiG7E/iPEMIqZiJ+68QAE4Jc3tjn0WpsVar0F7xXkKkkl0QknGNJPTAi1Dy
 gDjSj9Z1F2uGbZt/i3ppTdrA/gOGHLXRUZHEsgdL0hXEJO5BtgFY/7L0pjUXSRbZHAGCklx+4Qi
 jMpLxEi5wFDoYeGzTO8M1u5PVj9a08hExgI5cl8E4K1XnyT0w85nS/jkCh4=
X-Google-Smtp-Source: AGHT+IGClaaztaiqt0xPM8Zhuo0xzUpFxz510xp03JiIu1zH4QrIXNvJQU+RJjmuPAz3SxDXCd3c8w==
X-Received: by 2002:a05:620a:2603:b0:7c5:3df0:48cf with SMTP id
 af79cd13be357-7c53df04ae1mr1932588085a.3.1741741227396; 
 Tue, 11 Mar 2025 18:00:27 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c55e15e86csm227843985a.48.2025.03.11.18.00.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 18:00:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 2/3] doc/develop/codingstyle.rst: Add a section on
 conditional compilation
Date: Tue, 11 Mar 2025 19:00:19 -0600
Message-ID: <20250312010021.1671010-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312010021.1671010-1-trini@konsulko.com>
References: <20250312010021.1671010-1-trini@konsulko.com>
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
conditional compilation and add it here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
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

