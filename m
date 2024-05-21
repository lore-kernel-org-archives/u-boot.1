Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE03BC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 22:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D645C88403;
	Wed, 22 May 2024 00:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OdBRwfdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BFF883BE; Wed, 22 May 2024 00:33:00 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E338842E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 00:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a919a4bb83so14833486d6.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716330776; x=1716935576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KqPvbi+B9HNmTtF4c+te10S2yxrl0Wfzrw2WALYH7YQ=;
 b=OdBRwfdZcoAQv6CQP7GDgLwJx1CB/7a323jQp3+6z4qBmW4WmFwRbLXNO1/4N0kpfN
 HGzC7m6rUKhK9Tt4zlJ3oHhe28U2sQdvoJG/uKjkVLLB8k47kHeDI4z+9wlIijf77pfl
 TZPksdrhbiSoz4vR7VagG7OUxqcNrIu+R1eRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716330776; x=1716935576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KqPvbi+B9HNmTtF4c+te10S2yxrl0Wfzrw2WALYH7YQ=;
 b=vBjBcE2f4D9S4xygbju0ueJI/h7aZinbS9R9Tp/y1WVQJVp7IfGofg6VsrPAdHUiGJ
 lSu/Gx1E/qXgpCBmeCu8/zu94s5QydkD/nTvliio7tUkJCo9pX3yB3bQKKnmn3RfkNqA
 sd1c5xrRJFRHhZAvf/d1yNK6VcRi4jJmgi1Elj3sXfziw+uoiWKFbOr/+0OSesCE4rOv
 Sxxef3HnjhRBrdO9eS2XVOv1NJnihYydF8aQkElb4HnT7aZVpEw6czheCCluTW/AcNPi
 nEo97aLDB3K7ysv4RmbmPlC2WTHJFara0oOrn428N21PaOIeqyfqRwrq2noV65VGv3xg
 ehfg==
X-Gm-Message-State: AOJu0Yy2gHuCdnQ/QG0NQ9JXN6hB4xQ4MxRy7vGvrpAkKsCJxFwx183j
 KZQYD12/n00CTBccMwXrg1xtN63rXXrZp1wXV4hQgo8fHyPu8hgJZRnWHVLalCr/6OnsQ+rvIaH
 P
X-Google-Smtp-Source: AGHT+IG2UOvqf87bOsegqDG6EeniXsmUXQCWa5MIXiga8/t/XLrp9a6xKWWAveV0ZRNbnR8IiEQ8bw==
X-Received: by 2002:a05:6214:3d12:b0:6a0:d291:a357 with SMTP id
 6a1803df08f44-6ab809030e5mr2433736d6.54.1716330776533; 
 Tue, 21 May 2024 15:32:56 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a8c2d39d7esm35815046d6.95.2024.05.21.15.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 15:32:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc/sphinx, test/py: Update requests module to 2.32.0
Date: Tue, 21 May 2024 16:32:53 -0600
Message-Id: <20240521223253.1858188-1-trini@konsulko.com>
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

The issue described in https://github.com/psf/requests/pull/6655 has
been assigned as a security issue. While unlikely to be exploited in our
usage, update to the current release to fix it.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt | 2 +-
 test/py/requirements.txt    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 426f41e1a028..7d1e8a02018b 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -9,7 +9,7 @@ Jinja2==3.1.4
 MarkupSafe==2.1.3
 packaging==23.2
 Pygments==2.17.2
-requests==2.31.0
+requests==2.32.0
 six==1.16.0
 snowballstemmer==2.2.0
 Sphinx==7.2.6
diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 0f67c3c61949..20b6504454c4 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -20,7 +20,7 @@ pytest==6.2.5
 pytest-xdist==2.5.0
 python-mimeparse==1.6.0
 python-subunit==1.3.0
-requests==2.31.0
+requests==2.32.0
 setuptools==65.5.1
 six==1.16.0
 testtools==2.3.0
-- 
2.34.1

