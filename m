Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E741C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B678867D;
	Thu, 18 Apr 2024 20:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NopMQrwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A937D8869A; Thu, 18 Apr 2024 20:40:15 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D248866A
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so797218f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713465610; x=1714070410; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SB43OFyVU0FDBlZkgT04+T0wR7aHlJ5xA1rC3gsbkKo=;
 b=NopMQrwRSkXMo8LChJlJ5yg/Fgh1gdEzV23M3JQgk9eifwp951qxzYWtZgGA9u8xMM
 1AKDxhD+QKl0qw1c8oAzr4271P+bw0esWYNlZlaQn1mbGqvdWemSZvq3WwH3kftmtFt4
 iSsSjBBzTrwtPBbYCNXARjU6EDXTbssDw0YUK1msSjjAdbUiNL5UtUlTivboVTeArg2h
 UBaMKwpoC1Br3+xNvsUsPhGpbhBKW99U32cAxqQDb/bQSIvU7gSaAFshOylMgkAuQNG1
 sYSQFm5iPC+Q3tLJIiOcyAkytI2O+Keh0uz7D5eUGQszCI31tkAZgk9ZCrjmUOBh1x9+
 BQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713465610; x=1714070410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SB43OFyVU0FDBlZkgT04+T0wR7aHlJ5xA1rC3gsbkKo=;
 b=MFu8zxsRCUQDEpttRnzJ+SQb/DyS9hpLL3TeWY381rWVwHdPryxQKlsUgXBw+du7Hc
 O58YGM4rjparPTS4Yn3Q1Y8JQRaMqLU6ZGvI5ryt4TEXKfRaMixATJ6K9BsllOBA35U/
 eLnk8+NQqJuSsrinXLPTVnx0AHGs2uIpNutEytgyEnrIWTH6gEafF2kSuM63qvTNIofD
 2dm4QBJTcp+ZEwVPgHAaR2FpimJA6k0tNkL4Eom7yokMk8YlMmAJq+R98M0yYsVdlfZD
 x+sdlq0Ki/Q90E0PwRTfraCDJc7dIFHuWcbYefdGk/oHnjcSoa7YYQtz0ANxTk1lgu/i
 ERHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBCNHhhJXva6dsy47uWpMRMidBcIogoXXi2WyceyWPg0i6m5ZN9dUentxzH+cMvFPGnjWdBU8SsR9+wJuTb5GYxbU2Ow==
X-Gm-Message-State: AOJu0YyTAzw8VESUPmWIFmXBYyonD9ng1mJuzS8jICbTy2RzGfi8ow3k
 x1bI8CmtgIPyhM0LVkeEmTIrt3lvS3bGotSWsFPs7YYL/10mHVdxi2RFKbZbmGg=
X-Google-Smtp-Source: AGHT+IEWaavQWUK6fRfC9vV3z7ojb714qi0RKM6GTFIdymB2F7MELBz2nRrv6Uu6dSzpivySmKQA2g==
X-Received: by 2002:adf:f60f:0:b0:343:3a51:ad65 with SMTP id
 t15-20020adff60f000000b003433a51ad65mr2149122wrp.38.1713465610624; 
 Thu, 18 Apr 2024 11:40:10 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y5-20020adfe6c5000000b003436cb45f7esm2451408wrm.90.2024.04.18.11.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 11:40:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 19:39:56 +0100
Subject: [PATCH v4 1/3] arm: dts: imx6dl-brppt2: fix gpio.h include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-of-upstream-build-vendor-v4-1-d404deff386e@linaro.org>
References: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
In-Reply-To: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=694;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=a4N5FSU8ovaWKQBdcfnB3Oumi/PSHO6Hed2StXNvObk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTFTA6eBeznoyeYiCf3Tl7Mvi6As69dVMy9bnGxSoDtj
 039z2d2lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIkUFTL8z5/u4NF57R3vlB0P
 j6xeU927NfTEh492655+jFmtepHbXpXhr2h7kvDagkzdfwbBiddWt3u7J1eES55cEdencyeMc7L
 PAgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The "include" directory was included in the include path... Remove it.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/imx6dl-brppt2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx6dl-brppt2.dts b/arch/arm/dts/imx6dl-brppt2.dts
index 575bfac7bb73..05c843c3d0f3 100644
--- a/arch/arm/dts/imx6dl-brppt2.dts
+++ b/arch/arm/dts/imx6dl-brppt2.dts
@@ -16,9 +16,9 @@
 
 #include "imx6dl.dtsi"
 #include "imx6qdl-u-boot.dtsi"
 #include <dt-bindings/pwm/pwm.h>
-#include <include/dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "PPT50";
 	compatible = "fsl,imx6dl";

-- 
2.44.0

