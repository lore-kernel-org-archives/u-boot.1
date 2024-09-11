Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23DFEE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C2B89261;
	Wed, 11 Sep 2024 11:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rt4or0Pp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FFF8925D; Wed, 11 Sep 2024 11:59:07 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70A38925C
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so21054425e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048737; x=1726653537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCjcDCoXb5oyRDUvYeiyUQT0buhWu2O71HdCxslK+58=;
 b=rt4or0PplYDrUm1HISIoR2tu4Bf2qfmnFcgfaqb5SF8G9dnm1s9wBCIC57AnWo99b3
 UtB85AFf8b/1V0R2xpkMnTc0xgxKDIO2G08ZYoyHneJ1dealwSWTunxH47wMfbujZWrg
 +UiIiOMD+z2iuF8IKLNRULnltwdsRE+TOuMJ7N5f83ivGiGp595Db5qp9wA3ZKIChTYp
 /lsQkNVhnQ/t0nlYdz4S0MrWbPK6JvuVHZKjfpBFui4139HQZKiOghhmHIIoQhPtnEyw
 VVuEO2/QwOs4BH30/ktcU746gFRq/42MJPW74MTE/bnOqUeIhjX3P9pZUiVQ5cah/y9U
 xrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048737; x=1726653537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCjcDCoXb5oyRDUvYeiyUQT0buhWu2O71HdCxslK+58=;
 b=k1SQCFpi3rcVoWQVd3FdxhhGwpkGfWEQvWyxPi/Ttt6Z70DM03KLHnOL3Kwu586FCA
 QYXF1ZQmookmzHmDScF0UTO3hFo/IeglUcjxim1imoIw8bBLhgcrOiD3gCq2+Na/H9jg
 sirli+X40xb6zhJlhLh9HGJ1tmUXcKEqCPZ2ctPGhDETFadtH3TSmd4OaJJleUIvVoJQ
 8Y7JYi3k9VI71S7qjEXiMU37MeAFL2laXMN/7IOapU/IoOl8co3iNzqm6bSs/xWQmuef
 5N2uS44WUNeRuLk9apQwbTCDZaJKBYJMlE6Lm5hXWwWwfQLsB5IUePqlFyE29UgmNrSP
 JxKQ==
X-Gm-Message-State: AOJu0YyyIMqUUI2yS8dxOPKMLA6rD1sBC0MKngHaG2aUgQJTFlhvTh8T
 wscX9u8iYPRh7Jv+MxpZttzAzZ9E3gQTLeHbw8Fav7HuBiqEax0WB8CTo8Dnggkwf6eYUoEbkvT
 +Y4sVfA==
X-Google-Smtp-Source: AGHT+IFwBU6Vh2qVue1z2AwJ2s3NdkgKidlJCKyDoeXiBlqmu3HD6Qb1DGDZd/mNnu1DAuBBOACXBg==
X-Received: by 2002:a05:600c:468e:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-42cae79d262mr85779975e9.35.1726048737147; 
 Wed, 11 Sep 2024 02:58:57 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:56 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v4 10/15] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Wed, 11 Sep 2024 11:58:23 +0200
Message-Id: <2089194cf5b0895958a74cb52dafdcbf1de7c739.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

The fec_mxc_init() function currently always returns 0. This does not
allow the callers to detect when for instance the PHY initialization
failed due to the port being unconnected. Fix that by returning the
status of fec_open().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/net/fec_mxc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 0a0d92bc2cd..2dc1364beec 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -615,8 +615,7 @@ static int fecmxc_init(struct udevice *dev)
 	if (fec->xcv_type != SEVENWIRE)
 		miiphy_restart_aneg(dev);
 #endif
-	fec_open(dev);
-	return 0;
+	return fec_open(dev);
 }
 
 /**
-- 
2.40.1

