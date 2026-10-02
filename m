Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F26BCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ED6F40D99;
	Fri,  2 Oct 2026 14:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTPFoAXGsvGn; Fri,  2 Oct 2026 14:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2A06440CD6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790952593;
	b=H0Lbi3EBXjEn7gur8Ma5Cm34zM3M12fc6fb1dV4Z1c3MTyjsZEg/tUl0zcqM3/Md4J28
	 bMyaYbHHC9ea5+X2wkCY7a07NjwQ/mkjr+8eCAYl5zt9S/S1LgvPIukP9/OO9DhigP1iG
	 5FHmmi2OTYbV/eoMHF9oEDFj6HUhNZT1fWgg21eBuIA4TPxjyCgb93AbgpXBLvYLeyLyy
	 ggqUlwvdyK15CGRPXlGG59kpWy6WCrS+ryMYrDgc24tdS3VdVD/LtMnIzpf9AhOnAb6WR
	 VOAgR1dGi5ipYvOcVLlLirueBLpTkPa8/RC0uiVw6r8s2uLFGQcGV1EWyYoR0adngSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790952593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bvfBoCArgKppMMRoHHUObOKNUltJ6jJUCZBAfFCT92U=;
	b=U+uFSm2qKXwki1zDz3dL+MJq566VPVL1rn598twhjhvSI0xZ7XnVCbOUPZELmQS3QYAF
	 KWqxGegkz88Hv620sJbJ4kxW8X8GuKnxVJC5uQDljlV07NHnXT/Kn/j3XWJhOy5w7xqna
	 iHzNerEhK4P28HS+dKSpRzEVoi11Ig1zNc85Mf2P9Fm6p3Hj39wuohTuAUSq+SAY1iauF
	 CWtMOxioNGWBr5RcveUKwD5ItJMsgUd61Kjbl7ELYFdKJhDEXZpscXxk5n1xLpdSGtmS9
	 PpRJnvE9nxNpFfZIoD1FY98RjSSDr/6+YX6AAaMyWCvXlnCRPiJLQn/Rt/kbBQLPliA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790952593;
	bh=bvfBoCArgKppMMRoHHUObOKNUltJ6jJUCZBAfFCT92U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5DoW4I16q1vXw5ABWDE6aQtHPVxdvRTr84JaTacajsl75BiK48w7b1ze5eAzg+/j
	 MHlLKOM3PGuPLvqZCaQ8VAVbgiDZSQfehh8gR2F7VT1kxX/SYOtiUeViR2RFhiQWba
	 W9lHXN2TQtonZB/3nl32jNl1bd119OCERz11Vku0fWPOjUjg/VGHnqcp8gbtr060ha
	 tQKjV7zX06rn/6r0X0/tzGFs48JIa0+jXPF8mTzZF4ybJvRvBYbwInFV0P/ik2/XKs
	 ULHWdKoqi5yhNRxBYvX7/YnUJpQWkROHO2VNCPgvQULJ5WQlHcWgIc8TYNUCDbHm99
	 PFtDeiBR61GJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A06440CD6;
	Fri,  2 Oct 2026 14:49:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08C7B282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3375400AD
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Rz4sw4XBkxH for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 165D54004A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790952590;
 b=lHjIxPYrrDFR8uYoerpQ5CR/I+oI5OpuWicL5NmEr7MNbzqjnvr05fklQr9LqbKm6ssQ
 vTLG81pdLIDGL7QQTtE0BH1GbcmniKrL6A9qILuXNkXzVoGnXmFvbVhen7MuhnVxHhYeJ
 n+PlEjOSGyTarUVUmP5PI11DYvtVlzAxT+CXc2Fub+DJC/3DzyKIUar6/8cQxOO+BGcwL
 3JgJGugiGXOaZuImMCUkENxEeLubmhsxCW1EVzZCSWXk9jODvu0yFIrlYXg5VdRJF+/mT
 VApF7Ne4dLxlECzsrPecm9rZA4bZhnYmfrYSLS5XsbakHkD36HJ3GEjjzHc0pLwY5Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790952590;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=bvfBoCArgKppMMRoHHUObOKNUltJ6jJUCZBAfFCT92U=;
 b=s+gaK+xbBiTdKkkQGQwr52q2JOFLuAIal6SqYufgoV48zUdBHWCbrKCADL3grA2mXpYv
 yYOm78BOPuiG2GHM6EAKFK6HMf/KTeBTnwzgbF1vd63cgL/F6YAPBLlr0e8coORAtb/Xt
 wjS/UCpekOgld4vF4iey9yLkXvShuLfN1URg/eu83zDFj8Bp1lO9NcbPAPHTzYaOwAn8y
 qz4wAEat/bL30MANSjGmAV9piYmTIXKY/EcXlw18UPZOdkddAJ0LfMufhi6lherRaBdMZ
 V65OsMIKEm33GFJ50d6VraF1VGnlYmjATwteLsVoesRmnOggipHTr5kJ4YyuOz0QyFA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="oqPYqW/v"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oqPYqW/v
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 165D54004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:49:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C18C42E5A;
 Fri,  2 Oct 2026 14:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0141F000FF;
 Fri,  2 Oct 2026 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790952588;
 bh=bvfBoCArgKppMMRoHHUObOKNUltJ6jJUCZBAfFCT92U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=oqPYqW/v3++4SYu4SplGswICBp6Yl1dq09pB7xms+p4CksTyFPNk3iVlZcfSAULxh
 O10J89U4Y5jUnQM/X4NIl6QiBHezqvo/VwQ7252lRmqXkb4HkML/g32uRQdPuWfJGF
 y3E6UnUMU+5fyn2ET7U9Cw35l9EfktO5HYoYw4buTse3iDYUgGwI7yoA7BSOFAXev1
 BitsHS0cm/ike6ai/N0UokTwgtgoWTu3OpH8iYCQVzLXTEFheScHHAbocOaWeYI2xh
 xr78p1TxEy4IA0zpJqrYyb8Gp/9aKmlG2brVQMOkI3Wy1CFb1ptK0tblG0OPZYHY8H
 6jYlgQ5+61USg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com, Jan Kehren
 <jan.kehren@emteria.com>
