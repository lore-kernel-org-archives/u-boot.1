Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043FC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B184C84673;
	Thu,  7 Aug 2025 18:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G0tZ53zy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D74F84669; Thu,  7 Aug 2025 18:35:27 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A63083C2F
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7848df30cso1245783f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584524; x=1755189324; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3qorVhdnewt6HPBp1f+HiNakVbRMPMXF7DytVZBZFAI=;
 b=G0tZ53zyCoaHTSARA/0dqqUVMSukGh5KhCDkymLMHJTZJ6SX/xZw6dL7Af4IglyY9N
 B8RrYw0YIy5DD/3Z23hkSSqnelLsNIhDQO3A7xadkX2FbYa9CLlt53ZC/4Efbl632aau
 sryl9I5y/fMcjjOJgz5ZIn8ulWPoH3ouA1CkIcwMlOrZp5/81Y93cTfJ0ruSUIsDk+gm
 q8e0+YnTcgsKwCnfFv0dmt+T8Xz5VKrWY1WVmnWvOzRo86UcT59kYqWPZzoptF7C3u4Y
 cUqJu4rtGIXnn/Pr0EOql/ZPjzf75TvdaaX+Lqa7oUM8nG7xroDoQgWlUiaPtldVOUAN
 OAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584524; x=1755189324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qorVhdnewt6HPBp1f+HiNakVbRMPMXF7DytVZBZFAI=;
 b=RA+j1Ei6B6dzf/aVtOSYZMuRu/G4+HzcDCmAbQ004gb+dFG5KL3+iW3ZdUWQWw7ali
 FP3qJ3S4MVP6BJUmg7GIhl3S7yAC0kKqouH830wk+BbVmWpa1dYYt1N5nK+6Ms6vgdNX
 Yr6xycg5E5EmOnMxReDn75TCOr/KpGHsQCLD4tjR0HINxQdztTBUKvSI7q72Cw2afSKq
 duGxtgMpogvewV3QzA0RCvxf2iHtnP6n4GRh1k6em1qkHq4YU4OKQn17oDDc/k4eIaDM
 bs5I+ljFnYXcO7OOdpXV+h0EBfNssgIapVFe4LSKIfcPxIWazU3hgCR8D5iuKLEyRfFQ
 8eOA==
X-Gm-Message-State: AOJu0YxP0fEAhnOy4pglaXc3/F43l3J4zCPRdGGiJpNbtByPes0F/hTO
 jYsJ1zZNYT7/3TypssopCGOnnTruJSJcitreQmEPUPC1jH6BvdK3I9BUem0biCKvt6U=
X-Gm-Gg: ASbGncs0mqxwEvfHeMmJbuNZF8y5JmFgH3RPopb3qx4pkjt95c98T77+HORNfTn0Yln
 BanG4WlwJ6BuyU3YfoNml/c1KHCLaJOm0haY7c48uG41K5enroC+i3qb7phrNszLbxhRAqOK4q8
 MW0a0xUDWQ3t8dQPqZrmZusCDVJcf3zZhjKjkkeniFP8bIA4YeJ2iURfuK0QZveFpGMUaPliTtH
 LdM4FcjzVVxkZE22Z35fUE+2VL+0qOuFWm009GJzKom/dqYauZ5YypamWWDK0gc94QOzTR1qPEV
 XXVxdDJffRLZVoI7Za4e6gR6iAU/3XG7M8Vcb+Thp/B1fL6Vl4az6CTeLW+oApAwI5yOCbmnoBc
 +z8Dlarh5AbnTLWhGQpWIEJe5pwCDe+9iR5vaZNkH+WDhTqA3AO4=
X-Google-Smtp-Source: AGHT+IFPrBXfvn5p9BTt6xBl8mRHNnx/RVD841l8FcXBJJeUNVlKOgzabgW3/M2Z9deNPop5/MAlbA==
X-Received: by 2002:a05:6000:2c01:b0:3a5:8991:64b7 with SMTP id
 ffacd0b85a97d-3b8f97f50c7mr4309013f8f.26.1754584524448; 
 Thu, 07 Aug 2025 09:35:24 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:23 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 17:35:21 +0100
Subject: [PATCH 4/6] power: regulator: rzg2l-usbphy: Add parenthesis to
 return expression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pwr_regulator-v1-4-42a4105336ec@linaro.org>
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
In-Reply-To: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In order to get the expected result from
rzg2l_usbphy_regulator_get_enable the return expression needs
parenthesis so that the binary and is performed before the double
logical not.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/rzg2l-usbphy-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/rzg2l-usbphy-regulator.c b/drivers/power/regulator/rzg2l-usbphy-regulator.c
index 451f04c140e..0354555d0b5 100644
--- a/drivers/power/regulator/rzg2l-usbphy-regulator.c
+++ b/drivers/power/regulator/rzg2l-usbphy-regulator.c
@@ -27,7 +27,7 @@ static int rzg2l_usbphy_regulator_get_enable(struct udevice *dev)
 {
 	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev->parent);
 
-	return !!readl(priv->regs + VBENCTL) & VBENCTL_VBUS_SEL;
+	return !!(readl(priv->regs + VBENCTL) & VBENCTL_VBUS_SEL);
 }
 
 static const struct dm_regulator_ops rzg2l_usbphy_regulator_ops = {

-- 
2.39.5

