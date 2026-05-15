Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BB2CD4F46
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6024784713;
	Fri, 15 May 2026 23:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XH20ieT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087738486D; Fri, 15 May 2026 23:58:20 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B69846DE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8b3fecdd3c6so491446d6.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778882297; x=1779487097; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M1EmYSC/nTmcN4KpMXOsAyLZrMz8nMTLkpcfYzONYsI=;
 b=XH20ieT0RCaccl1KEqwMR2Co1MQuXc2ofBKXklh4t18s+aNoFghlkLB1Rer2kpI3A4
 hmNm9AmGMmy8M8XwWXntgSbLj4HVj+vAGzuBC3pbNy6A8LCzyAmypN2/79I22RRjt6gI
 RTJBqfcmKCvt0ZUkVOqcXOdPwbz1Ir3Bby3Cy+0QDwyBg4LBXpM8ft1S2Y0Xp7ArVmm4
 1Pl2s2NQYA8AK3iBLTMNclf+snwI7atlNvSPacQrxq7BpCxK3Gs5UGZOAbdu1jH7HAZo
 IX2d70c3EYdShVghxdtFCEbP7yq3/g5fo5R++Zc9475TLhaocWlpUegTg/ONo7fX1WZJ
 KkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882297; x=1779487097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1EmYSC/nTmcN4KpMXOsAyLZrMz8nMTLkpcfYzONYsI=;
 b=MILvVy4BHENuQsSUq1Dmiiq+Y1PYqgqdMF10W0AgDenLLnwzatAtolZlZ5Sha+Dprx
 38PREbfUt1kHvXILlWcJNNrekWZ1J3ib6Ab5vft36TYHq3bdQDrUvt34J/JUXvFIsyg7
 sY7WNrdIPHZWBd/HiUlLLLtaX8tNkwWG/WSXhCwal/kATZa0If76WlqttLetjr3ys67w
 gbWj3VtBzAMekrKZvJmyZ3t+E7C8tB3iIVwDZbGlpaIaMLyHU9M0cMPSg7nRbmzY1wW/
 B/ZjUgjT3zEz08GQ6q9elWyu1u6Te13/pDz1VUETpF6LYbI11pLYJZECAWkDlmlYxH7k
 R1pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pg5PZJLx9R/1GQ3iLOq4/qp6gvH7dhUpi2To4I7LWwdGHFgIBcDi6aUWMPW/pPtyp25EgBlM=@lists.denx.de
X-Gm-Message-State: AOJu0YwBrSnLT2Bn0gtcoWKlEorD96z/PMqRi5dXUJQE2OnigRI/3BoW
 97ko5mOSnL+oKT9mbORB6n6qNOY8m4CFGDSLs5GQy8pLPtiQmgRo7TEADL/Thg==
X-Gm-Gg: Acq92OEXbChpYnd2ELUeJby9gjptJiX+kOdbQHSsOahvovuMhQCqjV4pBHoJxBbWDb+
 u4ZGbn6oBmyg0qe/jaa5iiacyCRMHu/BbXRbFsIuS1dxyj8sWl0CEDjZCn/81gCSikVwflMEnZB
 hsIgflAUL7YK5gQF35oUFpvWy+gdrSOkL5Y8ERoxPuxtKG2NOrhJTISxm+VcNcGDt6mb3w0FkWg
 3p6YTTSDLRfV7KKp4mqudNELL+7lCLpRQT/f8LFFGmLOs7EMlmI1iEdB459zKIh/kryHlZvA3BO
 x1AfT0PHZzPAv4VYklP8NO8mG/yH97hRHD3dGmXwxFOjUiIu6aNo0oUL9NvOGgdfkgsce6Xy6tK
 FWikIkD8TpmJFYVJmPw5g/GvaOb2LHHNQLTE+ZlVuXVGliVafXd/vx4lqHbiXH2kv40/LT7/Hlz
 zgu2sR9yN0bm5Rkc2JHXt3d6a89sZDOPK8mJe4ZcTCP+gYvBy85v5OWd7di1wHVBarH20=
X-Received: by 2002:a05:6214:f2d:b0:8ae:65b7:1b0a with SMTP id
 6a1803df08f44-8ca0f601a73mr73530316d6.2.1778882296526; 
 Fri, 15 May 2026 14:58:16 -0700 (PDT)
