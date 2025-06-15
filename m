Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E4CC61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951BE82CB6;
	Sun, 15 Jun 2025 12:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TFxmX1+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF6582CA4; Sun, 15 Jun 2025 12:57:11 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7237E82CC9
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60727e46168so6037101a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749985027; x=1750589827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vn3wHSCaj4M6TW8nZZAsTATdqYloQGUyJTEzACOCQGI=;
 b=TFxmX1+eYUQVsL4PediAuY+gXr4SNU1/TK+fa40jTesl3nrO25pBG2xPd34rnFhEQO
 e2vmqKiWDEKkUwOd6zPqxPXK7DMiH4PZZw4+kkB58LvvUUxL5Q5Df5rBDuQHUZpuAMGx
 aLSZTOnUB1uRn+1jm5+Eypiu21/m7LHZGNbnZLO0dCQrHtJLjkPBZ1ChSO0uuYEt/Euv
 isHp3x4aieLwHS7SDXW4zwotzfukxTKWk3pbMrd748XVi6nuenI9Zm1k177V6VT+xAE/
 JKnVmTGIssQWvvRcxJ8hMxqV1TP5V3xDsOD1b0HFVsFq9ENSLbK2lClArIysAJrPTOJM
 CnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749985027; x=1750589827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vn3wHSCaj4M6TW8nZZAsTATdqYloQGUyJTEzACOCQGI=;
 b=knT6pn2f/BMikKWscmQJYBNirFYz52esspU7nX9PMg6YmknAIZ8Rq47i5N0SYSIwnn
 xflwI7IFMUbqpcHEeLrRD5k3S611yyKVtAseCe4qmXW9aFX3awUNtUy/7GxAXwL8d9YU
 b/VbRxjNDwMkzX5Ka+Ov3CycpzmcVWwzko8t2UptlU83bVH4be4SrK/KRO/4MV+TUCot
 Ymjp9dnnuECY5I6sKySCiqQXmYZNvdMpa2v6IVQ+i6QawqJuEYujGVUvXtLfYNAPAb78
 pqrY2hbf25xiRqFJiszwLR98GOH0GnMw/sCCPlHii/6Tyl9Q8l9XanS9oHWeeACUnZjb
 eiHw==
X-Gm-Message-State: AOJu0Yw0ClVKr145d4QKcQs6WCXtUwIhQJzLcfhu/tVyZV8Pw6YmXkeN
 LM3BjG+D569MIYJqQjwkM/n/HjGAy4jNNujuE9JcmO6jX9uTqHaHtmrRiejwDQ6ef2DHp9kYTV+
 eBUJ2dHGhZyAKYDn8d9mFzTQAMdvzJFs=
X-Gm-Gg: ASbGncsvH7pMGmWru71nfyGwIBh8ET16RQkyP/sagMBv6d5m2ga9GY/4wCfwldxkkUZ
 WBAPPAyc3uxg8mICMAtF+qV152O3C2VQLjOuDm5A/1R7N+XCuG7bgoos3li1AhFH+vOsgJ+4Ifd
 14pN9YpTiE89u/INH3L7/T7x6UtqSLV1MC8sEvr9k0BR7xlPiT8VKQxF4pibnLGAPkOTIx8eeoR
 82qD3cEY9sbrmY=
X-Google-Smtp-Source: AGHT+IGVJQ0E5xDPAtcyUDqweZQDrtcsQpvMdplpnyqPgejTlEJRMPA89wCfH5lj4OZWe5U+5NiRCTGdvwycd2Tig00=
X-Received: by 2002:a17:906:ee8e:b0:ade:76d0:fd9c with SMTP id
 a640c23a62f3a-adfad31bd39mr515761866b.3.1749985026545; Sun, 15 Jun 2025
 03:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <294e9037fe8b9502b41a06e9ac9363f2d5204b07.camel@opensuse.org>
 <851157797.299472.1749160367219@mail.yahoo.com>
 <da35020455a4a086617a0588ba913b5ad3d2dcd9.camel@opensuse.org>
 <1801521580.655864.1749318986908@mail.yahoo.com>
 <3b7988777abfb62a51cd2afa92764dfcb9f4a134.camel@opensuse.org>
 <1287835630.661385.1749328029886@mail.yahoo.com>
