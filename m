Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E104FCD1299
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC8A88416;
	Fri,  5 Apr 2024 10:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sXNW30Op";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC6288416; Fri,  5 Apr 2024 10:59:05 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AC787E7F
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so24635621fa.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712307541; x=1712912341;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j6jOjpO7Bs3iQJWY2G8qBTp17Dv0jRpcXQulsr7k4QU=;
 b=sXNW30OpAZbalMH4e5p5E9cLHGA08J4yYey8pEWsfRINeSSIFln4QuMOWuTrwSNiZJ
 YJ/wiSGR50eQJsr9A5XCkm0Q5LlRMcddcKhnHyfRZzVN+vtS6DqCPHvb8WwrXBsioB3U
 tGSBAALdeCoMbDOucJAE8iDdGxXVAb+WQXhPoSp/z2zhlI22C0H3Ro0SwVAAL82XhOMf
 KWjcivLKH726cMLQuKVYUletApizDSaAO/r+9xIK9doB4QYa/Ot6g8V9phjRf+VMkKMv
 LPuq4MLvGGdd+i8VUoIecLd6pDvM73CED6JvATEBpAX716zUkdOV2Bih9+GqUJf4cemf
 TqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712307541; x=1712912341;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6jOjpO7Bs3iQJWY2G8qBTp17Dv0jRpcXQulsr7k4QU=;
 b=Ofl6joVK5k5XFjZ+vRrqJpzSu3mSSCARBgrTy/TETou0xy20C1XgUdpzFVYrO7xOFV
 FewmbvhRvKQELJgxvCpiuwjcsTHVfML4oKQBWhH3SeL4o25qtZqHZ6rYSRSm5hL7dKjI
 BrNImN86dEraLYv4uDsTW72UCHXbKoI9+WHRWTDR50qVk6G7+GDwepJEiab4ir0B+42w
 871Qnlfg7jD82Gyj020c8nwdswTV0l9RPlHIw91PP20qikbc/2tUq3xvu7p+DSmPMchW
 SmxGKRoK1CbgrAz8PVqiFwyvDQiRw4IMJVXJXlcrslGpJ1hkCFLR80Mfj+3brsAb88hP
 8bBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg6vJq+Iu4M29CaoWnDtmgJAYgiNqmy57jGu4B5Keh82Pa1JYHBbvNU2nlsjAcG4HLCFlVCjVHSLxZNtl288fjpYLV6A==
X-Gm-Message-State: AOJu0Yzs8hpf3y/7KFgk3klLX/Vf+spb+0DhrmifvR06x1mVTAZTpa6o
 IuPqP2XYo6VpFEYqPFmzLJ6XelWY0PLPxniMAc5xU8FDp2iUBFTi7Cd0oB1vI6g=
X-Google-Smtp-Source: AGHT+IFCEg4EsMClf1obOs2JLyPCPp49wHzHj2D+bI+GIr+ZicKCbSUsPgVsIrUugHqxgqcBkFEwZA==
X-Received: by 2002:a2e:86c9:0:b0:2d8:63a2:50d2 with SMTP id
 n9-20020a2e86c9000000b002d863a250d2mr701082ljj.6.1712307541321; 
 Fri, 05 Apr 2024 01:59:01 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a7bc018000000b00414887d9329sm2104455wmb.46.2024.04.05.01.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:59:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH v2 1/2] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240403084900.5yxzfp7lz2u56y57@cab-wsm-0029881>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-2-avromanov@salutedevices.com>
 <874jeaytqy.fsf@baylibre.com>
 <20240403084900.5yxzfp7lz2u56y57@cab-wsm-0029881>
Date: Fri, 05 Apr 2024 10:58:59 +0200
Message-ID: <87jzlcfang.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Alexey,

On mer., avril 03, 2024 at 08:49, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Hello Mattijs,
> is there any feedback?

Sorry for the late reply. I was both swamped with other work and awaiting.
feedback from others.

I don't have strong enough arguments to state that this is not useful to
others, I have re-considered this and I'm willing to pick it up.

Please rebase, as this no longer applies.

Also see some review comments below

