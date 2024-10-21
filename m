Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D8DD0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF588931E;
	Mon, 21 Oct 2024 13:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D7oCMegx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D45892C6; Mon, 21 Oct 2024 13:39:11 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978038904B
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso317952666b.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510745; x=1730115545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIXCGkn24D5NedgufXfJ/+lgpVoclNjfjstmsmoRbh8=;
 b=D7oCMegxCl4DyQ/lA9Tiw8IB4fRleR0zWSt0aNS/UJ1pjoX9Cjw4aTCywrVz5ebRAB
 jaYA2g+ogRAjy3XLc2wyHqUJEns7sAwCDkT/NPgTeV/skxH9ETJDhOPEZ5o5tjwppWRg
 T5CxHU2XFvpsaye3TEa/kLe2vWTkjgmz4STjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510745; x=1730115545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIXCGkn24D5NedgufXfJ/+lgpVoclNjfjstmsmoRbh8=;
 b=mu38qxt5z3VRZ3XkeUqLdr5w+x/bHc3KVE0ffnt9P5W2x4TQeK3nuBx6d5KuQaiXQ+
 MsmY3h4ICUsGyW9A0HO+CYQ70/+ehNCWohgDB0yEWVzHNVTZ4zsDA1OPdrfVLizIBpyW
 Dpf8kPymLwDk9N6P6xX2/dvaMtqZ9C6i7BwplVs7tyZ642CCfXpvU0WpCZ3zcmtfcluv
 CwxFGWtCK63XkRfDT0oYjuHZxJFgEg4pSKspIBoaSknX0E6BA35xTfb2U9eRvk/IbbHl
 4fAMVooSFVaIqxwu0IzsJtaiO5L71ZkQIfexORSFqRScOkgxNpCBQ0gqbN2tBHOuj9sU
 j/Vw==
X-Gm-Message-State: AOJu0YxtuVPnh+K4F670hsKW5OrWNm+sEF+2kPRZVvfSS/+JdiTstbT7
 RMsVz4oMvKoH+pdmRLQXihHcRjYNkqQzi/8zmrtb7KLksULC1difD4TZSYRkk+J8lGRLgp/e1Bc
 dEq6o
X-Google-Smtp-Source: AGHT+IFDICKzgzWyDQxMZUtEuBTqo4XRY/5MYShKX0hnftnRS0xdKBDbeE+zbm6XVq1EipGn1TrgTw==
X-Received: by 2002:a17:907:7216:b0:a9a:e6:a031 with SMTP id
 a640c23a62f3a-a9a69cd2f73mr1135775566b.59.1729510745165; 
 Mon, 21 Oct 2024 04:39:05 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 16/25] m68k: Drop unused status_led.h header file
Date: Mon, 21 Oct 2024 13:38:24 +0200
Message-ID: <20241021113839.318572-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/m68k/lib/bootm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 3dcff8076e3..1fa112f8dbf 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -15,9 +15,6 @@
 #include <bzlib.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-# include <status_led.h>
-#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.43.0

