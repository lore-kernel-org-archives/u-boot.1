Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A161C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 19:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A26880FD;
	Thu, 29 Feb 2024 20:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RSywiZal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390F388100; Thu, 29 Feb 2024 20:45:05 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA6B87D25
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 20:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d311081954so9878571fa.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709235902; x=1709840702; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YN8Hug1uAEXASHoLYjK6XrfNAIhupqu52qRQjZVf+A0=;
 b=RSywiZal0c/L5Hs+r/CvCcmyd0EMDqZ5w9iiD5nGkOaDNJvWh26jqimuD6f3hrOphO
 e0Sj6IejBzshh2CtcXLDkIKSAWVVkcPe7f8nIIOFAROCFLcVg1uMxd6kBykzt2tr8MCZ
 TJTlp4U2SWA0+Bt2PFNQYa0+fZBi4BgcaoWn6tohDFJKFQ6AKfGBOAcak3TzhV6kTVnQ
 L8No/vbZ03K83htBAwurqQSG+pgaNSk7CyTqTPPaAlzpVekoKrKU2rJO15gxfb9ii2YD
 hU2tLmqloIkrsMUtc2mOae2XnUv5fUwsXef16tGAiLLnf7J3EWGr/5D6yC3w7UTeX0ru
 THHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709235902; x=1709840702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YN8Hug1uAEXASHoLYjK6XrfNAIhupqu52qRQjZVf+A0=;
 b=dKrB6HdFcvVaDXwoPLPKw1r1PUpskqkWygk4XazOjWEzdGChKppzsLcsmQDKr4gB7v
 ruL9BDt4fEXTBgRIwE3R1zk8gR5/YVEubXBHx/6yRID5qBfeeF+jxTpBx5kTJlZ6eRfd
 fco9OvztlIIBNUYMhOr7nFcRjr/Kq47ahC3nocOeQI2EhngOS/EvRl6aUYyXgkc1X8gW
 5j+W/QOyGgLkKNAEm8iGLmycmMV6BGDjz8pg3ZC1nxtcpK4EUq0IW+jlBlmFkm4BSKed
 77lReEaDq/IdL44uLXWnnIk8Yx5q5kIX5Tuqskr+Y3SiypuPg9TaUL5ENw4LAjm4ks8I
 Acjw==
X-Gm-Message-State: AOJu0YyYt5lhMoz5DZ72wnIHm6FJVGzJDhiocVQTrubbFTt3s4fDogtn
 uPSyQ4AZ3U6S+DxMTYgnoB0qGiVa31vP4omu4nBwOifalMAH5V4KSd5m4L5e
X-Google-Smtp-Source: AGHT+IEI4rYsKwG5NQzkWgrfFtwUcITqkls9PSeREqOdC4AhQtfHyHasKQv8w5beJ8XZAMMv5si7oA==
X-Received: by 2002:a05:651c:a0a:b0:2d2:e784:abc2 with SMTP id
 k10-20020a05651c0a0a00b002d2e784abc2mr2850251ljq.33.1709235901905; 
 Thu, 29 Feb 2024 11:45:01 -0800 (PST)
Received: from [192.168.1.6] (109-252-11-244.nat.spd-mgts.ru. [109.252.11.244])
 by smtp.gmail.com with ESMTPSA id
 u34-20020a05651c142200b002d316a6c6eesm164674lje.136.2024.02.29.11.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 11:45:01 -0800 (PST)
Message-ID: <82befd1b-4eb9-41ce-bbc3-ba9334306843@gmail.com>
Date: Thu, 29 Feb 2024 22:44:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: add FDT setup for bootelf by flag
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
References: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: "Maxim M. Moskalets" <maximmosk4@gmail.com>
In-Reply-To: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
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

Hello Tom,

On 26.02.2024 21:35, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
>
> Added the ability to use FDT for ELF applications, required to run some
> OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option for
> bootelf command.
>
> Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   cmd/elf.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/cmd/elf.c b/cmd/elf.c
> index b7b9f506a5..2fa28448c0 100644
> --- a/cmd/elf.c
> +++ b/cmd/elf.c
> @@ -38,6 +38,8 @@ static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
>   /* Interpreter command to boot an arbitrary ELF image from memory */
>   int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
> +	struct bootm_headers img = {0};
> +	unsigned long fdt_addr = 0; /* Address of the FDT */
>   	unsigned long addr; /* Address of the ELF image */
>   	unsigned long rc; /* Return value from user code */
>   	char *sload = NULL;
> @@ -46,13 +48,23 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	/* Consume 'bootelf' */
>   	argc--; argv++;
>
> -	/* Check for flag. */
> +	/* Check for [-p|-s] flag. */
>   	if (argc >= 1 && (argv[0][0] == '-' && \
>   				(argv[0][1] == 'p' || argv[0][1] == 's'))) {
>   		sload = argv[0];
>   		/* Consume flag. */
>   		argc--; argv++;
>   	}
> +
> +	/* Check for [-d fdt_addr_r] option. */
> +	if ((argc >= 2) && (argv[0][0] == '-') && (argv[0][1] == 'd')) {
> +		if (strict_strtoul(argv[1], 16, &fdt_addr) != 0)
> +			return CMD_RET_USAGE;
> +		/* Consume option. */
> +		argc -= 2;
> +		argv += 2;
> +	}
> +
>   	/* Check for address. */
>   	if (argc >= 1 && strict_strtoul(argv[0], 16, &addr) != -EINVAL) {
>   		/* Consume address */
> @@ -68,6 +80,14 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	else
>   		addr = load_elf_image_shdr(addr);
>   
> +	if (fdt_addr) {
> +		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
> +		flush();
> +
> +		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
> +			return 1;
> +	}
> +
>   	if (!env_get_autostart())
>   		return rcode;
>   
> @@ -298,9 +318,10 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   U_BOOT_CMD(
>   	bootelf, CONFIG_SYS_MAXARGS, 0, do_bootelf,
>   	"Boot from an ELF image in memory",
> -	"[-p|-s] [address]\n"
> +	"[-p|-s] [-d fdt_addr_r] [address]\n"
>   	"\t- load ELF image at [address] via program headers (-p)\n"
> -	"\t  or via section headers (-s)"
> +	"\t  or via section headers (-s)\n"
> +	"\t- setup FDT image at [fdt_addr_r] (-d)"
>   );
>   
>   U_BOOT_CMD(
Is it ok to merge?
