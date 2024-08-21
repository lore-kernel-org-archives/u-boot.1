Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB55C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C8E88E4F;
	Wed, 21 Aug 2024 18:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IKt9VocI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D0A88E3E; Wed, 21 Aug 2024 18:19:51 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F7888E12
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-704466b19c4so3975678a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257188; x=1724861988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1C1QWOt7Nc53x9hAhObUKMQH5WvPcUpeST/povX4Lvo=;
 b=IKt9VocIVsfzps8KaE/EbJUPxaKqPnkJsgkBKyF8ymnb41V6KcpH75CllNY1Wfxdto
 bKcuQPRLiDVOnhH4WcCcAero0p7ljo3dVifRP2KtD5wYUdBPHyn/qg8jsGYE52EGjwrR
 YkGbQ8oGPi0a+Qbn3L+VXfu2Buu1GqOAJlZ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257188; x=1724861988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1C1QWOt7Nc53x9hAhObUKMQH5WvPcUpeST/povX4Lvo=;
 b=Odr4Br6nct1x1PvCJ0SCLOBgf2dwKK3rpxV4VS+FghwlI4x+a+gfMsKEteFajmOgnK
 8uiX6UZJ1obVRgFdAVVb6448nQVTupmMeRrh0xiYBxY0HRk1k67CIP34mOF0NPOWge5O
 oaV33am2MCsCbqCcXiylr5BUVxzb2/xUGUFpG4+uw52zLwIHmOfrTG1eU1HGxbMMtZvH
 olIbmdTcaDKviJBZdxgbrnTeg4vNBuYEOFThf3JzM4pwQDUUiftEflpNVp4K430gYlnL
 snLb1SJooNMXlBcVAuV0Wfgf/ACEHrrNO7cMyv8athIXWE+tNb3quNTM1PnJ2IpggGxQ
 XrCg==
X-Gm-Message-State: AOJu0Yw+JLvM9hajUh1fnsWj3qGbV1JC2UOPK0zzhdymwep9fQ+P1EB9
 ykN0N0vDU3uzqL+/8IZU6pTrYXixf64zMokmfdPV4KWgajQei60MGQcP6YtERQErY5kWpIheMaE
 =
X-Google-Smtp-Source: AGHT+IHIkPRk429EenW/0mNhqaUZldEzuVKmwYFo2sHbiW7BxpGsMycRIFpBwnZTGohy8vVrSjDsvA==
X-Received: by 2002:a05:6830:2644:b0:709:4793:8757 with SMTP id
 46e09a7af769-70df85d5277mr2953629a34.2.1724257188048; 
 Wed, 21 Aug 2024 09:19:48 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/35] global_data: Drop global_data hose
Date: Wed, 21 Aug 2024 10:19:06 -0600
Message-Id: <20240821161927.695717-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This is set on one x86 boards, but is not used anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/ivybridge/cpu.c      | 5 -----
 include/asm-generic/global_data.h | 8 +-------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/x86/cpu/ivybridge/cpu.c b/arch/x86/cpu/ivybridge/cpu.c
index d71ab0a6385..05691a38d2e 100644
--- a/arch/x86/cpu/ivybridge/cpu.c
+++ b/arch/x86/cpu/ivybridge/cpu.c
@@ -55,7 +55,6 @@ int arch_cpu_init(void)
 
 static int ivybridge_cpu_init(void)
 {
-	struct pci_controller *hose;
 	struct udevice *bus, *dev;
 	int ret;
 
@@ -65,10 +64,6 @@ static int ivybridge_cpu_init(void)
 	if (ret)
 		return ret;
 	post_code(0x72);
-	hose = dev_get_uclass_priv(bus);
-
-	/* TODO(sjg@chromium.org): Get rid of gd->hose */
-	gd->hose = hose;
 
 	ret = uclass_first_device_err(UCLASS_LPC, &dev);
 	if (ret)
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 1db1fb651db..b860f3626b8 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -211,7 +211,7 @@ struct global_data {
 #endif
 #ifdef CONFIG_TIMER
 	/**
-s	 * @timer: timer instance for Driver Model
+	 * @timer: timer instance for Driver Model
 	 */
 	struct udevice *timer;
 #endif
@@ -298,12 +298,6 @@ s	 * @timer: timer instance for Driver Model
 	 */
 	unsigned long malloc_ptr;
 #endif
-#ifdef CONFIG_PCI
-	/**
-	 * @hose: PCI hose for early use
-	 */
-	struct pci_controller *hose;
-#endif
 #ifdef CONFIG_PCI_BOOTDELAY
 	/**
 	 * @pcidelay_done: delay time before scanning of PIC hose expired
-- 
2.34.1

