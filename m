Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2615EC47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4545287CA7;
	Fri,  2 Feb 2024 14:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DnWHIQkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C8787C7D; Fri,  2 Feb 2024 14:06:11 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A3087C7B
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so1866752a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879167; x=1707483967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfNK3eknAcYyOfZsqNMY4CG6zYLXXInt8BiOHB+Nmcs=;
 b=DnWHIQkU5RaFgemPUprkUMQ/lUoq5X3IGlzsnxgiSvFgLJQxYkhtrNHQtGCc/SGp9y
 R9nUw073Om9auVVacSnkKHl/J+33/zqItZ0hUKaGPsR+gb9oQ7Dpc2sa5Z4wJZJtw8r+
 QwyYvwG6ru1BhSVH9gpNyZifaUyKYbJJ/CdHr1Z89XfEw6h2leQiX3894P1rVW3urnVe
 rWrlUi8ANilKZz8Khru8l04dyavPNQLvo0HWl7Us6CNbQzXbzkhVrqdXgx1t8R7qLoYh
 JRCY0FYGB+O2Urxk/cQHBSLbBd7YPwdM4o73yoXYZGY8XqVtKlxUELslduFfhKT66Ve/
 zJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879167; x=1707483967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfNK3eknAcYyOfZsqNMY4CG6zYLXXInt8BiOHB+Nmcs=;
 b=ZiLsYyZJgnuEiyEpcXpZj/CgYzj07cl5M810nnPtbuBHA7nAqSJv3602sm6C2QkyGO
 /HkCfspbXOFZhlkbx9HNvaWTqHikVGKdCUvUPnaFrCn9lNqpDPxI1kHpVgsaBov+cc8t
 dNwc8ubIDFJp7iwMsWDIbQWhd2zoHG88cDKRnUeBWENtPmKuHLZf+IXJSRlPQ5Wu4tH2
 RR62j9cUzsomMOP0uXjVO/QW0IwKY0Tfzb4lTgLP9RaOQUQ88QXikfKHAMC1c/1Xf+zg
 k6y/W5XqRVqv4I3VpSw8mQTBMXo0iPmTFZMcW3evO6XsySh2k1oZf4AfCGvKW5hNCI2Q
 /ORw==
X-Gm-Message-State: AOJu0Yx6bOZcebZFUkler/QS4hhmgk6mE0Ci9an5yeMB53Ib5cFj6uLL
 b4QbTIAxnJ/V4RD0m+B6XvGGp7pYM4EJR6kNgBqvXqrMUd+GCat4VfWbWQjnlLbFBUwLJbDWkCo
 rnys=
X-Google-Smtp-Source: AGHT+IEGQLAT+Sq0VgJIdx2rH+Xg+tBhNepB53pXQdTQTP+3lwvE1TvMFcPpaGFu2F56o85L7drj7g==
X-Received: by 2002:a17:902:d2d1:b0:1d9:8222:e723 with SMTP id
 n17-20020a170902d2d100b001d98222e723mr236050plc.26.1706879166794; 
 Fri, 02 Feb 2024 05:06:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVteO+wGyE7gcguaCKkECiv/k47QJKRmESOXPQ/DkoxXiuP0bq5B+JuJL1tLWpitcuaV/nDETbi1762oxkPmlwwouOSnd1bHvHmFwHOxVb3yBWvu7gqxj8Kti8Yvdim7xlWxHpJTJ4uFFwgw061lMR6NMVY3CPDrku0Bjo7+lXctc4N2YuMjpcUem8dISpVdyIwuYqjlwKd3Sos6riOLmcYpQ090fYPJFEPsz8mKmbuPyrwY0rNJFNsqiG7cU6lVbhiQawgLFo2i2o6N1CwkSMepUjrjZMwSut104qhgll6CuY4rvcOEKGj90+prh6SqstYvMa+Mjx4BLtMA35AeCrRIUwJrBeVeSroRhznKYQobyMSkwTDxsGYnwxG2Mw7ro2Lmkiziu7oKLB0MDaPK+xoOGeXmAzxNzbB3RpNOgvb2Wv8zbnmZvXZaL4d/u2kUweamMhwNTBSTPFzZPZhekT+RtayaiiOW8MToSS6FAeuRgEClmxVHRzfciIhwas6+TSPnAC62bMS79ESOc6WU/Ok923zidvqhKa8w9LoLmNUaa1apKLOWS+PTohULjoEaWhMXbwRLxQDMZJyuy9+LHCdiVl2mvTwxLT4sIQo2N2vG6+1VEoBs2Mp/9Fnv/YOohTd7z50L8UO0p2hbSy9MwzL7YWzhvmWhuE3cXYwCx/xZ5q0zDYeia4tuT3wc9/B59i+CqK00anqxzdH2dcxxMrKmm4maW76EORLjsVhvOfkNghX1wHKb57vuUqOWZVJxTCvZ84b/9ZPPnV9ncXR3XBDN4Ahw+VI3DNYX+Gel+5GtDvDytnKplMqwDBNVVrrcfqpK+f/65R636b/XG2GSBiRQm/BgFvVBOM242Rp32K4YlTNyeybWbwzsgRGoyXu8pCJ0yp/QV/wDEnmS3oyc/BYkooxeNLzQ/dm
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:06:06 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 01/11] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
Date: Fri,  2 Feb 2024 18:35:24 +0530
Message-Id: <20240202130534.1051438-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
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

Changes in v5:
- None

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
index e2646783ee62..1d73215afbae 100644
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
index 278a2e2bbf31..8bfbadd6c89f 100644
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