>
> On Thu, Feb 15, 2024 at 10:14:13AM +0100, Mattijs Korpershoek wrote:
>> Hi Alexey,
>> 
>> Thank you for the patch.
>> 
>> On jeu., f'evr. 01, 2024 at 12:20, Alexey Romanov <avromanov@salutedevices.com> wrote:
>> 
>> > Currently, fastboot protocol in U-Boot has no opportunity
>> > to execute vendor custom code with verifed boot. This patch
>> > introduce new fastboot subcommand fastboot oem board:<cmd>,
>> > which allow to run custom oem_board function.
>> >
>> > Default implementation is __weak. Vendor must redefine it in
>> > board/ folder with his own logic.
>> >
>> > For example, some vendors have their custom nand/emmc partition
>> > flashing or erasing. Here some typical command for such use cases:
>> >
>> > - flashing:
>> >
>> >   $ fastboot stage bootloader.img
>> >   $ fastboot oem board:write_bootloader
>> >
>> > - erasing:
>> >
>> >   $ fastboot oem board:erase_env
>> >
>> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> 
>> Sorry for the delay. I needed time to give this some thoughts and I
>> waited for Sean to chime as well on this.
>> 
>> I've heard from Neil that this might be related to:
>> https://github.com/superna9999/pyamlboot/pull/20
>> 
>> I think this can be useful. Not necessarily for writing custom
>> partitions, but I see this could be used for other things:
>> 
>> 1. Provision SoC-specific fuses (serialno/mac addr) at the factory line
>>    (for production devices)
>>    Examples:
>>    $ fastboot oem board:write_serialno ABCDEF
>>    $ fastboot oem board:write_macaddr AA:BB:CC:DD:EE
>> 
>> 2. Access secure storage (via an Trusted Application)
>> 
>> But both examples could also be in a fastboot flash format:
>> $ fastboot flash serialno ABCDEF
>> 
>> One concern I have is that U-Boot forks might use this command as
>> an excuse to not makes things generic.
>> 
>> I hope that others will chime in on this as well.
>> I'd like to discuss this more because once this command is in we cannot
>> remove it later.
>> 
>> > ---
>> >  drivers/fastboot/Kconfig      |  7 +++++++
>> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
>> >  include/fastboot.h            |  1 +
>> >  3 files changed, 23 insertions(+)
>> >
>> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> > index a4313d60a9..4d94391a76 100644
>> > --- a/drivers/fastboot/Kconfig
>> > +++ b/drivers/fastboot/Kconfig
>> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>> >  	  this feature if you are using verified boot, as it will allow an
>> >  	  attacker to bypass any restrictions you have in place.
>> >  
>> > +config FASTBOOT_OEM_BOARD
>> > +	bool "Enable the 'oem board' command"
>> > +	help
>> > +	  This extends the fastboot protocol with an "oem board" command. This
>> > +	  command allows running vendor custom code defined in board/ files.
>> > +	  Otherwise, it will do nothing and send fastboot fail.
>> 
>> If we move forward with this, please also document the new command in:
>> doc/android/fastboot.rst

This still applies, document the command please.

>> 
>> > +
>> >  endif # FASTBOOT
>> >  
>> >  endmenu
>> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>> > index 5fcadcdf50..2298815770 100644
>> > --- a/drivers/fastboot/fb_command.c
>> > +++ b/drivers/fastboot/fb_command.c
>> > @@ -40,6 +40,7 @@ static void reboot_recovery(char *, char *);
>> >  static void oem_format(char *, char *);
>> >  static void oem_partconf(char *, char *);
>> >  static void oem_bootbus(char *, char *);
>> > +static void oem_board(char *, char *);
>> >  static void run_ucmd(char *, char *);
>> >  static void run_acmd(char *, char *);
>> >  
>> > @@ -107,6 +108,10 @@ static const struct {
>> >  		.command = "oem run",
>> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>> >  	},
>> > +	[FASTBOOT_COMMAND_OEM_BOARD] = {
>> > +		.command = "oem board",
>> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
>> > +	},
>> >  	[FASTBOOT_COMMAND_UCMD] = {
>> >  		.command = "UCmd",
>> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
>> > @@ -490,3 +495,13 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>> >  	else
>> >  		fastboot_okay(NULL, response);
>> >  }
>> > +
>> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
>> > +{
>> > +	fastboot_fail("oem board function not defined", response);
>> > +}
>> > +
>> > +static void __maybe_unused oem_board(char *cmd_parameter, char *response)
>> > +{
>> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
>> > +}

Please also document the functions with comment headers, as done for the
other oem_ functions.

>> > diff --git a/include/fastboot.h b/include/fastboot.h
>> > index 296451f89d..06c1f26b6c 100644
>> > --- a/include/fastboot.h
>> > +++ b/include/fastboot.h
>> > @@ -37,6 +37,7 @@ enum {
>> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
>> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>> >  	FASTBOOT_COMMAND_OEM_RUN,
>> > +	FASTBOOT_COMMAND_OEM_BOARD,
>> >  	FASTBOOT_COMMAND_ACMD,
>> >  	FASTBOOT_COMMAND_UCMD,
>> >  	FASTBOOT_COMMAND_COUNT
>> > -- 
>> > 2.30.1
>
> -- 
> Thank you,
> Alexey
