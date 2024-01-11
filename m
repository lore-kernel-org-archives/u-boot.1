Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6C2C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A015187A97;
	Thu, 11 Jan 2024 04:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iQCcye+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987B087B12; Thu, 11 Jan 2024 04:09:32 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD9A87B04
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-203fed05a31so3078132fac.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942561; x=1705547361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04HwiPFawIqbCII2LGetu6SD9m4mjbVpnnuIHfkRq3I=;
 b=iQCcye+LzXq6c/6IynFqxkX+35FiSDgtDfMHTeRAR/CBteCTmjndFRP69grcptaKVb
 Q+n3oWAo3cqZPt0GRkQqQ/PloLqJwDmDsWaaF8e1lSvr9gLpnLcHDXY85M+kWODRf5ml
 tzX7Yh28cBliLFTLdSknB8qIJQs/T/VPopsfrEqrpAHouZpZ2aMt/mcQ8yNHJBwRcl7d
 wAByIJMHmKKoPkZ8WvCWC2JNZVEJHJWM2+Nu1JGvGQ6Ug6X74UJSDMSx16k1Fq7VnnHf
 Zr0Z6hTs12+LZQen3Nmh8eus0UKpfnKvoUk6cU5r79knlPsWTPv8URiSGKnJoUeJN0Ud
 Qwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942561; x=1705547361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04HwiPFawIqbCII2LGetu6SD9m4mjbVpnnuIHfkRq3I=;
 b=d4f8BC8rdbESBf5KRPVJRZ/mSX9WITF7YZo9QJKGhmEzxeqfWNNi1zdY5aaIrvw3ND
 Pbxvdd01X4lqE60F8mn6Xlw7m8PXv2nxLrRFNhBrHCucNWiwb7ZRt9u+zRNsr+zDESS4
 XhqN+i3SCPzj1mkEVDdfEWinoErhZrPnJ98Nh0qC6AaeQhd5R2WovngKT9Fi1iwZj2F7
 wDs55LUZw3isbjiu0JKRhGolO8VMc+lgqXgTHh1eW7Jo57t7U7GTkElN1hcNR1phC9UE
 jX1vTkxv6yDzodK2atMkSW2N1KddDPU3E90pW82f8yeNFY6UfetiEAiOBQu49ljkzRYL
 94kA==
X-Gm-Message-State: AOJu0Yx8/6DqGNIj9A0E2EUlo2p9FyAGOFPJj0+9U1BaOA1XD9sJrN/A
 q+Pm4wtvCGAuJobjSBX69OXwj7mG+jtMvg==
X-Google-Smtp-Source: AGHT+IHrMKNuRdsbcBimFoWzRdgWHnuPMzeEuTaCGL5WDVt26flMw76hzVtzcGSvJTLZLWbB9Do/nA==
X-Received: by 2002:a05:6870:ac8c:b0:206:848d:a3e7 with SMTP id
 ns12-20020a056870ac8c00b00206848da3e7mr680290oab.53.1704942561315; 
 Wed, 10 Jan 2024 19:09:21 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 mm4-20020a056871728400b002059d4b979bsm8019oac.25.2024.01.10.19.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:20 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 10/13] serial: s5p: Add Exynos850 compatible
Date: Wed, 10 Jan 2024 21:09:06 -0600
Message-Id: <20240111030909.27373-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111030909.27373-1-semen.protsenko@linaro.org>
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
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

Enable serial support for Exynos850 SoC by adding the corresponding
compatible string. No additional changes needed, the driver works as is
on Exynos850. Related USI and PMU configuration is enabled in separate
drivers. The only other dependencies are clock and pinctrl drivers,
which are already enabled too.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 drivers/serial/serial_s5p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 7d04dcff54fc..801b7645afa4 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -257,6 +257,7 @@ static const struct dm_serial_ops s5p_serial_ops = {
 
 static const struct udevice_id s5p_serial_ids[] = {
 	{ .compatible = "samsung,exynos4210-uart",	.data = PORT_S5P },
+	{ .compatible = "samsung,exynos850-uart",	.data = PORT_S5P },
 	{ .compatible = "apple,s5l-uart",		.data = PORT_S5L },
 	{ }
 };
-- 
2.39.2

