Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A5DC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98A688749;
	Tue,  2 Jul 2024 20:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PbXlzfuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066F88874C; Tue,  2 Jul 2024 20:24:37 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E56DC87C86
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-44634afb2e7so36221701cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944673; x=1720549473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HdsglUiGxuB/WHfmbt0h7ZvLJKmqtq+FeYl8npHyKk=;
 b=PbXlzfuv8W8X94NAqxe0UCMipAMwEOhnMKXfh4+xKDAzIFMDRvYcqZ7P5idsfxtEIq
 CRdBxc3jHVVn8Iay8jRRc76gx1S8m2UtL3p0E6DYO8SpsnDYMpEhObz1r4+xs2eKEoL5
 4FzS2WTTYRuYfOj6OAWaWDjWuJ/90KK73+gWerkTBcfrdzFx2k3QKoclsabsvWNQd5YF
 rIx3jjfLH9vyIS0w8o67rh1JV5L+xmYcMBuBT9oAkZiXgx6HuUPskd1eZkjHyjMitTma
 E9rHUUc7LRdz31uQ7Ah6pNJRegbV/ERvwaP6uUbhIEEAYo33Qb7DxNjWw7mD2VR2iTND
 wS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944673; x=1720549473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HdsglUiGxuB/WHfmbt0h7ZvLJKmqtq+FeYl8npHyKk=;
 b=l9sjsbOas7JzA72nzasbeLxROxCnWiQb3VKrsPCEB9CnXFVYOfWjmnNWVwJU1N2Xac
 YuZHOxs71MGY8a6k5XaCKDbIirJbGYNE0Nj7oafsHs26CnBZE89OnHbwkdR6RSSqv7S8
 77kG9OtFrGsJgwrq028sw4W/onyNbgsYyDI7oAP9F1wA1ddPlZlD7Y4nBtLC9vLnfbnL
 hHqgAcChAfu5f6secGZuwmngVwpGlnB8UxSyg08yF+c1Yi4O7aqRFlqu7+dSCsa0SZaV
 A5p2plwzRTl0ISF7fK+iQUeMgn9oCu3rPC55XvSfE2u5ia+5Kp3FV8fx1bQ3uQ3+qFer
 UV/g==
X-Gm-Message-State: AOJu0YwGfp8LqsQmps4oyphAFecLeHtihlue7rgxsdCGjtPo5KfB7ofO
 MAoFdzYFDwG95rWVRq47f5CAQXCeNXyzC3fI+OB2cU3tLFt8RWYZqc92G5aawMGtb1aSXw7FnyH
 P
X-Google-Smtp-Source: AGHT+IEUi9hGUhRqosjEn7E+hn5qEzj6PeR5p14ddZ2sKotpLu8D63HePhdsd2TSbdGA1KBiv4ljFw==
X-Received: by 2002:ac8:5802:0:b0:446:5a73:29d7 with SMTP id
 d75a77b69052e-44662e57779mr111673171cf.48.1719944673284; 
 Tue, 02 Jul 2024 11:24:33 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:24:32 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 01/29] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Tue,  2 Jul 2024 11:22:37 -0700
Message-Id: <20240702182325.2904421-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

