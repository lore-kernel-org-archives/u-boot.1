Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4093C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B6986434;
	Wed, 23 Aug 2023 20:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JBEKoVCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E20C2864CB; Wed, 23 Aug 2023 20:48:07 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5238646D
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34b4b2608e3so19030685ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816484; x=1693421284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KYZXB4X3zM6A3I/+gfrzshTylcbhVZJXtE8qv65cW0=;
 b=JBEKoVCpC/XgG1owEicK1VdEqs/epBEsNBJ0HV5LGe1FrLD4G89beKJrGpIoV1HKTa
 RuaRsJRPZOupak0w5e4Y6z1pyq9u9jNRCcw6OPHcnXL84XAxRfVtt9hwXEl2JOdpcGAO
 NTdYpgiWsB1VLL5A4qG4ZHCASscPP4LrvgRBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816484; x=1693421284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KYZXB4X3zM6A3I/+gfrzshTylcbhVZJXtE8qv65cW0=;
 b=PjFJWv/6/hCNMKmicDFhKKxD4WGFCwAxFgwB4YnjXdWcxXjbjQC4VLelAu76eZNazV
 n+Xao/0vbtm6c8UhaOFXpwIN3uqDnOzQhf7QkcHYPNT5slEXNtI2L4k+RoElLNwn1/Ku
 O2SM9YGTsOPthpS4nKoWL8FiMX3HKpCrcW2RughyAICxTdGKnlRQ68K5wvPx46BWDrwE
 zQTjh5hs82j8fXB6UOn/twH7g3UL2PiQrJscRLE/QeKNFgIVaDWRbdLBSCy5wyWtd6fc
 Q4bJpiTZy/Co9ixzZFMhRbPDF1N+StbHzWznBPXlaihtHPACirWAg5PuLed7gKPoL9Mf
 5oQA==
X-Gm-Message-State: AOJu0YxSJutSWKwADCBHirj3Rvg0NacCuhj/MINUwJxxcHGJ7aOoc8Nk
 NVW/PNblaxvhH177ijDPwZtCidcp/ZM1CMIqBQk=
X-Google-Smtp-Source: AGHT+IGxzGwh/6xy2P370y5EBJ1Yt/Lv6Le4avxNS3BgK6+FrjcrTLLNcvY6Mxphl23qUmAe3H5bzw==
X-Received: by 2002:a05:6e02:144e:b0:349:9af5:7a7a with SMTP id
 p14-20020a056e02144e00b003499af57a7amr4144292ilo.11.1692816484414; 
 Wed, 23 Aug 2023 11:48:04 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:48:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 5/8] x86: broadwell: Avoid initing the CPU twice
Date: Wed, 23 Aug 2023 12:47:38 -0600
Message-ID: <20230823184746.842091-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

When TPL has already set up the CPU, don't do it again. This existing
code actually has this backwards, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/broadwell/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/cpu/broadwell/cpu.c b/arch/x86/cpu/broadwell/cpu.c
index f30aebfe4c6..70faa1ca474 100644
--- a/arch/x86/cpu/broadwell/cpu.c
+++ b/arch/x86/cpu/broadwell/cpu.c
@@ -11,6 +11,7 @@
 #include <event.h>
 #include <init.h>
 #include <log.h>
+#include <spl.h>
 #include <asm/cpu.h>
 #include <asm/cpu_x86.h>
 #include <asm/cpu_common.h>
@@ -67,12 +68,11 @@ int arch_cpu_init(void)
 {
 	post_code(POST_CPU_INIT);
 
-#ifdef CONFIG_TPL
 	/* Do a mini-init if TPL has already done the full init */
-	return x86_cpu_reinit_f();
-#else
-	return x86_cpu_init_f();
-#endif
+	if (IS_ENABLED(CONFIG_TPL) && spl_phase() != PHASE_TPL)
+		return x86_cpu_reinit_f();
+	else
+		return x86_cpu_init_f();
 }
 
 int checkcpu(void)
-- 
2.42.0.rc1.204.g551eb34607-goog

