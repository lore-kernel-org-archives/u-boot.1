Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8680CCF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A50D88EE3;
	Mon, 14 Oct 2024 04:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=holbrook.no
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=holbrook.no header.i=@holbrook.no header.b="XCJl+XGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C4188FEE; Sun, 13 Oct 2024 21:35:05 +0200 (CEST)
Received: from jeffvader.in-berlin.de (jeffvader.in-berlin.de [217.197.91.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2FA88FA8
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=holbrook.no
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=accounts-uboot@holbrook.no
Received: from localhost (unknown [149.88.22.152])
 by jeffvader.in-berlin.de (Postfix) with ESMTPSA id 808EC3A0B68
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=holbrook.no; s=smtp;
 t=1728848102; bh=vQuBwbGESRpTkLl4KapyTWAM/6zlQ/12crYTfk9Dx88=;
 h=Date:From:To:Subject:From;
 b=XCJl+XGyzZD+SjxXxpjcikfdKyzIAti2hXtUQrGA8v2JaCZoUWjOXRLtWLQ4WdgTd
 StrE3u0JSKtJVmGks0tqlsxYA+T47cpy2qlOh1WDr9nVKCvZgqV3ZsuNqvzgmwAMKv
 i4QmFBmSR8rN7Aeh78NP337GKj8RmdaL88xgoDq8VKkd4Av0yU5e8e6jGxx9YLGyVq
 6BSi5Orz3hD5XpPKiuuOAlfG8yGYMIQ+UyKcsGxb6FVP0MSbfEgW6l5zjfmxfOXa0L
 qRzmmmR4WDn6U0TjlddeKiHQmPEWdD8XMHV3FkUJts2HllZbWti/ijKafYy3kH7L0j
 RMYDYJXstBtbg==
Date: Sun, 13 Oct 2024 20:34:58 +0100
From: Louis Holbrook <accounts-uboot@holbrook.no>
To: u-boot@lists.denx.de
Subject: Mainline kernel bad magic for Pine64-A64-LTS
Message-ID: <Zwwg4oXUq6aWlk69@holbrook.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

(Also posted in pine64 forum
https://forum.pine64.org/showthread.php?tid=19460)


In an attempt to troubleshoot failing to get generic alpine linux to
run on PA64-2G-LTS, I've tried to reduce the problem to the smallest
steps that are legible to me. 

When booting the kernel, I get "Bad ARM64 Image Magic" I can't figure
out what this means, and why it is happening. Sources I have searched
seem to be board specific, and found nothing on this board. I've arrived
at a point where I cannot find a way to reason further about it, so thus
I am reaching out.

I am currently loading the kernel and dtb manually at the uboot prompt:

setenv bootargs loglevel=7 earlyprintk
fatload mmc 0:1 0x42000000 boot/vmlinux
fatload mmc 0:1 0x4a000000 boot/u-boot.dtb
booti 0x42000000 - 0x4a000000

My current configuration is:

- linux 5.14 from mainline (git:7d2a07b769330c34b4deabeed939325c77a7ec2f)
- u-boot v2024.10 from https://source.denx.de/u-boot/u-boot
(git:f919c3a889f0ec7d63a48b5d0ed064386b0980bd)
- dtb from the u-boot build
- bl31.bin from PLAT=sun50i_a64
https://git.trustedfirmware.org/TF-A/tru...ware-a.git lts-v2.10.6
(git:f2aebf361050d69176d60016170291efa9e08a68)
- scp.bin from https://github.com/crust-firmware/crust 0.6
(git:ffe9f1ac9c675e6e67db9084bd19fbdeffd8e162)
- u-boot-sunxi-with-spl.bin written to offset 8k
- tried sd and emmc vfat single partition (whole disk) with
	* boot/vmlinux
	* boot/u-boot.dtb

Files:

- uboot defconfig:
https://g33k.holbrook.no/c36cab0e6a15127...7b25f71bdd
- uboot environment (saved from soc):
https://g33k.holbrook.no/1c4d93e6510eb49...2329468b73
- linux defconfig:
https://g33k.holbrook.no/5bde4487e333f5a...19beb3382f
