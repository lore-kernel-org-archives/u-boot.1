Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94222C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 06:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C649888405;
	Tue,  9 Jul 2024 08:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jYtr74vO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A608884D0; Tue,  9 Jul 2024 08:28:22 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F02D88405
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 08:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so11920251fa.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720506500; x=1721111300;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=foWmJWDioSf02GceU1FIQIyZLcR6DFpqNRRaCaq36Ls=;
 b=jYtr74vOSNoVYiPdRJpMKTNRwCgCLlPS8fg5MF0JQMu9lTr35YQeK1tU6XXQgqTBC/
 KSau93T1qhh4zKvfFQy0zrBDwD5vX8bo5xnxRNSFhMAzA04Mp8VbKuSK/0alobOZOL3U
 1n7DFEfxtCerXkfgRi1+bdFEgYHl/sOXFoUgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720506500; x=1721111300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=foWmJWDioSf02GceU1FIQIyZLcR6DFpqNRRaCaq36Ls=;
 b=ikC5pgnIHvmTF4Y/SFuh1xLQHgh4nkw+MUAJllk8OY3VNuKRVTmueVLL9nQyDxXI7z
 HCHg/IctUbTvLnjQOUtkh/DZe2cfTP+YIXI5/Ju1+z06KbhlrM0teBXp/ic2XKp7O3+v
 YdfpFrthlIq8oHeFhpAezdq2VqESqM2Mj0LQJlbGgQ1anHiiqvmFUrEHx9JlSBCeyrgT
 mRFlRD087dZe2uR4K+H5mwek8rc/GIz+tx1j7dYtkPaRkgSJkeLdz1qUNvpK5e5RATjI
 39XTvLCyFcQvtUO3gqOWXwDMttdikpDPLUahkNdqY37x3Vm/kv1BXYFIDCjxFctMm2Sv
 jWzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWpFWoHywgaonWHTnlnmAmbBE5JrAFk4lJM8wJhsoruc+i6LLk1JpMeXXo1FuvtKg4aghoKVG8M0e+4z5TuB6NpvrCqQ==
X-Gm-Message-State: AOJu0Yx9914ZA9nG8JFVfphulrksbQRQhxYiM3qYIp5fklhqWrq/E2UD
 h7hHnMgGNbZEX98R98S2T67LbTprmiLG40s0o+7A+bQEITobvwSbff3+ialc/TU=
X-Google-Smtp-Source: AGHT+IEu4vduTeM/QJnahJHTSlqmg5ifx/XTNiVDpau4yReixbw9iKfCnuvw1K6oZm/8XH/WavjL7g==
X-Received: by 2002:a2e:b6d4:0:b0:2ee:8d07:3d64 with SMTP id
 38308e7fff4ca-2eeb318aab5mr9775161fa.41.1720506499635; 
 Mon, 08 Jul 2024 23:28:19 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 (93-35-128-17.ip55.fastwebnet.it. [93.35.128.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bbe2cf6bsm683547a12.34.2024.07.08.23.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 23:28:19 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] clk: clk-uclass: Print clk name in clk_enable/clk_disable
Date: Tue,  9 Jul 2024 08:28:13 +0200
Message-ID: <20240709062813.112698-1-michael@amarulasolutions.com>
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

Print clk name in clk_enable and clk_disable. Make sense to know
what clock get disabled/enabled before a system crash or system
hang.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/clk-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index d768e5ad2e..76f1026164 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -630,7 +630,7 @@ int clk_enable(struct clk *clk)
 	struct clk *clkp = NULL;
 	int ret;
 
-	debug("%s(clk=%p)\n", __func__, clk);
+	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);
@@ -691,7 +691,7 @@ int clk_disable(struct clk *clk)
 	struct clk *clkp = NULL;
 	int ret;
 
-	debug("%s(clk=%p)\n", __func__, clk);
+	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);
-- 
2.43.0

