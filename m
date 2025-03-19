Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FCBC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934D8819B1;
	Wed, 19 Mar 2025 15:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742393182;
	bh=hDBs8J/AAJQrQWnXLyCD4VFwnB4Qxggn0eQhUdtQz3E=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fSux9MPukgzMSSgQB2FvD7jYl98kMbHWCcd9hCQA5omxb1imDstQYwTow8w6ZyliP
	 ssLVZ/EVtMucIcVCEWilNN8cy7onUUJeIW1dghX3HKYraCRm/TkJkRuaLxjr4e91AO
	 LFMzCCMFC5xitPcB99MTqocKdpuEFpnWs7855PmGUTIQWZIlWNrgFfpyhUU20HJVbG
	 IhC3gXcm8kYx+cN1dqk21tM2h4oE85pg134U0mlNqaKJGeQBtwJ4eQLmjh/wDl7Y/A
	 PuNDoMDqGmywXJwCnJ4wPifmPoozsPmhR/P2kdyZJoI5xfVO42v6Np1Cyo8IdwNZin
	 XfjPAqgDysNTw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C412381D0B; Wed, 19 Mar 2025 15:06:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A3F81951
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NZUxIsvJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E8EF3101E91CC; Wed, 19 Mar 2025 15:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742393178;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hDBs8J/AAJQrQWnXLyCD4VFwnB4Qxggn0eQhUdtQz3E=;
 b=NZUxIsvJH7H5k9orr00HZC7sVy6tT8VCTpDXO5lG8aPotKd2GVt6ZpjgVuLTH/wMNLj/ub
 L0jLMJfwKKN8uGGwTAxHp67gZhgCOmmC9dHWwF1WM0y1GFc+jAE5OVMbYRoD7ihjTeota5
 KKdaahknfesIZvpftBTqZczj82VRhvuEG/bcmH5FNED3V4w1EenorzWfoAL+IUmCnt3fjI
 kTZyma5ye+nOChGfLJjjaPGEz/i2B1t5e2aBUxeGW+0sZiZCn1OA8oVwJbpAoHCvMF+X4u
 ixoPnn1MBdhZt7jC5ejJIabQQ+3lcygNCy/XJ1kSD0jKbhGJ92faBdEhEyaDww==
Message-ID: <78f39c8c-b0fd-915e-ba66-213f58464680@denx.de>
Date: Wed, 19 Mar 2025 15:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: block devices on MTD and UBI
Content-Language: en-US
To: Mike Looijmans <mike.looijmans@topic.nl>
References: <cd57ac47-02b6-458e-86a7-7c837a89b550@topic.nl>
From: Heiko Schocher <hs@denx.de>
Cc: Alexey Romanov <avromanov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <cd57ac47-02b6-458e-86a7-7c837a89b550@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Mike,

On 18.03.25 10:04, Mike Looijmans wrote:
> I think I have everything set up to access MTD (and UBI) devices as "block", however, lsblk always 
> ignores them, and refuses to list anything but the mmc. I can read ubifs and boot from it though, 
> and since UBI runs on top of MTD block devices, MTD block device should be working, right?

Yes. I must admit, I have no device on which I have such a setup...

added Alexey (who introduced ubi block support), may he can give some hints.

> I also have UBI_BLOCK enabled, so I would expect UBI volumes to appear in the "lsblk" as well.

good, that would have been my first question, if you have enabled "UBI_BLOCK"

> Example U-boot session:
> 
> Zynq> mtd list
> SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB, total 32 MiB
> List of MTD devices:
> * nor0
>    - device: flash@0
>    - parent: spi@e000d000
>    - driver: jedec_spi_nor
>    - path: /axi/spi@e000d000/flash@0
>    - type: NOR flash
>    - block size: 0x10000 bytes
>    - min I/O: 0x1 bytes
>    - 0x000000000000-0x000002000000 : "nor0"
>            - 0x000000000000-0x000000100000 : "qspi-boot-bin"
>            - 0x000000100000-0x000002000000 : "qspi-rootfs"

Aha, SPI NOR. I fear this is not supported yet.

Do you have somehow called ubi_part() ?

Can you try "ubi part...." and look if this helps?

> 
> Zynq> lsblk
> Block Driver          Devices
> -----------------------------
> efi_blk             : <none>
> mmc_blk             : mmc 0
> mtd_blk             : <none>
> ubi_blk             : <none>

Here (and for mtd) seems something missing!

> usb_storage_blk     : <none>
> 
> Zynq> ubi part qspi-rootfs
> Zynq> ubi list
> 0: qspi-rootfs
> Zynq> lsblk
> Block Driver          Devices
> -----------------------------
> efi_blk             : <none>
> mmc_blk             : mmc 0
> mtd_blk             : <none>
> ubi_blk             : <none>
> usb_storage_blk     : <none>
> 
> 
> I would have expected the SPI NOR flash to appear in the "mtd_blk" devices, and would expect the UBI 
> volumes to appear in the "ubi_blk" list.
> What am I missing?

It seems to me, that you have to implement this like it is done for spi nand:

drivers/mtd/nand/spi/core.c
1180 static int spinand_bind(struct udevice *dev)
1181 {
1182         if (blk_enabled()) {
1183                 struct spinand_plat *plat = dev_get_plat(dev);
1184                 int ret;
1185
1186                 if (CONFIG_IS_ENABLED(MTD_BLOCK)) {
1187                         ret = mtd_bind(dev, &plat->mtd);
1188                         if (ret)
1189                                 return ret;
1190                 }
1191
1192                 if (CONFIG_IS_ENABLED(UBI_BLOCK))
1193                         return ubi_bind(dev);
1194         }
1195
1196         return 0;
1197 }

The only thing I just stumbled over is:

drivers/mtd/ubi/block.c
  35 static struct ubi_device *get_ubi_device(void)
  36 {
  37         return ubi_devices[0];
  38 }

may this is not perfect.

But as said, I cannot try out ...

> What I'm aiming for here is to be able to:
> - Read from squashfs in (raw) MTD partition (NOR flash is ideal for that)
> - Read kernel/devicetree (fit) from UBI volume
> - Read from squashfs inside UBI volume
> 
> 
> I can read files from UBIFS (and boot into Linux using bootcmd_ubifs) just fine, e.g.:
> Zynq> ubifsmount ubi0:qspi-rootfs
> Zynq> ls ubi 0
> <DIR>        5200  Fri Mar 09 12:34:56 2018  bin
> <DIR>         160  Fri Mar 09 12:34:56 2018  dev
> <DIR>        4984  Fri Mar 09 12:34:56 2018  etc
> ...
> 
> 

Good to hear that UBI/UBIFS setup is working!

So I fear there is some "add feature"/debug work ToDo to get this up and
working ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
