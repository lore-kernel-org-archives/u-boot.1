Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111EEC30639
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3555286BA2;
	Thu, 17 Aug 2023 17:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NoU4ACyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E482986B97; Thu, 17 Aug 2023 17:10:38 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8D986B8D
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so15014217b3.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692285034; x=1692889834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1N88rtGHp8ufoOXGyFrhUPvLUxBc0/SMeSMmJS3ZQ4U=;
 b=NoU4ACyBWP498uSEptaU6bpFdnZhnfsH5G7y1+Vf4bXQnuezdeP82sLo1NawfVdDnz
 0YC7Jlco8tw0vOHjsMzCXqbzOQl/yrjvkqj9u5ymnhWr16unVsp3IQumU47OSgwcRsDv
 4K23CkPULt/opA/IbxHRIC7DZ+HFaSuuQCAcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285034; x=1692889834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1N88rtGHp8ufoOXGyFrhUPvLUxBc0/SMeSMmJS3ZQ4U=;
 b=VjRFrrYe879STWPKH1miXKrq74AfYFzKHNSRbD4MLdN5VH0S+9ua3LIP/36qUw7h+E
 3Aic0aCsOIivmMbi8eLxfQMs3AspuGugEKg7kbSgiIeSIWGHoJv8iR29BCyH2h5JO8hO
 QUffBbBk5km0y/NZBt6TcwPrptYRhgJX5AHMy4ekK1euGX3ixlA6gBy5eOfOfXS7zFHP
 Jmix+XJ/qW8QaUi+vzb/6Lp2WryIatzQEsq146zemYe5FgqdIsImV4tJwMpd6mfvHiPh
 cZxevYjSqF0AWayL+tJLiBR6uOiJ74K16/MVlJPwvs7M8Wfqv9E/J10ru9nniYdys9YI
 QP/w==
X-Gm-Message-State: AOJu0YwF3goUc1u3x6LCx/Soo0gFpwCm9CiIzjKks9FX6S/uiyWoOarh
 QCipO+pgMKaRO18/sVD9uVPeUg==
X-Google-Smtp-Source: AGHT+IGVW/fdou5o/amDXXLqkmAq083J4/nLR1mixMnDnLDwIbtjIN8k4/a/Ed5vVLjTe2Cw5koIUg==
X-Received: by 2002:a81:6c02:0:b0:583:7564:49de with SMTP id
 h2-20020a816c02000000b00583756449demr3563827ywc.3.1692285034318; 
 Thu, 17 Aug 2023 08:10:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a81c210000000b005463e45458bsm4636451ywc.123.2023.08.17.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:10:33 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:10:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nikhil M Jain <n-jain1@ti.com>, Anatolij Gustschin <agust@denx.de>,
 Michal Suchanek <msuchanek@suse.de>, Ovidiu Panait <ovpanait@gmail.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
Message-ID: <20230817151032.GG1515023@bill-the-cat>
References: <20230731160008.82342-5-sjg@chromium.org>
 <CAEUhbmXn0VQ6B8Qfs+XWEBuPKQ0mtVbzNeH7ZmT+V1Yh1r5qWw@mail.gmail.com>
 <CAEUhbmU14kY-DpNEZyXJEWX4vbqFY-ANgEZZskqY_gxVv4rD5Q@mail.gmail.com>
 <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
 <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
 <99f81e66-9295-8e4c-1693-86e3d81a302c@ti.com>
 <CAPnjgZ2EjOn86eQ-BdGH5F67Op3bSwG0BZb-LAbPOw955Srg0g@mail.gmail.com>
 <328fb0cf-5f98-019f-49f8-30674c9d34e1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8PSV0fFeUhqOOhl7"
Content-Disposition: inline
In-Reply-To: <328fb0cf-5f98-019f-49f8-30674c9d34e1@ti.com>
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


