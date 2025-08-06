Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E100BC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B98583B2C;
	Thu,  7 Aug 2025 00:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pWzvCSjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815AC83AEA; Thu,  7 Aug 2025 00:27:21 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC41A82D21
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-61b43c84905so235728eaf.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519232; x=1755124032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mHEsdLNYWJgjkomg0AFQzNpEGKdn+SV5lmhAbXpKE8=;
 b=pWzvCSjXePC5g62wdu3VRGEqa4hZPBHS4FZ8DuOtAkeFH9Iiuj6Abv2LP2Ep6sOu6b
 JE2dWm4BhaZ43hR2+B8XpQEdWkwHdgggUAA4gEGPEeheow8JQMSGHaQfmysabLYN3rmE
 PJr3/c2Tc2g6xWzee7Btyou1vzpw4sYV1BvmmrGFiTyJfAYoAik2Nzx6DbXn9dxZdDLf
 by+S5XCumeYY4Wkl1hj4KmW/15WrhKdGMC/WzdWv0t6bplFAQlA2+LS7hWIgLbM+Y4Ak
 JUjfrdEcujKHsMNhu9l8bG5krA931Q9XHPkdYo4kemfXtVSIi6C53hETXDBC9pZbdMnH
 UVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519232; x=1755124032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mHEsdLNYWJgjkomg0AFQzNpEGKdn+SV5lmhAbXpKE8=;
 b=dSvf0/jcP2mwkte6k6kh+TcPto6sXJZMM4kJTEVz5/FezZ5apIZ0hD2D9ruSPA9kj3
 w5cNI3UAKwUfzvmyClxU8Q1zi5NtW7jLFCEMdL0L98m7R4RMJSLk9IJJll7hw6ML/1ec
 mCMGt2T/mhibhfI4kgcO57UV5CncPeKcsO1VaacYv17IqrMm+S67z0YcBvRHn937Cy35
 vUAKh4WmydkBJM8R7DNxzDTCid3nCBhhXWSI7ojYs0fizLF2d8XtlTGOFDIa/F48ZTmZ
 zvx/CbujbKzXM1A7t+Z8qILFBL88bHhH/N2ecbJJUbkvFgroz7RwGVeaSu7deb4ZRe2T
 iMnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg/T1EbRGA2+Lku7T6VegB/QIFaM7eyrQuP2lVapaxyus/GSCbAzbwvBjdRZ1zYiWuuIlyf94=@lists.denx.de
X-Gm-Message-State: AOJu0YxzQREnlWGAcEMNeYlFCgG3WTFw04gLWOygyVlaH54LwSS4wcnJ
 RS/tAFhOIIOEIdUazbTEkeY6a6UcBIlTpCmRn9a8qOUl1wGi6mHfwAvmqgPz7cLfMTA=
X-Gm-Gg: ASbGnctpV3hJrjh1DAfxoOJhPH4Qgq8YdwK76hHomwIcFNd5J/TJWGz7JHN4VsMoud7
 rPmrIWdlSQ1KuDd8YxGBDM5zFGKI41dZa1jVCTRJjCBnzbFS7Rnc2TzPlfclrZ/JWezIEkjh8DL
 z9vLMBAVrBSPCb0jsW5LwZTGvE9wA0J2dEsmAM64g+GSMLxbQOzAidSFQlhTqXxe15E4nCAMU+u
 9Kf+O4ta+IDwQ27T23yeDM3eJeqFtwE2cd4JYHIbiIjri7HuyygZVfpqIgl+JvhfarSyWxZC2Aa
 16A0P464KzOaeKGSD5n8c9JAKv/Mv+IPrxdSr0E29SeTojZsy9IyLXopC3jry2ywxVyJqx7ZIva
 mEQZ0/qlTmOBDKdjse2jJ21AtrA==
X-Google-Smtp-Source: AGHT+IHEBF2KZm/uR4Xrriz5NOx2ugHTR3d89ke1NFfF+yte3Qt1hDovnXQVpaDVjaoAP2QdFRjuTQ==
X-Received: by 2002:a05:6820:f01:b0:619:a34b:3e25 with SMTP id
 006d021491bc7-61b5f3b30eamr3479857eaf.6.1754519232394; 
 Wed, 06 Aug 2025 15:27:12 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ecesm2529049eaf.17.2025.08.06.15.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:11 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 01/10] usb: host: dwc3-of-simple: Add exynos850 compatible
Date: Wed,  6 Aug 2025 17:27:01 -0500
Message-Id: <20250806222710.23773-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Enable support for Exynos850 SoC in DWC3 host glue layer driver.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/usb/host/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/dwc3-of-simple.c b/drivers/usb/host/dwc3-of-simple.c
index d52e7d22d1a7..362178b79004 100644
--- a/drivers/usb/host/dwc3-of-simple.c
+++ b/drivers/usb/host/dwc3-of-simple.c
@@ -91,6 +91,7 @@ static int dwc3_of_simple_remove(struct udevice *dev)
 static const struct udevice_id dwc3_of_simple_ids[] = {
 	{ .compatible = "amlogic,meson-gxl-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
+	{ .compatible = "samsung,exynos850-dwusb3" },
 	{ .compatible = "ti,dwc3" },
 	{ }
 };
-- 
2.39.5

