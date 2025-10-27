Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B4CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEB082A9E;
	Mon, 27 Oct 2025 06:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gGZn4gQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2EC82C7F; Mon, 27 Oct 2025 06:23:20 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C4680422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D6A8510525F; Mon, 27 Oct 2025 06:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761542597;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=tOkbQydeTVTiGzr1IJ2lTy3jTZU2lLswgfYYt8EfiCI=;
 b=gGZn4gQeIccndsIygjstRXOTXDhX6gFbf1dVnidI0zI3KfhbieoEULEMM4LG8e4hxXic/o
 mF4xfoYcn+OyXy1JGEZa+43eN2xU/W+6WobK/EW1KlL2RfIH3DtYL1QtJewZy1NKAM+6pA
 MHMZsXnFyYq9DEphTABEHIguKnp21o0pdOouxBN6cI5XYIMyl8q4zDD7OWKiojOAuu7LcP
 a2ng+rxtGsbdBwd5cjGMna/XOm9u4WzhkQWBWPC4hbjSYkmsDSnN+x5W4PHBSZlhpIzv9Q
 jWmtyYMN5+CT/3N3dvXx/9yOLr89zkbUlA/InXXPOPnmMSA/uSur6QqHYsw29Q==
Message-ID: <a68e90ba-5d0e-14f8-38b2-3715689c05a8@nabladev.com>
Date: Mon, 27 Oct 2025 06:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] i2c: add support for the MT7621 I2C controller
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Justin Swartz <justin.swartz@risingedge.co.za>, u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Tom Rini <trini@konsulko.com>
References: <20251008114831.30124-1-justin.swartz@risingedge.co.za>
 <d7311234-d316-e142-b11a-76417372d872@nabladev.com>
In-Reply-To: <d7311234-d316-e142-b11a-76417372d872@nabladev.com>
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

I am sorry, checkpatch drops some warnings, can you please fix them?

Thanks!

bye,
Heiko

[1] checkpatch warnings
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#233:
new file mode 100644

ERROR: Do not add common.h to files
#260: FILE: drivers/i2c/mt7621_i2c.c:23:
+#include <common.h>

CHECK: Prefer using the BIT macro
#281: FILE: drivers/i2c/mt7621_i2c.c:44:
+#define SM0CTL1_START                 (1 << 4)

ERROR: open brace '{' following struct go on the same line
#294: FILE: drivers/i2c/mt7621_i2c.c:57:
+struct mt7621_i2c_priv
+{

ERROR: trailing whitespace
#323: FILE: drivers/i2c/mt7621_i2c.c:86:
+^I$

ERROR: trailing whitespace
#327: FILE: drivers/i2c/mt7621_i2c.c:90:
+^I$

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#409: FILE: drivers/i2c/mt7621_i2c.c:172:
+       u32 status = *(volatile u32 *)(priv->base + REG_SM0CTL1);

ERROR: trailing whitespace
#415: FILE: drivers/i2c/mt7621_i2c.c:178:
+^I$

ERROR: trailing whitespace
#464: FILE: drivers/i2c/mt7621_i2c.c:227:
+^I^I$

ERROR: trailing whitespace
#468: FILE: drivers/i2c/mt7621_i2c.c:231:
+^I^I$

ERROR: trailing whitespace
#481: FILE: drivers/i2c/mt7621_i2c.c:244:
+^I$

ERROR: trailing whitespace
#484: FILE: drivers/i2c/mt7621_i2c.c:247:
+^I^I$

ERROR: trailing whitespace
#488: FILE: drivers/i2c/mt7621_i2c.c:251:
+^I^I$

ERROR: trailing whitespace
#492: FILE: drivers/i2c/mt7621_i2c.c:255:
+^I^I$

ERROR: trailing whitespace
#496: FILE: drivers/i2c/mt7621_i2c.c:259:
+^I^I$

ERROR: trailing whitespace
#500: FILE: drivers/i2c/mt7621_i2c.c:263:
+^I^I$

ERROR: trailing whitespace
#511: FILE: drivers/i2c/mt7621_i2c.c:274:
+^I$

ERROR: trailing whitespace
#519: FILE: drivers/i2c/mt7621_i2c.c:282:
+^I$

ERROR: trailing whitespace
#521: FILE: drivers/i2c/mt7621_i2c.c:284:
+^I$

ERROR: trailing whitespace
#546: FILE: drivers/i2c/mt7621_i2c.c:309:
+^I$

total: 17 errors, 2 warnings, 1 checks, 395 lines checked

On 27.10.25 05:49, Heiko Schocher wrote:
> Hello Justin,
> 
> On 08.10.25 13:48, Justin Swartz wrote:
>> This commit introduces a port of the Linux kernel's driver for the
>> Mediatek's MT7621 I2C controller.
>>
>> The port was undertaken as the existing driver intended for Mediatek
>> I2C controllers (mtk_i2c.c) is not compatible with the MT7621.
>>
>> To use the driver:
>>
>>    1.  Ensure that the mode of the i2c pin group is
>>        configured for "i2c" rather than "gpio".
>>
>>    2.  Delete the existing (bitbanged) i2c node from
>>        arch/mips/dts/mt7621.dtsi, or specify:
>>
>>          /delete-node/ &i2c;
>>
>>    3.  Declare:
>>
>>          i2c: i2c@1e000900 {
>>                  compatible = "mediatek,mt7621-i2c";
>>                  reg = <0x1e000900 0x100>;
>>
>>                  clocks = <&clk50m>;
>>                  clock-names = "sys_clock";
>>
>>                  resets = <&rstctrl RST_I2C>;
>>                  reset-names = "i2c_reset";
>>
>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&i2c_pins>;
>>
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>>                  status = "okay";
>>          };
>>
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>>
>> Notes:
>>      [PATCH v3]
>>      - Add an empty line between variable declaration and code to
>>        functions that did not have this separation.
>>      - Condense multi-line closing brace / else / opening brace
>>        sequences into single lines consisting of "} else {" instead.
>>      - Relocate mt7621_i2c_check_ack()'s I2C_M_IGNORE_NAK flag check
>>        to just after the last variable declaration.
>>      [PATCH v2]
>>      - Add "REG_" prefix to I2C (Serial Master 0) register definitions.
>>      - Remove unused "PINT" (Peripheral Interrupt) register definitions.
>>      - Adjust function definition style.
>>      - Refactor mt7621_i2c_check_ack() to accept the number of bytes
>>        expected to have been acknowledged, instead of accepting a
>>        literal value (which represents the acknowledgement status of
>>        (up to) 8 bytes, encoded as 8 independent bit values) expected
>>        in the SM0_ACK field (bits 23:16) of the SM0CTL1 register.
>>
>>   drivers/i2c/Kconfig      |   7 +
>>   drivers/i2c/Makefile     |   1 +
>>   drivers/i2c/mt7621_i2c.c | 375 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 383 insertions(+)
>>   create mode 100644 drivers/i2c/mt7621_i2c.c
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> 
> bye,
> Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
