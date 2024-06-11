Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB4C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 17:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FF7886E3;
	Tue, 11 Jun 2024 19:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENhgVvPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FB7886B1; Tue, 11 Jun 2024 18:16:24 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E62884FB
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so2042653a12.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718122582; x=1718727382; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=98f/7DuhsDATqsA5uRi1FjCW3CsYh5CcwabhjkgbH7M=;
 b=ENhgVvPWelSqAfwoFoqG/Z9661oe42FhgAqFI51+eqIEV7jQ8w35Hxv22WlBW2HZwa
 r19J9wzJ8rpR2UFNjn8M5cT5c9ugowCd6a80q/Mf3f0faCq9pz55wXlI+MHdD/9nODyH
 EGL/08Bj8nmSopv0qPUK1vx1TByRFhiuS5VN52q+Nk5DET+K0hvcYUKisoe6s3HU52Ks
 GUf/dyiguXFcUmDdLJB7bXX20r18g53yddYotiagkvKNu6yhGKfZNGjHvclig6/Qox3j
 jOz7MTuKYH43NqxfJxxw5hMrJ3UIoVuqh49bMkzDpfOpCBRVcblbZQ9FLk8bcWtuXf+J
 5flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122582; x=1718727382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98f/7DuhsDATqsA5uRi1FjCW3CsYh5CcwabhjkgbH7M=;
 b=On3IiDOCV6peJUWClfW8GZTuPoWzvc1xp8LmJoWLU6HMOOq4ropA6xpX8f+YatP7Rq
 XcYMzdOPMdl72UuPZAhe/4xTilrrcpF2im/uRM4MSNjqq6W8DTrz6fZQeXtmzXrr/UWN
 yboS4OKsOKOvOkzfUkHhPUzA7a/UlnnxNk+03xOwVjBfNvbj2TzScy1YImpLfkx+aD8B
 zqdkdYS0skodgC8g7K2sZu/o5UfOg6Tv1NNRFLFXmoyDqsmIbf3F+BEEq3TekyeyGSY1
 YlqxDTNL8OdCQ6HHJy76cVy92MrxoERkthDxT6H0TY3zyney6LeaunZVWNqFNZRdEdyM
 2odQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxrKjwWUUfB4QbPjCk9XH1L5j734bf/6Olk+m6ibSUOCxPDrqLfaxnLoDEssxzMLtZMdLPAHjhiO5eY3X99hMQwqJvSQ==
X-Gm-Message-State: AOJu0YzqU5Khm4fXPeIi1+rTmUBcjYz4mkCeJw2sIRzPoYC7RRuMj7CU
 jx0SQq0kGAUfK8eJUITFwJQ8zScH+zFiCeE1+EYxT/xmB1buwaR3
X-Google-Smtp-Source: AGHT+IFbVDyqNXZspUBVkjHBhm2j5xX8S0KxBrSpzWkFN4TXbzCwbo8m3fRi9ICsqtTUyamSgdKftQ==
X-Received: by 2002:a17:906:16d9:b0:a6f:a54:1598 with SMTP id
 a640c23a62f3a-a6f0a541702mr717197566b.49.1718122581481; 
 Tue, 11 Jun 2024 09:16:21 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:495b:e8ce:9b90:3908])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0369399csm468731166b.3.2024.06.11.09.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:16:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 11 Jun 2024 18:16:19 +0200
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240611161619.GB441859@vamoiridPC>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
 <20240611152733.GA441859@vamoiridPC>
 <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
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

