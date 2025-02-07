Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F3C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A7680885;
	Fri,  7 Feb 2025 19:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KLZUBHVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B855801BE; Fri,  7 Feb 2025 19:31:47 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36BF8082A
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so74859939f.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953103; x=1739557903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rWZsmt8zzRQHE7tDF7SSP65U5RAuO/m8IgjifW/LFw=;
 b=KLZUBHVdipXMjnBR6ZeUpiDtTYC83Os/lN1BUcXC5x2dt00Z/EgYsQFzdbbI1o/C8i
 Bz4r1YAHhgOzjHpHvCJWYubhX/CjYkZbv2UuPAv6ygmVZSJwqQChupb4zZc7wbiWMKcW
 OmX0x5ZkaVWaatV0aTQIS2h6vrh78vIux+8E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953103; x=1739557903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rWZsmt8zzRQHE7tDF7SSP65U5RAuO/m8IgjifW/LFw=;
 b=mlw6cn3YXgUewoI6cc9DEaw05y5HJx8THG1evdBbynv0Rj/wpLKm7Z5hNY/A5kEqkc
 JgTTdWcQ7+hl9lJ6g0JOahbEYa4Dippby64ude83Ms49OS0T3yVr6Wy9Pke9DOwbA4II
 WCu/mKEcaNsoM+CXy4mFzQ1bF6maRbwXXDC/n4XgOnCh/0P0BtfasQQbEApnl/LNqkz/
 d5LEAiEGKCj/WM6JmMd2gfS7b2TNcM0eqrKOaHMXgQzwuF3SWb6+BTr/uVCP6C6r+plI
 QndB8cgIGVNnunUIfq2pAu2QSNXEF78lnW+u/jwvgmbp8Y36ha3hDNuZjR55fNU+zkkG
 5QQA==
X-Gm-Message-State: AOJu0YyuUF3euput7IUTfB0AqxDkl9RBJyRwXZNHRMO7M1JyNSaRscmO
 6JoZefelx7koicXyTbAyenoET/ctB1k5sKgbS/CdgkmL3Cyh9FESpue2X8mmpW3p+i4hF+HXOk8
 =
X-Gm-Gg: ASbGncs9v+VRDjcpNXSSE+dFkRIDV5MyBYB0M05jrmpYjVtepum79U9dd+e5UJRdhtJ
 WRgsClx5fnWAAReH4a0j84WoBIzF8NUM0Ub6hLLDkBy5zJ2C4kEnz0gk/OgpOIWZX8OUlzfDaDA
 ySp5be4GrWbnQq6X0kcoXVVUpI4vpCWmw3eat8wSg9cY8tfUpUfxQjZh3NbZiawouTLovtKAD/r
 6BVoZ5A/3oaSNepk/fsYQJNdOemJjqBXwEvgo9/2if5cmNFOSQcKYZui/y9y5NBrpz6UhD3Jy+C
 rf6+xi22fQazH8TtZiz9C/5rYuB+e0gRgNUPkU6DqFZ5Ps52kJaT
X-Google-Smtp-Source: AGHT+IG4ztGzl4/SMo8O/6HF15i2s1LoioaLMtArSORaxNYRKbADXTbZWAxjn91qLbnQavZN2+kQIQ==
X-Received: by 2002:a05:6602:4c0f:b0:84c:b404:f21f with SMTP id
 ca18e2360f4ac-854fd9055bdmr452403139f.13.1738953103067; 
 Fri, 07 Feb 2025 10:31:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/29] test: Support an init/uninit functions for test
 suites
Date: Fri,  7 Feb 2025 11:30:38 -0700
Message-ID: <20250207183121.117663-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Some suites need things to be set up before they can run. Add a way to
declare an init function using the UNIT_TEST_INIT() macro. The init
function is just like any other test, but is always placed first so that
it runs before all the other test functions in the suite.

Add an uninit function as well, to clean up after the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/test.h | 20 ++++++++++++++++++++
 test/test-main.c    |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/test/test.h b/include/test/test.h
index 877fda8d5aa..0f2b68a5dee 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -100,6 +100,8 @@ enum ut_flags {
 	UTF_ETH_BOOTDEV	= BIT(9),	/* enable Ethernet bootdevs */
 	UTF_SF_BOOTDEV	= BIT(10),	/* enable SPI flash bootdevs */
 	UFT_BLOBLIST	= BIT(11),	/* test changes gd->bloblist */
+	UTF_INIT	= BIT(12),	/* test inits a suite */
+	UTF_UNINIT	= BIT(13),	/* test uninits a suite */
 };
 
 /**
@@ -147,6 +149,24 @@ struct unit_test {
 		.func = _name,						\
 	}
 
+/* init function for unit-test suite (the 'A' makes it first) */
+#define UNIT_TEST_INIT(_name, _flags, _suite)				\
+	ll_entry_declare(struct unit_test, A ## _name, ut_ ## _suite) = {	\
+		.file = __FILE__,					\
+		.name = #_name,						\
+		.flags = (_flags) | UTF_INIT,				\
+		.func = _name,						\
+	}
+
+/* uninit function for unit-test suite (the 'aaa' makes it last) */
+#define UNIT_TEST_UNINIT(_name, _flags, _suite)				\
+	ll_entry_declare(struct unit_test, zzz ## _name, ut_ ## _suite) = { \
+		.file = __FILE__,					\
+		.name = #_name,						\
+		.flags = (_flags) | UTF_UNINIT,				\
+		.func = _name,						\
+	}
+
 /* Get the start of a list of unit tests for a particular suite */
 #define UNIT_TEST_SUITE_START(_suite) \
 	ll_entry_start(struct unit_test, ut_ ## _suite)
diff --git a/test/test-main.c b/test/test-main.c
index 8c0d820032c..ee855bfe2ed 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -620,7 +620,8 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		const char *test_name = test->name;
 		int ret, i, old_fail_count;
 
-		if (!test_matches(prefix, test_name, select_name))
+		if (!(test->flags & (UTF_INIT | UTF_UNINIT)) &&
+		    !test_matches(prefix, test_name, select_name))
 			continue;
 
 		if (test->flags & UTF_MANUAL) {
-- 
2.43.0

