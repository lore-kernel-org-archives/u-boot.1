Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1478E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 20:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E190D8031F;
	Wed, 11 Dec 2024 21:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFYT8JOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853B38021C; Wed, 11 Dec 2024 21:11:34 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EEF80200
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 21:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5401c68b89eso1246832e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733947892; x=1734552692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnOLETI6XvBossxqWysqeWENMCBXhpCMt7P1SNIL/rY=;
 b=gFYT8JOcQQgDp4+nc1DgsM6bvEkD21huzoY0dJaGjQC3kFznIXUumqHI0zTg5KeHFO
 UwevSO0vkzQhG8tVjSQ8kJ5ctw3S+3mYFyJqpJZdMt2qTmFoU/np7JkxLoPqwsv4e4VA
 QyjlmBvZIV782eN66/4qHpISnIzSRoD4UCNLPzk4GOAod46BIPFn/jj8rgOXkmUDkWGu
 fnxJBtG5qPfe0Eq4A4HdYRzoHgSB4RaDDvD9551NvPtFoO65/fvuDS1PeD4jjZArZyLL
 jMzK/pJT4q75Es3NVngSSZru9hOfnKTUfbKgcWlti553hn7FhOExtTxIpmGu+vR0Z7It
 D2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733947892; x=1734552692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnOLETI6XvBossxqWysqeWENMCBXhpCMt7P1SNIL/rY=;
 b=Zs676T3TXSqadBy2aD4jmF5px9Df/WxRHkri5ZpDWculZiXRpbxJtskqLR+OjnkxSs
 pSxIcQmNWh2im02Lpq7o9vhdtoFktUWUctjcCSrb9FZMlVm41Fp0O6iC/j1dvbXMTs/D
 DEst+DPcYIBgMit2tQ6lM/sLM0MvGBKZWkd0mfDvCbwmW+XoSm/lRII7LEKsL91WQqda
 rty6dVxbc4YyNDmB7/5svMw1mM00bIXW6x8qrlW9R8LOfbh9ZuySV2stqInku0GgmGWP
 DxFAtkxKN3aMUbBTVM4ZcviZwTJ81nnGymaMJdC/zatj4ZCu/kuFtc6uiIwCcY0XUykM
 LtnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjTrR4GcTQPI2AO679lej0ejrqT5nB5eNfjMgq2gU6Xf/ScK1HYqVD/myB7Ir367W+hKUdrlk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7R1XC9W2MiVLvqv0yfU5btgVykb96fVGWeUaLtoCxTWMal7t9
 6h+EU+JXFgR7be6NZ3aJMiz1zAg4uKqI8mG3wCBlQAQdXoMEmODA
X-Gm-Gg: ASbGncs7aYqhfdpmMjbhX2rSa4mAEiYxL2y5TJr5fDJbUA257AZU81lIpzfUACBgjxs
 fZrB4LpDOXACESIA2pDPwqc49I8yUdRWm6iAypXfJSYouthYtzoIrXjw9omnxy/514XiaFZvPmq
 6mslTCZwm7gq+U2IXTdjsHwtO6V2BdZaohuLnlrkZfXGObGdSAOqz/MPtBlAxXECrl1JLUoZ+Ex
 DdMOi7gXvEYyP1ZDJawOKMQNzqCdL8GcE1cQbKPqbkWxl7AHRE8MdQn2O9XT0Z/LiyNIg9zdR6/
 jDlgI9m2iqliTw==
X-Google-Smtp-Source: AGHT+IEHVpaLeXyyxKogrCN5TMieJSkw/4cLOaKOofo6KGIgmdHb5HtmXEpKP4rhrSLcpWvX/rVMpg==
X-Received: by 2002:a05:6512:2391:b0:53f:1d9b:d4e with SMTP id
 2adb3069b0e04-5402f972a48mr193398e87.15.1733947891500; 
 Wed, 11 Dec 2024 12:11:31 -0800 (PST)
Received: from wpc.yadro.com (host-95-152-63-227.dsl.sura.ru. [95.152.63.227])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5401ea77d14sm1107401e87.113.2024.12.11.12.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:11:30 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/3] configs: th1520_lpi4a: enable mmc controller support
Date: Wed, 11 Dec 2024 23:11:01 +0300
Message-ID: <20241211201108.234285-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211201108.234285-1-bigunclemax@gmail.com>
References: <20241211201108.234285-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Enable driver for DesignWare MSHC. TH1520 supports all
speed modes up to HS400ES and UHS SDR105.

Also enable ADMA and mmc command.

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 configs/th1520_lpi4a_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 3b6ff62ee1..d13c97463a 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -54,6 +54,8 @@ CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADB is not set
 # CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
@@ -66,7 +68,14 @@ CONFIG_NO_NET=y
 CONFIG_DWAPB_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
-# CONFIG_DM_MMC is not set
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_SNPS=y
 # CONFIG_MTD is not set
 # CONFIG_POWER is not set
 CONFIG_SYS_NS16550=y
-- 
2.45.2

