Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72DFCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843AE89005;
	Sun, 13 Oct 2024 21:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="L5CsrmCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25F088FA1; Sun, 13 Oct 2024 21:24:37 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE5F88FC4
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HOiVaaoaRMZ+1eeUAaJpwdoIHqy6SyK62ymOeR9yf58=; b=L5CsrmCOR3Di3BONL3/104aByu
 DWbHpISaIBbldYkOVIf7/nkT3LbZbuPNRvEELsL4DeqUJPhtr6WYwyREyuRabIWr+nf8o5E9roRtP
 9PbOUZxofrjgglyjsVxKvMGp3CsKQ5txR0MnhZMT152IY+EQ7UsNQcrxX/31Nr4i3ycJU52fHmEZO
 cnumIz4/d7OClf1lG8eEfbQeO8zGNWZ3Gsao8Vd9H3V+r7Yw0il+1z4/q/CgRHYHX2b3Yoo/fsrqv
 iUQ/6hYw+S0mKfIlUYyBddcPnjE71JcpQBspdimNOeCl7VDqM6C7JTyA3F59RyBq8c+PY/dP9fvFo
 Rc5xAlyQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04Cb-000129-4L; Sun, 13 Oct 2024 21:24:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 07/18] arm64: dts: rockchip: add board-aliases for
 Qnap-TS433
Date: Sun, 13 Oct 2024 21:24:13 +0200
Message-ID: <20241013192424.84280-8-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013192424.84280-1-heiko@sntech.de>
References: <20241013192424.84280-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the aliases for the internal network interface as well as the emmc
on the board and make sure the dedicated RTC is always the first one.

The TS433 actually has two rtc devices. One coming from the rk809 pmic
without added functionality and also a dedicated RTC from Mycrocrystal
that is battery backed to keep the time.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-8-heiko@sntech.de

[ upstream commit: dadd4256e12360d3ff1f6481b2e4697f9d890caf ]

(cherry picked from commit cb53815764403f7f17967a32eec2aeb6625b396f)
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 40af4dd0e41..8be36250aa1 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -13,6 +13,12 @@
 	model = "Qnap TS-433-4G NAS System 4-Bay";
 	compatible = "qnap,ts433", "rockchip,rk3568";
 
+	aliases {
+		ethernet0 = &gmac0;
+		mmc0 = &sdhci;
+		rtc0 = &rtc_rv8263;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -120,7 +126,7 @@
 &i2c1 {
 	status = "okay";
 
-	rtc@51 {
+	rtc_rv8263: rtc@51 {
 		compatible = "microcrystal,rv8263";
 		reg = <0x51>;
 		wakeup-source;
-- 
2.45.2

