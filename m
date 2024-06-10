Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47C0C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED827884AA;
	Mon, 10 Jun 2024 03:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FVX7w5uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E964C88549; Mon, 10 Jun 2024 03:12:49 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC0A288521
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f9866bd5ccso687092a34.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981966; x=1718586766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKGVyBjU7QNgd3Ltzr4SKvpT8+mSsbZvSlV/SyjdgAc=;
 b=FVX7w5uurs+oVHYP63Fnv47OWxlY8nboYcrtpass91fsraM7lk7ji0sbyf8hhmuOWr
 fK8spbnwUk/5/3NQ0oo+sb2NO3OqPwaLS9fPpfXWAO4l61siUAPCMCvcxog+pdZjaxQT
 uyQY0x+7mE7JD/DdnzPxngZFfGvbXzWRKpK9KHoQsH7YqilJycMyNNJlh02r/3qf0N4I
 CECFZegUGE8CneNfX41W2EjaXWEMbIJ6j7INmdSacVvDGLFtLL99SMH2fiSZk4fX/Mox
 l3ptNziLuqxO8QwwjvyHDCEcb5+joy6dCf7G/nRqY3hJ2+Q74TzCJhmGnkOwFfD23rYv
 wpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981966; x=1718586766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKGVyBjU7QNgd3Ltzr4SKvpT8+mSsbZvSlV/SyjdgAc=;
 b=v2tDeZQVaEtdqduDz7Ynh4yHDV7VTd5OaWZdSERnbbF1W9vOTS4mQQyiQgwd3OZi+W
 JfaO/W4g0B9JtEuCOcE58iv0SYt5BM/iqO3DI/jP2Y+4wp2OEhFo539RB3LjRFTyt/v8
 EEAkjbrIGjmQn/NEfynX8+cqUQLHWKW1ikDZxzQz14gnrZFG8eqNFJ+W4/Mdw6u6S62F
 pdmNnPnSZbo4GGKL+Obl1HiOSwyxV0rRXjwEnXgj+yxQjaO/Iqxv5lJ7AE3Q2CQBbmDx
 wGPM9PjuLTAhmcQ6qwjyOz4zFn3gBIpOI7RpR7ceKHrjrgRdTZyVkkhlMN0xOXNr6jOP
 bvqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpcANMdxtf5T6N9LARwv5HhPQr9EzwY3KY95DAxlr3bYkfI0zRaxKK8MFJ2vHCckBiAK7ALeATSOTLhgpoiVOkolpD3w==
X-Gm-Message-State: AOJu0Yy1SKeV6Fho72gi50S+7nKHFjN6Z5bGn/+aEanqHnXzQuS5tna0
 mrPQj5oX8h/TGxTICSUfZhPBSbFrd21ae9okRDnQ18BQevC3TAMTbrs6bqVKKu4=
X-Google-Smtp-Source: AGHT+IFr45VpMO+o0PKnm69GKj2NGaJQGmsHNQ9ktzhZ0nGgFn0NOs2e+XLKuR5HSw4x+aCqD8nOtw==
X-Received: by 2002:a05:6830:3508:b0:6f9:3ed9:cefb with SMTP id
 46e09a7af769-6f957264bafmr12241483a34.20.1717981966473; 
 Sun, 09 Jun 2024 18:12:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f997b7312dsm492541a34.56.2024.06.09.18.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:46 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 27/40] mmc: exynos_dw_mmc: Read common bus-width property
Date: Sun,  9 Jun 2024 20:12:13 -0500
Message-Id: <20240610011226.4050-28-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

Instead of using non-standard "samsung,bus-width" dts property, read
common "bus-width" property used in upstream Linux kernel. It's safe to
do so, as "bus-width" property was already added to corresponding nodes
in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 drivers/mmc/s5p_sdhci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 098468f56e87..01e6bbb123f1 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -275,7 +275,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = dev_read_u32_default(dev, "samsung,bus-width", 4);
+	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
 
 	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
diff --git a/drivers/mmc/s5p_sdhci.c b/drivers/mmc/s5p_sdhci.c
index 3b74feae68c7..0b49a9c5f2a9 100644
--- a/drivers/mmc/s5p_sdhci.c
+++ b/drivers/mmc/s5p_sdhci.c
@@ -167,7 +167,7 @@ static int sdhci_get_config(const void *blob, int node, struct sdhci_host *host)
 	host->index = dev_id - PERIPH_ID_SDMMC0;
 
 	/* Get bus width */
-	bus_width = fdtdec_get_int(blob, node, "samsung,bus-width", 0);
+	bus_width = fdtdec_get_int(blob, node, "bus-width", 0);
 	if (bus_width <= 0) {
 		debug("MMC: Can't get bus-width\n");
 		return -EINVAL;
-- 
2.39.2

