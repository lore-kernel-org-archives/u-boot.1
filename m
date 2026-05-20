Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CBECD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16A984895;
	Wed, 20 May 2026 00:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="rK2ozr6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92E78489C; Wed, 20 May 2026 00:50:30 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E04D846A5
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36974220e45so1652822a91.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779231026; x=1779835826;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rys0EgrKnVrUGXjmMI9wK+LqZWSyvwEQT6JziotZhaU=;
 b=rK2ozr6cCG6FQtDdoL/eEeTU8K87bVdAwnLjpf1f6cKlhtz6v6QSKoKUbpvuUannzQ
 rG4i83vqms5L9KFKh1EEM/ZYVV695wUNHYFXWwYICpXuxuAhCpBPBgeLKnut2OaENG8P
 ViLBxHxaCADWnENR+hqqmRkozK64pOA9FX7DZbrdJicVUzMYNBb6YeOMbhcY/UO91J1S
 6RVLnoPfZI8zFFT271U6J+yxP+NYUb4Kt49I6gT5e3LF99ePws7mQBgdJdCcXItNk9fS
 vtnGBFH/nO/YbjKSfsUX3KR2yJkgVyLBOVamYGoOkIpTT3twkBf4HsJZH2vaCsQRD02g
 OdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779231026; x=1779835826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rys0EgrKnVrUGXjmMI9wK+LqZWSyvwEQT6JziotZhaU=;
 b=c7GGltu9PhX1EVSDn7YQ2xjPURhubBgT8+Bt0Dfnn/DuE/HHgnRhbO3yIC1/gJ1oET
 FM23pbvuipGPPSIOiWkMiLzIJeGGolgWKJXpi0lzzQkK2eU0Vg65U+zIZBUTvf0m72gd
 vXM/LdB2eK89wx+aRZ0pPhme8zbNUdax1Fzmo66eTCrAqYXhhUTQfH5rYcZb44HRuMyG
 30MSqzKBIo+bHSJCcKLCyc4AWlfIZ0hHc0VWA/zQYZRodjwTaWE7DiUIi9ttvcoHFtRm
 dCzk39qEGuCx7lj0yNoLnWLXnPMy5rUCQWpyhWGCzmzHp24CUsHt1MsYfCfymdko7gBE
 ccVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VhHqnfi8SPQ+6U3zmpn7gKkHwHoLliCifz+6Iiej2cu2srSS1081k3L/0BgRExLDmNWyEwXY=@lists.denx.de
X-Gm-Message-State: AOJu0YygAx+W3CuIH/jPJ264ffaNXhgVP4iK8Sf+gD0wPNp0RKTeE95O
 jvJk6AT6AbK7UQwwz5ggqaKOo+6o7pMYwQ0qsyswgK+TckrRQUw5AAMXzIsHQj6BdNw=
X-Gm-Gg: Acq92OFJlHrOliUg1Ui2v3Ea6UVdfs9QMdFCw3iy8wkWZ9rOVQW7eCbLho1d/BbAhCn
 6hECeKKTP3jhMLIqrR6Pw2ZJPQxKa0FwnQyY+RDLa9yJ1kmRZg9oIFRNm1nnTyQqGXQI4QpmRm/
 lKSuq3OU0Is+3K1fmvns3mEPpqbUmt1VYj+uZ6luezGi9O7WppC/MNgjjrYPafgQsBO7L6aIdI4
 gD7n88h4BK6OONGElZVn9+c0VN89j+yKtnllszzhDigtuhMZR5h4JxKbSZDGMbneSC18Qdfi7YC
 TEU8t4vRtllqy7KmhCvvLFDB/+ySEvL2JsEW0vewENlrd92/3jUXYoa5FyvanrdcUXgSoAhVvLn
 n4IqyN+j8cSKAG1x7P3Z6EAejnKH6Pt6WSQZDXdetlOkwLDE7NCUhjIeWjhTOoLi1PfCYOHWaBU
 faEfDpUZqLB6kCNe/A/EIdRlJa5xn9/Ed7DZqjti5Gt7f4JmOLfniNjw==
X-Received: by 2002:a17:90b:1c0d:b0:369:e9a2:6b with SMTP id
 98e67ed59e1d1-369e9a202d6mr5467523a91.13.1779231026316; 
 Tue, 19 May 2026 15:50:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:50:25 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:53 -0400
Subject: [PATCH v2 9/9] configs: k1: enable pinctrl and gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-9-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

Enable pinctrl and gpio configurations for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- Also enable CONFIG_CLK and CONFIG_CLK_CCF (U-Boot proper).
---
 board/spacemit/k1/MAINTAINERS | 3 +++
 configs/spacemit_k1_defconfig | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 8976c575dff..32d47ecc8f1 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -3,9 +3,12 @@ M:	Huan Zhou <pericycle.cc@gmail.com>
 M:	Guodong Xu <guodong.xu@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
+F:	arch/riscv/dts/k1-*-u-boot.dtsi
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
+F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 465788cc2e5..0604c2feefc 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -49,6 +49,8 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
@@ -59,7 +61,11 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_SPACEMIT_K1=y
+CONFIG_GPIO=y
+CONFIG_DM_GPIO=y
+CONFIG_CMD_GPIO=y
+CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_SPACEMIT_P1=y
 CONFIG_DM_REGULATOR=y

-- 
2.43.0

