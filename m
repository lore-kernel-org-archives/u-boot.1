Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F891CA0FEC
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62AF68675B;
	Fri,  1 Sep 2023 22:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QycyobF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4529A8675B; Fri,  1 Sep 2023 22:41:53 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC9A866DC
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso1879948a34.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693600907; x=1694205707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/gr/2RNFDGPDstqP+X91P4htJ2kCLipZXRTuQlWkNB0=;
 b=QycyobF7E+xTFL8Esqo3x97KYdFxwZM6V3WV5RSzyWUzbhti1pjZoQAPKYULemxdPD
 I2Dq2fEzPN10vqQOsdz8bBswF+ItgdK1s3ZINQOaMQRNKSItzqDxzRLz21mJ6X84vlio
 M+KXEmx/HJ181ENyutKbdFOTlWMbsK3KSjMlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600907; x=1694205707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gr/2RNFDGPDstqP+X91P4htJ2kCLipZXRTuQlWkNB0=;
 b=hkmxTCP41a/Gw0p+xKowxZiN02Z+6RlNiA/DbW8I2xTLIMFhF5YXY9w4Vx0yE6BSud
 9XFmRDt9FUc56ZC7Hnx3vG3yE0GrVr25pADjvyuPlMH02ngVj/vt3tBu4YzaiBpog5Sd
 QYD4NQlWzsWJ4wfL/6EWQvYCKbeaptnDon+3JgF/YEXuGN7JBj7paNqxSeTMpHWzkpLH
 plk1gbE0+CdcrphF4qX0KZ4PNoF9VIwqvLMzCHlqUcBb99Y+DaRNJJtfYGCGr8qW1wlu
 ELR4cMeeWmKWk2z1rfVD1mtFqcnol63zsOEc+AWiMKdz5VvWkTzKU4DjjzlaFE4hSFzA
 2G3w==
X-Gm-Message-State: AOJu0YwiXuldxnhbq9YlY006HuPZhlj82lVojY31Db8lBfmPgeTV+wv6
 pPdCWtXnKeb8tQxS84EP2U6XO8S0S+AljnrbIaVcZQ==
X-Google-Smtp-Source: AGHT+IEjoEv8/FlPHlca3ywLwYd5kAxSqeqHztkmbNgSWxDtVM119L+ltsR7+kQmTcOP4LSG3xO/hQ==
X-Received: by 2002:a05:6358:60c6:b0:135:73b0:cc6c with SMTP id
 i6-20020a05635860c600b0013573b0cc6cmr3366735rwi.28.1693600906748; 
 Fri, 01 Sep 2023 13:41:46 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-4587-e14d-65a2-5068.res6.spectrum.com.
 [2603:6081:7b00:6400:4587:e14d:65a2:5068])
 by smtp.gmail.com with ESMTPSA id
 k66-20020a252445000000b00d071631665fsm1075707ybk.59.2023.09.01.13.41.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:41:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] Azure: Add sandbox64 to CI
Date: Fri,  1 Sep 2023 16:41:43 -0400
Message-Id: <20230901204143.3617876-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204143.3617876-1-trini@konsulko.com>
References: <20230901204143.3617876-1-trini@konsulko.com>
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

Now that sandbox64 can run and pass the regular test.py suite, add it
here as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 72a772ce9c65..d01fa117c3a3 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -334,6 +334,11 @@ stages:
         sandbox_clang:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-O clang-16"
+        sandbox64:
+          TEST_PY_BD: "sandbox64"
+        sandbox64_clang:
+          TEST_PY_BD: "sandbox64"
+          OVERRIDE: "-O clang-16"
         sandbox_nolto:
           TEST_PY_BD: "sandbox"
           BUILD_ENV: "NO_LTO=1"
-- 
2.34.1

