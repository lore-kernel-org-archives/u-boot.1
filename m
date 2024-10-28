Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13331D3E2A2
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5805F89138;
	Mon, 28 Oct 2024 20:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="tLIlE5y4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C058911B; Mon, 28 Oct 2024 20:00:47 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B448912B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:00:43 +0100 (CET)
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
 bh=fBR/hK0usBGKRkM7U1aj+/9mdw+D31vNyMfss7DMKa4=; b=tLIlE5y49I4yii+FlIRxSGP8Ee
 IiDHemHWQzuXu6IXSP/4ZCWcFc8rAMrGzaimf2vyKS3hkluuDZSEL+92t+7MdMVq8tbFM1lLctU2n
 vSr/FnALXmC2TfQzXBFThi1NOga6QZo0UC6NOutwCDvlq1x2r3hPmVxWVb1YWSP8mp+1tz3RHqzBD
 RX2LuOerjW92keJpFbPNz/9fgqpjuHFQQbF730Y7xUYU7QoFH48J+MX+66UcFfTqX1S3advvHfGRj
 usavkOcOq1hbbg0Rw5DNuAA/qVwICrbOugXIt/br9FkQtAVcyFIrkiGdK6xe7Y43xk77Y3OQpQ8v9
 /cVaZHJw==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyp-0000Gm-5Z; Mon, 28 Oct 2024 20:00:43 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 07/18] arm64: dts: rockchip: add board-aliases for
 Qnap-TS433
Date: Mon, 28 Oct 2024 20:00:23 +0100
Message-ID: <20241028190034.143122-8-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028190034.143122-1-heiko@sntech.de>
References: <20241028190034.143122-1-heiko@sntech.de>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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

