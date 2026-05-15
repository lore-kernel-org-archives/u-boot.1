Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F36ECD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 07:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A02183AA9;
	Fri, 15 May 2026 09:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="SEwnoGuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5049483E81; Fri, 15 May 2026 09:46:05 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133CD838BB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 09:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=58830cfc4=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1778831162; x=1810367162;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n6iYPgh/z2M54uFo6j8nefngiY+6bjWjDKAzm1g256A=;
 b=SEwnoGuJjuxqNtVloxBu5FV76erhl6ei3bRpo+7y3dO3AqlSJnUdweIg
 v+PgaZ5sRN9hLXbZ59BDTPhoCctOHgX3yAa9sUB0l7vfRLRu6B9AZowrE
 jWUbDBe9652Q+Jrghea35ftpWA9sFVDWhDv24AR+hd2t36ZtNyZ10Y7e6
 OjEPUkoGfZgl5Bv60MTt1H/1csvSWthKYR6xB/mx6e6vxIKfLCdEiTeD1
 Jqs659KlXYrwSFVDyexqGVwIzNAVcHsw0kvG2d4NemShS3bL+koUAdL6A
 dfAe64WeerpHBM4xAoWfJmxYmMjycB8B8Wb/GntpIZBWTl0ZsX9VKWfJS w==;
X-CSE-ConnectionGUID: sRQAuv+YSKGRSuxpYkiZRQ==
X-CSE-MsgGUID: y7+eNPqeSZKfAW+pL4NPcQ==
X-IronPort-AV: E=Sophos;i="6.23,236,1770620400"; 
 d="asc'?scan'208";a="56783753"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 00:45:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 15 May 2026 00:45:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 15 May 2026 00:45:58 -0700
Date: Fri, 15 May 2026 08:45:20 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Sune Brian <briansune@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot patch submit standard and requirement
Message-ID: <20260515-finished-womanly-675afb9b0c7c@wendy>
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
 <20260514-spotted-happier-0ccb77ca8f24@spud>
 <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rzzp92lWB59/EOhI"
Content-Disposition: inline
In-Reply-To: <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
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

--rzzp92lWB59/EOhI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
> On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> > > On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinson@gm=
ail.com> wrote:
> > > >
> > > > Hi Brian,
> > > >
> > > > You have made a very generic statement about levels of accountabili=
ty
> > > > on patch sets and consistency in reviews.
> > > >
> > > > Can you be more specific?
> > > >
> > > > Ultimately there are subsystem maintainers and each maintainer has
> > > > variation on how they deal with their subsystem. You reference one =
doc
> > > > three times in your statement.
> > >
> > > Hi Peter,
> > >
> > > Now I understand what you mean.
> > > Simply one sentence is a bit hard to read what your thoughts are.
> > >
> > > That document I am quoting does not refer to the entire docs but only=
 one
> > > section of the docs with that link.
> > >
> > > Before quoting, my declarations as follows:
> > > 1) I am not referring to specific people or party
> > > 2) I experienced reviewer which again not being specific to one that
> > > mentioned this docs is a supreme rules to follow otherwise patch
> > > that is committed is not able to push to mainstream
> > > 3) I simply do a quick check on u-boot mailing pool and do see a lot
> > > of uncompiled reviewed patches that are not following that supreme
> > > docs.
> > >
> > > As such I will being to quote:
> > >
> > > The mailing that are reported as not passing the standard of [1]
> > > Full mailing:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-=
1-briansune@gmail.com/#3684415
> >
> > patchwork isn't loading for me, but it's on lore here:
> > https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.com/
> >
>=20
> Hi Dooley,
>=20
> Well I am sure you did not have the full picture.
>=20
> The request had nothing to do with under the --- line if this is
> really the case:

> Let me bring you back to the history of wonders:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-b=
riansune@gmail.com/#3680232
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.5398-1-br=
iansune@gmail.com/
>=20
> None of those reviewers had mentioned this issue once "---" rather they a=
ll
> just alarmingly repeated the wordings.

The first mail in the thread mentions it:
https://lore.kernel.org/all/CAFLszThg=3DEamyRohxNA7V+nk+OMVK356nUjAVSbu4+ko=
kOJpdA@mail.gmail.com/

>=20
> > The comment about the changelog format seems to be very harsh, I doubt
> > it really makes any difference. What you did and what the maintainer
> > requested are effectively the same thing at the end of the day.
> >
>=20
> Of course after reading the docs I got it immediately.
> However did those who request contributors quote this from first place?
>=20
> > The real problem with your patch is that you put the changelog into the
> > commit message itself, rather than under the --- line.
> > None of the examples you quote below do that.
> >
>=20
> Well after 4 patches of ridiculous request and logic change.
> I guess you will do the same. At least I am not doing it at the
> first moment on replying to the mails who or whom you had mentioned.

I think this is a reply to the comment below?
The aggressive/antagonistic responses begin in your first reply to
Simon:
https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhd=
mY3Q@mail.gmail.com/
"So forgive me I really don't give a damn on whatever the header
requirements." "There are many better things to do rather than complaining
about the patch headers."

> > Also, your responses to Simon in the thread you link are very
> > aggressive and antagonistic. Please try to be kinder to those that take
> > time to review your submissions.
> >

--rzzp92lWB59/EOhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagbPEAAKCRB4tDGHoIJi
0laFAP948kiwjQzoB/AqwpsfL65REZCfKHBAoobErQvEZJyIUAD/biDK0CsZw2tE
QsjTrdWatEHSz54mhZM6PH3CqDjMUQU=
=30ci
-----END PGP SIGNATURE-----

--rzzp92lWB59/EOhI--
