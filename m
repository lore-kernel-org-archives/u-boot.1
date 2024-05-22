Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D20C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E458889B;
	Thu, 23 May 2024 01:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PZDLTFyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5D08851F; Thu, 23 May 2024 01:32:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3248851F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f0ede03023so613515a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420730; x=1717025530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qjtx61ChieQWPWpf4GPgql1HGNGU26CgOdDr++TN9mw=;
 b=PZDLTFyuNadIoeVXcdEdSWZRyKuaBb4e/sMcsmKDn/9jAnh7JeGFRIEC7nDr046STF
 YiI3/aRyFZaWAHytF06AZ8qhe32z13cSVId10RuFxCfE5OOZ8ybPGjUSITeQUSAxaKM2
 QIGe4dLqWJN/GaTKzUsJ5stUhWGeErkHuFsUu5y4Aolf6YH3P9WLqlgAfxpKXy9Mmehk
 oiV4Sa5UT8MWlGTqPqv1zyDY5S8lLIH0KKweOxk1RJEsJYVt4m4y/pcHNUzniK71fZhB
 Lp44NyrBPTHzO5btzcG6m5be81rvW6vsi+mkYXEo2HTqd3KpoGD7coWSiKo7UFCaikwa
 AiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420730; x=1717025530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qjtx61ChieQWPWpf4GPgql1HGNGU26CgOdDr++TN9mw=;
 b=uTbNIgjvvAqdGS1CxN4aMhuyDi8Pzzk8cA7bXaZUIz8ZrQmhTCy9fA3ZrIperRQJDW
 8+hYrQ/+xosrBKkQKeTCpH14oBQdLsaZgSnm2vxbanDmHtmNzEn5e8Yq7kNZIf/Y7ZMW
 1+YF/VbbZp4A3srv4ymVd+8XYv5rUp1nwTAGAluCiDyllw4DwWWStGGieAVqjtsYuQey
 f3m2KhkVSn7x23sYR8MfHuc4GNTFW4wLH5AovIaz2EsGuHpjdMHIxrwSwsxBDTwAohZ0
 ZwkaPCc53atG500LtuHJKzfzVa8hZ35aRLAUkwuBCLmH+IdBqGO6xfVj52IbmG9bSECt
 IuKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXPVfCcdqL1KwYLV2cRk8RRvP+P+2eBRlZIVI21dq8B7Ij808gcxdDZHU+7B8CX00zXEIilZMJEcVWvh9qlJ0XkVlYng==
X-Gm-Message-State: AOJu0Yy1ze0gAs9CocFj4tyad26XcW0Is5+HBKyz+RplXPNSx/5T736h
 Ck7eB5h9MVnkXPqsVgbau3llnVSgGN3zeJutxWjcKKoA90O3fh1I0CoYqEyfHPk=
X-Google-Smtp-Source: AGHT+IHrL7zrHkfZgu4aMMbynYEbBJL5KKDof7iPHFM3vG73tcL8lAl2A+kD+dIUyLkNHHZg1+miTw==
X-Received: by 2002:a05:6830:f96:b0:6f1:248a:b5ba with SMTP id
 46e09a7af769-6f7d65af20bmr332042a34.18.1716420730172; 
 Wed, 22 May 2024 16:32:10 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f13ebc152csm1984544a34.47.2024.05.22.16.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:09 -0700 (PDT)
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
Subject: [PATCH 41/42] configs: e850-96: Enable MMC
Date: Wed, 22 May 2024 18:31:34 -0500
Message-Id: <20240522233135.26835-42-semen.protsenko@linaro.org>
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

Enable MMC subsystem and DW MMC driver support to make eMMC functional.
Also enable a couple of related commands so the user can make use of
eMMC from U-Boot shell.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index bb41635ff784..17054f25fe6b 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -9,11 +9,19 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xf8c00000
 CONFIG_DEFAULT_DEVICE_TREE="exynos850-e850-96"
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

