Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E285C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725E582C44;
	Sat, 10 May 2025 15:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/FxcStN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF13F82BE4; Sat, 10 May 2025 15:44:27 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E7D82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5fbeadf2275so5202177a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884665; x=1747489465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7SJa4F/NLBaFwvLjZnXnH94oB1nZ4P86cVzLM6Z++Y=;
 b=e/FxcStNm79u1qrFIYbwDl2xCosgxTKlEkfK+hYfhg8Ca8lEQGN5GizhqdIc2N6SqM
 vQfc5yPNey9/QlV2yQL+v58647pZ/s1IG2LcXe+q1ZhGh9y3NXJl2O8hgMbaOCXNsK0B
 9t5C37d44mAa3O6ONN1Vi3u93t9mp0/hKvnU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884665; x=1747489465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7SJa4F/NLBaFwvLjZnXnH94oB1nZ4P86cVzLM6Z++Y=;
 b=BnbFleWx9NxaVXc/0+rJdewfRSAsWCakqn+vyn8vKTm8w0RHoPDFZ+/I7ksQM99z9O
 XSwzny4kiaxAz5RY4VSP/kc//3lsas03a3AVfpYZqj1s338JsTqPM8igDOWY5tnavSbr
 Ic7xrTFtgU5uPnO2D5v+yMJutXHp99LYRSezQukLOLrvT8DO2icNvw18WP3eV65PkePA
 3gIO6GkeRtIe96uYH7hViur7dr1WEkhIuob6j424R0Uva84VP5rKgGq5Ajqygk8G6pcv
 i1xKHTjqSJZDtFeD6crVCvcoaQ/S5dhwWDVsdq4aeURO+hag2lNgaB6rZUJWhDZgxrmz
 IjgQ==
X-Gm-Message-State: AOJu0YwqSK/jyP8AJRB8yIMYn8NxVk7IXDK9GD9MKYXwkp9kBxZO00DT
 2VSwRJEU5WBQLP8jD4tjqMqO/P6VelUbZhypqsPhjYw8zLk/qG86x3lm24omwWrQTUbIsM6G060
 AkyeYaGHbSQ==
X-Gm-Gg: ASbGncu+pCxAMNkQV/1QZnsD3HGrE0SzIFsC7y9+gbuoM+81lyC9IIC0q+fAArVgo7F
 UODJjwGCgRR3XjOaQlJpzgNHRdWL7RTT3MKlCFDvy3AOKS8XRhdSWAhppDD7OdSzppDHjJV3X9W
 PYp9uhNm8nqupnILx4F3A04IvULh9mPWjp2Jch/yKKd9YtczvQbhy7bfPoD/NEysSmiu7nPYAsb
 FWp+Y9zKgHvWH9q/czEfWyUFdrVXW8Afk6m5tMTDbWXuZFXQGoUPVWANZWUWka9X9TV+bPgBwvT
 tXdKtt+9Kp76sIKKwBirXalZc8t7r9Y3QLLY+RjcAA/sBoRmN1xFiwSa1JCvDOdnIfoj
X-Google-Smtp-Source: AGHT+IF04xQPhFSgnWcnaECFoAlrjFoLv/RypqoVmbWS/B0BGPvc4B1VrNnlWLK6gCSAq53320k6jg==
X-Received: by 2002:a17:906:7955:b0:acb:5c83:251 with SMTP id
 a640c23a62f3a-ad2191789acmr670674266b.53.1746884664881; 
 Sat, 10 May 2025 06:44:24 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 22/22] CI: Add tests for gitlab and azure
Date: Sat, 10 May 2025 15:42:20 +0200
Message-ID: <20250510154214.v4.22.I321f53b875ffb594a569796509e64830b9f3fe09@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add tests that check that SPL can generate a standard passage on ARM and
that U-Boot proper can accept it successfully.

- Finish the commit message

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add test for aarch64
- Add tests for azure

 .azure-pipelines.yml |  6 ++++++
 .gitlab-ci.yml       | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 5e1938b0526..4378ba4ec9d 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -459,6 +459,12 @@ stages:
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_spl:
+          TEST_PY_BD: "qemu_arm_spl"
+          TEST_PY_TEST_SPEC: "test_passage"
+        qemu_arm64_spl:
+          TEST_PY_BD: "qemu_arm64_spl"
+          TEST_PY_TEST_SPEC: "test_passage"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f11331514b..bd8ec7555a8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -394,6 +394,18 @@ qemu_arm_sbsa test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm spl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm_spl"
+    TEST_PY_TEST_SPEC: "test_passage"
+  <<: *buildman_and_testpy_dfn
+
+qemu_arm64 spl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64_spl"
+    TEST_PY_TEST_SPEC: "test_passage"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.43.0

