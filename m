Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B600D29FA5
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 00:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4C4891E9;
	Thu,  7 Nov 2024 01:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="y6+GFm3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7859A88FED; Thu,  7 Nov 2024 00:33:44 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A90C88E35
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 00:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1730936022;
 bh=NbSSz/x9taAjkSlvm7QUK6dIbtpHcXICizlSryvYy/A=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=y6+GFm3Xw90qfVlGuj+N5pm1JOVPmB/BBiFfOqdFt0Eg1GRjNjjzR7FOc5081cf59
 gSTSIy+ehfDgrp0Ae5uyLGd457At59iuV4GsD/BsJMtzJpzd5mbzLYNGavrYri5xDD
 dMpFPqF8zT3sOW/S0B5lji7B3hQmU0qz8YkcGWro=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4XkM3B2Kx0z1xyK
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 23:33:42 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XkM360GRzz91pT
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 23:33:35 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id A062A2E256F; Thu,  7 Nov 2024 00:33:34 +0100 (CET)
Date: Thu, 7 Nov 2024 00:33:34 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: SiFive Unmatched: Linux kernel doesn't start (U-Boot 2024.07)
Message-ID: <Zyv8zn2oGmmKz5XU@vodafonemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1008
X-purgate-ID: 155817::1730936018-3B7FD466-131D9992/0/0
X-Mailman-Approved-At: Thu, 07 Nov 2024 01:52:53 +0100
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

Hi all,

To all owners & active users of the SiFive Unmatched board: do you have success
running any recent upstream U-Boot on your system?

I use the default U-Boot from Ubuntu 24.04, and it boots GRUB and Linux
kernel just fine. Today I flashed the unmodified U-Boot 2024.07 (compiled with
"make sifive_unmatched_defconfig" and OpenSBI 1.5), and the Ubuntu kernel
(6.8) doesn't boot at all. The last message I see on the console is:

EFI stub: Exiting boot services...

Adding "earlycon=sbi debug" doesn't change anything.

The same behavior is also when GRUB is excluded from the process:

=> nvme scan
=> load nvme 0:5 $kernel_addr_r /boot/vmlinuz
38603264 bytes read in 47 ms (783.3 MiB/s)
=> bootefi $kernel_addr_r
Booting /\boot\vmlinuz
EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...

Is some additional patch needed to run U-Boot on Unmatched?

-- 
Regards,
Yuri
