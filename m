Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9627C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 17:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA5E886F2;
	Tue, 11 Jun 2024 19:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzfejM/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B692D886E2; Tue, 11 Jun 2024 18:21:04 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973D9886C0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so115900061fa.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718122862; x=1718727662; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gmu5YWCtjZu1ubYTqKFsjetdCzwHZfrVSRYtFqVSaxY=;
 b=OzfejM/Tl32CgXDJoO/jr4soIZ/e/5I9nhPdLGEZKFLR/QRwvW41fUI72POxk7W1FP
 IwszoP9ujmgI1AO9j9gJhsnLhpyw+c2DkjvoWqG/5HZiN9t2KOER1BoSFTOqftd027BK
 gYW/ain3SgiXhNPh4EQql4fUJmh0WTJwOlHTkffq5NLT/XdW23mIp6l+HzBXjS1B2doW
 ma8r2QgbtaBGlkhtcA3TRziAKBhvmr3AG+ULF/MQHS4/eFkhj040sSS2yYLe61ITEy5f
 5jr/Wcj9bgUcnkF4slrE5+lzZRolBTahIx83a0Vp8nU5oWgzY5mUsKAl7WugNdej9Sp1
 Sglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122862; x=1718727662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmu5YWCtjZu1ubYTqKFsjetdCzwHZfrVSRYtFqVSaxY=;
 b=J4S2Qv2rAXI7njAZKoA609sH532AzkUeDURqDuTl8RAYx5imnH14WQs+aFc9J1N8QV
 bqnZGahgD/sr40gfhnp8gYcIUq7Y77K8w6I+7NYIRiimjSUQARYGtsWldrnVURjy4KsP
 zeofjPiF//ckWrLj8KCiAXD8iBPrf6UfWlBwwgEf1Pqjx4vm7lLjY7UwOQG/Zgv8p4G7
 jJMYDwHaWYItWzfgmHy8VltuN79G7lnfBPFaaiI0lbA9lCvp+IOiDMp9AKkGCV2ej0dZ
 ku8DzneqGYWMIAq3UULCkU4grvfgbDM+AECiDIl18nWwm8gR7aMXppUkksQnwFcpmUwU
 kkiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEGP+EKtekGDAuZJCCGBNsKODE3l6HNW8tSwuvfA1+ny/qtK5mnROhSGIwh+MoYwW9UvkH92lfpdKeieyKZwTtCSSirw==
X-Gm-Message-State: AOJu0YzA02uNKOoeR8FIORNU9FLYizvNJkqze250CT+RSFtM75fH2GN/
 UozHb7ncvn3bDmmpODnNajoMGM4JCSKw9CmiF0JD82C2TMgO31V2
X-Google-Smtp-Source: AGHT+IGbRfyfLuuOYL2nvNexIhwo2qR/Fc5ZQUrGDnAUQWfk4dlH6kU/oMqo+Ezb6CnX7lNyb5FUXw==
X-Received: by 2002:a2e:9b57:0:b0:2eb:d963:d8cc with SMTP id
 38308e7fff4ca-2ebd963dbffmr65408161fa.49.1718122861485; 
 Tue, 11 Jun 2024 09:21:01 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:495b:e8ce:9b90:3908])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c81d8d79bsm3947413a12.45.2024.06.11.09.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:21:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 11 Jun 2024 18:20:59 +0200
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, hs@denx.de,
 pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240611162059.GC441859@vamoiridPC>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
 <20240611152733.GA441859@vamoiridPC>
 <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
 <20240611160659.GH68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611160659.GH68077@bill-the-cat>
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

