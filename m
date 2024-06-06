Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541D9C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742FA88193;
	Thu,  6 Jun 2024 09:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717660719;
	bh=2OKdrf5gnprVwBluHDxxVBoL6fMwSokBh7FZ7Ar/PEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b1gYAixBP1/Kc+/iQ3ypT4CUf5JmPSxuPqqyEclvq/bLoknMGhGIjFXGbf+cY9VCY
	 OLNGHvOqaLJvZSmdzKvy3EvWw4giPV8ycVKtUPAce3LZ5pILJTjUCzeuSQbSGClcmc
	 0DshXE54MJ6RFeDocWk9Y+G+yR3XhuWkr3kcE0TKzUomTRqadjjFkUgb5Y46oRis7G
	 Hp3AAUhgrDVS9jzY/XC7Qwal76rEXula20qbpvLXQMtYg1gIm2jUhSsjgXk670Ygrh
	 GM4uXxebeOe6/IoqKp1SOEqqmQi4/6E5NPMrmKje+BbncY3DXcB+TsDWNzN3WUbZQc
	 aK+qJQTxGlaFA==
Received: from eryximachos (unknown
 [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 114BF87A09;
 Thu,  6 Jun 2024 09:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717660718;
 bh=2OKdrf5gnprVwBluHDxxVBoL6fMwSokBh7FZ7Ar/PEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jJkKOVcw2J0w+7DT65EyfDxmg5hNYrudi+LV9uuSzvPxOeRs+5eK6+XO/bGYjthvY
 8swhEx7Mx22ewaiCYmroo7cozRKWjWDo6XG2Ln49Yv91T6EofqFksLggfCcSAgsqge
 oxN2YkUCIIAZcy8yztNOyVopWZLiudJZIoBh1LhY+y61xXEjLfoQ9HrFA0XRAF/sLv
 SOrER4wWDOhJ8pLRzur5btSugOfBFAjW8MSYkjSTbYad+1cxSLttdvG2EU2W/0/mp4
 ffLUVXGXxCg7EeOw4O4iNSb4t3b2NfSwp5c3T/W67yNH21IDMyGMhTIGZeFeSlRWAF
 foKDtbrLg8Baw==
Date: Thu, 6 Jun 2024 09:58:36 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: trini@konsulko.com, hs@denx.de, vasileios.amoiridis@cern.ch,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH] drivers: bootcount: Add support for FAT filesystem
Message-ID: <ZmFsLMEAQPFuP_aA@eryximachos>
References: <20240605181041.68317-1-vassilisamir@gmail.com>
 <20240605181041.68317-2-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605181041.68317-2-vassilisamir@gmail.com>
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

Hi,

On Wed, Jun 05, 2024 at 08:10:41PM +0200, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Add support to save boot count variable in a file in a FAT filesystem.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>  doc/README.bootcount              | 12 ++++----
>  drivers/bootcount/Kconfig         | 49 +++++++++++++++++++++++--------
>  drivers/bootcount/Makefile        |  2 +-
>  drivers/bootcount/bootcount_ext.c | 18 ++++++++----
>  4 files changed, 56 insertions(+), 25 deletions(-)
> 
> diff --git a/doc/README.bootcount b/doc/README.bootcount
> index f6c5f82f98..cce66d4d70 100644
> --- a/doc/README.bootcount
> +++ b/doc/README.bootcount
> @@ -23,15 +23,17 @@ It is the responsibility of some application code (typically a Linux
>  application) to reset the variable "bootcount" to 0 when the system booted
>  successfully, thus allowing for more boot cycles.
>  
> -CONFIG_BOOTCOUNT_EXT
> +CONFIG_BOOTCOUNT_FS
>  --------------------
>  
> -This adds support for maintaining boot count in a file on an EXT filesystem.
> +This adds support for maintaining boot count in a file on a filesystem.
> +Supported filesystems are FAT and EXT.
> +
>  The file to use is defined by:
>  
> -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> +CONFIG_SYS_BOOTCOUNT_FS_NAME
>  
>  The format of the file is:
>  
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 3c56253b1e..a39a7556bb 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
>  	    Set to the address where the bootcount and bootcount magic
>  	    will be stored.
>  
> -config BOOTCOUNT_EXT
> -	bool "Boot counter on EXT filesystem"
> -	depends on FS_EXT4
> -	select EXT4_WRITE
> +config BOOTCOUNT_FS
> +	bool "Boot counter on filesystem"
> +	depends on FS_EXT4 || FS_FAT
>  	help
>  	  Add support for maintaining boot count in a file on an EXT
>  	  filesystem.

The help message refers to EXT only, not mentioning FAT.

> @@ -177,6 +176,30 @@ config BOOTCOUNT_BOOTLIMIT
>  	  counter being cleared.
>  	  If set to 0, do not set a boot limit in the environment.
>  
> +if BOOTCOUNT_FS
> +choice
> +	prompt "Filesystem type"
> +	default BOOTCOUNT_EXT
> +
> +config BOOTCOUNT_EXT
> +	bool "Boot counter on EXT filesystem"
> +	depends on FS_EXT4
> +	select EXT4_WRITE
> +	help
> +	  Add support for maintaining boot count in a file on an EXT
> +	  filesystem.
> +
> +config BOOTCOUNT_FAT
> +	bool "Boot counter on FAT filesystem"
> +	depends on FS_FAT
> +	select FAT_WRITE
> +	help
> +	  Add support for maintaining boot count in a file on a FAT
> +	  filesystem.
> +
> +endchoice
> +endif
> +
>  config SYS_BOOTCOUNT_SINGLEWORD
>  	bool "Use single word to pack boot count and magic value"
>  	depends on BOOTCOUNT_GENERIC
> @@ -184,26 +207,26 @@ config SYS_BOOTCOUNT_SINGLEWORD
>  	  This option enables packing boot count magic value and boot count
>  	  into single word (32 bits).
>  
> -config SYS_BOOTCOUNT_EXT_INTERFACE
> +config SYS_BOOTCOUNT_FS_INTERFACE
>  	string "Interface on which to find boot counter EXT filesystem"

Same here.

>  	default "mmc"
> -	depends on BOOTCOUNT_EXT
> +	depends on BOOTCOUNT_FS
>  	help
>  	  Set the interface to use when locating the filesystem to use for the
>  	  boot counter.
>  
> -config SYS_BOOTCOUNT_EXT_DEVPART
> +config SYS_BOOTCOUNT_FS_DEVPART
>  	string "Partition of the boot counter EXT filesystem"

And here.

>  	default "0:1"
> -	depends on BOOTCOUNT_EXT
> +	depends on BOOTCOUNT_FS
>  	help
>  	  Set the partition to use when locating the filesystem to use for the
>  	  boot counter.
>  
> -config SYS_BOOTCOUNT_EXT_NAME
> +config SYS_BOOTCOUNT_FS_NAME
>  	string "Path and filename of the EXT filesystem based boot counter"

And here. Other than that
Reviewed-by: Philip Oberfichtner <pro@denx.de>

>  	default "/boot/failures"
> -	depends on BOOTCOUNT_EXT
> +	depends on BOOTCOUNT_FS
>  	help
>  	  Set the filename and path of the file used to store the boot counter.
>  
> @@ -211,18 +234,18 @@ config SYS_BOOTCOUNT_ADDR
>  	hex "RAM address used for reading and writing the boot counter"
>  	default 0x44E3E000 if BOOTCOUNT_AM33XX || BOOTCOUNT_AM33XX_NVMEM
>  	default 0xE0115FF8 if ARCH_LS1043A || ARCH_LS1021A
> -	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> +	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
>  		   BOOTCOUNT_AM33XX_NVMEM
>  	help
>  	  Set the address used for reading and writing the boot counter.
>  
>  config SYS_BOOTCOUNT_MAGIC
>  	hex "Magic value for the boot counter"
> -	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> +	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
>  			      BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
>  			      BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT
>  	default 0xB0 if BOOTCOUNT_AM33XX_NVMEM
> -	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> +	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
>  		   BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
>  		   BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
>  		   BOOTCOUNT_AM33XX_NVMEM
> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> index e7771f5b36..c0427434d7 100644
> --- a/drivers/bootcount/Makefile
> +++ b/drivers/bootcount/Makefile
> @@ -6,7 +6,7 @@ obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
>  obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
>  obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
>  obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
> -obj-$(CONFIG_BOOTCOUNT_EXT)	+= bootcount_ext.o
> +obj-$(CONFIG_BOOTCOUNT_FS)	+= bootcount_ext.o
>  obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)	+= bootcount_nvmem.o
>  
>  obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
> diff --git a/drivers/bootcount/bootcount_ext.c b/drivers/bootcount/bootcount_ext.c
> index 9639e638e9..660bea2db2 100644
> --- a/drivers/bootcount/bootcount_ext.c
> +++ b/drivers/bootcount/bootcount_ext.c
> @@ -19,14 +19,20 @@ typedef struct {
>  
>  static u8 upgrade_available = 1;
>  
> +#ifdef BOOTCOUNT_EXT
> +static u8 bootcount_fstype = FS_TYPE_EXT;
> +#else
> +static u8 bootcount_fstype = FS_TYPE_FAT;
> +#endif
> +
>  void bootcount_store(ulong a)
>  {
>  	bootcount_ext_t *buf;
>  	loff_t len;
>  	int ret;
>  
> -	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
> -			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
> +	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
> +			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, bootcount_fstype)) {
>  		puts("Error selecting device\n");
>  		return;
>  	}
> @@ -42,7 +48,7 @@ void bootcount_store(ulong a)
>  	buf->upgrade_available = upgrade_available;
>  	unmap_sysmem(buf);
>  
> -	ret = fs_write(CONFIG_SYS_BOOTCOUNT_EXT_NAME,
> +	ret = fs_write(CONFIG_SYS_BOOTCOUNT_FS_NAME,
>  		       CONFIG_SYS_BOOTCOUNT_ADDR, 0, sizeof(bootcount_ext_t),
>  		       &len);
>  	if (ret != 0)
> @@ -55,13 +61,13 @@ ulong bootcount_load(void)
>  	loff_t len_read;
>  	int ret;
>  
> -	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
> -			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
> +	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
> +			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, bootcount_fstype)) {
>  		puts("Error selecting device\n");
>  		return 0;
>  	}
>  
> -	ret = fs_read(CONFIG_SYS_BOOTCOUNT_EXT_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
> +	ret = fs_read(CONFIG_SYS_BOOTCOUNT_FS_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
>  		      0, sizeof(bootcount_ext_t), &len_read);
>  	if (ret != 0 || len_read != sizeof(bootcount_ext_t)) {
>  		puts("Error loading bootcount\n");
> 
> base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
> -- 
> 2.34.1
> 

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
