Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CB4C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E91288872;
	Tue, 30 Jul 2024 16:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tt1RHffd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FC88887A; Tue, 30 Jul 2024 16:52:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6098882C
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722351126; bh=5O+JIB0+O5S2c2euHG8pgoqSi1gJqJRicyf+0O4dXQs=;
 b=tt1RHffdmlh7OOipzRZYZCVJhuQCR5Mylc1CqVMVJxJHGzE4EdwYBpkl04J3atzxD9BYj2Y2h
 Ksn6g8OjejMCCSmY1veGBTXUgFch3JmDH+2BliW/oFTff6YFwyMMTYfsj21OMge1J6rAHcESwF0
 1MnuUCopnVtOyqcL3ZV0X1dUyqAJ57Y14c7eqE5hw6HHhTNVIV28YA5eub+r9chdKjIYXgzldBt
 RETkrCVvLC3YIy+B5t1NamMjQnqtIxEK3FdEP7EUG5zytzEmuGhn+4zbY6J+MItDsm1M/geTojt
 x99x4clIbC3Ny8c9ZmNSbJ/JPGcUHMR/ytrU94OeG+BA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/8] arm64: dts: rockchip: Add sdmmc related properties on
 rk3308-rock-pi-s
Date: Tue, 30 Jul 2024 14:51:42 +0000
Message-ID: <20240730145148.849245-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730145148.849245-1-jonas@kwiboo.se>
References: <20240730145148.849245-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a8fe1188a51d097cb155be
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

Add cap-mmc-highspeed to allow use of high speed MMC mode using an eMMC
to uSD board. Use disable-wp to signal that no physical write-protect
line is present. Also add vcc_io used for card and IO line power as
vmmc-supply.

Fixes: 2e04c25b1320 ("arm64: dts: rockchip: add ROCK Pi S DTS support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20240521211029.1236094-5-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: fc0daeccc384233eadfa9d5ddbd00159653c6bdc ]

(cherry picked from commit 39110e4bec51c9ce6bbd342234b288dbfccb9f80)
---
 dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
index 079101cddd65..8ea984906403 100644
--- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
@@ -272,7 +272,10 @@
 };
 
 &sdmmc {
+	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc_io>;
 	status = "okay";
 };
 
-- 
2.45.2

