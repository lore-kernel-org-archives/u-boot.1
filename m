Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943ADCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2808485A;
	Fri, 15 May 2026 23:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZf5C/II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BA484862; Fri, 15 May 2026 23:37:46 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B9084812
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8b3fecdd3c6so462586d6.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778881063; x=1779485863; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWVwSDYLraTEF2Uq8qrbKpN2H7/wX19l9mwKCZM/aAc=;
 b=CZf5C/IIx1+vnPtqwT59vPBluFiupinH48z7tAKR4HkLbHBE763tAhvhHxgyM3DZvL
 LPc4/QOFWh64sX7qFyO7m55YLRASbW9goJZsVtlQ++K2GGSpGUVmPwz+/0D4gpjkXqfp
 PBN4BrS2q4DGPe9uXztEqFPtXkp1+EvTlJSIV4G5fi3mKBCdt425B5Yfa42CdINKdrES
 ApHhCVsVbH8AIa1HFBrF4QFpfK/GxxFb39tGYwU2neM8ONURIpy9K5o0CO4W8O857yT0
 nz9FwqUgkRI9UqrB/DjoZafwfRXINDxPykkEsTFso9ETCF261DYoMmTjmfLP+i7n4bI0
 ImVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778881063; x=1779485863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kWVwSDYLraTEF2Uq8qrbKpN2H7/wX19l9mwKCZM/aAc=;
 b=lxni+L5u53nj12DwFjuK/omPwlqUebsoaFBRD0E4HR1aTNOJKHuSmWVCl65ZoNYIhi
 296M8lCcjqyUopKrT1iNOVYzHFRJm92TAGwRcpvKpwS8pei4C1dqpp7IbTQh7t56HHFE
 fUiQMGsjOsc6FF9aXrrJdnUQSEQipqtVTOKEpXcQU8lI6Jimy95QfnYBgSCzGahqwzIn
 QZhQmB9g7TS4fJu2zvX/pj6Pcc3CZ3PIkyCyh/LcbnmGf8Pqo0JxKZGE8BjZcREN5P12
 BwEjsaNQEDzMyrAMFKPThPPObA9uexVzUeKKuqMqOgDQmam35eYu21UBmvBjhYMWYvDM
 phdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nti5o0HehNB8vyzaQqkWDHmoeP+/U4YjRIZuAq4oWL/gQKzozPokXpLoO6qGhMQU/MRhpIkA=@lists.denx.de
X-Gm-Message-State: AOJu0YwViffSA6YajvPyeVrfVWWAafisA9gmrqZprATjDBUnChzkSt8m
 En52FfqSXUMBmpx8ciEHHHydAuIPgFkyMoeJyiwejP4S3kDYgEj+n0yx
X-Gm-Gg: Acq92OGqy6bRRsuTIhfLpypfXu80wCIJj6NS9+VgbgBqF4/jI2OLlIdQLEbgM+4wZuW
 GiP9iB26h6vVrxl0DWgwkgYe+CdbtNw6DLX8Y64Qkfg/Cgk4zp/v+F8usVF340zX2n0usuC2Tpx
 8voOi1nDv+sVx0otcE1Lci4AsUVfctlbHp8EJyxwLN60OYwv/Z81/sIYwkfoMx2PRrGmF78EOYg
 9YVYVwEdQmL3M4uweAIwrxJ60bK1LwjdlQcXAKmfwIA9Wi19ZKtBKz94LVRvxSDoLgjWRMmIlUf
 PauQ5RSp34g70YYA3BhFMVBSpLmisH7TgMJri8OBJ27auQv5dRfEwSlKOxfTzbPaK4JnVYr98iy
 lRj0lHCV5Pv4b7y/71eozpiY4rlHT6zECf6qJQrich0DW2AzRlz4xMNMxrHpjO6fQkKHBCY5qZv
 GlsxQJLPxnc4cwcSFKB0gQ7Hb/INFu7Hu7Q1hsKkc9K3LjVx2RRkVmIrfUCSXYNLVsLfY=
