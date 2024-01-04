Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1CCC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949388799E;
	Thu,  4 Jan 2024 16:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRaRZK9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C87EA879B0; Thu,  4 Jan 2024 16:10:51 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C6F87994
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3606ad581a5so918285ab.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381047; x=1704985847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adceXGFHmnmuz954gBoxGe3m1Jb9++mO62kVOT4lwho=;
 b=aRaRZK9n+VTES6JbIZrtLy4/+Kjg5ErqlNagTV4adEy4fM+Hcg7LyHYKFSsT3n7Uqx
 xW+j1ePxxa2lDGP2Jdr9IdLkDLp+wNBbUNtc9nB8SSjy8qQsjYMkcuhUApclVYZju/RF
 ksp/7r8xV1CirhZCBsSctMVW4zCQSDP6dXGh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381047; x=1704985847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adceXGFHmnmuz954gBoxGe3m1Jb9++mO62kVOT4lwho=;
 b=BRCA6pDAkkuTbb9O+JrfF+fxghstzJQpr+OhDjM/ItZIdwknCZNptwlqSp4nfrA65C
 vEqOFk+SZSstsXbaucDm6wEjCOeZMC88B6twi3j5wsynTlVnhkDF7ErR0TvteB1JdrDe
 YkUcDbOB1c6w4hkuZj1QsMh+hg9hMmSHc+ZB7jG7sWw2Uc5Vfr6nrAoISm/zTynaPmBO
 WvYSXImFWRGnKxOKijREuIDYlD5HWRz//nW4pzXW09iaPYZ9LfpyiF9/ByJ+dqQeoqXg
 1KYUvfiEfwc0JnENky1nMDhmqzmCb5UOgWwVu/KxiIVF+tDMp3LKrZ9Ncl0sq+99oTAN
 96SQ==
X-Gm-Message-State: AOJu0YxoBNfoIWfDDOUa8m55BMHb4qvWh7ylCc7xEJXHa16PmHg3rcJ/
 nXGRNurlSHeLfbIdsrB3v9yRJlLW5A7a95WyEkG2hr5NV+90
X-Google-Smtp-Source: AGHT+IE9K0/t82z0Gcmtqq9wcuoJYRpbjmv9hvdt+ugqSs9ThWRs7a/Ddx7Ql9m0Sbuxt03eJrtwdw==
X-Received: by 2002:a5e:de0a:0:b0:7b7:fe53:ebdb with SMTP id
 e10-20020a5ede0a000000b007b7fe53ebdbmr749145iok.32.1704381047738; 
 Thu, 04 Jan 2024 07:10:47 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v6 2/7] video: Correct setting of cursor position
Date: Thu,  4 Jan 2024 08:10:37 -0700
Message-Id: <20240104151042.695717-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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
index 22d55df71f6..a312a198524 100644
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
2.34.1

