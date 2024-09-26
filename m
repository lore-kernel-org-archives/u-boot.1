Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA733CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 526A8889AA;
	Fri, 27 Sep 2024 00:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lrpLq8+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC7288FCF; Fri, 27 Sep 2024 00:42:22 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9AB88E1F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-458320b30e7so9070521cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390538; x=1727995338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xD+l5m0VzmMnybNLCeYmxHfNUDd4vxLTso4SoEpt8Mk=;
 b=lrpLq8+ZxKC42SMdxMgoBXsRQRi2xhw/gHOttVMg29HMGAGjVLNBs8WrOkNm+n28Nj
 1H0A/tlvZfP6SoZx+TnSORWbv+jD2zFI6fNW/9Zjc3B52211OQaooQsOuPmp1UMl6CeZ
 3cUvZzseYnLSmR2Slo6r0iyDs4UA4P7hBAUD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390538; x=1727995338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xD+l5m0VzmMnybNLCeYmxHfNUDd4vxLTso4SoEpt8Mk=;
 b=kx3u6C0+rKdH/M2jhO/sHTpYlfdm0DZJ82iW2Jwwk/4xI31Rk5nMys7L77BhdI4H0O
 XDGUFD8EzlnGbLSlYCZxOQfhNaIWpaNWcV7Xxl8ic4i3znaZePCuEVRKoiAEjnl3IsST
 /eUjNx/eSfu6Ly2Wy/4AJ6XK7EJyyBtTRmIi9zJ5ffYRJkiUVgC41U4G3r33orUmG9dL
 MG5NaFlie16rvohuvzn/ZxTDKXn3zNNf0JWTQ3f2WIS2r7rwXbWHwp3oF1vNkpq5/Ku+
 XoUfNSTW1aXh8iyzwm4ATTY4PLEdjP3m/v4qX6c8FzzNZfecmLXAJ1KjQaIE/nQiR1cC
 Z6Rg==
X-Gm-Message-State: AOJu0YzJ2UIHRXSj5FrAnULs4NXcBCp+k/cVyHyJd1uvN6By0uXK6r4N
 4JdwaUgssk3ZXpML+3bPNehyfnbpk7uV7JB/eJXsGEi49UMLKQuSTfc/Bc3Ya2Zlk55/VY0Cq0t
 qTxZ//OU=
X-Google-Smtp-Source: AGHT+IEffKrHeueluDbQVqSGvTjh8sgYyskWe0++lqBL+mcqGMP1fusp+rXXUHi3WCPaJIBTB2otvQ==
X-Received: by 2002:ac8:5a87:0:b0:458:3154:4d0d with SMTP id
 d75a77b69052e-45c9f282996mr15604571cf.37.1727390537972; 
 Thu, 26 Sep 2024 15:42:17 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH 16/42] powerpc: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:41 +0200
Message-ID: <20240926223814.1276764-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/powerpc/cpu/mpc83xx/Makefile | 4 +---
 arch/powerpc/lib/Makefile         | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/Makefile b/arch/powerpc/cpu/mpc83xx/Makefile
index 9974239f881..7c4ef7657e5 100644
--- a/arch/powerpc/cpu/mpc83xx/Makefile
+++ b/arch/powerpc/cpu/mpc83xx/Makefile
@@ -7,13 +7,11 @@
 
 MINIMAL=
 
-ifdef CONFIG_XPL_BUILD
-ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
 endif
 endif
-endif
 
 extra-y	= start.o
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index f797f8cee66..b218ae2b91c 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,13 +9,11 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o
 
 MINIMAL=
 
-ifdef CONFIG_XPL_BUILD
-ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
 endif
 endif
-endif
 
 obj-y	+= bdinfo.o
 
-- 
2.43.0

