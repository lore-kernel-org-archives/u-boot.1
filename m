Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6AB109C05D
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 20:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA1D83CD3;
	Wed, 25 Mar 2026 21:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QcAv8RHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B15BF83DA6; Wed, 25 Mar 2026 21:37:38 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551A183A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 21:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d1872504cbso192350a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774471055; x=1775075855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pnv+FZJuQ29CFAH/NRinJ0rHB+OiynEd3sD1rY8sJjg=;
 b=QcAv8RHjRZrzVbGwFv6bKTcbBGVlAOAffmi3aJuUwbMTgtHbtmj/7+lQa/5sImsNpa
 UR13mOGs2W2Puj4ebygcdZfVgVRNcOnnXNcFxZGPDqqIVt41Z1nU2rgtuoBsN/smmApK
 PFLLzlFBX73b+QmCvpbsfoajqOkYqBUbVYcqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471055; x=1775075855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pnv+FZJuQ29CFAH/NRinJ0rHB+OiynEd3sD1rY8sJjg=;
 b=NALD9/FjaLiAQxqoNPcFNO7rjRD9Lqj3jTw2BU80Ce2hTtndhl51HKzSM4UHPIdCc2
 EqdWM2/1ZKRuV75aD7KsFoHnRfg/g5BEldl/rt9MDnZqhCCs0MJyZQW3G38+jHXKF26E
 Ex4AVEzqdIEyd91UyOSbDLGQwWORQukVU18xGXVX1zy1XuxRevPNt82d8w5IwdAJvApq
 Gm8i57i4SCK/Qx9BLl0oDywTpVS2gj/pE9nvDTKEjnJdfe6sSYU+g5TGY7NSN9shvwG0
 gCA3vXdsOLERghoFLzigis+PNYcs+lAq+cRi+30MhIa6cdeg2oL+feEm9XjgMtfi0eQ2
 rILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk/kA9xu209ZKEOGLkabSt5V36SNDnj9PV5NynxAt1GgiAD5a88iENM2YzgKqg2fOH9IGlnCs=@lists.denx.de
X-Gm-Message-State: AOJu0YwwPL9S5ir05nFUohOMJWoaG660iLZeCOEax2X2BRmMpSSjPQgX
 DFmjpWtRVuw+hrRYL7oksLFBVJtsMLX9M6l5kEs9Bq6lQRfhIYs4oDTRwKy6mvQs4YcuwgORRrf
 KGePLWPg=
X-Gm-Gg: ATEYQzyIvJuxPq2Th4U3DYh7nVcdZdnwkPWgmVPmAVEs/lTKC1w/l+RaX5/WPCDh2LS
 t5WHfWQCtoAibp9yE+gyNP6Y2Ifd8k5CiuT9zn4YHdHE/9KdUaz3UYHFUoTL9WJJKY5ckEE2X1i
 tBthf0yDDeS1keTREl4Quh7lEXlft8gUdAKkmq0MOUZuOPOrtghhXTa0k9aL8WUWQvhIkQLkMP4
 3SN8/orXsQ4aZ6G8cVJwgqLNKCBJvYQxbUWPfd735513pKYNUFT1haekGNIHamybqFzevpQ3BnJ
 etWEz4hnsfNLkyvjlbY5R4MV5JkmwDHAAYYNDcou0pXySPSCXmg1Vmt6+XNYM15DMduFStxEL92
 uxl17YVw9g/ulaLGoATbEAvbQwohkXXTp2pT23Ph1/0WsfKopk+GEWu47KONSa5qTSMQ6o0whEN
 QAVEGIJtt6KJYnaElGKsSEWvbqtDBNeSl7LkvDdcAIGWUaPkhHhAFhBZBfW5TbDcz1UHRbdoVkJ
 h8quPi6Jv0z705+jJ2FzTRVrpuGXjT7gebRyy+h/NtX5sk2AIIQtDu+HBQ=
X-Received: by 2002:a05:6830:4411:b0:7d7:c79a:cb69 with SMTP id
 46e09a7af769-7d9c6cbe0cdmr4997115a34.18.1774471054947; 
 Wed, 25 Mar 2026 13:37:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e71f6815sm615036a34.15.2026.03.25.13.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:37:34 -0700 (PDT)
Date: Wed, 25 Mar 2026 14:37:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] arm: rockchip: Guard call of board_early_init_f in SPL
Message-ID: <20260325203732.GZ502704@bill-the-cat>
References: <20260325190025.3428560-1-trini@konsulko.com>
 <fb6ee141-3369-45e6-8320-e91f67ec6b1e@kwiboo.se>
 <CAFLszTiF4RDyo8+4RZhsNViSNquU3Ouq2fNr5NjG7PvK+2zrtg@mail.gmail.com>
 <20260325195129.GX502704@bill-the-cat>
 <c67bddd4-3827-4e72-a08e-99691cea2165@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8oRmmfjF+DUYnAlH"
Content-Disposition: inline
In-Reply-To: <c67bddd4-3827-4e72-a08e-99691cea2165@kwiboo.se>
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


