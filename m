Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00620CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D3B89001;
	Sun, 13 Oct 2024 21:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="SbHoqGyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82A788FBA; Sun, 13 Oct 2024 21:24:38 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3CF88FA7
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
 bh=Bwxf1EvXcYy6Gb6I4RXWrXmR3aaxt7pkZka/TVrLwkc=; b=SbHoqGyD8IZuMBPbqb5Z8evOeD
 QEI46L810R50wtZNKnEIHQlguv/bWKAua7eXDoFPjYFzqAs9WbU9W+TnrX3j+pgqf7yoU4aR+JjE+
 M013kKRg3zrXjdZy7Na0m1SEuzE7qKrvOvZ1ZYOmnRK13hMdaSZdAzuAxwL645/x1elCAq4bg61r2
 wOVNN+uFhNV4BoA3rS3psZzUdV3Wzluf1xXLzjz0Q6RGVznn3KZPdkAaFyuO44pyWnKArMJV98uU1
 RrbzLazFzfRRlYhcFFiOzvaRVypALOvA+A2dWTl0oGX2UUP9pZOsj9C81jRqmCwH2puW8phctDMC5
 7t0omMOg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04Ca-000129-Fc; Sun, 13 Oct 2024 21:24:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 05/18] arm64: dts: rockchip: add stdout path on Qnap-TS433
Date: Sun, 13 Oct 2024 21:24:11 +0200
Message-ID: <20241013192424.84280-6-heiko@sntech.de>
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

As most Rockchip boards do, the TS433 also uses uart2 for its serial
output. Set the correct chosen entry for it.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-6-heiko@sntech.de

[ upstream commit: e1cb5d8a92e41171bf4d5ddc459bd96372500901 ]

(cherry picked from commit 1e1af2af2192490a3d174624ac1bb976aa6afffa)
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index da735c4764f..be1c2286c2d 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -13,6 +13,10 @@
 	model = "Qnap TS-433-4G NAS System 4-Bay";
 	compatible = "qnap,ts433", "rockchip,rk3568";
 
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
 	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
-- 
2.45.2

