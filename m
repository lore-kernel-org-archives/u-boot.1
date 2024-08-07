Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5184C52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01EDF88BB6;
	Wed,  7 Aug 2024 19:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bWBqiuAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC93788A84; Wed,  7 Aug 2024 19:13:03 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CEA88B15
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso42719f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050780; x=1723655580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=bWBqiuAy5FtE5gLky5eAwVNMUjkqVGugtZOAlp735fy+mBCDz/zmYZPNldc+7qq5Ws
 G1lQvkAXJDq51mOesxFOXC1LfE4rRo1bYLz7DrlLDUmPCwbRYNbaEGMW+/AZk1/bJAzz
 e7kMSj3FHlv928yNO8P90kUNsj3tChyBg/yBWlnH4cXFOve1V1rotO27MemD7NjPvPtk
 H4kIQGWmKEBsdW8iKfVYnQ1ctvnF+E5Ub5jGIita/ptxu6ASPp5Kd0q7+927S7Hr0mcZ
 IAxa0Og15Pj1kS+y+RgAI4EcG2GxCObZl5214v32yb1G8Kfv6+BWlYLCrttr8NFypJyR
 F8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050780; x=1723655580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=XfpHGT75WahujUq7Z/6qX/NJwldyd/NWVcQzbmgp2Tt7O6aqnDLQ/jppeWcNT1yeNE
 ZyxaxScCM/W16fuKqeszIZuWUTUvdxptNQJ1d444QmSIF/SMv1yClVRIrLT7jD76xjXj
 DwvDr8Q7H4tm640koYoPntmb1bnOhHzgPhAv2btVl3lcBV2BvGYmu7eMnVoqytvEUMqf
 LJasNITw7xqC9JVJnuEWv5Xap2wPn2NxBuUIpUywdfA4Y88x7400kUIhBGOZAa/UzuFB
 c9Fet/cyqkVZTeCA0BU6DU1RLFYUjLeCL0tNoPiY9AybUll7YCIMX9EAlb/yw4ZBekFT
 laKA==
X-Gm-Message-State: AOJu0YxsEQ0sEkb1j6av/rP9WsjiXQ9n1cA6aN2NdIojEBEaTdOGEfJf
 p0hNBFaff6soxztVyP43CIFBWFeD5fp0mAJ0oRLDNS7K925Xi7qTwOB3R4wwCcxPW989fVeaKiG
 UQTQm2I4y
X-Google-Smtp-Source: AGHT+IEdH779GfR3FtXZ/0MOCZQg1xVB71kxkkQiQORHehkxCbuJRfjBwg2ns1EYeB3Bn02+Q9BPXQ==
X-Received: by 2002:a5d:484c:0:b0:367:8926:812e with SMTP id
 ffacd0b85a97d-36bbc1d3e28mr11271756f8f.62.1723050779705; 
 Wed, 07 Aug 2024 10:12:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:12:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v8 06/23] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Wed,  7 Aug 2024 19:11:50 +0200
Message-Id: <38486335f3ec7990124f0224108a967641f7dca7.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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

