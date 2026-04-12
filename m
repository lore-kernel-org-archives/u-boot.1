Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3FEF3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7C58418C;
	Sun, 12 Apr 2026 03:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1FVECCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D2BD83B99; Sun, 12 Apr 2026 03:35:26 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9494D841E6
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d7fdb922a5so2721547a34.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957719; x=1776562519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPyfSm5EVH+7daZH9oNJDxBmGsFCMCivITAhTXZqNQc=;
 b=Q1FVECCuNWYqfsKkU24RPL44JqdG4F1dKDD7koWSfb7Z4O2CyM6EP73aNIucpIUy/y
 XlsSVjWk7Qc4u6OA+kRvXAZT32Yih2UpcpeO2PQVzExbKFuFZKIeAE48/kpEGnQJba8B
 58P/VqajG/JgH75jM4cKRTnmhAmSUn/rIzjXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957719; x=1776562519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SPyfSm5EVH+7daZH9oNJDxBmGsFCMCivITAhTXZqNQc=;
 b=gOkR4ubv3JSz4Al209r6oaqooKa+b5pBMnWCom/EtQAynT3PP/D0mbkYdlkxeYttmG
 c0XHPX+KYmWZhyWmsuPFHbBEDJr5jx3sYT1pewDDtLy11W1dwv9NGaJ+OMap6oMeAUWk
 0+N0Ng/xJPBFWBe25HKwJJ8vHX7iglpQ7CV1OUNwj8ogt3AVbMBevkNgtWNR4TgurtzO
 jeembaUEQ9lTCqnlz2io+hDpCWXvYPS2iDwHuub0LUxkxr4HXrL6HC+wdkDhu4Cber+P
 fuIXKl+Qv1vNcBg52UjsTVkDBiUzWGHJ55NkWbeIFdyhUNLvH5tzpd3Me6+5URJRhM35
 VXEQ==
X-Gm-Message-State: AOJu0YzdvFzdtHeZEcJUxTDFzBss3LQQB46OVPMJE0DuV9TLUCODkUa1
 ZBqztBaVvp4cSJgNFLftHQ1MtbvazA5GzRik1EJY8OBdL7TXTwCzg8gaqXz9coyshZKAdbwUGlQ
 K+ZnM54uS
X-Gm-Gg: AeBDievCV4eBM7BZU4M+DVbqNmdcK/6wjzzbjKVUQvucDyptaF8RUKIGv1yO30Owvsn
 kOn86jaHYNhjdlSfmO96qcp6hSVb5XnWbcHMZUPcGChta8/8KEdI1OJfCjTBSKJFB85iEClSs/H
 rTplwOcAL/qhFKjijlpnz7n/ijCDYPWUEM8J0zZ1XggRgmfWfU5+xuvvQK/ve+wfcWRTotmlDO+
 U2cBTVf6ax9GmCxX2/ooVSEHUstFgl/6dK2qNSelNSt/GTjdmEcL0C+iWANOwaGW2NdSvnodLwB
 GdfpykrLFOglnt3/vpKaSVP9JC7com0kF/N6+99oF1S3dPqIz4q7r73IO0J+ViHh0xPg7vSWfwz
 llu55RcVvjk+5wn0ZDt2r5+5X1I3CL6VUuADaYZCd+Fd7F+4UllSvF2sIqzrkg1H/n/r/o1b8OU
 sEOP1HjVkTjYGnIPdIW4x3rnptgT8Z
X-Received: by 2002:a05:6830:6f43:b0:7d7:ebf0:34b2 with SMTP id
 46e09a7af769-7dc27dcfedemr5074075a34.14.1775957719153; 
 Sat, 11 Apr 2026 18:35:19 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/12] test: Add a macro to declare unit tests with arguments
Date: Sat, 11 Apr 2026 19:34:33 -0600
Message-ID: <20260412013451.2929001-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412013451.2929001-1-sjg@chromium.org>
References: <20260412013451.2929001-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a UNIT_TEST_ARGS() macro to declare and register a test with inline
argument definitions. The variadic arguments use struct ut_arg_def and
a NULL terminator is added automatically to the list.

Example usage:
  static int my_test(struct unit_test_state *uts) { ... }
  UNIT_TEST_ARGS(my_test, UTF_CONSOLE, my_suite,
      { "path", UT_ARG_STR },
      { "count", UT_ARG_INT, UT_ARGF_OPTIONAL, { .vint = 10 } });

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

