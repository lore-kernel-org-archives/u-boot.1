Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E92FE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2AF801BD;
	Thu, 12 Dec 2024 23:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mR4Ecwtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131D3801BE; Thu, 12 Dec 2024 23:33:43 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1EF801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso47337185a.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734042819; x=1734647619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Z7UiQzU7ukrkWoi9/iMd8vQET487HJkL/p85ZZE18s=;
 b=mR4EcwttU/cP3wtTzSCkxG+pMMNOEbYKtZ4nMGvXMgMOQ3VsMMkaC8ikXYboN0UGRe
 7EOO5TVRWo8XR5Vszx5vvGhflfJ4OG+sTfLANgk5MrvqVl09SSxcgcfJrC8VNmYFl4Nd
 Il55B8Cg3RHCwBMMHz/wvkqxtXJkGTXRGyTh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734042819; x=1734647619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Z7UiQzU7ukrkWoi9/iMd8vQET487HJkL/p85ZZE18s=;
 b=IrXsPEU46zwFD4kVab8MamP+L00zoZQcfwrV8wMqfCsf8t2aRPXZDrVE4DY/IN81es
 ClGyjzku7W5KjIiqCXdvULKEatUIxBwI+rHtZ/0G0tk3b5ltaP9TxKTXIcNIZHosOAIX
 HWBn8PpRBLwIVgca5Z3FU7krHx/ysvcfszSnsJqQH2IIivgSX5RvRdJ1AIbhHhSmny2v
 MQNmnm6vj5o8ZdbFMEl+G/o5LquHUzxxzlDrmf2DnQTyZMxC3zxWPywr0cQPhm5l0Dq/
 1l0W1ozk+sYQawPBDD+7YsLZyeJvGoSowZlXNQKtj2l7xtNyqHJzOJGW9MSDRUmLvh3Y
 PAgQ==
X-Gm-Message-State: AOJu0YyaU3s9EAmCXPbjQ+bezw1G6tOGMb5C89ezT/NG380jY5J7m6Wo
 txyNQbkQ4QL3pU6TlUcUQvKxeCMFRmOAYMZFCFkJsSggeXMQomJeoqQSYXsnNWV3hS2qdOKGqli
 LZRU=
X-Gm-Gg: ASbGncsMM7EQZuSEU+BCb0u3NYISzDWy/Ko9Vr34lyWjl00oC3ubZykRT1sBld2s2dK
 av0KcnGpUuPzlJaegx1Aauk0s5lw3OvcUlMkJ7oPd/S95ocIn6JcxOYHLMMyLTXS+QCTktjc4Mx
 nRRWzJs8eWMsGq2KK3euKzOpEnXK+FIqL1aZNvNDZd6+pOxBdih7Wi2ZjC03pPcLgrKtHOkleo7
 coF8S93aSdHjuBin3xkObaf7CG7RpvPTQPEE6Z56D6o2C3rHKRHvZuQw1zBlzzIDXjuM3XDwMV/
 QfY=
X-Google-Smtp-Source: AGHT+IE2uew6quJ4BNesV63MkV0zf1IFRtWwbP2E8SCZfgRIXVrLrB4+hEkyj5oAgIPuA9bgldnVOg==
X-Received: by 2002:a05:620a:4090:b0:7b6:c634:e332 with SMTP id
 af79cd13be357-7b6fbee8885mr32893785a.19.1734042819392; 
 Thu, 12 Dec 2024 14:33:39 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e96csm777402385a.120.2024.12.12.14.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 14:33:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH] Gitlab: Remove some "rules:when: always" lines
Date: Thu, 12 Dec 2024 16:33:36 -0600
Message-ID: <20241212223336.1623762-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In commit 399f739be6b2 ("CI: allow jobs to be run in merge requests") we
added "rules:when: always" to many stages of the pipeline to allow for merge
requests to trigger a run. However based on current Gitlab
documentation, we should still be triggered on merge requests without
this. Furthermore the way we have things written today we always run all
stages of the CI rather than failing out early on problems, which is not
always useful. Remove these as we should still be fine with merge
requests triggering a run.

Link: https://docs.gitlab.com/ee/ci/yaml/#rules
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Can you please test this in your setup? I'm actually a little unsure of
what your setup needs now that I look at this harder, thanks.

Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .gitlab-ci.yml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 57037e243ecb..2f324b0e1a90 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -24,8 +24,6 @@ stages:
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
   retry: 2 # QEMU may be too slow, etc.
-  rules:
-    - when: always
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
@@ -104,8 +102,6 @@ stages:
 
 .world_build:
   stage: world build
-  rules:
-    - when: always
 
 build all 32bit ARM platforms:
   extends: .world_build
@@ -157,8 +153,6 @@ build all other platforms:
 
 .testsuites:
   stage: testsuites
-  rules:
-    - when: always
 
 check for new CONFIG symbols outside Kconfig:
   extends: .testsuites
-- 
2.43.0

