Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CDCCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D22C8744D;
	Thu, 19 Oct 2023 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n6FBVJRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 850B08743F; Thu, 19 Oct 2023 17:01:21 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2D587259
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7c93507d5so96519967b3.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727675; x=1698332475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10k3CyKXIT1Wx48gbCHpjwVz1f4wpfSj6DXHa0ce1kU=;
 b=n6FBVJRT/FNSxyYCu5BeR/KSZKRRBLRZp9/9FOlHlbe6nlLGnsD/ufmTJ0KrXtH4qn
 tAUQZHTr0JFMkBN6FWbXmf+QkrlhbN4a7CattTkVdZJLtF26Q1WQ65XPW4R7IjTB7T9t
 xM5W10Ten3rFg74y4eYX2E/U5SV2EEafBfHo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727675; x=1698332475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10k3CyKXIT1Wx48gbCHpjwVz1f4wpfSj6DXHa0ce1kU=;
 b=oLah5e0N4m+5012y93adqZTYxi4VrYP5HcA1J+m6aPSE3GqKXAf7eD8onDrJmM4M6V
 BeEvuZkpX8A0ZrctRbTHBS+zSSJVM9AVOnZZvhfMiLRe4ESgt6qgik/ifUYVp68h0Smd
 BXbIVrmgyKCwzkVPV6CY9oM3vabxoGtGHAKlmPyf/MuQROdVspzCaW/Rc4Jo2284ZCu3
 A2GV/B1CrB/bHoxp2NfEBRmRAspmPwmGn01xuOgbCJcf6JasISL3bDFg/QdYwMl36j3W
 DYQZmx1zgLIr5OuCUQl0HDG1sUbAq2e6g5Yq0+XciVXp01RNGu7/mQQPpH9gpiZ6PU0W
 CfsA==
X-Gm-Message-State: AOJu0YzKHOrspBsfLdtPTdOZKAPcmAuy5rtPp81+0U+28I7r80M0Yfbg
 8XvQsY9fMcckzmh4bde0h03DG3J5IFaJ7yerpqdA+w==
X-Google-Smtp-Source: AGHT+IH/I2b+YeGhUTMt1eWL5EzfYiNb2QVyIX55eVfsacyK78pCQtZUhBzx1+uVcADV5+4NOR7l1w==
X-Received: by 2002:a0d:e2c9:0:b0:5a7:acae:3bb0 with SMTP id
 l192-20020a0de2c9000000b005a7acae3bb0mr2547266ywe.5.1697727675207; 
 Thu, 19 Oct 2023 08:01:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 09/24] video: Don't require the font command
Date: Thu, 19 Oct 2023 11:00:50 -0400
Message-Id: <20231019150105.714407-9-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

While it is nice to have the font command, using 'select' makes it
impossible to build the console code without it. Stop using 'select' and
make it default if CONSOLE_TRUETYPE is enabled when asking the command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v4:
- Rework to have the command itself be default y if CONSOLE_TRUETYPE
  instead of selecting it. (Tom)
---
 cmd/Kconfig           | 2 +-
 drivers/video/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ecf25b062ad6..16e5cb8f0633 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2340,7 +2340,7 @@ config CMD_VIDCONSOLE
 config CMD_SELECT_FONT
 	bool "select font size"
 	depends on VIDEO
-	default n
+	default y if CONSOLE_TRUETYPE
 	help
 	  Enabling this will provide 'font' command.
 	  Allows font selection at runtime.
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab927641bb7a..6f319ba0d544 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -180,7 +180,6 @@ config CONSOLE_ROTATION
 
 config CONSOLE_TRUETYPE
 	bool "Support a console that uses TrueType fonts"
-	select CMD_SELECT_FONT
 	help
 	  TrueTrype fonts can provide outline-drawing capability rather than
 	  needing to provide a bitmap for each font and size that is needed.
-- 
2.34.1

