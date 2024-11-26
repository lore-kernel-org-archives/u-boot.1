Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E145D3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7715890DF;
	Tue, 26 Nov 2024 10:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LkPvVnOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16EE089189; Tue, 26 Nov 2024 10:20:04 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27BF890BC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so20397315e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732612799; x=1733217599;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8eP+vUNblywDBzNEvpTVQwWowwWphbYZfR7M1H5AP9w=;
 b=LkPvVnOEFPRiXNK0AlH6QS05/tAaRf+FPIEOzjgY9nDgF3Nf/epZPvj4D5CfjOggLN
 ZzKoXTqoQ7zW81B3K7+yLAIP7EBCG+OHcm4B/0yUr0eTMUNBSr7z/0grY1kOqsNsJMBL
 N8cA523OdbhJiL+7qFvhVgL/W7PExBRdkfIhR1ztjx45wIFkSae54l9eVioUt8Aom+zr
 +V+NBLIOYm4dpO2S/H3b5I9VGImhnPruwE8ollg3nCF+fhXRmbiEsWo8/gikgp6+6uoU
 M5H+ikmN9AAxaarA+9BPomB3Dgl8lrHCY5EzNKGIqfQaYg7Opk1nUUDVifDRyxoIjXAB
 CkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732612799; x=1733217599;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8eP+vUNblywDBzNEvpTVQwWowwWphbYZfR7M1H5AP9w=;
 b=iZb8oOh9zQ68JMptIBl68mbNGjvOjgXAYwSxHQS45F+3TrtAvyHKO5W6UDXZ1rGqHB
 6jTZmvAkPeEEiKODl+pDO29gfG9nPKpLkioImsPZFdAoa9WSbGJ0zNPK4SYlSn1iDgCc
 6DodsVZDUwJUWGcZCv6WElwCob8fHNxH3LKLbwL4jq4FJZVZOI6VqejkLY1kaHmrVm/C
 6Gys+059Ez4XwgGaP9wt2wa9an2fud3raNNi2e/Lcm6Y6LR7CNVmtGBsBChF9FDf3VFj
 VacVwLoW7PrlzjAMjQQQEztio237ShvZYlq8b73/0LlPYatOhMcgaxALdd31WEItoF/e
 X/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ilgDt6wMvI+mpSqfQrVs8e3qIMWxthfiIkLzXqRn758Zn5QBFuIhOV89btdxxpkDC/ofIVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxHNKfFvsgIn9lT/EuZXLBEM25pJLtub6gi7SSp7c1nXaNj/RsP
 gSavTpjabDzUMFVN1xanv3zGGKD6McAHtx2h806hWKdVHreEOCwaapc/NqzmKXRaKyvA+s/H50o
 /
X-Gm-Gg: ASbGncsKb5YcUV6fNh3mCGO8KhzRIivfpWnkBD8YiRsrOUSyXBV48QH+lPKT9/kt0Zt
 Spr2F+j85Y3+AoVnlUWnZHnnueH3sNfDDnUCHApA5AzDpdT4FHwwkxf49vZ27fLAgeudGc8M27M
 q4YLz6PiEynHm2HHFMLMAt3NjDvAQ90FFvVGrXNo7Sq7zASt4Gn5fnu+XtlP01Mrcv3yXjOX31O
 Imy6HdEq5TYszM9nQkm5D6jC+D9j4Y2ZxbkVNC44fzjECPvjTeqVQ==
X-Google-Smtp-Source: AGHT+IEGps2s9XVnVRkweybA2HZIhYeH/IR3QxnOS7lNTNWShVHZt7PY4dVRXSR5yB8s1asrfGhrKw==
X-Received: by 2002:a05:600c:4f16:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-434a852bb86mr3708685e9.15.1732612799271; 
 Tue, 26 Nov 2024 01:19:59 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a6459f0dsm16058305e9.23.2024.11.26.01.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 01:19:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, jerome.forissier@linaro.org,
 avromanov@salutedevices.com, sjg@chromium.org, ion@agorria.com,
 clamor95@gmail.com, quentin.schulz@cherry.de, u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: fastboot: Enable flashing support for UFS
