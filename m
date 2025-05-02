Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A3C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56EFA82C49;
	Fri,  2 May 2025 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EY9fN2P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B665F82CBB; Fri,  2 May 2025 16:49:25 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2C382BDA
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8616b7ad03bso48167439f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197361; x=1746802161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rh1DBasZ0cboSsIBTx/Ln6a3NYScJctaZ8CPv8EDUBQ=;
 b=EY9fN2P3+/XhsHdn9k0ZQ7se8VwSRnbdG7UaZZjbR/8TpfTcK7X6rRNuTBBLOkYbDU
 aK7DKEbh6d3s7DBk/Buzx2LcSCitWTZww2hzUAa+qIsbg/0zZS2pCmE6d1mTo5HEuo3w
 MLY9KjEf8j6iZpq06nogGe/+Smnpr78A3LUO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197361; x=1746802161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rh1DBasZ0cboSsIBTx/Ln6a3NYScJctaZ8CPv8EDUBQ=;
 b=BD4Jz5XPDDV+TkiNXz8TkV0m0xx98asJuXxHR3WCrTHEzaSG7LGtiEKh/7ZWZCI8fL
 QLpp6yazTyAM1uKQjwbxacDyHjmJ8Q7kDiJAOoKSD+un1KbwMf0X5JB63Bl6N9E1t/Oq
 2Lz9+sdqm/JJj0pJhDZWiGyh1g9EgUuWVncwVJgtADhy1VP92p6M0WaKisYeHPxjjkbx
 pxA+v3y7dngHFp7xmsg3JMAES8FlYtIX6CivhdJBw1T8T6vqk6/Oi4A1fjDzvKhOBdnm
 Miy3PXGJiXGSOTWj1N/i1WES8PlN4bjLb4tFgTso3MIhhKlfOgwrzawUVNf7c3C1O2w7
 /Obw==
X-Gm-Message-State: AOJu0YygjwrovpATqnlzwt3Vu6mOcOcr9cUHsFS1y8ICTFrGxIH6JGmt
 /3pEhaFQ0O/sL4VUJyZVuqkaXEG79DTQzONkI9wid0q2rOD2FqhS7V8WiQztcjW7oTh4ON4FsqI
 =
X-Gm-Gg: ASbGnctZQlReWgZjWIsHap+rtI0WTcBzcMIj5G+6IaEJ21c5rRGo4r7cLCD/hvdb8SX
 hJCqT5OzdAbf1YlYtpl4mpkALPs30rLBYUwJV6IiD+olD+siB8n7tv3hUmAS78LSv1l6AZ1AkGT
 KCzdqbyYN9OiYV8sMbG37/3ADW3xUmA5GamwB9JyZeGPA0jHhNbDRVRmLjnqDkeklAWRDavoX8T
 C2lC2leUpudtC+NJgiPfRWfzd0F+ckh6DoqqDhTlw+pdJqF5fpwzHlIV8E6DRuSrb6rKOXWvwas
 k1RrS0zM2/7LtzXzAxrELjU34FNvfQ1iYq6Zi+NVWC84kejnAhf9yNau70m0lmTfTmUz7REFFEf
 Ldw==
X-Google-Smtp-Source: AGHT+IGqgVAYHPQ7zGy3DukIsXlrOGgJAyVLJCrPyzD50HmWvW+7qJ+waXAGalvUBEcjNKPtHhGr8A==
X-Received: by 2002:a05:6602:401b:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-866b42504e4mr441794339f.12.1746197361464; 
 Fri, 02 May 2025 07:49:21 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 59/60] expo: Set up menu fully in bootflow_menu_start()
Date: Fri,  2 May 2025 08:46:57 -0600
Message-ID: <20250502144718.313633-60-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Apply the theme, calculate dimensions, highlight the menu and arrange
the scene correctly, so that everything is ready to go when the expo
is rendered.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 56a34ac8ed5..43f074f19f5 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -212,10 +212,6 @@ int bootflow_menu_add_all(struct expo *exp)
 			return log_msg_ret("bao", ret);
 	}
 
-	ret = scene_arrange(scn);
-	if (ret)
-		return log_msg_ret("arr", ret);
-
 	return 0;
 }
 
@@ -296,7 +292,9 @@ int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
+	struct scene *scn;
 	struct expo *exp;
+	uint scene_id;
 	int ret;
 
 	ret = bootflow_menu_setup(std, text_mode, &exp);
@@ -317,6 +315,18 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	if (ret)
 		return log_msg_ret("bmd", ret);
 
+	ret = expo_first_scene_id(exp);
+	if (ret < 0)
+		return log_msg_ret("scn", ret);
+	scene_id = ret;
+	scn = expo_lookup_scene_id(exp, scene_id);
+
+	scene_set_highlight_id(scn, OBJ_MENU);
+
+	ret = scene_arrange(scn);
+	if (ret)
+		return log_msg_ret("arr", ret);
+
 	*expp = exp;
 
 	return 0;
-- 
2.43.0

