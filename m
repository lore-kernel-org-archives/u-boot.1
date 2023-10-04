Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F72E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACA7875ED;
	Wed,  4 Oct 2023 18:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jQIiaspZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8168667A; Wed,  4 Oct 2023 18:43:31 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2085C875B3
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b29186e20aso3363666b.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437786; x=1697042586;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOYz76y7znYpS+3myEnrYXQBvK60Mf6PA6ZkIFyQRMA=;
 b=jQIiaspZrOFWv9mxszj28i7GvBEa4wKjozwmkb+0H4tnK5e+RaK/gwbuTiNFg4z1S7
 3Vjh7srMO2+F2LyuOuu2UOcUbZ6SkU5Ksc9elG3oLJIbtEjBXgJy564hIgvNX+8xTIA7
 O4s1dTOpWeXSnkrRH+HMH1nuNuKowArynUk6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437786; x=1697042586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOYz76y7znYpS+3myEnrYXQBvK60Mf6PA6ZkIFyQRMA=;
 b=pRD3/dwpweTSuEIJfK8riShWer19nqe4sSj5wzbDw9hOLZfHOOyHnUQ4uJbpEwFg8P
 RcLf0uo9gHRZrWI7zIO9Qd/cF7MKHwNzJswgpJ9yJfxlZOdZoDDMv0yzZpO4xhsLxFIS
 KXbVhQxJ5ES67wVmAWFj1gruqdB76299eVCJvE0gmMWNi7sJd9dp4dwJtqbkaPhG4QHv
 6WbqufMYpXr0HvX3h5ijv5uRnTxVTi7mXT6j3nePJ/89wk1iho3OaJw0nHwNlf2H6CGv
 8E89k2UJjuMXpJExwAJjMJ0FFzXPugrDEZf1ZbqKDoWpuHPIJdjrk6XydL39lzqpkdsG
 wOsw==
X-Gm-Message-State: AOJu0YyVIKMpI4HLDN1Xu/ExgUqRPMDHrd/8qg5GzooxDp2BAC9Jfswu
 fC+2FezpIgKQ4A2A+jXkXQKtaukK7ocsBi+oYb8=
X-Google-Smtp-Source: AGHT+IHQd5zdrpx9Ghep28XRKiOZu6tr57UrYUR1CO6FmSkxthz6CXkFzFL8Jd0P+TysVNVh7fMsmA==
X-Received: by 2002:a17:906:2219:b0:9ae:690d:4284 with SMTP id
 s25-20020a170906221900b009ae690d4284mr2719776ejs.75.1696437786724; 
 Wed, 04 Oct 2023 09:43:06 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:06 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Stefan Roese <sr@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v10 10/24] global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
Date: Wed,  4 Oct 2023 19:42:06 +0300
Message-Id: <20231004164220.15738-11-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

This flag is used to indicate we are using the hush parser.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli.c                      | 2 ++
 include/asm-generic/global_data.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/common/cli.c b/common/cli.c
index 3916a7b10a..e5fe1060d0 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -268,6 +268,8 @@ void cli_loop(void)
 void cli_init(void)
 {
 #ifdef CONFIG_HUSH_PARSER
+	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER))
+		gd->flags |= GD_FLG_HUSH_OLD_PARSER;
 	u_boot_hush_start();
 #endif
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 8fc205ded1..f21926aa23 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -667,6 +667,10 @@ enum gd_flags {
 	 * @GD_FLG_OF_TAG_MIGRATE: Device tree has old u-boot,dm- tags
 	 */
 	GD_FLG_OF_TAG_MIGRATE = 0x200000,
+	/**
+	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
+	 */
+	GD_FLG_HUSH_OLD_PARSER = 0x400000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.34.1

