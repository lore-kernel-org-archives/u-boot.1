Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23008C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 12:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7AC82952;
	Sat, 10 May 2025 14:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="TrZus91O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 250F58295C; Sat, 10 May 2025 14:00:11 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDB28283E
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 14:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 9246b8eb-2d96-11f0-b8e9-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 9246b8eb-2d96-11f0-b8e9-005056999439;
 Sat, 10 May 2025 14:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=fsVMe1LZLZ2hU/4xTeYLgu0U1vFZ9fDEPvmOF2A44SQ=;
 b=TrZus91OhaDq9HIRwFQN9IQ//zAAbxKe36xJKIgiFI1dHHJDNgT5wyw2p8yLke3eqQsfdvODwiyRx
 3FmXAGnbsiHyt6LgQYhI+wS0kCAI5gOVHVK2bveyWSOsQ44yBMGEwzoWmpO7VEbQrtoMeWGcU1mLWY
 46dtdqa6RnLtAoOwVExCJU8N1fvKNWxUhKF2PjdwglA2dtyhao8GciUzXMqpPZCi8fdqUqTWxVeeX5
 DyqXVcsrs0u/NlC+wgF//HmPyuSQgfiu6u9cWfrQkFkolMZrl+Spo5nJBl4sRu1JZTboeWQ7Tlk7N1
 7J2VuzFZob0MGaPhH6kp/OxIYCpvTrg==
X-KPN-MID: 33|yTx013Eq7QWbCGNS4iWyxJxca4/s4WGBLsBjZTBxjWNoHbBXAwBv7TAx5nqa8uq
 YNE8n7oeZWuiY9jAqrKOWzXOfPzE/wvIpH6nd+dU/CY8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|QTG8jsnwRMxuQtEUMFg4wjW4Cl2OHI7ntDoRoZLHa3KvVmaV013g/1Vw/DegHF2
 05/gxTN4L+o+z7fb2JW0wdg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 50e51e87-2d96-11f0-9a00-00505699772e;
 Sat, 10 May 2025 14:00:08 +0200 (CEST)
Date: Sat, 10 May 2025 14:00:07 +0200
Message-Id: <87cycg8ym0.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@linaro.org, trini@konsulko.com, vincent.stehle@arm.com
In-Reply-To: <20250510113627.1476467-1-sjg@chromium.org> (message from Simon
 Glass on Sat, 10 May 2025 13:36:24 +0200)
Subject: Re: [PATCH] efi_loader: Disable ANSI output for tests
References: <20250510113627.1476467-1-sjg@chromium.org>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Sat, 10 May 2025 13:36:24 +0200

Hi Simon,

> We don't want ANSI characters written in tests since it is a pain to
> check the output with ut_assert_nextline() et al.

You probably shouldn't use the term "ANSI characters" here when you
really mean "ANSI escape sequences".
 
> Provide a way to tests to request that ANSI characters not be sent.
> 
> Add a proper function comment while we are here, to encourage others.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  include/efi_loader.h         | 21 ++++++++++++++++++++-
>  lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 25a809c3d53..b699479f346 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -532,8 +532,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
>  efi_status_t efi_bootmgr_run(void *fdt);
>  /* search the boot option index in BootOrder */
>  bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
> -/* Set up console modes */
> +
> +/**
> + * efi_setup_console_size() - update the mode table.
> + *
> + * By default the only mode available is 80x25. If the console has at least 50
> + * lines, enable mode 80x50. If we can query the console size and it is neither
> + * 80x25 nor 80x50, set it as an additional mode.
> + */
>  void efi_setup_console_size(void);
> +
> +/**
> + * efi_console_set_ansi() - Set whether ANSI characters should be emitted
> + *
> + * These characters mess up tests which use ut_assert_nextline(). Call this
> + * function to tell efi_loader not to emit these characters when starting up the
> + * terminal
> + *
> + * @allow_ansi: Allow emitting ANSI characters
> + */
> +void efi_console_set_ansi(bool allow_ansi);
> +
>  /* Set up load options from environment variable */
>  efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
>  				      u16 **load_options);
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 9d9f786a6db..28687d678c3 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -30,6 +30,17 @@ struct cout_mode {
>  
>  __maybe_unused static struct efi_object uart_obj;
>  
> +/*
> + * suppress emission of ANSI codes for use by unit tests. Leave it as 0 for the
> + * default behaviour
> + */
> +static bool no_ansi;
> +
> +void efi_console_set_ansi(bool allow_ansi)
> +{
> +	no_ansi = !allow_ansi;
> +}
> +
>  static struct cout_mode efi_cout_modes[] = {
>  	/* EFI Mode 0 is 80x25 and always present */
>  	{
> @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
>  	return 0;
>  }
>  
> -/**
> - * efi_setup_console_size() - update the mode table.
> - *
> - * By default the only mode available is 80x25. If the console has at least 50
> - * lines, enable mode 80x50. If we can query the console size and it is neither
> - * 80x25 nor 80x50, set it as an additional mode.
> - */
>  void efi_setup_console_size(void)
>  {
>  	int rows = 25, cols = 80;
> @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
>  
>  	if (IS_ENABLED(CONFIG_VIDEO))
>  		ret = query_vidconsole(&rows, &cols);
> -	if (ret)
> -		ret = query_console_serial(&rows, &cols);
> +	if (ret) {
> +		if (no_ansi)
> +			ret = 0;
> +		else
> +			ret = query_console_serial(&rows, &cols);
> +	}
>  	if (ret)
>  		return;
>  
> -- 
> 2.43.0
> 
> base-commit: c5a631df96de7421d10ee03dceed1b79db213026
> branch: ansi
> 
