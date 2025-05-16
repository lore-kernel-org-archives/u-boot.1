Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A7DC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E298277D;
	Fri, 16 May 2025 10:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KH/hji8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE21C8294C; Fri, 16 May 2025 10:52:25 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2ED681DD6
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso15082115e9.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747385542; x=1747990342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9Irt7DzrQAM3l0E4VZNmBwVloWSj8TdOJq2DBIFidU=;
 b=KH/hji8LUtZlMOx4onteoKluU3hq6mnrhCEny+Ozo5u5vaUp4G+y3xHu1jOrlMXjDr
 UUbIIqVTwBDZdKjof4+pwjq8AuvEDRKdmLxeOWQluTTRelngumpbiwDdGcL+bVJtPFS+
 lyBJcCPRmW9Ph66HC6xgGc+HOslmMigq8PLguDjoXNu2FLoV72S3lwBTONwkw7PYSdxv
 79ADsSPu054yBsF2fHjXVuZYaIrUv/HYeA/7d1EyOULru11cTQ4QgfL7txducKtwcT8w
 5E98OBwy/2ijQ1zwaJ3R1KesijI5Ayh1AmyVy+o3qBW491Ok1OOew0ET/HSrPkQ987+B
 e8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747385542; x=1747990342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9Irt7DzrQAM3l0E4VZNmBwVloWSj8TdOJq2DBIFidU=;
 b=G8N+1eFyPfR2Gv9XlHmYL4O+YRN3XDCdbYCoCzyCx77n/fBx/+38dlnTbgnGD3sfkJ
 9z2dpQZncqX6fqa535VVqZKnxqwoj9Yb0GN6Ld3FGE0lmZZ7+EpDYIQ85T5OnLI5B5Bz
 dDBNxQJ5k2DRY8E2fsyxaFUaW6M220XzbPuzzaM0C9MmzqFxtidgdu+MU5bBPYNP4wJM
 TvOE4263c8cbSD0IdrkD8sEczuL8ap0OzBdz35RAGqIIoZ7yQTYCoJA0yUhANbCTTC/b
 1ZlaZZHiRC/CF5EjRAxa5hDaPgpl0+y8L8N6DkoEHlt9dblYz+/WRg36WcXh6Olx0m/l
 JE1Q==
X-Gm-Message-State: AOJu0YxuEjcjF6s2FB2LCNeAcIMKX5WBNOjlQLlCtjOnWswn4zsrvXLu
 OqPuvZGbNw2Rt5WakCDuSjvKrKUKxkkLPw5lvU5Q/bMJoWzSnH2wMjDxXguLeBLPOgQ=
X-Gm-Gg: ASbGncszdI1Nawuq9e0KiC5kQfjq1C/77ukHfcf60uZwAPlDkO4JwfljMj0uUt8ba0M
 v2oSfKHOTa9u2ItIugzHafonbkm+52thvpvr4h8zrbb+RXi5GLv62Zm2yJrPKX221ao27KL9gqv
 NaSd+CDYoEensHmZbsDXXWT5gJXHCxly/v2MuuXhGdQfxWI37ln1uGQzU62qn9XF5PYtbUzCWZo
 vCjJI/LCQb0q1akVTMwM0thinK4ruCkjaybUdMN3erGfO3qd0BQLUydwszoX74aLlydWtq6fINf
 EcgH49Ef5XqtIxdAUVsCaEqE7NU1mzfbUzFctxM7cPsqyntTWyBWMAaWCeJvqw==
X-Google-Smtp-Source: AGHT+IEJrM6M0kzJeiGez+9nwgwJtcLf8RKn2uSG/apKqUrOKCfud1Qr6W3I5375eH32eI0A8mFgbw==
X-Received: by 2002:a05:600c:3112:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-442fd606b99mr21164145e9.7.1747385542125; 
 Fri, 16 May 2025 01:52:22 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef81csm96801125e9.34.2025.05.16.01.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:52:21 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v4 2/2] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
Date: Fri, 16 May 2025 04:52:56 -0400
Message-ID: <20250516085256.30386-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516085256.30386-1-adriano.cordova@canonical.com>
References: <20250516085256.30386-1-adriano.cordova@canonical.com>
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

select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
on the qemu platforms in CI.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..fa353c6fcac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2153,7 +2153,7 @@ config CMD_TFTPBOOT
 
 config CMD_WGET
 	bool "wget"
-	default y if SANDBOX
+	default y if SANDBOX || ARCH_QEMU
 	select WGET
 	help
 	  wget is a simple command to download kernel, or other files,
-- 
2.48.1

