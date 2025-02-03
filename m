Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE42C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBC6801BE;
	Mon,  3 Feb 2025 18:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E/TdM2tT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71288070F; Mon,  3 Feb 2025 18:44:37 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6EE5801A0
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb790888c6so1287560b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604674; x=1739209474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAxyUP1H+9h0XtYd9S49eZoCx8tT2LTmztko0OSEIEM=;
 b=E/TdM2tTmrCrxpe42wTlK2gibvvZolOq5iEADPwM+AEEqdZ2wskmtln7JHnp02oEIV
 bl1AnJuKFL5PhHSCEiJNzObnfiUt6ksQ0MN/B3QRcca6tsxsh12kKBsmWdR3YRaKk6re
 JwqQ4+UhySenVRu1RS8tghIWRvFOZTA0Sed4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604674; x=1739209474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAxyUP1H+9h0XtYd9S49eZoCx8tT2LTmztko0OSEIEM=;
 b=VO+e5dvRcz4rn9yj11cHXOXO4HYSGaVOZ98trbQ9oMzc/yCTIC4qbkBMHVb1K8jlyX
 RRcdfiW+r11X2cPMHtiFgTGMe4uTdoGpQvxO2DSV4q4ERXMEZZp6pdq+KA1PYQb45OqS
 Ax9jlZVD+07pRnyKwLmFktvbXpFpOBl6NOZy8bbfFhNVxdUF2OyotfOjZW9BBsI+b8Of
 zyxD6IheC2Y0dfCdsFW3XnHTLmd6ArRZ9oeSr6mHRVIhbgrFLC0QG8ZuCiNN70IFan9E
 nn/G2yVJzfE9vuzOmtsZCexwzlD+0daugLcZVSOMUWIYM6L0cbJ7anO4te5O0gZn6CBS
 2Pqw==
X-Gm-Message-State: AOJu0YwlPm2ss1v4EVzDuTXK3G1V1wGe49sQ6lhDycNHSf0xsWmMsKf8
 /7gaa/sCvvrwYIYarH9nKylPh0bn6cByrph65T759teu+dekP0K/tylJCWEUn00Sv0nNbCGW3GY
 =
X-Gm-Gg: ASbGnct83pn7EABdFYzZ19bvwuho44dqYTjHFVDIrMl9FiaCUO22FLjBJ/Q5siDKfMe
 xFEwt+WdfvxXquzE1KPk7wC9VMqkqdzXY51FOHLX2POhOilHX4FtqocrfGt42IgvtmeBoEb/Fu/
 gYVVc81mvlaoVvWmkue0QfXs5AU58deHN4Iw720kp+E/qRTYx6W4M1580zgbV20OCVc5QbaYRqu
 nYxWQMC+w58/kUpcOIhrWq3PgWGgsvlh8YSIRCfy2KF9hH+k8bJvjODLYjrSxy97tfppAx4yBjJ
 VmIxhXVj2Cftdj1gReHOCvcMklgfhXCT4diV3mFidAwr+cji42wx
X-Google-Smtp-Source: AGHT+IEbPlRDNIdGcdp6E7rjq4Y5vrp/cSoRVnevqt0rxL4Oe/H7gBZRx2EeGZjM5hKIk1P2Atd4pw==
X-Received: by 2002:a05:6808:1899:b0:3ea:aa8a:c121 with SMTP id
 5614622812f47-3f323a986b1mr14742357b6e.22.1738604673986; 
 Mon, 03 Feb 2025 09:44:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 29/32] efi: arm: Disable STATIC_RELA for the EFI app
Date: Mon,  3 Feb 2025 10:42:22 -0700
Message-ID: <20250203174245.1331464-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

This feature should not be used with the app, since we don't know where
U-Boot will be loaded. Disable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b032aac4caa..26168670e5c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -142,7 +142,7 @@ config GICV3_SUPPORT_GIC600
 
 config STATIC_RELA
 	bool
-	default y if ARM64
+	default y if ARM64 && !EFI_APP
 
 config DMA_ADDR_T_64BIT
 	bool
-- 
2.43.0

