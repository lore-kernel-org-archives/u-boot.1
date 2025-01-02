Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1C3E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 15:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07668007D;
	Thu,  2 Jan 2025 16:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sdZ/PYb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E1480196; Thu,  2 Jan 2025 16:38:30 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6FE8001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 16:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d896be3992so64828036d6.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735832307; x=1736437107; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ftweg2g33MXOikbRxjAlLomBYSv1UkuyirQ5PxFIhvM=;
 b=sdZ/PYb4eoMoV0JtpM7vmTUszqwLldK38Coyo2UGlNURZA+OwFPaazHv8FRLMUOCEY
 HWfpQet7j3BdkDofZL8eRCxN2soYP4IfPKmsThNfoOudzbRmEDtMg7LaB6yGR9qVSyYs
 /hDTP1dj9rhlZ/4jTODpXWrFwgCWQNUjOoKSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735832307; x=1736437107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftweg2g33MXOikbRxjAlLomBYSv1UkuyirQ5PxFIhvM=;
 b=oWrms65IcCIvEcLBD6m6O4ELvHkfQn/TOhyESr1jrm65jjUFHygHFktQXu//scwDT0
 SbsPJ/nUDluNKWi3/iTh3WMNzORt0V5Hk79PbxtRhOyLB9TWPf7PBUg2pzlDUeP5gSWh
 6dp/SGqPxZ7IXEotQECZpUiM+HKRwHQVKNPHalUfpe7hmoNKmU14VxEswKISAIMREudf
 n83y3GYPefCdSW9AFkl8BVXc2r8zYx7FSLRyc8HILRVuO45dcP1dbo0BkXUh2RYpNWBC
 Ir2Pn7dvnITHFv86iZCGHTyOEdbgkWaaIAaAOPQF0aKBDr1WIK9uERk78+Ye+4skB8z7
 NgxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX40IVQ8ADsWgh7o4KdVDSlI6CUvRjCjJA5fJFdAPXiBtVIVVQTxnpuB56nuC3Avb0HdwmDfME=@lists.denx.de
X-Gm-Message-State: AOJu0YziXtuubTZTuWAiqBsYj5qd0BXmtaLKLB5h5rQ7GyAXrK4MbGB6
 QtgoS6NWGm9f0HW2gcpXd67gdIVYu3bEF1nE96WEGqwF3qZaKuSC1pS1Ut5pL0V7DIkag3B76Ws
 tY5U=
X-Gm-Gg: ASbGncv9L5Fqy6NP6VFksMfwMmpYQNNnwP+q8Ihkba2pOzp3/a+8lPrMH2SLEI8Opxu
 OHhoBOuaJgM6twZO/5F7kZ0wVr+SrW4Mb7WabZxElayw73yNt5XtXPH3sCn36L0UizyNThb8kp6
 yAIsTvipWrFwFoRJok3rB3a3ik+vioseuq88W6tGKVlVa+DlRBJa5RTfvfEpT2PPbbFiYTmlK4b
 BfauIpZ9l7HrXMgrr9NWgZHQCnV/nmnPuvlKOxuho5WMatzooHjKQc87A==
X-Google-Smtp-Source: AGHT+IGTC3ABZdtFrP7C5gFhnk7mdo5I/3kutCxet8+gDs1ZfGs3SMw0qTWMv8y8LgVFcKkRSZ6NeA==
X-Received: by 2002:a05:6214:4199:b0:6d8:8aa6:ef27 with SMTP id
 6a1803df08f44-6dd233978bfmr889461766d6.38.1735832306698; 
 Thu, 02 Jan 2025 07:38:26 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180eacb8sm133202246d6.20.2025.01.02.07.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 07:38:25 -0800 (PST)
Date: Thu, 2 Jan 2025 09:38:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
Message-ID: <20250102153823.GN3476@bill-the-cat>
References: <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
 <20241219163604.GV1505244@bill-the-cat>
 <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KAdq2DGq9JPz3OpN"
Content-Disposition: inline
In-Reply-To: <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
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


--KAdq2DGq9JPz3OpN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 11:14:51AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Dec 2024 at 05:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 10:37:37AM -0500, Raymond Mao wrote:
> > > Hi Simon,
> > >
> > > On Thu, 19 Dec 2024 at 10:08, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > > Hi,
> > > >
> > > > On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.o=
rg>
> > > > wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> =
wrote:
> > > > > > >>
> > > > > > >> Hi Raymond,
> > > > > > >>
> > > > > > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linar=
o.org>
> > > > wrote:
> > > > > > >> >
> > > > > > >> > Hi Simon,
> > > > > > >> >
> > > > > > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.or=
g>
> > > > wrote:
> > > > > > >> >>
> > > > > > >> >> Hi Raymond,
> > > > > > >> >>
> > > > > > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <
> > > > raymond.mao@linaro.org> wrote:
> > > > > > >> >> >
> > > > > > >> >> > Hi Simon,
> > > > > > >> >> >
> > > > > > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium=
=2Eorg>
> > > > wrote:
> > > > > > >> >> >>
> > > > > > >> >> >> Hi Raymond,
> > > > > > >> >> >>
> > > > > > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <
> > > > raymond.mao@linaro.org> wrote:
> > > > > > >> >> >> >
> > > > > > >> >> >> > Get tpm event log from bloblist instead of FDT when
> > > > bloblist is
> > > > > > >> >> >> > enabled and valid from previous boot stage.
> > > > > > >> >> >> >
> > > > > > >> >> >> > Note:
> > > > > > >> >> >> > This patch depends on:
> > > > > > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE=
 options
