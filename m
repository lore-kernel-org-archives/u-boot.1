Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3632CE937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FDAD841D5;
	Sun, 12 Apr 2026 13:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OHz/4XDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5369F841CD; Sun, 12 Apr 2026 13:24:18 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE99841E6
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-466ec4c6846so1054460b6e.3
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993053; x=1776597853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnSMkKC6qnOXyoKVeTbvTUywTWvh6cT6Eaa85wQ6D0U=;
 b=OHz/4XDehllIy3tk5Zfjl6VAKjx1nGq6ySddBGFg4pb6NpHJftMPonHnE0QXRoXrJL
 Qi18XLcZMnc/+DQymfl6KfAB4aFosAxvvYk2dCX6/CrhmM+WudYyLq6Oc8HUK6CA6Vde
 lOX/8+kPoEHqVonjcAdZPHMGJoMfn+g1a0Qns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993053; x=1776597853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WnSMkKC6qnOXyoKVeTbvTUywTWvh6cT6Eaa85wQ6D0U=;
 b=jQS5/QRGGFOGhYu+zX65o1kjPE/yAFFDipYyEXVhLUd8G5QgoJ+eF2CDeXH5Ah74AJ
 VUaxglHKjOOwEA1K405tWJ04b4v3obNQdj3WSwUKpNCL22TSpNoL7SY+fD1HCb7BETGQ
 E5oJaxKm8V4Q851gWv3ctoA2OPxTvl3ESDv+iVC8gbOviNvnCXL8Zi4plmS36hCXGMmp
 3MTJxImN2FARVvEnYN+5BhK5tKtPfapLnKERFcF99LmapFt77U29rfAjJycEUBKyfpc7
 xmg6j2Es/s6IuostOXzjpduX0r6GEoGGr5tKMn/fbRFSJoI23fYagJ/Ecyg9G50tEtQC
 8Qcw==
X-Gm-Message-State: AOJu0YyUgroJwqn0Izcss7QqnUYxdnvXdYooT8uTpTwwSQ8zUiyfvnO5
 IrPG9maHsk6hRPowK9dfkUzVgl1omBP3EJteeYnXtFKJVTIqj6B9BrvYThENh379vDD8l7ghk08
 kaIAS2H+X
X-Gm-Gg: AeBDietv5KY9K2k3Yt7COUi/opOBSnzGT3SbP67ZI0ArJyB6eF31k6RBAfQiMpIFKaN
 KpbZ1bTSPb2Q6PGw85V0b7d9jZW3nQrgp52iz9scr51GBiENaUlJStXGF4xRD2i4TLlGnNJA0vO
 s0Em/kne7W3PdAGsJkRG0ybPQgjUZS5EhFmAHd1ejKhmhKxWnmWdlH1KKigaeJHcGI5Qkwk5Wg8
 fTujHiLrTm/n8rQS5rxdlefstlUB63IB1fvHbUgtAN4Ozmnz8fniK3gGHaWm/5FbqOOHwcpt9Z4
 rpVvBcO5nFkplxCOcTheNKWkzeKTIcJH+MtTQdGVoXbxodRGUUUoh2qyu05CimnoFgfXp3Jwyf1
 UhFb10WSKNnyQSfPy3h7vWU2WkiWhG5E07C2tq8m57HENVgzmYfBCjHogz1ac4+BTQIEBwcLll3
 aG7wff7u8KEZ+CIrHLzg==
X-Received: by 2002:a05:6820:986:b0:67e:21c9:ab55 with SMTP id
 006d021491bc7-68be5a6225dmr5075466eaf.3.1775993053591; 
 Sun, 12 Apr 2026 04:24:13 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/12] test: Add a macro to declare unit tests with
 arguments
Date: Sun, 12 Apr 2026 05:19:42 -0600
Message-ID: <20260412111958.943933-6-sjg@chromium.org>
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

Add a UNIT_TEST_ARGS() macro to declare and register a test with inline
argument definitions. The variadic arguments use struct ut_arg_def and
a NULL terminator is added automatically to the list.

Example usage:
  static int my_test(struct unit_test_state *uts) { ... }
  UNIT_TEST_ARGS(my_test, UTF_CONSOLE, my_suite,
      { "path", UT_ARG_STR },
      { "count", UT_ARG_INT, UT_ARGF_OPTIONAL, { .vint = 10 } });

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/test.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index c9b56c66eae..cdd19392844 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -49,6 +49,7 @@ enum ut_arg_type {
  *
  * @name: Name of the argument (points to ut_arg_def.name)
  * @type: Type of the argument
+ * @provided: true if value was provided on command line
  * @vint: Integer value (when type is UT_ARG_INT)
  * @vbool: Boolean value (when type is UT_ARG_BOOL)
  * @vstr: String value (when type is UT_ARG_STR, points into argv)
@@ -56,6 +57,7 @@ enum ut_arg_type {
 struct ut_arg {
 	const char *name;
 	enum ut_arg_type type;
+	bool provided;
 	union {
 		long vint;
 		bool vbool;
@@ -179,12 +181,14 @@ struct ut_arg_def {
  * @name: Name of test
  * @func: Function to call to perform test
  * @flags: Flags indicated pre-conditions for test
+ * @arg_defs: Argument definitions (NULL-terminated array), or NULL
  */
 struct unit_test {
 	const char *file;
 	const char *name;
 	int (*func)(struct unit_test_state *state);
 	int flags;
+	const struct ut_arg_def *arg_defs;
 };
 
 /**
@@ -236,6 +240,33 @@ struct unit_test {
 		.func = _name,						\
 	}
 
+/**
+ * UNIT_TEST_ARGS() - create unit test entry with inline argument definitions
+ *
+ * Like UNIT_TEST() but allows specifying argument definitions inline.
+ * The variadic arguments are struct ut_arg_def initializers. The NULL
+ * terminator is added automatically by the macro.
+ *
+ * Example:
+ *   UNIT_TEST_ARGS(my_test, UTF_CONSOLE, my_suite,
+ *       { "path", UT_ARG_STR },
+ *       { "count", UT_ARG_INT, UT_ARGF_OPTIONAL, { .vint = 10 } });
+ *
+ * @_name:	Test function name
+ * @_flags:	Test flags (see enum ut_flags)
+ * @_suite:	Test suite name
+ * @...:	Argument definitions (struct ut_arg_def initializers)
+ */
+#define UNIT_TEST_ARGS(_name, _flags, _suite, ...)			\
+	static const struct ut_arg_def _name##_args[] = { __VA_ARGS__, { NULL } }; \
+	ll_entry_declare(struct unit_test, _name, ut_ ## _suite) = {	\
+		.file = __FILE__,					\
+		.name = #_name,						\
+		.flags = _flags,					\
+		.func = _name,						\
+		.arg_defs = _name##_args,				\
+	}
+
 /* Get the start of a list of unit tests for a particular suite */
 #define UNIT_TEST_SUITE_START(_suite) \
 	ll_entry_start(struct unit_test, ut_ ## _suite)
-- 
2.43.0

