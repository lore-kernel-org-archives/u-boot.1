Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12961C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 16:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1954687C4D;
	Sun, 11 Feb 2024 17:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hy0vUE2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C0E87C6D; Sun, 11 Feb 2024 17:20:10 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F20E87B71
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 17:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5114c05806eso3897385e87.1
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707668407; x=1708273207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDlcWGPuMLoZvgx9bEEypvSbK2SxPt29KJiQ1wAM/Ts=;
 b=Hy0vUE2FMeMLVXpnV9WfJlwfPWO0IXF4QoWzeMmlaHb8GAoYs6akPd0B8j+LQ/1wSl
 ic/Jw+nH3c2IZllPCpTrf5emYP3XKQ1radppH9X4qOhVtwpoYmuQpFqmHYasYXKxhjLg
 QHMqz6OM2jxGsu6tydlMimKm0A3X7ifmhVABEzyIi0LpRpSuT5NODBVv4IK3eT6LE8gV
 kHh1SmkDJmegAnvdX5XtmCWdKbSbS+jiFGi0BcEUK2iLq/xTUsE4eOqqKulTLOGEYdW3
 5WYnqhI/rCjjj75HmAn1BkstDGyHYCkwcVSFK5L9DTpg5WiVzkOrTSZ0Vx76nFXej2Yo
 Nayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707668407; x=1708273207;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nDlcWGPuMLoZvgx9bEEypvSbK2SxPt29KJiQ1wAM/Ts=;
 b=ttbkAPNWVvIlYs+++sWPGoRwEHgYPaMIXXwbXtiJn1ikwBMBJtt9TAsoscLsoB0Blp
 VBAYRGZuUkLf0ZsRY5XbOgFkjful9o/jeuLyA6Z+NJp9zpjb01umY6RKIEo03HvHqWWp
 TqczDceCjEqNUtXNjdZIvCKCCfuVhuCw4gQdpgDL6pq5wpj3ZKg1gC2oATU/5CEOfgmy
 IQhJkEd1QMnt3jQMOS86m8E16cAg8BuOV0stPnllX8l2w8+NbRyLo8duWums1R07tEqc
 bkPhdiU4ATCxetmfgZ4CQ53pOh7Y3AbAFX4jR+NqGuyTAXkDI9LXOFtRD8qsezW14pBU
 Zuyg==
X-Gm-Message-State: AOJu0Yx1P6MuvTARxKhKW/s0C+4mLnOuuKwBLlg8GeGXL1BecGF4kwCb
 xRmmldv50xWoCyQYvfTTzhQ9LzU9f7c1YMx+RaV7mB48mjFScPh8
X-Google-Smtp-Source: AGHT+IHNhfJ/jyftSTBr0SRAlQO5tgW3k1yFIMmxklL1ixBuRNDJBjbIdSIChGzVszWr6CiEF2TC4Q==
X-Received: by 2002:ac2:48a6:0:b0:50d:f81e:6872 with SMTP id
 u6-20020ac248a6000000b0050df81e6872mr3198229lfg.10.1707668407043; 
 Sun, 11 Feb 2024 08:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUYwhh4skqvTHk1KzOZts6eoNK4pG0Cv93NuAMkDsMDUO1m9vLzlDjB5HoSk2Y5txoAsZSOEeHIlT9Eev+WFIeOBOvt45ZxqpJf8w+1/BBpSfnsNUSfM57p5EqSBIdnsix+fMhYsy5ejsIgVILTowmtRZnRh0gOFB2d5lJYt+kZqoOwbxuKpX13cumufY8KLY9zmpfDW9LaMFmcKP2X5RXSLN1ucgLydQ==
Received: from localhost ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a056512361a00b005114945fad7sm555911lfs.307.2024.02.11.08.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 08:20:06 -0800 (PST)
Date: Sun, 11 Feb 2024 19:20:06 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] sunxi: defconfig: Add pstore support for pinephone
Message-ID: <ZcjztoqfwDMAeVK1@skv.local>
Mail-Followup-To: Peter Robinson <pbrobinson@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Andre Przywara <andre.przywara@arm.com>
References: <20240211154514.925977-1-andrej.skvortzov@gmail.com>
 <CALeDE9NxT2f_Y=v12EaHraDOHNVMhjPNLJpbLPVLgeZmsxiBMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALeDE9NxT2f_Y=v12EaHraDOHNVMhjPNLJpbLPVLgeZmsxiBMg@mail.gmail.com>
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

Hi Peter,

On 24-02-11 16:11, Peter Robinson wrote:
> On Sun, 11 Feb 2024 at 16:02, Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> >
> > In general any DRAM address, that isn't overwritten during a boot is
> > suitable for pstore.
> 
> What's this functionality providing? The details below give the
> technical reasons for the memory address but I'm not sure what
> enabling pstore provides to PinePhone users.
>
Good point. pstore allows users to catch kernel crashes and report
them to developers. It's enabled by default in distribution kernels
like Debian.

CONFIG_PSTORE=y
CONFIG_PSTORE_RAM=m

systemd has service that automatically handles pstore and saves them
in /var/lib/pstore for later usage.

Modern (Android) phones have pstore enabled usually to get information
about kernel crash, since it's the simplest way to get kernel
backtrace on mobile device without serial console.

> > Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
> > internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
> > later in the boot process. Ramdisk start address is 0x4FF00000,
> > initramfs for kernel with some hacking features and debug info enabled
> > can take more than 100Mb and final address will be around 0x58000000.
> > Address 0x61000000 will most likely not overlap with that.
> >
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  configs/pinephone_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> > index 9d39204a43..7b80cc3131 100644
> > --- a/configs/pinephone_defconfig
> > +++ b/configs/pinephone_defconfig
> > @@ -10,6 +10,8 @@ CONFIG_DRAM_ZQ=3881949
> >  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> >  CONFIG_PINEPHONE_DT_SELECTION=y
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > +CONFIG_CMD_PSTORE=y
> > +CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
> >  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> >  CONFIG_LED_STATUS=y
> >  CONFIG_LED_STATUS_GPIO=y
> > --
> > 2.43.0
> >

-- 
Best regards,
Andrey Skvortsov
