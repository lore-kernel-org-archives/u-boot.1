Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07713C561E6
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F5FE6081D;
	Thu,  6 Aug 2026 09:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqXg1yAtYLEP; Thu,  6 Aug 2026 09:27:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80F046080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008445;
	bh=owmXgyyWFQz2oiQaMiBCeBl0BHToMPoPKgFnMgBvzU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S9x/nQygAauVIW/rEcpoYPzuOEtDVOX8bnKCLyVdjsB2GAPDeYCB74OQwdotDAJjr
	 EX29PCp8kMFTORJ2Qu1vgf3ypTgbm1bi+EmXvyW0vHzpXum51VT1aRCgYnOkj26ymV
	 bHljYpSGSzDcYyiAfMLFu8kAIPe3l3qxWkSMBLqBjreLkAxedAS5dbIEPdcPS1+qw2
	 mKSto6osWqWzA8ZAW2JJsKTRMwE4+VE+/YbPLGFEI0o2687QEGwUbgenxavg5HMo/q
	 myh/W5GsdeZfeQRb5dKl2NLsvycHUxqTrRQrLAW7anFiH+vmLrdPZHzXWbIQpdZbRp
	 oWM+nXUOCHpSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80F046080C;
	Thu,  6 Aug 2026 09:27:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91BB4194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8376C80D86
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fsa9KM3aBVvj for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 633D380D7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 633D380D7D
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 633D380D7D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-495437bb891so6712445e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008437; x=1786613237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=owmXgyyWFQz2oiQaMiBCeBl0BHToMPoPKgFnMgBvzU0=;
 b=VMGwpvChKzq5/UynoHQOpmRcEvSvJkRq+60WCo1iW4uLfTiOJDyaDy8z6oB2giLpVJ
 1uvJcpQ2IEDfW0+69KOs+raG1koy/+WijCTm3u78GThqjFhsebGyZZNbXAtmuzngtGcG
 KPTS3JOtQtRbRbSaxbZorKztj+vCy/e9nP9AvQEvY727T7L/9GRl6dtyONad5kreEaJ5
 +GAJ1JU5AHGl1MfKbVOoLx2xkzOt8uJudf6jhwC8UkGzdKwAKwM7fL2eLT04TIikx9qU
 +KkLKt6eBYf/npBH6tU5egPzy50FRF4hw5OoIdOioMZhs9hq4+4RAHKOOku1cm0p5h/h
 sznQ==
X-Gm-Message-State: AOJu0Yxn5bmB52nN1zTH+IHSnCeRpQ9kLXzogX2w8OkamIMfwgYDss9p
 0kN4WFWYT/w1L2AY2C2BifBqZWVZIsUYWSe8FaZJoc6yxEzBF0JS7nEfR/7Nd/3LKlA=
X-Gm-Gg: AR+sD102aNQ/5ZZ444/ILJERPj3Td4ITGYL//zOioOdeq7/OeJLA9Mn8AqBX/d3dbPs
 HQaXsyFk4xQkAphyrMXA8xE4udM23OBFxbRQfT+TU/GoVLyZVSSaeHuixPbdFFIqIzpvFWOOhHt
 wy0+gAdN0fEjZnBADnsMacJad4Wajj+sviVsyX8Tw861kJIzZaCeOIpp7iMVovdCWyfQQ7aR7Hn
 qnYYxCEMqj6Xqe+7IDAdNTkvZ3i+/6RMimvf1reRY1BOtUk6qxuHys9WjGyEEEHkRAHsw89d9sC
 V7W3GUqZTdTJuPdfAdjTOBGko8clYwLfnuaFeVowjXAC8ZMznRQQFBCBz1oSii2m4T+ZijbLIwT
 mVCBdR43cuPOyZOa8L3nKDpq2DFeLxD9ugpPgCz3nVE/gQRZSDqt28Qu9FhA5V79E/265jzkfiv
 a13kC0ngeq08G6HbYgw8iEQPuRhBgI9vI3G4p0UMMmxO5em9r7dRyjFV33o4dO01XwtUYeXnFTK
 C9xh/P3hDt63CRJZL3Uo3jE0scrDu2n/uHSHcsuOBjyTP+MCNtLo7D8wh4q9s/uixPEeSNVV8an
 2ykVn6wOQgTcknQMQoRpSJv5fMZd+g8pmWDEOpgH8T78nA==
X-Received: by 2002:a05:600c:68d2:b0:495:41ea:f6e with SMTP id
 5b1f17b1804b1-49952f24633mr53044675e9.8.1786008437134; 
 Thu, 06 Aug 2026 02:27:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 11:27:10 +0200
