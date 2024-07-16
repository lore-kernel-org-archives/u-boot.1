Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DB7C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 18:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E05D889FD;
	Tue, 16 Jul 2024 20:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N5dklpHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6BC889EB; Tue, 16 Jul 2024 20:00:27 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792AD88939
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 20:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-70368b53cc0so2987781a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721152823; x=1721757623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tfMP/IOYj+6tQTjdKSOFmgUSZdP5iBu7St0So2Hnc1E=;
 b=N5dklpHSut21s1ESIPrXxLm8pcSS7ILvkyjD99ZpZL1H1MeuK3QPxuJO62TMUvclb/
 ji/RgjivfuQHlay1Bs2PQV6uONEPssy7gCUR6GnsmCo3YbgyhucEGibPVk3RFxlcK0gL
 hN0c6DUxsP6lqfxzZp4uMhwyy2WCojbGE4p0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721152823; x=1721757623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfMP/IOYj+6tQTjdKSOFmgUSZdP5iBu7St0So2Hnc1E=;
 b=UthRdjv/s8QdbYIzbAyd2wMSiU8MPmcY0zM7OfJAlvthlilexyRF1z5+lYwVzcDbVo
 v6XWsPXEdjecxNgwT65iE17CluF7YcJmuOZ288C8zpTjzM1NJ+aFBUEHBTJkF1Fm+EUC
 ABaUtNbSTNgZqej4eJxG+8q9SX33K5V6TajScpNXzvOwQCt8P7TV84ii48Ln6YTawlVg
 64aM7aJvuA51d1t5xexOGNlxyOg/HugZ+j/L26//FakiwvN01Gf6md4BEpII5peS4Vhl
 W/tXY0oFC0wNnF4wHn8Eq9vZbwbhQPGTw+kq8ktF/PHzMVC4mSHxOFX+8aZHBhXygeRC
 90Ag==
X-Gm-Message-State: AOJu0YyDTj5vlgzG0kA+DPtO8yMGVzI3XXKfkJst5XXx7SpX6zi53+DY
 P4sbYeHHoQ61CqsM7Lgkmw5arTY3KgQzFxTsnaqOoBdvH+WMjYgNpMIgQxqDUTNsdTBPiG8hr+e
 o
X-Google-Smtp-Source: AGHT+IHnxvrlfipvi67EBmnOrknbbZDZuvsIj47eqXXPtx31bbyu0aF3Y4qlKUsNcnnZ6yGLGcqMFA==
X-Received: by 2002:a05:6870:1258:b0:25e:b632:b772 with SMTP id
 586e51a60fabf-260bdddbb9fmr1766298fac.28.1721152822889; 
 Tue, 16 Jul 2024 11:00:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260750db105sm1441444fac.12.2024.07.16.11.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 11:00:22 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:00:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: u-boot@lists.denx.de, barebox@lists.infradead.org, s.hauer@pengutronix.de
Subject: Re: Various Integer Overflows in dlmalloc
Message-ID: <20240716180020.GH561963@bill-the-cat>
References: <2561107.TLnPLrj5Ze@somecomputer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="176EOECzmln74KwL"
Content-Disposition: inline
In-Reply-To: <2561107.TLnPLrj5Ze@somecomputer>
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


--176EOECzmln74KwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 11:16:27AM +0200, Richard Weinberger wrote:
> Hi!
>=20
> While inspecting various security aspects of U-Boot I noticed some
> issues around dlmalloc and asking for your feedback, especially for the
> first issue.
> I'm CC'ing Barebox folks since Barebox seems to be based on the same
> dlmalloc-implementation as U-Boot does.

Thanks for digging in to all of this.

