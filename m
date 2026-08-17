Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC29C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 12:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7793A80EEF;
	Mon, 17 Aug 2026 12:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXqqo2NCtInk; Mon, 17 Aug 2026 12:35:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3653E80E8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786970110;
	bh=AawTU54rd3jOv8FeFh5fFQvv0U6gYQ0zTyWPWJflsAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HF/yrr/gTn81+vhL8a1/asdznmQvMlx2F+X6WPc5SZSDUDGpUfRP1DSsPCG2cZZvv
	 3sJVEjulsALhSmhdf3fY3rS4Xq1/VxJc0DcXAFpVsADLtQRGLA1qppZg6lM6yfknII
	 gLfxuo7YltBxIK3s/r6UvjEMgrvdypDxPK/SetKWX5Gjuo24VAMWqPey3LaiSTn57b
	 xXUUPtMa3j7asDlefjcHZWsr0h/76Uw82TJUU2HJ4plT4nSDpmGYGAWqc7o3oYS3du
	 U5YPwmUvjbQ1Lmrj87SU44gpjDMXe5fR/7Mj/5qtG6SDWygZp9N9ZDtlgct5Tlwc6S
	 jhYbilm4evbdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3653E80E8D;
	Mon, 17 Aug 2026 12:35:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 842A623F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 12:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7440280E8D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 12:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpG6_7NmPJGh for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 12:35:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7A6E280ABB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A6E280ABB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Y2SoEP7q
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A6E280ABB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 12:35:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6283E44226;
 Mon, 17 Aug 2026 12:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89C01F000E9;
 Mon, 17 Aug 2026 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786970106;
 bh=AawTU54rd3jOv8FeFh5fFQvv0U6gYQ0zTyWPWJflsAc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Y2SoEP7qyzW9kdLgW/HffRbX/I/oc6Y0hzKaiR49M/cBdoh8oB8hybNgoAfVrNSHk
 hY8dhzLHaQ5xHffk1jh1grN5fNQsRQgC6FPlHBgscTvQPX/p4z1tmqy35iZONRb0Rh
 2qyNZnV+DtPhIdrCKKdmmZ4VEET9wSIh7IA6Ka2icxEI6XxXX7KuoNY9S43D4aVksc
 9pj2P212UGzDvzDX20lFm1uyzSZ49yPQiAtzs4maHNV904as8V377Q/NUu0YmGZCw7
 kMpxDYQyNp0G8RtPT6SXlyBGQf47f5hvzPqrRWlN6TjDRKsm8oh2Wwu2EawhaeFzJ6
 xa/Qc7ChWIkHQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Carlo Caione
 <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH RFC v3 5/5] fastboot: add SPL support
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-5-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
 <20260731-ccaione-upstream-spl-fastboot-v3-5-dbea3ff4529e@baylibre.com>
Date: Mon, 17 Aug 2026 14:35:03 +0200
Message-ID: <877blphqmg.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

Thank you for the patch and sorry for the review delays.

On Fri, Jul 31, 2026 at 10:29, Carlo Caione <ccaione@baylibre.com> wrote:

> Some recovery and initial-provisioning flows run before usable firmware
> is available in persistent storage. In these flows the SoC ROM loads a
> small first stage, but that stage must still provide a standard protocol
> with which the host can provision the device.
>
> U-Boot already provides fastboot for this purpose, but its
> implementation is currently restricted to U-Boot proper and coupled
> to command-line support. This forces platforms that need provisioning
> from SPL to maintain a separate downloader or an out-of-tree fastboot
> implementation.
>
> Allow boards to run USB fastboot as a service directly from SPL. Include
> MMC partition flashing and Android sparse-image handling so that the SPL
> service can provision the same storage images accepted by fastboot in
> U-Boot proper.
>
> Keep the SPL interface deliberately narrower. The fastboot boot command
> is not supported because SPL is being used for provisioning rather than
> OS boot orchestration. Filesystem probing is also omitted, so partition
> types are reported as raw. Reboot support remains optional since reset
> and persistent reboot-reason handling are platform-specific.
>
> SPL size remains an important constraint. Make the support entirely
> opt-in and phase-specific: when CONFIG_SPL_FASTBOOT is disabled, no
> fastboot code or supporting library is added to SPL and its binary size
> is unchanged.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  doc/android/fastboot.rst        | 27 ++++++++++++-
>  drivers/fastboot/Kconfig        | 89 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/fastboot/Makefile       |  4 ++
>  drivers/fastboot/fb_command.c   | 27 +++++++++++--
>  drivers/fastboot/fb_common.c    | 21 ++++++++++
>  drivers/fastboot/fb_getvar.c    |  5 +++
>  drivers/fastboot/fb_usb.c       |  3 ++
>  drivers/usb/gadget/Makefile     |  1 +
>  drivers/usb/gadget/f_fastboot.c |  4 ++
>  9 files changed, 175 insertions(+), 6 deletions(-)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 96c544ae11b..885767e450f 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -10,7 +10,7 @@ The protocol that is used over USB and UDP is described in [1]_.
>  
>  The current implementation supports the following standard commands:
>  
> -- ``boot``
> +- ``boot`` (not available in SPL)
>  - ``continue``
>  - ``download``
>  - ``erase`` (if enabled)

