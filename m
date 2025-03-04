Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF8EC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DE4801CF;
	Tue,  4 Mar 2025 16:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GjiZyTvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0317A80786; Tue,  4 Mar 2025 16:29:16 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC67801CF
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e6087a8588bso5424289276.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741102152; x=1741706952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu539zbG90EJMzM9v2eCXhgLiSNFTfPd+jRCpKA2ofk=;
 b=GjiZyTvo14q53J3f2MQOdhV2FEuF82LO6keHor8H+UyabhjLp2xZCQh7tyb3GC/Kdk
 dm7a7n0AvSun8Iej+c+nM8IwtA2vrqMRX5av1qpkeXza9HTCn2ZYB6Gud34/JZDXGdEV
 GytwPzWxa9Cp+z0nZBMkJJKJFFNew5MOuAXv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102152; x=1741706952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pu539zbG90EJMzM9v2eCXhgLiSNFTfPd+jRCpKA2ofk=;
 b=ijslJWuJ7JUAuFmIb08OYscdQRHgwDGTA1Dz8deMngufea3/RPop3vAoAbg2EKMcwK
 sclKG7IMyJ7EA49yCGksgizM17mN/h+siqFMnQtEyPGIuYlOzwMhmwepbF3RpiZA/RXu
 pVYaMz15TpszrLiEMSDKzSIaFyCoxHdAwS22IDZGejSHrDjBDWmPgqdrESRqGt4k/ef2
 Hzk2iBlcKZ+MdbBOU5FQ9w2ViBZpP42DuAdro/GJOD0RG1ADO7jPCwMgQCSXxpygMI/C
 o+E1Vw60YktHpanuB0OHbKo+vMupGzqH+ykbvG0oXBm/V/ZnXuSZx7ZUCUX5jFrqkTgL
 LRFw==
X-Gm-Message-State: AOJu0YyGssY9HiyKlk502mporSEgUCA2QXWBXr2P35tf2dotEH9XoAjI
 LT7cpI5zh1r/26EJzM4MPODoKJW9k9jn/GLLBMpS+oZ5+fUksByB8We0wZMBQls=
X-Gm-Gg: ASbGncubiZVwk6+uxjEL4SbSSMECc7j6VcsZpPfcyuGMFi8H2K7mXlrstJPHq4CL66G
 qlZjqQN9E8U8v1wt2tCFPWgLUazJGdPCV9JLxH5T8WFX33EGnh+EwnSOvtIRQuNVkGT4gquQNsm
 2gEwBbtz5bQdd6e/BsPJt9IFHbGn4DCM5blbhO7OEydG8M5Xj67cnPDFTZWnCFwOVjMeTBKU+4Z
 ReHWG5LLyDUZI+nXKFcP9hzd27X8EqxdUZzT8Dwm97QePkzrk5hNqEB3CWQwIDQtm8sLSByOFgt
 f4RKVEkS7ow+NFUSTGw651vSKxbndi/9aNPe1vgN9GI=
X-Google-Smtp-Source: AGHT+IF8aaS64RjOwyWc72qC8WP7Vz8mNAV2101G4UROGaqefAvpLBh1g+9SFkGezwlqd/LDSg0qCA==
X-Received: by 2002:a05:6902:230d:b0:e5b:4a7b:c518 with SMTP id
 3f1490d57ef6-e610c315f1bmr4358499276.1.1741102152275; 
 Tue, 04 Mar 2025 07:29:12 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a417a6sm3645883276.28.2025.03.04.07.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:29:11 -0800 (PST)
Date: Tue, 4 Mar 2025 09:29:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250304152909.GZ2640854@bill-the-cat>
References: <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bSy74z/Gl57Lxv7q"
Content-Disposition: inline
In-Reply-To: <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
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


