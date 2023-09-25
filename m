Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA6CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F26B86BE7;
	Mon, 25 Sep 2023 14:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="0lqbHccm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TQ55iuor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB85386C06; Mon, 25 Sep 2023 14:10:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD9886BE7
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 14:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=msuchanek@suse.de
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 945851F459;
 Mon, 25 Sep 2023 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695643841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9oWAPkhFkiQkYgSTqg3XL4q3EVJcdwxMKXpdFEkdcVk=;
 b=0lqbHccmeRmOgMAcIKvk2I5rJVYI33QGEPTOEt0yk09eOZePA8s7aLmp91FqumXHg12D0e
 g6p6DMkUyuFt2pCzI5+CfgPi2Y5ZUDlF4QHhNFaKhYMSHUjLMzQFhh2etIhE6ZFCP8QLkn
 Ug4aVMh/9bmwSdzeMDWdl5jhBzhwMAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695643841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9oWAPkhFkiQkYgSTqg3XL4q3EVJcdwxMKXpdFEkdcVk=;
 b=TQ55iuorktdmKs8sKFAMnvgkHnB3QXd+vpWdy/tVt8LHCENaMLPWvuW2CjZjEtl8naL69b
 HdHYlnDQ0d013tBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5B5902C145;
 Mon, 25 Sep 2023 12:10:41 +0000 (UTC)
Date: Mon, 25 Sep 2023 14:10:40 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
Message-ID: <20230925121040.GC6241@kitsune.suse.cz>
References: <20230925110101.376878-1-rasmus.villemoes@prevas.dk>
 <20230925110101.376878-3-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925110101.376878-3-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Hello,

On Mon, Sep 25, 2023 at 01:01:01PM +0200, Rasmus Villemoes wrote:
> When debugging, one sometimes only gets partial output lines or
> nothing at all from the last printf, because the uart has a largish
> buffer, and the code after the printf() may cause the CPU to hang
> before the uart IP has time to actually emit all the characters. That
> can be very confusing, because one doesn't then know exactly where the
> hang happens.
> 
> Introduce a config knob allowing one to wait for the uart fifo to
> drain whenever a newline character is printed, roughly corresponding
> to the effect of setvbuf(..., _IOLBF, ...) in ordinary C programs.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  common/Kconfig                 | 11 +++++++++++
>  drivers/serial/serial-uclass.c |  8 ++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index cdb77a6a7d..49130f2a2b 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -224,6 +224,17 @@ config CONSOLE_FLUSH_SUPPORT
>  	help
>  	  This enables compilation of flush() function for console flush support.
>  
> +config CONSOLE_FLUSH_ON_NEWLINE
> +	bool "Flush console buffer on every newline character"
> +	depends on CONSOLE_FLUSH_SUPPORT

Maybe selects would be more appropriate here if it can be arbitrarily
enabled on any console

> +	depends on DM_SERIAL
> +	help
> +	  This makes the serial core code flush the console device
> +	  whenever a newline (\n) character has been emitted. This can
> +	  be especially useful when "printf debugging", as otherwise
> +	  lots of output could still be in the UART's FIFO by the time
> +	  one hits the code which causes the CPU to hang or reset.
> +
>  config CONSOLE_MUX
>  	bool "Enable console multiplexing"
>  	default y if VIDEO || LCD
> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
> index 2f75ff878c..b41e3ebe7f 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -181,7 +181,6 @@ int serial_initialize(void)
>  	return serial_init();
>  }
>  
> -#ifdef CONFIG_CONSOLE_FLUSH_SUPPORT

This should not be removed. CONSOLE_FLUSH_ON_NEWLINE will only ever be
configured when CONFIG_CONSOLE_FLUSH_SUPPORT is also enabled so there is
no need to remove, either.

Thanks

Michal

>  static void _serial_flush(struct udevice *dev)
>  {
>  	struct dm_serial_ops *ops = serial_get_ops(dev);
> @@ -191,7 +190,6 @@ static void _serial_flush(struct udevice *dev)
>  	while (ops->pending(dev, false) > 0)
>  		;
>  }
> -#endif
>  
>  static void _serial_putc(struct udevice *dev, char ch)
>  {
> @@ -204,6 +202,9 @@ static void _serial_putc(struct udevice *dev, char ch)
>  	do {
>  		err = ops->putc(dev, ch);
>  	} while (err == -EAGAIN);
> +
> +	if (IS_ENABLED(CONSOLE_FLUSH_ON_NEWLINE) && ch == '\n')
> +		_serial_flush(dev);
>  }
>  
>  static int __serial_puts(struct udevice *dev, const char *str, size_t len)
> @@ -242,6 +243,9 @@ static void _serial_puts(struct udevice *dev, const char *str)
>  		if (*newline && __serial_puts(dev, "\r\n", 2))
>  			return;
>  
> +		if (IS_ENABLED(CONSOLE_FLUSH_ON_NEWLINE) && *newline)
> +			_serial_flush(dev);
> +
>  		str += len + !!*newline;
>  	} while (*str);
>  }
> -- 
> 2.37.2
> 
