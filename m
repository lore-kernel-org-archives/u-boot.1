Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E4D4661C
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 19:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CABE82BF2;
	Thu, 15 Jan 2026 20:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WUJL9pGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5B983015; Thu, 15 Jan 2026 20:31:37 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826A880325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 20:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6610f045c1eso547117eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768505494; x=1769110294; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eI3AdzP7DvhcbO1pg6qRnI0D86dUuFjt/9uWdrcjaPc=;
 b=WUJL9pGYnssqiNc94gy8MusGNGLE8QkopOlNx2p0SsZtfbv0juKx2/RVZnysBCNXKA
 vpF4vS2k7B6lm4mb6pfqpvqlYNukl+d9nSqbkS4SvCPX1HMfiOAGefsWxFUKTdQfTqWh
 bROHzftCNexvIGXEl98apTSjcqez3xW8ZC0AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768505494; x=1769110294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eI3AdzP7DvhcbO1pg6qRnI0D86dUuFjt/9uWdrcjaPc=;
 b=pbTAi4gp4iSi45+y55jtTqHcUcVGz+9OdmVoxlQKHOaP37/WpWOTTU9exI3rzzq+1n
 55uUB6WWZNLkZqQOR8AG7XpcDQ5DW9e49wKe1/j3s+ZTxsbKtniK/nsB4NzUVIyrHOjy
 fFG/YjUSBLpKON8KdNDTHJRD3mILfW64AERSKc5aexTdG6ygTsWsStZ1VbXKdBiw9+Wn
 TvQmg+kZdGFES2sWMwbg8X6bRaedn6MQ0YIoWeDKo+JW97cko66hrTbScPsxen7jQCuv
 Nw2vl5PYhO0+eJvAUGIOKqYD5sq8i/AIU2EDNKGMbh8HehKNNLHJqrwSsAPCe57B62rq
 14Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQm7Drgj7nFO2qHaVFgBYlUDtlBg1jm6IWE1SGew+cVQ4R2LkN8JPf3JHWNvbiKN9s3HS2A0g=@lists.denx.de
X-Gm-Message-State: AOJu0Yym0GirT1zX5xNfDNEIgPAgiezab2I1Kf1N6czrZP7ddOoQknEu
 /jC16ZF2F0xDx8yXgDoWoTARl4RmlCdfFJTeClp/5fLfmcd18yi7+QHXjmnU3hN1+tw=
X-Gm-Gg: AY/fxX66LiZHh9+GYikpGvcl1OTFY3sd2M4jNO/SzdEVuCzJep1LQ4zLhKw0WvU0BGI
 EYWiX6wQGd2CHI3f5ZItLEat9k2vel8TXJ9EHD6QCu6SuXnupVlcGdjL1P7tz0yjoBD9vjfOisZ
 o8Xu6NEoPgmTE+hqkaaEC2Us3Y6EX5I9vv6oE0xv3iodmqY50nEOry5P1rQVwZTAVfpTAKzOWtk
 VCmWeSviSbgg6RClUe3+DUVg4zhiB0KIgv8g0akjCrJmFu4+ETMbrDa5N+++GhWPXiMRV2GSYh2
 DtBI+uvrpQ9mu+rjfaH+bGv1xK/G27xjJzywULfSHB4ifIhLzRnfu92SyglrbyfdHllvXiEDQt8
 9OCerSSWhYwpICbDzPyBvhT9TCU6gyGFdKzbo3Tz1LYfmtdT1HH/Zn611OtUg6odBOmjygc1YH2
 ZwNNs4J2R02LaurKC1q2cy0XBPtEl3bfteH2/dx4c5VGKpZpEh5pGgtA7RrmeSZEpSH0wDdzMeH
 IOVVHef75XCL7cotwRMqc2jTy30RUII37C635E=
X-Received: by 2002:a05:6820:490b:b0:659:9a49:8ff7 with SMTP id
 006d021491bc7-66117983e14mr309138eaf.36.1768505494132; 
 Thu, 15 Jan 2026 11:31:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6611860493dsm158343eaf.0.2026.01.15.11.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 11:31:33 -0800 (PST)
Date: Thu, 15 Jan 2026 13:31:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jamie.Gibbons@microchip.com
Cc: andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 michael@amarulasolutions.com, Conor.Dooley@microchip.com,
 Valentina.FernandezAlanis@microchip.com, fberder@outlook.fr
Subject: Re: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20260115193130.GI3416603@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
 <20251227223833.3019311-3-trini@konsulko.com>
 <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
 <20260114145842.GD3416603@bill-the-cat>
 <9fd13735b55dac213d23dc13309f0c3199be481e.camel@microchip.com>
 <8b4d8980c4c16a2d0f6e1b566f85034047c24fd5.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8NKUaeMEAaEov8Z5"
Content-Disposition: inline
In-Reply-To: <8b4d8980c4c16a2d0f6e1b566f85034047c24fd5.camel@microchip.com>
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


