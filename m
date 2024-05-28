Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E25C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB90884C8;
	Tue, 28 May 2024 16:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5rIf1Eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D48884CE; Tue, 28 May 2024 16:10:33 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3655E87D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-794ab4480beso61009585a.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905430; x=1717510230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQUyzEG/JRZtm3EFLCUqEKsysGKnPQx+WzNp+6B1dHo=;
 b=E5rIf1EqXso/Ebc0i019oV9PeI04yf4dXyfdXwaEQKEbtYSntELsBYRz8p1KdeI3gg
 48R0uwG3ZyoQbryGVybvvdL2T+unSrbQJeGjWghd+kWXoKORTXv2P1IKlUmkzfvDRIzL
 DDpaXsIUz1FpCuB7hWvfmX8A97s3eZhPx4c/bhtsrmkXB/zfNdPiRj7igWZlcq8z+JoW
 h4nvtwUbb3grbdXNGxH9uDIcxDdt7uxsId3FNpYPK4oCP8xwJltZwl/DoofgOqL71Gn+
 a228MwWUsi6txHLLryLpUPm4ybiqxehJ8pdN6F3wK5Jj5B0PVGKaf1cADi4NXESmyptA
 buuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905430; x=1717510230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQUyzEG/JRZtm3EFLCUqEKsysGKnPQx+WzNp+6B1dHo=;
 b=cUDp43RAmB2WZL5YS6FPfNBybRRwe8jcRjoRv9Nrk2JtldDTJBKiY8/llXG+x6ASzY
 +GEAy9iLTB3AwHxNs3MoUJxpnzCa2VVt+vm4wSKKy7t3EqOfzIaL5MhVGLQM8NdHvrf/
 qz/gccpWFxq3fDPlZhm4YccF82ZDlAzolu6JTY4EdMMywjSzLdRPEe0Q6a0rvBTX57am
 lIzwFxgbsFykvZMgZY1+eCP1PYDnaCMmuV4ayWQRUaJwMfpT97+/MdCn3/yHLgFk8dYs
 ngrkRW6YV1tfQrcoB9HFtvjbw4eSg/CM+/KbmAlJdHydi3tJFyL/qmdGN3R2wtbmb37a
 p3Ng==
X-Gm-Message-State: AOJu0YzyaxJoEJKzTuuTZnry+fzSVV44Cy+1bCeMRcFF63OcnHXKgg9H
 GxCxVTCjnuhsYg2Vb/Y7tzAT1s8MBxazOzBrWgz3t8QsHAxllzlTe26j/jvv7xU8ViPw2sCePpJ
 nT6Q=
X-Google-Smtp-Source: AGHT+IHpaZ1oJOCUpDQCoAzxLjFJoEcYkkD5NfCdUC/3GTLWx/jT55MVmsE6O4fRQXJiHRs6BblqZQ==
X-Received: by 2002:a05:620a:460a:b0:790:9929:3325 with SMTP id
 af79cd13be357-794ab0f66bfmr1673181285a.51.1716905429780; 
 Tue, 28 May 2024 07:10:29 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:10:29 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 01/25] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Tue, 28 May 2024 07:09:12 -0700
Message-Id: <20240528140955.1960172-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 27f69583c65..c8052771fa8 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/
+                  :^lib/mbedtls/external :^lib/mbedtls/mbedtls_def_config.h &&
                   exit 1 || exit 0
 
   - job: docs
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a833..a8f7f1940f3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -156,7 +156,8 @@ check for new CONFIG symbols outside Kconfig:
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

