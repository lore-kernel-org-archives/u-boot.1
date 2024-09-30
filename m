Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF19CEB2CD
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 23:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CBA88FD6;
	Tue,  1 Oct 2024 01:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gIzjS4go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D3888E00; Tue,  1 Oct 2024 01:39:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4927D89080
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 01:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727739536; x=1728344336; i=xypron.glpk@gmx.de;
 bh=V30PlMoUeGI9IVLAapzYnwGufUZfViJHV6ZEjvrX52k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gIzjS4goXxLucNCHvb9GVw2o8AB/DmKIFL7STEleu2YZNL4C6maYjqcFt9J5oaC9
 ndpLk5YLM8zjedRZy57ExSwQlEneaXBreEsQtiwiP23vKpeqfugOYUo3+cHUrTSCB
 5VMBwYDxPcZiFTk/b7s+05B+yOnMM5iUG8LNtlJco1lt4o2K3I28W/BEWCjiVgYQ/
 M3tdTwMXmE86D07CLGCUngdYcBCJ+t5vTlguZDQUz0BpqFPqwEX1blwVynnu9oIJ4
 x7dNXs7DKHO/m5jJpH+QDBzFIhIKntICg9bA0tEEZc1sH04/LWBTNBpYTmxHWfCA+
 /0wqzRSNqbne6Fmujg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4zAs-1rx5bI1h5A-015jRM; Tue, 01
 Oct 2024 01:38:56 +0200
Message-ID: <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
Date: Tue, 1 Oct 2024 01:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240926215950.1265143-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7IBbQ+GEqsgjnpk9BeydElwvVLU+fy+37tvQ3x/SPpLfZriYphI
 uTguAoBaSg7kp5BkU58wyXeB5Ifpqwi7J39YIJpAqwOfsfeyeAwWWC6K262cWaO33ysqQyQ
 uZGUoIJklmQ1JBcWNpO4I3MlFvrqhzPwtAdnLN0BPgL9BDFvuZTf43gs+lV4TiMUi5CXAvR
 /ESH7F4ogL4Ck+Ow1YM/w==
UI-OutboundReport: notjunk:1;M01:P0:j9RwAqhRYI4=;xO4NZ4Ofvfi+gv1sqLW5buuMycj
 veik+Mx2nPc+Xeqn5RuaAptLTHQVGroarUM8tQhgTPXeMLn5W12rXwn2pHN0Ye0tKYR3plekV
 oujhu9F1a53geXOKgDyzmVabsEeT6icJ2fQdAWDWRMBS3ze0ZnX3a/b1wiAifWljw0pNcCtxh
 /lWRCGcGNFEN+KoPY3YTBSTAd8lAshFgbF2Nros9/iq6HSp7/n2jLtw4ezWIHAcfinKRqfpcs
 GgKgF/9c+066V4/9jrphZ5Oxdru4qVYkobd5eg9P/MRj+bqfJ3LWctAIWazjBvoRRr8EJB5AC
 cXy0bVlyNbBSYBOg5aDo+BsFTirfdouP6e/9QisgkWveesZTB2/XjGHistcWOUKRF45YCML9P
 j3+kIh7H+l7nHYvPdO4Cj2RM/PsSZ3gHPIL4oUKdGK8ZEUSQLuIkkmarbOHZvdsOtDiI2zUMa
 epv0kvhiT129kMepaXtarDnRtD+hfH6dMutB9LNYX/VchTrz7zTH3deAB5lEaNmbGutin2rku
 01ZYhMHgn3agA0KDQ7AOxJEu5B6ICCTiXOHpcn6ohS5mdI/bds4WtvtqhxhayoqV+Mkcfg72a
 A3+4S/cvdw8ve9GQk1LLaudIPL4b62Md7QI2pAQrDYu70RTWQ/S4aFtfY5jN6Xm83ALq4Ac3H
 962bx7vZZThlMj9kEPlWCDuzCzQ2kXDnkwmATIBDiBZOu5IWPvmwj7b3xw3NWWW07UBdHGYi3
 JPeEaTy9KHmseOj3/2uSpu9lztXQxxlGG56dW2gCnCEseEIwLcBU92v91KePKNY9FY9t8PPxK
 els84pusLJwM2HQG6Do2j7gw==
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

