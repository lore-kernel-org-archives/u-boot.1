Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB27C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4AC885D0;
	Thu, 23 May 2024 01:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AUbQEJ0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2484288590; Thu, 23 May 2024 01:32:09 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 874188858E
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f12ff2da3fso2478964a34.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420721; x=1717025521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcH+hdIdUCPobv7oA3xIfa7qmTWGmaI58Zz2CMx7/uo=;
 b=AUbQEJ0CSZcE9WGv79tC3MBYAoukIVw+Ifi427Psso+Ws92Eej3bEDwot+bx2ttlpT
 2caSbWrWxHtQIdAjU7V8aV/jKBseJfad6NyR8WP1rUfIOw3qyxl1bh8HkG6opAvVoXMR
 nmG/Rvd/HJ16s/C/7EpIQzo7kN26CemR4FICBdOD9ruAtFTptSMhpT/MP2knkux9jdIX
 j1PpCWO4mPjuVeb65UhegFyeWB3jWRV43syXSHrov6wOgND6jvCajStFmx8IOOHfaObD
 a3TeV9nn0NKnF4CILQoixlAljRUtDwpDK4DuMnHjpmjWK5qV/8h3mMFKWCWqt6Z8ORne
 Eq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420721; x=1717025521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcH+hdIdUCPobv7oA3xIfa7qmTWGmaI58Zz2CMx7/uo=;
 b=OmpkGNbzdz7lMWmHx5n21Ugolww68cC+nM4RQ3MvbCeMT5TZYSS1Z33Gd2tVx46tZI
 h6+ArsDfwVLliYIHU1iwwB2HfdTpxkF85IYLHtaCqDvl7OaTn/LGhiEhGy4Qh4OOdRO7
 TbK9S871+8MYZpQ6SNUe5tibeNmttuzHv6obtCpu9oCWzP2gYdCI/awkO/X3qD6DV/PZ
 D+Ln8Yqk9//Q2N6lVRpWIANHaaCNxNAZXO92rkClSSQfkzfF6GVcbTZ1keqfG30amcDu
 BAYEPib/MAksR016z4vH8uvkH116/NKrtSIUPoeGh8j6HlgJM4Py7Mh5yt0wLzqhNyi7
 scEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHUfXZXGknBtQ8a2OP65OLgvy9oLn6z9leQLgu0/LVGWxZt0y/b52OiE+UNiQZ1HtRHAF0BLDwdw9z/9kEpXPnjyNGGw==
X-Gm-Message-State: AOJu0Yx71X0kCRUr3EfUtHfGwb5XGPnkl+4w1ZhVcP0DLosXfHg1yN+t
 BZyvOAp6SJIL+wPqkckqsuAwZ+2gTRi0eep9l8yTnhIXgPTLO+oDXjBKip35FYQ=
X-Google-Smtp-Source: AGHT+IFLzyCU0/iW8Xdc0jIuWmOxaBTf2eX6v3LV7nlAmsIlkYAM3bbFSdDSw0DffpUsA39WQCubzg==
X-Received: by 2002:a05:6830:3156:b0:6f1:2ff3:5abb with SMTP id
 46e09a7af769-6f66518f849mr4596730a34.5.1716420721367; 
 Wed, 22 May 2024 16:32:01 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0e022339dsm5193640a34.62.2024.05.22.16.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:01 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 29/42] mmc: exynos_dw_mmc: Read common clock-frequency property
Date: Wed, 22 May 2024 18:31:22 -0500
Message-Id: <20240522233135.26835-30-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b046ac6c55ea..8a307c9c123b 100644
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

