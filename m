Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744D1CD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951C488250;
	Thu, 11 Apr 2024 14:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZcsR7omN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC2C288251; Thu, 11 Apr 2024 14:37:38 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D988824A
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3f17c6491so39692335ad.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839055; x=1713443855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6DBZc8ZrpmQ9Qf2RjsaspwKuPUVLKAeV7lutQMDhdz4=;
 b=ZcsR7omN/8gHrLglpF+O9t4ZGmy138u9YAfhk4QHTEqZbuC0u1BUqeJTgPMZV9OhTa
 VDQBwOAUuA9qvX/gYHbw6D6iX+X87/JfbfpRtvkeDpi40/j79u5fNA2YwxtbKkq8kyTB
 BWistxQxHZDzuTbba8qYV274v2Y+3G635CfPgF2Bstj/4l8Ji1c0SM+VSSGhd458JQWI
 Mbf8N6fcdZ2Tg0GCOHzIew42o4iZPK3ndY6vp9dxs2FExnEp61k4r4apJee6VcWRJYrj
 E5aVB4xtqsT03vcXnxzhKcTPV4sxkc3tIbe4gTODYsWKSBhzJQGAZ7AJD3/uz9rAKFV2
 eoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839055; x=1713443855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6DBZc8ZrpmQ9Qf2RjsaspwKuPUVLKAeV7lutQMDhdz4=;
 b=kZgDh7HQOfOU//jx76e5LL0REq9TLKJgHCIaQEK4PQA8hKjXBAgGLGESwElsStRFwK
 OydLaKkdyFe7EDS8YHW+bQDxgEQILrGVCsfuPhlgyagJmPgyyPTalRGxXVH+J3NHB302
 yyOILeaOlqb32J9dWuFA60NOfamCEcHKL7AsCO53TZTU77fC4mc/1wxrP0+HZy/V1Emu
 MESTEuJ3Vkc4hZTwuUEwb+k2KaWk51v3NAnvuEElnx5AEV9OvQMYoRzw/LWIcIpqmneH
 kTFMNdcImGVFn+gejHRYVpLVmCVyY616nEO78ZV6bx3ftugqMpLIcgp4GrTb1R8msU/a
 bN6Q==
X-Gm-Message-State: AOJu0YwmVeUDq+pemRj7Vx+tMGqGfSd7I3Vkup62z8Iwk1Jhpx1BeZGh
 UdjibSZW8MldJD5k9SE3RhMOE03UkMT/9iwhC8DIE+LqBeOZOeTKILsArxxMPzwOVySsMk/ilAA
 m
X-Google-Smtp-Source: AGHT+IFaESuj1qW+FJyRxHSgF6OrSpFQG4UYCXLlLX96KVNaTQ4BH6T1pAXtbW0KZqEVbRORLkfk7g==
X-Received: by 2002:a17:903:41cc:b0:1e4:434d:395b with SMTP id
 u12-20020a17090341cc00b001e4434d395bmr8187194ple.35.1712839054669; 
 Thu, 11 Apr 2024 05:37:34 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 u6-20020a170902e5c600b001dda32430b3sm1079652plf.89.2024.04.11.05.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:37:34 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 stephan@gerhold.net, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] mach-snapdragon: Allow other board vendors apart from Qcom
Date: Thu, 11 Apr 2024 18:07:26 +0530
Message-Id: <20240411123726.356173-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Qcom SoCs derived boards can come from various OEMs/ODMs and not just
Qcom itself. So allow CONFIG_SYS_VENDOR to be set correctly
corressponding to the actual board vendor.

Suggested-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
- Retained default vendor being "qualcomm".
- Collected review tag.

 arch/arm/mach-snapdragon/Kconfig | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 96e44e2c549..536960b83c3 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -4,7 +4,12 @@ config SYS_SOC
 	default "snapdragon"
 
 config SYS_VENDOR
+	string "Snapdragon board vendor"
 	default "qualcomm"
+	help
+	  Allows to specify vendor for the Snapdragon SoCs based boards.
+	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
+	  will be used as the custom board directory.
 
 config SYS_MALLOC_F_LEN
 	default 0x2000
@@ -19,12 +24,11 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
 config SYS_BOARD
-	string "Qualcomm custom board"
+	string "Snapdragon SoCs based board"
 	help
-	  The Dragonboard 410c and 820c have additional board init
-	  code that isn't shared with other Qualcomm boards.
-	  Based on this option board/qualcomm/<CONFIG_SYS_BOARD> will
-	  be used.
+	  Allows to specify the Snapdragon SoCs based board name.
+	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
+	  will be used as the custom board directory.
 
 config SYS_CONFIG_NAME
 	string "Board configuration name"
-- 
2.34.1

