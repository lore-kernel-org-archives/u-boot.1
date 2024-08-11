Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CBC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250DB88C19;
	Sun, 11 Aug 2024 16:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BUYpYmnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5887F88A7E; Sun, 11 Aug 2024 16:52:54 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E40E889CB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39641271f2aso11320875ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387971; x=1723992771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnoJRYiA0jpgdtUTiaY1SSzDLCyCKyPzj2aCRxRQE1s=;
 b=BUYpYmnkmzARRk1PQEfWK+OSGq1Q+uoA0Qug409WlX78G9x4ydEnSPaE7Q8V8rrnmE
 eAqXVY/7HH1aWuyEK8EjSfA5K2hrAgr2UHrzw1oGlZoDijp3UgthwLpmf54N6rO5SjIi
 tm9KphPgdMar1wr/rXf134n2aT0H0sFdNBao8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387971; x=1723992771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnoJRYiA0jpgdtUTiaY1SSzDLCyCKyPzj2aCRxRQE1s=;
 b=pAarO2cmIYokBKmdNYDxT1FgumP6THlVZd0bDbZUakJ2tiLtIxOM78iu5apNOcppGN
 3TV82L/coAmnSCuE2FTxVKIA4wg70VNNYkuw5Fxr/5Nt7NLyxmHMA5iVZFfOSWwxRXzr
 csoXEsRzb8QdfwmXtTFMNVztM1geXZCxIuHyQ0RLfMiTBygdCfQn4mprXXT5s9hL/lak
 gWwlwz5eg0SCHHU0Vb1onWibG0MGo9CO+mGSqD2jvqSt09urzNHP1RB1rpN8BdyrnLCZ
 yLZdKQZ9+aDILfT8lMwMFPDityaff10qef0uZ+1wZzEE/FnG5aYS8ttHOlsTZgfCWTs1
 rtxg==
X-Gm-Message-State: AOJu0Yzs+ogHa8susM5RbOtLgMBZKioDDqIYFsDfgkCpMT8+RI7VqY4V
 GntU7GthFICD105vPiGflGu3KRjEBeETX/REPgfTtA3idS8sh8jnbvdCytjCytoc6AFHmU+JnY8
 =
X-Google-Smtp-Source: AGHT+IEhkqUpPlhpCrdojzsdbM7ZrI9/f/dA/cAlcD2u0d3MjO3aIYjVAkEB8Su0+7phKo5c/88weQ==
X-Received: by 2002:a05:6e02:b43:b0:376:1cf6:6be4 with SMTP id
 e9e14a558f8ab-39b7a41702fmr78378385ab.14.1723387970934; 
 Sun, 11 Aug 2024 07:52:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 26/40] efi_loader: Put back copyright message
Date: Sun, 11 Aug 2024 08:51:55 -0600
Message-Id: <20240811145209.4191404-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

This was lost in a later commit, so add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: dd860b90ff4 ("efi_loader: print boot device and file path in")
---

(no changes since v1)

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index bd72822c0b7..586177de0c8 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -2,6 +2,9 @@
 /*
  * Hello world EFI application
  *
+ * Copyright (c) 2016 Google, Inc
+ * Written by Simon Glass <sjg@chromium.org>
+ *
  * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  *
  * This test program is used to test the invocation of an EFI application.
-- 
2.34.1

