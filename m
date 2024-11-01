Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F954E6F08E
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 22:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04FA892A2;
	Fri,  1 Nov 2024 23:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hyrxEa2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5381A8926A; Fri,  1 Nov 2024 23:21:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768C088E3C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 23:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=178a=R5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730499704; bh=cPoC3XvKRDj04t2Vccb+p1y7j95d1ajCscfSsBlhQGs=;
 b=hyrxEa2APthAkW0f1gMiYrUupcCP5D5V4qdkGiOaIxzBBLKapyKlCd+wku7MySLxZTaW51KQo
 5mHPA4ZVUILrejiDQdF89HlewtASfMvZFkTN6yOiMBEaPe359YWbl/xNFi10XaOvMHfnaNHjk+p
 JjbAIie6F/W+xVmIg0Pp6jl8xoMFJXsCcAVx/gaOFKcOt/wkQD+pcBGiGUgH+0B9MYInY4l6b+e
 X90b//OonH1WUhBgCgry5/fSn56SCl0rtFsuBg8nPPiHN1Vir9SAVmwASVgMjRnh8e0kURDTQyE
 QJ0zNG+KEIaNwRvgsa0AYu1DkU732KHGyhZDv5NOLsFA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Sergey Bostandzhyan <jin@mediatomb.cc>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S
 Plus
Date: Fri,  1 Nov 2024 22:21:29 +0000
Message-ID: <20241101222135.3220074-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101222135.3220074-1-jonas@kwiboo.se>
References: <20241101222135.3220074-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67255477354c15e0314d0f02
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

From: Sergey Bostandzhyan <jin@mediatomb.cc>

The R2S Plus is basically an R2S with additional eMMC.

The eMMC configuration for the DTS has been extracted and copied from
rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip
repository.

Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
Link: https://lore.kernel.org/r/20240814170048.23816-2-jin@mediatomb.cc
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: b8c02878292200ebb5b4a8cfc9dbf227327908bd ]

(cherry picked from commit c9bf98827964441f4dd16faa45bd4046f472e693)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm64/rockchip/rk3328-nanopi-r2s-plus.dts | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts b/dts/upstream/src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts
new file mode 100644
index 000000000000..cb81ba3f23ff
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * (C) Copyright 2018 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+/dts-v1/;
+#include "rk3328-nanopi-r2s.dts"
+
+/ {
+	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
+	model = "FriendlyElec NanoPi R2S Plus";
+
+	aliases {
+		mmc1 = &emmc;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	mmc-hs200-1_8v;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	supports-emmc;
+	status = "okay";
+};
-- 
2.46.2