On 26.09.24 23:59, Simon Glass wrote:
> We don't want ANSI characters written in tests since it is a pain to
> check the output with ut_assert_nextline() et al.
>
> Provide a way to tests to request that ANSI characters not be sent.
>
> Add a proper function comment while we are here, to encourage others.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Please, consider prior review before resubmitting patches.

As responded to all prior submissions:

We want to test the code running on actual machines.
We don't want to have sandbox code everywhere.

I cannot see any test that is not passing due to the current behavior.

The size serial console is just requested once in the live-time of the
U-Boot session.

You have bunches of options in your upcoming tests. Neither of these
requires the suggested patch:

* You can set stdout=3Dvidconsole,serial and let the vidconsole provide a
screen size.
* You can add the ANSI sequence to your ut_assert_nextline() statement.
* You can filter out ANSI codes in the test framework.
* You can run an EFI command like 'printenv -e' before the command that
you actually want to test.

Best regards

Heinrich

> ---
>
> (no changes since v1)
>
>   include/efi_loader.h         | 21 ++++++++++++++++++++-
>   lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
>   2 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f84852e384f..82b90ee0f1d 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boo=
t_index);
>   efi_status_t efi_bootmgr_run(void *fdt);
>   /* search the boot option index in BootOrder */
>   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target,=
 u32 *index);
> -/* Set up console modes */
> +
> +/**
> + * efi_setup_console_size() - update the mode table.
> + *
> + * By default the only mode available is 80x25. If the console has at l=
east 50
> + * lines, enable mode 80x50. If we can query the console size and it is=
 neither
> + * 80x25 nor 80x50, set it as an additional mode.
> + */
>   void efi_setup_console_size(void);
> +
> +/**
> + * efi_console_set_ansi() - Set whether ANSI characters should be emitt=
ed
> + *
> + * These characters mess up tests which use ut_assert_nextline(). Call =
this
> + * function to tell efi_loader not to emit these characters when starti=
ng up the
> + * terminal
> + *
> + * @allow_ansi: Allow emitting ANSI characters
> + */
> +void efi_console_set_ansi(bool allow_ansi);
> +
>   /* Set up load options from environment variable */
>   efi_status_t efi_env_set_load_options(efi_handle_t handle, const char =
*env_var,
>   				      u16 **load_options);
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index cea50c748aa..569fc9199bc 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -30,6 +30,17 @@ struct cout_mode {
>
>   __maybe_unused static struct efi_object uart_obj;
>
> +/*
> + * suppress emission of ANSI codes for use by unit tests. Leave it as 0=
 for the
> + * default behaviour
> + */
> +static bool no_ansi;
> +
> +void efi_console_set_ansi(bool allow_ansi)
> +{
> +	no_ansi =3D !allow_ansi;
> +}
> +
>   static struct cout_mode efi_cout_modes[] =3D {
>   	/* EFI Mode 0 is 80x25 and always present */
>   	{
> @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *row=
s, int *cols)
>   	return 0;
>   }
>
> -/**
> - * efi_setup_console_size() - update the mode table.
> - *
> - * By default the only mode available is 80x25. If the console has at l=
east 50
> - * lines, enable mode 80x50. If we can query the console size and it is=
 neither
> - * 80x25 nor 80x50, set it as an additional mode.
> - */
>   void efi_setup_console_size(void)
>   {
>   	int rows =3D 25, cols =3D 80;
> @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
>
>   	if (IS_ENABLED(CONFIG_VIDEO))
>   		ret =3D query_vidconsole(&rows, &cols);
> -	if (ret)
> -		ret =3D query_console_serial(&rows, &cols);
> +	if (ret) {
> +		if (no_ansi)
> +			ret =3D 0;
> +		else
> +			ret =3D query_console_serial(&rows, &cols);
> +	}
>   	if (ret)
>   		return;
>