In-Reply-To: <Z0VZqWbA8avK0cjU@hu-varada-blr.qualcomm.com>
References: <20241125110354.602124-1-quic_varada@quicinc.com>
 <d741a762-f56d-44b9-898f-38a4ae3c5689@linaro.org>
 <Z0VZqWbA8avK0cjU@hu-varada-blr.qualcomm.com>
Date: Tue, 26 Nov 2024 10:19:56 +0100
Message-ID: <87y116pd1f.fsf@baylibre.com>
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

Hi Varadarajan,

Thank you for the patch.

On mar., nov. 26, 2024 at 10:46, Varadarajan Narayanan <quic_varada@quicinc.com> wrote:

> On Mon, Nov 25, 2024 at 06:59:40PM +0100, Caleb Connolly wrote:
>> Hi Varadarajan,
>>
>> On 25/11/2024 12:03, Varadarajan Narayanan wrote:
>> > MMC and UFS seem to execute very similar steps to identify the
>> > partition and write to it. Hence try to enable fastboot flashing
>> > support in UFS leveraging the MMC functions.
>>
>> Thanks for this! Do you think we could make this dynamic at runtime?
>> Since it's currently possible to build a single binary with
>> qcom_defconfig that will work across a wide range of boards (both with
>> eMMC and UFS), I don't think it makes sense to pick a fastboot backend
>> at build time.
>>
>> Some additional comments below.
>> >
>> > Tested on rb3gen2 platform.
>> >
>> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Seems there is a bit of an overlap with Dmitrii's work here:

https://patchwork.ozlabs.org/project/uboot/patch/20240306185921.1854109-2-dimorinny@google.com/

>> > ---
>> >  drivers/fastboot/Kconfig      | 19 +++++++++++++++---
>> >  drivers/fastboot/Makefile     |  1 +
>> >  drivers/fastboot/fb_command.c |  6 ++++--
>> >  drivers/fastboot/fb_mmc.c     | 36 ++++++++++++++++++++++++-----------
>> >  4 files changed, 46 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> > index 1eb460f5a0..5c41fc4684 100644
>> > --- a/drivers/fastboot/Kconfig
>> > +++ b/drivers/fastboot/Kconfig
>> > @@ -92,7 +92,7 @@ config FASTBOOT_USB_DEV
>> >  config FASTBOOT_FLASH
>> >  	bool "Enable FASTBOOT FLASH command"
>> >  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
>> > -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>> > +	depends on MMC || UFS || (MTD_RAW_NAND && CMD_MTDPARTS)
>> >  	select IMAGE_SPARSE
>> >  	help
>> >  	  The fastboot protocol includes a "flash" command for writing
>> > @@ -120,6 +120,10 @@ config FASTBOOT_FLASH_NAND
>> >  	bool "FASTBOOT on NAND"
>> >  	depends on MTD_RAW_NAND && CMD_MTDPARTS
>> >
>> > +config FASTBOOT_FLASH_UFS
>> > +	bool "FASTBOOT on UFS"
>> > +	depends on UFS && EFI_PARTITION
>> > +
>> >  endchoice
>> >
>> >  config FASTBOOT_FLASH_MMC_DEV
>> > @@ -133,6 +137,15 @@ config FASTBOOT_FLASH_MMC_DEV
>> >  	  regarding the non-volatile storage device. Define this to
>> >  	  the eMMC device that fastboot should use to store the image.
>> >
>> > +config FASTBOOT_FLASH_UFS_DEV
>> > +	int "Define FASTBOOT UFS FLASH default device"
>> > +	depends on FASTBOOT_FLASH_UFS
>> > +	default 0 if CONFIG_ARCH_SNAPDRAGON

Remove CONFIG_*
Should be:

	default 0 if ARCH_SNAPDRAGON

>> > +	help
>> > +	  The fastboot "flash" command requires additional information
>> > +	  regarding the non-volatile storage device. Define this to
>> > +	  the UFS device that fastboot should use to store the image.
>>
>> This doesn't map at all to how fastboot is intended to work. We would
>> expect to see all partitions exposed not just those of a specific LUN.
>
> Yes. Took this approach as this would easily align with the MMC's
> way of searching for a partition. Will fix this.

I agree with Caleb's point.

