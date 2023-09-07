Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252DEE14A9
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38BC286571;
	Thu,  7 Sep 2023 03:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djKZKX+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37D38657B; Thu,  7 Sep 2023 03:47:51 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7128D86454
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bf106fb6a0so72981a34.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694051267; x=1694656067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROSkvtjg2o1VCssYd1NVj1GOn0vJubSnLPY9xeAhgtE=;
 b=djKZKX+uDcbK1tiHVBjntfTmIbi40NJllid8kTDoOcv6uh3yRZbjuIgopiAJeyS2vk
 qwT2h4GUdUBQLbK+ZDfCEQ0KD0pIPDL5ED7aMUj/FiFNjd3cWDbnmAvZCp54UNq84RK4
 ACUHGLUtJV/LELn2qvSE7iNChq8IeRKeC+QPSg8hWra+jaJpDpP1naDa14o6MJuYdWLb
 ToZssnVCihR9SVJQIIFeizXu8gCeyUanoSbIwxVu7yFy0lbgkK8pZ1X+UmE+Fs7YDsXF
 TW8p3R4bwBUT/ovNLNNjW6E21rscHG/t7XtALwO7fVo5vmFsfQeUBgVIzOCGpZqp/c8T
 HL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051267; x=1694656067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROSkvtjg2o1VCssYd1NVj1GOn0vJubSnLPY9xeAhgtE=;
 b=iPqRY/UxAMUsOKR5Rbv3VPuAHyO048mM6gzV4m+S8uoh2XXNtUH6QIyEUsEw/zDbpO
 OH6DGHw4QFXxjtNKRVWjmX4W9SQA4FNmsFI+vvUToLvWfpp0tg2eNDG7mI07wDiY7WIw
 qZ9kit8E8CNwN7IIkeVVB5krHmJHkfUn+HujqrgFTXmz6pWhwONwpdB375WIYvjAWoQX
 roJQBL9UqVQ7VLEHKRL0mJNJLoNH/7fuc59zRvrHMXwYVFp95sWD9q04hEQ3ZDLml0Mt
 e5Co5AA794e7tSS2PlAJgh9Rf7y9zF6rnZuioemNNKjpl+ndJbmLldK+6aalDwRgt+31
 NUDQ==
X-Gm-Message-State: AOJu0Ywms0698dwDjMXA5x+CRcEu1Pd8BDmJySgCYRmPXqGdSWM+5ik3
 rXXIHdiGkED4wGarWRFOgDE=
X-Google-Smtp-Source: AGHT+IHFmO+O/2wHJH+AhQL+OQAz8LzOrekj/atDim7KAmYvUaUgVi7uEfp5s4nm7x16trrToWpg6w==
X-Received: by 2002:a05:6830:46a3:b0:6bd:9d65:fce with SMTP id
 ay35-20020a05683046a300b006bd9d650fcemr17572544otb.2.1694051267102; 
 Wed, 06 Sep 2023 18:47:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9526:31f7:eabd:d5f9])
 by smtp.gmail.com with ESMTPSA id
 i36-20020a056830452400b006bf0f95f702sm6951989otv.64.2023.09.06.18.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:47:46 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] imx: hab: Improve the hab_auth_img_or_fail usage text
Date: Wed,  6 Sep 2023 22:47:26 -0300
Message-Id: <20230907014727.371324-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907014727.371324-1-festevam@gmail.com>
References: <20230907014727.371324-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Split the hab_auth_img_or_fail usage text in two sentences to make it
clearer.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/hab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 6cacca069d9f..ea9c5d3c9fd4 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -712,7 +712,7 @@ U_BOOT_CMD(
 U_BOOT_CMD(
 		hab_auth_img_or_fail, 4, 0,
 		do_authenticate_image_or_failover,
-		"authenticate image via HAB on failure drop to USB BootROM mode",
+		"authenticate image via HAB. Switch to USB BootROM mode on failure",
 		"addr length ivt_offset\n"
 		"addr - image hex address\n"
 		"length - image hex length\n"
-- 
2.34.1

