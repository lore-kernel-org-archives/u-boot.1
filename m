Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02280CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C9F8357F;
	Wed, 15 Oct 2025 12:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB9C80107; Wed, 15 Oct 2025 12:23:51 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2FA4833C6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BD50EB220372;
 Wed, 15 Oct 2025 12:23:47 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 01/10] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
Date: Wed, 15 Oct 2025 03:22:44 -0700
Message-ID: <20251015102253.48276-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251015102253.48276-1-e@freeshell.de>
References: <20251015102253.48276-1-e@freeshell.de>
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

Relax no-sdio restriction on mmc1 for jh7110 boards. Property was
introduced for StarFive VisionFive2 dts to configure mmc1 for SD Card
but this is not necessary, the restriction is only needed to block use of
commands that would cause a device to malfunction.

Signed-off-by: E Shattow <e@freeshell.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ upstream commit: 481ee0fcbb9a0f0706d6d29de9570d1048aff631 ]

(cherry picked from commit b4e73596622f791e3c2a2449022671e4e579fbd0)
---
 dts/upstream/src/riscv/starfive/jh7110-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
index 2eaf01775ef..a315113840e 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
@@ -299,7 +299,6 @@
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	no-sdio;
 	no-mmc;
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	disable-wp;
-- 
2.50.0

