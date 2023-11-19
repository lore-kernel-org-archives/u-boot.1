Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688ABC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFDD874EB;
	Sun, 19 Nov 2023 20:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IlFqR5ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4819E874EA; Sun, 19 Nov 2023 20:12:32 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF55874DB
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-359398abeb5so12484335ab.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421137; x=1701025937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5z0QQEfPP9ZJpcAvRSXipOwkAatAMBPWEYRURt9T1o=;
 b=IlFqR5owmm9aFKHMdLg+858bWkRWa0+bYW/oxn+JUuQm2ogpHN2ymmM4CmEzVQ+3Rs
 WADQ0zcjot3IMDzDaR9GWZIs+vlkGY1m4Bfxb93+qGORydL/rxBtay1Se1qBA+cdnFei
 oq+OrDy9LeoIxIXbg8Cy93LhfyvyF6X7UfSIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421137; x=1701025937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5z0QQEfPP9ZJpcAvRSXipOwkAatAMBPWEYRURt9T1o=;
 b=oi0FI0EBIBMJYCeOuQmjGWJ6Xq+EF5ZAoWnzcvaN0flYkXOjsuQ0QFl0lODTPnxICF
 9ddc5r/1y0XLwnIwGF2rekcXIA+hogIt3tVGpzEUcdqZ7+NUTt0CSMeDilGaOxMyjEYm
 QGjdTmzIOXtFKoARs1FDNMt5rZNX87nPCciYWYqLopAR53mFTWRz7Qg6Pd+xn5sjC3FM
 NbjDPPqJsp3eEtDqFPqU074iPyplbet33HI7Psxp8poyvy0dL8HwCdp58Nies78Q9efS
 qOEfV+Bqy8YDUPG5w9fcEO/zG9hGQ10KBSj0Uk8C4fe/4+tJQ70cGZS7eYmKn9ZDqvi6
 FKCQ==
X-Gm-Message-State: AOJu0YwJk31ohAgzNZWj/B7/Fa6udmfsOrOS8Na7FC9v0dbZY45fEyV/
 dBfCsjipZPRB4FXiuXm2GpyoZwzSMCZKPHjWA/oKig==
X-Google-Smtp-Source: AGHT+IF6wI5xv3OA337Ik4Q/c/bSfNsYy595Lov3dsJigFMpFygkCPEVdfzHCGhg+lOPK2ZqsEvaKQ==
X-Received: by 2002:a92:de48:0:b0:35a:fa8e:54e2 with SMTP id
 e8-20020a92de48000000b0035afa8e54e2mr4178157ilr.0.1700421136808; 
 Sun, 19 Nov 2023 11:12:16 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v5 07/12] video: Correct setting of cursor position
Date: Sun, 19 Nov 2023 12:11:42 -0700
Message-ID: <20231119191202.667180-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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
Reviewed-by: Anatolij Gustschin <agust@denx.de>
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
2.43.0.rc0.421.g78406f8d94-goog

