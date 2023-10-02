Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5A0E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ABA87179;
	Mon,  2 Oct 2023 03:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fypf+DDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBD886CBB; Mon,  2 Oct 2023 03:14:24 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361FD8710F
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3515aad4a87so26283515ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209247; x=1696814047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSJ93MQgfr7/ZrFugxlQwVAHiuKEV/TjXzjwCvqA+is=;
 b=fypf+DDPkCFyt4McUJ+g1oUTLv2rUzxvNjVNG0O9HudLJOuf/W8VyNfytSvwAdoF2I
 Y16a+OgCvxP1Gc3gNPsoWOBVKeDIX4pOHEkTojOIxEKiinYl79ew9LylAhLIrD0zIJVE
 NP3GqMtYDp4n+yWIKr9InOcdx0zSGAcrmHj3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209247; x=1696814047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSJ93MQgfr7/ZrFugxlQwVAHiuKEV/TjXzjwCvqA+is=;
 b=p3pCLDr3CP5MLhr11F2eM0Fxp7yYcQt02rLq4EqDja3iIho2CMRLjBkGnXgImXtN8z
 pnlOqR+NxR/PUAWMbcbUgm38DuOWQ/Xa14RW5lV+WWbyVWs8TrFjK5A6MhqUL4psRiTA
 51UjwxJCO7J73tf0aLFk3Ss3ZJGbRtv9ohPFoUECKSZwm04DridXd3BXEBVRnmUOqKfO
 p9JSrJvIh5IrlJjVwr3NjBOMfLAvwjWOmJHbGTfRRw73cXjreZhd9Jkrzow3xKNl7akL
 kw8v4XObaoMqvf5xFEYSUeLkjD4UPlW41KIFeC0fCxV0i0fElWG65dRwayymT/0MTCO5
 FV1g==
X-Gm-Message-State: AOJu0Yzv9jxK6nyV8MTQ2IBNvdIxYIil4+n3eQLTs9hukq6oEVAh3MfM
 KlOemS8XC554cCt7igEGkqbtrXVz3rDIT6aA1yM=
X-Google-Smtp-Source: AGHT+IHYi/x2Bz08L0vfQnA/0sbsS+zbS8ZWULsVQdPmyG7pQyZLrK5KZ91weedEgBeSxDhl31vPLQ==
X-Received: by 2002:a92:c248:0:b0:34b:ba9b:c764 with SMTP id
 k8-20020a92c248000000b0034bba9bc764mr12867603ilo.18.1696209246717; 
 Sun, 01 Oct 2023 18:14:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 16/36] video: Export vidconsole_entry_start()
Date: Sun,  1 Oct 2023 19:13:20 -0600
Message-ID: <20231002011349.461284-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

At present this is called only when a newline is detected, since this
indicates the start of a line of text being entered.

Export this function so it can be used by expo, which may start a new
text line itself, without first writing out a newline.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/vidconsole-uclass.c | 2 +-
 include/video_console.h           | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 07427ba346b0..2f3f685a55c9 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -48,7 +48,7 @@ int vidconsole_set_row(struct udevice *dev, uint row, int clr)
 	return ops->set_row(dev, row, clr);
 }
 
-static int vidconsole_entry_start(struct udevice *dev)
+int vidconsole_entry_start(struct udevice *dev)
 {
 	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
 
diff --git a/include/video_console.h b/include/video_console.h
index 28d65451889a..87f9a588575d 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -399,6 +399,15 @@ int vidconsole_move_rows(struct udevice *dev, uint rowdst, uint rowsrc,
  */
 int vidconsole_set_row(struct udevice *dev, uint row, int clr);
 
+/**
+ * vidconsole_entry_start() - Set the start position of a vidconsole line
+ *
+ * Marks the current cursor position as the start of a line
+ *
+ * @dev:	Device to adjust
+ */
+int vidconsole_entry_start(struct udevice *dev);
+
 /**
  * vidconsole_put_char() - Output a character to the current console position
  *
-- 
2.42.0.582.g8ccd20d70d-goog

