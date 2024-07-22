Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E99C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76002885E4;
	Mon, 22 Jul 2024 19:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPjuEyvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A70885C5; Mon, 22 Jul 2024 19:57:50 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE0188005
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-25e397c51b2so2408968fac.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671067; x=1722275867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayKudOXUaJapN/875CebWt66dclSkxeyV6btsdEkOpE=;
 b=mPjuEyvSY2TthWyBlqanQKeZQ9v7umZMxOCfGGXeGnqQ74c0qQrQTQ22qowf2HVnTM
 EAF6soQHgyXtVHp0Y0huXbAydlnfL0IsMja1S2qAKfXDCDnFtIx12XfL2pDuQtTGKN6o
 WgW2UrgrpwSiMJucdYmB+6rZ6s2cJ33PbqWYrGkNR8HpAFWkUCBsysVv0bjTsuwnVfum
 ATjoNPHtvETnzMNTNYqG7oWT3Y91f7cuw8/KjLqbFYPIPLjQAiCvE8xWw3MwPlaXQVY4
 SEs8+utUQXYpqwHc917mtlezMrySznScm5/g70b96J1+czS44B/g3vPJ/RAvGO6M3yWM
 XCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671067; x=1722275867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayKudOXUaJapN/875CebWt66dclSkxeyV6btsdEkOpE=;
 b=NhR41uBqeeHOgv74cDSe693vXDHoGZ/fSv2ARecJH6Qdb0iSpsrIwhqs2BGY8hgjRX
 AM2rsENvnVNJ6qHAy903MlzPuZustnYP2vmD4W33GZGvN2Vc6zOafS1YOUIgMLp3wYpb
 eTodCSLnShuzJHjY+cNiR7rhwZkqAKQhb4xtEA3tH56NJ2j2gCdvacHRvgnlP0YdoSY2
 HZGY+sN1rl4m8hCqgRXoOwewGjPeY2GBnK/s9VC+V9Fbdn6IqA2CF9YiP4QLtARbLifj
 SXk5oOOYuFbfMrIWe9ggNFuEQTMLdUOUeTabBdQdPDW7U3u00j4bw92dDC+lXEeX47g2
 SMBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVVYyVrp9amUb1oOlLproPFN4KbnNYh8RAV806tnM1I/oxCRfuALlX6dNE+YXl+Nb/dMZEvXgamzXBjn3xCwAtpz5vbQ==
X-Gm-Message-State: AOJu0YwWEbP9dhMMPNc7odMwp5zhH+9knAGOh8AVlV0s/9ui3EOMq+dG
 sVqvP3fuDMu9Mfhdy0TLkPZocuL5kpkQeJN1jbNW/OzdICyARmXHATpuSrqkoZJ/JoKMl2IOVV1
 o
X-Google-Smtp-Source: AGHT+IG5hEbyrgE9eaxrgkRwSA1iA5oUX400su2qj3lSvp1XuLlYrR5yEoh18jeIaOqWpY25ROC9mA==
X-Received: by 2002:a05:6870:b61e:b0:25e:d90:fe78 with SMTP id
 586e51a60fabf-26468fedc06mr413861fac.8.1721671067353; 
 Mon, 22 Jul 2024 10:57:47 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c716fddsm1783083fac.8.2024.07.22.10.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:46 -0700 (PDT)
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
Subject: [PATCH v3 08/38] mmc: dw_mmc: Extract setting the DMA descriptor into
 a separate routine
Date: Mon, 22 Jul 2024 12:57:10 -0500
Message-Id: <20240722175740.6985-9-semen.protsenko@linaro.org>
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

Make dwmci_prepare_data() function easier to read by extracting the
preparation of IDMAC descriptor into a dedicated function.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 52 ++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 7b20f4936b62..8bec43f0bd16 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -53,47 +53,57 @@ static void dwmci_set_idma_desc(struct dwmci_idmac *idmac,
 	desc->next_addr = (ulong)desc + sizeof(struct dwmci_idmac);
 }
 
-static void dwmci_prepare_data(struct dwmci_host *host,
-			       struct mmc_data *data,
+static void dwmci_prepare_desc(struct mmc_data *data,
 			       struct dwmci_idmac *cur_idmac,
 			       void *bounce_buffer)
 {
-	unsigned long ctrl;
-	unsigned int i = 0, flags, cnt, blk_cnt;
+	struct dwmci_idmac *desc = cur_idmac;
 	ulong data_start, data_end;
+	unsigned int blk_cnt, i;
 
-
+	data_start = (ulong)cur_idmac;
 	blk_cnt = data->blocks;
 
-	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
+	for (i = 0;; i++) {
+		unsigned int flags, cnt;
 
-	/* Clear IDMAC interrupt */
-	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
-
-	data_start = (ulong)cur_idmac;
-	dwmci_writel(host, DWMCI_DBADDR, (ulong)cur_idmac);
-
-	do {
-		flags = DWMCI_IDMAC_OWN | DWMCI_IDMAC_CH ;
-		flags |= (i == 0) ? DWMCI_IDMAC_FS : 0;
+		flags = DWMCI_IDMAC_OWN | DWMCI_IDMAC_CH;
+		if (i == 0)
+			flags |= DWMCI_IDMAC_FS;
 		if (blk_cnt <= 8) {
 			flags |= DWMCI_IDMAC_LD;
 			cnt = data->blocksize * blk_cnt;
 		} else
 			cnt = data->blocksize * 8;
 
-		dwmci_set_idma_desc(cur_idmac, flags, cnt,
-				    (ulong)bounce_buffer + (i * PAGE_SIZE));
+		dwmci_set_idma_desc(desc, flags, cnt,
+				    (ulong)bounce_buffer + i * PAGE_SIZE);
+		desc++;
 
-		cur_idmac++;
 		if (blk_cnt <= 8)
 			break;
 		blk_cnt -= 8;
-		i++;
-	} while(1);
+	}
 
-	data_end = (ulong)cur_idmac;
+	data_end = (ulong)desc;
 	flush_dcache_range(data_start, roundup(data_end, ARCH_DMA_MINALIGN));
+}
+
+static void dwmci_prepare_data(struct dwmci_host *host,
+			       struct mmc_data *data,
+			       struct dwmci_idmac *cur_idmac,
+			       void *bounce_buffer)
+{
+	unsigned long ctrl;
+
+	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
+
+	/* Clear IDMAC interrupt */
+	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
+
+	dwmci_writel(host, DWMCI_DBADDR, (ulong)cur_idmac);
+
+	dwmci_prepare_desc(data, cur_idmac, bounce_buffer);
 
 	ctrl = dwmci_readl(host, DWMCI_CTRL);
 	ctrl |= DWMCI_IDMAC_EN | DWMCI_DMA_EN;
-- 
2.39.2

