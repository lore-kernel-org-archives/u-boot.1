Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A598CCCF9EB
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2BA839DD;
	Tue, 28 Oct 2025 09:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Zn2t2LnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D78983A2F; Tue, 28 Oct 2025 09:49:22 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCAE839CC
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4ADB1106DB3; Tue, 28 Oct 2025 09:49:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761641359;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=y9Mx/K/By+d4GJcvKUjwog4tKdP4JvEEoePnTgCEMt0=;
 b=Zn2t2LnB8rljP2tTkyHNjBxyH5GuByDZFLjGBou4xL5yPtn7AK6JYbwFCFDhIT3emLT9Tn
 YHnGGGO9zkVlYP9aOcciyHwCoa7jPn5OjrFf8xadvFkfI/fzt5I0yIShH8q3zeRk26VucH
 UDxxpe4EkAhXAlGyp1qh5wUdqETQ0t1RAEP0t8CswIHWoqtfhx7g7EfZ3aXUYXD/YNuAsM
 bi/jvbDq2FUUH6L22ysj75VM9ORd9zjsBGLbKLTEZXOVwgikDYtw8zJ2Gs97yNFPU5b3GN
 dJxX4CgHhouYJN9rZdsQBgnMcdYVHX3n0J7bVbgysFXtJFHeZGokoGALKQlnjw==
Message-ID: <5dfacb55-9e64-79a1-1f09-fb4fa11a9e15@nabladev.com>
Date: Tue, 28 Oct 2025 09:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] i2c: add support for the MT7621 I2C controller
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>, u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Tom Rini <trini@konsulko.com>
References: <20251027130942.12387-1-justin.swartz@risingedge.co.za>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251027130942.12387-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello Justin,

On 27.10.25 14:09, Justin Swartz wrote:
> This commit introduces a port of the Linux kernel's driver for the
> Mediatek's MT7621 I2C controller.
> 
> The port was undertaken as the existing driver intended for Mediatek
> I2C controllers (mtk_i2c.c) is not compatible with the MT7621.
> 
> To use the driver:
> 
>    1.  Ensure that the mode of the i2c pin group is
>        configured for "i2c" rather than "gpio".
> 
>    2.  Delete the existing (bitbanged) i2c node from
>        arch/mips/dts/mt7621.dtsi, or specify:
> 
>          /delete-node/ &i2c;
> 
>    3.  Declare:
> 
>          i2c: i2c@1e000900 {
>                  compatible = "mediatek,mt7621-i2c";
>                  reg = <0x1e000900 0x100>;
> 
>                  clocks = <&clk50m>;
>                  clock-names = "sys_clock";
> 
>                  resets = <&rstctrl RST_I2C>;
>                  reset-names = "i2c_reset";
> 
>                  pinctrl-names = "default";
>                  pinctrl-0 = <&i2c_pins>;
> 
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  status = "okay";
>          };
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
> 
> Notes:
>      [PATCH v4]
>      
>      - Fix style and whitespace issues to appease checkpatch.pl
>      - Include time.h (instead of common.h) for get_timer()
>      - Replace mt7621_i2c_check_ack()'s MMIO register access,
>        via a volatile pointer, with readl() macro expansion.
>      
>      [PATCH v3]
>      
>      - Add an empty line between variable declaration and code to
>        functions that did not have this separation.
>      
>      - Condense multi-line closing brace / else / opening brace
>        sequences into single lines consisting of "} else {" instead.
>      
>      - Relocate mt7621_i2c_check_ack()'s I2C_M_IGNORE_NAK flag check
>        to just after the last variable declaration.
>      
>      [PATCH v2]
>      
>      - Add "REG_" prefix to I2C (Serial Master 0) register definitions.
>      - Remove unused "PINT" (Peripheral Interrupt) register definitions.
>      - Adjust function definition style.
>      
>      - Refactor mt7621_i2c_check_ack() to accept the number of bytes
>        expected to have been acknowledged, instead of accepting a
>        literal value (which represents the acknowledgement status of
>        (up to) 8 bytes, encoded as 8 independent bit values) expected
>        in the SM0_ACK field (bits 23:16) of the SM0CTL1 register.
> 
>   drivers/i2c/Kconfig      |   7 +
>   drivers/i2c/Makefile     |   1 +
>   drivers/i2c/mt7621_i2c.c | 374 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 382 insertions(+)
>   create mode 100644 drivers/i2c/mt7621_i2c.c

Thanks for fixing the checkpatch warnings.

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