Subject: [PATCH 4/6] video: panel: mot-panel: use common
 mipi_dsi_dcs_write_seq macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-4-6b533788d0ac@baylibre.com>
References: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
In-Reply-To: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786008437; x=1786613237;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=owmXgyyWFQz2oiQaMiBCeBl0BHToMPoPKgFnMgBvzU0=;
 b=Mk4ztAMmZofSkHFhLB6mHrdrrV6KSXQD/I5NuAqgcG72DVDuHA45YusjftP1kYLYiA
 GAG8WvAFYWb3xVgpjId/PGLyLUyZDHHnyUqpwRx7KKMeAoQUaK+s46FgY3OgoVkUIHSc
 H6REBIgr9wY91Z2qIW1pqXYw9pHHdjfFoqOKeAErZM5bMcA4dHWnKhhfXATSmTd10mXn
 r4JYLKLbWPLtAeH7Z9+W5fBz2v28e5WgIQKB9NZyTKm4K3d6l2Vzz8I+ZjbW8jK7Il8o
 sK6eQ05aM8K9zIuGZRZD1+76D/jsXhUU1HyH6bscY04QDKtQdlhWU9bkPdxqekLzASSa
 eF+Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Mk4ztAMm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The current driver defines dsi_generic_write_seq as a wrapper around
mipi_dsi_dcs_write_buffer.

Now that mipi_dsi.h defines such macro, we can use the common one.
Note that we use mipi_dsi_dcs_write_seq instead of
mipi_dsi_generic_write_seq to keep the same behaviour.

No functional changes intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mot-panel.c | 140 ++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 74 deletions(-)

diff --git a/drivers/video/mot-panel.c b/drivers/video/mot-panel.c
index a9114957867..ee131133e1f 100644
--- a/drivers/video/mot-panel.c
+++ b/drivers/video/mot-panel.c
@@ -27,14 +27,6 @@ struct mot_panel_priv {
 	struct gpio_desc reset_gpio;
 };
 
-#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static struct display_timing default_timing = {
 	.pixelclock.typ		= 38250000,
 	.hactive.typ		= 540,
@@ -51,7 +43,7 @@ static int mot_es2(struct mipi_dsi_device *dsi)
 {
 	int ret;
 
-	dsi_generic_write_seq(dsi, 0x55, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0x55, 0x01);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -60,45 +52,45 @@ static int mot_es2(struct mipi_dsi_device *dsi)
 	}
 	mdelay(120);
 
-	dsi_generic_write_seq(dsi, 0xf4, 0x00, 0xbb, 0x46, 0x53, 0x0c, 0x49,
-			      0x74, 0x29, 0x12, 0x15, 0x2f, 0x2f, 0x04);
-	dsi_generic_write_seq(dsi, 0xf8, 0x4b, 0x04, 0x10, 0x1a, 0x2c, 0x2c,
-			      0x2c, 0x2c, 0x14, 0x12);
+	mipi_dsi_dcs_write_seq(dsi, 0xf4, 0x00, 0xbb, 0x46, 0x53, 0x0c, 0x49,
+			       0x74, 0x29, 0x12, 0x15, 0x2f, 0x2f, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xf8, 0x4b, 0x04, 0x10, 0x1a, 0x2c, 0x2c,
+			       0x2c, 0x2c, 0x14, 0x12);
 
-	dsi_generic_write_seq(dsi, 0xb5, 0x03, 0x7f, 0x00, 0x80, 0xc7, 0x00);
-	dsi_generic_write_seq(dsi, 0xb7, 0x66, 0xf6, 0x46, 0x9f, 0x90, 0x99,
-			      0xff, 0x80, 0x6d, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0xb5, 0x03, 0x7f, 0x00, 0x80, 0xc7, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x66, 0xf6, 0x46, 0x9f, 0x90, 0x99,
+			       0xff, 0x80, 0x6d, 0x01);
 
 	/* Gamma R */
-	dsi_generic_write_seq(dsi, 0xf9, 0x04);
-	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x30, 0x12, 0x0e, 0x0c,
-			      0x22, 0x27, 0x31, 0x2e, 0x07, 0x0f);
-	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x30, 0x12, 0x0e, 0x0c,
-			      0x22, 0x27, 0x31, 0x2e, 0x07, 0x0f);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x30, 0x12, 0x0e, 0x0c,
+			       0x22, 0x27, 0x31, 0x2e, 0x07, 0x0f);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x30, 0x12, 0x0e, 0x0c,
+			       0x22, 0x27, 0x31, 0x2e, 0x07, 0x0f);
 
 	/* Gamma G */
