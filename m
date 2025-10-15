Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35180CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE4D834D4;
	Wed, 15 Oct 2025 12:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F2D835FD; Wed, 15 Oct 2025 12:23:58 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC228835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F1C54B2208CE;
 Wed, 15 Oct 2025 12:23:53 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 04/10] riscv: dts: starfive: jh7110-common: drop no-mmc
 property from mmc1
Date: Wed, 15 Oct 2025 03:22:47 -0700
Message-ID: <20251015102253.48276-5-e@freeshell.de>
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

Relax no-mmc restriction on mmc1 for jh7110 boards. The restriction is
only needed to block use of commands that would cause a device to
malfunction, which by testing and observation [1] is not any problem.

1: https://lore.kernel.org/lkml/NT0PR01MB1312E0D9EE9F158A57B77700E63D2@NT0PR01MB1312.CHNPR01.prod.partner.outlook.cn/

Signed-off-by: E Shattow <e@freeshell.de>
Tested-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ upstream commit: 08128670a931a4117f7b93c703d0186c67c9e1e2 ]

(cherry picked from commit cd5d4277d9515be5c10752fd8140f03c3dfec541)
---
 dts/upstream/src/riscv/starfive/jh7110-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
index a315113840e..4fa77ffd54e 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
@@ -299,7 +299,6 @@
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	no-mmc;
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	cap-sd-highspeed;
-- 
2.50.0

