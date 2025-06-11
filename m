Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472DFC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FE382C30;
	Wed, 11 Jun 2025 22:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iQ0vHgam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16715828A2; Wed, 11 Jun 2025 22:24:58 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E3982B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so157810f8f.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673495; x=1750278295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jjj4S+SXWtWZl1U0074q5WFVEZe2vyUPwWkEBn1UlSM=;
 b=iQ0vHgamNkg+zXiHTaPt/xgeCAGR6BGgSf3eahnh1oAECfvzwOEACvNquUMjfW/gb2
 LONImJg07M7ERCH1wvt7lemtFay5w+SlFmFwzAyFuRZGV8E1egboAnHpp5S4g+xQ9Ehk
 eICTQYbhXdPDECRd36VzwVrtN98psfE5XKLHm55Yw6fAKkUD7OMCMCy65rDwtVxc0kFW
 FNdWKulIMIuG/eI06+ia8CFeBdlWv9nsMhPretk7RMk3nS0HRYrUIL8QUdg0TTYo3qB7
 jwMVO3/HwScVnW5LmYIU0WgbkpQ4WOTiUDIrhD3PqB9qvJVfUSpzOGYZdNmeOp5loBSr
 yd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673495; x=1750278295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jjj4S+SXWtWZl1U0074q5WFVEZe2vyUPwWkEBn1UlSM=;
 b=e82BDUFvsiVqIog0PGfns16y5B2GWUTAt4WUL68dFvImrSAU7B8kmdedgoMLyg7n6g
 Juna9hmrIucwTuMk7iESErrad0lsilIVHXQS8qlZlziTPPDkFLT+Ch/cbv9kJDVZ1HQK
 8ZSwi13YqUIEjtIXsrLQ5m5CmJG4EWxY6TVsPTPhEk+zRbHx8E43kepZ5t32VGoIq8Yw
 PuRk7RV9l+eWI9MaCM/i1EeZ6wB8pWxMctqLmfufNrpiPTlHCXPzzT5e0xdCNAQBMF8D
 8IJsC6rZGFKV3H5pjBJIjjwiGmLQMZn097Aie7e9x56end94ExrgXC+AjbHwxWAQChKA
 iRuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQkppA+yj83JNXdllu8E9jR0T8Xbp5Ao5LRiEQGHR4dTapTmw3//Bib9cUJVhh2boc4oy+o5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyAvg7Z9/zTQwE8O9HIluQw5XgKBkVE00mLwECqVtugoTH4Z5cL
 VyQtb8E04knDOcu4N8I1jZI0JPxU1x/2ZK59J6NSn1bi/bt4lYkmnlIPLTeRfEWtp2U=
X-Gm-Gg: ASbGncuGnzKwXJiCIddTPQcl78oH7YThgDF8aMHU7rUfdI2cPQID1pn14CGxvJRN1i2
 eWM1YMtKDW0mjJSh2Y4WS6GOeycXqmEJmscvA03mY0HPuZhKwxDoZbGfhVj9f9MxAWJYijoHZ7K
 NoJacOon3RDtmukdD5awe1qIGUKgH9A4lEXphpZRDsITOlc9TI6ObG5cHjWrUcDiGnYLWGzIjL+
 riEo4fpI7gR5H9xxsepvBwtIwMFrqOaMGieMt+33LSZSm8WnETqm3T0D8T/NMNYKWl8pr5pbA8a
 Mrjb9h9LIamRb7rAqYKtlSC6BQ1mIaRLFMZ55rx3tWUiwWI7wmoJjHJ0mbMZJgSzmIezrDHx5hL
 j+CoaydhnBOxbgz59UwzPVXkUebS6SO1DNSKkaFjM
X-Google-Smtp-Source: AGHT+IEX+GkeM7guhR5qXH0429WiFaFF6pptcEUaENqXryNUZqGEOsyVTS2hluni0qK8XANBItDxwg==
X-Received: by 2002:a05:6000:420c:b0:3a5:14e1:d9ec with SMTP id
 ffacd0b85a97d-3a56075d5f8mr544292f8f.51.1749673495600; 
 Wed, 11 Jun 2025 13:24:55 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:24:55 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 01/13] kbuild: add -fno-PIE flag unconditionally
Date: Wed, 11 Jun 2025 23:24:28 +0300
Message-ID: <20250611202449.2317279-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit 42a92bccd213 ("kbuild: add -fno-PIE flag unconditionally")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index e1ac2d9cec30..6c01ccfcb97d 100644
--- a/Makefile
+++ b/Makefile
@@ -435,9 +435,10 @@ KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
 
 KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
-		   -fno-builtin -ffreestanding $(CSTD_FLAG)
+		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
+		   -fno-PIE
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
-KBUILD_AFLAGS   := -D__ASSEMBLY__
+KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_LDFLAGS  :=
 
 ifeq ($(cc-name),clang)
@@ -457,10 +458,6 @@ KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
-# Don't generate position independent code
-KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
-KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
-
 # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
 UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
 UBOOTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-- 
2.49.0

