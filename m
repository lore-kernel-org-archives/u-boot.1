Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D452CC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209BB800C1;
	Sun, 30 Mar 2025 16:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PY1QjFm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413548144A; Sun, 30 Mar 2025 16:45:33 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFCC80050
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c81fffd523so1147348fac.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743345929; x=1743950729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fpnrFrzuSJ3jsg7FeEv1ZG0pREdNM5FlsSFHGCqbsfA=;
 b=PY1QjFm2YVZd4Ord3WI0NgtuB+CqqQOL2lKF4gOEPZ26Vhwl4qp2OQ99ifJ57Fo0RG
 F6Kug4fyaPj5HYT61irsoY2XiKtxwuxiXQU3myXoPb8YkpNuM/C8cYtvotBBcsdQgdp5
 JJHLdKaxmIGQFucCQBIuYaD21M35cha+TqvlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743345929; x=1743950729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpnrFrzuSJ3jsg7FeEv1ZG0pREdNM5FlsSFHGCqbsfA=;
 b=KWG9T3HCb7iEGrUB3UFdy0MGKvShM0VCaDmNTR2YEUGuDa6QQidB+wmHVfpiOERHW8
 1jMNustSrVLf/AjJeCCAtMFoUj0hztCQd8ydwhxrK+5q7Dml7IPdLAgrL897g4iSsyeL
 pEPH2HXzV0a64SselysMN9qOygPbGdhQ1lQHLNAU7wn22D+iivHwqhgRbjUGOmXP7VVD
 E4wSnlVsHXTsa5tWgwaiJPLwKK1pJ/lmpBBEQSJEdy2JLnbkVrKW4QgudsaTLIJpy3Cn
 /ACk5iW/8f6MwweTrpb19UVX8K6WmhvSg5QIKnopXQlGUyyFWwhXI/ROv/8+Ujdyc7Xu
 JWLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoGjEPzg5PjUG422LgP1ApWohHJsNxxRnkbTjKoffnuLkFIJPDN2kAc0jxGpoArMm7Nl1quCU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc0fmIozZa2IZo9DAxN9mC0rn+mHitdpBjMEogThImmoGNaxsF
 a+PhmniiXksqgUoxiu4XK8qfjpvW4/ru1ucnHgcn3OHyUZQmzREUfYpIIYj0rFZg9si/60Sgj+J
 c
X-Gm-Gg: ASbGncth1WCwnKB2OZ0n099T7BtGMdSpuG4KzL7cCBmmeBIP0EfpkiFSfqBz2g/patM
 GsIboX3DKVhhFHmugSPqu9jU1FueAunx04tWSjz6p6/99ue8MnvawKgvwbRQWEeq7xliKz0ln1s
 5gM8Bbacy2EJjN2m5ZjhZMkSkDxDQP4k5QF5yu3KJRjEsU+j6x+mxEPx/46aFFvho9/pTei1fhX
 nbzU76PNaPI2iwxsBQwNNoPSNk91sEmqZ0wEK6yU6XOYlgFjME/lRUS+gqVyq4E5P1jvUHzq9s8
 q0Oc7Ll3wnv8G8sRD5vg33ovz8Yy/j/tFMsY7xY6kWM9NkdVxSK15lIrfy5PEjTD+2Nt4uCPxoU
 XmjHI13mvKSerILbH
X-Google-Smtp-Source: AGHT+IFwiDPEeEUkD0H+2BbwNmRvD/OvmeaNJYXtztzAEDbcO94idxU5Ltl0VRrK7WjcmfP4nU/Iiw==
X-Received: by 2002:a05:6870:829f:b0:2c7:6f57:3645 with SMTP id
 586e51a60fabf-2cbcf56c73cmr3109024fac.18.1743345929407; 
 Sun, 30 Mar 2025 07:45:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91391esm1389775fac.46.2025.03.30.07.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:45:28 -0700 (PDT)
Date: Sun, 30 Mar 2025 08:45:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
Message-ID: <20250330144526.GO93000@bill-the-cat>
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
 <20250327234959.GS93000@bill-the-cat>
 <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OI0s/VQOeRcMyQwU"
Content-Disposition: inline
In-Reply-To: <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
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


