Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD16D68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B9289712;
	Sat, 16 Nov 2024 00:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kZ40H9jX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE3A89718; Sat, 16 Nov 2024 00:20:18 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5058971F
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a6e960fb5dso628455ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712814; x=1732317614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stuNeKu7DoFdEF3fkuyWmMB4QNePjuoJ+3xKMPh3/Gs=;
 b=kZ40H9jXn1lwfyR+dKz01YEcmWkNo+d5qaU6cF6TiyVuy4Jm6IfEqDukDZ+Srrx0J+
 47y2KrrEBvKIiIQtBsJztCe5/R598yQDcrESC8eqi0Eg9OY3kiZAVcENCAg64PDd1XCm
 rM6lrF4GCLuK8RyPV9yLqqxz1rrTnT5k0ikGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712814; x=1732317614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stuNeKu7DoFdEF3fkuyWmMB4QNePjuoJ+3xKMPh3/Gs=;
 b=swSgiRruEPmFt1gBYB9BPY6ZimlzqSB06NVvwKccVU+C4OPRmQy9s/5rJClnCP3lOO
 DBiBNpCwP6KUA2AFMYvHMAK9zFWAG7FxPUUjpnYFTUxLE2pbGELLsSljZORLzv1c1TEx
 /YksLXbA10o268k8/utPfMGd3TSviozXZ8BFulNxr6EFVW+gh8eCiEZNLKUHezyNmlOm
 0dG6ixR0lJpsk10xUih5POq/Tea4HXXAaBe4ga+VlylmKfW0YGPED1gA60PMZHoFRukb
 KeDzY5Q/swGSwyjur2fy7SB9GlJF5vCg9g/QiDIep9mj5jnG2tDlUs66FpOEYiC23tMN
 ddZQ==
X-Gm-Message-State: AOJu0YzPG0PTZkZEzEaLYKu5I5AWTV45xuT/xbx2MYc92sMei8jYL+VJ
 uNfJ7YmLwDongQLUKSzTNy3Asv15MWYkutEJqGPynzh/O3MNN881i2Xtj2SjUwjqQKNodRt61p0
 =
X-Google-Smtp-Source: AGHT+IG2g/2l/OSTaTM4IOSDixali8DvDLHsveYzsL3+hoJcr/GUhZajyWnftWZZ0Bd1Z8HZe7DN9g==
X-Received: by 2002:a05:6e02:388e:b0:3a7:1f70:ddd9 with SMTP id
 e9e14a558f8ab-3a748023285mr45891185ab.10.1731712813874; 
 Fri, 15 Nov 2024 15:20:13 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 15/19] bootstd: Update cros bootmeth to record images
Date: Fri, 15 Nov 2024 16:19:22 -0700
Message-Id: <20241115231926.211999-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use the helper function

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth_cros.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 1825293d93d..c7b862e512a 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -243,8 +243,17 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 	ret = copy_cmdline(map_sysmem(cmdline, 0), uuid, &bflow->cmdline);
 	if (ret)
 		return log_msg_ret("cmd", ret);
+
+	if (!bootflow_img_add(bflow, "setup",
+			      (enum bootflow_img_t)IH_TYPE_X86_SETUP,
+			      setup, 0x3000))
+		return log_msg_ret("cri", -ENOMEM);
+
 	bflow->x86_setup = map_sysmem(setup, 0);
 
+	if (!bootflow_img_add(bflow, "cmdline", BFI_CMDLINE, cmdline, 0x1000))
+		return log_msg_ret("crc", -ENOMEM);
+
 	return 0;
 }
 
@@ -306,6 +315,11 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	}
 	priv->info_buf = buf;
 
+	if (!bootflow_img_add(bflow, "kernel",
+			      (enum bootflow_img_t)IH_TYPE_KERNEL, 0,
+			      priv->body_size))
+		return log_msg_ret("crk", -ENOMEM);
+
 	return 0;
 }
 
-- 
2.34.1

