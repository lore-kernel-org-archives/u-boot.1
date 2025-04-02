Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F6AC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 22:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D5381F69;
	Thu,  3 Apr 2025 00:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MHwjBSrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071B981DE3; Thu,  3 Apr 2025 00:35:43 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 843BD810E8
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 00:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso103906b6e.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743633338; x=1744238138; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IaRkdSuILcWilUfQxI7feOcvKeZOtv2ioDISdkRBhyQ=;
 b=MHwjBSrZRprQ+JeK+eS1ULIBzY8JOl4XfvlqDFC8tgIEjwLW/C029+71A5suz0UaKq
 8GDWYcumQz0k5vdE70wj2AlkQoHoYOURbVPHGZTMr4ShJ4cO4qtQ8PkJDvFXnwG1dbJs
 T366E22uJ+o25HnkU9syM/Go6qfxPqdbtD050=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743633338; x=1744238138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaRkdSuILcWilUfQxI7feOcvKeZOtv2ioDISdkRBhyQ=;
 b=HqwmkxqyqOg0hEkJ55I176FNdQoJEBZ28UBQUwIIT3RgGGKhYmvxd2IyAAKOHVlWB9
 t1smRGzSZf/j4MQW5mfRHF1Pzfv6HrI0Xq2sWBA34UYOwcEF+GfhIjQw5B7B8Mit+NEy
 Jw/0IR0inBacaCSNlImWvrV/kN7bd8oGmBlbzg0s/GnRRMXJ7hhcP5UxtvUyVGrVSeGm
 Qb+vJr58BFjLvzWjhONWAF5UtDN5YEsWaY0oL6uqYdchr3J8Er4pRjRSoZ7909YxmlDl
 xpP9SvmtdM1A61AawRXDRQrT6vx197cwe4gpwzKSnMKjuuhJIE64Gd4zZ6BnssNAjfIU
 vijg==
X-Gm-Message-State: AOJu0YzSrTx7lS3yZejdPzYerC48BZ32IbiaUtwV0onhjO5loFoaFjto
 66/2dGn5cgvCLV7Kavom8iAdNUpKJC7K/ZrWHGrg5/I2XsO3kkpMQKLD4Mug+ls=
X-Gm-Gg: ASbGncswTGLgq9Rh50JDYU6fj7OfsPVPAa2LJUVBq/+byhuO6POaXxpGkYmTvg4qYoE
 7hQl9HItWnhKROXDXJhNAEsG2EHsQeS9mOSbFhT3e8FV5xFAsZI11VIRI+9L2qqx2xdTUTnx2fe
 47Cj8tzsk0LwyGzseu8OlpAJhIfUj6EEe9V5sl34k1qF8Ef3EHl3lQRy48BDi1yV8XFMRFGcLzz
 I6K2EufuQIGcOEKi7Ztg8bQ+3naBMxxMFlOWmJkIR5ljOpAdyZ5hjW0kEcBn+XIUgYLxugMswK9
 I9T60CllH4h8RjN9TvZMTxpU0ZxpFOmf4qF3Yrw8/yzxwkpO5tpqFg0JUD5GxvlKySbmBorXCUk
 Mrb7PbwH01BQj6NYZ
X-Google-Smtp-Source: AGHT+IEXVXSIHab5lxF8CzNYkm3otpjifIjRJtTieG9mEHofpfx/KrWXQl3JpBQ+KFD5T9RLionb9A==
X-Received: by 2002:a05:6808:1b98:b0:3f4:21af:6d45 with SMTP id
 5614622812f47-400361c4078mr2290218b6e.12.1743633338041; 
 Wed, 02 Apr 2025 15:35:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05167736sm2574863b6e.10.2025.04.02.15.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 15:35:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:35:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250402223534.GE5495@bill-the-cat>
References: <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
 <20250401171822.GM5495@bill-the-cat>
 <CAFLszTjzxXW_SdDMbjPKitgQ6HSv3Vse6ANrr5QEr85A1byyHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+H8Yuz7kWoCjIdvf"
Content-Disposition: inline
In-Reply-To: <CAFLszTjzxXW_SdDMbjPKitgQ6HSv3Vse6ANrr5QEr85A1byyHg@mail.gmail.com>
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


