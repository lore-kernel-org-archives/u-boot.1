Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4730C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398B486FFD;
	Sun, 12 Nov 2023 01:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F3bKV64I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1226086FE9; Sun, 12 Nov 2023 01:09:45 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA6786F42
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-359045af665so13195585ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747772; x=1700352572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n05ZpJ3WKCa4gDHjRNf4uFhYwNR31niXasROXQststI=;
 b=F3bKV64IcZXqIpRFXAbX91+nl3Wrsi4NSJDu1UCunU6fbKp+hWctS7JzXmaiEgMzzs
 REW0HVx2+4fMQ4NYOfOFLbkTaDNE8sA8it0Mzu2IWkj2XpaeRHvB89KlRzICdMG7FliF
 FSR6e8YCehSEq0Aq7IX8lo0RBrGNkOyNWmK54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747772; x=1700352572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n05ZpJ3WKCa4gDHjRNf4uFhYwNR31niXasROXQststI=;
 b=CeAN6We8u7Tn9e/fzfWRQ/aYahHrfVEckCHJ27rtAu3oRFsIv2SiDs8TPQGKDd5BQ/
 uOhqhfa4kfJHFdLuCzuWCAZPVDvSAzZNrTRJPvXcC+emAAhen8ljoFwiT5qKJ0O0rWFs
 XoRmsUvljr3/rLwLjnFqHLuDKl7Wqj2BXKAFI4mDzhRnS0kT4Ol2GHAlrzXyVLEt/EsM
 9E+B8otU2NuRbqdVAl+6CHlPBaft/qA8t/FlWAhw+CweWdsnR2vyqM80VOfoMp/5AmBj
 o+0TQOOinrfZDUvDySmkxWWHr7HVxns31EWi784ApsgL0H2yAhbIUStMa/g3ctfRh5DE
 6/6w==
X-Gm-Message-State: AOJu0YzRXLXIZopEBO3s9B4s657yiWCkA6XEzIWl/TzDc3lxujQsvDZb
 csK057PgrJ0rbocJuQW7j8f//kt1n5xRpnBZk3yKLg==
X-Google-Smtp-Source: AGHT+IFWFQC2sJrubJf6KmhQIPANxbUcxCwi+jF8eYCOmQVfv9SYgEsnTGBSvAqTgvSfiHmeeCApUw==
X-Received: by 2002:a05:6e02:2143:b0:34a:a4a5:3f93 with SMTP id
 d3-20020a056e02214300b0034aa4a53f93mr4836541ilv.5.1699747772495; 
 Sat, 11 Nov 2023 16:09:32 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 02/29] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Date: Sat, 11 Nov 2023 17:08:47 -0700
Message-ID: <20231112000923.73568-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
condition from the code it calls. Use the same condition to avoid a
build warning if CONFIG_CMD_SAVEENV is disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 env/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index cb14bbb58f13..da84cddd74f0 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -495,7 +495,7 @@ U_BOOT_ENV_LOCATION(mmc) = {
 	.location	= ENVL_MMC,
 	ENV_NAME("MMC")
 	.load		= env_mmc_load,
-#ifndef CONFIG_SPL_BUILD
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
 	.save		= env_save_ptr(env_mmc_save),
 	.erase		= ENV_ERASE_PTR(env_mmc_erase)
 #endif
-- 
2.42.0.869.gea05f2083d-goog

