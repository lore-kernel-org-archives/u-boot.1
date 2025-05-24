Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80090C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12ED0831FE;
	Sat, 24 May 2025 16:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BxRAoMPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7413D8294C; Sat, 24 May 2025 16:31:31 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF4128294C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2dfb991cb45so416073fac.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748097087; x=1748701887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RIrm0/NiDCqShNTTqsOxPUviMCXmET/+i8o1CZlizCk=;
 b=BxRAoMPe8Bm0OG8JDzy9s8fbcsh7ctKRvPZ9OII1m7qUuDqs8YLbUCgFHKJnApyu2a
 6HwwiwgmO6Lv8QvfxdnD4ksHeey/uvCJWtgHaGm6eXeK6F5AEtrv8HmazXaBu0pkwMod
 IRidOCckVoRyQh1skOUACXGOe4y63OeCW4zZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097087; x=1748701887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIrm0/NiDCqShNTTqsOxPUviMCXmET/+i8o1CZlizCk=;
 b=ZcXr4NLXSJxlhk1grfUoVWCWjItN9NiycfSRHMAwa63Pt0gnvPZssi0qJrqt9duUVz
 FMDVt5FHbW5bw1Qf0s9mj3l+lkic22AoY4rj5aFJKCW7GCChGoHOgK1QN86o/PHbYnpY
 VhWVgW2NSeDddYbHlMRgEkfyLT0cvLkjscl+3FD5CWDnRg3fnRB5IrstoP7KnWpWNT+8
 kc9BVFJ7Psza39bcksshWmGBwDiwhJxFGrZllIH9fTAA16yRIqHZqVLxpCWiHB085NDI
 ChcXlgHDO/b4nPHkCaDwBva+kL6V37rYWxHBsw1naMk30Wks+FbrLQYbycmLusRVDXfk
 d9AA==
X-Gm-Message-State: AOJu0YwyCc2KznB5Vt286kcWRT3rY1g6j1vG/yZFVGPHDQsLB53jY59y
 k72cp47Ki3vZamdSX0Oex4MyWY2rcb0Qz1wUihIadSDzYnq2dAea71atXxmxUL4SXXGmdwAh1Gg
 JFy4NLHo=
X-Gm-Gg: ASbGncsu59rKpPYo3oBT1OlTuLpxPml3BU4oklLOyLRK19KgNYC+YEPqhMMT6D6EQNL
 EVQVmg+ZojOR5glLg1ybICdI273uuMwdISrMYMd+iYQI/dF9989wZJI1F4qHuytB5e4fU/ZeqEw
 5XRSjsZ2CmZR5nzM5tT0hPHMaUBROLWw8R2RS7CQRXrWx8s35XmWoV4QOU1DbwfexOGU36tOQ3a
 5YGFtXCC2eGnN9BRKouKmHyc+hlV1R/BNdEl5EayGeWFt9tflTIhOw7f9KkWdpu4JiKEUsv51Md
 OuE/a+9sYZ1w+31dNbJWGtFJcWCwoa7BlgpEUoQ7K1WmFrAoRRXFIdeH/gaNRv4gCqPluIC+dIT
 WHEMK3CWIeuvN
X-Google-Smtp-Source: AGHT+IE83uBnO5EWQ5x02t1Sgh/5APtWsStYojzeytNQbe+ZabdoQnvXyiTjP0zRzgvALOzBR8hFbw==
X-Received: by 2002:a05:6871:42c8:b0:2c8:361a:da77 with SMTP id
 586e51a60fabf-2e8621c59dfmr1669775fac.26.1748097087467; 
 Sat, 24 May 2025 07:31:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06baca3sm4068275fac.19.2025.05.24.07.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:31:26 -0700 (PDT)
Date: Sat, 24 May 2025 08:31:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250524143124.GI100073@bill-the-cat>
References: <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
 <20250524141805.GB100073@bill-the-cat>
 <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qtv7qN2bBCeb1OVl"
Content-Disposition: inline
In-Reply-To: <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
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


--qtv7qN2bBCeb1OVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 03:22:57PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > > > > > > It is easier for tests if the top-level control logic is =
all in one
> > > > > > > > > module. Create a new do_patman() function to handle this.=
 Move the
