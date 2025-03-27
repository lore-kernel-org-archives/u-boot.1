Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D45C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E62A81273;
	Thu, 27 Mar 2025 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FJfpKH4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F52681879; Thu, 27 Mar 2025 15:17:51 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADDAF806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c2b7111bb1so500193fac.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743085067; x=1743689867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DaAQliI8gnBzMAAkCV1bBS5xeTZPD/pSYA9F61S8iF8=;
 b=FJfpKH4Az1kFrj+gv3kFUsTZgXCtAB8qB7pKBf5eBGXxPGRx48VNteNx4Bw346AdN8
 Mb+V8ZHsUD6nRM+mXjSHawi10WR9b9EvJ62zqLGvTXPzUWzS2I4kFffNaHXFMWPhE2fJ
 CEPSsmIHqjjlE8VS5HroOGohn7CYQfFyOSTn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085067; x=1743689867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaAQliI8gnBzMAAkCV1bBS5xeTZPD/pSYA9F61S8iF8=;
 b=wLCjHflMDwftRbEft8M5HzoShDqtaR/bTwPv1xhhGMGx3xc1qlSrbu5ASd/Ma1xZ5J
 iWNciqntGisRH9Lw1kYBODCpxjKFlp7pOI+vX7EmupzRXWxAdQ0FxunOFCdhjmRPuA/I
 U0n6a/vk6SFe18IJNyAJ/OU/odJWDZLuaYMnE+o0YLpf1Vqzp3md9zEExiKdrE1x1w8R
 ej4ElPJ8gYBJfja9grKx1W96E67ijvdgUALW7Zy7iCkJYwMxtbXbuMsvSWHq0KU/T3BY
 dgoZJU28EZSi5YphJmnSm+/Jp3s3M+Ryo53e6zSSHNTsX78X5sU+ru3dwKDnNZx5+IWs
 RUoA==
X-Gm-Message-State: AOJu0Ywy99kBnCiYi9qpjMMI3KufAyHGcZTtioQnn49pHPpO5xm+9h/v
 Up3p5q3HRSila/n13JS4lyo6ohrzCg2Mp5nFU2F7RjhciUzhAABpYrRjqeb3Wms=
X-Gm-Gg: ASbGnctQ8cF8opPXIxS3GFEhkFj6oh6i+dIuau6VbEdJ/C+985eAeG4gv2NAj8yauoQ
 tJQr5k5j0JJMDhtkEAuw4V4hUGNh0UoUqOLPHxvURjzg6ckbJHOaVoKEJXIB0JNaUoBJKZX4xMn
 gUprVwp3hc3NqXWV2TVvPR0Td8MCoFYyneDxXzM390cmGCkr2pNCfq7J0JjZ9rGOmy1wy8vNx6X
 bjnUqJsD8H0EvNnGC8tC3fWtnLlB0LuxsYvJ84bLqd40INU+JbSJm1n5Qi1xI5vq3O9mqyBpkNH
 3peeDV1EGC83GucZdRtxZqzmSaiorF68K71c5mvPQUGBf8/Le+XBJV1dDTMqw3A0m7Ql963Amo6
 ZB9leBg==
X-Google-Smtp-Source: AGHT+IHIOAApC03GVRZaCQPEXJ6URetVC64jxw6OVsPK8OosJjXDE0KFl3AEb6xDs6271xnPU10SPA==
X-Received: by 2002:a05:6870:459a:b0:2c8:3620:f595 with SMTP id
 586e51a60fabf-2c847ef922fmr2439879fac.6.1743085067046; 
 Thu, 27 Mar 2025 07:17:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c7fc2821c2sm1626303fac.20.2025.03.27.07.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:17:45 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:17:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/52] expo: Various features and improvements
Message-ID: <20250327141742.GP93000@bill-the-cat>
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
 <20250320142121.GQ2640854@bill-the-cat>
 <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
 <20250325162420.GI93000@bill-the-cat>
 <CAFLszTj49W-Vk_4xpmvtyFH6AH1QAZTLRM7x1k-Bhz7a3uEuBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bCwGPP+C/gUPfjMu"
