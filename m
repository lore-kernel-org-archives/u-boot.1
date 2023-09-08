Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91395EEB56D
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 20:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A688285894;
	Fri,  8 Sep 2023 22:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ig6V8vDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98ACA86A63; Fri,  8 Sep 2023 16:17:22 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1D686A3F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fshao@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-26f38171174so1690548a91.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694182638; x=1694787438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hhqYepBOV4e0+5cMGNJzKRmfwFgtIrM/9hQuwm9Z/U4=;
 b=Ig6V8vDPAulBGu8MhJKqc+pAy49r3fno3CFInmdZ10zUqn+i93f7cHdc7r+HQZNas5
 DRWRIwjGx0u50XIhkZpVhQTjkzdrRC0pe9c6hs0gR2yE6GYVEas9rEa7LeNc5SrvrJs9
 uIbPRM5OUasKGzIfIx8X7c99LQ9KbVimHcB/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182638; x=1694787438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hhqYepBOV4e0+5cMGNJzKRmfwFgtIrM/9hQuwm9Z/U4=;
 b=EisgwA6K6tDZ2NFV3I7f3+9SPy9KZYZwwoSXEUNESYeDEB6kUKq7H7jc0Eg6WIu4SU
 PJyubPccDYCIehs7cmKVJonxhj9uJRT5dRSHxdv5nlXfWRw6pHzY6t1cLOPJQseAlKJX
 2AiJf+5z77QI0YD4qZ9OVErbg270qbSibmO6TOIFMLWD6/hSoaG8Hw9UI/hWYfMeVRgd
 V5pSuQ4q1FS3GFtQe8vzyTBIjKAQATgSM4hoQnXqNSlJfnpKRmNEIT7w+4KMLsr6mwt/
 XGH1HpNsEPLkV53VQpb9M2Jv5HO6RJg5rvUqb+8jg3JcfYLsLv4p2Jp60YkefZM3BFW5
 BLgg==
X-Gm-Message-State: AOJu0YxQMRtjRyxzqkqVeTMiWCdCzuUd/qT2HpXZuyOzxar2O2O2M9Ln
 fEHkTdkhTKPgqedmMT2c1iw50g==
X-Google-Smtp-Source: AGHT+IGpKkvIS+b0lx50Bi6MyV0RCTkNX3tHb4uIhbicw8ivcssXY2VOwxP9C3nz/zvDLj4n9ngZWw==
X-Received: by 2002:a17:90b:3689:b0:26d:2162:f596 with SMTP id
 mj9-20020a17090b368900b0026d2162f596mr2619177pjb.6.1694182638003; 
 Fri, 08 Sep 2023 07:17:18 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com
 ([2401:fa00:1:10:2f7e:9c4:ed14:b826])
 by smtp.gmail.com with ESMTPSA id
 rm10-20020a17090b3eca00b00265c742a262sm1362301pjb.4.2023.09.08.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:17:17 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Simon Glass <sjg@chromium.org>
Cc: Fei Shao <fshao@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH] patman: Respect include directive on Git config lookup
Date: Fri,  8 Sep 2023 22:15:59 +0800
Message-ID: <20230908141655.2307809-1-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Sep 2023 22:21:30 +0200
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

People may put their user name and email in a local config file and
reference it by the include.* directives, however `git config --global`
doesn't look up the included configs by default.

Enable the --includes option explicitly to support such use cases.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 tools/patman/gitutil.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/patman/gitutil.py b/tools/patman/gitutil.py
index 6700057359fc..b0a12f2e8c06 100644
--- a/tools/patman/gitutil.py
+++ b/tools/patman/gitutil.py
@@ -651,7 +651,7 @@ def get_default_user_name():
     Returns:
         User name found in .gitconfig file, or None if none
     """
-    uname = command.output_one_line('git', 'config', '--global', 'user.name')
+    uname = command.output_one_line('git', 'config', '--global', '--includes', 'user.name')
     return uname
 
 
@@ -661,7 +661,7 @@ def get_default_user_email():
     Returns:
         User's email found in .gitconfig file, or None if none
     """
-    uemail = command.output_one_line('git', 'config', '--global', 'user.email')
+    uemail = command.output_one_line('git', 'config', '--global', '--includes', 'user.email')
     return uemail
 
 
-- 
2.42.0.283.g2d96d420d3-goog

