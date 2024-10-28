Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D600D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBD8890C1;
	Mon, 28 Oct 2024 13:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eqdHYpUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD6A890CE; Mon, 28 Oct 2024 13:48:27 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3384890A8
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so708257066b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119705; x=1730724505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqa3sdySiIXEV4hvREQrv+d+PKy6T2Qi/UBNyJREjGQ=;
 b=eqdHYpUdwUMxoCmLIoNKYOsri1wunytpV7TL4OfAnjKyR9lfz8aVjd2v/5KzzSsoGA
 8xCULnrj5bwG8DizkkaVXSJOrJxY5Lh7dmbbvkKZVgLuJuQq1uXZfm+IZyvPw5Y/bZlG
 4iENx6z2Y7x2WHKrQ80OyY+1p9SmIx9JNUTJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119705; x=1730724505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqa3sdySiIXEV4hvREQrv+d+PKy6T2Qi/UBNyJREjGQ=;
 b=a4KDVSDremOEPdRghhMwn8QbeqjiJv+A6sqvaP+JeJNcgH+qgFpow5WsjtNtmWIAk1
 dXvcHSBltc4Z98Zw67wKRo8Y3QLKjSVdWZPhhmof7HfTk/+DIvjlR6O0EGbSkOqiXHKP
 VTgAiBObVFpucmQsHvX50q1lI1TkdJVXDsjGPelcTe7eUebzq3E3GVPSaRyDAU0xJqYE
 D1Yyaknbw+W89ciYO2bVgwsesPlsMgfo9WadI/Mq/gfGCRKag12wsyA0LFxw9XqhVE9x
 bX9jvvVnmyBy3RdXj22qTw3adZAJUJw+yb9jJjN2m/fiWrqFQiVFEgqyZ6RHoyzWmL8B
 GcMw==
X-Gm-Message-State: AOJu0YwaEekI/JlAEqzrsRh79wvK7LwUpJSLVx2kw8HZtNVgfOJgL4DP
 RAM6fTNe3k10090yULeElCF2fq+Q/BzTC7kkCFJ+NmLqPcn6Prm81DR7WWjtSmHgIXT04+Ys7Z9
 JTg==
X-Google-Smtp-Source: AGHT+IEMEkjlsOChGIpxO2uTcJw+dZtNeC3Uy4Azw9lnKAvBp7NBuTfljUK98wvZ0rC8My88wJfNkQ==
X-Received: by 2002:a17:907:9803:b0:a99:44d1:5bba with SMTP id
 a640c23a62f3a-a9de615aec6mr718078366b.45.1730119704762; 
 Mon, 28 Oct 2024 05:48:24 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 01/15] log: Add a new category for tests
Date: Mon, 28 Oct 2024 13:47:52 +0100
Message-ID: <20241028124815.47262-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

In some core test code, no existing categories make sense. Add a new one
for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/log.c  | 1 +
 include/log.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/common/log.c b/common/log.c
index b83a6618900..c9fe35230d6 100644
--- a/common/log.c
+++ b/common/log.c
@@ -32,6 +32,7 @@ static const char *const log_cat_name[] = {
 	"fs",
 	"expo",
 	"console",
+	"test",
 };
 
 _Static_assert(ARRAY_SIZE(log_cat_name) == LOGC_COUNT - LOGC_NONE,
diff --git a/include/log.h b/include/log.h
index bf81a27011f..4f6d6a2c2cf 100644
--- a/include/log.h
+++ b/include/log.h
@@ -106,6 +106,8 @@ enum log_category_t {
 	LOGC_EXPO,
 	/** @LOGC_CONSOLE: Related to the console and stdio */
 	LOGC_CONSOLE,
+	/** @LOGC_TEST: Related to testing */
+	LOGC_TEST,
 	/** @LOGC_COUNT: Number of log categories */
 	LOGC_COUNT,
 	/** @LOGC_END: Sentinel value for lists of log categories */
-- 
2.43.0

