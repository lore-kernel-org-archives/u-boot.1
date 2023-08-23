Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB6AC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2CB86416;
	Wed, 23 Aug 2023 20:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="Ug+h9Mox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0483A86413; Wed, 23 Aug 2023 20:10:48 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A073E8645F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bcc14ea414so50264121fa.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692814243; x=1693419043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9AU2sph846FXX3t2PiYDMWMrSeLQmUONcWC5tFgsGoc=;
 b=Ug+h9Moxz10vygvjdaqln0Qc3e5TCziXmDIlNKhrTOAqGw+8Egc6G0EHojMt8SP75Z
 VTIXNzRAP8mejiM1J+aIYPrBVLFYDyieLKXEq9QD6PlgAJG9KKPEbgivOHdkPE8Cl5yO
 /tP8mUGrD2Gr6+2IB4p3zzq4ngfhrkSU/6UpphJ9hIoLHzomN0kpOmqfmemmo7UHXfs1
 m8QMJBlFGNOVrsZPa92PQD1aACA1McCp/fQfDeDk8ZrxSVwBRKLGfbaShDU4DffWy93o
 s28H+nhpKaSIU7NjxeSnt3OVe2ZsXaf4iDaBaOideOF/H55fnsd+B2COgOmwVq5l0i09
 C/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692814243; x=1693419043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9AU2sph846FXX3t2PiYDMWMrSeLQmUONcWC5tFgsGoc=;
 b=ZAFDW5Rc+kz9dNYH6mRco3POI9rgdrIOKAT1p4bNl0LHm4uU1GVGlh0NgvlOpY9uwU
 7W5XOeMwtSiqM02jRteaE/+ASON79eFIy/Rwycr/FQ2azbAbLnsX4qQEpgpPbL75bOrK
 gJ9/BIAteLUsIBxUocIv6IXQQUnDQe7KE0gFeXkZX4irBpC50KZCYTlrM3FovEQ8UVjf
 0brh5qDemtQIqdU8EHDydKlG/GmuBbrqylFxujbur0Xek6sHYMLJwsR2ygqIkLfPkgdZ
 lp3z5rWmCyIcMGttjbEfzcClOF7sKauXVafxgu+qsQfZuIibyb1UlpX0etiC05kGR67P
 uZKA==
X-Gm-Message-State: AOJu0YxEEgsw3VAfgxFH5fzJ7w5h1G2SEu0h9zcqHWsvXjsfou5jkj0p
 Y+VXRxbj/VKDrhZfQJgFlEyi/TEsDGfNHcG6E4c=
X-Google-Smtp-Source: AGHT+IHbR1GT+xgVgMS897TYYQCvpG9USEku8aJeASVRGjuy31VmrbYuc9PL7I5dgBNI917A0K0nuA==
X-Received: by 2002:a2e:a0c7:0:b0:2b6:df23:2117 with SMTP id
 f7-20020a2ea0c7000000b002b6df232117mr10403374ljm.43.1692814243455; 
 Wed, 23 Aug 2023 11:10:43 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 j22-20020a2e8516000000b002b9f0b25ff6sm3324520lji.4.2023.08.23.11.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:10:42 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] arm: mach-imx: loose enabling FSL_CAAM
Date: Wed, 23 Aug 2023 21:10:33 +0300
Message-ID: <20230823181038.30280-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

HAS_CAAM should be enabled for all architecture support it. Whereas
FSL_CAAM enables a driver for a device which may be managed by
another system, like OP-TEE. Allow disabling u-boot FSL CAAM driver
on systems with CAAM to prevent access conflicts.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d94b5828d0d..3c178fb435f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -52,7 +52,7 @@ config USE_IMXIMG_PLUGIN
 config IMX_HAB
 	bool "Support i.MX HAB features"
 	depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5 || ARCH_IMX8M || ARCH_MX7ULP
-	select FSL_CAAM if HAS_CAAM
+	imply FSL_CAAM if HAS_CAAM
 	imply CMD_DEKBLOB if HAS_CAAM
 	help
 	  This option enables the support for secure boot (HAB).
-- 
2.41.0

