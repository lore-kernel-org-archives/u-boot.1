Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA92C52D70
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D206788BCB;
	Fri,  2 Aug 2024 18:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gvcBd8Cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E54A88BDA; Fri,  2 Aug 2024 18:28:14 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CC988BCC
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-368f92df172so4181712f8f.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616089; x=1723220889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=gvcBd8CzyKIzppqTpR6cQJu9gJ1056eCkvZB3KOOG+wZnuBACj0B5cefoH0ucP/Jhv
 +BbSF8pNCZsemjuWaDZkXsJlGQiWxsn+Sxv3iNVgBPiVG01jjTg6a3ME6HReaupo//t3
 l7qDS4xSq3f7H+xyP+BigdBDQ4f93cpUvVlbAS8tsIXEjoCiPq+EbiCu+KweEfidAII2
 qxMT14KLXMnivIMXvReD1r1CKHy2XsZYQpx3oVtTn81ojYxQ4Eew3g/FcadMP4Rypkx0
 +m0mSi35LB8y2B0CGR4m6+YA2CUOeKVFZ//lLNOSxHXBsdJRXzr1eRJH+v+1G/DlZnse
 7O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616089; x=1723220889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=xTW18MsPFEgmPHV8hPMKICPDRaUPXenw2A1OqN7jZA+vIcDJQJtXVdOFIBHFVp7Als
 ucJlprbZOfITvg9XVeM2TTS1e8dAPGrJHGP6HhpC+F3S2GzJBbFQ1eO3xE/ZrdK8nuno
 warBD+lj5S47/drmdfygsHBFuPBauurmZtQb8eyjC0daT78rlz9mtXDCCDXxCk6dYppY
 joROhdIOmjWK6G7xZlm2aflbtqJuicLwJqBsTUSwqBxguS7yBNL46491nNrx2vWUeMtP
 xp3qsoFap90S7A/2k70E87M8KNF7fXk+gYCWZEr+KxjMlnHfemMsSBpUEtzdp+mkt2Mx
 qb0g==
X-Gm-Message-State: AOJu0YxohZnfpc3Zcgx5iibjPw5c9reng5qUHiTPu9j+cVHlyxwPug3v
 LCi9YyDUu/tg7JtU62u732ThaYkaQ5AjXiYzLZLyR9PLRFsMFQXqfqLxwBLE4q4mNt/lY93Vily
 IduzNfyas
X-Google-Smtp-Source: AGHT+IFpol4bRHHt3zd+8UOtkDGdenT9xtskt1HWR54qtcCIVR29bM5HYutGPXckuDrKfHpGJaOuGA==
X-Received: by 2002:a5d:5101:0:b0:367:9575:2820 with SMTP id
 ffacd0b85a97d-36bbc14ada2mr2118112f8f.45.1722616089274; 
 Fri, 02 Aug 2024 09:28:09 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v7 04/20] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Fri,  2 Aug 2024 18:26:31 +0200
Message-Id: <441dfcd637923a0b3f405db351ad0ddb4e7370f3.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

