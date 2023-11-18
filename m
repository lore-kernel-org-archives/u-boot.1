Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65371C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CF1874B9;
	Sat, 18 Nov 2023 22:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F7vRYRDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6B4870C3; Sat, 18 Nov 2023 22:06:10 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEA186A43
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so124548039f.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341558; x=1700946358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tceC/EkaNu43ZPV0xbWIcKWexiTBY9v1/HMf01mPmHA=;
 b=F7vRYRDlF+kYK9/+UiP/W9sGPU1UYTdiJpBS89XcsBMO+oopf2PPqOpxOAtB4lR1xN
 giyVR8oERHsxnMF8RYj1cEB99xufiFOceZqflAeTkb8gqVm1xaADJpR3O4q2dANDj1ky
 d0JhjVhj+OO/3LeIy7ISticzznLUZ5O1hj/Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341558; x=1700946358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tceC/EkaNu43ZPV0xbWIcKWexiTBY9v1/HMf01mPmHA=;
 b=EnLNW6whJV32LStKqfPTbiaa24WQ6qoWZRB4sa78uDEcbaT4A3P34Qk/nbYGV5J7d3
 9OAL7DOjCCl+vIBwEUYgmk6vns4gLQEPZMTNfwnY2mwGHszuv/tue36K3w1+PchFmzwZ
 gd+8t1z5jSfNbOErLfPROICOnAJAHfNsISDCfzCT0UcSFpSCGBzVo/6Vb0MwnFyhyuMa
 vJOgAkaZnjd3DscU3NTYn14+ESpVCECa58siJKqFKznZ6sUZP+rsQ3c8MhiIt+u5quBR
 PXy8vi4AZ9+u3OB6y6CjVPZssODSKIc5NS0scRwwoWIdcaqIk9m649pPMe6+FAd9ZeWf
 Kifw==
X-Gm-Message-State: AOJu0Yzwam/qrskG+kTvrbe5zeMls6dWZUEMSh74wJKKgY3ZvgLBQTqp
 AWNdHOOwwgluGA+7l2kxUv8MiqKJnpdVmHCbJp5d6g==
X-Google-Smtp-Source: AGHT+IGsPalgGiXWryfTMBxG57YssCgNkXUrXs7QHTzXcE+pHrcepn4zKbFu/isrIcYXbbb5QpHp+A==
X-Received: by 2002:a6b:5114:0:b0:7b0:aee5:a413 with SMTP id
 f20-20020a6b5114000000b007b0aee5a413mr1075275iob.15.1700341558222; 
 Sat, 18 Nov 2023 13:05:58 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:05:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 03/32] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Date: Sat, 18 Nov 2023 14:04:51 -0700
Message-ID: <20231118210547.577026-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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
2.43.0.rc0.421.g78406f8d94-goog

