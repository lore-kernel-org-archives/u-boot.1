Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA974C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A6C82C44;
	Tue, 15 Apr 2025 23:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RQ25774L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6BB82C2B; Tue, 15 Apr 2025 23:18:39 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF23482B53
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso3859790f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751917; x=1745356717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkP5Bcms/nyn0YXLuMG2fTx1wYMuCd6jOe/gbm85Qj4=;
 b=RQ25774LAlPqRVet6yE5ot88VkmYcATYdrraMnrFXYZC599CPyqYeBZCgmRqDzIzyt
 a9IRr9shBKuzG0ddzqorDvZyFyCxha4Oy30HLm8RUG5YZKT46aw+QSOtCfmIh2G93veE
 cWsfD/kQi49mBZtrfkLRTJu3s1OfmO5ddkvOaVRAT8kXXNvzH9d7TAmBP9i6V1nHfQ5b
 1wMEPYtbqSnyxljUFc5a6544XjA6tpZPscKW7qbZyaWcvTud6XjO/i/WlmDmY4U1S8OC
 V5Ct1bMnC9dRAOXjcGMvb1HiayldQJNo2LJsuCudOGOpzlwLSeZCUtleXVqkRfPrAq90
 MofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751917; x=1745356717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkP5Bcms/nyn0YXLuMG2fTx1wYMuCd6jOe/gbm85Qj4=;
 b=aW+fAdeUWjiRw4bs0CRpINKa1bLrqaRM8YuoXKnCYr/8eWRvjQ4t4lBz1TteA6HWZF
 Kft0jqadsAil9cUFDmEs0xzw+sXV7rEYTDFLL6LEJS0pGgIAYxwvmJBUw+Jug6AheUlD
 TtuS0U4L9sekINDIhM4BpNxkB4/qZeQfVV7ddz3yoOOom9QQE93bnCIFn71SYdpsWER6
 hORhBqjDXLLD2aj+pfeDuDa2tKHBZI7oFkRGdX6U8rcGCT8gxXO3Ka+034pVocBRG2Nf
 grme+zIouP8J4MTwK+gvhyLJQsA/hwa5CiNyKfAyyzqWyzkxPFfo9SrGgHAbqOuE4kYa
 X5pA==
X-Gm-Message-State: AOJu0YxUIHyfc2qJkH9kAcCbTedaC1vPUXhQFeL03xWT+zyRb4zPFyhj
 utJdX+zpAC4yMs0U+waGjO22rYUQZW8ZPinjf7tmwYHSwy+97pmQGzhaKiNU3QCYOO1ty5tDdIj
 VvrQ=
X-Gm-Gg: ASbGncvgtk9sDe0yioN07V+zgS+U1kBmRQ2Jc2TFmVAPct2jZYSw10LYlt98ymPWrfN
 I+lSam8b55ojG4+mhfBob4ztPYcT9sDFfkKA9MqLpfA58h/G4OKWK13Ua1mrh84ihQ98RNJaanK
 pq/pXov3AkJE+xFh6j7xu5pPWDTddtAPxCiblwahdWOguWVuhmetEcT9a/r5gZRsd1/LO4JKVWV
 KZrPbAlY7OGDIcryuZcZ1pISi3MRlObJkAb0MLBytckznAHMN/XZnKHTMt4PHzVYxzcwBXGXEv1
 yjyKgQpiRHOeBjkD327RCVJAb57xCxJXctMOwBv1iZoQrE3T
X-Google-Smtp-Source: AGHT+IFTFk2xli0TJ7b947mLBbTEyRx0asvZes+qY79Y2n27vuF1yV5SAb/IQg1vBQIjSo/VMjLiUQ==
X-Received: by 2002:a05:6000:22c2:b0:390:e5c6:920 with SMTP id
 ffacd0b85a97d-39ee272a0e6mr872158f8f.3.1744751917254; 
 Tue, 15 Apr 2025 14:18:37 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:37 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/11] CI: add sandbox64_lwip
Date: Tue, 15 Apr 2025 23:17:46 +0200
Message-ID: <20250415211819.1254435-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .azure-pipelines.yml |  2 ++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index cb787d32f14..01ab0c11f98 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -350,6 +350,8 @@ stages:
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
           OVERRIDE: "-O clang-18"
+        sandbox64_lwip:
+          TEST_PY_BD: "sandbox64_lwip"
         sandbox_spl:
           TEST_PY_BD: "sandbox_spl"
           TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f3418e482f..145bdad83bf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -290,6 +290,17 @@ sandbox64 with clang test.py:
     OVERRIDE: "-O clang-18"
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

