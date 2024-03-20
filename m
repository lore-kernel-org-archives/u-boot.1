Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD67C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12B688094;
	Wed, 20 Mar 2024 15:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hlf7rzbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF086880A8; Wed, 20 Mar 2024 15:31:35 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA8C880A6
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4146af3ebc8so5951115e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710945088; x=1711549888; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mpjeMUA64QiM2xumTj2IcLENnwtxaUaoBTt/9i25/yw=;
 b=Hlf7rzbnNz/HM8UITXGd2zeH23UXbVKfgsz8+PbFeJp1PonRvSIOCi2XI4zh7+V4cc
 xr05GXao9epwPN0EWcc/ecql3N2EX3NgeSFqH3hA8HpEpvBP+Vt4SP7RT22tl8CEqogA
 L0yUeIEjuuk1oGg80RGrwo+UIn1ycUP4OcsnEG5wvPPgrdUf1C2/TLBWlY/3AM0YyihZ
 YpRSZNiyJSfGXqnPx3UCz8su7EQDzykFF3GvfKN1Pq8XbuV8cJcE9XBQV4OkmH5tpfQM
 1HAbqF2fDZ+xCMTFo9ISr1anJyuyuu9SJ3t5h0h1LUjVCKLQD8M5VHTwgdrb3brwPYvo
 vVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945088; x=1711549888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpjeMUA64QiM2xumTj2IcLENnwtxaUaoBTt/9i25/yw=;
 b=pctavNV+kUvGpjg3xRrOX+/M4paG2ooyBHhxlw61Ifcpz42at33aEFjH0tfaEjzWV7
 1Z1zgv7sGNV7pUSKVSl5RtermedPxw1F+De2LWGGqqR2140ym1MvpFF+/R5f26VNnOFG
 l48cFil/o0to3aON2MaYGNi3QgcjdmquiIkVOMa/HzfZqjBhYtgPIYzvPnoH7OxBiUgM
 7HT/WnGAkax6GFDSKS2Ig0Seacg8JUFrF+VAdnon3CwHqbNHLEbwY6GTw88hOFQAFF8Q
 PhVQMGrIkBqMEQsrz2MPmTJrrdnLnDdO/IgwEm0wUe0qNga+fObMJezDQcSQ0WwPW+8o
 4gUw==
X-Gm-Message-State: AOJu0YwbcFBDnLFjqasBG8cN1Iwh1WDhNZPReqCg0bcSd+C/3NgQqXJ0
 iv3SR9q4wi/ymov0i2tyuT2TOCVK0EUWlBEw+a9f4MT73bO+2qv+O1UO3Y/tuKAJffY7VMInlgm
 y
X-Google-Smtp-Source: AGHT+IGWFEKHAkt8ys5WkGja26bjHniDRAny0oM/zN79xZmqvNVGcmjIJGTHFraX7/vWUYbyjdxoAQ==
X-Received: by 2002:a05:600c:2242:b0:414:a49:131a with SMTP id
 a2-20020a05600c224200b004140a49131amr9366483wmm.23.1710945088338; 
 Wed, 20 Mar 2024 07:31:28 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 az1-20020adfe181000000b0033ed7181fd1sm12036571wrb.62.2024.03.20.07.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:31:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:30:48 +0000
Subject: [PATCH v4 2/5] usb: dwc3: select DM_USB_GADGET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-usb-v4-2-41be480172e1@linaro.org>
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
In-Reply-To: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfn23tlEwOHNK7pTNB4+F09Ul+G4zmFSmLTJjL9fSRJ
 sPqkJMlHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAixycy/LO6P79xidqS+UY1
 M+b43FngeyLjvFS77LOJ76tPnj7LcUiH4X/ISa7OfOaTK/iE5h10vrh69vJ35r5TDB7Wp9ndfMb
 5o3UHAA==
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