> > > > > > > > > existing code into it.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  tools/patman/__main__.py | 49 ++------------------------=
----------
> > > > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++=
++++++++++++--
> > > > > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > > > > >
> > > > > > > > > Applied to sjg/master, thanks!
> > > > > > > >
> > > > > > > > Odd. I thought you had posted this against master or next, =
intending it
> > > > > > > > for mainline, which is why I assigned it to you in patchwor=
k. I see the
> > > > > > > > cover letter is missing what commit it's against. And inste=
ad here you
> > > > > > > > are once again spamming the list and with messages about yo=
ur personal
> > > > > > > > tree. Why?
> > > > > > >
> > > > > > > I'm applying it to my tree and intend to send you a PR at som=
e point,
> > > > > > > with collected tools/ patches. So I believe I need to send em=
ails
> > > > > > > about applying things and update it in patchwork. Let's discu=
ss this
> > > > > > > in a future call.
> > > > > >
> > > > > > I don't see what there is to discuss. Please follow the normal =
process
> > > > > > for mainline and stop spamming the list with notices for your p=
ersonal
> > > > > > tree. You're also diverging your own tree further from mainline=
 by doing
> > > > > > this and making it less likely (multiple people have told you t=
hey don't
> > > > > > want to review things not against mainline) any follow-up work =
will get
> > > > > > comments other than that it's not applicable to mainline.
> > > > >
> > > > > For patman, I have another series [1] I'm planning to apply to my=
 tree tomorrow
> > > > >
> > > > > Would you like me to send 'applied' emails for it to the mailing =
list?
> > > > > Or perhaps just for the cover letter? Would you like me to send y=
ou a
> > > > > pull request?
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D456=
256
> > > >
> > > > Yes, that's another series that while I disagree with the direction
> > > > you're taking things, would rather apply to mainline than let it bi=
trot
> > > > in mainline. So please send a PR against next. And that would also =
apply
> > > > to the series this email is in reply to. As again, I had expected i=
t for
> > > > mainline and not your downstream tree even if I think we (and our u=
sers)
> > > > would all benefit from managing the python portions differently.
> > >
> > > OK, once I have applied the remaining two series I will send a PR.
> >
> > Based on the emails in my inbox this morning, you're doing the opposite
> > of what I asked for. But maybe this afternoon will bring something
> > different.
> >
> > > You didn't express a preference for the 'applied' emails. It seems
> > > better to send these emails so that there is a record of the patch
> > > being applied.
> >
> > I guess I wasn't clear enough. Stop spamming the list with *anything*
> > about your personal tree. And if you're going to send anything about
> > something that's intended for mainline, you should make patman act more
> > like b4 and NOT send a message to every patch. I know I used to, but the
> > workflow b4 enables is much better for everyone.
>=20
> How do I (or anyone else) know whether a patch was applied? If you
> only reply to the cover letter, doesn't that mean that the patches are
> left 'hanging' in the mailing list?
>=20
> I didn't know you had changed your policy on this...it certainly seems
> odd to me. I often find Heinrich's patches are 'silently' applied, so
> perhaps he does the same thing?
=20
Every custodian does things as they see fit for mainline, but most are
adopting b4 which means that no, I'm not sure why there would be
confusion, or where it would come from. The emails say what the commit
ranges are for a series, patchwork is updated and then periodically most
patches in patchwork then get their githash added. Replying to the cover
letter with the commit range for the series means it's very much not
"hanging".

--=20
Tom

--qtv7qN2bBCeb1OVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx2DwACgkQFHw5/5Y0
tywy5wwAsEF0XrlmN4ursioHnhxnJIowf0PyMEYnTlEpe00v0XKnGcsZaMIuBBxz
xM1+21mncm+uNepAK+bjEmOiNnShIFj3ag8Hz2RmLgvcYI+1ZghHioABm8PjI70f
EadWWaOhfyHwVvCO+m5dr6RAgBQ6/uSvjt/rfQPrW+rzdueRqC2/KLEM3AN88pDI
gKZDU2lJzikGsdFz0/zQy0GdQdTvRNOArQT1chvPTv5YPokjMSRzC7SinVWYkwo5
n1Goz1rbeCbjrjdJohHBx441KmDkgcGk1iWomKoh40L1s2k0/wgVSoRTw55Z2RrD
LSIn4ZvRlqUnpcWyD1xq8PHi9KTkO3o6Nvr0OrtBv8c3qotlktEHGklaYA9K0KMo
1XSPp5XDXLPK7Ebdx4XUnQVCPiznCLPjjKFOdCEzzYCOYkmRnrrSxQyv28AoOPG3
Snd8xixOfsy/LtZt7WiNY629+BWoVqV8I+UFRzSrRBx1iBXnNSlvd4Otkipyty1/
3cSDldAn
=bgh2
-----END PGP SIGNATURE-----

--qtv7qN2bBCeb1OVl--
