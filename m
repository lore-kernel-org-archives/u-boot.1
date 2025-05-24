Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10614C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7786782F67;
	Sat, 24 May 2025 16:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DNGOpiCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C778310F; Sat, 24 May 2025 16:47:10 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDB482A25
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-605f7d3215cso346306eaf.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748098026; x=1748702826; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9oZUlYiz3SUJXz93OGOebGlIr+FJ+jnct9OTLoFwkBs=;
 b=DNGOpiCCXjNH27MIOpZc5EnCEV361LwS65ZWt4B1avrGDmCaCRpx97HetqVg+5oAQP
 53E8jFCCBlcRiYOmyaqViMhSncBDkDw+kzqWsA8uhQ4J72Q+uILjRueofjW7+r6b2lst
 4V/RuRIq/2Q66mxxlRACCDCv4usxNDL4DBMDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748098026; x=1748702826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oZUlYiz3SUJXz93OGOebGlIr+FJ+jnct9OTLoFwkBs=;
 b=tRL6RA4FaPmvTfC7/QBE5FDWYFoUcLXB5ddCaPv3gk4VHdV1cVhq2ovZzP+WInHYCV
 mJQLYeKTVU5yHik+wV7slRDjIcQhd7a/CH7cqyHIusmH0ahwQF5zsA0Wpivnpraca2wK
 y3OmS5uSh5H8C/DmbQlLVCe5xQKsuG25xmKAlgTUROmEpl3G6d8MwIxYORAQUQbXmcq2
 zSGgtDdrQTC28khg/09vwIt0iBnpPi26U5A1ZPyyOLYymTdsPeS23/izJSvbDXSfY5Dk
 geI5ksGh/wyqqFCCyGQoJJ8VZ9hLMLG7FddYJTb6pySJi5gLCGS1hYytBq5bfPyfSzk+
 b9gQ==
X-Gm-Message-State: AOJu0YyrLXWZiDKjixFr6agV3l0WgT+IBM5z10tOfKcoE8NXFkm0nxA9
 6/hKgL7AK3n2jH0WEZCbHYT5u4+gUoYIMWWlnvbt2EAZMjHAoQyGvMzZMmNpHBp4WO4=
X-Gm-Gg: ASbGncttDpt4jwk4AhWbP/9eJF/J1+79gfTtqGGs2DBr3I0h4PgqVkySdEbP6k8AjG1
 6Uprq7diyBVyCs1IMLjUqXc8JTHxvI4TKTQIP2c34nXF/a5B4n7jwIjJxiDf7Mh3Ye820C4n/YO
 9mUfoejKFazxB362wDxJ+zj0TEtLJvlixFqpgVX3n8f5GblQFKNd87xpoW0qUyRTkD6tPB4M1PD
 DALu3hJFxR22IJMZcQCZpFNHKiM52BXH81oVpCM30ii6mnwq2KjVQgJDSGpXhYGrNylccaruHdx
 CbsnISreBFBDgAnSbWrExZqRXdbJDyVmWIsdoiUoIhV1TvKEfoc60AdXSSWm0paRGVbi+PjG76Z
 Ptd8KxL8c9EBm
X-Google-Smtp-Source: AGHT+IGI09OU+T1VL2Ev6/sAWonWC/ijYyzF50/TrFeI/dcRJD+kbk6q3GlfJYr4SQer3un6JsbXTQ==
X-Received: by 2002:a05:6820:20a:b0:60b:7e53:f1c1 with SMTP id
 006d021491bc7-60b9faecfc4mr1689439eaf.3.1748098026124; 
 Sat, 24 May 2025 07:47:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f3f16esm3679065eaf.11.2025.05.24.07.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:47:05 -0700 (PDT)
Date: Sat, 24 May 2025 08:47:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250524144703.GN100073@bill-the-cat>
References: <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
 <20250524141805.GB100073@bill-the-cat>
 <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
 <20250524143124.GI100073@bill-the-cat>
 <CAFLszTizvrb9jX+a6-BVVtrH-fU5T_DdV8gakyEszSVCojp3hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QqvR+SCu4vZz9+GL"
Content-Disposition: inline
In-Reply-To: <CAFLszTizvrb9jX+a6-BVVtrH-fU5T_DdV8gakyEszSVCojp3hQ@mail.gmail.com>
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


--QqvR+SCu4vZz9+GL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 03:35:32PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 24 May 2025 at 15:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 24, 2025 at 03:22:57PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 24 May 2025 at 15:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass w=
rote:
> > > > > > > > > > > It is easier for tests if the top-level control logic=
 is all in one
> > > > > > > > > > > module. Create a new do_patman() function to handle t=
his. Move the
> > > > > > > > > > > existing code into it.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v1)
> > > > > > > > > > >
> > > > > > > > > > >  tools/patman/__main__.py | 49 ++--------------------=
--------------
> > > > > > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++=
++++++++++++++++--
> > > > > > > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > Applied to sjg/master, thanks!
> > > > > > > > > >
> > > > > > > > > > Odd. I thought you had posted this against master or ne=
xt, intending it
> > > > > > > > > > for mainline, which is why I assigned it to you in patc=
hwork. I see the
> > > > > > > > > > cover letter is missing what commit it's against. And i=
nstead here you
> > > > > > > > > > are once again spamming the list and with messages abou=
t your personal
> > > > > > > > > > tree. Why?
> > > > > > > > >
> > > > > > > > > I'm applying it to my tree and intend to send you a PR at=
 some point,
