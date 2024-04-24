Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FBC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 09:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F12E88B10;
	Wed, 24 Apr 2024 11:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="fxHnMnr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17D588B51; Wed, 24 Apr 2024 11:47:08 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0938C88AF2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 11:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso769967566b.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713952026; x=1714556826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/XgdYhakivWw5zOx4+yNAx8GXxsHz5xnP4qQnGYC0c=;
 b=fxHnMnr2Pd7ExqCLh4xWgpZIhP3MUSbe1FGmEeBoYMkoraV2TSw7w/CNTTTUq51J6x
 NKZazG5OfO4qbKO3BMe8SQD3IwqHx2o4ly7vFDbFeIjE+Wx8MHIspbEFWFmzSFoZ8zzk
 uZ3tUftQ8cc+FUOaB/yIQo1LjVy1+7yhnZmkPpprOoi10P72GuLDo5s3LtNUiPQianKf
 NIn67Re7iFEMHkAWZ6n6PY9ZZDjMdeVXDzJJHDgfLPqI1IAegisofrWcVeph7DLGYwSN
 jf3St2V4tFs2EcvRgx/OrW7q9dtbqjPG/0ARnqs/MVB8HCNUNzl3tcIymcYoPeQkaq0b
 No5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952026; x=1714556826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/XgdYhakivWw5zOx4+yNAx8GXxsHz5xnP4qQnGYC0c=;
 b=i7+8JmxtLCDSpu8qvqS/hO15HlMsdYfwoRCmGrGhKDxPH3wE6luprs+jEg0IA8Xn5T
 T36eKC0NDI9HglkyWV39Iu/mJnLZI3jbBDfvp2tYZjSU0ZF4GCPxZh2nWGaP/p3bO/s3
 o9ovPWUq3xRQLqX+yMoM4OnjnQpt99qVPldlDPWelbfwAGQ3j3b5Nyp8mLi0aLwpPMzQ
 OuHVWQ/3Lcu1z9tZcGnznoVphBWm72Kc9eOdCgS7DXpcC25AszJXQffFF689M8qAvkx2
 6Hy5JALJehdLYhdq0g0P+OkEnrw7I64e9wudzfKqBKcoIxoOufL4Pem+JiKCaFRoU0K3
 MCjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP1wtXxn9E1qUcp3n4vp0H8iJkZ+QYDhX23xISBIq/4cEKCbb2QoPwOdyIoFmz3bRE2oRKZBRLQwD0sDEhgAbC1fWuhA==
X-Gm-Message-State: AOJu0Yw+n/FA4YMB6JdYTlnhjIsHBmZPJ7QDZg2jZ+NQSB7m/CfFcMtg
 908OLvWyDlhU8Jhd+jBEFaneHnRcyGJZ7EgmIOQ3+VB1xL/LqOT9GoLNIskllzc=
X-Google-Smtp-Source: AGHT+IFpNRZN8Bp271FoGUGQepViSuMQZK0vFt9gviERVnctVxUmSBJtEk28KJffKUBP0794qFzFLg==
X-Received: by 2002:a17:906:3442:b0:a58:7298:fdfe with SMTP id
 d2-20020a170906344200b00a587298fdfemr1157512ejb.53.1713952026107; 
 Wed, 24 Apr 2024 02:47:06 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 lo27-20020a170906fa1b00b00a588685d769sm1274598ejb.32.2024.04.24.02.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:47:05 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, sjg@chromium.org, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/4] MAINTAINERS: IPQ40XX: update GCC dt-bindings
Date: Wed, 24 Apr 2024 11:46:23 +0200
Message-ID: <20240424094701.21198-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424094701.21198-1-robert.marko@sartura.hr>
References: <20240424094701.21198-1-robert.marko@sartura.hr>
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

The separate clock and reset dt-bindings for IPQ40XX were merged into one
recently, but the entry was not updated so do it now.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8691500d28..fdce7c8334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,8 +337,7 @@ M:	Robert Marko <robert.marko@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	arch/arm/mach-ipq40xx/
-F:	include/dt-bindings/clock/qcom,ipq4019-gcc.h
-F:	include/dt-bindings/reset/qcom,ipq4019-reset.h
+F:	include/dt-bindings/clock/qcom,gcc-ipq4019.h
 F:	drivers/reset/reset-ipq4019.c
 F:	drivers/phy/phy-qcom-ipq4019-usb.c
 F:	drivers/spi/spi-qup.c
-- 
2.44.0

