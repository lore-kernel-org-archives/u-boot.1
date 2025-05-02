Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE96C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDF582ACB;
	Fri,  2 May 2025 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J+KNFWGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE9948214F; Fri,  2 May 2025 16:49:04 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A96F982B39
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85df99da233so217315039f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197340; x=1746802140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tPj8ubYWw0pSaOi3zuotndXDjO07FArd9Fm9C59GYE=;
 b=J+KNFWGWe7SAGZ5kAk8a24WFFa3RZy/uMIN9OOuvbqb5XcvmkslHLK153EXSlZ3qkH
 Qrk6Pd3drcpUiRS1Tt8iICFK8UGAJFe4+byZIxVzTbLK/Oi3Vm/L6xlb7Yv9xmrRdhz+
 j/V2bvYQEj+KqUi4BSmXHne15eeNjSWJwD+k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197340; x=1746802140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tPj8ubYWw0pSaOi3zuotndXDjO07FArd9Fm9C59GYE=;
 b=AcFoeUFBUHOkBgyHrRg5U2MzSJLAiWj7mnj8D+GfoIcONzjdAtUTIxXfLCEPdIY/TK
 jwagD7Z7+nPSn4OhmzJLkoX97nZAbAchNkFjaj8egN4obyWBPOqtas5JZTrU1VbWqUo8
 KLVdrkLqx/eIXpynTArR3+iHWROLIGpCfomr+gyXaI1qHgqHd3VjYaOK3lYXre/N5F97
 VRPnD7qq/n1VH9fRdLIZf1LKmd9M9tJugoMShddo/9f/x1zEXVdwglRj1AcP0CNTpNm4
 4aX+A3UzfkKA9+/hlEmWccBBf/BOj53sZCkNdJURaY/RmNsGsRrH/oFcnYIiG6mPTYTt
 Z5ZA==
X-Gm-Message-State: AOJu0YxZFBeJnvUP1frMB97q+Qrxczmy/4Bsoghw9nxa5PWNQfbrNpP/
 6JDvTOu96Wjc0rP/2iX1GBXNxBz2/FFPaIKQvLdmy+S1rWFgk/jy8k+vVzBQR8SB+cMQeVwgViE
 =
X-Gm-Gg: ASbGnctEKxkAZmRZHQcMfPIKqZKcOM2kWk3O2zVTLWU8njmlv5djLPrV0PzD4vNGbDI
 gX1z1VRMDCIGcPGt7DhCAB/eajbL8wd5L3B530EuNabhDN+C0dCqnux+cAvQNZKUPTXx8bXabif
 Z6F8qf8CREdYwy9XKmF5K7Y4BSnZo/bD3sbofklTfTXvwXzzA00kVUNpa/w0RtLrTlvtREmPPJL
 cBSiYyV0T67BXRJV6cqddXxksa0zF4cN63cP9SWodoaawusdrGGPmRoEABj5I8e1w8PAM/knfMx
 LsrrUZk+Dp0in9AdiijXHCIQR7jFk0JBPch9cATclU0VqRH44xh9ojQQbtmD5kBF7DZ2aw6Bm48
 x7w==
X-Google-Smtp-Source: AGHT+IEr/+5KdPeLKowykzHi059nLuAj9AUFNfv+QXv2le+tZ1lW4FxlBMTHM/VHKdE5yatXrZZa7Q==
X-Received: by 2002:a05:6602:c88:b0:864:ad44:e606 with SMTP id
 ca18e2360f4ac-8668c26072fmr454563739f.0.1746197340706; 
 Fri, 02 May 2025 07:49:00 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 49/60] expo: Use a simpler name for USB media
Date: Fri,  2 May 2025 08:46:47 -0600
Message-ID: <20250502144718.313633-50-sjg@chromium.org>
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

For USB devices we use the string 'usb_mass_storage' which is a bit
verbose. Use 'USB' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index ab21ed84ffd..7b44b6439b6 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -84,7 +84,9 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 {
 	struct menu_priv *priv = exp->priv;
 	char str[2], *label, *key;
+	struct udevice *media;
 	struct scene *scn;
+	const char *name;
 	uint preview_id;
 	uint scene_id;
 	bool add_gap;
@@ -101,7 +103,14 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 	key = strdup(str);
 	if (!key)
 		return log_msg_ret("key", -ENOMEM);
-	label = strdup(dev_get_parent(bflow->dev)->name);
+
+	media = dev_get_parent(bflow->dev);
+	if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
+		name = "usb";
+	else
+		name = media->name;
+	label = strdup(name);
+
 	if (!label) {
 		free(key);
 		return log_msg_ret("nam", -ENOMEM);
-- 
2.43.0