--OI0s/VQOeRcMyQwU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 04:44:53AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 3/20/25 4:26 AM, Simon Glass wrote:
> > > > > Hi Quentin,
> > > > >
> > > > > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
> > > > >>
> > > > >> Hi Simon
> > > > >>
> > > > >> On 3/19/25 4:03 PM, Simon Glass wrote:
> > > > >>> Hi Quentin,
> > > > >>>
> > > > >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@ch=
erry.de> wrote:
> > > > >>>>
> > > > >>>> Hi Simon,
> > > > >>>>
> > > > >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> > > > >>>>> Logging of function return-values is used very frequently in =
U-Boot now.
> > > > >>>>> Add a few helper macros to make it less verbose to use.
> > > > >>>>>
> > > > >>>>> It turns out that the log_ret() variants are not so useful, s=
ince it is
> > > > >>>>> not obviously where the error is coming from. So only the log=
_msg_ret()
> > > > >>>>> variants are worthy of these macros.
> > > > >>>>>
> > > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >>>>> ---
> > > > >>>>>
> > > > >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> > > > >>>>>     1 file changed, 26 insertions(+)
> > > > >>>>>
> > > > >>>>> diff --git a/include/log.h b/include/log.h
> > > > >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> > > > >>>>> --- a/include/log.h
> > > > >>>>> +++ b/include/log.h
> > > > >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion=
, const char *file, unsigned int line,
> > > > >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> > > > >>>>>     #endif
> > > > >>>>>
> > > > >>>>> +/*
> > > > >>>>> + * LOGR() - helper macro for calling a function and logging =
error returns
> > > > >>>>> + *
> > > > >>>>> + * Logs if the function returns a negative value
> > > > >>>>> + *
> > > > >>>>> + * Usage:   LOGR("abc", my_function(...));
> > > > >>>>> + */
> > > > >>>>> +#define LOGR(_msg, _expr)    do {            \
> > > > >>>>> +     int _ret =3D _expr;                       \
> > > > >>>>> +     if (_ret < 0)                           \
> > > > >>>>> +             return log_msg_ret(_msg, _ret); \
> > > > >>>>> +     } while (0)
> > > > >>>>> +
> > > > >>>>> +/*
> > > > >>>>> + * LOGZ() - helper macro for calling a function and logging =
error returns
> > > > >>>>> + *
> > > > >>>>> + * Logs if the function returns a non-zero value
> > > > >>>>> + *
> > > > >>>>> + * Usage:   LOGZ("abc", my_function(...));
> > > > >>>>> + */
> > > > >>>>> +#define LOGZ(_msg, _expr)    do {            \
> > > > >>>>> +     int _ret =3D _expr;                       \
> > > > >>>>> +     if (_ret)                               \
> > > > >>>>> +             return log_msg_retz(_msg, _ret);        \
> > > > >>>>> +     } while (0)
> > > > >>>>> +
> > > > >>>>
> > > > >>>> Mmmm not sure this forced return call is a good idea, this wou=
ld forbid
> > > > >>>> us from performing some unwinding for example.
> > > > >>>
> > > > >>> Yes, it is really only for simple cases. Without the return, th=
ere
> > > > >>> isn't much value and you may as well not use this macro.
> > > > >>>
> > > > >>>>
> > > > >>>> I don't really see how that is better than simply calling
> > > > >>>>
> > > > >>>> return log_msg_retz("abc", my_function());
> > > > >>>
> > > > >>> That's not the intention. It actually replaces:
> > > > >>>
> > > > >>> ret =3D my_function();
> > > > >>> if (ret)
> > > > >>>       return_log_msg_ret("abc", ret);
> > > > >>>
> > > > >>> I use this a lot in my code. You can't always just return, sinc=
e there
> > > > >>> may not be an error.
> > > > >>>
> > > > >>
> > > > >> I see, I read too fast again. Only return if it's an error.
> > > > >>
> > > > >>>>
> > > > >>>> ?
> > > > >>>>
> > > > >>>> If we were to keep this, I would recommend to rename the macro=
 and fix
> > > > >>>> the docstring because it does not only log if the function ret=
urns a
> > > > >>>> non-zero value. It does actually return.
> > > > >>>>
> > > > >>>> So something like
> > > > >>>>
> > > > >>>> LOGZ_AND_RETURN(_msg, _expr)
> > > > >>>>
> > > > >>>> maybe?
> > > > >>>
> > > > >>> Sure, longer names are easier to learn, but then it is so long =
I doubt
> > > > >>> anyone would use it.
> > > > >>>
> > > > >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused =
with
> > > > >>> log_ret() and log_retz(), which I am actually thinking of delet=
ing.
> > > > >>>
> > > > >>> I would like the shortest possible name to avoid spilling funct=
ions
> > > > >>> onto the next line all the time.
> > > > >>>
> > > > >>
> > > > >> It should be absolutely obvious from the macro name that this ca=
n in
> > > > >> fact return because missing to unwind code is among the things
> > > > >> developers typically easily miss already, so with this macro it'=
ll be
> > > > >> even easier to forget about undoing things.
> > > > >>
> > > > >
> > > > > Yes that's true. We don't have a huge amount of tests for this 'u=
ndo'
> > > > > code either. I would bet that a code-coverage map would show that.
> > > > >
> > > >
> > > > Yeah but that's not a reason to make it even harder to spot issues =
in
> > > > the undo code :)
> > >
> > > I suspect people will just have to learn the macros, as they have with
> >
> > I would ask "What kernel construct have people already learned and we
> > can adapt inside the macro?".
>=20
> Is there such a thing?

Likely so. This isn't some new and novel problem, and it's likely more
people have put thought in to this and come up with something well
reviewed there.

--=20
Tom

--OI0s/VQOeRcMyQwU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfpWQIACgkQFHw5/5Y0
tyxsSwv/SZWHORSW5YazitRQQja+dL7gOCJIc/yKMbBmv1kxKF1zR0n74imy+cZY
BqrsKQ+ixma6XBepuTmXvk/XbSklNfh0Q9CrmEsr0dC0JTkurigvp5CjBglucPNr
gJj07DwcIpnDYn4cLrbkFVDoRPXwFKhGsKUWqidggv1eHlKeBAg/j5A3U3xi/WB3
Iu0sc/0HK5ctw7VTyS4zuJiE1hEnPR5ePNOdRbnGNDiqKNkGJAqfr7/NbkcclX1V
0zJlFa1Qdo3mCnnrdtTNK7XnKWjJWFSdXOACgIaCoXNx8sse0EdR/Z5e22MqwyD5
34WyZBFVV4ATIdL12Xqm3SC80ikC3Nl0vFiJjvp0E+/eYD1ZrviMXGO0fCSREu7u
BCWDihxI7QQ/jHLkVeAEYz8O7DyIAAoDY7e2liaL/tHAc227Qu9mDY1AcxCH/sKO
JU1tIXpDUBTus/vXKgn9N94erjAqyTDql0Rwk9KIQr0NTBLyKlwchaZpQvmFHH13
od4OQYVz
=UzdP
-----END PGP SIGNATURE-----

--OI0s/VQOeRcMyQwU--
