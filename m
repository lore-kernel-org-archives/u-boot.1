Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB4C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4C381E5B;
	Tue,  1 Apr 2025 19:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FwIaCO0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF51981F59; Tue,  1 Apr 2025 19:19:39 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5146381703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bd78e695dso1859101a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743527976; x=1744132776; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UMNhpBlDfFMuxlk/GldUV5lkcGdtOmxvcExynMYn1+E=;
 b=FwIaCO0YWp4FUU7vIThZYn/fi2gs5oRqAzp898Ahdx2a6HcCZNVXpKVWoS9KVOf2yu
 lRlbDl+viPlzBQC7DD1uZ16ZrCbosV25wlJ8P3NFo9hEx9hs+qboMAC7BLWT/5IsZey4
 EqzjeIQnilR8d5GMgOE2IdwtYimfLS6Oq6Ug0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743527976; x=1744132776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMNhpBlDfFMuxlk/GldUV5lkcGdtOmxvcExynMYn1+E=;
 b=pmr0YrrpuOiEZfKEbGqR/DnsimufR4+JP+pDi7b5qTbojrVvh3PHrID4MOjHWhlDEr
 c/MFC8QyQd5XDWnN0sfllz0aqxEc5N50hgITpHQJVUCfYdbClx0YMnVhaVdIGJcM5oFh
 LrjFXq+EPtwOdvL94XR3KN41HMDGqv0zYLzXrH2QOGDUNJvhv1EGveEeRjjOEIlHvrv5
 Wo07fc6w0h0YU3nTIeMK5a8B/qRUobQ6O/D19CHOvSthc/ywUUBgUfw4N1arES52DZov
 ScRjiyXvWbDLIDaKTQltShKUu9OyyGErv/4eAZyTJkmN4JGPh1GwAP8vWkcvJJTekRfX
 lQVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIJ8Csj0uJqRtU1JfRudlyzdra+3LhXEMelRWMUtnszkuPddLYmhLhNJCKYoPqofXc28UKls8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe1ui39QUeZoqDGK9lg1Gk0CHk7L28Kqp/kGKUNwGDy81YRITw
 ZfVCrIUXdWXRKN2Zcf88ja+5/RPzZ2vpoShJ0WLE2vCI2Uy3M0iHb4UEkf78aH40hLWWddwEWyg
 S
X-Gm-Gg: ASbGnct5ARs/mVED/RHLaXord48KsG8Fj3KGC9HrGa/75V4JXBYi+JQWtkTE/pxgewm
 4OsCrReKHdKv31YrKjD6jw2v4lULm3q0fOv1S7sLcDKhVuQReGDq/GYFdUVsbtWT4+OICZ1IEkU
 kHDpqRtjSZGXvWZg1dr11JaqGC0TENK+BlESLgTXHxaDLzAHiCQlId8xzG7OSM2R4QxORecRl51
 qKwmVnjpeV7nqjRpzDph83VARbnFxS95c1Pttbp0V4YW73JQ0mgqrfy8eQZcJBQVk2IFamuri4T
 CtSw29ByKoK9MG3X9NRqofL6yupjwXsgCa/czKFNkmaMx/nXL5mM3oruHrNRaicGZDBr3x/QTNf
 QhieEXueSUKlIp+lU
X-Google-Smtp-Source: AGHT+IFzzOSCUkH4Fgpc2SufdZWlnUTvmqx0Q/E6CFP2iTx+zGsJACY8oV4DIi5iyMFFwvou85TABg==
X-Received: by 2002:a05:6830:418a:b0:72b:9965:d997 with SMTP id
 46e09a7af769-72c6381de0fmr8952276a34.18.1743527975969; 
 Tue, 01 Apr 2025 10:19:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580cc609sm1906856a34.29.2025.04.01.10.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:19:35 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:19:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
Message-ID: <20250401171933.GN5495@bill-the-cat>
References: <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
 <20250327234959.GS93000@bill-the-cat>
 <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
 <20250330144526.GO93000@bill-the-cat>
 <CAFLszTjNwtmBqiDUQZPChXYMQei2spTMobZvAu3cQeMfJwNkkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NMsEBnaZCArYt5Yt"
