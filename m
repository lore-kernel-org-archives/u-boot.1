Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E68EC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 18:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E4A987CF2;
	Mon, 19 Feb 2024 19:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FGs9yH+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6975A87CF2; Mon, 19 Feb 2024 19:35:30 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D56E87971
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 19:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d22b8801b9so33895431fa.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708367724; x=1708972524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nilbIIbqniFtoADJBK2CchC96Kc2u9dJFq9yoI3Vx2k=;
 b=FGs9yH+FGkV9s04otX5Tlk35NyKodqvxTUJBkdpLt0xVCNNLayoOJEAODOM8lvpBHC
 VKjwEAT9YCMz0hopf1xwUhkTDy9Nbw1+wp5xgZtVyzfzZfZ+WQFmd7HgQb9CsjlHOrOL
 SiDZG6HViODW6gqUvoZuTssVTIjzoBynV4nWlpUYa72n4HLpaF99g+qiAIrB8I65BWBx
 FCKE7HSBoQpqdo/X4fqwjmvSY4CbMkwxsyG6y2Wg6lQnlXK+mEsLr4N+dfydVtNsqBHF
 AF1rBV/aoFFFvyQEZlJTebHmezvB+Y6n/hli2KEDFEJhY5dDZrcCpP7zcXLE5FO4s5rs
 d9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708367724; x=1708972524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nilbIIbqniFtoADJBK2CchC96Kc2u9dJFq9yoI3Vx2k=;
 b=HnTlKto7WWFrUQkBL2Yba55NQHdAy/kOnqRKL9s6Jzh0eBybiJgBEljA1h9NRGtotO
 cGzXz39L3w26lVNS/LT9R+2RLXNW1PDWNHcAqJOY2/u2rtN5+lPrscZd56oXR60H7diV
 /2ODkBPFldezQgaDwYLcrwRXn+iHrPasMtx9fkhKS38LCKaAS/gg3kUfrnGEij5J2Hn5
 eYeFMr9HrPl2Cn0mFR+0hMNL5dJQA7R6qvBteHTcWdYs/Pvz9SgMFQw2tozIv2ynX2cb
 mr7wRvB7rR4r6JS/E7veDSOLuo6u0TtZRY8Gn1xclcH0TpzTQFplAfexApMN2ntG/ZVv
 AYjA==
X-Gm-Message-State: AOJu0YwDGeQwn5bkmGhOEJnkih2z8M1LvMdAMouuUO7H1CZNdizu3wqe
 mOsKAr8X0jufDl5yB2+12UU2yJJ0sB6iQxiRBJMk9sWjPJx9XSi6u4Onv8z6q6Y=
X-Google-Smtp-Source: AGHT+IFGn4gQcwS1zDV7JpiZlglx2pVjqRCXxeZKSMKIo/O/OmolE16ipy13o3a7w5CTFdD+iwuUTw==
X-Received: by 2002:a05:651c:604:b0:2d2:4314:8c06 with SMTP id
 k4-20020a05651c060400b002d243148c06mr912138lje.15.1708367724157; 
 Mon, 19 Feb 2024 10:35:24 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c221400b0040fddaf9ff4sm12008887wml.40.2024.02.19.10.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 10:35:23 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] initcall: break loop immediately on failure
Date: Mon, 19 Feb 2024 18:35:03 +0000
Message-ID: <20240219183519.2183405-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
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

The current ordering always results in func pointing to the next
function in the init_sequence. e.g. if fdtdec_setup() fails, ret will
be set to the error code, then func will be updated to point to
initf_malloc(), only then is ret checked and the loop broken. The end
result of this is that the "initcall failed at ..." error will point you
to initf_malloc(), when the error actually occured in fdtdec_setup()!

This can be quite confusing and result in a lot of time wasted debugging
code that has nothing to do with the failure (ask me how I know :P).

Adjust the for loop to check ret immediately after the call and break
early so that func will correctly reference the failed function.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/initcall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/initcall.c b/lib/initcall.c
index ce317af213ab..128242e5ff55 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -52,11 +52,11 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 	ulong reloc_ofs = calc_reloc_ofs();
 	const init_fnc_t *ptr;
 	enum event_t type;
 	init_fnc_t func;
-	int ret = 0;
+	int ret;
 
-	for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
+	for (ptr = init_sequence; func = *ptr, func; ptr++) {
 		type = initcall_is_event(func);
 
 		if (type) {
 			if (!CONFIG_IS_ENABLED(EVENT))
@@ -70,8 +70,10 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 			debug("initcall: %p\n", (char *)func - reloc_ofs);
 		}
 
 		ret = type ? event_notify_null(type) : func();
+		if (ret)
+			break;
 	}
 
 	if (ret) {
 		if (CONFIG_IS_ENABLED(EVENT)) {
-- 
2.43.1

