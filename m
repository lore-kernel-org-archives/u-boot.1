Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1BCE936ED
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 23:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E7948758C;
	Thu,  5 Oct 2023 01:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Eke/1C+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF608759D; Thu,  5 Oct 2023 01:36:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516FE87574
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 01:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696462564; x=1697067364; i=xypron.glpk@gmx.de;
 bh=5e8HHHwMeS4xEqtmo2PwmE7Rf5fYL3m8WRKxaCn4O3k=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Eke/1C+UOgoCaSc+EUpn0zO/87au+Ji653S0M0NIRIJC0ZyJ17KiHCREcZC0ueY+w8NpQdeVvzr
 DldtthoKjKUPH+a7AUqGgXB3JHuNv277kn68O9bpz0jqk1g278aL0ViWOvVqlt5Xn+1OOH9vKRVWv
 wTgr1ojkX+thXZmp3wIz6fOzgKfZdxRizJK2ps0Vwbn5QG0+lZS/3ppgBHMyIncTT1DCE0LeLIyES
 xIyrycxHCPR4bNal7yELsmxQJdSVOjf7JPgE+Swmdi9WvFGZzKxwcgYyxnYdgroB503plMmFxeLf4
 snbH5Bpapq+xNvSr/LeHLYfiVhZVSus8H+oA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1rfJva0CR8-00raby; Thu, 05
 Oct 2023 01:36:04 +0200
Message-ID: <280787a9-5e7d-4e9b-be8e-419c854d4572@gmx.de>
Date: Thu, 5 Oct 2023 01:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 12/24] cli: Enables using hush 2021 parser as
 command line parser
Content-Language: en-US
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>,
 Hector Palacios <hector.palacios@digi.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Tony Dinh <mibodhi@gmail.com>,
 Stefan Roese <sr@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
 <20231004164220.15738-13-francis.laniel@amarulasolutions.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231004164220.15738-13-francis.laniel@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0artC5fuINIWiE7U8qVrw8wI0LF9zFV7J0JDdWUDzFJdjazrLB+
 omWztPgjBwcoSWI/XHYGorjxT+1hzkfWy0ldyIzbAoe9ZzJ3aJdvEF5SlTadc0n85t8TjY1
 fPqQ/2qqirUGIBB3OIHsGXwE/IcZK5MfoPqpNieK+xOw1XYURGQ9JFiXT76cZal3FgoHG7s
 Hnp4wdO3eeyvi6Qcr7LeQ==
UI-OutboundReport: notjunk:1;M01:P0:DfZuwevwV/k=;9ZlbPTKo2TuaHs0+dqM0KjHMp+k
 sJQUatX7oVUDVhfILkkeGKBKCBsPoBj+43N/fJ2bU3CjJvLxxikH3sOq2+im05LsAZwIqcL0c
 hH5WtfLxbLg6sC1CuyHuma3gZ00FhjFN7R5eTGesGRsYDlQPOUc/tlwYhdov0MWG6NWQSH8xh
 tya+n390rz3gFQyzqxdtRCTSxtpB9Nk6DcS04gA0MH8gTlpMISV3XGDUAk5d7TD6/95x5gn3P
 CmUfWnSv5xwDq0RivH4z9aFLHgwSefDgUL/WADZLlwAhaKaCK/IZXY7KrKxWdexg5v1XwA9io
 ScvmN66U0Y8zctQhNpPTe+fc2SK8JD3gZK3rHBNVBMlhIvczYe4tx+Dp/4fNke0KzqQR0Et/g
 Mzio+JN2Qo1aSRNT73I4XKuAY/kc9RpzWoGVNFPIHD8Sibfc8lRDPVO2Hkutdrf3+ECcsZZ9t
 BZkHBHm67jJbK2uKFf9KGxdS+Y245HWUD8UKcQwRd3IB0zGWs+KsQM5FeHBwk/ETKqLo0SXMr
 9r3WlyaVeF9ZAW4sxZGUceZIh8FbNy2pI6HlIxobrkiGnaH7tSMerkXfWEriKoUKuhPRS48T9
 FeQvZjvGZdZ9uRXFy0Y90bW//RsECXK1vyRTz2gBCtNVMFLFaL3t/P3JI9izyrmm97bb2xpZs
 QQH7bB9q5yZTi//eEYbFs4/eb37x1N6Y6aFGuo0LbS5KXFeMl+015H8Y+tmndPf0Rp7f/R5Sz
 rD2r7VsGm3LjItJw4hY0sYjmINFIOSaazMDITw8i1mveeZQDKJ37RjP6X7miyiVdZT1eiZJ6H
 pVWMRF++eLdwxpi+jntoeaCOXODimTn2sEHsDvTRcbMKJieUU8oCRIFRGQQp8cIxJwnl+U03b
 CQwZU7sfacSBssM4eXuSRhdg4ktEObeCDO6dOHHSycMwLnF1++5oNCnHz73W89r157yVhlP7r
 Gc4+qXJyw8A3aSbb1aJ9qrMlCkk=
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

