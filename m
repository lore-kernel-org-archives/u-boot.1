Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD2BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B3C88680;
	Mon, 22 Jul 2024 19:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aX6UV1XQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB0788645; Mon, 22 Jul 2024 19:57:58 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2983E88214
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d9400a1ad9so2615923b6e.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671074; x=1722275874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0y0jof263srhDFgZAkkgTTJzKgOeUotT2aFOff6tn8=;
 b=aX6UV1XQhJmpwRWX5dHY9XCM9UNdMHDA3XpGQScz3h4jSIpbaAUo435QWMOpOSqCjB
 nsz/CQsPguXWAiivMmFaVStFiqJbhAMoQTtWLsKUbAKIJiBRwpRg24GalqSywzZWyo1S
 G6c3RUeVv3CTy7aZvkaXuRYT0hObibeS+jAKsd7mT9nx1J0g2vXocbjh5j/zn4lfa/Fk
 CjqbxWNPv0LtPIpCy9CvNUVrc7KrBKRL9cCsBX3pGq5tESi9nw4TaPK2XoZRve9vdWLZ
 44qqAnEEB+IuS0FOkErZNiou9Te2P5NpJGaRupEPNKY4E09N6gbuSMHkfdrVICRDuqs+
 wj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671074; x=1722275874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0y0jof263srhDFgZAkkgTTJzKgOeUotT2aFOff6tn8=;
 b=gSMe8+WV+Stwg65vo+0EmgJupuHxKDVvLADgj30yDhowAv1XjZk7XF6HhGcNMvgLwF
 Phndv77fEathNtGs6dn7ofi3ncO94RQx79XhEp1hvxm2VTWIaei3I0M0qgE97YTmSK3K
 oCsEofDFY72a0a6ybnofrCCNYiibTjL9XHdAyEx9zIw0napHMHloHNCjkZzCFUXnOpVm
 oswG4rmUf+WaC0O1jSvt47MRkzkKNkmPwDxBljy+TSSXwxrhFNX04bxxhmYGZWdDNLnZ
 rro/vk7GxUDyXK8WJGiX9YraVNGC1Qkx1GBn04Erv+9j4rddBMHXOFnfMjjElXxdtVlw
 v5Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPawodHcO0KPboX5ILOo+d2PkDzaodD53/IdETK4AoXHsNeYjHxScI9ANckZNu9VHE5lem6Y8YpmX0tg4G0OB0sC8pbQ==
X-Gm-Message-State: AOJu0Yyvcid0Nucgr8o1mfeTbxKA+Pyq9nOTSZQm29n76iDSulo3TV49
 JVuT4moJ3UmgMVtSNzvHx19vk17MYrZFHmOPehdS7n5Vq3MfFFsrJEzN428MDDw=
X-Google-Smtp-Source: AGHT+IHdoCNJUHnrtBpsJ0pnFTiDvemzCPMrW6HLBLPCFEhL+c2w2AxXy+WskW108h2uKJ6IrfF/ew==
X-Received: by 2002:a05:6808:f07:b0:3d9:2b45:1585 with SMTP id
 5614622812f47-3dae5fb24bamr10121131b6e.22.1721671073938; 
 Mon, 22 Jul 2024 10:57:53 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae099013asm1596433b6e.25.2024.07.22.10.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:53 -0700 (PDT)
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
Subject: [PATCH v3 17/38] mmc: exynos_dw_mmc: Fix obtaining the base address
 of controller
Date: Mon, 22 Jul 2024 12:57:19 -0500
Message-Id: <20240722175740.6985-18-semen.protsenko@linaro.org>
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

Getting the base address with outdated fdtdec_get_addr() API and further
casting it to (void *) leads to next build warning on ARM64 platforms:

    In function 'exynos_dwmci_get_config':
        warning: cast to pointer from integer of different size
        [-Wint-to-pointer-cast]
            host->ioaddr = (void *)base;

Use livetree API instead (dev_read_addr_ptr()), which handles this
correctly.

Fixes: a082a2dde061 ("EXYNOS5: DWMMC: Added FDT support for DWMMC")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 377c9e6d90b9..a86d58663c1b 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -155,7 +155,7 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 				   struct dwmci_exynos_priv_data *priv)
 {
 	int err = 0;
-	u32 base, timing[3];
+	u32 timing[3];
 
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
@@ -173,12 +173,11 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
 
 	/* Set the base address from the device node */
-	base = fdtdec_get_addr(blob, node, "reg");
-	if (!base) {
+	host->ioaddr = dev_read_addr_ptr(dev);
+	if (!host->ioaddr) {
 		printf("DWMMC%d: Can't get base address\n", host->dev_index);
 		return -EINVAL;
 	}
-	host->ioaddr = (void *)base;
 
 	/* Extract the timing info from the node */
 	err =  fdtdec_get_int_array(blob, node, "samsung,timing", timing, 3);
-- 
2.39.2

