Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E899EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 07:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 597698642C;
	Tue, 22 Aug 2023 09:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQfQ3yXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BD38642C; Tue, 22 Aug 2023 09:51:31 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86EE686415
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so26565235ad.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692690686; x=1693295486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0B9Pr4vcy2/i4HUXWV6hdXmlscBCPXb7dubV880j6IA=;
 b=vQfQ3yXw6UOirxAY6R5yKs8CTEFzcyrcvrh/smmosfdVJHPYJK1YocxQJlLwFExE/h
 Bw0Ri6Th76YrMud/RdXm0NKJievfjChieUnQUIrG2sjonW9bYkBeNyU3v06HB9AZGRKv
 mbSDKzfD9/jMw53Fl8JsfUMsFVOz14Wt6zTv5QyGSH77xxyD8XuacduorZMgANyM4MmA
 CIWi/sPSClc1L464CJoLrRcJctb0EwuhD0Gy5Ax0/PYvFQaW5NRULlTyFC+8k6tSh+5G
 IGZdyFQR0yvtLvHrFUzqFMFKj5OCfkV4KGL+IkqYmAxRtsJfZAoDbFGhwKMeVgxT2YQi
 0t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690686; x=1693295486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B9Pr4vcy2/i4HUXWV6hdXmlscBCPXb7dubV880j6IA=;
 b=lqLxD22QcNKtesxRdOEKjFgyoPpCWBagmgWDTXdKMhHcSjJZ1KewHpusmtw2KgVEbD
 rsE7f7mDHmOLlG2K+44UNjSgEXdWydq0eZvzrlbmXh996TaGAVPdYAFAYMHedAGAMjt8
 t/6c95CF5Ic3IykefcM1ur0g86ldB1Du/Zb0wdahAPS/wp1DDJIpttKCtenXMqQ7KVCb
 KWsjJIm07SwE+7oumARFupfnZU6/3ewaOYEkVjxscgNcSrwCcOr+FD4lcR6ZcCUU3ZSH
 VTapmFVpI0myjqkdqpiGO0iwU6QrDjtqWRH6Lvp/DqgDldf2VPts4PbkMS6Sn6qpaxeK
 /RDg==
X-Gm-Message-State: AOJu0YxwNPOIG218TlW5nzyk8CcF1JzpAYu6nbhiS9nlYaDnWZGEcDKd
 5SykrQOXymt5pZIu4SUMGduHM/36UsiC0GcgWfI=
X-Google-Smtp-Source: AGHT+IH2pQGRmK1J5Dl3NI+Pi/ZzrQMKqLhy48BRZIC3hFgesuMRi9ukIwgLvgHFi3e47/71ZkFJdA==
X-Received: by 2002:a17:902:f68d:b0:1bd:ca21:c85 with SMTP id
 l13-20020a170902f68d00b001bdca210c85mr7154118plg.69.1692690686585; 
 Tue, 22 Aug 2023 00:51:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bb8895848bsm8422199plb.71.2023.08.22.00.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 00:51:26 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 2/2] armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF for
 ARM64
Date: Tue, 22 Aug 2023 13:21:12 +0530
Message-Id: <20230822075112.717992-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
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

Ideally SYS_ICACHE_OFF and SYS_DCACHE_OFF should never be set for
ARM64 (ARMv8) platforms, as it makes booting u-boot slower on these
platforms.

However, if some platforms require ICACHE or DCACHE  to be disabled
only for the smaller SPL stage, we should support such configurations
in u-boot as well.

Compile-tested for:
- qemu arm64
- imx8
- stm32

and run-tested on:
- Qualcomm RB3 platform

Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/Kconfig            | 2 ++
 arch/arm/cpu/armv8/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36ee1e9a3c..92bff715e3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -141,6 +141,7 @@ config THUMB2_KERNEL
 
 config SYS_ICACHE_OFF
 	bool "Do not enable icache"
+	depends on !ARM64
 	help
 	  Do not enable instruction cache in U-Boot.
 
@@ -153,6 +154,7 @@ config SPL_SYS_ICACHE_OFF
 
 config SYS_DCACHE_OFF
 	bool "Do not enable dcache"
+	depends on !ARM64
 	help
 	  Do not enable data cache in U-Boot.
 
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570db..0d0c1728e4 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -5,13 +5,13 @@
 
 extra-y	:= start.o
 
+obj-y	+= cache_v8.o
 obj-y	+= cpu.o
 ifndef CONFIG_$(SPL_TPL_)TIMER
 obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
 endif
 ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
-obj-y	+= cache_v8.o
-obj-y	+= cache.o
+obj-y  += cache.o
 endif
 ifdef CONFIG_SPL_BUILD
 obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
-- 
2.38.1