Subject: Re: [PATCH] avb: Take a storage interface in the AVB operations
In-Reply-To: <20260915145629.995499-1-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
Date: Fri, 02 Oct 2026 16:49:46 +0200
Message-ID: <xhkdbv77ktawl.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jan,

Thank you for the patch.
And sorry for the review delays.

Overall, the patch looks good to me. I have a couple of remarks below.

On Tue, Sep 15, 2026 at 16:56, Jan Kehren <jan.kehren@emteria.com> wrote:

> AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
> number and get_partition() called find_mmc_device(). bootmeth_android
> accepts any bootdev but passes only desc->devnum, so an Android bootflow
> found on nvme 0 or usb 0 is verified against mmc 0.

Oops, that's not pretty. Note that bootmeth_android has other
mmc-specific bits in there such as bootflow_iter_check_mmc(). So even
with this patch, we don't support booting from another storage medium in
bootmeth_android.

>
> Carry a uclass id alongside the device number and resolve the block device
> with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
> partition switch on the mmc path only. "avb init <dev>" still means mmc,
> "avb init <interface> <dev>" selects another bus, and both now look the
> device up before allocating. get_boot_interface() returns UCLASS_INVALID
> without ops, so a caller that skipped "avb init" fails rather than reading
> mmc.
>
> The IO helpers and struct mmc_part only ever used struct blk_desc, so
> rename them avb_blk_read(), avb_blk_write() and struct avb_blk_part.

It would help a lot the review of this if there is a prepatory patch
that does the rename (without introducing the support of other storage
interfaces), followed by the actual support of another storage
interface.

