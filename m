Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A58E909D9
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5834383D5D;
	Tue, 17 Feb 2026 17:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="TSvI03Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7591E83C32; Tue, 17 Feb 2026 17:39:18 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACB883AC5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3812110AC9; Tue, 17 Feb 2026 17:39:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346355; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=PGAS9cIXWUifCIyFPXqpgtQ99h48/Yqp0TSfcB25A4Q=;
 b=TSvI03RvAAiiyg9Dbet9vZj4KC67+do9pxfNe3Rgsv8UOm6N2u0kxYwoAnsNOzS/y27+J3
 +TYFcEXe/PeQruM03Dy7UUY4PcNInO66mB0S+tEqZKPWsg8PfJ41y8Iu/RW9EwB2Sx8E6h
 u9pnUMQPbfEqhp5z0SBt8wAGoHAfTKIvHlejZNb7mH3QsSEltmV1/147AUnlMXmpC7ecOT
 ZIA81jp1LV+jbK35FJK01RqjNJ2O+hy6/WJpjNxgEHGMeHMnEscYqHXtmstOcMn68lVk0Y
 IsS/XhVfe24zE2eU59wmu0L80idE/BIQS3vmUpFHhoGR9xYGxEd28h0h6D6W8A==
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
Subject: [PATCH v3 01/11] arm: dts: capricorn: pinctrl_usdhc1 cleanup
Date: Tue, 17 Feb 2026 17:39:01 +0100
Message-Id: <20260217163911.31878-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
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

(no changes since v2)

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

