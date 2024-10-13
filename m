Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46B8CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E603988F44;
	Sun, 13 Oct 2024 21:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="y7A2jLMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114C788F1B; Sun, 13 Oct 2024 21:24:38 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9376688FA5
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
 bh=a2N4bONQGuQXZr0bfqjiY7E9Es29JCEkTbddzYA1s1o=; b=y7A2jLMoGnANeMKiT4qYM4TEPO
 EOPRocv4RINiySkrQr0YwvVQqNDeMQ1euWqZpQ4ZKuw82fh7P4J/g01b4gcaRgQYbEWXuX7D4oWHK
 kFns3qjJsMvUCWsWNPQgldhKme2iTPD0TtvY3NtIEKZuHVHSiK0xPG4p5qIE+RnbeBF5rTXyX9MX3
 DvfSDZDB3TaTxYWaW38mCEYJpkFEx1hJm3A2UwkUjkl5UapDfmC4GUtOJlr1ghM6uM8ImBO+0mEdC
 4+SvkkSZzwOz2Tfg1UPXZyoKkNAzELPh/IWsdoEvFmNpkT1+FQDwCnqthSllzF23K5yBZ5AsrlgD5
 dU31Xr8g==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04CZ-000129-Qa; Sun, 13 Oct 2024 21:24:27 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 03/18] arm64: dts: rockchip: enable uart0 on Qnap-TS433
Date: Sun, 13 Oct 2024 21:24:09 +0200
Message-ID: <20241013192424.84280-4-heiko@sntech.de>
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

Uart0 is connected to an MCU on the board that handles system control
like the fan-speed. So far no driver for it is available though.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-4-heiko@sntech.de

[ upstream commit: 07ef8be476bebd77cba3ca4804be03cc0dba414f ]

(cherry picked from commit aaa5b1c4bd8f0e4327078d513f0eef05cb829bcf)
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 9bf9c3b65ca..bc26f2e98c1 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -104,6 +104,14 @@
 	status = "okay";
 };
 
+/*
+ * Connected to an MCU, that provides access to more LEDs,
+ * buzzer, fan control and more.
+ */
+&uart0 {
+	status = "okay";
+};
+
 /*
  * Pins available on CN3 connector at TTL voltage level (3V3).
  * ,_  _.
-- 
2.45.2

