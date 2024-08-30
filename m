Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8699CA100A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097FA88C9A;
	Fri, 30 Aug 2024 17:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGuiEQ1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D9488C90; Fri, 30 Aug 2024 17:57:44 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA4088C47
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-70f5a9bf18bso944849a34.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033461; x=1725638261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac3clolXtBWW4FL9/JYgaFFPoi0LZCznqT+B1+LGBPM=;
 b=MGuiEQ1tCHG+DLIUi4SpASLhdi5atKBRAU2ZVLLNnxz9HEXG0OqyOVpA2E4u0dfYdj
 4gW/r03JTtSZ4xWcHWCA091qZPPaaHnUra1kZAp9zxhXu4WAf2XMlOTsiXCeprTrsn25
 PFOFfYzBpSuPs8S1YtRsbPEl/f6CWD4ds+PQIq3C4ZAOjySJmiVfY7k9OzxiiYJGdY+o
 2SLNlgWQ8PxcwuxZIGXMWQ3nwloYgcRMa1zNuuLTox4P5LsnJPKFwE4pCaOupYhWGheW
 ZWL1SqkyTWzNbx/hlhJ5Y/jsGGq830SXGtc+TBBhULfJYcow4C2sycFjnUYHEwoeCIvp
 5New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033461; x=1725638261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ac3clolXtBWW4FL9/JYgaFFPoi0LZCznqT+B1+LGBPM=;
 b=DlRi1Co6MM07tcb39qGVfXvj/lFXuqUuJf89iJ8KiXKdLuJwA27NO5YnWp0XVkV0fq
 qmjJS59s9xqyaVgjgXtEwUciqM+uEvTcRBfEW55ltMwHlXkZHOCcdwATMRC19J6RA9ci
 N9dRR1mwYmeiNq/ZIRD06iZTe3q5S80pzGR17qh3ZoQGQqa757qU50x6BJf/20hAp5Fi
 2kHSF3FTwUbWaIXyWSczEemt2gOGZ4jGzkOXO54YhxZS4ZpE6LKfoCRIp5ILBKBUVLFK
 Na31eZO10YCcYW5UROiinHh23FhB0z91nRdXet5r232V/tE/pfYoTde/PnyiWnTMAfu0
 Hx+A==
X-Gm-Message-State: AOJu0YwQaYXRAStmMreOfi0FMiMVoIfHYB6I8w06LKYY/x4mOXCk7pEM
 5LF5SFc7YtFRzHz7HzmW44iwiXqvrWGz8Hd1EuM28mpQ/45GSyBYVCp5+g==
X-Google-Smtp-Source: AGHT+IFdlX5Qcl7/ogyJmRjJrwuQxkKjB0gqqtA7WCwqVZcj6JtEZ+kAxO73VSBj6yuQypy1wDP6lw==
X-Received: by 2002:a05:6830:44a2:b0:709:3b06:d578 with SMTP id
 46e09a7af769-70f7072ee46mr18066a34.26.1725033460616; 
 Fri, 30 Aug 2024 08:57:40 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:40 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 4/9] sunxi: H616: DRAM: Adjust size scan procedure
Date: Fri, 30 Aug 2024 10:55:09 -0500
Message-Id: <20240830155514.481410-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830155514.481410-1-macroalpha82@gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

It's safer to start scanning for columns first and then rows. Columns
reside on LSB address pins, which means that second configuration will
already have all needed row pins active.

This is also preparation for introducing DDR4 support, which need scan
for banks and bank groups too.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 31 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 35405915e9..4782e6fe38 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1362,28 +1362,33 @@ static void mctl_auto_detect_rank_width(const struct dram_para *para,
 static void mctl_auto_detect_dram_size(const struct dram_para *para,
 				       struct dram_config *config)
 {
-	/* detect row address bits */
-	config->cols = 8;
-	config->rows = 18;
+	unsigned int shift;
+
+	/* max. config for columns, but not rows */
+	config->cols = 11;
+	config->rows = 13;
 	mctl_core_init(para, config);
 
-	for (config->rows = 13; config->rows < 18; config->rows++) {
-		/* 8 banks, 8 bit per byte and 16/32 bit width */
-		if (mctl_mem_matches((1 << (config->rows + config->cols +
-					    4 + config->bus_full_width))))
+	shift = config->bus_full_width + 1;
+
+	/* detect column address bits */
+	for (config->cols = 8; config->cols < 11; config->cols++) {
+		if (mctl_mem_matches(1ULL << (config->cols + shift)))
 			break;
 	}
+	debug("detected %u columns\n", config->cols);
 
-	/* detect column address bits */
-	config->cols = 11;
+	/* reconfigure to make sure that all active rows are accessible */
+	config->rows = 18;
 	mctl_core_init(para, config);
 
-	for (config->cols = 8; config->cols < 11; config->cols++) {
-		/* 8 bits per byte and 16/32 bit width */
-		if (mctl_mem_matches(1 << (config->cols + 1 +
-					   config->bus_full_width)))
+	/* detect row address bits */
+	shift = config->bus_full_width + 4 + config->cols;
+	for (config->rows = 13; config->rows < 18; config->rows++) {
+		if (mctl_mem_matches(1ULL << (config->rows + shift)))
 			break;
 	}
+	debug("detected %u rows\n", config->rows);
 }
 
 static unsigned long mctl_calc_size(const struct dram_config *config)
-- 
2.34.1

