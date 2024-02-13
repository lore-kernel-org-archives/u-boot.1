Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F7C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 06:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BAD87CD2;
	Tue, 13 Feb 2024 07:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KNoDxhOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D6B87CDC; Tue, 13 Feb 2024 07:49:56 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38F187CAC
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 07:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso5390179a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707806985; x=1708411785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IhKSNldJyieiE9joWbSWRqVyUv1lWXnfL2o/5UGSPfc=;
 b=KNoDxhOPKAWyAex/4J1fgrhx0xvRq2e9nUKqGO8ot9PH67z23DQTOY0AdFmicR0izi
 qSKaIRXu6ah55VjwW/E2r47QsA8qfcugMeYOgzuOqZGoYz2WvSIQbQPo3XNqdzBulE7z
 RNx5efvZYTAGtawSZ5B52wU8QeJfzhaHKH1WPI8nIbovZ/0i9cZ5Zzx5nGhW429DfdFH
 jMyZANEa+2chHvKGboxPIsn345/Nz61UW6VjD1kdz9l/hBboTGBE9zsYtEz0ZCWvxenN
 hoKstxv0GG1iinFO5RzXF00y66hVJlnb1kkYSEGrtNVSVM6MNFBzMyRUz4a1MIMb64NE
 trtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707806985; x=1708411785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhKSNldJyieiE9joWbSWRqVyUv1lWXnfL2o/5UGSPfc=;
 b=JaeAesavGQr/p76Wh+4w4KwjkCXvZX0iDAa6gnsuiwpBmAEQdIahi0jq6vXoBDQQaP
 Bx6PMf3McQ8WVK7VMy7+eMbh+fZPGCPaJ+VHe7rvfunsqpEAf8jBbjHRIH2Gun8xjA3I
 N93DsjNdC6Jt3RVvfA/0iINYNqehy1Jr8SsRRPtfGKEnkpmxv9Ebyr2oqDOHrbUIkwZZ
 bUmCwqMbIx6EDauVOgo6bAcyDWHC/RxBWBIiI8k0Os0mB7jrGtREvBnv8EnHbj/rixFc
 av4jtKgdg5bVvSxJmqLCu8lFA+ih+e5o5erOtqq39I9fvU/hT00GB6+Q4Y6kHboxHlSO
 0uNg==
X-Gm-Message-State: AOJu0Ywlo2iaPZaLPOFkop382VT/7u581j9+pPRTIvtCAj38SClFt7qU
 7DTk3OEJHH+s8yFIPvbZaU2T2KZEAG5g5KEZd1aTGzdDmBlW5mKD3GKhE8hinZw=
X-Google-Smtp-Source: AGHT+IGh8eim0FMnDlyNvzHCxH5YQQ4OsK0RsoB9GAYhBK+L4H6tiCs5CbK9M1o+elTx0/I5h7R5Nw==
X-Received: by 2002:aa7:db48:0:b0:561:d3e5:a83a with SMTP id
 n8-20020aa7db48000000b00561d3e5a83amr1953950edt.5.1707806985399; 
 Mon, 12 Feb 2024 22:49:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxpKrayFGSu5tm4AQWymUEjzREe/0ZHN4Vy4oUlDLyRnkBc2n4veC7xMGSwTPTWZUTYcjOKhLxAM6gteNJ0aYR1oMp2wziFZjLnG3ojer6e+yq9LWvQ8UltrlWfiApFIfAZF8FD6WWWpIaPVr63dOrT9+2jbdWsFQSDb8=
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 b6-20020aa7c906000000b00560ba66587csm3379741edt.13.2024.02.12.22.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 22:49:44 -0800 (PST)
Date: Tue, 13 Feb 2024 09:49:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: u-boot@lists.denx.de, Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] command: add FDT setup for bootelf by flag
Message-ID: <e83d2a8a-ddf5-4bf5-b55e-2d2565ca78fb@moroto.mountain>
References: <20240211204248.273295-1-Maxim.Moskalets@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211204248.273295-1-Maxim.Moskalets@kaspersky.com>
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

On Sun, Feb 11, 2024 at 11:42:48PM +0300, Maxim Moskalets wrote:
> diff --git a/cmd/elf.c b/cmd/elf.c
> index b7b9f506a5..4d365771eb 100644
> --- a/cmd/elf.c
> +++ b/cmd/elf.c
> @@ -38,6 +38,8 @@ static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
>  /* Interpreter command to boot an arbitrary ELF image from memory */
>  int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	unsigned long fdt_addr;
> +	struct bootm_headers img = { 0 };
>  	unsigned long addr; /* Address of the ELF image */
>  	unsigned long rc; /* Return value from user code */
>  	char *sload = NULL;
> @@ -68,6 +70,18 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	else
>  		addr = load_elf_image_shdr(addr);
>  
> +	if (!env_get_elf_need_fdt()) {

Should the ! be there?  This looks reversed...

> +		if (argc >= 1 && strict_strtoul(argv[0], 16, &fdt_addr) != -EINVAL) {
> +			printf("Got FDT at 0x%08lx ...\n", fdt_addr);
> +
> +			if (image_setup_libfdt(&img, (void *)fdt_addr, 0, NULL)) {
> +				printf("ERROR: Failed to process device tree\n");
> +				return 1;
> +			}
> +		}
> +	}
> +
> +
>  	if (!env_get_autostart())
>  		return rcode;

There are a few style nits that I have with this change like the double
blank line at the end.  Try running scripts/checkpatch.pl on your patch.
We could also combine the conditions and pull the code in a tab.  Also I
recognize that you just copied the != -EINVAL from a few lines earlier
and it does work, but it's better to check for == 0 instead.

	if (env_get_elf_need_fdt() && argc >= 1 &&
            strict_strtoul(argv[0], 16, &fdt_addr) == 0) {
		printf("Got FDT at 0x%08lx ...\n", fdt_addr);

		if (image_setup_libfdt(&img, (void *)fdt_addr, 0, NULL)) {
			printf("ERROR: Failed to process device tree\n");
			return 1;
		}
	}

regards,
dan carpenter

