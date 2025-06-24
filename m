Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB39C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D8C82E9A;
	Tue, 24 Jun 2025 10:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uRRzM2DI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C2F82DA1; Tue, 24 Jun 2025 10:45:39 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194C882E34
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2460275f8f.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754736; x=1751359536; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3XpeQxVtJZqSpIyl6PRxaCj7fVsKjMFfwhM0CE6Ov3w=;
 b=uRRzM2DIiuVxs8EnmvfW8rF7M10Qt3XNbJidCGvP7Yx2eWFMc62j1UcM3N5Q+r7/Kv
 1+k2DCDyUbY1k5UT/W7V+bDaHvR57zEezlpNkeUDsks4o15co30XAM9pEzOcq52QYl0E
 j+Rhaab9Auq5ymRWZcm6JQpdcyxx/CVTGkTQbikARuLL0RnnmmYAW5KJ/7/G4dfFQotV
 Z4uzry7qTaedhvW4jxlRMLgJ4YNoTFyI3+tQhQZQ5cb3uV2NuB9wCidUI5/FagcZo8Vy
 GR8baRfr/1lZ/2fcg6iCXupWU242BTOX4L2dcXlGWX1AcQ1bXCXPR5nTCqBLmrnLFM/t
 1ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754736; x=1751359536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XpeQxVtJZqSpIyl6PRxaCj7fVsKjMFfwhM0CE6Ov3w=;
 b=RwEeVI6wGBQCEHMMXgdl3PmSjK7fBObckWqWr5vUuZVUb9gygTS3aEFz+9lIXvJqn+
 b9+Oz0x6pFdaDwJRFOwAYs2IV4YJRjXdu+YWRaEwgnYpvu+27JgkmXlIbPqJ/gL1aU2Q
 aV2yht9e6DeswoQERlETH+07lHwtAlxG4jQ8l3dOLdn5Z4afZPOBEN1lOHtR+JvPcbyO
 3YGn4cE1mBd7seKMGQHuqDATqxniUTSB91qqQjonCSK1Xa6DmN8mQRwELq4rhs6zVhJt
 cUBG87HFYFQJjwMr8scxjhwGa1+Qdh+ETgCiNwsy+T6DJtSw6cyF662RtVkWt1KB5PNW
 3ACg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtI7MwOY5TdtzS7qnA4Tq02/nHnWO7Rlb5E/HFhCRtBA31+eWCzF/hed9odpT+MRCl/GPQ3EI=@lists.denx.de
X-Gm-Message-State: AOJu0YygTtDOvUKolNYSFdLhXKq2naUtuniFpy0rTO0IrMeTpHCckxsr
 MKexx2hqiCJnR2D/cmYa6J+iWs18q97NluxfKuX+0s6cyxKP83Oyw7ZN1bQCEtJ3+Y0=
X-Gm-Gg: ASbGncsMeEW+DWl0zUl+krgWleSODG9cWtfA3dILELpTvpc7QN0D66g42YqhVoXjNam
 jWdpMlpjP3Ru1aND9qW5kp6i546TL+ml0C3Soxivi5bjhe2uui38IzetRwWovbGPQPct01E8ymv
 ILMWllFP82OYYPI/5oApcAF5JW02vLr+fKOyAcw45YgskZ7I6/rEJXYxade9H7TUlJ7AklR0lLO
 6mQINmze3AzotScs5s85iQ6mBB/AG40lLujDQzwBatx6C1IRdsAbRzuwfFQq89TSybrKqIA9Bo3
 2lJRqx585Pbv5U/AI6C3/2PMYK3c2BWt1KMjhAQE4ntuk0OWx+uzqOMaKBjysqT2KEOYM/2h6qY
 =
X-Google-Smtp-Source: AGHT+IEkb/fp86kL3EdiFcVn2XI/T3aWzkxpd2lJS/9CYMUKXqTI+PQcaFMim6lieD1E3pOUmLvc3w==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f6ba:51da with SMTP id
 ffacd0b85a97d-3a6d12db6d0mr13548434f8f.15.1750754736475; 
 Tue, 24 Jun 2025 01:45:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:36 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:19 +0200
Subject: [PATCH 06/10] Revert "serial: serial_msm: Delay initialization to
 let pins stabilize"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-6-d96c97ae41d1@linaro.org>
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
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
2.49.0

