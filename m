Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B30CE65D14
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 01:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7449388F7B;
	Fri, 22 Nov 2024 02:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732240759;
	bh=3+Bsn09aYb/0kJYBUDh2Hn/rbWpL1Ua0maiQKirklyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wrlnYvsOAiM38T/0gWygQJpjXlv3gfhN5pdj9DFtD3H8F/I7/u46rufr4JEbT5wGj
	 uob1FK8aSDbhyu4msX0aUZruXdk+5dPL8j1YgDFPAMBNJfki+RtnuBdhlMV6CbeDey
	 T60Mi9zoraKTK2NzIrN+G1uRl2qVg5ir1SDq0qUVKYO+aiPBaOSeAFil++JQxsjs88
	 rI8sJEAl/LK+k6bZzH8ZLT4cc/9BlaBQmSUbcaZNeLCYMLPH7YoYk/7ZFsBPC/lc4h
	 sCu30GTPQvx3VK5yknxnJ2gMobb9J9iyW9ymJTRr2a5WCS5cDJqKAHhH9j2ieJs3ol
	 Dty6ju41XR+Dg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E2B1989117;
 Fri, 22 Nov 2024 02:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732240756;
 bh=3+Bsn09aYb/0kJYBUDh2Hn/rbWpL1Ua0maiQKirklyA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R3O9dJgqDhgOWaplqS9FGTyp6Wad70x0MUeHWBuHA7hoPXoajxEwA098T5got85TB
 NIKnvmdbQ7kG/jpes8aWqEG/VxmJ3gGm/jPQyNiVvUcbGFkbDVz3jZoYO/O6A0CHFB
 iEcFgVjxGdvU+1bT1SQL67yrZO39W0ZRx+X4xtCfdXHpEmYDzwv2WAqnyxuCwQLd5O
 lSP6GrFQjzkglbYYakYTtD3/+HAsz9Eh/I6c7oxOY2geIGXZ0ylZd00Ypvz+hq+eUB
 csvaZoph9k1nUNyH+u2sZLJcbsirklYXuhdmxDsalueDEVg9XGb55SuWfH6whXnwg9
 PbqYN80LtrFGg==
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
Subject: [PATCH 3/4] arm64: dts: imx8mn: Remove unreferenced clock-controller
 clocks in SPL DTs
Date: Fri, 22 Nov 2024 02:58:14 +0100
Message-ID: <20241122015858.557561-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122015858.557561-1-marex@denx.de>
References: <20241122015858.557561-1-marex@denx.de>
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

Remove the clocks property phandles which cannot be resolved because their
matching nodes are removed from SPL DTs, so fdtdec_parse_phandle_with_args()
can resolve all the remaining valid nodes and successfully look up the osc_24m
clock.

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
NOTE: For v2025.04
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 6d80d856365..38e1934aee8 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -51,6 +51,10 @@
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 	/delete-property/ assigned-clock-rates;
+#ifdef CONFIG_SPL_BUILD
+	clocks = <&osc_24m>;
+	clock-names = "osc_24m";
+#endif
 };
 
 #ifdef CONFIG_FSL_CAAM
-- 
2.45.2

