Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB00AEF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79FA83DEC;
	Sat, 14 Feb 2026 05:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QAd0hjI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65EA83E0E; Sat, 14 Feb 2026 05:57:11 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D884383DE4
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D66010FF8D; Sat, 14 Feb 2026 05:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045029; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=q46QuP6OI4V+ZbJC55JMxxthou7tHZn4mk7v3+mU8dI=;
 b=QAd0hjI7quwAUitom9/ZEwLyBfqKr64O6ykCT3mWciAjiQi4REOMc/15yBJLx0CTMNrqP7
 cE3+gZFnezvKayrwwjYdnbVhdqFOGPpL2M9dfwvHc68HX1tYhNh/w5qBYeNMTz2C6kY5ce
 IDrQWFgiR65yHd6mPywQSepPfpv5+rivTriErpw2g25X8nDuxe3tSJyErG14qNlsZGzhKP
 1UfH1AKhpXLWVpYiqpm/YpKI5t6EsbZHVZ+BDMrDbEXTkhuKpaTxSkMmSFyBE3riM5Ixz7
 wHhuTkO3KkZU2ohkbPUbjfjLDqAp4uIGav1Xf47z7L5OvFQqA3Vm8swkrQAWQg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 01/11] arm: dts: capricorn: pinctrl_usdhc1 cleanup
Date: Sat, 14 Feb 2026 05:56:53 +0100
Message-Id: <20260214045703.28051-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
References: <20260214045703.28051-1-hs@nabladev.com>
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

From: Lukas Stockmann <lukas.stockmann@siemens.com>

gpio4.29 belongs to eth0 and not to emmc0 and is
handled by the mainboard dts and not here in the
cpu module dtsi.

Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
- rebased to mainline
  b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2
- respell the commit message as Peng suggested

 arch/arm/dts/imx8-capricorn.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 3734a9d21f1..38d36fafbe0 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -63,7 +63,6 @@
 				SC_P_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000021
 				SC_P_EMMC0_STROBE_CONN_EMMC0_STROBE	0x06000041
 				SC_P_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000021
-				SC_P_ENET0_RGMII_TXC_LSIO_GPIO4_IO29	0x06000021
 			>;
 		};
 
-- 
2.20.1

