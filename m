Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E44C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CCF82E37;
	Mon, 26 May 2025 20:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hoL4roy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D48782E8C; Mon, 26 May 2025 20:12:26 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A0582D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-730580b0de8so1818206a34.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748283142; x=1748887942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6O2ReipBGDJMsjJOhTSz0TkgOPamiUoY1pgZFty37m8=;
 b=hoL4roy9igy7cqr12vBBUHB0wadOdMiiy1lffI9WVvwxm6EK+7Ji+WM9hNnHTaHfyV
 A9cZcmyq+x6cbzLpFgaiUJT2XqX9dIKQcyizXrTYIlH/VLTove9KaxEqwTUmFNeHH1K5
 lZfMCzZpd8nakSU0vKVMVuRpeJVJvFrgD3gCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283142; x=1748887942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6O2ReipBGDJMsjJOhTSz0TkgOPamiUoY1pgZFty37m8=;
 b=aGeKNCiA2qqUFNVJkXXTw6ACiMk6z5cwK1qqngUfomMc9myC6ZPZusocm9xlJQfMH+
 2NLfreMHj7JWDF5lPBtzblozIIOr6km+YIQoumwAfJU8G+GAZQLXjAvyt2W3jY0U9Zpp
 7Nbfg7j9gTmcaTcInz+kkqa2hBxblVtcBEJpaTNd6qLf+EGFt/BDVDer87OyxKkLjswf
 mUXcs4E0H9vnegA9c9AMJIm1YGHmlSzhytL+OcPQMb47ZeN/zPOV/Cb60kkSKWhaAQ65
 dm1idcyuTeyYvcJ/AKXOBTbFPsim3usvEi8LF7AGgQzpV3gvuFI74+IjhWAQkfYPJ+xE
 ee6Q==
X-Gm-Message-State: AOJu0YwEX83MlDG305xuPVOw2vwKNgBot3OktvK/HtiMh8FnsmUB2+U1
 73w+AVbDYfFywGlPk/OT5EKogMSDr7VTqYQ5I4ELss8BYwDH3Jvq1RiOO56HfV03vxs=
X-Gm-Gg: ASbGncvCEdpqcB1CWqj/lEPl8vLhYPRMXQdaI6iSeutXiitGlDSriW6GHnJ1iPu64RE
 cAMMsl+9+eVzhLfeVWGQhi16JS8mXkQjWbrdxEncZ8AmGHAvJxsXiZsFpANqLfvDKfkIda34f+B
 /v4f2ir7JM7Ik5S6R6QKNmtW/4xO9onr7sXN213U5eIvPSLcVYR/zt7pungcRkOgiSxNLpe4gPL
 Pu04XN7fLMaa8d5jiLwQGgIHiBJPClMC/F7ZMGaUE9HIFH7Y220eaJOj8vqfYNwJMP6wkmKlWKS
 rpfyKCq2+EuoOy9de/++LYJDCnL86yGyRqvcFwvzvOnzmHxC3/dJxMqCVtCbK9ZjzkbARxW+1Gy
 k5YqQZjD2nWk0l1bNn2+xtWE=
X-Google-Smtp-Source: AGHT+IHbQr21ALHB4P71ljlRCLN/uufx9dyjk1ixTO3IljtyPCdjMyYTc2BNekEXGVUEchF3qeOAEQ==
X-Received: by 2002:a05:6830:3d97:b0:735:3e82:872b with SMTP id
 46e09a7af769-7354ca4cdf2mr7024494a34.11.1748283142276; 
 Mon, 26 May 2025 11:12:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6981454sm4064183a34.0.2025.05.26.11.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 11:12:21 -0700 (PDT)
Date: Mon, 26 May 2025 12:12:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250526181219.GY100073@bill-the-cat>
References: <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
 <20250524141805.GB100073@bill-the-cat>
 <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
 <20250524143124.GI100073@bill-the-cat>
 <CAFLszTizvrb9jX+a6-BVVtrH-fU5T_DdV8gakyEszSVCojp3hQ@mail.gmail.com>
 <CAFLszThUpdm2e0QgYuENfmC8+4L-29iW7XQgNLhZzpkkyEeUnw@mail.gmail.com>
 <20250524145114.GO100073@bill-the-cat>
 <CAFLszTgf+hY08ORLyxT_FsUwzZP36wjNvTKLRwwVcxBFh7URbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="neAHbqPdPJGyNd/t"