>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
> ---
> Prior art: this is the third attempt at the same change. Both earlier ones
> stalled without a design objection being raised.
>
>   https://lore.kernel.org/u-boot/20220926220211.868968-1-adelva@google.com/
>   https://lore.kernel.org/u-boot/20220801080717.9899-3-andrii_chepurnyi@epam.com/
>
> The first carries Reviewed-by: Simon Glass. Review asked for the in-tree
> "avb init" callers to be updated, plus docs and tests, and the v2 never
> came. That version made the interface argument mandatory, which is what
> broke the callers; keeping "avb init <dev>" as mmc avoids the problem, so
> no caller changes and board/ti/am57xx/am57xx.env keeps working as is.
>
> AVB_VERIFY keeps its "depends on MMC": the mmc bring-up path still calls
> into the mmc core. Dropping it needs IS_ENABLED(CONFIG_MMC) guards and is
> left as a separate change.
>
> "avb init" still parses <dev> as hex, as it always has, and the help text
> now says so. Happy to switch the new interface form to decimal to match
> every other block command if that is preferred.
>
> Tested on Raspberry Pi 4 and Raspberry Pi 5, verifying and booting Android
> from SD on both and from USB mass storage on the Pi 4. Those boards boot
> through a downstream command rather than bootstd, so the bootmeth_android
> hunk is build tested only.
>
> On the Pi 4 "avb init usb 0" then "avb verify _a" passes, "avb init 0" still
> resolves to mmc, and an unknown interface or an out-of-range index on either
> bus is rejected without disturbing ops that were already initialised.
>
> Build tested with khadas-vim3_android_defconfig and
> khadas-vim3l_android_ab_defconfig, both AVB_VERIFY=y CMD_AVB=y
> BOOTMETH_ANDROID=y. checkpatch --strict is clean apart from two CamelCase
> notes on libavb's own AvbOps/AvbIOResult types.
>
>  boot/bootmeth_android.c                |   2 +-
>  cmd/avb.c                              |  24 +++-
>  common/Kconfig                         |   7 +-
>  common/avb_verify.c                    | 168 ++++++++++++++-----------
>  doc/android/avb2.rst                   |   7 +-
>  include/avb_verify.h                   |  38 ++++--
>  test/py/tests/test_android/test_avb.py |  28 +++++
>  7 files changed, 182 insertions(+), 92 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 0db08d4f86..ae05c08488 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -443,7 +443,7 @@ static int run_avb_verification(struct bootflow *bflow)
>  	bool unlocked = false;
>  	int ret;
>  
> -	avb_ops = avb_ops_alloc(desc->devnum);
> +	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
>  	if (!avb_ops)
>  		return log_msg_ret("avb ops", -ENOMEM);
>  
> diff --git a/cmd/avb.c b/cmd/avb.c
> index 8fbd48ee5a..9381c2aa68 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -16,17 +16,28 @@ static struct AvbOps *avb_ops;
>  
>  int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> -	unsigned long mmc_dev;
> +	struct blk_desc *desc;
>  
> -	if (argc != 2)
> +	if (argc < 2 || argc > 3)
>  		return CMD_RET_USAGE;
>  
> -	mmc_dev = hextoul(argv[1], NULL);
> +	/* "avb init <dev>" keeps its old meaning of mmc <dev> */
> +	if (argc == 3)

Can we please change this so that the comment is close to what actually do.
I mean the following:

     /* "avb init <dev>" keeps its old meaning of mmc <dev> */
     if (argc == 2)
		desc = blk_get_devnum_by_uclass_id(UCLASS_MMC,
						   hextoul(argv[1], NULL));


