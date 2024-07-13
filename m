Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D033AC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C391388804;
	Sat, 13 Jul 2024 09:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hoM2fWA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE9F18855E; Sat, 13 Jul 2024 09:03:52 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE31E88806
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eebc76119aso30397531fa.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854229; x=1721459029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spZHfR6nUyJdkwY/1j0TIIYOp3ly9C8+WGByeLEyfm4=;
 b=hoM2fWA8OZ3Z/pe4BFppgv+TzPBfp5sMp93adRZz+LlbMEBKnTpBPk0l5Jp/o7gLf3
 0EzKzVis6FCkqn35MktgaM60SSUbhiE7WBQ5ic34imLc3abVhTgHlOixLMztQPuUJ/Gi
 ek6FimMKqVz9z0m60goNtKinrxiMFj95r8tMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854229; x=1721459029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spZHfR6nUyJdkwY/1j0TIIYOp3ly9C8+WGByeLEyfm4=;
 b=M11uvfqE+E2HXfFu4DwPWw6QbIJLJiUpij8D8QZy5o3bqHFjtFeccBI1QWnFzLTQkN
 NVMrI4xLg4fEBm2O697JHvM9xiqEhD2zw+fZ7A2380rEC/48RiDiL0sbsgHVu/kSfNwO
 JRWkVK/HZOZjZrTm0bX4NFUql3XfB6ghkGQYKpCRhdDtrIaxaDRaO+nFobb5jqUJDxuc
 DbD23R1sr34R0B9wHv0yYZPWghxYKUDQP9o8uPKrZ/hPEBZfbCwx3Y2w+LpyIi4CMSnb
 qfvZ9Mg3Axb/5q9OKQAz5FTlrOMjpJQJEIsGvObUvkTFScmRARpE4maDgmcghOi/icmA
 tMTg==
X-Gm-Message-State: AOJu0YxXJHAd1AHezp2jh0xV13Pav+LzeTRP3nvLLYC6ePQ/asLcdN7G
 VFOvR66lTRZ5htQREKVGI+QJ4yI90++g4YOWW0R6LBM04jgmTlD0zJHdtYDm6t4+cgCyFw+3h/c
 =
X-Google-Smtp-Source: AGHT+IFr51Kk1JQtaFYsGWMH7K2lu2jYQH+XCFdEMbcJ3SWSojjbryJlqZkK/p6HROe7aqBb8wFq7g==
X-Received: by 2002:a05:6512:39c7:b0:52c:d8c7:49ce with SMTP id
 2adb3069b0e04-52eb9991682mr10362860e87.22.1720854229044; 
 Sat, 13 Jul 2024 00:03:49 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/21] sandbox: Set up global_data earlier
Date: Sat, 13 Jul 2024 08:00:43 +0100
Message-Id: <20240713070055.2172883-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

It is possible for U-Boot functions such as printf() to be called
within state_init(). This can end up checking gd->flags (e.g. in putc())
before global_data is set up.

Move the setup earlier to avoid this. This fixes the suppression of some
debug output in memory allocation (when enabled).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index dce80416529..0920ed55965 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -483,6 +483,9 @@ int sandbox_main(int argc, char *argv[])
 
 	text_base = os_find_text_base();
 
+	memset(&data, '\0', sizeof(data));
+	gd = &data;
+
 	/*
 	 * This must be the first invocation of os_malloc() to have
 	 * state->ram_buf in the low 4 GiB.
@@ -501,8 +504,6 @@ int sandbox_main(int argc, char *argv[])
 		os_exit(1);
 	memcpy(os_argv, argv, size);
 
-	memset(&data, '\0', sizeof(data));
-	gd = &data;
 	gd->arch.text_base = text_base;
 
 	state = state_get_current();
-- 
2.34.1

