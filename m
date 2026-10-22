Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A4606A328
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TKwguEXJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fBvvgSja
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F0164099D;
	Thu, 22 Oct 2026 12:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yhC9aRsDjfUM; Thu, 22 Oct 2026 12:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B04B74099E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792670728;
	b=PH9J0U2v9bwqg5sJmkky5ZB2qzKa0oUNcxnjWIan2N84R+b6fUvhv0OPF0ajjguEvPLu
	 nMN1qu4H4WeaFAcTE8uJUj9MivR0xd7I0nkq63uA+BaAyZiqULMLffrd9mGplZWt8ylcg
	 pbhe6c8NcCp3FYaMw8sB0gV529ih6XouyTF91q/gr+Twat9FzI7IMmTMd3exdndHNXm77
	 9x+j+6cKG3GfHa33gJHu6gNTJtKhpSOdigqifnIoIuzsKNWjTFUwzfoGgLul67zBvEcf+
	 4caLp75tdTZHWSLslGOHU7Xc2NAyJ5M8tTugIXef6oQxR6SbG+vaw/Rsfj0hxcY1d1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792670728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rlauCELO5ifAaky7vbEvfCl9CRMp1CJ1sRi2lTFwg1E=;
	b=pr3Qvzk/JF26ZVChPrmzOcAelRi4fBXS1+Vy5XWGp2hSBKvWLb4zMe0M3npB/vQRAOFu
	 BlSvuGEYS+8o01SUlTa0amfpx73brEWrq3f1QjRQgYckYNwvBExOye6ngMqNhQtj4GpBb
	 WC5+qcorJpste2oVhba2a+4RbKA8Oy3khsWtsNVUtXM6x77t3fW0qNVa3+X8O6KjSYzT0
	 8H06dEJ0wuqS7xix8JRya7H+eXqY3p4ta3565VFHD/XSgfVqSoUUvzuLeBUo00XTSoTB2
	 TmAGmovDRoeFipsk49osSlUWyAlKppi0m96B7+ucMAJIEvj2hXf9GaFrdUngTc/Pssw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792670728;
	bh=rlauCELO5ifAaky7vbEvfCl9CRMp1CJ1sRi2lTFwg1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TKwguEXJdFjt7xT5o4uXEC7OwAeB+aT0vfhiJ35IwTNqGhcHUrTFGjFn6LHsHx/Vm
	 pbc6gv7ktOct+SL9IJjmzEPUd28cNxjs7x9lJO31XinfzBjC8AABrptwtp0bKbobFp
	 gtF6pcbn3B1jwhY24KpWO/Q0d8sQ6vkVfebgw2modAmIiYg/1jQy8gjiGDoArXkM+o
	 3TUal5YdFDq4VBIRcXtB51NvkiBv7IOzRMDpUYzFCZ0qt6QNaX/rhMfKJPYZrCxoOK
	 SVU7tIQfAW0jHszF6CC6LxF5tkP/P8rybREwbVDH04DfKHRRlvnGmFcpQv6MmcpXYZ
	 Ow3WpBMRkQiBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B04B74099E;
	Thu, 22 Oct 2026 12:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1067923A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DCF0812FE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUk6a4j8QQm6 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:05:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB8BD812B3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792670726;
 b=Bi47B8GKqxiYo8a63NNR25nRnWyR3xhRpuhQh5itBYnbXb0T8tT8XwS/GxbCXScmBbjW
 ++3EtqKUPmJmz+ayICE6iCGIoY8+rKKWeXPvIjx8OOblep5udlU0dj2MInb8EUQwHvVc4
 AxYMKC7E/WiTREgbAGHvjUWUtgnMKqt5Fy2H0SjhmAwlPkQTBR+wY0/1kXokhTnZqF9G8
 Snh5tWeMMAINQlqI95+PmRlN3Fz1eg16TRHZxOkR+08+GENrJ3tDa13NoVdW8zfm38/Kl
 aR97D/SCnVDdPttgcCct1XjIpciPqyCHMx8ZQCPup2PMtBhtnaSShctREeeZq+TwoOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792670726;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=rlauCELO5ifAaky7vbEvfCl9CRMp1CJ1sRi2lTFwg1E=;
 b=eLZoqGrR999eWeQB5RgDlpxsXz3dctPlu+IYyOgtGjVKoSk51HLDOj9AG1oT3mkWohlD
 7ok33GtZFtYF4dIrVMBLP/s2v/viG00mjkwm9uDiikqB2yo+bLcDR//526Xtr3bwnSb44
 V2QFnSB3VrEGZXCDNBQi0hun54XUrSDv6p9JzlxyvTETchiagDi2xPlhymmau/xHV6m6W
 yaPmpz5nuToDE6whS6opjrb5yrHe2ehG4/CjNI4wK5EG3o/qj9mVq4MbCownxosGKwrHm
 NMe3WxSS0n/AZkwwnDFrlCksHFT5BYEXqkNy2tRbIVvE7bqozZdYZ2E8hL/C9v2iXSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=fBvvgSja; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=fBvvgSja
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB8BD812B3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:05:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B76D2C41;
 Thu, 22 Oct 2026 05:05:21 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 505243F7B4; Thu, 22 Oct 2026 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792670724; bh=qzSuLckSneLjr2L66IPz9zmHXjwRIl1jjqPRY2ybfkU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fBvvgSjaflSZantpGl6e0TXPqc5XmUpI1AsSzykaj9EkuFHqrnn/jtKNL3xa9ktK8
 VCI0guN8NzUmtzJHEUhfreXQ7nEke7nZtJt2iUpJpbqPmQT4pFJpV8Zfli5GqOhuLz
 4VASGxTT0ZUujtwn2ipnWj8Y0NeJFd5dNTZZhsQk=
