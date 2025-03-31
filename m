Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA62C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 15:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2B281E5B;
	Mon, 31 Mar 2025 17:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l2FTlavB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E13481026; Mon, 31 Mar 2025 17:51:52 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16338129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6021e3daeabso2154481eaf.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743436307; x=1744041107; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DkzOyQrPKFsNbYZvfGyp4x2Kz8JkbcyFaSTd+vP4AFE=;
 b=l2FTlavBOyZ8IFnkr7X+WRoYSpeH80BUE+wiAEbeK/vdwwmFUMPUrMIdTkRx3Xvzmz
 SPjMDf6roCqvzMaioHlvwocihsalT8lkfmEl4B+eyL0PcRhfDxNaA+PaifVg5cp5vdzj
 Oqia7pRGypxrWzW+aBrK1mhXiVRXs1jhDdX4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436307; x=1744041107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkzOyQrPKFsNbYZvfGyp4x2Kz8JkbcyFaSTd+vP4AFE=;
 b=MPtxHqWQled4CsBOwOXlaz0FrSappVG0h0a2l9HaC8DH5xJP8TdAwZrorZbWEWrJXe
 3PiIDwG/7pZ2swydJ+dudVfDBuMAzejWN7O6rYKi07aCQlHysrGIKj5pYvTySg2CvRq6
 M1c+to/4hPAOm6Eqvv8V5AV9+yikK4t0XdJtgFhQrsVr7oqKw4EcmWnDF0Kl3sDM+VTp
 njRaoTRei/y1o+3NA7bE99YtF+vCNBx/79wTaCrEBmcB4CsPrUlv0M/Ke5iUr4P+dCKr
 Eq9JRQ+ABGrP2Lst8mDGkNw8pYF7HxALWPNcoqKTo5Qo8WT603iglHkzSxOcUfPht0yy
 A0nw==
X-Gm-Message-State: AOJu0YztXc8UNncXjXxNzy5A7mkep1eUrO4g+bhJxE9GRqHqxEyR8oAL
 wuk+7I5a9zNaxCQibpABXsjXtFWnaKOuo9ZqqMY849OM2JfkRtj182pBNcA8c70=
X-Gm-Gg: ASbGncuCHRq/nBk/DjIkQVWXt98IRebI9onTtEVcW461TsCMqCHg0CQsnsM7zLJUbdc
 W8jKgqZ6kzYwRRd2BKkyBmk9Ql1dnx5XQP4tOYdHlhx5oZaILhGolG/QeVUUsTsqAjynkkFeLel
 UwqeIiVKx+wcYLsMDOBK2hNb4DO35/S4sFtM8PmgBEMmP1gDZqEWo2zT5UHnn5FjO0jUPgq52wG
 CrjU9FnE7T9lZmJopa5DZtFLjtvdQh5iResCAjbVf6bM6b2BUZ6v4ZhiBMxfQI09SDbD8DWSW5e
 KE7cfu5wULCm+YLWcg0k7a7EAdN2ftZZ3h1MpWwN4lXasQJmC5FLBbgtbU60B3OJUNO7aeRpFFT
 6nZZIwQ==
X-Google-Smtp-Source: AGHT+IFL8dIobwZjirRxSa2PlrgXmhlNLN65vU7j6PoBxRLOa3IcmCBYKrFdEGjbpeRBbSgDYWeGBw==
X-Received: by 2002:a05:6820:206:b0:601:adbf:1f06 with SMTP id
 006d021491bc7-60290ff7268mr5522564eaf.8.1743436307212; 
 Mon, 31 Mar 2025 08:51:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602844e6574sm1497753eaf.2.2025.03.31.08.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:51:46 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:51:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250331155144.GX93000@bill-the-cat>
References: <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ulT1LkG1xUF+KuJh"
Content-Disposition: inline
In-Reply-To: <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
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


--ulT1LkG1xUF+KuJh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> > [snip]
> > > > Again, back to this thread, if you want me to migrate things, consi=
der
> > > > applying the sunxi patches as I have described above. I will then l=
ook
> > > > at the next target for bootstd. But while you hold this up, I cannot
> > > > move forward with more bootstd migration. It doesn't seem that much=
 to
