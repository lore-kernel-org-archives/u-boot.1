Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC6BD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18412891D4;
	Tue,  5 Nov 2024 17:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ealdwWpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5AF5891D4; Tue,  5 Nov 2024 17:01:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A054E891CF
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822475; bh=LQ9o+1VQIdCAHCTk/vnlv/lYvqu/VtK4tYQpAnIVS24=;
 b=ealdwWpS83SpBxuHMmsiNj0itbXeLKGl7A5DBi+jLwEAgYzQLzx01iaAlb2hzogRtEbTvLggC
 AszmAiKtLpfuTsPW7Ctlv1waAXl+BdEC06OAuqNleeDIzFSIW2AB6tCGGUtZIjO9wD69JpHLCCg
 U0yJlaxbWciGa784UNCkEkBejyMz8L2ceEfoR22hLyDgBXwPHM4aHDgbOZt+/menzuiRpfgntZg
 wjHHaqVfQZbRYRegIO1c39JjPNBH6vaHOFnERL/lCMndd9BgqVSd5UTQlwT0BIVJ7oFjSnNYS3q
 dx7qSgtl7TTEXBzwQ47VJhiXuAS1x9fBIanTjvxq1kBA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 03/13] rockchip: rk3288-tinker: Only include required DT nodes
 in TPL
Date: Tue,  5 Nov 2024 16:00:26 +0000
Message-ID: <20241105160054.1373319-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a4149ff3e144e4725e0c4
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

Drop the unneeded bootph-all prop from dmc node, it is already defined
in soc u-boot.dtsi.

Remove booth-all prop from gpio7 node, this node is not needed in TPL.

Adjust bootph props to include pinctrl related nodes for UART2.

Remove the explicit bootph-all prop from the pinctrl node, any bootph-
prop will automatically be propagated to the pinctrl node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-tinker-u-boot.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
index 032dac221c24..1665e4f5d10f 100644
--- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
@@ -6,7 +6,6 @@
 #include "rk3288-u-boot.dtsi"
 
 &dmc {
-	bootph-all;
 	rockchip,pctl-timing = <0x215 0xc8 0x0 0x35 0x26 0x2 0x70 0x2000d
 		0x6 0x0 0x8 0x4 0x17 0x24 0xd 0x6
 		0x4 0x8 0x4 0x76 0x4 0x0 0x30 0x0
@@ -18,6 +17,7 @@
 };
 
 &gpio7 {
+	/delete-property/ bootph-all;
 	bootph-pre-ram;
 };
 
@@ -29,7 +29,7 @@
 };
 
 &pcfg_pull_none {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pcfg_pull_none_drv_8ma {
@@ -37,17 +37,13 @@
 };
 
 &pcfg_pull_up {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pcfg_pull_up_drv_8ma {
 	bootph-pre-ram;
 };
 
-&pinctrl {
-	bootph-all;
-};
-
 &sdmmc {
 	bootph-pre-ram;
 };
@@ -77,7 +73,8 @@
 };
 
 &uart2_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &vcc_sd {
-- 
2.46.2

