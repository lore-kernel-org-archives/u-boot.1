Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77998D3E2BA
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7046689145;
	Mon, 28 Oct 2024 20:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="lEqGc5rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A3589043; Mon, 28 Oct 2024 20:30:12 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE0189156
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:30:09 +0100 (CET)
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
 bh=N6BAyGDxVHcIAlZM+wdEWS+OeZwtRjBb9apHS036Ym4=; b=lEqGc5rr77KNu0olFzZ01TLDJT
 hRIridtnQQjpxn6cvwgVGt04AUJgPJEy/ngqOfslHFuvhN9w61+iCwhqfyjDRiUZxIcGQzPZaf+/C
 6FUZNS/1y6QyAhj5mQ+WBxweHuIitF4QfnFJkjFQ9/HflubgnAbmSCKCVsnu/588wATcZo1Vul/lk
 5HGNP5lwBQ1nEhnlnA43d4iTptdMRCHTVHgxpeIP1X8+Uyfd3+4YYE/rfDyvHx8707LCjyrsldL9R
 Y1iiOoamgjisjXYhl4oQLSQx0C4DaB/sIbGAnR03h2MY52uvNoG6B2vee6LOaE77YT8MgiQDaA5tr
 XBDcQhmA==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyr-0000Gm-9h; Mon, 28 Oct 2024 20:00:45 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 16/18] arm64: dts: rockchip: actually enable pmu-io-domains
 on qnap-ts433
Date: Mon, 28 Oct 2024 20:00:32 +0100
Message-ID: <20241028190034.143122-17-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028190034.143122-1-heiko@sntech.de>
References: <20241028190034.143122-1-heiko@sntech.de>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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

