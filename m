Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDE9C25B7B
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 08:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8ACF8824C;
	Wed, 15 May 2024 10:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSnTO8zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA065881D6; Wed, 15 May 2024 10:01:55 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC5C8817B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 10:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so8428321fa.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715760112; x=1716364912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57gjT8Id0A9WzovRoDpMzRQmLiLnNDLpjF3dE8Tywuk=;
 b=ZSnTO8zOD0ZSzChvH6akJGiW79Z8nQFd3V1CWlpsq2v8Iomyz0VcyAn3QPmtetGZOk
 VRaewdFmBN37Rmosz0ab9POimBVDz2vJsBFDqXzV18yLjhAtS1LO9CLJviD/ZchifH7v
 lnaKhXBWBy7jPApK0ameeRv7b6Vs8Vy2uBKeTs2r2gpJqMZLWRXiPy8d1sOpEuJTRZ8l
 j28dkQb9jCv0GFoW6acQl3c8yfkZwh2lolYosFlt75c90iY4+kI240VvZt34pN/5+GBR
 Z3bf0b+SpmFZytC5Eddsm8NIr5pF8UAuOlPuAvUbqoNkYZQ341fkRp2SW9F1ab09K1oB
 nJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715760112; x=1716364912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57gjT8Id0A9WzovRoDpMzRQmLiLnNDLpjF3dE8Tywuk=;
 b=FCZgd8GN/niKcIuqVsl7CPA2Xvp2u7E/TSs1iRF5U3zOOs+aFKBdWaFOJiZvNZ6/mT
 Byt+W9WHXRzIFTylRb1z7EepPMgQEVpEONlAPHZCttkYPYXAJs2VSlApM4FlPwsdeIcP
 xCBhcOFgCV3lqEfG3TlVvr0LvSnqSO8l2bkCaFCFcG0roUzv4ncyg8+x04ZA7d946glq
 upeEkhe9RbBayTYJkstt3k5xg2ZyCje6dYOWRnnYLXelu1/u7g1HEwqtPm59Ki18CpSl
 3wu4niFKuLMvPpsdn6HybHPAJIyox6n8dpV07HiabUSm9FqjfWQM07f+FTZoN0g2UgLN
 ISOA==
X-Gm-Message-State: AOJu0YxtRjS7oMBvshTNOJwoPjyaIAGu24iZdRxGFN6RtnzgA4irJsUm
 slb8arffRKEW5rikWzIyJo8Ova5k7mGWj6H5UofTSrKdv4G/NPpNm3TfPcaMvfo=
X-Google-Smtp-Source: AGHT+IFO3duzfFqGzdBYV3qwisL1ysipe4I3BxESwulOTANy4kzKBoqB7Ma3uWxGA7wetNs7vW9/ow==
X-Received: by 2002:a2e:954c:0:b0:2e5:6957:187a with SMTP id
 38308e7fff4ca-2e569571f3amr101150541fa.4.1715760111247; 
 Wed, 15 May 2024 01:01:51 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01472sm823804966b.159.2024.05.15.01.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 01:01:50 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] arm: dts: k3-am625-verdin: Enable LPDDR4 WDQS control
Date: Wed, 15 May 2024 10:00:58 +0200
Message-Id: <20240515080058.1530985-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515080058.1530985-1-ghidoliemanuele@gmail.com>
References: <20240515080058.1530985-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Manually, since SysConfig tool do not have the relevant option,
set PHY_LP4_WDQS_OE_EXTEND to 1.
Since WDQS control mode is required on our modules LPDDR4,
this enables WDQS control mode 1.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi b/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
index ca883ae82c7d..5062447547b6 100644
--- a/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
@@ -850,7 +850,7 @@
 #define DDRSS_PHY_62_DATA 0x00000000
 #define DDRSS_PHY_63_DATA 0x00000000
 #define DDRSS_PHY_64_DATA 0x00000000
-#define DDRSS_PHY_65_DATA 0x00000004
+#define DDRSS_PHY_65_DATA 0x00000104
 #define DDRSS_PHY_66_DATA 0x00000000
 #define DDRSS_PHY_67_DATA 0x00000000
 #define DDRSS_PHY_68_DATA 0x00000000
@@ -1106,7 +1106,7 @@
 #define DDRSS_PHY_318_DATA 0x00000000
 #define DDRSS_PHY_319_DATA 0x00000000
 #define DDRSS_PHY_320_DATA 0x00000000
-#define DDRSS_PHY_321_DATA 0x00000004
+#define DDRSS_PHY_321_DATA 0x00000104
 #define DDRSS_PHY_322_DATA 0x00000000
 #define DDRSS_PHY_323_DATA 0x00000000
 #define DDRSS_PHY_324_DATA 0x00000000
-- 
2.34.1

