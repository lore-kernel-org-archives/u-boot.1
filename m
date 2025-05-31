Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BEBC5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7E582CB9;
	Sat, 31 May 2025 10:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z4Y9RVY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2D982C87; Sat, 31 May 2025 10:45:19 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7F18003E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso1539317f8f.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681117; x=1749285917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sc8e+7YgfbyQYptl1FbQhgi9+8kDVzuVjHSK8sU+Xzs=;
 b=Z4Y9RVY/0HthMGyYcwtQjONC9B+IXre8LTFjWTmFX8jxjmX+QYghLvOqn1h238bkz/
 kn2OXdIMJUW+3ixIZd7as8o4PCG1Bo59d3+8Llsz22zgImbqMrJPwVCZtFWzLFhocfSB
 d6Z6u6j24+fdg2+Px1zY3xRo1+XTQJdLUiZyyflpU1Iv1puB+PtLgs6iQR8LfCZYWzHv
 1G4EZnpeFHZpK8mdBfdBQXeIRKba4ZMw2RTTXrQDSsWjmqegjJCR6OvV6azIclyyaec8
 RK0B4DwYS6827Lblu3ofvtb4TXIQtI4S2DdT0IEcO1DepQ1qDcjbGqvCB9pQ9hJ79szJ
 mvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681117; x=1749285917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sc8e+7YgfbyQYptl1FbQhgi9+8kDVzuVjHSK8sU+Xzs=;
 b=lx5Z4n8hEmKjLukSuPFla9e42tVNkpaeIRIMdFIXKk7drsWo3hr8264A7io/G50BJQ
 VAuWxdxG3G8eU6m5JAkTkK9JFxj7GlvDe+se/nMgP5noRBMAUBvPLtYZpiFuq2kn/zI3
 Xu7v/uvLgmk7E2Latf9ST6i8k7V5iM960Lq8cwlMMShBwRXpwpm5pdSEz1utJd82Z21s
 iDRBcQihzGRGstAvIqo+cr1HMOVYmvPWt9Tz2GVcvfPeph+Oj7ywhD+lk6C/WEnKwyEz
 1HJ3DK4wL+GktV5+QTpV0JeBWps7AwrvGnk1yhWMh8JcHX7RX8Hhui24Zt3rrIvBzznN
 9XbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd0QskGJn7zJuq1k53raxUHlEv/pU6tNe7z//mxix2Ik/e8pTkLS/suE+qPw95X78i1ucaHK4=@lists.denx.de
X-Gm-Message-State: AOJu0YxH6XUUFaHhdzmI75gSLVJeYC/GLO5hOJ1HjwvlvDfTewWNCtiK
 nD+qpjwkB2AZSLgbXFIhxxnkWRyCE3BP5cFK0SFgWv/IYpy7Nm4l1AiQ52qKZV6QMyQ=
X-Gm-Gg: ASbGncv4faYSqUEW1DE3iGJhDOTYfE/iAeI2czTq2QTgerukP/g3MIKWtAacONX0UyB
 P5y8JMHTTapB2DxorFLkkdBDgs1GNUDLX3j1WDAY1p+Jf5gZYaaDU4Cwih2zYualzUZ209MnMr3
 5cqkquBfmkzntFECWJhVM2KzRAYNikXOiArdmqe5crk3NZ67epHwdat+CgoxXPpWPnn/VpIjzaE
 bdmJ7IaRXXLRisPrIOX/ImOhbHFGj9WbvcGlVb3G+1rX/MZS+9s/eo75J9jo8KMsPF60/9hIeoO
 FiRD21dY1DLDe1fYr8//58uYpb/SjjDAEsQYDJS9rD/csMSjhER6XKBmlLwR9je6pbXDpvKHjIU
 YirtbyM7qUOmAqQhmZga0Ob3vWQ13qA==
X-Google-Smtp-Source: AGHT+IEBIqrGYu1AtN25Vuf451IJO8rI2UyLOJ+D0E28fH1U4zX5+xbRojSc4tS+uxHxgKzj0IDs6g==
X-Received: by 2002:a05:6000:3106:b0:3a4:ef8e:b31b with SMTP id
 ffacd0b85a97d-3a4f89a7bfamr4307504f8f.24.1748681117328; 
 Sat, 31 May 2025 01:45:17 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:16 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 12/13] kbuild: make 'archprepare' depend on 'scripts'
Date: Sat, 31 May 2025 11:44:40 +0300
Message-ID: <20250531084449.4125187-12-ilias.apalodimas@linaro.org>
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
commit 059bc9fc375e ("kbuild: make 'archprepare' depend on 'scripts'")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 03f88e736a61..dbf1edc39ac4 100644
--- a/Makefile
+++ b/Makefile
@@ -1922,7 +1922,7 @@ $(sort $(u-boot-init) $(u-boot-main)): $(u-boot-dirs) ;
 # Error messages still appears in the original language
 
 PHONY += $(u-boot-dirs)
-$(u-boot-dirs): prepare scripts
+$(u-boot-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@
 
 tools: prepare
@@ -1979,7 +1979,7 @@ prepare1: $(defaultenv_h)
 envtools: $(defaultenv_h)
 endif
 
-archprepare: prepare1 scripts_basic
+archprepare: prepare1 scripts
 
 prepare0: archprepare FORCE
 	$(Q)$(MAKE) $(build)=.
@@ -2486,31 +2486,31 @@ else
         target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
 endif
 
-%.s: %.c prepare scripts FORCE
+%.s: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.i: %.c prepare scripts FORCE
+%.i: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.c prepare scripts FORCE
+%.o: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.lst: %.c prepare scripts FORCE
+%.lst: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.s: %.S prepare scripts FORCE
+%.s: %.S prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.S prepare scripts FORCE
+%.o: %.S prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.symtypes: %.c prepare scripts FORCE
+%.symtypes: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
-/: prepare scripts FORCE
+/: prepare FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
-%/: prepare scripts FORCE
+%/: prepare FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
-%.ko: prepare scripts FORCE
+%.ko: prepare FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
-- 
2.49.0

