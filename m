Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2AEFEC107
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9830F83981;
	Tue, 24 Mar 2026 20:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WihVQCTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CCC83952; Tue, 24 Mar 2026 20:43:31 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42891807C0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-41576c5c01cso945016fac.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774381407; x=1774986207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ztvdqHZ+etV5ybfDrYqlUDfJtJzdEuvsLfHBWRPjR0=;
 b=WihVQCTmYxZ3StDNLwUCBRKnFqNwA5kEJR+EVZWIyfPs8lClZR9Vr8gj5n/ie8Bz1z
 czGk7VSVLlFmcUayuXBwjllCpqG6o2s+CI12wVMWwZFf/S4xtJe5l//azq40NAom6NwI
 E0vlSqK2kzC+u8OMliYEYjo5PiC+ktXDHn/2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381407; x=1774986207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ztvdqHZ+etV5ybfDrYqlUDfJtJzdEuvsLfHBWRPjR0=;
 b=DwVNMwLn6Pa9JBK7pVpCQuyP1XOOB4HIGQOnyMkaRGARItWa6WJjyYTniRjmMKN1pA
 d5sd+v6Z7XsJq6pD9+cr8YOdi2W1isYOp3inKm4Em56GtpmMjk6PrN4Ovhgz1fLn+hOr
 G0Ny/HEXcJtg7+DejkWLLEZOjSms4/KiQXx+WOSc9YYLtV4KzsqNIyGSXh5VF7po6kYB
 FEi5e8f5lxTrNL7Qb7afbX2xVHRMfmJQrMudrqHBpV2Maj7hZdYIy7xZkjooDj4tzZxZ
 2f9tj9CBPccqQcebiiXIaioeSTG3ySYhakLgfETVdHYVyFtKZweBcTpWIYNXAo7DfWSf
 BtMQ==
X-Gm-Message-State: AOJu0YwnGx/v3zpdhFwxePP4w2oFoVkZDoU0KFmRrNyiLD7DUmR/5dTS
 Eq5pFNYacevZUWfPWQY6I+2l4KRPm90Nk7lXnlTSZZEPDjJnNkvfXaeVB+RFIcZ1NKjekLZhtu0
 XWNQ=
X-Gm-Gg: ATEYQzyE89lYf7pW6iUjNhPlc3lA4qLyhhtR+EpnL+UZCkMIJluMQnB/QMb24Z/1Y35
 BckDhgVneiy4W31BY8kuDRUhc6joWCLtgVYgoZe3xAZNDk4sNAYGi0s7JTMljofIa0YjaMoqjAY
 YM6gU0oeUcjnok6pruOOjNIZDLObDSdc9OShtQtFyVrwN38tCsFzWqmfhTkL2bHTRNLkZv8Fx+v
 94qiLCSm6FLjxXim6CJD/Hx/PY06dzbMfSOKGRDWmA8QcSWNtPs3Rlj3aleaobT6DzMZ2yFzGJZ
 k+MRq1PYqhLc0XcrdN9MWc669abTvHDmp4mGvVb+z3thDOdQF5mnqvnrbb7XtMgdAtphvVcP7zB
 pYQYGB4e1avUB9/AwZwIRhutBnXwnQSfTrcIyGHilrfR0Azhdt0Jl5m3u8DOrpK2HdXRG8UXMkU
 2Fas95Yp5uvSJdhPzthjoc+2OcF4eF
X-Received: by 2002:a05:6870:c104:b0:409:68f6:569b with SMTP id
 586e51a60fabf-41ca6dd4357mr530384fac.12.1774381407319; 
 Tue, 24 Mar 2026 12:43:27 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c88218654sm3714784fac.17.2026.03.24.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:43:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] test: Refactor FIT test for clarity and extensibility
Date: Tue, 24 Mar 2026 13:43:15 -0600
Message-ID: <20260324194323.2335679-1-sjg@chromium.org>
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
maintain and extend. It avoids unnecessary U-Boot restarts, renames the
main test for easier selection, adds a missing-kernel check, fixes
Python warnings, converts the test to use a class, and splits into
separate test functions.


Simon Glass (6):
  test: fit: Avoid restarting U-Boot
  test: Rename test_fit() to test_fit_base()
  test: Add a check for a missing kernel
  test: Update fit test to fix a few Python warnings
  test: Convert FIT test to use a class
  test: Add fsetup fixture and prepare helper for FIT test

 test/py/tests/test_fit.py | 403 ++++++++++++++++++++------------------
 1 file changed, 216 insertions(+), 187 deletions(-)

-- 
2.43.0

base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
branch: loada-us
