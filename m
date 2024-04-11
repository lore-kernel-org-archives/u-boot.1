Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE2FC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 16:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBDA987F04;
	Thu, 11 Apr 2024 18:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cM2RyJdo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8F787EFA; Thu, 11 Apr 2024 18:06:03 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C833E87F04
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 18:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e78970853so1644377a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712851561; x=1713456361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1YsdJ2lKnRMlY5iscf2Hs8TNoURjfkofgrTPZyUqYWY=;
 b=cM2RyJdob5Ruwv2Rq2lCUQrbEr47JDN/u7traxl6uI6p8U8ZpON/WBlRj8sIJDVC2p
 4BAwNEHFKwa+9zAVFkG3TFdOgypT8/jmjHRSDhWuvY/WxL7hSPUgZTVRshyP/K+qwjqh
 mcHTpIyKppSPXlcpkkT7pm0VzANRWn0j5afHFK9f87hPM3yH38rtvd7PCfauDNNARch9
 xauiIwzyGfrP7TQMB3GPBup4G2X136w+PsqF2VE+CM9wLPfiEumubVCVyyOREj9Ky75I
 J03r4C60jhrvRIi2W3X9uaJhAPZBaiGnrbOJP/9SAljnQYchqXqCkJKr4w7+gaLT8ryG
 lZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712851561; x=1713456361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YsdJ2lKnRMlY5iscf2Hs8TNoURjfkofgrTPZyUqYWY=;
 b=mPI7alt4jEvwIHMzrrbhqwhlr3WpfvzBRpzHjiPB4mq47PQ6LX3iQiknMEiVpWnkc1
 fAVVQkWAndvs3Dt0oJAz3TD3eQGPuMxBvhee0pBmYipOsPKFjub2X6rQqElpaOqB7yND
 H6vK9kveLwQH0G/IduO5ryLyOQ2PtL+v/DCsLVdW3QrD7a6D0+ahvTLgEFKlMZX9yMD2
 WwoD3LSINxQgeX6QN1HcjmN4e+LK4HeDU4jvCPEypSRuyrNfkfz2RNqxprvGrlsVWWy2
 y0PCASMW7Dsn884J2SiGLWkMnAYfBmZrULZ5CsZvByie0T6boO73KPOv2RK7/q9xLiaM
 gwXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWh4oRDtPIWq9D+otOg2T1gvhEfIAdcI22mIj8z7Dh1tJJLcFkpaOtymR1baMPiqb2/ek4MYJjDdj/MnOZbb8BB4Ny3g==
X-Gm-Message-State: AOJu0YxOwl5MemHEyy77RR/JhGwyb+Y4uJFOdc60zQ8KiQ9U97qnCMBI
 To7yxrhzDiTsp1aoU7Yvh1DfzCFGU2gvvrR1IZH4cNITe5I1Ub8l53dSNb4L89I=
X-Google-Smtp-Source: AGHT+IHBlpS11v2WMJ5rhFOda1BxC3zuns5Q01+/3m6ZIGlRNBSSE2TezonyzHYL+wX7IteuHANfvw==
X-Received: by 2002:a50:c05e:0:b0:56b:dd7c:ac3d with SMTP id
 u30-20020a50c05e000000b0056bdd7cac3dmr81034edd.10.1712851561205; 
 Thu, 11 Apr 2024 09:06:01 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v19-20020aa7d653000000b0056fd85df9ccsm814019edr.47.2024.04.11.09.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 09:05:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH] usb: dwc3: support USB 3.1 controllers
Date: Thu, 11 Apr 2024 18:05:12 +0200
Message-ID: <20240411160527.835767-1-caleb.connolly@linaro.org>
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

The revision is different for these, add the additional check as in
xhci-dwc3 core_init code.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 96e850b7170f..db045f5822d4 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -594,9 +594,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	int			ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	/* This should read as U3 followed by revision number */
-	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000) {
+	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000 &&
+	    (reg & DWC3_GSNPSID_MASK) != 0x33310000) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
 		goto err0;
 	}
-- 
2.44.0

