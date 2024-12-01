Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEFED49773
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42AB89152;
	Sun,  1 Dec 2024 15:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9F3uOTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3996489376; Sun,  1 Dec 2024 15:43:14 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74ED68912B
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8418a2f596fso105196039f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064187; x=1733668987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ej26JDHd7ZakS7MkC09lF6neLi9OxX3BZ/re/W9W0ks=;
 b=H9F3uOTSZXFb1JnYbx1VgnwlRCwI3fWW2ptZsj8Fm5JcU2Vsw5wb6by+xV84XX6ZgL
 dMw6eGbig59s+4ALIGa52ocr6jXV3fosQqX8f88Grv5BWamNTtR3MHnJmwfc8Osy3Q3v
 BXm6xXldGUZ+tEYJWZRKNhr0xvvAtLoshFu5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064187; x=1733668987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ej26JDHd7ZakS7MkC09lF6neLi9OxX3BZ/re/W9W0ks=;
 b=xUgF25xmE5V7g7wkCNJmyuAQyDed0nbsTSdSDe71jYcELpAjET6VmfulVgwFgjMrpQ
 t82tepjNwmpa0YdnN8qOqNyENVG5WNKpKO0CKEycdOLxJ5QrmIbjUsH5Irj7bXlTGHlI
 HFtGGv6fL+6vEKj3WaivotWv5oc3i/1pz0NeSCzmHMVJCVf7uEQmg0gdRL6jtQ9Ls/3b
 lZbm+1+NTs3IKh9wZ0Tyf6x2vY+1rjRJWG+CdU4JXBskQqiqGEbwj5slessmaLJ11w3Y
 fLWoEqYRWBWPERXLnqAk5IACcsbhdyGSBHzCsJVAFEilr0MNT0r4QD6Vly9t/Yiuwe3O
 r3Iw==
X-Gm-Message-State: AOJu0YyUmetfsiRIQoCLajs8I8CVucJNdrt80jBBI1P1JWxibdHH/uwQ
 5uGyWeggCnV8r5ywwav9l6qiqPrJ6MkBGOFAw1HwrX2kXUfUApIeS9mSC/dKzCYikFHUD016B28
 =
X-Gm-Gg: ASbGncuW4JPasXDs61mkNx5BKvcxNf7C9VdfPyEGGVIKSLArgtdyUe07mLCFAvqaGV+
 0eXS9I5NcttFCNo198W8bYIslnrSZ18/u63lWjQoNXKzuYC1QtQsAu2P0qK45UDOGr/5KgXkPVo
 OUGGx5A+y9ApO/sN3XaiCffzrr21P0NAg/omsrxL9eXGTjFX3wEr1amJ1FU1FCwF0ptm5gu5jGz
 S2j4T1x9ALCnJZeuB4gehlIHUy8JGKwxIHzh0B/QNrJ
X-Google-Smtp-Source: AGHT+IFBQYdDT8n6IjOMPOB26bavUZkqe92O95KAJLPkNvr6024cszpUzFqF2U2UrcYM9TXog42JPw==
X-Received: by 2002:a05:6602:140f:b0:841:a80a:f536 with SMTP id
 ca18e2360f4ac-843ed0253e2mr2151169139f.14.1733064186990; 
 Sun, 01 Dec 2024 06:43:06 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:43:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 6/8] binman: Avoid skipping binman_init()
Date: Sun,  1 Dec 2024 07:42:34 -0700
Message-ID: <20241201144240.1664398-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

A recent lwip change stopped binman's init from working, so it is not
possible to read nodes from the image description anymore.

Correct this by dropping the offending line.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 4d4d7838127 net: lwip: add TFTP support and tftpboot command
---

 lib/binman.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/binman.c b/lib/binman.c
index 93d85548116..9047f5275f3 100644
--- a/lib/binman.c
+++ b/lib/binman.c
@@ -137,7 +137,6 @@ int binman_init(void)
 {
 	int ret;
 
-	return 0;
 	binman = malloc(sizeof(struct binman_info));
 	if (!binman)
 		return log_msg_ret("space for binman", -ENOMEM);
-- 
2.43.0

