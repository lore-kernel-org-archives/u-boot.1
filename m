Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F0C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 03:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50AC088EBB;
	Thu, 22 Aug 2024 04:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i1wH2/4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA16588CB5; Thu, 22 Aug 2024 04:56:56 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D59E88C8E
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-82521c46feaso11465639f.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295413; x=1724900213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmvPMDULFpobe+S/hFhBfhEVyP0M1BL+LHT2wXM1CZs=;
 b=i1wH2/4d+h3omKn8gRe7JlQxZwwuGTmJiwNuehgW/ujcTZj65GYT5PPoRzkUclATrv
 RwplJ58g6dBp1dHkWlUhw8eJG/fpqlNANCbOnH7+Z0l4NihRPjoibfvuiNyq7AtVf3yD
 Zu5+V+gQqD2uovCZU3aB06uWRv7s5vj6/BtXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295413; x=1724900213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmvPMDULFpobe+S/hFhBfhEVyP0M1BL+LHT2wXM1CZs=;
 b=a0N4ES0NGZZYXrZaUurZgdlYCoijMuDH4icM6Xwp+0zYgAXrAp4OuOE1mHCQWbGPn2
 Xxbf5Yv3g3zCh+Qkr+pfnJfns9nMRmnC9U3od5lOsEtmnWXHe/kahDBB92YQad3IctmW
 KJ73JyC4SBuPBmMC5k8Qmr+i4V0h4MYVGyi5iY4PNj53N8+hWc1ONcXObCuQSEMCpqUa
 XGLNthWxiQ+91Kl2TLkSWFPdPcDwgzirE8BJhRtLBQpWM3d9rv5d4K+Plix+B/h6JuM5
 bhBk9xXB+yW/7f9UVVKIPw54g/E3CQ+z8SZ0wswxcaUjOtsKHYWKvkAx6Z5s3PAQAUbj
 yt4g==
X-Gm-Message-State: AOJu0YxPMAVYa4s0x80/HHsU++wobYQUr7XyXj3aa9YdV5QiMIynPo84
 aGPdtK3cquKacwTj6pqKqEX48oyAik6iXKOH/eADaoHA/BXXqHqX38NvbUQTjn4Sd3TqN9/178w
 =
X-Google-Smtp-Source: AGHT+IHc1nzFgL8idX5YTugiF5aw33thhYtVVjoMT5w8+93c6dc7n0NNJJwLIsbL3PkDRNsWQj2W1g==
X-Received: by 2002:a05:6602:1495:b0:824:d9c0:3fc6 with SMTP id
 ca18e2360f4ac-825916c52c1mr74634839f.3.1724295412856; 
 Wed, 21 Aug 2024 19:56:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/19] test: Add a section for closing the connection
Date: Wed, 21 Aug 2024 20:56:30 -0600
Message-Id: <20240822025631.1838434-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index f610fa9a6f8..b279d95dea0 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.34.1

