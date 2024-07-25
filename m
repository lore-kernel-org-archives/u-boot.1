Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E12C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042F5880D1;
	Thu, 25 Jul 2024 14:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ac404qih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD21881C3; Thu, 25 Jul 2024 14:58:47 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B17880DE
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso7062615e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912324; x=1722517124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=Ac404qihlR6H2yJ7CYLV+sdD0KAw/Y4IrxDtcahLwNR888OfcJvhI2TcycSOFURiHM
 EmGb/7SWaIZbVdhwaxEg3S5oM/6DPt+rzmp6NNquUwT0kPXJIVUp7Y6xF7pVfOlY7bZw
 zrI5X1/cZvCdJ++0wu/gQDvT4IDSIrEI1x58WFZaj99Qvn9fz3tbbpeu5zKBnA8/E/Jn
 C8ktxFST2Rjy0STzvDqyirakSsLTSePyZdNiab1mqqiXWyvdr6RD8Ag12RYtIoeegfTH
 7jtXreUGGvTDHc8k2Nh9Iv440XQ51uElwkSPEFAfqBeFeoE5XEP0h7AscQn877VqKfoo
 sWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912324; x=1722517124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDoaqxi/pyuwz1Jij51+SeQNLYun2RqMvJ8lA1MifIY=;
 b=M/jQrjvyqH4ttjKMnxoCnS3wCSxSFkH2c441K1tAEaDZVRRfizfkaKMDP0HPKtmENL
 vBEbNCUim+xPGd1MGj+MlkJBK9bKqEdcZkIjAToyit267U0/tEJBnnBzlUb1mWZaZlpa
 Vwl1zczX8KNGWxq7YXpdTrrya7poqXOVVTxfEMSalbmssiYECMP6sbB/230FkxrWbhpJ
 2IRKQYU/uIS8L4gJdSvFwZan4g0uikQWVh/+bKsBPHVQeW51LLajT6u8+n0tSxkQjSZX
 9CRmDUc4m2nwAuXynddBtWv2DHBvPw8B+Jus+HHvOFAjMnkvNgCJWw1tq2BCWvI8PSLw
 bnOg==
X-Gm-Message-State: AOJu0Yx3XpH91Iu3QK6OMwERYN0Q1LMt4LX4A0U/okDiPWL9BpuAwHtk
 SENanZ5BqUZDX3rKaAWP0i5sz57jeMjh/YRdZ4whN6yrcfEF0cYDzJzzEt87WKv6iizZstEUDPR
 itZUs4g==
X-Google-Smtp-Source: AGHT+IHlPVfecc7fiPE76h0MR6HSOqO12oDVE1DQPpTjCvnpj1YyKAOSd5P4shE34bHJIHaSxMItwQ==
X-Received: by 2002:a05:600c:3591:b0:426:67ad:38e3 with SMTP id
 5b1f17b1804b1-428055040abmr14082165e9.3.1721912324734; 
 Thu, 25 Jul 2024 05:58:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:58:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v5 04/20] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Thu, 25 Jul 2024 14:57:25 +0200
Message-Id: <7498fdd49878a29603e539354dad982a6fd3f049.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