In-Reply-To: <1287835630.661385.1749328029886@mail.yahoo.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 11:56:55 +0100
X-Gm-Features: AX0GCFvF2mN4vRWIy9GqDue5qRrXdPbGaQbrrhPyKj2UxHpE3f0-feUDHd5zWaM
Message-ID: <CALeDE9OgocnDjk57pUvK_VVagi7ay1wcDj5=XfnTeO0sn6VuAg@mail.gmail.com>
Subject: Re: Raspberry Pi Compute Module 5 support
To: Jojan <jjvazha@yahoo.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Jonas Kvinge <jonaski@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 7 Jun 2025 at 21:27, Jojan <jjvazha@yahoo.com> wrote:
>
>  Sorry I mean 2712Raspebrry -P 4 , that the U-boot support as of now incl=
udes , bcm2711.dtsi
> bcm2711-rpi-4-b.dts:#include "bcm2711.dtsi"
>
> However RPi-5 uses broadcom 2712 chips.These dts files are not available =
in u-boot.Howver you can get it from other places and modify / inroduce in =
your device tree source and configure correctly.

By default it will use the DT passed from the previous firmware, the
advantage of this is it deals with any of the overlays and other
pieces applied.

>
>     On Saturday, June 7, 2025 at 11:19:28 AM PDT, Jonas Kvinge <jonaski@o=
pensuse.org> wrote:
>
>  I've never heard of bcm7712, it's not
> on https://github.com/raspberrypi/firmware/tree/master/boot
> Or do you mean bcm2712?
>
> I managed to get u-boot v2025.04 to load  by setting boot delay to -2,
> same issue as described here:
> https://lists.denx.de/pipermail/u-boot/2024-December/576043.html
>
> What are the changes does the custodian version have that are needed?
> It seems like it's not up to date with the new version u-boot.
>
> Jonas
>
> On Sat, 2025-06-07 at 17:56 +0000, Jojan wrote:
> >
> >
> > Master is ok. But it won=E2=80=99t work as is. You need to have rpi5
> > configuration and the dts files. I did it a year back. But since  did
> > not have bcm7712 dts files, I took the dtb file from the raspberry pi
> > images ( it has a pre built dtb file, and extracted dts)
> >
> > dtc -I dtb -O dts -o <output.dts> -i< input.dtb>
> >
> >
> >
> >
> >  On Saturday, June 7, 2025 at 03:26:31 AM PDT, Jonas Kvinge
> > <jonaski@opensuse.org> wrote:
> >
> >
> >
> >
> >
> > Which branch? The master branch is 1 year old.
> >
> > On Thu, 2025-06-05 at 21:52 +0000, Jojan wrote:
> > >
> > > You need to take raspberry  ( custodian version)
> > >
> > >
> > > Making sure you're not a bot!
> > >
> > > Making sure you're not a bot!
> > >
> > >
> > >
> > >
> > > But it is still missing the device tree fro bcm7712 ( RPI 5 is
> > > bcm7712)
> > > But you can Dow load the dtb file from the pre built dtb file from
> > > raspberry pi images
> > >
> > > and  use those  device tree sources ( using a dtc )
> > >
> > >
> > >
> > >
> > >
> > >
> > >  On Thursday, June 5, 2025 at 02:13:24 PM PDT, Jonas Kvinge
> > > <jonaski@opensuse.org> wrote:
> > >
> > >
> > >
> > >
> > >
> > > Hi,
> > > I'm trying to boot openSUSE Linux on an CM5 using a sourcekit io
> > > board
> > > (https://sourcekit.cc/#/).
> > > u-boot seem to be stuck with the logo on the upper right corner, no
> > > text.
> > > I re-built u-boot using the latest source from git from the next
> > > branch
> > > and also set CONFIG_LOG in make menuconfig, but still no text.
> > >
> > > Is the CM5 supported by u-boot?
> > >
> > > Jonas
> > >
> > >
> >
> >
> >
>
