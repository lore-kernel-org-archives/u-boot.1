Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE5BC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 09:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A3F87AC2;
	Thu, 11 Jan 2024 10:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p6/MjAFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169EA87AC7; Thu, 11 Jan 2024 10:50:32 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC2287AB7
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 10:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33748c4f33dso4936174f8f.1
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704966627; x=1705571427;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=A+xkJMWY6lhd25ar1Y4BztRmZ+CK8oC+ljypuMtMLYk=;
 b=p6/MjAFteVBIWlx2+uKmirixjTYRRoOLP/8RuGmWlc0CbkfpB4K3XU+eVIEqMUN8MI
 2XDZwGEzjGy2B2+WG15NiUQjalJLi0gGANLxF0sFtgfExctTCjG0vnWh/jx7t22O7mHd
 vCXv1DDIR27KlJIV4csCgsp/BG6WhqOzvPQOT+HYsRr/9Ufr+/uOgQcsjNcifFlqiiY+
 rejvk3CWi1HKgCTrrMmIhMmZE109NvsCYnArn24jCeAxooe3CNpJRBcRsl30lU923nh1
 csLeWZSea+xzXKaoakZqMa1Z67RbuUIFBJhYbzMUc/pI2BS7ris7tab9um5zJm5alJmS
 YHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704966627; x=1705571427;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+xkJMWY6lhd25ar1Y4BztRmZ+CK8oC+ljypuMtMLYk=;
 b=mCL5a91xP1DyzthHL5DzrsVurJwgXyR2s1Gg1h7T09fKtydmUf4ypB+dicP+6sG3y9
 laen21vcI9rLPyCaGAEYcBB9I2LcfGoji8jB/eudakZEc52MOyd5BbDu34c+kM+ljKoO
 MRweEKL94G5nT1wGgwWoNdlCvx0JR/D/+/Hi9h3D/xwasaN+wcDWZVPZDvQ6/OdBo8DT
 BAcseDTcOUX1Br7A2NzdVVX92LTDPsbXsvhTrEvkgW9OjUDUTnD9TkqNGkT0Xc3m4YOr
 Ys/Z4ruiL9JjYpGUTaK6P0euESKrmCQnQmuKAw3M3greY4zNynN0qch8ItjsTP9kcf1p
 hr/g==
X-Gm-Message-State: AOJu0YwC87Fnbl1Zdlu/Gblzvd+6MjAUQrcqCCGkZ3n/8FS7EL8WuO1A
 /kFhPvaQCGvKSRDO71vTIyeP/17TCLaQug==
X-Google-Smtp-Source: AGHT+IExd2xtDLUxp1VKkrrIm6GYZjzazcrBuy0gvBNvIdV/PPGg1LlOf3yozS/xFfY4IjxJfAYPPw==
X-Received: by 2002:a05:600c:2e15:b0:40e:4832:9fab with SMTP id
 o21-20020a05600c2e1500b0040e48329fabmr244725wmf.143.1704966627401; 
 Thu, 11 Jan 2024 01:50:27 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 m15-20020a7bce0f000000b0040d23cea7bcsm2047283wmc.1.2024.01.11.01.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 01:50:27 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, Sean Anderson
 <sean.anderson@seco.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "dimorinny@google.com" <dimorinny@google.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel
 <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
 <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
 <48b16521-f1aa-4f78-ae9d-96832da0da72@seco.com>
 <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
Date: Thu, 11 Jan 2024 10:50:26 +0100
Message-ID: <877ckg6vx9.fsf@baylibre.com>
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

Hi Alexey, Sean,

