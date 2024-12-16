Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C837E77183
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 18:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4A2800D7;
	Mon, 16 Dec 2024 19:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EVuWWwQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F09180104; Mon, 16 Dec 2024 19:30:22 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4AE3800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4678664e22fso42195511cf.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734373818; x=1734978618; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FgsWZedFLpU+q0gfcl84wTp9bDtdnFyNZ+tQXc/HnzE=;
 b=EVuWWwQb9aDInvrD2mi4C2+UcWtu6Ff37ViTqAnKjS5is5dhw4P+MzvaOf5a/li0F/
 cyqKU0lkQ9WYcuXbufBzq3SbQrTqXtt1YfRPileZzbK5UJVyuxaI1ZtXgR+5Z3ztDdef
 F/C9RzDEiC62LTZbiUeAw52OjyItuyo0stGL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734373818; x=1734978618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgsWZedFLpU+q0gfcl84wTp9bDtdnFyNZ+tQXc/HnzE=;
 b=lvEkgrh66rEtrcj/E42LFbnh1cvOJ2OjPVTiqoRHlPGExuCkvsAMp8PBSRJohjZKye
 sO+2JMp3jBdEYA8ueujjnLD4rspWwm7n7BNzpIdOGW6nlNmyL2uiyWp5I244pOVANT3K
 0tLh3NWNXAq/UcUFlun1mFtVffqyboXFF29hxqk7c8pR60IOY+bt+SJgCRjnywxU2EhB
 IvM9o9giyEhyjHpsMbYpvxwv9YEAbMtdkkpnZ7zZgalhFKVz6jhf1E8mxtbiCNm5xXXV
 sQTaGaLHwXUJ8LRpIbHTvEpdynf1rKy/8Afq5cv4V4sbub8XGDq69maNL09fnj8o9n8p
 ux/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaY3zSSRcj3zg4FU0eRDlzghazzZz0QX1YYhyK1A3k02RPAqaYSQV51+uy9Nr1N6xxoPIw/u8=@lists.denx.de
X-Gm-Message-State: AOJu0YxdOLd/xkjLmXCIomYIpFefI4x84ZGfc/agJf/GJALK2RSPykNk
 FVm+tFN+aRMk47DvnZPJIp8OKx7MriRVoOXJNhDls+sopzqVvG9ZyOXdPI70nlo=
X-Gm-Gg: ASbGncuZZfY/bfvQwau1NdaYJoWNfvIiTGjweIp36dRGRphFfKjC9xCMpUaquc1tkog
 W/mPJHG+NURmSDQk3hwXEyKdSAYDN2Oy3gi0b3cBLUy1LryAVi2CaP8PQMoX2PVksSVOk0Gp6Sm
 NzCB4ChFwE+iCNKgxMQMQjrC20FKA+9BinAY4iN1cHYYKfeZL/1qDMwn59Uv0U/jRR5aZQl0RnL
 ki8jyaT0ao4CAjgFRfkzDtFaQaOM3JAgCBhF24+HzbqBedbU9MG3YKS
X-Google-Smtp-Source: AGHT+IEhzyzw/GujUvmQZ175kB1/DaczY+krESLk0RSe6y6HrPpdJER3rhhXF7Iqf5c1TFfCQNWsAQ==
X-Received: by 2002:ac8:5d13:0:b0:467:6226:bfbd with SMTP id
 d75a77b69052e-468f8ad51e0mr7428481cf.21.1734373818232; 
 Mon, 16 Dec 2024 10:30:18 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2c6ddf2sm30645551cf.16.2024.12.16.10.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:30:17 -0800 (PST)
Date: Mon, 16 Dec 2024 12:30:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
Message-ID: <20241216183014.GH1505244@bill-the-cat>
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cUnCnFoCX4r4B7GV"
Content-Disposition: inline
In-Reply-To: <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
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


