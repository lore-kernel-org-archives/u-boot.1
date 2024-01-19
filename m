Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAC0C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CE087CEB;
	Fri, 19 Jan 2024 16:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fUFj/f1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FCB87CEB; Fri, 19 Jan 2024 16:12:28 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF38887CF1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-783182d4a0aso58322785a.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677144; x=1706281944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uu9KOeZNqt2BbwLm17KcDIla7TLl11DDjvBPhEb/xBI=;
 b=fUFj/f1CTGfjJxdsB25kXiQql5mQu+PRoPLElihcND3QjgEcwOBnp6Po6LusK4o4PR
 hq1NZvVg3d1NKxV2TzKm8fGFi0Pdtbv8WCYx0seEZlFXtcOKyqa76yBzO2nGPbLmaOYL
 6tSBNk7ztkwXH+uLobcH8WRaZZHoSTeo0FN14hICKm1ESNgaTlGO7BPnvkH/L1JJ/Tsz
 0sLXDe6k2i58OIpbQUyOny+j9hXdrwilE/3m3NxO88aQJdyA924c4iwv1710kzJ02RdO
 4b9zfgs492fQT1txuLlO6bnNoXoiT6fTexmrXkm8CL5RbvVOJLWCT6FOKaGA9p33vBQ6
 cVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677144; x=1706281944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uu9KOeZNqt2BbwLm17KcDIla7TLl11DDjvBPhEb/xBI=;
 b=cFyi9Zha6I+RuPS9ZtlsIkrlhEhPCXAILiDdNVVCS2EJXj1z9T7iararQl0fZZF1N6
 SQIQ5Al0Fo11FPIWIpJAHC+/x4ie7+KD3VKt2SPoexfvzA1PBdM5ERjeMHvS27ZXTsIe
 F/gNnWn0ZJvw5oOWfFHjF267grWYRftaKQTGqCQD3iRue3UHgT47FierLXrAfF7QBiOh
 l1gISrSE2+yaIHfUWY1HHOweIbrGQ3E1s9ljZWrFSwG7yaIYBH1Hzg6P4AqGDM+gj6rJ
 0j2f+XSfhYVXNlccIVMoGHShRGQ5N5ssZ8PGW3vjtbaTxaNnACqQRr1DlXRXUB9vtAsJ
 lHrQ==
X-Gm-Message-State: AOJu0YynDNwT65cP1nLoF5duJtmwP0VOW5Wl0bU7XQQRhkdHqHU1svFW
 ns5uRrQYl5zSilBnrMTjNicazmEUyAwK5X96iJRgs0lZR0n5d780B16sIL5xN1/Wuwia594mgSx
 C
X-Google-Smtp-Source: AGHT+IGFHL98leYAix6rT+ozI3FUoPFYorB+15zAzkQ7YcdX5IQMC91+A0XNcJJQuporJMH2QLi4DA==
X-Received: by 2002:a05:620a:2942:b0:783:8d12:a9a0 with SMTP id
 n2-20020a05620a294200b007838d12a9a0mr28273qkp.12.1705677143875; 
 Fri, 19 Jan 2024 07:12:23 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:23 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v7 4/8] arm: armv7: save boot arguments
Date: Fri, 19 Jan 2024 07:10:00 -0800
Message-Id: <20240119151007.715348-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

Save boot arguments r[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in v3
- Swap value of r0 with r2.
Changes in v4
- Fix a bug when saving the boot args.
Changes in V5
- Drop the dependence on OF_BOARD.
Changes in V7
- Exclude the saved_args when BLOBLIST is disabled.

 arch/arm/cpu/armv7/start.S | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..91691062c1 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,30 @@ ENDPROC(c_runtime_cpu_setup)
  *
  *************************************************************************/
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	ldr r12, =saved_args
+	/*
+	 * Intentionally swapping r0 with r2 in order to simplify the C
+	 * function we use later.
+	 */
+	str r2, [r12]
+	str r1, [r12, #4]
+	str r0, [r12, #8]
+	str r3, [r12, #12]
+#endif
 	b	save_boot_params_ret		@ back to my caller
 ENDPROC(save_boot_params)
 
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.word 0
+	.endr
+END(saved_args)
+#endif
+
 #ifdef CONFIG_ARMV7_LPAE
 WEAK(switch_to_hypervisor)
 	b	switch_to_hypervisor_ret
-- 
2.25.1