> +		desc = blk_get_devnum_by_uclass_idname(argv[1],
> +						       hextoul(argv[2], NULL));
> +	else
> +		desc = blk_get_devnum_by_uclass_id(UCLASS_MMC,
> +						   hextoul(argv[1], NULL));
> +
> +	if (!desc) {
> +		printf("Can't find the requested device\n");
> +		return CMD_RET_FAILURE;
> +	}
>  
>  	if (avb_ops)
>  		avb_ops_free(avb_ops);
>  
> -	avb_ops = avb_ops_alloc(mmc_dev);
> +	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
>  	if (avb_ops)
>  		return CMD_RET_SUCCESS;
>  	else
> @@ -428,7 +439,7 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
>  }
>  
>  static struct cmd_tbl cmd_avb[] = {
> -	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
> +	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
>  	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
>  	U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),
>  	U_BOOT_CMD_MKENT(is_unlocked, 1, 0, do_avb_is_unlocked, "", ""),
> @@ -464,7 +475,8 @@ static int do_avb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  U_BOOT_CMD(
>  	avb, 29, 0, do_avb,
>  	"Provides commands for testing Android Verified Boot 2.0 functionality",
> -	"init <dev> - initialize avb2 for <dev>\n"
> +	"init [<interface>] <dev> - initialize avb2 for hex <dev> on <interface>\n"
> +	"    (mmc, nvme, usb, ...; defaults to mmc)\n"
>  	"avb read_rb <num> - read rollback index at location <num>\n"
>  	"avb write_rb <num> <rb> - write rollback index <rb> to <num>\n"
>  	"avb is_unlocked - returns unlock status of the device\n"
> diff --git a/common/Kconfig b/common/Kconfig
> index c739225621..5590fbfdb2 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -885,9 +885,14 @@ config AVB_VERIFY
>  	  This option enables compilation of bootloader-dependent operations,
>  	  used by Android Verified Boot 2.0 library (libavb). Includes:
>  	  * Helpers to process strings in order to build OS bootargs.
> -	  * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
> +	  * Helpers to access block devices, similar to
> +	    drivers/fastboot/fb_mmc.c.
>  	  * Helpers to alloc/init/free avb ops.
>  
> +	  Only mmc is initialised by AVB itself. Any other interface must
> +	  already be enumerated when AVB runs, either by the board code or by
> +	  a command such as "usb start".
> +
>  if AVB_VERIFY
>  
>  config AVB_BUF_ADDR
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index b96cd1ebd7..6be34db129 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -8,6 +8,7 @@
>  #include <cpu_func.h>
>  #include <image.h>
>  #include <malloc.h>
> +#include <mmc.h>
>  #include <part.h>
>  #include <tee.h>
>  #include <tee/optee_ta_avb.h>
> @@ -304,13 +305,13 @@ char *avb_set_enforce_verity(const char *cmdline)
>  
>  /**
>   * ============================================================================
> - * IO(mmc) auxiliary functions
> + * Block IO auxiliary functions
>   * ============================================================================
>   */
> -static unsigned long mmc_read_and_flush(struct mmc_part *part,
> -					lbaint_t start,
> -					lbaint_t sectors,
> -					void *buffer)
> +static unsigned long avb_blk_read(struct avb_blk_part *part,

Can we please call this avb_blk_read_and_flush() ? As far as I
understand, we still flush the cache after reading.

> +				  lbaint_t start,
> +				  lbaint_t sectors,
> +				  void *buffer)
>  {
>  	unsigned long blks;
>  	void *tmp_buf;
> @@ -342,7 +343,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
>  		tmp_buf = buffer;
>  	}
>  
> -	blks = blk_dread(part->mmc_blk,
> +	blks = blk_dread(part->blk,
>  			 start, sectors, tmp_buf);
>  	/* flush cache after read */
>  	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
> @@ -353,8 +354,8 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
>  	return blks;
>  }
>  
> -static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
> -			       lbaint_t sectors, void *buffer)
> +static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
> +				   lbaint_t sectors, void *buffer)
>  {
>  	void *tmp_buf;
>  	size_t buf_size;
> @@ -382,59 +383,83 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
>  		tmp_buf = buffer;
>  	}
>  
> -	return blk_dwrite(part->mmc_blk,
> +	return blk_dwrite(part->blk,
>  			  start, sectors, tmp_buf);
>  }
>  
> -static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
> +/* Hardware partition 0 is the user area, where the GPT and our images live */

Can the comment be scoped with the variable?

Or even better, since we ony use this variable once, can't we just drop
it and put the comment next to mmc_switch_part() ?

The rest of it looks good, thanks again

Mattijs

