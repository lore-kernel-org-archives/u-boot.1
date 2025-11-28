Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE19CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 05:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FDD83B9B;
	Fri, 28 Nov 2025 06:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MD9ReRDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4F1842A7; Fri, 28 Nov 2025 06:50:48 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D06E83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso2332998a12.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 21:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764309046; x=1764913846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvXFQZ/D0ZCD/e34IlA92isdpWj+WsIqj68VEavcQVg=;
 b=MD9ReRDNEC3K3SABRgMfnp9mghRuTR9z5hMVk6ZLMgEsvyZO8CXr56gEUNgrehNeC6
 SXyLXAk/BdYkN+udT7ChmWfTuljMwd9tdvHig+inl6RQ4P4uw7BFCRmkSviwe4lSo2z5
 5+Aa7JYlEZX2jgnB4bQoHSztuqrfYGw7z0yaB4MVsxQo3sPio1DhiD7c66CtpsJN3i/x
 CXM/ATNdk5Oe7e7BQ5ByvC1eJym/o73i/8mEmJODkfW4o+WgS4y9I4ca9po3zYNc/4hd
 +YNYuppCCo9jXPTGmmLR3G8FtEmxH3G4Di4m0hKaiSvkwAiowPxlLMrezcDgztyAIAy1
 CpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764309046; x=1764913846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvXFQZ/D0ZCD/e34IlA92isdpWj+WsIqj68VEavcQVg=;
 b=NQuAgtJw15O+b8kb0RyCH0l0DUeCQ3U8UAtS1rsOy7GxEz1I+THIMNCr4mrLRsakZ4
 KKolxCnEydpJBEIRG4c1Gst09k/RgRqrVNou2D+H94stQ/tytKbRS4+NtBwXZ1h6xMpa
 wLxHlQPOpGi0uS0KvyZNrO32gnhE9VqpTq1Gg8+IUmjLu4X1Vbh0rV+FILhNwTViaA/3
 p2WcWrT0g0eyNQUsCsr1IoyoAdFex6SiZaDqZgJnSCSbpjnSPLkwzjoYEH7ZIIjaM/Ge
 YYGsrQ3OeKsz2TcASylEkWHPzmoe+nxIBk7I5pxjyus5RaO99Z5yso5yjU2Zu5EEvx9P
 QmdA==
X-Gm-Message-State: AOJu0YznIxrEWPi7k77VmyE5eknCLxnPbb9mnbaLdqsLF/6fNZPEmRi9
 AwwdEBJkIG4cMDnAFWSP+sEmSlb/HAvo9K1f0m7ROAsCS1BQOft6d0cKOpGf5OlG2c/uzHdH3cu
 dnC99snwAn9ZH2OfTaNH7JrIwMtLve40=
X-Gm-Gg: ASbGnctz7tqeLiMLyrTI3d7Qnksy4iUpLNH8m/+Tm8sAg1Xlvo9hSZ//ICcMUmaDwVW
 XmpmjvRHPXC5JzXB5SLcSaBgYnVh9PEFlt9A+5fnoahm+g7EM7U8/A36AA9H85WWpS0/RZsBRZU
 tRmFVSOhKlixK8CIX1nYl6t/2v6S6vnrMNIe5zHK46xBtMLmfG5do0MHrgn2mzmv3MPZWYGOf/u
 F0qKYIHmS72358Q/gB89m6uvrL0ds3R59e8XTTbyZuHqPTPn1rduqmz+S2xStdp74edqAhDWDUp
 bnni
X-Google-Smtp-Source: AGHT+IE7trx3C9J44NMoPzKTK4VroQhRYYNhK/LiKjQHnBzVrEIthOTZzbW8Lk6hq7LzAOfbgeJ5dYXtSgyrgNo0P7Q=
X-Received: by 2002:a05:6402:1469:b0:647:57d5:ba76 with SMTP id
 4fb4d7f45d1cf-64757d5bacbmr1200511a12.14.1764309045493; Thu, 27 Nov 2025
 21:50:45 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
In-Reply-To: <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 28 Nov 2025 11:20:28 +0530
X-Gm-Features: AWmQ_bkqsPuT81JIPon1kzzxSn0eiQktR4hfol0havVNsh-8k-ghScio-aajrP8
Message-ID: <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Heinrich,

> > Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
> >
> > But I am booting from SPI flash, so I cannot stop this board in the
> > U-Boot prompt.
> >
> > Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
> > in the user space to spi flash? using dd coammnd
> >
> >  From the schematics, it has W25Q64FWZPIG
> >
> > [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
> >
> > I have tried to enable SPI flash, but it is not getting detected on
> > the board in userspace.
>
>
> https://wiki2.radxa.com/Rockpi4/dev/usb-install
> has some guidance how to avoid booting from SPI NOR flash.
>
Thanks for your tip.

I've attempted this method, but it hasn't worked for me.
Could you provide the SPI details for this board so I can map it in driver code
and from userspace and then attempt to erase or reflash the image?

on my board
[    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
[    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff
[    1.285967] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB

> Set the jumper as shown in the picture to boot from SD-card.
> Once booted remove the jumper to erase or update the SPI flash from U-Boot.
>
This board does not return to the U-Boot prompt.
So I cannot debug this further.

> Best regards
>
> Heinrich
Thanks
-Anand
