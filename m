Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3BECF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9F988CCF;
	Sat, 28 Sep 2024 22:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y/0hA+B6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D9E88D07; Sat, 28 Sep 2024 22:00:54 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE57888CCA
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a275a1562eso11999715ab.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553650; x=1728158450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGW9/RjthtPrxu0NuB0kudxXU0K+2cSrqMKY6I5ohnY=;
 b=Y/0hA+B6t6HkimkuPjVZSmDt5e87sQ9bXTysBT4XSQQsnjgd/2LKtz9lmJ8dddRbrT
 f4VsWtR3QmI/3tPNZvmbrcbGgEAlQxhbuV5dmTIgm1kXt1r3c4xKD1zxuYbyr4NGD6G8
 QAGIj8tLoWsfw/DqQXXzCNTJ9HF0/LLRRHPvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553650; x=1728158450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGW9/RjthtPrxu0NuB0kudxXU0K+2cSrqMKY6I5ohnY=;
 b=USK0CAzNdKgBx17FytBBI6ZkwitIaIKubTeOZ6pEfug84kzfBOuL938XadmDna19u8
 dvHG/UGkyWccgmAICwEROEvHZ+op1ItN0rJC8KS64EN6xngvnLrmB2EOiGlL7u4d7nZS
 QNkGvkDEUsrNeBb648UEywgjjNfwRtmJ3JoBH8CiKYPn1ZbP4b+gXGK1bYzAnp/dQutz
 jJepMGa891BBYDF93PQzGHO2xYio0VEOIGErT9dLZzCbxnX1GfttYxo13/pRv3ZKs7ux
 2mJkgjUiV6bmiUkDxKxYsUKoan7MaQTiQhtVopKU8ddWqKjHnW1mohLROT7k/ejevTwO
 m/3Q==
X-Gm-Message-State: AOJu0YxkIM3B3ot+9JQ4obvOROG3jMIjNwprR/w3cCvJ/MjXz/w1X0TN
 sXbyNVRny1BZztdvK4U9Bs6mIDRejB27RkTZSS2VcvbUsUsjfu1k6mC+Jy27n2S96LXrXVyWDeG
 E8Q==
X-Google-Smtp-Source: AGHT+IGKOQfA3LHsPA7LOGxlpAdMQcQWoOPYrmJYmuJM+NSANL/cc5fPL5curxk+kvGl9bq6PvKnGA==
X-Received: by 2002:a05:6e02:1c29:b0:3a2:6d54:33df with SMTP id
 e9e14a558f8ab-3a27685a0fcmr64661505ab.4.1727553650359; 
 Sat, 28 Sep 2024 13:00:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 08/30] x86: Update a comment to mention XPL
Date: Sat, 28 Sep 2024 14:00:08 -0600
Message-Id: <20240928200030.194546-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

This uses XPL now, so update the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index fbd23af6ce9..ea11b09eacc 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -247,7 +247,7 @@ static int last_stage_init(void)
 }
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
-#endif  /* !SYS_COREBOOT && !EFI_STUB && !SPL_BUILD */
+#endif  /* !SYS_COREBOOT && !EFI_STUB && !XPL_BUILD */
 
 static int x86_init_cpus(void)
 {
-- 
2.34.1

