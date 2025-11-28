Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C546D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB5D83BC9;
	Fri, 28 Nov 2025 23:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RVu/qMcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7E683B63; Fri, 28 Nov 2025 21:22:48 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A487583B85
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so13359455e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764361366; x=1764966166;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5On/utwLV4j2y5Oy7g3lf56Sj2eYB7jy8mgNP2KxvMU=;
 b=RVu/qMcB835l7kba+lMTHxBDVGGnJMBhTZv0TxwqJo/G/J7cvYq3DGbWbJrBU+jB/o
 LTePY9DM5axE5JOxMoWeBl2RzOfYy27N4Lf5l/lwVAoqHmrQIVPm1Lf6XJMtWlNfUKzy
 7pK54OWdFObCbfbOD1y4rQbAw4bwxCmtwOizhjbkVN0Y3mhvrTTWyVQloUqE9KenPojE
 yuj49mpVHiTrteDoi3MSbt1yAWOyOEA1gsFJiwn0k24VpK7urURWzDspJKtQNJmsRFLI
 vLU6SbkSGWYtYqlRx5oox2JNSyspOtnDiN1rCV1CjiY+E0h7IvZRbXqTVDywF7//vUCQ
 m88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764361366; x=1764966166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5On/utwLV4j2y5Oy7g3lf56Sj2eYB7jy8mgNP2KxvMU=;
 b=siZ1kGT5EshXlov5er8eboKYs6UvAh8bHfjm1hcoOCGB73GRcHy8c+Gte7AnQ31gDS
 ujGal4FlpDmh+prG2yD6pv3TWw1vEW6YXcFTtVJbOg0IXCZk0WgS/OsaRJrsQDrk9D+7
 bzB3NuMcgT2VlpVjF5OfAIsHlkjLXCUUnsqLki7jtXtXLeWiWFLO4uuWpfAP9NoIm0a0
 iAt9SfyisjtT57ikXXOLBD50CPMA5XkcETRqv2FfD2MHnfcKv3TndSwysrujXT3GSe2O
 YLlDdXXUiGfHqPxhYdiT2Wv7w85c21aF/53y8HiwqU4myu36IlzPNwE4dZeY67dgD3uW
 Pcrw==
X-Gm-Message-State: AOJu0Yz7njMLTGtym9XJFxU/fITNJ10V8+UTBv5qEV3jsXYpFvAhB5Xq
 ZjRFRTpCZM8yGjw/p9m6GqrKWA7X0g6EymX61mAQX+s4th19fwsIdNbxdtpKxh180Y8=
X-Gm-Gg: ASbGncsR4cbMiUJS3/gdk9JMoSQiD9SWygTq26qbCJrT8ZVWARpoxvIkTTWZDrAJoDT
 c5UdsDmQhFJHgLCovERp9+UYGmBTtOV5Bg+GryxwFg46YhgqrqlMvZPi1yjQM5hfeSW3ba8kobJ
 XnDMCSX1nda5R6Ftrt/cWnNm3VX+SIfkKKzweCT1r4y6OZRJWQi90OrAzCoAx3c3oaGn+vDw7q4
 iZ4/sTmybN89/1n0Y8XxsRrM/IfwbTZD0pSZT3IaDFrrrsJ8BVb7kvReiAo8EAr9Nko9ON0kBGU
 mkKA7u2PJ6M/TaGnwXQwN8RIGv9K1UE9JUXKlkndwJtMIHAHCvfR7cGnQ2nDvxYdepA+yP8zsRa
 MIASd/5LiEkYnoyp/U3beFyX73gK8eYtP3wsHhwobQQBEWwpQqX3UgBwd1RvNzKAqBYuZsFhv1f
 CilViCX1A=
X-Google-Smtp-Source: AGHT+IH4hVHYYWZTczQPiTZCc9hgTCvUDx+LZtUixmMvAaPNmI1AYysAzCP6XCzoWkIIA6QXDe93BA==
X-Received: by 2002:a05:600c:5252:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-47904b248demr190913925e9.31.1764361366125; 
 Fri, 28 Nov 2025 12:22:46 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1caa7406sm11029048f8f.37.2025.11.28.12.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:22:45 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:22:18 +0100
Subject: [PATCH v2 1/2] clk: ti: Split common omap2plus functions into new
 symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-1-451b4f4e7e85@baylibre.com>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=msp@baylibre.com;
 h=from:subject:message-id; bh=uzPCcTZ84N2KUz1RYSNQ0sB2oZhQDK1AK749vqBZCjI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtlhY9X+mNZ4JmTDPjyF9WLpHzZdmKInWfk7/Pz/z9q
 YjtQeqPjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIK1OGf5Z/+bm25ZwWqWZp
 /Jj9w7dE2MLWqDnot9xkr19b5zW2WDD8dzz0qeG6wesLGx6w6p711D5vWv73S+nxus2H5gunq1x
 4wAoA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

Create a new symbol for the common clock functions used by some of the
omap2plus clock drivers. These drivers now select this new symbol when
they need the functions. Note these common functions are not
ARCH_OMAP2PLUS specific.

Note that the common functions are using regmap, so select it here.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/clk/ti/Kconfig  | 11 +++++++++++
 drivers/clk/ti/Makefile |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fdda283d6d374b28230c68a8b29720184680c67b..7b8da69712e4fa61c15f3fb0cbdc9f3fd8de31bb 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -3,9 +3,17 @@
 # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
 #
 
+config CLK_TI_OMAP2PLUS
+	bool
+	depends on CLK
+	select REGMAP
+	help
+	  Common clock functions used in some TI clock drivers.
+
 config CLK_TI_AM3_DPLL
 	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
 	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the DPLL clock drivers support on AM33XX SoCs. The DPLL
 	  provides all interface clocks and functional clocks to the processor.
@@ -19,18 +27,21 @@ config CLK_TI_CTRL
 config CLK_TI_DIVIDER
 	bool "TI divider clock driver"
 	depends on CLK && OF_CONTROL && CLK_CCF
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the divider clock driver support on TI's SoCs.
 
 config CLK_TI_GATE
 	bool "TI gate clock driver"
 	depends on CLK && OF_CONTROL
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the gate clock driver support on TI's SoCs.
 
 config CLK_TI_MUX
 	bool "TI mux clock driver"
 	depends on CLK && OF_CONTROL && CLK_CCF
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the mux clock driver support on TI's SoCs.
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index a58f19f46d9f189e9394e756a5cf7bd32480287d..329fae67889b11a9ef3c646b166243abcb956144 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -3,13 +3,14 @@
 # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
 #
 
-obj-$(CONFIG_ARCH_OMAP2PLUS) += clk.o omap4-cm.o
+obj-$(CONFIG_ARCH_OMAP2PLUS) += omap4-cm.o
 
 obj-$(CONFIG_CLK_TI_AM3_DPLL) += clk-am3-dpll.o clk-am3-dpll-x2.o
 obj-$(CONFIG_CLK_TI_CTRL) += clk-ctrl.o
 obj-$(CONFIG_CLK_TI_DIVIDER) += clk-divider.o
 obj-$(CONFIG_CLK_TI_GATE) += clk-gate.o
 obj-$(CONFIG_CLK_TI_MUX) += clk-mux.o
+obj-$(CONFIG_CLK_TI_OMAP2PLUS) += clk.o
 obj-$(CONFIG_CLK_TI_SCI) += clk-sci.o
 obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) += clk-k3-pll.o
 obj-$(CONFIG_$(PHASE_)CLK_K3) += clk-k3.o

-- 
2.51.0

