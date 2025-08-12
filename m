Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4C5CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 06:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFA883192;
	Tue, 12 Aug 2025 08:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dFVUZUj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB15C831D8; Tue, 12 Aug 2025 08:10:30 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E628E8311B
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61813e2fc73so4243952a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979028; x=1755583828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jhF12Yw0ivhe4Jo+BSVAB3k7+s4a70NdtxJmL+oktSU=;
 b=dFVUZUj8iDbZiU1B49nPa877Qji960cCEk4HDWZ5TN4xZFi1ILJMfkgjhWFV7K5yyw
 HO6pHF8WfRYLZGUVjN3kvTOIB/ZC23gKfAZN2CQsy6LyUWaMXl3hNn/iGXj//E117uDF
 ExIw0dVxvyUUDfBt1uAerXTEOEfzpKDeRLVCAhW92vXsEebZbEr9elmW0d+RXMq83qj9
 x0ScE6nVW0bjrMLRcta9xqKqMNdk0vhbo744c8NPTCHk1FO25XKLbHvd2uDwWlhiS1gM
 oihuLloRCny0OBiW69pS/Tz18F7G+xEkwj89rhQKrVaACkl4VQ43llvKMnsfEniP7RhQ
 l80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979028; x=1755583828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhF12Yw0ivhe4Jo+BSVAB3k7+s4a70NdtxJmL+oktSU=;
 b=CPAFON0zT63eY1A47sz6atSPMYWQqKdRUnk4El+ZATnC+Enq3Yja7JRPkZsMyEO5as
 gOqt72D8Y7j6Us1O+C/Dru4Kf8cOLkdJ6jaTOWN2aMYBQesC3aT7dtyE32gCn1EiasLy
 edbUT70+VR2mQBCelI4w7S5fNSmoZSAg56vkhqVsI7HOMNr4RNHG1CuqJuWXyP2NI1hu
 3x/fCz4x7YqyJLVr4hlfYWV5xq82g4CBc6FDK3sf+K2GD9Milpguf9E9IogLVr/GeczK
 HQH0lLS2zBiPf8lVAcrcgwGtiwslOxlgkJuMXZgCkjCQUtkbqco8B3+JsVtnyn9yjubd
 Ie+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpxymlg/pkQph5zRoFWunsuwe7TDU6f7lrG0UhehKT7FVONWaiFK6TANHo5EDqFdZqMan0rFU=@lists.denx.de
X-Gm-Message-State: AOJu0YwTa1FoTyl7g6yzGMD8NciPB7bEYjeXbQ6vaCX/J2YtF/vRDvlp
 IxTVu70q2nh96nBv+SRz+hHQRpqI3JBxl9Pss4JyG1dUQi8PThNsUhRQ8NEoGYubsnQ=
X-Gm-Gg: ASbGncvomfyVxfX4sNloE6nEWJ24cpmjq8YodXEN/4vVCDuJpFflCaL4+5SyDs/S/54
 J5/c2NoJF+nJwcFM0fEDwYDJuoDf5d7fHGNeeJPdW3q1QKrGkocqsf3lXB8J+76yfIOaPrrKJzI
 zQrLceFQsPL+PoUrWWcljPUpdVJDOIQQQbx4bLzWJdvEbRy3w1S1zIL43VjqRM+ClWeFk0mmSln
 Yzm1Al2Qzo5/ucfWiDgTTmmGZXU8n1cwKcRtCxMOSpzWF8+XlWKv3dJCVFsP+7i04vBbVKSbGH1
 VCEZTY4OhkPxN/Ku3ItM0oTaQoS/ekz1x7S8Lat2v98epbKuUecwVCyXFNWCAFUVwFy99VNFOBX
 DZ8TQLWLej0bYcni0+I2k8jJjUg==
X-Google-Smtp-Source: AGHT+IE3hs09hhTbsI4f722GPHRaJhl8efwZMUrOCjA+4+P6WXr8wgOsr2jpaUIHZiMD8+5aElJdJQ==
X-Received: by 2002:a05:6402:1ecb:b0:615:f76:9408 with SMTP id
 4fb4d7f45d1cf-6184ec9434cmr1655680a12.32.1754979028264; 
 Mon, 11 Aug 2025 23:10:28 -0700 (PDT)
Received: from hera.. ([46.198.241.143]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f152easm19374680a12.15.2025.08.11.23.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 23:10:27 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] tools: aisimage: Make aisimage_check_params() static
Date: Tue, 12 Aug 2025 09:10:20 +0300
Message-ID: <20250812061021.1237280-1-ilias.apalodimas@linaro.org>
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

We are trying to enable -Wmissing-prototypes and this functiion is only
used locally. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/aisimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/aisimage.c b/tools/aisimage.c
index c5b33b559b02..7a44b2d6ab69 100644
--- a/tools/aisimage.c
+++ b/tools/aisimage.c
@@ -387,7 +387,7 @@ static void aisimage_set_header(void *ptr, struct stat *sbuf, int ifd,
 {
 }
 
-int aisimage_check_params(struct image_tool_params *params)
+static int aisimage_check_params(struct image_tool_params *params)
 {
 	if (!params)
 		return CFG_INVALID;
-- 
2.49.0

