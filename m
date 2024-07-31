Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB4C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AAC86FB1;
	Wed, 31 Jul 2024 19:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TrQaUx4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCFA87DDF; Wed, 31 Jul 2024 19:26:56 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4FE86D4C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e02c4983bfaso4886794276.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722446813; x=1723051613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FN1zBT1E7YnplGtBOrzIeQ3Vh43RQyc+/ZDF7ApuOIY=;
 b=TrQaUx4hJOb0ScYS4sCsv2J0KnfNrHMY2ezlyim8OGsvV4GtFvn2PbLT/B1RBwZhVY
 qsNpSS9Izhv1/2n/mid54B2yG10vnKhQwWKbHzoioL/dl4stA0lnim6yp0pFYn4uL34W
 0ejMnwkR/2uMjC9reWmG+5F0HblsmIvSjBe5AIinmifs3Mt0gy2ryhYWxMUpkNUWPWG+
 X/HrqPRcJy+sEiqYuq7NDriH+Dz5OAkhOVcdACK3lhb++F4Ep39jFzXsf+7Rg9B/nfO6
 P/8r6Vn6yan7x9VcLPRUqWyDX3yjpbm/ApDwHEIzgvX8XT8hhlRoHntMDOct9jKgf/L0
 umxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446813; x=1723051613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FN1zBT1E7YnplGtBOrzIeQ3Vh43RQyc+/ZDF7ApuOIY=;
 b=VBz1XVUl+/Y0NXWWhNGpn9JyjY15RiPpdYCFS5ZpKlnRuGXVuokPirKyJVL0nh1ZL1
 ReGy3DfWcOvu4Dj+mzIPuOjXIoY+TlgkyDP+tpZgLYATKd1YXy4Ybfe5CVvoRT3B8nkF
 v+G2mYU1Qr1OW22XKLGcp2Md69ZLo+rjl84fGwQvAu9fW4uaRNN/HgJzd3eFuziKNxJw
 dvsFWTPchnNyPR78p7RCJqbzNuIuTzpdLMgc4xjRmGUxev5+uzrKS5r7+IirwpWjSMSl
 6WRBPqk3+7z9BLpjtVh1CnybFxbArN0zP/pWk5Eau95hBE6b1YGyODfPj88FgdwJBWJf
 xBCg==
X-Gm-Message-State: AOJu0Yztf7a2bPa/C0RAuR3WyFz4PiG9sSZSmxJ9FlLgxREu/bd9KvEf
 B79iBYLPFwszABPJ2LfiNJjRHLpl3tC2s/PF0iFwdV77yKzwB45ogC8H/EaxOIWh6mKegfEPYaO
 BF6s=
X-Google-Smtp-Source: AGHT+IGIjhqE5AD637iySTjVQ5XT0MYOEGTZ8TUELjZWd/jxKMqNfyyxIofD6TF/t7h7tCpXuncBzQ==
X-Received: by 2002:a05:6902:1894:b0:e08:646f:661d with SMTP id
 3f1490d57ef6-e0b545af50emr17724121276.42.1722446813005; 
 Wed, 31 Jul 2024 10:26:53 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:26:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 01/27] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Wed, 31 Jul 2024 10:25:11 -0700
Message-Id: <20240731172556.1348487-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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
Changes in v4
- None.
Changes in v5
- None.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index c43bb51066a..339f9596b28 100644
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

