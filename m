Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C911AC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00315880F8;
	Thu, 21 Mar 2024 15:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XaS1nX8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DB9880FC; Thu, 21 Mar 2024 15:56:17 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D7F880FE
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e00b1c2684so8280855ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032973; x=1711637773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wps8uv/k5UQVBa/I0VqzJT2tx2q5k9BLdfIs1HgCOM=;
 b=XaS1nX8Zp4bHnKIx6V9c6Y6/2S4rspC4ePp4eGeuvxHOc/BPJe6EqylHtDsS1CSUXJ
 IzSB+whIGdK0FNUUCGnsHcUne9BF52QXCI6cKRgt4Rf6aQXUtbAlAgLu5LtekuzsTkrg
 kfzqInLIXHO7UUJh+IWb2UbAUdIPvW29zLVeOZ/F5MQb5Ay1MpRZCvWsgynmJE2JwthR
 wrVgRL9lgzGIEDb8cOmzBPxrC+y1kGIAM/sFBaZpA0D1eAKiKlAOgHRVlMx1aRlnEN1F
 fOVj4m0oYmxpByaeazEOoDSC6yFte47Dw8jYsraA8RRONdRG2wNDr06RVWMNVIlJ6IMp
 AisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032973; x=1711637773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wps8uv/k5UQVBa/I0VqzJT2tx2q5k9BLdfIs1HgCOM=;
 b=s3CybFHywxLbpmXcNp5RaXrfrRs1SYGleD0EmL6qST9UKnEluiB7TdMyI0ff+qpsqf
 zUyn2+6rIIhPVYSSdr3ItZWaVBonOouHQT1T10UGcR/N453Hlz8/cTxsanqGn6sPEvIq
 cFcd0l6AxZqzSUN23BQuWVTHcwFeRXHVtPWJoXD/5l0szz1XvciSTJC2Cn0/PsZseiLb
 r+esxfiE96Hebc0Lnj3Iq42FuUyRiaSe3NwghRoJpwjiTHcO8VSOTvy58y86BX0mc5rV
 4jtbX8lhYsvqSEapOXL6J8vH7kWy29qNyvjD2GnivM+zJ93Yq+nxo0BdNecyvbmzYt67
 43jg==
X-Gm-Message-State: AOJu0YxDcb5Oyrusn5SJvxg/oOhM8lUcKsBuwSSzi1y1ENGjnSJ6RlF7
 u5m5kWIeGF2YYve5mtarpOj0CrbH89ETAd5PAMog3lOuVaGZI5jvKV6c4Z1v2fohyIYDdOAmjLR
 F
X-Google-Smtp-Source: AGHT+IGal69B12T6leHN1rGpgWPX6x3uFrpUTyoHXC6ZwBMEca3fOF0qUi3OLH2SAyLz6esfkcXwmA==
X-Received: by 2002:a17:902:a385:b0:1db:f910:98a9 with SMTP id
 x5-20020a170902a38500b001dbf91098a9mr21679003pla.56.1711032972974; 
 Thu, 21 Mar 2024 07:56:12 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:56:12 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 08/11] pcie_imx: Update header to describe it as a legacy
 driver
Date: Thu, 21 Mar 2024 20:25:04 +0530
Message-Id: <20240321145507.619448-9-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
References: <20240321145507.619448-1-sumit.garg@linaro.org>
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

Since now we have the modern pcie_dw_imx.c driver for iMX SoCs,
encourage people to switch to that for any further new iMX SoC support
or even for the older iMX6 SoCs too.

Suggested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pci/pcie_imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
index 4a18b0e0910..78f2c7d6bcd 100644
--- a/drivers/pci/pcie_imx.c
+++ b/drivers/pci/pcie_imx.c
@@ -7,6 +7,14 @@
  * Based on upstream Linux kernel driver:
  * pci-imx6.c:		Sean Cross <xobs@kosagi.com>
  * pcie-designware.c:	Jingoo Han <jg1.han@samsung.com>
+ *
+ * This is a legacy PCIe iMX driver kept to support older iMX6 SoCs. It is
+ * rather tied to quite old port of pcie-designware driver from Linux which
+ * suffices only iMX6 specific needs. But now we have modern PCIe iMX driver
+ * (drivers/pci/pcie_dw_imx.c) utilizing all the common DWC specific bits from
+ * (drivers/pci/pcie_dw_common.*). So you are encouraged to add any further iMX
+ * SoC support there or even better if you posses older iMX6 SoCs then switch
+ * those too in order to have a single modern PCIe iMX driver.
  */
 
 #include <common.h>
-- 
2.34.1

