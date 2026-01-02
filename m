Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22AFA3755
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 22:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2456884203;
	Fri,  2 Jan 2026 23:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAikz2go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B97078428C; Fri,  2 Jan 2026 22:46:22 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF29983B49
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 22:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7f651586be1so112045b3a.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 13:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767390378; x=1767995178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CXg3z5dp8CbXbXs6UWRTwiIf+z0ANeQMvno05oXJBjI=;
 b=FAikz2goJjqJycadsbwSXmZ5xcSy/bqZxa1eM6GSs/g2Eo/Ik+Qxf/Yq3WiDG9hX4K
 5xM5FjF4eH4ZFNewNiX7pHHv+9A4B1NAiKcRa81Peh2lRG+fQiuYnDFj584v/kW8Um//
 ZkeS0fE8v2TvW1iEYoTH0/InxO6ozlj7guZ8iBj2pOrn+/UjnkY8RsU7qWIQ+mSPBTSe
 Yh8G1YEYrlst69NQblhguMKjWIcUWOKQDhDKCiIziDlIWH5bfgZtDiFtY/22dKk1eYIc
 dW/UIBkFHv2gXNoaF+0QgD+oscEL3zzrTDGjy/j6f3JKy+Ls5AHWZSQRKDKCEoel8myA
 m7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390378; x=1767995178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXg3z5dp8CbXbXs6UWRTwiIf+z0ANeQMvno05oXJBjI=;
 b=wnW+vwT8SC/pqSZlN/KHLllxzbqUhFu1Filj4uCAGBGQOLMhIRr5UbGi1fbKQeVneh
 QXk7zosePSbuD/GseOXpr20kzTo98XB59YPrQAe9DaoVhs9yCzb0xHaZvGZsBtYIudqj
 GbKfI793gcx9aZ3wlyzySPoQKM9ZBLHbR8nz/feyG+HireZovdmHTO05RV5BMMzf82mR
 OrTrYmfGyAUjUUewJreJZ9NfuKJt0+ac1AGcr1OhG63y9i3sUKcUZhVkJr2J+sGjFOVD
 Pd0TUPTUkkbO8ehVyPTTSSf8Ig2QRErwUskYwwzxMAiY993FOJ0/akgbMUV90H9+dY//
 E0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN3KF6Gx1Vs2p5OWtrxl6sH3QRM9jY4lPu5Ojg1rnb8etaT7+Itc6/NcejcADEF8LmwII0aig=@lists.denx.de
X-Gm-Message-State: AOJu0YyO9XBSk1N9bJi0X8T2IoSqdKJLlImdOni7WsrgVnYkaX7sFqXt
 JCbYas6LAANbl0BxU7nIEARKK1KGvwubRLgOk24h3F+YDaigC3TajGHX
X-Gm-Gg: AY/fxX5tu7NGK5Frz+IbtKqXf9IVDLt0tQgxaumBHkGgGqdggBgR0MpJeqZNvwGZY7k
 bNyvjYCbzWUiB+xjr44oa5y/2Xq32SgPqzNcCv4SVbTAvVcOqRgqR+kScuASLsu0O8qxjBu3U3U
 BgQ3EeHcjIbWF0nMwHw9gNPjJpPMpkSWKnHV2Gs3HDEXzAUxi9CM7wSIIylDgFkZZFZABpmJQtW
 TN+/FMD8xpoTwnqJATCEkH7XaITB2gO9VWzgdXMO5o7AoPaxKUxXVzNau5zBxy23zQ7od+GvnKS
 XmotmcXgfc1XJi1Bm4bM4ZIfAPMGi1yTGaM8PR9SspLJbIzWmKpAL4ZcIRoH98niBv3bh7EysWo
 o06xkDIb+E+6cW35BZJQ3yoM6GBDzjswqhn4/n+l0KPW7Z8sPvF0kLSuMltZABBk/F6V1AyXpci
 npXD836KcsOhvQIjjiVu7eZdfkUP1M8NWWbamaKsjuGHTqIkYLyMi2rs/ghw==
X-Google-Smtp-Source: AGHT+IEMVVRwMjs9glHiuQRUMNllJZV/gXKs5fMG7oIfSHNseGbVQhlJFok9SGFWgE32fF9Rybksbw==
X-Received: by 2002:aa7:9f4c:0:b0:7e8:3fcb:9b03 with SMTP id
 d2e1a72fcca58-8148c00b373mr585022b3a.25.1767390378229; 
 Fri, 02 Jan 2026 13:46:18 -0800 (PST)
Received: from google.com (61-230-44-212.dynamic-ip.hinet.net. [61.230.44.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a93b41fsm41030629b3a.13.2026.01.02.13.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:46:17 -0800 (PST)
Date: Sat, 3 Jan 2026 05:46:13 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
Subject: Re: [PATCH v4 5/6] board: Add QEMU m68k virt board support
Message-ID: <aVg8pSrbesxw7Abv@google.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-6-visitorckw@gmail.com>
 <e30ef59f-41e9-4b59-bc65-c963bdfd7e40@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30ef59f-41e9-4b59-bc65-c963bdfd7e40@canonical.com>
X-Mailman-Approved-At: Fri, 02 Jan 2026 23:16:51 +0100
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

On Fri, Jan 02, 2026 at 10:26:45AM +0100, Heinrich Schuchardt wrote:
> On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> > Add support for the QEMU 'virt' machine on the m68k architecture. This
> > board emulates a generic machine based on the Motorola 68040 CPU
> > equipped with Goldfish virtual peripherals.
> > 
> > Introduce the necessary board configuration and initialization
> > infrastructure. The implementation includes logic to parse the QEMU
> > bootinfo interface, enabling dynamic detection of system RAM size to
> > adapt to the virtual machine's configuration.
> > 
> > Enable the Goldfish TTY driver for serial console output. Additionally,
> > enable Goldfish RTC and timer drivers to support real-time clock
> > functionality and nanosecond-resolution delays. Include comprehensive
> > documentation covering build instructions and usage examples.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > ---
> > No changes in v4.
> > 
> >   arch/m68k/Kconfig                     |   8 ++
> >   board/emulation/qemu-m68k/Kconfig     |  12 +++
> >   board/emulation/qemu-m68k/MAINTAINERS |   8 ++
> >   board/emulation/qemu-m68k/Makefile    |   5 ++
> >   board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
> >   configs/qemu-m68k_defconfig           |  16 ++++
> >   doc/board/emulation/index.rst         |   1 +
> >   doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
> >   include/configs/qemu-m68k.h           |  18 ++++
> >   9 files changed, 222 insertions(+)
> >   create mode 100644 board/emulation/qemu-m68k/Kconfig
> >   create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
> >   create mode 100644 board/emulation/qemu-m68k/Makefile
> >   create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
> >   create mode 100644 configs/qemu-m68k_defconfig
> >   create mode 100644 doc/board/emulation/qemu-m68k.rst
> >   create mode 100644 include/configs/qemu-m68k.h
> > 
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index de7c673c376..605ae5ec20c 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -183,6 +183,13 @@ config TARGET_STMARK2
> >           select CF_DSPI
> >           select M54418
> > +config TARGET_QEMU_M68K
> > +    bool "Support QEMU m68k virt"
> > +    select M68040
> 
> Not even the dm command is available on the board by default. How about
> letting TARGET_QEMU_M68K imply CMD_DM like other targets do?

Agreed.
Will add imply CMD_DM in the next version.

Regards,
Kuan-Wei
