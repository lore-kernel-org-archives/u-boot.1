Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB61C677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 17:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC2C82B26;
	Tue, 10 Jun 2025 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OUORnIiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4FD82B95; Tue, 10 Jun 2025 19:00:06 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC45F82B20
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 19:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so74082665e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749574804; x=1750179604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tZ/sI+r+zEzXCzu/fkbc7Ig9TPW4o7mjamZUfWzxDJU=;
 b=OUORnIiOk04Gvr+aBLs2hxKLDg9vKuVgeapD5ecIL0FddB8Mfa3UzEB8sqiErA0fG3
 JqAG+Cy4CVjHPptZCi2ez+INtULAcyaaxM/zpfp//vcYEYtOF779FRIoKLa4mj2MfJFu
 J2MDgtd5ErJ9V9dYWbdYPWXYodELL1oy1s9rXTxWXANFs7q/X4QdYWW9WiHVsmA6Ofz4
 FDNmngC7a4U+6aeQ7yM9JMm7ETP0Di8g/HRKl/JSCb+C3nEQEjy1vN6/Mt1B/as8rBVU
 8S2XsTdV05eHMsL7H5xwvaEE4ij+Vd+Mv2ej8up+pEjm4yCFo1cHwqSWwVfSvzPndXUY
 yQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749574804; x=1750179604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZ/sI+r+zEzXCzu/fkbc7Ig9TPW4o7mjamZUfWzxDJU=;
 b=lQh8i4CajSCjWyzGScx1t1NC0HChcUvsrRTLuUl4B/puyfNC2+C3cqUmVwU/2Qr2N6
 qchxhvdK/2lfvwp0twDtir39/HRrNggvTugneCRt+Hfiro5wLx/c7zmwBdB3vw0tWH0o
 wMv8FMRwg6cMRl2b+XZevYxYWnlAMkf1UPfcCqEjvDA2SKkru0JfKfVSyN9rxOa4bQNE
 fbx5WZX3QUPPTMZZ2m5QcFzBE4fmVRXWBNO48T6bEKSU4EaLIOI2jCl2pohyJu90GOwc
 P6Jo2eKk2U4nGVBhwwe7py3SNPHZCTm/oKcnNpCt5WXHbwX46AgirgWTxncy5HGTuXtu
 G5KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy1eLyyp7ZaOLhbZIoGcGq9jEviELhG/bk9xZbbsHZBp7MBlBepx39586+RqpsoHgGhdo5pRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzzACwHLTtlzu++b2HRZPWp0gNLnRAAZ/V2hJ2TynFnBFL1ijT4
 1vkC6LfgA8tBqfUMPcyOAoFsKUby4Ehh+NQ/NGBL4NOlGyxya3JAFC2THBUQ26S3OG4=
X-Gm-Gg: ASbGncseg6JktW23rJiALJ/45bxiFBKSP23/vjDbPSmKzbJB1hDqejwsSAHTcwX0ZOc
 1FPnD8nNBXyA//JMrDiCgl6G8ACIfqELsZvoLWpuhwIjisKPSBqrMKxpE/SJRrvB8s3+pHoU8sm
 K//GRED/z2yNGXtwDlCWr0zd/rSkSTIALHaxFlK7Uya+N7M5JKdeYqdpE+Ic3hRch7yHTd3DmWL
 TTPMLAFoADUPtN/2sUP4/4ehCA11L4JkgANmQTnk71/Wil21GkkL22kXz+yyc5W/rrFJEAhCozA
 zGzulAXBYeRbDFMcC7/HBrYQq5moQ+37/rHJ2D8Y51mBEfpV5zVfokNrpEL+wRKXjNfswA==
X-Google-Smtp-Source: AGHT+IHNSJawIxBfL6LXJwe4ZZuBo8QlSzdEGKBAyTWB53W1CWm7aVJ3wPma1JMNn+/p6v4nowETJQ==
X-Received: by 2002:a05:600c:3ba6:b0:453:9b3:5b67 with SMTP id
 5b1f17b1804b1-4531d00c87emr41025655e9.24.1749574804190; 
 Tue, 10 Jun 2025 10:00:04 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b92c9sm143597115e9.24.2025.06.10.10.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 10:00:03 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Greg Malysa <malysagreg@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] Qualcomm: maintain trogdor so CI passes
Date: Tue, 10 Jun 2025 18:59:51 +0200
Message-ID: <20250610165958.152573-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Add chromebook_trogdor_defconfig to MAINTAINERS. This is a Qualcomm
board so for now I'll maintain it under ARM SNAPDRAGON so that we can
get these fairly invasive (but very useful) patches in which improve
Coreboot for all ARM platforms.

Hopefully someone who owns this device will be willing to take over
as MAINTAINER.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385b..789e6f0c37b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -670,8 +670,9 @@ F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c
 F:	drivers/spmi/spmi-msm.c
 F:	drivers/usb/host/ehci-msm.c
+F:	configs/chromebook_trogdor_defconfig
 N:	qcom
 N:	snapdragon
 N:	qualcomm
 
-- 
2.49.0