Received: from ?IPV6:2600:4040:4477:d400:2d8:61ff:fe7c:5d59?
 ([2600:4040:4477:d400:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90874e490sm65706246d6.1.2026.05.15.14.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 14:58:15 -0700 (PDT)
Message-ID: <23a059c1-e3ea-4351-bdfb-fba4462539ad@gmail.com>
Date: Fri, 15 May 2026 17:58:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 07/11] cmd: echo: Use getopt() with '+' prefix for
 option parsing
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515203311.2555651-8-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260515203311.2555651-8-sjg@chromium.org>
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
> The 'echo' command's option parser is a single strcmp against argv[1]
> that decides whether to suppress the trailing newline. Convert it to
> getopt() so echo follows the same shape as the other commands in this
> series and exercises the '+' prefix that POSIX-style 'stop at first
> non-option' callers need.
> 
> The optstring uses the '+' prefix to preserve bash echo behaviour: -n is
> honoured only as the very first argument, so 'echo hello -n' still
> prints 'hello -n\n' verbatim.
> 
> Two minor differences from the bash builtin remain, both of which
> the user can work around with quoting or --:
> 
> * -x (an unknown short option) returns CMD_RET_USAGE rather than
>    printing literally; use 'echo -- -x' to print it.
> * -nfoo (joined form) parses -n and then errors on the trailing
>    characters.

Why? This introduces incompatibility with echo as it exists today as
well as unix-style echo. We can have an (almost) completely-compatible
echo with

	getopt_init_state(&gs, argc, argv);
	while (getopt_silent(&gs, "+n") == 'n')
		newline = false;

	for (i = gs.index; i < argc; ++i) {
		<snip>

The only difference is that something like "echo -na" will result in
"-na" and not "-na\n". IMO echo is not a good candidate for getopt
due to its unusual argument handling. Even coreutils echo does not
use getopt. So I think we should really leave echo as-is.

> Add three test cases that pin down the new behaviour: trailing -n stays
> literal, -- ends option parsing, and -- is consumed even after a
> recognised flag. The positional loop uses getopt_pop() as an iterator.
> CMD_ECHO selects GETOPT so the parser is linked in on boards that don't
> already enable it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   cmd/Kconfig          |  1 +
>   cmd/echo.c           | 23 ++++++++++++++---------
>   test/cmd/test_echo.c | 10 ++++++++++
>   3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a19..709696c3c41 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1916,6 +1916,7 @@ config CMD_CAT
>   config CMD_ECHO
>   	bool "echo"
>   	default y
> +	select GETOPT
>   	help
>   	  Echo args to console
>   
> diff --git a/cmd/echo.c b/cmd/echo.c
> index d1346504cfb..63422c75cc6 100644
> --- a/cmd/echo.c
> +++ b/cmd/echo.c
> @@ -5,27 +5,32 @@
>    */
>   
>   #include <command.h>
> -#include <linux/string.h>
> +#include <getopt.h>
>   
>   static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
>   		   char *const argv[])
>   {
> -	int i = 1;
> +	struct getopt_state gs;
>   	bool space = false;
>   	bool newline = true;
> +	char *arg;
> +	int opt;
>   
> -	if (argc > 1) {
> -		if (!strcmp(argv[1], "-n")) {
> +	getopt_init_state(&gs, argc, argv);
> +	while ((opt = getopt(&gs, "+n")) > 0) {
> +		switch (opt) {
> +		case 'n':
>   			newline = false;
> -			++i;
> +			break;
> +		default:
> +			return CMD_RET_USAGE;
>   		}
>   	}
>   
> -	for (; i < argc; ++i) {
> -		if (space) {
> +	while ((arg = getopt_pop(&gs))) {
> +		if (space)
>   			putc(' ');
> -		}
> -		puts(argv[i]);
> +		puts(arg);
>   		space = true;
>   	}
>   
> diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
> index 7ed534742f7..5fc139fbe68 100644
> --- a/test/cmd/test_echo.c
> +++ b/test/cmd/test_echo.c
> @@ -35,6 +35,16 @@ static struct test_data echo_data[] = {
>   	/* Test handling of shell variables. */
>   	{"setenv jQx; for jQx in 1 2 3; do echo -n \"${jQx}, \"; done; echo;",
>   	 "1, 2, 3, "},
> +	/* -n only suppresses the newline when it comes before any
> +	 * positional argument; a trailing -n is just another argument.
> +	 */
> +	{"echo hello -n", "hello -n"},
> +	/* "--" ends option parsing, so a following dash-prefixed token
> +	 * is printed verbatim instead of being rejected.
> +	 */
> +	{"echo -- -x", "-x"},
> +	/* "--" is consumed even when it follows a recognised flag. */
> +	{"echo -n -- foo; echo done", "foodone"},
>   };
>   
>   static int lib_test_hush_echo(struct unit_test_state *uts)

