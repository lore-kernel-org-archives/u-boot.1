Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2411090225
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 13:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4007883F8A;
	Thu, 19 Mar 2026 14:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d0BEUKMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCA083F93; Thu, 19 Mar 2026 14:39:59 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7353583F2E
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so660973a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773927595; x=1774532395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v2fjeIDQc21aaSTQ6PY5Owx+9ghHyhCz/OT9HNo7BFc=;
 b=d0BEUKMjeXhY15ZcaDhgy8sZy7Skl+c0JdkPHCJATat1TgVymCH6xX6jPmBFSgg4pI
 RBjC03Gfr81JVODzrdU+8FV3EKF3JyJ0qbT5oBBBt4BsvM4u2wAh1iv+YngCUeOUmO/Z
 6dCp9mU61sGnZMeyhXO7vZXwtT+tYRwQAknlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773927595; x=1774532395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2fjeIDQc21aaSTQ6PY5Owx+9ghHyhCz/OT9HNo7BFc=;
 b=MuA8nxDqhQCGS7qO8HEvs5i/5s1skRkAMVMPMtxgNQB+sBmks66U5V9nw+ZaMcJ7PC
 upawo62CHitzhZLlvVqjXQDq7wNMk7grJFAZXGuNU9YtpTi+c/NkhvFKWnz+LwcA97fC
 UaBE/iRq+Tzb2VpdiW6VBNyXAlWrCQ5eUvf9LcY0chpGy3sIabflYk4QWlisJmUMEkWj
 phlP16PvHfGnQf+XYSvVP+9kq6f/Un1HZDWomrfuqSsxiyCcELLHVJ/FR003G2Dkocfh
 a9GuI8vbUbCk+W9A3fiPJjYi7RFx/37bsBxlZ9X5wI6tozTCyWf8lO7wqqxgZ5Cn8rIl
 7F7g==
X-Gm-Message-State: AOJu0Yw48yOgs1ogw612y//3Z7NV6T9pexs44XSrmu82QfcKsWNPTXrz
 0ghyEQ2NW/DQ616AQxNODMnDOo232wNloJl7HZo4F5JUJrDQXPZdGKSpNKI7pG7pmZQ=
X-Gm-Gg: ATEYQzwfOvG8l6sJ4igJ5MjRYNu6zodTEr2c43V86cs+R/hV3DE/CGU6CKQBgLKK1pZ
 xKpq8xdyBC0l/EiQDgJzl/Y6n8eeCLlx4peXuvI2wWPQCmgEAqiwnrSr6HlQd4MVhpmYc/nss8E
 brAnvMm1Fh5Yqal5hAe0/fd4rmbF3HxXSGAUs1QeGJlYVjfIms5loFI0cYX1DG+Vu9DDDmpYTEz
 XttvyISUO51vsqeUpRj/YDchhG0qrYCTY1C5Qb5FBzkVzdCHtdtpESjqpIXSHVq9FjnsP2++mhP
 5Xl38uhr9IckVGPy6+hAzb+1kb58hIy2t8iPy98tTA2fBUBwl+G79f2YQJqEK95jhmlBcUYIfmI
 uZnObmTFs1JVdFBWMM+XC7M1U4L/4HlJW5+uo/A4TD/IWa3SPWpFdVHdrAb50ZTPHB6MS/ybpPE
 b+bSmH83fMnTPUxBtePnrRyB50xpc4eZuEYM8naUohAcy0urAa6/dlA42glwofFrPDX0YKZlyth
 fEWhUCSI9wuQrBO0rbvw3LGtTEgXdzBAXHwTB2XUgBR1omN
X-Received: by 2002:a05:6830:82ea:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7d7ca77e96fmr4219105a34.23.1773927594912; 
 Thu, 19 Mar 2026 06:39:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7e459197esm636737a34.11.2026.03.19.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:39:54 -0700 (PDT)
Date: Thu, 19 Mar 2026 07:39:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
Message-ID: <20260319133952.GO502704@bill-the-cat>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
 <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
 <20260318012649.GG502704@bill-the-cat>
 <bf3bb11e-e891-4703-ad47-04d53e21d7af@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FdVm82+m5AVkkJtR"
Content-Disposition: inline
In-Reply-To: <bf3bb11e-e891-4703-ad47-04d53e21d7af@mailbox.org>
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


--FdVm82+m5AVkkJtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 01:50:56AM +0100, Marek Vasut wrote:
> On 3/18/26 2:26 AM, Tom Rini wrote:
> > On Tue, Mar 17, 2026 at 08:42:06PM +0100, Marek Vasut wrote:
> > > On 3/17/26 2:41 PM, Tom Rini wrote:
> > > > On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
> > > > > On 3/17/26 2:24 AM, Tom Rini wrote:
> > > > > > As exposed by "make randconfig", we have an issue around
> > > > > > USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> > > > > > SPL_USB_CDNS3_GADGET for example) and so have an unmet dependen=
cy. As
> > > > > > this is a hidden symbol, move it up within the menu.
> > > > > What is the issue this is fixing ?
> > > >=20
> > > > Valid configs causing the kconfig part of the build system to note
> > > > unmet dependencies.
> > > Lemme rephrase, is this actually a fix, or is this some readability/o=
rdering
> > > improvement patch ?
> >=20
> > Yes, it's a fix because randconfig finds problems that users may stumble
> > on to while trying to make a valid config for a platform.
>=20
> Is the commit message telling me, that "config USB_GADGET_DUALSPEED" is
> moved outside of the "if USB_GADGET" block ?
>=20
> Because if this is something else, and the symbols are simply reordered,
> that I do not understand how this could be fixing anything.

I'm unclear what else you need to know to take this bugfix. The symbol
is not placed correctly, leading to possibly unmet dependency errors.
Yes, the error is discovered by randconfig which makes it harder to
describe how exactly to reproduce it (but I believe it does), but that
doesn't make it any less valid.

We'll probably never hit the level of support the kernel has, which is
all randconfigs compile and link (and usually even run), but we should
at least be able to clear out most/all of the Kconfig issues that can be
caught at parse time in a month or two, and maybe even this year have
most CONFIG_SANDBOX=3Dy results build (excluding drivers not fully
configured by Kconfig). And this matters for real users because it means
that downstream developers can probably configure a build rather than
get stuck with odd errors.


--=20
Tom

--FdVm82+m5AVkkJtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabv8pAAKCRAr4qD1Cr/k
Cu7EAP9MG45wMpVDRmmkQ+nQDzLlMMFQYHBrRo2c0AqTotnXQAD/Zays3r2vI4G8
Kd48DkWnOXv/2XmURS207qLi9DS8mgU=
=dzlG
-----END PGP SIGNATURE-----

--FdVm82+m5AVkkJtR--
