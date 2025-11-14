Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55033CE7A8E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C2183F2B;
	Fri, 14 Nov 2025 10:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ofVH5tUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97241801CF; Fri, 14 Nov 2025 10:32:55 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27DC83F0A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 454153FE37
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112773;
 bh=nH/SVlWUg5PfZTPKP5zqvNlT3+5khpbZTvEcmDPPSlY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ofVH5tUnATz4B7lCjc0riYV/pYLQ8pgOugpvqpC26TVp1U55avKqFBnytnu2pMcfw
 aoJSWESgZH9g8wykLewSDTjvC+5bp3/3gogDYap6FLrXD9RIK3RmnVOqQJ4Plo8f9z
 9NuHcM9kdH2NE7yEDISgtkrUGLUuAz7tkxVdFnhbFXGSBxAnVqDD4pE6jqUj6k4Lw+
 nbBWnjBuDIOoMEnXAy9BRhUt8FMQqtTX1FSEDehJEGeS442D7Im0tOg3ZDKrOCwp9M
 bLLPdwPQDHTbf235z0RTmWl8ujm9F5sWrGooZewsosjWBQZLnow67cuB3mO7owtw4G
 0cObnN3pQvNDOb59h+OTtbOrGIUbWjg9sfTUgEvts7UDFPQDsY5cebQTmB22sFyGi+
 j+tJUjHe5djyU0s3in09kWkO7pBTB650ffNYq3iJ+3HCv5Rn76aGmfZra+XonPHV4G
 Wi/cwlSIJkr+GT4mpME5lZEVRigV0Q47IlDmKxEmP7OyAYBnnwiuVQe21J1RT+yUKN
 4FkxPKwtzlt2oUVJW+HhwgY97Q8NwRGc5x4cB0ehBiMiYEDRusgJraJNfCSL+WB5He
 Ll3WA/2+O7jh05xuhQBaeWqJy9hY0AGeFz/GW/NYM51ExSGKgYLIh0CjgTPWLS52yt
 jsePdA4ZraQBPbqDvD//xVvY=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso30392955e9.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112773; x=1763717573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nH/SVlWUg5PfZTPKP5zqvNlT3+5khpbZTvEcmDPPSlY=;
 b=OqjCv02QyXa8523PIOpMiA6m99AHy+M2U4V0SUw8FGVJTzOh+smyfQu6J7scjvOjYw
 O2a5K8fg9ygCcvtNBTxy6TgZ/Ihs0fL7bJJYhX3T4JK/lpRcG4NOhhGLpo+zH4EQz2bO
 cGi34JQBsNEgrTIjOXxPo4fU/dtVwLX4IdaSXNtauLXAP29n85YC6tSK4HqBhKBzwmKK
 FnH+m8Y11fA2nZftnnprL19eG56Tob6Nbl7gjgOMH0y/a6FeF7GSnErvtj3njPoRyzC/
 Xm0qReHGUUiZ+BY878Yv5NRfqxhbDKSOVGEPkX42Xiy2JmVUvi1RaxtQHGsfTZZqXf2l
 2Zkw==
X-Gm-Message-State: AOJu0YxB5Gza3vGUvh54UnF6yiRQDlwvu0XQ1wunrI/mMKtQ6QxGIGI8
 GJaqfLsvsy+1mgQaqn4T/8ifwW11nEGU9gkDbJcZLJizos0l0LNfaW+V4ZJVNzJoWPjhyXNl9se
 wL+uq5o7/8IEbAzLRn1KWaBQN+Urmr1T9YZ0arUqfNX18zQVUVhNrqmIIIyaKUq2PTP1WTUk=
X-Gm-Gg: ASbGncu4LAy49fpCLtdYj98RlvZxxOXWn0L3n74RFP/cG8yieSn+fKVoleS74OK8zM2
 TbBzB/SURj3MxkJDt3TBKi2d54SmEthabQUvGGNRAxT9/shmYYcQ/gs+qfE696p1x6lcBJWYPAQ
 zDExkBET6jq8XbgcraxL+6EE54VLpY8ajqotl+PVnA6n9VFE4Y9JqL6ypB4BPlYMPxxyi9pbS0+
 Py4sDUvVsGpmoxxdvnlkPJoad/iUCsFd0p76aqp0H1D1z6fG7skD918M6Xt2u/BUs5QU9huKfNX
 WBVUvsXEPsd2PP/OQJygjQxFThGnkNmmAmhQ0r1WrY2ZCb5EQGMdZdIA18BnqQe/u+uflcQyk/c
 fIMukmTBUDd49Xu052I/qq9KDRkPewJpeX5ZQAHWxAhIUhfEiDcTNr1OlUGdlXXkAwA==
X-Received: by 2002:a05:600c:4594:b0:477:bb0:7528 with SMTP id
 5b1f17b1804b1-4778fe9aec9mr23685215e9.22.1763112772779; 
 Fri, 14 Nov 2025 01:32:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErp8Yw4B6vBqGUEu+AcDDvvMYQ7R69jYokIaZtVJdnstGY99WdRGbM2xw5Z3N3yUwjxyCkXA==
X-Received: by 2002:a05:600c:4594:b0:477:bb0:7528 with SMTP id
 5b1f17b1804b1-4778fe9aec9mr23685015e9.22.1763112772385; 
 Fri, 14 Nov 2025 01:32:52 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:51 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/7] efi_selftest: simplify efi_selftest_reset
Date: Fri, 14 Nov 2025 10:32:41 +0100
Message-ID: <20251114093246.56422-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
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

Use global st_runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_reset.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_reset.c b/lib/efi_selftest/efi_selftest_reset.c
index 5dfe517de4f..8125f51815e 100644
--- a/lib/efi_selftest/efi_selftest_reset.c
+++ b/lib/efi_selftest/efi_selftest_reset.c
@@ -10,22 +10,6 @@
 
 #include <efi_selftest.h>
 
-static struct efi_runtime_services *runtime;
-
-/*
- * Setup unit test.
- *
- * @handle:	handle of the loaded image
- * @systable:	system table
- * Return:	EFI_ST_SUCCESS for success
- */
-static int setup(const efi_handle_t handle,
-		 const struct efi_system_table *systable)
-{
-	runtime = systable->runtime;
-	return EFI_ST_SUCCESS;
-}
-
 /*
  * Execute unit test.
  *
@@ -35,7 +19,7 @@ static int execute(void)
 {
 	u16 reset_data[] = u"Reset by selftest";
 
-	runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS,
+	st_runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS,
 			      sizeof(reset_data), reset_data);
 	efi_st_error("Reset failed.\n");
 	return EFI_ST_FAILURE;
@@ -44,7 +28,6 @@ static int execute(void)
 EFI_UNIT_TEST(reset) = {
 	.name = "reset system",
 	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
-	.setup = setup,
 	.execute = execute,
 	.on_request = true,
 };
@@ -52,7 +35,6 @@ EFI_UNIT_TEST(reset) = {
 EFI_UNIT_TEST(resetrt) = {
 	.name = "reset system runtime",
 	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
-	.setup = setup,
 	.execute = execute,
 	.on_request = true,
 };
-- 
2.51.0

