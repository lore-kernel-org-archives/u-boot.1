Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB02C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6D986A02;
	Tue, 15 Aug 2023 00:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WdU8y+Ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1116A8662F; Tue, 15 Aug 2023 00:41:36 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08936869A6
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3499936a13eso19523005ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052892; x=1692657692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlXNeIoiPjbmQiyKywOJaJKC2HR578Qecmg+gWenx4Y=;
 b=WdU8y+OlpAD/00xP5h8DleO3lgwZw7MkGWdt+gkwJRuV6YGta+/zie1MLHmJ0xpvtQ
 G3v8eylFrwZ4Z5HrskybyJIMFJLHaDRyxFJdhz85Z2RnHVunP0ysnkk/TwsCgGJB8sn8
 F5ItTHa6FwijBjwKesosDUMjso1mPJphY2Yms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052892; x=1692657692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlXNeIoiPjbmQiyKywOJaJKC2HR578Qecmg+gWenx4Y=;
 b=TI9TyQ6tk0Oi5YLehPQJvmVQICFxbDi1S0iLY+weaXvl9UDg2zFD29bE+55emyjnh7
 n6v33FCLJhYS9hh5Qlrg3w3LONPd8o5FXYbq6BJ49Wn5iiq1gZpK4jdhE1C88lyZRkzb
 DrPaQDogARkUtcsQ8UZTQHVHw8CpM2mtCKnJXS74+Qqa9qlvOugj8RyP14tavyt/Cg3N
 1D8FroaU8gGDNGqpcqj/CpbNmXtxB/L9bOEsIvaDogIWnsYxN6ulPajQ5SwUN7z2onpo
 m3Wa8P/kmV1X/Ii/PzHUThZxmIx0sWgo9m+urcQ9PXyBTBOzmfVANXWWPapBmnMyiuKp
 idlw==
X-Gm-Message-State: AOJu0YyUARyBJr1DTTYcqBVHr00KJkJ9YySCHECZlPukYNJcBgF2vZY9
 bmEya8VmlTgtzaxsBLq/UI2cFg0AIawqCigAOfc=
X-Google-Smtp-Source: AGHT+IE/A4hgKx9rjxe0+Bg05eeknJiotBeD8JegarplFOgildr+1MPu1EI0c28IN+SYChl2wV6zoQ==
X-Received: by 2002:a05:6e02:1bac:b0:349:365a:e191 with SMTP id
 n12-20020a056e021bac00b00349365ae191mr14530180ili.19.1692052892660; 
 Mon, 14 Aug 2023 15:41:32 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 19/19] expo: doc: Update documentation for persistent settings
Date: Mon, 14 Aug 2023 16:40:39 -0600
Message-ID: <20230814224047.535491-20-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Add mention of persistent settings in the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/cedit.rst | 15 +++++++++++++++
 doc/develop/expo.rst  |  1 -
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 8f0a554ae918..63dff9d3f140 100644
--- a/doc/develop/cedit.rst
+++ b/doc/develop/cedit.rst
@@ -152,3 +152,18 @@ Themes
 
 The configuration editor uses simple expo themes. The theme is read from
 `/bootstd/cedit-theme` in the devicetree.
+
+
+Reading and writing settings
+----------------------------
+
+Cedit provides several options for persistent settings:
+
+- Writing an FDT file to a filesystem
+- Writing to U-Boot's environment variables, which are then typically stored in
+  a persistent manner
+- Writing to CMOS RAM registers (common on x86 machines)
+
+For now, reading and writing settings is not automatic. See the
+:doc:`../usage/cmd/cedit` for how to do this on the command line or in a
+script.
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index 61b6855c72f4..f13761995d3f 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -485,7 +485,6 @@ Some ideas for future work:
 - Support unicode
 - Support curses for proper serial-terminal menus
 - Add support for large menus which need to scroll
-- Add support for reading and writing configuration settings with cedit
 - Update expo.py tool to check for overlapping names and CMOS locations
 
 .. Simon Glass <sjg@chromium.org>
-- 
2.41.0.694.ge786442a9b-goog

