Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA0FC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D6B82040;
	Tue,  1 Apr 2025 19:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c7VoSOJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB89817C4; Tue,  1 Apr 2025 19:31:08 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F1582040
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso7403917a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528663; x=1744133463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi3ZukTNiZjVZNKy7fxDWuL6vJQT0GQ4lEaXJTClJwo=;
 b=c7VoSOJqjyv/egCAvZL5p+FRW7+JMKSNLT7cacFMBofhFLnbPBo9JVDVB9Lv31Y3wX
 wc924TZOb+Cu4Y5JorQ1eOeBWHUXTcXM2FWk10Gs9GCDxQzYww6k4PLAQlxPIrdmPZid
 rGN+xf2SCIhDVp/yFaDXiFOZgQ2LuVDd/hSgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528663; x=1744133463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi3ZukTNiZjVZNKy7fxDWuL6vJQT0GQ4lEaXJTClJwo=;
 b=rvJnqe3u6xozqFujWMu5Hi/aKcErxrEDCUkFyGlfpDk5WciS4rSjynbiVQm9aW2pIj
 yCoeyCHdWnNPEKEEfgAQCL7TC/VEoZCyWteGJ9pT8aDt3/RO6/+mIfDxmacL4hwrdtJa
 WRXmD9v6/Si9DKZVmvQg7/Ro/E3bv2LVJ0qaN8HgHYBWTpxLxy5zeOPKaZaVp0bG8OOq
 zmesXqnUw5PNG8IMno/f8WVvzFDJcw3OJ10Xx6W+MpoLDS8CIPONt1SlwEBDXSEAjFD1
 Wh1pSmEWoDeuhggv5+ZgCxUo/VqF6xKTTRh+PZ4bvlzXnKeIi89xHB9SJWAqBbfQr2GL
 1cUA==
X-Gm-Message-State: AOJu0YzZcs/fffFDTWgP+TYsA4ehYcz1vMQ5M/qkLIE1Nfgz11czvY9j
 sVtI4A1nU60mKhwde4kyX+GgEcsxLRWA2Fuow4Iv7mO8/3cyJJQDKgoqKKgwaw8zbHI85SMrxtz
 rFw==
X-Gm-Gg: ASbGncslduO70Bq+xCIsFHi1eLP8p0jfXTg3QBgtqjqIAcKUqTaSMq2FmL9lWwdSfar
 Ng/kFtFkCX3Jq4QXpzGVGH5aJgPt7FFqS0p00Lbd5OSAkzA3Azfg40S+PxTcOo3dU5dZnn/ECaZ
 Q6kJAERdbXMPBZlpnTuXkE4uVy040cF6Yb0EeL5OEqqnZY05VQRIyEguUp4jQDsaITBGNt9lsf2
 6kvAOU0nwEeBor25s9HgQ3UFvbWJbwow+d3ivWvzI9nZh6LYTDLK67GYpR2KR9WF3IpLCJsRpo7
 /NXrjAxCi60WUp4tUM0MabIL2lvVqpPG9X3zszRk+cmjVc6MRhD4EA==
X-Google-Smtp-Source: AGHT+IG3d5feYMIi2Al2+AHiLOUs3cJLVui88BCKDTWTTaH6HHDFZhszdzAbO/IPBvsql3CfL0nCWw==
X-Received: by 2002:a17:90b:3e88:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-3053215d1a0mr20003982a91.29.1743528663626; 
 Tue, 01 Apr 2025 10:31:03 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:31:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] vidconsole: Avoid kerning against an unrelated character
Date: Wed,  2 Apr 2025 06:29:44 +1300
Message-ID: <20250401172948.1236000-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

When the cursor position changes, kerning should not be used for the
next character, since it can make the first displayed character shuffle
left or right a bit.

Clear the kern character when setting the position.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c  | 2 ++
 drivers/video/vidconsole-uclass.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 2e3e6f07112..6d2c2c2e177 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -490,10 +490,12 @@ static int console_truetype_backspace(struct udevice *dev)
 
 static int console_truetype_entry_start(struct udevice *dev)
 {
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
 	struct console_tt_priv *priv = dev_get_priv(dev);
 
 	/* A new input line has start, so clear our history */
 	priv->pos_ptr = 0;
+	vc_priv->last_ch = 0;
 
 	return 0;
 }
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 6ba62ec348e..f1b2d61bd8f 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -127,6 +127,9 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
 	priv->xcur_frac = VID_TO_POS(x);
 	priv->xstart_frac = priv->xcur_frac;
 	priv->ycur = y;
+
+	/* make sure not to kern against the previous character */
+	priv->last_ch = 0;
 	vidconsole_entry_start(dev);
 }
 
-- 
2.43.0

