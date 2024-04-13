Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A51EC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF1D8806C;
	Sat, 13 Apr 2024 20:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dW0gYgEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8164A88211; Sat, 13 Apr 2024 20:15:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8358988211
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032128; bh=1hXmHtA0H1aOr5hqkn7FSBv6m21lg8IOnOGijYGYrF4=;
 b=dW0gYgEpuQnXmfdRWrPiZR62QQF6nPTU3QMgluvY5dYT8CgmarL2KgvgBeuOWPDX228C7GuJy
 DUyINEcbU0OzFBr0Bmi2+76lZsRxnTNw0RejpwB6GpitYhQTNR/WcTPTPvP1yc3+vs0JTS/I7u8
 d2b6mvAKJd6cyZHsyntV13S2LSib0L585axnRvaOm5iNLOsAvniOzoS0FCNjdT8p58JwO60JeuP
 iMaKpv62MxWWHcnWbPcoAtvGpnwg3zLfI6tXhY1oZiIcQUcLsgVrna1bwYTqJmOi0vxnkGsAm8J
 Jl50ilHhMrVWm0g8BAMoYsgI0BFzEQmcxWFARnU3JOBQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andyshrk@163.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 14/23] rockchip: rk3588-coolpi: Add boards to documentation
Date: Sat, 13 Apr 2024 18:13:48 +0000
Message-ID: <20240413181425.1384357-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acbbe6fbb975d49a654bd
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

Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the documentation.
Also fix .dtb-file entries in Makefile.

Fixes: 3e15dee38d45 ("board: rockchip: Add support for rk3588 based Cool Pi CM5 EVB")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/Makefile           | 4 ++--
 doc/board/rockchip/rockchip.rst | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 08dfbdd557b7..38d259a7035c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -167,8 +167,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
 	rk3568-rock-3a.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RK3588) += \
-	rk3588s-coolpi-4b.dts \
-	rk3588-coolpi-cm5-evb.dts \
+	rk3588s-coolpi-4b.dtb \
+	rk3588-coolpi-cm5-evb.dtb \
 	rk3588-edgeble-neu6a-io.dtb \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5dd5ea7f1e29..9a726e9cde63 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -131,6 +131,8 @@ List of mainline supported Rockchip boards:
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
+     - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
+     - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
 
 * rv1108
      - Rockchip Evb-rv1108 (evb-rv1108)
-- 
2.43.2

