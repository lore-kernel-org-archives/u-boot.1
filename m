Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08025C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E8887DE6;
	Tue, 12 Mar 2024 08:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mk7QegPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C72687DE3; Tue, 12 Mar 2024 08:04:23 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED54C87F3B
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso3139290a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227057; x=1710831857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oj8qHyuFviHCa6TWR44Xr5I2AslDRMVitg0k3m1MYQ=;
 b=Mk7QegPJTdZYDQ+65YE8e63T8sX4vt8Rtfnu9XYhwaAG82VyGg3OwN5Ayre+04UUC9
 ewYOTxhTFLCO6DMPfihhdDbczK8sNt9Z5B8BmqmAEmyPJuCXPeHcp80ZmjM1tC/7PyK+
 DTbbL2pJxwRnzCawjRiwnAgO0/4fAMdRqZmohOEB7hmGX2Fdb9sJPcJtoYKxKZ00Rlf/
 XrNeBFWaIrUPVsx/CjbAgIE3R9+oi2YRbbJTP8bcQqmoCfGSTK9GmmW7NLoergZNUkW/
 Cnw9IPAvrctUGaD6bHNS7vwC8wr54u3rDi4tIAnrmthKNnt81pLQgZK7bOcCZYB2thys
 sjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227057; x=1710831857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oj8qHyuFviHCa6TWR44Xr5I2AslDRMVitg0k3m1MYQ=;
 b=M382d5eC/o2bPPmmB4x/4pO47CRVKcfMIuglgoyjbKkar7Ilrnmoy1W3wi/BN3bJ98
 HJqGokDWfvtwEBxZgjOzfvmCli3LCuemj95N6STM/Xoy9QTr15gveD3Tf8qIB+zH3746
 mggx/tIT9cRSWGr6AXQt4APCBPJrvaZzVBVDLyUXOzvtaY5QSpAnlJVL76VZcVPS9gR1
 mnwFWayk7eb3FVcfRA7xwx5/SxMFaQWHYBNNUXoF88xrVmUBapQ2fEBWPIhC5miMAMoA
 +6AanrUQaliuVPgJFgjbfCU+94j6E15+QjOYRiulB8/1G7xryVT76jvS9AeHfI2j46Kq
 ETow==
X-Gm-Message-State: AOJu0Yz7OknYxRl0ldTgTl3RG7gbOgJZ4EuajnTeFOt8kmO8cEvii7Q1
 JDMpvg5LBtOx4NU6KhRJaqxEIRsrduxnMrL/Sj4qQIB5TYlj4FW6tVSdZAtCWYWdKUZZwiSNaNT
 o
X-Google-Smtp-Source: AGHT+IEEmB6Ly822SWPdGEeqYMwz3YTlnsAY8ZKsPk3jw7waXcwcZc2rnke7fdKa7rV66DPLW2mFaw==
X-Received: by 2002:a17:902:c947:b0:1dd:8daf:99b2 with SMTP id
 i7-20020a170902c94700b001dd8daf99b2mr6773397pla.13.1710227057081; 
 Tue, 12 Mar 2024 00:04:17 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:16 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
Date: Tue, 12 Mar 2024 12:33:31 +0530
Message-Id: <20240312070338.86127-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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

power_domain_on/off() isn't refcounted and power domain bus shouldn't be
turned off for a single peripheral domain as it would negatively affect
other peripheral domains. So lets just skip turning off bus power
domain.

Fixes: 898e7610c62a ("imx: power-domain: Add i.MX8MP HSIOMIX driver")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index e2d772c5ec7..448746432a2 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -50,7 +50,7 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 
 	ret = power_domain_on(domain);
 	if (ret)
-		goto err_pd;
+		return ret;
 
 	ret = clk_enable(&priv->clk_usb);
 	if (ret)
@@ -63,8 +63,6 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 
 err_clk:
 	power_domain_off(domain);
-err_pd:
-	power_domain_off(&priv->pd_bus);
 	return ret;
 }
 
@@ -85,8 +83,6 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
 	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2)
 		power_domain_off(&priv->pd_usb_phy2);
 
-	power_domain_off(&priv->pd_bus);
-
 	return 0;
 }
 
-- 
2.34.1

