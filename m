Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338A3E7848A
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D6684320;
	Wed, 24 Dec 2025 20:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WLUcc3yG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5ECC84303; Wed, 24 Dec 2025 20:32:35 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED13842C2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cc50eb0882so2152173a34.3
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604752; x=1767209552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbagQZdVKUgMB/eRVCzV2d80/BbZcKNUo+hE9FgQZtY=;
 b=WLUcc3yGwh48+dDg7QhBdDpCMrP+ORQpmOwi83rpfEchonI7UlfCoDwZ/gaLxT8V1v
 xEYIt5LvMKdR1B9de7yHCTDKHsSlKM/CdPhtLh1EkznkH0rXJD3BN6xOOoIJ/0uSR7Br
 iaqrtOGxsnPYN18zypum8t2eVsN67uJaecRuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604752; x=1767209552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AbagQZdVKUgMB/eRVCzV2d80/BbZcKNUo+hE9FgQZtY=;
 b=I5z/ZBxviFpCSK0/cNoissfeu9aGbZECjg7JPBoT1K5/Os0eWbAiavIdeKA6/NZgYP
 jmy0oE5AqY5ABKKFhQifqJqkLEaDjs4deRqBsIba6lzoOjXXnt++RoUUkfVuDaW2dBrX
 q/n6fUTZeuFYSPuGifgds63nWTYvWGWYUIn8UKBirxxBzgvRmcQg0jvRDsMhn+kvOt51
 AWiLG5gJd36UKTZUkfZ5FNyGEZPVsmzw9YxL0UW+EK2b+ZKS4aIhbJXjLATHKTLgiTfl
 JGLZeVr0R8GkrlnH3+MIh78R7J4p5HlYw0O39O+WVWk8q7awNwFIlWypaD0SNjxEQfGs
 PfrQ==
X-Gm-Message-State: AOJu0YyU7oVbj6I2b7VxolkWRv60sIsH1/x6pfUJkGvhQpA3DfHB+7pV
 Ordqy03C8uRwMYIMyR3BE6/rCyd00SezyzampnA43jFCyqm4aUaSzn7flQeCoGlKeYnJQNVeDf8
 DS9+y5cg=
X-Gm-Gg: AY/fxX480v0NQ+1MAOQvXXn58Y1iHXdg76icIV6sooAX2YWAMDXSH5eY7HYBpHCeFsu
 gV3WEQ+umuDiy5upGyNYpF3st5oib79V3b5g2dxHMMFLLvKpBrHZ5WkPEaU5x0WnB2+BH5iJxLX
 yYJWpyjw3yba5GNVh5jb7JiZSUNsu9iXPWIaxOB4iHNhUkGKyo7h4CCDEtS3cixknlDK0sijgFK
 jwPYgJ2BwP3NwZJ4d2XLDIe+MbjXT/aIR9f18ueidmGP0aiA2uTmfEUjNebI2b5fFyVN57eBtgg
 J+rURQpMFB4tZYBo4c6cKZY1nkTqGWzcWlo5gaorydyvu30sx865jcKzTFZM0ZkDDHKbtCiziD8
 cAPUSmXXYTWIM/eJG+1Sf6vX9jXk7llE3g6F65s3loJM9FWfsyhDO1qHFP58zOG4FrxzBokjfC7
 THbvQdUpONezaigAh20Zt60CU9lmnI/nMOaxU=
X-Google-Smtp-Source: AGHT+IE7lhnTguYh79Wrc5s/Oj3Esoo70v/IRXE1aD2u2oni4LBG5uH6mPrzhlwbOh9ExRUWiRzPeg==
X-Received: by 2002:a05:6830:438c:b0:782:4423:223a with SMTP id
 46e09a7af769-7cc66a4b6cdmr8472846a34.22.1766604752182; 
 Wed, 24 Dec 2025 11:32:32 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:31 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Judith Mendez <jm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH 6/6] configs: j722s_evm_a53_defconfig: enable PCIe
Date: Wed, 24 Dec 2025 13:32:04 -0600
Message-ID: <20251224193213.802246-7-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251224193213.802246-1-george.mccollister@konsulko.com>
References: <20251224193213.802246-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 20:37:54 +0100
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

Enable PCIe now that it is fixed.

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
---

 configs/j722s_evm_a53_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 8639f462c128..43745f98de4f 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
@@ -55,6 +56,7 @@ CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
@@ -73,6 +75,7 @@ CONFIG_SPL_REGMAP=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_TI_SCI=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_MTD=y
@@ -117,6 +120,11 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_CDNS_TI=y
+CONFIG_PHY=y
+CONFIG_PHY_CADENCE_TORRENT=y
+CONFIG_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.51.2