--+H8Yuz7kWoCjIdvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 08:22:13AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 2 Apr 2025 at 06:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> > > > > > [snip]
> > > > > > > > Again, back to this thread, if you want me to migrate thing=
s, consider
> > > > > > > > applying the sunxi patches as I have described above. I wil=
l then look
> > > > > > > > at the next target for bootstd. But while you hold this up,=
 I cannot
> > > > > > > > move forward with more bootstd migration. It doesn't seem t=
hat much to
> > > > > > > > ask.
> > > > > > >
> > > > > > > I will take another look at what's still relevant. But I beli=
eve it's
> > > > > > > still blocked on the fact that it changes behavior and breaks=
 users.
> > > > > >
> > > > > > In details:
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-2-sjg@chromium.org/
> > > > > >
> > > > > > Now that the underlying BLK problem is resolved, this can just =
be
> > > > > > dropped I believe. Removing the BLK dependency from BOOTSTD can=
 happen
> > > > > > when you're supporting a flow that lacks a BLK device entirely.=
 This
> > > > > > would be another reminder as to why putting unrelated changes i=
n a
> > > > > > series is a problem.
> > > > >
> > > > > OK, then just don't apply this patch. Problem solved?
> > > >
> > > > Well, for a hypothetical v6 you would not include it, sure.
> > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-3-sjg@chromium.org/
> > > > > >
> > > > > > This is fine.
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-4-sjg@chromium.org/
> > > > > >
> > > > > > This is not fine. This is also not a sunxi problem. It means th=
at we
> > > > > > should drop bootmgr from rockchip, where the conversion has alr=
eady
> > > > > > taken place, and would need to drop it from future conversion t=
oo.
> > > > > > Neither of which are desirable changes.
> > > > >
> > > > > Why do you say that? I don't understand how this relates to rockc=
hip
> > > > > or why we would need to drop bootmgr from that.
> > > >
> > > > Then you don't have enough of a grasp of the details of the area yo=
u're
> > > > trying to solve problems in? Or maybe you need to refresh yourself =
on
> > > > the details of the area you're trying to work in.
> > >
> > > Or perhaps there isn't a problem? The sunxi case is special because we
> > > have a FEL boothmeth. That isn't present on rockchip, for example.
> >
> > Again, you seem to have forgotten what the problems with the series
> > were.
>=20
> No, it's just that we disagree on the path forward.

Then why did you bring up FEL? That's the part of the migration which is
NOT a problem, I keep being reminded when I ask.

> > > > > > This patch in particular is
> > > > > > where we have the note:
> > > > > >
> > > > > > "Yes, the introduction of boot standard changed the boot order =
and
> > > > > > specifically deprioritizing scripts is unexpected."
> > > > > >
> > > > > > Which should have had more attention than it did.
> > > > >
> > > > > From memory the scripts are a fallback used when the other things
> > > > > don't work, so that was the decision I made at the time.
> > > >
> > > > The key point being we changed behavior that others depended on, and
> > > > didn't document it well and didn't make sure the change would work =
for
> > > > them either.
> > > >
> > > > > > This is the thread that to me spelled out in details where the
> > > > > > conversions are now blocked. We changed behavior and that in tu=
rn breaks
> > > > > > users that have come to rely on ordering.
> > > > >
> > > > > I don't know what action to take on that comment. We cannot have =
100%
> > > > > backwards compatibility with the scripts, which after all weren't=
 even
> > > > > documented. But it is very close.
> > > >
> > > > You need to get feedback from the people you want to migrate from t=
he
> > > > scripts and ordering and rely on to something else and see what wor=
ks
> > > > for them.
> > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-5-sjg@chromium.org/
> > > > > >
> > > > > > Is an alternative to the above which then turned in to a discus=
sion that
> > > > > > I would very briefly summarize as "no discussions were had betw=
een
> > > > > > stakeholders before integrating efi bootmgr with bootstd".
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-6-sjg@chromium.org/
> > > > > >
> > > > > > This is fine, but only relevant once migration happens.
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-7-sjg@chromium.org/
> > > > > >
> > > > > > If Andre is fine with this, this is fine.
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-8-sjg@chromium.org/
> > > > > >
> > > > > > This is a generic bugfix. I will take this to next today.
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938=
=2E1534931-9-sjg@chromium.org/
> > > > > >
> > > > > > If Andre is fine with this, this is fine.
> > > > >
> > > > > Well, is he? I thought he was. Can you check?
> > > >
> > > > You're free to. It's one of the innumerable examples of why when you
> > > > group multiple things in a series and there's problems with another=
 part