On 10/4/23 18:42, Francis Laniel wrote:
> If one defines HUSH_2021_PARSER, it is then possible to use 2021 parser =
with:
> =3D> cli get
> old
> =3D> cli set 2021
> =3D> cli get
> 2021
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> ---
>   cmd/Kconfig                       |  8 +++++
>   cmd/cli.c                         |  7 ++++-
>   common/Makefile                   |  1 +
>   common/cli.c                      | 38 +++++++++++++++++++----
>   common/cli_hush_2021.c            |  3 ++
>   common/cli_hush_upstream.c        | 46 +++++++++++++++++++++++++---
>   doc/usage/cmd/cli.rst             | 17 ++++++++++-
>   include/asm-generic/global_data.h |  4 +++
>   include/cli_hush.h                | 51 +++++++++++++++++++++++++++++--
>   9 files changed, 160 insertions(+), 15 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5fb4cef54c..36595638a2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -34,6 +34,14 @@ menu "Hush flavor to use"
>   		  2005.
>
>   		  It is actually the default U-Boot shell when decided to use hush a=
s shell.
> +
> +	config HUSH_2021_PARSER
> +		bool "Use hush 2021 parser"
> +		help
> +		  This option enables the new flavor of hush based on hush Busybox fr=
om
> +		  2021.
> +
> +		  For the moment, it is highly experimental and should be used at own=
 risks.

Every usage of GPL code is at own risk. That is in the license.

"This parser is experimental and not well tested."

Best regards

Heinrich

