Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F5EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B40D86A82;
	Fri, 15 Sep 2023 02:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RsYCwtaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AB586A50; Fri, 15 Sep 2023 02:23:08 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237A78648D
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so43184939f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737385; x=1695342185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00bioIQInj7WTikMgQnjloThiQ68941OkKfUUkn03OA=;
 b=RsYCwtafuo3XrvMQkXAqQMwP0jlOa400ZH4oDR7F1+g882ySVU0leZPIk0mMr4gTU+
 mqf0AmtIMyiP7E1DkbQcU+kBmuKHNmjuskGRVn1evFDR20iYet2xBSBsIw4g2UqwPrtl
 gPlaijDe5qVrX3YZX16Od2QnhFqnzPixh7RTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737385; x=1695342185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00bioIQInj7WTikMgQnjloThiQ68941OkKfUUkn03OA=;
 b=WA/RGmHX6xRXITbm+GTAS/r4qyl1Qiinh/I5ETpROZ3g5qD4Lr/HiphDnKCyDxW+kA
 nbIihxDBTlZNEAWacWQQBB+yPhTBcO3mlOwU7U6y6p4imbhY1tgBwos9RVVTfqIiS9j0
 bpxprSjyTi+dSAXmBmyCw7/obpnC5wY6Ig3wiWr4wPYdeGNv1jIKlWTLiO5AroWcTY32
 tmVbHuE7ha36QXEwBfoYGK8f1N5UdzGaKwEhVpAygCasSi3MwKRPkFS+inUkLR4M9Oel
 Sf6Vv0hHX2eY35fvAVvrthJuYKnD1W9uk5cZKSnrtoOnMliKl/KBL2oBN25mkNbKhyEP
 GsLA==
X-Gm-Message-State: AOJu0YzdS9uWGdPFMgVHqNtFOB6IJtkgaLMHae9XGUDroNvaZfmtfm8z
 gBfvhszUUzmkoBQjli0oV5ShLCfWVohoo8XNro4=
X-Google-Smtp-Source: AGHT+IEobJKJWdrmWgbFC7XeZz641eHHuBZ14nCYrj6A9bLa1EDRdzyddzWtx0GRnGjvezYiL0GBxA==
X-Received: by 2002:a05:6602:2c85:b0:792:6aaa:b54 with SMTP id
 i5-20020a0566022c8500b007926aaa0b54mr3920289iow.7.1694737384817; 
 Thu, 14 Sep 2023 17:23:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/27] moveconfig: Drop the initial output
Date: Thu, 14 Sep 2023 18:22:25 -0600
Message-ID: <20230915002236.798760-24-sjg@chromium.org>
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

Since moveconfig now just does what it is told (build database or sync
defconfigs) we don't need to print what it is doing. Drop this info, which
is of very little use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index c6d7c53f8b89..5392e1f808e7 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -727,12 +727,6 @@ def move_config(toolchains, args, db_queue, col):
         db_queue (Queue): Queue for database updates
         col (terminal.Color): Colour object
     """
-    if args.force_sync:
-        print('Syncing defconfigs', end=' ')
-    elif args.build_db:
-        print(f'Building {CONFIG_DATABASE} database')
-    print(f'(jobs: {args.jobs})\n')
-
     if args.git_ref:
         reference_src = ReferenceSource(args.git_ref)
         reference_src_dir = reference_src.get_dir()
-- 
2.42.0.459.ge4e396fd5e-goog

