Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58234889BB;
	Tue, 30 Apr 2024 17:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iQWhrdsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E98F88A30; Tue, 30 Apr 2024 17:32:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0B088A3F
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491103; bh=I9E/t4DKTBQCY6l8P1OkV48CNdJM4KtmF0P9vO0mzXA=;
 b=iQWhrdsK0C+tUg7PIiUMXPuemkZphKha0TWD9u4NDPCI3rwcgCRKtjNZVJj5h9heQ7tRwi/Eq
 Jwc3HElEzLM/+y1yCp9f9JSwvnUuZs40CNllc5VOtOWAAjfHpWTGxumW5zdHHn4PrfozrirP6P1
 cloj2Vhs/vj1WnLoreRHiv17CRnZXCPQPjwHWKzIGXuuRGHRkjivDMZwDDmnLqzMuIqIGHP7fuX
 ohP6Mbfj5jt2+Pl50dbRxKiX9qgls4pRbggx1JSyTflr0gSOCX4skQkbPWTP2XYvoxzln/ksy/E
 DsX1/OTiFXIlY9urCekHuVtrVzzHoRY9kHDN4iaqFATQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 08/18] rockchip: rk3399: Imply support for GbE PHY
Date: Tue, 30 Apr 2024 15:30:15 +0000
Message-ID: <20240430153053.308788-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ed8d99e42224315b855
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

Imply support for GbE PHY status parsing and configuration when support
for onboard ethernet is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tags
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index f580d69ed879..6f1213b1710c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -271,6 +271,7 @@ config ROCKCHIP_RK3399
 	imply MISC_INIT_R
 	imply OF_LIVE
 	imply PARTITION_TYPE_GUID
+	imply PHY_GIGE if GMAC_ROCKCHIP
 	imply PRE_CONSOLE_BUFFER
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
-- 
2.43.2