On Tue, Jun 11, 2024 at 10:06:59AM -0600, Tom Rini wrote:
> On Tue, Jun 11, 2024 at 05:41:19PM +0200, Quentin Schulz wrote:
> > Hi Vasileios,
> > 
> > On 6/11/24 5:27 PM, Vasileios Amoiridis wrote:
> > > On Tue, Jun 11, 2024 at 11:33:12AM +0200, Quentin Schulz wrote:
> > > > Hi Vasileios,
> > > > 
> > > > On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
> > > > > Add support to save boot count variable in a file in a FAT filesystem.
> > > > > 
> > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > > ---
> > > > >    doc/README.bootcount                          | 12 ++---
> > > > >    drivers/bootcount/Kconfig                     | 53 +++++++++++++------
> > > > >    drivers/bootcount/Makefile                    |  2 +-
> > > > >    .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
> > > > >    4 files changed, 50 insertions(+), 29 deletions(-)
> > > > >    rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
> > > > > 
> > > > > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > > > > index f6c5f82f..0f4ffb68 100644
> > > > > --- a/doc/README.bootcount
> > > > > +++ b/doc/README.bootcount
> > > > > @@ -23,15 +23,15 @@ It is the responsibility of some application code
> > > > (typically a Linux
> > > > >    application) to reset the variable "bootcount" to 0 when the system
> > > > booted
> > > > >    successfully, thus allowing for more boot cycles.
> > > > > 
> > > > > -CONFIG_BOOTCOUNT_EXT
> > > > > +CONFIG_BOOTCOUNT_FS
> > > > >    --------------------
> > > > > 
> > > > > -This adds support for maintaining boot count in a file on an EXT
> > > > filesystem.
> > > > > -The file to use is defined by:
> > > > > +This adds support for maintaining boot count in a file on a filesystem.
> > > > > +Supported filesystems are FAT and EXT. The file to use is defined by:
> > > > > 
> > > > > -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> > > > > -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> > > > > -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> > > > > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > > > > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > > > > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> > > > > 
> > > > >    The format of the file is:
> > > > > 
> > > > > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > > > > index 3c56253b..d3679eb5 100644
> > > > > --- a/drivers/bootcount/Kconfig
> > > > > +++ b/drivers/bootcount/Kconfig
> > > > > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
> > > > >    	    Set to the address where the bootcount and bootcount magic
> > > > >    	    will be stored.
> > > > > 
> > > > > -config BOOTCOUNT_EXT
> > > > > -	bool "Boot counter on EXT filesystem"
> > > > > -	depends on FS_EXT4
> > > > > -	select EXT4_WRITE
> > > > > +config BOOTCOUNT_FS
> > > > > +	bool "Boot counter on a filesystem"
> > > > > +	depends on FS_EXT4 || FS_FAT
> > > > Do we really need this 'depends on' here? Especially if we have a choice
> > > > below...
> > > > 
> > > Well, probably this is redundant indeed.
> > > 
> > > > >    	help
> > > > >    	  Add support for maintaining boot count in a file on an EXT
> > > > The help text is still mentioning EXT here.
> > > > 
> > > 
> > > Ahh, I missed that.
> > > 
> > > > I would recommend removing it, or listing the supported filesystems at the
> > > > moment. While I assume you tested with FAT, I assume that with FS_ANY, any
> > > > FS should be supported?
> > > > 
> > > 
> > > Well, I tested it with both FAT and EXT4 and it works. AFAIU, due to the
> > > implementation of the filesystem handling code in U-Boot, if the fs supports
> > > a write a function, then it should work. But I cannot test for other
> > > filesystems apart from FAT and EXT4 so I think it's better to limit the
> > > option to these two.
> > > 
> > 
> > I guess we can let people figure things out themselves and add new options
> > for when they have tested them, no strong opinion here.
> > 
> > > > >    	  filesystem.
> > > > > @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
> > > > >    	  This option enables packing boot count magic value and boot count
> > > > >    	  into single word (32 bits).
> > > > > 
> > > > > -config SYS_BOOTCOUNT_EXT_INTERFACE
> > > > > -	string "Interface on which to find boot counter EXT filesystem"
> > > > > +if BOOTCOUNT_FS
> > > > > +choice
> > > > > +	prompt "Filesystem type"
> > > > > +	default BOOTCOUNT_EXT
> > > > > +
> > > > > +config BOOTCOUNT_EXT
> > > > > +	bool "Boot counter on EXT filesystem"
> > > > > +	depends on FS_EXT4
> > > > > +	select EXT4_WRITE
> > > > > +	help
> > > > > +	  Add support for maintaing boot counter in a file on EXT filesystem"
> > > > > +
> > > > > +config BOOTCOUNT_FAT
> > > > > +	bool "Boot counter on FAT filesystem"
> > > > > +	depends on FS_FAT
> > > > > +	select FAT_WRITE
> > > > > +	help
> > > > > +	  Add support for maintaing boot counter in a file on FAT filesystem"
> > > > > +
> > 
> > Seems like I missed a typo here as well:
> > 
> > s/maintaing/maintaining/ ? At least that's what we have in
> > doc/README.bootcount
> > 
> > > > > +endchoice
> > > > > +endif
> > > > > +
> > > > Since we now support FS_ANY, do we really need this choice at all?
> > > > 
> > > > Alternatively, should it **really** be a choice and not just a bunch of
> > > > configs that depends on BOOTCOUNT_FS + whatever's needed to write on that FS
> > > > instead? I think we could have both BOOTCOUNT_EXT and BOOTCOUNT_FAT set
> > > > without issue?
> > > > 
> > > > Cheers,
> > > > Quentin
> > > 
> > > Well, I think I kind of get the point but I am still a bit confused.
> > > Do you mean that basically the configuration should be done the other way
> > > around? Instead of choosing BOOTCOUNT_FS and then specifically to choose
> > > EXT or FAT, to choose one of EXT/FAT and then to select BOOTCOUNT_FS?
> > > If yes, what is the advantage of this approach?
> > > 
> > 
> > I'm suggesting:
> > 
> > """
> > config BOOTCOUNT_FS
> > 	bool "Boot counter on a filesystem"
> >  	help
> > 
> > config BOOTCOUNT_EXT
> > 	bool "Boot counter on EXT filesystem"
> >         default y
> > 	depends on BOOTCOUNT_FS
> > 	depends on FS_EXT4
> > 	select EXT4_WRITE
> > 	help
> > 	  Add support for maintaing boot counter in a file on EXT filesystem"
> > 
> > config BOOTCOUNT_FAT
> > 	bool "Boot counter on FAT filesystem"
> > 	depends on BOOTCOUNT_FS
> > 	depends on FS_FAT
> > 	select FAT_WRITE
> > 	help
> > 	  Add support for maintaing boot counter in a file on FAT filesystem"
> > """
> > 
> > This way we can have defconfigs where BOOTCOUNT_FAT and BOOTCOUNT_EXT are
> > both selected, the user would then be free to decide if the same partition
> > on two different devices but for the same purpose can be either ext2/3/4 or
> > FAT, without recompiling U-Boot just for that.
> > 
> > However, it would now be possible to have BOOTCOUNT_FS=y but neither
> > BOOTCOUNT_EXT nor BOOTCOUNT_FAT set to y (e.g. if FS_EXT4 or FS_FAT isn't
> > defined).
> > 
> > Finally, the other option was just to NOT have BOOTCOUNT_FAT or
> > BOOTCOUNT_EXT and let people select FS_EXT4/FS_FAT and EXT4_WRITE/FAT_WRITE
> > themselves since the BOOTCOUNT_FAT/EXT aren't actually used in C code. This
> > is less user-friendly though.
> 
> I was thinking that with FS_ANY, we don't need a symbol per filesystem
> type but can just handle it in the help text with something like "Please
> ensure that you have enabled write support for the filesystem that you
> will be used by the partition that you configure this feature for."
> 

Hi Tom,

I see that both you and Quentin are leaning towards this solution which is
totally fine by me. As I said before, the user already needs to specify the
device interface and the partition to be used so they can also be
responsible to enable the appropriate filesystem write functionality. Indeed
if more filesystems are added, it would be quite ugly to have multiple
symbols just to choose a config.

Also, if the user forgets to enable the appropriate *_WRITE config, it will
trigger an error message in U-Boot that this operation is not supported
which will be pretty obvious what needs to be done.

So I can go with a v3, following your proposals.

Cheers,
Vasilis
> -- 
> Tom


