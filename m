Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043CACD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 16:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4D284687;
	Thu, 14 May 2026 18:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="slZDyrdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DA084690; Thu, 14 May 2026 18:14:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D606B8467C
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 18:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 25A1B4012E;
 Thu, 14 May 2026 16:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12300C2BCB3;
 Thu, 14 May 2026 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778775288;
 bh=nQAKwxGURJKwWDi2s7Z/9s67lI+9f9xv3JXpG5Fx/zc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=slZDyrdCwf9OCnVGEMP7jxEUJerSDui4sgnwebUnJvEm8NJS3mdpWukITGXMm1cjp
 kPPG325lmn+p+mCqoBK4sJFh949AxyqwK8kA3EzfTESVCAXdjcUDxkXhHvqisV0h1X
 NtGVlwem2V1IX43MHmah8QJKAMkHoUUFRh+YA7qXyvU2bTG0oSVJfjkpacflwqkqeY
 AhLHTSCMsClJ3/hNB/QwHRebXt62oPrM+uhsri0Zw/iPQXx1ik5vSWR1qQBGMqkb+Q
 kuQ63UR19Jk+sdVZzY1ieW8nVSnWDIhmFSyLtVwaklwlSBx21xrrYenYErb7zRnGzw
 /7jPwbObUpjXw==
Date: Thu, 14 May 2026 17:14:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot patch submit standard and requirement
Message-ID: <20260514-spotted-happier-0ccb77ca8f24@spud>
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l021XDUKB0ZJeF1b"
Content-Disposition: inline
In-Reply-To: <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
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


--l021XDUKB0ZJeF1b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > Hi Brian,
> >
> > You have made a very generic statement about levels of accountability
> > on patch sets and consistency in reviews.
> >
> > Can you be more specific?
> >
> > Ultimately there are subsystem maintainers and each maintainer has
> > variation on how they deal with their subsystem. You reference one doc
> > three times in your statement.
>=20
> Hi Peter,
>=20
> Now I understand what you mean.
> Simply one sentence is a bit hard to read what your thoughts are.
>=20
> That document I am quoting does not refer to the entire docs but only one
> section of the docs with that link.
>=20
> Before quoting, my declarations as follows:
> 1) I am not referring to specific people or party
> 2) I experienced reviewer which again not being specific to one that
> mentioned this docs is a supreme rules to follow otherwise patch
> that is committed is not able to push to mainstream
> 3) I simply do a quick check on u-boot mailing pool and do see a lot
> of uncompiled reviewed patches that are not following that supreme
> docs.
>=20
> As such I will being to quote:
>=20
> The mailing that are reported as not passing the standard of [1]
> Full mailing:
> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-br=
iansune@gmail.com/#3684415

patchwork isn't loading for me, but it's on lore here:
https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.com/

The comment about the changelog format seems to be very harsh, I doubt
it really makes any difference. What you did and what the maintainer
requested are effectively the same thing at the end of the day.

The real problem with your patch is that you put the changelog into the
commit message itself, rather than under the --- line.
None of the examples you quote below do that.

Also, your responses to Simon in the thread you link are very
aggressive and antagonistic. Please try to be kinder to those that take
time to review your submissions.

Cheers,
Conor.

>=20
> Quoting message [A]:
>=20
> - The required format is 'Changes in vN:'. Custom formats such as
>    'Changelog vN -> vN+1:' are not acceptable.
>=20
> Now quoting those examples that don't follow this supreme rule.
>=20
> Example 1: Reviewed without any change requests as [A] complained
> also aginsted [1] supreme standard
> https://patchwork.ozlabs.org/project/uboot/patch/20260508-qcom_spl-v6-1-a=
aac1ab17b50@seznam.cz/
>=20
> Example 2: Reviewed without any change requests as [A] complained
> also aginsted [1] supreme standard
> https://patchwork.ozlabs.org/project/uboot/patch/20260513015606.591384-2-=
rs@ti.com/
>=20
> Example 3: Reviewed without any change requests as [A] complained
> also aginsted [1] supreme standard and even "Accepted Stage"
> https://patchwork.ozlabs.org/project/uboot/patch/BESP194MB2805271AD5DBE47=
B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM/
>=20
> Example 4: Reviewed without any change requests as [A] complained
> also aginsted [1] supreme standard and even "Accepted Stage"
> https://patchwork.ozlabs.org/project/uboot/patch/20260511144437.46645-1-j=
ames.hilliard1@gmail.com/
>=20
> If you want more examples I can keep listing but I think this is more
> than enough.
>=20
> Well in order one t o follow the rules other should do the same.
> Under such bases I have no issue however I cannot see this is
> the real case.
>=20
> Enjoy!
> Brian
>=20
> >
> > Ultimately the rules are there as guidance and if someone chooses not
> > to follow them to the letter there is little that can be done. if the
> > individual becomes problematic they will be asked, publicly or
> > privately depending on the situation, if they could better comply and
> > there may be further action.
> >
> > It's very hard to act on your generic statement without examples,.
> >
> > Peter
> >
> > On Thu, 14 May 2026 at 09:41, Sune Brian <briansune@gmail.com> wrote:
> > >
> > > On Thu, May 14, 2026 at 3:29=E2=80=AFPM Peter Robinson <pbrobinson@gm=
ail.com> wrote:
> > > >
> > > > Hi Brian,
> > > >
> > > > Can you provide more context?
> > >
> > > Hi Peter,
> > >
> > > Not getting you sorry.
> > > Context means?
> > >
> > > Thanks,
> > > Brian
> > >
> > > >
> > > > Peter
> > > >
> > > > On Thu, 14 May 2026 at 03:02, Sune Brian <briansune@gmail.com> wrot=
e:
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > Sorry to bother you.
> > > > >
> > > > > I am curious that for me myself I had no issue to follow
> > > > > the requirements [1] as long as all patches that are
> > > > > passing the review stage do follow the rules in [1].
> > > > > However based on most recent commits and reviews
> > > > > most of those are not even close to what [1] mentioned.
> > > > >
> > > > > So at the end, reviewers in U-Boot just made their own
> > > > > standard and requested contributors to follow?
> > > > >
> > > > > Rather the U-Boot itself should all follow the docs rules?
> > > > >
> > > > > [1] https://docs.u-boot.org/en/latest/develop/sending_patches.htm=
l#sending-updated-patch-versions
> > > > >
> > > > > Thanks,
> > > > > Brian

--l021XDUKB0ZJeF1b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagX09AAKCRB4tDGHoIJi
0vC1AP42Px5zHWwpTZUouhFIl08qSX+OhhjO+jY5q6KZ4UBVEAD/U0/sNISO2FgE
u8dgpeq+FKR4+40nYeI2uMjo2Vovzgo=
=udf8
-----END PGP SIGNATURE-----

--l021XDUKB0ZJeF1b--
