Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC227C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48CB8855C;
	Fri, 21 Jun 2024 15:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m+MAxTUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7694E884FF; Fri, 21 Jun 2024 15:14:32 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8BD88528
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eb6ca2cd09so61250639f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718975668; x=1719580468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pztTEcQpgLbhvqiwb+N4h+BLnTNxkbZUaSNiUYTND/0=;
 b=m+MAxTUre38U37T8u4KYT2By0wyxf/f9GEfAB9mFDvBnwIX1vvmEhUY3eM1h9/oV0x
 AnJ7OLmpTRE49v742YyEf/ei+Qt0/a8u3svAIwcgMcSS1rl37y0wPIZB5f4sWmCxwOem
 yz+0Lwe7do1z/77glcOqEAbzv352/iWcloSHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975668; x=1719580468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pztTEcQpgLbhvqiwb+N4h+BLnTNxkbZUaSNiUYTND/0=;
 b=HwxbkK7d3jGyGLquKVrqcL2bL2VNoIt0/8TpWwk0tHtFyMu/BghjstMVHOo7EW1p9V
 BCovsM7cWoUQecLolyejebyCY3+ydj7sc6Zf4BfBBa679rBwIWUN1WJFD5rFS747zdPj
 Y9z9NH3omlBdWzMgG911MSCZaCN7yQcvksHfmB+sfKx5s729C/yU13WcSFc5uH6GXWTW
 b8ZEYdUY2mAYFhdn24/51CyMHai5zKaEkC3n/YY9ebzWeih5+l0U/rDp3f1mO4xoaxqB
 dTUm8rFHjppJqUSJSiejS7jAnby0ukPNanUDR2/aKNDmTLHRIS6M8A1xYG2JA/KafPPA
 lg6A==
X-Gm-Message-State: AOJu0Yxyfnt0PaGDcn1S1SRuE7bDjxh2MUCqR1BBDnSeVQoZNncn98dP
 QAuGOKjcnnVlG48x3kbco45nZAYhxKnQbRHmZXvbBpZ7as00N8QdcEsW3C1J5AkGDeuhfj8exrv
 UDw==
X-Google-Smtp-Source: AGHT+IFc1uamojiRlq49om0mb1n6eVrjXf4pcudAwh3GupYlfK5pBMaO/P1B8OUNYRf02sIV7XGyxA==
X-Received: by 2002:a05:6602:1614:b0:7eb:75e9:8f2e with SMTP id
 ca18e2360f4ac-7f13ee7b6b9mr901179639f.16.1718975668464; 
 Fri, 21 Jun 2024 06:14:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d12496fdsm346881173.163.2024.06.21.06.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 06:14:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Brodkin <abrodkin@synopsys.com>
Subject: [PATCH v2 3/6] buildman: Fix a few typos in toolchain code
Date: Fri, 21 Jun 2024 07:14:19 -0600
Message-Id: <20240621131423.2363294-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621131423.2363294-1-sjg@chromium.org>
References: <20240621131423.2363294-1-sjg@chromium.org>
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

Fix 'Thie' and capitalise 'unicode'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v2:
- Add new patch to fix a few typos in toolchain code

 tools/buildman/toolchain.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 79c7c11a110..324ad0e0821 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -175,9 +175,9 @@ class Toolchain:
     def MakeEnvironment(self, full_path):
         """Returns an environment for using the toolchain.
 
-        Thie takes the current environment and adds CROSS_COMPILE so that
+        This takes the current environment and adds CROSS_COMPILE so that
         the tool chain will operate correctly. This also disables localized
-        output and possibly unicode encoded output of all build tools by
+        output and possibly Unicode encoded output of all build tools by
         adding LC_ALL=C.
 
         Note that os.environb is used to obtain the environment, since in some
-- 
2.34.1

