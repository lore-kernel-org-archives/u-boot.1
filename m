Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADFBCD612F
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 20:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906F786C32;
	Mon,  9 Oct 2023 22:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="D48MRUAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A571786D4A; Mon,  9 Oct 2023 22:41:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCF4864A9
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 22:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5f6d=FY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1696884106;
 bh=p6n2dyBlHim3xEMmFw5/gsjqIdIdxmveY0GoOEOh1rk=;
 b=D48MRUAS9biMsZgNKUZHiw19h9wXZM8rNtgOE9hQ+6GBjvwZ+5B5sJqh4gVyFoUKj7/Xm69Va
 67U+nPDa2NhVA629wQo7y5Z6Rn49p2OxNs7Q9lRx2FMv1DsBbLH/MefsniyIGp/sZI/+xuciNaY
 YysCjHUMb50jTrZbmcONZUWq7HN+byZG1ga4nREI4iJxLKWG1R24H9VwtNpOPRrH6wlIZ7LSF44
 ez/bRSGqtxwA7y4q/hwW5lnh4OtNl+N+zuvANwP/pK4Jid0Uvqgk1Qs5m2O3TS7ojFUbG99B5dM
 9kcef3qgksVcOMqYdGFMTHU1yugb3r7yF/mk3t3H/4gA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3] rockchip: rk3568-radxa-e25: Enable pcie3x1 node
Date: Mon,  9 Oct 2023 20:41:39 +0000
Message-ID: <20231009204141.3074894-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6524658aae6aaef2f99d9ecd
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

Enable mini PCIe slot, pcie3x1 node, now that the PCIe PHY driver
support bifurcation.

A pinctrl is assigned for reset-gpios or the device may freeze running
pci enum and nothing is connected to the mini PCIe slot.

Also drop the AHCI_PCI Kconfig option as this option is not required for
a functional M.2 SATA drive slot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3:
- Collect r-b tag

v2:
- No change

 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi | 11 +++++++++--
 configs/radxa-e25-rk3568_defconfig        |  1 -
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
index 572bdc5665b1..1136f0bb3b81 100644
--- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
@@ -8,9 +8,16 @@
 	};
 };
 
-/* PCIe PHY driver in U-Boot does not support bifurcation */
 &pcie3x1 {
-	status = "disabled";
+	pinctrl-0 = <&pcie30x1_reset_h>;
+};
+
+&pinctrl {
+	pcie {
+		pcie30x1_reset_h: pcie30x1-reset-h {
+			rockchip,pins = <0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &sdhci {
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index a905100a794d..2dfff6af3bd1 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -54,7 +54,6 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-CONFIG_AHCI_PCI=y
 CONFIG_DWC_AHCI=y
 CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
-- 
2.42.0

