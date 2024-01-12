Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F2AC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CB6879CE;
	Fri, 12 Jan 2024 22:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WpFrvhTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1D0879F0; Fri, 12 Jan 2024 22:34:31 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A09F8799C
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78333ad3a17so389573785a.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095267; x=1705700067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiMM1MFv91uHV7BD5aRWuIOj8x1+iCYX0IYLQ6Y+DEw=;
 b=WpFrvhTClHfC3VUTAr+LhHZOoe7uGngxXRFZPAvfgEUWon7OBrRZh28TcMDr29SbgI
 9N+2uf5uOm05KNNsp5iDVVvp/ZcI7iCUlzuQ05BCnPxemhtjOnOlZtg46rbptwU4xgVA
 dzMplmVmzIInnNi/MVN/cErAyEnQ3ytdevsiszefyxVMaHMiRoWQqi/V27y4a7R4ubtl
 aFCjUmBMGpdALW8d5BQtpALX2nxE5OqoGr4mMTvGH5uoHfBgXfDdS08zskJ46pTRrxez
 3OM3JBZSjvpEavfbg5euYLY6CdPM03N1uJz1ZIByUhQV476XRot6rpBy4w/EzoufK0zj
 CPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095267; x=1705700067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiMM1MFv91uHV7BD5aRWuIOj8x1+iCYX0IYLQ6Y+DEw=;
 b=ToE27UP8fsfsD5i7nAS7MyuCp6XhU5NCca1LNkjWIbAaN7hnMPCMkZ2663Xh14NpVY
 w8ie8JezPhZnkxN4MtZAy7ohJvHP7ykP0RIoAS4McnHZniILlIKZZc4vC68L5dxsh01+
 Abh4/1oa9bfx2JMb9tDr9zYi09XcuOLHFlTdyRfHWUEEpLisbL0Ao3jlidrJIVeOMbGw
 fXv4Fy/kgz65BG5RFqt0f+cAeu4uONKFn1vpQeApJtMm0tO9Z4H8AUCtpLkQ+MGrDNHI
 uVvGFMJUmBTN2k9r+a/r6WwRrYUhav/PS57VWc+0whyQG5DoHgX3pI10mK+AZa0VReaH
 9M8A==
X-Gm-Message-State: AOJu0Yx8aIIrI9WUDZrX7oDnCpQPbCcgpO6XKYre9m2yAMbxFoPMgY8Y
 bUT7/dZ6Zv2Z8YDFWW6xmdTgVAKFF5PaKPqxaonoVeit/V8=
X-Google-Smtp-Source: AGHT+IENMqVNP5FW1y3VdDhVgkkxlCB2qaaIXw/P2IyjmNzWagRKRUUWvywc79j+zSXHzWXnUfOPNg==
X-Received: by 2002:a37:ac19:0:b0:783:1aeb:fb60 with SMTP id
 e25-20020a37ac19000000b007831aebfb60mr2172246qkm.20.1705095267466; 
 Fri, 12 Jan 2024 13:34:27 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:27 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 4/8] arm: armv7: save boot arguments
Date: Fri, 12 Jan 2024 13:33:30 -0800
Message-Id: <20240112213337.185460-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
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

 arch/arm/cpu/armv7/start.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..f4f50ab9a4 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,28 @@ ENDPROC(c_runtime_cpu_setup)
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
 
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.word 0
+	.endr
+END(saved_args)
+
 #ifdef CONFIG_ARMV7_LPAE
 WEAK(switch_to_hypervisor)
 	b	switch_to_hypervisor_ret
-- 
2.25.1

