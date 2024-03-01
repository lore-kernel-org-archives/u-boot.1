Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63094C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6CC88166;
	Fri,  1 Mar 2024 19:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4rXhKJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07BD87903; Fri,  1 Mar 2024 19:54:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A3D88166
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6089b64f4eeso21474507b3.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319251; x=1709924051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CWNyQRsuAHonLv9ysvP0YXzNT3tbUhE8QRu9jtbKdTs=;
 b=Q4rXhKJu71meRZtML8OSoRzAuo8LpuGAWNtyGNPBFKp/UPd1u+JLC4NQ8KwqiZcA0U
 Rx49i1QaPQOWgGOa9uwxzMg7CW/VvD4EX29xdwIgZYxTKDzyzkgENB71l2kO+ZEsKSgW
 Y4hHj0UxFUb9bocQ+jz7R5s7DsQB2WJPM0xNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319251; x=1709924051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWNyQRsuAHonLv9ysvP0YXzNT3tbUhE8QRu9jtbKdTs=;
 b=ZBKY2YLA8IS33r0mhDyQtIsIPDaDPG3lLubausH4bJNa3wm1qWZSrlvHuqQ6YLKNoJ
 QM9k1JQK49RnJjAmzPBfhGPw5qB2S4r1DHtynunm0dvNcLOQOYProxz9BiUyNiymW8GS
 AhCXkAJQArZAX9G2E53fOkNuicyZBdQP/fSb4z134jsmZetoY5edwWKgZVCKCFuVhBEI
 UQGptUacMzSf21CZTp4r32ZHnJGR+59WzJVsz8wEyQHRYWjFcER7udW4wBZ4uIcb6bgf
 658/8xmR4B3vNujtrHSUgf/KNwBNL0bedUJZqpnJlNOwCa/dZela4cGP/xbIblSc3tQc
 Rz8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcI63hACzKoIIBC0Ou+GN2lWjGlRD6OiVH84wDsH9RTnI7GD9rx6Pk+M8gYp2A5JFThndNRUkKz6bWkODSVQLGK/V9kQ==
X-Gm-Message-State: AOJu0YwNNqArJMcWy1dw2HzKMONzEmF39vlyWNE8PuqI4pMcOaLIaGCg
 SJYPGNzvSZq+ZwZaQ8n+WvbA9Aw20dNhojRdOOF6KbYohq3TXf2ix1R9yLC5KS8=
X-Google-Smtp-Source: AGHT+IF9VVmDMk1iWq+DHthbU0UJuJ4jQbbr94WdbgrH7y1Q51/CPa5U6z9Tx7p36ahkLU6RuSneiw==
X-Received: by 2002:a25:3dc7:0:b0:dcd:2f2d:7a05 with SMTP id
 k190-20020a253dc7000000b00dcd2f2d7a05mr2199744yba.35.1709319251028; 
 Fri, 01 Mar 2024 10:54:11 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 c17-20020a5b0991000000b00db41482d349sm896409ybq.57.2024.03.01.10.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:54:10 -0800 (PST)
Date: Fri, 1 Mar 2024 13:54:08 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, shawnguo@kernel.org,
 Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Rob Herring <robh@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240301185408.GE3040305@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
 <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
 <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Axn46gSUagJETGzk"
Content-Disposition: inline
In-Reply-To: <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
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


--Axn46gSUagJETGzk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 10:17:35AM +0100, S=E9bastien Szymanski wrote:
> On 3/1/24 07:02, Sumit Garg wrote:
> > On Thu, 29 Feb 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Thu, Feb 29, 2024 at 08:42:42AM -0500, Tom Rini wrote:
> > > > On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
> > > > > On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
> > > > > >=20
> > > > > > On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > > > > > > + Shawn, Krzysztof, Conor
> > > > > > >=20
> > > > > > > Hi Tom,
> > > > > > >=20
> > > > > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >=20
> > > > > > > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wro=
te:
> > > > > > > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szy=
manski wrote:
> > > > > > > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise devic=
e trees with
> > > > > > > > > > linux") removed the display timings from the board devi=
ce tree whereas
> > > > > > > > > > they are still needed by the mxsfb driver.
> > > > > > > > > > Add the timings back (the correct ones) in the
> > > > > > > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from=
 the
> > > > > > > > > > opos6uldev.env file.
> > > > > > > > > >=20
> > > > > > > > > > Update the opos6uldev_defconfig file so that the LCD tu=
rns on at boot.
> > > > > > > > > >=20
> > > > > > > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise devic=
e trees with linux")
> > > > > > > > > > Signed-off-by: S=E9bastien Szymanski <sebastien.szymans=
ki@armadeus.com>
> > > > > > > > >=20
> > > > > > > > > Huh.  This is the commit that did that upstream.
> > > > > > > > >=20
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > > > > > > >=20
> > > > > > > > > It's interesting how the timings in linux were always sli=
ghtly different
> > > > > > > > > from in u-boot.
> > > > > > > >=20
> > > > > > > > Thanks for tracking that down, Dan. I'm adding in Sumit and=
 Rob here
