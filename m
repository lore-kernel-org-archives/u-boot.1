Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE9C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 15:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620A7810EA;
	Sun,  2 Mar 2025 16:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740930295;
	bh=xZYx1dIwK5FAkAjyPFC06ex1KaFT1IUk2n2Y1GLkbOM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZHTJgjoyIuK5NIbAo2aMj6xomVmLNJfUHe20qjCGzQa9AM7VYR0WeSQ3HXtoz0yaP
	 tslyrPO8MA3OPIkz9gZY0hBS5b2VpuCHd3zAxw6PLSiwwJYN2X2534B1jMkoLEmWB1
	 3+Uytu4j5zrqvEz/+OsinxnrU/fG5dhOJVVxwxTIFTrNTYH6mJcHuEMREzfVWhAuSx
	 YDGI2VfvIHni7nDuDKhkToFxCDKr8EVUp4uriGTr2JKtERiNmY61RbzuWaA0eGxBqX
	 HUurpORIHbMTuj9nQvwuWq2BeyCuAA5GRE8UvZY6YLVXKVqqZKMQ5eOyHXe28HMFWu
	 ifgx+tWeg0PnQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCBE810ED; Sun,  2 Mar 2025 16:44:54 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C418058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 16:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PEfoKN7P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E945210382D03; Sun,  2 Mar 2025 16:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740930290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xZYx1dIwK5FAkAjyPFC06ex1KaFT1IUk2n2Y1GLkbOM=;
 b=PEfoKN7P574mkiHN3dAD2SgdUR8lyrke4yjE8rLKsk7CoOi1ygNUjK3ikN+tdJbIwtvCeR
 OPT4DGhkxyuV/PhxzeKOr4Kcszn0hdMaXOu28Ee0cxGqxZtGY77FavYd2ixYQpTmtnBgmv
 zpEfO6gFryTF1mabnc+bccDCfHgtep1+KPfg8kCaHHO+CT2HTqBlCjX7ruOVMaZgRwI/t1
 CqZQIqlZUOwAr4x8F27ajZDlYvR/biYgL+9Koi5X40Cl0JV/n+A6GdSSCkH6b8mcaCQYoO
 Nqb3LUT+YC4CQ4OC6HgEcf9a9Htcbqrwjh98YWiN3SEd8plMRwOH92gO70Xx1Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Add support for STM32MP13xx DHCOR SoM and
 DHSBC rev.200 board
Date: Sun,  2 Mar 2025 16:43:41 +0100
Message-ID: <20250302154429.65581-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

LDO2 is expansion connector supply on STM32MP13xx DHCOR DHSBC rev.200.
LDO5 is carrier board supply on STM32MP13xx DHCOR DHSBC rev.200. Keep
both regulators always enabled to make sure both the carrier board and
the expansion connector is always powered on and supplied with correct
voltage.

Describe ST33TPHF2XSPI TPM 2.0 chip reset lines.

This is a port of Linux kernel patch posted at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250302152605.54792-1-marex@denx.de/
This change shall be removed when the Linux kernel DT change lands
and Linux kernel DTs get synchronized with U-Boot DTs.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 .../dts/stm32mp135f-dhcor-dhsbc-u-boot.dtsi   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/dts/stm32mp135f-dhcor-dhsbc-u-boot.dtsi b/arch/arm/dts/stm32mp135f-dhcor-dhsbc-u-boot.dtsi
index d718aae16ca..eace94f5fa4 100644
--- a/arch/arm/dts/stm32mp135f-dhcor-dhsbc-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp135f-dhcor-dhsbc-u-boot.dtsi
@@ -23,3 +23,25 @@
 &usbphyc {
 	bootph-all;
 };
+
+&st33htph {
+	reset-gpios = <&gpioe 12 GPIO_ACTIVE_LOW>;
+};
+
+/* LDO2 is expansion connector 3V3 supply on STM32MP13xx DHCOR DHSBC rev.200 */
+&vdd_ldo2 {
+	bootph-all;
+	regulator-always-on;
+	regulator-boot-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
+
+/* LDO5 is carrier board 3V3 supply on STM32MP13xx DHCOR DHSBC rev.200 */
+&vdd_sd {
+	bootph-all;
+	regulator-always-on;
+	regulator-boot-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
-- 
2.47.2

