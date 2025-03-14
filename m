Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C663CC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47B0820B3;
	Fri, 14 Mar 2025 22:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dfZ2njeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2322981F0B; Fri, 14 Mar 2025 22:56:08 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A3282054
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3965c995151so1585325f8f.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989363; x=1742594163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0raDn9mV19b2df9THk+UzfKKGheEhUONpNkUdNQ72xE=;
 b=dfZ2njeO9ELDMGg2zj5QyqZXOCBa34mTPNuq4FG00PBdTRjToNxYpWGRG6+5E1V4Vg
 4ZWLZAi9f/KyiEV8Wnge2XHaXLxm09n9dCnaxDeVZD8Fp0+zHc3del8AqpBeH3uFwJSL
 larD8soVLKqRqvxxtGyQ1G6w99RvWdFRG9XDKTSkdYgfgipnM/pHt0TtkutJMS/c72LY
 hocscC+AzKSUa3L7mh/M1ATX+AZ5JDy38DUcLfQg/8zE/M1Do2Q7EhdnwN0PsSXkSSl1
 RhmMv5JWvU+7SgEAToBgbnKfQuJ3qHLZ7boVx9a5oySRVrgcMPjMFoj8vu2+xOeCjznM
 QnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989363; x=1742594163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0raDn9mV19b2df9THk+UzfKKGheEhUONpNkUdNQ72xE=;
 b=UtnmsBMmmJB1ZBJTHnJKUIDk9qOlIoxzWOGvnGYtzNOjSSQqeARsh3f4WEMx5uqGqx
 KKl7XkUedmuhl34RY8pACVNsUHjJG8MPuI/DYfTNGGWEa1Hy5ckPkebLwjamhsojozDL
 HFxZMs2DUcQMNRgr1CKebc9IDUeshNueiDnH5qpsQ8bSRgwGQa10VJ3VxGgsY+UXeLX7
 jm0L9cC5iIyGYR9M1dmsHzrwWR7iReTPeGteqOw2DfS+nE/M2G3NRV9htFqkc2bo5ESD
 zs+GIMCSydt6Bh95cXVG6S+WJ8eBJPHJ2jai37WvZaBFhbioq4efANpT89znVn/nKbyj
 DXhQ==
X-Gm-Message-State: AOJu0YwB3HNeYnWYNA7OBaLhvCk2c70QHh9uYNMXpzpJnggzaO9ZeIa1
 1P9eon1G2MyUEe9FlVoSeKRwIaUdU7R+6MfcRWvWa2A5xCvrFyYc/xhvhZtt+YL/Tc0y5h+vUv1
 T0e8=
X-Gm-Gg: ASbGncslat2ZYrQsxG1C9YI1spidQLUNRscnTJJ0cqMMbHuWcELK05kGCi8Do29/s1E
 slIjQ5OQdQF1PeJ3hgS37IfAhJnIM5qxV0BrmYrCV4ZMBPAdJL+n3P3nhjEn2M0bXaKlRMNa0wY
 ENNRHvitg2U5Gvh/pIAtNB2/VAezBRltGe4pLFjLECMHqyJLMJvi8QOKTB7n+ITXbPElNgsUBW8
 aaiL/9ZdrqOihLCSgbe8mVnYZ3EmJ1y4ykMZd+J+X0buPIYzqnVtULi8uen0jNKF9oWv1mRqA9q
 g5WlD5Th/aip1WHBQ8+OUDVYelzdfWv7meHeZu6sFD6MPDvsQonddA==
X-Google-Smtp-Source: AGHT+IGV8k7SW1xylb5/ih3VD17ztja8iXkPTo9AhZmEuS258Gv64UPWKGFAV2pvtTUSUcAJ0ABXbQ==
X-Received: by 2002:a5d:6da2:0:b0:391:2fe4:de0a with SMTP id
 ffacd0b85a97d-3971cd57412mr6715726f8f.2.1741989363670; 
 Fri, 14 Mar 2025 14:56:03 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:56:03 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 12/12] CI: add sandbox64_lwip
Date: Fri, 14 Mar 2025 22:55:14 +0100
Message-ID: <20250314215525.579655-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Add sandbox64_lwip_defconfig to the list of tested boards.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 .azure-pipelines.yml |  2 ++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d5cfa59a8a6..2e894948507 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -346,6 +346,8 @@ stages:
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
           OVERRIDE: "-O clang-17"
+        sandbox64_lwip:
+          TEST_PY_BD: "sandbox64_lwip"
         sandbox_spl:
           TEST_PY_BD: "sandbox_spl"
           TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2dbe6325f33..8c31bab6604 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -287,6 +287,17 @@ sandbox64 with clang test.py:
     OVERRIDE: "-O clang-17"
   <<: *buildman_and_testpy_dfn
 
+sandbox64_lwip test.py:
+  parallel:
+    matrix:
+      - HOST: "fast arm64"
+      - HOST: "fast amd64"
+  tags:
+    - ${HOST}
+  variables:
+    TEST_PY_BD: "sandbox64_lwip"
+  <<: *buildman_and_testpy_dfn
+
 sandbox_spl test.py:
   variables:
     TEST_PY_BD: "sandbox_spl"
-- 
2.43.0

