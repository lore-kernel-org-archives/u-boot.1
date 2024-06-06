Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520EAC27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 06:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AB788428;
	Fri,  7 Jun 2024 08:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fw/IEC+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EB68816D; Thu,  6 Jun 2024 19:34:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1615C8806C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 19:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a2f032007so1566260a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717695237; x=1718300037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FJAVLxGpfLK0GY6Uakbhh3EsV5OWsjilRU7K6aOGdKg=;
 b=fw/IEC+7vKI6meP1ifMwzcipnbpLPFouJNtavo6fodA82h3Im3j8f2dTnckcK4NLDZ
 EiE6BJcXnayd5BgxiprXPvhu+Ay8jrlUebNvZV3U7cSRxRXEeBmLJNFu38LFOOm8lRqC
 ZQCuelGguBL6qif6YM7o77jXKnX7GqTryD+Vo/oYPzXXik3XWF239JiZonznvVbkrqQe
 LaAx27pJ+y0NCP2q5gRTI0I7m1SwWxE0SRijROqcsxsrkb1SWBMCErU38rOoKBSXIFjk
 0Ku1OYk6qUzD/PpO4ZpzqaLtsVLXexQH5whPwKOrsUGSzN/irdh71/36bAxiulQKKxWI
 vCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717695237; x=1718300037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJAVLxGpfLK0GY6Uakbhh3EsV5OWsjilRU7K6aOGdKg=;
 b=JM7S+JfvMdTtqo+qRSBy7BkuC5dgZwxxkqU8wRSnQ+Zhkl3onr28BtkjE2m2fh64mm
 2DuXClDSEcNrgfWcV3RYdkNqwSP2vleYzLOTOi4ypuHk1nMGa7l4LYV5a/+h2iMlJamI
 rjq+nO7URsSBGLfwNu0KQmXIYRZ9+moM6Rq5WKh4NTtKkSQ4bx3InjZRbG1yav46wm9h
 e3BjHiUjZ+qixLoeVlJrjI1jyQubhgI26NpVqLIPhASA7TKgOVnkA7C89O27DUs/qvwy
 C7J0VYfQzClUza0F6kl/40dPF7L7KwvT9T2uSc12akm79UKVUI9wiMtpL8cHny8zNtpW
 t82Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJVMu+i8w5Qtyr8AX3Q/C6Q7VnixDxy5eva7ZlYlD7gHSH/k2fnuBjjnqWkvDXagTqHedc2JTcGlfej/QmkStMRIzMyA==
X-Gm-Message-State: AOJu0YwHGkWJJf5YNBtTwDZ1sIpeqpjfLTNCXZo8YU2mKsYJV68KTMXT
 cTCECj+mlXpT+9B3mZN5G81hqlS83s4UFYQBWPabuEy851IoMO4x
X-Google-Smtp-Source: AGHT+IFoOvNNF0iNz1x+3VRw6mPjXkkms4pLDw22Ji3A7l9WDhdC6kmfvnPqJ9kRhIeJi/0MdTaDwg==
X-Received: by 2002:a50:9eef:0:b0:57a:3273:e648 with SMTP id
 4fb4d7f45d1cf-57c508ffe2cmr37449a12.18.1717695237264; 
 Thu, 06 Jun 2024 10:33:57 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d064sm1394746a12.10.2024.06.06.10.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 10:33:56 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 6 Jun 2024 19:33:54 +0200
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [RFC PATCH] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240606173354.GA125107@vamoiridPC>
References: <20240605181041.68317-1-vassilisamir@gmail.com>
 <20240605181041.68317-2-vassilisamir@gmail.com>
 <a9b83883-f429-46c7-a2d8-0be187ad3be4@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b83883-f429-46c7-a2d8-0be187ad3be4@cherry.de>
X-Mailman-Approved-At: Fri, 07 Jun 2024 08:06:57 +0200
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

