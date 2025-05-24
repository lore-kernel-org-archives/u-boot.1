Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E4C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7848310F;
	Sat, 24 May 2025 16:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A2o/QA9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C657C834EC; Sat, 24 May 2025 16:51:21 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E28F82D6C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7306482f958so498382a34.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748098278; x=1748703078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KvlFd97j9f3G2KpXiJO0iwgsXjevyreTYXMHD3Hw0bc=;
 b=A2o/QA9vvFMV+rL50VeL/+LfN9fP0RonMqXtigkMcej+A5VSEZFqr1QVYIEq3IerG5
 04AVH+4U0BMdFTI8wvsY37rdXwA8HZLoi6dB3qb9rchz5n/gYcpW1KEG3Z6zyHvkKH/e
 rV1JXNNP15O0wIWavbzSdUtOG4j1AOuKcePv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748098278; x=1748703078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvlFd97j9f3G2KpXiJO0iwgsXjevyreTYXMHD3Hw0bc=;
 b=RtjcwgGGmCRuguTKX7WFUqY3HnkzKSLNEfSOTXgsaAQbQTEJzlyH3Y823y96wLwSOo
 p1d7g68rXS3wDcLi8gy/MgRGW6j7VloheeQtNrcLqSQHnNhbbP8W0wkwyasruYAhRK40
 7cMX+BspX4DuveWeR5PhKLX9+n/cmsz6TbSZPihD1X9q1sYAaJ7xnOFVuGrsPhOsfq51
 TZllXXUngEQJqnu7sJPneUDjcebEx2L5veKHwvZgS2LFr8GUWnU+YSXfT4Ttl82ZxhNG
 kHtUJrOuv89Afc1WtzScw1eSa8DXH0Be17Se+F1EN4KnE5zXr4Bsj0vTYCi5cY6oNLzb
 vZqA==
X-Gm-Message-State: AOJu0Yx6a5iHD6NgnSX5d6cDwty+Po4dokTG4ScHRnuV4TEmt/1Ay8xE
 uoq/qSmSUqItIIfn7rDjao/ejz8o25iQzLcGzRldMOm2COjNL1Fn7nxj3bNdYUx3RB4=
X-Gm-Gg: ASbGncty41yl9AoPeYEMNpxPeiNywoOQMzxw+54RuW89y3AiDFCuf0BgqVPTSL150Ji
 zEXFDqKdybE0xphmBgIZhpJw2o5XzqfH+V2ZdhHUvYW5IpDOCoW3TACSA+fx0jvt68LCDwJ/6/T
 wf5yEKONaacukz55XQ+vn9ZBZtnV7XdCS/6Ez6NWLOCUS89/wFeLjS9y68mqx2fZUnVH6unSUNi
 pHgk+Eb1COAIDzN87VoONNWEMPDw0w6cqetgVQvooTMyKfGa/atFb5PaKJds1v3cWVAsN9PMaSy
 Yc5POjIMVTfbBLXrqAOSCuvQc19OuotAW3L24lzwEOyjwWt1c+ImlfmYMmoKC9CBRItj3KkdB2k
 sZF/De+Vlyo3n
X-Google-Smtp-Source: AGHT+IGZ1yCz+2Erpt1Ejz2LuzjO9N0PYDOKFfoXASeahxqa2Bzr7OnT4jDqXkDX3Buk0gd8npc9Jg==
X-Received: by 2002:a05:6830:7010:b0:72b:8326:f0c7 with SMTP id
 46e09a7af769-7355d1ca50emr2053547a34.28.1748098277693; 
 Sat, 24 May 2025 07:51:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a9cc8dsm3302485a34.40.2025.05.24.07.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:51:16 -0700 (PDT)
Date: Sat, 24 May 2025 08:51:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250524145114.GO100073@bill-the-cat>
References: <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
 <20250524141805.GB100073@bill-the-cat>
 <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
 <20250524143124.GI100073@bill-the-cat>
 <CAFLszTizvrb9jX+a6-BVVtrH-fU5T_DdV8gakyEszSVCojp3hQ@mail.gmail.com>
 <CAFLszThUpdm2e0QgYuENfmC8+4L-29iW7XQgNLhZzpkkyEeUnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oyPqq+9B4dyIg1QK"
Content-Disposition: inline
In-Reply-To: <CAFLszThUpdm2e0QgYuENfmC8+4L-29iW7XQgNLhZzpkkyEeUnw@mail.gmail.com>
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


--oyPqq+9B4dyIg1QK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 03:39:35PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:35, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Sat, 24 May 2025 at 15:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, May 24, 2025 at 03:22:57PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 24 May 2025 at 15:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass=
 wrote:
> > > > > > > > > > > > It is easier for tests if the top-level control log=
ic is all in one
> > > > > > > > > > > > module. Create a new do_patman() function to handle=
 this. Move the
> > > > > > > > > > > > existing code into it.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > >
> > > > > > > > > > > >  tools/patman/__main__.py | 49 ++------------------=
----------------
> > > > > > > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++=
++++++++++++++++++--
> > > > > > > > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > Applied to sjg/master, thanks!
> > > > > > > > > > >
> > > > > > > > > > > Odd. I thought you had posted this against master or =
next, intending it
> > > > > > > > > > > for mainline, which is why I assigned it to you in pa=
tchwork. I see the
> > > > > > > > > > > cover letter is missing what commit it's against. And=
 instead here you
