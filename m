Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB50E937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB949841FF;
	Sun, 12 Apr 2026 13:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hpEer5WP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8317D841D5; Sun, 12 Apr 2026 13:24:14 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C384841D6
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-464bc03efd8so2010721b6e.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993050; x=1776597850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gd5ka50w82XQuShn1IDs16nRmP+r3WISm8LWruzN950=;
 b=hpEer5WPwEet8tXDuyWBIfrYW/iXfwt1lyNOgK3Z0SzWbsQ/8WHV011TS4+zSfA7Vf
 FN/7luaA8sIAXGuOCbEAoYNnvaXRS1NCB8Gpl7AV5woXhXSHzfOLnsLHDZRvclVW4y/n
 tBJ0vsefUFshASPGwShJqNfbyrPZ13vax33C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993050; x=1776597850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gd5ka50w82XQuShn1IDs16nRmP+r3WISm8LWruzN950=;
 b=SUR2bxsHQUH28EinyrWqxsXFRMARgjj4oA5Ot2VtelR+LChtApiG1pmuGQiY9uxilt
 qk6EhI1XujJ5s1jXVfJGkyQRmEs86Dfa+RichgfOwvuOexbJo/CDl52e5VidDRxpyJ81
 O/6LgrPXSKbzxioAzrXh2uC+/jSl2raVVIrcG7TPKS9RxY/QDmUq9GJL/CavLsvp49Ms
 z+Yvx1ww2qeG0uisXaQ5f52iASsVSjxRgYUZcXJZPdaXsClhJWc1VdjW8GrDYXZnK+OM
 mXCzUKCv9G9aZMQOP9KMkguOXqwKJzfUFrAu+m8d3DGbaB6UYiS54DeUGzmXWCqNCnwx
 rGMQ==
X-Gm-Message-State: AOJu0Yy/rKz6WpU1oTR227W13aFsINwI1tR9FNqWBNMs8T8a7cHjKzIq
 HRxRC7pJt5LSz0aWo8zhaFFYibzV+e7istADkEdapT7vvg1Q029hI6DN2/AD7a0DDiU4FEPX8SX
 tEbMq0tM5
X-Gm-Gg: AeBDieu7Srel46UO92zxFLqsFSDbLiYlfyxOG7izUOwJvXzTDz2cmxxJ6JpK6IEE84U
 zy2XBQ/6hBbiLZdEFwxUU4xS9B7kuSY88WL5AJf1ePX4eVDCS7CTJCYwj0FFu+ddJ55EHFNsswN
 BCTcV+bSs8T8B5dHW4PnI5tRpdlbyz75baxlOqhlLDVGi9oMkWV2qQ1lYHNtuXiBdvQRmQGwBG6
 cPvaGljELPpbsh47LvZzt3hujVhJZL0UvT76xg+UItFQcDbRuG/dYvWvjDUH0JWJSuAA1D0GRM0
 joih5Vs+bEo0CrrxPI5Q8biGIY9LIw+YMYgwkeGYG89JuO7j+oepti45h89ZsPuO7y8hG47YqvD
 JpfhhNEoxav4FiAKWT4UsygsbJnqA06Eafy+jlpxBsA9CQxA18lcsCS5kXvFD3tOe6FEkcLF86v
 OsWI/RH/gQMV/jeMqsuw==
X-Received: by 2002:a05:6808:c2b8:b0:467:2926:1252 with SMTP id
 5614622812f47-4789f9ff601mr4845821b6e.30.1775993050239; 
 Sun, 12 Apr 2026 04:24:10 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/12] test: Add argument-type definitions
Date: Sun, 12 Apr 2026 05:19:41 -0600
Message-ID: <20260412111958.943933-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
References: <20260412111958.943933-1-sjg@chromium.org>
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

Add types for declaring and storing unit test arguments:
- enum ut_arg_type: INT, BOOL, STR types
- enum ut_arg_flags: OPTIONAL flag for non-required args
- struct ut_arg_def: declares expected args with defaults
- struct ut_arg: holds parsed argument values

This prepares for passing key=value arguments to tests via the 'ut'
command instead of needing to use environment variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/test.h | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index f8a80a88959..c9b56c66eae 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -29,6 +29,40 @@ struct ut_stats {
 	ulong duration_ms;
 };
 
+/**
+ * enum ut_arg_type - Type of a unit test argument
+ *
+ * @UT_ARG_INT: Integer argument (hex with 0x prefix, or decimal) -> vint
+ * @UT_ARG_BOOL: Boolean argument (0 or 1) -> vbool
+ * @UT_ARG_STR: String argument -> vstr
+ */
+enum ut_arg_type {
+	UT_ARG_INT,
+	UT_ARG_BOOL,
+	UT_ARG_STR,
+};
+
+/**
+ * struct ut_arg - Parsed unit test argument value
+ *
+ * Holds the parsed value of an argument after command-line processing.
+ *
+ * @name: Name of the argument (points to ut_arg_def.name)
+ * @type: Type of the argument
+ * @vint: Integer value (when type is UT_ARG_INT)
+ * @vbool: Boolean value (when type is UT_ARG_BOOL)
+ * @vstr: String value (when type is UT_ARG_STR, points into argv)
+ */
+struct ut_arg {
+	const char *name;
+	enum ut_arg_type type;
+	union {
+		long vint;
+		bool vbool;
+		const char *vstr;
+	};
+};
+
 /*
  * struct unit_test_state - Entire state of test system
  *
@@ -108,6 +142,37 @@ enum ut_flags {
 	UTF_UNINIT	= BIT(13),	/* test uninits a suite */
 };
 
+/**
+ * enum ut_arg_flags - Flags for unit test arguments
+ *
+ * @UT_ARGF_OPTIONAL: Argument is optional; use default value if not provided
+ */
+enum ut_arg_flags {
+	UT_ARGF_OPTIONAL	= BIT(0),
+};
+
+/**
+ * struct ut_arg_def - Definition of a unit test argument
+ *
+ * Declares an expected argument for a test, including its name, type,
+ * whether it is optional, and its default value.
+ *
+ * @name: Name of the argument (used in key=value matching)
+ * @type: Type of the argument (int, bool, or string)
+ * @flags: Argument flags (e.g., UT_ARGF_OPTIONAL)
+ * @def: Default value (used when argument is optional and not provided)
+ */
+struct ut_arg_def {
+	const char *name;
+	enum ut_arg_type type;
+	int flags;
+	union {
+		long vint;
+		bool vbool;
+		const char *vstr;
+	} def;
+};
+
 /**
  * struct unit_test - Information about a unit test
  *
-- 
2.43.0

