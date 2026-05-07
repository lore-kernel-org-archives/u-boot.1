Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DFACD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C5184A27;
	Thu,  7 May 2026 10:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="Gd2yupju";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0mtN6am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9308D84A29; Thu,  7 May 2026 10:06:24 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A104784A1E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AA7761400009;
 Thu,  7 May 2026 04:06:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 04:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1778141179;
 x=1778227579; bh=CZ6hUpSEcwieECPxnKdC5bmBkFZn1+1Ip6P4iZJZ7Lk=; b=
 Gd2yupjujUG7rMW1t6WLmEAFAOjXpW6kwDRYEOASfHGvZ7MYq1pdT9NlDvItwNEd
 0dnfhYi1HgnIKoaqzYaOXTBaKjpHGGDKvr5aRXRIowPnT6OzIkQaIO147ZwCydvC
 3WBCxE12TpMSm28irK2K9mTbU7ZMjvcbcwVoKrzbRR0sV4FGHS+lu4GJkCWGVFhf
 PhNFb7UCb0ankPkST0iWGH3v5ekyIl3f4ORNdKIBko9ruo52EejZR02SJ6QydHrU
 Deej2ZVWMNOGD63Zi9zxO/VwL5thuTijnBoGp60eHh7yMz1NTkxIUpb6Bi+mpDaz
 sf/p2d8bWc8O2tueqwQeag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778141179; x=
 1778227579; bh=CZ6hUpSEcwieECPxnKdC5bmBkFZn1+1Ip6P4iZJZ7Lk=; b=H
 0mtN6amC7KNQa4klLlSrR4R6almv/NuB9IfylNG/OiyarwCyJl3jZLGQbEUzCf9Q
 iPlYgaTnsfy1FelAFVOhf1VJg5SnBTQ2kOUEP+VKq5/d3dvj15BF7dH+R7hY+X0j
 DDWDRTXmzoLejKDgpwDNATZ6PN647mERFk6Nc/Yo/Gu5UtCYM1zX/4XP8QLaNzIr
 bXi3TwFg3WAM3mvhJye1G0mCZLqXjGqRvAcfnSo3SWc/kDvL1/FX4ZGGYbUm0Ijy
 +VVOAnYCWANMRzuMc40kpEKc2PbJsrH2steHiWangTZGld8nItf10ajz4W/91viZ
 CRRJ0NmS/1a9pJURbfEuQ==
X-ME-Sender: <xms:-0f8aSf9pMsF-MKP8T6LT448WWOBjZ1WxeN8ocy4CF50KonZj_KFvQ>
 <xme:-0f8aTOU04VDnII8dq83MqXEz-KwYDN2iB2r3ytwHnAqKxFOMI-e3E_DkOfbrHB7O
 Iyce_GdCnUemRX3aquML6XffUFpUOfdQg0g_A37chr6NgvC_gqtzeA>
X-ME-Received: <xmr:-0f8aYj5KVkfr395AlkzDHObdjxp96nbJkkT648c8Mxj24J_Dk81rCIxzEf1WML_w0vF0AKxo_XWySfk2vvPS4OCy874RcYfLpPM_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeileehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
 ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
 ekgeduheegtdekvdeifeegkeekledujeelkeevhedvvdejtdeuveekffffheelnecuffho
 mhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghp
 thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvthhtvghnihhsse
 hophgvnhgsshgurdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghp
 thhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghooh
 htsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:-0f8ae18j387onAVRVV6wPp_ywYPtjrox2ihq-xUBgetwyspmIHFeA>
 <xmx:-0f8aahUEph-M68P6MKCYRfYpHqM5RZNEm-ZiMrFubY191J2Utt43A>
 <xmx:-0f8aWdJU0Gb471dnadk9jktq_ssdlU1T0aYK1VPvCG0-KeA2clkdQ>
 <xmx:-0f8aVneRyngQD4KyuRX3WsPFMe80QT6nuz4rjGTGOpnR2erxFgAtg>
 <xmx:-0f8aY-BPeJVGih9ko99Inf0AtiiALSOUL2UHjKKwz0PDm_G6zNsWgM4>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 04:06:19 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 10:05:50 +0200
Subject: [PATCH v2 2/3] doc: device-tree-bindings: Remove
 apple,pinctrl.yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-apple-dt-upstream-v2-2-35181f2b0509@jannau.net>
References: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
In-Reply-To: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=1DwQsahD0veYEkS23Vs22CE2EqXMsEsJDcqaJ7LFvoI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/7t/42+Tnytcv7f/S0Jwt4y7vkxi6YIGehuvC+eK1v
 Se3+Ct0lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmIiNEiPDEcuVj3jy1rMLRZ7l
 Y3A5/+7ELp5Pi3TSVPfe+WFffKN7KiPDyzNzXy7bearESVrbjjOv/NmlxM+p8149cNv5dcnisDv
 qzAA=
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
2.54.0

