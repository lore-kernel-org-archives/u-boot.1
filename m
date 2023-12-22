Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780BDC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E00F3877DE;
	Fri, 22 Dec 2023 22:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W+YOL59W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A3087824; Fri, 22 Dec 2023 22:10:45 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E4F877CE
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d2764c0f2so26583855e9.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279443; x=1703884243;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRIUNlQel0sC+RSVQ1KwofwL8na+eFbUITDofeUcUzs=;
 b=W+YOL59WjNSNiMfdZUuqjCsVfqEyjJMAKvuUGBmrS+2/8Rpt7ccvbBr00Ioa8Uwgxk
 YobBt9SqNSGezArhcn7N3VWlwpI0/pJsQulc8DOZ7wnuFKDoNt/AUhFvuCZn+9uiuuSF
 sgAFEFfCExbyJqGS5JIPPUjfgtj0VFHLwnoww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279443; x=1703884243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRIUNlQel0sC+RSVQ1KwofwL8na+eFbUITDofeUcUzs=;
 b=m75gzZ56/Df/knktnU81tVxD/ToliA3ioKrZpsycS9PIwcT2Y2D+BgH2c5dPEpU4L+
 ciu6vzju8hGg53ch0kRMNenem8tjkIRVhfGzzLqFRCXXTImTiCXuLCVcbDEgg03s3tRp
 b+7mNRFcW5AgQ08vHSgKLWeqg6nsGmMGTgM/7z8wfrj4jjDWfkya6C2BydzFGGpqCS4A
 85mknyzDoWP+Aiwhy+a0x3Ybhj6T/LQc37oeHWnZkKjGdSnEafs4/Ji302tDGWZTOIwO
 kf76VOkdvlPvainuOT9xZveOlvDlLtvQVvHMfQv5HlT7EFJVmpnOoT5qwZv9w2hABw7T
 CYjg==
X-Gm-Message-State: AOJu0YwQkTZPVLXiNv/mOIevBEiaAubYWgJelIEAtQHISX41RrcmmYpp
 WPeDTWdQ94XJOcWXoCSqU0dqhyKQPSAiUtKLEidm0wYJde8=
X-Google-Smtp-Source: AGHT+IHC3A5d9dfzXF/OFJTCrWyk5/3PrCzYEYJin726HG++wy8Mm9T6HEnRaPZyN16Ax2LEu6JG4w==
X-Received: by 2002:a05:600c:4e87:b0:40c:343b:4515 with SMTP id
 f7-20020a05600c4e8700b0040c343b4515mr997504wmq.243.1703279443234; 
 Fri, 22 Dec 2023 13:10:43 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b0040c2963e5f3sm8083224wmq.38.2023.12.22.13.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:10:42 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>,
 Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH v13 15/24] cli: add modern hush as parser for
 run_command*()
Date: Fri, 22 Dec 2023 22:10:42 +0100
Message-ID: <5739012.DvuYhMxLoT@pwmachine>
In-Reply-To: <20231222210244.91830-16-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <20231222210244.91830-16-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi!


