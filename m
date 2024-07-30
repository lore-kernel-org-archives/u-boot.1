Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5AFC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901B38882F;
	Tue, 30 Jul 2024 16:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qpp2ohrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3623788806; Tue, 30 Jul 2024 16:52:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64027887B9
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722351116;
 bh=itc3vwOsADvvh/rdqbo/EHC4sp+h4XiIO15Oopj1Mn0=;
 b=qpp2ohrdPfK0X4l0f6IhPYCXYaye5rCGnCm7bsmQ/lCOASBsn78+oL0muix6BVFrc+0FvPHwH
 0uZdeZuQfL+nmBercED3MP2Wk6WjeNZ8kMP3DBGZFFiDyOaWRJAX1Oy9WuBLcLwlEh3QwQRIYld
 xs3i/AS2HlOPYibhZU3jQLO+Phj3pUhs+HNTaVuXIG4zlRaz4/gZlDOv8syKfrrLPPpwrF8zba+
 TW+Ud+DbAsvbW7P0PThaAT2t9LdLQ7jqDFcY23aR/0EClu6vc5lAaAj5B489s2ifKBEY5Ezy7yN
 Imr2TC7cHRLbwjrJJL0RjuVuNn29NpFpLfrZvDlVBWbw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/8] rockchip: rk3308-rock-pi-s: Update DT to v6.11-rc1
Date: Tue, 30 Jul 2024 14:51:40 +0000
Message-ID: <20240730145148.849245-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a8fe0a88a51d097cb15596
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

This series cherry picks related rk3308 and rk3308-rock-pi-s commits
from devicetree-rebasing v6.11-rc1-dts tag to improve support for the
new v1.5 hw revision of Radxa Rock Pi S.

This series loosely depends on following patches:
- mmc: rockchip_dw_mmc: Allow 4-bit mode when 8-bit mode is supported [1]
- rockchip: io-domain: Add support for RK3308 [2]

[1] https://patchwork.ozlabs.org/patch/1964169/
[2] https://patchwork.ozlabs.org/patch/1964170/

Jonas Karlman (8):
  arm64: dts: rockchip: Add rk3308 IO voltage domains
  arm64: dts: rockchip: Add sdmmc related properties on rk3308-rock-pi-s
  arm64: dts: rockchip: Add pinctrl for UART0 to rk3308-rock-pi-s
  arm64: dts: rockchip: Add mdio and ethernet-phy nodes to
    rk3308-rock-pi-s
  arm64: dts: rockchip: Add io-domains to rk3308-rock-pi-s
  arm64: dts: rockchip: Update WIFi/BT related nodes on rk3308-rock-pi-s
  rockchip: rk3308-rock-pi-s: Remove unnecessary u-boot dtsi overrides
  rockchip: rk3308-rock-pi-s: Enable LED and IO Domain driver

 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi     | 19 -----
 configs/rock-pi-s-rk3308_defconfig            |  4 +
 .../src/arm64/rockchip/rk3308-rock-pi-s.dts   | 81 +++++++++++++++++--
 dts/upstream/src/arm64/rockchip/rk3308.dtsi   |  5 ++
 4 files changed, 83 insertions(+), 26 deletions(-)

-- 
2.45.2

