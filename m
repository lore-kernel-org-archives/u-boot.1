Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ED0EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7895084120;
	Wed, 31 Dec 2025 20:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hfMrMn8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA5684131; Wed, 31 Dec 2025 20:11:14 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3518408D
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D8F003F863
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767208271;
 bh=P102rswwvO94fI0y/XrZL8+0LvsF+hK9sKTcNwk5TqA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hfMrMn8UASrkIUU2UKOvTTepSZK28QLp6dGsjS0TXRyLmCxsKuWmtouYVnuwYmBU8
 Wp97H4suL2kDt4S+wjtOvpex0zTeDf26/ZPIoOTECIFFQ8ydrOsRL6FtQG9uolQ5eK
 vTa9UOXXfqim3VTHIGZ7KJWTTh8+SlzFF9ttCLyrXp8LF1h9WqhygOYt3aOvO9L/OY
 aQAzyImw/IKDz6Cmu7UlFRQFS8FpbiaoTOO67zhRSbttk37RkE8dve/+H0keMkQMBE
 WUBEPI2wOan9aOWUBmVpq+uIHNwblcEu7nXsl5gUJ2R+DPSCe5J6GpPPfE6aqXN1sD
 W2gX2lyxxZ62bneCx3umSC1413KRoRjoEcrqVpZtVr7rgy+ceFWN54aFpyxnj1o/tJ
 hppzjLJzTwaA5Pp96lLD4gwsc74WuJ4nC+7jltrBDnfVIhaU3g7J36S2rwxN2IdW2O
 ZvnI+SLBzlm2Vb1zAqyVMYQdCyR10OT+jrCk3l0hio/QDLrhuj7hVoN+Xo5Ke1QTqq
 w2ISidNZLqiExdGUxuAM8VMsNTXpS2BnmrW5kf2ZgBkrbxMSzjRfCIQFz4CrQm4Gzl
 vCF3GnRj6QltpWou+yO8OsTegCYcFcXi9ZOdP5FD+O7Kft5X53mm7Y7ctKdMUKFD/f
 w4AciVV6KoMpJ1tSiwrcjGXQ=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so87269705e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208271; x=1767813071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P102rswwvO94fI0y/XrZL8+0LvsF+hK9sKTcNwk5TqA=;
 b=gU3k3xjhJNKVtYSFAklcc6E7am3gQHrEIrIZt7oBuOXijAAQdcv/N1kqv1zNxx7aWH
 7SlDBz5CLlAPM3Oeql1nj9AmDDoIyoWcR/V81/TfmFHWZTKBd6MB2xW/HHvbRDHjydIa
 2nbJB07gMgWO8ka6ovruomLhuuJ1/itXbGVaN+ZVhFv5LqNkoS2GbLkLaqz2QDgxlYID
 qnIiCQMQ+1z9mEAC3yCh8BQAYze4192b1FFm8/3b7SvSeE1sST1ORGi+J2SOhyquKMmY
 HQ3LYBvLqjkrmMXKn80Ze1PhTB16VpsrVqCLD/ADVUmraXN1kIjRKuUk7lG1SMKsE1pY
 QSVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh84axHDhmZ+TRZMzaacYNmFjtzQqQGU8gcyvAZsNGCq+6honaLj/i/vBa1eLzGc/wwdagSyE=@lists.denx.de
X-Gm-Message-State: AOJu0YzCPnLXZq2apZXijLQ73/6JPWGoqPyC5O36/yqrAAh71XkSyvu+
 GRgP9bJmE60Xg6+Im/WFs4i4+ThKfkhh08E79MaJmrAj2Li4Cc++RG8qZ9/mTZUXhHSzASW1bFA
 ZcjI8TFJ5JuJDWJn+PTFCorXZ+BrcuyijUwO3Qle3Bn7NcrOC7XFSOJaHbOK1dtm+IzMXml4=
X-Gm-Gg: AY/fxX7oBsQ6eOKFkRVSJZ1tHPMjcPgP/lKF5huR4kOzyaEGRqAsrK/XToJ2nrIl/Af
 5fqnFBiTxQPDojOn6zxMUgA/Mw3zX8tJkmJbegsgJBO42IoGTkXH7pvf2jA62u+5lInxaiPNqcT
 s6bLRPtw8wFGtkYLxX8q7qnNb3JFjEb3WjtVVkHxuVYSCby7X6ms9bKZmFfDGLMfGZ/p6X0Ek9w
 2InREMsd3l4bIUY1SZVNqnjr4PX3+mWRBJ6l5GqA9g2fVjNGmCzIhZmoSn6t7qDQBDZwNrra6w3
 nvVedYqreTtytD3Pp1Lo4FEOMyYYY2ZNaCLyVlZXGFfJsWa/XMIrkQhk6LWYuQ7iDaM4Gc6ZwJb
 pmK4v6teKej0bRFneKqsvOnPOxEpTTVbrwFAw39z3emfqCVrvufkuL8DsMzvscm2LEc7He+fpRG
 nL
X-Received: by 2002:a05:600c:3f14:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-47d5e02182dmr78982955e9.5.1767208271417; 
 Wed, 31 Dec 2025 11:11:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuTwxUYnK04GBgNbLZcJk7WHsZ/SaBZS+TPsJFUZnlHgKx4DSKIP1J7e+dEkMOxydyhwXdqg==
X-Received: by 2002:a05:600c:3f14:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-47d5e02182dmr78982645e9.5.1767208271025; 
 Wed, 31 Dec 2025 11:11:11 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm701685995e9.5.2025.12.31.11.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:11:10 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] Fix CONFIG_CC_OPTIMIZE_FOR_DEBUG support
Date: Wed, 31 Dec 2025 20:10:50 +0100
Message-ID: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

When trying to build qemu-riscv64_smode_defconfig with
CONFIG_CC_OPTIMIZE_FOR_DEBUG=y it became evident that the build was not
using -Og as expected. This is due to an incorrect update of the build
system with commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1").

The first patch reestablishes setting the build flag.

But now the build failed due to missing symbols.

We have opted to prefer 'if' over '#if' to more easily see problems in
contributed code.

When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y the compiler does not
execute all optimization paths and references to unused functions are
introduced.

The issue is resolved by using #ifdef around os_malloc() in our test
code and adding stubs for live-tree functions.

Maybe we should inject CONFIG_CC_OPTIMIZE_FOR_DEBUG=y into some of our CI
builds to ensure that building remains possible.

Heinrich Schuchardt (4):
  Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
  test: do not imply os_malloc() outside of the sandbox
  dm: add missing includes in dm/of_addr.h
  dm: dummy implementations of live-tree functions

 Makefile                  |   5 +
 drivers/core/Makefile     |   6 +-
 drivers/core/nof_access.c | 246 ++++++++++++++++++++++++++++++++++++++
 drivers/core/nof_addr.c   |  37 ++++++
 include/dm/of_addr.h      |   4 +
 test/test-main.c          |   2 +
 6 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/nof_access.c
 create mode 100644 drivers/core/nof_addr.c

-- 
2.51.0