On Thu, Jun 06, 2024 at 05:34:55PM +0200, Quentin Schulz wrote:
> Hi Vasileios,
> 
> On 6/5/24 8:10 PM, Vasileios Amoiridis wrote:
> > [You don't often get email from vassilisamir@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > 
> > Add support to save boot count variable in a file in a FAT filesystem.
> > 
> > Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > ---
> >   doc/README.bootcount              | 12 ++++----
> >   drivers/bootcount/Kconfig         | 49 +++++++++++++++++++++++--------
> >   drivers/bootcount/Makefile        |  2 +-
> >   drivers/bootcount/bootcount_ext.c | 18 ++++++++----
> >   4 files changed, 56 insertions(+), 25 deletions(-)
> > 
> > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > index f6c5f82f98..cce66d4d70 100644
> > --- a/doc/README.bootcount
> > +++ b/doc/README.bootcount
> > @@ -23,15 +23,17 @@ It is the responsibility of some application code (typically a Linux
> >   application) to reset the variable "bootcount" to 0 when the system booted
> >   successfully, thus allowing for more boot cycles.
> > 
> > -CONFIG_BOOTCOUNT_EXT
> > +CONFIG_BOOTCOUNT_FS
> >   --------------------
> > 
> > -This adds support for maintaining boot count in a file on an EXT filesystem.
> > +This adds support for maintaining boot count in a file on a filesystem.
> > +Supported filesystems are FAT and EXT.
> > +
> >   The file to use is defined by:
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
> > index 3c56253b1e..a39a7556bb 100644
> > --- a/drivers/bootcount/Kconfig
> > +++ b/drivers/bootcount/Kconfig
> > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
> >              Set to the address where the bootcount and bootcount magic
> >              will be stored.
> > 
> > -config BOOTCOUNT_EXT
> > -       bool "Boot counter on EXT filesystem"
> > -       depends on FS_EXT4
> > -       select EXT4_WRITE
> > +config BOOTCOUNT_FS
> > +       bool "Boot counter on filesystem"
> > +       depends on FS_EXT4 || FS_FAT
> >          help
> >            Add support for maintaining boot count in a file on an EXT
> >            filesystem.
> > @@ -177,6 +176,30 @@ config BOOTCOUNT_BOOTLIMIT
> >            counter being cleared.
> >            If set to 0, do not set a boot limit in the environment.
> > 
> > +if BOOTCOUNT_FS
> > +choice
> > +       prompt "Filesystem type"
> > +       default BOOTCOUNT_EXT
> > +
> > +config BOOTCOUNT_EXT
> > +       bool "Boot counter on EXT filesystem"
> > +       depends on FS_EXT4
> > +       select EXT4_WRITE
> > +       help
> > +         Add support for maintaining boot count in a file on an EXT
> > +         filesystem.
> > +
> > +config BOOTCOUNT_FAT
> > +       bool "Boot counter on FAT filesystem"
> > +       depends on FS_FAT
> > +       select FAT_WRITE
> > +       help
> > +         Add support for maintaining boot count in a file on a FAT
> > +         filesystem.
> > +
> > +endchoice
> > +endif
> > +
> >   config SYS_BOOTCOUNT_SINGLEWORD
> >          bool "Use single word to pack boot count and magic value"
> >          depends on BOOTCOUNT_GENERIC
> > @@ -184,26 +207,26 @@ config SYS_BOOTCOUNT_SINGLEWORD
> >            This option enables packing boot count magic value and boot count
> >            into single word (32 bits).
> > 
> > -config SYS_BOOTCOUNT_EXT_INTERFACE
> > +config SYS_BOOTCOUNT_FS_INTERFACE
> >          string "Interface on which to find boot counter EXT filesystem"
> >          default "mmc"
> > -       depends on BOOTCOUNT_EXT
> > +       depends on BOOTCOUNT_FS
> >          help
> >            Set the interface to use when locating the filesystem to use for the
> >            boot counter.
> > 
> > -config SYS_BOOTCOUNT_EXT_DEVPART
> > +config SYS_BOOTCOUNT_FS_DEVPART
> >          string "Partition of the boot counter EXT filesystem"
> >          default "0:1"
> > -       depends on BOOTCOUNT_EXT
> > +       depends on BOOTCOUNT_FS
> >          help
> >            Set the partition to use when locating the filesystem to use for the
> >            boot counter.
> > 
> > -config SYS_BOOTCOUNT_EXT_NAME
> > +config SYS_BOOTCOUNT_FS_NAME
> >          string "Path and filename of the EXT filesystem based boot counter"
> >          default "/boot/failures"
> > -       depends on BOOTCOUNT_EXT
> > +       depends on BOOTCOUNT_FS
> >          help
> >            Set the filename and path of the file used to store the boot counter.
> > 
> > @@ -211,18 +234,18 @@ config SYS_BOOTCOUNT_ADDR
> >          hex "RAM address used for reading and writing the boot counter"
> >          default 0x44E3E000 if BOOTCOUNT_AM33XX || BOOTCOUNT_AM33XX_NVMEM
> >          default 0xE0115FF8 if ARCH_LS1043A || ARCH_LS1021A
> > -       depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> > +       depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
> >                     BOOTCOUNT_AM33XX_NVMEM
> >          help
> >            Set the address used for reading and writing the boot counter.
> > 
> >   config SYS_BOOTCOUNT_MAGIC
> >          hex "Magic value for the boot counter"
> > -       default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> > +       default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
> >                                BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
> >                                BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT
> >          default 0xB0 if BOOTCOUNT_AM33XX_NVMEM
> > -       depends on BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> > +       depends on BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
> >                     BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
> >                     BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
> >                     BOOTCOUNT_AM33XX_NVMEM
> > diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> > index e7771f5b36..c0427434d7 100644
> > --- a/drivers/bootcount/Makefile
> > +++ b/drivers/bootcount/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_BOOTCOUNT_AT91)    += bootcount_at91.o
> >   obj-$(CONFIG_BOOTCOUNT_AM33XX) += bootcount_davinci.o
> >   obj-$(CONFIG_BOOTCOUNT_RAM)    += bootcount_ram.o
> >   obj-$(CONFIG_BOOTCOUNT_ENV)    += bootcount_env.o
> > -obj-$(CONFIG_BOOTCOUNT_EXT)    += bootcount_ext.o
> > +obj-$(CONFIG_BOOTCOUNT_FS)     += bootcount_ext.o
> >   obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)   += bootcount_nvmem.o
> > 
> >   obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
> > diff --git a/drivers/bootcount/bootcount_ext.c b/drivers/bootcount/bootcount_ext.c
> > index 9639e638e9..660bea2db2 100644
> > --- a/drivers/bootcount/bootcount_ext.c
> > +++ b/drivers/bootcount/bootcount_ext.c
> > @@ -19,14 +19,20 @@ typedef struct {
> > 
> >   static u8 upgrade_available = 1;
> > 
> > +#ifdef BOOTCOUNT_EXT
> > +static u8 bootcount_fstype = FS_TYPE_EXT;
> > +#else
> > +static u8 bootcount_fstype = FS_TYPE_FAT;
> > +#endif
> > +
> 
> I know nothing about filesystems, but I was wondering if we couldn't just
> use FS_TYPE_ANY here? Do we really need to specify which FS_TYPE to use? Are
> there some limitations, etc.?
> 
> Cheers,
> Quentin

Well, I am not very accustomed to the U-Boot code yet but by looking at the
fs_set_blk_dev() and fs_write() code, you might be right. I will test with
FS_TYPE_ANY and I will let you know.

Cheers,
Vasilis
