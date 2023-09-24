Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A14ACE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2802869CD;
	Sun, 24 Sep 2023 22:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="feVN2gam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54CB86B34; Sun, 24 Sep 2023 22:40:29 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E4686B16
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34fe6722847so17530225ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588025; x=1696192825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSyGLH5JurDxDueimryfrOIw1OEOpfRVdV8UhvQQUiw=;
 b=feVN2gamNmnDOK5cVTkymMHk9tip2h0vkj2hI2GKl2a/lqV8ruejaMbczcm6Y3ePf/
 AjQk0WilZroDaOx3EP5NIQMgBa2Q+6QV7nBF6g4ds799n1Wj4N+8gNQ/AaCIgZkqOxz4
 hoj76dd+nrzzzV++k8MSmfUpfKNNrsKa4dKro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588025; x=1696192825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSyGLH5JurDxDueimryfrOIw1OEOpfRVdV8UhvQQUiw=;
 b=I/CT4P/BOlEcR+23K6+6H5TRDG7v0WuCNfkPG+h53olk59dF+bPXrqVupdv/f5+Qid
 X0LozUsoib0VDyz0ZiHMfxzdTn/YpOqzjv+ecN+LiN1e+TSir5hiqP0JlBvprOgb92wB
 eWmWne6lH2O9hLlpwB5WKU+iPltAQ6TTd3uBLcQ1Rsmm9ATUcmFTLRsyVPHId4OeZQjh
 /nJz7shGPOa2Iln9xUG77yz9qWomHWZjEtuF/VRG2cXMYvzAhiuFohXQGYV5A6FTMWrw
 blq4aCEjXcJfFklwwYCRFtY34nWbq5Az+xHaZQZqLGjwj9M/gfx6i5OJ91KxGrkdyCcf
 xp4Q==
X-Gm-Message-State: AOJu0YwyUtmNaU+sKrtCv2UB9wNSFTzKriI8vFuRjUJKb7H/rDe/BqMi
 GWVnw0JjpHwg+sc9iGFmhGUAYq9uh0jtCVmtwgs=
X-Google-Smtp-Source: AGHT+IFepumUN7Y3szlOf0Wr3Q9vaXTJKCyhycGjSV2U1DTtWALYFoBudLf05nDrMuhGTUqP/uVQbA==
X-Received: by 2002:a92:cd88:0:b0:350:f0e6:a7c5 with SMTP id
 r8-20020a92cd88000000b00350f0e6a7c5mr7257687ilb.16.1695588025737; 
 Sun, 24 Sep 2023 13:40:25 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 06/25] test: Make UNIT_TEST depend on CMDLINE
Date: Sun, 24 Sep 2023 14:39:24 -0600
Message-ID: <20230924203953.1829820-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

Many tests make some use of the command line, so require it for all test
code.

This could be teased apart, perhaps with a test flag indicating that ut
uses the command line. Leave that for later.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index 830245b6f9a9..2b4036704f91 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -2,6 +2,7 @@ menu "Testing"
 
 config UNIT_TEST
 	bool "Unit tests"
+	depends on CMDLINE
 	help
 	  Select this to compile in unit tests for various parts of
 	  U-Boot. Test suites will be subcommands of the "ut" command.
-- 
2.42.0.515.g380fc7ccd1-goog

