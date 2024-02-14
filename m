Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66F2C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 18:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3CD87D71;
	Wed, 14 Feb 2024 19:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="igA/uUUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C3D87D94; Wed, 14 Feb 2024 19:35:12 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFEB8785F
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 19:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so90967a12.0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707935692; x=1708540492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coMBrwKo8FxHUKtJ7NDABYA6WDE7AakJLJNkVlYE2kk=;
 b=igA/uUUuk5wfTeZz+2ZRGjaWTTyMEhrRSH4xFR/rb66fphen4OQymfZvtWKAOlXDvW
 6FCHuWr3oaoGD865scK0bAZIss35Ih/nvtHMPon7F173v0dy3/k785M46slbHDJPoEvA
 8hYlybiBac7V4X1jiD/hPHANSmP5uFvt/emBWMMbj3RVLYci5oiirnvph0J+l2znfbxC
 ZUOMCMtTAtBGCkLpB/r0vnHNgD5u4GDQrclodbSxaemNlzzSyY8CTEG62GMKIJAGGYTt
 +pyaiKphZI7NGFFl2q9s7MAx+kHfYrwdwmuxQaEljtbqN16nMCxDhuGTpl6iZQYnPT4o
 iI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707935692; x=1708540492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=coMBrwKo8FxHUKtJ7NDABYA6WDE7AakJLJNkVlYE2kk=;
 b=pog/S8a6MRoFgWcJHikCOclpoPvgRhKWRD3PXRzVRvgX/wvO4pZwE6a6LQT7FB5wDG
 yqoo8SBuGabKr3waOkY92KwVqwRb1b3nNOWcB0nnGrIboWQC4UNorIsCzltwZicHLUyU
 UkW15ss+SS07lmDcob+diKaiEWmJ5kfmZRNEJl8ikdVx6pxWS4j6O2xUPooEUssn6sg6
 XKvML0TSn238o1oMitiaWTP4YbsP6w4s5UP9FgNsfs8kiU2d0uMKS+uxsaJbBGAL3YHf
 rChIsEVLyuw4+hkT3eUlzd5kbrX077jqjjt+ziUwheKCx5eI1tOZwkdIXCbESqC6TMzZ
 qGWA==
X-Gm-Message-State: AOJu0YwtE0uCUr1zR24+uOfI2FG4jbcVb5qmlVmnfYkWK5ZGgs1tZoXZ
 VW8qG+cnbPv2P449tLHvzSW/y9bwh6m1Gc0L3BKapXYfYI2D4q1NVYKFpez0AmQ87RhuDfLh+Nx
 MJ18=
X-Google-Smtp-Source: AGHT+IGk0GXq8sU/yWXGaS64ka/8/QWGAzG8tpkbYrLzLjnfWMpnIyXbtRmK5J6GcGAL6vSzx7GdcA==
X-Received: by 2002:aa7:dcc1:0:b0:560:ecd5:968b with SMTP id
 w1-20020aa7dcc1000000b00560ecd5968bmr2651991edu.23.1707935692395; 
 Wed, 14 Feb 2024 10:34:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWyUQemE5uyNxZ2L8P5nEPOIocQU3+MlTdti+avzXXHXFLggsqwXCVmyqS6iuj2wcUv3BH6EXSDtx3r2/AsuBwTRRua/ajCyU5/VOWX70Ej0SarRWoy/ruv33kowdF98ozz1BMfZEKP8o3cLJjz2Vybk0pMJN1q5Yux1w==
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 x9-20020a056402414900b0055ef7742204sm4513440eda.97.2024.02.14.10.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 10:34:49 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
X-Google-Original-From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/5] tee: optee: fix description in Kconfig
Date: Wed, 14 Feb 2024 19:34:40 +0100
Message-Id: <20240214183444.493629-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214183444.493629-1-igor.opaniuk@gmail.com>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
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

Fix OPTEE_TA_AVB symbol description in Kconfig:
s/"write"rb"/"write_rb"/g

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 drivers/tee/optee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 9dc65b0501e..db0bcfa6f15 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -19,7 +19,7 @@ config OPTEE_TA_AVB
 	default y
 	help
 	  Enables support for the AVB Trusted Application (TA) in OP-TEE.
-	  The TA can support the "avb" subcommands "read_rb", "write"rb"
+	  The TA can support the "avb" subcommands "read_rb", "write_rb"
 	  and "is_unlocked".
 
 config OPTEE_TA_RPC_TEST
-- 
2.34.1

