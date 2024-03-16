Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F49C54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D1188093;
	Sat, 16 Mar 2024 23:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KdkS215f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542E988091; Sat, 16 Mar 2024 23:57:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F4888096
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629837; bh=6WHhb1pN9axaeXWgBwqMSAJ//8SndkGv37OheVC3NFs=;
 b=KdkS215fb/YH12sjNX480m+Hz7Q5hkXNlJw57FQvWrywv70EUJU1nHSKvpehePTwdHiLvQPnx
 l3a3OALZo1/nBH3d3+JbEE2nX+bs4YCcisRUfjlJ3bVa5kGgCK3xN2Y4z7lnPtpwaudqC2ChfQ9
 9JnGb7b5CGGMJp31q3TuESFlANF6iSFlGKN/wJ+3pjYnFzUSW1/9Q9QBHvjVJqdc4xg+vIvowEz
 KqvM5rGMoBBl9yATzfkheAArRczSnPV97opbvEinDiYlUob2LJs55IiCELU0lCDyLLUtnYDxulA
 UYQ6ZYINU9ArV5W0v1lY+gBMkc9NINyV6QuVqvUt9XkQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 05/13] rockchip: rk3308: Enable random generator
Date: Sat, 16 Mar 2024 22:56:31 +0000
Message-ID: <20240316225655.3244348-6-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65f623cd0957eaab7babfcd5
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

The RK3308 SoC contain a crypto engine block that can generate random
numbers.

Add rng node to soc u-boot.dtsi and enable Kconfig options to take
advantage of the random generator.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
 arch/arm/mach-rockchip/Kconfig  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index 396fefb743cf..d6c71f62bc93 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -21,6 +21,11 @@
 			reg = <0x07 0x10>;
 		};
 	};
+
+	rng: rng@ff2f0000 {
+		compatible = "rockchip,cryptov2-rng";
+		reg = <0x0 0xff2f0000 0x0 0x4000>;
+	};
 };
 
 &cru {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 6e07a70bf4ae..fa5917236a43 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -162,9 +162,11 @@ config ROCKCHIP_RK3308
 	select SPL_LOAD_FIT
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
+	imply DM_RNG
 	imply LEGACY_IMAGE_FORMAT
 	imply MISC
 	imply MISC_INIT_R
+	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
-- 
2.43.2