> > > > ask.
> > >
> > > I will take another look at what's still relevant. But I believe it's
> > > still blocked on the fact that it changes behavior and breaks users.
> >
> > In details:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-2-sjg@chromium.org/
> >
> > Now that the underlying BLK problem is resolved, this can just be
> > dropped I believe. Removing the BLK dependency from BOOTSTD can happen
> > when you're supporting a flow that lacks a BLK device entirely. This
> > would be another reminder as to why putting unrelated changes in a
> > series is a problem.
>=20
> OK, then just don't apply this patch. Problem solved?

Well, for a hypothetical v6 you would not include it, sure.

> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-3-sjg@chromium.org/
> >
> > This is fine.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-4-sjg@chromium.org/
> >
> > This is not fine. This is also not a sunxi problem. It means that we
> > should drop bootmgr from rockchip, where the conversion has already
> > taken place, and would need to drop it from future conversion too.
> > Neither of which are desirable changes.
>=20
> Why do you say that? I don't understand how this relates to rockchip
> or why we would need to drop bootmgr from that.

Then you don't have enough of a grasp of the details of the area you're
trying to solve problems in? Or maybe you need to refresh yourself on
the details of the area you're trying to work in.

> > This patch in particular is
> > where we have the note:
> >
> > "Yes, the introduction of boot standard changed the boot order and
> > specifically deprioritizing scripts is unexpected."
> >
> > Which should have had more attention than it did.
>=20
> From memory the scripts are a fallback used when the other things
> don't work, so that was the decision I made at the time.

The key point being we changed behavior that others depended on, and
didn't document it well and didn't make sure the change would work for
them either.

> > This is the thread that to me spelled out in details where the
> > conversions are now blocked. We changed behavior and that in turn breaks
> > users that have come to rely on ordering.
>=20
> I don't know what action to take on that comment. We cannot have 100%
> backwards compatibility with the scripts, which after all weren't even
> documented. But it is very close.

You need to get feedback from the people you want to migrate from the
scripts and ordering and rely on to something else and see what works
for them.

> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-5-sjg@chromium.org/
> >
> > Is an alternative to the above which then turned in to a discussion that
> > I would very briefly summarize as "no discussions were had between
> > stakeholders before integrating efi bootmgr with bootstd".
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-6-sjg@chromium.org/
> >
> > This is fine, but only relevant once migration happens.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-7-sjg@chromium.org/
> >
> > If Andre is fine with this, this is fine.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-8-sjg@chromium.org/
> >
> > This is a generic bugfix. I will take this to next today.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931=
-9-sjg@chromium.org/
> >
> > If Andre is fine with this, this is fine.
>=20
> Well, is he? I thought he was. Can you check?

You're free to. It's one of the innumerable examples of why when you
group multiple things in a series and there's problems with another part
of the series, unrelated changes get dropped.

--=20
Tom

--ulT1LkG1xUF+KuJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfquggACgkQFHw5/5Y0
tyyMlAv+MDbu7DSMNwVBQnJx1RfIc/UeqK0UaKiBP2x1CuYBw5ehj3CYjklluTWT
+pNBo/nDt6r1IADJ1ksEnYe26BgUxEGE9a2ZBnzY0K0cp6A4O6ZLfg6jPMFTf3AD
nhcRkyEprpxVkuyanTyZ4f6A++pPy+SwVbrvgk+EhHr9r2qCBLbKfSKL9iCycbPI
nhJrdpBnBMECop4KOxdBPKPZw16DR1Ke0L6LPrXyAGwEVCJR+3LqwNrxSyCTG/y1
0m594G6Gz6KwxWX0Kn3ZA+azil7H7mQy2djYbkbCwP/++eOqMbXCG3fY5eCRSHul
GDGhf+aWFDsvhXQ6HH9qCjyY9unXxVNboRHxMsA+/o/7ZH7sWOTbNMglylltSD4g
Hs1dI5SC+1JtOh8IxX0EaAmQuIfs11KUNbQMMnXZU1JhRvwf6WR5bI1rGSQ7uA15
VYqleNhmynVZ6t/P+HYjHzK4Sjl5DDkQHtftuaMmpQri+JfCYMvz5Rd+TLQgGV1k
vr+lNsfT
=nUBu
-----END PGP SIGNATURE-----

--ulT1LkG1xUF+KuJh--
