Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F457C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 06:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5999C81CF0;
	Thu,  3 Apr 2025 08:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Uzpr7HF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15CC81DE3; Thu,  3 Apr 2025 08:59:45 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9F88043C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 08:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1743663581; x=1743922781;
 bh=15adZ9gwBoO2xAFjODohK29lQVYSJ2qSafue5FwUxDg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Uzpr7HF8+CF7BWu6+3McQxd+lzIPOYrj7qnEyZtAiRjRmtJ/44oy1c2gwZPE7vI37
 JDlyT030w++vq7CFuv6/sjXNn+FCA5KJKCppt8W7nKeGlZcFWl6ZdQbk/D0NS7gnUW
 LG0zjieC8X/G1ZNdcO2pVjRdizqoZT/B/nmqDKprQHSlruz3qRio7sOERy8zVQpR9t
 GAfq+aitdEj18FKwSYJzmk+7nQC6RxiWxBVJhIOajCBWJR+pUv5sA/qJ3jNS4j0Nog
 CeeG7PpzMgRy1sM2q/GcBA4rgMM9WqHSFI1W8jTsfapfn0lk6LJPlpvCioxKn1fohW
 EK8K6gHINY++A==
Date: Thu, 03 Apr 2025 06:59:37 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
Subject: Re: [PATCH v4 1/6] board/qualcomm: introduce phone config
Message-ID: <D8WT5EXUI8OY.2UDUBQXGBSQR3@samcday.com>
In-Reply-To: <20250331-qcom-phones-v4-1-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
 <20250331-qcom-phones-v4-1-f52e57d3b8c6@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 07af2f055dca62b3ad2101ecd8cd155e37b91b98
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

G'day Caleb,

On Mon Mar 31, 2025 at 2:23 PM CEST, Caleb Connolly wrote:
> Phones don't have keyboards! Introduce a phone-specific config fragment
> and associated environment file to make U-Boot more useful on these
> devices. This allows for navigating via the buttons and enabling
> various USB gadget modes or displaying info about U-Boot.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
> Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/qcom-phone.config | 29 +++++++++++++++++++++++++
>  board/qualcomm/qcom-phone.env    | 47 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone=
.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..913c91757c1d77b79b5997597=
917f9ac002049fb
> --- /dev/null
> +++ b/board/qualcomm/qcom-phone.config
> @@ -0,0 +1,29 @@
> +# Settings for phones
> +CONFIG_DEFAULT_ENV_FILE=3D"board/qualcomm/qcom-phone.env"
> +# Hang on panic so the error message can be read
> +CONFIG_PANIC_HANG=3Dy
> +# We use pause in various places to allow text to be read
> +# before it scrolls off the screen
> +CONFIG_CMD_PAUSE=3Dy
> +CONFIG_BOOT_RETRY=3Dy
> +CONFIG_BOOT_RETRY_TIME=3D1
> +CONFIG_BUTTON_REMAP_PHONE_KEYS=3Dy
> +CONFIG_RETRY_BOOTCMD=3Dy
> +CONFIG_FASTBOOT_BUF_ADDR=3D0x1A000000
> +CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> +CONFIG_USB_FUNCTION_ACM=3Dy
> +CONFIG_CMD_UMS_ABORT_KEYED=3Dy
> +
> +# Record all console output and let it be dumped via fastboot
> +CONFIG_CONSOLE_RECORD=3Dy
> +CONFIG_CONSOLE_RECORD_INIT_F=3Dy
> +CONFIG_CONSOLE_RECORD_OUT_SIZE=3D0x6000
> +CONFIG_FASTBOOT_CMD_OEM_CONSOLE=3Dy
> +
> +# Only MMC is supported by fastboot currently, but this is still useful.
> +CONFIG_FASTBOOT_FLASH=3Dy
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
> +CONFIG_FASTBOOT_OEM_RUN=3Dy
> +
> +# Many phones don't actually define a serial port in their DTS
> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.en=
v
> new file mode 100644
> index 0000000000000000000000000000000000000000..6750b6daaed8695faa2fbe154=
6c1582713f7d56f
> --- /dev/null
> +++ b/board/qualcomm/qcom-phone.env
> @@ -0,0 +1,47 @@
> +bootdelay=3D0
> +bootretry=3D1
> +stdin=3Dserial,button-kbd
> +stdout=3Dserial,vidconsole
> +stderr=3Dserial,vidconsole
> +
> +# Fastboot is keen to use the address from kconfig, but we
> +# allocate its buffer at runtime.
> +fastboot=3Dfastboot -l $fastboot_addr_r usb 0
> +
> +# Always probe for UFS storage, though it should be done by board code.
> +preboot=3Dscsi scan
> +
> +# Shortcut to enable USB serial gadget and disable bootretry
> +serial_gadget=3Dsetenv stdin serial,button-kbd,usbacm; \
> +=09setenv stdout serial,vidconsole,usbacm; \
> +=09setenv stderr serial,vidconsole,usbacm; \
> +=09setenv bootretry -1; \
> +=09echo Enabled U-Boot console serial gadget
> +
> +# bootretry will run this command over and over, if we fail once
> +# then bail out to the boot menu instead (with a pause to read
> +# the error message)
> +bootcmd=3Dbootefi bootmgr; pause; run menucmd
> +
> +# When entering the menu (either from button press or failed boot)
> +# remap bootcmd so it will re-open the menu and we won't get stuck
> +# at the console with no way to type
> +menucmd=3Dsetenv bootcmd run menucmd; bootmenu -1
> +
> +# Pause is used so the output can be read on the display
> +bootmenu_0=3DBoot=3Dbootefi bootmgr; pause
> +bootmenu_1=3DEnable serial console gadget=3Drun serial_gadget
> +bootmenu_2=3DEnable USB mass storage=3Decho "Press any key to exit UMS m=
ode"; ums 0 scsi 0
> +bootmenu_3=3DEnable fastboot mode=3Drun fastboot
> +# Disabling bootretry means we'll just drop the shell
> +bootmenu_4=3DDrop to shell=3Dsetenv bootretry -1
> +bootmenu_5=3DReset device=3Dreset
> +bootmenu_6=3DDump clocks=3Dclk dump; pause
> +bootmenu_7=3DDump environment=3Dprintenv; pause
> +bootmenu_8=3DBoard info=3Dbdinfo; pause
> +bootmenu_9=3DDump bootargs=3Dfdt print /chosen bootargs; pause
> +
> +# Allow holding the power button while U-Boot loads to enter

Comment should mention vol-down rather than pwrkey. I also noticed that
the cover letter still mentions the vol-down serial gadget path which is
dropped now.

Cheers,
-Sam

> +# the boot menu
> +button_cmd_0_name=3DVolume Down
> +button_cmd_0=3Drun menucmd


