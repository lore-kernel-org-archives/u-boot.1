Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4184CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41D186C16;
	Tue, 19 Sep 2023 20:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SZMFEloc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA7286BE1; Tue, 19 Sep 2023 20:09:44 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF2386BF8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-350f43b9c3dso1388705ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146980; x=1695751780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+ygwqwBEwB0rSVC36dZFNMYaYXEIqDfv+96YclH7p0=;
 b=SZMFElocpfV9zt7i8V1XxduYEruwACASumMLTyJztWNeWAM/Iwhu8zTwI6t7yHRGG0
 9B2BZLXYc/BwbPy4duwoDNLOVZuHccrnyGxXDmzc/6mk46yzmk5H+SWfWpXZrrnaPZ6f
 YXOG3r9PAEt3UWspLPrN62boi31DoMbWXbulc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146980; x=1695751780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+ygwqwBEwB0rSVC36dZFNMYaYXEIqDfv+96YclH7p0=;
 b=LLIeCkALRn+6TYzussGNZKfOLqE73D+jA50qNorEiedkumkMPOod0ynp0UvUkxtDjs
 yX+wpjfCOsdwyfnX7dn/+4Ey/8/CVajOdc/bXgroAzhV2k0fw3J7uDCslT7YcCAP82qy
 Dl96W9b7oL/6pRy4GF9HfRsNacRyBhtIv92tI459jytgZeawi6v2b6cwjlxCCEVgAu9l
 vg2Eud1pfdb6j/mkvuMgx7fGbNs+mv5ohhg2LnINV6z9PmnkoI66Ceqw++HIVEn4DU9q
 j0cGRjS4j3sPXOfRJRCE1747gF+LVTW6U+k61NkPBHWC48LQtRKj7ybBEYbuSfKjbAT7
 7qrw==
X-Gm-Message-State: AOJu0Yy7UAKDgR7rmqAbykxmoH2sQWpSokaCML++Mgt6vKoTuJIsO+ax
 zv+FXk32jWoZOctKeMISLH3OAyZhcJRZdu84RyE=
X-Google-Smtp-Source: AGHT+IG8oP8gRbuRFgqe9Qbv4E5iBQfMwDrzWaVJ/XAJ36/W5BQisFoOFVzsgfBWruVjU54eFc8n3w==
X-Received: by 2002:a05:6e02:1c83:b0:350:f0bb:6a42 with SMTP id
 w3-20020a056e021c8300b00350f0bb6a42mr651841ill.29.1695146980657; 
 Tue, 19 Sep 2023 11:09:40 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 16/36] video: Export vidconsole_entry_start()
Date: Tue, 19 Sep 2023 12:08:46 -0600
Message-ID: <20230919180918.2904313-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 drivers/video/vidconsole-uclass.c | 2 +-
 include/video_console.h           | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 07427ba346b..2f3f685a55c 100644
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
index 28d65451889..87f9a588575 100644
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
2.42.0.459.ge4e396fd5e-goog

