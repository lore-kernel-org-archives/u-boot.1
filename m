Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC49C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F123E87873;
	Mon, 26 Aug 2024 20:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bC234qHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F63841BC; Mon, 26 Aug 2024 20:33:26 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A5088B55
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a501dd544eso283057185a.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724697202; x=1725302002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tD29vJ5zaQQJdWZj/js3YNSkVjUUfPG+Yq46uYeL7hk=;
 b=bC234qHOVOgJCAednyMz3YSpnLnUyr6Ip6hx104XeOQFOx04RWof7rztOhWoeabZtc
 tUQFnBfs1dpphVuniMEQhWJy9j0Ru42RYTJq8LElLajWjceN2oDkc+7YwhpwbXBjxVKp
 dP5bj9JHM8CLYf9y0fH231pvPg3y2FWUUZnA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724697202; x=1725302002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tD29vJ5zaQQJdWZj/js3YNSkVjUUfPG+Yq46uYeL7hk=;
 b=XFj63B4Hv6urRDiDpGCoBJsxAtmo5Ri5OUIP/qfVLkRYVqCVyLoWrna9/Mq3bVOrlN
 6XMRRe01v0Z2iEv5e3oZ6A0EZaxENL15sE0Kc5zyshGTYCbtCqwK5kGEHhAMikG851lg
 JmjU5Sd2sSY4lj7UhuTKywxXEh+B/fdTeC6NlEw4xd5Eiej3WB938Hk+BYZzimm88xjt
 7S8IU/eRDHDhAaPonAXs0wopLFBt950qY5ydaxAOOGFd4EvC2dtIRU1xSmVKCyzGOK9Y
 /EofbMWvo23Zchgam9t/mPyHMf7EpoORXWHuBTb7l2JCwQIOCKnWnzGqy+lOGYSuhpbT
 67Nw==
X-Gm-Message-State: AOJu0YzqEbn5Mm/phlbYZMs8pFhqhtRUzeR6mcPVK0O+zt8Pr3tepf8K
 l3BRRBzwDkbkO50ng/MC58hBklNfdsrntOwYDhr5EUEj4hm3QgsvOn+hyb5UFLi2Zo7gy9zkPrk
 Z
X-Google-Smtp-Source: AGHT+IFZD2rsKlMdvB7Vp9AAx5vYjmNlDQd5AuI9sav608qO74BlNt8/852PL1hryXctrO+yFPnrAg==
X-Received: by 2002:a05:620a:24cf:b0:7a1:c40c:2f7b with SMTP id
 af79cd13be357-7a689715fd7mr1385474485a.30.1724697201804; 
 Mon, 26 Aug 2024 11:33:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f318e1bsm480426585a.27.2024.08.26.11.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:33:21 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:33:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
Message-ID: <20240826183318.GL2479150@bill-the-cat>
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
 <20240823133450.GA1627158@bill-the-cat>
 <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
 <20240823210723.GY1626301@bill-the-cat>
 <CAFLszTirvuCkhb7BTj84Y3oNey34fmi=+V=fFTwb73rV428i=Q@mail.gmail.com>
 <20240823214940.GC2479150@bill-the-cat>
 <CAFLszTh5JTmtm55TrHTpHSjYPzGSyxBVOa8hG=yUVfPg1y3jsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NUM05neTvLMfnqDM"
Content-Disposition: inline
In-Reply-To: <CAFLszTh5JTmtm55TrHTpHSjYPzGSyxBVOa8hG=yUVfPg1y3jsw@mail.gmail.com>
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


--NUM05neTvLMfnqDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 05:30:48PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 Aug 2024 at 15:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 03:44:45PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 23 Aug 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Aug 23, 2024 at 02:30:04PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 23 Aug 2024 at 07:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > The early malloc region is normally quite small and is certai=
nly less
> > > > > > > than 4GB, so use a 32-bit value for the limit and pointer. Up=
date the
> > > > > > > comment for clarity while we are here.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  arch/arm/lib/bdinfo.c             | 2 +-
> > > > > > >  common/board_r.c                  | 2 +-
> > > > > > >  common/malloc_simple.c            | 7 ++++---
> > > > > > >  common/spl/spl.c                  | 4 ++--
> > > > > > >  include/asm-generic/global_data.h | 6 +++---
> > > > > > >  5 files changed, 11 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > This breaks booting on am64x_evm_a53 which is an odd platform t=
hat does
> > > > > > SPL->SPL->U-Boot.
> > > > >
> > > > > OK, I can repeat that on the Beagleplay in my lab. I sent a v3 pa=
tch.
> > > > > Thanks for bisecting.
> > > >
> > > > Oh good, beagleplay is run after the EVM in my loop and so I didn't=
 see
