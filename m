Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0971DC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 07:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4CB87949;
	Tue, 23 Jan 2024 08:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g0RVKaXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40FC5879B2; Tue, 23 Jan 2024 08:03:13 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9A88790F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 08:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wenst@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50eaaf2c7deso4346028e87.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1705993390; x=1706598190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddhENJzpuSm+e5t9XVYpOKZ1/5Beo/JWYDYIzCEe7Ig=;
 b=g0RVKaXzJcPqShXV+c/gcBZu6TJTmchyTxjk4q5BzHq34UvkDG8gPxMsg+Vwmsx+S1
 1smiYaRT9GiYsrckU2+1DCyf+5aIJVHqc+L7/rSITbeR7WEQP0HuuRXCE4aHkgLcMOxy
 lDgUSr+tF66X9blPlk64/f667Vl10zKexjpKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705993390; x=1706598190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddhENJzpuSm+e5t9XVYpOKZ1/5Beo/JWYDYIzCEe7Ig=;
 b=gpcIyvkHrs8lLpsWPdLn5SvKHdaTvDOF0gbzVn7VhDP21KwHc8L5aeZQRakC50qzAC
 I3HhnuO7yiMaOvUre1Q17HFBlZhNFwRaeONopd1vAXWM5Yr2WA9BAtqt9RnaP9LDfSzV
 1yIMZtaLiA1tu2Raz4lwbtfNP6ri+6+ctsIz+xGIdAoLWjDHSFC41DgJcwuxpXtHbVn0
 Hh+27XWuwj6HEa7LabQSNhlBleHSMnR3wkn78n57pyNk9EepFwtxe3IYpLHnWdpVuryn
 zGDYZsCJ8TlWNMjHwQZ11WcArID26GD++zPKVKrZ4fDY9btP1aKJAbW96XHFkx/lewY/
 PBJw==
X-Gm-Message-State: AOJu0Ywjzk6htCvF67TZSt0NYk3KINESXu16Dv8MNEBNmBHYjOGLMqzH
 YUjcaHf4yy8AmFzeR0YvIMLuh2PjUZIt6qzBk6DtF86vYSKln6XBiYS3l9Oo7bRBu/wII/NwcOV
 db1dKiy+xL/D541Yr0lyes1Z89+/6WSUl0V5D
X-Google-Smtp-Source: AGHT+IFtGwYHc3ZR4b3U3A144egCTuGtSUKInhJ5MWjDVj40tMbAk0NMprfhEKYTVNlg/K+tas3Q4Qt3JygRZGRHNkQ=
X-Received: by 2002:a05:6512:3092:b0:50e:e1d4:44fe with SMTP id
 z18-20020a056512309200b0050ee1d444femr2291559lfd.1.1705993389588; Mon, 22 Jan
 2024 23:03:09 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
 <51c47679-32d8-45a7-9d9a-4c534ed98c32@gmx.de>
 <CAFLszThR79UyrqDai3U2Kb6mAvGOPAg_pTcSBoPvG8c4c7S+iA@mail.gmail.com>
