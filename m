Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9849C25B5F
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 11:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A6E8829C;
	Sat, 11 May 2024 13:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vfkpvzUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB49885DA; Sat, 11 May 2024 13:28:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C4E8817B
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 13:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6c02=MO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715426924; bh=KVCE54yaI5Ur/JlMKmXsTcyJy7+gHS2NnxjtE1KvONE=;
 b=vfkpvzUU+nHHnEKV4fWaI+CUXx8CS9e72oy/Dn0BiuzKNSTy2EUV1xFVKVS/TJ2IjSfYQ0Fn8
 KEwX0U8XaTXWX1NS2mh0UgJI1nPI7cLGSjNJQ5Q56i8OloO+WdAhCe/33WOIiGiWpUPiShb7jC7
 Eld9uO9nxedDFrMM+PGPoaWRqjBuUA40qAqrJa248/4dpYh4tCCqk0loZTXPFAvpqPFXbr2qZ91
 hWDc5Sq7x93AN5SXJmJ0JdP9V2IUajMkLsXMD7AOD4RM5y35cyaj4Z8USso+Grqb2zOW6TU6BWt
 NkhjvRtk8UBm5ass8aJPq0R0WQptB6ig66sL6+TMkQNA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 4/4] rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios
 workaround
Date: Sat, 11 May 2024 11:28:15 +0000
Message-ID: <20240511112821.1156519-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240511112821.1156519-1-jonas@kwiboo.se>
References: <20240511112821.1156519-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663f566aacd5e90e057dfc76
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

The GPIO0_C3 pin is changed to use func-3 using pcie30x1m0_pins during
probe of pcie3x1. This cause the device to lock-up when pci driver use
the reset-gpios unless the pin is first changed to use gpio pinmux.

Drop the board u-boot.dtsi workaround now that the gpio and pinctrl
drivers automatically use gpio pinmux when a gpio is requested.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
index 74755a44eaee..00fa0dfee19c 100644
--- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
@@ -2,18 +2,6 @@
 
 #include "rk356x-u-boot.dtsi"
 
-&pcie3x1 {
-	pinctrl-0 = <&pcie30x1_reset_h>;
-};
-
-&pinctrl {
-	pcie {
-		pcie30x1_reset_h: pcie30x1-reset-h {
-			rockchip,pins = <0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-- 
2.43.2

