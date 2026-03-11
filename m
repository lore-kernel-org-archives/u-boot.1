Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA41FD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3796840DE;
	Wed, 11 Mar 2026 15:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="swo+6tAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385A08404A; Wed, 11 Mar 2026 14:31:31 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FA884013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so9857662f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235889; x=1773840689; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rMch0JQB7yrW+6bDQFRQ9sVrY6C+3KX44Z7iiBWmdDI=;
 b=swo+6tAHR1SBs8P8N/YWJ48I4p0hAqtzKKk46tJj9WKUS8m2BJRFUTonDUC0WYJk5z
 9/29mJMPb8JGLWuFQpbgbCmdNfYX/DtoJNq+vc56MMMmCJSMaBuIf4VqoRJpFXVwFyU3
 99YBoAOUk6kjoH6djFgZOtvhiqeENRpWKY3kAcKlunraEZnM+uQl5kmPbCeN0uDHb8om
 oKd7peKJosg3buWq5NUeUe34L0fTUVappxplT5hvePCN6cn6ADTpaWy+D77Z5m9l0WQi
 oAt4nKC5fXtNgnC01s2V1/eWrGaqd0bILI3KwQJi4/AZvJDN5VjAlJAlw6IfsOT4Xci1
 iQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235889; x=1773840689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rMch0JQB7yrW+6bDQFRQ9sVrY6C+3KX44Z7iiBWmdDI=;
 b=OIETN7mshp4w5hGIfC+lwKe/+SQUXK5YpiLQD34EsWGg+ut/ZwahMsrbHkNab4o51T
 JKCDqEpO7enozCyUvgDKknycxZRPVuP4Gh6OeewfiIh0OCvNWsTMxz2N/2kebg9TH2Wl
 dOi2xZh1VjidJeYxEuKdk/VrOXElCWq/Bp3Z7yPK64g4uNB5oPgA1sDCC48rxafss+Ej
 S2kvN7BZJbTg9EREMlLuPY4ZtBHjtMRfZzOtgit+t0/59pDa8VFD7WvLAIS8OuTOfv+y
 mfO8pehdFvvYNUMM0CmIBXMkwsXNtpuuNfIGSSWZI4InEJ6mEnvQJQAI3LvjEMPgk9Ao
 pfHw==
X-Gm-Message-State: AOJu0YxWxkEtDcBtNVGUNz6Xi3M2qZLa0Aq3BvA+46wFaOBjZyJE8cqd
 5cSXk4V7W4+kBh/6Tqtjoh6IAwc4E8NeCbTxy7XFcWLpl2n49FdF+TdOtL559nMzx7A=
X-Gm-Gg: ATEYQzxb+ERVKDPiOiqwF5ZZ15XPZoPIhpECVtv4uafCSjjyhisog7EQIPuMSHyOJZf
 IjS+66A14I/Sg22J1OxZKP/CbkI5PhSYHLVnusqj173S0q7pENi1lwWb2CC7fyE0wqVvUFaAbeg
 DBBz4Wg/l5d2VlL8YvqqH98xuwLhdgUmOTq9iHVTsaNwXB9I6cX4yc7u0Rpzb5JW7YdjiShKP/o
 R+RJCRHLhmeMCDkgOv5yvLBM2ak3Kh1/9Y9r5R8atrdtw2WSzmviHpjZEdZjV+hLG02CFDsrppb
 GOnxiWiSpOoRJf0NzTR6tkTFfDXo5xZAft1mzrOsJyIEZq6iC30hdVl6hp9a7ZQLG1ypy7H35jv
 pgWou9bAjBoF6BIhUyP3QVaOEapTnCTwF6RGCVLMb04PVUTPvri9ykMh1NvHzKsVqp6vWd1avVL
 OgxomcNSjutFqaZ/OQmNE+AdyF+k0YUSlghHJLIPxO8Iox75q9EoMCuj7QCLFNZgRRuHEx9Y6hF
 aqKzg==
X-Received: by 2002:a05:6000:26c6:b0:439:b666:6c9a with SMTP id
 ffacd0b85a97d-439f8225337mr4975289f8f.54.1773235888570; 
 Wed, 11 Mar 2026 06:31:28 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 17:30:58 +0400
Subject: [PATCH v6 3/6] reset: rockchip: make device resets available in
 SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-rk3576-ufs-v6-3-c7c353739242@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1836; i=alchark@flipper.net;
 h=from:subject:message-id; bh=62mEHz13BHj+E1ghaYV7HpfcOZmPJ6XnFPWjuHvkcrE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFtw+FmhCwtDf40eX5W+5NPPqpWO9w8GhTAZxXxW1
 nXXDc7tmMjCIMbFYCmmyDL32xLbqUZ8s3Z5eHyFmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 DXWMdYwYuDgFYKqrtjAyPA3Jc2SxKp/QOfOn7YkQ2dvH/CRmPu9t/m7a/j50G0MtEyPDvP0730h
 xFDU/iPvtbOJ8jHVhXrLY90Uxp6u5p757VrOGCQA=
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

Enable the Rockchip reset controller driver in SPL to allow resetting
attached devices like UFS during early boot.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/reset/Kconfig  | 9 +++++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2fd91d6299cc..c8d2669d5e69 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -100,6 +100,15 @@ config RESET_ROCKCHIP
 	  though is that some reset signals, like I2C or MISC reset multiple
 	  devices.
 
+config SPL_RESET_ROCKCHIP
+	bool "SPL reset controller driver for Rockchip SoCs"
+	depends on SPL_DM_RESET && ARCH_ROCKCHIP && SPL_CLK
+	default y
+	help
+	  Support for the reset controller on Rockchip SoCs in SPL. Select this
+	  if you observe any reset-related warnings or errors when booting SPL,
+	  such as when using UFS storage
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on DM_RESET && TARGET_HSDK
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 088545c64733..9f4202c1bb65 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
-obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
+obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o

-- 
2.52.0

