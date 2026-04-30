Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54ACD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB73803C6;
	Thu, 30 Apr 2026 23:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="JuqEfR3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA66583936; Thu, 30 Apr 2026 23:55:19 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 794AC80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 463bd8ec-44df-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 463bd8ec-44df-11f1-8ff3-005056999439;
 Thu, 30 Apr 2026 23:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=EbmfcKBIqQ+UFSdH0vjYB+JlhjU5AoLoZ4JFtJ91Ppk=;
 b=JuqEfR3Xd/HdgT4SNz3l6AYb9akZ6hiuGA8a6eVdoH6tSpoQGIxV7ExaAb1V3jGg7LDAIrKlVDHrg
 4QThAB6JSniJQeO9GLVSA4kC2gsgdafQzpDY90yYPe6yBoDYlWUMOLvONIPIcO48UyxMLbmWymZuFB
 TlBsxZdlDVx9J6xl5Pt/ekLZV+hFwlC6vaukvrz0KkqOD5X+uWTOTfns2hOJHFzNJwRhQ3X0MBqeZ2
 3sTlghc6mk9OTpunGYXuq+XTTTRDcxTdbkdrR66WG6+Q5e7i9G03PR0jDykLS9tpjmkGW8lrN7sIjJ
 hjsQdEloXrjqd5HqxSDOOd6hEBBXUXA==
X-KPN-MID: 33|reZvrZfceXlNtAZdMSBMhEHELm0uN4CT3BiJJQcvesN5pgx6Hu7oVkjLeaDtEzQ
 76Z+SpZpFgikLVRZtO79Tj0h3EWWl7AliUxbTHHUMNvA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|QlwG/EuLqQ+8/gnl4MWyPKqTFytndbyGRRA34FWunGkIfwmCyN2AP5TBp0al9/A
 98SPem9ipU17s8AOrCorz/Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 45b04716-44df-11f1-9c0c-00505699d6e5;
 Thu, 30 Apr 2026 23:55:17 +0200 (CEST)
Date: Thu, 30 Apr 2026 23:55:16 +0200
Message-Id: <87ecjw8663.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 j@jannau.net
In-Reply-To: <20260430-apple-dt-upstream-v1-2-dda66c16e0da@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:25:47 +0200)
Subject: Re: [PATCH 2/3] doc: device-tree-bindings: Remove apple,pinctrl.yaml
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
 <20260430-apple-dt-upstream-v1-2-dda66c16e0da@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Thu, 30 Apr 2026 23:25:47 +0200
> 
> Remove outdated apple,pinctrl.yaml. The dts/upstream contains the
> current version of this binding.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  .../pinctrl/apple,pinctrl.yaml                     | 106 ---------------------
>  1 file changed, 106 deletions(-)
> 
> diff --git a/doc/device-tree-bindings/pinctrl/apple,pinctrl.yaml b/doc/device-tree-bindings/pinctrl/apple,pinctrl.yaml
> deleted file mode 100644
> index d50571affd1..00000000000
> --- a/doc/device-tree-bindings/pinctrl/apple,pinctrl.yaml
> +++ /dev/null
> @@ -1,106 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/pinctrl/apple,pinctrl.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Apple GPIO controller
> -
> -maintainers:
> -  - Mark Kettenis <kettenis@openbsd.org>
> -
> -description: |
> -  The Apple GPIO controller is a simple combined pin and GPIO
> -  controller present on Apple ARM SoC platforms, including various
> -  iPhone and iPad devices and the "Apple Silicon" Macs.
> -
> -properties:
> -  compatible:
> -    items:
> -      - const: apple,t8103-pinctrl
> -      - const: apple,pinctrl
> -
> -  reg:
> -    maxItems: 1
> -
> -  clocks:
> -    maxItems: 1
> -
> -  gpio-controller: true
> -
> -  '#gpio-cells':
> -    const: 2
> -
> -  gpio-ranges:
> -    maxItems: 1
> -
> -  interrupts:
> -    description: One interrupt for each of the (up to 7) interrupt
> -      groups supported by the controller sorted by interrupt group
> -      number in ascending order.
> -    minItems: 1
> -    maxItems: 7
> -
> -  interrupt-controller: true
> -
> -patternProperties:
> -  '-pins$':
> -    type: object
> -    $ref: pinmux-node.yaml#
> -
> -    properties:
> -      pinmux:
> -        description:
> -          Values are constructed from pin number and alternate function
> -          configuration number using the APPLE_PINMUX() helper macro
> -          defined in include/dt-bindings/pinctrl/apple.h.
> -
> -    required:
> -      - pinmux
> -
> -    additionalProperties: false
> -
> -required:
> -  - compatible
> -  - reg
> -  - gpio-controller
> -  - '#gpio-cells'
> -  - gpio-ranges
> -
> -additionalProperties: false
> -
> -examples:
> -  - |
> -    #include <dt-bindings/interrupt-controller/apple-aic.h>
> -    #include <dt-bindings/pinctrl/apple.h>
> -
> -    soc {
> -      #address-cells = <2>;
> -      #size-cells = <2>;
> -
> -      pinctrl: pinctrl@23c100000 {
> -        compatible = "apple,t8103-pinctrl", "apple,pinctrl";
> -        reg = <0x2 0x3c100000 0x0 0x100000>;
> -        clocks = <&gpio_clk>;
> -
> -        gpio-controller;
> -        #gpio-cells = <2>;
> -        gpio-ranges = <&pinctrl 0 0 212>;
> -
> -        interrupt-controller;
> -        interrupt-parent = <&aic>;
> -        interrupts = <AIC_IRQ 16 IRQ_TYPE_LEVEL_HIGH>,
> -                     <AIC_IRQ 17 IRQ_TYPE_LEVEL_HIGH>,
> -                     <AIC_IRQ 18 IRQ_TYPE_LEVEL_HIGH>,
> -                     <AIC_IRQ 19 IRQ_TYPE_LEVEL_HIGH>,
> -                     <AIC_IRQ 20 IRQ_TYPE_LEVEL_HIGH>,
> -                     <AIC_IRQ 21 IRQ_TYPE_LEVEL_HIGH>,
> -                     <AIC_IRQ 22 IRQ_TYPE_LEVEL_HIGH>;
> -
> -        pcie_pins: pcie-pins {
> -          pinmux = <APPLE_PINMUX(150, 1)>,
> -                   <APPLE_PINMUX(151, 1)>,
> -                   <APPLE_PINMUX(32, 1)>;
> -        };
> -      };
> -    };
> 
> -- 
> 2.53.0
> 
> 