In-Reply-To: <CAFLszThR79UyrqDai3U2Kb6mAvGOPAg_pTcSBoPvG8c4c7S+iA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 23 Jan 2024 15:02:58 +0800
Message-ID: <CAGXv+5Eh3jDO-HemjD-WP770eGsDyOoijbB7JY05B3JooZB0xA@mail.gmail.com>
Subject: Re: Proposal: FIT support for extension boards / overlays
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>, Andrew Davis <afd@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Dec 28, 2023 at 1:49=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Heinrich,
>
> On Tue, Dec 12, 2023 at 3:43=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 12.12.23 15:05, Simon Glass wrote:
> > > Hi,
> > >
> > > The devicetree files for a board can be quite large, perhaps around
> > > 60KB. To boot on any supported board, many of them need to be
> > > provided, typically hundreds.
> > >
> > > All boards for a particular SoC share common parts.  It would be
> > > helpful to use overlays for common pieces, to reduce the overall size=
.
> > >
> > > Some boards have extension add-ons which have their own devicetree
> > > overlays. It would be helpful to know which ones should be applied fo=
r
> > > a particular extension.
> > >
> > > I propose implementing extensions in FIT. This has a new '/extensions=
'
> > > node, so you can specify what extensions are available for each FIT
> > > configuration.
> > >
> > > For example:
> > >
> > > / {
> > >    images {
> > >      kernel {
> > >        // common kernel
> > >      };
> > >
> > >      fdt-1 {
> > >        // FDT for board1
> > >      };
> > >
> > >      fdto-1 {
> > >        // FDT overlay
> > >      };
> > >
> > >      fdto-2 {
> > >        // FDT overlay
> > >      };
> > >
> > >      fdto-3 {
> > >        // FDT overlay
> > >      };
> > >    };
> > >
> > >    configurations {
> > >      conf-1 {
> > >          compatible =3D ...
> > >          fdt =3D "fdt-1";
> > >          extensions =3D "ext1", "ext-2";
> >
> > Shouldn't there be braces around the item list?
>
> I don't think so.
>
> >
> > How do you specify optional and required but otherwise unrelated
> > extensions for a configuration?
>
> Do we actually need to know which extensions are required or optional?
> Do you have an example?

If an extension is required for a device, then it wouldn't be an extension
per se. The referenced DT overlay should be directly tied to the device
compatible through the configuration node.

If say "ext-3" depends on "ext-1" (assuming that is one definition of
"required"), then based on the syntax I believe "ext-3" should only
be listed in the "extensions" property under "ext-1", and not the
base configuration?

> > >      };
> > >    };
> > >
> > >    extensions {
> > >      ext-1 {
> > >          fdto =3D "fdto-1";   // FDT overlay for this 'cape' or 'hat'
> > >          kernel =3D "kernel-1";
> > >          compatible =3D "vendor,combined-device1";
> > >          extensions =3D "ext-3";
> > >      };
> > >
> > >      ext-2 {
> > >          fdto =3D "fdto-2";   // fdt overlay for this 'cape'
> > >          compatible =3D "vendor,device2";
> > >      };
> > >
> > >      ext-3 {
> > >          fdto =3D "fdto-3";
> > >          compatible =3D "vendor,device3";
> > >      };
> > >    };
> > > };
> > >
> > > So FIT configurations have a list of supported extensions. The
> > > extensions are hierarchical so that you can have ext-1 which can
> > > optionally have ext-2 as well. This allows boards to share a common
> >
> > ext2 seems not to be related to ext-3. Do you mean ext-3 optionally
> > extending ext-1? How would you specify that ext-n is required for ext-m
> > to work?
>
> Yes, I mean "optionally extending ext2". Again, I don't consider
> required extensions here.

See above for my take on extension dependencies.

ChenYu

> > The sequence of applying overlays may make a difference. I cannot see
> > that your current suggestion defines a sequence in which the overlays
> > are applied.
> >
> > > SoC to add in overlays as needed by their board. It also allows commo=
n
> > > 'capes' or 'hats' to be specified only once and used by a group of
> > > boards which share the same interface.
> > >
> > > Within U-Boot, extensions actually present are declared by a sysinfo
> > > driver for the board, with new methods:
> > >
> > > get_compat() - determine the compatible strings for the current platf=
orm
> > > get_ext() - get a list of compatible strings for extensions which are
> > > actually present
> >
> > Do you expect U-Boot to have code that injects device-tree fragments
> > with a compatible string into the control FDT after discovering add-ons=
?
>
> Yes, that's right, by applying overlays.
>
> >
> > Why can't we simply write the compatible constraint into the overlay
> > definition (fdto-#) and enumerate the overlays in the configuration?
>
> Yes, that is the example quoted below.
>
> >
> > On some busses detection is problematic. Two alternative add-ons may us=
e
> > the same SPI address but need different FDT overlays.
>
> If there is no way to detect the extension, then it cannot work anyway, r=
ight?
>
> BTW I am not suggesting that the bus is used for detection, although I
> suppose this is possible. More likely there are GPIOs which can be
> decoded to indicate the extension, or perhaps an I2C EEPROM.
>
>
> >
> > Best regards
> >
> > Heinrich
> >
> >
> > >
> > > The extension compatible-strings are used to select the correct thing=
s
> > > from the FIT, apply the overlays and produce the final DT.
> > >
> > > To make this simpler for the common case (without extensions), we can
> > > allow multiple FDT images for a configuration, with the first one
> > > being the base SoC .dtb and the others being the .dtbo overlay(s) for
> > > the board:
> > >
> > > confi-1 {
> > >          compatible =3D ...
> > >          fdt =3D "fdt-1", "fdto-1";
> > > };
> > >
> > > Comments welcome.
>
> Regards,
> Simon