I think there might be other commands that are not available in SPL,
right?

What about oem run, oem console for example?

> @@ -72,6 +72,31 @@ platform. The location of the buffer and size are set with
>  may be overridden on the fastboot command line using ``-l`` and
>  ``-s``.
>  
> +Fastboot in SPL
> +^^^^^^^^^^^^^^^
> +
> +Fastboot can be used from SPL without enabling the command line. Enable
> +``CONFIG_SPL_FASTBOOT`` together with the platform's SPL USB gadget support,
> +then start the session from board code::
> +
> +   ret = fastboot_usb_run(controller_index, NULL, 0);
> +
> +A ``NULL`` buffer and zero size select ``CONFIG_FASTBOOT_BUF_ADDR`` and
> +``CONFIG_FASTBOOT_BUF_SIZE``. Passing explicit values overrides these
> +defaults. The ``continue`` command ends the session and returns control to the
> +caller. Unlike the command-line invocation, an SPL session cannot be aborted
> +from the local console.
> +
> +MMC flash and erase support is enabled with
> +``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
> +storage layout must also be enabled, for example ``CONFIG_SPL_EFI_PARTITION``
> +for GPT.
> +
> +The ``boot`` command is not available in SPL. Reboot commands require
> +``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform ``reset_cpu()`` implementation.
> +The ``reboot-bootloader``, ``reboot-fastboot`` and ``reboot-recovery`` commands

[...]

> +
> +config SPL_FASTBOOT_GPT_NAME
> +	string "Target name for updating GPT from SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC && SPL_EFI_PARTITION
> +	default "gpt"
> +
> +config SPL_FASTBOOT_MBR_NAME
> +	string "Target name for updating MBR from SPL"
> +	depends on SPL_FASTBOOT_FLASH_MMC && SPL_DOS_PARTITION
> +	default "mbr"
> +
>  endmenu
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index 12008ac05e2..43e391d8ec4 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -3,7 +3,11 @@
>  obj-y += fb_common.o
>  obj-y += fb_getvar.o
>  obj-y += fb_command.o
> +ifndef CONFIG_XPL_BUILD

Can we drop the negation and invert the logic please?
It's easier to read the other way around.

>  obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
> +else
> +obj-$(CONFIG_SPL_FASTBOOT) += fb_usb.o
> +endif
>  obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_BLOCK) += fb_block.o
>  # MMC reuses block implementation
>  obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 111516fd1b3..4a3cc4cbb27 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -37,9 +37,9 @@ static void getvar(char *, char *);
>  static void download(char *, char *);
>  static void flash(char *, char *);
>  static void erase(char *, char *);
> -static void reboot_bootloader(char *, char *);
> -static void reboot_fastbootd(char *, char *);
> -static void reboot_recovery(char *, char *);
> +static void __maybe_unused reboot_bootloader(char *, char *);
> +static void __maybe_unused reboot_fastbootd(char *, char *);
> +static void __maybe_unused reboot_recovery(char *, char *);

Please follow the file conventions and move the __maybe_unused to
the function definition instead.

See, for example:
static void __maybe_unused oem_format(char *cmd_parameter, char *response)


