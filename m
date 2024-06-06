Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584AFC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 06:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851E888224;
	Fri,  7 Jun 2024 08:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QEm+YkOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905A488428; Thu,  6 Jun 2024 19:11:11 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706D080E9A
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 19:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6265d48ec3so151137566b.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717693869; x=1718298669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BIIDtk8w0dhjE+3z4dNv5EMRTLcUwaMMq0vkP1dx9S0=;
 b=QEm+YkOzAB0s90IRylhzh3fUSnySXeSRrcard9dZhsMqgO+1rmg1cSeyoZV+xMJj79
 giJL3CVh0GSQDKBIcfwtkZZsLNm7turWTr7fryNsoVZXHSkdEtc0jnbQQhyXREuyX43u
 GAo0WC9fHbPNdtSAhZPnJCI7id5XhMOUmIzAzuwo2BZFDoPXzqwqDO5vQJmHBIaqev5/
 5avwtp/07q90iHsXBwt6qQxXUEH0pkbE5iQpjus7gpSMZfZvxOXvzLZuz74uFcnsEKvB
 7jSNoCnPYyD5RTBDHfIn4JwvFfg1tIDoVLK/c14gfY3+3f3cnON5BL4h03TNjDMfQwTV
 AR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717693869; x=1718298669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIIDtk8w0dhjE+3z4dNv5EMRTLcUwaMMq0vkP1dx9S0=;
 b=xJPsJGx91xLnk+YgwhUySaV58CtAPQTdz0czOoH/h5mJTNQgYw75Ytx7rKdZb2inRt
 mkqPl30JtlQMcc59qIbo37QvC15/dQ7PniAojN1wH/A7jFRyynVfEsiNcPaED91wheWa
 v4bw43BdlixvT1Wv3OPc5bN+WL3U/omSLFlWKuNzXBO2c0OcuDmwhV/BD0cdR2E0vOam
 yIOrWFUaAN2C03E7wpoNR+7br0C5lO/4JzECsMPzqGQLEuOyOcW53U5uU9ow6niDgOPB
 unQ/83gUvVcuA/kXA+MMAPhPK9IV9i3LZ1JqmlzsFhaNL+v7B2XU+ReApy9PVR2xaLyx
 5fPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU68GQhBnbrRZ2DRIYnN7Agt9oliVHWVh8VIt1taBbP2gLy/dA2V2NW2ZffzmxP9pKvv21CIZOIhmlqz2aqPnOlsMsFDA==
X-Gm-Message-State: AOJu0YxlpRyU9D8/U6Efq94wokjPDxRrU0TasE2YGg7QDWQlkXzn19tk
 Yr4T9arQQqUoBmq376arvXVlF8UtN0ew45urOKuw5pUZJxtIGD2mtnnmF2wz
X-Google-Smtp-Source: AGHT+IEITO6ysrEgNEPW9r6dgEcxd4eEAEC6wUHftLL5BQ6PKaOPlCXedm8bLESmanUDI6ApZfhfLg==
X-Received: by 2002:a17:906:1d5b:b0:a65:4268:dfca with SMTP id
 a640c23a62f3a-a6cdb9ddff5mr10635166b.65.1717693868508; 
 Thu, 06 Jun 2024 10:11:08 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80582030sm121399566b.33.2024.06.06.10.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 10:11:07 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 6 Jun 2024 19:11:06 +0200
To: Philip Oberfichtner <pro@denx.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [RFC PATCH] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240606171106.GA123822@vamoiridPC>
References: <20240605181041.68317-1-vassilisamir@gmail.com>
 <20240605181041.68317-2-vassilisamir@gmail.com>
 <ZmFsLMEAQPFuP_aA@eryximachos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFsLMEAQPFuP_aA@eryximachos>
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

