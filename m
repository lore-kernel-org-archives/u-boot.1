Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EB8C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 06:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B91877C4;
	Fri, 22 Dec 2023 07:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wQlHhOmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8577877E2; Fri, 22 Dec 2023 07:12:41 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2580B877B2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d411636a95so1937832b3a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703225555; x=1703830355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Tf23Ua/+FicwJ/WtQiM3dare+y0p7cztAVrViWK4Ho=;
 b=wQlHhOmPAUtofm7Soneb5LkUlS3RE2BfAq7lzHeDouLALiVciC/VDx2vdD1Qo4+ifc
 pwTknfTgTD1mdWVnCdzCFlSfIn0tM/StlpejXhBANh0Y4SACByvTmcTGbySyYKNGspT0
 kSOdFQ8qMouXS7HTdHLqDSlGW1GGJ/BExHBgCmkYdrdkszbvaPUQFz8s8kBgJB/2T+c/
 It550A4fjDNsUDqD7yaGS9oNVQ2M1ZRH9+ckBSS54s0nTCJW3zbKosDJRkFwPKrrshXv
 +vUs7UtEty0pKJnlMj0oXmbf2BIOZWwISgTgMOIixT1Dz4E9+bysSjkEsH5mLK2+dWvF
 +fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703225555; x=1703830355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Tf23Ua/+FicwJ/WtQiM3dare+y0p7cztAVrViWK4Ho=;
 b=ciCLk3b2jgR3ZsBThW83dnGS7d52yhd0Pa/DCvma0x5Vl+ZvCjbgFlAYWANg7uutar
 Xciu74jc8EBJ1F+UrI0LPP82tgb4UFtBxaL7Uskce7MxI9Ie8tePuxBlM9fSRCNG96Uo
 iDbKL6sRCG/dOFTh3uo9lDKPqiNMq4YdPaGq593ja/yq4V6/Nx2yvHCenRC2+Z3aw56e
 dFRomQoNsAsgFPVq9ZDt84mSdw7zDHmOPILCtEfDOm4rff5zIIHvpAfnbwZ07go8FylJ
 pkK71If9O3CqHKTCkb9w8AYqUqdMFhMvqzaPpju8R7x0yKrkFqJXP6u4m+Zn2FkSryj3
 +YLQ==
X-Gm-Message-State: AOJu0YxjZT6N5KjjdSDxPnD1MBiWU4fg/9rS+VQ3w5yjRoNzXxSfXzTe
 EGLg6wkas/xDZ8l2feTt/0KF1GvYtKrWmeaHiUgtGDl0cUdY8w==
X-Google-Smtp-Source: AGHT+IGShQJ9a0wobRWAcXQpTN3pexrC9j/u7anCK8Mt7dGoZakaYS7hpuCs7BAz1YU9Dd86s3gacQ==
X-Received: by 2002:aa7:8e5a:0:b0:6d9:6262:b30d with SMTP id
 d26-20020aa78e5a000000b006d96262b30dmr921596pfr.27.1703225554874; 
 Thu, 21 Dec 2023 22:12:34 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.219]) by smtp.gmail.com with ESMTPSA id
 h6-20020aa79f46000000b006ce835b77d9sm2602883pfr.20.2023.12.21.22.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 22:12:34 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
Date: Fri, 22 Dec 2023 11:42:01 +0530
Message-Id: <20231222061208.3009970-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222061208.3009970-1-sumit.garg@linaro.org>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
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

Since devicetree-rebasing is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d6f3fa423c6..f100c4493e6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fee165198ae..96ca9f72bbc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+        :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
+        exit 1 || exit 0
 
 # build documentation
 docs:
-- 
2.34.1

