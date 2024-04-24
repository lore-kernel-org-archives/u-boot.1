Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97212C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 09:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D08488B0F;
	Wed, 24 Apr 2024 11:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="vez5GiHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9463B88B10; Wed, 24 Apr 2024 11:47:07 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D29B886F2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a55bf737cecso310591166b.0
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713952025; x=1714556825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bxOM4ce852ncrrru07A+vnR4dYrKA8w7FaLRDiRJg+w=;
 b=vez5GiHD9fdD3pOnc+TUrYhxEI+iUgKDpWNZP5NqXplI6aHUJiGSfyzPv22dco7qsO
 c/QgOGkq7kNClZJFX7TpENpgMQH+7F5iiSeqFPFOWy1ZC9fJzJoPni6hlWpmhLSNgmoh
 JM7BfcKnYpKByo1TnMJiZgDduJEulhQ0TF5JsOImegzf+YsGCAW13WZOLkC0Wk+GbFQ4
 IEzygh/2BuOuTeES7vEkQ1BEMYlFmbCNGDebjXRLHJ9VvPnqtwEsmPZhObZ5T3Ao7AJz
 0c+80mvR4MzDKA6TJBDFPZx/VDiLdesUVj2Lcfmg1w7Z9Cyd56a+P6kE9O+SZOMTlTgn
 HbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952025; x=1714556825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bxOM4ce852ncrrru07A+vnR4dYrKA8w7FaLRDiRJg+w=;
 b=NqRtzobGemAwuk3K0idsB+uF+YDAhxys2u7IIE7bJOpepQyMoYOlvWIKyU8qKgkUxp
 NGS2rCzVJ4kWu4CmwyczwNdNgg4kxbcDu7JL2a5hqBwnGWTR0viLmRfhCwJkqe8a+3Kv
 upXyoLu6wECOOZCDlWoLSGyPJOz5/u1YpKKAy/MCFA7j6WXX5hrbIDKTT29DcIV94Zdp
 bNKfKrCbu/wyzRhpNpMbfjFYEbUaOrv4/P1MvL056noWCnMIzbnetsizh7HU7oBTb5DJ
 8jkurUzYooTSrn9ZbbPH2MHvHw7xHwIAQKjP061d15Q12Ri+COuRVG2gVI7rN9kABEH7
 WTWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdEFD/x68VHcPYP4r6KdgKRRddU7Gwnkgzo4NEfDEIhQcet7+rwbMsKXqKZD0iQKmHURSt0saSHtTPDw3lzzV9zx3Cpw==
X-Gm-Message-State: AOJu0Yx75492aGBFcevL0O0qpWJJOcvBjC6O+r13hQ+kpWp8ctLmCiWm
 D0c2meX2t/uIEk/aAW29BnpkUS2wcnZOWpjbh0BOkIG1gQHDO6Xaopy0+QO88WM=
X-Google-Smtp-Source: AGHT+IFt0v+gQSvPfEhvdgYPqOZ/6vvx0TrBhCfHkTjliiX2Z2CEDD5/Jnp7pbe1J379UrV7zEmYDw==
X-Received: by 2002:a17:906:b784:b0:a52:2e91:321e with SMTP id
 dt4-20020a170906b78400b00a522e91321emr1149058ejb.72.1713952024710; 
 Wed, 24 Apr 2024 02:47:04 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 lo27-20020a170906fa1b00b00a588685d769sm1274598ejb.32.2024.04.24.02.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:47:04 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, sjg@chromium.org, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/4] MAINTAINERS: IPQ40XX: remove Luka Kovacic as maintainer
Date: Wed, 24 Apr 2024 11:46:22 +0200
Message-ID: <20240424094701.21198-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

Luka Kovacic is no longer at Sartura, so remove him as one of IPQ40xx
maintainers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0a4a28b40..8691500d28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -334,7 +334,6 @@ F:	drivers/spi/gxp_spi.c
 
 ARM IPQ40XX
 M:	Robert Marko <robert.marko@sartura.hr>
-M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	arch/arm/mach-ipq40xx/
-- 
2.44.0

