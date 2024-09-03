Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7482BCD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B879C88D16;
	Tue,  3 Sep 2024 10:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UnnFo9Np";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 014E588CED; Tue,  3 Sep 2024 10:39:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1239788CFA
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-375e5c12042so333894f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352739; x=1725957539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCjcDCoXb5oyRDUvYeiyUQT0buhWu2O71HdCxslK+58=;
 b=UnnFo9NpulXO6SUPPzXJ9mFx4U8RW2tXvVfdV0dm4fweUVy3Hqw917Vud1rx/wPOdf
 lCYKQ937DFnv82nM0wseGmxx+by8m8JRVVHRH8pXICT2lBaf18szF2/qmaN8SX0D+If0
 OFG5yVrlCAJQHoXJ0i+rHYa6bk+dJ6b3nj8s5OQ+kY1eqPR+95pnsk4UNlI/9Yil+giv
 npjEcGNbVNUE1IoLe5GINT6JKlLTfgRrKji+RNvhOTigzRgXyd5EuVNSkSkSM4yX881f
 uWtYj65C/VhgVLfh5+3Sj39pwvsygiKxxa0RFirJzYOJ2OyEJFlonyJBxEfRkeIBa3gP
 AI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352739; x=1725957539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCjcDCoXb5oyRDUvYeiyUQT0buhWu2O71HdCxslK+58=;
 b=sFPDQLvcUja0cLa25nB+aUnlRGmvUl0IMwsgqcGAbGV+g2IgpAoF14h1IX1W1Mu5d9
 waRzLG190Sfqmm2Bb7JnVL/nW/EjvZqS5yj/cOZjFy0bs94M11hZT/oU/ba9Dk6R7EVG
 zwzqwhN5skBeTK6KTDm2SLnxaPrGliwHP+tA4ITE1ljxe1l8y4ViePIVfL5RpzpRY/tG
 /6m/D/GwiqoSTIUhUYvAtBdIncpkkFA0K8BPsEUokbWrOY4W/oFgMF8CerLEhAewZ4WO
 bsDDzOIcjQPuvezeALSSi0jAqwHQsQ35JbdX29k4y04DLoR+vBN6uRYhpqxmj0WWP0RC
 CKMQ==
X-Gm-Message-State: AOJu0YyVQ/mB45AZZbpoDZjjvdXjvrwzfQML5G4lNquulzPWj0E6cEPg
 QQetHPrldP60tmumFKZ/ylZZclJAdMwLpgvtMS0Ac7qaNkeo0lnC1s21Lu0BasPDVqQgxn60zAe
 58EzxHA==
X-Google-Smtp-Source: AGHT+IEEIMSWPOfoTaBuueg2jkR10dbk0o2poKxA0n4TtQDDxCbe4oXHcbM6D+/b4SY82kW/ywihGQ==
X-Received: by 2002:a05:6000:1564:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-374ecc8f13cmr2058695f8f.14.1725352739257; 
 Tue, 03 Sep 2024 01:38:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 11/16] net: fec_mxc_init(): do not ignore return status of
 fec_open()
Date: Tue,  3 Sep 2024 10:38:08 +0200
Message-Id: <f4936e5e1579b7d0ffaaece66acf8d3794eda3ef.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

