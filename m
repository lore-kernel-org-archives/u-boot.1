Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13854C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1397682CB1;
	Fri,  2 May 2025 16:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Djqpyc8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A8C828C2; Fri,  2 May 2025 16:49:24 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B2D82C4C
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-86135af1045so234002639f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197360; x=1746802160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCLx11SUpZNnU9hn0936sIz7Nz4KUGr6dVTNfg4EsLU=;
 b=Djqpyc8ty7Z7O5VqikmjZP8PRFYh+Qazwt7I4g+PyyTCYxBDphL3eSgUThUSiuxGu4
 7+kSE94Q7pY4t92nQPXawFpRFr7sXf0ev82ohzWbRbmKk8M7ihdeDFNZe0WAFazMi6/c
 EFWPWXIP4T4l8rexdlEaGUjYjj2DR2YyJ5zOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197360; x=1746802160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCLx11SUpZNnU9hn0936sIz7Nz4KUGr6dVTNfg4EsLU=;
 b=rIZPKQuIbgQXxfsF/E8ly0thV6TH66tQWFZMC07i3LRVoIHU2ZLDhg7bEvRoKZfwHz
 TjPLO6BkOryHj7v4lGcYHIep1d40yvbt0Yiq2sxqAInAUX89WMiABw/QD/P7JdY747+I
 VSgD+gFD+CL0yb0h/+/GsD8sFIDzaj3yEqBjg5ZTpZC1nRUn0XrC89YViNJWx48gH7YB
 MQuXRwGIvNe4jt8dPkLHwiky+OuQtqHDMn2K20cNBiqCHpbBLhfus0mBWTw3Foj17Vk/
 Ah6GwPIMpQ2F0whedq3gCo+g/bkyUuVn1pww/rSvkgm/uAr73/pmwypRMG62w9MgXi2l
 V3bw==
X-Gm-Message-State: AOJu0Yw4/ML5alSlgMacgRvh3X0M9VC1yW5Z1qfx44kJl/Qe7l7ww/9Z
 HmGDcKNrSE/ACYB1pfAwRGP+67E+z7BEhDyd93bzyQ1s68eK+Rk9zMzen2UvzaNtyrz2D09Y+bA
 =
X-Gm-Gg: ASbGnctd1LSOT7G5BNMDP2L+wpXOjDaMunBwXhs44SIqJbBcRo3JvRMEURdG0U6E50N
 FnrIcfDFq2KEVXBmxvocsBczfj/7fMv1eTvD2Tk7TwpP3TyBIcH+FSAwBMehSKK+RxwFKzcA553
 wdACUUW59qLHOznU2Jypyfmc20xAiXJJprJc0btyDQX3l2hEISa3maspV/wsEXXjLSj16R+kDlV
 akm9H0K7Hu83xCrDQNdm9S4O94iJ35WAfqAvK2mlanwZYtbLG1FOY8pRRZOiK4iGQmprRpus14b
 s8TjDY8YiPdgucW6yG1C7Heq7djEf6+8Nn0v8FisGhXJc3vTlKTE8LXy64CV6xg1D0CKCUbaFWy
 ENJtmLSF69U8S
X-Google-Smtp-Source: AGHT+IGO64Y8H9VkjEC4c9nqnsDWYhHDeR44EtX3IXD7t/sHnk0tAwZX+YFncWer4zUMJvKXKM4jQA==
X-Received: by 2002:a05:6602:b84:b0:864:a1fe:1e42 with SMTP id
 ca18e2360f4ac-8669fae93bamr395077739f.7.1746197359924; 
 Fri, 02 May 2025 07:49:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 58/60] expo: Split setting up the menu from adding items
Date: Fri,  2 May 2025 08:46:56 -0600
Message-ID: <20250502144718.313633-59-sjg@chromium.org>
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

Some callers may wish to add items later as they are discovered. Split
the setup code into its own function, to permit this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 31 ++++++++++++++++++++++++++-----
 include/bootflow.h   | 15 +++++++++++++++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 6bca17142ad..56a34ac8ed5 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -210,7 +210,6 @@ int bootflow_menu_add_all(struct expo *exp)
 		ret = bootflow_menu_add(exp, bflow, i, &scn);
 		if (ret)
 			return log_msg_ret("bao", ret);
-
 	}
 
 	ret = scene_arrange(scn);
@@ -257,7 +256,7 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
 	return 0;
 }
 
-int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
+int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
 	struct udevice *dev;
@@ -267,9 +266,6 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	ret = bootflow_menu_new(&exp);
 	if (ret)
 		return log_msg_ret("bmn", ret);
-	ret = bootflow_menu_add_all(exp);
-	if (ret)
-		return log_msg_ret("bma", ret);
 
 	if (ofnode_valid(std->theme)) {
 		ret = bootflow_menu_apply_theme(exp, std->theme);
@@ -292,6 +288,31 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
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
+	ret = bootflow_menu_setup(std, text_mode, &exp);
+	if (ret)
+		return log_msg_ret("bmd", ret);
+
+	ret = bootflow_menu_add_all(exp);
+	if (ret)
+		return log_msg_ret("bma", ret);
+
+	if (ofnode_valid(std->theme)) {
+		ret = expo_apply_theme(exp, std->theme);
+		if (ret)
+			return log_msg_ret("thm", ret);
+	}
+
 	ret = expo_calc_dims(exp);
 	if (ret)
 		return log_msg_ret("bmd", ret);
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

