Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463B9C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAB588585;
	Mon, 10 Jun 2024 03:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WBFkq0Tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F4A8857A; Mon, 10 Jun 2024 03:13:01 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACC988581
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f9a4f9923aso350234a34.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981975; x=1718586775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqkE2BmuwICkL3yAL/WT/Aadg7mmPS2fm9a4jxxx2l0=;
 b=WBFkq0TjJusqHMk3FQ9PIhyhMuhEDX5ebRrkzYpmm0Hdc1fhFdE/4T8IXgqb/htkXG
 OJSZfrQXmqna9axdMenqAON6PbAS5PhA57eNIu0O6RQbjWiZZ8Gb7IPPx+8/J9wM+vOy
 SOzuHFHc8ao+kR35Jmc2C36sUIJd3XzLCleoPr5Rw0HTuDsNSIYbW+6NM0eJIm6j20BE
 q8Tvt4jo6Nz95zf8OFK4aNaH5/osTUa3YAjVILQbWO9b+lqGd9asbhjtSNOHBoIs+aj2
 vlTP3I/92WV3BuroPj3rycAcG+CtcoM/Jh3avC0SiyVULidbKhl9x03UjcQku0WIXLwz
 bxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981975; x=1718586775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqkE2BmuwICkL3yAL/WT/Aadg7mmPS2fm9a4jxxx2l0=;
 b=ghe336GTGOwwQjp1r28FCWKM3ZOtYE0rSzqIDvhNVTGv9+FiqFiGPzrS5exoyBvRzO
 G0vsk4wp0iV1mfMSpwIXGnkvUiBBk7RVIFZqdLDxw9sv5isbApgoCVMjWA4mDNTd75TX
 Xh4c3IPHpL2VZgjvClIxWJa5VVqfaxFszJ94XzNXkKiYbIa6fuex7pzFw8g9zmiT3482
 SOuWMGQ9oNR3IiEHBKoed6U3mLywVynzSzpshZMEEB9kBZMW1cMGMGYuW0DWTQ8L4tF0
 2tSZkXeTee026BojTpT0YLbIcFz+YKIFEN1NQ3X75OHsn4HsheK/iXcWNj2ANmF20x0J
 xIRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs2PJCTvTdzFGKmwDgzdu0mDqw7hZJxGObDGJ85GqNvvR5d1tol4eDg0YKGEINxX5Xxn3yS0puUJfLlHmcbTx1+LBwow==
X-Gm-Message-State: AOJu0YyrB0mbs8d5A4jw5Niu5K0vxNU0a79s2PQzi0d0mPp/uiLH5F8t
 O271owfwWjpp4EhJyNn5Tyo8BmOSvetHjCq5HNyv4Vge6L/kbj88LyiHBn4zwOc=
X-Google-Smtp-Source: AGHT+IGhg2FTv/XgIJ0rF563YyNQrbx31YtYW8b+BkmBwLlfyyMqlFK30ypRjVqM7yFZsd7j6wUttw==
X-Received: by 2002:a05:6830:12cb:b0:6f9:c7f6:8fd0 with SMTP id
 46e09a7af769-6f9c805d3d0mr505444a34.4.1717981974876; 
 Sun, 09 Jun 2024 18:12:54 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f988a89d3esm616939a34.0.2024.06.09.18.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:54 -0700 (PDT)
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
Subject: [PATCH v2 39/40] configs: e850-96: Enable MMC
Date: Sun,  9 Jun 2024 20:12:25 -0500
Message-Id: <20240610011226.4050-40-semen.protsenko@linaro.org>
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

Enable MMC subsystem and DW MMC driver support to make eMMC functional.
Also enable a couple of related commands so the user can make use of
eMMC from U-Boot shell.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 38b9968c1671..29ad31d5f8ed 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -9,11 +9,19 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xf8c00000
 CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
 CONFIG_SYS_LOAD_ADDR=0x80000000
+CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ABOOTIMG=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_TIME=y
 # CONFIG_NET is not set
 CONFIG_CLK_EXYNOS850=y
-# CONFIG_MMC is not set
+CONFIG_MMC_DW=y
 CONFIG_SOC_SAMSUNG=y
 CONFIG_EXYNOS_PMU=y
 CONFIG_EXYNOS_USI=y
-- 
2.39.2

