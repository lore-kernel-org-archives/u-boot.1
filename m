Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5232E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FFC800D2;
	Mon, 16 Dec 2024 00:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734305546;
	bh=mZ1TqDvY1cWuKJdV5IkGigloKzC2gc2iO83Z0FHST/8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i5xKpJdhCaLrNHy1Le43G04xFWDcvhBcJ70BMi+Lf2PmH1cn+UGLuWCU0SzfWXzRt
	 8CG7LhCPStpkEVm/4vwpUn4AgW4xRQ42xN4d4Wup5LVfTBkJTFIXWxpzGu7vR1mVZY
	 piT78qTGOq63iUkm4V64oQDIDbr54gL+lFPuXwHZC3cCcHMKU8bjTse2Hz5AV/l7re
	 CgKqFaNP7eJ0TeHnObLiYczQOJIq58hFFXW3fnGZi+5EskiKeg7xH+GADNBiWixY/u
	 yIEW+M38Vet7vhqBY/2PTkQ4fwTB4FYN7H8587/5moLc8k4+LwNAhsuAqEjFUxVIkE
	 2BpXmXxDNUrDA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CF1800D7; Mon, 16 Dec 2024 00:32:25 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206AC80092
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TtbR5V4w"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BE3A71048AF66; Mon, 16 Dec 2024 00:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734305542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mZ1TqDvY1cWuKJdV5IkGigloKzC2gc2iO83Z0FHST/8=;
 b=TtbR5V4wlmcedhu5gaC7DNEZCNFk7QfdzAJmegJPBGqgzhIN+3pD7j1ZPjZskAu3DlobMC
 JOOM3ZX7tJiE5rVKiy/PCdP+nC5UjlVk9FVfJh/fKQDUxUaYXQo6fz2OLDHyBz1RhIHH2u
 3Vr3VQ75J5yy+OhC7vx+jP5Mvtws3ZdVVldZpDDuIFwx0K4SAEzGxa9elDyQR37N+1VInp
 6lr2EJkltg2rQ5I8wossFKJFX7376t05Ds2TAk5G9IEIUDoCNK1dpTuOl4Ki88pmshj3AV
 q2CwOHUywZEVFgTCOI7p18T+XAhw/Cu2QfQmz3RAq44jVfQfWtOZvtBt/AYU2w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Reinstate missing root oscillators on
 STM32MP15xx
Date: Mon, 16 Dec 2024 00:31:38 +0100
Message-ID: <20241215233210.569642-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The root oscillators reference used to be in rcc node since
3d15245502c4 ("ARM: dts: stm32mp1: explicit clock reference needed by RCC clock driver")
however this is not part of upstream stm32mp151.dtsi . The
RCC driver does need this reference, reinstate it globally.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: Would be good for 2025.01, but needs to be tested on other systems
---
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/stm32mp15-u-boot.dtsi b/arch/arm/dts/stm32mp15-u-boot.dtsi
index 66d4c40c6a8..3f57bd5fe0f 100644
--- a/arch/arm/dts/stm32mp15-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15-u-boot.dtsi
@@ -186,6 +186,9 @@
 	bootph-all;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	clock-names = "hse", "hsi", "csi", "lse", "lsi";
+	clocks = <&clk_hse>, <&clk_hsi>, <&clk_csi>,
+		 <&clk_lse>, <&clk_lsi>;
 };
 
 &usart1 {
-- 
2.45.2

