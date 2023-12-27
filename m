Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ABBC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9AD879C3;
	Wed, 27 Dec 2023 18:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TcQgR8cO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46568794F; Wed, 27 Dec 2023 18:49:09 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A681F87946
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f7aa55bfeso46123906d6.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699345; x=1704304145; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYgTHtLXlZ4p/jVAFYLB0NJdrrjF2ketL9BPM1Sq3kU=;
 b=TcQgR8cOVrz7Gje6WpwICIGHRTpGrf80ZCjEajJ2BZ+gYiKd10kSPj7ZjCLU/A8PDS
 rSawjQpLpYZE3JoA9srQoy940X2yrlweyYEZlxX5GRzJOMfzqUVLgm3t85RhLVhMkksh
 GstmJFjLsnCSKlCOVN1DD3T4tBML7e30NW0Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699345; x=1704304145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYgTHtLXlZ4p/jVAFYLB0NJdrrjF2ketL9BPM1Sq3kU=;
 b=LmZ0RkzEjOQyFWMptyCrjYE3Qa1MNAMDWuA/tdj5W+RyCGrRwegwzbw2VS7pgxPQBV
 EjPq3WoB9wGeYn/ueuwvNG+pAyGtTB7WNSZLOwvclou5D1UvOpe4nK6JMeQ+tMC9WP1R
 7ZbyZ5nyPZ2jSEGTo49S9TwFKnFcWUpntN1vEstWhYGn+vIfi5376Puv456hPcASM996
 Fv4DrOJXyOp501KbcNfh+gaY1W+iZDsjsyks25B2U5qzgR3vGtIk0+zpL6DnKAbFV2Y8
 11wJ3BSfmRM8s+ho2L0pSHBpL6VOWiVE7pt37tq5ezAWKf4tZaNFXclyZmNQNqQv9LWF
 PEzg==
X-Gm-Message-State: AOJu0YxTzZ2h7ii6VX+8miy2tlRhORtB8obVvRbEpKNI0kWIdi7OACjE
 eZFd+AaZscKApAHccTTRLfdyfhVnTwa2pRhl3Q/7xQdVebO2+biluNgBGRBePw==
X-Google-Smtp-Source: AGHT+IHobL9ZXw9zBZEAqVoYHskO+/kPnbkPlIP78ERxjDWxR4/c+EjPvd6ABZD2r/1ezzrvwImGLDLdlWkrS5VIA90=
X-Received: by 2002:a0c:d646:0:b0:680:141:3aa8 with SMTP id
 e6-20020a0cd646000000b0068001413aa8mr6797353qvj.109.1703699345515; Wed, 27
 Dec 2023 09:49:05 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
 <51c47679-32d8-45a7-9d9a-4c534ed98c32@gmx.de>
In-Reply-To: <51c47679-32d8-45a7-9d9a-4c534ed98c32@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:54 +0000
Message-ID: <CAFLszThR79UyrqDai3U2Kb6mAvGOPAg_pTcSBoPvG8c4c7S+iA@mail.gmail.com>
Subject: Re: Proposal: FIT support for extension boards / overlays
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>, 
 Andrew Davis <afd@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, Dec 12, 2023 at 3:43=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 12.12.23 15:05, Simon Glass wrote:
> > Hi,
> >
> > The devicetree files for a board can be quite large, perhaps around
> > 60KB. To boot on any supported board, many of them need to be
> > provided, typically hundreds.
> >
> > All boards for a particular SoC share common parts.  It would be
> > helpful to use overlays for common pieces, to reduce the overall size.
> >
> > Some boards have extension add-ons which have their own devicetree
> > overlays. It would be helpful to know which ones should be applied for
> > a particular extension.
> >
> > I propose implementing extensions in FIT. This has a new '/extensions'
> > node, so you can specify what extensions are available for each FIT
> > configuration.
> >
> > For example:
> >
> > / {
> >    images {
> >      kernel {
> >        // common kernel
> >      };
> >
> >      fdt-1 {
> >        // FDT for board1
> >      };
> >
> >      fdto-1 {
> >        // FDT overlay
> >      };
> >
> >      fdto-2 {
> >        // FDT overlay
> >      };
> >
> >      fdto-3 {
> >        // FDT overlay
> >      };
> >    };
> >
> >    configurations {
> >      conf-1 {
> >          compatible =3D ...
> >          fdt =3D "fdt-1";
> >          extensions =3D "ext1", "ext-2";
>
> Shouldn't there be braces around the item list?

I don't think so.

>
> How do you specify optional and required but otherwise unrelated
> extensions for a configuration?

Do we actually need to know which extensions are required or optional?
Do you have an example?

>
> >      };
> >    };
> >
> >    extensions {
> >      ext-1 {
> >          fdto =3D "fdto-1";   // FDT overlay for this 'cape' or 'hat'
> >          kernel =3D "kernel-1";
> >          compatible =3D "vendor,combined-device1";
> >          extensions =3D "ext-3";
> >      };
> >
> >      ext-2 {
> >          fdto =3D "fdto-2";   // fdt overlay for this 'cape'
> >          compatible =3D "vendor,device2";
> >      };
> >
> >      ext-3 {
> >          fdto =3D "fdto-3";
> >          compatible =3D "vendor,device3";
> >      };
> >    };
> > };
> >
> > So FIT configurations have a list of supported extensions. The
> > extensions are hierarchical so that you can have ext-1 which can
> > optionally have ext-2 as well. This allows boards to share a common
>
> ext2 seems not to be related to ext-3. Do you mean ext-3 optionally
> extending ext-1? How would you specify that ext-n is required for ext-m
> to work?

Yes, I mean "optionally extending ext2". Again, I don't consider
required extensions here.

>
> The sequence of applying overlays may make a difference. I cannot see
> that your current suggestion defines a sequence in which the overlays
> are applied.
>
> > SoC to add in overlays as needed by their board. It also allows common
> > 'capes' or 'hats' to be specified only once and used by a group of
> > boards which share the same interface.
> >
> > Within U-Boot, extensions actually present are declared by a sysinfo
> > driver for the board, with new methods:
> >
> > get_compat() - determine the compatible strings for the current platfor=
m
> > get_ext() - get a list of compatible strings for extensions which are
> > actually present
>
> Do you expect U-Boot to have code that injects device-tree fragments
> with a compatible string into the control FDT after discovering add-ons?

Yes, that's right, by applying overlays.

>
> Why can't we simply write the compatible constraint into the overlay
> definition (fdto-#) and enumerate the overlays in the configuration?

Yes, that is the example quoted below.

>
> On some busses detection is problematic. Two alternative add-ons may use
> the same SPI address but need different FDT overlays.

If there is no way to detect the extension, then it cannot work anyway, rig=
ht?

BTW I am not suggesting that the bus is used for detection, although I
suppose this is possible. More likely there are GPIOs which can be
decoded to indicate the extension, or perhaps an I2C EEPROM.


>
> Best regards
>
> Heinrich
>
>
> >
> > The extension compatible-strings are used to select the correct things
> > from the FIT, apply the overlays and produce the final DT.
> >
> > To make this simpler for the common case (without extensions), we can
> > allow multiple FDT images for a configuration, with the first one
> > being the base SoC .dtb and the others being the .dtbo overlay(s) for
> > the board:
> >
> > confi-1 {
> >          compatible =3D ...
> >          fdt =3D "fdt-1", "fdto-1";
> > };
> >
> > Comments welcome.

Regards,
Simon
