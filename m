Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F4EE14A9
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81BB686722;
	Thu,  7 Sep 2023 03:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iHpJEAoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F3B86784; Thu,  7 Sep 2023 03:47:53 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991128608A
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1d535fe4798so94183fac.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694051269; x=1694656069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gktWXCB/0v4fWUoypzKzVkrwS57Hfr6/4G5MQJJv/Xs=;
 b=iHpJEAoG/BemNzu3OQx3GGOoqtu6Yv9GXsaFYvRMfZn6+Ld7AkFgvTnyFpU5+BeApo
 8oIbs2lh6/fVZ02z9QzWIUSnJwvHLuGd3p8yWzLicYt9pG9QzJZSUf/nESqFDgKkVDcw
 trmRYd8FkOElQffWaxZZhJjOdPLofWWM8gyE9PWJtg1NEQ/oWqTAGl3XMqfBEKEYhh8l
 oWTdR36iqV0TSsWkf6GJmmRdSzPLSTMian9pqn4YCwqJjiyQ4YrbHIKvrnBSxKF8ibac
 Or/188iJWjPTOwnrUMQpSvwluRQn4wEP6cjzlOuj2YaeIAU0VL8+1b7IKSFUAf1AsWhp
 q50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051269; x=1694656069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gktWXCB/0v4fWUoypzKzVkrwS57Hfr6/4G5MQJJv/Xs=;
 b=bNayCSkOHQXQhDeh3IoeslL6EDSBmr7Xgkgux7ciZgFfPg130dLvC2W3sB2O3lGrLP
 CTsc/hz3P6B/Yzg73j1yp0EUgxSOW7+gAy2ARSbakbxA0f9Ua30GWKNVIr5eXX1a7vEX
 WUGbZ7nJ/s4ERZJS4LfqqGh8se2Zh4ALRIICb9v1KdtU/yV95e6As+YvBnnvdS0/I1hH
 GmxS6l3SU1zieSZ/+zTsvO0OgmAOxlWlvKDflO6QcBGeMeqmcqhzK8mHtNE83Ih4h8bh
 p5sgRnX0nmxwu8M7pr5e/uYXFDZoHo16JIP9vXw6CBB5NXrPOX7scAx3G0HwsUC4pcYg
 XRxw==
X-Gm-Message-State: AOJu0YyxdzE2cdFhJqLc0z2cRggvK5KFjms+tiNxTbYUIjxTZ9Lb8z43
 n7PdTkOeIn1uYbnJJnOd7I8=
X-Google-Smtp-Source: AGHT+IH1OCzEaUE51Y/EaNyWKJ8YLUicnTuFOEsESxaUZyZhBeK9ANiUTCl/DWO9xnAbqy6PiRadkQ==
X-Received: by 2002:a05:6830:4694:b0:6b7:36af:1937 with SMTP id
 ay20-20020a056830469400b006b736af1937mr17628189otb.0.1694051269289; 
 Wed, 06 Sep 2023 18:47:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9526:31f7:eabd:d5f9])
 by smtp.gmail.com with ESMTPSA id
 i36-20020a056830452400b006bf0f95f702sm6951989otv.64.2023.09.06.18.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:47:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] imx: hab: Explain that ivt_offset is optional
Date: Wed,  6 Sep 2023 22:47:27 -0300
Message-Id: <20230907014727.371324-3-festevam@gmail.com>
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

The ivt_offset parameter is optional for both hab_auth_img_or_fail
and hab_auth_img commands.

Document it in their usage texts to make it clearer.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/hab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index ea9c5d3c9fd4..41121d575734 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -700,7 +700,7 @@ U_BOOT_CMD(
 		"addr length ivt_offset\n"
 		"addr - image hex address\n"
 		"length - image hex length\n"
-		"ivt_offset - hex offset of IVT in the image"
+		"ivt_offset - hex offset of IVT in the image (optional)"
 	  );
 
 U_BOOT_CMD(
@@ -716,7 +716,7 @@ U_BOOT_CMD(
 		"addr length ivt_offset\n"
 		"addr - image hex address\n"
 		"length - image hex length\n"
-		"ivt_offset - hex offset of IVT in the image"
+		"ivt_offset - hex offset of IVT in the image (optional)"
 	  );
 
 U_BOOT_CMD(
-- 
2.34.1

