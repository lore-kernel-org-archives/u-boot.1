Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE01C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB7488460;
	Fri,  5 Apr 2024 11:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cNqyAAYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05A1884C7; Fri,  5 Apr 2024 11:01:29 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D56188460
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4162b8cb3e9so14268765e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712307687; x=1712912487;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=agx9DK8GrnQ38BQicYso2L59l/ba/7FFixdGSXQOUas=;
 b=cNqyAAYrzciko3wmWlLG66qsqB8qQSraXv2JEa9tVAjRxX008WzAUzJuyC+nJrYm9O
 fit4U2XjVFX3MBcA92RNx6Qcx24D6ke9fSsPFE6NKfG2LITL3QaybJxIK1+0ZBwPQ1Zn
 tFbHuBOwF4LFj96dbD4GjsVDcY7JDINnowuysG3/+pDk7Z7kxVQOkjBidSvqamwTgWek
 v6VmbhI6Px/PnWann9CJ5dUtbLuiPmqfKUIECXlr91NucW9FDmD4KLVrYX3ixjN/sPlk
 L2c81YbQB/V/AAsrYRyyWNU8lZyPVxmdOCoVdf70xgiQmsG6xjGTbkloOOvMF4yolxhp
 pkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712307687; x=1712912487;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agx9DK8GrnQ38BQicYso2L59l/ba/7FFixdGSXQOUas=;
 b=cK/aB14pJgo6cLg/N+G+afXwF7DiFgMwLARxUQXTNAsUfbI4IQT7bCdwgvMzXgvG5K
 SHuFYTztxygKsEJ2GrqmWFEOmsogG6IgbxW5W8fHvjZ/ipl4ZXK/ZO+SHHQoXkyNTemJ
 D0qtcjJbn1EmXcnfXZ/LB0zQ0hG30i3HwicbucpCicw9yFxXhDjQ+ptszuo8n/Vxl8xr
 WmNSwARPIbcCLNZS7eBsNX9VMuc9DKnh4WPei3n7BkitjFRdO5jeEqEG4LjObB4TSIpI
 0YG0NJRexvmXCt7ksDucEQD0U1RUbeHcDGBfMGbI6bFZ40045smw1CppgXLj1siLkUhi
 5kfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqlTRhhnoSU34lxitgLRcduRKhCD5O+2W5jIHEG9OH8F5BBZj52LpqWPD/+zO0vzs0DhAaCuntok/O6+J3U+PZsX2Dbw==
X-Gm-Message-State: AOJu0Yw89mZKvnbg5GLIJiYkIIh3P3RdSlTa9ff69F0eMCTw0OHdbW8a
 xBoZwlVijOreGdoiwly54cncWiIY9yf6ExgUhoT19kyD/Dch7kVIHs8rEyD8kW4=
X-Google-Smtp-Source: AGHT+IGPneEGW0BJKtctt487gL5uaBL6FxUnR7rNiKa2PuwloNro5xIy2UjqXFkf3jipENuzKAb0Rw==
X-Received: by 2002:a5d:570e:0:b0:33e:7a7c:a058 with SMTP id
 a14-20020a5d570e000000b0033e7a7ca058mr841781wrv.18.1712307686912; 
 Fri, 05 Apr 2024 02:01:26 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 i8-20020adfb648000000b00343e46c9a9esm1198801wre.11.2024.04.05.02.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:01:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH v2 1/2] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240304141126.otcp6tl7v6pupgzl@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-2-avromanov@salutedevices.com>
 <874jeaytqy.fsf@baylibre.com>
 <20240304141126.otcp6tl7v6pupgzl@cab-wsm-0029881.sigma.sbrf.ru>
Date: Fri, 05 Apr 2024 11:01:25 +0200
Message-ID: <87h6ggfaje.fsf@baylibre.com>
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

On lun., mars 04, 2024 at 14:11, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Hello,
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
>
> Yeah, pyamlboot also uses the same 'bootloader' partition flashing
> scheme as I present in the patch 2. This is custom Amlogic protocol.
>
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
>
> Agree, you are completely right.
>
>> 
>> But both examples could also be in a fastboot flash format:
>> $ fastboot flash serialno ABCDEF
>
> But this case requires to 'serialno' partition definition in schema?
> I didn't fully understand you.

I meant more in a "conceptual way". (from a end user perspective)

"fastboot flash" is generic command that's just supposed to write data
somewhere.

The back-end (partitioning etc) depends on the storage the device uses
so that's a "implementation detail".

In any case, I don't have a proper alternative to what you are proposing
so as send in [1], I'm okay picking this up after some minor review
comments are addressed.

[1] https://lore.kernel.org/all/87jzlcfang.fsf@baylibre.com/

>
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