--cUnCnFoCX4r4B7GV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> Hi Raymond,
>=20
> On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> >> >
> >> > Hi Simon,
> >> >
> >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org> wrote:
> >> >>
> >> >> Hi Raymond,
> >> >>
> >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <raymond.mao@linaro.org> =
wrote:
> >> >> >
> >> >> > Hi Simon,
> >> >> >
> >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org> wrot=
e:
> >> >> >>
> >> >> >> Hi Raymond,
> >> >> >>
> >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.or=
g> wrote:
> >> >> >> >
> >> >> >> > Get tpm event log from bloblist instead of FDT when bloblist is
> >> >> >> > enabled and valid from previous boot stage.
> >> >> >> >
> >> >> >> > Note:
> >> >> >> > This patch depends on:
> >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> >> >> >> > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@=
konsulko.com/
> >> >> >> >
> >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> >> >> > ---
> >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> >> >> >> >  1 file changed, 7 insertions(+)
> >> >> >> >
> >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> >> >> >> > index 7f868cc883..acaf0acb88 100644
> >> >> >> > --- a/lib/tpm_tcg2.c
> >> >> >> > +++ b/lib/tpm_tcg2.c
> >> >> >> > @@ -19,6 +19,7 @@
> >> >> >> >  #include <linux/unaligned/generic.h>
> >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> >> >> >> >  #include "tpm-utils.h"
> >> >> >> > +#include <bloblist.h>
> >> >> >> >
> >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr=
, u32 *active_pcr,
> >> >> >> >                       u32 *pcr_banks)
> >> >> >> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct u=
device *dev, void **addr, u32 *size)
> >> >> >> >         *addr =3D NULL;
> >> >> >> >         *size =3D 0;
> >> >> >> >
> >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !blobli=
st_maybe_init()) {
> >> >> >>
> >> >> >> Please drop the second term...the bloblist is inited by U-Boot a=
lready.
> >> >> >>
> >> >> >
> >> >> > As an independent library, from the tpm library's angle, whether =
the bloblist init was already called or not is agnostic.
> >> >> > I think this is the purpose of the "maybe" function.
> >> >>
> >> >> No. U-Boot does init at the start. We don't want each subsystem
> >> >> 'maybe' initing each other subsystem that it uses. If you want to
> >> >> check whether bloblist is available, you can use the GD flag.
> >> >>
> >> >
> >> > OK. I can use the gd instead.
> >> >
> >> >>
> >> >> >
> >> >> >>
> >> >> >> Also please drop the first term. If you find it in the bloblist,=
 just use it.
> >> >> >>
> >> >> >
> >> >> > I think here we should have the same logic as the existing one in=
 fdtdec:
> >> >> > If bloblist is not enabled or errors observed, do a fallback to t=
he original process.
> >> >> > At least I want to keep the same logic in different places before=
 everything is ready from TF-A to U-boot.
> >> >>
> >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist, nor
> >> >> should it. Nor do you need it, since you can just check the bloblist
> >> >> for what you want. If you don't find it, fall back.
> >> >>
> >> >
> >> > Since Firmware Handoff is still an experimental feature and not mand=
atory yet (at least now),
> >> > I put everything under PRIOR_STAGE to allow users to disable it by t=
heir own decisions.
> >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added a d=
ependency claim in my commit message.
> >>
> >> Yes, but even if Tom does pick his patch, which I object to, by the
> >> time your code is called, there will be a bloblist.
> >>
> >> So the end result of your test is to allow the user to ignore any TPM
> >> log in the bloblist. If that's what you want (which seems fine to me),
> >> add a Kconfig for it.
> >>
> >
> > Per my understanding of PRIOR_STAGE, it means we have a bloblist from t=
he previous stage and we want to use it (as a Transfer List).
> > If this is the case, it is not for DT only but can be applied for event=
log or anything for Firmware Handoff in the future.
> > That is the reason I use PRIOR_STAGE here, I don't think we need to add=
 another kconfig.
>=20
> Who knows what it is supposed to mean...anyway, it should not be used
> like that. The devicetree is special in that we want to get it from
> the bloblist very early, if available. Nothing else (so far) in the
> bloblist has this constraint, certainly not the TPM log.

Raymond is exactly right, and the device tree is not special. The
specialness is "do we have a valid bloblist upon entry or not". Which
means that also no, this series (since it happens late enough) shouldn't
care about if the previous stage had created it or not, merely as you
said if the tag for the TPM (or other blob) is found.

And that said, yes, I will be v2'ing what I did, in some manner or
another as it's not quite right either in terms of being clear about
what the condition is.

--=20
Tom

--cUnCnFoCX4r4B7GV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdgcbIACgkQFHw5/5Y0
tywJZQwAoVU/+Vno6+REwg13K8LJnESIk7/r+x9Ype4pyXfdJwGV4qmswwHe6zZf
I/aAPuTytcilVouixyW6SaYvEqa9Eztc3u7e59yXB7TCWLG/ssQp98d24/rfaQ67
bPDncy/Tu2VHa3qWd1OtO/R0KeFivCrXjxGhW5218ooHfe6t/Frz2TrgUSmLBrYu
mE3zJL0MuoGzk1mlzD/k9cN+zOz51KDk1XRHbvErnjlMPX19GttsftmQJ4Jltw0K
GcJ8zMHsK/CikjwU9Dmpaps7Jg8viA30T7Imu9uXIjiYh9B3piGO8Y57eboG9TjW
E99W3g+5aN39kydHuEbvqmyQ/BZmqsun683HcnkXEUtUQ1fo3iT036nJ6JyyktCn
uOgzG78PCsRRz/OfR9L2GWnfaOa7nEmwNVd+yrfi/41LemTI44ph5goX8cvcsB0i
ev8DtXPICc5AjK4sZP2Q8wkAJdJY26YtF8RZ4euXYcUaoEEYrNIVRPRUo7f41nWF
x8+kwW8s
=JlO7
-----END PGP SIGNATURE-----

--cUnCnFoCX4r4B7GV--
