Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0C9C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E30805DA;
	Mon,  3 Feb 2025 18:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TUjf3oK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655DE807E2; Mon,  3 Feb 2025 18:44:09 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46854800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb972dd8e5so2527971b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604645; x=1739209445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMkJT5uoRjIEAUIFT2EEyeYHwzNZG9LVKjoU5nFbcZ8=;
 b=TUjf3oK5RaqeAuty0eYNlE/Zx01SbOnyRTghqCM5seoI+tmWtZkByS5wy45aZTUHio
 EBYuZbwlCfwNExkKMervCa1lC95CWcnBEr9IsEb34kB8xAGnHZ++sqq4h810DnkJn+iV
 Z/lmkgCTd6hhqjxAMAT+3Wb0FCQkeVmd3aB8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604645; x=1739209445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMkJT5uoRjIEAUIFT2EEyeYHwzNZG9LVKjoU5nFbcZ8=;
 b=FyWXNMsHcF7IK4RrVhRrye/CRHGuvGmMDJEjZZPHuHLNJ++Y8eEo/1U7wtonZCplkP
 01GoLWjnUGzfUU58Lr+6ZnnnQDpgUEm4RihxDnGVVhg+T4ebyGVYLpzAkBZi+gU8Jl92
 5kODmsac0hxXcmAGtwCkBExRwIQ1ApLHdNoYlWDyPphrgs170w4m26QaYHqN0FFIy1AP
 OJPY8Y8ifcmyaxRrIoeymppqnXcDaTcAGoylYMWGTr1J9oHR7pfgAJK70+LFfPYstazs
 ZWgX3cutyHCDWpzrAuBM+U8Huoh0/9aeARV+HEXUxyEb98glYYj/3C42+FvNytoJLcI5
 Tl5A==
X-Gm-Message-State: AOJu0Yx9HHKgi+g0rpcB2u2pxY4Ns1ykZj9W8J1NRdABw9UO+vXqK7G2
 CtW4b8WYdNwiO0HZLegA993qBGJvYZwDp/Gbax2B2QM0MYqVy3RiRHWTp2xF4mA6CIw0+lM6Y3U
 =
X-Gm-Gg: ASbGnct4SWT8I6iu5j0+UegyCNHwGMqKtMrCy+/iexI9saKBhbQuKEmObJcFZzPU/lq
 MjwgRezxtRXkdBbYom7w9W6WJMKXBNzg4PCSeVAiULiBz6wLw7CLf4qrvkYihI4yqzIBUJeV9xk
 rF0HIM4kPs41hnnE6hkttEeXs4oqRI3ZHvNZzuuyda8n/yQmTbLdVOPkHBE92RPAZMUCzGeZIkr
 LIrdeUZxttSMLjUZ9vvt2VRit7kJjdiLMyItD/hqC6aqOzR1v9VGJeRL9YlwB0xmDED+1q8SESr
 KQW4231s/PruO6bhsd1j+GrjVv+flPFCgdyUO5fxdkck2HNlQAu0
X-Google-Smtp-Source: AGHT+IHJyuKsUAISRmKCIc9kK4IX7FdCw6/cz0fROH5q2YoxOJhxahHChRDAERfHb0UnxQGsJfJfVQ==
X-Received: by 2002:a05:6808:2f0c:b0:3eb:7398:846 with SMTP id
 5614622812f47-3f323b407ecmr15802237b6e.24.1738604645574; 
 Mon, 03 Feb 2025 09:44:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/32] efi: arm: Omit the ARM start-up code in the EFI app
Date: Mon,  3 Feb 2025 10:42:13 -0700
Message-ID: <20250203174245.1331464-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

This code is not used with the EFI app, since it enters through a call
to efi_main(). Remove start.S and crt files from the build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/Makefile     | 2 ++
 arch/arm/lib/Makefile | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index cb87a684754..2e569b330d0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -104,7 +104,9 @@ PLATFORM_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs))
 
 libs-y += $(machdirs)
 
+ifndef CONFIG_EFI_APP
 head-y := arch/arm/cpu/$(CPU)/start.o
+endif
 
 ifeq ($(CONFIG_XPL_BUILD),y)
 ifeq ($(CONFIG_SYS_SOC)$(CONFIG_SPL_FRAMEWORK),"mxs")
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 14e3990925a..9500ba6fddc 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,19 +7,21 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o \
 				    lib1funcs.o uldivmod.o div0.o \
 				    div64.o muldi3.o
 
+ifndef CONFIG_EFI_APP
 ifdef CONFIG_CPU_V7M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
 obj-y	+= crt0_64.o
 else
 obj-y	+= vectors.o crt0.o
-endif
+endif  #  CPU type
 
 ifdef CONFIG_ARM64
 obj-y   += setjmp_aarch64.o
 else
 obj-y   += setjmp.o
-endif
+endif  # ARM64
+endif  # CONFIG_EFI_APP
 
 ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_ARM64
-- 
2.43.0

