Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FEAC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1F688AE4;
	Thu,  8 Aug 2024 05:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XnT00wR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A4E88A2A; Thu,  8 Aug 2024 05:14:55 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5458873C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d59e491fefso282749eaf.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086891; x=1723691691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74cEtQY4AKykl70Rjuduf42kwRXuU030jQ8VMINt+nE=;
 b=XnT00wR/cCI15MmuY5pAb+s4LcqbMY3beyH+n94CIyw06lAoiixjdJuklcU6poy0Q8
 6UHrnlfmeNV16DDzsOwgtOVLtCCahNSGsAKcf0Y5Rb9+nUILVZBuDM0P2F8XaiC2q8Ny
 gxMEkqI2Y2gVVd/cA+AjqiMS3MEuGgB4ByBCigQlVpSKZ5939BiVUA+Jqk+ok7mrxAWU
 +zLX+ffLVMlmDUDAyEh/COk92LdmCEAdqSReq6tprXdj/AabjdPoqdAQDT2lnC2jmSgN
 C6fftEwvkoGc0rCleSBelCOTInM0jab57bIsFWUhnc1jo2eY3uSidHrUU027Ut+xCXmO
 6v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086891; x=1723691691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74cEtQY4AKykl70Rjuduf42kwRXuU030jQ8VMINt+nE=;
 b=H1GXou9NoTmpQlKrN/piI4Ow0vyoxdPOn6/HDSbOvG4XwDhnrHGeM0lX+cGl+V6Iud
 DRepbxCXLjAqtl7gt/g0RWbjOALC/jcYAjC/C17FyxpLTtuLwY+EZGKYRr3aYnXLifoc
 7QKQHosPNYt3CeN6E9wV8Tw1Qs+rNG9SrpD89GqsuCJ3NtMtOWnhNdjYPe1Pl1apSlH2
 u4d7pkpxXXK1NHc19P/zZ9cCvhkcSVeZ+TV4Rg1VNXxerGBJfVm/PPtzAJgdcbubTRfN
 LbLhfDqu/v1+LRiWLfVclRCWX4XTFi8pchOwsdk590rel6rce3PGsICpIAJzrVJE6tTb
 5suA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9n/j3WIlbV0Agu/FIYUA1atPjvwyxv4PmoKvlF7EQ4GKNz3eL/csrpdFudRDMiBPmba7IcSQEjvVphaFDh5jl9FVnDA==
X-Gm-Message-State: AOJu0YwnYK+q0fkF3Nbz4S59kVdvlcry5wy4M4Xb0hGqUGnapCiX2WWR
 BM8d/LP4BduPAdy+ZvgoXRcH3Sddlaw6kid5d+/PATrxAAVILjFWsKSwlj78GqQ=
X-Google-Smtp-Source: AGHT+IEs4cUCY37kNTgNQkNXLHGUwLhX1EtrM7bhYPcpBA2yXqD6ygSjN53a9qOXJpiRPAVCreR4pQ==
X-Received: by 2002:a05:6870:d18b:b0:261:1a17:c817 with SMTP id
 586e51a60fabf-2692b61859amr758267fac.7.1723086891009; 
 Wed, 07 Aug 2024 20:14:51 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9e011sm5154051a34.1.2024.08.07.20.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:50 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 08/38] mmc: dw_mmc: Extract setting the DMA descriptor into
 a separate routine
Date: Wed,  7 Aug 2024 22:14:14 -0500
Message-Id: <20240808031444.9619-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

Changes in v4:
  - Rebased on top of the most recent master

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 8fc26399034b..d73d58bcf7d7 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -53,46 +53,57 @@ static void dwmci_set_idma_desc(struct dwmci_idmac *idmac,
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
 
+	data_start = (ulong)cur_idmac;
 	blk_cnt = data->blocks;
 
-	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
-
-	/* Clear IDMAC interrupt */
-	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
+	for (i = 0;; i++) {
+		unsigned int flags, cnt;
 
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

