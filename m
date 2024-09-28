Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980B1CF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3209888CCA;
	Sat, 28 Sep 2024 22:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g4CMEJc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C42B88D07; Sat, 28 Sep 2024 22:00:58 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F85988CE5
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a1a412638fso13574775ab.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553655; x=1728158455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/roAvz+WSrX5sSOrEoY346/4AJgK3itQ2Y+Hcx5Ej54=;
 b=g4CMEJc5FEUUMCQyPNqKEDxhp8J59d6k7fdweaxYfd3Icr2o3bO+Bhp7mFl7LUhV8B
 P3VCzFZziMzHMtuALcx6CEK14nTLE4pEaiisKJElbOvfnWdpvIwCvK+kFni7AH6QvqC1
 TiosFen64vi6SRV59OFcYsqhcwsFc0KzX0SHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553655; x=1728158455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/roAvz+WSrX5sSOrEoY346/4AJgK3itQ2Y+Hcx5Ej54=;
 b=hGYpIpnHmtqwnQo1WgX0m1YEEIXvI/IA68gAueS0YsNzi1XkoLdko0ei4j+4FFHAjB
 Cd4cqlkfIy2RoZ/tk58h1aoNRaPjdtjjlJUCF3WZH4kmkkoKR9P/PoIjJAb/1Gm1tUVP
 UU9kb7q+yMwhKk08qHnx6r9VNPcW0Qf20XTwPZXdXL+TA0JVmFvU9oK7Wz8ivDZgecKa
 W88P6ny34ZB8QnpDT/iPvnFbeJlIKCMWxorzho33HnPWRxby3R91oey9mygRwEEsFVWi
 PFkqb5ynhoEabiky/JulVYY+xkOKdM3lI9nKEVnoKtbEydj7i1PVadQXhqyL27MFIz3c
 zlbw==
X-Gm-Message-State: AOJu0Yw8qZAvKcziCysRQl1V6WEe3V0cUuLMx37yWksWrXjyGWvFYIjL
 Je4rlsLQdlbuvNogJbuMi9/kC8yPLMAL7lpsTH2ZZaA3LgcdhYDYcb2iaYxauvGCfTFNunsGN51
 oyw==
X-Google-Smtp-Source: AGHT+IEEg4xDQ8IeJ2yfux92TS9YEmVSYskbJ0Z28kHI25FEcHVRkJxymNAjceeuAXuA0rXhLkbysQ==
X-Received: by 2002:a05:6e02:1705:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a34514af38mr75415205ab.5.1727553654734; 
 Sat, 28 Sep 2024 13:00:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 12/30] boot: Drop unnecessary ifdef for LOAD_FIT
Date: Sat, 28 Sep 2024 14:00:12 -0600
Message-Id: <20240928200030.194546-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Use the normal SPL_TPL_ approach for this option.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/boot/Makefile b/boot/Makefile
index 299a22ed689..5bf07e83388 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -58,9 +58,7 @@ obj-$(CONFIG_$(SPL_TPL_)FIT_CIPHER) += image-cipher.o
 
 obj-$(CONFIG_CMD_ADTIMG) += image-android-dt.o
 
-ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_SPL_LOAD_FIT) += common_fit.o
-endif
+obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += common_fit.o
 
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
-- 
2.34.1

