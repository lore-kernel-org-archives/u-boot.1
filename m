Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D1E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A62806FF;
	Thu,  9 Jan 2025 13:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EIt1T0ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FF1805EA; Thu,  9 Jan 2025 13:31:00 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BD380628
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a9628d20f0so5156925ab.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425856; x=1737030656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoL8QUqMKfDGKabyaegxXSpmb6N/aOsOjEkopkeStqk=;
 b=EIt1T0ZVl3FYHUJ4jv3RkoaMtgVvv2iSfxnEqK9lv2ZUoIY+OlTp5kwysy1LhickGp
 vwf9slYDTakffTJiEn0j+DKXdltQPa8HukQbhhCIOf5Z9qY6FSR3wKX+dNcfxK9/ECut
 2zpVTIljolsS9WOspBpu2ZDKJ+2QUyxCNAPgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425856; x=1737030656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoL8QUqMKfDGKabyaegxXSpmb6N/aOsOjEkopkeStqk=;
 b=AyQwS3TzraW9e9ZqwrfVgbuTBAjYhScoaeOkFRVfLhYw1VCAs8FOqdvlDMuadTFCQX
 GSDCsb6Vho1LGnPSw2VK0RS7L3wPYP2ApHSoFStovM4U42DDgEm9tHB71UKgAIF/5XMw
 NOjpRP+xI8Jb2Q8mKskzjJBAw6IrhX8XM9vuO1KPyji6di1qKdCZG4l8n6LhWitM0jyg
 OiRfVMKruCwVbnvHuqivbPnY3rSx6FlhX1xTD05f/tF1OxQD3qgWvgKGrtsckfWPJvCp
 iA1Eg+yFB4Hnvpfgq9bx35dyq6EO8uS2qp4XZSil3hfERHm6RQFECuxAM5Kp8E0fodNA
 y3gg==
X-Gm-Message-State: AOJu0YzAVyFvH+Y0tcbb4X3I13na2SyKK3TwWrRe3bZVMrw5G1F1FH7S
 ICmo5TB1nDCWM6DaJh/YTJ3gVcxOL4f2AUIuKMJE5rLxor/no6wviv0A6BnKswIlFA9mr6pRswU
 =
X-Gm-Gg: ASbGnct8BEnGgDie4oz7/EmorK2jkplrGkqdtBXTOtYJrKkxt0v8bKRbzgGd94KQcnB
 aMJIGf/y69ycYXEiEAe22CGg3CI5FcmiL0qQOe+nd26jYfYV0hScroWWxN0xMW5IYBY1uBsI/tY
 fYqBAO2AiC7352aFdJvgvOmtys/ae+ChVSX6S1edkJQnUiEMcVxUZ440bazJcZdi4xi2xpYvcOf
 xC2iUQ/p+LA1SCLKWZFeDqqmwwScnCbdeaahjOqnnTEEcADXRzq/v1qZwqc6lFCd+3+0TMzdWRM
 h1WE8V25VcSnc+vY+g==
X-Google-Smtp-Source: AGHT+IG3L8M1fsZFeeigiqwrtcZG1O4tGUWTWik1d5dLJCvcEc5ZHZ6lp1kNIV8xLS16UiWrahWAZg==
X-Received: by 2002:a05:6e02:1cab:b0:3a7:1f72:ad3c with SMTP id
 e9e14a558f8ab-3ce3aa71e6amr56108065ab.19.1736425855755; 
 Thu, 09 Jan 2025 04:30:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 10/15] spl: Add a type for the jumper function
Date: Thu,  9 Jan 2025 05:30:05 -0700
Message-Id: <20250109123010.4005298-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

This function will be used by the relocating jumper too, so add a
typedef to the header file to avoid mismatches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 3 +--
 include/spl.h    | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index ad31a2f8b6c..09e6dc26f5e 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -671,8 +671,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 		BOOT_DEVICE_NONE,
 	};
-	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
-	jump_to_image_t jump_to_image = &jump_to_image_no_args;
+	spl_jump_to_image_t jump_to_image = &jump_to_image_no_args;
 	struct spl_image_info spl_image;
 	int ret, os;
 
diff --git a/include/spl.h b/include/spl.h
index 781e5a2d638..488adbeb1bc 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -292,6 +292,9 @@ struct spl_image_info {
 #endif
 };
 
+/* function to jump to an image from SPL */
+typedef void __noreturn (*spl_jump_to_image_t)(struct spl_image_info *);
+
 static inline void *spl_image_fdt_addr(struct spl_image_info *info)
 {
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
-- 
2.34.1

