Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EA2EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA796890F8;
	Tue, 10 Sep 2024 20:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XR0vQ8N+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 358E3890FE; Tue, 10 Sep 2024 20:42:49 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6700890F6
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6c3551ce5c9so1133226d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725993766; x=1726598566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wZj73zdvMVntG/yEgdYlN3rLRyXwIprTIAMzaha6Y30=;
 b=XR0vQ8N+c/ANOWBohCB6MW5xS+17lzX8gJ0ck9nkhn6rnDRHdWAD8ji93HMo6s8xdx
 R8TTaX89PKXKi5ijVJBvtcwg5lix/HIzM5t/C/dt6x7VQxsJbLSSCQrDuMuky2UA43QC
 Zte6KO0DGuzrcYxVzih/tNS+eRUw2Ch3ImCfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993766; x=1726598566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZj73zdvMVntG/yEgdYlN3rLRyXwIprTIAMzaha6Y30=;
 b=aq3vDVt+I1xFlnZnJaJs/cWF5BHqwYKagxhrgEY9hzdhahMfGHkwqgxoJgZhTxJZ4o
 zIY8SAnv2uohmqmr8IiAJSlPvKm5LCuTSmxz8q2rf4pOJ9/3QeMkKpIf4/G0ySPpdn1G
 r6trpiY9Nc2M3oULfTaq6s7EGj7tdlksPx+E0tyytax9gAyNKr+FQsqYpzixdM/4jr4+
 Rg7YydrwxZgixxYFxzNurqI9H1OyGy6BYRlMRvySqKX804CEIOYZbM9lQZmcmM6Lj0TO
 L1GZ/z7QlXaAj4wf2FP6f0DiA71Rxi4099zsjkQdMGzxJlTZyz56ZphpMgGseyQxxA/s
 MSfw==
X-Gm-Message-State: AOJu0YyjBmdYEiE5RLUIWl1H7O+YpYxD2JIHc/micV8dxGL2VRhGyDWY
 NaJlHK9XoguZm4+MK895DHi5bbK7iQYFRfreMrqPMTd0/jr5gb3iJLJUry6zI4U=
X-Google-Smtp-Source: AGHT+IHX5k05G8ZbjgKhk3jKghJfzZxKIw1Bs9CgXwTI3qPWVtaA3vRq0RijMW/WQ/7UIsBnV0Zfqg==
X-Received: by 2002:a05:6214:27e4:b0:6c4:2b5a:128b with SMTP id
 6a1803df08f44-6c554d0dea4mr66395186d6.5.1725993765594; 
 Tue, 10 Sep 2024 11:42:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5343294c0sm32640086d6.10.2024.09.10.11.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 11:42:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:42:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240910184242.GL4252@bill-the-cat>
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
 <20240902153904.GX2479150@bill-the-cat>
 <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nTHCBU0ju2tYVwX7"
Content-Disposition: inline
In-Reply-To: <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
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


--nTHCBU0ju2tYVwX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:41:11PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Sept 2024 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > For most boards, the device-tree compiler is built in-tree,=
 ignoring the
> > > > > > > > system version. Add a special option to skip this build. Th=
is can be
> > > > > > > > useful when the system dtc is up-to-date, as it speeds up t=
he build.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  tools/buildman/builder.py       | 27 +++++++++++++++++++++=
+++++-
> > > > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++=
++++++++++
> > > > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > We should probably do this more generically, outside of build=
man. We
> > > > > > > have scripts/dtc-version.sh and if the system version isn't n=
ew enough
> > > > > > > (and we just need to define whatever the minimum version is),=
 then we
> > > > > > > build our (not currently that new anymore) dtc instead.
> > > > > >
> > > > > > Yes I think I did a patch for that ages ago [1], but it was rej=
ected.
> > > > > >
> > > > > > I'd be very happy for it to be applied as I think it is a better
> > > > > > solution than this one.
> > > > > >
> > > > > > I see that some poor sod tried to do this in Linux this morning.
> > > > >
> > > > > Any thoughts on that patch?
> > > >
> > > > I'm open to re-considering [1] again, but we need to handle the war=
ning
> > > > problem first. That means...
> > > >
> > > > > Also I do see one problem. Newer dtc version produce a lot of
> > > > > warnings, which causes CI to fail. So if we always use the newest
> > > > > version, people are going to see a ton of warnings when they run
> > > > > locally. Am I missing something here?
> > > >
> > > > Well, it would be great to get our Kbuild logic anywhere close to
> > > > in-sync again with upstream. But syncing up the disabling warning f=
lags
> > > > shouldn't be too hard.
> > >
> > > So, coming back to this patch, the nice thing about it is that it is
> > > deterministic. So people who build U-Boot and don't want funky
> > > behaviour will be happy. It will use the internal dtc by default. To
> > > use the external one, you must provide an option.
> > >
> > > This patch only affects buildman, but as you can see the mechanism it
> > > uses is to set the DTC variable, which people can do without buildman.
> > > It's just a convenience, but useful enough to have a flag, I believe.
> >
> > Wait, that's right, we have DTC as a thing that can be set in the
> > environment, so why do we need something for buildman at all?
>=20
> It's a convenience. I have found that it speeds things up quite a bit,
> so I want to enable it most of the time. But we can't do it by default
> and need it to be optional, I believe.

I wasn't clear, sorry. Why is:
$ export DTC=3D/usr/local/bin/dtc
$ tools/buildman/buildman ...

Enough?

--=20
Tom

--nTHCBU0ju2tYVwX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbgkx4ACgkQFHw5/5Y0
tyz7aAv+KE30CyFoZo1rCROsaT+pOMCnNKEPJoTZPtUMC6n9JvjWFmdEJpMdbOGW
UXGK/XxutiugWLLNw1fXIf+X6BUjcoIF0aZTuPUA9EDNIBnT84BPoKcsPBXUH+KR
f4+kcSuM6Nd+LmrFRKduw2eGhprDqn4jtWbdx6fMhQ57WYOUUxdij4OgrLcfOzhs
eBzhRtft+LCkRSo2MTWaei6hniLVyzED69e29Z8pi68oWiTI7EzVqKSY/0Y08RP2
I9yHCHyNR+Le19Rcmtw+M/bvS1cbV8ZFkj9gdH24LF7S2Z5Sa4uSQdHJ3bURZ+Pu
YPzlRn9YDHbTnhCDFNPUetyxR0JPgFnDmaSQiJxCoPK8LmlVAjyre71XvoU0CQb+
Rv4VlLEqeZHXh1jZHJY/Hh/FLDh1eP/4GYQEUAZqJ9wi1FUn56m7ToC3WjfjSn3d
HVNjTfLlzsrLpf8U7iplk6NQ49PYsZTAPiFQdOaXRJPN2AcwtR5mfSV3VSJv+fhl
yV52TMrg
=O9cQ
-----END PGP SIGNATURE-----

--nTHCBU0ju2tYVwX7--
