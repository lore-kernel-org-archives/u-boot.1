Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B357DC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1311F8219D;
	Fri,  2 May 2025 16:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IlrGTjOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623A38219D; Fri,  2 May 2025 16:47:32 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8A081F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85dac9728cdso61589839f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197248; x=1746802048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsvAlCH6+sr9/fE/TrstzsDyYMoLnyFjZwyR/A67l64=;
 b=IlrGTjOkKuu14c5eKTkQKQhCoLFLJH+Tm8sDqvSvtDOb3mR72IFlN704xdYU0DbAAv
 EvUmnHC9e87pXguSr/BqDPtGZMj+pCzE6QUJjksi+/wWNoVMIAAUw9GURv0Ai/82tSeB
 TH4qadjte7yHK5X6RTer7CLlfnkOmwucWgQbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197248; x=1746802048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsvAlCH6+sr9/fE/TrstzsDyYMoLnyFjZwyR/A67l64=;
 b=TGRp6isj0yYONpPg5rpbuJ/InPiC7FFOOlPX2CoI7uhI7EtySJkU+VHwG171m4Qtvu
 r7KuEkG0aHJxhAXuJjp76HGP0C6CrWr3fxszP5PzjaeWaVUS/RPNEh7+gy6P03hqyqxs
 wQHJ2jIuoqBUxaA68NR0+NcfBqILlN3YXCXsCzL40c4y+DXfTjKA/0wbDnGb4s1ypjwI
 e+oZeFTyVGOLX1+VsTnWBBWD3MZ60w/sFj2loRglvBPHY+GQFPC04be5wyvCIg6nNmCf
 KADg3WzutnSnS/gEKzFSRa11TVw/1QhdIVDAP7ybUTCLjQecBsJBEheMownePt/r+8PR
 kvEQ==
X-Gm-Message-State: AOJu0YyEqT8yXQDiT68cZS1LLJXzBYZQB+Zs+yIDMYA+jCN7b/I59QH2
 ML/MoHta2Amc+8KY3oSIfmn/ML2xVueKAYPz1tPZ4FsUwnMVBfVGReOboL/yNh4tQJLDfbo9USc
 =
X-Gm-Gg: ASbGncvhyDYdWp7e5nRIfJGZKcSZulPOvbLz7zbgw7sTXKo1e80OENmTB3sQkexkjvR
 NkljpVVIUAzaAGfgKdXuwkYxYq/MBMXcXn2TY7z/Y30uCkZ67AbcTgo+OhfArPkOouppdME/XkV
 cy4ZReKyd9Bk+2BTzoy7FpxPoBRXRUXS+ltLrhGSiwpsreHvnngk9I6kFOe3HRnfybyOuWjYcxU
 fGdpalkFI6jfJxVy7YDl1Odt0Um9Bc8at3t8tAD/vXqE5TzS3r60OjHvbhUuiKSmEAXU3hs8qpX
 na/EZm1F66pxqxFTIjHXRJGqM1sqozh2rA6TFoqYbWvn8QehWMeOw4UtdTVgrlVp3w6fEn4r2oi
 T1/3Wht513iHc
X-Google-Smtp-Source: AGHT+IErYdCy28YFWliaireWNqz3jaTk4vHVwk9HMevvpexQy5c5n1Su4s3h/NxixHZGil4oIJJd5Q==
X-Received: by 2002:a05:6602:2748:b0:855:5e3a:e56b with SMTP id
 ca18e2360f4ac-866b466c79cmr449012839f.12.1746197248129; 
 Fri, 02 May 2025 07:47:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/60] sandbox: Provide an option to continue on failure
Date: Fri,  2 May 2025 08:46:00 -0600
Message-ID: <20250502144718.313633-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Normally the first failed assertion causes the test to stop. Provide a
flag to allow the test to continue, as a means to discover other
problems later in the test.

Note that the utility of this depends on the test, since some tests will
be broken if any step fails. But this can be useful when there are lots
of test adjustments to make.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c         | 10 ++++++
 arch/sandbox/include/asm/state.h |  1 +
 include/test/test.h              | 13 ++++++++
 include/test/ut.h                | 57 +++++++++++++++++++++-----------
 test/test-main.c                 |  1 +
 5 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index d3bb8ff429e..ae004a69c98 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -468,6 +468,16 @@ static int sandbox_cmdline_cb_noflat(struct sandbox_state *state,
 }
 SANDBOX_CMDLINE_OPT_SHORT(noflat, 'F', 0, "Don't run second set of DM tests");
 