> > > > > > >> >> >> >
> > > > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsu=
lko.com/
> > > > > > >> >> >> >
> > > > > > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > >> >> >> > ---
> > > > > > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> > > > > > >> >> >> >  1 file changed, 7 insertions(+)
> > > > > > >> >> >> >
> > > > > > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > > > > >> >> >> > index 7f868cc883..acaf0acb88 100644
> > > > > > >> >> >> > --- a/lib/tpm_tcg2.c
> > > > > > >> >> >> > +++ b/lib/tpm_tcg2.c
> > > > > > >> >> >> > @@ -19,6 +19,7 @@
> > > > > > >> >> >> >  #include <linux/unaligned/generic.h>
> > > > > > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> > > > > > >> >> >> >  #include "tpm-utils.h"
> > > > > > >> >> >> > +#include <bloblist.h>
> > > > > > >> >> >> >
> > > > > > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32
> > > > *supported_pcr, u32 *active_pcr,
> > > > > > >> >> >> >                       u32 *pcr_banks)
> > > > > > >> >> >> > @@ -672,6 +673,12 @@ __weak int
> > > > tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> > > > > > >> >> >> >         *addr =3D NULL;
> > > > > > >> >> >> >         *size =3D 0;
> > > > > > >> >> >> >
> > > > > > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) =
&&
> > > > !bloblist_maybe_init()) {
> > > > > > >> >> >>
> > > > > > >> >> >> Please drop the second term...the bloblist is inited by
> > > > U-Boot already.
> > > > > > >> >> >>
> > > > > > >> >> >
> > > > > > >> >> > As an independent library, from the tpm library's angle,
> > > > whether the bloblist init was already called or not is agnostic.
> > > > > > >> >> > I think this is the purpose of the "maybe" function.
> > > > > > >> >>
> > > > > > >> >> No. U-Boot does init at the start. We don't want each sub=
system
> > > > > > >> >> 'maybe' initing each other subsystem that it uses. If you=
 want to
> > > > > > >> >> check whether bloblist is available, you can use the GD f=
lag.
> > > > > > >> >>
> > > > > > >> >
> > > > > > >> > OK. I can use the gd instead.
> > > > > > >> >
> > > > > > >> >>
> > > > > > >> >> >
> > > > > > >> >> >>
> > > > > > >> >> >> Also please drop the first term. If you find it in the
> > > > bloblist, just use it.
> > > > > > >> >> >>
> > > > > > >> >> >
> > > > > > >> >> > I think here we should have the same logic as the exist=
ing one
> > > > in fdtdec:
> > > > > > >> >> > If bloblist is not enabled or errors observed, do a fal=
lback
> > > > to the original process.
> > > > > > >> >> > At least I want to keep the same logic in different pla=
ces
> > > > before everything is ready from TF-A to U-boot.
> > > > > > >> >>
> > > > > > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't e=
xist,
> > > > nor
> > > > > > >> >> should it. Nor do you need it, since you can just check t=
he
> > > > bloblist
> > > > > > >> >> for what you want. If you don't find it, fall back.
> > > > > > >> >>
> > > > > > >> >
> > > > > > >> > Since Firmware Handoff is still an experimental feature an=
d not
> > > > mandatory yet (at least now),
> > > > > > >> > I put everything under PRIOR_STAGE to allow users to disab=
le it
> > > > by their own decisions.
> > > > > > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have=
 added
> > > > a dependency claim in my commit message.
> > > > > > >>
> > > > > > >> Yes, but even if Tom does pick his patch, which I object to,=
 by the
> > > > > > >> time your code is called, there will be a bloblist.
> > > > > > >>
> > > > > > >> So the end result of your test is to allow the user to ignor=
e any
> > > > TPM
> > > > > > >> log in the bloblist. If that's what you want (which seems fi=
ne to
> > > > me),
> > > > > > >> add a Kconfig for it.
> > > > > > >>
> > > > > > >
> > > > > > > Per my understanding of PRIOR_STAGE, it means we have a blobl=
ist
> > > > from the previous stage and we want to use it (as a Transfer List).
> > > > > > > If this is the case, it is not for DT only but can be applied=
 for
