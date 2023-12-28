Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01889C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2254879FF;
	Thu, 28 Dec 2023 12:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AWkGFIA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EBF587A01; Thu, 28 Dec 2023 12:58:41 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0584987895
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d4414ec9c7so9912555ad.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703764715; x=1704369515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3W8sVu0jjxpWWQ933Uj3U3rjnY6OkWb8wvQvg7blCM=;
 b=AWkGFIA8Rh01g6xD2r8O/yb7aMaUGQmtlkrjZyby51S8rLhNf56E3rZYZf1ZKYA0gU
 Pa3H4Fwzcv7NJKWaHI9k0dwdQAk52y/Hovh6F0Y4zSIfEYaFjf2NfuM/GjRtXT8xQmFp
 7F8oawIgc80azFUX5liyHIiG7qCfzRzsnYi4WH41QjYJZqYEw1rCRsXrjcpkzisIYA4X
 K2irY4fSfcOT10IQQSIHAzkqBd5J/NYS0Q1Hs1NMMwd5OOOl6i+vhiVCl7EyuutM2vWD
 3UIF3edKwbo4x0dWnFTnQyOaS75PxgViBcmyVOsZBV9CZV5MAWk+QjIi/vBjq2POYFPv
 x8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703764715; x=1704369515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3W8sVu0jjxpWWQ933Uj3U3rjnY6OkWb8wvQvg7blCM=;
 b=vfpfghGLAWOprwNXIZpak/43b67rJ29ccFAhBCrxH0U3pXK6jSMxX14POnn3Vkt6k+
 DgKqn8xWS+9fyot9eRt8t08Ya27MYCXjR8wCa72XIWHZ+ek/90stV2U2dTPz8NzptDBr
 XsXj9T5TS82PPN0IzCktc7OR/dsgcM7X4SQEUzEMopA4itnUeRMAAo8s+MF9Dmg0/r11
 hcG75E+fgH8gUqGP2821seJSXtg9NFTJZs+Cdm3Vzj3CLWihdGjUMuLg/P4P0JdyhjaA
 w37yz3VZRiSFdGFB7CUlUOzslrX9/U7qRPvUOiK0gYiQl6anY8+LDm49OcgBt2VpJkJz
 Nw9Q==
X-Gm-Message-State: AOJu0YxYxx+NHQ19yyDcnAdNwKjWq9HdLp+pp2PRTaJAPUUcpKWrbAHl
 PnrGeroCftOXamoad0/Cd0hPUEtbeUzzfHNxSw+EHpMxbVMsQw==
X-Google-Smtp-Source: AGHT+IEPnf+HylEaD69SjNL6H5NDpIh1Qutsch41q0LOQUQWicnXl9IvgAIgsw+41xD5iDycNi2T1g==
X-Received: by 2002:a17:903:28f:b0:1d4:35ad:41de with SMTP id
 j15-20020a170903028f00b001d435ad41demr4482702plr.60.1703764715137; 
 Thu, 28 Dec 2023 03:58:35 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 03:58:34 -0800 (PST)
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
 mibodhi@gmail.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
Date: Thu, 28 Dec 2023 17:27:57 +0530
Message-Id: <20231228115804.3626579-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
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

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Picked up review tag

Changes in v2:
--------------
- Excluded gitab CI config check and added commit description.

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

