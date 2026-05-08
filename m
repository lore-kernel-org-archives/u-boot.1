Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C23CCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E2384D73;
	Fri,  8 May 2026 18:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLYoHtB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD1F84D78; Fri,  8 May 2026 18:23:14 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B3184D5B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so1776839a34.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778257390; x=1778862190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qd0lFrNgia3xt11lvXyTMTwJ4JVGX0Yzc+WztkmvhLY=;
 b=QLYoHtB45tc7mCJ2l3110pcvGs3D/IyIw5nIhzD0/1NfYBFOPWF/5cYIK0hVrSuTRy
 nAZ79M6yE8amZSVSA5R/X9MHvQCTD4DQDOGhpJbvZabMHNg3Q05S0LJTmraVbBdNyq8b
 OkkimttxB6RrK2qDy36IjtnVYSMMNjw8YnL+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257390; x=1778862190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qd0lFrNgia3xt11lvXyTMTwJ4JVGX0Yzc+WztkmvhLY=;
 b=bHc7fEcwRh4A2qY43yyPnD+fZAouAE+rdVjMuYGthcQpCc3s01kZ3+tjHIIiA2VCO5
 ts5vDqP95e80A1ib2aOToLTp/ebBzp1Q1/cZoY9jrIeJRp16XcNMnurKCDLgINIvNfSO
 9O9poT92iq5Um+IfBjpMpFDYqh3zHEkcH04IzCP9T/KIrucERGZmFLaXJ1Gkb6IGNkBE
 SJbI34IBZB3vH/rgpAQXKFyKFM5Rj/RmkHYs41Jh2lC0KbV9xDaP/sDiYXMdcH8VPLmM
 mTZEFykZZ9KO4Lki9qmttqBqDwnHFfhPxEglKzCh1+eKAc8685PrIXu/n5kekIIvrOrV
 KS+w==
X-Gm-Message-State: AOJu0YxxHDx5jmKQA801PLOUvTmPPdX3cjLA3PzyKO/rD+1uhHb7xihm
 mdJI9tYn1nph8BbOBVa+7Oa/W6YHWhSTXhlZf/RdcgaDGteNEkzBkEfRTuagruujDaxpnkA5Bs+
 yXBMAkaUs
X-Gm-Gg: AeBDietDoHeU8LI0AKUlP95xrx+yPhWtziuJnkKe88KAblkZ4YRzoS7hatCWfETm4ba
 Eju+jzdYen5yI8Cf1mGYMXFHRf8pd79/gcqsmf8mhKGDgtECApXbSbzQHOHFgLohed5+DT96zqU
 5ZUVNkEcXrav09fjwNBJQuvhnXw5mQo+tOra1gWEKVCo5fOxt+Xo6Btlr3ey1xXawSqn9RotKrD
 JIUZN1r+dQIcpQ+kyfCDPRWUomEyM2j7tL9NGqpSft2ylEpy+xNjlWUZJmHq2kGLyA3mMG8r2SQ
 qdJnk2VNZ+sfiuZIJNoZctl8/tb29eAnN1ed4jGyac9Q0eqSJLJgD0arjxTZrD/n5xpYM1CLNz9
 Pakv24CBUCZ3N5o2kJmzi+Qr5pd7XVk2/X6sdCvXIJozfHCGV0On4Q+//QfcwjlBUvjlzgIYnKg
 pIVVq6qBWKpJREV5CmbQ==
X-Received: by 2002:a05:6830:6ad3:b0:7e1:cba6:9837 with SMTP id
 46e09a7af769-7e1deefaccemr8314084a34.6.1778257390074; 
 Fri, 08 May 2026 09:23:10 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm1436337a34.20.2026.05.08.09.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:23:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/1] cros_ec: Sync with upstream Chrome OS EC
Date: Fri,  8 May 2026 10:22:31 -0600
Message-ID: <20260508162259.2302319-1-sjg@chromium.org>
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

U-Boot's include/ec_commands.h is significantly behind the upstream
https://chromium.googlesource.com/a/chromiumos/platform/ec ChromeOS EC
tree.

This series updates it and provides some fixes to resolve the resulting
compilation errors and warnings.

Changes in v2:
- Drop patch 'bitops: Guard GENMASK and GENMASK_ULL against prior
  defines' by restructuring the __KERNEL__ gate in ec_commands.h
  instead, per Quentin's review
- Nest '!defined(__UBOOT__)' inside the existing '__KERNEL__' gate so
  U-Boot skips both <linux/limits.h> and the local BIT/GENMASK
  defines, avoiding redefinition against U-Boot's linux/bitops.h
- Pull in <linux/bitops.h> up front for U-Boot

Simon Glass (1):
  cros_ec: Sync ec_commands.h from upstream Chrome OS EC

 arch/x86/cpu/apollolake/cpu_spl.c |    2 +-
 cmd/cros_ec.c                     |    4 +-
 drivers/misc/cros_ec.c            |    2 +-
 drivers/misc/cros_ec_sandbox.c    |    2 +-
 include/cros_ec.h                 |   36 +-
 include/ec_commands.h             | 7784 +++++++++++++++++++++++------
 6 files changed, 6299 insertions(+), 1531 deletions(-)

---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
branch: ec2

-- 
2.43.0