> > > > eventlog or anything for Firmware Handoff in the future.
> > > > > > > That is the reason I use PRIOR_STAGE here, I don't think we n=
eed to
> > > > add another kconfig.
> > > > > >
> > > > > > Who knows what it is supposed to mean...anyway, it should not b=
e used
> > > > > > like that. The devicetree is special in that we want to get it =
=66rom
> > > > > > the bloblist very early, if available. Nothing else (so far) in=
 the
> > > > > > bloblist has this constraint, certainly not the TPM log.
> > > > >
> > > > > Raymond is exactly right, and the device tree is not special.
> > > >
> > > > That is quite wrong IMO. Devicetree is special because we need it
> > > > early and it might come from bloblist before the bloblist has been =
set
> > > > up by U-Boot. It also controls the whole operation of U-Boot. There=
 is
> > > > nothing else in U-Boot quite like the devicetree.
> > > >
> > > > > The
> > > > > specialness is "do we have a valid bloblist upon entry or not". W=
hich
> > > > > means that also no, this series (since it happens late enough) sh=
ouldn't
> > > > > care about if the previous stage had created it or not, merely as=
 you
> > > > > said if the tag for the TPM (or other blob) is found.
> > > >
> > > > I would feel more comfortable having the discussions about what
> > > > previous stages need to pass U-Boot a bloblist once we have that
> > > > situation. This particular patch seems clear enough, and well
> > > > motivated. It just needs to drop the conditions.
> > > >
> > > I think we still need a condition here indicating that the kconfig of
> > > "handoff via bloblist" is enabled.
> > > And this "handoff via bloblist" kconfig should mean to handoff everyt=
hing
> > > via bloblist, including DT.
>=20
> No, I don't agree with that at all.
>=20
> What actually breaks if you look for the TPM log in the bloblist?
> Please answer this question.

Yes, the case of bloblist found, TPM log isn't found needs to work.

> > There's at least two sets of challenges here. One, being solved by
> > vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE as
> > an actual option. And in that case, there's no U-Boot before full U-Boot
> > and the bloblist exists for us. Two, U-Boot is what is creating the
> > bloblist. The contentious parts are *when* it's created and *where* it
> > resides prior to full U-Boot seeing it.
>=20
> There isn't contention, so far as I am aware. The normal case is that
> U-Boot creates and uses the bloblist itself. Pre-U-Boot blobs (like
> TF-A, sadly) are not the normal case and should be discouraged in an
> open-source project. That doesn't mean we shouldn't support them, but
> it is the tail wagging the dog.

No. The normal case is that no one is using a bloblist. The rare case is
the platforms you developed bloblist on. The new and growing case is
other platforms using the standard mechanism you designed to communicate
across projects in a not ad-hoc manner.

> > In both cases, full U-Boot will copy the bloblist to where it likes.
> >
> > And this is separate from "bloblist has device tree or we hang()".
>=20
> Yes, well that has been the case in mainline for over a year with
> several of my boards, so it is a bit late to start worrying about it
> now. I have OF_BLOBLIST and it works fine.

You mean your boards that are broken in mainline, because no one quite
understood how you were trying to use the bloblist? And that are AFAIK
end of life platforms? No, they aren't the important use cases for a
bloblist. They're apparently not ideal references for demonstrating how
to use a bloblist.

--=20
Tom

--KAdq2DGq9JPz3OpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2sucACgkQFHw5/5Y0
tywYeAv/cVT8IH7BEIl53LQa5RQjss2gXA9pIgsJXuz/mKiAiJcxvW9OBLlnt/PF
OPqKGKwnfZ3gA93ku0zMR0NWJq+XFvQFN/uxWsw9EH0DwztnetzzxWqZe0U17RaP
sEGjvmGdV7GS437mE2KEzwd5tG+TPfTikFk2OyQVuTOjsQN5Fx6xUzbpsV7jyMJf
9gaBZ1ziuG2PL8T73zfRi9Y/Nl6OdAUfEBOsaTxMOYdqqVWENy/XNJtDrE9y5J8l
T0TOJqHK5lXhy16W0TH6F2zcTnNJlBsGY94uV/4CwEmh1GhKCgSm5J6ooh0W8lUC
KrX8zwNMFDYoKI+fAPU/62hTs5jM4wIHYrx39fUFQt8TJ3k0IuQfeiAI6YhcGbBN
GderEIieozeFr6ARU9NHHxSr2J5Z3MCsvPDchqpNjyxZXOteCMyJCAT2+Iw4AZKR
ZaeSs3KY0lVrAMsXI6GGtQUt4ZsI5PejL9AmOp4AR23CqQgWr6TwjikdWlxK/tZp
WgNdsULv
=l88Q
-----END PGP SIGNATURE-----

--KAdq2DGq9JPz3OpN--
