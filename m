Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AC8C36002
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 03:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6118D82C87;
	Mon,  7 Apr 2025 05:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="cO7VIti7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E3C82C87; Mon,  7 Apr 2025 05:38:13 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAD782B7E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 05:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9033625E9E;
 Mon,  7 Apr 2025 05:38:11 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFmnaGZ6I2TT; Mon,  7 Apr 2025 05:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1743997090; bh=7No7SXJBFjZhWq+xWbP7o7akDZ0zSl4xrdrnDB1Ec70=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cO7VIti7slphOsRRYYfDE/TDmHniRfw/7+SKKJ2Pk7gNhrdKm8lZvNSRt5DwOTIOi
 jIbS9PAI5+nJmrtnBjcWcXywdCjesoHHAfKhzZ8yq98juPEY7KeFgTa7OfVqkXSAwQ
 eHeIdfK4+KtDxtqNq/ft2dOxiCXFxLKaej5u5B9zqK9R/UBq69cjchFAHVe7VTSW04
 G2bkrqbK1iO+AwwzlY9ZwLBvgEbZkB7Xum78Hss83MuwSl9YBUy+dOaYKADuYHIuDP
 PiVdcLpvTls5yGHlctWGCX+RvcUBkRI1LwtfsrQI+kgAX/OcA99JlKnv6ezlQMfnpj
 o8a4MkQSBXIqA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Trevor Woerner <twoerner@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/2] spl: riscv: Disable SPL_BINMAN_UBOOT_SYMBOLS by default
Date: Mon,  7 Apr 2025 03:37:43 +0000
Message-ID: <20250407033744.4025-2-ziyao@disroot.org>
In-Reply-To: <20250407033744.4025-1-ziyao@disroot.org>
References: <20250407033744.4025-1-ziyao@disroot.org>
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

The default binman configuration of RISC-V wraps proper U-Boot into a
FIT image instead of shipping a plain image, thus there's no
"u_boot_any" entry by default. Let's disable the option to prevent
binman from looking for a plain proper U-Boot image, failing the build
with message like

  Section '/binman/spl-img': Symbol '_binman_u_boot_any_prop_size'
     in entry '/binman/spl-img/mkimage/u-boot-spl/u-boot-spl-nodtb':
       Entry 'u-boot-any' not found in list (u-boot-spl-nodtb,
       u-boot-spl-dtb,u-boot-spl,mkimage,spl-img)

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 common/spl/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7d6780936d1..356ddab38de 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -214,6 +214,8 @@ config SPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in SPL"
 	depends on SPL_BINMAN_SYMBOLS
 	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
+	# A FIT image is created with default binman configuration of RISC-V
+	default n if RISCV
 	default y
 	help
 	  This enables use of symbols in SPL which refer to U-Boot phases,
-- 
2.49.0

