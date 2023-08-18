Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D0EC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6686286C0E;
	Fri, 18 Aug 2023 02:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LWcfH2yN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00FC86C04; Fri, 18 Aug 2023 02:27:20 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCB386C01
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34baf19955cso1407995ab.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318436; x=1692923236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37hJ9HlpUNr6X/Uftwt2W1KqkPmCc+NrJrpJ0QYhZRs=;
 b=LWcfH2yNc7o9hutZsMPSqPrbTBvowEJfI57eQWxo0D8nQTVTD4naMxxBWeCXYVKdHh
 FJr7l13ikhsiuhX4sup/XhWwLbagROTatdMYpWIlkO4gD2OeQPd6S8Iv36w4osgcwray
 Szx570+fg59QA3YSLqCDvHTlvksYJK3ghkbcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318436; x=1692923236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37hJ9HlpUNr6X/Uftwt2W1KqkPmCc+NrJrpJ0QYhZRs=;
 b=DM35aG+B4UimjrcTnolyrgSqrOAl8pFgY7rGLiMhb/c9apE1Kp8UA5snr+CeyG60cs
 xLxKg1ESlOb4ssy5ciofwfH8XJ25meEsUNxObicZQM/ld5DfpiKHYrpc98jz87IDItR6
 vCnp3TcR6vf/FXYJ3FGAXLDQPVNnjE0l55ppWzjnloAbZWX0IadGl/jsOaWzhjG29x6b
 gLu7GGCtVfPfxz6CuN2QBq6rWb7OEuC6KMPp6FbVc+h9bWxlu1vROct9e3Ra2Nm4wHmg
 le23iZpeNu9XsKXiGItSHECZY9P5CDO68DhiNZvOHpH+K3K+ft1EmF4pdLDtzbECMnv3
 ATsQ==
X-Gm-Message-State: AOJu0YzBMEeZ0oiLyyIN9+FMH1GTHS/ajpN4v+QOaZqXTPIj2arNRiex
 Wbe1M+V3HSXUC6ymD/5wKSbYSGrGZOEDiRRmGBc=
X-Google-Smtp-Source: AGHT+IHp89w1oC/d+IbyypnqBGd+290LmURJrt6I7NbnQd0fXAAW2E9MR0n/QzHzKoXjxpxdR7RzLw==
X-Received: by 2002:a05:6e02:e50:b0:34b:ab5e:efcc with SMTP id
 l16-20020a056e020e5000b0034bab5eefccmr1367099ilk.10.1692318436258; 
 Thu, 17 Aug 2023 17:27:16 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 03/20] x86: coreboot: Rearrange arch_cpu_init()
Date: Thu, 17 Aug 2023 18:26:42 -0600
Message-ID: <20230818002706.853550-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

Init errors in SPL are currently ignored by this function.

Change the code to init the CPU, reporting an error if something is wrong.
After that, look for the coreboot table.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/coreboot/coreboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d7eedbd7436e..a0c62cce2293 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -20,7 +20,14 @@
 
 int arch_cpu_init(void)
 {
-	int ret = get_coreboot_info(&lib_sysinfo);
+	int ret;
+
+	ret = IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
+		 x86_cpu_init_f();
+	if (ret)
+		return ret;
+
+	ret = get_coreboot_info(&lib_sysinfo);
 	if (ret != 0) {
 		printf("Failed to parse coreboot tables.\n");
 		return ret;
@@ -28,8 +35,7 @@ int arch_cpu_init(void)
 
 	timestamp_init();
 
-	return IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
-		 x86_cpu_init_f();
+	return 0;
 }
 
 int checkcpu(void)
-- 
2.42.0.rc1.204.g551eb34607-goog

