Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06563CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E577288D47;
	Fri,  4 Oct 2024 06:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pz6WGuUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DD288D1F; Thu,  3 Oct 2024 23:51:59 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7074888CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7ae6f8956baso15745385a.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992316; x=1728597116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJrUom187vQ7D9xKVwXa8/EbksTH8ZlazMM4zq45vDE=;
 b=Pz6WGuUe9As9P6D6fVnlX3GbBaF1lgN8S3uF9H5uIflf/ml+AlsenBA0kUj8hOKWqb
 RAxM7/elwF3+e+CGXoX/APU9D5iK1ge/AeU3ly1rN7+v2aOE+Yf1gFITbialB4F/443G
 PnR5AeCbSyd8fGClu4bi+n6vzsWqeNK7xHminQBPmr0Ln6R95a8VmzZAdBnt+O9IIcq2
 XPi20OETUUnvW98yaokJBmv7nbRD8c9bWvIlkCTcjnqCPKlJNkzhoHzbKtqlLWNd7dHe
 dCrzDTQ46o+KQJndxL0p1xN9nHGnx8G2+cUK0ZoX2iGPAonOmRtGFN0RrVv5FlBXoQji
 +olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992316; x=1728597116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJrUom187vQ7D9xKVwXa8/EbksTH8ZlazMM4zq45vDE=;
 b=YoFme37hebh9kY5+2yp3VdhYetvb2WpdEiU0V7CQ1hHvE117lCjiEiTKKo1Bu9nXgp
 BQ1//NUaxj1zdER6+F5z1ZDdpGPbDpC1TypMgqqa0LSrxj2fCSVLwNg8jj4m1iWfDk92
 /3G/RS4egYPgxNxqnUAxmbWZzK4Iavb8zMyhvQscgFCS7zGOr+5zQdPveU8lK0BhUbYt
 x417vFEc66VlZEGwqVuPmYfOZL4GX4KK7UlFOP/yTSXWbvn65Ojbb2PCvePh+r1YfESk
 E9TRwNS06eDIUhO+mLTST3T3BN5tz8VPFVNo0nWgq58v7cOveVtDBBPEg5VnZYX4KAP8
 fQcg==
X-Gm-Message-State: AOJu0Yx30742ClF9imIwjuXDbosII1Mk2Q2Vatwt+e7qUBM21sR77z10
 a6AsGmaNjJ/Lp/yQ5Jrm2qvrqG+w76d2jCKWHtozR/mOnWrtrzGkqmM0+ecC6Bw3q3JMBu8Er34
 k
X-Google-Smtp-Source: AGHT+IHwElwwGQJNcssgsluetgdPz+K6xdkvhmIEHtBJiMjxNVc2lRX0JdBQuLyjl9UmorFggxpZww==
X-Received: by 2002:a05:622a:1310:b0:45d:9689:9dd5 with SMTP id
 d75a77b69052e-45d9ba5dcc8mr9163381cf.25.1727992316090; 
 Thu, 03 Oct 2024 14:51:56 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:51:55 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v8 01/27] CI: Exclude MbedTLS subtree for CONFIG checks
Date: Thu,  3 Oct 2024 14:50:14 -0700
Message-Id: <20241003215112.3103601-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v8
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

