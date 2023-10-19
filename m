Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E7DCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 12:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019DE87028;
	Thu, 19 Oct 2023 14:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ehjF+5ZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92818702D; Thu, 19 Oct 2023 14:37:01 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA4487028
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9d132d92cso19016435ad.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697719018; x=1698323818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9O8um212shELbPBDFh8MqdzYBKWWoCjbp9aD82tXV6U=;
 b=ehjF+5ZTE11/2ZrRlD6hottAWEvtLVWWhxh6jmFSgpvZC9UtooJdrhuKUIP807aewX
 98wgPvGRl9+O/dTOapoEu81EGefhbxx2KaNHcCSYubZOkohJlZn8+3NdmtzQDTLqpjxU
 SF00JlrcZwqzB2M1IYv2XqtCmyX0bMbJ3xamGxXaY8Avj3v1fpzBcAkDUNUdFW7AT/AW
 H3WyATvoTCKhOBBGrSQlA9PU/gHjLocSOnvERieNCz3wOiiMxpIbRgcYXogcBqZFFs/e
 dcPf8fTM9tIEfo7WPVDg7btvkaxmIZOHCPGVg3Mn4fL+HznhthQswAYTPFeBWJgibzwV
 EEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697719018; x=1698323818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9O8um212shELbPBDFh8MqdzYBKWWoCjbp9aD82tXV6U=;
 b=ddJ9+5iqYGvp/b6Gxv6G2JGfGdoPLbgpvv/xzJsWKNeuWS73p8tLWjDRxmMGAReQr3
 UZrPKTqoC56qU1SPL7FWdzqP3tV0d8rwSayL4Dn4YvG3FVT4HBNjwiLEAl4aR1tT/egC
 8s+Z0Xw39NEy5g6YszvxBSpXizSvzZJrFgga+gIbxtEx7VRWmL+SR2m/VYR4Aylu3NXc
 uAO6/JAcRKOX6EJutKBm/SaVvyDBLvlMnzEvZdOiKlTJ5jTL0sjrCIfUnsv4NogPkX7G
 W8I6oNn8M3ZwefD+As9RzEkYYpRtTQx0aRra8fjbMOw2nuiE/b3yNLlOsbnAB65UKEPR
 1w6Q==
X-Gm-Message-State: AOJu0Yw3qfV9UW7C1TqFHUxrXqF8FZpSnkWnQurhSMEi2U3x8pi+nD+L
 E7S1LTYjvLyoDZK8FNm7QvM=
X-Google-Smtp-Source: AGHT+IEP/1AjbNeNdYmAPyu+89DlI4z0cYn4gAe9UowbwdM6gKU/7hjn2jwR2JmMhXGSGksGPfOe+w==
X-Received: by 2002:a17:903:244a:b0:1c6:9312:187 with SMTP id
 l10-20020a170903244a00b001c693120187mr2102619pls.3.1697719017586; 
 Thu, 19 Oct 2023 05:36:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001c74df14e6fsm1820978plg.284.2023.10.19.05.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:36:57 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, marex@denx.de,
 tharvey@gateworks.com, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] phy: phy-imx8mq-usb: Remove .exit operation
Date: Thu, 19 Oct 2023 09:36:09 -0300
Message-Id: <20231019123609.1489768-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Currently, when running "ums 0 mmc 2" and breaking it via
CTRL + C, the following message is seen:

u-boot=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1dacc00
CTRL+C - Operation aborted
clk usb_phy_root_clk already disabled

The USB PHY clock is disabled twice: first it gets disabled
inside imx8mq_usb_phy_power_off(), then it is disabled again
inside imx8mq_usb_phy_exit().

Let the USB PHY clock be disabled only once inside
imx8mq_usb_phy_power_off() by removing the .exit operation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/phy/phy-imx8mq-usb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/phy/phy-imx8mq-usb.c b/drivers/phy/phy-imx8mq-usb.c
index b660eadecf1c..e5e96e77a681 100644
--- a/drivers/phy/phy-imx8mq-usb.c
+++ b/drivers/phy/phy-imx8mq-usb.c
@@ -231,16 +231,10 @@ static int imx8mq_usb_phy_power_off(struct phy *usb_phy)
 	return 0;
 }
 
-static int imx8mq_usb_phy_exit(struct phy *usb_phy)
-{
-	return imx8mq_usb_phy_power_off(usb_phy);
-}
-
 struct phy_ops imx8mq_usb_phy_ops = {
 	.init = imx8mpq_usb_phy_init,
 	.power_on = imx8mq_usb_phy_power_on,
 	.power_off = imx8mq_usb_phy_power_off,
-	.exit = imx8mq_usb_phy_exit,
 };
 
 int imx8mq_usb_phy_probe(struct udevice *dev)
-- 
2.34.1

