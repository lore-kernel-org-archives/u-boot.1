Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A5CF4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2776842ED;
	Fri, 17 Apr 2026 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KIHkVFxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7038A84105; Thu, 16 Apr 2026 17:38:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B84A84105
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so5652921f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776353933; x=1776958733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnhK6VVl+qDn/OgvD1N+rAHS6ZKS98nwH2lorpKhQAM=;
 b=KIHkVFxxjAPFROtVgiLrY3Z9gTNkXtArKNnbRFY3uOV0UbPBxe82VNO28ItlV22ywB
 zqGigJkA1uGWPBcnPA0RZyVzHo1sMh6zohFcgfbOoYRMcmH+J162GLOGP+d/oNdGXomE
 7O9NLtsuuJrMKz5bvPlxbER/znhX740EiuSa7EleEF4KsN2W2GMZMFHh6wxswxTvFeV+
 3CODVcFZ+5lRTc7sxV6n/WIHfFrHgnUFGUhomV6CZ+AEbmk+g3C87nBNCfTnO7z11DFm
 yZzm4Sx8G0eOVfrXLLMCt3scoRo2m0N9Cpuzcup7bb25ikqLFj1P9XjPL77C398T1hLs
 0yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776353933; x=1776958733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gnhK6VVl+qDn/OgvD1N+rAHS6ZKS98nwH2lorpKhQAM=;
 b=JeabAg22jA+UOLMJWg6y9BylLpNtYaUAfdQBhABj15zlpEiVAcmqRg45pNpJOPIaID
 NSND3GkGYiBngQczoA8PbX6Pz4z4YjmXad865POP3Jy/xwGabhnp4mFxyp2sYwciisNP
 XQqT3Oy1uREh1ymlNyvXQG+5Uaxrrc4k5iaswlwg5Ge40QO6wpEMFoBH+ko2diccUmFi
 UzKhNlko7OcF0dl8aNS5Sy/evmqmEgMtzgFmeukuxSVe5Khr9QaugiKt5gUmRQJyRf+r
 CDA8GXm11JMpb/+uL83Xd0LOyVmwkl3GAQOr83wAR+Jr4GcCZyOpq/Yz4Q8pVQoF/kgC
 QLyQ==
X-Gm-Message-State: AOJu0Yw1ZLbwmL1Qod2HxMPLFdyetpdlZrzUAmh7Ijd2FcHyQwPMwd/K
 L6i4+vVPeFAAd0+w+m8B5ViXs0nslok/xqStCwFpc5+ofUSnR0Ss/Sz8hNDY11Xb
X-Gm-Gg: AeBDieszQu+DlwiSONKiuwg2CROHdXRRm6Ant6NYQkGySqJI+ppi5Uu6TysWKOTv4HU
 tRMoW8GcTrDbwBWbwPosulNMaUnOKcSv6gPsM18hZzz7BStTJS7uLqcid9RJNqjaqzThAVbgEuX
 f72MjhPapwkUuiEqvZX4508ZYmWQHcykWmDuPtIx5V/TX9wGPj+g6BDk0KJJE6jK06BVfEYT8Eb
 hC1a6lxgMgoc5mjByAE3uqP1nk5sd5x59xjeasvgR67fHRAx42eqPIrIOZ2ei2By+5W/eR5rwSd
 Cq9X11/N1bwV6VcJ/7YWpOdNsl82JvsRtEeWHpn0P/rWsXOSq2UdxGRksaMKEBCTbpnCL4AOt23
 NfkueQ2HQmISHrwPFAZXdcvS7cpZzZNTmw+tjd03hh/Gw0LuQ4QCc2nTm5gg4beqiIhM1pqQfnz
 V3r/V1De6KEzfP/9fxOFB8daMtYehAtyCpi9lozcAOGMHQheZgvl8=
X-Received: by 2002:a05:6000:4211:b0:43d:7275:c1eb with SMTP id
 ffacd0b85a97d-43d7275c413mr28179714f8f.39.1776353932677; 
 Thu, 16 Apr 2026 08:38:52 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm15663463f8f.18.2026.04.16.08.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:38:51 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v3 1/2] regulator: rzg2l: implement connectivity notification
Date: Thu, 16 Apr 2026 17:38:26 +0200
Message-Id: <20260416153827.14256-2-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416153827.14256-1-micbis.openwrt@gmail.com>
References: <20260416153827.14256-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Implement CON_CTRL manual connectivity notification.
By setting SEL_CONNECT and CONNECT_1, the UTM+ core is notified of
connection status in peripheral mode.

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/power/regulator/rzg2l-usbphy-regulator.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/regulator/rzg2l-usbphy-regulator.c b/drivers/power/regulator/rzg2l-usbphy-regulator.c
index 0354555d0b5..03f8dec4f08 100644
--- a/drivers/power/regulator/rzg2l-usbphy-regulator.c
+++ b/drivers/power/regulator/rzg2l-usbphy-regulator.c
@@ -9,16 +9,22 @@
 #include <renesas/rzg2l-usbphy.h>
 
 #define VBENCTL			0x03c
+#define CON_CTRL		0x020
 #define VBENCTL_VBUS_SEL	BIT(0)
+#define SEL_CONNECT		BIT(4)
+#define CONNECT_1		BIT(0)
 
 static int rzg2l_usbphy_regulator_set_enable(struct udevice *dev, bool enable)
 {
 	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
 
-	if (enable)
+	if (enable) {
 		clrbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
-	else
+		setbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
+	} else {
 		setbits_le32(priv->regs + VBENCTL, VBENCTL_VBUS_SEL);
+		clrbits_le32(priv->regs + CON_CTRL, SEL_CONNECT | CONNECT_1);
+	}
 
 	return 0;
 }
-- 
2.34.1

