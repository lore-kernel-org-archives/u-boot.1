Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155ABEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8F986403;
	Wed, 23 Aug 2023 17:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MXLpgqzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E6C83F7F; Wed, 23 Aug 2023 17:41:39 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042F786403
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so45636175ad.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692805295; x=1693410095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ua56PexO0PB0WocLx4bHYVCVu0rkt9kVrEIylXM8wI0=;
 b=MXLpgqzQtWVS21mHj4ed4Md2LpO/xBQLWIdu94n/ngJOgd8F/SbyUcuXtJG074JIWf
 bExFM0N12yn9iucrCDfH4QbWsQ6q2DjyZuEAgISi3IqMQCgHsZ6EiBDDEljzHZiu+fF3
 xICvIjUaTxIvuu1Ly3AWe1BQ2eftJWLwJAsBtpqQMGf8vH7cucN7l0xjGYUYsmYOH9ij
 EOELkyfJTb4j+MlukBxsCL44JS8EKKhJUoes6TyPxcgz24hA9CmmpAddqKYrbCfLwYMl
 ngLhE5rstli31lq1ak1VhqDIK03yPNi4z0AiVtxZRV1KJ+WJ+eUqFE2JTqm//Oiwxv4u
 oVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692805295; x=1693410095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ua56PexO0PB0WocLx4bHYVCVu0rkt9kVrEIylXM8wI0=;
 b=JN1aEMvOUgqiJwTX2kHzN3rLKWWDJOoqQH8lGmJsb41Caxd+rAzI5Hwd2JvkfsS0CJ
 x06u05hLgQwgoEt2k304jkEmg3VYz1YTdAK7Im7cfoZphtSTgsgFhXCMoW3tyUwOAamJ
 veqZ5nO3enLWAIqA8Kn5MoJXbvmU+q+Q/2dZLbgirFca5bvHf1wPYayAQV1DgMqdWJqu
 FDQ3Ejj6YrnNvXXsD0SBZNwj1HEnJlHgvK5vmMUtJEFw3L9kkB0ed28vCpMtLGHMtNuA
 xqxbGtWTBcHlztZTg7uPcEWPXqoISwOoSKu7an9Vbqncl5lHu2jc8mxgJhnNfWmMCsKp
 8t4g==
X-Gm-Message-State: AOJu0YzF4HcwcbOfEpL7UK/vZ9YArpmIG69du1csvuWMEatmE1xSP2yA
 BiqAJKQ2Ddf7d5GHl6+8CHMHdTRiY7wN/r+nFf0=
X-Google-Smtp-Source: AGHT+IEzVcTfmDVQrj3T7AvOeAjF04KaA2/RissAS0qyyXGxDShSw/OUS0Ggznqo+JA+Q947/TLB6g==
X-Received: by 2002:a17:902:ced1:b0:1b8:33d4:77f8 with SMTP id
 d17-20020a170902ced100b001b833d477f8mr17041518plg.23.1692805294983; 
 Wed, 23 Aug 2023 08:41:34 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:9994:72d7:d8ae:7ab6])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a170902868700b001bb3beb2bc6sm11033034plo.65.2023.08.23.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:41:34 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marex@denx.de, bmeng.cn@gmail.com
Subject: [PATCH] usb: xhci: Define 'XHCI_MAX_HALT_USEC' macro only once
Date: Wed, 23 Aug 2023 21:11:23 +0530
Message-Id: <20230823154123.859927-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Right now xhci header file defines XHCI_MAX_HALT_USEC macro
twice. Fix the same.

Cc: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 include/usb/xhci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index 4a4ac10229..958c94bfa7 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -1136,8 +1136,6 @@ void xhci_hcd_stop(int index);
 /*************************************************************
 	EXTENDED CAPABILITY DEFINITIONS
 *************************************************************/
-/* Up to 16 ms to halt an HC */
-#define XHCI_MAX_HALT_USEC	(16*1000)
 /* HC not running - set to 1 when run/stop bit is cleared. */
 #define XHCI_STS_HALT		(1 << 0)
 
-- 
2.38.1

