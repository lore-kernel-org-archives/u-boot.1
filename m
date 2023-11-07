Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B051C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6D3875CC;
	Tue,  7 Nov 2023 22:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mIYtwkbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F8B87627; Tue,  7 Nov 2023 22:43:05 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021D78762C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso3779682f8f.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393382; x=1699998182;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ia2VcIMGPeQt3ekGN/hfcSr4VKDKJwCudqdZo7MvZ4=;
 b=mIYtwkbfCjdtXybWMlrrqnsSSpc54tCjghoYUNdXwQxZwXOgDjmj5OPHl6RmAriUgg
 345rnQCsWUi2RVrb9MYO6JhGJQhrC9pkxh+i/J/3N5LO96vcrpgRvfuga79m83Em09xd
 Xcg4LAoNVfhVOfa4JKv1XxdDh1gcrqmNUYbl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393382; x=1699998182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ia2VcIMGPeQt3ekGN/hfcSr4VKDKJwCudqdZo7MvZ4=;
 b=P2a4UW69f6384U8c5rm5Y6RcVkhEeNchzoMeabTzcPAD1ZF/1TCi/FpISCWlQetyCR
 zOUPE+z8F6vQqQZ4tSK52jafWbVV7KlXj5Q33za8dRUzuKwVAA+BQ/1Q+ygkXIj0l4Dn
 l10GEKdvXOZVjoJgu93vCuAzR2oBYhKd/g3Q7Gx+9wuLwpamfoQPKKE7m22SySlv4lCM
 khCT2fyavViKPa3LNwW2HHbVJ6Ucwk3p22/8gaDucSjWzuys3kDv4ydI1dCgp3/zxLS9
 FL+ZWBFlTV8nhFbTcHlpQMzKSoz1JJJT7RlnsbIgxQdMLXDCPPWZ3l+cMm/9jekIkN6i
 zU1g==
X-Gm-Message-State: AOJu0Yxvi916w0ljy+q/XhGqtRnbvEq18oKHr8PQ91sHcGMktJcHL+Ou
 jT09zrVyKujpymhWGFMcUZwhSQ==
X-Google-Smtp-Source: AGHT+IHj+0ZbHTcMCSqUvEYEaDW2WZdGYgTnHD4WXFki3wtfL2lsgleBtdP9TbIGoC7t8rx5XFe/wA==
X-Received: by 2002:a05:6000:1882:b0:32d:b2cf:8ccd with SMTP id
 a2-20020a056000188200b0032db2cf8ccdmr25487wri.47.1699393382392; 
 Tue, 07 Nov 2023 13:43:02 -0800 (PST)
Received: from pwmachine.localnet ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a056000181100b0032da6f17ffdsm3335101wrh.38.2023.11.07.13.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:43:02 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Roger Knecht <rknecht@pm.me>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Hector Palacios <hector.palacios@digi.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH v10 11/24] cmd: Add new cli command
Date: Tue, 07 Nov 2023 23:43:00 +0200
Message-ID: <5725960.DvuYhMxLoT@pwmachine>
In-Reply-To: <9a4cea75-894f-4c71-b672-3b5607199ba5@gmx.de>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
 <20231004164220.15738-12-francis.laniel@amarulasolutions.com>
 <9a4cea75-894f-4c71-b672-3b5607199ba5@gmx.de>
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


Le jeudi 5 octobre 2023, 02:26:52 EET Heinrich Schuchardt a =E9crit :
> On 10/4/23 18:42, Francis Laniel wrote:
> > This command can be used to print the current parser with 'cli print'.
>=20
> Please, provide a commit message that matches the code.
>=20
> > It can also be used to set the current parser with 'cli set'.
> > For the moment, only one value is valid for set: old.
>=20
> If there is only one valid value, we should not provide the 'cli'
> command to save code size. The patch seems to be in the wrong spot in
> the series.

Thank you for your feedback! I normally addressed this problem in v11.

> > Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> > ---
> >=20
> >   cmd/Makefile          |   2 +
> >   cmd/cli.c             | 120 ++++++++++++++++++++++++++++++++++++++++++
> >   common/cli.c          |   3 +-
> >   doc/usage/cmd/cli.rst |  59 +++++++++++++++++++++
> >   doc/usage/index.rst   |   1 +
> >   5 files changed, 184 insertions(+), 1 deletion(-)
> >   create mode 100644 cmd/cli.c
> >   create mode 100644 doc/usage/cmd/cli.rst
> >=20
> > diff --git a/cmd/Makefile b/cmd/Makefile
> > index 9bebf321c3..d468cc5065 100644
> > --- a/cmd/Makefile
> > +++ b/cmd/Makefile
> > @@ -226,6 +226,8 @@ obj-$(CONFIG_CMD_AVB) +=3D avb.o
> >=20
> >   # Foundries.IO SCP03
> >   obj-$(CONFIG_CMD_SCP03) +=3D scp03.o
> >=20
> > +obj-$(CONFIG_HUSH_PARSER) +=3D cli.o
>=20
> Don't waste binary code size. We only need the command if at least two
> parsers are available.
>=20
> ifeq ($(CONFIG_HUSH_OLD_PARSER)$(HUSH_2021_PARSER),yy)
> obj-y +=3D cli.o
> endif
>=20
> The symbol CONFIG_HUSH_PARSER should be eliminated.
>=20
> > +
> >=20
> >   obj-$(CONFIG_ARM) +=3D arm/
> >   obj-$(CONFIG_RISCV) +=3D riscv/
> >   obj-$(CONFIG_SANDBOX) +=3D sandbox/
> >=20
> > diff --git a/cmd/cli.c b/cmd/cli.c
> > new file mode 100644
> > index 0000000000..7671785b83
> > --- /dev/null
> > +++ b/cmd/cli.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <common.h>
> > +#include <cli.h>
> > +#include <command.h>
> > +#include <string.h>
> > +#include <asm/global_data.h>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +static const char *gd_flags_to_parser(void)
> > +{
> > +	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> > +		return "old";
> > +	return NULL;
> > +}
> > +
> > +static int do_cli_get(struct cmd_tbl *cmdtp, int flag, int argc,
> > +			 char *const argv[])
> > +{
> > +	const char *current =3D gd_flags_to_parser();
> > +
> > +	if (!current) {
> > +		printf("current cli value is not valid, this should not happen!
\n");
> > +		return CMD_RET_FAILURE;
> > +	}
> > +
> > +	printf("%s\n", current);
> > +
> > +	return CMD_RET_SUCCESS;
> > +}
> > +
>=20
> Please, describe this function (and all the others) in Sphinx style.
>=20
> /**
>   * parser_string_to_gd_flags() - converts parser name to bit mask
>   *
>   * @parser:	parser name
>   * Return:	valid bit mask or -1
>   */
>=20
> > +static int parser_string_to_gd_flags(const char *parser)
> > +{
> > +	if (!strcmp(parser, "old"))
> > +		return GD_FLG_HUSH_OLD_PARSER;
>=20
> Please, do not return an invalid bit mask.
>=20
> if (CONFIG_IS_ENABLED(HUSH_OLD_PARSER) && !strcmp(parser, "old"))
> 	return GD_FLG_HUSH_OLD_PARSER;
> if (CONFIG_IS_ENABLED(HUSH_2021_PARSER) && !strcmp(parser, "2021"))
> 	return GD_FLG_HUSH_201_PARSER;
>=20
> > +	return -1;
> > +}
> > +
> > +static void reset_parser_gd_flags(void)
> > +{
> > +	gd->flags &=3D ~GD_FLG_HUSH_OLD_PARSER;
>=20
> gd->flags &=3D ~(GD_FLG_HUSH_OLD_PARSER | GD_FLG_HUSH_2021_PARSER);
>=20
> If there were only one parser, we wouldn't create this command.
>=20
> > +}
> > +
> > +static int do_cli_set(struct cmd_tbl *cmdtp, int flag, int argc,
> > +		      char *const argv[])
> > +{
> > +	char *parser_name;
> > +	int parser_flag;
> > +
> > +	if (argc < 2)
> > +		return CMD_RET_USAGE;
> > +
> > +	parser_name =3D argv[1];
> > +
> > +	parser_flag =3D parser_string_to_gd_flags(parser_name);
>=20
> This function should return -1 for for any value that is not supported
> be it 'foo', 'old', or '2021'. Then you can eliminate a bunch of error
> checking code below.
>=20
> > +	if (parser_flag =3D=3D -1) {
> > +		printf("Bad value for parser name: %s\n", parser_name);
> > +		return CMD_RET_USAGE;
> > +	}
> > +
> > +	if (parser_flag =3D=3D GD_FLG_HUSH_OLD_PARSER &&
> > +		!CONFIG_IS_ENABLED(HUSH_OLD_PARSER)) {
> > +		printf("Want to set current parser to old, but its code was not
> > compiled!\n"); +		return CMD_RET_FAILURE;
> > +	}
>=20
> Superfluous check, see above.
>=20
> > +
> > +	if (parser_flag =3D=3D GD_FLG_HUSH_2021_PARSER &&
> > +		!CONFIG_IS_ENABLED(HUSH_2021_PARSER)) {
> > +		printf("Want to set current parser to 2021, but its code was=20
not
> > compiled!\n"); +		return CMD_RET_FAILURE;
> > +	}
>=20
> Superfluous check, see above.
>=20
> > +
> > +	reset_parser_gd_flags();
> > +	gd->flags |=3D parser_flag;
> > +
> > +	cli_init();
> > +	cli_loop();
> > +
> > +	/* cli_loop() should never return. */
> > +	return CMD_RET_FAILURE;
>=20
> Consuming stack space for every invocation of the 'cli set' command
> cannot be intended.
>=20
> Why don't we define cli_loop as __noreturn and ensure that it has no
> return statement? Then gcc can generate a simple jump without consuming
> stack.
>=20
> cli_loop should() invoke panic() instead of returning.
>=20
> > +}
> > +
> > +static struct cmd_tbl parser_sub[] =3D {
> > +	U_BOOT_CMD_MKENT(get, 1, 1, do_cli_get, "", ""),
> > +	U_BOOT_CMD_MKENT(set, 2, 1, do_cli_set, "", ""),
> > +};
> > +
> > +static int do_cli(struct cmd_tbl *cmdtp, int flag, int argc,
> > +		  char *const argv[])
> > +{
> > +	struct cmd_tbl *cp;
> > +
> > +	if (argc < 2)
> > +		return CMD_RET_USAGE;
> > +
> > +	/* drop initial "parser" arg */
> > +	argc--;
> > +	argv++;
> > +
> > +	cp =3D find_cmd_tbl(argv[0], parser_sub, ARRAY_SIZE(parser_sub));
> > +	if (cp)
> > +		return cp->cmd(cmdtp, flag, argc, argv);
> > +
> > +	return CMD_RET_USAGE;
> > +}
> > +
> > +#if CONFIG_IS_ENABLED(SYS_LONGHELP)
> > +static char cli_help_text[] =3D
> > +	"get - print current cli\n"
>=20
> "get - display parser\n"
>=20
> > +	"set - set the current cli, possible value is: old"
>=20
> 'cli ' is only printed automatically in the first line.
>=20
> "cli set - set parser to one of:\n"
> #ifdef CONFIG_HUSH_OLD_PARSER
> "\t- old\n"
> #endif
> #ifdef CONFIG_HUSH_2021_PARSER
> "\t- 2021\n"
> #endif
>=20
> Why would we need the 'cli set' command at all if there is only one
> parser enabled?
> Should we better disable the sub-command in that case?
>=20
> > +	;
> > +#endif
> > +
> > +U_BOOT_CMD(cli, 3, 1, do_cli,
> > +	   "cli",
> > +#if CONFIG_IS_ENABLED(SYS_LONGHELP)
> > +	   cli_help_text
> > +#endif
>=20
> This is wrong. You must pass an empty string at least. Please, follow
> the style of the other commands and place the #if in the long text.
>=20
> > +);
> > diff --git a/common/cli.c b/common/cli.c
> > index e5fe1060d0..d419671e8c 100644
> > --- a/common/cli.c
> > +++ b/common/cli.c
> > @@ -268,7 +268,8 @@ void cli_loop(void)
> >=20
> >   void cli_init(void)
> >   {
> >   #ifdef CONFIG_HUSH_PARSER
>=20
> This Kconfig symbol is superfluous when you already have
> CONFIG_HUSH_OLD_PARSER and CONFIG_HUSH_2021_PARSER.
>=20
> Please, remove CONFIG_HUSH_PARSER from Kconfig.
>=20
> > -	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER))
> > +	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER)
>=20
> The first part of the if statement is superfluous.
> There is no harm in setting the bit again.
>=20
> > +		&& CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
> >=20
> >   		gd->flags |=3D GD_FLG_HUSH_OLD_PARSER;
> >   =09
> >   	u_boot_hush_start();
> >  =20
> >   #endif
> >=20
> > diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
> > new file mode 100644
> > index 0000000000..89ece3203d
> > --- /dev/null
> > +++ b/doc/usage/cmd/cli.rst
> > @@ -0,0 +1,59 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +cli command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Synopis
> > +-------
> > +
> > +::
> > +
> > +    cli get
> > +    cli set cli_flavor
>=20
> We should show the available values here:
>=20
> cli set [old|2021]
>=20
> > +
> > +Description
> > +-----------
> > +
> > +The cli command permits getting and changing the current parser at
> > runtime.
> The cli command permits displaying and setting the command line parsers.
> Currently two parsers are implemented:
>=20
> old
>     The 'old' parser is what U-Boot provided until v2023.10.
>=20
> 2021
>     The '2021' parser provides ....
>=20
> Please, describe here why the '2021' parser might be preferable. Please,
> describe which parser is the default.
>=20
> > +
> > +cli get
> > +~~~~~~~
> > +
> > +It shows the current value of the parser used by the CLI.
>=20
> The command display the parser used by the command line interface ('old'
> or '2021').
>=20
> > +
> > +cli set
> > +~~~~~~~
> > +
> > +It permits setting the value of the parser used by the CLI.
>=20
> The command sets the parser used by the command line interface.
>=20
> > +
> > +Possible values are old and 2021.
> > +Note that, to use a specific parser its code should have been compiled,
> > that +is to say you need to enable the corresponding CONFIG_HUSH*.
> > +Otherwise, an error message is printed.
>=20
> Should we use .. note:: here to highlight the information?
>=20
> > +
> > +Examples
> > +--------
> > +
> > +Get the current parser::
> > +
> > +    =3D> cli get
> > +    old
> > +
> > +Change the current parser::
> > +
> > +    =3D> cli set old
>=20
> =3D> cli set 2021
>=20
> Who would want to set the current value?
>=20
> > +
> > +Trying to set the current parser to an unknown value::
> > +
> > +    =3D> cli set foo
> > +    Bad value for parser name: foo
> > +    cli - cli
> > +
> > +    Usage:
> > +    cli get - print current cli
> > +    set - set the current cli, possible value is: old
>=20
> This looks like a bug. I would have expected at least two possible
> values. Otherwise we would not need a 'cli' command.
>=20
> Please, add a 'Configuration' section describing the relevant
> configuration variables.
>=20
> Best regards
>=20
> Heinrich
>=20
> > +
> > +Return value
> > +------------
> > +
> > +The return value $? indicates whether the command succeeded.
> > diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> > index fa702920fa..90a38c5713 100644
> > --- a/doc/usage/index.rst
> > +++ b/doc/usage/index.rst
> > @@ -42,6 +42,7 @@ Shell commands
> >=20
> >      cmd/cat
> >      cmd/cbsysinfo
> >      cmd/cedit
> >=20
> > +   cmd/cli
> >=20
> >      cmd/cls
> >      cmd/cmp
> >      cmd/coninfo


Best regards.