On Thu, Jun 06, 2024 at 09:58:36AM +0200, Philip Oberfichtner wrote:
> Hi,
> 
> On Wed, Jun 05, 2024 at 08:10:41PM +0200, Vasileios Amoiridis wrote:
> > From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > 
> > Add support to save boot count variable in a file in a FAT filesystem.
> > 
> > Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> > ---
> >  doc/README.bootcount              | 12 ++++----
> >  drivers/bootcount/Kconfig         | 49 +++++++++++++++++++++++--------
> >  drivers/bootcount/Makefile        |  2 +-
> >  drivers/bootcount/bootcount_ext.c | 18 ++++++++----
> >  4 files changed, 56 insertions(+), 25 deletions(-)
> > 
> > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > index f6c5f82f98..cce66d4d70 100644
> > --- a/doc/README.bootcount
> > +++ b/doc/README.bootcount
> > @@ -23,15 +23,17 @@ It is the responsibility of some application code (typically a Linux
> >  application) to reset the variable "bootcount" to 0 when the system booted
> >  successfully, thus allowing for more boot cycles.
> >  
> > -CONFIG_BOOTCOUNT_EXT
> > +CONFIG_BOOTCOUNT_FS
> >  --------------------
> >  
> > -This adds support for maintaining boot count in a file on an EXT filesystem.
> > +This adds support for maintaining boot count in a file on a filesystem.
> > +Supported filesystems are FAT and EXT.
> > +
> >  The file to use is defined by:
> >  
> > -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> > -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> > -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> >  
> >  The format of the file is:
> >  
> > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > index 3c56253b1e..a39a7556bb 100644
> > --- a/drivers/bootcount/Kconfig
> > +++ b/drivers/bootcount/Kconfig
> > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
> >  	    Set to the address where the bootcount and bootcount magic
> >  	    will be stored.
> >  
> > -config BOOTCOUNT_EXT
> > -	bool "Boot counter on EXT filesystem"
> > -	depends on FS_EXT4
> > -	select EXT4_WRITE
> > +config BOOTCOUNT_FS
> > +	bool "Boot counter on filesystem"
> > +	depends on FS_EXT4 || FS_FAT
> >  	help
> >  	  Add support for maintaining boot count in a file on an EXT
> >  	  filesystem.
> 
> The help message refers to EXT only, not mentioning FAT.
> 

Ack.

> > @@ -177,6 +176,30 @@ config BOOTCOUNT_BOOTLIMIT
> >  	  counter being cleared.
> >  	  If set to 0, do not set a boot limit in the environment.
> >  
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
> > +	  Add support for maintaining boot count in a file on an EXT
> > +	  filesystem.
> > +
> > +config BOOTCOUNT_FAT
> > +	bool "Boot counter on FAT filesystem"
> > +	depends on FS_FAT
> > +	select FAT_WRITE
> > +	help
> > +	  Add support for maintaining boot count in a file on a FAT
> > +	  filesystem.
> > +
> > +endchoice
> > +endif
> > +
> >  config SYS_BOOTCOUNT_SINGLEWORD
> >  	bool "Use single word to pack boot count and magic value"
> >  	depends on BOOTCOUNT_GENERIC
> > @@ -184,26 +207,26 @@ config SYS_BOOTCOUNT_SINGLEWORD
> >  	  This option enables packing boot count magic value and boot count
> >  	  into single word (32 bits).
> >  
> > -config SYS_BOOTCOUNT_EXT_INTERFACE
> > +config SYS_BOOTCOUNT_FS_INTERFACE
> >  	string "Interface on which to find boot counter EXT filesystem"
> 
> Same here.
> 

Ack.

> >  	default "mmc"
> > -	depends on BOOTCOUNT_EXT
> > +	depends on BOOTCOUNT_FS
> >  	help
> >  	  Set the interface to use when locating the filesystem to use for the
> >  	  boot counter.
> >  
> > -config SYS_BOOTCOUNT_EXT_DEVPART
> > +config SYS_BOOTCOUNT_FS_DEVPART
> >  	string "Partition of the boot counter EXT filesystem"
> 
> And here.
> 

Ack.

> >  	default "0:1"
> > -	depends on BOOTCOUNT_EXT
> > +	depends on BOOTCOUNT_FS
> >  	help
> >  	  Set the partition to use when locating the filesystem to use for the
> >  	  boot counter.
> >  
> > -config SYS_BOOTCOUNT_EXT_NAME
> > +config SYS_BOOTCOUNT_FS_NAME
> >  	string "Path and filename of the EXT filesystem based boot counter"
> 
> And here. Other than that
> Reviewed-by: Philip Oberfichtner <pro@denx.de>
> 

