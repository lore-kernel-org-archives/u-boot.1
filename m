Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A401125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591A984127;
	Wed, 11 Mar 2026 15:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="xuYTerpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B5E484065; Wed, 11 Mar 2026 14:31:39 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB0684013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so32072785e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235897; x=1773840697; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8KYX8/TVTBRyymQSXEbIv+fNoyhQSVlUGunEvgtqY3o=;
 b=xuYTerpBIR2E0v3lDguil2E0dO7SsEw6cJH86o0sxc4HwNsOcsIGvfyfhbRwT9/1n1
 4ax60MP2paJCCSH2CtYc5MIDk8Xttz5nKJYNscCanNsGxROJC8oKbyRUvZpN+EiWJ5OE
 Fkz9tk574rXitCJHVf6FSigWYEweNRAb3Siw3fetfPE1K4fyBj8JHU08Ya3I+E53Amd1
 g3j3soZG+bTrT+jQCLS+sfsP5RunzTYOhOT/v8f7IHNLgsmhrpYPp6qYSVoOr/42pBzK
 Qe2bvqb+GLgwhU5KQ2czxO6WQ8xxjzJ7kfte+bqXnJF2G7ArKwrzD5Ree+ce8PgohDO0
 2hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235897; x=1773840697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8KYX8/TVTBRyymQSXEbIv+fNoyhQSVlUGunEvgtqY3o=;
 b=op8bdQ95cCETbhQBqLH9WV9wt0cKjFwe+pLhLsnpH5Ur4Wwr3t2aJ3oGhPeddo5sQN
 HElTGIdl+PZASSBOsBjWOtRfM3EJafU9dfQd3eo0l+nHyOaHasxoOvYf65jhGcRLlRrQ
 WiUWO0O6lPRmfM+2UVXGIwV3rWhox+yT6bgQgNZZZH7AzzbyTTtS0ZowHmA+bt+dw3uS
 nD7g0nIIkB5+JuxTMbkubniY4/ef7zRrrNsjl9+XkkzvYCu0N1O+cEGcf7OgDE78xRsp
 DBsuewBgI2vri8ZRn92FPZWv17+mnPgyH/4onNvYeQQ0LpM4csx3FhRWqsQPl91utjLq
 Ed6g==
X-Gm-Message-State: AOJu0YygCQrPnuNUo8lLprRoAXwPYtJMtcOC0/oBAVHJnY1btC8IXq4c
 /tAUz9AGqNdsbrwZhBgiDDweVj+wz/dX7AW2nyTy/VWh13uB24q47q/h/rzaCMYa11s=
X-Gm-Gg: ATEYQzxiM18gWzMZy2cVfarlTsZyxdWiP3jorlWblmdviGXywRiUMZP+h+tP3czq2i0
 dLkbo9vb5+O64v5z0vz7Lmi63tBo7aoSibQqx1vvN4icXr/5A/ZmHU8S6HNBJ++jJTATBzhRAQ5
 GO+tbt+TFIl+QYb9VHr4XLOvPkJERtEBbsHL92pGbwruvqz6ZSu8fVcCCmfnonZvi96ZDC/SvE2
 Szev3SpN/iUx3ljBiM1mvo/BcP5gCeF+zNpxwCMlvLbeHFrQxLxf6TvMockEzk9fKVRbzMAEtZ5
 EwaWHpVPc8S4Nrnn7WWTPTj2iisUkUmKyGVNpcp3gAnftaoqRK/d+gF/MHT9yUu3rzpnlySdjRl
 7DtKYGAXUm82HFJ/nBD8S74OzLtcwb7ZJH/Ze1uQ65ZGQD/MeOnUjWD4OznOs9T/ZQvwgiHgL2s
 AhZ5KtaRQn+PnyguuOylwpxPoFV3+L76U1vcxkbf6bVLnW34+IN7NlGYo36Fp4dgNDXc2VStP9P
 OwUww==
X-Received: by 2002:a05:6000:611:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-439f8423adamr5123499f8f.41.1773235896498; 
 Wed, 11 Mar 2026 06:31:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 17:31:00 +0400
Subject: [PATCH v6 5/6] rockchip: rk3576-rock-4d: Enable UFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-rk3576-ufs-v6-5-c7c353739242@flipper.net>
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
In-Reply-To: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Sz4sd8mpR9rgEVDcJXlfKtHAY7yV0t+UGOReJe/tGZk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFvwbd/O6eyCwcJply/0G0p03GqacK6/XEyZ8/Yaz
 5CeoiWiHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz1E21GhjWqiebNs6t2z30cXBM4/4Piw6f3Z9be/f64MPLen6AXhfsYGXrbZ2u
 4/u6rbruldJJNWGPiatHAxkNyMw/PuDe9NaS5mgkA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

From: Jonas Karlman <jonas@kwiboo.se>

The Radxa ROCK 4D has a eMMC 5.1 / UFS 2.0 module connector.

Enable UFS related Kconfig options to support booting from UFS storage
on ROCK 4D.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/rock-4d-rk3576_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 140a3e0ccd84..4c0827764d11 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
 CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-rock-4d"
@@ -19,8 +20,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-rock-4d.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_UFS_SUPPORT=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_ADC=y
@@ -30,6 +33,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_RNG=y
@@ -56,6 +60,7 @@ CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_RK8XX=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -65,4 +70,6 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_UFS=y
+CONFIG_UFS_ROCKCHIP=y
 CONFIG_ERRNO_STR=y

-- 
2.52.0

