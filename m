Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B3AC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AC982D2E;
	Wed, 11 Jun 2025 22:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGLFSyZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF3882CB8; Wed, 11 Jun 2025 22:25:25 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A2A82D2E
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so246247f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673523; x=1750278323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/JsFnX9nYTxK/H9GGWkEAtg/dbhMTW/CzDsRF3YLDA=;
 b=mGLFSyZRXw7IriuLE0YF3GHcDxa49NvlURQOpprVYZWYbEdgWAu9ncDXsp6flXCwOT
 Te/Xf1JhdQtk7EbdsifYXPHlkWqmqWM5onHPl3E4Ooy7W1GAJKDnXFwS7vhvokuu841p
 32CqZNNXGqdZ2HNJbYabBo7IbFc4f8QxDwrfT/GqCsjAZeW3SLPoW8QcMeIrRzyWL/x3
 5qT7gWcNs7yqCvf1O+yOL6n+9DLqTn++uymuT4QCI/G0r7MLl1o2SXlLEPZ/4n4ufY6Q
 Nohbs7zHB5dyVx8n0TYLivNGvsLksIk9X2KKnfXpRqXs4B5ahibud3V6OrcR6zt7dhNN
 tBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673523; x=1750278323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/JsFnX9nYTxK/H9GGWkEAtg/dbhMTW/CzDsRF3YLDA=;
 b=ti/FE7PU+EoC8KkuPt+XRSj+RJ1gu8LuczP9SRULrdNuzxJL0SpPqyz7/s1nBKwYU1
 2vnz1I9jurzV5unHonD9FhwTheHPoEvZ1zYDrQxlPfx92kE2/HM1ztzXw/Phvc8EIf17
 koE9txhYDGBxwF3QyIsuTbh5slMVjf5Dnz4QobuRfaQ7e6t2eBtTYlBcAkXeiq7TDQIE
 uAAK7GPCmEcnyb2l2NkNhQp8GdPSaTEf/eH5sdzW2GCDPR5rlAyj2FzNxQToj2D6ShE9
 noxuiZb/9Sry8JPXExWdQfjMVaFW7dZOpVFCZ6otJTrL9bk5rcofJkLRzGviSpKH0pY3
 cgLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgBDsDKMuoGYj2esUGEJOsbvRQbLJRKPjpPM4eL+r/0W8U9jBsIbLQRXZd/BJk8+Hp94WhnEM=@lists.denx.de
X-Gm-Message-State: AOJu0YwAjUJk0XT78gRviOU+NX3FMvIFnZgRP3ijn9c9EaJObMILV1P8
 3oJAwkV538zlqTrIRZ0wu8k2oYHp0no20k3TZDgk+Wh54gAV0GSdws2xt6XXtNsaeDY=
X-Gm-Gg: ASbGncux4zH2TmdpYBrkYZffBYT90xiYqPbrDYFUqCozVgbNQRMzBrj5vsdgV+G6ZCa
 RlbCINy8j5xdlcyiXT7ENk3K561B4UFMWaMoTgN7H0e/Fb2PDMQ3aXF93aid90wmzBsqFgxLDcH
 Hn+nwiv2qE+qZe7zsHHUqSoS6vSpU/wUdBsXvh8y6q9n4BTgOfTZJ+D6dA1QYbXgZ8rv+HSd6VR
 T1zkImAry/Jq20ANqhvtgX+WrWPMy607u+9NH0/giLYFm1obvJme17JryzF4Xcz8xcg7WRm63mR
 SrRuP4+f/vlGqOQ6e3wcMOWuTNnEQ8QbkZ9yb+KH6Oi6OYtZDAabkTibOGz3Anjmzmrtq59V0Ts
 XGmwhQ9gNyj6Z5BrQ9mzzTCCgtjaPFMU+hPMQF9EH
X-Google-Smtp-Source: AGHT+IHMlkSvTUOE6hG4xh9mnD/9n06NDWn1Rc3TMMpWAJZ4Fk5StEkG+zGYzk0e/CUnMiGmsV0rtQ==
X-Received: by 2002:a05:6000:2909:b0:3a5:287b:da02 with SMTP id
 ffacd0b85a97d-3a5614c1aacmr219425f8f.40.1749673523563; 
 Wed, 11 Jun 2025 13:25:23 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 13/13] kbuild: fix single target build for external module
Date: Wed, 11 Jun 2025 23:24:40 +0300
Message-ID: <20250611202449.2317279-14-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit e07db28eea38 ("kbuild: fix single target build for external module")

It's worth noting that crmodverdir is empty for U-Boot.
Just backport it to make diffing easier

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index af8129ccc884..a9cba5b6e076 100644
--- a/Makefile
+++ b/Makefile
@@ -230,6 +230,9 @@ ifeq ($(KBUILD_EXTMOD),)
 _all: all
 else
 _all: modules
+PHONY += prepare
+prepare:
+	$(cmd_crmodverdir)
 endif
 
 ifeq ($(KBUILD_SRC),)
@@ -2503,15 +2506,12 @@ endif
 
 # Modules
 /: prepare FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 %/: prepare FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 %.ko: prepare FORCE
-	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
-- 
2.49.0

