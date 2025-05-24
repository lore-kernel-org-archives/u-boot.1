Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3506CC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79278310F;
	Sat, 24 May 2025 16:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NUxyv5fW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6083B83264; Sat, 24 May 2025 16:18:12 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32BB82AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2db9e29d3bcso330101fac.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096288; x=1748701088; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6vForQgT/ZF1Hoe+3Xzg/y5EeH+KSwPPqR8rxUObmzc=;
 b=NUxyv5fWZGxLAxVF6oo3qjvAAb2m21tqziX4ID1WiBHeBfUiC1bZmR0p8tH1gSrtx5
 OUg7W7zYrKO8Fn91NyunZHnAeTWynNrudgK40diSopSN5KokgZaIjgpk+cEBz9F65NmI
 t/wCMTif9VyyR0LqglIAzBZe1DgvkxjF3u6UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096288; x=1748701088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vForQgT/ZF1Hoe+3Xzg/y5EeH+KSwPPqR8rxUObmzc=;
 b=r3G5j46ful48RxeKcIRVN899zlC4/EXluh98xfZpHrApDCg5autQzzSLoz88Rv9As2
 yggftSJjCuZrS3lQbwtnC3Zw7tKcNKQzwBtymTiJt/LnKcZVxTU4QJ0VVnr4BH9Ck6Q+
 OlQRZOspTQ1+jO+0qiJ2FuHQeDeqPk/YkXnH0aN/6vNjRheqFp65IgzWNJkNHg1Ls6O/
 Tl+4a0SPQDUo2sOIuAZnn0Ov3PI/GAcbZeyDX9XZYeJPTHsGp6tc35IKg3bKRF+vCQ8L
 FEvLgoYwHqCfXFQ4ZuldD6cfSzFnC028pe7l8h8NKIzJ4IAzZoz5HHas7FywFWvnIQ7c
 wbVQ==
X-Gm-Message-State: AOJu0YwCWeSmZvaqi13zVJgefYNg6JeqbCzjaF+uGmBv7p3pqie+dubD
 +Q55D9XMdpvTNLu4roWQWj/fKeEpj5lIZyzVqlI+5Ooq1lW2o2DwA1hPmFn2BBQ4tcFj9hxdE6o
 QEPRaVrs=
X-Gm-Gg: ASbGnct8RZP+H32+1vXW/NJPm/DxngMt0vNsVxAi5bTD/1YtnRJSUCC/f2PB7m/98i6
 n+EVGF5D+NwqtfeQplDq0pclZ0m9Do3CiPVZrwx3ONv60k82n7XgtNAYrWJK/1vflb0HkvQEMhR
 phWMhiNtcfgwt4I9F56i4lZZawJUcKf0G4RILpBub2Yq8hBrOoL3opO+01xqEe8KhMWxZUWBWOl
 S1zMiC3nZfl1jV6JrEGHz1e7zTWo5T39kgSX2ZmNe+sp7cP3YTb2pVJR8eYFh+mGPXXJSD3bEGL
 jZul+Vq8infkQDeV4I6Vbuo4Wig3bvK8vkfTNJaRpIvROTnTiuS+nmpb6uBbtVURqPNFjeP4Mx9
 NCBSn84Xuom2uOnGi8lKTyMs=
X-Google-Smtp-Source: AGHT+IGNebnMQ35nIZ3BcgdzeKAPguutirbgc2ZOs+gQsra5ESoTYfDrlrPefA251sSbYLFcnJCaIw==
X-Received: by 2002:a05:6808:11d1:b0:400:b701:33cf with SMTP id
 5614622812f47-406467ef69emr1376554b6e.15.1748096288333; 
 Sat, 24 May 2025 07:18:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f3e3f5sm3647063eaf.9.2025.05.24.07.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:18:07 -0700 (PDT)
Date: Sat, 24 May 2025 08:18:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250524141805.GB100073@bill-the-cat>
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ky4CXYIWyM7PkKWm"
Content-Disposition: inline
In-Reply-To: <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
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


