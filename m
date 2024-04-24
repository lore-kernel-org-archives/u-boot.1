Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31D0C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 11:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF36088AE0;
	Wed, 24 Apr 2024 13:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="r7rYksjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE3988C60; Wed, 24 Apr 2024 13:14:40 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B199D88AE0
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 13:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51b09c3a111so5430777e87.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713957278; x=1714562078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7GyaVUFVM1xiFyT75ApX6dDIgtBkQDboe6bxfdnUaQ=;
 b=r7rYksjPnjXcSlryO6VGRJ7SPNquTC7x0NrOo0liwVW+X0Bz8bx4wyHCkGlsD5cIQh
 ilYWbc7JyxQPoYF3Zxv70NNaDxXOIY7Fju10KfFoqyYn9fpMdC3UHmQotu1dMAlRZLRw
 QJunNY34sc/+HEFdmG+N/E2cjv0GZzo49DdbChX3iNBQQuQBPNqA+MTiRNSz3vB18Gza
 lQbum1lwLA3A08AqE9k+9SmUBfwzRBqdTkc4aO/iVls0/U7z2rPzgmeDuJw476P8LaT6
 nOzESsWZNJtTIoNHPyblr2knJ+6XxuUKwzNEOTWveHCWlH2k/l22cJ3f2V3Y+obUGJxp
 7H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713957278; x=1714562078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7GyaVUFVM1xiFyT75ApX6dDIgtBkQDboe6bxfdnUaQ=;
 b=QUx/pfEcafP2/8hOX/ZuasOvZ3BC65np5e97vHpVBXPCoEA3fCeB1qF6ThslP54iYm
 05gLe+Jo5jIkt9RrlwQ8FojIM7RZ7Pss+yt+Zvt2+laNexrw90kyP8+PuBmyMbcKyXPx
 hme0CEPuyP6xGfy6IQFRFNVMXddBGoDIlz+GJwLcwyp9iadWKjM+uVTPnYSYLKTGFzz3
 DZLbneq/w4tm61NAmouo/yo6c5GulDFQrhs1AJnK4bHbRkSJXItvVPkNxjfacKcXEoGr
 6HCNOkZp89o2fiTefgVPrCZXcrngipPwG0ByT/78946lj3fu8v7GEGA7gtqdNWJGUH5m
 EQ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUutFwMlUQVa98uveZPhYhsbGBP02FCGryS7RTE7XL1sLkc8VRkBpUdJ5DeRm7Ry6ZXGiAmkawQ45mZz4izHCVEtWFIcA==
X-Gm-Message-State: AOJu0Yz7AyJZ8WTbfqedyq7pZXfZTyrEZc4eRDHnpe+RytZ1A+WAsoJB
 d3FfuB+q2FQbD5OxAjiS2SQKSQacB5Nx/JJ280IRFigyPAO1rYU+1S1GTCCZtP9sNb0pby6NJNW
 7
X-Google-Smtp-Source: AGHT+IHRh3IXKPS4IE+BCqrmz1jz3aHDlu1dfnKe86H74dKlJrpRuglDT49Hz7S1F8jE36eqNiVJ0g==
X-Received: by 2002:a05:6512:3128:b0:519:5df9:d945 with SMTP id
 p8-20020a056512312800b005195df9d945mr1451471lfd.4.1713957277939; 
 Wed, 24 Apr 2024 04:14:37 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 ju5-20020a170906e90500b00a55b35b57a7sm3964553ejb.62.2024.04.24.04.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 04:14:37 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] mach-ipq40xx: use OF_UPSTREAM
Date: Wed, 24 Apr 2024 13:13:57 +0200
Message-ID: <20240424111434.373920-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424111434.373920-1-robert.marko@sartura.hr>
References: <20240424111434.373920-1-robert.marko@sartura.hr>
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

Now that drivers are compatible enough with the upstream DTS, there is no
reason to not use the upstream DTS, so imply OF_UPSTREAM by default.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93e12d8d53..5c2769b59d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -768,6 +768,7 @@ config ARCH_IPQ40XX
 	select CLK_QCOM_IPQ4019
 	select PINCTRL_QCOM_IPQ4019
 	imply CMD_DM
+	imply OF_UPSTREAM
 
 config ARCH_KEYSTONE
 	bool "TI Keystone"
-- 
2.44.0

