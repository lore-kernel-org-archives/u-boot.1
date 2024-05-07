Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5C7C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE2188377;
	Tue,  7 May 2024 19:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S4tWRYXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49E58837A; Tue,  7 May 2024 19:52:27 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE718836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso21720136d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104344; x=1715709144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahgQ7wthbpBRk6Ls8TB9V1Me8czQyRK1MGc5q0jLd4w=;
 b=S4tWRYXyRZTJPBb+UIgUovavoDZdYF0mCx+lDgBF+T47mneThLvLOR2f0kiTlpKU/K
 R74O0QgxBKkfft+0/5UDzcQBb+eDYfW74icOYhoC2r33cuRfBdENfqkuuhqGaQdPK7Y4
 K/zzCi9HNs0sMpGL6HJwyx8UsGtMHLrJqauRsFwf8t8oRV6yFdwfqh4VzI4/pTBLUoRC
 Q4qnbO+X8zpBo0FBx/PquXjWbIAMZK1V10w/NMLnQz19vjfPNwpT2fbrAvZj0gbuONe7
 FyXFiHRfE7CeCn5i9jYEw5qxv047eXxYkpgZyDsXBrT65vW/1gou0Bs6vagwxzXwflTQ
 R8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104344; x=1715709144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahgQ7wthbpBRk6Ls8TB9V1Me8czQyRK1MGc5q0jLd4w=;
 b=w94NZbT+j+qsnZsNLeKEBbrcZy40HJz74iJF8RZZBZO8sygGEN7dfhDHmi4US0Z6P/
 3Whuzrfs3QtNG8SbF6iGm2uXz2fdMQvW0TqBMQzg+cnxx0MlabNiI+BEkB4QkxIP9tCa
 meYxr/G4InhAVhQnjmPoWbQ1+EKZnYlpCTtSsUVVQdBqJuU4WqCCAdXkYpQlrMWfVBgq
 5VyiTRtmooWm0fYZbDr20Sspb8Ot6ZZho4XGLIXYXsZMnohgH59Vru3iGsRC5T+/kOiL
 PGp84CuV7VpIW0Pot5T5YhNmugq6PCUs18q4ub/2BNLbMA0bl5TcDrM6PWxSAwiFvRiU
 dbFg==
X-Gm-Message-State: AOJu0YyEdqXibvE2csiaBpylH9oZHXMmfB/LPbwNuP3UeWQEBc3FAtId
 x3Y16qg6ErobiDyijAYgIkvugwaUIIvYWbXk28eAfGIQQkqo/snOx74dT6y/M9GoDShdCCyKMY2
 K
X-Google-Smtp-Source: AGHT+IGebLmeI8WXUz1eORLxvAIy6ZFDTRgWushd0ZmWhl+STHCkFNRk50+MgXW+LOeUtkz2AewLBQ==
X-Received: by 2002:a05:6214:ca1:b0:690:c568:8dc9 with SMTP id
 6a1803df08f44-6a15147122amr6782926d6.36.1715104344138; 
 Tue, 07 May 2024 10:52:24 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:52:23 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 01/28] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Tue,  7 May 2024 10:50:43 -0700
Message-Id: <20240507175132.1456512-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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
---
Changes in v2
- Initial patch.

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

