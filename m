Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B2AC54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C944487FCC;
	Sat, 16 Mar 2024 23:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jJBpB4+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C42C88053; Sat, 16 Mar 2024 23:57:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF1787B30
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629824; bh=/IT/Ve3RLoQVvDdsJkCN3OycCsxh8tmllZ+/fq6SxPY=;
 b=jJBpB4+f8QruZr2WGlg+B0fzNG+wT+u41Pp+33dL+mSqXhfQ9qWQ92pBM2cU15R5w/709tqpa
 BNV2b7Xc2b6DShaPC0KW7+xMk5zA2nEbYzQUi31J9XW8yE19JnLO0tK069wq50M2i1eyzLJcILi
 T9Waq3Cllc3vyZMNbEmYPOoIFqixgUlBq6XMsWsI5hAqpxZg0V5q+8dI+C2pF31AOXQ38dMAMJ7
 YySnHsxK/oqN7fo6obbngRQYfRsuX03Hhdh+1L872hfSKKz7Jt3c8ZQKcTd2tyXuJ36xRMKyFT9
 i2um5iHXYr29chfjJAzuxRG1BskxSeouhLo4GntSWZhA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/13] board: rockchip: rk3308: Add device tree files and
 myself to MAINTAINERS
Date: Sat, 16 Mar 2024 22:56:27 +0000
Message-ID: <20240316225655.3244348-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316225655.3244348-1-jonas@kwiboo.se>
References: <20240316225655.3244348-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f623c00957eaab7babfc8d
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