> > > > > > > > > > > are once again spamming the list and with messages ab=
out your personal
> > > > > > > > > > > tree. Why?
> > > > > > > > > >
> > > > > > > > > > I'm applying it to my tree and intend to send you a PR =
at some point,
> > > > > > > > > > with collected tools/ patches. So I believe I need to s=
end emails
> > > > > > > > > > about applying things and update it in patchwork. Let's=
 discuss this
> > > > > > > > > > in a future call.
> > > > > > > > >
> > > > > > > > > I don't see what there is to discuss. Please follow the n=
ormal process
> > > > > > > > > for mainline and stop spamming the list with notices for =
your personal
> > > > > > > > > tree. You're also diverging your own tree further from ma=
inline by doing
> > > > > > > > > this and making it less likely (multiple people have told=
 you they don't
> > > > > > > > > want to review things not against mainline) any follow-up=
 work will get
> > > > > > > > > comments other than that it's not applicable to mainline.
> > > > > > > >
> > > > > > > > For patman, I have another series [1] I'm planning to apply=
 to my tree tomorrow
> > > > > > > >
> > > > > > > > Would you like me to send 'applied' emails for it to the ma=
iling list?
> > > > > > > > Or perhaps just for the cover letter? Would you like me to =
send you a
> > > > > > > > pull request?
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Simon
> > > > > > > >
> > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=
=3D456256
> > > > > > >
> > > > > > > Yes, that's another series that while I disagree with the dir=
ection
> > > > > > > you're taking things, would rather apply to mainline than let=
 it bitrot
> > > > > > > in mainline. So please send a PR against next. And that would=
 also apply
> > > > > > > to the series this email is in reply to. As again, I had expe=
cted it for
> > > > > > > mainline and not your downstream tree even if I think we (and=
 our users)
> > > > > > > would all benefit from managing the python portions different=
ly.
> > > > > >
> > > > > > OK, once I have applied the remaining two series I will send a =
PR.
> > > > >
> > > > > Based on the emails in my inbox this morning, you're doing the op=
posite
> > > > > of what I asked for. But maybe this afternoon will bring something
> > > > > different.
> > > > >
> > > > > > You didn't express a preference for the 'applied' emails. It se=
ems
> > > > > > better to send these emails so that there is a record of the pa=
tch
> > > > > > being applied.
> > > > >
> > > > > I guess I wasn't clear enough. Stop spamming the list with *anyth=
ing*
> > > > > about your personal tree. And if you're going to send anything ab=
out
> > > > > something that's intended for mainline, you should make patman ac=
t more
> > > > > like b4 and NOT send a message to every patch. I know I used to, =
but the
> > > > > workflow b4 enables is much better for everyone.
> > > >
> > > > How do I (or anyone else) know whether a patch was applied? If you
> > > > only reply to the cover letter, doesn't that mean that the patches =
are
> > > > left 'hanging' in the mailing list?
> > > >
> > > > I didn't know you had changed your policy on this...it certainly se=
ems
> > > > odd to me. I often find Heinrich's patches are 'silently' applied, =
so
> > > > perhaps he does the same thing?
> > >
> > > Every custodian does things as they see fit for mainline, but most are
> > > adopting b4 which means that no, I'm not sure why there would be
> > > confusion, or where it would come from. The emails say what the commit
> > > ranges are for a series, patchwork is updated and then periodically m=
ost
> > > patches in patchwork then get their githash added. Replying to the co=
ver
> > > letter with the commit range for the series means it's very much not
> > > "hanging".
> >
> > Generally I rely on seeing a reply to a patch to know it was applied.
> > So it is confusing when the patch goes in but there was no reply to
> > the patch.
> >
> > I've noticed that you seem less inclined to apply some patches from a
> > series, instead requesting that the whole series is resent. Perhaps
> > that is why?
>=20
> Also, was there an announcement about this change? If so, could you
> please point me to it?

I don't see why there would be an announcement? Now, again, please stop
posting things to the public mailing list about your tree. I'm not the
only person who has told you it's not helpful.

I mean heck, a big part of the problem is that you keep replying to
patches you posted for your tree and spamming the rest of the community
about it. I can't tell if you're acting in bad faith or not anymore.

--=20
Tom

--oyPqq+9B4dyIg1QK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx3OIACgkQFHw5/5Y0
tyxwIQv+Pi1Wi2ezULxgUbcG+YNVvoDff2iyk1naLJuFGbKDLmviXO/t+RGlReC+
CEm6eqnECTOU9VqUweM+J3u0RyOY1xORUxe6IMzlBZSVhWAjizwAXsBvLpTHxAa6
2mNOEriNbYDSyqtaIpyGNAPKGsPpNksXAED0KNPb2SnDV9Y84J7FFuyUHCGaGH6v
w+2R0kKC+Y44V+geg8PZyaxgQoCEblxjR3fXgZnzXF37dnzWeVL0NLv+TzqZs1L+
Cgd6T9OmYXp4EGN2O7kUwchsZElZMPKfPmsowNvLhZv7fFLMCCcoBTbyteJTuTp+
Gn0GafafLiP/CaB8Sv4QcGRRa+jCICR6y702B4IomqHmUgjgH4F75Bn+jUhW3Osb
6ydeEB//8n6Aq/oTX9eY2pL8dZHUZbzsLtEJO53BtB1sPINZBq97CkJYiLeoElUI
thrrstLGnj08/K/ioEU8tvwD7xXMu9fBJPwEc8BHso220jrZfQVDBATlm9/O/XaF
TZvurqwD
=JCRd
-----END PGP SIGNATURE-----

--oyPqq+9B4dyIg1QK--
