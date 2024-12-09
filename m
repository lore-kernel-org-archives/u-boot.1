Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A767E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 20:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DDE89792;
	Mon,  9 Dec 2024 21:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gtlIQmBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642C189793; Mon,  9 Dec 2024 21:08:26 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139F989457
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 21:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-46753228bfbso15747041cf.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 12:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733774903; x=1734379703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7swrqi1LrFCx9BsCoQtCHs6huE8bxQ3ze97wHzXRWYE=;
 b=gtlIQmBxjsth0udlmRAayBM8c347q/hx9Gy1r6hXXKmAVvfqfgTr22bci2vpGSrZDq
 TKY0JL+F+NCJTh0vv98JL8yXwAanncsItJrtjzf3Ch6EN65CKC9d0NA0TmIquAowXRwA
 3SVD3gV+/2coqUBYGI9YcE1tpCFTvt2H/hFxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774903; x=1734379703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7swrqi1LrFCx9BsCoQtCHs6huE8bxQ3ze97wHzXRWYE=;
 b=HefV4IP5RIxkQsw2lphLc/62jhyTSDriRwlg+5BFLrztAl1IpufFaLbgQr7VlMmtK1
 t89TjDsvyT0qyeliTIWzYD2lAqUqX7wqgFGyr39m38Nzfi8Yk64KzD/UPLsqFlrNscbO
 Z+7sX9Zt1kvZWkkGMS3IkoMSblTNznbIRIo0wZUOOBhE9UNH0GSShHigjY2BairJd006
 mRSmLb7SHbk+9YqPjIRqwXsEHAQM/ArroiY3Ewrt+fYGPakpV0JK/5t+/VD4mdMWCMGv
 Fmfn8euK07fk/NXNTpDYZsKKEK45T9S5Lr7K4ihz0DvWYWqpy/DcyztBgMP+aSoK06mB
 053A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEZNb7RnlKOlrG9YaEmgc2ByUtQw3fs6ZTKcASaILit4a3ekr86Ctvpmo3+LJCV+pwn0DToNI=@lists.denx.de
X-Gm-Message-State: AOJu0YxVL4dfAFJyhGjjAltTRyQGO+RdrMzj/yhrnolwFOwGV545FuFa
 Yy5A0JswGSbSXRTCau2wVapRSWliTzcHG4z4SnN/KV1XP7YB8yWnjVUh3ESaoLk=
X-Gm-Gg: ASbGncuZ0/TdAUZmT0+fhL129tXYzai+IlGdpCKMvaZoIN/OimE4B3M18EBv2QG6wvv
 hdWqjRZoe0gyKMo2UEm8fS/rmlwEAlCBeLldMMNdD7lw/hkxdrNUPS0KkOhYey2aU/3wwJn57FF
 Gfk03GCxemRbdrCwRxPkJP4mjx9L60FhwGTn7PLjaDz3dHVdiybIvHVtlSBhQKFlSwZYf1rZweU
 i5CE3OgodujWS4WjhzaYQzFFSD93NeR1HQ0ZnRTpM0WwYegP6OYyKs=
X-Google-Smtp-Source: AGHT+IGqem50LxStPfp7AfvAIOL1sbHO/ABbLipyeRHeHqDMYFLRvqe7eXK4NQyYMsrY7Jl0juuyBQ==
X-Received: by 2002:a05:622a:1f92:b0:466:b29a:816d with SMTP id
 d75a77b69052e-46771eae990mr29920251cf.3.1733774902722; 
 Mon, 09 Dec 2024 12:08:22 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467753461c0sm1571491cf.57.2024.12.09.12.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:08:22 -0800 (PST)
Date: Mon, 9 Dec 2024 14:08:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, neal.frager@amd.com,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
Message-ID: <20241209200818.GW2457179@bill-the-cat>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
 <20241209192340.GV2457179@bill-the-cat>
 <CAFLszTi-NsvU=UP2Ze7NH4iGRKtG1Ja9Z5pFig+52LNJRxqd-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DrIXQMtKv00J9+jb"
Content-Disposition: inline
In-Reply-To: <CAFLszTi-NsvU=UP2Ze7NH4iGRKtG1Ja9Z5pFig+52LNJRxqd-w@mail.gmail.com>
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


--DrIXQMtKv00J9+jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 12:27:31PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 9 Dec 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 07:34:34PM +0100, Michal Simek wrote:
> > >
> > >
> > > On 12/9/24 16:47, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
> > > > > >
> > > > > >
> > > > > > On 12/6/24 20:20, Simon Glass wrote:
> > > > > > > On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.c=
om> wrote:
> > > > > > > >
> > > > > > > > Calling empty function when BINMAN_FDT is adding +64B for n=
othing which is
> > > > > > > > not helping on size sensitive configurations as Xilinx mini=
 configurations.
> > > > > > > >
> > > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - new patch
> > > > > > > >
> > > > > > > >   From my perspective there is no reason to call empty func=
tion. It is just
> > > > > > > > increase footprint for nothing and we are not far from that=
 limit now.