--8PSV0fFeUhqOOhl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 09:16:05PM +0530, Devarsh Thakkar wrote:
> Hi Simon,
>=20
> On 15/08/23 20:14, Simon Glass wrote:
> > Hi Devarsh,
> >=20
> > On Tue, 15 Aug 2023 at 03:23, Devarsh Thakkar <devarsht@ti.com> wrote:
> >>
> >> Hi Simon, Tom,
> >>
> >> On 15/08/23 04:13, Simon Glass wrote:
> >>> Hi Devarsh, Nikhil, Tom,
> >>>
> >>> On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>>
> >>>> On Thu, Aug 3, 2023 at 7:03=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com>=
 wrote:
> >>>>>
> >>>>> On Thu, Aug 3, 2023 at 6:37=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com=
> wrote:
> >>>>>>
> >>>>>> On Tue, Aug 1, 2023 at 12:00=E2=80=AFAM Simon Glass <sjg@chromium.=
org> wrote:
> >>>>>>>
> >>>>>>> When the video framebuffer comes from the bloblist, we should not=
 change
> >>>>>>> relocaddr to this address, since it interfers with the normal mem=
ory
> >>>>>>
> >>>>>> typo: interferes
> >>>>>>
> >>>>>>> allocation.
> >>>>>>>
> >>>>>>> This fixes a boot loop in qemu-x86_64
> >>>>>>>
> >>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>>>> Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info from=
 SPL to u-boot")
> >>>>>>> Suggested-by: Nikhil M Jain <n-jain1@ti.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Changes in v3:
> >>>>>>> - Reword the Kconfig help as suggested
> >>>>>>>
> >>>>>>> Changes in v2:
> >>>>>>> - Add a Kconfig as the suggested conditional did not work
> >>>>>>>
> >>>>>>>   common/board_f.c      | 3 ++-
> >>>>>>>   drivers/video/Kconfig | 9 +++++++++
> >>>>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/common/board_f.c b/common/board_f.c
> >>>>>>> index 7d2c380e91e..5173d0a0c2d 100644
> >>>>>>> --- a/common/board_f.c
> >>>>>>> +++ b/common/board_f.c
> >>>>>>> @@ -419,7 +419,8 @@ static int reserve_video(void)
> >>>>>>>                  if (!ho)
> >>>>>>>                          return log_msg_ret("blf", -ENOENT);
> >>>>>>>                  video_reserve_from_bloblist(ho);
> >>>>>>> -               gd->relocaddr =3D ho->fb;
> >>>>>>> +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
> >>>>>>> +                       gd->relocaddr =3D ho->fb;
> >>>>>>>          } else if (CONFIG_IS_ENABLED(VIDEO)) {
> >>>>>>>                  ulong addr;
> >>>>>>>                  int ret;
> >>>>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> >>>>>>> index b41dc60cec5..f2e56204d52 100644
> >>>>>>> --- a/drivers/video/Kconfig
> >>>>>>> +++ b/drivers/video/Kconfig
> >>>>>>> @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
> >>>>>>>            if this  option is enabled video driver will be remove=
d at the end of
> >>>>>>>            SPL stage, beforeloading the next stage.
> >>>>>>>
> >>>>>>> +config VIDEO_RESERVE_SPL
> >>>>>>> +       bool
> >>>>>>> +       help
> >>>>>>> +         This adjusts reserve_video() to redirect memory reserva=
tion when it
> >>>>>>> +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). Thi=
s avoids the
> >>>>>>> +         memory used for framebuffer from being allocated by U-B=
oot proper,
> >>>>>>> +         thus preventing any further memory reservations done by=
 U-Boot proper
