Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F85FC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 23:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8487888C53;
	Thu, 22 Aug 2024 01:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yl0OP6x/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5EE888C29; Thu, 22 Aug 2024 01:52:31 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377F788C4D
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 01:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d2256ee11so939585ab.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724284348; x=1724889148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5AdaDCLLHRES4S6at10A2Yr2k5Bxbt5qvpcAJ+E3MJo=;
 b=Yl0OP6x/sw9GHT0f/nR7KMaE2xSp3jJ+F/Fqi8ZS7mswzrcaFvxFMCgMOYg0WZD5SF
 cvbTRxODZG0jVJ4E3IWyf+PvGh3qBogrXkMpco0W5eSn/rI0cOdaoj/mqeF2cPWCFEvm
 YdWAYA3lLw5GK1comHgET0e6RZNSEMJ8GvPGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724284348; x=1724889148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5AdaDCLLHRES4S6at10A2Yr2k5Bxbt5qvpcAJ+E3MJo=;
 b=pCyZndEkCfwttXoj6cIOkJDyg7gjsqW1mSEwt1s3ObiIrau2XEPErync5hamq31GgA
 V45z0K2E0OCm3tlJMd6tJiq7orZpN2WmbdFeFZ05SoSmlKBZksa+Y9m9iOX7bol6nTPL
 YP56p2Gm+FRFmphiFtj/8WY2GEQALtT/QDhvjXnqPsJ+ljqTQRCNpz4jfC59yrLt8ofL
 +oTKNCkmv4itqJtDEc7D8oz45gIKHuwU0Ss+IZT89tI6z8TwFu7ygLQl+loe1zXDOjQW
 p7MzBE6+rKLPPPwtiaRHG7yTdLGAqRr06cwu4Zi4/MrLi7Gufnb7KhNveiQ/brMAXonp
 VcmA==
X-Gm-Message-State: AOJu0YwFW1XE2LviyJg5lL/UKjwwcrIaz5x3FgjTl0iaggYxgSw6qA/+
 LPl8yZxWI6ypNWdADVmJN7Fp7g0p9I4lnSMyDVzNNBV3TFH59RqX1SJrU0e1q1ciFwoi7Z+yH/I
 =
X-Google-Smtp-Source: AGHT+IHEKnYkqOaPIWf1WTfkTvGWJBfcu0blkdUJ365j8E1DYhy2mp1dGEJW9rNdq7PtyTrFK1x4Fw==
X-Received: by 2002:a05:6e02:1c04:b0:39d:254c:ece5 with SMTP id
 e9e14a558f8ab-39d6c3928f1mr50788745ab.16.1724284347824; 
 Wed, 21 Aug 2024 16:52:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c2a2sm1552275ab.38.2024.08.21.16.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 16:52:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] qconfig: Fix an incorrect format-string with negative value
Date: Wed, 21 Aug 2024 17:52:24 -0600
Message-Id: <20240821235224.1734620-1-sjg@chromium.org>
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

This is not allowed, so use ljust() instead. This fixes the
'qconfig -i -I help' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 1bd43060b3e ("moveconfig: Use f strings where possible")
---

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 7b868c7d72c..8c2fc9efc5f 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1595,7 +1595,7 @@ def imply(args):
             if flag == 'help' or bad:
                 print("Imply flags: (separate with ',')")
                 for name, info in IMPLY_FLAGS.items():
-                    print(f' {name:-15s}: {info[1]}')
+                    print(f' {name.ljust(15)}: {info[1]}')
                 return 1
             imply_flags |= IMPLY_FLAGS[flag][0]
 
-- 
2.34.1

