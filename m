Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5226ECF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CB088FFD;
	Sun, 13 Oct 2024 21:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="DKhRXsX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303BB89089; Sun, 13 Oct 2024 21:26:35 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF1B89093
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oJ8k1ncuQCf0nm2tlnRWCA7CiBmEfst7McyhR/EMgRQ=; b=DKhRXsX8WWplGwhJOktnoTdZ92
 kRRnlWWBp0LhQFDHkbE0t4Mn0hPksqkd6VoEs1r6ekpR5TuMfR+VszAvpclKo6i1yIMsIS2xVesdO
 BTwr0c/apS/CCUCnMDxJaoU05IyY2IQNCtR0UJE87Cw5Sz0PEeZ4GMCzRmbX8XT+6/REZNs/WDvGY
 XfJhNdoQrMj1rftZV1Y2LYGGP2a0dpYN1cq///fhQNgR/dvYEMHLsH763/fIXjxyhvWHbQvI4Jf5t
 9vgMqV0LRT8+WdcSFxSfMWksb1uT5vhK7Jk5gdPRrTgoTQx5pbKC1f8TzC0guo+8WTGftrLLc7f7E
 ZqYt6CHQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04Ce-000129-FG; Sun, 13 Oct 2024 21:24:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 17/18] arm64: dts: rockchip: add product-data eeproms to
 QNAP TS433
Date: Sun, 13 Oct 2024 21:24:23 +0200
Message-ID: <20241013192424.84280-18-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013192424.84280-1-heiko@sntech.de>
References: <20241013192424.84280-1-heiko@sntech.de>
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

The device contains two i2c-connected eeproms holding some product-
specific values. One sitting on the mainboard and one on the statically
connected backplane.

While the eeprom chips themself have a size of 512 byte, the eeprom data
only uses 256 byte each, probably to stay compatible with other models.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240810211438.286441-3-heiko@sntech.de

[ upstream commit: da6f4130234448122fe3e66c8116f7d9eea8a5c7 ]

(cherry picked from commit 0b3109708caf5002ba188ae28eae9ce46b2c39b4)
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 90d8d526629..e601d9271ba 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -454,6 +454,26 @@
 		reg = <0x51>;
 		wakeup-source;
 	};
+
+	/* eeprom for vital-product-data on the mainboard */
+	eeprom@54 {
+		compatible = "giantec,gt24c04a", "atmel,24c04";
+		reg = <0x54>;
+		label = "VPD_MB";
+		num-addresses = <2>;
+		pagesize = <16>;
+		read-only;
+	};
+
+	/* eeprom for vital-product-data on the backplane */
+	eeprom@56 {
+		compatible = "giantec,gt24c04a", "atmel,24c04";
+		reg = <0x56>;
+		label = "VPD_BP";
+		num-addresses = <2>;
+		pagesize = <16>;
+		read-only;
+	};
 };
 
 &mdio0 {
-- 
2.45.2

