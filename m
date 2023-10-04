Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA9FE936EC
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 23:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11CD86E2F;
	Thu,  5 Oct 2023 01:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jSHY6Npa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A988753C; Thu,  5 Oct 2023 01:27:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74CD86B18
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 01:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696462016; x=1697066816; i=xypron.glpk@gmx.de;
 bh=kAbP0WRdALH8jQxjlD7JC6JLbbdSMGQ7xrgvtgdYoeI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jSHY6NparPDnYQJgzmPhz6ICvfo414qXaDPgeLZrWGRKe+FSWU94TbvWeOhdvCxssS2RATB8Fjl
 pP+gLOFWi+c+Hvlzp9uU4QwCVXx7cQHbp4e3NBQ6+w3+Qni/NK2ukHL0lZ43qsk1kffR0x/ua+b6G
 rxOh9xAaUArwdNH3rb2k2GSCwDlpEbajrc8FJjrtMYCPdI4AxSVXJETrVKsEzhPeEAik8K7avQOtw
 LFAfeythSBhkRbOUFmw8lEk+AfWkFsJQgpQ49nGs/0AG+99cmlGha/GgMK//EOGc9v+F+pNB37pdR
 /T7+mBF1RBfx5X4eKQ9ObG3cyUzxHmORvZHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1rd8Dt3qCg-00tnXv; Thu, 05
 Oct 2023 01:26:56 +0200
Message-ID: <9a4cea75-894f-4c71-b672-3b5607199ba5@gmx.de>
Date: Thu, 5 Oct 2023 01:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 11/24] cmd: Add new cli command
To: Francis Laniel <francis.laniel@amarulasolutions.com>
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
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
 <20231004164220.15738-12-francis.laniel@amarulasolutions.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231004164220.15738-12-francis.laniel@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tFO9K6fAmQUB55Xrqu9bnT7RMp419tpnDrIZ+0bEMjQJqvbF5Zm
 rIhyltCcVFdJDBAHmoM+Sw86yxlmkPAYfB/Du5PI8dmDzXYuEHVAZQM8M25jJNsWhwFMoKt
 h6vE+BQ8fPHaF6vraoP3eZRhwKOijvbRP7rUd+RnG6DvWzHxa9XTF8iR1BBja1Vvhz/kvdU
 mVGZRcl3kna6xY8RbbEuw==
UI-OutboundReport: notjunk:1;M01:P0:EzgQ94J1zOM=;PNPGe4GgYwuWDmKfnKkdIrOyVjy
 3N00MQBW2COlCBe2rDLOyZvAhuTRQwGFvD6IwH9kZnjHyj/jC7Mwb1mpzkTln4b1ok+Iogwq2
 hUKzqNocjOd2xJfQttVJKGJeMD1i1+pzypTeKKt7rSasyshOv9czupZcr7dyPYL/qiQzLtE2A
 my4GMIzlv+sszMkSjF9AP2RocJSLYBncNogc5ThPWleMDbrwhCztfKnuTCvmdJNZfCxJL8mWv
 +IwUQlLvT3t4FSw9OMGhz7wzA34W+fINefZ2KvZxfGUaVm/IUYxuBQGmNwjP+fNvVz47w96az
 Ofa+PX9+86N2Fy9meUC/sKpP2FTajEY5etUaH7Fqv4PNwu5V2tq3Is7uMCkgu4O0qTsUU8K4w
 qux5DThUo3QaznnUcmPxHReNbAaSozyDjRJctXWJREqwF0c7DXIwSyLSPFs5sIvhj8BZQ+Px/
 jb7fIIiqYaPdNR5cgm53ebudU+MB88XXg8mHfAzJ3dM3WmpwGfPzIHbG6pin4++YMC/sd7AOO
 m7AnMStE5kzbdVWDUskPXh5LWX1W//DbmALk8/uezc+Jn/wH/yL4GkrpJBn1A06KeLa1qBfAJ
 KNSHU34wzLptO/tbzIZHEg2PyifWTvthE7MB7unl13U3s5DyEB24mIEXbxYIqasryhcSzNaEh
 z0HsfZFNv7sl8AS/SDn87oz9Ip1G/eIkykMIBYmvsS3l45gLRanKDtDCey7Xi6ACzeOUxJ35+
 yE/wkHuEmQEW/j3bKDMIk/Q9lKn7rj4f7Qkv0qSccnGFhmo01+/2KgRAvoPLFaqP2gqhyIe4T
 pG5pH1fCZCZYCYAf+31F85wRG2AIDIzFQcI4OWTRR5cNhWQaBqoqBL+cFi/kIpqi0OEDncbXr
 vhOGR8ORrg6zQn4zAvtnHPJQuMlxNmmZKGJc/jjazQj8AMK82BOKVIaX0Mz49mRCFLD8DSBoz
 mhoVr1P7XuU4Jjr7rKCaTvkalaM=
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
> This command can be used to print the current parser with 'cli print'.

Please, provide a commit message that matches the code.

> It can also be used to set the current parser with 'cli set'.
> For the moment, only one value is valid for set: old.

