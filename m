Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A7E7D26A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E6386DD2;
	Tue, 26 Sep 2023 10:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bshmSt2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3336486D93; Tue, 26 Sep 2023 10:57:17 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C73586DCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso57196655ad.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695718633; x=1696323433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQaXXiYdoMIn6zmOjgfuPJGiZg66CABteonAptW4UKI=;
 b=bshmSt2EqUy2C1b2UuCGoDUprTylpSx7iO8ZbNpps62OSr6AhDvIIXaDp1lVCdG9bE
 XTm8mKtYxXCyU1hkbQZT9+NVN85g2Ll3u2MExefe5gWVbiFJh7Frg5rWsjrSv1UApYRN
 VSToe5xQve9LBvg3fPLYtn61Hxom5l904epKbM8Wmek+yw5aMnV5dBlZ5pxvQ9dzwasY
 7j83u0cObpoSYgfoWFXCKQPlh6vYTUKnvHBj7q9VAMp2R7awtrX4Oq02SGmYcYD8fBrh
 QYCrc1m89Pj+Nx/gbQxNb2yD1AZVq6+zyliUo7c62h3UDN5zmov0KREyYTJ0/yGGE2sN
 enZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695718633; x=1696323433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQaXXiYdoMIn6zmOjgfuPJGiZg66CABteonAptW4UKI=;
 b=lS9v54FLnVMWB51KvIKqVlZXdya0jpcgBWHRqcofKNurA3pZVzHiwLx8tnieHfSrkj
 VwnSF1LE5AbzvMDvC1r1nOOVTKe5mhcOnhEAzmtpqVlxnuBDo6uSfZSyBGyZInBHiqab
 1Dw3fLy/ZFrDk9D1cylgBfI4UCFgkByFU6Y1AmdfnLaNNBwRB6Uk13A9jndfFbmFdJ4C
 m1B2nuZPh/1dFQgPkwPyvDa2LFNdeq4l2WXWwqbMO79CSiJQQpYo3EZUn6K57q1iizA0
 EhxRjRze9wrMJ8TL+7+8SbrCE/5WxhVkjAWX7uBVpPx4S7Kq/kpwLMOgYg2K5cpZylsQ
 /fDg==
X-Gm-Message-State: AOJu0YykPPO7fGIUFTkfSvG4zfKut3LmSlffHKTHqSxlRIyx70ZoRaRq
 6K0ECbbGzxaJpL8yxq70BeU=
X-Google-Smtp-Source: AGHT+IE1oxp9gK7ohsVUDsSYZVpiNctsu4SQcVL1A3RUnoaUUjmAK9bP5kWuiChhxF6QNht+kJ1fqQ==
X-Received: by 2002:a17:902:bb83:b0:1c3:a2ea:64cb with SMTP id
 m3-20020a170902bb8300b001c3a2ea64cbmr5779255pls.53.1695718633477; 
 Tue, 26 Sep 2023 01:57:13 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a170903265400b001c5fc291f02sm6515863plb.216.2023.09.26.01.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 01:57:13 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] arm: npcm8xx: support dcache off
Date: Tue, 26 Sep 2023 16:56:50 +0800
Message-Id: <20230926085651.395069-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926085651.395069-1-JJLIU0@nuvoton.com>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
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

do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=y

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
 arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach-npcm/npcm8xx/Kconfig
index 5f4a0506dc..163e7e7d48 100644
--- a/arch/arm/mach-npcm/npcm8xx/Kconfig
+++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
@@ -6,6 +6,10 @@ config SYS_CPU
 config SYS_SOC
 	default "npcm8xx"
 
+config SYS_NPCM_DCACHE_OFF
+	bool "Do not enable dcache"
+	default n
+
 config TARGET_ARBEL_EVB
 	bool "Arbel Evaluation Board"
 	help
diff --git a/arch/arm/mach-npcm/npcm8xx/cpu.c b/arch/arm/mach-npcm/npcm8xx/cpu.c
index af59452609..fc691de950 100644
--- a/arch/arm/mach-npcm/npcm8xx/cpu.c
+++ b/arch/arm/mach-npcm/npcm8xx/cpu.c
@@ -81,7 +81,8 @@ int print_cpuinfo(void)
 
 int arch_cpu_init(void)
 {
-	if (!IS_ENABLED(CONFIG_SYS_DCACHE_OFF)) {
+	if (!IS_ENABLED(CONFIG_SYS_DCACHE_OFF) &&
+	    !IS_ENABLED(CONFIG_SYS_NPCM_DCACHE_OFF)) {
 		/* Enable cache to speed up system running */
 		if (get_sctlr() & CR_M)
 			return 0;
@@ -143,3 +144,12 @@ int timer_init(void)
 
 	return 0;
 }
+
+void enable_caches(void)
+{
+	icache_enable();
+
+	if (!IS_ENABLED(CONFIG_SYS_NPCM_DCACHE_OFF))
+		dcache_enable();
+
+}
-- 
2.25.1