> > > > of the series, unrelated changes get dropped.
> > >
> > > It would be easier for me if you could apply the patches as I've sugg=
ested.
> > >
> > > But if you are willing to apply these patches and just want me to send
> > > the series again without the BLK and RFC patches, I can do that.
> > > Please let me know either way.
> >
> > Again, you should:
> > - Take the non-bootstd sunxi enhancements, rebase them to next and post
> >   for Andre. By themselves. This way they won't get stuck.
>=20
> There's no point, though, since it doesn't provide the bootstd migration.

Are you saying there's no point in generally improving things if it
doesn't also involve one of your particular projects?

> > - You should work with Heinrich to come up with something that handles
> >   efi bootmanager and bootstd without breaking how our actual project
> >   users use us.
> >   There's no reason to migrate *more* platforms until we have this
> >   fundamental problem sorted out.
>=20
> It isn't actually a fundamental problem at all. We shouldn't even be
> discussing this and it is really unfortunate that you continue to
> block this effort.
>=20
> As to bootmgr, I would be willing to implement a solution here, but it
> would involve changes to how bootmgr works under the hood, i.e. to
> have it be iterative instead of doing everything at the start. My firm
> understanding is that such changes would not be acceptable to
> Ilias/Heinrich and anyway I am unable to get patches into the EFI
> subsystem.
>=20
> So the fallback is the work-around which Heinrich proposed. He is free
> to implement that if he likes, but I am not planning to do this myself
> as I see it as a short-term measure and it may cause problems for
> bootstd, as did f2bfa0cb1 which I bitterly regret allowing in (but I
> suppose they were happier days before everything froze up).
>=20
> > - You should work with any FOSS distributions to get their feedback on
> >   what would make their life easier, from a user of U-Boot perspective.
> >   bootstd won't be useful if it's not something our users want to use.
>=20
> Bootstd is designed to replace the distro scripts and the feedback I
> have received is that it is good at that. If you have any other
> feedback, or any suggestions on people I should contact, I'm happy to
> approach them, or they can email the list and cc me.
>=20
> But really, it would be a lot easier if you could just apply this
> series so we can move on. If I can see even just a glimmer of
> compromise here it will help my confidence.

Your sunxi series is broken as posted. I am not interested in applying
or encouraging more bootstd usage until there's actual work being done
to move forward wit bootstd (a thing you want) and EFI (a thing most
distributions want). That would be some of the general feedback you've
been given and missed or forgotten.

This is even setting aside that I can't recall now if you ever started
on making non-BOOTSTD_FULL more useful / usable in general because it's
so minimal that every conversion ends up also enabling BOOTSTD_FULL in
order to be flexible enough for users to decide SD vs eMMC and so on.

--=20
Tom

--+H8Yuz7kWoCjIdvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftu64ACgkQFHw5/5Y0
tyw2PQv/exYZmuNB/le5pxZcyANLXRqFD3zbKbXWt4RoovlV0JHeZsnS1FFjZ4gJ
IVzxOhVv/Hn2TmMw8hTKgSibTBsrawEddtFMHWMK43r9P2XJUlR56xAM/xKul03G
tOi2ifbeN/AOArtBQovZlnpzf+QAnMg4xAd36EGmaBbPCbKDgHcYxHDt16N/23Xn
mK+puXBJnaYzL9og3ZVrnj7/M4dXQb0oZ1drcs+0IS4CXjfTK+AsznEBrRabaLJ1
XWiwEsUzGpLUSMAFBmr81yix2uqAe2PI4uupU7AM0DGSYNQddoYqXbcKZr689tJa
s7P7ymp9dFwqWuFEgqRYITt51mdaJFYbesd8LFVGAX4fy1Rh71uRmKzf8YReKiQO
pfJpwBOb+DahgmUXJgCIA3vdLnOG7aSsccG3thSpyoCoyAlEFGhaxXNdJv4srP5f
wgcYWjhCBzSWiT8UCc+5l2xngCN8DMoGqT7fVRE/No4zWghCjKdNoJrPko5HYeEl
1Lh13N/g
=dpvj
-----END PGP SIGNATURE-----

--+H8Yuz7kWoCjIdvf--
