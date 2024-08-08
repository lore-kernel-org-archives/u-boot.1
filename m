Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F83C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167DC88A6D;
	Thu,  8 Aug 2024 05:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QGLDI+6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E00088786; Thu,  8 Aug 2024 05:14:53 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1669888CF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-260e1b5576aso381785fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086887; x=1723691687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82+AAIfpblJ/FxfNzNEtfvvh8sailDSat4YEVZKvy/M=;
 b=QGLDI+6n6cncDjq9tlQCVBi2eFbekSyXNoVlSoiGy6aF1M4N+W6dP+/L7y4nAsiktP
 Jj94xCGkXjX7kVmi/xebwpMqs9bUdHtTXdo07oqJypDVOme7NthiQo5iPyJfi3FBgQti
 2OT3nhM1UEbiRl5TmeVFWbSZQn8qtPfryN7BVu4N3BWoFvWvDS+ac7TZ+sOB0M/djwzG
 a1QJr9la7nJd/p7np4QyvycKiMSUOJsNfkdcbtr7P4T0hhwxuoyY2lsOSqXyno5JXwty
 xgfvNRIEAuury0K9Nlqe6a/u8mNfsWiymTJ8mEAQA9Kj6Rak9atiCx6oNWx6aZ4BkSth
 Mhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086887; x=1723691687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82+AAIfpblJ/FxfNzNEtfvvh8sailDSat4YEVZKvy/M=;
 b=Oo57Kx2r2PzjqzegnvdAMCC74TdtpOoyD5xyxQRgQjACfrA4t5Mibo4MDrSpM23T/Q
 j2Sc6/PDxUCfzF/lo0SNfrhIEhy+y0C6AaI7aeuNF+nRzQ/lyKFAXGhSszarylZKZMVi
 7YuztGuzVDTXdbu7YyR99UA7gTI5Rnlsydq0UYCEg1NO4HpR0caVXkrfcmKPm4pL8Ygg
 8J2ifnrAXgk57EWjh8uDrEUYrGOySpGtTBWWv3GdAuDP3oBaUdnPUhcJanT6mlpyUELn
 DUcHCc6IE0OoPyKhLGilVPkMMoSxsG4Nw8OmFZMLl+ktD33717W1NfoZQm/ktQwsBj7m
 iRzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgtY9ZvT1LDLBNy3F8FYjDKvH6dp7NrYiJOiZVgzDlj3F6XA0N6beuF3yINM5NXIqi7Lv5avQjh4zqbcTBbfJaS5ccCA==
X-Gm-Message-State: AOJu0YywHoYn1Fi6Fv0DMt1Va+xFuMD793odArVGh3+BghE6Vu8VTbnv
 qma7JhBJs1ryoZqnBrEuhSJ96ndEZeR9Vch5Z5nH9BXCoJt765oBmty1nCp4rDQ=
X-Google-Smtp-Source: AGHT+IEe+kz9CfI9rCY3l8WRD2sWXcHmyq2Be5ZnfV7LB21MfoRUkMgUww/YLsWwNWCsllG2WhuM1Q==
X-Received: by 2002:a05:6870:700f:b0:260:e429:2498 with SMTP id
 586e51a60fabf-2692b6ad6camr586034fac.26.1723086887504; 
 Wed, 07 Aug 2024 20:14:47 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a6824f3sm4380931fac.57.2024.08.07.20.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:47 -0700 (PDT)
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
Subject: [PATCH v5 03/38] mmc: dw_mmc: Extract waiting for data busy into a
 separate routine
Date: Wed,  7 Aug 2024 22:14:09 -0500
Message-Id: <20240808031444.9619-4-semen.protsenko@linaro.org>
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

Waiting for data busy is a logically separate operation and should be
implemented as a separate routine. Follow Linux kernel example and
extract it from dwmci_send_cmd(). This way it doesn't clutter
dwmci_send_cmd() function, and can be reused later in other cases.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 45665e517068..395b699b0a0a 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -245,6 +245,21 @@ static int dwmci_set_transfer_mode(struct dwmci_host *host,
 	return mode;
 }
 
+static void dwmci_wait_while_busy(struct dwmci_host *host, struct mmc_cmd *cmd)
+{
+	unsigned int timeout = 500; /* msec */
+	ulong start;
+
+	start = get_timer(0);
+	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
+		if (get_timer(start) > timeout) {
+			debug("%s: Timeout on data busy, continue anyway\n",
+			      __func__);
+			break;
+		}
+	}
+}
+
 #ifdef CONFIG_DM_MMC
 static int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 		   struct mmc_data *data)
@@ -259,19 +274,11 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 	ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac, cur_idmac,
 				 data ? DIV_ROUND_UP(data->blocks, 8) : 0);
 	int ret = 0, flags = 0, i;
-	unsigned int timeout = 500;
 	u32 retry = 100000;
 	u32 mask, ctrl;
-	ulong start = get_timer(0);
 	struct bounce_buffer bbstate;
 
-	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
-		if (get_timer(start) > timeout) {
-			debug("%s: Timeout on data busy, continue anyway\n", __func__);
-			break;
-		}
-	}
-
+	dwmci_wait_while_busy(host, cmd);
 	dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_ALL);
 
 	if (data) {
-- 
2.39.2

