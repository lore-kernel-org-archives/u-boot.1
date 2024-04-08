Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43931C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C751687DCA;
	Mon,  8 Apr 2024 20:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="N8qaoz9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC0087C7F; Mon,  8 Apr 2024 20:15:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C818811C
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600091; bh=E17yF5QkzzOk7c/HARFouw6brE3OqVrlnP+FblE+XQQ=;
 b=N8qaoz9Pc9G9iNYmUpn/SLnQbsSaPhiFaW8pKkFCSZzq9xzGtHrYqWzml15VcDQDK8hD0mR1h
 B5nR9H/rl+h7Kud0zaULLOTgGKUtGp9bdi3eDEgd+ykLw3AWkPKqMHyo5MZxALv8Qu1M1sBYbpd
 iWA6LEbTs9fI4Un9gJ2t9Ul+mPSol8RZPFElbqJASDmeQetgYjy5v5HMryEN0Cd4Zlx0c0o/sHK
 8aIPydSUM3kZ9y9+TaKbLaivbTpNT8ZW/Xj6IjvvujY4ufgpfLx3SMqMEDTMnUW/JEoMC4gDZH9
 VYVVTkmOe/l/AeW102BJCU9I1h1mrVLs3JL1Yjyy5yEQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 05/14] rockchip: rk3308: Enable random generator
Date: Mon,  8 Apr 2024 18:14:02 +0000
Message-ID: <20240408181429.3676856-6-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 6614341b45fff4c2aa5b4a4d
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
v2: No change
---
 arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
 arch/arm/mach-rockchip/Kconfig  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index 436f66d1b87d..fa31c838d34d 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -26,6 +26,11 @@
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

