Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19907C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE1482786;
	Fri, 28 Mar 2025 14:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fW6ux2+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8021B82169; Fri, 28 Mar 2025 14:08:58 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FCF827A6
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so160150039f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167334; x=1743772134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrPE5XTL5ZXpPOqknaoJpZtckGEFgl051uI7qQDaZKk=;
 b=fW6ux2+0zSM1/ClsPD2pPUeuC81+YEmfX9835P+UXPfSPYB4LxaZ1mez2XK6QGYonh
 WdQ2e4m+nViCsg7sAcnJwRubHJWfuD5DcBsM9Chh2DWq4d3Ou8AZEKAweSqY5DOeo1ze
 P65hf0QAMmyVBkzMA8Pefj/zRDvtcRTtLCYyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167334; x=1743772134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrPE5XTL5ZXpPOqknaoJpZtckGEFgl051uI7qQDaZKk=;
 b=ibnLM6toh0mZnP5FanRdIyzpZPUnBP11d477lJGXwU2+D8gdVnNO8aMhgV8F7gAKEh
 c65GWRmszSD4x2YMt3EdjGtDobMrgtMgnHUH6QxGtHv553+fIHhsu1nCJp9bAF/IVE3o
 8O9i9A9k60euVdFd+WBCzGcPak8oB5QpIgZJIsLAn1O/aNu6/w3e7iY1VxM14TNgys72
 eUOU+vJGfdSplGkNAF9XuVE3seNog014G3b51Z8A6uT3qtoRTBlDHncENrUJTBY4j15S
 qBxTneLy+G+37/8ejEyIGX39H6cne0liuq9S2wlElFNrl4JyX0vA2S8cQ1vuiOGti4m4
 /Weg==
X-Gm-Message-State: AOJu0YzajqPIY2DmH5zdMH5hNOLib/GPpyhAunuPp2382+eKP0FPw1ET
 d5IvNzEh58Oe7kfoCXQS8DTFzaJmxbdzKBVyygVFGbTQUhiNFoAeHTpr52UAiseru0WaH99o6wQ
 =
X-Gm-Gg: ASbGncv3dLOfqV2uSyLF+M7jUY6bX05WBdhXn2yYfl8JEXRCWjhFW0lYvE/4OxNHjpM
 L+JTx/SHMbmebpj5mU/3TcGKtCl55aoyx/QyEwCeuQztyqOL/Bx53kF9fI0DafRIiaphIlpT/Ft
 ccUZiZqhcvo4wJl96xclJL1uyZE+46/UhhZCqLy2lHmEoKdT5gPfxpDFjF0N5kn65DPIEurhVOS
 1S/9C+VZzNAW0bpa8RlPgoWLyb1Vu2Ypbh5Gcv36KV5A9KBEv6bgHdC1+4mZjCPCCEBBYvMCm9i
 AERasqSPFMbyMsyrA1PSQRzWluenJdkbDRVJ5e96V7adrj7ewBE4d+vn8G3l4cFFz+JtqjlR9V9
 IM1v0hXVSZYq/VBig
X-Google-Smtp-Source: AGHT+IHJd5h/7Vhc+cgliL78eIjYi/qxVl/QiLF/2pcZIQBgmEOjqVoiJ1zMYh21t5H3AL+DYRzf7w==
X-Received: by 2002:a05:6602:4c83:b0:85c:c7f9:9a1c with SMTP id
 ca18e2360f4ac-85e82170983mr899531439f.13.1743167334028; 
 Fri, 28 Mar 2025 06:08:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 51/56] expo: Provide a way to position things relative to
 display
Date: Fri, 28 Mar 2025 07:06:38 -0600
Message-ID: <20250328130713.2612648-52-sjg@chromium.org>
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

It is often necessary to centre objects within the display area. Add a
special position value to indicate this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c   | 5 +++++
 include/expo.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/boot/scene.c b/boot/scene.c
index 15f85c39359..a6f264cceca 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -363,6 +363,11 @@ static void handle_alignment(enum scene_obj_align horiz,
 {
 	int width, height;
 
+	if (bbox->x1 == SCENEOB_DISPLAY_MAX)
+		bbox->x1 = xsize ?: 1280;
+	if (bbox->y1 == SCENEOB_DISPLAY_MAX)
+		bbox->y1 = ysize ?: 1024;
+
 	width = bbox->x1 - bbox->x0;
 	height = bbox->y1 - bbox->y0;
 
diff --git a/include/expo.h b/include/expo.h
index 2addddd5012..4dee479e9a0 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -242,6 +242,12 @@ struct scene_obj_dims {
 	int y;
 };
 
+/* special values for dimensions */
+enum {
+	/* width/height of the display */
+	SCENEOB_DISPLAY_MAX	= 0x7f000000,
+};
+
 /**
  * enum scene_obj_halign - Horizontal alignment of objects
  *
-- 
2.43.0