> > > > > > > > because this is a recent (rather than ancient) example of o=
ne of the
> > > > > > > > concerns about OF_UPSTREAM.
> > > > > > >=20
> > > > > > > I rather think about this as an opportunity to improve with
> > > > > > > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > > > > > > corresponding Linux kernel sub-arch maintainers. Especially o=
nce we
> > > > > > > move to OF_UPSTREAM and a sub-arch maintainer profile in Linu=
x kernel
> > > > > > > to keep them aware that U-Boot should be considered too.
> > > > > >=20
> > > > > > Yes, a more extensive check around when removing information fr=
om dts
> > > > > > files would be good.
> > > > > >=20
> > > > > > > > I think the commit in question can be
> > > > > > > > summarized as "remove a bunch of explicit HW information be=
cause there's
> > > > > > > > now a Linux Kernel driver that determines that dynamically"=
=2E What do we
> > > > > > > > do next? The old information is in a presumably valid bindi=
ng still, can
> > > > > > > > we just put it back and comment that consumers outside of L=
inux use this
> > > > > > > > still so it's not removed again later? Or am I just missing=
 where we can
> > > > > > > > instead get this information from the DT still and not need=
 to come up
> > > > > > > > with a new driver and subsystems?
> > > > > > >=20
> > > > > > > I can see following two paths forward:
> > > > > > >=20
> > > > > > > 1) Partially revert the Linux kernel commit to add back the d=
isplay
> > > > > > > timings in DT.
> > > > > > > 2) Extend drivers/video/simple_panel.c in U-Boot to add suppo=
rt for
> > > > > > > compatible: "armadeus,st0700-adapt".
> > > > > > >=20
> > > > > > > If possible then I would be in favour of (2) rather than the =
current
> > > > > > > patch to do this properly.
> > > > > >=20
> > > > > > Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.=
c driver
> > > > > > and then our drivers/video/simple_panel.c it sure would be nice=
 if it's
> > > > > > just a matter of adding a compatible but I wouldn't be surprise=
d if it
> > > > > > ends up needing more information being passed along too?
> > > > >=20
> > > > > Although I am not a LCD panel expert but looking at the kernel dr=
iver
> > > > > code [1], the display timings are rather taken from a static data
> > > > > structure matching the compatible "armadeus,st0700-adapt".
> > > > >=20
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/drivers/gpu/drm/panel/panel-simple.c#n901
> > > >=20
> > > > Yes. My point is that it seems like the situation changed from "dev=
ice
> > > > tree provides timings for the platform" to "driver has timing
> > > > information for N displays" and so we'll need to do something cleve=
r to
> > > > avoid including the structs for 5 panels when we'll only ever
> > > > (likely...) see one. And that also yes, we'll probably need to add =
data
> > > > for this panel rather than re-use the PANASONIC_VVX10F004B00 data.
> > > >=20
> > > > > > And I'm going
> > > > > > assume there's good reasons for the design change in how the dr=
ivers
> > > > > > work in Linux now and note that it might make things more chall=
enging
> > > > > > for us when we do care about space.
> > > > >=20
> > > > > I agree it is always going to be challenging to use DT during SPL
> > > > > stage which is mostly constrained by limited on-chip RAM.
> > > >=20
> > > > Well, no. The DT way handled this more efficiently, I think I wasn't
> > > > clear enough in my reply.
> > >=20
> > > And it's not just SPL, full U-Boot needs to stay small and within fla=
sh
> > > partition considerations and I become cranky and question people when
> > > non-generic changes impact platforms that don't need the change.
> > >=20
> >=20
> > Okay I can see your point. I suppose this leads us to option (1) to
> > partially revert the Linux kernel commit [1] to add back the display
> > timings in DT. Ironically all the folks (developer, U-Boot and Linux
> > kernel iMX maintainers) were involved in the upstream process for the
> > Linux kernel commit [1] under question. So I will let them chime in
> > too.
>=20
> It is also now possible to have the display timings under the panel node:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/gpu/drm/panel/panel-simple.c?h=3Dv6.8-rc6&id=3D4a1d0dbc8332231d1d5=
00d7a1d13c45457262a97
>=20
> Not sure if that could help here.

So yes, this in conjunction with
https://lore.kernel.org/linux-arm-kernel/20200115123401.2264293-4-oleksandr=
=2Esuvorov@toradex.com/
type changes is what I would like to only support in U-Boot going
forward (and our drivers/video/simple_panel.c will need an update). This
should help make sure we don't have the problem of "new panel, more size
growth for every platform".

--=20
Tom

--Axn46gSUagJETGzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiJFAACgkQFHw5/5Y0
tyyE8gwAipqn0DTL8n2F9TjbyHVl6G3aFpgom/g5vk6RESilU0nGx+VbNlUg8tPh
WhyIJY93e6psDS0UcEcYPgUw1jFvM0ygWsUmQS1ewBi16gm+ZHZ19/+dv00cPQFy
kqoLaIrqY802Ox151xx0t5fESeIB/AJklyvVr8uTDqJUKGJWwznmaboTxSJG1PEu
JrK0krQkWXuZFEkDz5wfY9kVJc616pCpCL8+/Jq2owpkuda1FBxA7GC7YE1mO9NL
jOXfWf0vXGz7ozi0xi1a969uEF49sJ3h2LrMrtVu1hrpmGLyzfm18QTxf5hw+eZc
Ju7tNZ3ejsnEbujFnA1iQfp9vQITZr/j92Wa5hvORYRGdSMk8PwiimnlycYJ1Wr0
9HKTZa2nFt9XaOMMq4VKi/iqXCpVt0Gn6BllAfbqX6U9BUo8YgvPgOz69Kryqjnr
19Qkw7qZXV2+RBlI+ja0EE10ihBjyFBYPhix93pVDM8uX1EXIh06jKME3Y3AaTbv
UuZlsuGV
=QyAl
-----END PGP SIGNATURE-----

--Axn46gSUagJETGzk--
