Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DFEE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DCF80107;
	Thu,  9 Jan 2025 16:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="AZ1fh/K/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354EE801F5; Thu,  9 Jan 2025 16:31:49 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20653800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d9b9d7b6-ce9e-11ef-bc52-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d9b9d7b6-ce9e-11ef-bc52-005056992ed3;
 Thu, 09 Jan 2025 16:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=i16YvM58Cvq3tDjUjE2rsCjWm6xqd7Ve+cPvuFFWTAM=;
 b=AZ1fh/K/+J8bcMrTv3FlUwyxCMwRxMvgvj/WgLPDZmkyukZDiK+kGYU9JZ85lY+dOduHol2Q0aA8f
 dLTsw4uqWZIuIfjyhBKHE8JsnR5gH0Tvqm1+NCtwt1JAIO+9VBrmFZMc8nMnzxbQbJiyvSu1uNauFK
 kaNpDL0CxAKM2Uqu4fgrcJr8z78j2Zpi/CrPIQwn0sDzJff+EWphxHnEwNXzhTWoDA58rKc4/cLkmI
 Uuec5qIKfMUUHxupYJgfmuRPnOuieQT1eesJioIia1GuFKFzxHkHy0nJFZX09NWDxKCZP87Sa/ivC0
 iXE7f2/sjg0T7c42YbFXDV2im5iAGxQ==
X-KPN-MID: 33|XsFIAPRzbvVEArfXIyMTLDwEmq0pfDW21XNfzzzRTM6ShH/m+JjO9Ei39De973B
 d/EiQx1/RYh3dhh7cWxxQvw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5anv2VwsLu7LksRDlA6nl9PYxBxjPNmsY1z4JWTrUOnriuMfWuv0pzqIohIGtPB
 qyETP5Rr1LiaioHttFyqPCw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d5e64700-ce9e-11ef-b697-00505699b758;
 Thu, 09 Jan 2025 16:31:46 +0100 (CET)
Date: Thu, 09 Jan 2025 16:31:46 +0100
Message-Id: <875xmongv1.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 trini@konsulko.com, akashi.tkhro@gmail.com,
 adrianox@gmail.com, u-boot@lists.denx.de, moritzf@google.com
In-Reply-To: <CAFLszTi02WTz1TRZBtH1JKQo-zfdX345f_HiA9V4ia8j==8fAg@mail.gmail.com>
 (message from Simon Glass on Thu, 9 Jan 2025 08:01:34 -0700)
Subject: Re: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-5-sjg@chromium.org>
 <4a0a3ab8-d828-426f-93b8-364e0eeb9f74@gmx.de>
 <CAC_iWjKyBV3xYDNcXQkZ8QOiWPJxn53kgqoPoT1ZXDSD_SDevw@mail.gmail.com>
 <CAFLszTi02WTz1TRZBtH1JKQo-zfdX345f_HiA9V4ia8j==8fAg@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Thu, 9 Jan 2025 08:01:34 -0700
> 
> Hi guys,
> 
> On Sun, 22 Dec 2024 at 06:17, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Heinrich
> >
> > On Sun, 22 Dec 2024 at 14:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 12/19/24 03:38, Simon Glass wrote:
> > > > This uses a few global variables at present. With the bootflow we have
> > > > the required parameters, so add a function which accepts these. Update
> > > > the existing function to call the new one with the globals.
> > > >
> > > > - Rename efi_binary_run_() to _efi_binary_run()
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >   lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > > >   1 file changed, 25 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > > index b42ff3cb4e0..f7aedeaab8a 100644
> > > > --- a/lib/efi_loader/efi_bootbin.c
> > > > +++ b/lib/efi_loader/efi_bootbin.c
> > > > @@ -228,18 +228,22 @@ out:
> > > >   }
> > > >
> > > >   /**
> > > > - * efi_binary_run() - run loaded UEFI image
> > > > + * efi_binary_run_() - run loaded UEFI image
> > > >    *
> > > >    * @image_ptr:      memory address of the UEFI image
> > > >    * @size:   size of the UEFI image
> > > >    * @fdt:    device-tree
> > > > + * @device:  EFI device-path
> > > > + * @image:   EFI image-path
> > > >    *
> > > >    * Execute an EFI binary image loaded at @image.
> > > >    * @size may be zero if the binary is loaded with U-Boot load command.
> > > >    *
> > > >    * Return:  status code
> > > >    */
> > > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > +efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
> > > > +                          struct efi_device_path *device,
> > > > +                          struct efi_device_path *image)
> > >
> > > A non-static function starting with underscore? Please, avoid this.
> >
> > I was the one who requested this, the v1 had it as efi_binary_run_,
> > but i a dont mind any of those
> 
> Well I'm not changing it again :-) Heinrich you are free to send a
> patch later.

Well, you shouldn't commit a diff where the function starts with an
underscore but the comment documenting the function ends with an
underscore.