-	dsi_generic_write_seq(dsi, 0xf9, 0x02);
-	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x37, 0x15, 0x15, 0x11,
-			      0x1f, 0x25, 0x2d, 0x2a, 0x05, 0x0f);
-	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x37, 0x15, 0x15, 0x11,
-			      0x1f, 0x25, 0x2d, 0x2a, 0x05, 0x0f);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x37, 0x15, 0x15, 0x11,
+			       0x1f, 0x25, 0x2d, 0x2a, 0x05, 0x0f);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x37, 0x15, 0x15, 0x11,
+			       0x1f, 0x25, 0x2d, 0x2a, 0x05, 0x0f);
 
 	/* Gamma B */
-	dsi_generic_write_seq(dsi, 0xf9, 0x01);
-	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x3f, 0x16, 0x1f, 0x15,
-			      0x1f, 0x25, 0x2d, 0x2b, 0x06, 0x0b);
-	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x3f, 0x16, 0x1f, 0x15,
-			      0x1f, 0x25, 0x2d, 0x2b, 0x06, 0x0b);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x3f, 0x16, 0x1f, 0x15,
+			       0x1f, 0x25, 0x2d, 0x2b, 0x06, 0x0b);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x3f, 0x16, 0x1f, 0x15,
+			       0x1f, 0x25, 0x2d, 0x2b, 0x06, 0x0b);
 
 	/* Gamma W */
-	dsi_generic_write_seq(dsi, 0xf9, 0x20);
-	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x34, 0x15, 0x1a, 0x11,
-			      0x1f, 0x23, 0x2d, 0x29, 0x02, 0x08);
-	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x34, 0x15, 0x1a, 0x11,
-			      0x1f, 0x23, 0x2d, 0x29, 0x02, 0x08);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x20);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x34, 0x15, 0x1a, 0x11,
+			       0x1f, 0x23, 0x2d, 0x29, 0x02, 0x08);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x34, 0x15, 0x1a, 0x11,
+			       0x1f, 0x23, 0x2d, 0x29, 0x02, 0x08);
 
-	dsi_generic_write_seq(dsi, 0x53, 0x2c);
-	dsi_generic_write_seq(dsi, 0x35, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x2c);
+	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x00);
 
 	return 0;
 }
@@ -107,9 +99,9 @@ static int __maybe_unused mot_es4(struct mipi_dsi_device *dsi)
 {
 	int ret;
 
-	dsi_generic_write_seq(dsi, 0xd2, 0x04, 0x53);
-	dsi_generic_write_seq(dsi, 0xd2, 0x05, 0x53);
-	dsi_generic_write_seq(dsi, 0x55, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0xd2, 0x04, 0x53);
+	mipi_dsi_dcs_write_seq(dsi, 0xd2, 0x05, 0x53);
+	mipi_dsi_dcs_write_seq(dsi, 0x55, 0x01);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -118,45 +110,45 @@ static int __maybe_unused mot_es4(struct mipi_dsi_device *dsi)
 	}
 	mdelay(120);
 
-	dsi_generic_write_seq(dsi, 0xb5, 0x03, 0x7f, 0x0a, 0x80, 0xff, 0x00);
-	dsi_generic_write_seq(dsi, 0xb7, 0x7a, 0xf7, 0x4d, 0x91, 0x90, 0xb3,
-			      0xff, 0x80, 0x6d, 0x01);
-	dsi_generic_write_seq(dsi, 0xf4, 0x00, 0xbb, 0x46, 0x53, 0x0c, 0x49,
-			      0x74, 0x29, 0x12, 0x15, 0x37, 0x37, 0x04);
-	dsi_generic_write_seq(dsi, 0xf8, 0x0a, 0x04, 0x10, 0x2a, 0x35, 0x35,
-			      0x35, 0x35, 0x21, 0x1a);
+	mipi_dsi_dcs_write_seq(dsi, 0xb5, 0x03, 0x7f, 0x0a, 0x80, 0xff, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x7a, 0xf7, 0x4d, 0x91, 0x90, 0xb3,
+			       0xff, 0x80, 0x6d, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0xf4, 0x00, 0xbb, 0x46, 0x53, 0x0c, 0x49,
+			       0x74, 0x29, 0x12, 0x15, 0x37, 0x37, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xf8, 0x0a, 0x04, 0x10, 0x2a, 0x35, 0x35,
+			       0x35, 0x35, 0x21, 0x1a);
 
 	/* Gamma R */
