Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97ADC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF0183C61;
	Thu,  7 Aug 2025 12:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754562322;
	bh=z3654EUGwTGGHFQiTWCOspOKiW0f753v2e9FWcF0ECM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0sf7Nq7N/OpuVYrWIXVMqo4KdEdI6APsj8f9iq8HjT2XeFRmizAYxNx6DGnFzBxT
	 jwcU4nDDh4FN35sQ6VVg6Gb5VXJWJtXgkbOJfwJ1uEYNtH6hq8gF+NNsg5MGXNBym+
	 29YSW5mzsouHxB9hTZE1xkrnSAxsQPITw4rj8/Ciowb/dv7NqIDe+lD3AtDa3pz4w3
	 j6gRqsq0lTK2fuNyaZ4q9CY6Tu5JNs4Cy0ANDd+xvM0EcrudRvRmpjH9bDV2dfpV9I
	 UsTEBAm1s0C55KZ2jpEBiht99VvSQWmtJYayEakowl+Evgt7NyHHhUhyEgW8zxP+jL
	 2+T7p2AiEREeQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FE1844D2; Thu,  7 Aug 2025 12:25:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1723C83C53
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YB3bW4Jh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 26B871038C12B; 
 Thu,  7 Aug 2025 12:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754562315; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=z3654EUGwTGGHFQiTWCOspOKiW0f753v2e9FWcF0ECM=;
 b=YB3bW4JhtPnS68Nyf/XPYia0gOZ99QSeXEJ5YZQQoe4FhK3Wofqqiu5kWsB4kuLimP09wO
 uC9EUTXdVQzzRk/6YyipAgJUcWlxX4w4NmJgFnYoF3Hqlix/U1US2a29lwflYf9EA+RUzR
 IpTE2EkxsH9h3s5j9cjLgPAERsfc2zVCENmbrXZicJ61DN/i4YhQeWW7RGewK1kM9SJDFP
 trjpXKQlKuI4YULvIXu6LcT7s2q7bth9pgLRYIgA3nJGHyvJI8CRdOAkUTn2vszl9rVcDZ
 HQwO5d+QNeT1cGznlSmA99OvtFWge4yqaeX+2ZBjm5ekxRZFms4mW2wR4NJ+CQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 3/3] Image size checks: Simplify help text
Date: Thu,  7 Aug 2025 12:24:36 +0200
Message-Id: <20250807102436.452691-4-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807102436.452691-1-pro@denx.de>
References: <20250807102436.452691-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

For coherency, use the same help text for all related size checks
options. Furthermore, simplify the depends-on logic.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v2: new

 Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Kconfig b/Kconfig
index ec20603883b..490a706101a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -543,10 +543,8 @@ config BOARD_SIZE_LIMIT
 	default 1048576 if RCAR_64
 	default 0
 	help
-	  Maximum size of the U-Boot image. When defined, the build system
-	  checks that the actual size does not exceed it.  This does not
-	  include SPL nor TPL, on platforms that use that functionality, they
-	  have separate options to restrict size.
+	  Specifies the maximum length of the U-Boot image.
+	  If this value is zero, it is ignored.
 
 config UBOOT_WITH_SPL_SIZE_LIMIT
 	hex "Maximum size of u-boot-with-spl.bin"
@@ -558,8 +556,8 @@ config UBOOT_WITH_SPL_SIZE_LIMIT
 config SPL_SIZE_LIMIT
 	depends on SPL
 	hex "Maximum size of SPL image"
-	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
+	default 0x11000 if ARCH_MX6
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
 	default 0x0
 	help
-- 
2.39.5

