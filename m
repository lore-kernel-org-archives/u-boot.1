Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E8EC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA0F88883;
	Tue, 30 Jul 2024 16:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="y6mxdA+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8620688800; Tue, 30 Jul 2024 16:52:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F078885E
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722351121; bh=INvXLlKe49ye1DSpX0PsO/3a5VgLxEgxI5DNnPtxSXo=;
 b=y6mxdA+bEYh2r4ef8H16Tw2jXp32B/dxbi1pLyUoB6j7w+bzp7K03laTEV13NEb+UJ8X+LLZ8
 RJq9huJmbKRz8VdhxND0ckRsb9ghvKdQwKr36i1JAmHINGRBynD5oJsAsdXnpOF0PUzL6Jv0J3r
 5Ky2gHFYEz7HqcpvjttPk61bEaByF+HoI9htoOeTCFhN6OXQuSg78ckoMYo4UUDR1jkDWRU+J88
 vlKY6vjmnFSK7hAcX3qe+3RbPLLO6/lUktD/ILhpXO2FMGQWHjZGWXTNjhWO2VuyLv2ZR92EE29
 qY2+alcaTPL22XQVu29VjIvLlCsYEM7iZC3t/YyOWW1Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/8] arm64: dts: rockchip: Add rk3308 IO voltage domains
Date: Tue, 30 Jul 2024 14:51:41 +0000
Message-ID: <20240730145148.849245-2-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66a8fe0d88a51d097cb155a8
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

Add a disabled RK3308 IO voltage domains node to SoC DT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20240521211029.1236094-12-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: d1829ba469d5743734e37d59fece73e3668ab084 ]

(cherry picked from commit cebde305971e33a76efc3280e09814499ef89f54)
---
 dts/upstream/src/arm64/rockchip/rk3308.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3308.dtsi b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
index 6531ede13af9..31c25de2d689 100644
--- a/dts/upstream/src/arm64/rockchip/rk3308.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
@@ -173,6 +173,11 @@
 		compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff000000 0x0 0x08000>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rk3308-io-voltage-domain";
+			status = "disabled";
+		};
+
 		reboot-mode {
 			compatible = "syscon-reboot-mode";
 			offset = <0x500>;
-- 
2.45.2

