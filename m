Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0AAC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E98580805;
	Wed, 22 Jan 2025 17:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KwwK2lnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E331280817; Wed, 22 Jan 2025 17:10:11 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90ADB807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so10243037a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562209; x=1738167009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cJh1LKAMUW2TFIMlpmwT1EfZFMwlrzzwoYdnYiApE60=;
 b=KwwK2lnJSsrNm6RNMslc1Sf6iO1LQ7EafhliOEsFAR5tar0m/vQaJcuE/KEDxGRxjK
 a7z+t0M/fmp7VaFpB4ALEh5Ov2r9XrqPEkPa/umhVMZMTEsepg7LbC/CpOE9KmakE/si
 1QIMyq+GecRG2B+srQ28O5CRpjPaOBp7i4V5r+ztmVA7ja7Ip1nARXDkb14dow2hQzI1
 PbrbuOGtM2GIowem1s7o1r0RjiR+l3jkenJ26CoPAI7rS5ffHm84d6DJCPkqUaX4VfkH
 s1Wct4X8c63eSK+aun0x6vUyLiM5viZo/AKrgdfeSx7qg00hKZCIQ/sWJnl3RyYYRBFw
 Dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562209; x=1738167009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJh1LKAMUW2TFIMlpmwT1EfZFMwlrzzwoYdnYiApE60=;
 b=NH8+e0zu6rkhhcEVpKTLt48miQKlWYQ5E+u9qQxjDXAuBfp/OvhPIa3eAUfyMAo1YY
 OihZUhIZMYlFpB0aB6f6EISIbTo2GbAzT0dLKktJ4RXmIxAz5zCeFDVzdpPiZAcb01+G
 e9vnzTyIMnj9XGb2ZzfbFnZBKvL/XbcL2DIRWiW1dIzCaCfjl0ERqgxasKEcHypkFgS9
 t3C2sRb/9Hw1fycoAfePFcQq0eF0SHbKNYKBkkVh4hViUPmD7fz3NinbBv529scvfIYh
 QGmxbOtqCps0RW2u0iQbYw8SgbUcK9DsS7J3EzvTtoucs5oXiv7XoVAGZRX+8/IfeqpY
 89PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy4hsgfzdhnKgo74UTMDy8tDch73jkGuQdcFSs8vLaDa99piyv6dd81I4AzShiG+LV6jKQbHw=@lists.denx.de
X-Gm-Message-State: AOJu0YxaIKvzcbnc2Yc3vpoRkVpjgSCP3R96nK3p9HVBr1dG10Wad4D0
 m1XI0VyGajJZByRC65g5N7o0jFYyAzhL33c5hOzYITSlxu24VV7LkvyKbVSa96Y=
X-Gm-Gg: ASbGnctROintVaOd2EBIcgQVG6k64x0WoGmoSWtga18O7xZMW/en6VQnD2te6Z5uFp8
 ktjloMjYI9VCrm0z+F4ZbYbq/wH5I55jfjunQM9cPkRNTRysaktnc0Wuf645kTqiTuiduyMS5pe
 qVZ6T+TWcU1cxlyJlfCkZ6HCTbAHo9g6QNridDB0ZWDIJ0GQ53QDI2USCuW9rc+mnEqgn3Fia6a
 tC3QLBvoD96lLwSf2WbJWyEyS9CF0QnGOwswdTUOy1GnmhzpeGqU5ehkkmPegGRnMB8oMQRHVOJ
 Yx1GAeiqBM86/zMJOFMWmT9KhoYB
X-Google-Smtp-Source: AGHT+IGiaVMqXFOtKG6i0c7UDFwExebPp9qqN9VG0qgbqEE90rW8wjdgtjUnW++k8vGCB6XFZoDx4g==
X-Received: by 2002:a05:6402:4416:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5db7d0eca61mr55707726a12.0.1737562209047; 
 Wed, 22 Jan 2025 08:10:09 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab63eb956ffsm283652766b.74.2025.01.22.08.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:10:08 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH] MAINTAINERS: maintain qcs9100_defconfig
Date: Wed, 22 Jan 2025 17:09:46 +0100
Message-ID: <20250122160951.1861910-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.0
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

Add this to ARM SNAPDRAGON maintainers entry.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6d..5a575f43277f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -630,8 +630,9 @@ R:	Sumit Garg <sumit.garg@linaro.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	configs/qcm6490_defconfig
+F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
-- 
2.48.0

