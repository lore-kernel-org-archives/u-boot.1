Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BF7C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F161B82B53;
	Sun,  6 Apr 2025 02:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OsWkipU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E68882B63; Sun,  6 Apr 2025 02:25:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C422382B4A
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899122; bh=I+P92fUF7QrdJV1N7wbPpS5fT1agO06NpWLjF8tMJwE=;
 b=OsWkipU4+dU0sfzyn/DFnAPx0FAF2LaP1Qn1V8ta3H/g4Yb8Y+T7x8+sy6dgzS7sRJX/cGZYj
 ZM0KTyfFg95SzzzRj5QJFMdqaaJ0slFmnXo0eLyuLp8r8KNRyodpphchmDqHrnz9GaartT4sV1D
 Q9T8eu0aSRNFJLXS9SFKIxPDeN6C1HeplvGLcjfnqbIkX1DemJYMy/8NLKqh3+7t4qZveRJZx82
 5X97gXvCAN0NwONZTfD2goW5N7BGEb4igds7UELBMrpxj3pYox0V0rEYR60rYIs1VNz3XvWXEJM
 dntV6GPWAPanZ2UMIvNr6c2jSnfa2JmfCvSuVmepJEFg==
X-Forward-Email-ID: 67f1c9f1fb2b6fde09d69fc8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/11] rockchip: rk3568: Drop BOARD_LATE_INIT from target
 config
Date: Sun,  6 Apr 2025 00:24:29 +0000
Message-ID: <20250406002447.1555596-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406002447.1555596-1-jonas@kwiboo.se>
References: <20250406002447.1555596-1-jonas@kwiboo.se>
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

BOARD_LATE_INIT is already selected by ROCKCHIP_RK3568 so there is no
need to select it under any board target config.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3568/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 8cad77890f13..2730220a18e8 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -5,7 +5,6 @@ choice
 
 config TARGET_EVB_RK3568
 	bool "RK3568 evaluation board"
-	select BOARD_LATE_INIT
 	help
 	  RK3568 EVB is a evaluation board for Rockchp RK3568.
 
-- 
2.49.0

