Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEEEE65D14
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 01:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFD8893A4;
	Fri, 22 Nov 2024 02:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732240756;
	bh=pRgLlihTqfK98Cuk5JyVHyR4J4i+6DMlvfXdWjyJCZc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v9S/CjDrxrwtPBAlrMt12pn0pgtmw+1MyTj8s7nCx6ApLpV+o+KhQb5oDQjoxO59l
	 A/jktDI2PYNy6GPPFiKlINsC8CaGLOtw1pvTTF4z1tukY6kuoVOyhgbrK+2/cle8Rm
	 GByjQ6GPh8Q7CXprAJ2qym64huxemfRSjOMIzsD+4kCAWpxNyiUGOvkv6GKozMEVNm
	 FLn1ZLnzbhB4JM/Mz/21Yv33y6ECStAUkAMUFRuwgYh1q219mnycpGJBSNVVi6BQhU
	 jf1zze3qfyGvk8xl2I/rnVCkD32QiNYKhy8vtamUuwic07mw84vivBZtBmlMVLkq/U
	 Nkn2gKjZma5HQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3D68E88D61;
 Fri, 22 Nov 2024 02:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732240755;
 bh=pRgLlihTqfK98Cuk5JyVHyR4J4i+6DMlvfXdWjyJCZc=;
 h=From:To:Cc:Subject:Date:From;
 b=hALO4EMuITO83WlEAK5tONIjzG15KHsyFKK5OaPcA1mSMD8cELlz/jK9+vi/z1S/p
 K7tDV+c5jfb+4//WdJbEsdo15TRE5FIB5KORtup6vwqTiMiqi2LYigr7IW+clJeHFa
 TurC6gHAvQcatlTpnaW17rvSYmFPpWEnKtihINUtsP5Gcs9FyMqf0wZIIIrY78/ivG
 8l0OEOWIoTHhqTOf9uFlN6uoKtbVexU/mCfZ6tFg3Y2MYb4YKxIWUBTuiP+rQcRCXg
 boidAI5Z8oiP1OvCpEuj+Cde8XxBIBcvYPDVlvI7OtQGqUmUvGQmRg9Vr2nJkrbgLM
 T5OH33XcQ2KmQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] arm64: dts: imx8mn: Include 32kHz oscillator clock in SPL
 DTs
Date: Fri, 22 Nov 2024 02:58:12 +0100
Message-ID: <20241122015858.557561-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent"),
drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_clk)
fails with error -22 EINVAL in SPL. This is because clk_get_by_name() in the
end calls fdtdec_parse_phandle_with_args(), which iterates over all phandles
in clock-controller@30380000 { clocks = <&osc_32k>, <&osc_24m>, ... } node
'clocks' property in an attempt to find the "osc_24m" clock, but fails to
resolve the &osc_32k phandle and returns with -EINVAL.

Include the osc_32k clock in SPL DTs as a low risk fix for v2025.01 release.
This way, fdtdec_parse_phandle_with_args() can resolve both the osc_32k and
following osc_24m phandle and successfully look up the osc_24m clock.

Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Malysa <greg.malysa@timesys.com>
Cc: Ian Roberts <ian.roberts@timesys.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.01
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 6875c6d44ff..6d80d856365 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -68,6 +68,11 @@
 	bootph-all;
 };
 
+&osc_32k {
+	bootph-pre-ram;
+	bootph-all;
+};
+
 #ifdef CONFIG_FSL_CAAM
 &sec_jr0 {
 	bootph-pre-ram;
-- 
2.45.2

