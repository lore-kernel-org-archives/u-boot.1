Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D183D26292
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 19:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A8882A9E;
	Tue, 20 Jan 2026 20:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HeCvp0Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646FA83015; Tue, 20 Jan 2026 20:29:01 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933748063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 20:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d148ddb583so96202a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768937327; x=1769542127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eC8zdyOIPgH5J9KsyInRJF+qCEqzA+zPURjWGD1wWnA=;
 b=HeCvp0RnmWgZV/P9rqxKO1JUPhQN6j97XcXRk6FFIHHkNQ/lEHYPR62pC+v2OZCWlG
 glVxgFXZulIcMGyJcIwYxKOsgkn6NhO6IJ13RH90lt13FHt+RiPeGhZZuKHtTfn6w1mO
 X6zIHYr4RyIudLu2e9miBTTPKFmHP71FuDtKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768937327; x=1769542127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eC8zdyOIPgH5J9KsyInRJF+qCEqzA+zPURjWGD1wWnA=;
 b=PwLKPqMjtZPF+Xma3/WfQjYj4zGGzUm1rgVmKNmA4ZbfuAMHbPv/YYBExBIv3GahbT
 k4gmUP571Ds2HBeq/oySl+Fcd3EuaXtC0RAo17STCi0h1/6BY+Tns21qCH5r8rVINZJo
 N4mzDOpn0NhgNm1/O1lQHiRpqXyKKe2PIqoAdIxjEAdoAuJphp0LwSpKRzRU+/rgn0Jf
 4byCR0CuQc4RfGu4ZqaBB6evuQBTRmMb8waAjpLwS+sFCFTyg0/RGmg1v2uEl90JxURz
 7XFbkVu07O4zHeVR/EOrP8huWwAN2B2knmyUuGe2IvwSupUkT5uixX6yUYwGfaJPV6DG
 fVmg==
X-Gm-Message-State: AOJu0YwkDQZlSeYbiBl1N5fO3olvJkTTkBctZcIvm3A1jvgXMc7WCY8T
 oDvLmsBWg6EOsAXY6hpy7/4h+h0YoodsLF3PCo5Cly667PRLMurpLT3gZk/GqmSYTbU=
X-Gm-Gg: AY/fxX5ih90r0fzqRS5N7WTKRpfAxJW2c8QhxsIEPMYSWLSLus+6LbPw0EjB985lyE9
 +vwHDEwrScWsc6ePPrX9OvPyd9+CQfWvhcVCorKwalORaA7royiKV/mjcplUgXIwQX2DAYuJKns
 R7VOkne0H/Wz4I0Rd5OXk567Ejio7wiQ21TFXyelsle7AyR5uAlDycUX+hFF6D7U9L5P7wS9/JI
 PaD7lg1CChi8n8ZE4BuzE5KZr3dSvw/9LbXMCcBEXW6l3IeHNmj0jZawfuVOySbwUQIF0pq8aXq
 qmVBXWQvqIonlMtVoGBUtRBVJSn5mpievlEtccFRSJnI/q6TGDIw71uF0WL8HHZQEf6uTaldI62
 i6GVDldCCYEMbkRz8S6zTWTw+X+SYUcKKWUd0LGoNVF2La+44FzA8i1+gn0Z8M5PzoC8WIQkKnk
 tcikrMtB+x8FbaFF01q3roG7GdDhaEyRREnXhHpBzV7QXBclv56UhtilrTZ0BtjHrZjE+a95Lz7
 ErAx9Q/VygZCU9Tbm3hKz+nul6zKdyI56ZyZM4=
X-Received: by 2002:a05:6830:6504:b0:7cb:125d:2a47 with SMTP id
 46e09a7af769-7d140a3d5eamr1358015a34.1.1768937327243; 
 Tue, 20 Jan 2026 11:28:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8b28sm9248328a34.2.2026.01.20.11.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:28:46 -0800 (PST)
Date: Tue, 20 Jan 2026 13:28:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 3/3] doc: develop: process: Explain when/how
 Custodians may edit patches
Message-ID: <20260120192844.GQ3416603@bill-the-cat>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-4-trini@konsulko.com>
 <f3bf1986-187c-405d-aafe-9e59ab14b3fc@cherry.de>
 <20260119164728.GC3416603@bill-the-cat>
 <d35d3c89-1b8c-478b-bbbd-7a29f7e10dbf@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2iFUFDucXJ7JBc87"
Content-Disposition: inline
In-Reply-To: <d35d3c89-1b8c-478b-bbbd-7a29f7e10dbf@cherry.de>
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


