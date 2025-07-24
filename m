Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A9BC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21D883775;
	Thu, 24 Jul 2025 11:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t3mLo82T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674F983826; Thu, 24 Jul 2025 11:03:06 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E70783775
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so15647585e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347782; x=1753952582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8HC3BvmzTyN/R8eclXrecG9Emv/Q6QtpoI3TTQFRHs=;
 b=t3mLo82T2BH1IfiIttnmKehFeJ5usxdxY2p9sxjJj8CZ8JJeukmC2ajhNA1BRP/Iiz
 +PcIsZOCRI1btXz0x4hrbE++04ayH4TwOLApZXOzsDJGhQGwl9m8DiB/3gv5D9TxPQ6t
 K9k24bSO0MFaGYTT8wjL/d5mMBHhk4XM1qqj28k/l+2kSKxlKuoBjHMChZBBl2/e1Ax8
 7OytcgM17bALJNKBvNJVRSgzbBpTy7g+kyHA9NVhRyv4hdN4j4P949mniVG1HmyI5KLl
 1nSBwm6UhMO9eq3GTrf0tkjLprzOTUldK7JJmzXeAk1nKc3OzdqjN77NO9FN6CZjyH3P
 4D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347782; x=1753952582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8HC3BvmzTyN/R8eclXrecG9Emv/Q6QtpoI3TTQFRHs=;
 b=LWZ/3H6usoVXScVyEfUkXTrDtS17JckL5RScquLnaC5hau6aXlVZcQ2e3AnPZCqWFi
 yJtogXJkBccYoM2Gw5KLoCGDIQkeEGgmJcH29U+CrLputteDGd0Ro95HKo9i2Trl6dHn
 kcP3eQYhZCrIeUKMw6GRqMQavDimGR7lVYeNgMf7XNdiQiTOR01kqCVCCRKTV0ArTzVp
 03q5opCkicV6e+Z/6RHrgiFUVxv18BB9CNoot/qYQxPJx1r3kPauxM+9Wm8uxBfGIZrB
 AAHW3ZIBbRUSpZVhfN1QXJrtZGoeSqxP6DmAeyVIk4eV8K6eL6ft/t5Q0i7mdUCbgPcF
 PsPg==
X-Gm-Message-State: AOJu0YxprA3NKTeOIY8pU0VtAZ7qZcXlzMirWLyVRxI4TJAtx0Tw4K12
 Pz379NVI/CSaLIF3BkM07NeBFkNHziXnls2nXHdmkJmGikh9KqrWv8n6D+WzHxMnndm9x63fDfx
 sAScFhyxU/Q==
X-Gm-Gg: ASbGncusa6uyNok2JeDgnCZoB7UYK5TvoqMTFqMVgS7cNkhk7hdhYj/Fs0ylW1AdHrR
 /HrpgFdNehxcLQMI7Gk2Au7kuh1iZ+9E9ytlo5JLZWW28ywnB/zTuZ3+rLxlD0l270aM5z8QZ7/
 qxyQ+BbEzGt5fhLrguu9kZYrqsXa8sKboztyrXwKZ865lXvDkgARKhQDmmKYY0b1Q/ixL5aNZKQ
 +1o+zKlzcrF49saH1sOD1ICt+If+D3Lq+b7mta3/xMqBzsO3L0liQG8iEPSlifgGJiEQUv1pKfM
 0Tbt+xDtg0M5KzQ5+SUXd+PzECRF1V7T5LuhorKZLyt1KJo5zYBOgPfdSt+KrsqaW2XMUNomhxJ
 /AgRLZ6ukPZesBUoybxW0mu31wdRXiQ==
X-Google-Smtp-Source: AGHT+IFCAsaZcKImaAu8V8TDtiHr83qlbVwsfZ/70KgG5Lokrkw8kxfaQXqn/K/FDrPOIaVybI6zUw==
X-Received: by 2002:a05:600c:3e8d:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-45871065773mr7675625e9.12.1753347782118; 
 Thu, 24 Jul 2025 02:03:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870577af8sm11958715e9.32.2025.07.24.02.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:03:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] binman: bintool: run 'apt-get update -y' on first
 invocation of apt_install()
Date: Thu, 24 Jul 2025 11:02:36 +0200
Message-ID: <20250724090247.59221-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724090247.59221-1-jerome.forissier@linaro.org>
References: <20250724090247.59221-1-jerome.forissier@linaro.org>
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

'apt-get update -y' may be required to make sure that the list of
packages is up-to-date and that the subsequent 'apt-get install'
operations can find the requested packages.

Fixes the following CI error:

 Fetch: zstd
 - trying method: binary download
 - sudo apt-get install -y zstd
 Exception: Error 100 running 'sudo apt-get install -y zstd': E: Unable to locate package zstd

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- Use apt-get instead of apt

 tools/binman/bintool.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index f46bb52a7b3..141cc66657c 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -55,6 +55,9 @@ class Bintool:
     # must be called before this class is used.
     tooldir = ''
 
+    # Flag to run 'apt update' once on first use of apt_install()
+    apt_updated = False
+
     def __init__(self, name, desc, version_regex=None, version_args='-V'):
         self.name = name
         self.desc = desc
@@ -421,6 +424,11 @@ class Bintool:
         Returns:
             True, assuming it completes without error
         """
+        if not cls.apt_updated:
+            args = ['sudo', 'apt', 'update', '-y']
+            print('- %s' % ' '.join(args))
+            tools.run(*args)
+            cls.apt_updated = True
         args = ['sudo', 'apt-get', 'install', '-y', package]
         print('- %s' % ' '.join(args))
         tools.run(*args)
-- 
2.43.0

