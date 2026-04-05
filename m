Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C658E64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF7A8352B;
	Sun,  5 Apr 2026 13:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UlJ3HRnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406E18394E; Sun,  5 Apr 2026 13:12:20 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171068341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-470145d7e6fso379685b6e.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387536; x=1775992336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YPHAr5+l1ePlUstZkt0QDQQlxLSla+w4iEbtul44JLw=;
 b=UlJ3HRnMYo4gWkV/scs93fhQxsDIUCnYU/EmcbB643gTTdSznMpRIN7FYfJPl73atj
 kC/JswfqmSn5UrQAcxwCVRssyzfkOCxRRXCgVAxY4M1kBCnFlP/KUSUjqfzavv/na6dS
 z37U2Q3zgqwFQ0zVfG86TZ30tSVY+yy9JhAFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387536; x=1775992336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPHAr5+l1ePlUstZkt0QDQQlxLSla+w4iEbtul44JLw=;
 b=WcfXT6ypwE7nTJ9XAumC4pNS19bVxiRwokHmv+tTR4qXLdJhd69Dp2b2T6yMEVgNJD
 aqSNhs28kJRrK+owPINU2sRABoP3BAuJFFnXj0OJQVYgNe/uDDHAdAlH5lF1LFoStKh+
 WXYiAbiw3nJCkhyMuX5hyTFwEUjW6KjpKn5V4wCyWiub9v2zs+RT1dqeFzi7k4TRFdEf
 Kq7djUBwU/0stIpYDTtRzuTh6I+noiDyqsDN1pMmGDlY867mGmBVoHx0hR4G9XFc8tWl
 6sxvPXr1HKAbLkgshQXjaGxdKfcyM0I/Ev4spJCvJc0t0CMBJ+RBorltfHRskySoTQni
 55LA==
X-Gm-Message-State: AOJu0Ywe/o2r/Ei0i4IzIiVfKViCB6hObqsJhpQrFwkLa95gKkXE+6lX
 wep7Re8LSzOXVeRSSHBePDWauJWaPloilr4xv/YrsGVSyQQsb38rX/0kzFKRPe8giMBVjXKEtrS
 5VxlDzA==
X-Gm-Gg: AeBDievcDgEqogG8R+CaT9xZVumGJ/0OYBzlEUg/q1Z6dgyqLF4hrQD3LqocY4KIJGV
 1aGTfnFMPwNXoHrXrS+VwRuduRUAe7+B9noFPVCTxOh4M+1qDYcSjiHkdxkTf2h9pNP+VazzFN8
 khczg0f5eP1o8CShTYdhMtvJHK4UYix7xVvH0t9A7lPJPfm+PYsYaiEqUJuDbN+T0dA+XrefQqD
 F16X0kTI6in/oJervkyufrNaDJPqwYblKmc6qbQY7igB5oRKOkttWmMFvq0gBW62Kzdzvp8QOXg
 Es9VIQ2fqbGbi7sIQQ6eqb7zZFPvjI+ZFmS/VW6MVTMc19MTJrodRfm6lc1McKToCXlN4pSIzDZ
 GKMVdJIfNtf/lZPVKcTS+VRMNFe1aQ/iVvMHwOEcB2UclHZPwPaSQa/vbco1TvFxcktNmZxNoG3
 uhuEXsyR9EhungMULW9M8d7f+tNOk/
X-Received: by 2002:a05:6808:c186:b0:467:fcc9:7948 with SMTP id
 5614622812f47-46ef5af41dbmr4387697b6e.20.1775387536191; 
 Sun, 05 Apr 2026 04:12:16 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/8] test: Refactor FIT test for clarity and extensibility
Date: Sun,  5 Apr 2026 05:11:45 -0600
Message-ID: <20260405111206.945185-1-sjg@chromium.org>
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
 test/py/tests/test_fit.py       | 419 +++++++++++++++++---------------
 2 files changed, 228 insertions(+), 201 deletions(-)
 create mode 100644 doc/develop/pytest/test_fit.rst

-- 
2.43.0

base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
branch: loada-us2