Content-Disposition: inline
In-Reply-To: <CAFLszTgf+hY08ORLyxT_FsUwzZP36wjNvTKLRwwVcxBFh7URbg@mail.gmail.com>
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


--neAHbqPdPJGyNd/t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 04:26:55PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 03:39:35PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 24 May 2025 at 15:35, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Sat, 24 May 2025 at 15:31, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, May 24, 2025 at 03:22:57PM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 24 May 2025 at 15:18, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon G=
lass wrote:
> > > > > > > > > > > > > > It is easier for tests if the top-level control=
 logic is all in one
> > > > > > > > > > > > > > module. Create a new do_patman() function to ha=
ndle this. Move the
> > > > > > > > > > > > > > existing code into it.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  tools/patman/__main__.py | 49 ++--------------=
--------------------
> > > > > > > > > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++=
++++++++++++++++++++++--
> > > > > > > > > > > > > >  2 files changed, 54 insertions(+), 49 deletion=
s(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Applied to sjg/master, thanks!
> > > > > > > > > > > > >
> > > > > > > > > > > > > Odd. I thought you had posted this against master=
 or next, intending it
> > > > > > > > > > > > > for mainline, which is why I assigned it to you i=
n patchwork. I see the
> > > > > > > > > > > > > cover letter is missing what commit it's against.=
 And instead here you
> > > > > > > > > > > > > are once again spamming the list and with message=
s about your personal
> > > > > > > > > > > > > tree. Why?
> > > > > > > > > > > >
> > > > > > > > > > > > I'm applying it to my tree and intend to send you a=
 PR at some point,
> > > > > > > > > > > > with collected tools/ patches. So I believe I need =
to send emails
> > > > > > > > > > > > about applying things and update it in patchwork. L=
et's discuss this
> > > > > > > > > > > > in a future call.
> > > > > > > > > > >
> > > > > > > > > > > I don't see what there is to discuss. Please follow t=
he normal process
> > > > > > > > > > > for mainline and stop spamming the list with notices =
for your personal
> > > > > > > > > > > tree. You're also diverging your own tree further fro=
m mainline by doing
> > > > > > > > > > > this and making it less likely (multiple people have =
told you they don't
> > > > > > > > > > > want to review things not against mainline) any follo=
w-up work will get
> > > > > > > > > > > comments other than that it's not applicable to mainl=
ine.
> > > > > > > > > >
> > > > > > > > > > For patman, I have another series [1] I'm planning to a=
pply to my tree tomorrow
> > > > > > > > > >
> > > > > > > > > > Would you like me to send 'applied' emails for it to th=
e mailing list?
> > > > > > > > > > Or perhaps just for the cover letter? Would you like me=
 to send you a
> > > > > > > > > > pull request?
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Simon
> > > > > > > > > >
> > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?se=
ries=3D456256
> > > > > > > > >
> > > > > > > > > Yes, that's another series that while I disagree with the=
 direction
> > > > > > > > > you're taking things, would rather apply to mainline than=
 let it bitrot
> > > > > > > > > in mainline. So please send a PR against next. And that w=
ould also apply
> > > > > > > > > to the series this email is in reply to. As again, I had =
expected it for
> > > > > > > > > mainline and not your downstream tree even if I think we =
(and our users)
> > > > > > > > > would all benefit from managing the python portions diffe=
rently.
> > > > > > > >
> > > > > > > > OK, once I have applied the remaining two series I will sen=
d a PR.
> > > > > > >
> > > > > > > Based on the emails in my inbox this morning, you're doing th=
e opposite
> > > > > > > of what I asked for. But maybe this afternoon will bring some=
thing
> > > > > > > different.
> > > > > > >
> > > > > > > > You didn't express a preference for the 'applied' emails. I=
t seems
> > > > > > > > better to send these emails so that there is a record of th=
e patch
> > > > > > > > being applied.
> > > > > > >
> > > > > > > I guess I wasn't clear enough. Stop spamming the list with *a=
nything*
> > > > > > > about your personal tree. And if you're going to send anythin=
g about
> > > > > > > something that's intended for mainline, you should make patma=
n act more
> > > > > > > like b4 and NOT send a message to every patch. I know I used =
to, but the
> > > > > > > workflow b4 enables is much better for everyone.
> > > > > >
> > > > > > How do I (or anyone else) know whether a patch was applied? If =
you
> > > > > > only reply to the cover letter, doesn't that mean that the patc=
hes are
> > > > > > left 'hanging' in the mailing list?
> > > > > >
> > > > > > I didn't know you had changed your policy on this...it certainl=
y seems
> > > > > > odd to me. I often find Heinrich's patches are 'silently' appli=
ed, so
> > > > > > perhaps he does the same thing?
> > > > >
> > > > > Every custodian does things as they see fit for mainline, but mos=
t are
> > > > > adopting b4 which means that no, I'm not sure why there would be
> > > > > confusion, or where it would come from. The emails say what the c=
ommit
> > > > > ranges are for a series, patchwork is updated and then periodical=
ly most
> > > > > patches in patchwork then get their githash added. Replying to th=
e cover
> > > > > letter with the commit range for the series means it's very much =
not
> > > > > "hanging".
> > > >
> > > > Generally I rely on seeing a reply to a patch to know it was applie=
d.
> > > > So it is confusing when the patch goes in but there was no reply to
> > > > the patch.
> > > >
> > > > I've noticed that you seem less inclined to apply some patches from=
 a
> > > > series, instead requesting that the whole series is resent. Perhaps
> > > > that is why?
> > >
> > > Also, was there an announcement about this change? If so, could you
> > > please point me to it?
> >
> > I don't see why there would be an announcement? Now, again, please stop
> > posting things to the public mailing list about your tree. I'm not the
> > only person who has told you it's not helpful.
> >
> > I mean heck, a big part of the problem is that you keep replying to
> > patches you posted for your tree and spamming the rest of the community
> > about it. I can't tell if you're acting in bad faith or not anymore.
>=20
> It's just that I am trying to work with your tree in areas where I'm
> not blocked, to minimise the delta.

This is a confusing statement to make in response to an area that you
were not blocked on (since I had said several times I would take) and
you increased the delta.

> Most of the patches apply fine to -next . I could perhaps update the
> tooling to indicate that. Would that help?

Most is the wrong number. Everything needs to apply, cleanly.

> I'm thinking of adding a feature to patman to support multiple
> 'target' upstreams.

This seems like a whole lot more work than just only posting things from
a tree that's based on the correct branch of mainline. If "git show"
doesn't include whatever the hash is in mainline, it doesn't belong on
the list.

--=20
Tom

--neAHbqPdPJGyNd/t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0rv8ACgkQFHw5/5Y0
tywIkgv/Xb3/Bs2t4/enpmLm8O1tA5xwb8WTvFiTZoakEKghTpZ7baAVkwRzJUPr
oth+GI5I/D9DotCCBmbPSsVDA4Q4RkjpkAe5Pv+AYnO+7HsRLjAcf6LsYWhSseUd
uj3ktaa1k6iFjaWzDoGsUvEW86i1p4AhJAgZNEHsvBQRnZJpqbXuUKbr82veBYpn
gxQJGpSWa00+vDrRB/XAmh1Y56pVXi3UJM5Ik6r1MfThvMTOmGBiXWhkPyluVRyL
Nq/cHfRuwgb48iG8/Srsbhhp4IQE2conNh1RU28iB0RwENXjI2jLSc72Mop/F/Oz
X1qBT+4khSNfU9Wugchz3f7jaA4qxjb2ToBODpDIbvBs1EbCvIaM0EmyTk3vBi1z
OxzITa7Ha8drMTmvQXExtS0aDP3/qdj5QWZZH6k+Ci7O2So4GIsY9mOBwEAzpQtA
vk3lk/PU+bpfwTLTUM9GInHgyoeCKAuJOe5yWCa6QcjgBBYvXRjs/7aXNfTJhHkE
M5pwWlX6
=nfmZ
-----END PGP SIGNATURE-----

--neAHbqPdPJGyNd/t--
