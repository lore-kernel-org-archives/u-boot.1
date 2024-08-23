Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF2C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FBF88ABF;
	Fri, 23 Aug 2024 15:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qCQfOrGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE49889EF; Fri, 23 Aug 2024 15:49:23 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526D4886E7
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3718706cf8aso1014585f8f.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420960; x=1725025760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Drt734jtNXjt1i15GA8hE9TCdNeg4g5UkVsQ668keI0=;
 b=qCQfOrGNufLPypM5XM1+per0euSg5Ln0VlqJoLkOTOUqvnfWnvhqCmgxNDYliSE9Yx
 UY2LslG1r8Xa683lTdHGYNooZQRu9rKBLPHMLs4rtKBeIrl6qvWD2edmxX70gJPXE1Mz
 jBmuL6cz5n+cmkwohqi4NNMVXnLI1cB9uInycl6789xF8XHs+cRKc74SzX2UUCUG07TC
 hmBHSw6Jv1MZQqEjUOgHJGS02lMX7pZCxkix5tWI0AnP1TYocq71Xn7p9UmmOI5XtAqG
 VdaCAtYM4sHLSmJqXyVMUdfYeX3bqtlzc3IzZ2E0vvLCRadBncsl62kSrh54tVdVP5ET
 tuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420960; x=1725025760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Drt734jtNXjt1i15GA8hE9TCdNeg4g5UkVsQ668keI0=;
 b=BNPpbs912aGtVbzLQaJuRFtBsbEti16ro71wadH/hmQvkNAC53PHcfPC1d/bZBH1Q0
 qvv2LxLlULgAUWC6TxYZp5iwmhSlnGbk2n/SV2uLdn93zOErjzeh/itGIWmWk5dXB798
 ebDvSr4tCrSrAVMhXYHntE9v4yk7lcuMhmTJaHGPSrTlcpbDDNg8H9EumUYEpvnr28TV
 vycAAsDgzhCahUaAawNny8IxGP36bnDg/C0F5NJ/xvxxT2gRaUm2+vrhleIVHOwKH1Y6
 F7LjuhJ7ZKLTh7VlXLkqfWD4E2NGZoPfUpkx3XRyBh2ABhIHzZsNa0EjvOty3NQr4uYu
 FtXQ==
X-Gm-Message-State: AOJu0YwApBsmiAa4fxTbM5v9wu4aWvT4pf5MFWA9MIS5pU3EEjFNGjLW
 H7UhSkgDUqwNMvZZRQcD+aTCYa/mWX62J3bxdshQX4vWRRleegX+Gy2VvNIBs5Le6G4mvgQiYaX
 FCApfxkre
X-Google-Smtp-Source: AGHT+IHMrOZYdeTpgQQbeniRU7uV2K4RusTf3shz4l8eaz35T6nGmoIXkeSilmqFjCmzQKqi2JecbQ==
X-Received: by 2002:a5d:68cc:0:b0:371:8eea:24b4 with SMTP id
 ffacd0b85a97d-373118e4170mr1405025f8f.61.1724420960513; 
 Fri, 23 Aug 2024 06:49:20 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:20 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v9 10/37] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Fri, 23 Aug 2024 15:48:14 +0200
Message-Id: <b678b0cdcfed568473615b95687ce22a0b9084c6.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