+static int sandbox_cmdline_cb_soft_fail(struct sandbox_state *state,
+					const char *arg)
+{
+	state->soft_fail = true;
+
+	return 0;
+}
+SANDBOX_CMDLINE_OPT_SHORT(soft_fail, 'f', 0,
+			  "continue test execution even after it fails");
+
 void state_show(struct sandbox_state *state)
 {
 	char **p;
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index b0dfc87f1f9..926761db180 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -103,6 +103,7 @@ struct sandbox_state {
 	bool upl;			/* Enable Universal Payload (UPL) */
 	bool native;			/* Adjust to reflect host arch */
 	bool no_flattree_tests;		/* Don't run second set of DM tests */
+	bool soft_fail;			/* Continue on failure */
 
 	/* Pointer to information for each SPI bus/cs */
 	struct sandbox_spi_info spi[CONFIG_SANDBOX_SPI_MAX_BUS]
diff --git a/include/test/test.h b/include/test/test.h
index cadf39a0c9d..51609e799b7 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -51,6 +51,7 @@ struct ut_stats {
  * @runs_per_test: Number of times to run each test (typically 1)
  * @force_run: true to run tests marked with the UTF_MANUAL flag
  * @old_bloblist: stores the old gd->bloblist pointer
+ * @soft_fail: continue execution of the test even after it fails
  * @expect_str: Temporary string used to hold expected string value
  * @actual_str: Temporary string used to hold actual string value
  */
@@ -76,6 +77,7 @@ struct unit_test_state {
 	int runs_per_test;
 	bool force_run;
 	void *old_bloblist;
+	bool soft_fail;
 	char expect_str[512];
 	char actual_str[512];
 };
@@ -299,4 +301,15 @@ static inline bool test_flattree_test_enabled(void)
 #endif
 }
 
+static inline bool test_soft_fail(void)
+{
+#ifdef CONFIG_SANDBOX
+	struct sandbox_state *state = state_get_current();
+
+	return state->soft_fail;
+#else
+	return false;
+#endif
+}
+
 #endif /* __TEST_TEST_H */
diff --git a/include/test/ut.h b/include/test/ut.h
index be5502e03a1..6731b43dba9 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -147,7 +147,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 									\
 	if (!(cond)) {							\
 		ut_fail(uts, __FILE__, __LINE__, __func__, #cond);	\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -159,7 +160,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	if (!(cond)) {							\
 		ut_failf(uts, __FILE__, __LINE__, __func__, #cond,	\
 			 fmt, ##args);					\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -174,7 +176,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 			 #expr1 " == " #expr2,				\
 			 "Expected %#x (%d), got %#x (%d)",		\
 			 _val1, _val1, _val2, _val2);			\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -192,7 +195,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 			 (unsigned long long)_val1,			\
 			 (unsigned long long)_val2,			\
 			 (unsigned long long)_val2);			\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -206,7 +210,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 #expr1 " = " #expr2,				\
 			 "Expected \"%s\", got \"%s\"", _val1, _val2);	\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -225,7 +230,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 			 #expr1 " = " #expr2,				\
 			 "Expected \"%.*s\", got \"%.*s\"",		\
 			 _len, _val1, _len, _val2);			\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -245,7 +251,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 			 #expr1 " = " #expr2,				\
 			 "Expected \"%s\", got \"%s\"",			\
 			 __buf1, __buf2);				\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -259,7 +266,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 #expr1 " = " #expr2,				\
 			 "Expected %p, got %p", _val1, _val2);		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -274,7 +282,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 #expr1 " = " #expr2,				\
 			 "Expected %lx, got %lx", _val1, _val2);	\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -288,7 +297,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 #expr " != NULL",				\
 			 "Expected NULL, got %p", _val);		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -302,7 +312,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 #expr " = NULL",				\
 			 "Expected non-null, got NULL");		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -317,7 +328,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 			 #expr " = NULL",				\
 			 "Expected pointer, got error %ld",		\
 			 PTR_ERR(_val));				\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -333,7 +345,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 "console", "\nExpected '%s',\n     got '%s'",	\
 			 uts->expect_str, uts->actual_str);		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -346,7 +359,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 "console", "\nExpected '%s',\n     got '%s'",	\
 			 uts->expect_str, uts->actual_str);		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -358,7 +372,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 	if (ut_check_skipline(uts)) {					\
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 "console", "\nExpected a line, got end");	\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -371,7 +386,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 "console", "\nExpected '%s',\n     got to '%s'", \
 			 uts->expect_str, uts->actual_str);		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -384,7 +400,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 "console", "\nExpected '%s',\n     got to '%s'", \
 			 uts->expect_str, uts->actual_str);		\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -397,7 +414,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 		ut_failf(uts, __FILE__, __LINE__, __func__,		\
 			 "console", "Expected no more output, got '%s'",\
 			 uts->actual_str);				\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
@@ -411,7 +429,8 @@ int ut_check_console_dump(struct unit_test_state *uts, int total_bytes);
 			 "console",					\
 			"Expected dump of length %x bytes, got '%s'",	\
 			 total_bytes, uts->actual_str);			\
-		return CMD_RET_FAILURE;					\
+		if (!uts->soft_fail)					\
+			return CMD_RET_FAILURE;				\
 	}								\
 	__ret;								\
 })
diff --git a/test/test-main.c b/test/test-main.c
index aa3eb5a3d8e..8515a77fe42 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -77,6 +77,7 @@ void ut_set_state(struct unit_test_state *uts)
 void ut_init_state(struct unit_test_state *uts)
 {
 	memset(uts, '\0', sizeof(*uts));
+	uts->soft_fail = test_soft_fail();
 }
 
 void ut_uninit_state(struct unit_test_state *uts)
-- 
2.43.0

