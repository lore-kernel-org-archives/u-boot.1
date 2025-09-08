Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B45CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAB783145;
	Mon,  8 Sep 2025 13:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XIqeexAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16577809A5; Mon,  8 Sep 2025 13:31:50 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3BE82E34
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afcb7ae31caso717512466b.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331105; x=1757935905; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qHM+dDrPsROhPSys3yqSXmN0yZhh34n/cr4/IS9xkM8=;
 b=XIqeexAVeNCcgyFLfhFNZrzr9/7r1AmIrTqLmz/ReobHWxICOrUmOsgsytBc7W/bxQ
 pYNjQ5Z0FW7P1ginMWYrpFeXW6EfSNl+eTCmDCuAyOvfselCcNy7CjMDhXZszrObyc36
 aTs8tDwUKfi/DURs+rNL0h10KK5phWghEQaZBoNbUM/0WqmuO76v9mabuPKUeje5W1Q3
 fA2Lqjc87wbbMMD57WVoJSTeN8hxaB4mT83jKR8aVmLHxyiQalvV0/Zfaf0vGq9BHin4
 1+WYwg4tTVreQTWn4wmbZTCIspT0EqzKcUAHkLN1K0E+6PVqiRaVeCI6KEhQXdKToGcR
 aEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331105; x=1757935905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHM+dDrPsROhPSys3yqSXmN0yZhh34n/cr4/IS9xkM8=;
 b=FVkyuD+x7eEeoQvffIXWROxgwzRQ5YBb9rSKGnt1sYwaa6B4PkO/0Khmg4ye+vBEUW
 TavWpGPjc1NBlg3PirrRXtTkdUw6iQWy6sodBn7uM6Nyhjo2uCydXdOuL9KJk/hGrpjk
 Z+AZSBvrlRJc7eoLjmCuHfxK70WLAwf6DL6k2tosPWFJOkvaoI/X/vw3xR9wfZGFr5wQ
 fIIQQE/3m4RLRgEOignF7tQZtyI5X/xYIbjsLyFFDgRJH+9ssBsC2SMvbLb41MAVpPNI
 C/Y4K/P8xyjQLU6AjVC5At+YOSOMR2LcShGoXSy75rqaaN68/wjKCCEKd4A5zrOGR9dg
 Yi7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBi1ouvtxMwfnvHHTTkeUnTYE8SAya0r5ObXr6qB/N6vcFgcsn1GNi2b6qyZQETz9dNOnFbiI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5hKOgpe+oVMSsIPgKfGgbbvRT4eW/ILtTAmKrA3h6jp3uLY9X
 Uahf1jx/bKtqhZrHQHVPmRRwbDsdY+rOWrNW/DssbwiUfj7i9Re/OAHJFoJF0UeEb2qPfosSydO
 SCIwBqLs=
X-Gm-Gg: ASbGncv2Dv37dVCZanNqrHXk9SLrSNo6PMkqIfC+vKc9ToArK5ZfZq1kdOa9XAR+5t8
 gfclckAS0DyQxWLujQUVhi0BjJgvyYlTDCP0ArOT7dfogAD/vdF3A+CCFf+S4m5IsO3E/yYermE
 CabYrkJtvf1ldkdkeHopF/XUkiDp/dAD3yfDsWxYrQunGYTc2QpBKUtS2R6bsKCYma9BZ4rLCy+
 tASRja5nsjyFZ1vLbg2tuHNc0ZXa7H5HfHTQlktytHRa9q7q7bAdk/Hcav4j2e50cKIQeMtBA87
 yPMw+NZZrNeM1Ht04BbYgPLBFZAOkh43XabuhKY8bsc08sZPLphXBhXSdwZOJz6mAtNyJLobvo/
 Q7IalX/ZjCL33X9E4YulOOwTrYRhsRFC9gg0GhNKY7QTH
X-Google-Smtp-Source: AGHT+IEcPwQSgmLoYpPscBY4AtZhfW05dudAeuaJb6vrgafU+dmECKVU0JI25H67QKjt+j3WfQckWA==
X-Received: by 2002:a17:907:7e9f:b0:b04:6bb6:c91d with SMTP id
 a640c23a62f3a-b04b13c174amr632984066b.1.1757331104778; 
 Mon, 08 Sep 2025 04:31:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bb7sm21251501a12.13.2025.09.08.04.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:31:44 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 08 Sep 2025 13:31:22 +0200
Subject: [PATCH v2 2/6] Revert "serial: serial_msm: Delay initialization to
 let pins stabilize"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-db410c-autoboot-fixes-v2-2-316ed98e0143@linaro.org>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

There have been issues with autoboot on DB410c for years, where autoboot
gets interrupted by spurious input on the UART console. Back in 2021, I've
tried to fix this by inserting a delay before UART initialization, but it
has turned out this is not working reliably either.

It looks like the root cause has always been the lack of bias-pull-up,
which was causing the RX line to be floating when UART is disconnected.
The delay does not seem to be needed anymore when applying bias-pull-up,
so drop it again in favor of the proper fix.

This reverts commit ad7e967738a9c639e07cf50b83ffccdf9a8537b0.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 757e5eaf974fc171c7a56006a218554be1425612..c8df91fca589433e57cd4c25a18d09548715c840 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -17,7 +17,6 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
-#include <linux/delay.h>
 #include <dm/pinctrl.h>
 
 /* Serial registers - this driver works in uartdm mode*/
@@ -207,8 +206,6 @@ static int calc_csr_bitrate(struct msm_serial_data *priv)
 
 static void uart_dm_init(struct msm_serial_data *priv)
 {
-	/* Delay initialization for a bit to let pins stabilize if necessary */
-	mdelay(5);
 	int bitrate = calc_csr_bitrate(priv);
 	if (bitrate < 0) {
 		log_warning("Couldn't calculate bit clock divider! Using default\n");

-- 
2.50.1