--bSy74z/Gl57Lxv7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 06:13:36AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> (I changed the subject as 'change' sounds like change for change's sake)

Frankly, you have a lot of "tidy up" patches where nothing was
functionally wrong.

> On Mon, 24 Feb 2025 at 16:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > (I think you chopped off too much context, so I've added it below)
> >
> > That's fine. But I omitted it because it's also true for any other DM
> > migration, and bootstd more fully and adding more classes of devices for
> > bootmeths and I honestly think you have a half dozen big things that are
> > in various states of being merged and enabled and perhaps even more that
> > didn't get much past sandbox being enabled.
>=20
> Yes I often have new ideas and start things.

And my point is they need to be finished.

> > > On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > [snip]
> > >
> > > [unsnip]
> > > > > > > >
> > > > > > > > Sure, but we can't even get sunxi bootstd or LED over the l=
ine. How do
> > > > > > > > you imagine we could retire the legacy image?
> > > > > > >
> > > > > > > Partly by focusing on one thing and not 5 things at a time. b=
ootstd is
> > > > > > > stuck on reworking efi bootmanager integration, and LED is wa=
iting for
> > > > > > > someone to confirm that really, finally, we have all of the o=
ld use
> > > > > > > cases supported in the new code.
> > > > > > >
> > > > > > > But more importantly, do we really have anyone not using u-bo=
ot.img? I
> > > > > > > don't know.
> > > [unsnip end]
> > >
> > > > > > If we did one of these sorts of things at a time, we would only=
 get
> > > > > > 2-3 things done each year!
> > > > >
> > > > > A project with 4 yearly releases finishing two 2-3 big changes a =
year
> > > > > sounds great to me. Rather than not finishing a dozen things?
> > > >
> > > > As this is a huge thread already, I'm splitting this part out.
> > > >
> > > > I would seriously frame slowing down and having just one big change
> > > > being in progress at a time, until it's done, as a good thing, not =
a bad
> > > > thing. We're a small community with limited bandwidth.
> > >
> > > I can't see how that would work.
> >
> > Well, what we have today is clearly not working well enough for you. And
> > "just land my changes" is still not an option for mainline.
>=20
> You really haven't addressed my point here.

Then I don't see your point, or fundamentally disagree with it.

> > > I just looked at LED[1] originally sent almost 5 months ago and the
> > > latest version is marked 'changes requested'. I don't know of any
> > > changes I can make. Are you hoping that [sorry forgot who it was] will
> > > get around to digging the only affected device out of his drawer and
> > > try to get the activity-LED going? It might take a while.
> >
> > Yes, and as a reminder it's only been 6 or 7 months since mainline had
> > all of the required functionality, maybe. And what *you* could do to
> > speed things along is implement the functionality on any of the boards
> > at your disposal. Anything with a LED today would be fine for this.
>=20
> Oh well. I would have thought that Christian's series was enough there?

Might be. Waiting for someone to have time to confirm functionality.
Which you had previously agreed was a good idea, I thought.

> > > The sunxi one[2] was sent over 6 months ago and the latest version is
> > > also marked 'changes requested'. You could apply that series with
> > > either the bootmgr revert or the patch that drops bootmgr for sunxi.
> > > Then Heinrich can come along with his patch on top of that.
> >
> > The sunxi one is blocked because it needs to be rebased on top of the
> > fix I did for BLK stuff and then yes you also could have done the
> > "bootstd uses bootmanager" idea that you've both agreed is a step in the
> > right direction. Because it's actually a generic issue with bootmgr +
> > bootstd that only became more evident as more platforms moved
> > towards using it.
>=20
> So can you clearly explain what is blocking sunxi?r

In no particular order:
- Testing.
- Fixing the problems with efi boot manager, which is a global "use
  bootstd more" problem, not sunxi

And maybe:
- Handle FEL correctly. I'd have to re-read everything again to see if
  that was resolved right, or not.

> Does it just need a rebase?

Not just a rebase.

> Which patches should be included and which not?

Once the efi boot manager part is fixed, just the parts required for it?

> Also we
> normally expect patches sent first to have priority.

No we don't. There might be some general advice / rules of thumb but
it's far from some sort of absolute rule. Things are merged when they
work and are correct.

> Here you have
> apparently applied your BLK stuff and then want me to rework on top of
> it?

Yes, I applied the "handle BLK correctly" part that I tried to explain
to you how to fix a few times, and you either didn't understand or
didn't care. I'm leaning more towards "didn't care" now and thought we
should break things a little bit first and fix them later.

> I agreed to the bootmanager work-around but I'm certainly not going to
> write it. I would rather make bootmgr more iterative, if that is
> possible.

Then more bootstd migrations are likely blocked until it can handle efi
boot manager correctly, which you don't want to do.

> > Which is why I had spent so much time trying to get
> > you to migrate more SoCs to bootstd because it's your feature.
>=20
> So take the sunxi patches and then I'll do the next one? On the one
> hand you complain that there are too many balls in the air and on the
> other you stop the balls from landing. It just doesn't 'compute' for
> me, sorry.

Yes, I'm sorry you're having trouble following my requests. Again, I
wanted more bootstd migration not for its own sake, but to expose
problems with the framework and for you to then fix those problems.

> > So yes, I think things would be in a better place if we tried to get
> > *less* big things done at once and didn't pick up another big thing
> > until the last was really done.
>=20
> You should address my point above. Are you trying to limit me to 3-4
> large series a year?

You personally? No. The whole project? Yes, one big feature that's
complete and works every 3 months for a project with limited resources
sounds amazing. U-Boot isn't a toy personal project, it's something used
in production on real devices and needs to move at a sustainable pace
with minimal regressions.

--=20
Tom

--bSy74z/Gl57Lxv7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHHDsACgkQFHw5/5Y0
tyzLXgwArwcMapNIt5ruAaFf79prCgYm3HNfX+dM8xQZsCweg3Qe5vPtLgoqigEO
1uGo9LhO1h6GgdkdzxKFW+cWLVYU9+5OC38oIejUcublResidEHcibf5OQTiU2ag
AH40EuI6xDPMVrLT/0VqpeQ23O2sCVyeGvTizwmb6w6J/h0wh9pWiMEJzROSMVwx
LXzWk3TOdjhH9feXQgmR6WXx6vQb9+c0/3uvCKPO7pTXmKvQwq8gTGG+r5CQOsE1
UVTmmOowgCwZguSjD3tQlb5h+nfOYBMbYkQ2u+PbsXi7bepFf3Kya9nRSAdkdP/0
8QshMkoN905PXCaSjF3CbpJV98OfSIPhjG/q4OQbEPyGsgU0GBibIaxUPSSgPaX+
lEToLuKMbNGzzlqiCxrDcx2ac3oxuUi+fugd26lycinITZdbn1nwJwZFaWziQJKa
nRfd9DCUj/IFGFpCGiimg39uZWqOov95QgB9nYlExJwfPJQ4A4ts890CapDNpFws
MS/fx5GX
=qVRQ
-----END PGP SIGNATURE-----

--bSy74z/Gl57Lxv7q--
