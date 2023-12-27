Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE085C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 20:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A108775F;
	Wed, 27 Dec 2023 21:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fkX9+KDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5CB87835; Wed, 27 Dec 2023 21:07:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A08E87740
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 21:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso2138460e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703707628; x=1704312428; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eQZqrXKtxGpXAem+ovJrhTffr7FD9Kzt8nnnrO0xCE8=;
 b=fkX9+KDc1dGmNsIiQyghvlJ3BOSCjdJyRV+T7nc6xNnhCc69fAfdRkH5HjE2qnk9aF
 XvsufKolLVO3t+tElHvM7RjTaa5BQ/Lz/5cTuwF0eNRDEs2xSDKpMREe+XMGW93S4RGg
 Rk3wCWyPvRK2G3u9h1fhe5ly29y2wVlNe88wdaDk52Ub3mg9dD3ZYLbOOvteC+UJ8Gbn
 eK5JUwmESUk5un4jePPmRNL1iRrFG2lkjObhuuohBobPnskdR4z2kqHwPvYdydW5j1hv
 JKQ32/BVh6SEY7ylSSjyA2iYqgEtBDPxM2gSQcP5SWQ5lsqHqba4UNY2Z3AAjsC4M9yE
 LUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703707628; x=1704312428;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQZqrXKtxGpXAem+ovJrhTffr7FD9Kzt8nnnrO0xCE8=;
 b=inBw8Pt9IuY3pCmwqAc1ZzR6HcE8wvXGyTbrzpcB9C7iOxiZSL09pPNFBL07GUcp8x
 /ZPN6D+xipiH2kxncrMWxJYbvksc4ieZzpuOch4wGyCbIwB27cm2IU4Iy3KkEuldVfHZ
 +yOMGWj2l4a50dQ6Zw9F+5HnJ55waWxXFJ5PtO2wyJjxRVk57tUr7Gmw4rKtwa9rMngF
 SN8QmK1rQ0T8gyWmtJ45Ny6rxvM56vI3vncQDzx+v5lKXz/ExFirtVEGCEOxqWGFM6bp
 zUBjHILlju7aRIQZylNAQV4qdC3UDhHjGg/3nM0MTT0XgjU6sj0TiKazsGnSnMYrdh/b
 Mm+w==
X-Gm-Message-State: AOJu0Yybg82XPxKnCxhVYcN0LXfWJ53S3B6FgFUmJiV/xHx5+0J2mVKu
 Nq/ms/VfW77wo8rl5dzgWKUeYzcFvV7TzWTeHczfYje6y3n2TA==
X-Google-Smtp-Source: AGHT+IF4yHAqHTmIcc/VQhge3MoKdgLBIoFzPYuIy3yxRpIZdiWgLITXqVOAl5Qjnd80JgF0pdEgtflGqZ1ZbBpwyfU=
X-Received: by 2002:ac2:58e5:0:b0:50e:76bb:fc82 with SMTP id
 v5-20020ac258e5000000b0050e76bbfc82mr2092761lfo.69.1703707628047; Wed, 27 Dec
 2023 12:07:08 -0800 (PST)
MIME-Version: 1.0
From: Mario Marietto <marietto2008@gmail.com>
Date: Wed, 27 Dec 2023 21:06:32 +0100
Message-ID: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
Subject: I'm looking for the source code of a specific u-boot version.
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hello.

I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chromebook
SNOW with xen. Basically there are two ways to accomplish this task :


1) to write a patch that allows the FreeBSD kernel to boot as a zImage
file. This could be accomplished applying this patch to a specific
file that's on the source code of FreeBSD :


https://xenbits.xen.org/gitweb/?p=p...8;hb=0782e25d98cc1391472717035f986c979edef0c9



This patch was written by Julien Grall a lot of time ago and now it
does not work anymore. This is the reason explain by the xen
developers :



It appears FreeBSD-CURRENT removed the last step converting the kernel
file to kernel.bin.The patch can be readily rebased, but without
kernel.bin that doesn't do too much.



So,without a rebase of that patch the first option is not applicable.
And I'm not able to fix it.


2) booting FreeBSD using U-Boot,as explained to me by a xen developer :


I was trying to explain why and how Julien's patch works so that you
could be the one to re-do something similar or fix the patch on the
FreeBSD kernel that you are working with. I am happy to help review
and write patches but I don't work with the FreeBSD kernel so I
wouldn't be able to help you quickly. However, I might have a
suggestion. Do you know if FreeBSD can be booted by U-Boot ? Because
U-Boot definitely boots as Xen on ARM guest firmware/bootloader. You
should be able to build U-Boot and use the U-Boot binary as Xen guest
kernel, then U-Boot could load FreeBSD from disk or network and start
it. For instance as domU config file:

kernel="/home/petalinux/u-boot.bin"
disk = [ '/home/petalinux/test.img,raw,xvda' ]


Actually I'm working on the idea n. 2. Basically I need to find the
proper u-boot file that's able to boot the image of FreeBSD that I
have installed (13.2 for arm32 bit). Maybe I found it here :


http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/nv_uboot-snow-simplefb.kpart.bz2


I found that link inside this tutorial :


https://wiki.freebsd.org/arm/Chromebook


the version of u-boot that has been embedded in that file is the following one :


# strings nv_uboot-snow-simplefb.kpart | grep U-Boot
U-Boot 2011.12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250


So the question is easy : I need to find the source code of that old
version of u-boot,because once compiled,it will give me the proper
u-boot.bin kernel / bootloader file that maybe will be able to boot
FreeBSD.


-- 
Mario.
