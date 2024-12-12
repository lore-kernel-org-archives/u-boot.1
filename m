Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04ECE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19347801FE;
	Thu, 12 Dec 2024 23:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iq6VyrBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2126801A0; Thu, 12 Dec 2024 23:10:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0528B80224
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041420; bh=ELm8fRdLBtielB04Ms+hs7a8LI7lzQuJRcPB+662X8g=;
 b=iq6VyrBj3JYFTlCXXvqOUwY3SNTMh9wi5XzOLpgX2TuMyFCjW0XD++JfQL+Cs3mED2VcJFES9
 V46kUdasBKbGdvmmHOMUZFP8YEUrOMzHzP2ASMUNdRXCZZQICx2MXv7Bn0t1GFqNuonrGVOjFSb
 yRkpEyeYTExdNuAo4Ik5N0AFd3sUVV68qdMfSEVD9Ig++C8kW57SNakKn2ioFkKul7hIaK/FOLl
 BVMXFL/cZBhL3VQXHInEdzyWLMuV6eXeP7tCm4p5Qd3xPpdh36rO5w0aGXb6nUHEXHC+zMhWbfW
 b1dx68LWukj4Q/3IPI3en1AIrT05rSCldRmIeu6GjwVg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/11] rockchip: rk3288-firefly: Sort u-boot.dtsi nodes
 alphabetically
Date: Thu, 12 Dec 2024 22:09:35 +0000
Message-ID: <20241212221000.94501-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f47a511ed8f0b3fc7fb
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

Sort the nodes in rk3288-firefly-u-boot.dtsi in alphabetical order.

This has no intended change to board DT, this only rearrange nodes in
preparation for future changes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-firefly-u-boot.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
index 30b471900b30..8870188e6129 100644
--- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
@@ -25,30 +25,26 @@
 	rockchip,sdram-params = <0x30B25564 0x627 3 666000000 3 9 1>;
 };
 
-&pinctrl {
+&emmc {
 	bootph-all;
 };
 
-&uart2 {
+&gpio3 {
 	bootph-all;
 };
 
-&sdmmc {
-	bootph-all;
+&pcfg_pull_up_drv_12ma {
+	bootph-pre-ram;
 };
 
-&emmc {
+&pinctrl {
 	bootph-all;
 };
 
-&gpio3 {
+&sdmmc {
 	bootph-all;
 };
 
-&pcfg_pull_up_drv_12ma {
-	bootph-pre-ram;
-};
-
 &sdmmc_bus4 {
 	bootph-pre-ram;
 };
@@ -64,3 +60,7 @@
 &sdmmc_pwr {
 	bootph-pre-ram;
 };
+
+&uart2 {
+	bootph-all;
+};
-- 
2.47.1

