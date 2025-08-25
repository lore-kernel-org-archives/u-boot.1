Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67225C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11208312A;
	Tue, 26 Aug 2025 00:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KFlQNkbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E9582DA1; Tue, 26 Aug 2025 00:46:18 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259FB830E4
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3c854b644c1so1455634f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161975; x=1756766775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y039dE6s1ohhkaAMQG1WOFq2umqD5uQS/SofKbrhwOU=;
 b=KFlQNkbDALmmBnmOxv+i6oQOuwLgTOUfm/9GbZqU9gfu9nsu02Ala34qBXKIq3odct
 lVyDRxrwZzbisV284+nBc3O9uuhbo0Q0oiBTzbf3l51BjgfBFtBOv4v2VCkAC5NHWmrg
 euPPEvmUO3+ig/SohIBzMIsQO8XmIeV2hAIBvSljHUEov1pdf3/+vjqZsx9gTXCq7Ypy
 TnHohlRoMv3yhzyTBOx73nrlxMfzX7Vmi/PUFN+Agl1R5oM0h1T5L4txMFEMZ0wrqdhx
 Je9g90zaT011AtK5NSMJeWrA0UA8db9jL6p7iDdEftTGDBDKERddzXKSAhKtMhxpTq2G
 Y8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161975; x=1756766775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y039dE6s1ohhkaAMQG1WOFq2umqD5uQS/SofKbrhwOU=;
 b=jW4tYa3CmVC3oKl6nhTjbYNPL7xX93pq15Wlrhgx/biSCpME0Mur0CJYVdpIxz0kuI
 lCIVR5WUhy1RkjTdmp0P33bvM5T5QtPybitx32pKgOwAIP04NAJFMW+DvZcsq5tzFARr
 zpbVbPWC4RF2OnLNn6PX9wkbtpSptHVICzX3MBfZmn1ksWxThBbHUGGMVLe8vXH1lvCD
 emHW8cXmD1UszRXE8Dk7ABl/7Q2u0LUkmYrOc8D2jmc/55Neci+Jr81D2CQKuk4wtgRE
 KAeHHCD3Dd5SA6RVOzsUHyBGesIFTX3fH4A8itKhpHnJ0O15NsUb8zNjprjRMS2V3Zjj
 82LQ==
X-Gm-Message-State: AOJu0Yz+n+xH7lUPz07hraaY8WuP4bhY6CenmcLjXQlumTVrgb9+z1N2
 SEw0Tev936asdH0gs4wMF2TOAJlkgpSACTJSxoF20gm9/qa2pAdXUXDwl0EJu3r5z4c=
X-Gm-Gg: ASbGncshTGUz6giqVB1F4i2OTzkt4e8xyQI1+6/V0eIPWiP8bfhwgNSSIQg7U2D47ks
 BQs8mGHmGNAfdzuUGAxCMYzwupUdd8cmCGy6ELsjk6u93MemdoJisr159Q0gGKzQum9U/qHDGSD
 N2hl8t3W3ayA4HmEtkj4z8qiPNXXvfK3aTslvehOCAyr62M2ZRlGHZ2LR7GcX7966KBKUKqBaZD
 6syIUJjAbA0kZCHqZNJvr85uF1EmVUr9QleKMB8J6SrEawrJNWWGWVqPcucCJ7E2Ji5yf37JpEW
 VzLIT6hVMdOXBM2RtPjUSFoZVl4tDdGg5goDKCy1QafTPeIa66GwIflC4LP///1yBql2/O/25/M
 PbkHRL5eAQUkExNg9EofAZPe4In/p
X-Google-Smtp-Source: AGHT+IGEi8roF+T5tSwCI+jpdMsttyD1BmwuZmqYITsxx68j7gbj8s8iXv0oZJcHGGHC478Q0WlZbQ==
X-Received: by 2002:a5d:5f8c:0:b0:3b7:8d70:dac5 with SMTP id
 ffacd0b85a97d-3c5da83b60fmr10779729f8f.2.1756161975203; 
 Mon, 25 Aug 2025 15:46:15 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:15 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 3/7] doc: make pdfdocs: Add pip install pytest to the list of
 needed steps
Date: Mon, 25 Aug 2025 23:44:46 +0100
Message-ID: <20250825224459.682403-4-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
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

If I don't install pytest, this is what I get with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
[...]
WARNING: autodoc: failed to import module 'test_bind'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_bootmenu'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_bootstage'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_button'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_efi_loader'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_net'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
WARNING: autodoc: failed to import module 'test_net_boot'; the following exception was raised:
No module named 'pytest' [autodoc.import_object]
[...]
build finished with problems, 7 warnings (with warnings treated as errors).
make[1]: *** [doc/Makefile:84: latexdocs] Error 1
make: *** [Makefile:2686: pdfdocs] Error 2

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 2540f3973d2..69e0dc418b1 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -32,6 +32,7 @@ The *htmldocs* target is used to build the HTML documentation. It uses the
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install pytest
     # Build the documentation
     make htmldocs
     # Deactivate the Python environment
-- 
2.48.1