Content-Disposition: inline
In-Reply-To: <CAFLszTjNwtmBqiDUQZPChXYMQei2spTMobZvAu3cQeMfJwNkkw@mail.gmail.com>
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


--NMsEBnaZCArYt5Yt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:48:35AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 04:44:53AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> > > > > Hi Quentin,
> > > > >
> > > > > On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On 3/20/25 4:26 AM, Simon Glass wrote:
> > > > > > > Hi Quentin,
> > > > > > >
> > > > > > > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> > > > > > >>
> > > > > > >> Hi Simon
> > > > > > >>
> > > > > > >> On 3/19/25 4:03 PM, Simon Glass wrote:
> > > > > > >>> Hi Quentin,
> > > > > > >>>
> > > > > > >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schul=
z@cherry.de> wrote:
> > > > > > >>>>
> > > > > > >>>> Hi Simon,
> > > > > > >>>>
> > > > > > >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> > > > > > >>>>> Logging of function return-values is used very frequently=
 in U-Boot now.
> > > > > > >>>>> Add a few helper macros to make it less verbose to use.
> > > > > > >>>>>
> > > > > > >>>>> It turns out that the log_ret() variants are not so usefu=
l, since it is
> > > > > > >>>>> not obviously where the error is coming from. So only the=
 log_msg_ret()
> > > > > > >>>>> variants are worthy of these macros.
> > > > > > >>>>>
> > > > > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >>>>> ---
> > > > > > >>>>>
> > > > > > >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> > > > > > >>>>>     1 file changed, 26 insertions(+)
> > > > > > >>>>>
> > > > > > >>>>> diff --git a/include/log.h b/include/log.h
> > > > > > >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> > > > > > >>>>> --- a/include/log.h
> > > > > > >>>>> +++ b/include/log.h
> > > > > > >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *asser=
tion, const char *file, unsigned int line,
> > > > > > >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> > > > > > >>>>>     #endif
> > > > > > >>>>>
> > > > > > >>>>> +/*
> > > > > > >>>>> + * LOGR() - helper macro for calling a function and logg=
ing error returns
> > > > > > >>>>> + *
> > > > > > >>>>> + * Logs if the function returns a negative value
> > > > > > >>>>> + *
> > > > > > >>>>> + * Usage:   LOGR("abc", my_function(...));
> > > > > > >>>>> + */
> > > > > > >>>>> +#define LOGR(_msg, _expr)    do {            \
> > > > > > >>>>> +     int _ret =3D _expr;                       \
> > > > > > >>>>> +     if (_ret < 0)                           \
> > > > > > >>>>> +             return log_msg_ret(_msg, _ret); \
> > > > > > >>>>> +     } while (0)
> > > > > > >>>>> +
> > > > > > >>>>> +/*
> > > > > > >>>>> + * LOGZ() - helper macro for calling a function and logg=
ing error returns
> > > > > > >>>>> + *
> > > > > > >>>>> + * Logs if the function returns a non-zero value
> > > > > > >>>>> + *
> > > > > > >>>>> + * Usage:   LOGZ("abc", my_function(...));
> > > > > > >>>>> + */
> > > > > > >>>>> +#define LOGZ(_msg, _expr)    do {            \
> > > > > > >>>>> +     int _ret =3D _expr;                       \
> > > > > > >>>>> +     if (_ret)                               \
> > > > > > >>>>> +             return log_msg_retz(_msg, _ret);        \
> > > > > > >>>>> +     } while (0)
> > > > > > >>>>> +
> > > > > > >>>>
> > > > > > >>>> Mmmm not sure this forced return call is a good idea, this=
 would forbid
> > > > > > >>>> us from performing some unwinding for example.
> > > > > > >>>
> > > > > > >>> Yes, it is really only for simple cases. Without the return=
, there
> > > > > > >>> isn't much value and you may as well not use this macro.
> > > > > > >>>
> > > > > > >>>>
> > > > > > >>>> I don't really see how that is better than simply calling
> > > > > > >>>>
> > > > > > >>>> return log_msg_retz("abc", my_function());
> > > > > > >>>
> > > > > > >>> That's not the intention. It actually replaces:
> > > > > > >>>
> > > > > > >>> ret =3D my_function();
> > > > > > >>> if (ret)
> > > > > > >>>       return_log_msg_ret("abc", ret);
> > > > > > >>>
> > > > > > >>> I use this a lot in my code. You can't always just return, =
since there
> > > > > > >>> may not be an error.
> > > > > > >>>
> > > > > > >>
> > > > > > >> I see, I read too fast again. Only return if it's an error.
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>> ?
> > > > > > >>>>
> > > > > > >>>> If we were to keep this, I would recommend to rename the m=
acro and fix
> > > > > > >>>> the docstring because it does not only log if the function=
 returns a
