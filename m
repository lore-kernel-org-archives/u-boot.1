Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C1C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD8F8288D;
	Thu,  1 May 2025 03:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I+2cZnFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A53D8288D; Thu,  1 May 2025 03:06:04 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA825807B1
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso14282839f.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061559; x=1746666359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VETY4vcbyQ2SqOdtKfaKtQlVLlTqO/ZvxupoXgy0aEM=;
 b=I+2cZnFf3oRRrazyDEX/I+8hm2Vtwx1rRjPCiyUkbeydivxL7Gh33HKIrras0Y+2xk
 6wD9dE2drimQCLHg5IqZ7IWLh5NDh+tVPty4XXzxqx8WSFb/vODaPrnneWINR9y73uxz
 aYwNfs2U7VDVgMGc974KMF3YZjaUdoReW71yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061559; x=1746666359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VETY4vcbyQ2SqOdtKfaKtQlVLlTqO/ZvxupoXgy0aEM=;
 b=vApVsm1kQ0USjwkZyCjjwEZVfFVLxY4Fefgm5+acQeughTUGC+4AQkg5g90q5pKCx4
 SfksZpAUtDmeijk/68XokEr4VCqv0iI6LwptXr/5o5Ya1dljDBi0O2GJaeJMNYp+FMv/
 P2GHhcpYdiH/G3aXj4mHV0qaZSlrxDwaJGvAtNjkpGgCY07zpt1TtaWSkRlNS3YXveZd
 d7zDrblFWQ6YWcOZ1Efi0TZYfBqh6bCVfLZjKLsdaMZoO2yKf46Laf6Qzuk+X0qmvwY3
 cfPp0DQgTxkQVoatl+PNwTbBxFdRrHsioyttmF0RP4OsLg6MdauxdIYbwr3H4WaMs5fz
 OtYg==
X-Gm-Message-State: AOJu0YzHOHDgAS3cgtqlmQhNiOiTLfFLi/g9g39tgpxqtJHiN8gMKdKT
 Qb9aK/JFWLjWYkjmrEJ0uSvn+VOAmM0s0pioWI7+QRTqq0/lAJ9MeoAvl2M6gJsLNIT3np9sXwg
 =
X-Gm-Gg: ASbGncuB0+ZrfinuQieidjK6IW4OLWFpy8009t1gCBsGVrw3nPi8CloHe8yl2Y48Jwr
 Jj16tLJM1Jh+gq3feRDm5MCoWd2V77zmanTgS/iuBeoveV+QKhwHIyDImpd6YGixBRcvgLogMtj
 n5lx/kQZa09GSw3HWsVvaliM+3uexPMLOUOy99CDbbAMG20yBLfBqm+rHoO1tr36F+LZTrlp8cy
 LVWqHvn2g7nk8zWAF2ZSRlui8nL8T/ax2pHdGOsrzlN75rGQnnLxHr/0pVD95HqXOGejcmvMYEG
 i+yU2+brLS6SLKsjklJzrJQgLLbtGuU41AQUEfuVd1oYvtHwoP2ywaJsNuZ4Mms1QVJNLwWtJFW
 m8g==
X-Google-Smtp-Source: AGHT+IHM07F1Uteve1tioRDepgpQtAkvCWWHsTwJvP5yXFGkcWrAyDPvrXkQUHzDxHMXpamJO5BuBA==
X-Received: by 2002:a05:6e02:1688:b0:3d6:d179:a311 with SMTP id
 e9e14a558f8ab-3d96f1b1d11mr15391015ab.6.1746061559655; 
 Wed, 30 Apr 2025 18:05:59 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH v2 16/22] technexion: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:41 -0600
Message-ID: <20250501010456.3930701-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/technexion/pico-imx7d/pico-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index d0f739c624a..cf6b7fcbd95 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 NXP Semiconductors
  */
 
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
-- 
2.43.0

