Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004DEC27C78
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 17:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E4688263;
	Tue, 11 Jun 2024 19:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WIkl6Tws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5080E886E2; Tue, 11 Jun 2024 17:27:40 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86299886D5
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 17:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57c83100cb4so2753791a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718119657; x=1718724457; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6tOIqVJKyjcRgNn8ERSH7E5sHvT5b7UeW91dWTS+Uyo=;
 b=WIkl6Tws0UoSDnrfrgXmJOuzETw1slZ/HOxMZTvyQBe/6XP069DJN0hEVcomY8uDoE
 B/atbgGMZJN8IK6agiQLjuihiZXz0vBLhuMjBiNVOfRJEslrzM5eoW0imv27wB3OK6VD
 mmz4YwdvDq/hV3nFLYkiT+JmxGe3Upzi28Cv1n+yg3mL4XoOa8lcJb3OAXPiHKDudCHU
 EAK8UI8T/69mFhvB9lxgAxV3H19oNk8UrXR1yrgNN8aepZx9NJ1qiAgx8kZ8HdR2OZRg
 U8yUHP/LmvEsN4DRKSWlk0alolZ1/UZqUL3FjyndCWvypMElyOgGCDgHIBMEdHOCBd4m
 PIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718119657; x=1718724457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tOIqVJKyjcRgNn8ERSH7E5sHvT5b7UeW91dWTS+Uyo=;
 b=OB/HazUgd62PKpVgdpTCM66syysw9v6urkfFD5xqrSxBdmCVaRDWa0YOF/qh4Zv48N
 jjAng8TMImXSjOeSr9L7MBYDRanF8FdOzaTQw0ANj0l+KB5lspFTymgmKkfIwsbSvFWE
 7YMXePnj/+FUTOQFm5yAqmGdKttRpG8iWF2IZ83jmXaWuyKUjj0JYGb0yLPXHGL47D9m
 7IY903Uweddbs7TWpF1QdnvkAF49OI/fJFOTZyHE+rO1zs60JI5F6YlLk85wRhHfX5kS
 m0eRJ8eeK/n+C6VX+76jrcjMW0ZudQk3J8Y9ZiBYXfaNpViauiZ910N3pM956jy7zuZF
 r0ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvUtnD2o3jsFa3jOK7emfQKb+Y74rwMq/T8Y9T0082ODSs4cBPanKCrBUSybT78sIE7MfsiZp3GDdnEHPHlaFXzlIm9A==
X-Gm-Message-State: AOJu0Yy0sIH2hdjAXglGIrOpPC4y2EqDbiVzaZzPO6wCdbEFpeEBUyo0
 7xD8O53rWvI8Rj1tc2SJxsiYUcZnanCSXKJLelT9S0h+2ap4TIwp
X-Google-Smtp-Source: AGHT+IHp2OS8EFT8EeZ3wquzxkKMlIbDdpalH5EYbW/IqJJ80xsQhjCkXpSy8Zlb+nGh6dgUc/tJoA==
X-Received: by 2002:a50:d48f:0:b0:57c:628a:1759 with SMTP id
 4fb4d7f45d1cf-57c628a1ab5mr6000956a12.8.1718119656500; 
 Tue, 11 Jun 2024 08:27:36 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:495b:e8ce:9b90:3908])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c7cf18193sm4654133a12.50.2024.06.11.08.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 08:27:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 11 Jun 2024 17:27:33 +0200
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240611152733.GA441859@vamoiridPC>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
X-Mailman-Approved-At: Tue, 11 Jun 2024 19:55:31 +0200
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

