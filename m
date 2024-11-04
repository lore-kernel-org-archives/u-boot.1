Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0CCD1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78E689021;
	Mon,  4 Nov 2024 18:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCno89xt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131948909B; Mon,  4 Nov 2024 18:51:45 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0189088618
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a6bc0600f9so11414665ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742701; x=1731347501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfQkbG5KsvvdyESx3IO4+JsNy8FNRKJ8osJbY549D3c=;
 b=JCno89xtZX2WNvXmV/P11HCfqRS2yobLDmdx9+mBDO29KOEO8NRe4jObjOqNkTnaZg
 arIfqHU1oGxqUQVgHSzYSQHrjs/5ZnnJFIqcttTBTLTrrx3hzZ57vFCPBzZDnHSGj6W1
 mvyhu/kO+0VnIUyVidU91wub2rbHIH50lFbC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742701; x=1731347501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfQkbG5KsvvdyESx3IO4+JsNy8FNRKJ8osJbY549D3c=;
 b=UBcd+eyaYYfcm+03C/oUyicJUB3GPwNYuVKhKDLGM1HgHlXRl+xhjekQQ//2bNTGNy
 UQAbTpPIkIlKhxZkQ4xwK5dsY1ski+besTS5yC5ZfJvtgXoaTIUWNLKQvur6LNAOM+xr
 8wHwktYoPfaJwbCMkATNE6+Jb93pAhtqEU7jNWMsCbmtoa/memQEk6JJ2hdxb6F2+mT3
 WfiHppceU66YCUdFxcLdR/bUggqnEisu7Z8qMvdpU1ZrIDWdoC5wLdtUg9kuFuVxAyd8
 I6pU+u5OnQIFTRW6WV/TQws4rnHjMSqjrV0HAhe2HSs87cLSl/uSzhD8+m1UwutkQ4i5
 itTQ==
X-Gm-Message-State: AOJu0YwI25ChwSpIHQocXCkWc2Y+Wo/trQu+5u0pIMH2NitVV3Ae4isP
 vlVp9aqxwpF+L9UHiBC87V8xnXwpt1Wz54RwYwYO3LsXl6XUnPRAd6fZFhNdC9DrvzPKRZHmONM
 =
X-Google-Smtp-Source: AGHT+IFiHduMDhWJv+DreMXTxCwlV9TPurvx0j1hIS5++Gbh1+3Wp6WgN4UkFacdAHGa/hCk1ES9Ow==
X-Received: by 2002:a05:6e02:1383:b0:3a4:e99a:cffc with SMTP id
 e9e14a558f8ab-3a5e2512f34mr223700865ab.20.1730742701195; 
 Mon, 04 Nov 2024 09:51:41 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 15/19] bootstd: Update cros bootmeth to record images
Date: Mon,  4 Nov 2024 10:51:06 -0700
Message-Id: <20241104175110.1048449-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

