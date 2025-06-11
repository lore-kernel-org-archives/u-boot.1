Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E86C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EFC782A4B;
	Wed, 11 Jun 2025 22:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MnlYnSLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462EA82C7F; Wed, 11 Jun 2025 22:25:03 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424BC828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a3798794d3so305775f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673501; x=1750278301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUloOpiTNLJJ/yDov7BZxm3eQF48L+xD+Qg2LA9++ug=;
 b=MnlYnSLgMqRWJ3SZPd16ODJEL6Kc/thaQ95BfmFWpzSfm1FYgYP/OyZ0karhjiVVl8
 2zJkcLDewc8iQTvJR1gCadshxyURZ2qQvOR7Krrlxc4jsQf35X+1kRWBegqnUNVaWT5F
 kk2UUGp9tgm82jfK9kxUP/TTE//yt9Or3az9EBkkvyfuLl6hzXJlqNkleYfvD51QohUm
 Wr5T0ghcX04lsiHsEBzJEdM4fHFxJQOXELEWiB4qepshImVhZKpsRoB41HsNgGMJHqfM
 T2FEsocDY0WvyRh0J7UqDlSY/ecqu9ys8w86ac+uOLu50NHiRjn6ZP/CAO5CsvLeh5yN
 lwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673501; x=1750278301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUloOpiTNLJJ/yDov7BZxm3eQF48L+xD+Qg2LA9++ug=;
 b=O4N62WVD4YBpIltNYKgzzG72mb7vAinTFN7ukq0cs9M2HMldjNdn/fze/XPe/wse6g
 qc6sHGCULPodE2HdO/e05avYi+72cvyWVkcK5Uwz4QZPlCzlZt+LzwWzKXuqiRkfv8vK
 JYrrqIg7/0XqBclL65pkl70sxEBaJjYNsDs4FzCrzXrssRhd64eKm3O7O7OZHv9lZMYX
 2uRf0R1DxiBrqXiCPje8ULjPSTba4N8Kz9svB9QM6/r70LDgJY3pjLDSMkvd4IL0h2dX
 nxZ0eVxTOwgFoV3tsVgrlcD+hQz8LTPWbv4Hs7qLZi9GLATXy9IVlCE7TVnaX+rJxuIo
 m+1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDwwG/vn9ru8gnMagS8gDBz1YmYUACaFLWXbe0pzJn8UNrdSkHIgjBBHIb15C3cSbzW96NQrQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyHJR9i9hBAQkLmS2OZZNdQfJZ1Q6ZiYVTYHk64CxCLViTAuRMe
 sc/CtQwtHtghPpEXp2esXagSxqgzoRIpNHTmmzWimZEcXsFrhgXVkkhztqujxAhxe+Y=
X-Gm-Gg: ASbGncuSdO4zzFpJllWcQXlbcOZjcSrfj+OgOPOKFibPIC0qYD5l2BZ92lhReOTnKZ1
 kenghT9eBU2hXEFfzJcZsY/Q1+dJrDat7CL8du+cwV1puJ68IXAoyDk4fhk7OIUc6MlVYcFjPOn
 pJDKEITjUpp++CaZs9gF9yQx0wRFIlOMpO4jIJnZGnq9f5CdYXrgyX+JSwLIfpH/d721Q0pP/NR
 Ei05sgzzhfITCW3fLjzHUBufbuSmibCWdsTlZId8A2C7JgwSlYii1WzeC07ugVd6uTFvAFPI4ps
 ng+6LXaFP4qAE5yXZGNGtby5uobngpmHuzc6xcjbOgqMXZc1I07r5Ny2H8R9ivFggjlOPtwkXtq
 s+VGwC4hPP9LJDps/4S3z/a/R25lo5eU4Jr/7ZTUene/mNj2Xfdo=
X-Google-Smtp-Source: AGHT+IGMXaDjimcZ3CjlAbqs+vaIRwqN70rI5ZnM9gzlKx2Rz6CTkgzB0GVsgj4V/nbI3Sz+yme6Mw==
X-Received: by 2002:a05:6000:2912:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3a5612f466bmr272280f8f.43.1749673500700; 
 Wed, 11 Jun 2025 13:25:00 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:24:59 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 03/13] kbuild: use assignment instead of define ... endef
 for filechk_* rules
Date: Wed, 11 Jun 2025 23:24:30 +0300
Message-ID: <20250611202449.2317279-4-ilias.apalodimas@linaro.org>
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