>  static void oem_format(char *, char *);
>  static void oem_partconf(char *, char *);
>  static void oem_bootbus(char *, char *);
> @@ -70,7 +70,9 @@ static const struct {
>  	},
>  	[FASTBOOT_COMMAND_BOOT] =  {
>  		.command = "boot",
> +#ifndef CONFIG_XPL_BUILD
>  		.dispatch = okay
> +#endif

I'm not super fan of the ifdeffery here and below.

Can we consider creating an alternative SPL specific command array?
This might add some code duplication but will it make easier to
identify which commands are supported in SPL and which are in proper.

Or alternatively, have a .dispatch and a .dispatch_xpl ?

>  	},
>  	[FASTBOOT_COMMAND_CONTINUE] =  {
>  		.command = "continue",
> @@ -78,19 +80,38 @@ static const struct {
>  	},
>  	[FASTBOOT_COMMAND_REBOOT] =  {
>  		.command = "reboot",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
> +#else
>  		.dispatch = okay
> +#endif
>  	},
>  	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
>  		.command = "reboot-bootloader",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_bootloader), (NULL))
> +#else
>  		.dispatch = reboot_bootloader
> +#endif
>  	},
>  	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
>  		.command = "reboot-fastboot",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_fastbootd), (NULL))
> +#else
>  		.dispatch = reboot_fastbootd
> +#endif
>  	},
>  	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
>  		.command = "reboot-recovery",
> +#ifdef CONFIG_XPL_BUILD
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
> +					     (reboot_recovery), (NULL))
> +#else
>  		.dispatch = reboot_recovery
> +#endif
>  	},
>  	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
>  		.command = "set_active",
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 3c0013490cc..bd8ba8824de 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -12,6 +12,7 @@
>  
>  #include <bcb.h>
>  #include <command.h>
> +#include <cpu_func.h>
>  #include <env.h>
>  #include <fastboot.h>
>  #include <net.h>
> @@ -89,6 +90,14 @@ void fastboot_okay(const char *reason, char *response)
>   * which sets whatever flag your board specific Android bootloader flow
>   * requires in order to re-enter the bootloader.
>   */
> +#ifdef CONFIG_XPL_BUILD
> +int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
> +{
> +	(void)reason;

Is the void cast needed? Can't we use __maybe_unused in the function
prototype?

Also, why do we need it alltogether? It looks like most stub functions
I've found don't do this.

> +
> +	return -EOPNOTSUPP;
> +}
> +#else
>  int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>  {
>  	int ret;
> @@ -127,6 +136,7 @@ out:
>  	bcb_reset();
>  	return ret;
>  }
> +#endif
>  
>  /**
>   * fastboot_get_progress_callback() - Return progress callback
> @@ -138,6 +148,7 @@ void (*fastboot_get_progress_callback(void))(const char *)
>  	return fastboot_progress_callback;
>  }
>  
> +#ifndef CONFIG_XPL_BUILD
>  /**
>   * fastboot_boot() - Execute fastboot boot command
>   *
> @@ -175,6 +186,7 @@ void fastboot_boot(void)
>  		do_reset(NULL, 0, 0, NULL);
>  	}
>  }
> +#endif /* !CONFIG_XPL_BUILD */

Some #endif have this extra comment. Some others don't.
Can we please be consistent about this?

>  
>  /**
>   * fastboot_handle_boot() - Shared implementation of system reaction to
> @@ -189,12 +201,14 @@ void fastboot_handle_boot(int command, bool success)
>  		return;
>  
>  	switch (command) {
> +#ifndef CONFIG_XPL_BUILD
>  	case FASTBOOT_COMMAND_BOOT:
>  		fastboot_boot();
>  #if CONFIG_IS_ENABLED(NET_LEGACY)
>  		net_set_state(NETLOOP_SUCCESS);
>  #endif
>  		break;
> +#endif
>  
>  	case FASTBOOT_COMMAND_CONTINUE:
>  #if CONFIG_IS_ENABLED(NET_LEGACY)
> @@ -206,7 +220,14 @@ void fastboot_handle_boot(int command, bool success)
>  	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
>  	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
>  	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
> +#ifdef CONFIG_XPL_BUILD
> +#if CONFIG_IS_ENABLED(FASTBOOT_REBOOT)
> +		/* SPL may omit CMDLINE, so use the platform reset hook directly. */
> +		reset_cpu();
> +#endif

[...]

>
> -- 
> 2.55.0
