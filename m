Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605AEC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 10:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9E3867F7;
	Fri, 25 Aug 2023 12:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="KcVzZ+z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7322F867F7; Fri, 25 Aug 2023 12:43:10 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC718681D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50078e52537so1135042e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692960186; x=1693564986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nx3Ir95vsspcS93KA6dd59EJxbUpConhD04moMvlaDM=;
 b=KcVzZ+z8lRKwp7FX7ZJ2W4e0M4792WOlJeM+op5g1M0GBZ0t6xWf69iVBIPXEBB6Nm
 Q3qdiofu3FwZeyDXFf8X1Y83Kn9HZVe39kABnmZfX255ec0AYuzo5bBCTxhzqzPD9f+p
 1GJOckuqPETjaHV4xPBZtTBtzfhOor7WWwvhr8fFbS7TmKJFjTnvI+2kFUg5f08pUB6Q
 JJOwJ43DO7W/yNREr0r4AG9c2WMG8Xet/Z0ooj3YBnj7p1o5YKWCYe72lbhtl2NDhM0H
 QLMeC+bY7ALNnyMfIiHaPupHsO3xPmY8YwQMbqN+bkg+WZyuQxVQ+ypH8gg+oguXhlv9
 AVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960186; x=1693564986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nx3Ir95vsspcS93KA6dd59EJxbUpConhD04moMvlaDM=;
 b=GsyC31jZTLm2hgr5wpbfRZNsGfIsdzPSTjlvbjpw1hiPyNERq7gaTf/WIBfYgOfVtr
 LVzJ3Lj6Czg9PC8mHUqubwO5BGLIRmeBMVVq/xJOIOsD/PaKHQL/V1AafSFSEdy2FkJI
 FSKY1+EtBwEgK18UEZv0RHbjm0uJ30m7Ts01z2MXl1fKyAgwb+AJ/VQsfwtHd4R7nGM8
 LfGdGB5udZZznaB1HxoNwn2uU73wSjuJoFf7EbgHpoowgXZjYxtND9+VUdHgudCJFceZ
 R+nnlJparHhEJE7hbu5/EdBxaXRmUnQGveDyG2XyoRqScSb6J2OHDaRMKpngMSxpOZoe
 F12Q==
X-Gm-Message-State: AOJu0YyX/UJ/JvaSAlJAoUC5RKWixSENJDlr9P2K/u0prQTZJz7opQdY
 2fyh6ovvesq9XpuXoEP8MKTfcSEjtqZAtzsbqA4=
X-Google-Smtp-Source: AGHT+IHGHyArTcSpIMe5qlrSUkoDPBcg8NiLRmPhdeSTm6ZmXutGZ1MUBWkFqxDvIrzClPem/HvzVA==
X-Received: by 2002:a05:6512:ea4:b0:4fb:8c52:611 with SMTP id
 bi36-20020a0565120ea400b004fb8c520611mr17356267lfb.38.1692960185722; 
 Fri, 25 Aug 2023 03:43:05 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 e17-20020ac25471000000b004ff71ecaebcsm238359lfn.268.2023.08.25.03.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:43:05 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Marek Vasut <marex@denx.de>, Michael Walle <michael@walle.cc>,
 Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v3 2/2] usb: dwc3: Fix enabling USB_DR_MODE_HOST
Date: Fri, 25 Aug 2023 13:42:40 +0300
Message-ID: <20230825104251.28311-2-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825104251.28311-1-oleksandr.suvorov@foundries.io>
References: <20230825104251.28311-1-oleksandr.suvorov@foundries.io>
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

The original logic always enables USB_DR_MODE_HOST operation mode in
dwc3_layerscape_bind() in u-boot. Prevent choosing USB_DR_MODE_HOST
operation mode if USB_HOST is not enabled.

Fixes: 2b0b51d0bed ("usb: dwc3: add layerscape support")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

Changes in v3:
- fix original logic of choosing a host operation mode

Changes in v2:
- shrink the code using CONFIG_IS_ENABLED()

 drivers/usb/dwc3/dwc3-layerscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index 58baa017ad1..c32df2396d7 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -193,7 +193,7 @@ static int dwc3_layerscape_bind(struct udevice *dev)
 		driver = "dwc3-layerscape-peripheral";
 		break;
 #endif
-#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(USB_HOST)
 	case USB_DR_MODE_HOST:
 		dev_dbg(dev, "Using host mode\n");
 		driver = "dwc3-layerscape-host";
-- 
2.41.0