If there is only one valid value, we should not provide the 'cli'
command to save code size. The patch seems to be in the wrong spot in
the series.

>
> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> ---
>   cmd/Makefile          |   2 +
>   cmd/cli.c             | 120 ++++++++++++++++++++++++++++++++++++++++++
>   common/cli.c          |   3 +-
>   doc/usage/cmd/cli.rst |  59 +++++++++++++++++++++
>   doc/usage/index.rst   |   1 +
>   5 files changed, 184 insertions(+), 1 deletion(-)
>   create mode 100644 cmd/cli.c
>   create mode 100644 doc/usage/cmd/cli.rst
>
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 9bebf321c3..d468cc5065 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -226,6 +226,8 @@ obj-$(CONFIG_CMD_AVB) +=3D avb.o
>   # Foundries.IO SCP03
>   obj-$(CONFIG_CMD_SCP03) +=3D scp03.o
>
> +obj-$(CONFIG_HUSH_PARSER) +=3D cli.o

Don't waste binary code size. We only need the command if at least two
parsers are available.

ifeq ($(CONFIG_HUSH_OLD_PARSER)$(HUSH_2021_PARSER),yy)
obj-y +=3D cli.o
endif

The symbol CONFIG_HUSH_PARSER should be eliminated.

> +
>   obj-$(CONFIG_ARM) +=3D arm/
>   obj-$(CONFIG_RISCV) +=3D riscv/
>   obj-$(CONFIG_SANDBOX) +=3D sandbox/
> diff --git a/cmd/cli.c b/cmd/cli.c
> new file mode 100644
> index 0000000000..7671785b83
> --- /dev/null
> +++ b/cmd/cli.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <common.h>
> +#include <cli.h>
> +#include <command.h>
> +#include <string.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static const char *gd_flags_to_parser(void)
> +{
> +	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> +		return "old";
> +	return NULL;
> +}
> +
> +static int do_cli_get(struct cmd_tbl *cmdtp, int flag, int argc,
> +			 char *const argv[])
> +{
> +	const char *current =3D gd_flags_to_parser();
> +
> +	if (!current) {
> +		printf("current cli value is not valid, this should not happen!\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	printf("%s\n", current);
> +
> +	return CMD_RET_SUCCESS;
> +}
> +

Please, describe this function (and all the others) in Sphinx style.

/**
  * parser_string_to_gd_flags() - converts parser name to bit mask
  *
  * @parser:	parser name
  * Return:	valid bit mask or -1
  */

> +static int parser_string_to_gd_flags(const char *parser)
> +{
> +	if (!strcmp(parser, "old"))
> +		return GD_FLG_HUSH_OLD_PARSER;

Please, do not return an invalid bit mask.

if (CONFIG_IS_ENABLED(HUSH_OLD_PARSER) && !strcmp(parser, "old"))
	return GD_FLG_HUSH_OLD_PARSER;
if (CONFIG_IS_ENABLED(HUSH_2021_PARSER) && !strcmp(parser, "2021"))
	return GD_FLG_HUSH_201_PARSER;

> +	return -1;
> +}
> +
> +static void reset_parser_gd_flags(void)
> +{
> +	gd->flags &=3D ~GD_FLG_HUSH_OLD_PARSER;

gd->flags &=3D ~(GD_FLG_HUSH_OLD_PARSER | GD_FLG_HUSH_2021_PARSER);

If there were only one parser, we wouldn't create this command.

> +}
> +
> +static int do_cli_set(struct cmd_tbl *cmdtp, int flag, int argc,
> +		      char *const argv[])
> +{
> +	char *parser_name;
> +	int parser_flag;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	parser_name =3D argv[1];
> +
> +	parser_flag =3D parser_string_to_gd_flags(parser_name);

This function should return -1 for for any value that is not supported
be it 'foo', 'old', or '2021'. Then you can eliminate a bunch of error
checking code below.

> +	if (parser_flag =3D=3D -1) {
> +		printf("Bad value for parser name: %s\n", parser_name);
> +		return CMD_RET_USAGE;
> +	}
> +
> +	if (parser_flag =3D=3D GD_FLG_HUSH_OLD_PARSER &&
> +		!CONFIG_IS_ENABLED(HUSH_OLD_PARSER)) {
> +		printf("Want to set current parser to old, but its code was not compi=
led!\n");
> +		return CMD_RET_FAILURE;
> +	}

Superfluous check, see above.

> +
> +	if (parser_flag =3D=3D GD_FLG_HUSH_2021_PARSER &&
> +		!CONFIG_IS_ENABLED(HUSH_2021_PARSER)) {
> +		printf("Want to set current parser to 2021, but its code was not comp=
iled!\n");
> +		return CMD_RET_FAILURE;
> +	}

Superfluous check, see above.

> +
> +	reset_parser_gd_flags();
> +	gd->flags |=3D parser_flag;
> +
> +	cli_init();
> +	cli_loop();
> +
> +	/* cli_loop() should never return. */
> +	return CMD_RET_FAILURE;

Consuming stack space for every invocation of the 'cli set' command
cannot be intended.

Why don't we define cli_loop as __noreturn and ensure that it has no
return statement? Then gcc can generate a simple jump without consuming
stack.

cli_loop should() invoke panic() instead of returning.

> +}
> +
> +static struct cmd_tbl parser_sub[] =3D {
> +	U_BOOT_CMD_MKENT(get, 1, 1, do_cli_get, "", ""),
> +	U_BOOT_CMD_MKENT(set, 2, 1, do_cli_set, "", ""),
> +};
> +
> +static int do_cli(struct cmd_tbl *cmdtp, int flag, int argc,
> +		  char *const argv[])
> +{
> +	struct cmd_tbl *cp;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	/* drop initial "parser" arg */
> +	argc--;
> +	argv++;
> +
> +	cp =3D find_cmd_tbl(argv[0], parser_sub, ARRAY_SIZE(parser_sub));
> +	if (cp)
> +		return cp->cmd(cmdtp, flag, argc, argv);
> +
> +	return CMD_RET_USAGE;
> +}
> +
> +#if CONFIG_IS_ENABLED(SYS_LONGHELP)
> +static char cli_help_text[] =3D
> +	"get - print current cli\n"

"get - display parser\n"

> +	"set - set the current cli, possible value is: old"

'cli ' is only printed automatically in the first line.

"cli set - set parser to one of:\n"
#ifdef CONFIG_HUSH_OLD_PARSER
"\t- old\n"
#endif
#ifdef CONFIG_HUSH_2021_PARSER
"\t- 2021\n"
#endif

Why would we need the 'cli set' command at all if there is only one
parser enabled?
Should we better disable the sub-command in that case?

> +	;
> +#endif
> +
> +U_BOOT_CMD(cli, 3, 1, do_cli,
> +	   "cli",
> +#if CONFIG_IS_ENABLED(SYS_LONGHELP)
> +	   cli_help_text
> +#endif

This is wrong. You must pass an empty string at least. Please, follow
the style of the other commands and place the #if in the long text.

> +);
> diff --git a/common/cli.c b/common/cli.c
> index e5fe1060d0..d419671e8c 100644
> --- a/common/cli.c
> +++ b/common/cli.c
> @@ -268,7 +268,8 @@ void cli_loop(void)
>   void cli_init(void)
>   {
>   #ifdef CONFIG_HUSH_PARSER

This Kconfig symbol is superfluous when you already have
CONFIG_HUSH_OLD_PARSER and CONFIG_HUSH_2021_PARSER.

Please, remove CONFIG_HUSH_PARSER from Kconfig.

> -	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER))
> +	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER)

The first part of the if statement is superfluous.
There is no harm in setting the bit again.

> +		&& CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
>   		gd->flags |=3D GD_FLG_HUSH_OLD_PARSER;
>   	u_boot_hush_start();
>   #endif
> diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
> new file mode 100644
> index 0000000000..89ece3203d
> --- /dev/null
> +++ b/doc/usage/cmd/cli.rst
> @@ -0,0 +1,59 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +cli command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopis
> +-------
> +
> +::
> +
> +    cli get
> +    cli set cli_flavor

We should show the available values here:

cli set [old|2021]

> +
> +Description
> +-----------
> +
> +The cli command permits getting and changing the current parser at runt=
ime.

The cli command permits displaying and setting the command line parsers.
Currently two parsers are implemented:

old
    The 'old' parser is what U-Boot provided until v2023.10.

2021
    The '2021' parser provides ....

Please, describe here why the '2021' parser might be preferable. Please,
describe which parser is the default.

> +
> +cli get
> +~~~~~~~
> +
> +It shows the current value of the parser used by the CLI.

The command display the parser used by the command line interface ('old'
or '2021').

> +
> +cli set
> +~~~~~~~
> +
> +It permits setting the value of the parser used by the CLI.

The command sets the parser used by the command line interface.

> +
> +Possible values are old and 2021.
> +Note that, to use a specific parser its code should have been compiled,=
 that
> +is to say you need to enable the corresponding CONFIG_HUSH*.
> +Otherwise, an error message is printed.

Should we use .. note:: here to highlight the information?

> +
> +Examples
> +--------
> +
> +Get the current parser::
> +
> +    =3D> cli get
> +    old
> +
> +Change the current parser::
> +
> +    =3D> cli set old

=3D> cli set 2021

Who would want to set the current value?

> +
> +Trying to set the current parser to an unknown value::
> +
> +    =3D> cli set foo
> +    Bad value for parser name: foo
> +    cli - cli
> +
> +    Usage:
> +    cli get - print current cli
> +    set - set the current cli, possible value is: old

This looks like a bug. I would have expected at least two possible
values. Otherwise we would not need a 'cli' command.

Please, add a 'Configuration' section describing the relevant
configuration variables.

Best regards

Heinrich

> +
> +Return value
> +------------
> +
> +The return value $? indicates whether the command succeeded.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index fa702920fa..90a38c5713 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -42,6 +42,7 @@ Shell commands
>      cmd/cat
>      cmd/cbsysinfo
>      cmd/cedit
> +   cmd/cli
>      cmd/cls
>      cmd/cmp
>      cmd/coninfo

