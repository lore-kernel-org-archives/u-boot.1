Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ABEC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E8D82E27;
	Wed, 16 Apr 2025 15:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BfeOAFJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CA580944; Wed, 16 Apr 2025 15:58:04 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF7F81B4B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so70339895e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744811882; x=1745416682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExNEXryQ1la6CTBw1MiWKMnNLYwRBZKJzUgABvRPBQM=;
 b=BfeOAFJi4YXWNtPZukQCTquPXyRJzSMyFuR4xrehGJzFdn4RMPiVAglXCsKUNGxWba
 YZTLxwBiteeDMvkRyyDeQaK+LEkl2wk3tYfP9D4JHTesrLgHRneSJ+Ji9UJSuWw5YhGH
 NRzv2wnhc8AzO1fgZ1bkQIivAo/N0K9ynFn7pVtJgz3zPvnFjihMKF1N+Xt05hWW+7IJ
 3bukcUutYso1FMVZ7OF2+Swz6+M0+8UpvMASo7j06Gonp4aMJuC7qOpA7I9l/+2+1lii
 tNliiF47f+/WZGxir3+Q6ixsDxZYxq6NdVmcVAa6KsUZX4NvxGkJPn1vf9b1gSjgXJzj
 HkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811882; x=1745416682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExNEXryQ1la6CTBw1MiWKMnNLYwRBZKJzUgABvRPBQM=;
 b=RaPQDZ0xXouNzhKrKW+1OAOsDgjXKddAmxA3DlYFyABmhpiqYJaHsGBkDI9CafMPRr
 mH2h5n+H1symUplFQ/dUFE3BraQCRgEIXtDXtwdgNF6wTUMxGBh4pe+PRw0wxhS5nYqR
 Ym6J4W5A5UU4B9MCwORdau63QOUTo7bgdXVEht1LCHG+CytBTWv7P/43r7ksG8fdWfW0
 c/6QKBb8wVk933MmSFVFvthz7vgtNKzkypYCwx9XKmnLIuAeUoBZOGqhtt/xI9MdBVKt
 ZhKYhInoMx/r3gt7NEjuagQpZVr3MUeIxV2i8R4ZWyUT+PNUlIGALA2ywXOu8VT1fE1O
 kHUQ==
X-Gm-Message-State: AOJu0Yy9Spl0vXd1fH7P4Zwrq50rGnXOoJOvmVMzmYEPvIH+8tb3dIh1
 RiJOnpIzMotjCisS1LeVLVEjkJ+4CcmEBcNgFaS2N7FDEp0QK5KuvWgpKKMhRPcZdkOQprhBVkF
 q65I=
X-Gm-Gg: ASbGncscviH+JXZ38IYnhrUzeIietzsyESjdpLr8jYBM8tQwR2p956RhuOgwRztmt6f
 y2HsBKVwY3ZBJxVTmlg8lr7Qak68QLxghOk89HNzCWlvLHf5do08Oh7kh6U/ZB7vSPqbqbjoLSy
 jK401SVwUTpmggDHYCofWs1+n+laUPl8DVY4cx7YwIk19irgmzOdzGd904Utngh545EZXYc4NLZ
 AV5+zls9HCRZm8qWbeC9UR516iT2z4aGaznNGI1pUww5MxYPS2TMN80Qk3pN22q1H1wH36LVCY4
 W9yMmKZEVRkeAxoigdvCWez9v2x5VEnaGxVrb/41odUmAHsq
X-Google-Smtp-Source: AGHT+IGiY5Wmi3Uh582I4bsuxYT+IZ4pHIIqysAhiUlQNll7c1PtFR7X2GRKhcw7RLQ2h/ki/VFz7g==
X-Received: by 2002:a05:600c:450d:b0:43d:ac5:11e8 with SMTP id
 5b1f17b1804b1-4405d6aadbcmr13660575e9.21.1744811881700; 
 Wed, 16 Apr 2025 06:58:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7ba5:2291:675f:52e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5437c7sm22013765e9.39.2025.04.16.06.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 06:58:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] test: run some test commands only if HUSH_PARSER is
 enabled
Date: Wed, 16 Apr 2025 15:57:30 +0200
Message-ID: <20250416135744.1995084-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135744.1995084-1-jerome.forissier@linaro.org>
References: <20250416135744.1995084-1-jerome.forissier@linaro.org>
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

Some test commands (such as "false", or the empty string) need
CONFIG_HUSH_PARSER=y. Fix test/cmd/command.c.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 test/cmd/command.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/test/cmd/command.c b/test/cmd/command.c
index 5ec93d490ba..5b1e5a77e5d 100644
--- a/test/cmd/command.c
+++ b/test/cmd/command.c
@@ -45,31 +45,32 @@ static int command_test(struct unit_test_state *uts)
 		"setenv list ${list}3", strlen("setenv list 1"), 0);
 	ut_assert(!strcmp("1", env_get("list")));
 
-	ut_asserteq(1, run_command("false", 0));
 	ut_assertok(run_command("echo", 0));
-	ut_asserteq(1, run_command_list("false", -1, 0));
 	ut_assertok(run_command_list("echo", -1, 0));
 
-#ifdef CONFIG_HUSH_PARSER
-	run_command("setenv foo 'setenv black 1\nsetenv adder 2'", 0);
-	run_command("run foo", 0);
-	ut_assertnonnull(env_get("black"));
-	ut_asserteq(0, strcmp("1", env_get("black")));
-	ut_assertnonnull(env_get("adder"));
-	ut_asserteq(0, strcmp("2", env_get("adder")));
-#endif
-
-	ut_assertok(run_command("", 0));
-	ut_assertok(run_command(" ", 0));
+	if (IS_ENABLED(CONFIG_HUSH_PARSER)) {
+		ut_asserteq(1, run_command("false", 0));
+		ut_asserteq(1, run_command_list("false", -1, 0));
+		run_command("setenv foo 'setenv black 1\nsetenv adder 2'", 0);
+		run_command("run foo", 0);
+		ut_assertnonnull(env_get("black"));
+		ut_asserteq(0, strcmp("1", env_get("black")));
+		ut_assertnonnull(env_get("adder"));
+		ut_asserteq(0, strcmp("2", env_get("adder")));
+		ut_assertok(run_command("", 0));
+		ut_assertok(run_command(" ", 0));
+	}
 
 	ut_asserteq(1, run_command("'", 0));
 
 	/* Variadic function test-cases */
+	if (IS_ENABLED(CONFIG_HUSH_PARSER)) {
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wformat-zero-length"
-	ut_assertok(run_commandf(""));
+		ut_assertok(run_commandf(""));
 #pragma GCC diagnostic pop
-	ut_assertok(run_commandf(" "));
+		ut_assertok(run_commandf(" "));
+	}
 	ut_asserteq(1, run_commandf("'"));
 
 	ut_assertok(run_commandf("env %s %s", "delete -f", "list"));
-- 
2.43.0

