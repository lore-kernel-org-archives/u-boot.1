Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEBFC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD56F888A0;
	Thu, 23 May 2024 01:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SZ739skE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3DF8855C; Thu, 23 May 2024 01:32:12 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F97B88584
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-23ee34c33ceso2666785fac.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420725; x=1717025525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwybiIurhrdGzoKP/gtQzM2IqX52A1zjBO4NGrKx40c=;
 b=SZ739skEOQMu7LSn6d+27hapRJFYdXWEYjWPmW2kUpE/t3BxiJ+xF6SR55fIcDgTF/
 KzoxS1/c22xHByX7HRh7y2AyQCAu4lHZj/TphKxhEr8fIcihdIjWEPrI3tJxxnbDBtLz
 nHvpN1IzNpY9T4lXO4x1S1ocPA97DjFVJJ7ZcDOLk5KkKXWQ0fsQInYVSFDSvGU41pjD
 imoZcivATMmH52aDUS20SAcnYd4qxs1XgddRscgKV1SKL9WgldZ3dQHv7xSXeOTHmdZ+
 TlmCLgbSev7mzPvMZQBdgDBCVPn7CrrpgtWRhOxqW8tARPooyg69AEp6SsApKaeOO5of
 pqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420725; x=1717025525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwybiIurhrdGzoKP/gtQzM2IqX52A1zjBO4NGrKx40c=;
 b=xP42cDmEL7yvznFFnPgnpmVwvnfCwypa5flSk9FPEJeeHQBY3sUrdnGnRmMiDRrfOX
 /9CknTW2TcWbmk1kTXBHHMLO+BT2pC/RrY4DX1P5x45Cwf4pmCZcdoxF0LR6boh54/wC
 3l0A89aW1JK60RpmPAVz1wBlSe19dBcLLlJw4SyuMp+t5RlJspQCK8+5p7QLdC/D4BYt
 TBF2iGD+SfqtK8aFvCphNuu97lRSVnh+EtnFzdBDg34sprsE2lyUYCD+lxWltwdSy296
 OBCiogEOf38hZK+09uvm15iKRBP7AMynxtBB3Rlrkn6O68topg4k98XsjJEt5GPytRBr
 o91g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQqMQe7XufWIJbAf4TLYpGXJSUWp2EEJF4trFpNK+9YvtHr+F5icZfboLCp9PPPDz/qdocifjau2aRSAb1vihNOfNSSg==
X-Gm-Message-State: AOJu0YyP29i7Z4ui72jatH3JABkOA6nsuiDmOv19gU+4XUdZaWAcVZSg
 BpXM8DfoUqLV09pfpW7Lu6ymncpg6yQJyLJkqO6IkkRYc1my0g2XoYmDSUGjPI4=
X-Google-Smtp-Source: AGHT+IGsuFF1cDpqQVJ7YSt05EADpp4c2aMYiDTm7A6DIJKr/79dKiBwTL5vbh89AgShKuY/+lkm7g==
X-Received: by 2002:a05:6870:4154:b0:24c:5eae:6acc with SMTP id
 586e51a60fabf-24c68dd6829mr4005330fac.49.1716420725141; 
 Wed, 22 May 2024 16:32:05 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24c6f824851sm422383fac.26.2024.05.22.16.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:04 -0700 (PDT)
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
Subject: [PATCH 34/42] mmc: exynos_dw_mmc: Remove common.h
Date: Wed, 22 May 2024 18:31:27 -0500
Message-Id: <20240522233135.26835-35-semen.protsenko@linaro.org>
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

common.h header is marked for removal treewide and shouldn't be used.
Remove it from Exynos DW MMC driver.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index ac1a1784b440..e416fbe5397a 100644
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

