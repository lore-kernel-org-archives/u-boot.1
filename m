Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B840E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 16:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD4689616;
	Fri,  6 Dec 2024 17:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="cFGHzGqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9168689622; Fri,  6 Dec 2024 17:50:32 +0100 (CET)
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEF58932B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 17:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id A8376240ECB;
 Fri,  6 Dec 2024 17:50:29 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id C7C87240031;
 Fri,  6 Dec 2024 17:50:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1733503827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBmZtYBvO9E8LAntFqNuVA0BA0SNslgWwAA88wycrPA=;
 b=cFGHzGqkmQRt3HeClIZpgqGVwSxaSsoL4XCIl4WlJ8loMIjgIMfT/npNIMGQVAtBc9Om1l
 YUYIaHXnlhIeah6YZb9e85un2Gop+WelFqiouZuDaMMjXF5t6Gn8u9gNDYia1kQAd4ronD
 wIOWpApMIxdttDJGvfaEzTGTbbwueTO2KBopVPd69UxNe71ORnq7vADj0f8BqSHliaUbo/
 awpiZqqd5X5zadP67k8hPIjlJ0otUO2HBpc7Pi9cxgElcnSq0Yz9njpr3j0aIRqKL9iL3W
 Inf+JbAqr9YaYffD9Q1hcug6mHhpEMqdsdwMh0GpKoY3tGSPglqcSpFerU69lg==
Received: from [IPV6:2003:cb:ef05:3810::76d]
 (p200300cbef053810000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef05:3810::76d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id 775C024001B;
 Fri,  6 Dec 2024 17:50:27 +0100 (CET)
Message-ID: <d8546140-414d-4dff-ae8b-9ecc9452c17c@devpi.de>
Date: Fri, 6 Dec 2024 17:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] board/qualcomm: introduce phone config
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
 <20241004-qcom-phones-v2-1-c7ab67ac3043@linaro.org>
Content-Language: en-US
From: Julius Lehmann <lehmanju@devpi.de>
In-Reply-To: <20241004-qcom-phones-v2-1-c7ab67ac3043@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 03c518
X-Rspamd-UID: 81e0ab
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

On 04.10.24 14:46, Caleb Connolly wrote:
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
> index 000000000000..388d4c3e7398
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
> +CONFIG_BUTTON_REMAP_PHONE_KEYS=y

should also include fastboot, serial gadget and 
CONFIG_CMD_USB_MASS_STORAGE. otherwise some menu options wouldn't work.

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
this doesn't work. according to doc 
(https://docs.u-boot.org/en/latest/usage/environment.html), multiline 
variables don't need "\".

but even without "\" it only executes the first line.

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

maybe at an entry for ufetch? ;)

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