--8NKUaeMEAaEov8Z5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 04:59:19PM +0000, Jamie.Gibbons@microchip.com wrote:
> Hi Tom,
>=20
> On Thu, 2026-01-15 at 16:16 +0000, Jamie Gibbons wrote:
> > Hi Tom,
> >=20
> > On Wed, 2026-01-14 at 08:58 -0600, Tom Rini wrote:
> > > On Wed, Jan 14, 2026 at 02:33:04PM +0000,
> > > Jamie.Gibbons@microchip.com=C2=A0wrote:
> > > > Hi all,
> > > >=20
> > > > On Sat, 2025-12-27 at 16:37 -0600, Tom Rini wrote:
> > > > > The devm alloc functions that we have may follow the Linux
> > > > > kernel
> > > > > model
> > > > > where allocations are (almost always) automatically free()'d.
> > > > > However,
> > > > > quite often we don't enable, in full U-Boot, the tracking and
> > > > > free()'ing
> > > > > functionality. This in turn leads to memory leaks because the
> > > > > driver
> > > > > author expects that since the functions have the same name as in
> > > > > the
> > > > > Linux Kernel they have the same behavior. In turn we then get
> > > > > functionally correct commits such as commit 00e1fed93c8c
> > > > > ("firmware:
> > > > > ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource") that
> > > > > manually
> > > > > add these calls. Rather than manually tracking allocations and
> > > > > implementing free()s, rework things so that we follow
> > > > > expectations
> > > > > by
> > > > > enabling the DEVRES functionality (outside of xPL phases).
> > > > >=20
> > > > > This turns DEVRES from a prompted symbol to a symbol that must
> > > > > be
> > > > > select'd, and we now remove our non-managed alloc/free functions
> > > > > from
> > > > > outside of xPL builds.
> > > > >=20
> > > > I=E2=80=99ve encountered a regression on the Microchip PolarFire SoC
> > > > Icicle
> > > > Kit
> > > > with mainline U-Boot.
> > > >=20
> > > > After commit 217cf656e249 - the application of this patch (=E2=80=
=9Cdm:
> > > > core:
> > > > Default to using DEVRES outside of xPL=E2=80=9D), U-Boot fails to b=
oot on
> > > > this
> > > > board. After this patch was applied the Icicle kit no longer boots
> > > > and
> > > > crashes immediately after OpenSBI. Between this patch and master
> > > > HEAD
> > > > the following errors are found - please see attached logs for more
> > > > detail:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Failed to reserve memory for fdt at 0xbf386210
> > > > =C2=A0=C2=A0=C2=A0 Required FDT relocation for applying DTOs failed=
: 1
> > > > =C2=A0=C2=A0=C2=A0 Could not find a valid device tree
> > > > =C2=A0=C2=A0=C2=A0 Device tree not found or missing FDT support
> > > > =C2=A0=C2=A0=C2=A0 ### ERROR ### Please RESET the board ###
> > > >=20
> > > > Sometimes, I also see an =E2=80=9CUnhandled exception: Illegal
> > > > instruction=E2=80=9D
> > > > and
> > > > a reset.
> > > >=20
> > > > The last known good commit is before this commmit. I used `git
> > > > bisect`
> > > > to confirm that 217cf656e249 (this patch) is the first bad commit.
> > > >=20
> > > > Steps to reproduce:
> > > > - Build U-Boot for MPFS Icicle Kit
> > > > - Boot using HSS payload as usual - I use our build system
> > > > Buildroot
> > > > for
> > > > this
> > > > - Observe the boot failure after the above commit
> > > >=20
> > > > Any advise on the problem?
> > >=20
> > > It's really strange that it bisects down to this commit, rather than
> > > something device tree related. Do you still have fdt_high=3D0xffffffff
> > > or
> > > so set in the environment? It was in at least one of the logs, but I
> > > can't see for sure if it's just that the other log is from before
> > > the
> > > commit that added the print warning about not doing that, or if it
> > > wasn't set.
> > >=20
> > Apologies for the daly in my response, I wanted to do some more
> > debugging before getting back to you.
> >=20
> > Thanks for the suggestion about fdt_high. We have it set in our boot
> > scripts. I chased this down with a bisect to 9235da9446e (boot: Warn
> > users about fdt_high=3D~0 usage). I have now set fdt_high to our maximum
> > addressable value instead of ~0. This does get rid of the warning
> > about
> > fdt_high in U-Boot, so that part is resolved.
> >=20
> > However, it doesn=E2=80=99t fix the underlying boot issue =E2=80=94 U-B=
oot still fails
> > to boot altogether. During some bisections it often fails to apply
> > device tree overlays and doesn=E2=80=99t boot the kernel - I have attac=
hed the
> > latest crash log.
> >=20
> > From my bisecting, the overlay breakage seems to start with the
> > DTC/libfdt update commit (0535e46d55d...). After that, overlay
> > application consistently fails, regardless of the fdt_high settings.
> > As
> > an additional piece of information disabling MULT_DTB_FIT allows the
> > board to boot as far as fdt error.
> >=20
> > Let me know if you have any other ideas.
> >=20
> > Thanks!
>=20
> Just for some further clarity, before the DEVRES Commit:
>  - U-Boot boots fine with overlays disabled and fdt_high reset.
>  - Overlay application causes FDT errors, but base boot works.
> After this DEVRES Commit (dm: core: Default to using DEVRES outside of
> xPL):
>  - U-Boot does not boot at all =E2=80=94 no output, total crash.

So to be clear, there's just nothing on the serial port from power on?
The initial logs I think confused the situation slightly. If no output,
I would suggest bumping up SYS_MALLOC_F_LEN a little bit (maybe 0x2800
instead of 0x2000) and see.

--=20
Tom

--8NKUaeMEAaEov8Z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWlAigAKCRAr4qD1Cr/k
CofCAQC52Foz3sPf3nw0i5zYnG5QCOqxpxN3gYLHsSYMAKINFgEAn5gmCDCRTQJX
2+Fs5faZ906XY2uM74jhSOxx0zS32gM=
=Q6Jd
-----END PGP SIGNATURE-----

--8NKUaeMEAaEov8Z5--
