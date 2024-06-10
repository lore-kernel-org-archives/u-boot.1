Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F8FC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9038850A;
	Mon, 10 Jun 2024 03:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IzMkIkZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F1C8851A; Mon, 10 Jun 2024 03:12:54 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0735C8852E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f97ea43c39so683149a34.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981971; x=1718586771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzYITZL8crUF+H2su7EpoQ+00fKcpsKhtq/C+HCl19s=;
 b=IzMkIkZ/HOC+Wfq6CNtQKcUcrrOuclIsVHgzWJhr5IIh+j53eHebE0p0/f+tkxUIrH
 12O7tsCAb4qqDTlJ8nubSSoCrxFDfnsKB15VzFsKP07dPhKfguZnhgSPmevlSYt3i+NG
 DqqmHB55ad3DljWaXjX+3p/MGfPUnctVXgFS2fRKDvgKQ812niRvXoEFJHHLeifYGTmb
 Hc77sHITil4x4INaLyvbjb6x8NTvqM/2BEIylTDqeAagX+jbNUaqmlg4EEjTZ0iHPlqo
 voiyz4wnyo9Ckh8QeA2uHHNm/mLoxnQgsA4f8O5Fri5r7LY1XKUop1yqXRkfwS1uX36i
 cB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981971; x=1718586771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzYITZL8crUF+H2su7EpoQ+00fKcpsKhtq/C+HCl19s=;
 b=xRO0LI+euThagP+xqd477h0u86Zi2Ecz7laJ0tto+sclWjsw2zboyHSNDbIqz4K9IX
 exovQRGOo68EvhaXj+FNJo0UvRsEu2ts8GYvpIV6LQeQTZs7RoRu/x03dw9n+kPkaTMS
 12QAWBIezyj7ovlVrsfSU/UPG++uuuel8mCqEXQLJEZMmEX+OtTM9xhA/CM/zJb3jq0a
 xPEoSxZ0UbcMy8oUfxUZRwM2M4DjiGoiMhMHvRVlxSSwq++x+rjZCKyKnZiZbvuHka6K
 cSab542ExXmTQ5N6tqj5bXXHATzE7ftiqWeJR6in86Du+kLv6pGV52LY+PmWlbRSxq1h
 XH4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgqo6K852BCm8tVdX53S9dEMNcCs8ymgofT7Oj9jnRUKPo3wLl2YP0L/bDaawNt8AHFby4ObIhuSWZxpP9KZCPMSYjdw==
X-Gm-Message-State: AOJu0Yw/PIUty0LfGuSDQnL5n4YZGcXYST46zlCBVedUwnoZWW1W6+uu
 Gd8lZ5c9PuRbDQN1Vlyh9cNbZS9xTxQA/+2hNUCAMORzIwDKoM9zJ7XjbUmE1Z0=
X-Google-Smtp-Source: AGHT+IEOzm6orzPtq64TZAWR/vy1Q0Zxm2K8w0Wg/wksp9FoziCF48kqMwxCcY0IqGT05bkWmkOmQQ==
X-Received: by 2002:a05:6871:28a8:b0:251:1c9d:dd5d with SMTP id
 586e51a60fabf-254648b5f62mr10212707fac.56.1717981970790; 
 Sun, 09 Jun 2024 18:12:50 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f95cdd9934sm1067800a34.29.2024.06.09.18.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:50 -0700 (PDT)
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
Subject: [PATCH v2 33/40] mmc: exynos_dw_mmc: Remove common.h
Date: Sun,  9 Jun 2024 20:12:19 -0500
Message-Id: <20240610011226.4050-34-semen.protsenko@linaro.org>
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

common.h header is marked for removal treewide and shouldn't be used.
Remove it from Exynos DW MMC driver.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 2c8364ab8d40..29241edf7915 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dwmmc.h>
 #include <asm/global_data.h>
 #include <malloc.h>
-- 
2.39.2

