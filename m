Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B913D2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05283891B0;
	Tue,  5 Nov 2024 17:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pYli+uru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A875B89048; Tue,  5 Nov 2024 17:01:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBB88904C
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822467; bh=sNJT3Dgp+8VPT9++tN/bqxG9OPssAmPZCe0ikIZIzTk=;
 b=pYli+uruJt3HtQvIvK2cTGk+pZ4bFJdy+oCsH9UOYL1GqdDfDLjh9pW93wbbgcz+82XFm5oVS
 qeG76xL6VvjI9D0tAmm/zkL/TIaC125LP0raxMSMrbvq9svtHqXm0CTO5Qu5sUUUsc955JZLHEX
 vNU6GHPfDnaMbKBu+8yakF2TMZ+Y9TeA0vRyufVJ2r2NrUZlrEAnAjW/9dopTPBDN77wzMHgT74
 PTqZQi9GkhwhPV4e4onF4UpkfuNsgHL9THxFL+XybuVJfS33CYNwx+CAYTsYIwn09r7zh1VLYtu
 Cf5E6llso5WcOoXb1HRdlOrDd0y8scQg80vLLh7+B41w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 01/13] board: rockchip: rk3288-tinker: Add myself as reviewer
 to MAINTAINERS
Date: Tue,  5 Nov 2024 16:00:24 +0000
Message-ID: <20241105160054.1373319-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a4142ff3e144e4725e097
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

Add myself as a reviewer for Tinker Board and S variant so that I can
help with review and testing of defconfig and device tree changes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/rockchip/tinker_rk3288/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/rockchip/tinker_rk3288/MAINTAINERS b/board/rockchip/tinker_rk3288/MAINTAINERS
index 3869d5dc8534..a5cae55d4286 100644
--- a/board/rockchip/tinker_rk3288/MAINTAINERS
+++ b/board/rockchip/tinker_rk3288/MAINTAINERS
@@ -1,5 +1,6 @@
 TINKER-RK3288
 M:	Lin Huang <hl@rock-chips.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	arch/arm/dts/rk3288-tinker.dts
 F:	arch/arm/dts/rk3288-tinker.dtsi
@@ -12,6 +13,7 @@ F:	configs/tinker-rk3288_defconfig
 
 TINKER-S-RK3288
 M:	Michael Trimarchi <michael@amarulasolutions.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/rockchip/tinker_rk3288
 F:	include/configs/tinker_rk3288.h
-- 
2.46.2

