Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA3E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0DD8714B;
	Mon,  2 Oct 2023 03:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DXjTo+ab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9E5870BD; Mon,  2 Oct 2023 03:15:52 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E045E87123
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3528bc102adso1070665ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209301; x=1696814101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnHvuCVnvTEsZt9EaHu41KOjUCgRYw2+M/aYEesWs/g=;
 b=DXjTo+abGdUi6E/GjmtUAppzM9raBvrh2U0ExvlHFybVZIJ83so4KHmTA8HLXF4kB2
 ZCT24/mRK83IFST/EvTUAplbNwmSJvSHkf0kCY7+3dBA993H8sXqygI1tnb91KL3o7Y1
 bn/+p5wJLhUyNwqREGCOjiXc0g3vLUC79uW6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209301; x=1696814101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnHvuCVnvTEsZt9EaHu41KOjUCgRYw2+M/aYEesWs/g=;
 b=U4QI/8eDfvQ47OxDQZicWowb5i7JCDobWf0rKq+o4JHKlyVEyAemMgVOcDkc+nFKjr
 jB5Bube7BqSvpI6p8KNmfjd3ByJlH6AJoe+3gzwWQ0/ZSFNL7s+DNTaGBjKKmZJHoX7R
 tEIwRFna1Fp6Z/D0Dh6Cv9dRTzuaIISLBsua/6EVcIb98cNjw5zJRxRShVUKSCk25kL8
 DI2GFgLOxgdIGVaWN8ELH8qqkNndBz3K5lMKBk6bb3GKWsoMy9gkNTFgvhvmXc5dApbx
 3QtX/ZNEgkEypchNV5j7py8d9uRE2Z5D//mC+tO17SITjOIdUqrQewfwfwzC4lcmruDU
 bkOQ==
X-Gm-Message-State: AOJu0Yx8m//g6EiR0e4oP3sphCVCAEoWxo6vJSPYwlUxEcCGpc7WeY8y
 l6/WdTGMbTdCw4hz13RsUIG6/mOAxr5OYCxSmRE=
X-Google-Smtp-Source: AGHT+IEyQ/mONRHnf0ek9ck29pip09ZkF9D3ad4cSZMQUwqhcDOR4QhivLUKwIDfZbfzzbp5NJXECw==
X-Received: by 2002:a05:6e02:ca4:b0:350:f442:9a4d with SMTP id
 4-20020a056e020ca400b00350f4429a4dmr9424625ilg.28.1696209301051; 
 Sun, 01 Oct 2023 18:15:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:15:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 07/12] video: Correct setting of cursor position
Date: Sun,  1 Oct 2023 19:14:42 -0600
Message-ID: <20231002011450.462468-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

The ANSI codes are not correctly handled at present, in that the
requested X position is added to the current one.

Correct this and also call vidconsole_entry_start() to start a new text
line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/vidconsole-uclass.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 22d55df71f63..a312a1985242 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -125,6 +125,7 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
 	priv->xcur_frac = VID_TO_POS(x);
 	priv->xstart_frac = priv->xcur_frac;
 	priv->ycur = y;
+	vidconsole_entry_start(dev);
 }
 
 /**
@@ -134,8 +135,10 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
  * @row:	new row
  * @col:	new column
  */
-static void set_cursor_position(struct vidconsole_priv *priv, int row, int col)
+static void set_cursor_position(struct udevice *dev, int row, int col)
 {
+	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
+
 	/*
 	 * Ensure we stay in the bounds of the screen.
 	 */
@@ -144,9 +147,7 @@ static void set_cursor_position(struct vidconsole_priv *priv, int row, int col)
 	if (col >= priv->cols)
 		col = priv->cols - 1;
 
-	priv->ycur = row * priv->y_charsize;
-	priv->xcur_frac = priv->xstart_frac +
-			  VID_TO_POS(col * priv->x_charsize);
+	vidconsole_position_cursor(dev, col, row);
 }
 
 /**
@@ -193,7 +194,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
 			int row = priv->row_saved;
 			int col = priv->col_saved;
 
-			set_cursor_position(priv, row, col);
+			set_cursor_position(dev, row, col);
 			priv->escape = 0;
 			return;
 		}
@@ -255,7 +256,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
 		if (row < 0)
 			row = 0;
 		/* Right and bottom overflows are handled in the callee. */
-		set_cursor_position(priv, row, col);
+		set_cursor_position(dev, row, col);
 		break;
 	}
 	case 'H':
@@ -279,7 +280,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
 		if (col)
 			--col;
 
-		set_cursor_position(priv, row, col);
+		set_cursor_position(dev, row, col);
 
 		break;
 	}
-- 
2.42.0.582.g8ccd20d70d-goog

