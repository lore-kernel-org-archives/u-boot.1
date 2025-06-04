Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BDCC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABAB803DF;
	Wed,  4 Jun 2025 15:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k+wxNCN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E335A807B1; Wed,  4 Jun 2025 15:09:33 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E932801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-86d013c5e79so446478539f.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749042569; x=1749647369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h4V9yVgSAf4/6cR1fJgpjdjvxd7h1pYo+zrvRdLXQZk=;
 b=k+wxNCN5wAX15jFYRh5TMtNwrkAF4cVzQXz1hXzYp8OqiH2xUs0X/0HmW4yqP1YR+E
 XlhQTp/4tnoRYrp9nucpDBRDiZlOEhI07t6IroxEV8NAwHmO0Nfmj1dyB9rYRyLMP0yq
 UMP7AgaAJomX9i/G1uk49dL3dn6ktSrtSIn84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749042569; x=1749647369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4V9yVgSAf4/6cR1fJgpjdjvxd7h1pYo+zrvRdLXQZk=;
 b=p6KA1vgWlt2HkJmTQurrxi5pePWL+xhtVcmDagXq0QaNOT7D4u63UIYU2QNn2fBg1L
 6vH6IhllzfMYcJeoVU76RjvipbKOOUApl9ytfWeUP1U0FjDP4z8juekX72U3GRGkJvPN
 U+ZJ1uecW/vigfpxWOkDqxcBODpWzkuhFSCPVh/qW3lmuvTmS7BAwqDBDlR7GFEuAYQQ
 mMRFk1uFYQSqMXgSfIUPzWl0JH2AZYq647l92TGDgxRztyPXSpEBDQzLdZwzBF+gYFS0
 kWfJljO2vJvrV6WC0d5rHi/h7R4OReRTgSyAnYpD/xRKrGd5jqD4kdtH00NC25fWQxNH
 WqtA==
X-Gm-Message-State: AOJu0YwwmMijotlcPeQBcyIBgizS6GAjiuvgxTbL2LYMAIi/V4lDSf4A
 FAjHyPtHTQO83TZKIahkbhmip0g/UF+ivoB0Sb0MudMW7CFiZCxAf3URcB1WA1S3Opv8Lm/QX+/
 YrGY=
X-Gm-Gg: ASbGnctYabxrHFzXpCdLG3TX6Hjfg9ueWu1Z10cacCeEMqVDC2KmXITqK8FptYmJejM
 bq4AoYyN4etRe0/h/jdxVpPR32lNW6/hdB5VHQ3/qQJjQXgprU9xO23YFi491ZxebAJhuZ7M/s7
 ndsNWF9kkbPAU3OFuEiCWz25IerwADlCF8kSTzL8SH44AL6M+UutSSQbxKIxn/g8rdcvQlM4YR5
 mTL+1ALPjxKWNbvj5lfF0FQsiomP5A9/7gW3vW+fSZABSpO6w7YFufq+xWy+mVSmVTqDmwYxH4O
 zqB6mr7HNCXyJuBW4HYWLKKIpz8gxuACl8CG9Pkq0gHDwyQfbHgu4FMyL3kYGfQ2BP5CWFYTTgs
 A12qmNEgqjmTG
X-Google-Smtp-Source: AGHT+IEa4Bum+DOYhcLcb4NItXbWjss6AM/JQGHr+uxVA5NCg4CL1WxM2M4B1cy8X9f5QSHCM2P5HA==
X-Received: by 2002:a05:6602:c81:b0:86c:f603:890a with SMTP id
 ca18e2360f4ac-8731c544822mr306712739f.3.1749042569569; 
 Wed, 04 Jun 2025 06:09:29 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdd7e28e08sm2798416173.47.2025.06.04.06.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:09:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] x86: Correct condition for init_cache_f_r()
Date: Wed,  4 Jun 2025 07:09:02 -0600
Message-ID: <20250604130923.1484873-1-sjg@chromium.org>
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

The condition here is reversed, which makes link and coral very slow,
leading to lab failures.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes 6c171f7a184 ("common: board: make initcalls static")
---

 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index bff465d9cb2..c8a612d6070 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -1079,7 +1079,7 @@ void board_init_f(ulong boot_flags)
  */
 static void initcall_run_f_r(void)
 {
-#if CONFIG_IS_ENABLED(X86_64)
+#if !CONFIG_IS_ENABLED(X86_64)
 	INITCALL(init_cache_f_r);
 #endif
 }
-- 
2.43.0

base-commit: 422222f5170ac399f0e5fd39290f8508ad777fcc
branch: x86b
