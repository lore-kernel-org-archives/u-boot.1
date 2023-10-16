Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F0BCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59CC186DE6;
	Tue, 17 Oct 2023 00:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EFff+npp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0DF803AE; Tue, 17 Oct 2023 00:32:01 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EAD86F2D
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77063481352so515130585a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495491; x=1698100291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRJze8gIw4hCic8YfZI8lr5I4nBlA2/69lBmFD6Cx8w=;
 b=EFff+nppkVxX8N9IQJnNW5fH3zmzFcxv22PbBJ5BgjdGBpQqmrzRKOI2WCqLyrzkTG
 BNPlX2mfc2PuJAP+cgat73pri17th8dj0Z18XJDYWbIhm3DJAX67w0fUDxL/QLvN01SB
 XH3GB1mC6gwr3yTiZdGhK5vnf3Fxg3nekKB8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495491; x=1698100291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRJze8gIw4hCic8YfZI8lr5I4nBlA2/69lBmFD6Cx8w=;
 b=G0KZvBhlx8/iazy1saVQFIjXUKlZ6HAyH2DuUoNwo4wQp89u0zK14tnHuIVXmtkrbP
 JFJalq6cPf3xutDXEahOAAYejoV48YFph2emUM+VHViaBaDZo+2pZ2ofYwCVxhs6zjca
 U1R2pOVccthZwbMzO6xsBnlDoOtmF8iMwND8OhtN9Tb9kUPF5cARVZs8bKiY8HDA/Iqq
 Sg6eJGskm5ZN1Z6c3J22zmcDMjTGJiIEtaumpi7kS0qPmYNud+n06O2w/AMeUGD4wz9+
 Jc4fa4Lhe7v55O23Gd1Cg19/xeHrkcEAnCAuf2vSv9SrVRMRRzIJTW0rjlRf70x+yNPq
 o+RA==
X-Gm-Message-State: AOJu0YyjTLnrQ2y7AUqvKVyI/SBYcWoE4fyPajkqZUwFVVj89h+Ho3UE
 D4tSGLV+wStAav8+Sgub0BeuYja4fpCKpBpKK0W6+w==
X-Google-Smtp-Source: AGHT+IGgptgfo+BtKGAxDp3CJmnZSeLTFWg79zWCaICdNq0EVQ8dRDuUxg3/8/LJiERxupIjzUoIAA==
X-Received: by 2002:a05:620a:1aa0:b0:774:21d8:b0bb with SMTP id
 bl32-20020a05620a1aa000b0077421d8b0bbmr179903qkb.24.1697495491116; 
 Mon, 16 Oct 2023 15:31:31 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 19/32] video: Dont require the font command
Date: Mon, 16 Oct 2023 16:28:10 -0600
Message-ID: <20231016222835.596572-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

While it is nice to have the font command, using 'select' makes it
impossible to build the console code without it. Change this to use
'imply' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab927641bb7a..21ea5c860cca 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -180,7 +180,7 @@ config CONSOLE_ROTATION
 
 config CONSOLE_TRUETYPE
 	bool "Support a console that uses TrueType fonts"
-	select CMD_SELECT_FONT
+	imply CMD_SELECT_FONT
 	help
 	  TrueTrype fonts can provide outline-drawing capability rather than
 	  needing to provide a bitmap for each font and size that is needed.
-- 
2.42.0.655.g421f12c284-goog

