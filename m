Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0CEC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 20:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA5688405;
	Thu, 16 May 2024 22:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FHAZ53TP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39389883EE; Thu, 16 May 2024 22:34:22 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA1A8841A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 22:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6a0ffaa079dso80984126d6.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715891658; x=1716496458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m5BF5+u5CpGxag+FUE/xIAbd0rnBG5hgbJ/y6PY7qZk=;
 b=FHAZ53TPje89DjmqV1aDsz6lzXsV2X/6WFn7ZJ72iRkks1OADfAcMr3Tnf6di+48BP
 kKb5lmm8Ait0vZyHSwzapYv7WXx2P5DGBQK6tbqiEgJCOV7FUVjxV5yIQOjOBp5Nk9hj
 1epAsp3s6ayXP+14wLySnpjHusDe6yk80vz9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715891658; x=1716496458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5BF5+u5CpGxag+FUE/xIAbd0rnBG5hgbJ/y6PY7qZk=;
 b=K3S5cdnOeccQa/r+UIlueX6DI7VWb2kAdzQsXebOaqXCLdA2AA4WeW8NB4JdvH/63/
 y+nTPaX5F+2o9r5EGgKpphoO5m0T9QhlThK8Sq21mzhvC/qhOREv1dy9ljX5Agl3s+gA
 9YFZ5n0UPXK/X3aC/tYD7UED9cKjkzGP3bvakS8hFshZEe7sW+ZcMBpkyoWhrLfB3Yus
 0B7T89k5dHIcSh73+lSNOZWp267B/bWpE4fqRHa/mt4gu0gnx+AxslQVK8/i6+5cawC/
 qb+0MKJ9oszZu7LU+KlyEFJI8nc0n/7qQLeA8mfgqziezEKngLPM4li22jO237QhR5p+
 YDyw==
X-Gm-Message-State: AOJu0YwG4xqkhd3k32W3hKR9+RteO4K90hF7Y13d1Kw4OqeRMryD8Ycc
 +UlO3PpVdg9kSFlwOTlXQGwSkJGpK01Vrum0GERRQdS90A8KjDaGmPiLOnbltSFkuMa55GVpOm7
 34dc=
X-Google-Smtp-Source: AGHT+IFFM+8IYtKjUdIj0YZ/5ENT20TIdHpT6tpgwJC9MBkA+4CMmFfgxhOscxsAPQKqq7e2YkigVA==
X-Received: by 2002:a0c:f6c4:0:b0:6a3:58a1:1e24 with SMTP id
 6a1803df08f44-6a358a129b7mr85294876d6.25.1715891658387; 
 Thu, 16 May 2024 13:34:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f20570bsm78234346d6.140.2024.05.16.13.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 13:34:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/2] doc: process.rst: Use subsubheading for "Phases of the
 Development Process"
Date: Thu, 16 May 2024 14:34:15 -0600
Message-Id: <20240516203416.928567-1-trini@konsulko.com>
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

These sections which talk about the different phases of the development
process should be using the subsubheading identifier.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/develop/process.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 92477d05dd85..a66540a698c1 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -34,7 +34,7 @@ It is followed by a *Stabilization Period*.
 The end of a Release Cycle is marked by the release of a new U-Boot version.
 
 Merge Window
-------------
+^^^^^^^^^^^^
 
 The Merge Window is the period when new patches get submitted (and hopefully
 accepted) for inclusion into U-Boot mainline. This period lasts for 21 days (3
@@ -44,7 +44,7 @@ This is the only time when new code (like support for new processors or new
 boards, or other new features or reorganization of code) is accepted.
 
 Twilight Time
--------------
+^^^^^^^^^^^^^
 
 Usually patches do not get accepted as they are - the peer review that takes
 place will usually require changes and resubmissions of the patches before they
@@ -65,13 +65,13 @@ the Merge Window does not preclude patches that were already posted from being
 merged for the upcoming release.
 
 Stabilization Period
---------------------
+^^^^^^^^^^^^^^^^^^^^
 
 During the Stabilization Period only patches containing bug fixes get
 applied.
 
 Corner Cases
-------------
+^^^^^^^^^^^^
 
 Sometimes it is not clear if a patch contains a bug fix or not.
 For example, changes that remove dead code, unused macros etc. or
-- 
2.34.1

