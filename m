Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D79FCA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 23:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94D283322;
	Sat, 13 Sep 2025 01:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lkVIDQ2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B571283429; Sat, 13 Sep 2025 01:02:57 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943A8830A0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 01:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-746d7c469a8so2196854a34.3
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 16:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757718174; x=1758322974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JavC2Yzm37v86vM7yHwpfkOFlQWqgvREX4+4jPGNdbI=;
 b=lkVIDQ2NedW9xFoffGJtD9wWx4Xz/c4gJOqOZF2iHYnl7KmyxLlTtARAbAywO8UF95
 nCOE89TFI40R0PDnqrCJBC0+hOGDd1sM18isA+qVFxo0kTf/wiPidcXz0K4fAGy0E+6A
 s2mGVN+Ce5eQ7CTg4Id7coK/xgbJMqKw7Xqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757718174; x=1758322974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JavC2Yzm37v86vM7yHwpfkOFlQWqgvREX4+4jPGNdbI=;
 b=Od0huRj2HIC0LbPa9aMeJdDBDK1UUX/uk9gSTry5Yfen08Ejmwx/uGKWPvqiF9jQs4
 BtQbs8j8/Ir07kmT2HAnstQMRXmqUr20DvK/abNHzK0gmMKKkxVjaf0LpnvCkWZ5ho8d
 XuDbl77yHqK+xzktLRtansBHQTY4LlixNmCdW20UxqSG89/XqugmogVVjiYu4aor70mG
 J/ha0tVwHUe0LATvFGBaVvGu4KrWuVWDxlt3WQ9Tlya+1vk9JxFxjAzsM0sxQQQl3HZG
 D2PpA2n6a1CY9mwEARSLyYiijmoosxzJkZ2MJrT9/jRyiyaB5ehFM0OXhqViWU6gtvUF
 b8cQ==
X-Gm-Message-State: AOJu0YwV8mZphFmyvFpC53eg0F5MjbTzpLZs/XzoVFxZmUdeOyblTjbv
 XxzA6JJsuyuvmV71MpCNx7eULC5Nw0evmYM25RQMMjmrdF69Nds1CmzCJb2CQm5VNoEtI+wbp+H
 +25Dg2Ro=
X-Gm-Gg: ASbGncuEE9EM0coSoXp/bJM/SY+QNieVhAC8p+RAldPbKrgO4X+2mrdVKtNrfn60PtT
 7N2sUGrktFbOC1YJHpeVLd6nJcyvJYB6GT58NC4goEmxV2v3QQlIgCC06KnKt/a0RZs6zcipudo
 oiwcsd4nBZf7gt4KqLwyr38SOcjPJ8ynEN5plohzltRMOLCKn1GWpiXxlvguharL/vi/wKXezMG
 3S7vc0E23maZOUhXSfCliRWJEPx1u6V4XkPl2pva6UxQhyaN5uVCh3frRDp67yG7bCkAXOwm3IK
 OJeHub4clsnFZmngxYA1N0M0qzTg9kumlcwMD/OfxZIQzs6b94wjFEqEWwWHMey+TSU7bTRVwMb
 I7gV3S0cVW7x4gVfVLbfxD7Gbxlmeuf5L50kMTASmjBkVVRihpXSfZV5V8BQ=
X-Google-Smtp-Source: AGHT+IFMJn9rliERzk/z+PptM945pUxGTZdRi1Qy5wQKSAZJGsmhjJdXuTfvp6CdPdhW9Qq1ugVxjg==
X-Received: by 2002:a05:6830:411c:b0:746:d995:4e56 with SMTP id
 46e09a7af769-75353379d0fmr2744803a34.11.1757718174328; 
 Fri, 12 Sep 2025 16:02:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524be7ad7fsm1278649a34.37.2025.09.12.16.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 16:02:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Remove README.commands.itest
Date: Fri, 12 Sep 2025 17:02:52 -0600
Message-ID: <20250912230252.4144988-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We currently document this command in doc/usage/cmd/itest.rst and this
documentation is more comprehensive than the older README file. Delete
the older file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/README.commands.itest | 16 ----------------
 1 file changed, 16 deletions(-)
 delete mode 100644 doc/README.commands.itest

diff --git a/doc/README.commands.itest b/doc/README.commands.itest
deleted file mode 100644
index 5e0fe86247a8..000000000000
--- a/doc/README.commands.itest
+++ /dev/null
@@ -1,16 +0,0 @@
-A slow day today so here is a revised itest command with provisional
-support for comparing strings as well :-))
-
-Now table driven to allow the operators
--eq, -ne, -lt, -gt, -le, -ge, ==, !=, <>, <, >, <=, >=
-
-Uses the expected command modifier for integer compares of width 1, 2 or
-4 bytes of .b, .w, .l and the new modifer of .s for a string compare.
-String comparison is over the length of the shorter, this hopefully
-avoids missing terminators when using an indirect pointer.
-
-eg.
-if itest.l *40000 == 12345678 then; ....
-if itest.w *40000 != 1234 then; ....
-if itest.b *40000 >= 12 then; ....
-if itest.s *40000 -eq hello then; ....
-- 
2.43.0

