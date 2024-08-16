Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE40EC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 22:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F4C88C35;
	Sat, 17 Aug 2024 00:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OW447CPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093DA88C13; Fri, 16 Aug 2024 23:45:14 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C49E88C2F
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6bf89e59ff8so1048126d6.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844709; x=1724449509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDt9WA9sQEzd6yRVIezJoOGCxgbfg7DZWZ8Ob3P06hM=;
 b=OW447CPVpw1/50YGwoL2mcGQCc+dd9AJY4Z8UuBmMB/BXa1rJF0vMtKLD5goZzmwU5
 hca2eAewQCTMTrhCX9U6i8tJuyE4gWgYPajdbcqATNPKhoG7VOPexHcYsEueUpSpm5N5
 7dmqxjaz+I4uz026dr2BZh8fGj9TQHmXj67JjBR2J0fmjm9ohs+QykFCIA6GTIWRAtrj
 ue+YQs4RLJttyXnsep9eZn0ERJ8C6Agc6To34cB8TYMoJAacSokq7zHnpYMEHF6QYBp7
 IJyRdTSlt+TjRWPhLLkZzMZGJq+Zb10W5QJUaiRIwc8I8PlqPqXDpzzc/RAtRcD1bC7v
 k8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844709; x=1724449509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDt9WA9sQEzd6yRVIezJoOGCxgbfg7DZWZ8Ob3P06hM=;
 b=Dz9G0V6dkyl7HOFktnA8V8LRxpFA0UoMZutVe0W14My22Ro7KypWRhTik8JpKE66/5
 rrngTQoYPkaP5LHcHGxD7R+dkCf02b43vveeJrP2PpvESUkOiVZQuP8bU+4CCKUpMvTE
 tDzITZG2P6M4xYZQhqNjvV34z6o9Vh0psPXgSor3uBcLQMq/8CwxF4K/LOkc82eF0QuV
 W5ZaSosHT5qxTAGUXPkxrYRzscraoOBXQ6AvHWr1KodNOQEvP8WJPBaS4CVNNqjGZuma
 ulaSi5Hcp1zvNGEIpoGmwVUzBVcjZlWRW7M4ml0JC+TAZFZKYSTtu7/TIxlB0MgI506m
 WeNw==
X-Gm-Message-State: AOJu0YwORAUFY9N+Sg4RASEx0zbMB3CeSCv7t6a0xJj8yakGpF/u1K8e
 bFIfVuKNLZN4rYM9nYbprNeaujyJ4rj43mXZwGyNNXCrBjsX4EOsAWd9EAmhA9SFBazw9vM2Im3
 cwII=
X-Google-Smtp-Source: AGHT+IEip8FSGachFMnXTmUwcU0Q8MOzOQ5hn3jWCBfMowFHaNH/35t13xZqscrPoBOss/FDInqSbQ==
X-Received: by 2002:a0c:f40d:0:b0:6bf:6f67:2d27 with SMTP id
 6a1803df08f44-6bf7cee6459mr40135996d6.27.1723844708850; 
 Fri, 16 Aug 2024 14:45:08 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:45:08 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 01/28] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Fri, 16 Aug 2024 14:43:50 -0700
Message-Id: <20240816214436.1877263-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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

Since MbedTLS is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- None.
Changes in v5
- None.
Changes in v6
- None.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e1b2f87b974..17dc6398e66 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -76,7 +76,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/
+                  :^lib/mbedtls/external :^lib/mbedtls/mbedtls_def_config.h &&
                   exit 1 || exit 0
 
   - job: docs
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0a15b7352cd..c04aa8dbad4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -159,7 +159,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+        :^include/linux/kconfig.h :^tools/ :^dts/upstream/
+        :^lib/mbedtls/external :^lib/mbedtls/mbedtls_def_config.h &&
         exit 1 || exit 0
 
 # build documentation
-- 
2.25.1

