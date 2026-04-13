Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985ECF34C51
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E523F8407D;
	Mon, 13 Apr 2026 15:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gVzx4pjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5F88352B; Mon, 13 Apr 2026 15:01:53 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF46841BE
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbcf927395so2526062a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085309; x=1776690109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8S36gRrhSjsO33l6bhWIEiCG98l/OJpgqXTQopEle2g=;
 b=gVzx4pjjLReJ1+/mmsaNi9/trc13EkoR3Hxm59RHOS3BywRFwFB3R1KtYiFtg7r+v9
 Y0ttwPxGDWwpCQNfWSNC1Y9CzE1HU8rc0fP2rlHslnIIPr6uCfHEaQoVw61iOHAA2vGD
 V8+FPmls7qBhyECUi7F9hV97N+oJIet2bb0KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085309; x=1776690109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S36gRrhSjsO33l6bhWIEiCG98l/OJpgqXTQopEle2g=;
 b=gQ39EQj5EL/51llMtXWIynnfuD4ZZCyzsqwrIBx4Dk+f9+KSPnteML4XptQzeHiFLA
 sSRUjzsDlT0KNWz9b9O3h4A2cdxuPwI0NDXoxVgDrr4wrsZ32SmYY8OLvn5ASu+XGfGv
 sRd1eK5bZde/WloePhnVNlpShwBZmw4jUw4USBXnrxyhwMnGv6K2ozHg+vO199KRayuj
 ld/mj1Gj6KFuXLfb0R7PmRK10Y2v8Yk729IsP2Vuzi5Y1NQ7HPhjDd+tebluQZI6MKoc
 Mxhq3joX8jFEazWOGPBZJ1IpHjfN3XWjGhRMCOP7dtfTEeQEIeFIBAJ7MAQNrwL2CzHe
 2o5w==
X-Gm-Message-State: AOJu0YxczgPtcQGTkTMPckDYtZ4JgXv7BcU3MQ16YDi5FXgmQMqU8z9c
 WZkOcmtqicirYCYcNGH+Kxw1rP5NGKSyh8siN7YslRwN9rwL3z9zYCUOVjjTZB6dQwonI8xtc+n
 lbkC4IA==
X-Gm-Gg: AeBDieu2nVy2zU1YdRE7Z9reSyWOIwwKvdvH6BQhsqnOHH9GMh7NRhLYuOmhpJGs5wl
 gAW4zRd8+eKa/IC+cJDxo4jZFb+KpUpN2ZIYto8t84hoyryMvOh5zmvEHeatGEWuMeGK7fBfb8A
 Jmd+COgktvQwWYjSV3dg7Q22qblcA4Jom3pN4tZxZBEOLSrzgvfoav90w4qFloyPxjAy6ywgHka
 g26hoBTBs/BX3+eQI2fy6eiJTnsYxeyzGaAv8GFwwgtAhq+1KqGadQ0e/YK3eJ2s1ou5jqhcGwk
 fydt4JbGXQQDsGf6UVha+h2iL45fswsvlE3XjNpqEZK+kgoMStL/jiM7hxITybPrjoIgPuce8HY
 tspZOsI9CzjKcZUCVB/pGQm/KIvAM1RKKsyAkGW1oQzNEVkIthx0f/urG4G4Cx1xej40onNiW23
 /VA+riGewJ9Qb0nUNccA==
X-Received: by 2002:a05:6830:6f43:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7dc27e0ae09mr6709491a34.21.1776085281812; 
 Mon, 13 Apr 2026 06:01:21 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/8] test: Refactor FIT test for clarity and extensibility
Date: Mon, 13 Apr 2026 06:59:51 -0600
Message-ID: <20260413130007.1987326-1-sjg@chromium.org>
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

This series reworks the FIT test (test_fit.py) to make it easier to
maintain and extend. It fixes the buildconfigspec so the test actually
runs on sandbox, avoids unnecessary U-Boot restarts, renames the main
test for easier selection, adds a missing-kernel check, fixes Python
warnings, converts the test to use a class, splits into separate test
functions, and adds Sphinx documentation.

Changes in v3:
- Restore the find_matching() examples, wrapped in a code-block::

Changes in v2:
- Add new patch to fix the buildconfigspec marker
- Remove doctest examples from find_matching() to fix Sphinx warnings
- Add new patch for Sphinx documentation as requested by Tom Rini

Simon Glass (8):
  test: fit: Drop the fit_signature buildconfigspec
  test: fit: Avoid restarting U-Boot
  test: Rename test_fit() to test_fit_base()
  test: Add a check for a missing kernel
  test: Update fit test to fix a few Python warnings
  test: Convert FIT test to use a class
  test: Add fsetup fixture and prepare helper for FIT test
  test: Add documentation for the FIT test

 doc/develop/pytest/test_fit.rst |  10 +
 test/py/tests/test_fit.py       | 431 +++++++++++++++++---------------
 2 files changed, 241 insertions(+), 200 deletions(-)
 create mode 100644 doc/develop/pytest/test_fit.rst

---
base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
branch: loada-us3

-- 
2.43.0

