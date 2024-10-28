Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F190CD3E2BA
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 610B28911E;
	Mon, 28 Oct 2024 20:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="ytIzKUqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF01E890CE; Mon, 28 Oct 2024 20:29:47 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9538911D
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:29:45 +0100 (CET)
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
 bh=JrIS2lL6O8HEry7Ylb0/CeD0pF5LcAoPa3eBooleG1E=; b=ytIzKUqAnb+rZwnWQT7x3usRql
 TcNa5GJjkarRHq4NPluAsb9Hhq9VQvbWWYNyjadx9BkZxVG2vyuCFSgRjnT2TVdRnS8nw6tN0eQYV
 xKBE1BaR9wn8KcI/aXTwxWj8QdoHVam6bc/MAYF7u4+M1Pq3i3offXPT5v/LdlDJI0F0EkuieT7hW
 8TJo1NpLR7pCSxEH7V7E7Z8bNGW3Z2TEqQevAsULHv0O8wqpnS4jixqHlNteyc1PDX4m+LGKjCjF9
 j/qzY6yitm5ff2o++BfGvI1jVzeh0hEI9tn6Td26zAPbQyRGKN4Zfrblgr+HPxGFbpczkop6aHxa0
 37rc5paQ==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyq-0000Gm-QV; Mon, 28 Oct 2024 20:00:44 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 14/18] arm64: dts: rockchip: add 2 pmu_io_domain supplies
 for Qnap-TS433
Date: Mon, 28 Oct 2024 20:00:30 +0100
Message-ID: <20241028190034.143122-15-heiko@sntech.de>
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

Add the two supplies for the pmu-io-domains that are defined in the
vendor devicetree for the TS433.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-15-heiko@sntech.de

[ upstream commit: 64b7f16fb3947e5d08d9e9b860ce966250e45d52 ]

(cherry picked from commit 9b4d4c02b5762196063ab03c5439f96cbbaf2485)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 9a0cb69c3cf..6c4269b3d95 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -531,6 +531,11 @@
 	};
 };
 
+&pmu_io_domains {
+	vccio4-supply = <&vcc_1v8>;
+	vccio6-supply = <&vcc_1v8>;
+};
+
 &sata1 {
 	status = "okay";
 };
-- 
2.45.2

