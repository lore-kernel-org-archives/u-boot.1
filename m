Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A4BE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 20:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143A68022B;
	Thu, 12 Dec 2024 21:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z/JUK7XC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B660801FE; Thu, 12 Dec 2024 21:15:06 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F118010E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 21:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d900c27af7so11755896d6.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 12:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734034502; x=1734639302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=X6IFMo4SeAPkNOASUTeA8sWITNKjPV99Mz10kNkVCvs=;
 b=Z/JUK7XCiLdqWAS4IGxWxjiorftLI4zf4wvW73lqlMIrWlpaUG9rdtiEuFCmnu+BQH
 RJmIaqT4y+VSQfKPdlZhDEwYklMmogxL53LniV5X3RxlyY0PnczEehm4+k+BONWbOdrT
 CQe46POumfZekN30G22yds2ga4zPN4lUe9rIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734034502; x=1734639302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6IFMo4SeAPkNOASUTeA8sWITNKjPV99Mz10kNkVCvs=;
 b=k7ghc/ggDmP2c7tv5lyaDrQVXMdzXG4gRjYvtG0p8DWGuQnKtFW1lZa275dAHLdOWX
 B52bPu+6WZ0vuAcJLttYmGMAVGltzyZvClEypv/ft2P99yJsMb5srXYlXW+t+Z7nYkKi
 APPC8kt3hlsX20xM0Z7ZVp+fD525NN2L7g/56ZuGan3V0eZKGUt/5riJvjfE129ApCdG
 hQFvTMKgKoKSQA1/olwXLjjvXlVAEigVIOxiI2bviN5szuIEwhDoHk1Mzd/tCHf8roX9
 PXfd+wAlIVtzekugBnYKc5pVy69dHIP/6YFkU+EBoUXKsds//Wv87VU9mIJTHkqOCeA8
 0yNQ==
X-Gm-Message-State: AOJu0Yzq7eHs4IzcO/eDSAsU4X80WKqvSZyhEHVQEiYOgRkc93qgS4r+
 947e3Pzo0XISL/k6k43yGIdVfTfyjPVoX6oi3z2s/9B93HEiTOD89nSMEFIvKL2Byqeof7ChEIQ
 G
X-Gm-Gg: ASbGncuXsKDKwjEcboTS4Uloz8HCBt5634C7LvJX3h9rOfEUdiISM0Hcm0utG7rZ2pF
 xN+02aKrtgG/vfey9Dy718du6eGrqKWLwfiqpY9O4tBrKEjCQKs9s3ICBohszYftmfXfgRNvGH6
 DAOb5EoYA53WIF57nXMNbHe2wSdcVY2URW3IZ3uHYsvVbVDTFUgQ7bNgvGXE6QQY1spKJRbNJDs
 eHFQUSCDUrSylY3ry/hfyO7yIHpWY0xpIroMMXopkXmq0axU4hGuvvDSiWrCmEA4YBg77TcqwX0
 wbE=
X-Google-Smtp-Source: AGHT+IGTAjKsCIDt00/dKN5MyxA+GbEgzEAvJHvLYL+yfeHlcYCecdG37cdGukkNWYldd2QgMEdGmg==
X-Received: by 2002:a05:6214:5017:b0:6d8:aa14:f5b8 with SMTP id
 6a1803df08f44-6db0f838df7mr25369586d6.40.1734034501823; 
 Thu, 12 Dec 2024 12:15:01 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da9feab9sm84970566d6.71.2024.12.12.12.15.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:15:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Make test.py stage only depend on binman et al
 testsuite
Date: Thu, 12 Dec 2024 14:14:59 -0600
Message-ID: <20241212201459.1613044-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Our Gitlab pipeline is currently broken up in to several stages. This
was done with the thought process of "we should test tools and if
they're good test emulated targets and if they're good test real
hardware and if they're good test the world". However, in terms of that
first stage it only really matters that binman, et al are still
functional. And for a few years now Gitlab has had a "needs" keyword
that lets you refine pipeline dependencies. Use this to perform the
minor optimization of having test.py only require that tool testing job.
This will become more useful later when we add long running testsuites
that we do not want to block later jobs.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
More specifically, after talking with Ilias we will get the SystemReady
IR ACS testsuite as a possible job in CI. But it takes ages to complete,
so we'll be (a) running it only on tagged releases and (b) want to make
sure it doesn't the rest of the pipeline.
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2164ad79a72b..807837b6e118 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,6 +23,7 @@ stages:
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
   retry: 2 # QEMU may be too slow, etc.
+  needs: [ "Run binman, buildman, dtoc, Kconfig and patman testsuites" ]
   rules:
     - when: always
   before_script:
-- 
2.43.0