X-Received: by 2002:ad4:5aa7:0:b0:8b3:edb3:e608 with SMTP id
 6a1803df08f44-8ca0f6e0f60mr74103226d6.7.1778881062455; 
 Fri, 15 May 2026 14:37:42 -0700 (PDT)
Received: from ?IPV6:2600:4040:4477:d400:2d8:61ff:fe7c:5d59?
 ([2600:4040:4477:d400:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90b2dc4besm63040516d6.32.2026.05.15.14.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 14:37:41 -0700 (PDT)
Message-ID: <8b0ef7a8-5c7e-5fdf-0db7-bb7a63d1b756@gmail.com>
Date: Fri, 15 May 2026 17:37:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 05/11] lib: getopt: Permute by default with inline
 reorder
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515203311.2555651-6-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260515203311.2555651-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/15/26 16:32, Simon Glass wrote:
> Currently getopt() does not reorder its argv: it stops at the first
> non-option, which forces options to appear before positional arguments.
> This is not the usual way that arguments work - people expect options to
> be recognised wherever they appear on the command line, although some
> U-Boot commands are hard-wires for particular positions.
> 
> Restructure the parser to permute by default. Add argc and a writable
> args[CONFIG_SYS_MAXARGS + 1] buffer to struct getopt_state, plus a
> nonopts counter. The init function getopt_init_state() takes argc and
> argv, copies argv into args, and resets the parse position. Then
> getopt() and getopt_silent() take only the state and an optstring; argc
> and argv are read from the state.
> 
> When getopt() encounters a non-option, it bubbles that argv element to
> the end of args and increments nonopts, then keeps scanning. The outer
> condition stops when index + nonopts reaches argc, so the parked
> non-options are never re-scanned. After parsing finishes, gs.index
> points at the first parked non-option, with gs.nonopts of them sitting
> at gs.args[gs.index .. argc - 1]
> 
> Callers that need the previous POSIX-style 'stop at first non-option'
> behaviour can prefix optstring with '+'. This matches GNU getopt's
> convention and keeps to two public entry points (getopt() and
> getopt_silent()) instead of doubling them up for in-order variants.
> 
> Update the two existing in-tree callers, cmd/bdinfo.c and cmd/log.c, to
> the new signatures. bdinfo has no positional arguments so it works the
> same either way; log filter-list/add/remove preserve their original
> semantics with the '+' prefix. Update test helper in test/lib/getopt.c
> too.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   cmd/bdinfo.c      |   4 +-
>   cmd/log.c         |  12 ++--
>   include/getopt.h  | 146 +++++++++++++++++++++++-----------------------
>   lib/getopt.c      |  67 ++++++++++++++++-----
>   test/lib/getopt.c |   6 +-
>   5 files changed, 135 insertions(+), 100 deletions(-)
> 
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index ddf77303735..c46094c3ddf 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -188,8 +188,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	if (!CONFIG_IS_ENABLED(GETOPT) || argc == 1)
>   		return bdinfo_print_all(bd);
>   
> -	getopt_init_state(&gs);
> -	while ((opt = getopt(&gs, argc, argv, "aem")) > 0) {
> +	getopt_init_state(&gs, argc, argv);
> +	while ((opt = getopt(&gs, "aem")) > 0) {
>   		switch (opt) {
>   		case 'a':
>   			return bdinfo_print_all(bd);
> diff --git a/cmd/log.c b/cmd/log.c
> index 64add6d8b5a..344f379d8cc 100644
> --- a/cmd/log.c
> +++ b/cmd/log.c
> @@ -95,8 +95,8 @@ static int do_log_filter_list(struct cmd_tbl *cmdtp, int flag, int argc,
>   	struct log_filter *filt;
>   	struct log_device *ldev;
>   
> -	getopt_init_state(&gs);
> -	while ((opt = getopt(&gs, argc, argv, "d:")) > 0) {
> +	getopt_init_state(&gs, argc, argv);
> +	while ((opt = getopt(&gs, "+d:")) > 0) {
>   		switch (opt) {
>   		case 'd':
>   			drv_name = gs.arg;
> @@ -157,8 +157,8 @@ static int do_log_filter_add(struct cmd_tbl *cmdtp, int flag, int argc,
>   	enum log_level_t level = LOGL_MAX;
>   	struct getopt_state gs;
>   
> -	getopt_init_state(&gs);
> -	while ((opt = getopt(&gs, argc, argv, "Ac:d:Df:F:l:L:p")) > 0) {
> +	getopt_init_state(&gs, argc, argv);
> +	while ((opt = getopt(&gs, "+Ac:d:Df:F:l:L:p")) > 0) {
>   		switch (opt) {
>   		case 'A':
>   #define do_type() do { \
> @@ -250,8 +250,8 @@ static int do_log_filter_remove(struct cmd_tbl *cmdtp, int flag, int argc,
>   	const char *drv_name = "console";
>   	struct getopt_state gs;
>   
> -	getopt_init_state(&gs);
> -	while ((opt = getopt(&gs, argc, argv, "ad:")) > 0) {
> +	getopt_init_state(&gs, argc, argv);
> +	while ((opt = getopt(&gs, "+ad:")) > 0) {
>   		switch (opt) {
>   		case 'a':
>   			all = true;
> diff --git a/include/getopt.h b/include/getopt.h
> index 0cf7ee84d6f..5a9e7802e65 100644
> --- a/include/getopt.h
> +++ b/include/getopt.h
> @@ -10,120 +10,120 @@
>   #define __GETOPT_H
>   
>   #include <stdbool.h>
> +#include <linux/kconfig.h>
>   
>   /**
>    * struct getopt_state - Saved state across getopt() calls
> + *
> + * Initialise with getopt_init_state(); the embedded @args buffer holds a
> + * working copy of the argv passed to that initialiser.
>    */
>   struct getopt_state {
> +	/** @argc: Argument count, as passed to getopt_init_state() */
> +	int argc;
> +	/**
> +	 * @args: Working copy of argv. getopt() reorders this in place: as
> +	 * options are consumed, non-options are bubbled to the end.

Please use terminology from getopt(3) wherever possible. So "permute" instead
of "bubble" or "park".

non-options are permuted to the end.

> +	 */
> +	char *args[CONFIG_SYS_MAXARGS + 1];

This should come first to eliminate padding. And should probably be named argv for consistency.

>   	/**
> -	 * @index: Index of the next unparsed argument of @argv. If getopt() has
> -	 * parsed all of @argv, then @index will equal @argc.
> +	 * @index: Index of the next unparsed argument of @args. When
> +	 * parsing has finished, @index sits at the first parked
> +	 * non-option (or @argc if none).

Index of the next unparsed argument of @argv. If getopt() has parsed all of @argv,
then @index will be the first non-option argument of @args (or @argc if none).

>   	 */
>   	int index;
> -	/** @arg_index: Index within the current argument */
> +	/**
> +	 * @arg_index: Offset of the next unparsed character within
> +	 * ``args[index]``. Lets the parser step through grouped short
> +	 * options like ``-abc`` (1, 2, 3...). Reset to 1 each time
> +	 * @index advances to the next argv slot.

to the next argument.

> +	 */
>   	int arg_index;
> +	/**
> +	 * @nonopts: Number of non-option arguments parked at the tail> +	 * of @args. The parser bubbles them down so it can keep scanning
> +	 * for options past them.

Number of non-option arguments in @args.

> +	 */
> +	int nonopts;

Could we just modify argc instead? E.g. once we move a non-option to the end, then we
decrement argc. I think this also fixes the problem discussed below.

>   	union {
>   		/**
> -		 * @opt: Option being parsed when an error occurs. @opt is only
> -		 * valid when getopt() returns ``?`` or ``:``.
> +		 * @opt: Option being parsed when an error occurs. @opt is
> +		 * only valid when getopt() returns ``?`` or ``:``.
>   		 */
>   		int opt;
>   		/**
> -		 * @arg: The argument to an option, NULL if there is none. @arg
> -		 * is only valid when getopt() returns an option character.
> +		 * @arg: The argument to an option, NULL if there is none.
> +		 * @arg is only valid when getopt() returns an option
> +		 * character.
>   		 */
>   		char *arg;
>   	};
>   };
>   
>   /**
> - * getopt_init_state() - Initialize a &struct getopt_state
> - * @gs: The state to initialize
> - *
> - * This must be called before using @gs with getopt().
> + * getopt_init_state() - Initialise a &struct getopt_state from an argv
> + * @gs: The state to initialise
> + * @argc: Argument count
> + * @argv: Source argv. Copied into @gs->args; the original is not
> + *        modified. @argc must not exceed ``CONFIG_SYS_MAXARGS``;
> + *        excess arguments are silently dropped.
>    */
> -void getopt_init_state(struct getopt_state *gs);
> +void getopt_init_state(struct getopt_state *gs, int argc,
> +		       char *const argv[]);
>   
> -int __getopt(struct getopt_state *gs, int argc, char *const argv[],
> -	     const char *optstring, bool silent);
> +int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
>   
>   /**
>    * getopt() - Parse short command-line options
> - * @gs: Internal state and out-of-band return arguments. This must be
> - *      initialized with getopt_init_context() beforehand.
> - * @argc: Number of arguments, not including the %NULL terminator
> - * @argv: Argument list, terminated by %NULL
> - * @optstring: Option specification, as described below
> - *
> - * getopt() parses short options. Short options are single characters. They may
> - * be followed by a required argument or an optional argument. Arguments to
> - * options may occur in the same argument as an option (like ``-larg``), or
> - * in the following argument (like ``-l arg``). An argument containing
> - * options begins with a ``-``. If an option expects no arguments, then it may
> - * be immediately followed by another option (like ``ls -alR``).
> - *
> - * @optstring is a list of accepted options. If an option is followed by ``:``
> - * in @optstring, then it expects a mandatory argument. If an option is followed
> - * by ``::`` in @optstring, it expects an optional argument. @gs.arg points
> - * to the argument, if one is parsed.
> - *
> - * getopt() stops parsing options when it encounters the first non-option
> - * argument, when it encounters the argument ``--``, or when it runs out of
> - * arguments. For example, in ``ls -l foo -R``, option parsing will stop when
> - * getopt() encounters ``foo``, if ``l`` does not expect an argument. However,
> - * the whole list of arguments would be parsed if ``l`` expects an argument.
> + * @gs: State, initialised with getopt_init_state()
> + * @optstring: Option specification (see getopt(3))

Please retain the original description. We are not 100% compatible
with getopt, and I think explicit examples are a good way to document what we
support as well as the new API, which doesn't quite match libc getopt.

>    *
> - * An example invocation of getopt() might look like::
> + * Parses the next short option from @gs. By default, getopt() permutes

Parse

> + * the working argv: when it hits a non-option, it bubbles that argv

bubbles -> moves

> + * element to the end and keeps scanning, so options can appear
> + * anywhere on the command line. After parsing finishes (returns -1),
> + * @gs.index sits at the first parked non-option, and there are
> + * @gs.nonopts of them at @gs.args[gs.index..argc-1].
>    *
> - *     char *argv[] = { "program", "-cbx", "-a", "foo", "bar", 0 };
> - *     int opt, argc = ARRAY_SIZE(argv) - 1;
> - *     struct getopt_state gs;
> + * If @optstring begins with ``+``, getopt() instead stops at the
> + * first non-option (POSIX ``getopt`` behaviour). Use this when the
> + * command's grammar requires options before positionals, or when the
> + * option string includes optional arguments (``::``) whose adjacency
> + * to a following positional would be ambiguous under permutation.

when the command requires options before non-options, or when options
with optional arguments would be ambiguous under permutation.

>    *
> - *     getopt_init_state(&gs);
> - *     while ((opt = getopt(&gs, argc, argv, "a::b:c")) != -1)
> - *         printf("opt = %c, index = %d, arg = \"%s\"\n", opt, gs.index, gs.arg);
> - *     printf("%d argument(s) left\n", argc - gs.index);
> + * In @optstring proper, ``x`` is a flag, ``x:`` requires an argument,
> + * and ``x::`` takes an optional argument. The argument is delivered
> + * in @gs.arg.
>   *
> - * and would produce an output of::
> - *
> - *     opt = c, index = 1, arg = "<NULL>"
> - *     opt = b, index = 2, arg = "x"
> - *     opt = a, index = 4, arg = "foo"
> - *     1 argument(s) left
> - *
> - * For further information, refer to the getopt(3) man page.
> + * A literal ``--`` argument terminates option scanning; the parser
> + * advances past it and returns -1.
>    *
>    * Return:
> - * * An option character if an option is found. @gs.arg is set to the
> - *   argument if there is one, otherwise it is set to ``NULL``.
> - * * ``-1`` if there are no more options, if a non-option argument is
> - *   encountered, or if an ``--`` argument is encountered.
> - * * ``'?'`` if we encounter an option not in @optstring. @gs.opt is set to
> - *   the unknown option.
> - * * ``':'`` if an argument is required, but no argument follows the
> - *   option. @gs.opt is set to the option missing its argument.
> - *
> - * @gs.index is always set to the index of the next unparsed argument in @argv.
> + * * An option character if an option is found. @gs.arg is set to
> + *   the argument if there is one, otherwise NULL.
> + * * ``-1`` if there are no more options.
> + * * ``'?'`` for an option not in @optstring; @gs.opt is the unknown
> + *   option character.
> + * * ``':'`` for an option missing its required argument; @gs.opt is
> + *   the option character.
>    */
> -static inline int getopt(struct getopt_state *gs, int argc,
> -			 char *const argv[], const char *optstring)
> +static inline int getopt(struct getopt_state *gs, const char *optstring)
>   {
> -	return __getopt(gs, argc, argv, optstring, false);
> +	return __getopt(gs, optstring, false);
>   }
>   
>   /**
> - * getopt_silent() - Parse short command-line options silently
> + * getopt_silent() - Parse short command-line options without errors
>    * @gs: State
> - * @argc: Argument count
> - * @argv: Argument list
>    * @optstring: Option specification
>    *
> - * Same as getopt(), except no error messages are printed.
> + * Same as getopt() but does not print error messages for unknown
> + * options or missing arguments.
>    */
> -static inline int getopt_silent(struct getopt_state *gs, int argc,
> -				char *const argv[], const char *optstring)
> +static inline int getopt_silent(struct getopt_state *gs,
> +				const char *optstring)
>   {
> -	return __getopt(gs, argc, argv, optstring, true);
> +	return __getopt(gs, optstring, true);
>   }
>   
>   #endif /* __GETOPT_H */
> diff --git a/lib/getopt.c b/lib/getopt.c
> index e9175e2fff4..70adb2d0faf 100644
> --- a/lib/getopt.c
> +++ b/lib/getopt.c
> @@ -10,37 +10,71 @@
>   
>   #include <getopt.h>
>   #include <log.h>
> +#include <linux/kernel.h>
>   #include <linux/string.h>
>   
> -void getopt_init_state(struct getopt_state *gs)
> +void getopt_init_state(struct getopt_state *gs, int argc, char *const argv[])
>   {
> +	int max = ARRAY_SIZE(gs->args) - 1;
> +
> +	if (argc > max)
> +		argc = max;
> +
> +	gs->argc = argc;
> +	memcpy(gs->args, argv, (argc + 1) * sizeof(*gs->args));
> +	gs->args[argc] = NULL;
>   	gs->index = 1;
>   	gs->arg_index = 1;
> +	gs->nonopts = 0;
>   }
>   
> -int __getopt(struct getopt_state *gs, int argc, char *const argv[],
> -	     const char *optstring, bool silent)
> +int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
>   {
> -	char curopt;   /* current option character */
> -	const char *curoptp; /* pointer to the current option in optstring */
> +	char curopt;	/* current option character */
> +	const char *curoptp;	/* pointer to the current option in optstring */
> +	bool stop_nonopt = false;
> +	char **argv = gs->args;
> +	int argc = gs->argc;
> +
> +	if (*optstring == '+') {
> +		stop_nonopt = true;
> +		optstring++;
> +	}
>   
>   	while (1) {
> -		log_debug("arg_index: %d index: %d\n", gs->arg_index,
> -			  gs->index);
> +		log_debug("arg_index: %d index: %d nonopts: %d\n",
> +			  gs->arg_index, gs->index, gs->nonopts);
>   
>   		/* `--` indicates the end of options */
> -		if (gs->arg_index == 1 && argv[gs->index] &&
> +		if (gs->arg_index == 1 && gs->index < argc &&
>   		    !strcmp(argv[gs->index], "--")) {
>   			gs->index++;
>   			return -1;
>   		}
>   
> -		/* Out of arguments */
> -		if (gs->index >= argc)
> -			return -1;
> +		/*
> +		 * Bubble non-options to the end so we can keep scanning for
> +		 * options past them. In '+' mode (POSIX), stop at the first
> +		 * non-option instead.
> +		 */
> +		while (gs->arg_index == 1 &&
> +		       gs->index + gs->nonopts < argc &&
> +		       *argv[gs->index] != '-') {
> +			char *tmp;
> +			int i;
> +
> +			if (stop_nonopt)
> +				return -1;
> +
> +			tmp = argv[gs->index];
> +			gs->nonopts++;
> +			for (i = gs->index; i + 1 < argc; i++)
> +				argv[i] = argv[i + 1];
> +			argv[argc - 1] = tmp;
> +		}
>   
> -		/* Can't parse non-options */
> -		if (*argv[gs->index] != '-')
> +		/* Out of options to scan */
> +		if (gs->index + gs->nonopts >= argc)
>   			return -1;
>   
>   		/* We have found an option */
> @@ -48,7 +82,8 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
>   		if (curopt)
>   			break;
>   		/*
> -		 * no more options in current argv[] element; try the next one
> +		 * No more options in current argv[] element; advance to the
> +		 * next one
>   		 */
>   		gs->index++;
>   		gs->arg_index = 1;
> @@ -80,7 +115,7 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
>   			gs->arg_index = 1;
>   			return curopt;
>   		}

Is the above condition (not included in the diff) correct for something like

getopt({ "prog", "foo", "-a" }, 3, "a:")

? That is, getopt should return ':' and not 'a' in this situation, but I'm not sure we're
tracking the non-options correctly.

> -		if (gs->index + 1 == argc) {
> +		if (gs->index + gs->nonopts + 1 == argc) {
>   			/* We are at the last argv[] element */
>   			gs->arg = NULL;
>   			gs->index++;
> @@ -113,7 +148,7 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
>   	gs->index++;
>   	gs->arg_index = 1;
>   
> -	if (gs->index >= argc || argv[gs->index][0] == '-') {
> +	if (gs->index + gs->nonopts >= argc || argv[gs->index][0] == '-') {
>   		if (!silent)
>   			printf("option requires an argument -- %c\n", curopt);
>   		gs->opt = curopt;
> diff --git a/test/lib/getopt.c b/test/lib/getopt.c
> index 388a076200b..6b384eb016a 100644
> --- a/test/lib/getopt.c
> +++ b/test/lib/getopt.c
> @@ -18,9 +18,9 @@ static int do_test_getopt(struct unit_test_state *uts, int line,
>   {
>   	int opt;
>   
> -	getopt_init_state(gs);
> +	getopt_init_state(gs, args, argv);
>   	for (int i = 0; i < expected_count; i++) {
> -		opt = getopt_silent(gs, args, argv, optstring);
> +		opt = getopt_silent(gs, optstring);
>   		if (expected[i] != opt) {
>   			/*
>   			 * Fudge the line number so we can tell which test
> @@ -34,7 +34,7 @@ static int do_test_getopt(struct unit_test_state *uts, int line,
>   		}
>   	}
>   
> -	opt = getopt_silent(gs, args, argv, optstring);
> +	opt = getopt_silent(gs, optstring);
>   	if (opt != -1) {
>   		ut_failf(uts, __FILE__, line, __func__,
>   			 "getopt() != -1",

Please add a few tests for reordered arguments, especially the scenario described above.
