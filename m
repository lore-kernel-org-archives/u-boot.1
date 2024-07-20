Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276F0C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA12884BE;
	Sat, 20 Jul 2024 17:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d7TIxADh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1414886CC; Sat, 20 Jul 2024 17:52:38 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CDE884BC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-824ae03efbfso516864241.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721490755; x=1722095555; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j+zRf4QdIkblrARycCbZVAq34xdIXoURKiW2GILwsuE=;
 b=d7TIxADhONW8ZWeBx1NRuaTz3TQA1+7K2S4atngQ5WSGEEkXKkbGKiFUW7Voyaml42
 f6NHZzKpybxZApnN1bR77Xa9/cBh4YTLxQEVOUDjVAyXF13X6t3vN4JAQf+pFSxBwbQN
 7jhdmWCgO81R1eFhwfofULnPE/Wgtf2Bcsfbpb3UxyfhHDFs63+XqzSrI9yWW6mHsKWN
 l/jdsdTRh5uFxwcspz2SYl1wIOEBbjZ+oTdcF2QKrkrERcDtjQsWM7AqZEpmKV0fnLka
 i0HA+C4opN7lMxHSqnfUHGEZQoxPV5RKMuZ76Wl+5h0PtlRF4KLg918f29vwgLmQLX0h
 i+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721490755; x=1722095555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+zRf4QdIkblrARycCbZVAq34xdIXoURKiW2GILwsuE=;
 b=hCLfGNcncNZXFTMmoGQEXaU9Af6nSp7LRYsQIa6jf4eJm/gpGRLkunKThyAYSMHj0N
 Vg7SGrvLZe3F6wT9dZ8YxwBjnZMH1BvAtYSChuo8KEYvx3VsS0ERjaLZkeQpZyI62+yC
 d/zq8iaxxx6VPCdp1j4hySWAVwVbeHX+YrEAxqxb+CLtlN2egK7d6mb02auHYFicKwlA
 HYzOtyvusajk/BUCseaOK/3Nd8vSOGiX4ImZm9PXblb/Rrq5oTk4daK7f1HLvhV94OA1
 aI4d/hp+gUbKuNyPURtK9vzPtjZMqFRk0MUgTkoYZgm9NpWoRg8xjmhl5lyJAsQEvNx2
 owgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX81x4Tm8Y6GTAWE2MeH46jVmOxDvgi/tcCmpBXteRUO01Ykvqpf+u8A8C3T4WmZw3l3voLGTedbULOB2CYztI/z5Cemg==
X-Gm-Message-State: AOJu0YwiEAOHqMaGwr4oHrGrvNeqBLSfXv0D//lX2Mb5SBZy1q4Bvbh6
 +jTipRQ9mrP2ATvWY7NC0WfiIjCOVO8YILMrtUzxk33+cT6b8ND/
X-Google-Smtp-Source: AGHT+IG3lO6N0ymwHQaIyyS6lczdEwZTm2vXuGKOWvE8regCvKUCLCth/TjsWYY5+zdeoV25hBndHA==
X-Received: by 2002:a05:6102:5c1b:b0:48f:b577:e02d with SMTP id
 ada2fe7eead31-49283f75fa1mr2415028137.25.1721490755313; 
 Sat, 20 Jul 2024 08:52:35 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b8f98f4a9asm11997656d6.75.2024.07.20.08.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:52:34 -0700 (PDT)
Message-ID: <f7dff022-9eb2-7ce8-971d-de282f0404e2@gmail.com>
Date: Sat, 20 Jul 2024 11:52:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/14] log: Avoid including function names by default
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-8-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-8-sjg@chromium.org>
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

