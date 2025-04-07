Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EAFC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EFA82EAA;
	Mon,  7 Apr 2025 19:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QwNERYRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182AC82F65; Mon,  7 Apr 2025 19:00:07 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4393982FAA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso9581528a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045204; x=1744650004; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jib1TE3nu6IbxtO6AEYHHFgwynayw+SkHcpVF0E26to=;
 b=QwNERYRWKqJUttTA7YFwKNdfVr6T17hFGCzybm6FBT2u64VSm4pJ96Xy26IJWyjMKD
 nBqSgbUkjmM+5Sdg+vt8M+espwz2gMQzBtKaVGgK34wvR1inq+YJL2h31Pqvyrd5yIid
 qskTROk4PFNlywjsTTxuDXUFTgLO1QgPSqaqCSGEFoyq9lauKY/DOR/d/HJbNhvMzUmP
 vRGoI/SU7Rz/ob4QvPfC4dth0kmjAL3KVvanAzN96ihV++dJa0k2qovI3N92bJsE9QjU
 finowcyXbCMkoC1YCnQM4rcOwMa02AwNhnVVkfrJjSnaWnHf6KyeT/V3VMuYDc/ifn+f
 px8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045204; x=1744650004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jib1TE3nu6IbxtO6AEYHHFgwynayw+SkHcpVF0E26to=;
 b=sH6R/+t6u1XUSZKNy6hJU+ZagOV/7oeyS3R6BWFxnyPvMj6ucebGnsO5qf2TL4/hp/
 2NvKWoMABo14uD6fqngitX3HZ8PS/36Yx/qTPdlRny91WgPEpfH2yA5cQN6WPIurnPY4
 mu3Z6g0wEHvNnuJ0JeVbxtPpJ7Qx3IFKmB0wdxHmQy5z5bq3q38edCJHDkYTLP1HiyJM
 bhKNbqjESKFKsH8uslE1Rd3eUehIBQtgJo+V8rC5mXurq+aTgNZ8Lxo7cArazu1sjYCq
 rSXheHZjj6kEdw2TGiCUPklhPgG3Lcv21c3P2PnT6CcRSaOkLn7Y3g94AO3Gj/LkpP8H
 O4RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkMXLVJBk42qFz1RGLBams7c+v6JbRTNMTowxqbOGCpffh4rFwi9PJ8B74NbLjgysudLPgJAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/hQB7dczJ4eaHrcsaz9qA5fq0EQEZ3tQDPD3jJ8VVlflA5pul
 X0QPA+CTQIqq55qLsgiaxa3uL6roU6jjYe1YcQufzeIPBXRkX8y/kj/CgAd90cQUjYEdn4Of1J9
 2
X-Gm-Gg: ASbGncs0RlMtmkAFqHHSlZv6jsGVVkSfdsHr1MxFBPUTC/15M3Df80ZDFPMOPxCu3vi
 cjVnfKEC1+Qmbv8J3+PTeoIAhw81dgYkP5FgfXR5WL9bhZeeciB18N97McwrNgS1iGseuQ4dCyl
 PHBeFN/DMawGn2NhGKKP/MdAZvMeEwp1MQid/2HE6uDya26/cY5Mgk2wssTvIN53NahtJfp06FG
 +yAPgEKri8j+agrHQFHtlFi2g+uwYQTn+KcetUrIn1pl6SjkWGY/4zhWy+XiTKIjdU9VLMs83xI
 pHQIIuHmTXUcOc46aKBw/GYAWpUzqkbantKy2QwRH2P18k5iocrq9LMQbQ==
X-Google-Smtp-Source: AGHT+IFmeKblRcdF5EUb1TsGe2g7SCn+Wr+p5xTom5OCb1uLeQJzE0FgVhpVxyIDhxxPuIaVnd+euA==
X-Received: by 2002:a17:907:9712:b0:ac6:dd57:4bf4 with SMTP id
 a640c23a62f3a-ac7d190ec33mr1083254366b.25.1744045203621; 
 Mon, 07 Apr 2025 10:00:03 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:03 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:30 +0200
Subject: [PATCH 09/13] board: dragonboard410c: Enable RTL8152 ethernet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-9-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

The Geniatech DB4 V3 [1] has a RTL8152 onboard for Ethernet. I don't have
one to test if that works, but the other USB Ethernet drivers work pretty
much as-is, so just enable it with the assumption it will work out fine.

[1]: https://www.96boards.org/product/db4/

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 configs/dragonboard410c_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index b7f284b4fa2812c60804126362b61164135adeeb..da1ec4bfc60cdf4a2a9077efb081383b5b39301a 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -69,6 +69,7 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x18d1

-- 
2.47.2

