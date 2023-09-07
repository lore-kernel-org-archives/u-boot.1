Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8852CEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D1586A35;
	Thu,  7 Sep 2023 17:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P9kIdTyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DD986A90; Thu,  7 Sep 2023 17:58:40 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1339986A35
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79565370aa3so48825139f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102314; x=1694707114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnMYYQNTuec7dJVSutdaH4jlfk6JWuzaxgFSrXcjmcI=;
 b=P9kIdTyg9rCGguMNEbDeotVT7Nfbygjqerav9qkSQptUYYiZMoDgfcYonOnqURce7/
 DUT7dekyJNbnLW1Sk1Pif5eVWYhKTEprr1K7lUJbQf/yJWEcPMJootAMCDl5RB+A23qE
 1hjosdwWFbhEyuGPVnG0X0xymSmYziCGEDn5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102314; x=1694707114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnMYYQNTuec7dJVSutdaH4jlfk6JWuzaxgFSrXcjmcI=;
 b=gvvuO8BP0SO06KRbvemQzS6p6KQ6RiDxTD803oOJCtVlf9zZg5a0XaiCYtsVmkL/GI
 WQGUflQoQxB+s/7rj/PS01N0StIcDq78ZvuBJI6Pir89FbClZl1zRca2rS5tXimqZS55
 2MUWK5PlG/rFtwc9BPn5s46DvCs71hOqkAHezRrM+mXPNQsKjIiUgkMKkHO6IBgsEPpL
 KOVxy3TwicneBBoeNugAQTMaGBQUcsnwr8eU563R6ocdMX7Z21DF0jRsveGfO55oSD+0
 AFLobV1qiD9a58tRqiFtoYVuHnET1aehnVaR/pKeb/M5wNDtqF1JrAIu99i/ZnPQU1yX
 Tfdw==
X-Gm-Message-State: AOJu0YwWChnikQJ553y+k01aKXO9/hcPiDim8Jd73EARqy2IL5CRUuTe
 0OlAtkKlBzO7juioUmBNiQkaRXathxk2On0CQsM=
X-Google-Smtp-Source: AGHT+IH8aQEXshJJT39JpMj+hlLB4PdNnFoJkAZLpiULIV6U+fZBgCG2YZNqQ+35PhZZUd5gb1CDnA==
X-Received: by 2002:a5e:c60d:0:b0:783:47cd:27b5 with SMTP id
 f13-20020a5ec60d000000b0078347cd27b5mr144886iok.3.1694102314725; 
 Thu, 07 Sep 2023 08:58:34 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/9] x86: spl: Change the condition for copying U-Boot to
 RAM
Date: Thu,  7 Sep 2023 09:58:17 -0600
Message-ID: <20230907155825.48056-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

Make this depend on whether the address matches the offset, rather than
a particular board build. For samus_tpl we don't need to copy, for
example.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 58fa572b71ae..335dacf47fd0 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -258,7 +258,7 @@ static int spl_board_load_image(struct spl_image_info *spl_image,
 	spl_image->os = IH_OS_U_BOOT;
 	spl_image->name = "U-Boot";
 
-	if (!IS_ENABLED(CONFIG_SYS_COREBOOT)) {
+	if (spl_image->load_addr != spl_get_image_pos()) {
 		/* Copy U-Boot from ROM */
 		memcpy((void *)spl_image->load_addr,
 		       (void *)spl_get_image_pos(), spl_get_image_size());
-- 
2.42.0.283.g2d96d420d3-goog

