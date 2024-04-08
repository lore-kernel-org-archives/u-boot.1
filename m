Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438BCCD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6852688103;
	Mon,  8 Apr 2024 20:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Wj5PNTeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD982880FB; Mon,  8 Apr 2024 20:14:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC4A87DCA
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600078; bh=yJR2Gm9aTAXoqXJyizETk0WKPuqMz1a4eBC3q4Mkkyo=;
 b=Wj5PNTePNnjXivm4MGqHTz3PI/ujrQM/NRvFe2aODelSVDKsoNMjd0u5isOiKZ7NIJRgtstLe
 2Ep71CplqNVAOtk6qGAlqqZUB3k1E2z8xk9XVTjTPy6XAW3HSp5oNiomlIpFBb3HSNxpIaGhQe2
 9G5uBPZ9rkawIN/4ismNs+YE8Y+ovkktde8MYdqwFKQpXiX+5IsCMzctYs46m8iuyvxbCu6upms
 xfvk2Z50ZrIPGRI2Vem6p8ImepDe4tvLKbrSWa7NMTHVdFE0roXeB/2ifidUwHYiTcBXoI3xVwo
 jWoMaTJ0csa76yW9ntjoh0bB58cwco2EmhhIUgKNPYFw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 01/14] board: rockchip: rk3308: Add device tree files and
 myself to MAINTAINERS
Date: Mon,  8 Apr 2024 18:13:58 +0000
Message-ID: <20240408181429.3676856-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6614340d45fff4c2aa5b49f9
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

Update MAINTAINERS files for RK3308 boards to include related device
tree files. Also add myself as a reviewer for the ROCK Pi S board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 board/firefly/firefly-rk3308/MAINTAINERS | 1 +
 board/rockchip/evb_rk3308/MAINTAINERS    | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/firefly/firefly-rk3308/MAINTAINERS b/board/firefly/firefly-rk3308/MAINTAINERS
index e584038a2033..b70ff52ea741 100644
--- a/board/firefly/firefly-rk3308/MAINTAINERS
+++ b/board/firefly/firefly-rk3308/MAINTAINERS
@@ -4,3 +4,4 @@ S:      Maintained
 F:      board/firefly/firefly-rk3308/
 F:      configs/roc-cc-rk3308_defconfig
 F:      include/configs/firefly_rk3308.h
+F:      arch/arm/dts/rk3308-roc-cc*
diff --git a/board/rockchip/evb_rk3308/MAINTAINERS b/board/rockchip/evb_rk3308/MAINTAINERS
index fe2c5f004c34..abffbb1eb0ab 100644
--- a/board/rockchip/evb_rk3308/MAINTAINERS
+++ b/board/rockchip/evb_rk3308/MAINTAINERS
@@ -4,10 +4,11 @@ S:      Maintained
 F:      board/rockchip/evb_rk3308
 F:      include/configs/evb_rk3308.h
 F:      configs/evb-rk3308_defconfig
+F:      arch/arm/dts/rk3308-evb*
 
 ROCK-PI-S
 M:      Akash Gajjar <gajjar04akash@gmail.com>
+R:      Jonas Karlman <jonas@kwiboo.se>
 S:      Maintained
 F:      configs/rock-pi-s-rk3308_defconfig
-F:      arch/arm/dts/rk3308-rock-pi-s.dts
-F:      arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
+F:      arch/arm/dts/rk3308-rock-pi-s*
-- 
2.43.2

