Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEAFC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 23:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA37810EA;
	Fri, 28 Mar 2025 00:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mLSSx2y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA66810F4; Fri, 28 Mar 2025 00:50:06 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F628070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 00:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c09f8369cso423368a34.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743119402; x=1743724202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u3aPukSGvY5k3yWCWv63F60dWWx/8dTzOrF/pWbS790=;
 b=mLSSx2y1JgMXJP1JTuZQXq1fOfachflOiSpYvK2tDjssThKRXmiHN+Y+r1kA+xArkA
 r0WHI5y6wEe7mxhCfw0XdCh2l1n7lFQl5OYF5VOp4Zm3qZfj/o7DDAY+4uzaU5APMzuk
 NrLVGR47Kx7mBnqgQGLsBAmT80BO91GQoz0dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743119402; x=1743724202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3aPukSGvY5k3yWCWv63F60dWWx/8dTzOrF/pWbS790=;
 b=Y6HHsozT/YC5N7meDaIxUrLz1pFwWxrWBLPJrEXfnDy/LZ+fNeSQ8AgRouYRqJfrn6
 1jByGRClaIdd2D+6PCvEEaESMo9BVVMwLJPVADBi4pNrJdmGkEka8ELYfSbOJgcSJzYW
 v7Ms73ektGXtNcPEQ1Pn649YDf04nBh686jdAAq8zkmUupFfTGEco64DV3C25Tb2XGnD
 7ikM5JXHowoK/Jk+mAyomh0VNr1dfQyQB64tC/KeueYMB/7yJy9/WQJHB0kzc30gpoFw
 VAPT3tFKieNXkY6b8CYkJ5o2ZkOqJmMeJ79LipTytKVhqn/uP27Ug9+EKyeYEuVvtPih
 UoQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVfI7vSHRgkb9Al5nhuo+0p+OrKzBbHLu01v796Zu3G5nzjNMwXAljUIaFOv/natQiM15poe8=@lists.denx.de
X-Gm-Message-State: AOJu0YxyPjM8FCjqse9wlWQduaEq9fM2u4fzK5jSQlFbH31lIj49h9sN
 AMdNZWSJ92iBgGewmeIn3/wOUIQ0GWXKDDNE/LWphWFC0rx3ZSDgWn4RhYMeJlA=
X-Gm-Gg: ASbGnctcZbYPell3NcUmcOlft5+iem/DpIoqtAzDCN9T4kBHCTyqK3dWhtnM0uvMzee
 rI3CfQ67aH4VpmftWb1Dhvjp10R+MtmBO5UreIGQbCs6Yn4H7O3Uu0J1ErWcxtnx5m+lmX9Qt0H
 PnyR6WlZpfGrNELFHE39BU+CnaA5vgqoKBMDbcPv8B6Qd88fyEbWAnMtPtD75Aiys8vaK7k57iX
 axsEOJXNploq/aMGxB9lu2K/wKAiFZzFk4XKK764P5/WjR/FnR39qtPqiGZ5rvOTLqL+G4GoRuk
 j4WkvYODNUwPVupwev16LiQBE/BkTpG/LI9PO96T2xeqw46ilyn2LHPV/dG2JVeYrhQoe2on8AI
 ADDpeKA==
X-Google-Smtp-Source: AGHT+IGjLQ/3Y8bL+epbyCnzKMSw25s9rCDcDumlLIEpCbZ1kheI5Nj306A0Pwn4CHd3HU3KjzLp6g==
X-Received: by 2002:a05:6830:6c0e:b0:727:3439:5bec with SMTP id
 46e09a7af769-72c4c9f1998mr4202757a34.15.1743119401935; 
 Thu, 27 Mar 2025 16:50:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580fa72fsm173811a34.41.2025.03.27.16.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 16:50:01 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:49:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
Message-ID: <20250327234959.GS93000@bill-the-cat>
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nh3HXs3fPXyo8zyo"
Content-Disposition: inline
In-Reply-To: <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
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


--nh3HXs3fPXyo8zyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> Hi Quentin,
>=20
> On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> >
> > Hi Simon,
> >
> > On 3/20/25 4:26 AM, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > >>
> > >> Hi Simon
> > >>
> > >> On 3/19/25 4:03 PM, Simon Glass wrote:
> > >>> Hi Quentin,
> > >>>
> > >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry=
=2Ede> wrote:
> > >>>>
> > >>>> Hi Simon,
> > >>>>
> > >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> > >>>>> Logging of function return-values is used very frequently in U-Bo=
ot now.
> > >>>>> Add a few helper macros to make it less verbose to use.
> > >>>>>
> > >>>>> It turns out that the log_ret() variants are not so useful, since=
 it is
