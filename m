Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A44C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15618791C;
	Wed, 27 Dec 2023 09:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q0UulPeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D6E87919; Wed, 27 Dec 2023 09:24:18 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D677A86590
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d5d898162so3280275e9.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665456; x=1704270256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvewTaNfq2HjnYSXwIgJpEkNQHnIEQS8WgJPtj8s7yw=;
 b=Q0UulPeQgexXrWtPdDiLoxQMDGFjngepiMEJUdhomBWGNI531/+wIaoVujzQOptm73
 Eh3lhqeEPvYTR8YWXcl08csaHMeVTK9vN4nE0CfBPVsD3NOIYCBKlL8J8aGPckfbjLXn
 UgLuxag6N12u7QcTPX5ByNN2eELH/SDzcpjGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665456; x=1704270256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvewTaNfq2HjnYSXwIgJpEkNQHnIEQS8WgJPtj8s7yw=;
 b=dck/wqA59+Riwzc5QsJXfvPrFT2Jd96G/ATmEW/27fDCiimcupgUMBC+Pfxi9/qjnu
 bZNfutpONe/+ozAdM/sS+nQYaZkFNAH3m654hV1vZnmhpkjMoQh+8Or8eEhhFsrHuuAj
 S2aSqoi9vKPJNRwOZALNjbY/60sc4l/NsRRxNF8tyxl2BrHJADQccbGIDmH3op3xAYaa
 rxfGnaYVxw/5cEWx7gorjcE7tPW7sWY5PfKlbSzuh0I1BM6A+RODu7k6zSAzewi7XY/p
 oOMWUby5sydaC5pDhSHVn46UW5ixW7R09RTYZY+XnoOiF8dIJW7P2nEzbcLRpaQPt0b2
 Kwjg==
X-Gm-Message-State: AOJu0YzhuIN0yzqAsFYO7WjVPVi8kQ6jt8ufZiJSojzuGNlfnVg6C8gA
 8dOkftg8aUwhhLI1WPKbBtgg1Dfh/+wTqqrlIOOECRYrQRpq
X-Google-Smtp-Source: AGHT+IHgGPDykxJWPUhvEowfhZJIVj0fqgWFix2MXUgovVWCdWpT2D3okPw4dtoBy/PB3Smm823DoA==
X-Received: by 2002:a05:600c:3c88:b0:40d:418a:eece with SMTP id
 bg8-20020a05600c3c8800b0040d418aeecemr5365553wmb.106.1703665456176; 
 Wed, 27 Dec 2023 00:24:16 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.org>
Subject: [PATCH 3/9] arm: at91: dts: Start an SoC-specific build rule
Date: Wed, 27 Dec 2023 08:23:59 +0000
Message-Id: <20231227082405.2202246-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227082405.2202246-1-sjg@chromium.org>
References: <20231227082405.2202246-1-sjg@chromium.org>
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

Make a start on using the SoC-specific Kconfig option for Microchip
AT91 SoCs

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e9e58c5478d..d8af3c26b27 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1196,12 +1196,14 @@ dtb-$(CONFIG_TARGET_AT91SAM9263EK) += at91sam9263ek.dtb
 
 dtb-$(CONFIG_TARGET_AT91SAM9RLEK) += at91sam9rlek.dtb
 
-dtb-$(CONFIG_TARGET_AT91SAM9260EK) += \
-	at91sam9260ek.dtb	\
-	at91sam9g20ek.dtb	\
+dtb-$(CONFIG_AT91SAM9260) += \
+	at91sam9260ek.dtb
+
+dtb-$(CONFIG_AT91SAM9G20) += \
+	at91sam9g20ek.dtb \
 	at91sam9g20ek_2mmc.dtb
 
-dtb-$(CONFIG_TARGET_AT91SAM9M10G45EK) += at91sam9m10g45ek.dtb
+dtb-$(CONFIG_AT91SAM9M10G45) += at91sam9m10g45ek.dtb
 
 dtb-$(CONFIG_TARGET_PM9G45) += at91sam9m10g45ek.dtb
 
-- 
2.34.1

