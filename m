Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CAFC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC50F884D0;
	Mon, 10 Jun 2024 03:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CvPgEEaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A097388433; Mon, 10 Jun 2024 03:12:36 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7502288452
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d1bc6e5f01so2152194b6e.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981953; x=1718586753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0146DouQsOatr7usL3FKhQq9K5snmF+YpxZgikTni/U=;
 b=CvPgEEaPJMUFwVI4as7r/KGhMd1Jpp6QCvaeAV4FhK2qZZzqS9WjTePTnET8Hxtjvx
 OkZZwngNUhGQ/TyT7TCr8eo40ni6UTE5plhQHmRUkvLxPEDD8H1En7jKGRVFrJNhAerB
 BMCkfEeh0JprIh91/QnlqbpvMpN/feBJailiEg9CyH8IE2/k0bhYGjxK0Enxni4C8aWg
 w0Wnens/3GX8GV4lw/mkGr4pGIOH6OnJ5NSjic37HePkzYvv4n+vfqWQ7vlrwdNCAzQf
 VJar7ZqAh4a2aAwKGlAHK7XPRh1gydqL/+yf47KYLI6zeJyuv+kETgbu3JYO8yW0BxyR
 sNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981953; x=1718586753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0146DouQsOatr7usL3FKhQq9K5snmF+YpxZgikTni/U=;
 b=JjjQx9+FSRODu10FFR9UmGehr4CnW2GH68UH1DDbDlLqgudaYXr+Vprzgih4H1eerv
 xt5C/QmyoiLeStKjpbV+HiC2dOokdGk6ZiV8XyipI4FtT929mU67okKCqjuHOvXzS267
 udRvWSRrjx99As0JOwLcs4u+mzEXjIkuVkGco8XrTTZCYacou+6HMKZTzlfe4q+zd5dZ
 J37a0LzUWWp9cDXgB9o4YldXVthUEfLI5gLY9SP4eLVmwvcTwk1bTgGSf4kysG0MaNJH
 ks6bSp/B5ok2mParVsJH2Lzjalt1gVvjS+JCVjahDmw5QxF7zmoWjLfn7SQIH1g9Yvo3
 5PVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyeBoM2OBaD3peC2gJq78KpAQ9Akt3KqBUUI7kiZLJ1f6+QqTUZKGyvn+brCZYOd2ZUNmKASKsv+78L/NKppTUmUn0Jw==
X-Gm-Message-State: AOJu0YxOD2Cfe+fNcFfhn+Rew2q/r2XbmONVWdqB8Dp0GFtuE+EsCja5
 wlMU306Sm0LLGuiAzhlbwHuyVtrB62OXqqS/5guEjW4w5AI7mzklMZlv2WDh7ko=
X-Google-Smtp-Source: AGHT+IF7Xjuvk/me+6VQkqj3gEgiMAEJs44nbrUsz3TVr8bGhLRF1ZV4IVJSh5zi3Win9EDF4y8hPQ==
X-Received: by 2002:a05:6808:d54:b0:3d2:29ae:540 with SMTP id
 5614622812f47-3d229ae077bmr2093170b6e.14.1717981953204; 
 Sun, 09 Jun 2024 18:12:33 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d21c52b167sm749101b6e.20.2024.06.09.18.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:32 -0700 (PDT)
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
Subject: [PATCH v2 09/40] mmc: dw_mmc: Extract setting the DMA descriptor into
 a separate routine
Date: Sun,  9 Jun 2024 20:11:55 -0500
Message-Id: <20240610011226.4050-10-semen.protsenko@linaro.org>
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

Make dwmci_prepare_data() function easier to read by extracting the
preparation of IDMAC descriptor into a dedicated function.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
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

