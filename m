Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A49C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBD681E18;
	Sun, 30 Mar 2025 11:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOMdd1sB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED38080F9C; Sun, 30 Mar 2025 11:28:35 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0475E817C4
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so482195966b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326913; x=1743931713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hlbRdZU8umxiMuhrW/yhR/j+nx5CnT/Z2mXTLTRbfM=;
 b=jOMdd1sBSeio8O+RwhS0Sgnbutaou8FKcvU6wR1R+1smqZfbXmRun9DU/qCm9T9Xbb
 5s8KiK1mPs8b3FaVOdEUA+UR5hhxXbmiXS7q7FrIQ4XHmkwVY1yqWD0CH3GihFmyWUm6
 s4e1o2wH++Z2QHPVCIEApZJfmp/llDT8deKFfuP5k+6l84QjVAoehA32BAqr3H7kamsD
 qlJjod/9qkK3QZW9+gzDcqy+eDDbh5vS05KB83xgxeSrF3vIqNMeuFgDX1BCqBYtQUV+
 bwVtNqSJcVswPdQhE1KpGpZzblQ5KXO/Lr2dGIrHUZw99qDVcrWHYb1KDv+VeYsMjyNH
 nJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326913; x=1743931713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hlbRdZU8umxiMuhrW/yhR/j+nx5CnT/Z2mXTLTRbfM=;
 b=qwWePRoF9aB5Sd4jtMhzWeA5E/rhxzOew4WlSJgqxAQDfz6SrMRxeg1YD5Hhcbag7Y
 mRaX2Ft5gP859s2UjRdGgkPgzPQsOKgwW+kv18xanoXdOw+yVqtwLJBJXCGsbWOTx7pc
 +Fpv1LRlkG1wXwKPtvwWjCcsRlItqh+innjVnCUqjCjF3voO8wFzpPmfJbchSkVv2j8q
 ZIvvy8HqFx/C+HLzHuXhmSeoS1l4y2g0PQ2ZiN5eSjMf+6ERfhzF2hkqW7XrnKbnzD9Y
 cgiwgoQg9vwmkcy2w83uxx7ytAxoqM6Zl08g9ZtHhnqQ64lrgtX0le5qqqNjIxf57Pkn
 Bc4g==
X-Gm-Message-State: AOJu0YwNG/PWwuAqbV5yJNysJohRLOd6+xpJvuTSNnQYfu2gvczSwphK
 1Q0aUe9U8seWdTDBa6uajGxyTFTn/d0Osq0OLzpDRIlvOwr/0P7L
X-Gm-Gg: ASbGncvDNwwUFxcyN1KgZTNA+iSaXDuYoVF/A9T2Xri0Fe4f6xgxEkooou/c7lj3uYk
 vlXmq74Dnet544BIAtXgIzgDWBR+ngPj/KlXi1R6fh1LC1UmUlIs5aNHf6T6JNIBM4Du3ZvYBX9
 5QZVgiESergFhl6FRSZtQst1jEMEKzSf61csn5J/NE5B458yQ3zeqVZS4aQQXaYxku4pQ1kA9kv
 gCW+Htgn3h1Js/Te5wby77lgAj5VL7EFeFFri3tWjSxBVJuyPa6btnbVsD0jVGDazlEbU14QWbJ
 6mcTV642Sc9mHo5UbJXaXYKTCH7Z7tTP2eZn
X-Google-Smtp-Source: AGHT+IEZmepN9lU2w/vMXsu3udGLs2/0K8n91iG6ZY/JyWDZUu3CR/YePPKXyDMXEWjABjktvckB9A==
X-Received: by 2002:a17:907:9719:b0:abf:d4a9:a096 with SMTP id
 a640c23a62f3a-ac738bacc99mr415433666b.37.1743326913339; 
 Sun, 30 Mar 2025 02:28:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971053csm455653966b.178.2025.03.30.02.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:28:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] sysreset: add PHASE_ to GPIO reset and poweroff configs
Date: Sun, 30 Mar 2025 12:28:15 +0300
Message-ID: <20250330092815.10350-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330092815.10350-1-clamor95@gmail.com>
References: <20250330092815.10350-1-clamor95@gmail.com>
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

GPIO reset and power-off functionality depends on device tree data, which
is often absent in SPL or TPL. To address this, incorporate PHASE_ into the
config option.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/sysreset/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index 796fc9effa5..ded91a4d325 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) += sysreset_rockchip.o
 obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
 obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
 obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
-obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
-obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
+obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) += poweroff_gpio.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) += sysreset_gpio.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_MAX77663) += sysreset_max77663.o
 obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
-- 
2.43.0

