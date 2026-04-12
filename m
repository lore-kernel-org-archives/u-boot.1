Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0164DF3ED67
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393BB84220;
	Sun, 12 Apr 2026 03:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U/F6xBdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89692841E6; Sun, 12 Apr 2026 03:35:21 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF6F83B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso1674184a34.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957715; x=1776562515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jRNRrNr+SlAMzhOHrqNuVXEzu7yUxUKxR9oOj7BpA0=;
 b=U/F6xBdW9mNtJwHZEp3tByFJwcVkV45OMNl9FPAkDS5xbYTDOEKXXcrYORVMrI5Qro
 shG2dHo0Pg5uLyQf49GBOHsqPkYPJydj2YqLgnl3+DXHbVh10H3Qt5eWKZGgi4p2Evtv
 vcbpMlwuM5vGeY3OUJCo8P14joic9FseRgxww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957715; x=1776562515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0jRNRrNr+SlAMzhOHrqNuVXEzu7yUxUKxR9oOj7BpA0=;
 b=LGt4HmJITYobH4cO8LIbL82dQEVY+RrlGvdAkqB3gw8FlWOi7DOqPzmdeslI4ujkkl
 FwGt7ueaYO0xS8dL0yDlBvFCEg1+8/uZ5pN7UDkvEmsQ26JGB4X6LFckl5n+NR3HdBY5
 gVkJmIuY/Vd21eJGeA/GEzLLcDoBmBH69AFa0RqD2XuDDhj6BR6avC9iT6A+KDSgYpbk
 q1Q6256IbmXaucBIHUKWIHNNvM+ui7dCebzXvXmgpBw+TV+bhZlJHMUNB5zGvTaI8lGP
 JIJX7oQ+SNvi4SB44phH7sgcLmijnN/TQafRsT1BZu23H+O6/edSMiX09Ek9hh0vwV5y
 Go0A==
X-Gm-Message-State: AOJu0Yxu+ehMOYm2aVSSMyV5cxVT1VSpqC4m3t9OSENGO7+Z6L545U1j
 gfigARMcEo7lghrm1SGI85ZndD+XRFX5ky1SRxgrFHanggKL8zMTICOtjL84XOnE0X2gymOQPAn
 FIqV7DEij
X-Gm-Gg: AeBDietz/8bZaQV63Xw2lOZ2uBeW9XUzWrKLKvwDQfJPGRC0Ccn7mfraeiuN2jvFyZH
 rVqj2IV1o9Knm3meRfNBIsl5v0z8NbYSnC2fM8/FERtC14NxZx8o+3thUHEEobWqO4VSZO24MG8
 3fPNf58JMFTUD9sJzP5BFXZOwdsAPBHa/GGP169oESxdIRdGTL3r6EifMHYhbdBa+0frdBsfHv8
 Vb1AhC7UMpxFwDtJG3qYFDyKnRNUDOqIlvNjTArqdJkbFbBBUhBE60rRJEZMi5BBdeIYuvdiDwP
 qot9xeJ6Zlu1WmTBnabwt1jpgmQFvqZAfjhcg19OF6qZUQuLwIY5fGxfHwmi9mCLSaLTgZ9FrgM
 285jemoQFWikBHV+Cyzz6z1USMlAxZiyhJ+ipR1fbwTe+q4J09CCBSnNHOk7TT5Noue/QVc2N+j
 tYafN2LcXiyaZDLSIOnA==
X-Received: by 2002:a05:6830:67fb:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7dc27e14161mr4673484a34.21.1775957715288; 
 Sat, 11 Apr 2026 18:35:15 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:35:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/12] test: Add argument-type definitions
Date: Sat, 11 Apr 2026 19:34:32 -0600
Message-ID: <20260412013451.2929001-5-sjg@chromium.org>
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

Add types for declaring and storing unit test arguments:
- enum ut_arg_type: INT, BOOL, STR types
- enum ut_arg_flags: OPTIONAL flag for non-required args
- struct ut_arg_def: declares expected args with defaults
- struct ut_arg: holds parsed argument values

This prepares for passing key=value arguments to tests via the 'ut'
command instead of needing to use environment variables.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