> 1. Integer Overflow While Computing Allocation Size
>=20
> malloc/realloc/memalign take an arbitrary request size and apply
> padding.
>=20
> First, the length is (imperfectly) checked and the the conversion happens:
>=20
>   if ((long)bytes < 0) return NULL;
>=20
>   nb =3D request2size(bytes);  /* padded request size; */
>=20
> The problem is that the request2size() macro is casting the requested
> size to an signed long and adds SIZE_SZ + MALLOC_ALIGN_MASK:
>=20
> #define request2size(req) \
>  (((long)((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) < \
>   (long)(MINSIZE + MALLOC_ALIGN_MASK)) ? MINSIZE : \
>    (((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) & ~(MALLOC_ALIGN_MASK)))
>=20
> So, any allocation request between LONG_MAX - (SIZE_SZ + MALLOC_ALIGN_MAS=
K) - 1 and LONG_MAX
> will cause an overflow and as a consequence the caller will get
> less memory than requested.
>=20
> e.g. on an 32bits system malloc(2147483647) will succeed but allocates
> only 16 bytes (MINSIZE). I've tested this with U-Boot on i386 and ARM.
>=20
> This is a beefy vulnerability for exploit writers since unbound allocatio=
ns
> do happen. Like in the ext4 and squashfs symlink code, I'm sure there are=
 more.
> If you don't care about verified boot, it's less of an issue, though.
>=20
> I'm not so sure what the best fix is.
> Mostly because I'm not sure why request2size() is anyway casting to long.
> The original dlmalloc.c implementation doesn't do so. It has also a more
> sophisticated overflow check, which is also missing in both U-Boot and Ba=
rebox.
> See https://research.cs.wisc.edu/sonar/projects/mnemosyne/resources/doc/h=
tml/malloc-original_2src_2dlmalloc_8c-source.html
> Lines 01938 to 01962.
>=20
> I tracked down the bug to ppcboot, it's there since day 0.
> So I don't know what's the intention behind casting.
>=20
> On the other hand, since over commit is not supported, we could also just=
 fail
> if the requested size is larger then the total amount of system memory.
> I'm a little in fear that more overflows are lurking in the code.

The "why" is likely lost due to time and I could only speculate and wave
my hands about funny compiler issues at the time. Since we don't support
overcommit, I'd be inclined to go with just failing if we're exceeding
SYS_MALLOC_LEN.

> 2. Integer overflow in sbrk() (U-Boot only)
>=20
> sbrk() does:
>         ulong new =3D old + increment;
>=20
>         /*
>          * if we are giving memory back make sure we clear it out since
>          * we set MORECORE_CLEARS to 1
>          */
>         if (increment < 0)
>                 memset((void *)new, 0, -increment);
>=20
>         if ((new < mem_malloc_start) || (new > mem_malloc_end))
>                 return (void *)MORECORE_FAILURE;
>=20
>=20
> If old + increment overflows (increment is a ptrdiff_t) then
> sbrk() wrongly thinks we're shrinking the heap and memsets an invalid
> range.
>=20
> I propose as solution, applying memset() after the range check.

OK, sounds good.

> 3. Wrong ptrdiff_t type (U-Boot only)
>=20
> U-Boot defines __kernel_ptrdiff_t to int for both i386 and x86_64.
> As a consequence, large allocations on x86_64 will overflow the increment
> parameter of sbrk() and less than requested is allocated.
> I suggest defining __kernel_ptrdiff_t on x86_64 to long.

OK, sounds good.

--=20
Tom

--176EOECzmln74KwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWtTAACgkQFHw5/5Y0
tywoIwv/TrYUuDq4c9Ols9IwfRrYB6aXPo9UqhTEex3NS/YbNWf9UnXvRoculZTq
KwPdnX7hK285DOTwY3FX/mnpGtfiyqB8ZG1gboVX+0G3T4NRU2NmZN/p3RBp04sF
hhfiBgarsJSngvfZi2W3dTF2aC4vCIXaSRRRGzMOUKavbt5cNSFH5ElKo0C6TjFh
YbscSPJANoisHe550tpXF8sDxktGb2DnJ45oixy/MYpIwGJWfOYHFMgqQgNV/mbs
asCJ60TeMQ4GiE1xstLSlXw4JYSafx6y2anOOfAkJ82lMElB+eAhq58bYTTS4iQL
foWLnJwe5ydSq7cDmh4cSKE7hnhLvQoXJBYRPa8T1lkfMPBIh9Oa4rim9QGAyHQs
ooCzOzFUv72Rw3ty4o4IwMuyijvOLnE1umn6EPPMXCw7uBbIjYSQwPF6Xwzslx3G
1xsGbk70fQy3SM50zP/HLQSQqkUAC3irw+MKSNbOdJjzsxw01SV3cI1rtOiGATDf
QjlAgR68
=M2Ik
-----END PGP SIGNATURE-----

--176EOECzmln74KwL--
