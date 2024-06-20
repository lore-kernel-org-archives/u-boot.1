Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BB0C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 22:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0003A87F19;
	Fri, 21 Jun 2024 00:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="sfjU4Si0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2300B88191; Fri, 21 Jun 2024 00:33:54 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81A287EBD
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 2b87f99b-2f55-11ef-9240-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 2b87f99b-2f55-11ef-9240-005056999439;
 Fri, 21 Jun 2024 00:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=H0EFUfBYIcjduOT6Zl/qQN49wZ7YNqNmWQWXqDGDGUc=;
 b=sfjU4Si0UH+fpU0zK4iG8DQqS2f2+75HrErMX7LGKG+DWWFgeRc1l1iePhg2RqVjoI2q2eYIPAkGh
 cyLo2P0BakDNjeeOJLFYkJLbTdTRoosnyFy8p7MVbPmrUXv1YONEeeSnyfmJCl1RgMaDjFONVAbTgA
 uiwl2F1N8hBmvr6gWmEvdBkEI9jIJR7SvvX5J3v/1YatmTlmKFKUm5djEctOJIk6Ye2sfXhN3cLmzN
 aSqTkNQToZ5D36qv4yT4UsDSkZ8cv0AIlSsnXzKBsVZWTI5Gd2krlMF246DhebsbCZfP8IBLAb1z4+
 vxVrn7Dt2AVNhm9IDY4mSh3ZLGluU5Q==
X-KPN-MID: 33|YNLadeN0e/4+RP3eems1AG15xuRekQWvvgh/DfX+qkwNJvnh+ysjdMZvxkK8rIg
 LJ0HLmrBneJtswboWh+60uB22mf0+/hz3ByVAxqYehmE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|n/a3KrB5uauJ+ibnsuSVrS4z9uR9qV8DzpfqNZVGPnZ+ZNLjCuK9FOxG1mTpDVu
 aAW+VNIQmHM2Ry7cdzsdWXQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 2a33e0b1-2f55-11ef-8b18-00505699d6e5;
 Fri, 21 Jun 2024 00:33:50 +0200 (CEST)
Date: Fri, 21 Jun 2024 00:33:49 +0200
Message-Id: <87msnf2qia.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: nm@ti.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, pbrobinson@gmail.com, eballetb@redhat.com,
 uboot-imx@nxp.com, jwboyer@redhat.com,
 kever.yang@rock-chips.com, heiko@sntech.de
In-Reply-To: <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de> (message from
 Quentin Schulz on Fri, 21 Jun 2024 00:22:43 +0200)
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
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

> Date: Fri, 21 Jun 2024 00:22:43 +0200
> From: Quentin Schulz <quentin.schulz@cherry.de>

Hi Quentin,

> FYI, the DDR bin is printing stuff on the console, so we had to modify 
> it (with a tool from Rockchip) to remove the gibberish breaking the 
> terminal by setting the appropriate controller, mux and baudrate (for 
> our products, there's no one size fits all :) ). The question is how to 
> handle this since we cannot realistically store every possible 
> permutation of that binary for each UART controller, mux of UART 
> controller and baudrate (the only parameters **we** modify, but there 
> are tons of others).

To build the RK356x and RK3588 of the u-boot packages on OpenBSD I've
written a small program that changes the baudrate from 1500000 to
115200:

https://github.com/openbsd/ports/blob/master/sysutils/u-boot/rk356x/files/rkbinpatch.c
https://github.com/openbsd/ports/blob/master/sysutils/u-boot/rk3588/files/rkbinpatch.c

This just does the bare minimum and it might break with future changes
to the layout of the binaries.  But I don't think it would be
difficult to add a few more parameters.

Cheers,

Mark
