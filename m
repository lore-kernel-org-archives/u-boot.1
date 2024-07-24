Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF7FC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1663088929;
	Wed, 24 Jul 2024 17:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LHdxdO1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E308818B; Wed, 24 Jul 2024 17:48:21 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1749088929
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368313809a4so684261f8f.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721836097; x=1722440897; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5GUX+/hleNqxcTaZXAgRavQAAtag56nexX+KTS2glto=;
 b=LHdxdO1u5froPAdJ3KsDFx+8oJDvWladhvz+OXzj8lB4mN/DcmQqtcr2lFeb5Fm9BW
 4LX70NJLvkMcd8Oj+0gECIXt4ggYlC/zmxiEs2ufAUkY4bHA/ny1iJvBtchFGEszBicr
 8yJUyWck20opNlmskHQpnsHM2pRlzjZ6RyMwTbmSiEJZO7j012FzAX6GsIKvockIccB5
 tPcq8u1fbIWUZAG0z6f2nCHXTfeqazc0IP/GZjnUr4xu/j1Bl7k7ZEHGKKvFpSan1uNh
 fjESpz5xklvmSeDmkxLyjDoFkNQgxAyTwIrcWVQY4UnxVxwAsANNx2WaAlRzFMfeBj3L
 wSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721836097; x=1722440897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GUX+/hleNqxcTaZXAgRavQAAtag56nexX+KTS2glto=;
 b=XzZNnA3IFjn007fPEs1mQixhelbDpm+arU08uCp6BudjUvmh3MQ9YFD63D0eKfVh1W
 N/1QS2rDYWr9PjuBvNyc/cR1m6y7V/FfBhCbxkJPsESZhQz0bGE9KLkCpmm9laOq0HZA
 Hv10EpCbMuCFyUHwvZnwGSpNVKJhTq9tTfNZ0WAlKEy6gtsjpacVlZVcGWdbhtusAF0K
 C1W9c9lCuQKA3SMh1jdeJ/pSSIbOU6WMHIlszGV+S2jjm6Jo1rIK39YENzIZ+78HQ8/y
 ZaCo+Q4/cKr1E+RzqmbJidl7awdo82yXliPPkDlZqloK6Xk3iGbYSR1fihx5FZ1nmTzD
 bFAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqSQ/RjBn1ZsPMctdGWhkSH02mUKfJfi+lZsx4wsZhDo1V38f9sOWrRoK572JorSu8jUI2YGyJB9C1pTKwQziKgW/HXQ==
X-Gm-Message-State: AOJu0Yy1q0im30+8fO/+N+4LRscg+tifXrD55HHUhEj3CITEGwVsrRmT
 z3PvqHPd4nKui+/q3HhGVHlL5jZ98ZxWYU7VSbdodVKKQI5qHnIT4Ky1HDr1zqs=
X-Google-Smtp-Source: AGHT+IG2iXBWk+nZ8BGFrxHAYXADxosd8xitOS3rVYbr7b0NT/oPy0f8IeiPxWp15I77jp5rpFZ6UA==
X-Received: by 2002:adf:f9c5:0:b0:366:df35:b64f with SMTP id
 ffacd0b85a97d-369f6667e81mr1923295f8f.4.1721836097389; 
 Wed, 24 Jul 2024 08:48:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93aabdasm33633015e9.36.2024.07.24.08.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:48:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 24 Jul 2024 17:48:10 +0200
Subject: [PATCH v2 2/3] usb: dwc3: fix dcache flush range calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-2-65836d699a71@linaro.org>
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
In-Reply-To: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=srY3udycfvqYMAFtZZ11qUpBrqT3tgodDPaWL7DnMTs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmoSI8fsFRKV70il9VEJqdZNr1wcJolgjcgpszJhKZ
 +OXeJhaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZqEiPAAKCRB33NvayMhJ0Vt0D/
 0eq6hnxu9FDrX1Y1nlW0a0Z0k2e6o24IWb9IwzyNBoTQATaQGd6rIVn8oYQne7AndiTJP2qi3pmVyW
 1a5hrwHXQ9tcS2vcw5xibG/NZEfNKtN/7pycBhMRgAPScpEdffDNcPN+AWaXZ10ose3gXy489HXN4m
 JDQK2K3c+Ku77XcbO3yjXaibxux0Qs/o0Kc3nwMAI43bFD9HT8uW84rgfrcVeFx/4mAc9trC1lcXk1
 nHfooUQ0uZxF4//I9BccyK+V023LBwB5sXY2XXznjGS92Tm/wtGiCyLiwp/n5xER7nvHkLUJ72r833
 4U4EuDRoanRkUDpQqxcBh9UCPod4rd2uSzteobjh9JdUl0S3vS86WPB9b0I4i1/Kijo5qezZlmOGKw
 memsoQcPaRFycidZaXp81uusNbiOV3IaepqGUbxBVI9pustDD3w5o+ec5qvJ0SRw1DsNBzyC96MQUQ
 OvMWK7xtL7JR6/Y1jvyhcREt6SF4X+5Ec7WCrxgJBwYnQnu28My3Qo5ppfgFKfqcyOokHnA17IfNB2
 615gouZaRf0AhpQG12+Fjh2pWd0K8RZI/idx6xAocUu+9Fi0QozZCMvUNPQj+8AYxuL32cmi2epIKw
 VQs/iCoSxXvkZ4AR1Jo7LR7uF4L68XZRurkJyVi+mAMsDnylNsg/CpsqW9MA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The current flush operation will omit doing a flush/invalidate on
the first and last bytes if the base address and size are not aligned
with DMA_MINALIGN.

This causes operation failures Qualcomm platforms.

Take in account the alignment and size of the buffer and also
flush the previous and last cacheline.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/io.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 04791d4c9be..1aaf5413c6d 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 
 static inline void dwc3_flush_cache(uintptr_t addr, int length)
 {
-	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start_addr, end_addr);
 }
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

