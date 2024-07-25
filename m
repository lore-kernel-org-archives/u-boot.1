Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B981AC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E3F88700;
	Thu, 25 Jul 2024 22:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dm9lN+Mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1429886A6; Thu, 25 Jul 2024 22:45:44 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4EA885C5
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70448cae1e0so164421a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940341; x=1722545141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNDumY49CDktTqx3IPFl3vyE5aLeGsbRRyWHKlFDfo4=;
 b=Dm9lN+MuEOdNlaarrlMACxf0UncSois4k4/ShyYL1y/F9Lu3iUKY6kQt+7crjwKerB
 Q2MVn6Es14SIVE7G5KgVlsyAuK0vx1X67nosJ58Qn+N+Km2PYVxQbU0QusovtG2yyxSv
 fHEVnOSGRHRYnPTeDKKQhEuclcgZaRZEbw+yADHAzEkcbTHvgOG4oGBD54ewD9GEW6i4
 6Q79S6L1zo2dfDuM38ClDZojUo6a6WfZ+LtRTdB/tue1Q88FRuFWicKNsy0V1tKq3cQa
 VoCHnQEmPD+PKiJXqCBF0kNGyxHeh7cttNT4wrTUiu9miwGjBuUh7nspKsRD4Ubb4+++
 VCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940341; x=1722545141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNDumY49CDktTqx3IPFl3vyE5aLeGsbRRyWHKlFDfo4=;
 b=hpmWXvJNV12Nyc/zMEFWCpOQum5lxoxo9mpEPLTQ6WSsFBVB0NrsUJuuWtJrP5jXZp
 MmjhqfICw1c0HdrkbwxG1UIHCm8FRp8Rw31Stn+jEMZgEzmm/q5O68b20Cp32dRxb+0/
 pvp1O7TVsXK21Ox6XTL8OByM/UjEDkaXmgSL0atrewB8/XeYGatcabM2t+oW5nPR5gHe
 T0k9RzFP5jDE+zctHn56oTma/4mAOSomaiplsFC1So4eZHJkmAkB/wQB50N4CMSh7FXT
 HqhNC4fhsXUbzVHkWZuUEOo3YhI5kX3BejjTDvEtL2zbwzVwc06LBXeA0qwLqPd+FfSW
 hMpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQEgHMvWVxZxB5aTuFbGtjFFwtF91blJxWxVBE72YBZnMXh8EmS9/kWL/oEcfz+58iNW8BG4kJ8g97S74hFb5Lfi09kg==
X-Gm-Message-State: AOJu0YyTtH+t5lLDCi16sSFr0s9fjsRJ/rzAMS/QDWAl16oNQh6v8Ot8
 swrlq5FebXXgrilQ5vNCE+Pf1yUVFrdjYCB8KBfTUYwAetcvZk4b90OhAFaMV2M=
X-Google-Smtp-Source: AGHT+IG5JXrgYYSPnrd9LOgZn0C8UibdvGANZEhHBlA1AHphSgMxR/v/BkGuWARZyJnTy2pCQGO0LQ==
X-Received: by 2002:a05:6830:6181:b0:703:64ad:83e7 with SMTP id
 46e09a7af769-709324fe04cmr4093479a34.30.1721940341393; 
 Thu, 25 Jul 2024 13:45:41 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093072b795sm460388a34.42.2024.07.25.13.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 27/38] mmc: exynos_dw_mmc: Read common clock-frequency
 property
Date: Thu, 25 Jul 2024 15:45:09 -0500
Message-Id: <20240725204520.18134-28-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

Instead of using non-standard "bus_hz" dts property, read common
"clock-frequency" property used in upstream Linux kernel. It's safe to
do so, as "clock-frequency" property was already added to corresponding
nodes in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 612c2d0c615d..bed8bd8a0fcf 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -306,7 +306,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
-	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
+	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
 
 	return 0;
 }
-- 
2.39.2