On Tue, Jun 11, 2024 at 11:33:12AM +0200, Quentin Schulz wrote:
> Hi Vasileios,
> 
> On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
> > Add support to save boot count variable in a file in a FAT filesystem.
> >
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >   doc/README.bootcount                          | 12 ++---
> >   drivers/bootcount/Kconfig                     | 53 +++++++++++++------
> >   drivers/bootcount/Makefile                    |  2 +-
> >   .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
> >   4 files changed, 50 insertions(+), 29 deletions(-)
> >   rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
> >
> > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > index f6c5f82f..0f4ffb68 100644
> > --- a/doc/README.bootcount
> > +++ b/doc/README.bootcount
> > @@ -23,15 +23,15 @@ It is the responsibility of some application code
> (typically a Linux
> >   application) to reset the variable "bootcount" to 0 when the system
> booted
> >   successfully, thus allowing for more boot cycles.
> >
> > -CONFIG_BOOTCOUNT_EXT
> > +CONFIG_BOOTCOUNT_FS
> >   --------------------
> >
> > -This adds support for maintaining boot count in a file on an EXT
> filesystem.
> > -The file to use is defined by:
> > +This adds support for maintaining boot count in a file on a filesystem.
> > +Supported filesystems are FAT and EXT. The file to use is defined by:
> >
> > -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> > -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> > -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> >
> >   The format of the file is:
> >
> > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > index 3c56253b..d3679eb5 100644
> > --- a/drivers/bootcount/Kconfig
> > +++ b/drivers/bootcount/Kconfig
> > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
> >   	    Set to the address where the bootcount and bootcount magic
> >   	    will be stored.
> >
> > -config BOOTCOUNT_EXT
> > -	bool "Boot counter on EXT filesystem"
> > -	depends on FS_EXT4
> > -	select EXT4_WRITE
> > +config BOOTCOUNT_FS
> > +	bool "Boot counter on a filesystem"
> > +	depends on FS_EXT4 || FS_FAT
> Do we really need this 'depends on' here? Especially if we have a choice
> below...
> 
Well, probably this is redundant indeed.

> >   	help
> >   	  Add support for maintaining boot count in a file on an EXT
> The help text is still mentioning EXT here.
> 

Ahh, I missed that.

> I would recommend removing it, or listing the supported filesystems at the
> moment. While I assume you tested with FAT, I assume that with FS_ANY, any
> FS should be supported?
> 

Well, I tested it with both FAT and EXT4 and it works. AFAIU, due to the
implementation of the filesystem handling code in U-Boot, if the fs supports
a write a function, then it should work. But I cannot test for other
filesystems apart from FAT and EXT4 so I think it's better to limit the
option to these two.

> >   	  filesystem.
> > @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
> >   	  This option enables packing boot count magic value and boot count
> >   	  into single word (32 bits).
> >
> > -config SYS_BOOTCOUNT_EXT_INTERFACE
> > -	string "Interface on which to find boot counter EXT filesystem"
> > +if BOOTCOUNT_FS
> > +choice
> > +	prompt "Filesystem type"
> > +	default BOOTCOUNT_EXT
> > +
> > +config BOOTCOUNT_EXT
> > +	bool "Boot counter on EXT filesystem"
> > +	depends on FS_EXT4
> > +	select EXT4_WRITE
> > +	help
> > +	  Add support for maintaing boot counter in a file on EXT filesystem"
> > +
> > +config BOOTCOUNT_FAT
> > +	bool "Boot counter on FAT filesystem"
> > +	depends on FS_FAT
> > +	select FAT_WRITE
> > +	help
> > +	  Add support for maintaing boot counter in a file on FAT filesystem"
> > +
> > +endchoice
> > +endif
> > +
> Since we now support FS_ANY, do we really need this choice at all?
> 
> Alternatively, should it **really** be a choice and not just a bunch of
> configs that depends on BOOTCOUNT_FS + whatever's needed to write on that FS
> instead? I think we could have both BOOTCOUNT_EXT and BOOTCOUNT_FAT set
> without issue?
> 
> Cheers,
> Quentin

Well, I think I kind of get the point but I am still a bit confused.
Do you mean that basically the configuration should be done the other way
around? Instead of choosing BOOTCOUNT_FS and then specifically to choose
EXT or FAT, to choose one of EXT/FAT and then to select BOOTCOUNT_FS?
If yes, what is the advantage of this approach?

Cheers,
Vasilis
