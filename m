Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7563B109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FEA083FAF;
	Wed, 25 Mar 2026 23:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h+/siIoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AADC83FD9; Wed, 25 Mar 2026 23:33:00 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E5083A1B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cd80f56b27so41170185a.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477977; x=1775082777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaboqfwrUatI90pnoDvZ02bq9KoCJRIJvO9J/dh8ywg=;
 b=h+/siIoR/tZulPzSbd8gHfnlagZLyXO9jdERxjNRqsdBq9QganHGgN2Kkxh+boU51d
 XoKkPVgu/LgaG4IgwVNqe0ChIVsepXqcHPquex2osMQqSBmdvSUnuzdAySXtZZZNmQY5
 uaBzqsTqhZaYwhF0aEuOMTiOh9mUSS63sswRVXqRgQWlsVPtCnKNlvFCG/MwWLwhkHZz
 5ZcaFkwVwboiqFBvEhuHL9U5IMkzQmJOu4qaG7VStj8/hh/t3nWDP79tLjIYgRVOS2C8
 /Fnh3HaRZYrppPlbGPL4jxdgMTL6MQPmW2fiw3ikyLcZmPyzj518biRZY7LuwTYp8qS6
 m71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477977; x=1775082777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aaboqfwrUatI90pnoDvZ02bq9KoCJRIJvO9J/dh8ywg=;
 b=H7LG+12GDwkFodel96PEHAgyGKucu2m1LNwegHPVDkIkxq0N+NtLavVQA2dbRaWjY7
 2AnxpuIxA4UOANTXYqvrY/z3eQyf6n61vPdHSFrRAS/mVN3jX/LteKylhvc4enZL5ZV5
 dQfWmivJFaQn2X5bCF5zd2gAI+73VrlFvzUUHvnirIk9Z56oIPNUNiF/IovILTkVNo+a
 1G+69A5BDpTeh4wXZcGKOLLH2NVIZon+DpS48mCh6mxiDtOdioJdrr/nCCM8FAXSagiq
 zSbl5GRRkWCa877esPp4rDhnA5hHGyHqsZ53y2/HBsIGDUB7nJiWz78Z/DWWxXy6f2E3
 1ZGA==
X-Gm-Message-State: AOJu0Yy1V8vJCHPHe5Wl+QanpXVhZ99boJw8eKLXZPmX/U5hxphkKxH9
 SGp5F/ch21Q2NV9iiVsfbFJ6oQBEjoyS56ePKICg8DP6hncYYgAqo5IWExkErTRu
X-Gm-Gg: ATEYQzz3kEtvOh0eOyaB8jfqnki1NFAAg36VQ27pXgMBoAf627SfrfMaA8JCCBFOOJL
 Ww1qimkrO9VUifYRSXw6hiLMSenHl6dN9ZJX6vfKHTxIajHDh/+P0J/w58rFyelrrqmhmmt89G0
 US2MCr0kb66/+03+wsqoRCknzlwlOmyzzLPS3VnI4x7RPFSBrqDD7OgbEzV/2oxVVftnJoFYLdC
 VvJC4kiEZilLNWiAf4clZ3zGdXPMDe1WxplHeoGuAQOxOEXKlNj2nioZZ4p3w8SS4BsTwVUJJiI
 IOAwTmsXmjCp1RcOn1a4l0wc96rWQaTN5DZUH+jY2l2tHYgsrgg8Qa0UwdbSz4kS2a4tAGCYGyE
 3XlNN0viLiO/xaTRh16vlo+tuiq1dNqcXZvdqhR+Kn6RvSQXX1V2wt/ccS9bIGjwb3gYBozVCWC
 zL3p6pwj2qHfXteWA1S3wBndkCgQNUGBnztW5NK1F6FS6oiZ3xs4wuZrzF1Bmu4rliFhGeF1cpE
 mcLiFq+Ca8=
X-Received: by 2002:a05:620a:4096:b0:8ca:2cf9:819a with SMTP id
 af79cd13be357-8d0010efeb7mr686205685a.40.1774477976970; 
 Wed, 25 Mar 2026 15:32:56 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:32:56 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 04/16] reset: k1: remove TWSI8 reset restriction
Date: Wed, 25 Mar 2026 18:32:20 -0400
Message-Id: <20260325223232.1553212-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Remove TWSI8 (I2C8) reset restriction. Since it's writable, not
inaccessible.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v3:
- Drop SPL_RESET_SPACEMIT_K1 Kconfig to fix unmet dependency
  warning when building without SPL

 drivers/reset/reset-spacemit-k1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/reset/reset-spacemit-k1.c b/drivers/reset/reset-spacemit-k1.c
index 613e002fc4f..99dce90b4c4 100644
--- a/drivers/reset/reset-spacemit-k1.c
+++ b/drivers/reset/reset-spacemit-k1.c
@@ -452,10 +452,6 @@ static int spacemit_reset_update(struct reset_ctl *rst, bool assert)
 	if (rst->id < RESET_UART1 || rst->id >= RESET_NUMBER)
 		return 0;
 
-	/* can not write to twsi8 */
-	if (rst->id == RESET_TWSI8)
-		return 0;
-
 	spacemit_reset_set(rst, rst->id, assert);
 	return 0;
 }
-- 
2.25.1

