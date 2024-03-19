Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4798BC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB15C87FF1;
	Tue, 19 Mar 2024 13:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W2/XgfLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF8F8802B; Tue, 19 Mar 2024 13:14:45 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FFD87FF1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33ec7e1d542so2988458f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850482; x=1711455282; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mpjeMUA64QiM2xumTj2IcLENnwtxaUaoBTt/9i25/yw=;
 b=W2/XgfLl7jQ9ZJJYpAOg+StAtyqDuKrk6+1HMIZW43xvaTmZcdVJi2m/m/SDuV7ZuV
 PmkBNR9F5yDS1EnFfSl6V1a81ad1ZZDG2g9UZAdO/2ElxJbvk7R5VrkC0oo5obT91wnP
 HZfB3cIrHbtYdT7C20OupLCmSeGo1h/1Z1EB6HgRfdVb/Q6sSJfS7BSuhndqrhZSDgQ4
 uzxV9NHJf4HDOglDLnreQHHzLw4Nlu2fsOUCwQdyjljy9RHSPGEzqMzi7WJ8gEBx4bfq
 sPWdfLaTCyhiizdnf8+cnIXdJCZdKU7wJjguYPWyHlPdQAn+c9wwLUUF06ra5IoIAfE+
 R+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850482; x=1711455282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpjeMUA64QiM2xumTj2IcLENnwtxaUaoBTt/9i25/yw=;
 b=BWmyQ2lczoTg2qnOLNpxey++Xe0xKpnARTCqC9XKN91fU0whwBqeq0hmt3jFQiC2CP
 LB2u3bMlUVN94AOqbjHNkS0dNnNAgEWH7PklkpZb/jLDGnW6s+Afg9RSBiLazuVLVBfE
 yHD1hjFgWFM5UYR8hHcyfEcMrf0RQL9g94hwvdev4txcV7NmlBnFrHV65ph5GVTWuA1Z
 4iX4ZFBYorc8R+wLzf0R8iHIGvxfqqhH2PontUFqqLDAaXtiJyC4pB9yHO2fohMQpCqD
 ZwP64Gto/xDnwdV1D4amkrpUx99+V37IVQNlLJgwQ3ZE8Hopug2E7+t306Mp7LCdLOX7
 0Egg==
X-Gm-Message-State: AOJu0YxvR1JrTtB8lfSS6hc6eQCfdv2qD/sG4Ll0hZA4HNh/UWdHMjxz
 kauFCGxt96RMM9jDSrqAK8DXD6/4wm8qyu6f4PkPEHPUc6+RIIN92Xz+fQPhEEA=
X-Google-Smtp-Source: AGHT+IH8AQuY4ecymNQ6j8ZigH97YrcLZe/TNq+bsiWbB5e5nFKxkXqF/67R9SVgwSiqTwYQHX+ujA==
X-Received: by 2002:a5d:5f94:0:b0:33e:6760:6def with SMTP id
 dr20-20020a5d5f94000000b0033e67606defmr2177774wrb.56.1710850482573; 
 Tue, 19 Mar 2024 05:14:42 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm12345792wrq.7.2024.03.19.05.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:14:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:14:25 +0000
Subject: [PATCH v3 2/5] usb: dwc3: select DM_USB_GADGET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-usb-v3-2-09ba1f86d259@linaro.org>
References: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
In-Reply-To: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zgAPVW9qDed342mDNE8anMwCvoGIxZpCW8smqhdbBBw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfjes/fG4s8+lW3hjNX9S3e6HTk4p8+86psbyxORvWb
 mfd8uhyRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI6UyG/3FiwoaSDn5zdEI/
 sn6Y6H7kyV9W4yMuIQsEL8YYVTrty2H4Z/H3q/zlupTLjJtt/68zY+3r8a7U+zrffnPvqeTfbNl
 TcgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

DWC3 platforms depend on DM_USB_GADGET for gadget drivers to work,
otherwise compilation fails due to no implementation of
dm_usb_gadget_handle_interrupts().

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index c0c8c16fd9c2..8a70bc682322 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -10,8 +10,9 @@ if USB_DWC3
 config USB_DWC3_GADGET
 	bool "USB Gadget support for DWC3"
 	default y
 	depends on USB_GADGET
+	select DM_USB_GADGET
 	select USB_GADGET_DUALSPEED
 
 comment "Platform Glue Driver Support"
 

-- 
2.44.0