Content-Disposition: inline
In-Reply-To: <CAFLszTj49W-Vk_4xpmvtyFH6AH1QAZTLRM7x1k-Bhz7a3uEuBQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--bCwGPP+C/gUPfjMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 07:36:02AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Mar 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 21, 2025 at 07:38:45PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 20 Mar 2025 at 15:21, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
> > > > > >
> > > > > > > This series collects together some new features for expo to m=
ake it more
> > > > > > > useful for boot menus:
> > > > > > >
> > > > > > > - measurement and display of multi-line text objects
> > > > > > > - internal alignment for objects (e.g. centred text)
> > > > > > > - editable strings in text fields
> > > > > > > - new 'box' object to draw a rectangle
> > > > > > > - highlighting of menu items, rather than just relying on a p=
ointer
> > > > > > >
> > > > > > > Expo's boot menu is restructured so that it is possible to it=
erate
> > > > > > > through various bootdevs and update the menu as new ones are =
found. This
> > > > > > > is more in keeping with how bootstd works.
> > > > > > >
> > > > > > > A new textedit object is added, intended to provide a simple =
text
> > > > > > > editor. Future work will complete this.
> > > > > > >
> > > > > > > With this series the boot menu has a better layout and appear=
ance.
> > > > > > >
> > > > > > >
> > > > > > > Simon Glass (52):
> > > > > >
> > > > > > I see you haven't internalized the "don't post massive series" =
feedback
> > > > > > yet. Please, stop posting massive patch series. Figure out how =
to
> > > > > > logically break things down in to smaller chunks that can be
> > > > > > meaningfully reviewed.
> > > > >
> > > > > I could split this into two series of ~25 patches, perhaps. Would=
 that be OK?
> > > > >
> > > > > I believe no one else is using expo yet, apart from postmarketOS,
> > > > > except the trivial case of 'bootflow scan -m' but I'm hoping that=
 will
> > > > > change in the future. I believe that Linaro is mostly encouraging=
 EFI
> > > > > bootmgr and the text-based menu. That could be converted to use e=
xpo
> > > > > but I doubt anyone has looked into that, particularly as grub is =
being
> > > > > pushed as well. I did look at converting the existing menu code a=
 year
> > > > > or two ago, but it seemed better to eventually deprecate it.
> > > > >
> > > > > Also, there is a following series which I split out and will post
> > > > > separately, but not for a while as I have a lot outstanding.
> > > > >
> > > >
> > > > It would make sense to split expo out to its own series as there's =
not
> > > > likely to be any feedback there. All of the other parts of the seri=
es
> > > > already have something else in their subject and that would be logi=
cal
> > > > places to split this up more and then assign to the appropriate
> > > > custodian. Thanks.
> > >
> > > This is the expo series and it only has expo patches, so I believe we
> > > are OK there.
> > >
> > > The bootstd series is small and its own thing.
> >
> > OK.
> >
> > > I can split up the strim() / test series,
> >
> > OK.
> >
> > > but I'm still unsure what
> > > you are asking for with respect to code which is not yet used. I can't
> > > reasonably do all of a) send code only when it is needed by later
> > > patches in the series and b) keep series sizes small and c) keep
> > > series related to a single topic.
> >
> > I don't see why you can't do that. It is in fact really hard to review
> > how useful some library functions you write without seeing how they're
> > used and if in turn we should be doing something different. You might
> > need to defer or break out as it's own some refactoring changes in order
> > to meet 'b' above. However "here is a thing" and "here's using a thing"
> > are still a single topic.
>=20
> You could just review the code itself, perhaps, rather than worrying
> whether it will never be used? For me, creating and maintaining a
> series through acceptance into your tree is still a lot of effort,
> unfortunately.

No, that's a no-go. Reviewing a library without knowing how it's going
to be used is not effective.

> While on that topic, it seems that the sunxi and rpi series have still
> not been applied to your tree. It would really help to see some
> movement on those after all these months.

I provided a detailed explanation of what's still wrong with the sunxi
series. The Pi maintainers are still actively working their way through
things.

--=20
Tom

--bCwGPP+C/gUPfjMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmflXgYACgkQFHw5/5Y0
tyyBhAv9HqTTKiPwtxIkLsOFvMM08PAdOfv3e+Qbiate4NxqXRJ5iX4iTviEENOg
BRsjmfwQqwr1LQLkS2IyRGDSNxGMlcoooZfqbCb5P4VR2vAW/lCPfeYjze73MxHm
3OyXb75GWai+TG66IcA/as+2ZLPHWX2qaDPc2CmIOLXeCdSnrpXrpU/lFbDKkZfs
GtZ7MS2YBrMMV5ntLwwXqbbPklyjk1t+3ru22yf1AJkAtv9ftktPNtFB77Uwa7/1
d0W0A6T6u63G+FeRcIqYvbAre9nnN2lTeF79DNMjWkFLMHXyJAYgS2v+nZV70XYa
+sBjTA4MRD4aYD09epY40RjLCFuS0jVNB+vnC/yuEb6XD7lXCYLNslDz07EPkpvO
6qDJvJF3pLO/V5HKivs0yIZfP//wJ2lT2BWkP7hapPpw7fSwKKzNu34sFdh6GBs4
dSVV9tv1AvniTZWNByUb2grbzBoA+3QR6Q/N7L7pGSWfiT/4sx1EjJvd00hSQev5
TU8X2jOT
=sodK
-----END PGP SIGNATURE-----

--bCwGPP+C/gUPfjMu--
