Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFACEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 15:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DCB86E4C;
	Mon, 11 Sep 2023 17:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsA6ZkZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6996086E4E; Mon, 11 Sep 2023 17:37:28 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33E286AEC
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 17:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99bed101b70so577364966b.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694446645; x=1695051445; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESx0CoexlSyWJh0hP5T1ahUykEKQsNsATjsSs+GXgo0=;
 b=EsA6ZkZCZX98Hl1BTLNm4jwJ/hfQNlZkGx4uxzJv3GC90bXOW/PR2zCEcnZqRRne1U
 TLP6Ke5MCk9CqLsN69DaIlU9VcPQXssF1YWqGxrGpXUNovtQtyE4wF65byPN7tOxfB6D
 AxT6OWqbevDOnIc3S0HTg5BXZlPt9OCWtSQTkU/y0nne0oOrsXMAhutFokroOgcWacIE
 I45P9ovxMFKEG5GxErabgzqcA3VvFuDF1N7WZ2n8Bc1qXfibGyVwbgrUIft1dW68mJkN
 PZPWBTQJXezCTh7lqcmVXGmn/PuoJdmQnfluPvu4bedEVNQxGAJbUzMq+D3FePimfCk0
 zLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446645; x=1695051445;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ESx0CoexlSyWJh0hP5T1ahUykEKQsNsATjsSs+GXgo0=;
 b=QWVqYFbH8o0yqKSjv+SXksm7DuMBarrdIjdveKmItz2eXf3E2PghGOt3f+p1Gu/68e
 6kZWxgNP64VqV5uTC0Ktn35SG9QpLdQoUg6bKaAnUboEAwmE+UR9NXoz+/OhBTRXUnFw
 aAhhLFEwaNBkJVp1/EVgwakJ5raB+xjEQ0ZTlf5YULPAsOxwlcsW0Gvm6GXcbE0VRmys
 JgSryXNbtdrVcWMCeis7BY+XwQXrURFRptzKA8HAHt9bceJqeTl+GCeYjdhKiB0L+GL2
 S+EwtAwGOZye6zfnP8O4nsWSk+4nDEEdLXHH5MYHXZiy3QxENNuOfnTjN95FxWRTDGd8
 FAHw==
X-Gm-Message-State: AOJu0Yy06HBdnUa7NyrObH/uUSiG/EqhR/ZJVDr/2ufYvKaQcl1bgEsu
 KLWliqqWyY4At2vBMh3zKdA=
X-Google-Smtp-Source: AGHT+IGYx42NpyemHf3EqizmtffcUeOhOkQYmbGMybG2oYsRIs1uTjsZaBHdK31oXG/uhU9sYuZTGQ==
X-Received: by 2002:a17:906:d84:b0:9a1:cbe4:d033 with SMTP id
 m4-20020a1709060d8400b009a1cbe4d033mr7235497eji.53.1694446645115; 
 Mon, 11 Sep 2023 08:37:25 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a1709064f0e00b00992e265495csm5458724eju.212.2023.09.11.08.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 08:37:24 -0700 (PDT)
Message-ID: <d94f5f41-b610-4345-f583-439eb1bc7c8a@gmail.com>
Date: Mon, 11 Sep 2023 17:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] rockchip: include: asm: fix entering download mode rk3066
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

When a Rockchip rk3066 board download key is pressed it hangs.
The rk3066 BROM doesn't have support to check the return to BROM,
so when a key is pressed the loop that reads data must be broken
by writing a "-1" to the variable that points to the next page address.
It then goes in download mode and waits for data on USB OTG and UART0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/boot0.h | 32 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
index 0c375e543a5e..305461ce3751 100644
--- a/arch/arm/include/asm/arch-rockchip/boot0.h
+++ b/arch/arm/include/asm/arch-rockchip/boot0.h
@@ -3,6 +3,8 @@
  * Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */

+#include <asm/arch-rockchip/boot_mode.h>
+
 /*
  * Execution starts on the instruction following this 4-byte header
  * (containing the magic 'RK30', 'RK31', 'RK32' or 'RK33').  This
@@ -23,17 +25,39 @@
 	 * the first one may be overwritten, if this is the first stage
 	 * contained in the final image created with mkimage)...
 	 */
-	b 1f	 /* if overwritten, entry-address is at the next word */
+	b	1f  /* if overwritten, entry-address is at the next word */
 1:
 #endif
 #if CONFIG_IS_ENABLED(ROCKCHIP_EARLYRETURN_TO_BROM)
-	adr     r3, entry_counter
+#if IS_ENABLED(CONFIG_ROCKCHIP_RK3066)
+/*
+ * Unlike newer Rockchip SoC models the rk3066 BROM code does not have
+ * built-in support to enter download mode after return to BROM code.
+ * Before a return the boot mode register must be checked for the
+ * BOOT_BROM_DOWNLOAD flag. Writing '-1' to a location in SRAM
+ * where the BROM stores the next page address breaks the loop
+ * that reads boot blocks. The boot ROM code then goes into a
+ * download mode and waits for data on USB OTG and UART0.
+ */
+	ldr	r1, =BOOT_BROM_DOWNLOAD
+	ldr	r0, =CONFIG_ROCKCHIP_BOOT_MODE_REG
+	ldr	r0, [r0]
+	cmp	r0, r1           /* if (readl(CONFIG_ROCKCHIP_BOOT_MODE_REG) == */
+	bne	counter_check    /*     BOOT_BROM_DOWNLOAD) {              */
+	ldr	r1, =0xffffffff
+	ldr	r0, =0x10080028
+	str	r1, [r0]         /*     writel(0xffffffff, 0x10080028);    */
+	mov	r0, #1           /*     return 1;                          */
+	bx	lr               /* }                                      */
+counter_check:
+#endif
+	adr	r3, entry_counter
 	ldr	r0, [r3]
 	cmp	r0, #1           /* check if entry_counter == 1 */
 	beq	reset            /* regular bootup */
-	add     r0, #1
+	add	r0, #1
 	str	r0, [r3]         /* increment the entry_counter in memory */
-	mov     r0, #0           /* return 0 to the BROM to signal 'OK' */
+	mov	r0, #0           /* return 0 to the BROM to signal 'OK' */
 	bx	lr               /* return control to the BROM */
 entry_counter:
 	.word   0
--
2.39.2

