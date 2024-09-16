Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287FC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 21:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F4B88F3A;
	Mon, 16 Sep 2024 23:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OydwkZS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AB288F0B; Mon, 16 Sep 2024 23:04:05 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053B588F20
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-277f35c01f5so2340134fac.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726520641; x=1727125441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO+ITt5tznvQb2RP7JyZvQNe0Z2DkBEU84LbgQ6fzII=;
 b=OydwkZS3Kw8mbDvKtdkiWJJe2/7SpdVjIfGOxm6/2+eeo1RmnXiaL14ZX/wmr9b3AC
 dDEwTgY222k6j+Zzr4sYWWedw1hiJlN1Vn50GjhW9PgRzkh64K9USBk9DMEvXuqjRjGH
 UdoVpylAQd9XT9a4a1Bu76YZSgSmaMXv6f3V7SfCUToi45ZiQjL5ENdbMfBXPkfQukdy
 1el7oG7cTh2iVKy2sOHSFoM8CuDKh04pLRYLn+98jF7h6ZQER58uNaYM/3Qg1Ay0cSVm
 wl+3hZKpSmUUPzA8X3+gVBmNTBLqsGC40oWQS2eC5h45bcvO5h48vDb08ynM7dIe7y6/
 6gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726520641; x=1727125441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO+ITt5tznvQb2RP7JyZvQNe0Z2DkBEU84LbgQ6fzII=;
 b=hmmhn0Qcc/TS6i+PgVbNG2qdxVaNYCRPwaNGQRoRCnOewyjuSH5YpSgj0RXP2uDPHK
 OavH8jMYV8XnC6Ppca78EWSbyh1sKo/RgWC1pH7EGK55UOMO2P2jxI82bLAAbOoXDDSr
 JtWG5ukU90GAKCJDKsO5QaI7do/kR2L7ZEj9Zm9Vql9VnI3ajhFhbjOrTMjuGB/jqFG6
 SgWGikgFDuvM5lWQ0VD0ZK3Vu2eQs+NlGyiVOomnoM9nZDVdMlX/kvppjz0Zat+IGn8c
 HvH1XOxwi42vHKyryEL+/j2MbWkvcC1oxzDjve8WdY+r71Kx++Gts6dXYnJtya4k5oXO
 WrAw==
X-Gm-Message-State: AOJu0YwARp/pCNnTR3IDoor4dhn9EXBnRXW0iqbYyAI8fouV90mq5WTW
 RfMUPlfUsWrJZT1ttyW2KNxPDy769+RHXjUsGxdC7rPWknPOaL4/3b3HlBsn
X-Google-Smtp-Source: AGHT+IEBKzbym0Owemp0e1AuCX42i1n2cXwofIBgF7XGszpCW6ME+ywbf3Bys6SUVNgzC/wAwnQpqQ==
X-Received: by 2002:a05:6871:8f8b:b0:27c:df1d:85c6 with SMTP id
 586e51a60fabf-27cdf1d99a1mr138437fac.8.1726520641704; 
 Mon, 16 Sep 2024 14:04:01 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:a919:5ae5:ea0e:c71])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27c95990905sm1745300fac.58.2024.09.16.14.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 14:04:01 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3] board: rockchip: Fix panel detection for mainline A-TF
Date: Mon, 16 Sep 2024 16:01:37 -0500
Message-Id: <20240916210137.182493-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916210137.182493-1-macroalpha82@gmail.com>
References: <20240916210137.182493-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The current panel detection logic crashes when the device boots with
mainline A-TF, causing a reboot loop. It turns out mainline A-TF
doesn't enable the VO power domain like the BSP A-TF did.

Set the VO domain on and use a memory barrier to ensure it is powered
up before we attempt to do the panel detection.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 13 +++++++++++++
 configs/anbernic-rgxx3-rk3566_defconfig    |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index c1d1826fd14..f4e7c1ab360 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -22,6 +22,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define PMU_BASE_ADDR		0xfdd90000
+#define PMU_PWR_GATE_SFTCON	0xa0
+#define PMU_PD_VO_DWN_ENA	BIT(7)
+
 #define GPIO0_BASE		0xfdd60000
 #define GPIO4_BASE		0xfe770000
 #define GPIO_SWPORT_DR_L	0x0000
@@ -311,6 +315,15 @@ int rgxx3_detect_display(void)
 	int i;
 	u8 panel_id[2];
 
+	/* Disable VO power domain power-down */
+	writel((PMU_PD_VO_DWN_ENA << 16),
+	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
+	/*
+	 * System will crash if the power domain isn't enabled before
+	 * we start trying to talk to the DSI panel.
+	 */
+	wmb();
+
 	/*
 	 * Take panel out of reset status.
 	 * Set GPIO4_A0 to output.
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index f5e5470df8c..49d3766613e 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_ADC=y
 CONFIG_SPL_CLK=y
-CONFIG_ARM_SMCCC_FEATURES=y
-CONFIG_SCMI_FIRMWARE=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-- 
2.34.1

