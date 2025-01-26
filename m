Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE05C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEB780FC4;
	Sun, 26 Jan 2025 19:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V3tFE3cJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ADF80FBA; Sun, 26 Jan 2025 19:43:55 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF63280FA6
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so5532975ab.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917030; x=1738521830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLp/UB59wknCibkrXJn9t3KC2VleO11dT6gBVKfX3M8=;
 b=V3tFE3cJ7mc0NYbJNWv62ZXu9hd3Ny35wJ3Jw/bHSzCNiikpwXgSKylpaGUA2HECsn
 VMV+TcHb3Rm3Q+sWzFsB4Vsi8l3nW824pEQ7Xx46tdOM2juqW0gb9LuxZyDIEVoeDcLZ
 Fa4BRamAY5zMFPMETBPn+BEMMMpe4tsj2nHuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917030; x=1738521830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLp/UB59wknCibkrXJn9t3KC2VleO11dT6gBVKfX3M8=;
 b=qZRJXzEndJ29WjC9L4DMTP3Y03h8gGV0W3alxR51gS46CpKjKOFZ9CSJGNlKTUtXx5
 +Ef3o1ZcxhDfa6APo4Irk6irThUGh9Cm8TfVa8SV15/bh1vK9A08skbIawb7ZEMVaWUe
 KryBwApgOl4+OY/d/6TqgBLG2IVe57JeUpPusRUqm924jl8l9K73FA5dlk48pc83XBAq
 JNndlvB6HdeqPLurRoMZGCGYv9ieW/I+rko6bRkMlY3CBvmw40M95j9Y87jzoGXpNlng
 O+HF4G7tQ+YSYD58fNZCcicOeAtj7T6Ahb2JkfXjFlG0I3GBJ7pRUoBsbJsWBbmcmM1I
 j+qA==
X-Gm-Message-State: AOJu0YxBk7I9pCfnWtE4N7d1LwXoh7n1I5nI6naDrOqHpvXZFOvs5A5l
 PDwL4hCaEQXSc5cXtCvocekXWCPL6XsmzYi1eNDGVA/62GINR438Ni1+A4oZUN6opWGu2rs2J90
 =
X-Gm-Gg: ASbGncuBbkV2D2i8lwZ0bjvFPvq1u0xN4Njcrzse9BLAblplSCkIJW9uCfJk0qF68yB
 wD9fw033pAzwe0fBK+/JUnHYxtVJ1pSen26MQ+3BlznxCtPmBnKPg+hSH8V5YEgAPi71GOrTT9v
 /YW5IERemIM0NgTCSjcdnB1ZOizW0ZZvpShA/6XM4p7dqCKDZVukuszxA1c5j4Tdw8jALKVc1WM
 +OkfSxSMvpyb4R1G/TIQ2gD8pyHchgVIjF6EyFsdEtmm4MLiUwMKdh2s8YEVVfZBjC7baCqBEdp
 2QbZJNt7RnSXoLhW1oh5QVBVWtuxdXt2IqbLWgZHxQ==
X-Google-Smtp-Source: AGHT+IGPtGEFXpIg7/6um0CU6e6s8zUj48s6+M3yqGdq4LvwDdkpXystTg4wWBkLFrS+kGLStX2KnA==
X-Received: by 2002:a05:6e02:349a:b0:3cf:b9b8:5052 with SMTP id
 e9e14a558f8ab-3cfb9b851f6mr148663935ab.3.1737917030200; 
 Sun, 26 Jan 2025 10:43:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/19] mmc: Allow controlling DM_MMC for VPL builds
Date: Sun, 26 Jan 2025 11:43:13 -0700
Message-ID: <20250126184333.4058848-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

VPL may want to use driver model for MMC even if TPL does not. Update
the rule in this driver to support that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mmc/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e1110cace89..a51494380ce 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -724,7 +724,7 @@ static int dwmci_init(struct mmc *mmc)
 	return 0;
 }
 
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 int dwmci_probe(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
@@ -749,7 +749,7 @@ void dwmci_setup_cfg(struct mmc_config *cfg, struct dwmci_host *host,
 		     u32 max_clk, u32 min_clk)
 {
 	cfg->name = host->name;
-#ifndef CONFIG_DM_MMC
+#if !CONFIG_IS_ENABLED(DM_MMC)
 	cfg->ops = &dwmci_ops;
 #endif
 	cfg->f_min = min_clk;
-- 
2.43.0