Message-ID: <b0f30962-3a67-4435-8786-b9b18d256eb5@arm.com>
Date: Thu, 22 Oct 2026 13:05:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sunxi: Add Orange Pi 3 LTS defconfig
To: filipescu.cristian@gmail.com, u-boot@lists.u-boot-project.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
 <20261022-sunxi-orangepi-3-lts-v2-2-46b9df5f9e43@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261022-sunxi-orangepi-3-lts-v2-2-46b9df5f9e43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian,

On 10/22/26 07:55, Cristian Filipescu via B4 Relay wrote:
> From: Cristian Filipescu <filipescu.cristian@gmail.com>
> 
> Add a separate configuration for the Orange Pi 3 LTS, using its local
> device tree rather than the original Orange Pi 3 board description.
> 
> Reuse the H6 LPDDR3, SD/eMMC and USB configuration from orangepi_3.
> Enable the sun8i EMAC and Motorcomm PHY driver for the LTS Ethernet
> hardware, and omit the AP6256-specific Bluetooth fixup used by the
> original board.
> 
> Enable GPIO LEDs in main U-Boot to light the green power LED on PL7.

Why? Please don't make this so complicated: we have the simple SPL power 
LED hook in, like you did in v1.

> Leave the early SPL status LED disabled. At the OS handoff, turn off
> green and turn on red before Linux initializes its LED driver. Limit
> this indication to the Orange Pi 3 LTS board compatible.
> 
> Extend the board maintainer entry to cover the new configuration.
> 
> Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
> ---
>   board/sunxi/MAINTAINERS          |  1 +
>   board/sunxi/board.c              | 19 +++++++++++++++++++
>   configs/orangepi_3_lts_defconfig | 19 +++++++++++++++++++
>   3 files changed, 39 insertions(+)
> 
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index e84219e2..6a47b9cc 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -442,6 +442,7 @@ ORANGEPI 3 LTS BOARD
>   M:	Cristian Filipescu <filipescu.cristian@gmail.com>
>   S:	Maintained
>   F:	arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
> +F:	configs/orangepi_3_lts_defconfig
>   F:	arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
>   
>   ORANGEPI 4A BOARD
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 3d1afec7..7b735a26 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -10,6 +10,7 @@
>    * Some board init for the Allwinner A10-evb board.
>    */
>   
> +#include <bootm.h>
>   #include <clock_legacy.h>
>   #include <dm.h>
>   #include <env.h>
> @@ -17,6 +18,7 @@
>   #include <i2c.h>
>   #include <image.h>
>   #include <init.h>
> +#include <led.h>
>   #include <log.h>
>   #include <mmc.h>
>   #include <axp_pmic.h>
> @@ -875,6 +877,23 @@ int board_late_init(void)
>   	return 0;
>   }
>   
> +void board_quiesce_devices(void)

Please try to avoid board specific code as much as possible. If you want 
your board to light up in a specific sequence, you could try to do this 
with a U-Boot script. But adding some code that does some arbitrary 
sequence of LED accesses is not a good idea. And doing this in 
board_quiesce_devices() sounds a bit like an abuse of that hook.

Cheers,
Andre
> +{
> +	struct udevice *dev;
> +
> +	if (!CONFIG_IS_ENABLED(LED))
> +		return;
> +
> +	if (!of_machine_is_compatible("xunlong,orangepi-3-lts"))
> +		return;
> +
> +	/* Indicate the OS handoff before Linux initializes its LED driver. */
> +	if (!led_get_by_label("red:status", &dev))
> +		led_set_state(dev, LEDST_ON);
> +	if (!led_get_by_label("green:power", &dev))
> +		led_set_state(dev, LEDST_OFF);
> +}
> +
>   static void bluetooth_dt_fixup(void *blob)
>   {
>   	/* Some devices ship with a Bluetooth controller default address.
> diff --git a/configs/orangepi_3_lts_defconfig b/configs/orangepi_3_lts_defconfig
> new file mode 100644
> index 00000000..b7571134
> --- /dev/null
> +++ b/configs/orangepi_3_lts_defconfig
> @@ -0,0 +1,19 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="sun50i-h6-orangepi-3-lts"
> +CONFIG_SPL=y
> +CONFIG_MACH_SUN50I_H6=y
> +CONFIG_SUNXI_DRAM_H6_LPDDR3=y
> +CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUN8I_EMAC=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_PHY_SUN50I_USB3=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
> 

