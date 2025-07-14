Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D92C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 22:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E855882E37;
	Tue, 15 Jul 2025 00:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oSIUMB6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A3282E52; Tue, 15 Jul 2025 00:34:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF5B8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 00:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752532464; bh=7VugHVtMAD/bJkwhC4LP9gLOjkpCAgGbw3MbmbhpWoc=;
 b=oSIUMB6rOqnA82ahUJINI/MrNWu34825O9LNJCzoYOHBY12fYn2rS8MpPkCKs9pjoPjxmWv4x
 gS3bgiZFrxyU1oC95RvMjMujjLvcpTMHU6Qhm7Ei9thxyvnNzcGSJRaonzkoMcqHfTkw5Fcy01t
 r/3uXQNhQNl+86QqPEyfh2Gt4g4TBnwq2eS0yT+wdiJOH6VrVm7xCndcLaGXQ6Y8bg4O6HxuC+P
 K5tANk5NVQ4NwsKOtjQV5nm7SCQovgseTdkxyBSNMlw7mBoDcQeYeLLpKzzq7OMgqsIMkONf7zL
 XHW68DeVq+MTlt+n7xKS41zJMsyY9lGXd62lVjWkBGqQ==
X-Forward-Email-ID: 687585ec9931367d30116e39
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Diederik de Haas <didi.debian@cknow.org>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/4] arm64: dts: rockchip: Add vcc-supply to SPI flash on
 rk3588-rock-5b
Date: Mon, 14 Jul 2025 22:33:58 +0000
Message-ID: <20250714223410.1836893-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714223410.1836893-1-jonas@kwiboo.se>
References: <20250714223410.1836893-1-jonas@kwiboo.se>
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

From: Diederik de Haas <didi.debian@cknow.org>

The Radxa Rock 5B component placement document identifies the SPI Nor
Flash chip as 'U4300' which is described on page 25 of the Schematic
v1.45. There we can see that the VCC connector is connected to the
VCC_3V3_S3 power source.

This fixes the following warning:

  spi-nor spi5.0: supply vcc not found, using dummy regulator

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/20250425092601.56549-5-didi.debian@cknow.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 425af91c58023a8924cc2330384e040d388adc4e ]

(cherry picked from commit b31830e88153e20bf3454e210760264b7f24b206)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts
index d22068475c5d..17f4fd054cd3 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts
@@ -562,6 +562,7 @@
 		spi-max-frequency = <104000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
+		vcc-supply = <&vcc_3v3_s3>;
 	};
 };
 
-- 
2.49.0

