Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3CEC369D5
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 20:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F1D8070C;
	Wed, 23 Apr 2025 22:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A8C807AE; Wed, 23 Apr 2025 22:09:13 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5D580194
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 22:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9A007B24F989
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 22:09:10 +0200 (CEST)
Message-ID: <c0023d23-4614-40c5-b612-9c0cb5b4d8b1@freeshell.de>
Date: Wed, 23 Apr 2025 13:09:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
From: E Shattow <e@freeshell.de>
Subject: RISC-V (and others?) UART0 clock rate from OF_UPSTREAM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Quoting Emil reply to
https://lore.kernel.org/lkml/CAJM55Z95pwTZmw-WPcUaB1BGpVoNgaRYYjUnqSFcLTNyVmZahg@mail.gmail.com/

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 8a59c3001339..6bb13af82147 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -635,6 +635,7 @@ GPOEN_DISABLE,
>  };
>
>  &uart0 {
> +	clock-frequency = <24000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";

"The uart0 node already has a reference to the uart0_core clock, so it
shouldn't need this property."

jh7110-common-u-boot.dtsi-26-&uart0 {
jh7110-common-u-boot.dtsi-27-   bootph-pre-ram;
jh7110-common-u-boot.dtsi-28-   reg-offset = <0>;
jh7110-common-u-boot.dtsi-29-   current-speed = <115200>;
jh7110-common-u-boot.dtsi:30:   clock-frequency = <24000000>;

$ grep -B1 -rn 24000000 dts/upstream/src/riscv/starfive/
dts/upstream/src/riscv/starfive/jh7110-common.dtsi-115-&osc {
dts/upstream/src/riscv/starfive/jh7110-common.dtsi:116: clock-frequency
= <24000000>;

What should U-Boot be doing to get this uart0 setting when OF_UPSTREAM ?

-E