>
>> > +
>> >  config FASTBOOT_FLASH_NAND_TRIMFFS
>> >  	bool "Skip empty pages when flashing NAND"
>> >  	depends on FASTBOOT_FLASH_NAND
>> > @@ -196,7 +209,7 @@ config FASTBOOT_MMC_USER_NAME
>> >
>> >  config FASTBOOT_GPT_NAME
>> >  	string "Target name for updating GPT"
>> > -	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
>> > +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && EFI_PARTITION
>> >  	default "gpt"
>> >  	help
>> >  	  The fastboot "flash" command supports writing the downloaded
>> > @@ -209,7 +222,7 @@ config FASTBOOT_GPT_NAME
>> >
>> >  config FASTBOOT_MBR_NAME
>> >  	string "Target name for updating MBR"
>> > -	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
>> > +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && DOS_PARTITION
>> >  	default "mbr"
>> >  	help
>> >  	  The fastboot "flash" command allows to write the downloaded image
>> > diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
>> > index 048af5aa82..772276cb6c 100644
>> > --- a/drivers/fastboot/Makefile
>> > +++ b/drivers/fastboot/Makefile
>> > @@ -4,4 +4,5 @@ obj-y += fb_common.o
>> >  obj-y += fb_getvar.o
>> >  obj-y += fb_command.o
>> >  obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
>> > +obj-$(CONFIG_FASTBOOT_FLASH_UFS) += fb_mmc.o
>> >  obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
>> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>> > index e4484d65ac..a6fa8299b8 100644
>> > --- a/drivers/fastboot/fb_command.c
>> > +++ b/drivers/fastboot/fb_command.c
>> > @@ -336,7 +336,8 @@ void fastboot_data_complete(char *response)
>> >   */
>> >  static void __maybe_unused flash(char *cmd_parameter, char *response)
>> >  {
>> > -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
>> > +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC) ||
>> > +	    IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
>> >  		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
>> >  					 image_size, response);
>> >
>> > @@ -356,7 +357,8 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
>> >   */
>> >  static void __maybe_unused erase(char *cmd_parameter, char *response)
>> >  {
>> > -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
>> > +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC) ||
>> > +	    IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
>> >  		fastboot_mmc_erase(cmd_parameter, response);
>> >
>> >  	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
>> > diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
>> > index f11eb66761..bf242e4b2a 100644
>> > --- a/drivers/fastboot/fb_mmc.c
>> > +++ b/drivers/fastboot/fb_mmc.c
>> > @@ -20,6 +20,16 @@
>> >
>> >  #define BOOT_PARTITION_NAME "boot"
>> >
>> > +#if defined(CONFIG_FASTBOOT_FLASH_MMC)
>> > +#define fb_flash_str	"mmc"
>>
>> Macros be in upper case.

I agree with Caleb's point.

Also, if this has to stay at compile time, I prefer Dmitrii's approach
using FASTBOOT_FLASH_BLOCK_INTERFACE_NAME.

See: https://patchwork.ozlabs.org/project/uboot/patch/20240306185921.1854109-2-dimorinny@google.com/

>>
>> This is something I think would make more sense as a variable. Perhaps
>> the fastboot command could be extended to allow passing in a device (or
>> list of devices?) to use.
>
> Considered that approach but didn't follow through since it might
> break the existing command syntax. Should we extend the 'flash'
> command itself or should we add an 'oem' command to select mmc or
> ufs.

I don't think we should extend the 'flash' command since the fastboot
documentation states:

flash %s           Flash a given partition. Optional arguments include
                   --slot-other, {filename_path}, --apply-vbmeta

See:
https://android.googlesource.com/platform/system/core/+/main/fastboot/README.md#flashing-logic

If this is made dynamically (which seems like a good idea to me), then
I'd prefer this to be an oem command.

>
>> > +#define fb_flash_dev	CONFIG_FASTBOOT_FLASH_MMC_DEV
>> > +#elif defined(CONFIG_FASTBOOT_FLASH_UFS)
>> > +#define fb_flash_str	"scsi"
>> > +#define fb_flash_dev	CONFIG_FASTBOOT_FLASH_UFS_DEV
>> > +#else
>> > +#error "Incorrect flash type"
>> > +#endif

With the current implementation, if both CONFIG_FASTBOOT_FLASH_MMC and
CONFIG_FASTBOOT_FLASH_UFS are enabled, we cannot use UFS because MMC
takes priority.