>   endmenu
>
>   config CMDLINE_EDITING
> diff --git a/cmd/cli.c b/cmd/cli.c
> index 7671785b83..d2b64da613 100644
> --- a/cmd/cli.c
> +++ b/cmd/cli.c
> @@ -12,6 +12,8 @@ static const char *gd_flags_to_parser(void)
>   {
>   	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
>   		return "old";
> +	if (gd->flags & GD_FLG_HUSH_2021_PARSER)
> +		return "2021";
>   	return NULL;
>   }
>
> @@ -34,12 +36,15 @@ static int parser_string_to_gd_flags(const char *par=
ser)
>   {
>   	if (!strcmp(parser, "old"))
>   		return GD_FLG_HUSH_OLD_PARSER;
> +	if (!strcmp(parser, "2021"))
> +		return GD_FLG_HUSH_2021_PARSER;
>   	return -1;
>   }
>
>   static void reset_parser_gd_flags(void)
>   {
>   	gd->flags &=3D ~GD_FLG_HUSH_OLD_PARSER;
> +	gd->flags &=3D ~GD_FLG_HUSH_2021_PARSER;
>   }
>
>   static int do_cli_set(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -108,7 +113,7 @@ static int do_cli(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
>   #if CONFIG_IS_ENABLED(SYS_LONGHELP)
>   static char cli_help_text[] =3D
>   	"get - print current cli\n"
> -	"set - set the current cli, possible value is: old"
> +	"set - set the current cli, possible value are: old, 2021"
>   	;
>   #endif
>
> diff --git a/common/Makefile b/common/Makefile
> index 615eba8672..4b060bb565 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -9,6 +9,7 @@ obj-y +=3D init/
>   obj-y +=3D main.o
>   obj-y +=3D exports.o
>   obj-$(CONFIG_HUSH_OLD_PARSER) +=3D cli_hush.o
> +obj-$(CONFIG_HUSH_2021_PARSER) +=3D cli_hush_2021.o
>   obj-$(CONFIG_AUTOBOOT) +=3D autoboot.o
>
>   # # boards
> diff --git a/common/cli.c b/common/cli.c
> index d419671e8c..e3e2bc7fe1 100644
> --- a/common/cli.c
> +++ b/common/cli.c
> @@ -43,12 +43,15 @@ int run_command(const char *cmd, int flag)
>   		return 1;
>
>   	return 0;
> -#else
> +#elif CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
>   	int hush_flags =3D FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
>
>   	if (flag & CMD_FLAG_ENV)
>   		hush_flags |=3D FLAG_CONT_ON_NEWLINE;
>   	return parse_string_outer(cmd, hush_flags);
> +#else /* HUSH_2021_PARSER */
> +	/* Not yet implemented. */
> +	return 1;
>   #endif
>   }
>
> @@ -108,7 +111,12 @@ int run_command_list(const char *cmd, int len, int =
flag)
>   		buff[len] =3D '\0';
>   	}
>   #ifdef CONFIG_HUSH_PARSER
> +#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
>   	rcode =3D parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
> +#else /* HUSH_2021_PARSER */
> +	/* Not yet implemented. */
> +	rcode =3D 1;
> +#endif
>   #else
>   	/*
>   	 * This function will overwrite any \n it sees with a \0, which
> @@ -254,8 +262,13 @@ err:
>   void cli_loop(void)
>   {
>   	bootstage_mark(BOOTSTAGE_ID_ENTER_CLI_LOOP);
> -#ifdef CONFIG_HUSH_PARSER
> -	parse_file_outer();
> +#if CONFIG_IS_ENABLED(HUSH_PARSER)
> +	if (gd->flags & GD_FLG_HUSH_2021_PARSER)
> +		parse_and_run_file();
> +	else if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> +		parse_file_outer();
> +
> +	printf("Problem\n");
>   	/* This point is never reached */
>   	for (;;);
>   #elif defined(CONFIG_CMDLINE)
> @@ -268,10 +281,23 @@ void cli_loop(void)
>   void cli_init(void)
>   {
>   #ifdef CONFIG_HUSH_PARSER
> +	/* This if block is used to initialize hush parser gd flag. */
>   	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER)
> -		&& CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
> -		gd->flags |=3D GD_FLG_HUSH_OLD_PARSER;
> -	u_boot_hush_start();
> +		&& !(gd->flags & GD_FLG_HUSH_2021_PARSER)) {
> +		if (CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
> +			gd->flags |=3D GD_FLG_HUSH_OLD_PARSER;
> +		else if (CONFIG_IS_ENABLED(HUSH_2021_PARSER))
> +			gd->flags |=3D GD_FLG_HUSH_2021_PARSER;
> +	}
> +
> +	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> +		u_boot_hush_start();
> +	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
> +		u_boot_hush_start_2021();
> +	} else {
> +		printf("No valid hush parser to use, cli will not initialized!\n");
> +		return;
> +	}
>   #endif
>
>   #if defined(CONFIG_HUSH_INIT_VAR)
> diff --git a/common/cli_hush_2021.c b/common/cli_hush_2021.c
> index 6d109933b8..653ea52929 100644
> --- a/common/cli_hush_2021.c
> +++ b/common/cli_hush_2021.c
> @@ -221,6 +221,9 @@ static uint8_t xfunc_error_retval;
>   static const char defifsvar[] __aligned(1) =3D "IFS=3D \t\n";
>   #define defifs (defifsvar + 4)
>
> +/* This define is used to check if exit command was called. */
> +#define EXIT_RET_CODE -2
> +
>   /*
>    * This define is used for changes that need be done directly in the u=
pstream
>    * sources still. Ideally, its use should be minimized as much as poss=
ible.
> diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
> index cc64af4e0c..84227a248e 100644
> --- a/common/cli_hush_upstream.c
> +++ b/common/cli_hush_upstream.c
> @@ -7914,7 +7914,17 @@ static void parse_and_run_stream(struct in_str *i=
np, int end_trigger)
>   		}
>   		debug_print_tree(pipe_list, 0);
>   		debug_printf_exec("parse_and_run_stream: run_and_free_list\n");
> +#ifndef __U_BOOT__
>   		run_and_free_list(pipe_list);
> +#else /* __U_BOOT__ */
> +		int rcode =3D run_and_free_list(pipe_list);
> +		/*
> +		 * We reset input string to not run the following command, so running
> +		 * 'exit; echo foo' does not print foo.
> +		 */
> +		if (rcode <=3D EXIT_RET_CODE)
> +			setup_file_in_str(inp);
> +#endif /* __U_BOOT__ */
>   		empty =3D 0;
>   		if (G_flag_return_in_progress =3D=3D 1)
>   			break;
> @@ -10369,13 +10379,39 @@ static int run_list(struct pipe *pi)
>   #endif /* !__U_BOOT__ */
>   		rcode =3D r =3D run_pipe(pi); /* NB: rcode is a smalluint, r is int =
*/
>   #ifdef __U_BOOT__
> -		if (r =3D=3D -2) {
> -			/* -2 indicates exit was called, so we need to quit now. */
> -			G.last_exitcode =3D rcode;
> +		if (r <=3D EXIT_RET_CODE) {
> +			int previous_rcode =3D G.last_exitcode;
> +			/*
> +			 * This magic is to get the exit code given by the user.
> +			 * Contrary to old shell code, we use + EXIT_RET_CODE as EXIT_RET_CO=
DE
> +			 * equals -2.
> +			 */
> +			G.last_exitcode =3D -r + EXIT_RET_CODE;
>
> -			break;
> +			/*
> +			 * This case deals with the following:
> +			 * =3D> setenv inner 'echo entry inner; exit; echo inner done'
> +			 * =3D> setenv outer 'echo entry outer; run inner; echo outer done'
> +			 * =3D> run outer
> +			 * So, if we are in inner, we need to break and not run the other
> +			 * commands.
> +			 * Otherwise, we just continue in outer.
> +			 * As return code are propagated, we use the previous value to check=
 if
> +			 * exit was just called or was propagated.
> +			 */
> +			if (previous_rcode !=3D r) {
> +				/*
> +				 * If run from run_command, run_command_flags will be set, so we ch=
eck
> +				 * this to know if we are in main input shell.
> +				 */
> +				if (!G.run_command_flags)
> +					printf("exit not allowed from main input shell.\n");
> +
> +				break;
> +			}
> +			continue;
>   		}
> -#endif
> +#endif /* __U_BOOT__ */
>   		if (r !=3D -1) {
>   			/* We ran a builtin, function, or group.
>   			 * rcode is already known
> diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
> index 89ece3203d..bc600bf9e9 100644
> --- a/doc/usage/cmd/cli.rst
> +++ b/doc/usage/cmd/cli.rst
> @@ -41,7 +41,14 @@ Get the current parser::
>
>   Change the current parser::
>
> +    =3D> cli get
> +    old
> +    =3D> cli set 2021
> +    =3D> cli get
> +    2021
>       =3D> cli set old
> +    =3D> cli get
> +    old
>
>   Trying to set the current parser to an unknown value::
>
> @@ -51,7 +58,15 @@ Trying to set the current parser to an unknown value:=
:
>
>       Usage:
>       cli get - print current cli
> -    set - set the current cli, possible value is: old
> +    set - set the current cli, possible values are: old, 2021
> +
> +Trying to set the current parser to a correct value but its code was no=
t
> +compiled::
> +
> +    =3D> cli get
> +    2021
> +    =3D> cli set old
> +    Want to set current parser to old, but its code was not compiled!
>
>   Return value
>   ------------
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glo=
bal_data.h
> index f21926aa23..49ac892912 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -671,6 +671,10 @@ enum gd_flags {
>   	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
>   	 */
>   	GD_FLG_HUSH_OLD_PARSER =3D 0x400000,
> +	/**
> +	 * @GD_FLG_HUSH_2021_PARSER: Use hush 2021 parser.
> +	 */
> +	GD_FLG_HUSH_2021_PARSER =3D 0x800000,
>   };
>
>   #endif /* __ASSEMBLY__ */
> diff --git a/include/cli_hush.h b/include/cli_hush.h
> index 2bd35670c7..4ef79de53c 100644
> --- a/include/cli_hush.h
> +++ b/include/cli_hush.h
> @@ -12,11 +12,58 @@
>   #define FLAG_REPARSING       (1 << 2)	  /* >=3D2nd pass */
>   #define FLAG_CONT_ON_NEWLINE (1 << 3)	  /* continue when we see \n */
>
> +#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
>   extern int u_boot_hush_start(void);
> -extern int parse_string_outer(const char *, int);
> +extern int parse_string_outer(const char *str, int flag);
>   extern int parse_file_outer(void);
> -
>   int set_local_var(const char *s, int flg_export);
> +#else
> +static inline int u_boot_hush_start(void)
> +{
> +	return 0;
> +}
> +
> +static inline int parse_string_outer(const char *str, int flag)
> +{
> +	return 1;
> +}
> +
> +static inline int parse_file_outer(void)
> +{
> +	return 0;
> +}
> +
> +static inline int set_local_var(const char *s, int flg_export)
> +{
> +	return 0;
> +}
> +#endif
> +#if CONFIG_IS_ENABLED(HUSH_2021_PARSER)
> +extern int u_boot_hush_start_2021(void);
> +extern int parse_string_outer_2021(const char *str, int flag);
> +extern void parse_and_run_file(void);
> +int set_local_var_2021(char *s, int flg_export);
> +#else
> +static inline int u_boot_hush_start_2021(void)
> +{
> +	return 0;
> +}
> +
> +static inline int parse_string_outer_2021(const char *str, int flag)
> +{
> +	return 1;
> +}
> +
> +static inline void parse_and_run_file(void)
> +{
> +}
> +
> +static inline int set_local_var_2021(char *s, int flg_export)
> +{
> +	return 0;
> +}
> +#endif
> +
>   void unset_local_var(const char *name);
>   char *get_local_var(const char *s);
>

