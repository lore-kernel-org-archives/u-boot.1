Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C340DC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5668388D;
	Thu, 24 Jul 2025 11:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TwMMIML1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA40836B8; Thu, 24 Jul 2025 11:14:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4295883826
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so4505675e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753348443; x=1753953243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CQEalSoYHX3M4b/ndPhEy82/+2fJV/JWg7t967qz3s=;
 b=TwMMIML1H4NlcVCvRLp6zP1heloA3qunES95wOIYWs0K6A5eZdt+2cTabLyTr5zOaI
 PgDMUkpKNRbytLPCCNUKmINyn0yX7r77JPYBEMQQXCxfpuNzx0f04TZ10lfm3uWF5hVm
 6AxrWHdpa5dVbDNAHqlYdkc1zapvX7V6NftoQWB+dV/gPHGrIckYVD4qIxps5JwnlbFu
 6X1YMrJ9FhBYNK8+4NUAJtd0KRvNbOiCvt7eBzZ2a7L+YRtSSvsnuTW4WHOt/FPpg24O
 H3VcquO8DVc/kndckFUquWIJ4bhUudejTfxl8mFSUxdWQb+hGm/SFxokZNYWVS89QG7s
 ZvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753348443; x=1753953243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CQEalSoYHX3M4b/ndPhEy82/+2fJV/JWg7t967qz3s=;
 b=LhMDNiGjbZvc89oYcBR5w2z7TJhXDAe5JeIFtLpaysaOqmJworjXYVX8ayltfp2RbM
 VC5qsGlrlBDvu+8+CkVoDkS4nFMG/N/tG1+BDds/zvvTt8o/ysghZjh/nMZyHdau92UG
 wrbbZ5jNx7ea8ckIMFXZv/+P/By+M/4Jkz0YGCasnkJTX+EVxnSqh/6109IG8suTadhU
 vO8ToZSIurHtq9lnYWYGbnXaZ+leYCLDbzi7tnR0LLciCiguevdWEbLXyWncNFhZZPf9
 Rcejc5pRTJiPMNl1UGYzqiG64OiwN9wPnmQzAzJLryeOE9Yq9yvz+IH2Gq0rzlRCKtr3
 CsuQ==
X-Gm-Message-State: AOJu0YyyFxvXVvzMXEO7K71XZz9T4eOj5IFn2zzMJvLwXoyCRqFjRkyw
 XTPEgRBxM5LFUSryaA7dqQyzkz76bMqG+Cbyo9EQImBNFi64brP42e+kPeDCNna5ZqTTAV/UCMZ
 ZT3OH0rSgCg==
X-Gm-Gg: ASbGncuT5+MvPGEw+/8Zh7eEULiqKsXWUdbJDfY8affN0ANGGnqu+Mm1YJJpwaSKVg5
 /WhJ8tkZACM4zga1rpIPCwnza4fPMiL97OkyOCB/YmlJby2FO4woBi+3BW12f++TrWGeF8TPicg
 8sRw5ujc/T6kPGdyub6lz0gFim3ZFkta9nbbSuvGfz2YGwKKGr8Yq9i3xvBkVHiSzGotcKX7i9L
 pQT0eLnHu38zYuuaZLklWjKBYOb1MrkeJBnD2RqKybqMzF6jL+UdX6AjTMqIHpJLJCQCEvVqMmY
 eLAkAs7F/qTVcPTnj0LBOdQT9fBaIOtL568fVYphKQ9RuPdPxu0j6P5IxTn2ApvBNcUfJvslsRr
 8HXyl66XnL+AtDwTApeG/kRjvQFOZew==
X-Google-Smtp-Source: AGHT+IEFeUfQenPsxsO9rfC4YW6207G9SB67d2DG/1qAioguHjBfvUL0gdCdfJbA0mwgfZ6YuUFJkQ==
X-Received: by 2002:a05:600c:8b30:b0:458:6733:fb69 with SMTP id
 5b1f17b1804b1-45868c9dbb1mr59670235e9.14.1753348443344; 
 Thu, 24 Jul 2025 02:14:03 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586ec63d29sm15522595e9.1.2025.07.24.02.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:14:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] binman: bintool: run 'apt-get update -y' on first
 invocation of apt_install()
Date: Thu, 24 Jul 2025 11:12:41 +0200
Message-ID: <20250724091342.59902-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724091342.59902-1-jerome.forissier@linaro.org>
References: <20250724091342.59902-1-jerome.forissier@linaro.org>
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

Changes in v3:
- Really use apt-get instead of apt

Changes in v2:
- Use apt-get instead of apt

 tools/binman/bintool.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index f46bb52a7b3..9c76c8881a4 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -55,6 +55,9 @@ class Bintool:
     # must be called before this class is used.
     tooldir = ''
 
+    # Flag to run 'apt-get update -y' once on first use of apt_install()
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
+            args = ['sudo', 'apt-get', 'update', '-y']
+            print('- %s' % ' '.join(args))
+            tools.run(*args)
+            cls.apt_updated = True
         args = ['sudo', 'apt-get', 'install', '-y', package]
         print('- %s' % ' '.join(args))
         tools.run(*args)
-- 
2.43.0

