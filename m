Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF480D0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F09689315;
	Mon, 21 Oct 2024 10:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NNoyxGBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3336E892E1; Mon, 21 Oct 2024 10:19:48 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E63289315
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so531452266b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498785; x=1730103585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dmQ7JL8bQzPcKkobPLhTQMm4sylKaVBBFpwXBmSF3M=;
 b=NNoyxGBmYlOQEzED3FC8Xp3aOM4sTpMA/hlGL4ikOP6KrmPe+sBJTAW0CSZZmWiUzo
 53qFLzg2QcW5ojfEHMXBuqs8VhbFv0dL66OYKjoNP+mGCabviset5wzTacE7JeiakJG4
 nAS4Vdf7Xy4tm9/97W791Gdrx/7WS8J1fCKCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498785; x=1730103585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dmQ7JL8bQzPcKkobPLhTQMm4sylKaVBBFpwXBmSF3M=;
 b=DVy961sckxPCAE61WDzonRWJDHa6CXM1A9xBlsxVWXlLkxPn3peuOxw/ekZYBCC52m
 ka9SttNF7Y7c/9p4bdYqpmEHl8NHwiUCt4bnrsXi/T1VUiCLhCFGesQnwXUGWdFpuEFL
 eYHPwJfnwnFcrdej5bqiReSZXS6cnsSTcgcwK5bOVU3fhnoBuQlroyPMWdb8YUhgVAHc
 2RNc4I35kjMz5ik+HazTqlxrj4tNaxNB9WzmRJi1i9SVW0NEFU1LBwmDI8U6aP8d3nz2
 FYjCG/huJMB1z1BXHFSv7y1gVMF5WaVbPP2MC9Clsupvf+P8A62AJhjiAtbwZyAl34FX
 3fVQ==
X-Gm-Message-State: AOJu0YyS2WwuPuTZtHo2hUY/ycVvdipZ32/3WXqqFQZlmegHuFh6cljN
 TP6WNplklWiCG9FU8HXhddiwy9wn6sCY+dpnAFz0epuOtP4W9uVEOTi9+qeTOV4SZRLtCs9tNvf
 tWV8p
X-Google-Smtp-Source: AGHT+IFAIAUT3zK4q8jAR+n5LdkQjeHKp1D9yVh6CvAeUc4f7jkdgXTagl3+Lck05ebg+vIb1qNrbg==
X-Received: by 2002:a17:907:7f12:b0:a99:2ab0:d973 with SMTP id
 a640c23a62f3a-a9a69ca1f86mr946506166b.55.1729498785389; 
 Mon, 21 Oct 2024 01:19:45 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 7/8] lmb: Export the lmb data structure
Date: Mon, 21 Oct 2024 10:19:31 +0200
Message-ID: <20241021081934.289473-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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

Provide a way to access this data structure so that the meminfo command
can use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add patch to export the lmb data structure

 lib/lmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 7e90f178763..eec99c185ee 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -887,12 +887,12 @@ int lmb_init(void)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(UNIT_TEST)
 struct lmb *lmb_get(void)
 {
 	return &lmb;
 }
 
+#if CONFIG_IS_ENABLED(UNIT_TEST)
 int lmb_push(struct lmb *store)
 {
 	int ret;
-- 
2.43.0

