Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DBBC87FDA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D45483B27;
	Thu,  7 Aug 2025 00:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fq/Hb8KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D4A83B03; Thu,  7 Aug 2025 00:27:39 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8193482D21
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61b43c84905so235782eaf.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519240; x=1755124040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzvnkD57qhHojNreheOmv93X7Qc1wkoafeNTmJhjQT8=;
 b=Fq/Hb8KWb+1UBG7AsXaXCGlvALDEiR+UfLbcsynmdmT5ELPvLCNc0u+lz+UabEAJwa
 uuhFXfIZ8qqho8qNMGg/3k8Ktk0XT7eaxq62M1/xDjg1g4/yUdO2vqe3zMbpv4V8+Kd2
 MdguA+IPHWzUoA5URCg4+UpglcLdnAm+RZcAa6D7T0Vfjc+IRWWCzNeim7Se5crb+j9l
 1YLrAepsbWArRuTDC8m0of0YFETpJw/iYhu36gnAk4u9COSh9jWlx465j8hdrs28GN6k
 W4yiMH0+x62HCGVeeptvsuSuaTEfQp3X/C8bPapABjPILfbQoKkyCgMAchqptAHEfdpB
 uX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519240; x=1755124040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzvnkD57qhHojNreheOmv93X7Qc1wkoafeNTmJhjQT8=;
 b=p1hs9O4LWfO+8/bi8d0gYyhiqIAUNYiXw2orfHSm4SiTVB0rsb9wors3e0Kn9wytgl
 eyqtPBFN18Mkd09Y9/yI6Dmwl076UJdGbhAFb6g6xe80KHs7KlpD5zjCgGOU9jD5DhBS
 NDFALm1ivu+5cFRRucs5Ew9Waup62zBN1Lzxmf0Cf3GBIQQkFg5xnmayF/fdVkoH9c66
 FGJ38ixp4laKI0hwnWpB6E7pMhIvT2SvyJJNmNk6YxxBNwitKYCGIjPRQGo8FwX7YfOT
 HLseXp98DdLSaPrx+loCz6zrI1jKjN5UBj5KR3uTnmC9gsepWMwH49Dk3Nkro5SVcnsM
 8AjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvwMvQHeubQbA+kyFpCcALuCRvC7DLL6CGNa8e+F6tLn1iSfDBErZnDY9BFIJ9+4iI8ViFQak=@lists.denx.de
X-Gm-Message-State: AOJu0YxUxfQEApBkeHhptJzw3FBH0e0RPidOWKab0CScZVq3isHrxll3
 3xkwOoEuoVXvr4XYSEv1UZtG8iJwSfl8MottHauM5q9neCrvx8KNG3jpSsgDLXetBeA=
X-Gm-Gg: ASbGncvt3/kB6FAmZPmiSWVoL0SObMi2hhj3zUuN5o9QiFRGRQ2xPH+xzKhZNSKyOXo
 MX05gxqBRcxXnpuNlMWh3Iw31yFz0UkKi5g3y531fUGfBZ2z04PI8ns3FUQ2S4ilrbgYRRoE/rI
 gWZDqRhGnEgPQooOjwUDgSZ7lTjMtm9OoBcLf6f5NTRsy8OZhemULYwm8rOLzAtZLJ3BP7PXWzF
 3rPV40vZ2h+NF4HjIYnP7WlDsZ+HQLgBnFDdW+RlFG4ZXa6BPLNrHoH4yDLELjGsDBqj3zRMmZK
 jXPFMnnRyjP+7l9gmdozD6Hj6USqqsRH/KnInoMb+NKocIOf+016TMu4Kb4ZxHoFCSTW8Y+A3JJ
 oqeTUgBcNgceMR9wL2MjnfrKDm6dQ+D3Uprdn
X-Google-Smtp-Source: AGHT+IF85C983DyDkWLOr+GYklGfIhdEa+4fdK6tNwftN6RT9p9fPpuusk9pmajDZbMGe2l0tERY4g==
X-Received: by 2002:a05:6808:66c4:b0:435:8501:4cbd with SMTP id
 5614622812f47-4358501577fmr1316258b6e.5.1754519240138; 
 Wed, 06 Aug 2025 15:27:20 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-434e9a77e2dsm1182481b6e.24.2025.08.06.15.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:19 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 10/10] configs: e850-96: Enable Ethernet
Date: Wed,  6 Aug 2025 17:27:10 -0500
Message-Id: <20250806222710.23773-11-semen.protsenko@linaro.org>
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

LAN9514 is a chip on E850-96 board which acts as a USB host hub and
Ethernet controller. It's controlled via USB lines when DWC3 is
configured to be in USB host role (by setting the "dr_mode" property to
"host" value in e850-96 dts file).

Enable network support and LAN9514 chip support. This makes Ethernet
functional on E850-96 board.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index d7cd1b4b8ba5..8f9659ce050c 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -42,7 +42,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_NO_NET=y
+CONFIG_NET_LWIP=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
@@ -70,6 +70,8 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Samsung"
 CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
-- 
2.39.5

