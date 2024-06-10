Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B81C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C9E8846F;
	Mon, 10 Jun 2024 03:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XumNLUb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E131B8845B; Mon, 10 Jun 2024 03:12:33 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C7087D46
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c9cc681ee4so2115978b6e.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981950; x=1718586750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8viY7SbYuROR2eM2ZSnRIvO0crt+QSUsF5mzdu0K1oo=;
 b=XumNLUb7KPoebMuP2hnlCh0iNihS8Htj99OScH7Ox7oUwp2IGAuKcT1l0CEjreOZRG
 h0GyrtkjShlUSGs3JACf7dfWnuz5uE+qLJpWqNxlaciLgH/kOOR3FoJ0TfheSp1slYrD
 Fh7ioLOLizmx8SYNrAvQYX7Eb9jEpInAdZYNXVawoDIfId8lpWttE1xxusFks/2tIVeF
 RTmxYnsFS73SYz67nRi06VztJ95Qo1JxDRIznmQz0vfZjz7GCLY+r8N2Qy/KEv0QSrSn
 w4WQEu/fGRJRiQSLpP5Wp65hls687tDS3as9K+Df0a1dnPl5hawA2zIda4ihZtqKIw5n
 WI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981950; x=1718586750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8viY7SbYuROR2eM2ZSnRIvO0crt+QSUsF5mzdu0K1oo=;
 b=SvYQsLjSCF+VcG/+3/3VdNEtwWv/1Ug0ngqbcGXaIB5ag10pmqV2KHzn0KFhIvQsf8
 x5m+WwAkzdfxscpzlnBKCdFtHG8nxXmEvm3ZheVgoB1OX37Yr5ew2amkqBDX4By0fHsZ
 abJMz4CoTS1LE8rAGYE4m14lWVNOxafu7QnFDzobaSwhvuowJExyBAxzA+coV0bHunc3
 vQNT9aHEK7YkQeaHsgxihrda2q+DPhkhz6YC3iLpziOS4aW5E9YoffuI3eOLG0ch7/sf
 noNNxOaasQhGRHqbWmPUl2zOafrr379K4F08qViWws5qsEKCbcdFlNr01wTVuPLt9rv4
 jYtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVi13b7XDAQ4UeqMDDapuZlyTN6dpQmQRU9OtW5RdfW1zhpDyFTTjbfTWk2OUxZGtvEX9Y2q/RRiZ7yFcPqfoSGapGjg==
X-Gm-Message-State: AOJu0YwUP1mbkoPzPxeaQUz5R5yzEtiJRTJyBjOZ1vrM3YTSfBp9kQB2
 dr127vwMhp5GMjumdhQUPEWNwMoFQyj/tCRnfo8CwH8v28quAQL4E+OPBYCtsSM=
X-Google-Smtp-Source: AGHT+IEhWumVjqfxEhCFBqqtvGcQ6s54rhFn4nBIVsbibm7R9583lULIY45LboPhaMuRP53xJITZgQ==
X-Received: by 2002:a05:6808:2390:b0:3d2:2577:89a2 with SMTP id
 5614622812f47-3d225778b03mr3426260b6e.2.1717981950421; 
 Sun, 09 Jun 2024 18:12:30 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cae2sm1441631b6e.4.2024.06.09.18.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:30 -0700 (PDT)
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
Subject: [PATCH v2 05/40] mmc: dw_mmc: Extract FIFO init into a separate
 routine
Date: Sun,  9 Jun 2024 20:11:51 -0500
Message-Id: <20240610011226.4050-6-semen.protsenko@linaro.org>
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

Move FIFO threshold initialization into a separate function to make
dwmci_init() more readable.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index a82f6a96db39..cbfb8d3b8683 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -540,6 +540,20 @@ static int dwmci_set_ios(struct mmc *mmc)
 	return 0;
 }
 
+static void dwmci_init_fifo(struct dwmci_host *host)
+{
+	if (!host->fifoth_val) {
+		u32 fifo_size;
+
+		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
+		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
+		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
+				   TX_WMARK(fifo_size / 2);
+	}
+
+	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+}
+
 static int dwmci_init(struct mmc *mmc)
 {
 	struct dwmci_host *host = mmc->priv;
@@ -564,16 +578,7 @@ static int dwmci_init(struct mmc *mmc)
 
 	dwmci_writel(host, DWMCI_IDINTEN, 0);
 	dwmci_writel(host, DWMCI_BMOD, 1);
-
-	if (!host->fifoth_val) {
-		uint32_t fifo_size;
-
-		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
-		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
-		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
-				TX_WMARK(fifo_size / 2);
-	}
-	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
+	dwmci_init_fifo(host);
 
 	dwmci_writel(host, DWMCI_CLKENA, 0);
 	dwmci_writel(host, DWMCI_CLKSRC, 0);
-- 
2.39.2

