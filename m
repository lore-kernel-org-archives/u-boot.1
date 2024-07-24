Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5EFC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF77889B0;
	Wed, 24 Jul 2024 17:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mFTarFdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D7C88962; Wed, 24 Jul 2024 17:09:54 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3381F8899A
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3970f9331deso28076525ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833790; x=1722438590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PSmVo8TzeGfazt+iQTAQD1SvaxvEXUHNG6f81e5Kjg=;
 b=mFTarFdRV0vBvZj7r3G1vm4EdNLWJtO3hVSf+R7Eb5kw24Ikht6mqt4+n/5ji+MGBm
 IfW4q9OBhBsUUQuA2qmFjZ+BN3pp6u6v/Zz3eDkCITF57i89u4k9VTkZ1qx9Az4JLe04
 jNdzDbmHA8bOTJU8M70aeTwfc1dOhAatn3I2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833790; x=1722438590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PSmVo8TzeGfazt+iQTAQD1SvaxvEXUHNG6f81e5Kjg=;
 b=cUYFuHd+y3+um6xsFk/aolqzu1hZSXIpmTQd1jdU3Eo1vIWErxa+nMj/6H0N6eljtq
 2RkOFezC0fXngrsa9ueV+PTTLgsyejPaBK3g8eIGUO1GpZLwL5Ch9DWpqaJEAH8Kg1FR
 QirWNz6odeULjFhxnG9ZCMH70ld2VrkiE4LrbU2v0NWf0GJ6KO64Q5lv2RYSyCdeKMFR
 YsTpx0VTLd+hG0a5zx7BSaWy94ymw6Wxq9MqK+6XoPPCTcmJ3+ZAtBXwuEWvfw7bqM73
 mhruP492chTNmaR2OEfk79JIdDHfEAIHIabAlZ4OdRtyj6gnLraiwdcl9eXCbN5vC31q
 tNLQ==
X-Gm-Message-State: AOJu0YzcMFe/ixV4UyEAK56Cf878f4KQlQt1YJ7169Kpg3yawHZzCDop
 f24jKpw5NV2/s59eKq1QcPu/iLkMQa/a/mCjkabY0KlXQNx180aJGjudcvar2mMrKN7WZVSSTpU
 =
X-Google-Smtp-Source: AGHT+IFosrHA9JS1Zh8oA5JzejuoPb41nJBMkhq8LSrlfRYYtyOTaQue1UDTOqsLJqwEk9Dj1IilGQ==
X-Received: by 2002:a05:6e02:156b:b0:397:3045:9dc2 with SMTP id
 e9e14a558f8ab-399403c05b7mr155736245ab.27.1721833789718; 
 Wed, 24 Jul 2024 08:09:49 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 14/35] global_data: Drop global_data hose
Date: Wed, 24 Jul 2024 09:09:01 -0600
Message-Id: <20240724150922.2343249-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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
index d014beb2617..e57015365c1 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -210,7 +210,7 @@ struct global_data {
 #endif
 #ifdef CONFIG_TIMER
 	/**
-s	 * @timer: timer instance for Driver Model
+	 * @timer: timer instance for Driver Model
 	 */
 	struct udevice *timer;
 #endif
@@ -297,12 +297,6 @@ s	 * @timer: timer instance for Driver Model
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