--ky4CXYIWyM7PkKWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > > > > It is easier for tests if the top-level control logic is all =
in one
> > > > > > > module. Create a new do_patman() function to handle this. Mov=
e the
> > > > > > > existing code into it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  tools/patman/__main__.py | 49 ++----------------------------=
------
> > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++=
++++++++--
> > > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > > >
> > > > > > > Applied to sjg/master, thanks!
> > > > > >
> > > > > > Odd. I thought you had posted this against master or next, inte=
nding it
> > > > > > for mainline, which is why I assigned it to you in patchwork. I=
 see the
> > > > > > cover letter is missing what commit it's against. And instead h=
ere you
> > > > > > are once again spamming the list and with messages about your p=
ersonal
> > > > > > tree. Why?
> > > > >
> > > > > I'm applying it to my tree and intend to send you a PR at some po=
int,
> > > > > with collected tools/ patches. So I believe I need to send emails
> > > > > about applying things and update it in patchwork. Let's discuss t=
his
> > > > > in a future call.
> > > >
> > > > I don't see what there is to discuss. Please follow the normal proc=
ess
> > > > for mainline and stop spamming the list with notices for your perso=
nal
> > > > tree. You're also diverging your own tree further from mainline by =
doing
> > > > this and making it less likely (multiple people have told you they =
don't
> > > > want to review things not against mainline) any follow-up work will=
 get
> > > > comments other than that it's not applicable to mainline.
> > >
> > > For patman, I have another series [1] I'm planning to apply to my tre=
e tomorrow
> > >
> > > Would you like me to send 'applied' emails for it to the mailing list?
> > > Or perhaps just for the cover letter? Would you like me to send you a
> > > pull request?
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D456256
> >
> > Yes, that's another series that while I disagree with the direction
> > you're taking things, would rather apply to mainline than let it bitrot
> > in mainline. So please send a PR against next. And that would also apply
> > to the series this email is in reply to. As again, I had expected it for
> > mainline and not your downstream tree even if I think we (and our users)
> > would all benefit from managing the python portions differently.
>=20
> OK, once I have applied the remaining two series I will send a PR.

Based on the emails in my inbox this morning, you're doing the opposite
of what I asked for. But maybe this afternoon will bring something
different.

> You didn't express a preference for the 'applied' emails. It seems
> better to send these emails so that there is a record of the patch
> being applied.

I guess I wasn't clear enough. Stop spamming the list with *anything*
about your personal tree. And if you're going to send anything about
something that's intended for mainline, you should make patman act more
like b4 and NOT send a message to every patch. I know I used to, but the
workflow b4 enables is much better for everyone.

--=20
Tom

--ky4CXYIWyM7PkKWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1RkACgkQFHw5/5Y0
tywkiwv/VLHSZA3slG2KbYu1odWB923H+gJ10yo4ZxEW5XrBwK4zp4pmJFZnN3yH
hlfKGxkGYOWsEWVeradY37QYXztl31lR9wylCK2W7o6K0DmZjoTvCXpf6uqjbvDO
RTkxPT8SPQ1LfahsutbI5otzNw6nxOvvbmn6MnT2yk14ec9MBBj5e6URFlshJOVy
uNXpIQAWHcpNfeGs6pgaY95zsoghU8qQy3mrkukcgMBXUvCvo6Uhp52zYd9qCjCx
0lvar3A6M2naN12wH/V8kbuoIzsVZo/ZrEKOZ0De+K3wCAD4iFAnpVwvsNg6gAaH
/D7lVQiboZOlhfhC4lB1wvd0v5NpevPDBYM7C6ND0OUlJmhd3XWlC3ky0+bPRFze
s/vOxq7BaiQ2iCVR4JHz+l9yD3/g7OoicYe3V6GEYmIm9NW7sN1zRAqIu/ZPxOGV
lThe6/O52T+gwG3myIlF+PKFR7jgW7Jn3CNHUpHBOu67u9RhelsBZZvPon+Jr5DQ
tT56nG+8
=vVIy
-----END PGP SIGNATURE-----

--ky4CXYIWyM7PkKWm--
