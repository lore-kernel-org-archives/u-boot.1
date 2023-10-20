Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8910C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5114387521;
	Fri, 20 Oct 2023 23:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nEKJuiL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700D48752E; Fri, 20 Oct 2023 23:46:39 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2159B87517
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1dd8304b980so892784fac.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697838394; x=1698443194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=odgDf3bzblPOJM20jHgCIWjrLhOjf2wIemM/1nw1XZw=;
 b=nEKJuiL6EWxwXOOcqSH9CYEqN9im1QrBEzfY652g552G0iwDIVxa1N1l2jgjjSbEiy
 pz1zSjw4kYp9OiUcFS/sE37OBQlroIjSOWokJGyC4p4SsZSbos61lf+aA+QByNlAWdRW
 gpxZgoSCPaFu+4mmJedvzvy8NGFNmr4XdshYmy7amjR0Q+HWUCyuZJ5jSQOsuT1p7P39
 2vaAfGDFYcCqcDgkQGSHgwYLHd+YWgauam13+R6ocMuTs4j6WZH7N6tZmKnaNP/t9icF
 53j1XkM5QQtOaj7Z5rrRtBKtOG6UbNbwbG+ZpdQhzr9sGyxN0ixVbi03/D6uB/OU1dy0
 URHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697838394; x=1698443194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=odgDf3bzblPOJM20jHgCIWjrLhOjf2wIemM/1nw1XZw=;
 b=Up8htEYJ2lH5TrJh26F8ZkApWKQQE+vNd5UtJMpQJSMuXW+eKKbDZBaG5FcD/W+1TE
 qrKVX9r+sQrwmtlWGnLBI4vfOcSEys+kfbSIOx9c9f9UMdTV4A3B3gmgyQS1Pa9K8Toe
 J0PNAtbKpwiY+cF1r63cJGvtSVGwBIpzlApK5knsO62tVMMxvoVikEbQZ9L+bF09Va/8
 h8rmx2bXXeEAM5Vd20XivVmCf98csAE5J0QVXjERfBcyHGMmrOZ32vs3O6BdZ9CpfaQT
 ECCBJMgPPFoEL6LcBawOZpL1BSX9Vw7BKbcpSKO8C1EpR5eo9PnZkv6huwjI64I0uoR9
 C73w==
X-Gm-Message-State: AOJu0YzUq/m0132RNfo1l67U0+Pngb+L8SnuU7o5I2Vc/KRu7/IMk13W
 Fh/+WgzA4ImzdySEJ3RRFCVr1g==
X-Google-Smtp-Source: AGHT+IFu2hO40SSUvDSB0rGSSS4u0OtAZ8yXvaTeK2naS15lxiLfpQ1lrg0V4WAGnYZlqh8OxfZpUQ==
X-Received: by 2002:a05:6870:6ec9:b0:1ea:1667:6c8f with SMTP id
 qv9-20020a0568706ec900b001ea16676c8fmr3518063oab.50.1697838393713; 
 Fri, 20 Oct 2023 14:46:33 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 le25-20020a05687c341900b001eae28db525sm533169oac.23.2023.10.20.14.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 14:46:33 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH 0/3] exynos: Include missing CPU headers
Date: Fri, 20 Oct 2023 16:46:30 -0500
Message-Id: <20231020214633.30883-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

During porting a new Exynos-based board to U-Boot I faced a couple of
similar build errors due to missing <asm/arch/cpu.h> inclusion. This
series make sure it's fixed in all places I found.

Sam Protsenko (3):
  arm: exynos: Include missing CPU header in soc.c
  arm: exynos: Include missing CPU header in gpio.h
  watchdog: s5p_wdt: Include missing CPU header

 arch/arm/mach-exynos/include/mach/gpio.h | 3 +++
 arch/arm/mach-exynos/soc.c               | 1 +
 drivers/watchdog/s5p_wdt.c               | 1 +
 3 files changed, 5 insertions(+)

-- 
2.39.2

