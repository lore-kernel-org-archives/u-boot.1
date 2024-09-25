Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF89C7882B
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0F788B79;
	Wed, 25 Sep 2024 14:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h8n7o1Zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A64788B63; Wed, 25 Sep 2024 14:58:42 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD0088D66
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so178084866b.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269104; x=1727873904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd3qKVb3wp1Ho+9jVMi7FFwQQu7frvBUCsumfey2kag=;
 b=h8n7o1ZgT7FUL0vhA8YJqTvwvCQkGPbDah7G5S01TKlJlVibEPEuoX/6kouilttyIb
 U6CTwRp8ILp/OM9Ugh2FGXsNZSG0PA2FhT5U1Q0ANmzKQA4LINCu0Q0x0v9xAglfst5H
 0GWsg6EiEnyc0vjs7SgIUI3PVbB3hDkiH8Qe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269104; x=1727873904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd3qKVb3wp1Ho+9jVMi7FFwQQu7frvBUCsumfey2kag=;
 b=Fxhuti53nAPO/R40iks63tPYmimBidnFXmPWiVGQ9hGoi+R8Kz8RYW4oJfcUV5bIQJ
 EbyrzGedGw782Zgbg2VFYN1LtDmqHYsVKNXqG8kRFDkYEQegocRAwnC49tebnRbpuf1a
 VeTDjgh0VzgIH0SptoQM4ENDn8DjnFA83E0ub1PMqWHY5hiU4VJ6HjmiuPIHwl43IyWE
 YI5CNi2P3oFq1GtLG2QYnDfwHDxockM7EXvgZwZK3IHfY7YCtf56yO14b4ZdMApjuuI9
 SYGsXOrZVwMpBJCouXxlO3Ts7eJhwsAt7Gh1XxvwXFfnU+qSV+q+u2WxwhXxn4FPHnZU
 J1wg==
X-Gm-Message-State: AOJu0YyUrruVegWTG/VpVESna0h4fOUM24WuSU81K2j1df+H57bNody6
 49ZHMfL/4KJhWEIHQrUeBns3HIZlVnma6EY/Sm1cptLmEaUo3fhZ2M41lfNTBlZ6xq8H6/tSRMS
 rAw==
X-Google-Smtp-Source: AGHT+IHA0CQh2Tgt5f1vt4ngT+Ilc3uFOGkpBDxc7gDiCRX+0xnyYdB4Go1kWcDvqcGVT+K0sjQeqg==
X-Received: by 2002:a17:907:9705:b0:a8a:9243:486 with SMTP id
 a640c23a62f3a-a93a1804ba1mr304485066b.21.1727269103784; 
 Wed, 25 Sep 2024 05:58:23 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 19/19] CI: Add new test for reloc loader
Date: Wed, 25 Sep 2024 14:55:45 +0200
Message-ID: <20240925125622.197915-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Add this to CI. This relies on a u-boot-test-hooks update

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .azure-pipelines.yml | 3 +++
 .gitlab-ci.yml       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb6127..51c4346ce64 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -415,6 +415,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm64_tpl:
+          TEST_PY_BD: "qemu_arm64_tpl"
+          TEST_PY_TEST_SPEC: "test_reloc_loader"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d621031b85..8020853b73c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -344,6 +344,12 @@ qemu_arm64 test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm64 tpl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64_tpl"
+    TEST_PY_TEST_SPEC: "test_reloc_loader"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.43.0

