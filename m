Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4B6C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 10:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D9D87F0F;
	Mon, 19 Feb 2024 11:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CgYLM40R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C351287F0F; Mon, 19 Feb 2024 11:24:34 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF85875FD
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 11:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 04a64a6a-cf11-11ee-b64d-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 04a64a6a-cf11-11ee-b64d-005056994fde;
 Mon, 19 Feb 2024 11:24:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=lE33BY7+3OIzwNL76PjQ2XBJODgKPY08r4rORh3OI3k=;
 b=CgYLM40R5E8gEf6AJtId5/vcVv/tZjEqrdZvDPI8jTTJeqGtPkKBbeOm1gFvDG3DTbjdFfpTzeHOn
 2p+J1AvnpUnqbnMIv6IOSG/YS0hZty+4klGLjc17tJtK1245tWmKHOfnCGUYp2+56OvhMOAoKKOUBd
 skSu9qOJCDTyocaczuREqhAFSL3a1qsxFobluNgmNAv/7pLfqdInDIqb5iqE4893ZgX3D30PVBk4rE
 xOtUAm4EUNaMkwv8/4ZqMMfWy9i/yz+qUD+nK6skUFfkUVFG4ZW79ByTA49i+rcZQY0877Do/SzBYe
 Sr7AjZbkrp9Rlq4Cv9hZBA03R5dmKEg==
X-KPN-MID: 33|vhDnFt0e9kgG8w+kSNVc9l9dcZoFGU1GViZM/ZcLeNj+/Nxbm4fM0SFed14gFAu
 dAhIcqolvjym7Iz282g7vWcJ0Y6nXz5DvMS3W2O2+mIc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|CkhcVdDpix0ERYOvzLs9TUapwW1E2hoZ+SiMxYm17oI/xFO04bvltmkIOFwUwp/
 OYNYAT6XA4ZLFiW+AUg8TZA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0edce5a0-cf11-11ee-94ba-00505699b758;
 Mon, 19 Feb 2024 11:24:27 +0100 (CET)
Date: Mon, 19 Feb 2024 11:24:26 +0100
Message-Id: <878r3gn44l.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, pbrobinson@gmail.com
In-Reply-To: <20240219091220.1022422-1-pbrobinson@gmail.com> (message from
 Peter Robinson on Mon, 19 Feb 2024 09:12:15 +0000)
Subject: Re: [PATCH] disk: dos: Add all options for EFI System Partitions
References: <20240219091220.1022422-1-pbrobinson@gmail.com>
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

> From: Peter Robinson <pbrobinson@gmail.com>
> Date: Mon, 19 Feb 2024 09:12:15 +0000
> 
> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.

Hi Peter,

Any reason not to include 0x0c as well?  That is what we use on
OpenBSD/armv7 and OpenBSD/arm64.  And as far as I know all UEFI
implementations (on arm64 at least) boot from such a partition.

(And yes, we use that partition type because we want to have a
bootable image that works on the various Raspberry Pi models).

That said, what problem does this fix?  And what happens if we have
both a 0xea and a 0x01/0x06/0x0b/0x0c partition?  In that case U-Boot
should probably prefer the 0xea over the others as the ESP.

Oh, and while your're at it, the hex constants are a bit inconsistent
(0x1/0x6 vs. 0x0b).

Cheers,

Mark

> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  disk/part_dos.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 567ead7511d..303eb1d13ee 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -40,6 +40,12 @@ static int get_bootable(dos_partition_t *p)
>  {
>  	int ret = 0;
>  
> +	if (p->sys_ind == 0x1)
> +		ret |= PART_EFI_SYSTEM_PARTITION;
> +	if (p->sys_ind == 0x6)
> +		ret |= PART_EFI_SYSTEM_PARTITION;
> +	if (p->sys_ind == 0x0b)
> +		ret |= PART_EFI_SYSTEM_PARTITION;
>  	if (p->sys_ind == 0xef)
>  		ret |= PART_EFI_SYSTEM_PARTITION;
>  	if (p->boot_ind == 0x80)
> -- 
> 2.43.1
> 
> 
