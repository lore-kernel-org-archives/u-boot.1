Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DC4CEACF0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94298922E;
	Tue,  1 Oct 2024 19:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="GAGAnhFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5527589230; Tue,  1 Oct 2024 19:30:08 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7DD89216
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 19:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=julius@devpi.de
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id C2DB2240E86;
 Tue,  1 Oct 2024 19:30:05 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id 22EB5240552;
 Tue,  1 Oct 2024 19:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1727803804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLHIJMmqLint25jbNwGPLDknRQhwQch6XakAdRR60AE=;
 b=GAGAnhFCZ7hE3St4XnePK44LrAmELYUSTqVryZex7aa5bxc7c9w8JcFvoyCNh4Qucd5tP5
 /tob9s0eh5VdjAznjEkLi/7Cm54NgbUyXaiVcNdFLByakBlJ+o6vwbXKVZMQ2ZPR2X0FtO
 g2mwSqWnTVRJN1CK+XLW3YXVrXL8gJZjocWL5B55oKQ/viTKdlZV1VA+qQKKGKwIz21AmV
 se2zBE+otHH0d7E1FCeS/5k3llajIbSzsX8rIyr9Ea+oBsJzbmRILFHWHm6TkAPg67HLow
 hlp1hB9tj0Ce+1ilbWIQGaSTjIwb/NTVL+uuBzx3c6hIFOfZYH6YstvgjVLRvQ==
Received: from [IPV6:2003:cb:ef39:8710::76d]
 (p200300cbef398710000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::76d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id C872F240524;
 Tue,  1 Oct 2024 19:30:03 +0200 (CEST)
Message-ID: <f4361cd5-5eab-449e-8cf4-f8c3f85f1c0c@devpi.de>
Date: Tue, 1 Oct 2024 19:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] board/qualcomm: introduce phone config
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
 <20240831-qcom-phones-v1-1-08614edd8e35@linaro.org>
Content-Language: en-US
From: Julius Lehmann <julius@devpi.de>
In-Reply-To: <20240831-qcom-phones-v1-1-08614edd8e35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: c0111a
X-Rspamd-UID: 90beb5
X-Mailman-Approved-At: Tue, 01 Oct 2024 19:30:26 +0200
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

On 31.08.24 18:48, Caleb Connolly wrote:
> Phones don't have keyboards! Introduce a phone-specific config fragment
> and associated environment file to make U-Boot more useful on these
> devices. This allows for navigating via the buttons and enabling
> various USB gadget modes or displaying info about U-Boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   board/qualcomm/qcom-phone.config | 12 ++++++++++
>   board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
> new file mode 100644
> index 000000000000..4639e19a3df2
> --- /dev/null
> +++ b/board/qualcomm/qcom-phone.config
> @@ -0,0 +1,12 @@
> +# Settings for phones
> +CONFIG_USE_DEFAULT_ENV_FILE=y
> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
> +CONFIG_PANIC_HANG=y
> +CONFIG_CMD_PAUSE=y
> +CONFIG_BOOTSTD=y
> +CONFIG_BOOT_RETRY=y
> +CONFIG_BOOT_RETRY_TIME=1
> +CONFIG_REMAP_PHONE_KEYS=y

this should be CONFIG_BUTTON_REMAP_PHONE_KEYS (at least that version is 
used in the referenced patch)

> +
> +# Many phones don't actually define a serial port in their DTS
> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
> new file mode 100644
> index 000000000000..2a0791c888c6
> --- /dev/null
> +++ b/board/qualcomm/qcom-phone.env
> @@ -0,0 +1,49 @@
> +bootdelay=0
> +bootretry=1
> +stdin=serial,button-kbd
> +stdout=serial,vidconsole
> +stderr=serial,vidconsole
> +
> +# Fastboot is keen to use the address from kconfig, but we
> +# allocate its buffer at runtime.
> +fastboot=fastboot -l $fastboot_addr_r usb 0
> +
> +# Shortcut to enable USB serial gadget and disable bootretry
> +serial_gadget=setenv stdin serial,button-kbd,usbacm; \
> +	setenv stdout serial,vidconsole,usbacm; \
> +	setenv stderr serial,vidconsole,usbacm; \
> +	setenv bootretry -1; \
> +	echo Enabled U-Boot console serial gadget
> +
> +# bootretry will run this command over and over, if we fail once
> +# then bail out to the boot menu instead (with a pause to read
> +# the error message)
> +bootcmd=bootefi bootmgr; pause; run menucmd
> +
> +# When entering the menu (either from button press or failed boot)
> +# remap bootcmd so it will re-open the menu and we won't get stuck
> +# at the console with no way to type
> +menucmd=setenv bootcmd run menucmd; bootmenu -1
> +
> +# Pause is used so the output can be read on the display
> +bootmenu_0=Boot=bootefi bootmgr; pause
> +bootmenu_1=Enable serial console gadget=run serial_gadget
> +bootmenu_2=Enable USB mass storage=ums 0 scsi 0
> +bootmenu_3=Reset device=reset
> +bootmenu_4=Dump clocks=clk dump; pause
> +bootmenu_5=Dump environment=printenv; pause
> +bootmenu_6=Board info=bdinfo; pause
> +bootmenu_7=Dump bootargs=fdt print /chosen bootargs; pause
> +bootmenu_8=Enable fastboot mode=run fastboot
> +# Disabling bootretry means we'll just drop the shell
> +bootmenu_9=Drop to shell=setenv bootretry -1
> +
> +# Allow holding the power button while U-Boot loads to enter
> +# the boot menu
> +button_cmd_0_name=pwrkey
> +button_cmd_0=run menucmd
> +
> +# Hold volume down to drop to a shell with the USB serial gadget
> +# enabled for debugging
> +button_cmd_1_name=Volume down
> +button_cmd_1=run serial_gadget
> 

