Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE3AC3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 08:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080B1887E8;
	Thu, 11 Jul 2024 10:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YbVKJ9j9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AC98876D; Thu, 11 Jul 2024 10:10:10 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0254C887E4
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 10:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ee9b098bd5so7965951fa.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720685407; x=1721290207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oQXT6ZtTn+9IjvfbghAR+B8w13LT7Svp7kE08x9G16M=;
 b=YbVKJ9j9lNqpb1hlYvIv0TpmDPZCRv85UDvs3etEug0xHDmzDjHKGP82qkn07SEo5t
 atiS1MHW5lzd5jgH8xMv+fNR3r8vtHSUn2gz4QKy+suyMTuh02DsfBk6JiLDfi+v/UJM
 n5R36uzPd5LYzHV13mFp9plTIzv/EL0AofM5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720685407; x=1721290207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQXT6ZtTn+9IjvfbghAR+B8w13LT7Svp7kE08x9G16M=;
 b=hZQ8v5a1D/JhDTeOlzLFFWg9ElCGWKCyPISo5WrXPgn/r/M1i37sVwMGimAC2RTlUb
 pmacWN42on9zw1bMqZf4N2uIHw0UhHcIbsyDQziyqazGrYEve7jSB1D8vh6a4mUA611j
 LOx4OCb7a6VbVFwMa5mwmIDMTVEK3dtFOjEGUvnpavWsrCPmrUILGEJTLc53EBxDEv3M
 zsL3kDs8++KJpWwMIFg7IdLOzek1APasDh7k9juOPuilnQYtk4caDsFXwb2e+tHjhuXf
 o9m7/5B0qdx4U5D2d2rjSDd5WZMLMgiGqiQbsVt/nB8T+9sB9EWdPDQsCQDoa3bm3kd0
 dKHQ==
X-Gm-Message-State: AOJu0YztOHF9w/In2q6z78MhLnIAqeRPLKJlyj6AXGGazBCUR9kImi4m
 vGlZmEJi3Mx/7ukJ0lB0mCdOz36jFipl7ue2gRvh+4MNTgZOecJJ0qHiFLpTmELCRTLozgOZIP8
 =
X-Google-Smtp-Source: AGHT+IF9yRIGrVaoG/L5TqxrbS/4N/18xVfizbxgIvsKB/NOqv9AXZuf8aVE0a1lzkRc8e6NoweKrg==
X-Received: by 2002:a2e:95cf:0:b0:2ee:7af6:54ec with SMTP id
 38308e7fff4ca-2eeb30b9a59mr54299841fa.1.1720685406628; 
 Thu, 11 Jul 2024 01:10:06 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264d5101ffsm262927685e9.16.2024.07.11.01.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 01:10:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Show board list with -x
Date: Thu, 11 Jul 2024 09:10:04 +0100
Message-Id: <20240711081004.304917-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

When -x is used, buildman does not show the list of boards that will be
built, since there are no terms which cause boards to be added, only
terms which cause them to be removed.

Add a special case to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/control.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 464835c5be5..d3d027f02ab 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -124,7 +124,8 @@ def show_actions(series, why_selected, boards_selected, output_dir,
             print(commit.subject)
     print()
     for arg in why_selected:
-        if arg != 'all':
+        # When -x is used, only the 'all' member exists
+        if arg != 'all' or len(why_selected) == 1:
             print(arg, f': {len(why_selected[arg])} boards')
             if verbose:
                 print(f"   {' '.join(why_selected[arg])}")
-- 
2.34.1