On 7/20/24 02:16, Simon Glass wrote:
> Unless function names are requested, the logging system should not
> compile these into the code. Adjust the macros to handle this.
> 
> Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
> function names to be included. Fix up the pinmux test which checks a
> logging statement.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/log_console.c      |  4 ++--
>   configs/sandbox_defconfig |  1 +
>   include/log.h             | 18 ++++++++++++------
>   test/cmd/pinmux.c         |  8 +++++++-
>   test/log/log_test.c       |  4 ++--
>   5 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/common/log_console.c b/common/log_console.c
> index c27101b8fe2..9376baad664 100644
> --- a/common/log_console.c
> +++ b/common/log_console.c
> @@ -38,10 +38,10 @@ static int log_console_emit(struct log_device *ldev, struct log_rec *rec)
>   			printf("%d-", rec->line);
>   		if (fmt & BIT(LOGF_FUNC)) {
>   			if (CONFIG_IS_ENABLED(USE_TINY_PRINTF)) {
> -				printf("%s()", rec->func);
> +				printf("%s()", rec->func ?: "?");
>   			} else {
>   				printf("%*s()", CONFIG_LOGF_FUNC_PAD,
> -				       rec->func);
> +				       rec->func ?: "?");
>   			}
>   		}
>   	}
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index e2db66d4a25..d43d92d0cf2 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -38,6 +38,7 @@ CONFIG_PRE_CONSOLE_BUFFER=y
>   CONFIG_LOG=y
>   CONFIG_LOG_MAX_LEVEL=9
>   CONFIG_LOG_DEFAULT_LEVEL=6
> +CONFIG_LOGF_FUNC=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_STACKPROTECTOR=y
>   CONFIG_ANDROID_AB=y
> diff --git a/include/log.h b/include/log.h
> index fc0d5984472..67b6fd70050 100644
> --- a/include/log.h
> +++ b/include/log.h
> @@ -125,7 +125,7 @@ static inline int log_uc_cat(enum uclass_id id)
>    * @level: Level of log record (indicating its severity)
>    * @file: File name of file where log record was generated
>    * @line: Line number in file where log record was generated
> - * @func: Function where log record was generated
> + * @func: Function where log record was generated, NULL if not known
>    * @fmt: printf() format string for log record
>    * @...: Optional parameters, according to the format string @fmt
>    * Return: 0 if log record was emitted, -ve on error
> @@ -141,7 +141,7 @@ int _log(enum log_category_t cat, enum log_level_t level, const char *file,
>    * @level: Level of log record (indicating its severity)
>    * @file: File name of file where log record was generated
>    * @line: Line number in file where log record was generated
> - * @func: Function where log record was generated
> + * @func: Function where log record was generated, NULL if not known
>    * @addr:	Starting address to display at start of line
>    * @data:	pointer to data buffer
>    * @width:	data value width.  May be 1, 2, or 4.
> @@ -193,6 +193,12 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
>   #define _LOG_DEBUG	0
>   #endif
>   
> +#ifdef CONFIG_LOGF_FUNC
> +#define _log_func	__func__
> +#else
> +#define _log_func	NULL
> +#endif
> +
>   #if CONFIG_IS_ENABLED(LOG)
>   
>   /* Emit a log record if the level is less that the maximum */
> @@ -201,7 +207,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
>   	if (_LOG_DEBUG != 0 || _l <= _LOG_MAX_LEVEL) \
>   		_log((enum log_category_t)(_cat), \
>   		     (enum log_level_t)(_l | _LOG_DEBUG), __FILE__, \
> -		     __LINE__, __func__, \
> +		     __LINE__, _log_func, \
>   		      pr_fmt(_fmt), ##_args); \
>   	})
>   
> @@ -211,7 +217,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
>   	if (_LOG_DEBUG != 0 || _l <= _LOG_MAX_LEVEL) \
>   		_log_buffer((enum log_category_t)(_cat), \
>   			    (enum log_level_t)(_l | _LOG_DEBUG), __FILE__, \
> -			    __LINE__, __func__, _addr, _data, \
> +			    __LINE__, _log_func, _addr, _data, \
>   			    _width, _count, _linelen); \
>   	})
>   #else
> @@ -302,7 +308,7 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>    */
>   #define assert(x) \
>   	({ if (!(x) && _DEBUG) \
> -		__assert_fail(#x, __FILE__, __LINE__, __func__); })
> +		__assert_fail(#x, __FILE__, __LINE__, _log_func); })

Can we keep this one in? It's only compiled for debug and we are including file/line anyway.

>   /*
>    * This one actually gets compiled in even without DEBUG. It doesn't include the
> @@ -314,7 +320,7 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>   #define assert_noisy(x) \
>   	({ bool _val = (x); \
>   	if (!_val) \
> -		__assert_fail(#x, "?", __LINE__, __func__); \
> +		__assert_fail(#x, "?", __LINE__, _log_func); \
>   	_val; \
>   	})
>   
> diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
> index 4253baa5646..7ab7004b684 100644
> --- a/test/cmd/pinmux.c
> +++ b/test/cmd/pinmux.c
> @@ -30,7 +30,13 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
>   
>   	console_record_reset();
>   	run_command("pinmux status P9", 0);
> -	ut_assert_nextlinen("single-pinctrl pinctrl-single-no-width: missing register width");
> +	if (IS_ENABLED(CONFIG_LOGF_FUNC)) {
> +		ut_assert_nextlinen(
> +			"   single_of_to_plat() single-pinctrl pinctrl-single-no-width: missing register width");
> +	} else {
> +		ut_assert_nextlinen(
> +			"single-pinctrl pinctrl-single-no-width: missing register width");
> +	}
>   	ut_assert_nextlinen("P9 not found");
>   	ut_assert_console_end();
>   
> diff --git a/test/log/log_test.c b/test/log/log_test.c
> index 855353a9c40..d756b96dbac 100644
> --- a/test/log/log_test.c
> +++ b/test/log/log_test.c
> @@ -452,8 +452,8 @@ int log_test_buffer(struct unit_test_state *uts)
>   	/* This one should product no output due to the debug level */
>   	log_buffer(LOGC_BOOT, LOGL_DEBUG, 0, buf, 1, 0x12, 0);
>   
> -	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
> -	ut_assert_nextline("00000010: 10 00                                            ..");
> +	ut_assert_nextline("     log_test_buffer() 00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
> +	ut_assert_nextline("     log_test_buffer() 00000010: 10 00                                            ..");
>   	ut_assert_console_end();
>   	free(buf);
>   

Anyway, the rest looks fine. This probably breaks the use case of someone turning on
function names at runtime, so maybe we will need to split this config if someone cares.

--Sean
