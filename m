Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95F0C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F0087FF1;
	Fri, 15 Mar 2024 16:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="we+cU4Lh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559FF88003; Fri, 15 Mar 2024 16:06:14 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D164888004
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-414008713beso4908955e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515168; x=1711119968; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cnrSRMGhccGbRZbFvxipCAyufaiPSD/lfhCstPEB5Ls=;
 b=we+cU4LhTuFGEClJ75KlzxgsRFDA0RzEzjQQysSWu1hCijBEKaJcVRVgr38MvjoHZC
 9L/tDoNXeO2jr5EL6/cK2KqJDYtuiduHcmFeTzg8NweEF+n3p2sgDzvoQoNL7IZAjyuc
 zBmpgqaFRItbfc8hA+0L8YFwCxvAtvQ4virnTYPD+JlATd+wwtB+XvctU9fROgzPx3Kt
 kzP3zfi16+Jn6cOSE6bDd9hGj/SO5zof08O4yy26otiozl3F3kouAOCnV6R32Cokxtzh
 iSJt69fW2KPT/7BorG8TFNd0Ens4HVUKIAaSzO98QtujX3avrcVX47ljRGMQtqTEWmN9
 50cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515168; x=1711119968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnrSRMGhccGbRZbFvxipCAyufaiPSD/lfhCstPEB5Ls=;
 b=UjQdLM9CeCuyJCfblQl0AVROCZ4TRprF1/PwdMkX/UX45LPV0KBZNdCczYCxR6hNzb
 1vQ6bLZiBBB80fE4bWtoWlK6003RKgD5GwupF+HbQKrclRQP1HQc3mSBcgX6+3qRhmb+
 0K28DvytY12/jJCwf3oCDRtKzQstRsB5rbGH5Um/Bymb1t6kvAe2FEhgRjWbmEEuagHw
 Ep1MCSeKKUJcVilxjPsAmLw2h0K+Gk1DzqA+aBp1xbiJAweIfCrN0WRkHrRDMeLUKpx7
 eiV4pkhfPdaOsey4SEixR5z+6AW0f4+DcbIlRbuHGFXVTJR4fr8bd8Zusg1oZQp1IJTj
 FUKg==
X-Gm-Message-State: AOJu0Yx7Bl2djTbudsPSn1HZ7O7xH0EKYRXv3WtYjp2nfidBf0/ZSVGc
 4qWNIAGDVoOcFGkWePBlukyJMxaBy1KNruV2LfEuYRyhvsu2N9t1fzuR3ZB1Snc=
X-Google-Smtp-Source: AGHT+IEriPhAebo5bWmX0BLke29eA38Izu8SWbylPuxNVBhdyQQVufwQ3NJHbstIwCB9yNbj2h8ZPw==
X-Received: by 2002:a05:600c:444b:b0:413:f276:1123 with SMTP id
 v11-20020a05600c444b00b00413f2761123mr3523966wmn.35.1710515168357; 
 Fri, 15 Mar 2024 08:06:08 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 jg28-20020a05600ca01c00b0041401fbe446sm1939502wmb.11.2024.03.15.08.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:06:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:06:01 +0000
Subject: [PATCH v2 2/5] usb: dwc3: select DM_USB_GADGET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-usb-v2-2-5467ec27cb26@linaro.org>
References: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
In-Reply-To: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=777;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=FFtOCdyc7kFWeNXYCi6LiWr/yQ+G2PLU3dzzfBLIqOM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvyXd9p0ka/L+UoDzvwtnwB28ihE9lFZ0pTM68/FBp1
 uMvB3MWd5SyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJHD3J8IcnsmlBYdh6lV9C
 yVXcD6Y/ffLmRG75FZPfFx7LNnpWs3ky/BX/skymuYTzw/EXP8yYjjRs7NVedsjtxqXC21cS7mb
 88xMHAA==
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

