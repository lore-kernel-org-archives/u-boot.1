Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA2C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18B8826AA;
	Fri, 28 Mar 2025 14:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TROT1N3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571EC828D0; Fri, 28 Mar 2025 14:09:04 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7408281E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85b42db7b69so39008539f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167340; x=1743772140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NaG42BSonjimE+65rn2D975CTtpm6O6m6xYALl2pjo=;
 b=TROT1N3qFYdzOPYxK7K7Fj/ruoPlJYJEzqX/oerRjv2/bcBvRrf6W8VRk5gINIFv9M
 VwcDFefvBWCHUiHgdcJg2T3uAyYRCaFCk2YYAdm7H4KrXiOgeQPKa6nFyo6Aw3uwUxo1
 oKIZXQnewc1GHba3JcJd/ly8WJvSniAlso64U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167340; x=1743772140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NaG42BSonjimE+65rn2D975CTtpm6O6m6xYALl2pjo=;
 b=r0nOCUyTWSleU0oDUfQy8VWcl149SFR+nsr9DIWoGECdZCCoWPp2eFvVRohKb7oAwy
 zszxMqD4TqbJ07P5iz03OHiEDOhUeK2zNQTsC02Eo+TC1BnqC3mo7yLHU5s01HrTthmv
 Mx7KmGpjiDpVpO+kyuC6tMrTtbFSijsHuOVo/IdopwEZNfhMTbwtdYqLGAxn6f3SjwcW
 eWUHCOThJTum6P5Uj4C1H4EUKYk54fVrW/0sgQneTWNr9ENKgoRoK/tqiH21orC42uz/
 +PT2U/4iEqDSKlgoEDNXygBm2E8zLIurxmpmF1slqvL3nXAo0mlZIdWRmHKQKdqJh2k+
 9srQ==
X-Gm-Message-State: AOJu0Yyl4lnwc1J1jqjvruYfnoh0BXTQ3AGSrhhnGLxFu8uoUbFC8J7S
 lHtBOExW+ITXRtfoAtLQ/AcuHu/Kz8pX8dxcAWdyGWXzM2IL95JZ+jJOD7avJeTl/8Rt5+YcJLg
 =
X-Gm-Gg: ASbGncstx+BfiJGHt7JLgBZfOWIi9ZRVEJEJP9jbvEFqzp+uxh5DsfCoG+6i4N8kTeF
 C2wCEIk2A3spgfXW0eUqBZUN59wudSltfP28eE/rf/LNV0X9cjyPYCL+n7mkZeKnj7FdtzZTGaQ
 ukl4gDyxQn6EdF+9SeIMhTWPy6BeTXav6qgBoUp/+sBysExn4unV3B1gyRySkEhrmu7QKQUe5IU
 gi+3ntG9oly0yU15FhIdIE/vqVMG6ClVW0pJ4nXn0TeOyfBmjQ6+abNxcC5k8N4ZGtjbssR9gPv
 7uuOrU1RO2RFPmcDhlTbfT1OEm09vfaDpy18wfj0Pzm4nUFWUkw/whwVana9whMhbvuUDyW0jHk
 4l9rtpQ==
X-Google-Smtp-Source: AGHT+IFH3IIB5PcCqtyVj+hQpUIBi5vQxT9va4TeNrQjGkLS1Vfy0a7uI7mXHw2/bvaoGxdFDqn6dg==
X-Received: by 2002:a05:6e02:2165:b0:3d4:36c3:7fe3 with SMTP id
 e9e14a558f8ab-3d5ccdca126mr69409115ab.9.1743167339518; 
 Fri, 28 Mar 2025 06:08:59 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 54/56] expo: Split setting up the menu from adding items
Date: Fri, 28 Mar 2025 07:06:41 -0600
Message-ID: <20250328130713.2612648-55-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