Ack.

Cheers,
Vasilis

> >  	default "/boot/failures"
> > -	depends on BOOTCOUNT_EXT
> > +	depends on BOOTCOUNT_FS
> >  	help
> >  	  Set the filename and path of the file used to store the boot counter.
> >  
> > @@ -211,18 +234,18 @@ config SYS_BOOTCOUNT_ADDR
> >  	hex "RAM address used for reading and writing the boot counter"
> >  	default 0x44E3E000 if BOOTCOUNT_AM33XX || BOOTCOUNT_AM33XX_NVMEM
> >  	default 0xE0115FF8 if ARCH_LS1043A || ARCH_LS1021A
> > -	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> > +	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
> >  		   BOOTCOUNT_AM33XX_NVMEM
> >  	help
> >  	  Set the address used for reading and writing the boot counter.
> >  
> >  config SYS_BOOTCOUNT_MAGIC
> >  	hex "Magic value for the boot counter"
> > -	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> > +	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
> >  			      BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
> >  			      BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT
> >  	default 0xB0 if BOOTCOUNT_AM33XX_NVMEM
> > -	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> > +	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
> >  		   BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
> >  		   BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
> >  		   BOOTCOUNT_AM33XX_NVMEM
> > diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> > index e7771f5b36..c0427434d7 100644
> > --- a/drivers/bootcount/Makefile
> > +++ b/drivers/bootcount/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
> >  obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
> >  obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
> >  obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
> > -obj-$(CONFIG_BOOTCOUNT_EXT)	+= bootcount_ext.o
> > +obj-$(CONFIG_BOOTCOUNT_FS)	+= bootcount_ext.o
> >  obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)	+= bootcount_nvmem.o
> >  
> >  obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
> > diff --git a/drivers/bootcount/bootcount_ext.c b/drivers/bootcount/bootcount_ext.c
> > index 9639e638e9..660bea2db2 100644
> > --- a/drivers/bootcount/bootcount_ext.c
> > +++ b/drivers/bootcount/bootcount_ext.c
> > @@ -19,14 +19,20 @@ typedef struct {
> >  
> >  static u8 upgrade_available = 1;
> >  
> > +#ifdef BOOTCOUNT_EXT
> > +static u8 bootcount_fstype = FS_TYPE_EXT;
> > +#else
> > +static u8 bootcount_fstype = FS_TYPE_FAT;
> > +#endif
> > +
> >  void bootcount_store(ulong a)
> >  {
> >  	bootcount_ext_t *buf;
> >  	loff_t len;
> >  	int ret;
> >  
> > -	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
> > -			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
> > +	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
> > +			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, bootcount_fstype)) {
> >  		puts("Error selecting device\n");
> >  		return;
> >  	}
> > @@ -42,7 +48,7 @@ void bootcount_store(ulong a)
> >  	buf->upgrade_available = upgrade_available;
> >  	unmap_sysmem(buf);
> >  
> > -	ret = fs_write(CONFIG_SYS_BOOTCOUNT_EXT_NAME,
> > +	ret = fs_write(CONFIG_SYS_BOOTCOUNT_FS_NAME,
> >  		       CONFIG_SYS_BOOTCOUNT_ADDR, 0, sizeof(bootcount_ext_t),
> >  		       &len);
> >  	if (ret != 0)
> > @@ -55,13 +61,13 @@ ulong bootcount_load(void)
> >  	loff_t len_read;
> >  	int ret;
> >  
> > -	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
> > -			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
> > +	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
> > +			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, bootcount_fstype)) {
> >  		puts("Error selecting device\n");
> >  		return 0;
> >  	}
> >  
> > -	ret = fs_read(CONFIG_SYS_BOOTCOUNT_EXT_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
> > +	ret = fs_read(CONFIG_SYS_BOOTCOUNT_FS_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
> >  		      0, sizeof(bootcount_ext_t), &len_read);
> >  	if (ret != 0 || len_read != sizeof(bootcount_ext_t)) {
> >  		puts("Error loading bootcount\n");
> > 
> > base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
> > -- 
> > 2.34.1
> > 
> 
> -- 
> =====================================================================
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
> =====================================================================