> >>>>>>> +         from overwriting the framebuffer.
> >>>>>>> +
> >>>>>>>   if SPL_SPLASH_SCREEN
> >>>>>>>
> >>>>>>>   config SPL_SPLASH_SCREEN_ALIGN
> >>>>>>
> >>>>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >>>>>
> >>>>> applied to u-boot-x86, thanks!
> >>>>
> >>>> Dropped this one from the x86 queue per the discussion.
> >>>
> >>> I just wanted to come back to this discussion.
> >>>
> >>> Do we have an agreed way forward? Who is waiting for who?
> >>>
> >>
> >> I was waiting on feedback on
> >> https://lore.kernel.org/all/3b1e8005-f161-8058-13e7-3de2316aac34@ti.co=
m/
> >> but per my opinion, I would prefer to go with "Approach 2" with a
> >> Kconfig as it looks simpler to me. It would look something like below :
> >>
> >> if (gd->relocaddr > (unsigned long)ho->fb) {
> >>       ulong fb_reloc_gap =3D gd->relocaddr - gd->ho->fb;
> >>
> >>       /* Relocate after framebuffer area if nearing too close to it */
> >>       if (fb_reloc_gap < CONFIG_BLOBLIST_FB_RELOC_MIN_GAP)
> >>              gd->relocaddr =3D ho->fb;
> >> }
> >>
> >> Regarding CONFIG_BLOBLIST_FB_RELOC_MIN_GAP
> >> -> This describes minimum gap to keep between framebuffer address and
> >> relocation address to avoid overlap when framebuffer address used by
> >> blob is below the current relocation address
> >>
> >> -> It would be selected as default when CONFIG_BLOBLIST is selected wi=
th
> >>   default value set to 100Mb
> >>
> >> -> SoC specific Vendors can override this in their defconfigs to a
> >> custom value if they feel 100Mb is not enough
> >>
> >> Also probably we can have some debug/error prints in the code to show
> >> overlap happened (or is going happen) so that users can fine tune this
> >> Kconfig if they got it wrong at first place.
> >>
> >> I can re-spin updated patch if we are aligned on this,
> >> Kindly let me know your opinion.
> >=20
> > I'm just nervous about the whole idea, TBH. Perhaps I am missing some
> > documentation on how people are supposed to lay out memory in SPL and
> > U-Boot properr, but I'm not really aware of any guidance we give.
> >=20
> > Perhaps we should say that the SPL frame buffer should be at the top
> > of memory, and U-Boot's reserve area should start below that?
>=20
> 1) As per my personal opinion, I don't like putting such constraints and =
would
> instead like to give some flexibility to end user for choosing
> framebuffer area as I earlier mentioned, as for that matter if we are usi=
ng a
> predefined address then there is no need of using framebuffer address on
> videoblob,

I think this is the wrong direction.  We need to offer strong defaults
that shouldn't be deviated without good reason, rather than "pick what
you want".  Very few cases will deviate from the defaults, and of those
it's hard to know if they're being changed for the best, or because
someone didn't fully understand the implications and breaks something
else.

--=20
Tom

--8PSV0fFeUhqOOhl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeOGgACgkQFHw5/5Y0
tyww3Qv/WnJlE1za+wykCgFVDPjcWDWSb3i7HIhpG3XJxZxdFm+xbGus+KZtuAU0
v5BVqB+Rz8Pgp3stM5mFLeDUqKKFBBFJvLpP8x/5Co56jyPOS1OxJqt3ApdBbAd4
mWSaoCmy37oH4LryJHFi6hJ9jFVXIgH/3IG+o/KyzRWA+X8hExxywpE7Q65edS+X
WiDc7xQ5Fw4VdtXBcr9XYY5OyNH16xAHAkelrfWWEVRp3nvukZwIrP6hmYmeVb7y
ZfMrn8nSdlZbDVgZLqRL9sBYVB7IL1IQD5kUyyGifKfPlrmcntPiS5YwDYqNzhig
AviWKF9Km5LQvV2iAzZmSYUTx+B+5bz+dSHxjhfuxPw3rUrcvJ/DKndRjZHuGQGs
EjvsOxyJQPomiab+xt405a5FI3qAyBTGlKggxvP+gT5ZqZoRcWai0Ca1s1x23lhx
GOFCDACwdEhAMXUjdId7VQIMEqEUKOptD3jKYu1JtCJlJkeuY95Vc9CKM3dm33Lc
dJSmpk2y
=UbuH
-----END PGP SIGNATURE-----

--8PSV0fFeUhqOOhl7--