On mer., janv. 10, 2024 at 08:03, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Hi,
>
> On Tue, Jan 09, 2024 at 10:45:46AM -0500, Sean Anderson wrote:
>> On 1/9/24 05:27, Alexey Romanov wrote:
>> > Hello Sean!
>> > 
>> > Thanks for you reply.
>> > 
>> > On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
>> >> On 12/28/23 10:25, Alexey Romanov wrote:
>> >> > Currently, fastboot protocol in U-Boot has no opportunity
>> >> > to execute vendor custom code with verifed boot.
>> >> 
>> >> Well, I would say the most conventional way to do this would be something like
>> >> 
>> >> => fastboot 0
>> >> => source \# CONFIG_FASTBOOT_BUF_ADDR
>> >> 
>> >> and on your host machine,
>> >> 
>> >> $ fastboot stage my_script.itb
>> >> 
>> >> where my_script.its looks like
>> >> 
>> >> /dts-v1/;
>> >> 
>> >> / {
>> >>     description = "my script";
>> >>     #address-cells = <1>;
>> >> 
>> >>     images {
>> >>         my-script {
>> >>             data = /incbin/("my_script.scr");
>> >>             type = "script";
>> >>             arch = "arm64";
>> >>             compression = "none";
>> >>             hash-1 {
>> >>                 algo = "sha256";
>> >>             };
>> >>         };
>> >>     };
>> >> 
>> >>     configurations {
>> >>         default = "conf";
>> >>         conf {
>> >>             description = "Load my script";
>> >>             script = "my-script";
>> >>             signature {
>> >>                 algo = "sha256,rsa2048";
>> >>                 key-name-hint = "vboot";
>> >>                 sign-images = "script";
>> >>             };
>> >>         };
>> >>     };
>> >> };
>> >> 
>> >> This method is especially useful to pass complex parameters to your command.
>> >> This method of course requires commit bcc85b96b5f ("cmd: source: Support
>> >> specifying config name").
>> >> 
>> >> Would it be possible to use the above method for your use case?
>> > 
>> > This method sounds good for some cases, but we have encountered some
>> > problems that prevent us from applying it:
>> > 
>> > 1. Looks like this method requires access to UART (for typing 'source'
>> > command). Open the UART is unsafe at devices with verified boot.
>> 
>> Generally the idea is that you run source after you run fastboot. E.g. you set
>> your altbootcmd (or whatever) to something like
>> 
>> while true; fastboot 0; source \# || boot; done
>> 
>> so you try to source whatever gets staged, and boot it otherwise.
>
> If I understand right, U-Boot always will try fastboot mode?
> Yes, it seems like it will work. But the code for complex
> fastboot scripts will be complex and difficult to read.
>
> I think my version looks more elegant and simple.

I think your solution is elegant, but i'd like to make sure that the
problem cannot be solved otherwise (via environment changes or other things)

>
>> 
>> > 2. We use automation scripts to flash our devices using fastboot
>> > protocol. A typical example of flashing scripts (device is already in
>> > fastboot mode):
>> > 
>> >   $ fastboot erase bootloader
>> >   $ fastboot stage bootloader.img
>> >   $ fastboot oem board:write_bootloader
>> > 
>> >   $ fastboot reboot-bootloader
>> > 
>> >   $ fastboot erase super
>> >   $ fastboot flash super super.bin
>> > 
>> >   $ fastboot reboot
>> > 
>> > This method doesn't assume what something typing additional command in
>> > U-Boot shell, even if we have access to UART.
>> 
>> I'm curious what you actual usage for this is? That is, what do you need
>> a custom command for.
>
> Our SoC vendor use custom scheme for flashing bootloader partition.
> So we can't just use fastbooot flash command - we have to use custom
> flashing logic. We also don't want to use hacks in generic fastboot
> code, for example something like this in _fb_nand_write():
>
>   ...
>
>   if (!strcmp(part->name, "bootloader"))
>      write_bootloader_custom_logic(...)
>   else
>     nand_write_skip_bad(...)

Could you detail what "custom scheme" means?

Wouldn't using "fastboot_raw_partition_*" be appropriate for your use-case?
https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors

I know the above is for mmc but maybe this can be extended for nand ?

>
>   ...
>
>> 
>> --Sean
>> 
>> >> 
>> >> --Sean
>> >> 
>> >> > This patch
>> >> > introduce new fastboot subcommand fastboot oem board:<cmd>,
>> >> > which allow to run custom oem_board function.
>> >> > =
>> >> > Default implementation is __weak. Vendor must redefine it in
>> >> > board/ folder with his own logic.
>> >> > 
>> >> > For example, some vendors have their custom nand/emmc partition
>> >> > flashing or erasing. Here some typical command for such use cases:
>> >> > 
>> >> > - flashing:
>> >> > 
>> >> >   $ fastboot stage bootloader.img
>> >> >   $ fastboot oem board:write_bootloader
>> >> > 
>> >> > - erasing:
>> >> > 
>> >> >   $ fastboot oem board:erase_env
>> >> > 
>> >> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> >> > ---
>> >> >  drivers/fastboot/Kconfig      |  7 +++++++
>> >> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
>> >> >  include/fastboot.h            |  1 +
>> >> >  3 files changed, 23 insertions(+)
>> >> > 
>> >> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> >> > index 3cfeea4837..4c955cabab 100644
>> >> > --- a/drivers/fastboot/Kconfig
>> >> > +++ b/drivers/fastboot/Kconfig
>> >> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>> >> >  	  this feature if you are using verified boot, as it will allow an
>> >> >  	  attacker to bypass any restrictions you have in place.
>> >> >  
>> >> > +config FASTBOOT_OEM_BOARD
>> >> > +	bool "Enable the 'oem board' command"
>> >> > +	help
>> >> > +	  This extends the fastboot protocol with an "oem board" command. This
>> >> > +	  command allows running vendor custom code defined in board/ files.
>> >> > +	  Otherwise, it will do nothing and send fastboot fail.
>> >> > +
>> >> >  endif # FASTBOOT
>> >> >  
>> >> >  endmenu
>> >> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>> >> > index 71cfaec6e9..4d2b451f46 100644
>> >> > --- a/drivers/fastboot/fb_command.c
>> >> > +++ b/drivers/fastboot/fb_command.c
>> >> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
>> >> >  static void oem_format(char *, char *);
>> >> >  static void oem_partconf(char *, char *);
>> >> >  static void oem_bootbus(char *, char *);
>> >> > +static void oem_board(char *, char *);
>> >> >  static void run_ucmd(char *, char *);
>> >> >  static void run_acmd(char *, char *);
>> >> >  
>> >> > @@ -106,6 +107,10 @@ static const struct {
>> >> >  		.command = "oem run",
>> >> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>> >> >  	},
>> >> > +	[FASTBOOT_COMMAND_OEM_BOARD] = {
>> >> > +		.command = "oem board",
>> >> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
>> >> > +	},
>> >> >  	[FASTBOOT_COMMAND_UCMD] = {
>> >> >  		.command = "UCmd",
>> >> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
>> >> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>> >> >  	else
>> >> >  		fastboot_okay(NULL, response);
>> >> >  }
>> >> > +
>> >> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
>> >> > +{
>> >> > +	fastboot_fail("oem board function not defined", response);
>> >> > +}
>> >> > +
>> >> > +static void __maybe_unused oem_board(char *cmd_parameter, char *response)
>> >> > +{
>> >> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
>> >> > +}
>> >> > diff --git a/include/fastboot.h b/include/fastboot.h
>> >> > index 296451f89d..06c1f26b6c 100644
>> >> > --- a/include/fastboot.h
>> >> > +++ b/include/fastboot.h
>> >> > @@ -37,6 +37,7 @@ enum {
>> >> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
>> >> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>> >> >  	FASTBOOT_COMMAND_OEM_RUN,
>> >> > +	FASTBOOT_COMMAND_OEM_BOARD,
>> >> >  	FASTBOOT_COMMAND_ACMD,
>> >> >  	FASTBOOT_COMMAND_UCMD,
>> >> >  	FASTBOOT_COMMAND_COUNT
>> >> 
>> > 
>> 
>
> -- 
> Thank you,
> Alexey