--8oRmmfjF+DUYnAlH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 09:12:31PM +0100, Jonas Karlman wrote:
> On 3/25/2026 8:51 PM, Tom Rini wrote:
> > On Wed, Mar 25, 2026 at 01:42:28PM -0600, Simon Glass wrote:
> >> Hi Jonas,
> >>
> >> On Wed, 25 Mar 2026 at 13:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>
> >>> Hi Tom,
> >>>
> >>> On 3/25/2026 8:00 PM, Tom Rini wrote:
> >>>> Today, no platforms call board_early_init_f, and rockchip provides a
> >>>> weak default function. Change this to not providing a weak function =
and
> >>>> only call board_early_init_f if CONFIG_BOARD_EARLY_INIT_F is enabled.
> >>>> This will allow any potential future needs to be taken care of, and =
make
> >>>> future consolidation easier.
> >>>>
> >>>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>>> ---
> >>>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> >>>> Cc: Kever Yang <kever.yang@rock-chips.com>
> >>>> ---
> >>>>  arch/arm/mach-rockchip/spl.c | 8 ++------
> >>>>  1 file changed, 2 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/s=
pl.c
> >>>> index e989c148079a..8026cc0abb8d 100644
> >>>> --- a/arch/arm/mach-rockchip/spl.c
> >>>> +++ b/arch/arm/mach-rockchip/spl.c
> >>>> @@ -97,11 +97,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 =
boot_device)
> >>>>       return MMCSD_MODE_RAW;
> >>>>  }
> >>>>
> >>>> -__weak int board_early_init_f(void)
> >>>> -{
> >>>> -     return 0;
> >>>> -}
> >>>> -
> >>>>  __weak int arch_cpu_init(void)
> >>>>  {
> >>>>       return 0;
> >>>> @@ -111,7 +106,8 @@ void board_init_f(ulong dummy)
> >>>>  {
> >>>>       int ret;
> >>>>
> >>>> -     board_early_init_f();
> >>>> +     if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))
> >>>
> >>> This patch seem to introduce a change in behavior for chromebook bob =
and
> >>> kevin, they do not seem to enable BOARD_EARLY_INIT_F, yet they have a
> >>> board_early_init_f() in board/google/gru/gru.c no longer being called
> >>> after this change.
> >=20
> > I wouldn't call it a behavior change, since it's not called now, and
>=20
> You mean the function is currently being optimized out? Why would it not
> be called before the change introduced in this patch?
>=20
> The code in board/google/gru/gru.c is silly and probably gets optimized
> out anyway, but the comment there suggest something was done to try and
> make so it was not.

You're right, sorry. Since the size change is the exact same as every
platform that was calling the weak function, it seemed like it must have
not been using that gru.c version at all. But building on top of this
patch and enabling BOARD_EARLY_INIT_F for bob/kevin (and some quick
rework so that full U-Boot links), and there's no size change to SPL.

> > this is the output from building before/after, checking for size
> > differnces (and how I spotted odd cases as part of this overall work):
> >=20
> >             chromebook_bob : spl/u-boot-spl:all -8 spl/u-boot-spl:text =
-8
> >                spl-u-boot-spl: add: 0/-1, grow: 0/-1 bytes: 0/-12 (-12)
> >                  function                                   old     new=
   delta
> >                  board_init_f                               148     144=
      -4
> >                  board_early_init_f                           8       -=
      -8
> >             chromebook_kevin: spl/u-boot-spl:all -8 spl/u-boot-spl:text=
 -8
> >                spl-u-boot-spl: add: 0/-1, grow: 0/-1 bytes: 0/-12 (-12)
> >                  function                                   old     new=
   delta
> >                  board_init_f                               148     144=
      -4
> >                  board_early_init_f                           8       -=
      -8
> >=20
> >=20
> >>> I do not have a chromebook_bob/kevin so I cannot help verify if this
> >>> change break anything, hopefully Simon can help test/verify.
> >>
> >> Kevin spews some junk to the console with or without this patch.
> >>
> >> No change observed on bob or kevin. BTW both are in the lab so you
> >> should be able to test if you push to your tree.
> >>
> >> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_kevin
> >> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_bob
> >=20
> > Perhaps the problem is those platforms should be enabling, but lost.
> > I'll take a look, but would be unrelated to this (since if enabling
> > BOARD_EARLY_INIT_F it would then call it).
>=20
> board_early_init_f() in gru.c is wrapped around CONFIG_XPL_BUILD so
> should only be included in SPL and was called from rockchip spl.c
> board_init_f() prior to this patch.
>=20
> Based on Simons comment I guess the board_early_init_f() in gru.c
> probably could and should be fully removed, as it currently does not
> seem to provide the suggested delay.

Yes, both currently go green in GitLab when we run CI on them, with or
without this patch, so there's no change in the end.

--=20
Tom

--8oRmmfjF+DUYnAlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacRHiAAKCRAr4qD1Cr/k
CqK4AQCr8lm5rf6NjHxJ7KYhuDfyJyRXOKaIZN+uXJ2E9i+I1gD/f9pt22swCg7x
6hbyIWFxqvih4gPgClN6pDhxliyWZww=
=4xxE
-----END PGP SIGNATURE-----

--8oRmmfjF+DUYnAlH--
