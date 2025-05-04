Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B7BC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DAA82928;
	Sun,  4 May 2025 15:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ETTpIwua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5BC828BC; Sun,  4 May 2025 15:24:09 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B1B8297E
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so609565766b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365046; x=1746969846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v26vQ2tDJg8fdFAaMKSSGj/vzIXJiVLZCRPegor1wQ=;
 b=ETTpIwuafeV8+8E54YnbT5zcVPU1vpRFHxTEHhV5sJwHikrao+gPGZ2SspPi24Qpoi
 F0c1RGbl5gik6d2W/6l3pU4pNl2OBzmc3kI4Gr4e9rg+V0vfUaHKaHhH48DoU9HP4EsR
 OdnTZmf5c8AJSuEys9Vq9LRGr5vzXxw9N1HY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365046; x=1746969846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v26vQ2tDJg8fdFAaMKSSGj/vzIXJiVLZCRPegor1wQ=;
 b=POqjyMnlipX2KeH/SQ99gVMN6zf74LUBK14uEzm+KDDn52T+20/TwmDnTzxGA+9plK
 zc5MrmGe0zwnYDgkw5mQ5xY8WjalsUMkWyAMTHYVgHLZoUKRxn87Z+9teqJnc46zArWU
 UxgjAtI07iwKA63WEO0MwD9OFhgUE8p3C9G0BBiwWP/wfWDJOUbDlfP7/rJ/OdaopVmH
 qEZVbnVs98kRTIHOEZqCa854MVe6Ce4wbcR9uU+gCWkicgYCJiikqTnpmPHuKzsLFMew
 pjXOPB3oo5Sog3lngLQMN27QU05FHByutac3jtqH7usY8uAnJ+KnSy322YdH5YFnPTPz
 SPvg==
X-Gm-Message-State: AOJu0YxBiMZ3Jz4DHhgs5JfgJwdc1vYb9sGrBOYYiKSoPbEk1Gi+TZg3
 oZFIw9cueCoEbqYSNP03zA/76jV416R+lWkD1u5It3afb/VazooEby0kQD3Z/lHi5Trz8cquzXj
 3eZGU+Hw=
X-Gm-Gg: ASbGnct/qvrNyUkPl1gklUcnUywgiNa9FKoK/IHCgBeyxP3I8jGoq2oNNzxnM5SQtGB
 uW2wKmEwn5d+Qbx0A9YKNDNNepBQ8QY8Em8+K2pp3kbmIWcSG9I8EPZzMH8nTmqV7lsd/hbwEhK
 x685+Fh5dUgSGetGkJAAFd7exbWTpiKur8r5p0tyxGUtJ5YTSMGmR55l3Z4Gc3CK1NNVNT8Dlyk
 kCOTJyMFYURnb5E0l0gu4+9ZkVzyoOtsmpxecwfRrnJu6YPmeus9GXgT09PysXml5MgAOej+7hf
 zF69mIaKDPeQjrMbw8Uu+V9pp97T/lQAgtqj
X-Google-Smtp-Source: AGHT+IGfZAkAHNvlhxXy2hFD6AdWbELskxr0DgtA/M+fXLBQVHpbeybTobCvXf7vmV34Ai0v8mAe4A==
X-Received: by 2002:a17:907:6096:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ad1a490ec6fmr381438466b.13.1746365046118; 
 Sun, 04 May 2025 06:24:06 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/30] binman: Correct a typo in the toolpath comment
Date: Sun,  4 May 2025 15:23:19 +0200
Message-ID: <20250504132356.2317305-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

Fix the 'ist' typo in the comment for TestFunctional

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a0a1fea5155..f2f478d5e7e 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -279,7 +279,7 @@ class TestFunctional(unittest.TestCase):
             preserve_outdir: Preserve the output directories used by tests. Each
                 test has its own, so this is normally only useful when running a
                 single test.
-            toolpath: ist of paths to use for tools
+            toolpath: list of paths to use for tools
         """
         cls.preserve_indir = preserve_indir
         cls.preserve_outdirs = preserve_outdirs
-- 
2.43.0

