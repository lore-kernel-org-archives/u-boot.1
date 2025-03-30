Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92A9C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 08:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C60480F9C;
	Sun, 30 Mar 2025 10:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="PrM3FFAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84C38129B; Sun, 30 Mar 2025 10:23:23 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9F780BA8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 10:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1743323000; x=1743582200;
 bh=ca/I5dBc6U87BM8wUer9PbkViy0+tEL4VFf5yb6XGFU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=PrM3FFAa7IWMavlqatQ7gKvrhyraltGhSHE7aP1GMZNodo8Fo+wQJpgvSR9Hos7R+
 9AxUa0SUJUJrFC6ZH5icYkEombZGlGsk/BwTig6P1fWfRdNBsgLkMEuXuxdQF8Lt/4
 U407s/W3vfJokQt3DaPM/3iSTROTdHDkC/ihvJUZIWta1/A2L/ZQ3hJpb3c+7W9Ab6
 F6sIZbrFmh9gm6GitKu2eKKap/i3Glm7wOGmQ9nJrjoaW8W68BBFeoXVkWQHXPG+ME
 2fya75d2C+C+Bf3fGWivPJnTZWDS8S7uLBU+DCGJ88pW69PDMGaQMDuWifKq9okBBS
 1TgWTIoMGiB/g==
Date: Sun, 30 Mar 2025 08:23:14 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/4] board/qualcomm: introduce phone config
Message-ID: <D8TGF97ZRSMG.2NFLDZX72HZ9E@samcday.com>
In-Reply-To: <20250311-qcom-phones-v2-1-83dcd88a6a87@linaro.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
 <20250311-qcom-phones-v2-1-83dcd88a6a87@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 9187e8e348298ec7a23fb7b893e823817b4af9db
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

'Ello Caleb,

On Tue Mar 11, 2025 at 1:31 PM CET, Caleb Connolly wrote:
> Phones don't have keyboards! Introduce a phone-specific config fragment
> and associated environment file to make U-Boot more useful on these
> devices. This allows for navigating via the buttons and enabling
> various USB gadget modes or displaying info about U-Boot.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/qcom-phone.config | 17 ++++++++++++++
>  board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone=
.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..a2aa882285b61746a243a7a1c=
7c384f33839f1b2
> --- /dev/null
> +++ b/board/qualcomm/qcom-phone.config
> @@ -0,0 +1,17 @@
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

Maybe also include CONFIG_CMD_UMS_ABORT_KEYED=3Dy here? Then folks can
bail out of UMS mode without needing to hard reboot their device.

> +CONFIG_RETRY_BOOTCMD=3Dy
> +CONFIG_FASTBOOT_BUF_ADDR=3D0x1A000000
> +CONFIG_USB_FUNCTION_FASTBOOT=3Dy

I would propose to also add:

CONFIG_CONSOLE_RECORD=3Dy
CONFIG_CONSOLE_RECORD_INIT_F=3Dy
CONFIG_CONSOLE_RECORD_OUT_SIZE=3D0x6000
CONFIG_FASTBOOT_CMD_OEM_CONSOLE=3Dy

This allows folks to pull down the U-Boot logs with `fastboot oem log`

CONFIG_FASTBOOT_FLASH=3Dy
CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0

Allowing to flash to partitions via fastboot (not sure about if/how UFS
support works here though, I've only tested it on msm8916 with eMMC)

CONFIG_FASTBOOT_OEM_RUN=3Dy

Allowing to run arbitrary commands (e.g `fastboot oem run:'bdinfo')

> +CONFIG_USB_FUNCTION_ACM=3Dy
> +
> +# Many phones don't actually define a serial port in their DTS
> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.en=
v
> new file mode 100644
> index 0000000000000000000000000000000000000000..2a0791c888c62b9f225744835=
8dd196a02e4b6fb
> --- /dev/null
> +++ b/board/qualcomm/qcom-phone.env
> @@ -0,0 +1,49 @@
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
> +bootmenu_2=3DEnable USB mass storage=3Dums 0 scsi 0

This doesn't work on my fajita unless I run `scsi scan` first. I note
that this used to be in the preboot=3D section of default.env, maybe we
should bring that across?

Also, if you choose to include CONFIG_CMD_UMS_ABORT_KEYED=3Dy per my
earlier suggestion, it would be worth adding an "echo press any key to
exit UMS mode" here or smth, I guess?

> +bootmenu_3=3DReset device=3Dreset
> +bootmenu_4=3DDump clocks=3Dclk dump; pause
> +bootmenu_5=3DDump environment=3Dprintenv; pause
> +bootmenu_6=3DBoard info=3Dbdinfo; pause
> +bootmenu_7=3DDump bootargs=3Dfdt print /chosen bootargs; pause

I think options 4-7 should be at the bottom of the list since they're
less typical/useful than jumping into usbacm/fastboot/ums modes. Reset
device should be at the bottom of the list.

I'd maybe also go as far as suggesting that these could be removed
entirely? Once you're in serial mode (or fastboot mode with
CONFIG_FASTBOOT_OEM_RUN enabled) you can run these commands easily.

> +bootmenu_8=3DEnable fastboot mode=3Drun fastboot
> +# Disabling bootretry means we'll just drop the shell
> +bootmenu_9=3DDrop to shell=3Dsetenv bootretry -1
> +
> +# Allow holding the power button while U-Boot loads to enter
> +# the boot menu
> +button_cmd_0_name=3Dpwrkey

Two issues with using pwrkey as the boot menu trigger:

 * Many devices display a "custom OS" warning screen which can be paused
   with the power button, which this will conflict with.
 * When I trigger the boot menu this way, releasing pwrkey when the boot
   menu shows up causes the first boot option to be selected. I note
   this doesn't happen in your qcomlt branch so I'm guessing you did
   something extra there to prevent this undesired behaviour?

> +button_cmd_0=3Drun menucmd
> +
> +# Hold volume down to drop to a shell with the USB serial gadget
> +# enabled for debugging
> +button_cmd_1_name=3DVolume down
> +button_cmd_1=3Drun serial_gadget

I would propose to simplify this and just have one button_cmd that is
used to pop the menu, since the serial gadget option is available there
anyway.

-Sam


