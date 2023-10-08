Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F50DE95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D3D86A3C;
	Sun,  8 Oct 2023 23:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lH9Az7JO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F4F86B68; Sun,  8 Oct 2023 23:36:04 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617CE86587
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a269637b98so140996639f.3
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696800960; x=1697405760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iOmlfM0BOpRk/yaHS1pWFX1OcUUpA9sOnwBuWT1eIOc=;
 b=lH9Az7JOWG03CloUyOdvUeBSJKa9pvPVgsP/Fjj4SlSvvjaBR+iICagALqBtlx/2de
 th6KwI8LMQnSo2wGBLTp/ahO2GYycsjH9ydSKRfYGudttMACSXy+yB6qNVLIH00GIoNq
 to4ygXDBQzM+K6r2TJHr0ppGB+l0Bs8iSEi4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696800960; x=1697405760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iOmlfM0BOpRk/yaHS1pWFX1OcUUpA9sOnwBuWT1eIOc=;
 b=fcOjZNL/Uuczapww3o6kGQEpddD89Ntuo+PPRYB5JG3he5WFCxWxwcl56hqwQvG5UC
 3SSJBQiIyUeesfT5t+wm8KdfKCkfcug3nOJC5wnUz1oyOpJ49tYFITa6WMi3tkIRbfHU
 1geMDV2279aH1C+RK9frFo14A1T0zJUtrAwOZZfTunWaJRIBozKz6STSCndMi5cGEfRM
 lAHSOgqeGL2UE6i8h1IwNf3VzrbQL0ihvyuv8bKyD+pAnLtEcDZNsBQYNa/yGhTw9cdB
 Sqa0uxfxN50FtamYukVvoiTyPhuiw3hpZ9bapDm6u9djwZ6EQfsWf4D/y9VOnPNMlQow
 VZoA==
X-Gm-Message-State: AOJu0YzIY4XKyjPZMApwLOFhjZJPvWkV1xHzqparMeTOQUS1cSvfTZ82
 504+GhdTJxG80fm5dflvb6cQLBv1OpjoIOhpN5A=
X-Google-Smtp-Source: AGHT+IEXTiWKjnmwIEi3H37uKejm7WbVb+I5/PaE4jsx05TUOTHpNv3PFj+cwVVZ2tzLUrdN8wsVGQ==
X-Received: by 2002:a5d:96cc:0:b0:795:1a7c:486f with SMTP id
 r12-20020a5d96cc000000b007951a7c486fmr15186075iol.14.1696800959882; 
 Sun, 08 Oct 2023 14:35:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 gn8-20020a0566382c0800b0043d7ef4de09sm1641905jab.116.2023.10.08.14.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:35:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] doc: Add a short intro video
Date: Sun,  8 Oct 2023 15:35:56 -0600
Message-ID: <20231008213557.621529-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

This video covers the basics in a short time, so add a link to it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/learn/talks.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/learn/talks.rst b/doc/learn/talks.rst
index 0bb44aeabe55..d65e3b92be1a 100644
--- a/doc/learn/talks.rst
+++ b/doc/learn/talks.rst
@@ -15,6 +15,9 @@ learn a bit about U-Boot:
   <https://www.youtube.com/watch?v=YlJBsVZJkDI>`__
   from Embedded Linux Conference 2023.
 
+* `Introduction to U-Boot for beginners
+  <https://www.youtube.com/watch?v=rVaiLgXccSE>`__
+
 See elinux_talks_ for a more comprehensive list.
 
 .. _elinux_talks: https://elinux.org/Boot_Loaders#U-Boot
-- 
2.42.0.609.gbb76f46606-goog

