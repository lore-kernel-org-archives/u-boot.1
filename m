Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F15CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 13:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9226984857;
	Tue,  2 Jun 2026 15:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AUrKKVT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2124E8485F; Tue,  2 Jun 2026 15:25:58 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC1684855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 15:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6dcc22cbcso277907a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780406754; x=1781011554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g2rmCzOyFy+OS9kjlbtnpDnbFs+23UJ4Tj27ui+eDXk=;
 b=AUrKKVT37cACk81yUNAat9k7mqOkZfn+3rTBjmt9t1oPfvBImPQ7EXK/E9X9udajzF
 k6A6RpIvju73pXrpkO42rT0Lgku8pLXyRvWkn22MIXU9Xctob6c+aNqZ1aUUYbsW8RqN
 jtN2fYWchPRPs34koZLGqKLCxcBQVT02aqtwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780406754; x=1781011554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2rmCzOyFy+OS9kjlbtnpDnbFs+23UJ4Tj27ui+eDXk=;
 b=ESNuUGgPm5y+V+fnShQPPcJUWdwUGppP/5BWEIg1Y49xNR2fplaWAvnmEoYomyHH+e
 bT+dN195oiOe2uaUogCDdeKLvJ69h/MPtXJSIXeA0plaC4aPo0HHpJGmRh6wavuTlYUG
 8kA4OYi0RWslmpePFeqloFWqtkMCQLPlDFnTPxal7XZ9jB6rRPN+KzChgZmnZZwlSat0
 aPX6XaLCU8JDM8JK13ArGhcuFRCYgUlk4e6YrnZpK0RIbbhsH5YWZzSwas36bFjqBK+H
 ZirTHKJnPQup3FWU8OGKrMvoqaMGZh+9FBgYYh5OvarezrW1v+mL56dE2cQTGR1aoxB7
 MSog==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MeaUBz40iT7u3q7fOgjXXVvM4BCwR2vduJOzBCjS8ZvTX0rTdlHRnOWiU8V8uysRs/uJWyRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzrFUzbwuv9zYCQiNi75oM1Clf9eJbij6OVw4JTha0GpeT+uV1L
 wt//w3Kbe2zwVNtEKDEWH0GUI3Z2UCfB+6F+4N6A6vpmKTLChllQfSuSumh/240EUFg=
X-Gm-Gg: Acq92OEJ+nCYfv2uh7U52hy8Qg2qklfmOJeP4/VxBs2wVWmMeEv3vVnh7F1PHY2Pmvn
 dKO0LSKWr73vvUP2t7L7NYXOYSKedv7cBk99Bpju19hqB+7w+/H7O1kft1blDRrC2d8y9q5quOJ
 f6E6hf0JFkw4yxiLxDb0IhBdD5iGxBbz821rlbmiddTX/A8PnLtVIyCbNZOs9wpCQo25qu/ySvd
 0aoBvsBS7CP+VWNUBKHTVzkO+B/xqHeLMXn6Dr4quoBb8RWIuzrSDYhNiVKlZ9ZfNdFuFgw5OXY
 YW9YxB8/3lD0MNCmM7ON+iNpAoaKa4YYrUQPEciS2tZ3RjNxnK2zKHI0axbfqd7TyPYNd5MdRdU
 wdhas5A9cEicj/jnOgBZwxIexaPPyhIerc5zXY7oi79BalVpbYpfXNzonQuxrdSFORhhM53dfhZ
 0aFNK55qdXGXsrU+bcAKTN8accHM0sTDJSMReSKIAcOP50NDHvcPqVYgAMR5QWOiPKfaK+/OONu
 NbkoQBVn62MUfVgtMnWSVpfa8Iw8s/ZE0DKJrrK+BrWAnHOsU1rzqaTjuFzeg==
X-Received: by 2002:a4a:ddce:0:b0:69e:31c6:2e9a with SMTP id
 006d021491bc7-69e31c63a44mr2340997eaf.45.1780406754377; 
 Tue, 02 Jun 2026 06:25:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e067de2b8sm8415438eaf.4.2026.06.02.06.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 06:25:53 -0700 (PDT)
Date: Tue, 2 Jun 2026 07:25:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fdt: fix condition for devicetree from bloblist
Message-ID: <20260602132551.GL627328@bill-the-cat>
References: <20260601082632.238595-1-alexander.stein@ew.tq-group.com>
 <20260601161513.GK627328@bill-the-cat>
 <13995287.O9o76ZdvQC@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dVU3Tir5yNMfKzWi"
Content-Disposition: inline
In-Reply-To: <13995287.O9o76ZdvQC@steina-w>
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


--dVU3Tir5yNMfKzWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 08:36:20AM +0200, Alexander Stein wrote:
> Hi Tom,
>=20
> Am Montag, 1. Juni 2026, 18:15:13 CEST schrieb Tom Rini:
> > On Mon, Jun 01, 2026 at 10:26:30AM +0200, Alexander Stein wrote:
> >=20
> > > On boards without TPL, but SPL enabled, xpl_prev_phase() will return =
never
> > > return PHASE_TPL. This the condition is always true. This is a problem
> > > for system which use an SDRAM bloblist location and initialize the SD=
RAM
> > > in SPL. Adjust the condition to take this config into account.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > There is also another possibility for the check. I'm not sure which o=
ne
> > > is better or preferred.
> > >=20
> > > --- a/lib/fdtdec.c
> > > +++ b/lib/fdtdec.c
> > > @@ -1829,7 +1829,7 @@ int fdtdec_setup(void)
> > >          * not whether this phase creates one.
> > >          */
> > >         if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > -           (xpl_prev_phase() !=3D PHASE_TPL ||
> > > +           (xpl_prev_phase() !=3D PHASE_TPL &&
> > >              IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > >                 ret =3D bloblist_maybe_init();
> > >                 if (!ret) {
> > >=20
> > >  lib/fdtdec.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > index c67b6e8c133..3f31f9c2aeb 100644
> > > --- a/lib/fdtdec.c
> > > +++ b/lib/fdtdec.c
> > > @@ -1829,8 +1829,8 @@ int fdtdec_setup(void)
> > >  	 * not whether this phase creates one.
> > >  	 */
> > >  	if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > -	    (xpl_prev_phase() !=3D PHASE_TPL ||
> > > -	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > +	    !xpl_is_first_phase() &&
> > > +	    (IS_ENABLED(CONFIG_TPL_BLOBLIST) || IS_ENABLED(CONFIG_SPL_BLOBL=
IST))) {
> > >  		ret =3D bloblist_maybe_init();
> > >  		if (!ret) {
> > >  			gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> >=20
> > Can you please test the series at
> > https://patchwork.ozlabs.org/project/uboot/cover/20260519162225.770071-=
1-trini@konsulko.com/
> > and see if your problem is fixed there too? Thanks.
>=20
> Indeed. This fixes my problem as well.
>=20
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks, can you please reply to that series (the cover letter is fine)
too?

--=20
Tom

--dVU3Tir5yNMfKzWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCah7Z3AAKCRAr4qD1Cr/k
CllAAQC1GrVFFUKcmJyuLeGLZMCTj7hwGIEjGLMyCZzx1rRUxAEA92CLxFoIDrd4
IayZnULwH9Jn7fasnsWVZD1LTVGw6w8=
=bss2
-----END PGP SIGNATURE-----

--dVU3Tir5yNMfKzWi--
