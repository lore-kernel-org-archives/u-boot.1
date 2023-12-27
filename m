Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756DBC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE4287935;
	Wed, 27 Dec 2023 09:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JnCriHM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C994D8791B; Wed, 27 Dec 2023 09:24:21 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F422187661
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d5f40ce04so1783025e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665459; x=1704270259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ex0wBcRsQU2toorY/5ceTjKZpH75mJlUQNjz6jPd2GA=;
 b=JnCriHM/9yHW6VfC+OYdfJILQ3gt1WdA92SkzGhBEfLW3jcxYpk67XPJEBv8x6SESf
 dqxb/6yQ65v1fbvagvP6oXKZSxAQO2K48osjHMU6QVYOwRY8XOZpse3gznaiz2baj8/3
 XFvqcP41ONS//dpRKO8FmG5LanL1UpUkjA8W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665459; x=1704270259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ex0wBcRsQU2toorY/5ceTjKZpH75mJlUQNjz6jPd2GA=;
 b=YK3PUnhiRh/zGAwY0S7pmM+elC8SyHJ6nKvqnh8FxDd0tf9LNNBLkn9HrKN29Enegm
 Zk7RVmS9oOs/HI9hZ1yXef1H//+pgL0wfB5WJmSLadW6nSg2+xVkjVYFVIUvV7zGf2Bt
 tXdKJy0ut9jYjYBtI0KWghnDZomxazMkEahf7JDEYA1vbtODDM7gC8Kr6gE3DwzcWKFg
 XXGIfqyxlY4piDi7FRh8Tbvz38BRVfA/bTIy93iIwOAg9exAtwXUubN+lF05h8VOJAT4
 wWh+lyA9hvKw0Vxu+bj9chHvhuY500ZnH9bhV7rpEET7ZyhocQ6t6Bhw8iuZbuoRZ7I9
 IVtg==
X-Gm-Message-State: AOJu0Yyhd7LArXkuQ3wqUDCM+NMvp8IsEqhpoNt8ogwfkb1l6uhrBC0/
 BriP7Tnli70i5sqK2L8tk4F81JzTJxMLmfgsleq2miAu15xP
X-Google-Smtp-Source: AGHT+IHQ82YHYpZOjiNsfwgNBOz2U6oYC+jSF0ws/7izkJg2OZDiJOOQt+h6rBOnTOaHPkXANTF3MA==
X-Received: by 2002:a05:600c:468e:b0:40b:47f0:66b5 with SMTP id
 p14-20020a05600c468e00b0040b47f066b5mr4924598wmo.26.1703665459442; 
 Wed, 27 Dec 2023 00:24:19 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH 8/9] arm: qualcomm: dts: Convert to SoC-specific build rules
Date: Wed, 27 Dec 2023 08:24:04 +0000
Message-Id: <20231227082405.2202246-9-sjg@chromium.org>
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

Move all of the Qualcomm rules over to use SoC-specific Kconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3fc90648aea..8c704169b7e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -623,10 +623,11 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
 
 dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
 
-dtb-$(CONFIG_TARGET_DRAGONBOARD410C) += dragonboard410c.dtb
-dtb-$(CONFIG_TARGET_DRAGONBOARD820C) += dragonboard820c.dtb
-dtb-$(CONFIG_TARGET_STARQLTECHN) += starqltechn.dtb
-dtb-$(CONFIG_TARGET_QCS404EVB) += qcs404-evb.dtb
+dtb-$(CONFIG_ARCH_SNAPDRAGON) += \
+	dragonboard410c.dtb \
+	dragonboard820c.dtb \
+	qcs404-evb.dtb \
+	starqltechn.dtb
 
 dtb-$(CONFIG_TARGET_STEMMY) += ste-ux500-samsung-stemmy.dtb
 
-- 
2.34.1

