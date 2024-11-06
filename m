Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C46D44D6A
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD42891DB;
	Wed,  6 Nov 2024 14:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XN7N6lNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EDA891E1; Wed,  6 Nov 2024 14:50:24 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C688C88CA2
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so4880885f8f.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730901021; x=1731505821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yQAlxpqFXMQfYqaWc2PEU4mNzSNgCkFT2yB0Qsyvzxk=;
 b=XN7N6lNtbZCOCAV3l3Bcgp6dFtfFC9jfHduLB9vkJgOjBYP+mv79Sqazr7OGz+I9uE
 IRKPYzlbHJr2DzczaP/r/z/Zi9Vk63aEez1QlJn9So7fBMT9gECf2EXTf6x5Ayocxecz
 Pu/rWxUwQBBBgN/RstGyxRe9r5+2k3+FL/EooiI4BMDb8/3HI6vSiDOdQ24ArOkK3O47
 Wm0ba48sZX+X+LmjxNmZqrBmz8jdi+WStpGf+5gfcqru5j6oN/2e/pMYRe3PxfEHP7fl
 heCI3j2PA6jlP5MrSIWqpNadroXibxIjyWltlTghr0WWcmwdE0oMyOcw459iYspFFqlx
 6aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901021; x=1731505821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQAlxpqFXMQfYqaWc2PEU4mNzSNgCkFT2yB0Qsyvzxk=;
 b=Xwp677B797gOQIYNKa5/92n7uzJwzWkDlt+4pYZVgesaWWO+EWH6RhhartEEu1I7p1
 2fPSu2OMa6vUEfFHS0I/cdvdQgI7DKhBUGe8Z6AdWjQL20swz2fGwf71diQUyd6mrmWk
 2M1dvOCBpS4yC6RXau/o2TPV8xwpKPLLUlO3LGDHm5NQ/6BHoBban0wztg0N+VPThFkn
 Te9aP90H7XqBBdd3OExgFaLmPrvhNdybbWfk/W32XQ23FKzcOy8TJqCiyfmMNU6m9ImD
 OFe2Te6rxZgSclmxijVz1RKTTIVRiIJN6ZlstcOVyBl8GI3OvKFq9LwiIKpjXkC9iFjq
 tkPQ==
X-Gm-Message-State: AOJu0YwHw8Eof18EgDXlhcnXDDZYGfKoXw7wfQLAPH0c0ZLH5bc2IVOt
 T024R/rzrUGx1S4m1Jur5abUcQmvcNGUOuSYg01W1KjfOd0EtJhtk35IHjtG8qJaqMd6X0TlD75
 H4RKc+Q==
X-Google-Smtp-Source: AGHT+IGskVI4gcom9t8eUYqMB3Z/9rLGk0V/2YD/eyXZSIOIYmtFsD1uN+DbgFoXsGppzgstBYhFiA==
X-Received: by 2002:a5d:514c:0:b0:37e:d92f:c14a with SMTP id
 ffacd0b85a97d-380611e4a96mr28082078f8f.42.1730901021244; 
 Wed, 06 Nov 2024 05:50:21 -0800 (PST)
Received: from artemis2.elfringham.co.uk ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b8csm19407232f8f.5.2024.11.06.05.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:50:20 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: bootm: Ensure tests can be run twice
Date: Wed,  6 Nov 2024 13:50:17 +0000
Message-Id: <20241106135017.696551-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Some of the bootm tests rely on state that is assumed to be
correct but is changed by the tests. This means that running
'ut bootm' twice will result in failures on the second run
as the state left by the first run is not what the tests
expect.
Fix this by ensuring the state is as expected by explicitly
setting that state.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/bootm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/bootm.c b/test/bootm.c
index 52b83f149c..9455f44884 100644
--- a/test/bootm.c
+++ b/test/bootm.c
@@ -28,6 +28,7 @@ static int bootm_test_nop(struct unit_test_state *uts)
 
 	/* This tests relies on GD_FLG_SILENT not being set */
 	gd->flags &= ~GD_FLG_SILENT;
+	env_set("silent_linux", NULL);
 
 	*buf = '\0';
 	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
@@ -183,6 +184,7 @@ static int bootm_test_subst(struct unit_test_state *uts)
 	ut_asserteq(0, bootm_process_cmdline(buf, 22, BOOTM_CL_SUBST));
 
 	/* Check multiple substitutions */
+	ut_assertok(env_set("bvar", NULL));
 	ut_assertok(env_set("var", "abc"));
 	strcpy(buf, "some${var}thing${bvar}else");
 	ut_asserteq(0, bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_SUBST));
@@ -201,6 +203,7 @@ BOOTM_TEST(bootm_test_subst, 0);
 /* Test silent processing in the bootargs variable */
 static int bootm_test_silent_var(struct unit_test_state *uts)
 {
+	ut_assertok(env_set("var", NULL));
 	env_set("bootargs", NULL);
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_SUBST));
 	ut_assertnull(env_get("bootargs"));
-- 
2.39.5

