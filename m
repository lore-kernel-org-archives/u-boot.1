Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E490C5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4B582AB9;
	Sat, 31 May 2025 10:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FhsYpmw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE76882B70; Sat, 31 May 2025 10:45:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00C382AC4
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a37ed01aa0so2289959f8f.2
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681107; x=1749285907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ww2jkm4IOV6ODtj+50YOwD56/9FRHbj7rWwKw1LxU1w=;
 b=FhsYpmw9XJ681MPPYD+ifZoF49QI2DxiGsaPMvYwFxBVt42k4CLWMHiI5G56KHMtC5
 jpoTiy3kpXwZGYGuUjVJjFlgCzOP4sYLFoS7Swig3KUlx0h+5t+9tPXa9IwNUG1rENNg
 dQALaFSaDWBwQSLrlVyBwHIaQIg5mrE01NMFCE9yTE6De8DerJBU+pOAeQddvAZUZx6m
 Kkr6Ynme1MFybigaOrtiG8/OoTlwe/uIn9xfA1YJflBu497QjQPd2tjO7mqsJvGZ9yoX
 46igoZ8kxtXqXLiZVxoG8lzq0UqKVWyTQhZizLm4zp1vFtWv1dMZHtT7YR8g8BTm37CV
 6wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681107; x=1749285907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ww2jkm4IOV6ODtj+50YOwD56/9FRHbj7rWwKw1LxU1w=;
 b=mIhQS26r0rMV8efRTZA54LetFjIDo2wWo3MNulJcuFL/8fIIlm0fPncfTT71Yolxcl
 dstsXSd1OR6uzHeoD60mL88jnICo0C0rn9DQbEuyu6Gry6pysJXmMG9HgnfgiuyWSBL6
 J5q4GcfHCpz7i2ATIndHyPpjvYD3IDLz6AE0e/BOk3xc+xSNOoVqRoyBTEjiNXvOmUev
 Tq92haqkZWYZk+WsyTavxiJ9peMyTcrYn++raciUdruP286L/8jKDuDmqfcWp8BERoaT
 GFb4czs/V7eD86jdlbv/IUJPjPXRLYOpR8Od1V/452WXxhUqjufX/WbR0C5aXppb9B8C
 Vp8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjvJqgmNDrppFWu44BVnRwYrhp6wbJBz/LUG0QC4s6c25xd8QJV7OHacyb+REQvVtYufIFmco=@lists.denx.de
X-Gm-Message-State: AOJu0Yyidw7X0lBy+1qetxaA3IXwxd2DCGCqcIF75CCawR84MSr8H4d0
 r2tOr8bkohHKeQ40bbbkwtUT2DqVwfQ+lNIb66GZDl1Cc4MiCwlukpXf+vxZv1WOupY=
X-Gm-Gg: ASbGncuZoqUib2glVVzJ2OQuPNqZ17UZFAGWJDeHABDQrefIXFCVt5aJD5jzOao/IPi
 JZnIFDkOz60ugI140cgp6U4qmi7avnqb4RZFzTtE8jJ+DV83g+PULA3PhdVCkOXVHJfWtDrt/xj
 YzzKkxb72Ud2jf7RsUjWXLHRYZrEQMpOZmGnY9iP4N18DbYlefE6Fq0elQ2jypTXO+s/kwjJylB
 ++91K6E2gVJjRvnM4RO9c6jvxQiVJk7tCmzbZ9hixxs6eATVfJZGNQHRc9pd8aXtUdvBthXOOTd
 kGvdZv5V2hP++ct4daGIvR2zdZJ91sW2DDgXxpWC7xkHSwjPSeTY1nIN19s7tW8GC/j9W32euaz
 V2pqvaKzOvMfLeQgVjh+p+wk/Q77WMw==
X-Google-Smtp-Source: AGHT+IFWjiQUqsEbhWXzQiKAJP6YubX8BbetJ1Zhul8akhKpHfYdFXl2SP6cSLc3tN60cpaHMuWYRQ==
X-Received: by 2002:a05:6000:240b:b0:3a4:f24c:d719 with SMTP id
 ffacd0b85a97d-3a4f7a816a9mr4536519f8f.29.1748681106922; 
 Sat, 31 May 2025 01:45:06 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 07/13] kbuild: remove meaningless prepare2 target
Date: Sat, 31 May 2025 11:44:35 +0300
Message-ID: <20250531084449.4125187-7-ilias.apalodimas@linaro.org>
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
commit 4f1c1008e786 ("kbuild: remove meaningless prepare2 target")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 6758ec4103e8..1f190b40ef2c 100644
--- a/Makefile
+++ b/Makefile
@@ -1949,7 +1949,7 @@ include/config/uboot.release: include/config/auto.conf FORCE
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare0 prepare1 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1964,10 +1964,7 @@ ifneq ($(KBUILD_SRC),)
 	fi;
 endif
 
-# prepare2 creates a makefile if using a separate output directory
-prepare2: prepare3 outputmakefile cfg
-
-prepare1: prepare2 $(version_h) $(timestamp_h) $(dt_h) $(env_h) \
+prepare1: prepare3 outputmakefile cfg $(version_h) $(timestamp_h) $(dt_h) $(env_h) \
                    include/config/auto.conf
 ifeq ($(wildcard $(LDSCRIPT)),)
 	@echo >&2 "  Could not find linker script."
-- 
2.49.0

