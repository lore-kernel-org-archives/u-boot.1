Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51162C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD5578291E;
	Wed, 19 Mar 2025 15:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bJVNh8lD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFF8828D0; Wed, 19 Mar 2025 15:57:03 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAB282014
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31735295e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396220; x=1743001020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVvI1RzjLdwGU57nwQOMyxcd3xoEBCNU03QRaG7sk1o=;
 b=bJVNh8lDKBrUHTyI2md00wd/BgeDKngcUhroIgEhczSXaqI2u47BFnzP70flXh2vsL
 k5DYEqp1WZJpRomCUjZ9ukiPFfhYIcPxK7zRjeuI0olt5ecaxLouiAe6lQOjFlbFS3d2
 R4UehipoCyHiWZiHK7I2MWuU2NFySxnkfLVVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396220; x=1743001020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVvI1RzjLdwGU57nwQOMyxcd3xoEBCNU03QRaG7sk1o=;
 b=tyv38CQA3y3lCiOSv+rgk79CJlBQ7ch3obfnqBL2vYPMqoWQOAQgJKsBhFcVPf5h+k
 HBPb8r0eczT4NKqZ5e5wcC6LouJhCmj0X7HLcRbbH4WBXa077GhB5SFq1AlzViigbQkd
 PsgFyUDN4OVpLlvf1W1u8SSfHSb83+fEdlc5s/jSjm2zmbXLdobafoi9CEcaI8uWp6r9
 7WqM/FKylps6a4gFczHve07NAVjWFxTGVoHMGBNqN5JhpCxJ5AscyUHLkq9UURIzxD5c
 +jnnUuQP0MTtcGbLrP3AKJavA85rGqawLtZ3fv0OOKdIJ56sSOC5uoCfruDPIccmet3W
 tX6A==
X-Gm-Message-State: AOJu0YxxvGA3D2AJut9IewJ+Z/mXYU0Gi3te463YuOgAVYlogLEKLnVF
 q6usiNLw7+l8xzIlfZAJbXcjU3C88tHmv8W6qbOOfunk63EMJhXxDg48nRTPuVoTGb1rAPz/Dos
 =
X-Gm-Gg: ASbGncvfKpD0HyybnDhw6IEc3fdvDkR0G3hLIFEnazqvabRfBXnkl71QebSgGil0tr4
 YsGhclYwoXNY07y07+LvKsriLBEvS0bmviCwag9CiaQRL8qdzQEZgNAEcGP26vsR1YZ/SNRzGxX
 JmwB9xUPT6FAbqezI1wktAmXmg46fMw07V1IiontmOSfmVc72omXYH76A6GseavAWp+bkyqQBRp
 4p84hJS0cK26OuOxI1n7/N82l/m2sXNgH1kd0wZZdq7Yd0bv1Xyq8Ud7MFiOPp0UeHnIO/QG6Wb
 FnSM8BNngr+1n2HBFSzF9mY4ApG7I6XSrP4vFaBKAAqb5TDNAGA5
X-Google-Smtp-Source: AGHT+IFWpmEFKp5ldNO1Cmb49r/PWOd/3W0BvwUAwfvltEisqjramTppMVULkd8qZlrGNq1I6nH3Eg==
X-Received: by 2002:a05:600c:1da1:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-43d438298c6mr28777035e9.25.1742396220359; 
 Wed, 19 Mar 2025 07:57:00 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 50/52] expo: Split setting up the menu from adding items
Date: Wed, 19 Mar 2025 15:54:55 +0100
Message-ID: <20250319145512.2391122-51-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Some callers may wish to add items later as they are discovered. Split
the setup code into its own function, to permit this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 24 ++++++++++++++++++++++--
 include/bootflow.h   | 15 +++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 7e131de3f6d..4fe5d985064 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -252,7 +252,7 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
 	return 0;
 }
 
-int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
+int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
 	struct udevice *dev;
@@ -260,7 +260,6 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	int ret;
 
 	LOGR("bmn", bootflow_menu_new(&exp));
-	LOGR("bma", bootflow_menu_add_all(exp));
 
 	if (ofnode_valid(std->theme)) {
 		ret = bootflow_menu_apply_theme(exp, std->theme);
@@ -283,6 +282,27 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	if (text_mode)
 		expo_set_text_mode(exp, text_mode);
 
+	*expp = exp;
+
+	return 0;
+}
+
+int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
+			struct expo **expp)
+{
+	struct expo *exp;
+	int ret;
+
+	LOGR("bmn", bootflow_menu_setup(std, text_mode, &exp));
+
+	LOGR("bma", bootflow_menu_add_all(exp));
+
+	if (ofnode_valid(std->theme)) {
+		ret = expo_apply_theme(exp, std->theme);
+		if (ret)
+			return log_msg_ret("thm", ret);
+	}
+
 	LOGR("bmd", expo_calc_dims(exp));
 
 	*expp = exp;
diff --git a/include/bootflow.h b/include/bootflow.h
index 8362cbe2e69..c0e19feb9cc 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -656,9 +656,24 @@ struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
  */
 int bootflow_get_seq(const struct bootflow *bflow);
 
+/**
+ * bootflow_menu_setup() - Set up a menu for bootflows
+ *
+ * Set up the expo, initially empty
+ *
+ * @std: bootstd information
+ * @text_mode: true to show the menu in text mode, false to use video display
+ * @expp: Returns the expo created, on success
+ * Return: 0 if OK, -ve on error
+ */
+int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
+			struct expo **expp);
+
 /**
  * bootflow_menu_start() - Start up a menu for bootflows
  *
+ * Set up the expo and add items
+ *
  * @std: bootstd information
  * @text_mode: true to show the menu in text mode, false to use video display
  * @expp: Returns the expo created, on success
-- 
2.43.0

