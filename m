Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56044C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 14:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FABE84942;
	Mon, 29 Jun 2026 16:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dn8a+2zy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBBE84994; Mon, 29 Jun 2026 16:29:07 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0289C84931
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a0b1edbe32so2886162eaf.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782743337; x=1783348137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/v9wyUhvLUnKWvEwY+thX4ENTYGyoEY6zt+lVxhwsjQ=;
 b=Dn8a+2zyWIiWWm+k3AM0OWxQ052D96aN/phNaHKW/f9EAfF4S09gvRYl+9W2IS5WA1
 mexLxAN9PaBKZy4eWnSJ9j6Y/FrOy813RtYuSd7649lC1ANrfj9YhIG31FresKV4xjy0
 BYjQqgNjWEBsok1RTw7IepJ4MRGBc08CZ9460=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782743337; x=1783348137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/v9wyUhvLUnKWvEwY+thX4ENTYGyoEY6zt+lVxhwsjQ=;
 b=dUGqprUiM2vl9zEh0KVfGEf2M9rqhpXo0AcD/CsTkQ9d93rgzRJ9AETfdJekXXWg0F
 p7c3wi3AigobvSX5UohnBXntY65NS0lKCoX4oVg0DnMiSwiOEKL1tVJbyoLodpeqgNAc
 YhAccMyz9JP3v/rL10Felu78NUHGox4XrgDPzLQwDCvxrmbrT4TXbiYankaV7DORdAkE
 Tga0rY3lDQsxAxqxPj4+h5MxS98zJY/ru+YEpI2QJl69S+dAISBakCYSRiVLn3DGW94W
 3yQW7DHlW3VtCpcrNJPkdCO2uh0PeKANtvQyDNCNHRuMTJlIjHSp7FxwzWvQddvEG8Mh
 aPMw==
X-Gm-Message-State: AOJu0YzyQSpxoKZiyQjLgxReFBWfD8zBlIZvoNUf9FGkgsk+tqmkJciA
 VBqHlnk08McMg+gZqiyFjPPLHAkQF+AYXZD3wp5S18wbo7gDap+XlELFPg3nz9+ciPY=
X-Gm-Gg: AfdE7cm0Ztlvtp/5EnNU5c0oYEgy186h30Kk9sZL3J9dl6izrFzSP9waGwWSw6gTse/
 XtgtGpZYPkimz3h4muH5aIC5UbYdiR7k2SYvnyAFSUDg1uEBqI5N9U5TMEd06dolRq5W/pafVdN
 PisTPvVIF5MktycbieNrU0IU/0uKsbrvB5P2ejxdCZ9eVq0AUwUxmhjhxbWEvKqLGIahBn4XLC+
 mxO3pqHtUeL0Yt6anmhO0ZrrQQa4SqW/zHMABW2jQmW5hwS31hj55mwNFHhdqJxggvLvpmCx8Vi
 nHh+NcIlv3201VPymTuGI0uiwUj05Cq35idg2IpywmJhCpou9t9N5Rf1v1YB45HLvtqHdWs2VBt
 6Tr2in1exFff79Zt72lQ875KWH3ggDB4nQT0ifvtXfLQNxS4LTZc+ubEK56dtsdseAXm7EeQR8U
 g+vTSdGD7Bj3HTjh5R+bXIw1gB5QiX5/RUU+8IF0p1Whf+DvzZvt+cz2Ve4zzy8ZAtBytNokV20
 9/6KBw9d5mMeJbO5BrLcDpknF4g9hRT2Dyu8BVM
X-Received: by 2002:a05:6820:1843:b0:6a1:57ff:1fd5 with SMTP id
 006d021491bc7-6a18502892dmr487902eaf.47.1782743337589; 
 Mon, 29 Jun 2026 07:28:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ec52815sm22211324fac.1.2026.06.29.07.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:28:56 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:28:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>, Leo Liang <leo.liang@sifive.com>,
 Tim Ouyang <tim609@andestech.com>
Cc: u-boot@lists.denx.de, git@amd.com, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>
Subject: Re: [PATCH v2] riscv: Skip riscv_cpu_setup() when CPU driver is
 disabled
Message-ID: <20260629142851.GE382693@bill-the-cat>
References: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
 <967b6d66-15f2-4e5c-9de9-3c530700cd05@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mDgEhaaBiiDvBk8C"
Content-Disposition: inline
In-Reply-To: <967b6d66-15f2-4e5c-9de9-3c530700cd05@amd.com>
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


--mDgEhaaBiiDvBk8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 11:00:40AM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 5/11/26 10:31, Michal Simek wrote:
> > Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
> > instead of plain ifdef"), add an early return in riscv_cpu_setup() when
> > CONFIG_CPU is not enabled. This allows platforms to save code space in
> > SPL by disabling CONFIG_SPL_CPU.
> >=20
> > Without this patch, building U-Boot with CONFIG_CPU=3Dn and CONFIG_EVEN=
T=3Dy
> > is broken: riscv_cpu_setup() is registered as an EVT_DM_POST_INIT_F eve=
nt
> > spy, and when the CPU uclass is unavailable uclass_find_first_device()
> > returns no device, so the function returns -ENODEV. That in turn makes
> > event_notify_null() in dm_init_and_scan() fail and triggers a boot hang
> > ("initcall initf_dm() failed"). Returning 0 early avoids that failure.
> >=20
> > The compiler's dead-code elimination combined with --gc-sections
> > removes the unreachable code and all associated static data,
> > achieving significant size reduction without preprocessor guards:
> >=20
> >    spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
> >    spl/u-boot-spl:text -1460
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > Reviewed-by: Yao Zi <me@ziyao.cc>
> > ---
> >=20
> > Changes in v2:
> > - extend commit message
> >=20
> >   arch/riscv/cpu/cpu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> > index bbadd0c9a469..3bec7c7cb6d0 100644
> > --- a/arch/riscv/cpu/cpu.c
> > +++ b/arch/riscv/cpu/cpu.c
> > @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
> >   	const char *isa, **exts;
> >   	struct udevice *dev;
> > +	if (!CONFIG_IS_ENABLED(CPU))
> > +		return 0;
> > +
> >   	uclass_find_first_device(UCLASS_CPU, &dev);
> >   	if (!dev) {
> >   		debug("unable to find the RISC-V cpu device\n");
>=20
> Can you please take it directly to next branch?

I understand your frustration at how the RISC-V changes have been being
handled for several months now. I'm adding the new custodian (Tim) as
well as Leo's new email to the email here as I expect a pull request for
the next branch (and I can help with questions on "how", off-list, if
needed), hopefully soon.

--=20
Tom

--mDgEhaaBiiDvBk8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakKBIwAKCRAr4qD1Cr/k
ColzAQDslsl4I9srKbpP6p+zoyTKLxAIu7XihdNe5vxJdklXJgD/Ztx8x2W0cR5A
13NzBFH2r8s8sDKFonrcw1b2dtZCkQ4=
=QplA
-----END PGP SIGNATURE-----

--mDgEhaaBiiDvBk8C--
