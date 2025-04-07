Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0A0C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D122831A4;
	Tue,  8 Apr 2025 00:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VBfLF+iD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD1A83189; Tue,  8 Apr 2025 00:48:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148A08311B
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066103; bh=vlIJTmL3KqabLolOUik9U8g/sgLnqJ8pj765ULWehg4=;
 b=VBfLF+iDEw16annITtnF9pmpX9LUYgiHcRORTdwbkayRkb7tiSuKwHAamKmRwYxP3QzIiCSF3
 IHLoG0pu4VfAyLW+8fgGwSqBgJCimxATYKxVhrQsTdjMnSl+hzfyvk8lxgLdixWBv/jH3jAm8jh
 Wjmoqak3HnU3RgtiPEoRfqqvLIEyONeFvRqWpIjx+xuAhsyXfxojzsmWGLpEeHRB37uhDJYbkZ/
 jsrZ3b5E3b/lTrMcYqZer3zK5vT7fowCMSKo2eOf3AB8r3c83RvWxdPqHVJFiFh5ZJu3jQj95oC
 Lrhq33LnrDZrcBzxq+1WDFAxmOVma6rDR2vCWZzSqwoA==
X-Forward-Email-ID: 67f456359fd75b9b965127fb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 09/30] arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
Date: Mon,  7 Apr 2025 22:46:42 +0000
Message-ID: <20250407224743.2423921-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

Radxa E20C route UART0 M0 pins (GPIO4_C7 and GPIO4_D0) to the onboard
CH340B for debug console use.

Add pinctrl for UART0 M0 pins used for serial console.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20250228064024.3200000-6-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 0d2312f0d3e4ce74af0977c1519a07dfc71a82ac ]

(cherry picked from commit 9bcf6ccdd87c3be48fe7d75150c6e403c5c0a42d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
index d2cdb63d4a9d..5161d22330ab 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
@@ -18,5 +18,7 @@
 };
 
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer>;
 	status = "okay";
 };
-- 
2.49.0

