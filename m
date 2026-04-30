Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8D5CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981B0841D7;
	Thu, 30 Apr 2026 23:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="AW0viLjc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="qynF0uK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC21842C7; Thu, 30 Apr 2026 23:26:06 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA5984099
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 02F861D00099;
 Thu, 30 Apr 2026 17:26:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 30 Apr 2026 17:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1777584362;
 x=1777670762; bh=KU9K8T0MZDM6+yhznkFU4vH3jmtKb0bzOdlzTOScBjI=; b=
 AW0viLjc0iEmsK3F3tPfyanmootQzDoMPqqsoWD8zhS9Tn3WMn7/oeJ29xyuBKrm
 ZiNxPfCYFlo5AigiJlAM1MQSGpVp/v7NMAso4erDGMJh7p4u8y/7kDTzdu3o34qS
 tWkKHAg7uDcLHkFP3HZBEabEOfLS717LL+CuB3nzLelgssd4rO7QP5IXYYgHvBd1
 NQPO8stDw3RFoUf8oE0b+Qqk2LV5SlcObBsScEH3vE5H9PGl90PXrXeiHfx7mmz4
 TSBQNDF4kFwRVjkRCS9MeXekNglG3YadWTS9plvlhP/mQe1yh/czdeS9jaGZrJVH
 oZcEF8WBNRQ3ajZrRSC58A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777584362; x=
 1777670762; bh=KU9K8T0MZDM6+yhznkFU4vH3jmtKb0bzOdlzTOScBjI=; b=q
 ynF0uK5IYLpUzDRDk4VJ5FDIuK7hjWU5ioc04xzY4/YEyxImVE7SAx+7iqmdku5e
 wj6URfsymjS0hlF/wiueDzpTkMCQMAzHw4B7qMEsYaDjBSL9kw/+rwoqZXxhzXhK
 T00Fv2cjKRseaLC49TLnLtIuySOBA0znaXA4VpGv/tj5HNv6MiQz/RWPsFsAGYxK
 bctSjipM1yk8feBvAS7sGpP/EAP+iiTYf5opyCGXOMiMqj367pjvpyJiRkoAIksN
 dSFyZHa8fQCI/AOyEmiBEtZsSujuGhWvi4v7afbEqBVhUI/U2qjJjl4bCAQKulJC
 YAA/2f0r7FcHWZvin52Zg==
X-ME-Sender: <xms:6sjzaYyXosgDkD1SkTZgJpnHPq9ohHydjajII5cRz15K5uX_NU_Ijw>
 <xme:6sjzaTQPoQEOoF65EFg6E-czTZUUb0pDwWWlKrgnndIfqEP7kXiLlB-hqWEBb0KcN
 AiKh22ZFJtmcOLFqyblNVIonaGdMrqSKKKUZs9UdUMt_2kSNS7kMvk>
X-ME-Received: <xmr:6sjzafU-Fu8YLZZIWGvt9HAx6So_sSBFsOb0DyBDzMEL_ZJ8Jy-WDCxIEuEwalrBCrHWhRone1QrXurU9X1_Pq7HxjVWDp-VJJwFrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
 ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeevke
 egudehgedtkedvieefgeekkeeludejleekveehvddvjedtueevkeffffehleenucffohhm
 rghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphht
 thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghtthgvnhhishesoh
 hpvghnsghsugdrohhrghdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphht
 thhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhoth
 eslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:6sjzaVb6BCKn0Nhc_e5La-I1ZyR7g0oJkeVg5x0487xOmuwncldA6A>
 <xmx:6sjzaV0Qkf0g6JG3XGX2Zgh97BTpUCbQ2WxrbpO4tw50u8M-BBFOsw>
 <xmx:6sjzaXjTyVWScYStkV6M0vJrZC_agPkNDbpCsAhWWcLZ9rPW_z889Q>
 <xmx:6sjzaZbtd2U6fGoXiPsERxjxd7xSkMJl3NiETFhIt2_uj6Ev2A2ajQ>
 <xmx:6sjzaTMacnC_bZm_e3ekqZXNpFO5tDIsv3RQox3H2qbfM-LkB0ePY9B1>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:26:01 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:25:47 +0200
