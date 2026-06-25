Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB33CDE009
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0C8847C8;
	Thu, 25 Jun 2026 20:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="tOOAfEcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B3684894; Thu, 25 Jun 2026 20:53:08 +0200 (CEST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424B784704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4gmScG0h7BzyNS;
 Thu, 25 Jun 2026 21:53:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1782413582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDSdOx5xDh2QJkEzZgB0VxyAwI/N+0H7bu5/ob6iZw0=;
 b=tOOAfEcECfEG1P1U2S5/EA3MTCv156GUVjMTIzGmNbOi97FXnOM53J/PV6Iptzs0H7CQjt
 op5coTvTGBupJhRGAxJ39LFVhZnIamEF64MHvUguOMkF8Ai/DgisbcaSSa0mloxMWqUOYM
 9GPaZ+VHShM23MhfOrRkHERsQlEuiPk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782413582;
 b=a6bfCA3VnFR+gXIFh9XEUJRtrvZy/QaGys7f2N0EwGKTXQJBm6pR3CPCRogErWieDEuH+C
 QCEFYa4dNml/3W/QUfTBbHkKl3NA3wxsgmVpo/t8jlTGso93YU7D0MKzg7CG7lwfXXaQeX
 61o6oypZlgtZYdMQ60sqrqqF36Fhy4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1782413582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDSdOx5xDh2QJkEzZgB0VxyAwI/N+0H7bu5/ob6iZw0=;
 b=nqs0xX0AriTx2yD+foLv4c7HjvlmBQPRJ1XQRSYAdavTGAhjBNBTvnLOJ5V5+pAd6WXc1r
 t5zMINB1paICiaYE36L5rixxxmB2ruFEQR6caefbGOVLCR0GN9qhM6VmfxljIpdDSNX/OD
 jO7nwaqhG2kTDBgnSozIzhR6L3SFaxg=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Thu, 25 Jun 2026 21:52:59 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com,
 trini@konsulko.com, afd@ti.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCHv2 0/5] k3-am62-pocketbeagle2: add board and variant support
Message-ID: <aj15C4bUnYHve9yk@kehys.lan>
References: <20260619231719.3823195-1-rs@ti.com> <ajwSkh6Pa97LPVi5@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajwSkh6Pa97LPVi5@kehys.lan>
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

Wed, Jun 24, 2026 at 08:23:37PM +0300, Marko Mäkelä wrote:
>I successfully booted this together with a version of the software 
>ECDSA patch, but did not try to load a signed FIT image yet.

Is Linux flexible about the kernel and FDT load addresses, or is there a 
recommendation that I should follow? I see that earlier when I tested 
CONFIG_FIT_SIGNATURE based boot on a Phytec phyBOARD Lyra, I had used 
0x81000000 and 0x83000000, respectively. I didn't test those addresses 
on the PocketBeagle 2 yet.

My initial experiment failed, because my image had specified the entry 
and load addresses 0x82000000 for the kernel, which is the same as the 
$loadaddr. It is thinkable that zlib inflate() returns -3 (Z_DATA_ERROR) 
because it is simply corrupting its input (data start: 0x820000c4) when 
decompressing it to 0x82000000 onwards.

Here is some output from a failing run:
=> load mmc 1:1 $loadaddr fitImage
15014068 bytes read in 180 ms (79.5 MiB/s)
=> bootm
…
Working FDT set to 88000000
    Uncompressing Kernel Image to 82000000
Error: inflate() returned -3
gzip compressed: uncompress error -3
Must RESET board to recover

Below is the start of a succesful run when I invoke the image from a 
non-overlapping address:

=> load mmc 1:1 0x89000000 fitImage
15014068 bytes read in 179 ms (80 MiB/s)
=> setenv bootargs "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02860000 root=/dev/mmcblk1p3 ro rootfstype=ext4 fsck.repair=yes resume=/dev/mmcblk1p2 rootwait net.ifnames=0"
=> bootm 0x89000000
…
    Verifying Hash Integrity ... sha256+ OK
    Loading fdt from 0x89e430d4 to 0x88000000
    Booting using the fdt blob at 0x88000000
Working FDT set to 88000000
    Uncompressing Kernel Image to 82000000
    Loading Device Tree to 00000000996b2000, end 00000000996c2d82 ... OK
Working FDT set to 996b2000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 7.0.0 …

The kernel was configured as follows:

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

It seemed to boot well into the user space of
https://www.beagleboard.org/distros/pocketbeagle-2-debian-13-5-2026-05-19-minimal-v6-12-x-ti

where I had simply replaced the bootloader files and added the signed 
fitImage to the root directory of the boot partition.

With best regards,

	Marko
