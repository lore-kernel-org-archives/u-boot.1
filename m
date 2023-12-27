Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D98FC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7975E878C1;
	Wed, 27 Dec 2023 09:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuwqYuzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F0F87823; Wed, 27 Dec 2023 09:24:21 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BBA86590
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d5d8a6730so4002075e9.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665458; x=1704270258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5FabhTVrCMfzswGYnqNofzeclxKHBIHXnOmkop29Mw=;
 b=cuwqYuzNOnCog+7hJcf24eP9x48fBGhjp1/ee7slrJf3wOgj8KUUnLG83750VqdcoF
 qqI9jRKE4aFpqErUC8pXINf9Jjd+dPx+ZA4jWK0jXFNK67f7ZsjcmyE/U98cJR1Zs4LQ
 f0RPw9qcZe+8rJRrbVk5GYbcCu1+8YN1M+gG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665458; x=1704270258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5FabhTVrCMfzswGYnqNofzeclxKHBIHXnOmkop29Mw=;
 b=U9hK249SFSEa1haunP9FTuy4Mjx9JdfekQqPAxBa+pmmDG0Y81p3ML5a7aAjRPOAeo
 y4M/f7AUXbrAO6lQu5iVdzm5UZXAWsuZPTpxact3Idz/RUjlPHw2oYFcMeaKgt+a5NZi
 2YRNGx+m9FqXiojFbW494v8j55+7nbPtm/se6+63jq5sxCyOqF//cTLimzEne3v7VbLV
 EVWG9K9NxkjCqj+OjSrKJgZqavxNxLLOiUvzZftMAukxRfepVkVIbIgDIoTYcO94RGqK
 JYgFIgaGrYWZ+WDm2102cuG/8wEEKUPXGv3dooTILw33WntWUvOgk5BB8/vUK8krgIcz
 0Kxg==
X-Gm-Message-State: AOJu0YzakYbN66kikyuzo93fj3PMcoFLoHW6tNcOHBwX8pEZpCeUPZYl
 kpnSDpca3r7GQYa9LQoTVsqOOhX76GzdDbTHt0QYSnffKrE3
X-Google-Smtp-Source: AGHT+IE4HR4wfy/wGJzenCEG29486p/il8cly83sI3FVvO6VIseUAiu8F+bQFhPEVT7f+fZYY1gpjg==
X-Received: by 2002:a05:600c:8513:b0:40d:4909:deaa with SMTP id
 gw19-20020a05600c851300b0040d4909deaamr4010906wmb.67.1703665458700; 
 Wed, 27 Dec 2023 00:24:18 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH 7/9] arm: ti: dts: Convert OMAP to SoC-specific build rules
Date: Wed, 27 Dec 2023 08:24:03 +0000
Message-Id: <20231227082405.2202246-8-sjg@chromium.org>
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

Move all of the OMAP3 rules over to use SoC-specific Kconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 60301dd2b07..3fc90648aea 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1245,31 +1245,22 @@ dtb-$(CONFIG_SAM9X60) += \
 	at91-sam9x60_curiosity.dtb \
 	sam9x60ek.dtb
 
-dtb-$(CONFIG_TARGET_OMAP3_LOGIC) += \
+dtb-$(CONFIG_OMAP34XX) += \
 	logicpd-som-lv-35xx-devkit.dtb \
 	logicpd-som-lv-37xx-devkit.dtb \
 	logicpd-torpedo-35xx-devkit.dtb \
-	logicpd-torpedo-37xx-devkit.dtb
-
-dtb-$(CONFIG_TARGET_OMAP3_EVM) += \
-	omap3-evm-37xx.dtb \
-	omap3-evm.dtb
-
-dtb-$(CONFIG_TARGET_OMAP3_BEAGLE) += \
+	logicpd-torpedo-37xx-devkit.dtb \
 	omap3-beagle-xm-ab.dtb \
 	omap3-beagle-xm.dtb \
-	omap3-beagle.dtb
-
-dtb-$(CONFIG_TARGET_DEVKIT8000) += omap3-devkit8000.dtb
-
-dtb-$(CONFIG_TARGET_OMAP3_IGEP00X0) += \
+	omap3-beagle.dtb \
+	omap3-devkit8000.dtb \
+	omap3-evm-37xx.dtb \
+	omap3-evm.dtb\
 	omap3-igep0020.dtb
 
-dtb-$(CONFIG_TARGET_OMAP4_PANDA) += \
+dtb-$(CONFIG_OMAP44XX) += \
 	omap4-panda.dtb \
-	omap4-panda-es.dtb
-
-dtb-$(CONFIG_TARGET_OMAP4_SDP4430) += \
+	omap4-panda-es.dtb \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb
 
-- 
2.34.1