Subject: [PATCH 2/3] doc: device-tree-bindings: Remove apple,pinctrl.yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-dt-upstream-v1-2-dda66c16e0da@jannau.net>
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
In-Reply-To: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=wvz/oaWdvgZfCvif6I3G6liuKJyawdgiROoILWEMDJM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPJ+4yuu8PN3P/xdggevL3a6MNOvyPONxUpm499p9Dk
 ovhPOe8jlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABM57cPI8KMw903ShktLv7yW
 WJLBKnVv9uGf350j2uuZbDNSvAvXn2Bk+LBAS9swykO78pFTQMg95x/Ca9Ru532/dNXxpoTuusD
 ffAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Remove outdated apple,pinctrl.yaml. The dts/upstream contains the
current version of this binding.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../pinctrl/apple,pinctrl.yaml                     | 106 ---------------------
 1 file changed, 106 deletions(-)

diff --git a/doc/device-tree-bindings/pinctrl/apple,pinctrl.yaml b/doc/device-tree-bindings/pinctrl/apple,pinctrl.yaml
deleted file mode 100644
index d50571affd1..00000000000
--- a/doc/device-tree-bindings/pinctrl/apple,pinctrl.yaml
+++ /dev/null
@@ -1,106 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/apple,pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Apple GPIO controller
-
-maintainers:
-  - Mark Kettenis <kettenis@openbsd.org>
-
-description: |
-  The Apple GPIO controller is a simple combined pin and GPIO
-  controller present on Apple ARM SoC platforms, including various
-  iPhone and iPad devices and the "Apple Silicon" Macs.
-
-properties:
-  compatible:
-    items:
-      - const: apple,t8103-pinctrl
-      - const: apple,pinctrl
-
-  reg:
-    maxItems: 1
-
-  clocks:
-    maxItems: 1
-
-  gpio-controller: true
-
-  '#gpio-cells':
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
-  interrupts:
-    description: One interrupt for each of the (up to 7) interrupt
-      groups supported by the controller sorted by interrupt group
-      number in ascending order.
-    minItems: 1
-    maxItems: 7
-
-  interrupt-controller: true
-
-patternProperties:
-  '-pins$':
-    type: object
-    $ref: pinmux-node.yaml#
-
-    properties:
-      pinmux:
-        description:
-          Values are constructed from pin number and alternate function
-          configuration number using the APPLE_PINMUX() helper macro
-          defined in include/dt-bindings/pinctrl/apple.h.
-
-    required:
-      - pinmux
-
-    additionalProperties: false
-
-required:
-  - compatible
-  - reg
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/apple-aic.h>
-    #include <dt-bindings/pinctrl/apple.h>
-
-    soc {
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      pinctrl: pinctrl@23c100000 {
-        compatible = "apple,t8103-pinctrl", "apple,pinctrl";
-        reg = <0x2 0x3c100000 0x0 0x100000>;
-        clocks = <&gpio_clk>;
-
-        gpio-controller;
-        #gpio-cells = <2>;
-        gpio-ranges = <&pinctrl 0 0 212>;
-
-        interrupt-controller;
-        interrupt-parent = <&aic>;
-        interrupts = <AIC_IRQ 16 IRQ_TYPE_LEVEL_HIGH>,
-                     <AIC_IRQ 17 IRQ_TYPE_LEVEL_HIGH>,
-                     <AIC_IRQ 18 IRQ_TYPE_LEVEL_HIGH>,
-                     <AIC_IRQ 19 IRQ_TYPE_LEVEL_HIGH>,
-                     <AIC_IRQ 20 IRQ_TYPE_LEVEL_HIGH>,
-                     <AIC_IRQ 21 IRQ_TYPE_LEVEL_HIGH>,
-                     <AIC_IRQ 22 IRQ_TYPE_LEVEL_HIGH>;
-
-        pcie_pins: pcie-pins {
-          pinmux = <APPLE_PINMUX(150, 1)>,
-                   <APPLE_PINMUX(151, 1)>,
-                   <APPLE_PINMUX(32, 1)>;
-        };
-      };
-    };

-- 
2.53.0

