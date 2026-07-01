Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D972FC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BF384C60;
	Wed,  1 Jul 2026 19:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RLC9zOAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E922E84C5E; Wed,  1 Jul 2026 19:58:26 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA9D84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8b49639fbaso509527a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782928703; x=1783533503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXwzn/WBDbPRKrYNMxo1K2MV2WIvaDHxyHU0vX4r9G0=;
 b=RLC9zOAlyXFc7u5PRjtXqNrvNFONGxfER/5E3RkuanliRZsmz9VjzDilLj7yQWJNOb
 GYD8//iIu+Og9DZ5fj39f8jGBU9JPfaU8Kl8N0R6iXrVpXhUDdfvoZU95k423JWDhUoL
 o3sAO0ct4PC3ueDzXt2nOwc+i0Pv1aef1ihl/mVYtdCexryGXFmHMF59cg/aH2jaODUA
 S7Ag8HvjV+IhXyg7R7jxXVbU6Lxu4RTOOGRZgZcLbyB+sDDpVjsoP86UwzLTuHieVrG1
 QI7Twsr2/tT3e/+LdwkPKgdJlU84JBX43I8PjogNxJa69mxDw9sm14o7wF+gPBO4uXP9
 7PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928703; x=1783533503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXwzn/WBDbPRKrYNMxo1K2MV2WIvaDHxyHU0vX4r9G0=;
 b=CB+WYzJyiqHop6EEfC+t+MuTRtfQXx5EJltjJm+GukT/5M5oRcy5zXwOmHpuX+RJtI
 oOtvQ/fW8IwEHUxvtx8ylkfsQ3peJxev4+3GMnA1DuORqBT0kq5EOpvYoRqkKX1uSErm
 6tiP29PkWHBn2103eXbhCs752Qk5+ddV1+/wqEftivSAZ/4sOA5C7DAraVfRCwQteTzG
 WvGuXiEmqAw2FD4oBxrmhUYDDxGcxLVggZxaui7SMaEsPAEX6mN1Daxh8yO75h4PhEVe
 I66pJZ4pcohXjIQ0Nm1cVy8q3iuCBWZyFCQZ4NhZi/aWdrE/OMM/zbu3PBKhNKj1iapL
 MZGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qBPFMvEk5LNnFXbbT+lZFbLMHV7XQL1vb72nDDu0hXT3lblcAZS1Cf6KGZssxV93vz9UEBQo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4N81ba1804Un0hhd2vQdnajVrS/NbiaHSOf/dePU83UtDDFVL
 1RWJd6A25MjhsNl5n0j25rSsvXT+vUgn1CqCR2mMU4cU3EP7H4nRD74b
X-Gm-Gg: AfdE7clXzRhKQ3joxhwKwLEmg7VzfLZxMfTuksbshcWBetU9AWegrx+0S8UUXxp5d1U
 5NarrtbAm390RZGSMaBefITF6GGO+QWQdtVUpKlgGnTJnumlUWcrRJC+UG4n2CbhoLHI7TnUeKJ
 Gfbt2t01Y3DX+pk5F7eRArHtpU7Rcqp4zXIpMpi7Z/mOr4g1hnw590yWsED2wuB7+Ks39xL2xtW
 rebQCecs1W+oGWcyzYYj1RHpKDLPamkaDh7xiwFrHEfsJThErhNsuz7IDiRWiAlW+PL893y9OMY
 U/Wyc9S9LWD2WKt+KBfVcCLmJejZBHi7ZXqGf/LQGTv2yX6of+S6ZYMnGXi4M2EISi/v/P0+TpT
 acwoGkmG2KRDr4FxrSO/h8XBABHHlZip3xpBYUWlBI1kA5+wXFHhb31eRZx7hZ4OWLayd+Hupv2
 3S3iufCzUBj1SeoqMKo6yph9Tpb0Ju1bBDfDdjP8xVkJImqGtWadP/L4rsVX8VMnucUXhouQ==
X-Received: by 2002:a05:6a21:48d:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3bfed29d324mr2853898637.20.1782928703004; 
 Wed, 01 Jul 2026 10:58:23 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:5116:3bae:12e8:a7c9:dab9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm63078eec.27.2026.07.01.10.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:58:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 4/5] roc-pc-plus-rk3399: Introduce new variant
Date: Wed,  1 Jul 2026 14:57:59 -0300
Message-ID: <20260701175800.40141-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701175800.40141-1-festevam@gmail.com>
References: <20260701175800.40141-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

The roc-pc-plus-rk3399 board shares a lot of features with the
existing supported roc-pc-rk3399 board.

Its devicetree is also supported in the upstream kernel.

The plus variant has only a 12V supply. It contains a XMC XM25QH128C
SPI NOR flash.

Add support for the plus variant.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- None.

 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 9 +++++++++
 board/firefly/roc-pc-rk3399/MAINTAINERS     | 1 +
 configs/roc-pc-plus-rk3399_defconfig        | 4 ++++
 doc/board/rockchip/rockchip.rst             | 3 ++-
 4 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
 create mode 100644 configs/roc-pc-plus-rk3399_defconfig

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
new file mode 100644
index 000000000000..7d5af3e234da
--- /dev/null
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3399-roc-pc-u-boot.dtsi"
+
+/delete-node/ &vcc_hub_en;
+
+&dc_12v {
+	/delete-property/ vin-supply;
+};
diff --git a/board/firefly/roc-pc-rk3399/MAINTAINERS b/board/firefly/roc-pc-rk3399/MAINTAINERS
index 2c0de4432fa8..d32b078431ab 100644
--- a/board/firefly/roc-pc-rk3399/MAINTAINERS
+++ b/board/firefly/roc-pc-rk3399/MAINTAINERS
@@ -5,5 +5,6 @@ S:	Maintained
 F:	board/firefly/roc-pc-rk3399
 F:	include/configs/roc-pc-rk3399.h
 F:	configs/roc-pc-rk3399_defconfig
+F:	configs/roc-pc-plus-rk3399_defconfig
 F:	configs/roc-pc-mezzanine-rk3399_defconfig
 F:	arch/arm/dts/rk3399-roc-pc*
diff --git a/configs/roc-pc-plus-rk3399_defconfig b/configs/roc-pc-plus-rk3399_defconfig
new file mode 100644
index 000000000000..4ec2f7d44b5f
--- /dev/null
+++ b/configs/roc-pc-plus-rk3399_defconfig
@@ -0,0 +1,4 @@
+#include <configs/roc-pc-rk3399_common.config>
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc-plus"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-plus.dtb"
+CONFIG_SPI_FLASH_XMC=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index ae18b08031d2..b87d857a312e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -81,7 +81,8 @@ List of mainline supported Rockchip boards:
      - 96boards RK3399 Ficus (ficus-rk3399)
      - 96boards Rock960 (rock960-rk3399)
      - Firefly-RK3399 (firefly_rk3399)
-     - Firefly ROC-RK3399-PC
+     - Firefly ROC-RK3399-PC (roc-pc-rk3399)
+     - Firefly ROC-RK3399-PC Plus (roc-pc-plus-rk3399)
      - FriendlyElec NanoPC-T4 (nanopc-t4-rk3399)
      - FriendlyElec NanoPi M4 (nanopi-m4-rk3399)
      - FriendlyElec NanoPi M4B (nanopi-m4b-rk3399)
-- 
2.43.0

