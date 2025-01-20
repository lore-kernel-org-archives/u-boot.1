Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A38C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E4D807E9;
	Mon, 20 Jan 2025 22:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iU3avSak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F5BA807C4; Mon, 20 Jan 2025 22:54:18 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD70807DD
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce7c4115e8so20449505ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410054; x=1738014854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLY23Yukzu+3SLH4J2bj+ljQxlKYJ1vVVrSWzZWIRYQ=;
 b=iU3avSak6tks0AHI/qawnwzX7ZjtxsUD2AiBT7oif7zgLi5c+4saOS+KWU2Mmt+nC5
 pRW0ugsGjLI6S+Fq2hPUbxl4ClhBCqywzQM9kRbntKI2WYx5zvniAVAZ7i1is/xyt1GM
 fVZXEu+WgJpswjInbq07VaJQy5aumd2XMsvVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410054; x=1738014854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLY23Yukzu+3SLH4J2bj+ljQxlKYJ1vVVrSWzZWIRYQ=;
 b=RRzRxOmW2oPU890mUNpZ5xpnwBPpj80l0tVY8UXlCvLRD087jhzVACIFScawe2YDtB
 9jk01Tx5fQ7zS9u/xE2Wkasx4oXw1Q8D1bqYkvt0SlgdBWkdrL6r7/jJdkruw/C5+skW
 59QFuhRhzrc68wPrdT8KfI91GPk6YcPmfjwSdoXtXNSG6foolqATGkT8KviSTsWBQWQc
 rJgonE3adXPWVXSbnmQtgaJRMgieFw0Be4OeXN3biN4EbeN5DC7rwsO9nHYLjBxHJN7g
 c+1+WxTh5D8FycftUFZ9Oqw6uw+3aWtEu1oc9dqd7BMx7lc2vSi68UmTz9rDQK5mYyAg
 nCBA==
X-Gm-Message-State: AOJu0YwzX/rTStmTFsgtM/Xp0JVQvVT4ZOySS/uzVazrjpyCsLfxYbih
 K6sAj0WHw/008NKAgGt6bAS4IPA/QY/qWZiwQf8+8GqGJiTcWQ8qgn7h0/b0QVP9LWgZvwjQEx4
 =
X-Gm-Gg: ASbGnctKL3kMVWA73RFGJxeiIK6Zs8tmazp5xrIKqmW+yL312OcvMYg5swFNFBhPeAW
 eJoovGrPirVBoKS1z0+4sXk25wjQ3uL/2OudfBg7lO+lpubuHj8ixREva4EQMMG0OL1bbihDCvG
 qBC2i8SS2WrGzZHboRhJwDqRE3VgIltf6uHvs3nCN65EWTQlYpBjaDELKLVUVlC6MdR/3oEmrW3
 IIO0qXKNEtkEWKXecNqonn1dzl2KMzQ8wqPfkyOmVGBWkcwdyXxxIGxqjXpTI9YUd28ZCpwnVxg
 MNAp/bOyHe6AV8uIcS8OU/t66Llmf/0=
X-Google-Smtp-Source: AGHT+IFXUz5lqneknUb/YjEHJKo4owBHLPbb70etyKGnQ4uh/8fV57U7TMoWSF0aoEXWg5fgGQ797w==
X-Received: by 2002:a05:6e02:16cb:b0:3ce:3657:7407 with SMTP id
 e9e14a558f8ab-3ce84a8d3c7mr168584515ab.11.1737410054157; 
 Mon, 20 Jan 2025 13:54:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/28] test: Update fdt_overlay to do init from tests
Date: Mon, 20 Jan 2025 14:53:14 -0700
Message-ID: <20250120215340.617194-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

Rather than having an init function and then running the tests, create a
test-init function to do it. This will allow us to get rid of the
command function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/fdt_overlay.h            | 4 ++++
 test/fdt_overlay/cmd_ut_fdt_overlay.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/test/fdt_overlay.h b/include/test/fdt_overlay.h
index 34e8020a496..251ad0ec97a 100644
--- a/include/test/fdt_overlay.h
+++ b/include/test/fdt_overlay.h
@@ -12,4 +12,8 @@
 /* Declare a new FDT-overlay test */
 #define FDT_OVERLAY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fdt_overlay)
 
+/* Declare init for FDT-overlay test */
+#define FDT_OVERLAY_TEST_INIT(_name, _flags)		\
+	UNIT_TEST_INIT(_name, _flags, fdt_overlay)
+
 #endif /* __TEST_OVERLAY_H__ */
diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index ac8a3b2be23..c716c6bd6b0 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -81,6 +81,7 @@ static int fdt_overlay_init(struct unit_test_state *uts)
 
 	return 0;
 }
+FDT_OVERLAY_TEST_INIT(fdt_overlay_init, 0);
 
 static int fdt_getprop_str(void *fdt, const char *path, const char *name,
 			   const char **out)
@@ -243,7 +244,6 @@ int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_overlay);
 	int ret = -ENOMEM;
 
-	ut_assertok(fdt_overlay_init(uts));
 	ret = cmd_ut_category(uts, "fdt_overlay", "fdt_overlay_test_", tests,
 			      n_ents, argc, argv);
 
-- 
2.43.0

