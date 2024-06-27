Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4684C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E8688572;
	Thu, 27 Jun 2024 10:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cvNFZEcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAAB68859A; Thu, 27 Jun 2024 10:30:02 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D688B88572
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42565670e20so1806105e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477000; x=1720081800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=cvNFZEcyt5YL2Sk9liIQzRC+wt0SaaPuV5YR6jnZ6Vwa60L5ldvBnmEeUTpOws1kn4
 hrXPthMAyWcOjwX35352a0aBI1pXFo+TTTy1ovpf8oboXuz5ju3S2WPMiV1fKNNJUFRW
 E551eTQ7qL3sYo2fcEuaeu67eF+k7wB6P8ALM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477000; x=1720081800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=AGSfRVtrn7phvGPNZxUxYDLVSzRYqceWjqZFmWiCsIUpXL2AGYJp3OEFR2YVffHUtK
 mrfH0eKwWh51uOlB2VvZ7YJoVbhgizN5phIOSOXZj4a7iBXzOC2KungnW1sxgSLhjRVd
 t4qF+XUDJH2+Pkjfg4HfzTy9zBbWCc2/mogzmaQCSqNk2k2yI4pLaYtrUoFbATrjLQMA
 0QsSiqqfz1zaTE3SFdQaSs/IejZTQt+NY04jEQY/rLKNi/VkWckvNeTZqSXecjXkjXkU
 7FhkQIP6T6OhayivH/6xnN/664+OYmOfaD1zBLKYUUp/CNCw/8W1KWU+6DIdXeNz4bk2
 I36Q==
X-Gm-Message-State: AOJu0YxmiSrLWrVBJowRHZTbADiAvXz93fjABbxCxTByH2Sp5P1FxhwF
 3mAsN1lo/mXNxxTkkpJ+9BBs+yineUiFqna10zceVwaiibEIY7WnDj7p//ShawI7WrhAmlC25u0
 muw==
X-Google-Smtp-Source: AGHT+IE0WtOtmveYPHln9CIffpOmhUUtVH+m1jMqnEK+qATy6S0EJ2KIHoItFie5N8WdLduGKmwJ7g==
X-Received: by 2002:a5d:548b:0:b0:366:e308:f9a1 with SMTP id
 ffacd0b85a97d-3673cc7f1b3mr1718118f8f.23.1719477000175; 
 Thu, 27 Jun 2024 01:30:00 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 6/8] spl: Allow ATF to work when dcache is disabled
Date: Thu, 27 Jun 2024 09:29:47 +0100
Message-Id: <20240627082949.357089-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

The dcache may not be enabled in SPL. Add a check to avoid trying to
use an undefined function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_atf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3bdd013a35f..9afe6456bc4 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -204,7 +204,8 @@ static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
 						       fdt_addr);
 
 	raw_write_daif(SPSR_EXCEPTION_MASK);
-	dcache_disable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_disable();
 
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
-- 
2.34.1