> > > > > > >>>> non-zero value. It does actually return.
> > > > > > >>>>
> > > > > > >>>> So something like
> > > > > > >>>>
> > > > > > >>>> LOGZ_AND_RETURN(_msg, _expr)
> > > > > > >>>>
> > > > > > >>>> maybe?
> > > > > > >>>
> > > > > > >>> Sure, longer names are easier to learn, but then it is so l=
ong I doubt
> > > > > > >>> anyone would use it.
> > > > > > >>>
> > > > > > >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confu=
sed with
> > > > > > >>> log_ret() and log_retz(), which I am actually thinking of d=
eleting.
> > > > > > >>>
> > > > > > >>> I would like the shortest possible name to avoid spilling f=
unctions
> > > > > > >>> onto the next line all the time.
> > > > > > >>>
> > > > > > >>
> > > > > > >> It should be absolutely obvious from the macro name that thi=
s can in
> > > > > > >> fact return because missing to unwind code is among the thin=
gs
> > > > > > >> developers typically easily miss already, so with this macro=
 it'll be
> > > > > > >> even easier to forget about undoing things.
> > > > > > >>
> > > > > > >
> > > > > > > Yes that's true. We don't have a huge amount of tests for thi=
s 'undo'
> > > > > > > code either. I would bet that a code-coverage map would show =
that.
> > > > > > >
> > > > > >
> > > > > > Yeah but that's not a reason to make it even harder to spot iss=
ues in
> > > > > > the undo code :)
> > > > >
> > > > > I suspect people will just have to learn the macros, as they have=
 with
> > > >
> > > > I would ask "What kernel construct have people already learned and =
we
> > > > can adapt inside the macro?".
> > >
> > > Is there such a thing?
> >
> > Likely so. This isn't some new and novel problem, and it's likely more
> > people have put thought in to this and come up with something well
> > reviewed there.
>=20
> What are you referring to here? I am not seeing anything in Linux
> related to this.

Then it's probably more pain than help in getting everyone to write code
that handles wind/unwind/logging consistently and correctly and no we
shouldn't wrap this up in some macro.

--=20
Tom

--NMsEBnaZCArYt5Yt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsICUACgkQFHw5/5Y0
tyzXyAv/V4E0sLjQ26PpsOusc9bbpC8iRhJNi/Fr/R62y0ZyydTw6/vfP9OvBAqC
KnFl63+dTdzQHAyRV3qHS/4Lvfwg6GXS6NSI3DH1TQo6K2iwcYlOsOIbhV+9eIHW
/rWv8o8RKxbW/RmC5pZhe+4FS/ejgVe3GCXwznNU+Ri+UVxoE/sCziRT6oplIFFx
Nng2qtpXBq97EEGfA9Oqwd1/Zs0Opyv0PRKWqswHzKmGODm15OEGXKmwu6Sll63+
Z2vy936+K/QzW+/M3l/k8ECJ3k1Q0YMSiKPjYduuQ6+3cEvt2jVx8Abf2Gu0lcRX
1ur5uHxnmvDkIW4yaNeSev3g6JF5CiSWQxJ1qHYwTvHffS//eJHQoDQ3wMe2BOAs
6bIM3qFoGqVJ+VmSycmDfLxIjHZ2itMcGSMKrpwkNshT2A7Fn2/+ezX+3aNJCo/d
slullkF3HcKf5EHMj4nZNWBleXXPS4oDP8FkmmYRSAzXDg03hlQBhxD+SrHIu8q2
BeIh5yIa
=vwSw
-----END PGP SIGNATURE-----

--NMsEBnaZCArYt5Yt--
