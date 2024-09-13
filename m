Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B218FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4AC88C60;
	Sat, 14 Sep 2024 03:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xG88nZ9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1170888706; Fri, 13 Sep 2024 18:04:57 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B617E887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4583083d05eso17012741cf.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243492; x=1726848292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzO7Kt09Ym+Jl6wcXZ/ayCXtQdP88HoaNLNVOow9olQ=;
 b=xG88nZ9nSv5me5OcKoM6EYzbRZGW5rVmURaX+yDfg07G9uza2Jje1HalOy5dUfq7Bd
 rRBLO2cJMT+jXmj/uztsk3P5jrHJse8IR+37kIeKRqT9TKBssIIpUbmTQfA95N6nanPH
 zLRryQoIfjL6ISd8yOoFoZTiAuVYLnZ9Sm5FEkFX4Ea6B1pk927WAmR0BwepLtMzDazS
 CzU0YZfBeM4er8hc+EM2BgbAQQJPJsQscYB7BlU8ALT5UqNn23o/qcLbbo6baiLph3Tj
 xLlFzUch6Af4byi8hb4goUDcLMAW3m8RMCoUgV4x5s5BjOQXC/OogaqY3fYGnFd3L62Q
 J3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243492; x=1726848292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzO7Kt09Ym+Jl6wcXZ/ayCXtQdP88HoaNLNVOow9olQ=;
 b=Lur/tJBdeNswCaKdIMvHyTFu9UIlvkAbBpGoDolNxak4go7tFPNv9JMNTUYIFAZ7gI
 UDz8+OzfOBZBAwI8WwKVLxm+38azqK/0q0cURky1QQWxTB5N6IZKl1dBqfGp1emYgVOh
 M71gDiacLOlKKFCcm8WdtrdL6fonKmWJuqCJHW2tlo640Ap4YfSVfXFfTzDmT2mUMZ6/
 kvL8yu6KUyvKQ5ODD+zsN9zR+gi4henVNsmvZm2QkQ3FHN+jN9QIUHlKt9BCkUIh4Gpi
 GSjc9ek23jXeFnTs45KrI3RTYWejVx9zO3FmB+HRyE1uBsQ/kmBiDcDherjbuZeqyj9c
 zN/g==
X-Gm-Message-State: AOJu0YyuH137JLbkBEOVMCpil/lTQ8ejk9UGGRBim6dVyUXsiAGxCLvL
 frLq4TXx+yIfs8OcCmkcC2S/EcY2r809CUQy4s9faSD2nPjhGCVYB+0l1A/2RVNvnWG5OsJCzlQ
 2
X-Google-Smtp-Source: AGHT+IGCofCApG3AVgZeMN2truhTF4ldPrlQx1yRHHRq6z5idD1RYSFoq3+ev4Me2yV+bcZonnoviQ==
X-Received: by 2002:a05:6214:469c:b0:6c5:4f37:2b51 with SMTP id
 6a1803df08f44-6c57352dff0mr115839776d6.28.1726243492309; 
 Fri, 13 Sep 2024 09:04:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:04:51 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 01/27] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Fri, 13 Sep 2024 09:03:18 -0700
Message-Id: <20240913160408.2199558-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Changes in v7
- None.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb6127..b66d49a62ba 100644
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
index 7d621031b85..2a52e15d0fe 100644
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