>> > +
>> >  struct fb_mmc_sparse {
>> >  	struct blk_desc	*dev_desc;
>> >  };
>> > @@ -78,7 +88,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
>> >  	int ret;
>> >
>> >  	/* First try partition names on the default device */
>> > -	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
>> > +	*dev_desc = blk_get_dev(fb_flash_str, fb_flash_dev);
>> >  	if (*dev_desc) {
>> >  		ret = part_get_info_by_name(*dev_desc, name, info);
>> >  		if (ret >= 0)
>> > @@ -91,8 +101,8 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
>> >  	}
>> >
>> >  	/* Then try dev.hwpart:part */
>> > -	ret = part_get_info_by_dev_and_name_or_num("mmc", name, dev_desc,
>> > -						   info, true);
>> > +	ret = part_get_info_by_dev_and_name_or_num(fb_flash_str, name,
>> > +						   dev_desc, info, true);
>> >  	return ret;
>> >  }
>> >
>> > @@ -202,17 +212,20 @@ static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
>> >  {
>> >  	lbaint_t blks;
>> >
>> > -	debug("Start Erasing mmc hwpart[%u]...\n", dev_desc->hwpart);
>> > +	debug("Start Erasing %s hwpart[%u]...\n",
>> > +	      fb_flash_str, dev_desc->hwpart);
>> >
>> >  	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL);
>> >
>> >  	if (blks != dev_desc->lba) {
>> > -		pr_err("Failed to erase mmc hwpart[%u]\n", dev_desc->hwpart);
>> > +		pr_err("Failed to erase %s hwpart[%u]\n",
>> > +		       fb_flash_str, dev_desc->hwpart);
>> >  		return 1;
>> >  	}
>> >
>> > -	printf("........ erased %lu bytes from mmc hwpart[%u]\n",
>> > -	       dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
>> > +	printf("........ erased %lu bytes from %s hwpart[%u]\n",
>> > +	       dev_desc->lba * dev_desc->blksz, fb_flash_str,
>> > +	       dev_desc->hwpart);
>> >
>> >  	return 0;
>> >  }
>> > @@ -487,11 +500,10 @@ int fastboot_mmc_get_part_info(const char *part_name,
>> >
>> >  static struct blk_desc *fastboot_mmc_get_dev(char *response)
>> >  {
>> > -	struct blk_desc *ret = blk_get_dev("mmc",
>> > -					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
>> > +	struct blk_desc *ret = blk_get_dev(fb_flash_str, fb_flash_dev);
>> >
>> >  	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
>> > -		pr_err("invalid mmc device\n");
>> > +		pr_err("invalid %s device\n", fb_flash_str);
>>
>> 		pr_err("invalid "fb_flash_str" device\n"); -- and the same for all
>> other cases.
>
> Not sure if this will be applicable if we move to dynamic mmc or
> ufs selection. Will see.

I agree with Caleb's comment.

>
>> >  		fastboot_fail("invalid mmc device", response);
>> >  		return NULL;
>> >  	}
>> > @@ -644,10 +656,11 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>> >   */
>> >  void fastboot_mmc_erase(const char *cmd, char *response)
>> >  {
>> > +#ifdef CONFIG_FASTBOOT_FLASH_MMC
>> >  	struct blk_desc *dev_desc;
>> >  	struct disk_partition info;
>> >  	lbaint_t blks, blks_start, blks_size, grp_size;
>> > -	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
>> > +	struct mmc *mmc = find_mmc_device(fb_flash_dev);
>> >
>> >  #ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
>> >  	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
>> > @@ -706,5 +719,6 @@ void fastboot_mmc_erase(const char *cmd, char *response)
>> >
>> >  	printf("........ erased " LBAFU " bytes from '%s'\n",
>> >  	       blks_size * info.blksz, cmd);
>> > +#endif
>> >  	fastboot_okay(NULL, response);
>>
>> I don't think it's really acceptable to just lie that we erase a
>> partition when in fact we did nothing at all.
>>
>> This should respond with some error indicating that the command isn't
>> supported.
>
> Sure.

I agree with Caleb's comment.

>
> Will post a new version shortly.
>
> Thanks for the feedback.
>
> -Varada
