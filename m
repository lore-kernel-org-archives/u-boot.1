Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB4C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B9188A98;
	Fri,  2 Aug 2024 15:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P8Psfvku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7561288BBA; Fri,  2 Aug 2024 15:14:51 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697C888BC6
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368526b1333so1940595f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604487; x=1723209287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=P8Psfvkue1PglVSemZ74+vUhHdGcAxvBYfLHGAHehJJ7m/Vv/k8SX/7D2EbND0+W86
 Y6F15NCbiB1EjF3eML/PFOwxdPwj8hAvoKfjMOO+2SF59vSORl/e5iV9D4BPQXoLvv98
 mfAv1fZY3plgVoQQjiiIx7bVunmlmZsjL/O+ILLTHcp52BS/FnaEaQ3PXuPLvC2XS3VG
 G5D9JnEIjYAVUP7DQXlkuSCvTvJ1oh1r5SVQuYupOdvWJsiy29gkJ5MZqyUj7PaEgY2o
 fb2jdmK3mIIUIVTz84+hjEBgSTSRqMVvGGsqpR/BR0XHqE/KLYelZ5EzZ6E8IYLMtBGg
 YFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604487; x=1723209287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=DRRR63mfla5ezmnonvrTFt6pu7PKKATx//IsRJch1B96IMfFe4Jm2VgPMCEqurA253
 /0O0PElsHfz3vAZU7x/AOsD+Tivo3cktzWN+XUOAHM7VOIpvRBvL5W9DDSci0nsmubts
 D0xqYi4Xd2W0m/nB3RMKW1zc0RcC9/p6U8/xDgiJc/DI/I65DjW5ntnxUJKokZALjrS8
 THyY2Z4uROHKwQdDjADVVPfVfVs0w6uGSgSSeDATx02uTOG2JqIHUgwVmYk/mB7jtcR3
 Nk8i4V79FcweKnNy7us3DJFk/nW0gy9XJovFqWYZXvOIcssoMaayfhO2OCNKSHRB084u
 DXVQ==
X-Gm-Message-State: AOJu0YwM15G3aEtOfHpMSsIWk16ZM71ediQ0e5KgOQHC+I2TIUg/BNiT
 nDIqBQJFw5+I/TugFBR9Kj7PI06K/ee9mW4DFgpVklXuv0SZpuTQIwLoSoOsVsmcedAGj+S5rcv
 t9Kjf8DCO
X-Google-Smtp-Source: AGHT+IFOjLc6ij3ae3c6YkZeAaN2CMbr7v5IaRbc0UYqHC/w/ht08N6Vnb1K/HXTQRwHLW7At+P2og==
X-Received: by 2002:adf:f588:0:b0:360:70e3:ef2b with SMTP id
 ffacd0b85a97d-36bbbecb238mr2518948f8f.26.1722604486662; 
 Fri, 02 Aug 2024 06:14:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:14:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v6 04/20] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Fri,  2 Aug 2024 15:13:51 +0200
Message-Id: <f85577564a96916e74a45b063429ebe15b2b0646.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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

