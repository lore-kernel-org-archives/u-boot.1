Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC94CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8938D890CA;
	Sun, 13 Oct 2024 21:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="nVBCNgdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10192890C2; Sun, 13 Oct 2024 21:26:25 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BB088FA1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:26:22 +0200 (CEST)
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
 bh=4e2MAMQHF2yPvTu4ay8Lo1CpHqR8MhEC1jyh9YVObdM=; b=nVBCNgdOi/Ak8bXSFv3fhXp3D/
 Ss/IzzzWB+TbYOWbBYmjfj9EUT3RUVvScluVvjQOpZhMj6BovbtUgPUIc/iAbP1hq1EKlS4MCNW8W
 hV0WPeAItM8yeZhrc+30kBLcET6rNHoU8yjCKRNPYRNRvqx/n3IqI6aBQuBnidaF2Vy8iHijXEJUG
 g32soF+xLOnYOsGOdj6etnhWXiskV1EWH+/s0rY/HyKkJ47Mk15kEgqszyLDW6KMyKKushoU1HMBC
 ycfiK/i3U+BXrRTKbHUB0zhTXMK2QRFh7t1TB0JGerSPh4BxBBN8llNSsiGmHEXrrvs+lGRqoTCeg
 F+0zcsng==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04Ce-000129-4a; Sun, 13 Oct 2024 21:24:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 16/18] arm64: dts: rockchip: actually enable pmu-io-domains
 on qnap-ts433
Date: Sun, 13 Oct 2024 21:24:22 +0200
Message-ID: <20241013192424.84280-17-heiko@sntech.de>
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

Contrary to the vendor-kernel the pmu-io-domains are not enabled by
default. This resulted in the value not being set according to the
regulator, which in turn made the gmac0 interface that is connected
to the vccio4 supply inoperable.

Fixes: 64b7f16fb394 ("arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240805162052.3345768-1-heiko@sntech.de

[ upstream commit: 40cc4257169712f0ae3835820a4c5afbdd1a16ff ]

(cherry picked from commit f509fcb1fb82117e551b489592ac5714a6c5cd8d)
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 20e4fa6c185..90d8d526629 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -532,6 +532,7 @@
 &pmu_io_domains {
 	vccio4-supply = <&vcc_1v8>;
 	vccio6-supply = <&vcc_1v8>;
+	status = "okay";
 };
 
 &sata1 {
-- 
2.45.2