> > > > > > > >
> > > > > > > > ---
> > > > > > > >    common/board_r.c | 7 +++----
> > > > > > > >    1 file changed, 3 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > This is a bit odd, though. Do you have LTO enabled?
> > > > > > >
> > > > > >
> > > > > > yes LTO is enabled. And there are other candidates like this.
> > > > > > Is LTO able to fix function arrays which is calling empty funct=
ion?
> > > > > >
> > > > > > (without this patch)
> > > > > >
> > > > > > 00000000fffc0eb4 <initr_of_live>:
> > > > > >      fffc0eb4:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0eb8:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0ebc <initr_dm_devices>:
> > > > > >      fffc0ebc:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ec0:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0ec4 <initr_bootstage>:
> > > > > >      fffc0ec4:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ec8:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0ecc <power_init_board>:
> > > > > >      fffc0ecc:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ed0:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0ed4 <initr_announce>:
> > > > > >      fffc0ed4:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ed8:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0edc <initr_binman>:
> > > > > >      fffc0edc:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ee0:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0ee4 <initr_status_led>:
> > > > > >      fffc0ee4:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ee8:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0eec <initr_boot_led_blink>:
> > > > > >      fffc0eec:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ef0:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0ef4 <initr_boot_led_on>:
> > > > > >      fffc0ef4:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0ef8:   d65f03c0        ret
> > > > > >
> > > > > > 00000000fffc0efc <initr_lmb>:
> > > > > >      fffc0efc:   52800000        mov     w0, #0x0              =
          // #0
> > > > > >      fffc0f00:   d65f03c0        ret
> > > > >
> > > > > No, but maybe Simon would prefer if we marked all of the could-be=
-empty
> > > > > functions as __maybe_unused and did:
> > > > >          CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
> > > > > etc in the list instead?
> > > >
> > > > Yes that looks better.
> > >
> > > But we are talking about using macro inside array at best with using =
#ifdefs.
> > > Or maybe I am not seeing what you are saying.
> >
> > No, nevermind, sorry. I was hoping that:
> > diff --git a/common/board_r.c b/common/board_r.c
> > index ff9bce88dc93..c18997446dfa 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -610,9 +610,7 @@ static init_fnc_t init_sequence_r[] =3D {
> >         noncached_init,
> >  #endif
> >         initr_of_live,
> > -#ifdef CONFIG_DM
> > -       initr_dm,
> > -#endif
> > +       CONFIG_IS_ENABLED(CONFIG_DM, initr_dm),
> >  #ifdef CONFIG_ADDR_MAP
> >         init_addr_map,
> >  #endif
> > @@ -632,9 +630,7 @@ static init_fnc_t init_sequence_r[] =3D {
> >  #ifdef CONFIG_EFI_LOADER
> >         efi_memory_init,
> >  #endif
> > -#ifdef CONFIG_BINMAN_FDT
> > -       initr_binman,
> > -#endif
> > +       CONFIG_IS_ENABLED(CONFIG_BINMAN_FDT, initr_binman),
> >  #ifdef CONFIG_FSP_VERSION2
> >         arch_fsp_init_r,
> >  #endif
> >
> > would work, but the macro doesn't evaluate how I'd hope it did and that
> > just blows up.
>=20
> You should drop the CONFIG_ inside the brackets. Also, you need
> something like this, since the comma must not be present unless the
> option is enabled:
>=20
> CONFIG_IS_ENABLED(BINMAN_FDT, (initr_binman,))
>=20
> If we want to do this more generally, we could:
> - convert more things to use an event (then the cost is just 4-8 bytes pe=
r item)
> - add a helper to initcall.h to make it easier, e.g.
> INITCALL(BINMAN_FDT, initr_binman)

We should probably just do a follow-up cleanup to, as you note
	CONFIG_IS_ENABLED(FOO, (initr_foo,))

I don't think a more complex macro in there is worth while, but saving a
few bytes overall here for free would be good. We can figure out later
the cost/benefit on moving stuff here to events.

--=20
Tom

--DrIXQMtKv00J9+jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXTisACgkQFHw5/5Y0
tyzfQAv+IwKMF4oOwL0gmQ3kXUV4A2bO5ZRQ9N6/mDj+zRLeassHEUBdzW5tUh4w
BaIruRsjkhOwA5JnaDJQqPy8ZkNx+pQ8LhHolgni8DJn6D4BEeiuy5E+BLON7nrq
3Z4tuJg+skdUJ81BxuQDZRzs8bbebsyeaUeiXmy0g3CluXb1CGs/rBSRQ7sFPWuL
3ano48vhw6hbMZqTJCSvZNQpJkmHaq+tOOqwcnaivxn0LewN2ZHC3t0yoJABsmm/
qgZH1CgNLz5IlyMiSMVVY3H0zGEDvKY7bHSnreCKuumjq5sMRSaNA5l6nSDNEnQr
AZr0KCeUhWkD9sCcBkjELxhNfdHmXmEWzuWbJrFdlB/tDEYDz41u9QDA9x3LOlvU
OWX30iWUu0VSSoadgdCMhEsz4IGniMBKRZq5vLXp1HaimLZAYRiFT9eJUoKRf38M
/Aib0DChAWvqP7O6UQH15F6mucPdPpqwj2cQGSlLNizv08pG1hGw1C4it55Q7wEW
5OowKvfR
=Lx5Q
-----END PGP SIGNATURE-----

--DrIXQMtKv00J9+jb--
