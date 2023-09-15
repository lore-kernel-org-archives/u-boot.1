Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E759EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680AC86A24;
	Fri, 15 Sep 2023 02:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O6Ryg4XX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD07869D1; Fri, 15 Sep 2023 02:23:01 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051AC8698E
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79ac0d271b4so2815839f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737377; x=1695342177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ov8T+DI8gfCrrpVf8qf27Bugzen4N6xfhyk8fOYuhSo=;
 b=O6Ryg4XXbGWEt1OINrsHVGI4EIYraZNFFGUpT6jqYph5ESao3EFhLLs5b5fCmB0btD
 9izp14Yi/fx4k4yQkmfMGUwG3VDG/5pMeQBFPgRBh+x5ZEZbLZbWuzrVtsmO7QVO0Yp7
 gTejnvCzF5iuOuDhq+GIqtSJTaHe+mKg/Cx2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737377; x=1695342177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ov8T+DI8gfCrrpVf8qf27Bugzen4N6xfhyk8fOYuhSo=;
 b=rpa8G4JfvgJ9xJ6TN46O6/3JxQDJ8mwSYE/99bYT5OYbpG5+zewCydMsCDRzacV0Ea
 ATkrTuLZxxhxP+5rHmo5AYMXvLt6IQAXNuchAkcsNZIH/cFeOoRmYAjdoSp/DqWU2t78
 pwYUcs55Hf5AinQRGqTId8xpAMxeDxI7rHNRWkgYczdhUMiaSIg9mHZkc5/R2KVAeD3h
 SD9rM73Ln4j3ZiWPFqiX1eRTO74fS2ydoGRXPSGjLHGjibf9l6VTtUkWpDwpAR99qniL
 APAlGbBsZvcLB2Xgoriy4/+hoBqRE6mo5ylyjGX7qpXpb3cSKVtTAKlbNaHseKbjFzAv
 n6tQ==
X-Gm-Message-State: AOJu0Yx6UhaODF56AT4txI5Bj5w8a6y57IkxXdEaEEUyTDXX52kUQ0et
 N5D0kwc6itAPApC4g6wWMqcUyuWUgHikgdMc4Ic=
X-Google-Smtp-Source: AGHT+IHbNyVHnDeC56E1R11xKvYlUiFcT2shJM+TGumz9X2B5lmVkkdzf1PYXdQ2ucRnt8Fxbv1pcA==
X-Received: by 2002:a6b:dc0c:0:b0:780:d76c:b640 with SMTP id
 s12-20020a6bdc0c000000b00780d76cb640mr70345ioc.9.1694737377666; 
 Thu, 14 Sep 2023 17:22:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/27] moveconfig: Correct use of members not declared in
 __init__()
Date: Thu, 14 Sep 2023 18:22:15 -0600
Message-ID: <20230915002236.798760-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Fix these pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 2234f28a7724..1dff89159312 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -410,6 +410,10 @@ class Slot:
         self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
+        self.defconfig = None
+        self.log = ''
+        self.current_src_dir = None
+        self.proc = None
 
     def __del__(self):
         """Delete the working directory
-- 
2.42.0.459.ge4e396fd5e-goog

