Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD308C28B28
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 03:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B55780756;
	Thu, 13 Mar 2025 04:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TxQU+4Wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF08F8191C; Wed, 12 Mar 2025 20:43:30 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935538175D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c5568355ffso12938885a.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741808607; x=1742413407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2a0u7tKrNThmbpeV8RGbRJ1hHh7idxYBNAJ+fSKcUo=;
 b=TxQU+4Wx+HOH0/gAtmhrFbmNIaAivimkwjMPbHwwTJV2N8yZ8jLq9T/U1r75q3iB51
 3bsOyrfYNJwCnf7biDlUZnExCxc7bIe2QX1kLNqldwpXnXxKS6KjDpAbYa1APwVPQ6dz
 mvNbX1E1l2ger23U7m5uEtw4JArNBsgeD0e58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741808607; x=1742413407;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2a0u7tKrNThmbpeV8RGbRJ1hHh7idxYBNAJ+fSKcUo=;
 b=c+lATzZBAbhzLz7WBXGpHQaFzgxHzVsyz6FD1RGj8XRfNZTudQQa+UbzzlxopGvg0J
 b67tKo/g74wRp0jbhNNeS5Xl0lOB3sONWaP5TJjk29GiWo9P6pQQhmYTI3wL0WxxhqkQ
 UhLXI8rkwadBGeDkXMeBzMiYpusSt1M6xcGJOCfMx4Z036OMq1b9yUFOiUK00J2KAd7u
 VYtl++F529TXGHXQcbiw/7o1yM3yQbwY7lHXsXA8teSywyKOknHYPNu0A3oAyP4HuSoD
 g6dMll63dSuW2iZvYmtU9GLs4qjAQEU4VgVtYZzI8Aeok/sEc1o1UcmY5S9sJ9y9Q3QJ
 ZThA==
X-Gm-Message-State: AOJu0YzW5T39w+En5tXqXrD2PWmh/7xMRusx9TDVByMIjaRFH6oWocK8
 /6X9285C3RSd2/eC9lujkvdBEsQcNgxn/8GWZv0FinXm/fswHVYuc4uZu5WN9sw=
X-Gm-Gg: ASbGncuugWClJl2S2jIPIYFnwfOvs73bFQ+alKn7iRKyC9pa8Wq+YY14/hKvdZ7hpE7
 UXBWNzEZrFqGZ+NOWaE3Lb7iVs7jORRr1ycZxV3nEFljtHdksBxHJoboHeXKwhuwru0gJddzQm6
 DyzG+MpekVhkX7z345nhMcBUC+ezccDR/1CNRvkxpbCwtxSJjuq9lUFP3S3FexYSKAdssvnjKe6
 rzaRd/iVEUQWUFDGTTOFEYfS7QfJKF8lBE2JtXCeTlTBT/nsmAOmQxlM/Lrgunr20ndaM6nvim4
 YIzWIrE5Nq9etm2LLQpNwkOZi65jAf4Q/PjcHuSMDk3D
X-Google-Smtp-Source: AGHT+IEQaiemsWg+Jh/HmWW0TA9pmJK694IyuoKj/vRhxOGXBybWuHBSiQAbJQ5ZObXsJnvmDR6O4A==
X-Received: by 2002:a05:620a:1b95:b0:7c5:5343:8c2c with SMTP id
 af79cd13be357-7c55e886113mr1512602285a.27.1741808607454; 
 Wed, 12 Mar 2025 12:43:27 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5491fd795sm630841285a.110.2025.03.12.12.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:43:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: adsp-linux@analog.com, Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Boon Khai Ng <boon.khai.ng@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Christophe ROULLIER <christophe.roullier@foss.st.com>, 
 David Virag <virag.david003@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Erik Schumacher <erik.schumacher@iris-sensing.com>, 
 Fabio Estevam <festevam@gmail.com>, Gabor Juhos <j4g8y7@gmail.com>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 John Watts <contact@jookia.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 MD Danish Anwar <danishanwar@ti.com>, 
 Maksim Kiselev <bigunclemax@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marex@denx.de>, Markus Gothe <markus.gothe@genexis.eu>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ramon Fried <rfried.dev@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Romain Naour <romain.naour@smile.fr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>, 
 Greg Malysa <malysagreg@gmail.com>
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
Subject: Re: [PATCH v3 00/12] drivers: Driver support for ADI SC5xx SoCs
Message-Id: <174180860112.1757127.14501024973817729043.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 13:43:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 13 Mar 2025 04:19:44 +0100
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

On Wed, 26 Feb 2025 12:30:22 -0500, Greg Malysa wrote:

> This series adds all of the supported peripheral drivers for the sc5xx
> series of SoCs from Analog Devices and other drivers that are used by
> the evaluation kits, such as a GPIO expander used by the EZLITE carrier
> boards. This series passes gitlab CI tests.
> 
> Changes in v3:
> - Add check if PORT peripheral base address was mapped successfully
> - replace read*/write* with ioread* and iowrite* and friends across all
>   drivers
> - update for compatibility with changes to dwc qos driver between 2024.04
>   and 2025.01
> - (spi) Primarily addressed issues identified in earlier feedback:
>   - Removed unused pins and memory_map priv members
>   - Added __iomem to device mmio pointers
>   - Replaced readl/writel calls with iowrite32/ioread32 and friends
>   - Added map_sysmem() call to prepare device mmio pointer
> - (sdhci) Removed struct adi_sdhc and replaced with the struct that was its
>   only member
> 
> [...]

Applied to u-boot/next, thanks!

[01/12] pinctrl: Add support for ADI SC5XX-family pinctrl
        commit: 79ccd6c7dc7055d5bbe375fddef925d7986c204d
[02/12] doc: Add dt-bindings and descriptions for ADI SC5xx-family pinctrl
        commit: a0ffd8d7cd8efb8b348c07fa18a610a4534f9bea
[03/12] gpio: Add support for SC5XX-family processor GPIO driver
        commit: 1e87f0ed79100d915540658eda76e4e125713323
[04/12] gpio: Add support for ADI ADP5588 GPIO expander chips
        commit: 446179627fcac2e99aaa329a1d6cf49805482c6b
[05/12] usb: musb-new: Add support for Analog Devices SC5xx SoCs
        commit: 2f6a86a6125645ef818dd0d4c0bfc1f77c73e31f
[06/12] i2c: Add support for ADI SC5XX-family I2C peripheral
        commit: 7f99650bb8f592827fc687022f4238ffdd4fde3e
[07/12] net: Add support for ADI SC5xx SoCs with DWC QoS ethernet
        commit: df831ebf6114c5f534f774c8b5b6998d328d0101
[08/12] watchdog: Add support for ADI SC5XX-family watchdog peripheral
        commit: cbc0dfd424caabaa9f2a1fee911940c7f65666e2
[09/12] dma: Add driver for ADI SC5xx-family SoC MDMA functionality
        commit: 072320d9215641dd30c5697a6b479ad46f05f2f9
[10/12] remoteproc: Add in SHARC loading for ADI SC5XX-family processors
        commit: d3bfe577880d20a19f155cf2bd33c5545c72cf6f
[11/12] spi: Add support for ADI SC5XX-family processor SPI peripherals
        commit: 7535a9280be1fc81b280517c7c44b5f1c2efc0ba
[12/12] mmc: Add support for ADI SC5XX-family processor SDHCI peripherals
        commit: 036118ebd81e6b2c593d5ea6dc0056b34931c870
-- 
Tom


