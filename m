Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D297C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45C38862C;
	Mon, 22 Jul 2024 19:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TtB8x1Nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D812588669; Mon, 22 Jul 2024 19:58:05 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61B7884AC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d9e233873aso2128053b6e.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671081; x=1722275881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FHeNwdnpi6EdFwhOvhLAK/f4VN+1hjXcFqzslTE8tc=;
 b=TtB8x1Nvdgdajsbg0eSxbOM348ig7xudkyRyZ7CSUrZNteSIPTeSF3gzfgBv85NbiL
 SDxAcSq8gDsw5f9AGS44V/iaAoDlXxV1ttAPuL7KBgoO+F1EaRnZA/VvewsHLA6P2fVc
 Hc0UpIuztk+272fRuQUOQY/PPpzE2143cU9TKYeXwM8ZSlB7bV0twbng5qbZ7rqpWT9c
 XXwgA3wlVw0qbdyY3jAlv7RnWBDS9aT125SAOlbZWSqBtTij/R7qWRJ+uQC7Mc1qZ7ju
 q+G0dFa10XsUfTsN5MgByn+KIyXBYqA5srUGsJbMk7P5weDwsIzof06hDAREQd6Nz030
 1pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671081; x=1722275881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FHeNwdnpi6EdFwhOvhLAK/f4VN+1hjXcFqzslTE8tc=;
 b=OW3ogE16eqvrq669nZT7J+IIp/zKbm2LfvRI9j8/Kc6NWe7H1XU4qOG1nqMGayUZ9T
 CF7td70ttG5nPSDORV277EbcEQk0zWX3oRHpt8OLZKG9/iVR2WHz50aicKPrhDDelWr6
 GPD2ih6nG56Z4qjwiaam8ZYv7pEfsklHYVomzQhNsX80iZ9S2g0hKmQRDl6YEnGE3Ayl
 xdKRYTlclvnJ+Yxqef/73ZuPnjv6SU8IDLMkdANeVEkgHtqUuJdaG21GueiVPMynidpc
 97pSxZpxBqEmBFact+U5cok4vtpdwSKh3lTMZCj3q8p0zur05jI1+TCQHxmwWkV/DbMF
 io9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVLCjbrpK26Xldz9xR+GCwMAcQGgUPnnpfB0YkL95rfoRo45C1LsS3ykiH9PDIa2i4gn9QlOnfFifVWgGDGAfVnmR00A==
X-Gm-Message-State: AOJu0YyRzJ1baHdwDvqwVUGKlC3X4B/eQEYr650jmOfoAx9PxjD5GC4S
 TwJrJHRwLgfFgy4kO2goaMcv1V8OsV3Lcfxlc0rFuvXdhjNTsxDpA92Nu1Js/vs=
X-Google-Smtp-Source: AGHT+IFWRRAhvFXso+UdV/LEfcI3sLXiY3lnxEJ5wHEqbwbE4ybgH5eruZjZ2HjVePsVFO4QOqeGcQ==
X-Received: by 2002:a05:6808:23d2:b0:3d9:daf9:345d with SMTP id
 5614622812f47-3dae97e4d0cmr6492821b6e.24.1721671081199; 
 Mon, 22 Jul 2024 10:58:01 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae096b0ecsm1617049b6e.2.2024.07.22.10.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:00 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 27/38] mmc: exynos_dw_mmc: Read common clock-frequency
 property
Date: Mon, 22 Jul 2024 12:57:29 -0500
Message-Id: <20240722175740.6985-28-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