On Tue, Jun 11, 2024 at 05:41:19PM +0200, Quentin Schulz wrote:
> Hi Vasileios,
> 
> On 6/11/24 5:27 PM, Vasileios Amoiridis wrote:
> > On Tue, Jun 11, 2024 at 11:33:12AM +0200, Quentin Schulz wrote:
> > > Hi Vasileios,
> > > 
> > > On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
> > > > Add support to save boot count variable in a file in a FAT filesystem.
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > ---
> > > >    doc/README.bootcount                          | 12 ++---
> > > >    drivers/bootcount/Kconfig                     | 53 +++++++++++++------
> > > >    drivers/bootcount/Makefile                    |  2 +-
> > > >    .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
> > > >    4 files changed, 50 insertions(+), 29 deletions(-)
> > > >    rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
> > > > 
> > > > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > > > index f6c5f82f..0f4ffb68 100644
> > > > --- a/doc/README.bootcount
> > > > +++ b/doc/README.bootcount
> > > > @@ -23,15 +23,15 @@ It is the responsibility of some application code
> > > (typically a Linux
> > > >    application) to reset the variable "bootcount" to 0 when the system
> > > booted
> > > >    successfully, thus allowing for more boot cycles.
> > > > 
> > > > -CONFIG_BOOTCOUNT_EXT
> > > > +CONFIG_BOOTCOUNT_FS
> > > >    --------------------
> > > > 
> > > > -This adds support for maintaining boot count in a file on an EXT
> > > filesystem.
> > > > -The file to use is defined by:
> > > > +This adds support for maintaining boot count in a file on a filesystem.
> > > > +Supported filesystems are FAT and EXT. The file to use is defined by:
> > > > 
> > > > -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> > > > -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> > > > -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> > > > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > > > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > > > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> > > > 
> > > >    The format of the file is:
> > > > 
> > > > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > > > index 3c56253b..d3679eb5 100644
> > > > --- a/drivers/bootcount/Kconfig
> > > > +++ b/drivers/bootcount/Kconfig
> > > > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
> > > >    	    Set to the address where the bootcount and bootcount magic
> > > >    	    will be stored.
> > > > 
> > > > -config BOOTCOUNT_EXT
> > > > -	bool "Boot counter on EXT filesystem"
> > > > -	depends on FS_EXT4
> > > > -	select EXT4_WRITE
> > > > +config BOOTCOUNT_FS
> > > > +	bool "Boot counter on a filesystem"
> > > > +	depends on FS_EXT4 || FS_FAT
> > > Do we really need this 'depends on' here? Especially if we have a choice
> > > below...
> > > 
> > Well, probably this is redundant indeed.
> > 
> > > >    	help
> > > >    	  Add support for maintaining boot count in a file on an EXT
> > > The help text is still mentioning EXT here.
> > > 
> > 
> > Ahh, I missed that.
> > 
> > > I would recommend removing it, or listing the supported filesystems at the
> > > moment. While I assume you tested with FAT, I assume that with FS_ANY, any
> > > FS should be supported?
> > > 
> > 
> > Well, I tested it with both FAT and EXT4 and it works. AFAIU, due to the
> > implementation of the filesystem handling code in U-Boot, if the fs supports
> > a write a function, then it should work. But I cannot test for other
> > filesystems apart from FAT and EXT4 so I think it's better to limit the
> > option to these two.
> > 
> 
> I guess we can let people figure things out themselves and add new options
> for when they have tested them, no strong opinion here.
> 
> > > >    	  filesystem.
> > > > @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
> > > >    	  This option enables packing boot count magic value and boot count
> > > >    	  into single word (32 bits).
> > > > 
> > > > -config SYS_BOOTCOUNT_EXT_INTERFACE
> > > > -	string "Interface on which to find boot counter EXT filesystem"
> > > > +if BOOTCOUNT_FS
> > > > +choice
> > > > +	prompt "Filesystem type"
> > > > +	default BOOTCOUNT_EXT
> > > > +
> > > > +config BOOTCOUNT_EXT
> > > > +	bool "Boot counter on EXT filesystem"
> > > > +	depends on FS_EXT4
> > > > +	select EXT4_WRITE
> > > > +	help
> > > > +	  Add support for maintaing boot counter in a file on EXT filesystem"
> > > > +
> > > > +config BOOTCOUNT_FAT
> > > > +	bool "Boot counter on FAT filesystem"
> > > > +	depends on FS_FAT
> > > > +	select FAT_WRITE
> > > > +	help
> > > > +	  Add support for maintaing boot counter in a file on FAT filesystem"
> > > > +
> 
> Seems like I missed a typo here as well:
> 
> s/maintaing/maintaining/ ? At least that's what we have in
> doc/README.bootcount
> 
> > > > +endchoice
> > > > +endif
> > > > +
> > > Since we now support FS_ANY, do we really need this choice at all?
> > > 
> > > Alternatively, should it **really** be a choice and not just a bunch of
> > > configs that depends on BOOTCOUNT_FS + whatever's needed to write on that FS
> > > instead? I think we could have both BOOTCOUNT_EXT and BOOTCOUNT_FAT set
> > > without issue?
> > > 
> > > Cheers,
> > > Quentin
> > 
> > Well, I think I kind of get the point but I am still a bit confused.
> > Do you mean that basically the configuration should be done the other way
> > around? Instead of choosing BOOTCOUNT_FS and then specifically to choose
> > EXT or FAT, to choose one of EXT/FAT and then to select BOOTCOUNT_FS?
> > If yes, what is the advantage of this approach?
> > 
> 
> I'm suggesting:
> 
> """
> config BOOTCOUNT_FS
> 	bool "Boot counter on a filesystem"
>  	help
> 
> config BOOTCOUNT_EXT
> 	bool "Boot counter on EXT filesystem"
>         default y
> 	depends on BOOTCOUNT_FS
> 	depends on FS_EXT4
> 	select EXT4_WRITE
> 	help
> 	  Add support for maintaing boot counter in a file on EXT filesystem"
> 
> config BOOTCOUNT_FAT
> 	bool "Boot counter on FAT filesystem"
> 	depends on BOOTCOUNT_FS
> 	depends on FS_FAT
> 	select FAT_WRITE
> 	help
> 	  Add support for maintaing boot counter in a file on FAT filesystem"
> """
> 
> This way we can have defconfigs where BOOTCOUNT_FAT and BOOTCOUNT_EXT are
> both selected, the user would then be free to decide if the same partition
> on two different devices but for the same purpose can be either ext2/3/4 or
> FAT, without recompiling U-Boot just for that.
> 
> However, it would now be possible to have BOOTCOUNT_FS=y but neither
> BOOTCOUNT_EXT nor BOOTCOUNT_FAT set to y (e.g. if FS_EXT4 or FS_FAT isn't
> defined).
> 

But why having both *_FAT and *_EXT selected at the same time? You have to
specifically mention the device interface and the number of partition to use
from that interface. Also, the bootcount is kept in just one place, so having
enabled both wouldn't it make it incosistent? 

> Finally, the other option was just to NOT have BOOTCOUNT_FAT or
> BOOTCOUNT_EXT and let people select FS_EXT4/FS_FAT and EXT4_WRITE/FAT_WRITE
> themselves since the BOOTCOUNT_FAT/EXT aren't actually used in C code. This
> is less user-friendly though.
> 

This is indeed less user-friendly but on the other hand, the device interface
and the partition number have to be set by the user. So leaving also this
choice to the user shouldn't be that big of a problem, right?

> Cheers,
> Quentin