Le vendredi 22 d=E9cembre 2023, 22:02:35 CET Francis Laniel a =E9crit :
> Enables using, in code, modern hush as parser for run_command function
> family. It also enables the command run to be used by CLI user of modern
> hush.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> ---
>  common/cli.c               | 67 ++++++++++++++++++++++++++++----------
>  common/cli_hush_upstream.c |  2 +-
>  test/boot/bootflow.c       | 16 ++++++++-
>  3 files changed, 66 insertions(+), 19 deletions(-)
>=20
> diff --git a/common/cli.c b/common/cli.c
> index b3eb512b62..a34938294e 100644
> --- a/common/cli.c
> +++ b/common/cli.c
> @@ -25,6 +25,14 @@
>  #include <linux/errno.h>
>=20
>  #ifdef CONFIG_CMDLINE
> +
> +static inline bool use_hush_old(void)
> +{
> +	return IS_ENABLED(CONFIG_HUSH_SELECTABLE) ?
> +	gd->flags & GD_FLG_HUSH_OLD_PARSER :
> +	IS_ENABLED(CONFIG_HUSH_OLD_PARSER);
> +}
> +
>  /*
>   * Run a command using the selected parser.
>   *
> @@ -43,15 +51,30 @@ int run_command(const char *cmd, int flag)
>  		return 1;
>=20
>  	return 0;
> -#elif CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
> -	int hush_flags =3D FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
> -
> -	if (flag & CMD_FLAG_ENV)
> -		hush_flags |=3D FLAG_CONT_ON_NEWLINE;
> -	return parse_string_outer(cmd, hush_flags);
> -#else /* HUSH_MODERN_PARSER */
> -	/* Not yet implemented. */
> -	return 1;
> +#else
> +	if (use_hush_old()) {
> +		int hush_flags =3D FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
> +
> +		if (flag & CMD_FLAG_ENV)
> +			hush_flags |=3D FLAG_CONT_ON_NEWLINE;
> +		return parse_string_outer(cmd, hush_flags);
> +	}
> +	/*
> +	 * Possible values for flags are the following:
> +	 * FLAG_EXIT_FROM_LOOP: This flags ensures we exit from loop in
> +	 * parse_and_run_stream() after first iteration while normal
> +	 * behavior, * i.e. when called from cli_loop(), is to loop
> +	 * infinitely.
> +	 * FLAG_PARSE_SEMICOLON: modern Hush parses ';' and does not stop
> +	 * first time it sees one. So, I think we do not need this flag.
> +	 * FLAG_REPARSING: For the moment, I do not understand the goal
> +	 * of this flag.
> +	 * FLAG_CONT_ON_NEWLINE: This flag seems to be used to continue
> +	 * parsing even when reading '\n' when coming from
> +	 * run_command(). In this case, modern Hush reads until it finds
> +	 * '\0'. So, I think we do not need this flag.
> +	 */
> +	return parse_string_outer_modern(cmd, FLAG_EXIT_FROM_LOOP);
>  #endif
>  }
>=20
> @@ -67,12 +90,23 @@ int run_command_repeatable(const char *cmd, int flag)
>  #ifndef CONFIG_HUSH_PARSER
>  	return cli_simple_run_command(cmd, flag);
>  #else
> +	int ret;
> +
> +	if (use_hush_old()) {
> +		ret =3D parse_string_outer(cmd,
> +					 FLAG_PARSE_SEMICOLON
> +					 | FLAG_EXIT_FROM_LOOP);
> +	} else {
> +		ret =3D parse_string_outer_modern(cmd,
> +					      FLAG_PARSE_SEMICOLON
> +					      | FLAG_EXIT_FROM_LOOP);
> +	}
> +
>  	/*
>  	 * parse_string_outer() returns 1 for failure, so clean up
>  	 * its result.
>  	 */
> -	if (parse_string_outer(cmd,
> -			       FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP))
> +	if (ret)
>  		return -1;
>=20
>  	return 0;
> @@ -111,12 +145,11 @@ int run_command_list(const char *cmd, int len, int
> flag) buff[len] =3D '\0';
>  	}
>  #ifdef CONFIG_HUSH_PARSER
> -#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
> -	rcode =3D parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
> -#else /* HUSH_MODERN_PARSER */
> -	/* Not yet implemented. */
> -	rcode =3D 1;
> -#endif
> +	if (use_hush_old()) {
> +		rcode =3D parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
> +	} else {
> +		rcode =3D parse_string_outer_modern(buff, FLAG_PARSE_SEMICOLON);
> +	}
>  #else
>  	/*
>  	 * This function will overwrite any \n it sees with a \0, which
> diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
> index 7f6b058e6c..11870c51e8 100644
> --- a/common/cli_hush_upstream.c
> +++ b/common/cli_hush_upstream.c
> @@ -8022,7 +8022,7 @@ static int parse_and_run_string(const char *s)
>  }
>=20
>  #ifdef __U_BOOT__
> -int parse_string_outer(const char *cmd, int flags)
> +int parse_string_outer_modern(const char *cmd, int flags)
>  {
>  	int ret;
>  	int old_flags;
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index a9b555c779..104f49deef 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -710,7 +710,21 @@ static int bootflow_scan_menu_boot(struct
> unit_test_state *uts) ut_assert_skip_to_line("(2 bootflows, 2 valid)");
>=20
>  	ut_assert_nextline("Selected: Armbian");
> -	ut_assert_skip_to_line("Boot failed (err=3D-14)");
> +
> +	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> +		/*
> +		 * With old hush, despite booti failing to boot, i.e. returning
> +		 * CMD_RET_FAILURE, run_command() returns 0 which leads=20
bootflow_boot(),
> as +		 * we are using bootmeth_script here, to return -EFAULT.
> +		 */
> +		ut_assert_skip_to_line("Boot failed (err=3D-14)");
> +	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
> +		/*
> +		 * While with modern one, run_command() propagates=20
CMD_RET_FAILURE
> returned +		 * by booti, so we get 1 here.
> +		 */
> +		ut_assert_skip_to_line("Boot failed (err=3D1)");
> +	}

I would like to give a bit of context here.
With the following patch:
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index c169c835e3..cc5adda0a3 100644
=2D-- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -173,7 +173,7 @@ else
        fi
 fi
 booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
=2D
+echo $?
 # Recompile with:
 # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
 ''' % (mmc_dev)
We can easily see that booti is failing while running the test:
$ ./test/py/test.py -o log_cli=3Dtrue -s --build -v -k=20
'test_ut[ut_bootstd_bootflow_scan_menu_boot'
=2E..
Aborting!
=46ailed to load '/boot/dtb/rockchip/overlay/-fixup.scr'
1

The problem with old hush, is that the 1 returned here, which corresponds t=
o=20
CMD_RET_FAILURE, is not propagated as the return value of run_command().
So, this lead the -EFAULT branch here to be taken:
int bootflow_boot(struct bootflow *bflow)
{
	/* ... */

	ret =3D bootmeth_boot(bflow->method, bflow);
	if (ret)
		return log_msg_ret("boot", ret);

	/*
	 * internal error, should not get here since we should have booted
	 * something or returned an error
	 */

	return log_msg_ret("end", -EFAULT);
}

With modern hush, CMD_RET_FAILURE is propagated as the return value of=20
run_command().
As a consequence, we return with log_mst_ret("boot", 1), which leaded to th=
is=20
test to fail.
The above modification consists in adapting the expected output to the curr=
ent=20
shell flavor.
I think this is the good thing to do, as I find modern hush behavior better=
=20
than the old one, i.e. it propagates CMD_RET_FAILURE as return of=20
run_command().

>  	ut_assertnonnull(std->cur_bootflow);
>  	ut_assert_console_end();


Happy end of the year!