--2iFUFDucXJ7JBc87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 07:02:50PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/19/26 5:47 PM, Tom Rini wrote:
> > On Mon, Jan 19, 2026 at 01:27:52PM +0100, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 1/16/26 7:16 PM, Tom Rini wrote:
> > > > As seen with commit d503633a3676 ("Revert "doc: board: starfive: up=
date
> > > > jh7110 common description""), it has not always been clear what is =
and
> > > > isn't allowed by custodians, and what the expectations are. To prev=
ent
> > > > further unintentional conflicts, document the limited cases where
> > > > custodians are allowed to modify patches directly, and how to do th=
at.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Changes in v2:
> > > > - New patch.
> > > > ---
> > > >    doc/develop/process.rst | 6 ++++++
> > > >    1 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > > > index 6f5bdd3db957..775a855fd7a0 100644
> > > > --- a/doc/develop/process.rst
> > > > +++ b/doc/develop/process.rst
> > > > @@ -144,6 +144,12 @@ feedback to the submitter of a patch about wha=
t is going on:
> > > >        feels it has been too long since posting their patch and not
> > > >        received any feedback, it is OK to follow-up and ask.
> > > > +    * A custodian may make spelling corrections, spacing fixes and=
 other
> > > > +      obviously correct trivial changes. They must also in turn am=
end
> > >=20
> > > I guess people will have a different interpretation as to *what* is an
> > > "obviously correct trivial change", based on the U-Boot git history, =
are
> >=20
> > Yes, but this is intentional, honestly. In my other follow-up to E
> > Shattow I mentioned there is other general process stuff we need as a
> > project. Custodians are trusted members of the project and should have
> > some leeway.
> >=20
>=20
> Ack.
>=20
> > > there some commits that used the [] + SoB form that are fine or shoul=
dn't
> > > have be made such that we can elaborate a bit more?
> >=20
> > Yes, we've made changes before that perhaps really shouldn't have been,
> > or at least are questionable and should have had more discussion.
> >=20
>=20
> I was just suggesting to provide real-life examples in the docs so people
> have some idea on how to format the commit log for example. I am neither
> intending nor expecting to review all commits ever made to check if some
> changes were made without approval from/feedback to the contributor.

OK, thanks.

> > > I think providing an example would be nice, e.g. the patch as on the =
mailing
> > > list and after being merged with changes (obviously one you think fol=
lowed
> > > the rules here). This will make the section longer for sure but it'll=
 be a
> > > visual cue that this is important.
> > >=20
> > > I would suggest to require the custodian to notify as answer to the o=
riginal
> > > patch if any change was made when merging the patch, even if the chan=
ges
> > > match the allowed list of changes listed above. What do you think?
> >=20
> > I worry that we're making too many changes in the wrong direction, based
>=20
> It's always a fine balance to find. I guess this could be less "needed" if
> we encourage custodians to use b4 ty to send thank you notes when merging.
> Then one can simply go and check the commit themselves (or like you allud=
ed
> in the v1, have tooling that can check that).

I think more custodians using b4 would help (as discussed slightly on
irc, it offers good patchwork integration too), but thats not exactly
what E Shattow was suggesting for a tooling idea, I believe. But I do
believe more custodians using "b4 ty" would be helpful as it provides
"is applied" along with "this commit hash".

> It's always easy to suggest processes when you won't have to follow them
> yourself, so I'm mostly asking questions or suggesting things.

Yes, thanks. :)

> > on the problem that did occur. Which was a real problem. But it was also
> > something that obviously fell outside of the "trivially correct" rule
> > above, as it was adding new content.
> >=20
>=20
> Ack.
>=20
> > Maybe, since the kind of spacing and spelling fixes I perform are the
> > kind checkpatch complains about, and submitters are already supposed to
> > use checkpatch, I should reword it to something like:
> >=20
> > A custodian may make corrections to patches that checkpatch.pl
> > (reference) notes, or may request the author re-submit after fixing
> > them, at their discretion.
> >=20
>=20
> This does help but only for code parts. We don't really have anything for
> the docs for example, or Kconfig, where typos or formatting errors can cr=
eep
> in. But I assume you intended to keep the whitespace/typo as general rules
> and just add the checkpatch requirement for everything that falls out of
> those rules?
>=20
> We can always improve this over time, better have something explained now
> and refined later if custodians have questions or feedback to provide.

Note that checkpatch.pl will (modulo bugs) catch spelling problems
globally.  We now have it catching (some) spacing issues in Kconfig
files, but since the kernel doesn't enforce something there it's local
to us.

--=20
Tom

--2iFUFDucXJ7JBc87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW/XZQAKCRAr4qD1Cr/k
CvsBAQCJ4nW2bllGz96HkFEt0AekiR1mbgqbld4Nu1DgPPBTMQD+NgUF1TqrEe57
4vHoCWifs5SrMVb3lfjFVdJAunArOQ8=
=E+zR
-----END PGP SIGNATURE-----

--2iFUFDucXJ7JBc87--
