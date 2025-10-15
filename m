Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E438CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C168E835B0;
	Wed, 15 Oct 2025 16:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hatzhsHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1E483678; Wed, 15 Oct 2025 16:19:45 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F206800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-87a092251eeso18418636d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537982; x=1761142782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zc9Tu48aDwEG5ptxQ31bs0a+o7HRU/7+ekhXp87YR/s=;
 b=hatzhsHED3T0jgcThrS7cjwkr4giYMhdNfbAvarcVuL5WiqU1tiBKky9PN3AkFsBxU
 Va0uNdxf8tTahvSkJ19ZCsb/1VE0y5S9dhHm4rCWAxnXdgUWRdFqvrObvHd9uaf7vJDs
 tpJtbl4mCW11Qo/R1rvH55DdJk5JV2jjGsc8RI39NJdOwNK6FJQfHLgVz7WZvUa3fTEU
 WNn5zZ54AXl0JQ1U96sZ8okjXcl1CvTCPbHblKgVndCUp2od/YIBADFC3RVOlGjcpnyQ
 TJ1MA6xnVBuoMQDeyr1KzbJtkgSNuowRQnbDXqJE9Su3NGR2hupM8/etn9ewgwA9fq4W
 Vgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537982; x=1761142782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc9Tu48aDwEG5ptxQ31bs0a+o7HRU/7+ekhXp87YR/s=;
 b=Kyhk5fyS8jo33bPAfNFh5yxCLxRePRqhWxa66KgZ0/NRsRO6EK0hVrn4lnQtEE8vqq
 TPI9+FrQdL93yvehUwS4yyfCI5cGxZevP4rerGlCvJzSNOlw1zMkgwIpc8vD4Ftjxdt5
 LG7InKpbsEa7dB6cVrv4QaeFhOxH7ZPZ9+FVjQDkHvm2C01EMWs8NzdWNl/9Uw8y29br
 aRMFQQU31B6B6ePwZRGvgza/GqOWqKXgQgBB2Y0TEVXBUkQ6PWK35B2neHIYCe6gPdu7
 Qc+ZNkEiAhtXeeKIeCTo9I9vb0BsdgWJ9035+hGg1l7Dc67hb+2Mm6qBM6kFI8AY8Dm8
 q+/A==
X-Gm-Message-State: AOJu0YyaN0vDhOQgAEgmK0QcwwkiPaGFOJ0lHBUCLn9gSAl6abj5GfMe
 cxJsQQFHcDIGkg5XeTgo85AJ+OqPqBvLKguucAgV7ShqMev2WGm73eqMisl5Z0Z9gi/w0GGSzQC
 SYx4t
X-Gm-Gg: ASbGncuSCQmQKtXfH67v2dacCqEcRf0U1IkICJMvnaDPgUUW7lIdINE2Gw+pfCzluUc
 Vksgcgl1M4ZafCwOKf+ZfoPMhhPupqUQmm1Pe4cGTPBC5EeWbhl94J6NYOA82urQ0QMTl5t4diL
 yDv6HnNTAgRQrLmlnrBQRhY4o0riCMRdMNu27D7E8er5MA2h03Ksqs9z4E+ULKbn/MMC1MIJV6q
 igTNSRJ4fyUTj/U+Kxrbw0HPHm7U4fB5h4jQaO1Xr4t2KzkBKRkFv2EcMvxbJWvoEbDBzKR1z2f
 wHePcit58aMdGDt9yGOnd3a4IeVarsGPkKLgj3z/wnCijW1I6IsQGrfcG/lILRgxH/mc5Dl+5XF
 STWtl/QG/V7WssscbxBqHEoQLneP92xBnIjQbzeYYlTn4caFcn//+8uTq24Ft5I7pFda6U7PusE
 fyaFA=
X-Google-Smtp-Source: AGHT+IGPHXtEn3WsT2weW+lS4TVNkBNNQrvgjalWSIjVHBRwcgyyHqzxtyeW6I9n8O7QkriwNn+L6w==
X-Received: by 2002:a05:6214:5bc5:b0:87a:97f:de8c with SMTP id
 6a1803df08f44-87c0c870e6fmr4388416d6.28.1760537981644; 
 Wed, 15 Oct 2025 07:19:41 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:40 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 5/6] ci: rename conf.qemu_arm64_na to conf.qemu_arm64
Date: Wed, 15 Oct 2025 07:18:49 -0700
Message-Id: <20251015141856.4168612-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
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

The test-hooks config file has been renamed by [1], thus update the
name where it is used by the script.

[1] https://lore.kernel.org/u-boot/20251003191918.767698-2-raymond.mao@linaro.org/

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3:
- Initial patch.
Changes in V4:
- None.

 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 1382e4f6475..4bf4d9e763b 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -254,7 +254,7 @@ stages:
           git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
           # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 224485a2e64..5ae02176167 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,7 +39,7 @@ stages:
     - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
     # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
     # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
-- 
2.25.1

