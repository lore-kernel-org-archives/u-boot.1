Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE82C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8D587A88;
	Wed, 10 Jan 2024 11:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HfRR5jVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3280287AB7; Wed, 10 Jan 2024 11:36:22 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7383887A7F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cdfed46372so2989140a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704882976; x=1705487776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E6fdywU6EW50aUjkVw7y3e/KpKAjgOGXE0XQF5Dqz4=;
 b=HfRR5jVoIuu2LI6dMQJfc9ArwXUtPZwZ98NRk/GhdGMuM9b95/wr7XbYvXYpb2yek/
 eWwfXpQDCALfYXp0w20P85XfK+tkrOFU2tx62UT0NNCSclafrjlPaJKrl+uIcYN/nk7+
 dh/rAswl71ux64GDFtXTuQdU58okK0XiNIL/CaH/qboAXsmUseF5E5yhqmnXN7OsgZAn
 D2GZ3G/MEb0z5zkA4gGBNCAtHZPBS/lpHuprMzJgm67uJ8riDWVVor5F+/d3XG43uOB1
 xLPn8zHbTznXPf29h1otu8aMIhpzyrMaar4cHlxrshpEAUp1ukzKxpzeAX+/Uy51Bl+0
 CIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704882976; x=1705487776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E6fdywU6EW50aUjkVw7y3e/KpKAjgOGXE0XQF5Dqz4=;
 b=W30bhvuw/xBYz9Sd2KAormgr1eLrf6CQRWFW5MBGuhSqTHqJ1pIyocdDd6ctgqRVU7
 IzJjX9253VV9aPEo63Qjz8lW03gdmBnaEaRdUeL+dbDtOW3p99PZxulKgTFfts6q2inI
 3LyyU2NVf/2fhc8CULlmu5RybPox0fZMURo3j2xj5NpHr2XJStw9yFzV+IAcfC2g3/ce
 tGJic+ixoa6KFicYJEBlonbOyRajCjftkbgmTNb6FJk7EjqKsmL7nD7D/972b4ZKs7JC
 DMoZYjAenQ/0BoHvzRk7tszX5reYKMUZVHgjGlm1KlnWj04VHKUvB9aAK5jWD9VomlZf
 cDEw==
X-Gm-Message-State: AOJu0YzBsFWgQ5pTbj/FfC1RSBtTO9mih1QULY5QT+c1yKh2ja2iqE3M
 Hmwrng3xkZnNqJ37e8f1t75gYIw5j/qSsQukm2F8PVoRwNA=
X-Google-Smtp-Source: AGHT+IHMxbiZP0ppj/kQVvCZTlIseJu814BoA6Q/8k7YIf3mGnL/5D4Rf7gF6LcXmfkw2cMJLhGA6g==
X-Received: by 2002:a05:6a20:8e01:b0:19a:2a0b:b24a with SMTP id
 y1-20020a056a208e0100b0019a2a0bb24amr415634pzj.79.1704882976475; 
 Wed, 10 Jan 2024 02:36:16 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:36:16 -0800 (PST)
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
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 01/11] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
Date: Wed, 10 Jan 2024 16:05:37 +0530
Message-Id: <20240110103547.719757-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.

Changes in v3:
- Picked up review tags

Changes in v2:
- excluded gitab CI config check and added commit description.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b9d6aa98a0b..97c88bc2a5e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fbf99f0322a..6362f2857c5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+        :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+        exit 1 || exit 0
 
 # build documentation
 docs:
-- 
2.34.1

