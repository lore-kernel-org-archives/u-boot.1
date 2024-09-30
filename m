Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D25CE8340
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B6488F83;
	Mon, 30 Sep 2024 15:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ehzpsMk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E02F88387; Mon, 30 Sep 2024 15:25:08 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0323A88F2C
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c721803a89so5711077a12.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727702701; x=1728307501; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hGJQYzEDeV4jbflEoLXZcY1KL+7iyfVvhHx2F6eh2M4=;
 b=ehzpsMk2eRsHixy/YxWf5smsi1acTvw2HAjgot60rdYo8n4MbEZL88R2euahRKaf21
 L9sQYdn3rljJ7ELDI7QsAn629p+mplN3xe5/4ZmO425FswE1DAOCADyQpvfJqj8eXVNF
 tbtVH7fKJWe2dpG5jci9/Bc4D/+F8gWfXDsyiFrkaewIASTToSJlpo3HgOrY4B8OtMWO
 TB5pZJ4lSN77MM5pVizYD6+HueCsjeE0G0+zkazHVPoEZvkY7XCmcCazuA3e7gHCANq0
 J7fhRhizC78d8pYvvO+n1L6bFuE7Kmjpz0NbIdJneinr5BA9wBpVB+VL95f34NmncJEU
 0yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702701; x=1728307501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGJQYzEDeV4jbflEoLXZcY1KL+7iyfVvhHx2F6eh2M4=;
 b=B4JXkXapgucjhbZ7xfOFvXPTmMjSCqMPOoFAWlVxxT9dyWLSktlD/QmvN4DAFWn/rr
 P5W17LQKt8SlyyIbUA52Ho+6bd+qSeE7YNRFo9fnp8hKTZhBoo46T20WZZNLNi7E62Hv
 l74yheYIuEYsEyB1qhnT201hK7p2hBfCUORSY4IM8vfWcD40OytENxuvwbyJ556HjwWd
 eCB5k6PEIuLHnaQkvcShKrLjUq0EY9M+d0geogkMjLzEuwRb4XIC6QsCKd7AVaGfQLp2
 hjUzpqn57hzQy8+AeHackmoseyT/bNCJ66EIGkiPjoSmW0KKRMLcQU3qTuHSdYtYbQNk
 MKrg==
X-Gm-Message-State: AOJu0Yy5m9J/j9+nYkbC2uWzyKP5G0JveqFd9wuurTxRrXZ+sZrLuib0
 +oitQD4aLVWVQjE/grA2zicCrjkbWIiu0VF264sCEv4n0BHWWgnTBbNgnxJ6iLQ=
X-Google-Smtp-Source: AGHT+IEzoTo0udQFzQZcU5y/QgX1wmHvtXjf/KKkqadAE7Unw6BlcsolfOCVFiG60RvsbKHF10AKCw==
X-Received: by 2002:a05:6402:210b:b0:5c2:6090:4047 with SMTP id
 4fb4d7f45d1cf-5c8824e5101mr13288754a12.8.1727702700876; 
 Mon, 30 Sep 2024 06:25:00 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88245fbeasm4484786a12.54.2024.09.30.06.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:24:59 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Sep 2024 15:24:55 +0200
Subject: [PATCH 3/4] drivers: nand: bcmbca: Enable on BCM6846
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-bcmbca-nand-support-v1-3-e637c65de947@linaro.org>
References: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
In-Reply-To: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

The BCM6846 has the BRCMBCA NAND controller so enable
it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-bcmbca/bcm6846/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-bcmbca/bcm6846/Kconfig b/arch/arm/mach-bcmbca/bcm6846/Kconfig
index 229ab88dbb0d..5ef9535369ec 100644
--- a/arch/arm/mach-bcmbca/bcm6846/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6846/Kconfig
@@ -8,6 +8,9 @@ if BCM6846
 config TARGET_BCM96846
 	bool "Broadcom 6846 Reference Board"
 	depends on ARCH_BCMBCA
+	imply MTD_RAW_NAND
+	imply NAND_BRCMNAND
+	imply NAND_BRCMNAND_BCMBCA
 
 config SYS_SOC
 	default "bcm6846"

-- 
2.46.1

