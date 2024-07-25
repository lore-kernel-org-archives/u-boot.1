Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7268AC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F63C88808;
	Thu, 25 Jul 2024 22:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SxUty/Ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA0B88717; Thu, 25 Jul 2024 22:45:50 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CEA88599
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5bb03fe42so162485eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940346; x=1722545146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncm51mb4XPPkXlgtosrF2Gll54fHmWIKTQhB9ftYqo4=;
 b=SxUty/Nin2ZugX+bdWetbR5UYiD3z+ho92B6MwmLn2rCig852fw1KVWGJr+SL11b95
 yfABdlgKLyOKF9NV/UNBeFNc1RVkfynrxR/qKUinMgLlLNNLcfWEZRfMjbHBsSjI/sw+
 0uq7dX3YlelgdejNSZ9uW3jG21xO+j2dl7uWGzoI9Z8xmRlX7Nk2M89AG4PhOu+udQg3
 DfVFf3ejBAPAzKM+eIj4BUARkV0YyQvg1gT14tKZewCMkEkNu8lB80xfgCSoaZ30vT6A
 ewkP+YF62RAFuewmexpDj2jh+Yp4fmlvV4nvzSx3vODLa/8ek2shyfTs9FVVIZH3p6yg
 RHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940346; x=1722545146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncm51mb4XPPkXlgtosrF2Gll54fHmWIKTQhB9ftYqo4=;
 b=fY3dugUQkgqUd3IE+ifV0gEj5NB+oLEYjqPYGrt+wN8Gyu/12LxDmP7LUzPBVcfEll
 FIBHqZVCTMYBpyghC1F/byPG1fAY7N+nahGkYaAat3ZOv9CvkNhV1xnfcCcmj+c3lq1E
 sYHU232R+4Lz9WBST3WJ6lqZgWyCNyJtQV/VzwrVOow+jYT+EFprGdNhQW2W3WfskPox
 +FUUgtYnv2jYkiFBjxQuOkmHcy/CkFa490PokxTm3feKT3MODW3+LGKRkYmHJ+/HhrdF
 IFq0zWwhfFR+aQKi1I4BLxCwI4NQ7SDFMHxMtLb6sq+kQbDalKfjT2WiXq8D6T9a6YDo
 ASwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjM8qI4VitKW3cM3qNGppIqC2rSHHFvItocLLDTy5PtQ0znN4BgveCrIPrw6iDdkw6ircTv+5ggHdoQaJVmgs2yyjiEw==
X-Gm-Message-State: AOJu0Yx4Rvm1cys27lkJOZaOrkYq2kkW68/evXrKfGYWArYehrJrIewU
 Vk65+QBmB5P/l02Frok1J7G2YQb5obM5c1l9ZLMBvGZ0uF+youSEB4vTOEJS4r0=
X-Google-Smtp-Source: AGHT+IEpNLU7/3JTI5ISSIgE3iwYbkfL/1KDHP2kWbi5V+uNKlnwMM86Gh38KB0hvSFH52pQxgRCbQ==
X-Received: by 2002:a05:6820:1b09:b0:5cf:24e0:b78 with SMTP id
 006d021491bc7-5d5adac7d98mr5521860eaf.3.1721940346177; 
 Thu, 25 Jul 2024 13:45:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b2c639f9sm258109eaf.0.2024.07.25.13.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:45 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 34/38] mmc: exynos_dw_mmc: Use dev->name as driver's
 displayed name
Date: Thu, 25 Jul 2024 15:45:16 -0500
Message-Id: <20240725204520.18134-35-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

Reduce U-Boot footprint by reusing dev->name as a driver's displayed
name. This changes boot device name (and "mmc info" output) from "EXYNOS
DWMMC" to something like "mmc@12100000".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 43111b749a6b..a9e240fd91d6 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -327,7 +327,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		       "continue anyway\n", host->dev_index, err);
 	}
 
-	host->name = "EXYNOS DWMMC";
+	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz;
 	host->clksel = exynos_dwmci_clksel;
-- 
2.39.2