> > > > it was broken there too.
> > > >
> > > > > I'd love to be able to push trees to gitlab and have them run on =
my
> > > > > lab. I think you said that the patches[1] break your lab, so let =
me
> > > > > know if there is anything I can fix.
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D420=
392
> > > >
> > > > Well the good news is that I've got the tests running again here, a=
nd I
> > > > think I mostly understand where the challenges will be in updating =
this
> > > > lab to a newer labgrid version and so being able to migrate it to o=
n top
> > > > of your patches. The challenge next will be time. Likely the next s=
teps
> > > > will be splitting out your serieses in to test fixes and labgrid
> > > > implementation details.
> > >
> > > I just sent v3 of the u-boot-test-hooks series. That needs to be in
> > > for Labgrid to work.
> >
> > Yes, thanks. It reminded me how far apart what you have is from what I
> > have, for labgrid.
>=20
> Oh...is it posted somewhere?

I posted it in response to your other lab grid series at various points.
At this point there's not much too it because it's just one-liners more
or less like:
$ cat console.labgrid
exec $LG_CLIENT -c $LG_ENV console

and so forth (and LG_CLIENT shouldn't be abstracted honestly, it should
just be labgrid-client).

> > > The only other series is [1] which makes the integration nicer, but is
> > > not necessary. That makes sense since we still want the lab to be able
> > > to test older commits.
> > >
> > > From that series patch [2] fixes a problem which breaks pytest runs,
> > > since without it, pytest gets a double echo of a few of the characters
> > > of the first command it sends. It is a pretty annoying problem which
> > > took a while to figure out. I tried very hard to fix it without
> > > patching U-Boot's pytest code, but I gave up. One thought I just had
> > > is that it is possible that setting up the terminal in the
> > > u-boot-test-console script might work most of the time, i.e. before
> > > calling Labgrid.
> >
> > I know with previous iterations of all of the test cleanups and changes
> > you did, my non-labgrid lab also started failing immediately. Keeping in
> > mind that today I run all of the pytests on a few hardware platforms,
> > both with and without labgrid, I need to see what changes you've done
> > lead to what behavior changes here, and then eventually get things
> > boiled down to just the your labgrid implementation specific parts, and
> > see how to work with them, or if it's too far away from the rest of my
> > use case.
>=20
> It might have been that it stopped running conf.xxx files...I fixed that =
in v3.
>=20
> OK, I will wait to hear.

It was I think a lack of the new top-level scripts being present, I
think. We might need to re-work that part of the series to be 3 parts,
where release.none/u-boot-test-release are added in preparation for
adding the labgrid specific one.

--=20
Tom

--NUM05neTvLMfnqDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMym4ACgkQFHw5/5Y0
tywXGAv/RAAmVeN4DoDeQBveOH+rZ/DleMy/RZxT5MUOickd8XrCufRXTDKA/749
YjFeQaDJ4ngctKySgq5g2QyiZsoVkrbaqUqx5Rv835soirT5jJw5uYwpg7UPxRmB
nafHHA3DIceJj5nDD5Rpn8AQ7zfB2797Di5AkDOtzWOwHov1bR6yiccqNsOaqsw9
tVq5d5ql4Rp0sdSLBziE+dyp8X1DmSSDKpzdGqgMUZkOaSEMloawv2YTE1LH1KDb
7ADcmU8oPhdSQkJutEEGY3WYaqVvn7a6cvNT+a++ZzdROO7CpDB5PLKw/KxTGzVG
Cudnziqxh/nPonbn3U4vw3pWnLDYT6Yg3jwM8VL7s4rnBS+LDAX2ZpQ0ToeeIaey
v/uNDSJ2dRD2k1YmOCVnS+7itW4Zp2Or2QKYfh/mXmQDwH7VIXqsXXVHXvwepRTg
2Z9CYlbTVq/6/l+T29STSt1NkWzVdYlzF03/HxWmEw4K1XST/H2VX3s/I1K4gCvW
k2PwDrh0
=VwlQ
-----END PGP SIGNATURE-----

--NUM05neTvLMfnqDM--
