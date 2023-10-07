Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFEEE95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E865C86F99;
	Sun,  8 Oct 2023 01:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lQlNZByM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CD286EBF; Sun,  8 Oct 2023 01:15:20 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BFB86D82
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3529eafb3a9so13404365ab.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720405; x=1697325205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpybGH7y1JNMcp/jxcY2j7JBFi/eB3zM779IhD+0ooU=;
 b=lQlNZByMq+wTfMz6lFInymxoTniiSjZAw/hCHWK30+vA7N12/mH8aqEYsrUi5z0VQk
 n7YeEnuG0UCQQ19uXuuSwkJLvxOhJXkwW/XJnV6rY99ynFX2FmlynGQoudwgnee9DTbL
 icfQj4OHT0uQ/mThRv3/dds/ROY+4CmSE11ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720405; x=1697325205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpybGH7y1JNMcp/jxcY2j7JBFi/eB3zM779IhD+0ooU=;
 b=L8mFfj0XYxbleFsdRcfDtaq6NemhRNKZarJrpMKNjGyAVs4gJt0pPzmf8b3ZXydQd3
 1gN09AxQPztNt2RELb2xuxEPukPzxTXRFg2SynaLHolrtCer67z8RvOjPg+ZrFAk0AOl
 jUCCL7GxL7zTG8Q2XxxszXKKMpABgX1ZMx2RMDui372Xc+5P/Hb1qQLOHQOjHdNfaqcY
 x94AhYQvtkSXT1iKwrBz3CyjhOSupKzMUfB4PXT3lrtM5UzYKL54vOwD/q3t+8xRTzKk
 Dbog40pA7YdIQvyZlLaofrnQfyMg6k4kfkOQwaEp0AfAEJgYMtKh+Dhzqn+RoN6WNfTq
 F8+Q==
X-Gm-Message-State: AOJu0YyJbO3Gbnh34hQoiU56v0+v8pDSi6aRZfgMpb9S2kmvDgMNJHD0
 6ncpl494vRtu3icFJTmUUsX/1O0cw61vnSx6PTg=
X-Google-Smtp-Source: AGHT+IFucwwtWmyz1wmdpac0nmfaAyZGL7A3i0MspPZbwoTkP2CVeq/jAieP4sK967Lvje2C3i0OgA==
X-Received: by 2002:a05:6e02:12ea:b0:34a:c2e2:b2a7 with SMTP id
 l10-20020a056e0212ea00b0034ac2e2b2a7mr14185471iln.25.1696720405465; 
 Sat, 07 Oct 2023 16:13:25 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 26/27] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Date: Sat,  7 Oct 2023 17:12:45 -0600
Message-ID: <20231007231255.277623-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to unify the U_BOOT_ENV_LOCATION conditions

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
2.42.0.609.gbb76f46606-goog

