Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8671C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B764C87DAD;
	Tue, 23 Jan 2024 18:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BB8c8H6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB70687D29; Tue, 23 Jan 2024 18:17:20 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C8087D9B
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cf0390eddbso21745161fa.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030232; x=1706635032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBqxs24A75qIySiG5LZS+FbS3OjiLjbjCzMo+fZTuQs=;
 b=BB8c8H6gQ0F7gfEkRtDKVJBIOfDK5BVfnXYFuDY7+vICNhgiyRYLNBTYkrFioYvOkC
 bQjsWrXl0zkx+iavw+lW0FvbWQtmrnp+sIy7fyQlGQXWVLibxWUufdNqKX3Kb91YLjuZ
 dNUKSCMmC4WG3GMmPN3mW43c4R4tfp5shbwvWX0lxSXYQJ0T61J1n/7n/ELO+LzU0GZ0
 kq/q0DNgEVG4EXuaxgehM3KqTwpf6z7z1CBsMt+sABhczc/hq1fdbNNZuLOxq7MmX3B+
 w1OwNlIQ868QkeBIb3g1XPDysb3sgM4L0nleV/d15fizaaYLsnJcyhbtzdOG9wShDuoT
 4cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030232; x=1706635032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBqxs24A75qIySiG5LZS+FbS3OjiLjbjCzMo+fZTuQs=;
 b=wYWsfSzMYuT+Gb/9K9cAjuh1rvUTGHQ0RGS3mp/hV9+IMideHuyxq5Y8xLBEGqlaaw
 qUtq59hEqcda+bvIwcItFPQCP54OF+7HwWSCkr7e6XojyVX/M7I3L17eEG0r85+HLwKw
 BOzKWk00XLkACGHbL5fbZRjWaMHVx8GEwjKZqJ/PFBjtpY7Y3YB6j9PuTgI9sskHnsir
 S+BZUzZkLMtjVKQfusQWZBtKhiUNvy9etEHaiiS75mnKPoMRDUTxV4eShsrIEX9J4flV
 JIuw0arD35yZazmYz/nVZt9eP/53mgcbVnIOaSQNXMjh68kyfJww0FR+549t5YL8jAr+
 6Kuw==
X-Gm-Message-State: AOJu0Yyytfl0pJ3BVvTj3a6VJo28HbAR1h4HvzY+F0ubw0//x3JPe8/3
 hgbZ4Yi0cCaWdrpKS3VxZ5x+MqPe+yWZgJu6y1eviP1i61kyI7QQP+qpMRFW5I/Csw==
X-Google-Smtp-Source: AGHT+IGhVFgBbD5QUDcBxQcxb9Ga1Z6wxltbDgqndJn/tTWJwl8zm3LPj+H778Hf+n9FPbFlcdfb1w==
X-Received: by 2002:a05:651c:81d:b0:2cd:3e51:8d85 with SMTP id
 r29-20020a05651c081d00b002cd3e518d85mr55672ljb.70.1706030231540; 
 Tue, 23 Jan 2024 09:17:11 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:11 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 11/18] video: tegra20: dc: clean framebuffer memory block
Date: Tue, 23 Jan 2024 19:16:26 +0200
Message-Id: <20240123171633.246057-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Fill the framebuffer memory with zeros to avoid visual glitches.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index ac6833229a..caeec94468 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -4,6 +4,7 @@
  */
 
 #include <backlight.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
@@ -398,6 +399,10 @@ static int tegra_lcd_probe(struct udevice *dev)
 		priv->scdiv = dc_plat->scdiv;
 	}
 
+	/* Clean the framebuffer area */
+	memset((u8 *)plat->base, 0, plat->size);
+	flush_dcache_all();
+
 	if (tegra_display_probe(priv, (void *)plat->base)) {
 		debug("%s: Failed to probe display driver\n", __func__);
 		return -1;
-- 
2.40.1

