Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3483EC7115A
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 02:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8578C82CDF;
	Fri, 20 Jun 2025 04:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YlDqt+pT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE3082D4A; Fri, 20 Jun 2025 04:26:02 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165C682CFA
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2da73155e91so396068fac.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750386359; x=1750991159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsNJfwr2fJiSrXwNpDjvOnZDK2i4Yf3k1Rg19bpt+yA=;
 b=YlDqt+pTL9KVkT6vcNm6BrNDX22M0y2+ZMjULyg0j0EmX6xmJzUPUFy7L/bSWr/xh/
 5triXK4QfDu6NUcjKo4CS6wiP8kp4ym2CLsj9NacdT7Bm2o6/plUi4Sc/XhYd+y2mI1q
 Ez6VwF7vQ/M1TjJJGsV7KroKweNcJAEINiA0t7KT3OJGYGBXp7OeEox6SFhPC/swzAte
 zdbdMzw8vf7LAOk856sEYmipPwHNlfTwndz0cSuB5qsTf4AZd1wsn8D66ZFOEQQ/3ihO
 WLwhziHQ0+deYjE8rTvWBFu301mxCwd3qG2tUAn5Imo0L9cJnoVn/XzmnByTQpVDsBq9
 CP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750386359; x=1750991159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsNJfwr2fJiSrXwNpDjvOnZDK2i4Yf3k1Rg19bpt+yA=;
 b=E2uXpK1BBgkfhJUK0nqDzIX7zZlEPLZ8BJ+7S0mft37ag0+pVRxaaWWmMX3bAsk/rT
 9wuCcGxOk50s7u/+4JM3Ay3ZbGcWGcBqSiFcNFZ4SOqzWOaKTemgnc4mXPkBQqXrh/FW
 9t7U1ERngcADOBDDs0YnQ3CtGgjJyWucnLTZNSx8tu3j09W68ZTRXNBrWfe48iuNNarl
 X2Ih+JIDTNr9XwcgQymQ9J1dhMYMHMXxyxFAM6uhc6aElluIgWZuVtq1ucEf27Geu8mC
 aLwuiHXEj4R/Fmag2rY6QqNoOCHFpUhg1EiJtF0TX9waeVYKNGPJEY9mrTc/lQQqQrtq
 4rIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL9Apb1mpaLS6pDuAd9z7hd70Wdg82kufd4xpOxSO0zTW7iG295quEc/w5UUnJs/mp7fGr9wo=@lists.denx.de
X-Gm-Message-State: AOJu0YyNm2yAG5Qh5Mj3I1L/pzUD6mB/8xpGanYl/KNd0M1MtX2ClAs/
 UGKjt+KaaitUOUP5eyf+hsD8qzqG7/79XwL3466hWmltNoPhh8KxpWKu/Fb60kZ7LgE=
X-Gm-Gg: ASbGnct8wvzSxbwp30iv7UFWAlf8RcWVCMjACL6v0QN3DEEvXt66kbxASPlDloShmOZ
 htmKUG182XsvRPjewb40zJ1RECydflAMC7ZsQxDBlgO3e0hyLuQM76T8Zru8reqiN2TA1z6gk1l
 WR0T3ZcGEkdcf2uF946G/nNNJZ7rqXwx3SoIGmXgR5ODn77aJ+dKCHSTrO6XT7ZByB9k+KM10wD
 swkHa6SqKzL6jAYMw+gtv4Nfb7JER5//Naa7pp5Z0fMn3G1zlMq+wvJXlVzKoY4fqxL8HkcEISg
 2MbKguvwtTS/ULXhRfKm9BgBJH6blZxcbY9Dr6k/KEft6QCZVlwdbOftYVKkoaJ02NfYHyLv
X-Google-Smtp-Source: AGHT+IGrZ7nwg/mWkfdtlkembgghkFTnIldXu7BNfh/S8TZrMBlsj/hk3/zVfBAePRJ2FhlDGKTz1g==
X-Received: by 2002:a05:6870:8196:b0:2d5:1232:b081 with SMTP id
 586e51a60fabf-2eeee573ca2mr1028523fac.29.1750386358792; 
 Thu, 19 Jun 2025 19:25:58 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee665ae530sm195324fac.20.2025.06.19.19.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 19:25:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 1/2] configs: e850-96: Enable BOARD_LATE_INIT
Date: Thu, 19 Jun 2025 21:25:55 -0500
Message-Id: <20250620022556.10363-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620022556.10363-1-semen.protsenko@linaro.org>
References: <20250620022556.10363-1-semen.protsenko@linaro.org>
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

LDFW firmware should be loaded in board_late_init() when MMC driver is
already probed and initialized. Doing so in board_init() causes MMC
driver to be probed earlier, which leads to EFI disk objects not being
created. Enable CONFIG_BOARD_LATE_INIT to make that possible.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 5facd418260c..e4c6aa28e0b7 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -19,6 +19,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.39.5

