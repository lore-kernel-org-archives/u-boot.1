Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC88EC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC91986D62;
	Sun, 12 Nov 2023 21:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hTkuy6UE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7885686BF7; Sun, 12 Nov 2023 21:03:15 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A41870F2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so157692539f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819385; x=1700424185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFd6hA7beDzZv3TGDVaa4RewIUGPs/x0L+Qlk9OkJ1o=;
 b=hTkuy6UE36AC09zelIFEvn75i0TMnQhQRB4fl1DJ2jDzgkGMcrPRV8BzPZEneufola
 O17dZGRK233tZU1Sk8zkimaDUT80avpCSh+Rp0AF4H2rHiMnHzDD8bw5oT3czsq0V1mR
 aj0CSfkTwGX/I/BJVFcqZWd7FoXMjy1sMwsCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819385; x=1700424185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFd6hA7beDzZv3TGDVaa4RewIUGPs/x0L+Qlk9OkJ1o=;
 b=ZkkVlihPbUEQnAUfRUHsL83n/zPP2mPz90M2eURpeqpTf6YLy9IkCxOEXZJdVXHYo+
 ifKM4+OdOFUXRbKVN20/g0yxKtK+jgdBhvRQbwXB8IAbbor3rFreaWfV24zbLFjMfkQO
 HYEQ4v5wM3ua4CaXsIeAJXL6w4emstIYeyEgrvSiCuNXMTKEdDJAUv4O91MTbZ8GnfLl
 T38TJzkp1QrIrkMWqUvi4TAVOA7+xYdc5RwUeoSL0fsuyBktLQzB3BowTI15dr4r7flb
 zIWLA8CxXeCieXE6cLh13ngUTNiUkMjGtFS+/b1DCmqBl3+6d5bIKc/8S6y59BjLsxpE
 psVg==
X-Gm-Message-State: AOJu0YzoxPB1toGo3W25fGNYJ3fH/Kvux9dbtma4ChrK7P2UO2F3l/xd
 O/2vCxa3MzgdQ8avYJR6BHhOxG58TyJ9xmwCrTlOYQ==
X-Google-Smtp-Source: AGHT+IG60AzhVD8p3p3edVSUszl24btemdoSF8v67ecHhK5mTtW0RKb3dmfK545MTJMZ6PV5jrTlRA==
X-Received: by 2002:a05:6e02:1b0b:b0:359:4fde:628f with SMTP id
 i11-20020a056e021b0b00b003594fde628fmr6701926ilv.24.1699819385522; 
 Sun, 12 Nov 2023 12:03:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 07/12] video: Correct setting of cursor position
Date: Sun, 12 Nov 2023 13:02:44 -0700
Message-ID: <20231112200255.172351-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

