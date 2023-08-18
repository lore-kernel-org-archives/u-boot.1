Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99755C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DEC586C46;
	Fri, 18 Aug 2023 11:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2NxeJKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6ED86C83; Fri, 18 Aug 2023 11:05:12 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D44C986C6A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso79232566b.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349508; x=1692954308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6oxIDqirMMX6utzVp08VNOTXylmElq0gEjQlEX36bk=;
 b=F2NxeJKbERKio4fyQ4YcQeU6kGD1Fy9K0bTHY/zzTA3vp0fpiQHqblowg/iCHjtRAw
 4BXWUuBcEvmFQdK/GCXrp4jzMRN4VbzvEiMcQHTotcd/0dcyE/EteQ1wRrud8PnJBsFd
 GFGOP5tKd+YDJq981Z02FSycZ64ClHqiMOWvQYnuhHSifqUxB6dPXpQ8MD2u1rLG8QsL
 LQMvykcCZXGAlHbVaevnqUCbv5l3enC6SupxoZpBAImbcUKIg4QWtwFls+Smhy/LVKTi
 MukGr35ufikSnHEOY6eqV1jZ0o4mO+Y52kAId/gaKsUJPgmjc8cBKLNWI/MeyB66Bd2d
 r4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349508; x=1692954308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6oxIDqirMMX6utzVp08VNOTXylmElq0gEjQlEX36bk=;
 b=gxWyeHkypiO2zTZpAdX1qhmpwwFBE1H8LcXgmle+OFyAAlfJNXuYcz7oEbM7C6Uljr
 4OhhTMFwYsTV/iiBfu3K91c5SkUf4tUNVJ9BlD680Cb7aQPS7ZItrm1GsTMW+KFJsZCM
 NzbCS9V5U1VfXmI9ldPfMj6xzkC1nYau2KMu0zsMIFCow32aGG+0n3NIGZParosl9Xaa
 KXwsdj30g/rysLwBP05eIL6XLXodVex6aCH+q7djOKf6OmyoRBLrL7Sk5ZU8XjEmJwhP
 HuYacGrb+m80Ye1EkNjtB7I+Yza/WCL0QBieHLNStObXFQWEEmKx0MKThb/ay67tCGvd
 c6rA==
X-Gm-Message-State: AOJu0YxGLP3+dBgEblOg+GD00tirVeR9vF0vPkEd1lXoDtPG4M2s99sj
 /8CNgaOC+mKr3IWzvYmCiW4=
X-Google-Smtp-Source: AGHT+IEKDUC8nIQ4IabeuvolotSegXfapRPUDLQv0V8xpQ7q0/DnIUZMkX4/ILub5liGLr3sFH4x5A==
X-Received: by 2002:a17:906:5391:b0:993:d5bd:a757 with SMTP id
 g17-20020a170906539100b00993d5bda757mr1508603ejo.19.1692349508106; 
 Fri, 18 Aug 2023 02:05:08 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 1/7] configs: tegra-common-post: add GPIO keyboard as STDIN
 device
Date: Fri, 18 Aug 2023 12:04:41 +0300
Message-Id: <20230818090447.348820-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818090447.348820-1-clamor95@gmail.com>
References: <20230818090447.348820-1-clamor95@gmail.com>
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

GPIO keyboard is used on many newly upstreamed devices.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895 T30
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 include/configs/tegra-common-post.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/configs/tegra-common-post.h b/include/configs/tegra-common-post.h
index 991ffbb7df..2d5095639a 100644
--- a/include/configs/tegra-common-post.h
+++ b/include/configs/tegra-common-post.h
@@ -35,6 +35,12 @@
 #define STDIN_KBD_USB ""
 #endif
 
+#ifdef CONFIG_BUTTON_KEYBOARD
+#define STDIN_BTN_KBD ",button-kbd"
+#else
+#define STDIN_BTN_KBD ""
+#endif
+
 #ifdef CONFIG_VIDEO
 #define STDOUT_VIDEO ",vidconsole"
 #else
@@ -48,7 +54,7 @@
 #endif
 
 #define TEGRA_DEVICE_SETTINGS \
-	"stdin=serial" STDIN_KBD_KBC STDIN_KBD_USB STDOUT_CROS_EC "\0" \
+	"stdin=serial" STDIN_KBD_KBC STDIN_KBD_USB STDOUT_CROS_EC STDIN_BTN_KBD "\0" \
 	"stdout=serial" STDOUT_VIDEO "\0" \
 	"stderr=serial" STDOUT_VIDEO "\0" \
 	""
-- 
2.39.2

