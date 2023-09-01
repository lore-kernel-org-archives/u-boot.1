Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A36BCA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 05:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BE786563;
	Fri,  1 Sep 2023 07:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOEVzbrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3944384003; Fri,  1 Sep 2023 07:05:48 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2609886563
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 07:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.cournoyer@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4122129390eso10009401cf.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693544743; x=1694149543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RyR05oCqv8C5/4hGVw1jdIKvj4fiog6RzAip/WZRC3s=;
 b=lOEVzbrwj/I3Ap8iPizq2RVTOkmxKGaKzt7vpeD4lXg09nhPTlKquU3wvaMAldDxGy
 YzVowZTPtieSWBqhsE1YO3XsbZz1BRi9WA0kIl0vNqmCyEiTs79goDTqoIY2CJmLbxd9
 TcvWMPrSCbOl0jdfOZJqwtlH6HkUKqtekL4eUczDiyPrvJPSvd8pz/YYw+pO1u8B78lX
 eCMlIWT1RYjJW0kmrNQhP/4EhmSuakN1ul8EZ9riExl6KEEdpgGC1mt8P6J2YQCVJe6G
 TrUvmrtR0GPY32Bhx+uidQRqJFndv019y4Mml1wGGhp3nRNPZHe28mhY1ZeEddQGHlJH
 Zx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693544743; x=1694149543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RyR05oCqv8C5/4hGVw1jdIKvj4fiog6RzAip/WZRC3s=;
 b=UjwsfHVBmZyvXBxPR/qrXcdA+yAfrpUEzwY2dVIeqG4PILvEWSlpPnt9d1LELnWOhP
 K/XcC15roP5bjfyYPT/PBts+pM7/0lsgvgoXPRF75CmQJwKRGn6C6g3gnFGJmn0Oe7+s
 uGesLW5Fh6ImhgwZ9OfvubeUg1PdgZDp9JXlylLx2+RAl8oyqjAFoMvti3ReHgTUB1WV
 b8TUQcmFmDDkylbE/CYrYlqDjncB8I5Mg1PkGD0tmikof0BrmElZZGMDaD7BZ+8atusu
 FpXhK1R3KLjzii0hucCcJZEylQu+rIE9oXSPncs960HYhTYGB38mNsji7fVdu9jOsYzR
 CnKw==
X-Gm-Message-State: AOJu0YzeZmCN9LFFnIcRviisySslJKNRDz02l6tXrC8C2SFm/0dAUcGc
 PZH7BaFx7hTyYg9IzAu+FA5XY5t6DMc=
X-Google-Smtp-Source: AGHT+IG01iTb6joe2x2P9W/5f5Jr9KF62oMl0qrGPI0GDE0zSaZIlGU4z08Oy5H1z5rue6KIp6REhA==
X-Received: by 2002:a05:622a:1a90:b0:410:90c7:518d with SMTP id
 s16-20020a05622a1a9000b0041090c7518dmr1779863qtc.11.1693544743545; 
 Thu, 31 Aug 2023 22:05:43 -0700 (PDT)
Received: from localhost.localdomain (dsl-10-128-23.b2b2c.ca. [72.10.128.23])
 by smtp.gmail.com with ESMTPSA id
 jc8-20020a05622a714800b00403cc36f318sm1184533qtb.6.2023.08.31.22.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 22:05:42 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: u-boot@lists.denx.de
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] tools: Fix patman launcher script.
Date: Fri,  1 Sep 2023 01:05:12 -0400
Message-ID: <20230901050532.725-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.41.0
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

There is no "run_patman" procedure in patman's __main__.py file, which
would cause the following error at execution:

  "AttributeError: module 'patman.__main__' has no attribute 'run_patman'"

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---

 tools/patman/pyproject.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index c5dc7c7e27..a54211f706 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -23,7 +23,7 @@ classifiers = [
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
-patman = "patman.__main__:run_patman"
+patman = "patman.__main__"
 
 [tool.setuptools.package-data]
 patman = ["*.rst"]

base-commit: 0fe0395922d859730eb7ddfcff6ed8d3ac4b2937
-- 
2.41.0

