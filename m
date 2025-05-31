Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06F8C5AE59
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A3D82BD6;
	Sat, 31 May 2025 10:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PBzFVRFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45BC82B72; Sat, 31 May 2025 10:44:59 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C313382AB9
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so23147835e9.1
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681097; x=1749285897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUloOpiTNLJJ/yDov7BZxm3eQF48L+xD+Qg2LA9++ug=;
 b=PBzFVRFmhpbmJ89zcnKmPHVpc/WMghZ0gtK24tMSnwt2JpzTG0Ki6C+UlfSPBDisOo
 0BAJbWgRGZuMx1VWw/WwNvDaqHMhQ9c/qg7t2LUDQxdqaoyuZPPhqEilYU6ASRtbP31N
 SIMwy/Er0kTYvEe+9Zu3fycZuZOiIxREZG9hEwVXXyLvGiQ/ne6+1EUxnGFhVWlx2+FI
 xk6+H7oe52F7BN3btF7ESo44kQoe31+sj5Uo31Z+jNaCVO1iYhgLcebdKRyPi61tDVgv
 ZOvlmT+1Jr11gNkY32f4VCSU37drI/UisUdSuJxOLyPmiZTxYVKMyoOXBX8pMZRoTfBc
 Tilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681097; x=1749285897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUloOpiTNLJJ/yDov7BZxm3eQF48L+xD+Qg2LA9++ug=;
 b=GMGGZTktkyAsuaVxfkW5ZxjbC+bRihrND6vG/ktEr62MsG1UAQClzft9XK3wmPlJuF
 9Nnn4WbFSHe2cGzH3j08zk0H9rh87fEttCihSdoWkewsoqTF6X9fZmBk8OmMoEVRLj6Z
 uT2dq9bBscee5nnrBUrIjaqcI45ymqM8itEFeiPqu+PBn6rSQ4A5bzHwsd3xkIJUIxRG
 akQebq9ZYBZNZK0FU32DWnB5nyod2RumpydLbgASPlwWsCFb1ftcqtRcWJ8ZXkx6RbTG
 OdVHgx62EZV9eR3IA5Caqk4lvZPeapcACJLbEp8lYyyN8e6O1NsTGwM9UDJI6WbXTNtq
 cQRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWMb84IudG1K6X8JHmORxX/2snVCnqrvmR78DBZ1qtrVdygBJBqP39rfKbLxmz9dF0eLOMSvA=@lists.denx.de
X-Gm-Message-State: AOJu0YyHT5PSvIPSCc4gnrWSDZDZS7V6CqWPeo7PfYdpyIGiPrk67Q2g
 0j+bfkCbhj8d6Z4TIiW3eEhUbGFLcZCwGgabiRQW2xPrYwC54Im7109dIDPAjGZ5quY=
X-Gm-Gg: ASbGncsB4fGznzXqm4hIZwWajjR4ntgRtJtwh41n+NEOh6EaUzzD6zPGX+uPVXOIB2z
 seyIOT2JbF2yJfaLnI78kLo+NdBtVHJJnnXv5ayCKLOCGloiBrllrFQShyyfAQK9XpObmu5Jq3z
 Z3muSb5Z56hukDP+jCyNTqfrFwCb40Y7zXaPA3jDvF6DCJvDWxlWlhINmxZnR/sjb8BOmQSN6JM
 3w5/C0HO8q1/u6BOR05WFRWchGCev3Wp1EQ1/vbyjqHzhYoKOJ9SThXaKnQF0O45u1x/8gsFvEn
 IXDV5BIE6B0Uv4X2vGLbWCJNpq9wPEDlvTV4bV31lyA70suWHQ3SvzaQlEm9vB6xPulj+cfFO80
 K6PJHNWH4rpss1hNwEWuDSOe/uKpM0A==
X-Google-Smtp-Source: AGHT+IEwERmRLNOiMvs7S3L+hs40zQZBeJ2TmVSpvYFnrx728TyU1NKFTClocVGj+DEN31/iKh18yg==
X-Received: by 2002:a05:600c:6488:b0:442:f4a3:9338 with SMTP id
 5b1f17b1804b1-4511ee1215emr9159175e9.21.1748681097199; 
 Sat, 31 May 2025 01:44:57 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:44:56 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 03/13] kbuild: use assignment instead of define ... endef for
 filechk_* rules
Date: Sat, 31 May 2025 11:44:31 +0300
Message-ID: <20250531084449.4125187-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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
commit ba97df45581f ("kbuild: use assignment instead of define ... endef for filechk_* rules")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Kbuild.include   | 7 +++----
 scripts/kconfig/Makefile | 4 +---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c0d3440a4b3e..fd7a744478fc 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -49,11 +49,10 @@ kecho := $($(quiet)kecho)
 ###
 # filechk is used to check if the content of a generated file is updated.
 # Sample usage:
-# define filechk_sample
-#	echo $KERNELRELEASE
-# endef
-# version.h : Makefile
+# filechk_sample = echo $(KERNELRELEASE)
+# version.h: FORCE
 #	$(call filechk,sample)
+#
 # The rule defined shall write to stdout the content of the new file.
 # The existing file will be compared with the new one.
 # - If no file exist it is created
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ba30652f01aa..f0f93c56bdb5 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -220,9 +220,7 @@ $(obj)/gconf.o: $(obj)/.gconf-cfg
 $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
 
 # check if necessary packages are available, and configure build flags
-define filechk_conf_cfg
-	$(CONFIG_SHELL) $<
-endef
+filechk_conf_cfg = $(CONFIG_SHELL) $<
 
 $(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
 	$(call filechk,conf_cfg)
-- 
2.49.0