> > >>>>> not obviously where the error is coming from. So only the log_msg=
_ret()
> > >>>>> variants are worthy of these macros.
> > >>>>>
> > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>>>> ---
> > >>>>>
> > >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> > >>>>>     1 file changed, 26 insertions(+)
> > >>>>>
> > >>>>> diff --git a/include/log.h b/include/log.h
> > >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> > >>>>> --- a/include/log.h
> > >>>>> +++ b/include/log.h
> > >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, co=
nst char *file, unsigned int line,
> > >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> > >>>>>     #endif
> > >>>>>
> > >>>>> +/*
> > >>>>> + * LOGR() - helper macro for calling a function and logging erro=
r returns
> > >>>>> + *
> > >>>>> + * Logs if the function returns a negative value
> > >>>>> + *
> > >>>>> + * Usage:   LOGR("abc", my_function(...));
> > >>>>> + */
> > >>>>> +#define LOGR(_msg, _expr)    do {            \
> > >>>>> +     int _ret =3D _expr;                       \
> > >>>>> +     if (_ret < 0)                           \
> > >>>>> +             return log_msg_ret(_msg, _ret); \
> > >>>>> +     } while (0)
> > >>>>> +
> > >>>>> +/*
> > >>>>> + * LOGZ() - helper macro for calling a function and logging erro=
r returns
> > >>>>> + *
> > >>>>> + * Logs if the function returns a non-zero value
> > >>>>> + *
> > >>>>> + * Usage:   LOGZ("abc", my_function(...));
> > >>>>> + */
> > >>>>> +#define LOGZ(_msg, _expr)    do {            \
> > >>>>> +     int _ret =3D _expr;                       \
> > >>>>> +     if (_ret)                               \
> > >>>>> +             return log_msg_retz(_msg, _ret);        \
> > >>>>> +     } while (0)
> > >>>>> +
> > >>>>
> > >>>> Mmmm not sure this forced return call is a good idea, this would f=
orbid
> > >>>> us from performing some unwinding for example.
> > >>>
> > >>> Yes, it is really only for simple cases. Without the return, there
> > >>> isn't much value and you may as well not use this macro.
> > >>>
> > >>>>
> > >>>> I don't really see how that is better than simply calling
> > >>>>
> > >>>> return log_msg_retz("abc", my_function());
> > >>>
> > >>> That's not the intention. It actually replaces:
> > >>>
> > >>> ret =3D my_function();
> > >>> if (ret)
> > >>>       return_log_msg_ret("abc", ret);
> > >>>
> > >>> I use this a lot in my code. You can't always just return, since th=
ere
> > >>> may not be an error.
> > >>>
> > >>
> > >> I see, I read too fast again. Only return if it's an error.
> > >>
> > >>>>
> > >>>> ?
> > >>>>
> > >>>> If we were to keep this, I would recommend to rename the macro and=
 fix
> > >>>> the docstring because it does not only log if the function returns=
 a
> > >>>> non-zero value. It does actually return.
> > >>>>
> > >>>> So something like
> > >>>>
> > >>>> LOGZ_AND_RETURN(_msg, _expr)
> > >>>>
> > >>>> maybe?
> > >>>
> > >>> Sure, longer names are easier to learn, but then it is so long I do=
ubt
> > >>> anyone would use it.
> > >>>
> > >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> > >>> log_ret() and log_retz(), which I am actually thinking of deleting.
> > >>>
> > >>> I would like the shortest possible name to avoid spilling functions
> > >>> onto the next line all the time.
> > >>>
> > >>
> > >> It should be absolutely obvious from the macro name that this can in
> > >> fact return because missing to unwind code is among the things
> > >> developers typically easily miss already, so with this macro it'll be
> > >> even easier to forget about undoing things.
> > >>
> > >
> > > Yes that's true. We don't have a huge amount of tests for this 'undo'
> > > code either. I would bet that a code-coverage map would show that.
> > >
> >
> > Yeah but that's not a reason to make it even harder to spot issues in
> > the undo code :)
>=20
> I suspect people will just have to learn the macros, as they have with

I would ask "What kernel construct have people already learned and we
can adapt inside the macro?".

--=20
Tom

--nh3HXs3fPXyo8zyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfl5BsACgkQFHw5/5Y0
tywbBgv/Yio18p88z81/0VY8OS0rocTsHB1+RjR1QtJyo0EgBAXt9oXsscuw7dNx
icpEAYuI2HosATi7sYl9s2kJX6gLe2iCr0NnTe0vn5k+pYINc6pDyUjuCGS6ONBb
SpGcB+zGfPonV14tmVu4fsLC4+9IdTK5V9ylkEbe/dqYnY1CNSAtbXt+8xQR/qJX
X6lC3c6q3oxfwTQCP30wE0CIGM4XDTxmwc0blficOh1v9o7RCEEW2ZQFg31AjRd3
jQMq7o5a8MpCAx75q84EydGD2G6CFB/Uh3/jZRzZD/Uc1VMAHewn5hI7gWBwFgkV
gX8Eg5xPw1wavlmFfKWvW4SOBD4tPMFnWWhcb7y1DD009w1iIMNGBzkjOvJB6xRH
oJ1GFFfhoRB2x0/gOf2Tpf6TOSw2qELaAmBFCvh7eGLSAp/Ab2uAGXLQY9qJXVgU
Bf+6TIOwaumWEvtq0j2deGXc8JSKj9xc3sHFSzrl07CHeIkEyuURgnkP9oWBRhxZ
iJRrKHQ9
=N8Sv
-----END PGP SIGNATURE-----

--nh3HXs3fPXyo8zyo--