> +static int avb_init_mmc(int dev_num)
>  {
> -	int ret;
> -	u8 dev_num;
>  	int part_num = 0;
> -	struct mmc_part *part;
> -	struct blk_desc *mmc_blk;
> -
> -	part = malloc(sizeof(struct mmc_part));
> -	if (!part)
> -		return NULL;
> +	struct mmc *mmc;
> +	int ret;
>  
> -	dev_num = get_boot_device(ops);
> -	part->mmc = find_mmc_device(dev_num);
> -	if (!part->mmc) {
> +	mmc = find_mmc_device(dev_num);
> +	if (!mmc) {
>  		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
> -		goto err;
> +		return -ENODEV;
>  	}
>  
> -	ret = mmc_init(part->mmc);
> +	ret = mmc_init(mmc);
>  	if (ret) {
>  		printf("%s: MMC initialization failed, err = %d\n",
>  		       __func__, ret);
> -		goto err;
> +		return ret;
>  	}
>  
> -	if (IS_MMC(part->mmc)) {
> -		ret = mmc_switch_part(part->mmc, part_num);
> +	if (IS_MMC(mmc)) {
> +		ret = mmc_switch_part(mmc, part_num);
>  		if (ret) {
>  			printf("%s: MMC part switch failed, err = %d\n",
>  			       __func__, ret);
> -			goto err;
> +			return ret;
>  		}
>  	}
>  
> -	mmc_blk = mmc_get_blk_desc(part->mmc);
> -	if (!mmc_blk) {
> -		printf("%s: failed to obtain block descriptor\n", __func__);
> +	return 0;
> +}
> +
> +static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
> +{
> +	int ret;
> +	int dev_num;
> +	enum uclass_id uclass_id;
> +	struct avb_blk_part *part;
> +	struct blk_desc *blk;
> +
> +	part = malloc(sizeof(struct avb_blk_part));
> +	if (!part)
> +		return NULL;
> +
> +	dev_num = get_boot_device(ops);
> +	uclass_id = get_boot_interface(ops);
> +	if (uclass_id == UCLASS_INVALID || dev_num < 0) {
> +		printf("%s: no storage interface, run 'avb init' first\n",
> +		       __func__);
> +		goto err;
> +	}
> +
> +	if (uclass_id == UCLASS_MMC) {
> +		ret = avb_init_mmc(dev_num);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	blk = blk_get_devnum_by_uclass_id(uclass_id, dev_num);
> +	if (!blk) {
> +		/* Every bus but mmc must already be started when AVB runs */
> +		printf("%s: no %s device %d, is the bus started?\n", __func__,
> +		       blk_get_uclass_name(uclass_id), dev_num);
>  		goto err;
>  	}
>  
> -	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
> +	ret = part_get_info_by_name(blk, partition, &part->info);
>  	if (ret < 0) {
>  		printf("%s: can't find partition '%s'\n", __func__, partition);
>  		goto err;
>  	}
>  
> -	part->dev_num = dev_num;
> -	part->mmc_blk = mmc_blk;
> +	part->blk = blk;
>  
>  	return part;
>  err:
> @@ -442,22 +467,22 @@ err:
>  	return NULL;
>  }
>  
> -static AvbIOResult mmc_byte_io(AvbOps *ops,
> -			       const char *partition,
> -			       s64 offset,
> -			       size_t num_bytes,
> -			       void *buffer,
> -			       size_t *out_num_read,
> -			       enum mmc_io_type io_type)
> +static AvbIOResult avb_blk_byte_io(AvbOps *ops,
> +				   const char *partition,
> +				   s64 offset,
> +				   size_t num_bytes,
> +				   void *buffer,
> +				   size_t *out_num_read,
> +				   enum avb_io_type io_type)
>  {
>  	ulong ret;
> -	struct mmc_part *part;
> +	struct avb_blk_part *part;
>  	u64 start_offset, start_sector, sectors, residue;
>  	u8 *tmp_buf;
>  	size_t io_cnt = 0;
>  	AvbIOResult io_ret = AVB_IO_RESULT_OK;
>  
> -	if (!partition || !buffer || io_type > IO_WRITE)
> +	if (!partition || !buffer || io_type > AVB_IO_WRITE)
>  		return AVB_IO_RESULT_ERROR_IO;
>  
>  	part = get_partition(ops, partition);
> @@ -486,11 +511,11 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>  				residue = num_bytes;
>  			}
>  
> -			if (io_type == IO_READ) {
> -				ret = mmc_read_and_flush(part,
> -							 part->info.start +
> -							 start_sector,
> -							 1, tmp_buf);
> +			if (io_type == AVB_IO_READ) {
> +				ret = avb_blk_read(part,
> +						   part->info.start +
> +						   start_sector,
> +						   1, tmp_buf);
>  
>  				if (ret != 1) {
>  					printf("%s: read error (%ld, %lld)\n",
> @@ -505,10 +530,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>  				tmp_buf += (start_offset % part->info.blksz);
>  				memcpy(buffer, (void *)tmp_buf, residue);
>  			} else {
> -				ret = mmc_read_and_flush(part,
> -							 part->info.start +
> -							 start_sector,
> -							 1, tmp_buf);
> +				ret = avb_blk_read(part,
> +						   part->info.start +
> +						   start_sector,
> +						   1, tmp_buf);
>  
>  				if (ret != 1) {
>  					printf("%s: read error (%ld, %lld)\n",
> @@ -520,8 +545,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>  					start_offset % part->info.blksz,
>  					buffer, residue);
>  
> -				ret = mmc_write(part, part->info.start +
> -						start_sector, 1, tmp_buf);
> +				ret = avb_blk_write(part, part->info.start +
> +						    start_sector, 1, tmp_buf);
>  				if (ret != 1) {
>  					printf("%s: write error (%ld, %lld)\n",
>  					       __func__, ret, start_sector);
> @@ -538,16 +563,16 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>  		}
>  
>  		if (sectors) {
> -			if (io_type == IO_READ) {
> -				ret = mmc_read_and_flush(part,
> -							 part->info.start +
> -							 start_sector,
> -							 sectors, buffer);
> +			if (io_type == AVB_IO_READ) {
> +				ret = avb_blk_read(part,
> +						   part->info.start +
> +						   start_sector,
> +						   sectors, buffer);
>  			} else {
> -				ret = mmc_write(part,
> -						part->info.start +
> -						start_sector,
> -						sectors, buffer);
> +				ret = avb_blk_write(part,
> +						    part->info.start +
> +						    start_sector,
> +						    sectors, buffer);
>  			}
>  
>  			if (!ret) {
> @@ -564,7 +589,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
>  	}
>  
>  	/* Set counter for read operation */
> -	if (io_type == IO_READ && out_num_read)
> +	if (io_type == AVB_IO_READ && out_num_read)
>  		*out_num_read = io_cnt;
>  
>  out:
> @@ -603,8 +628,8 @@ static AvbIOResult read_from_partition(AvbOps *ops,
>  				       void *buffer,
>  				       size_t *out_num_read)
>  {
> -	return mmc_byte_io(ops, partition_name, offset_from_partition,
> -			   num_bytes, buffer, out_num_read, IO_READ);
> +	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
> +			       num_bytes, buffer, out_num_read, AVB_IO_READ);
>  }
>  
>  /**
> @@ -630,8 +655,8 @@ static AvbIOResult write_to_partition(AvbOps *ops,
>  				      size_t num_bytes,
>  				      const void *buffer)
>  {
> -	return mmc_byte_io(ops, partition_name, offset_from_partition,
> -			   num_bytes, (void *)buffer, NULL, IO_WRITE);
> +	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
> +			       num_bytes, (void *)buffer, NULL, AVB_IO_WRITE);
>  }
>  
>  /**
> @@ -883,7 +908,7 @@ static AvbIOResult get_unique_guid_for_partition(AvbOps *ops,
>  						 char *guid_buf,
>  						 size_t guid_buf_size)
>  {
> -	struct mmc_part *part;
> +	struct avb_blk_part *part;
>  	size_t uuid_size;
>  
>  	part = get_partition(ops, partition);
> @@ -920,7 +945,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
>  					 const char *partition,
>  					 u64 *out_size_num_bytes)
>  {
> -	struct mmc_part *part;
> +	struct avb_blk_part *part;
>  
>  	if (!out_size_num_bytes)
>  		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
> @@ -1111,7 +1136,7 @@ __weak AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
>   * AVB2.0 AvbOps alloc/initialisation/free
>   * ============================================================================
>   */
> -AvbOps *avb_ops_alloc(int boot_device)
> +AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
>  {
>  	struct AvbOpsData *ops_data;
>  
> @@ -1134,7 +1159,8 @@ AvbOps *avb_ops_alloc(int boot_device)
>  	ops_data->ops.read_persistent_value = read_persistent_value;
>  #endif
>  	ops_data->ops.get_size_of_partition = get_size_of_partition;
> -	ops_data->mmc_dev = boot_device;
> +	ops_data->uclass_id = uclass_id;
> +	ops_data->dev_num = dev_num;
>  
>  	return &ops_data->ops;
>  }
> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> index a514701241..cef49d3e0d 100644
> --- a/doc/android/avb2.rst
> +++ b/doc/android/avb2.rst
> @@ -29,6 +29,10 @@ integration in ``common/avb_verify.c`` and the platform port under
>  
>  For additional details check [1]_.
>  
> +Only mmc is started by AVB itself. Any other interface must already be
> +enumerated when AVB runs, either by the board code or by a command such as
> +``usb start``, or the partition lookup fails.
> +
>  AVB using OP-TEE (optional)
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> @@ -80,7 +84,8 @@ AVB 2.0 U-Boot shell commands
>  Provides CLI interface to invoke AVB 2.0 verification + misc. commands for
>  different testing purposes::
>  
> -    avb init <dev> - initialize avb 2 for <dev>
> +    avb init [<interface>] <dev> - initialize avb 2 for hex <dev> on
> +        <interface> (mmc, nvme, usb, ...; defaults to mmc)
>      avb read_rb <num> - read rollback index at location <num>
>      avb write_rb <num> <rb> - write rollback index <rb> to <num>
>      avb is_unlocked - returns unlock status of the device
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 66655aab87..6dbbb39a8a 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -7,8 +7,9 @@
>  #define _AVB_VERIFY_H
>  
>  #include <../lib/libavb/libavb.h>
> +#include <blk.h>
>  #include <mapmem.h>
> -#include <mmc.h>
> +#include <part.h>
>  
>  #define AVB_MAX_ARGS			1024
>  #define VERITY_TABLE_OPT_RESTART	"restart_on_corruption"
> @@ -24,7 +25,8 @@ enum avb_boot_state {
>  
>  struct AvbOpsData {
>  	struct AvbOps ops;
> -	int mmc_dev;
> +	enum uclass_id uclass_id;
> +	int dev_num;
>  	enum avb_boot_state boot_state;
>  #ifdef CONFIG_OPTEE_TA_AVB
>  	struct udevice *tee;
> @@ -32,19 +34,17 @@ struct AvbOpsData {
>  #endif
>  };
>  
> -struct mmc_part {
> -	int dev_num;
> -	struct mmc *mmc;
> -	struct blk_desc *mmc_blk;
> +struct avb_blk_part {
> +	struct blk_desc *blk;
>  	struct disk_partition info;
>  };
>  
> -enum mmc_io_type {
> -	IO_READ,
> -	IO_WRITE
> +enum avb_io_type {
> +	AVB_IO_READ,
> +	AVB_IO_WRITE
>  };
>  
> -AvbOps *avb_ops_alloc(int boot_device);
> +AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
>  void avb_ops_free(AvbOps *ops);
>  
>  /**
> @@ -78,7 +78,7 @@ const char *str_avb_slot_error(AvbSlotVerifyResult res);
>   * I/O helper inline functions
>   * ============================================================================
>   */
> -static inline uint64_t calc_offset(struct mmc_part *part, int64_t offset)
> +static inline uint64_t calc_offset(struct avb_blk_part *part, int64_t offset)
>  {
>  	u64 part_size = part->info.size * part->info.blksz;
>  
> @@ -110,10 +110,24 @@ static inline int get_boot_device(AvbOps *ops)
>  	if (ops) {
>  		data = ops->user_data;
>  		if (data)
> -			return data->mmc_dev;
> +			return data->dev_num;
>  	}
>  
>  	return -1;
>  }
>  
> +/* Mirrors get_boot_device(): no ops means no interface, not a default one */
> +static inline enum uclass_id get_boot_interface(AvbOps *ops)
> +{
> +	struct AvbOpsData *data;
> +
> +	if (ops) {
> +		data = ops->user_data;
> +		if (data)
> +			return data->uclass_id;
> +	}
> +
> +	return UCLASS_INVALID;
> +}
> +
>  #endif /* _AVB_VERIFY_H */
> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
> index 137d83e1de..4c5b3c6f59 100644
> --- a/test/py/tests/test_android/test_avb.py
> +++ b/test/py/tests/test_android/test_avb.py
> @@ -135,3 +135,31 @@ def test_avb_persistent_values(ubman):
>  
>      response = ubman.run_command('avb read_pvalue test 12')
>      assert response == 'Read 12 bytes, value = value_value'
> +
> +
> +@pytest.mark.buildconfigspec('cmd_avb')
> +@pytest.mark.buildconfigspec('cmd_mmc')
> +def test_avb_init_interface(ubman):
> +    """Check that 'avb init' accepts an explicit interface
> +    """
> +
> +    response = ubman.run_command('avb init mmc %s' % str(mmc_dev))
> +    assert response == ''
> +
> +    response = ubman.run_command('avb init %s' % str(mmc_dev))
> +    assert response == ''
> +
> +
> +@pytest.mark.buildconfigspec('cmd_avb')
> +def test_avb_init_bad_device(ubman):
> +    """Check that 'avb init' rejects a device that does not exist
> +    """
> +
> +    response = ubman.run_command('avb init mmc ff')
> +    assert response.find("Can't find the requested device") != -1
> +
> +    response = ubman.run_command('avb init ff')
> +    assert response.find("Can't find the requested device") != -1
> +
> +    response = ubman.run_command('avb init nonsense 0')
> +    assert response.find("Can't find the requested device") != -1
>
> base-commit: 6e3f574e576585b0250ac387475d59e581bb5d9f
> -- 
> 2.43.0
