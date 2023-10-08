Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B982E95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 22:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D40286406;
	Mon,  9 Oct 2023 00:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CEJaX1Rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3E486538; Mon,  9 Oct 2023 00:32:54 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9101863CF
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 00:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-65b0557ec77so23789836d6.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696804369; x=1697409169; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FNXgeLTAEHhaeHQhPNtcXqpf4G01yhUfjOkBs5+VvOs=;
 b=CEJaX1RpVxdwMXyC+SjcehQ2AeJx4MWrN3RoBdAq7PlzBxioOhSOrhntdzNYlJwYuD
 HcNbHPlUNGa1Y4T2J0y6RkJffg8gA/YAuwV8u12Qcrw4Scdx2qNkn8b6Q602N8knV+81
 i/nW5o4esQ+E2dAY5aWVFz+b4baWQxw8xOke8x1uyLsWIRv9TSzhXa7y6V82oBOuj73r
 cXQkJNX5vOL2MoM/lpLKiZQeGV7qf9mWOk5oNnaxjYlPHEbUU06NvBap0WyY6ob7+SHT
 XaVUx6V2qZyc3iDnj2PdUhg708uH/hDInUIzJl1gVFLTQQy7pafZNgEln5v/+ozSa2bN
 KlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696804369; x=1697409169;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FNXgeLTAEHhaeHQhPNtcXqpf4G01yhUfjOkBs5+VvOs=;
 b=lPxufxxB4xj724bQRJgZP/KnfRFt/lWHbDmFW8YJpF22ZnlvNY/otjom53zDfmVTlj
 v/ikfCmTVPap+cdN58CSrWVC9sDSyyJk+8xA91WynYmhgQnu2MUqvoKQlAuH/fpJYm2s
 kxc7j6iqiX8jMZa1aP6tcfTO9e5J3b5NyDIns0KQWH1mAq1jJRRdZ8tZzzu6AAU/ufFn
 P85jz0SExtyaBYZjBa0gfbdw3FoAHG7nX4YzLwF1DixKAkRylm0aMurTND8bU1cSuDTa
 nm1/3HuzWaoyUQx6p+RQbeG1iG6hdBiuQB4ifOvdtfnP+zSz7pyKYCwNX2Ov+nHmZUp5
 k2Zg==
X-Gm-Message-State: AOJu0YzzihgPG1FyZf9jBpJdObzQkBrEeNNiWrOE5qx4W+RD+CZRivBB
 XCw70PfcYl8R6CuNtnplE10=
X-Google-Smtp-Source: AGHT+IGWK+fI6wtU/yk5cJ4omJBTOSFdRKeJhpTd2EOW7YHdsfc0YA1ROkToocm4MRnfNQ7RB9u4PA==
X-Received: by 2002:a05:6214:3019:b0:65b:150e:604b with SMTP id
 ke25-20020a056214301900b0065b150e604bmr14866586qvb.49.1696804369466; 
 Sun, 08 Oct 2023 15:32:49 -0700 (PDT)
Received: from Dell-Inspiron-15 ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a05620a11b800b0076ee973b9a7sm3077357qkk.27.2023.10.08.15.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 15:32:48 -0700 (PDT)
Date: Sun, 8 Oct 2023 18:32:46 -0400
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
Message-ID: <ZSMuDsxG8M6opMFy@Dell-Inspiron-15>
References: <20231007155535.1699567-1-benwolsieffer@gmail.com>
 <CALeDE9MX8FiayfjY=Wv2y3n9DBkTAqQsqnNjDkCXDDUeCSMLag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALeDE9MX8FiayfjY=Wv2y3n9DBkTAqQsqnNjDkCXDDUeCSMLag@mail.gmail.com>
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

Hi Peter,

On Sun, Oct 08, 2023 at 07:21:57PM +0100, Peter Robinson wrote:
> On Sat, Oct 7, 2023 at 4:55 PM Ben Wolsieffer <benwolsieffer@gmail.com> wrote:
> >
> > Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
> > fail to boot. c771e5b explains this approach as follows:
> >
> > > We don't need to specify the mmc devices individually, since they are
> > > used in order from 0 to 2, and standard boot uses that order anyway.
> >
> > In practice, U-Boot first attempts to boot from the unconnected mmc1
> > interface, and, when this fails, moves on to attempt the USB and network
> > boot targets rather than trying mmc0.
> 
> Really? It shouldn't be enumerating it if it's not defined in device
> tree, I've not seen this in my testing.

It does seem odd, but U-Boot definitely sees two MMC interfaces:

U-Boot> mmc list
mmcnr@7e300000: 1
mmc@7e340000: 0 (SD)

> 
> > This patch explicitly enumerates the mmc interfaces, causing each to be
> > attempted in turn. This matches what is done on other boards, and allows
> > the system to boot successfully.
> >
> > Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
> > Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> > ---
> >  board/raspberrypi/rpi/rpi.env | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> > index 30228285ed..02210b97b5 100644
> > --- a/board/raspberrypi/rpi/rpi.env
> > +++ b/board/raspberrypi/rpi/rpi.env
> > @@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
> >  fdt_addr_r=0x02600000
> >  ramdisk_addr_r=0x02700000
> >
> > -boot_targets=mmc usb pxe dhcp
> > +boot_targets=mmc0 mmc1 mmc2 usb pxe dhcp
> 
> Why are you adding mmc1 and mmc2 if they're not connected?

I was trying to match the old distro boot behavior, which had three MMC
interfaces listed.
