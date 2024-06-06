Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580EFC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC60B881DB;
	Thu,  6 Jun 2024 18:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pyM5TUcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BDE881DB; Thu,  6 Jun 2024 18:44:30 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F72688423
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f8e287fa3eso478464a34.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717692267; x=1718297067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DVFoIpNXzZy49yfCBWAqsfrAyDZ9CjAd6wnDWL7kPt8=;
 b=pyM5TUcnKp0G12jcf4FXHM0LKG1w+J/id/Wm+l3d5q5VSVFBAsr4uuaDhnLYOi13li
 +V7nl1B2QB2mwS5JbNVF3v5JvGVknOd1fUujkpOMRzUtyI4sW/qe6tfrummfsL7snqzh
 rmLI3uGsByffKEZugirCKDfO4XwPBUcERAcxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717692267; x=1718297067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DVFoIpNXzZy49yfCBWAqsfrAyDZ9CjAd6wnDWL7kPt8=;
 b=Xo7uz5aEVSduS8VkNqmPyeQCo1Ujp2xpHqk79goOXKkqzckuQYWOF4QAejSElL4a3n
 5nQUb8nxcJ7Uskbnt7dC0yrIcFkBLIFwTNwgTcHA+Xkr0ZYLbhJ9ln1WpH5VcUGaBxCz
 ZDJMtLexTlFF3TpfT0mpM8bZ2ulR0XPlmXc3cAGNl09gFkHcdGqdzYvfTuW32J6zxdqh
 IXN0jA9mkOW2nFeBrMIdHU1dsDXZgnHaTBJwcN+9Ij/xq0xJItnWnqFJAtazW1/Mump3
 FQ16kVnkc8e+rKPR0ex1glFGu3n+jOH3VYddi9qXdq2XaQI/rKhB0/3gi20K6YaWLbTI
 7uyw==
X-Gm-Message-State: AOJu0YxPrvTvz27Z6l0KnBs5S6I0M7TIDM2UUA16RLldJLYDJCZ9l1Wk
 uehNRtw+iFAGkBayLL5pPjX8K7qHD1zg1Vh5RUNhZUMqHqZX7YIV2nVsXjIlSeKiAJfa/kzU+f1
 EHso=
X-Google-Smtp-Source: AGHT+IHf4NBoJrnoMyNKKHoIWrZC9cEQCg38tzD2ExgzgATVr/mT27O/l2KWXY8SCZIZFOfXcCAZww==
X-Received: by 2002:a05:6830:2043:b0:6f9:4034:8740 with SMTP id
 46e09a7af769-6f94340e916mr6431457a34.4.1717692266765; 
 Thu, 06 Jun 2024 09:44:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-100-45.totalplay.net. [189.203.100.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f94dc70779sm331217a34.1.2024.06.06.09.44.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 09:44:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc/sphinx, test/py: Update requests module to 2.32.2
Date: Thu,  6 Jun 2024 10:44:25 -0600
Message-Id: <20240606164425.3066381-1-trini@konsulko.com>
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
usage, update to the current release to fix it. Furthermore, upstream
has now moved on to v2.23.2 as the release to use which has all of the
issues resolved.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Switch from 2.23.0 to 2.23.2 to use most recent upstream.
---
 doc/sphinx/requirements.txt | 2 +-
 test/py/requirements.txt    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 426f41e1a028..54eb70aa92c0 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -9,7 +9,7 @@ Jinja2==3.1.4
 MarkupSafe==2.1.3
 packaging==23.2
 Pygments==2.17.2
-requests==2.31.0
+requests==2.32.2
 six==1.16.0
 snowballstemmer==2.2.0
 Sphinx==7.2.6
diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 0f67c3c61949..c1dd636931f7 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -20,7 +20,7 @@ pytest==6.2.5
 pytest-xdist==2.5.0
 python-mimeparse==1.6.0
 python-subunit==1.3.0
-requests==2.31.0
+requests==2.32.2
 setuptools==65.5.1
 six==1.16.0
 testtools==2.3.0
-- 
2.34.1