> > > > > > > > > with collected tools/ patches. So I believe I need to sen=
d emails
> > > > > > > > > about applying things and update it in patchwork. Let's d=
iscuss this
> > > > > > > > > in a future call.
> > > > > > > >
> > > > > > > > I don't see what there is to discuss. Please follow the nor=
mal process
> > > > > > > > for mainline and stop spamming the list with notices for yo=
ur personal
> > > > > > > > tree. You're also diverging your own tree further from main=
line by doing
> > > > > > > > this and making it less likely (multiple people have told y=
ou they don't
> > > > > > > > want to review things not against mainline) any follow-up w=
ork will get
> > > > > > > > comments other than that it's not applicable to mainline.
> > > > > > >
> > > > > > > For patman, I have another series [1] I'm planning to apply t=
o my tree tomorrow
> > > > > > >
> > > > > > > Would you like me to send 'applied' emails for it to the mail=
ing list?
> > > > > > > Or perhaps just for the cover letter? Would you like me to se=
nd you a
> > > > > > > pull request?
> > > > > > >
> > > > > > > Regards,
> > > > > > > Simon
> > > > > > >
> > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=
=3D456256
> > > > > >
> > > > > > Yes, that's another series that while I disagree with the direc=
tion
> > > > > > you're taking things, would rather apply to mainline than let i=
t bitrot
> > > > > > in mainline. So please send a PR against next. And that would a=
lso apply
> > > > > > to the series this email is in reply to. As again, I had expect=
ed it for
> > > > > > mainline and not your downstream tree even if I think we (and o=
ur users)
> > > > > > would all benefit from managing the python portions differently.
> > > > >
> > > > > OK, once I have applied the remaining two series I will send a PR.
> > > >
> > > > Based on the emails in my inbox this morning, you're doing the oppo=
site
> > > > of what I asked for. But maybe this afternoon will bring something
> > > > different.
> > > >
> > > > > You didn't express a preference for the 'applied' emails. It seems
> > > > > better to send these emails so that there is a record of the patch
> > > > > being applied.
> > > >
> > > > I guess I wasn't clear enough. Stop spamming the list with *anythin=
g*
> > > > about your personal tree. And if you're going to send anything about
> > > > something that's intended for mainline, you should make patman act =
more
> > > > like b4 and NOT send a message to every patch. I know I used to, bu=
t the
> > > > workflow b4 enables is much better for everyone.
> > >
> > > How do I (or anyone else) know whether a patch was applied? If you
> > > only reply to the cover letter, doesn't that mean that the patches are
> > > left 'hanging' in the mailing list?
> > >
> > > I didn't know you had changed your policy on this...it certainly seems
> > > odd to me. I often find Heinrich's patches are 'silently' applied, so
> > > perhaps he does the same thing?
> >
> > Every custodian does things as they see fit for mainline, but most are
> > adopting b4 which means that no, I'm not sure why there would be
> > confusion, or where it would come from. The emails say what the commit
> > ranges are for a series, patchwork is updated and then periodically most
> > patches in patchwork then get their githash added. Replying to the cover
> > letter with the commit range for the series means it's very much not
> > "hanging".
>=20
> Generally I rely on seeing a reply to a patch to know it was applied.
> So it is confusing when the patch goes in but there was no reply to
> the patch.

I don't want to comment on your workflow, but I know from experience
that maintaining downstream trees is hard.

> I've noticed that you seem less inclined to apply some patches from a
> series, instead requesting that the whole series is resent. Perhaps
> that is why?

Nope, b4 is quite happy to apply parts of a series and send out useful
emails.

--=20
Tom

--QqvR+SCu4vZz9+GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx2+YACgkQFHw5/5Y0
tyw44wv9Gln9fvaTrq5d+cMhJZMvrFRWO0jW0lcNCRvGyCBvWtEaXTMzw8aY53JP
G/HQhSoKFRwdsHg52+8J735abWJgs2FmQse4FttTko94c65QZ+WjMRG01B4umHCH
5/AC9d30QclDO3RTOd3pqrT06EYpQ6M9rc+c1yj/KEMXe2vsIoxJ9rZLXQuYv2zV
8SU4LRasDzeN4i0f6kxQmUkYOd1z4oNkXPTMj64aH6m+sQXFRQybtctI3FSDiQMy
kMkBfWzu5He3YlSlBBYJwtwExuJJS2Q2W5fb+mmQ7sI8Ey0avysEtL2ZySQ9m6SM
hIKR7OK8Hn6Cqg9QAGni41/6+PcfsfKlFhW30x4csIk2yT+bdlxZVHl3xUovsDdr
FeOb3hwCUtu6XlG02UxLDyFFijsqX4M01dFx+kiSi7zajP+XTER0Tj8evndrewDS
qTtAHJ2oN5R6/KqZvFjguXsrlTklsXovp+IkIoG0z/zM3BTUFGRIzI2sUMZiKub/
voPXIz3B
=jv4y
-----END PGP SIGNATURE-----

--QqvR+SCu4vZz9+GL--