-	dsi_generic_write_seq(dsi, 0xf9, 0x04);
-	dsi_generic_write_seq(dsi, 0xfa, 0x08, 0x1c, 0x1b, 0x0f, 0x0f, 0x0a,
-			      0x1e, 0x22, 0x27, 0x26, 0x07, 0x0d);
-	dsi_generic_write_seq(dsi, 0xfb, 0x08, 0x3c, 0x27, 0x0f, 0x0f, 0x0a,
-			      0x1e, 0x26, 0x31, 0x2f, 0x07, 0x0b);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x08, 0x1c, 0x1b, 0x0f, 0x0f, 0x0a,
+			       0x1e, 0x22, 0x27, 0x26, 0x07, 0x0d);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x08, 0x3c, 0x27, 0x0f, 0x0f, 0x0a,
+			       0x1e, 0x26, 0x31, 0x2f, 0x07, 0x0b);
 
 	/* Gamma G */
-	dsi_generic_write_seq(dsi, 0xf9, 0x02);
-	dsi_generic_write_seq(dsi, 0xfa, 0x30, 0x14, 0x0f, 0x00, 0x06, 0x02,
-			      0x1e, 0x22, 0x27, 0x27, 0x08, 0x10);
-	dsi_generic_write_seq(dsi, 0xfb, 0x30, 0x35, 0x0f, 0x00, 0x0a, 0x02,
-			      0x1c, 0x23, 0x31, 0x2f, 0x08, 0x0e);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x30, 0x14, 0x0f, 0x00, 0x06, 0x02,
+			       0x1e, 0x22, 0x27, 0x27, 0x08, 0x10);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x30, 0x35, 0x0f, 0x00, 0x0a, 0x02,
+			       0x1c, 0x23, 0x31, 0x2f, 0x08, 0x0e);
 
 	/* Gamma B */
-	dsi_generic_write_seq(dsi, 0xf9, 0x01);
-	dsi_generic_write_seq(dsi, 0xfa, 0x12, 0x1b, 0x26, 0x0e, 0x12, 0x0b,
-			      0x1e, 0x22, 0x27, 0x27, 0x06, 0x0c);
-	dsi_generic_write_seq(dsi, 0xfb, 0x12, 0x3b, 0x2c, 0x12, 0x12, 0x0e,
-			      0x1e, 0x26, 0x31, 0x2f, 0x06, 0x0d);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x12, 0x1b, 0x26, 0x0e, 0x12, 0x0b,
+			       0x1e, 0x22, 0x27, 0x27, 0x06, 0x0c);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x12, 0x3b, 0x2c, 0x12, 0x12, 0x0e,
+			       0x1e, 0x26, 0x31, 0x2f, 0x06, 0x0d);
 
 	/* Gamma W */
-	dsi_generic_write_seq(dsi, 0xf9, 0x20);
-	dsi_generic_write_seq(dsi, 0xfa, 0x37, 0x1b, 0x09, 0x01, 0x06, 0x04,
-			      0x19, 0x19, 0x22, 0x24, 0x04, 0x15);
-	dsi_generic_write_seq(dsi, 0xfb, 0x37, 0x3b, 0x17, 0x01, 0x0a, 0x04,
-			      0x19, 0x1d, 0x2c, 0x2c, 0x04, 0x13);
+	mipi_dsi_dcs_write_seq(dsi, 0xf9, 0x20);
+	mipi_dsi_dcs_write_seq(dsi, 0xfa, 0x37, 0x1b, 0x09, 0x01, 0x06, 0x04,
+			       0x19, 0x19, 0x22, 0x24, 0x04, 0x15);
+	mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x37, 0x3b, 0x17, 0x01, 0x0a, 0x04,
+			       0x19, 0x1d, 0x2c, 0x2c, 0x04, 0x13);
 
-	dsi_generic_write_seq(dsi, 0x53, 0x2c);
-	dsi_generic_write_seq(dsi, 0x35, 0x00);
-	dsi_generic_write_seq(dsi, 0xc3, 0x01, 0x4e);
+	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x2c);
+	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xc3, 0x01, 0x4e);
 
 	return 0;
 }
@@ -167,9 +159,9 @@ static int mot_panel_enable_backlight(struct udevice *dev)
 	struct mipi_dsi_device *dsi = plat->device;
 	int ret;
 
-	dsi_generic_write_seq(dsi, 0xf0, 0x5a, 0x5a);
-	dsi_generic_write_seq(dsi, 0xf1, 0x5a, 0x5a);
-	dsi_generic_write_seq(dsi, 0xd0, 0x8e);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq(dsi, 0xf1, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq(dsi, 0xd0, 0x8e);
 
 	ret = mot_es2(dsi);
 	if (ret)

-- 
2.54.0

