Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BD6CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1914586F4B;
	Tue, 17 Oct 2023 00:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V30Zigmq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C610A86F4B; Tue, 17 Oct 2023 00:33:49 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939A186F50
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-777506c6109so219860185a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495596; x=1698100396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gDbcfTI61ws6D2saOzD/8wqhW1K1Zkfqly2aKI2kts=;
 b=V30ZigmqZnewZaq6127x5Mtd63uKqoOsY9qk21YfOMc9gZe8QHEWkXJO2pHqg3n7BH
 XYRFGXwcbqrykfeEk/S0pzorWQYExQChj74sUxKOAO7dBQQHsRvbqw+YWNQG2YsCyJCX
 ztwY8vt8fQKr13hmDJ/ja6O9KbAYME9XX6ikk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495596; x=1698100396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gDbcfTI61ws6D2saOzD/8wqhW1K1Zkfqly2aKI2kts=;
 b=G2xOur/CFKVzG3CSY4J/doxcxK1wVAlMQ5XNFOA/uzATziE21JHt+l2hcxLlfU+L63
 FIJi1y3JEMqyGNxAgY8OwTiSbxLbJ/y3x33MfxAS1EiBz+qpKDSs0UD++PYTCUeXCiHL
 wlf64G2Pe6ABmPo5n3MKdSpfnl9OadVKqakenw6Vp91ECSMCmx1zURHaOVWKXfyR5mSg
 M1mAW/DfMhAakbF16o4YL+wZkzlajqDJzUogXgT3iuWX2cDeI89LJtNVCw3jsb+CGzJN
 zukAbpM2ZmxU/SWTSVdxl7q4Eco0Ut0A2pfacLKnAMMLYt35orJZp6HmiHH6DRXJKhxq
 MIug==
X-Gm-Message-State: AOJu0YyN9xijrL5zYhd9VsBCelZC67qa7nUTdOqkbzW7/5+CYoAHdQ2v
 /gyM0pIH4LcF6OPjG6yg2AOFbZ1ZjAWHtRMTbpK8AQ==
X-Google-Smtp-Source: AGHT+IH9fP1FbIHdXJQ+SqV+pqwLfEIxBRnH7g4HaWdpqFn6mDpRUTHsgc8tJsOtTT7DsPDuMqk+3Q==
X-Received: by 2002:a05:620a:318b:b0:76d:a110:856d with SMTP id
 bi11-20020a05620a318b00b0076da110856dmr710792qkb.0.1697495596232; 
 Mon, 16 Oct 2023 15:33:16 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:33:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 30/32] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Date: Mon, 16 Oct 2023 16:28:21 -0600
Message-ID: <20231016222835.596572-31-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

(no changes since v2)

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
2.42.0.655.g421f12c284-goog

