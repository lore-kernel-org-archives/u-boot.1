Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EF8C982DF
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 15:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C97D81117;
	Fri, 18 Sep 2026 15:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edi_PiQ8Yh1M; Fri, 18 Sep 2026 15:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 79EC38113E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789743783;
	b=To4tW4Y0KoM/JMbvICElPU+nPezNYAI4IOqe1ZX6eUtZzjfB7IwKmnX9KQzoQxf/LsA2
	 gqNU2UuhZRDdQOXhVBPsJN8Iv9W/nQxCNNHM6C4hxwMR/e4odvkXOoS2KQIp/ek+Y/bR4
	 FlRGOioC5hK2NALrN8JrIRYDWsmLk283bErs2mtKs/FlGbS56FhBsjU5xXO025BJrGo5l
	 s/OKaxD8Lm8ean7o3YMmqlJE/isJ9WfHPNLTuKxsxlNebnXho9VknbnA9MZsMHp1zyh2j
	 /CDV428rzInv407l6WhrNVoOb7caTgm5abLLNTVWi5k/V0CceHEHq0U7AKda9DSlycQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789743783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dRS9oBj4N4qBXFHPBsykLYU7JjPQ5rKaDTotcjzOsII=;
	b=KoGijLI5TpVs1NiF5Y/Bun344MECicAVTvjgS/aN4qmnXKx/lPGzzHcKb3OGigrjNRMW
	 EaxDFr/a3HudvaTPa1IC92A34MG3jmv3HBoXh0rGD4OdwJmJAQPU9mQ+8aRgl/FFtOdAP
	 UEhntMl3YiH/EmlURCCigFbpO1al31qVjxPztfu+DzPqY8SwFS7lpdZeGqOQsz9CnpksN
	 GK7N4z8Y2ajiassiqTj3hNJi9SAME7dWFFOjojzgDqsYm4rql5zhxcVaPpAo/sbawB751
	 5vn0uoYFoEKf1ydnHW/ZN6RWgtNAckD04YQzXlfnjaaGUcze76AbaUyqVKLlClwrnrg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789743783;
	bh=dRS9oBj4N4qBXFHPBsykLYU7JjPQ5rKaDTotcjzOsII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r1zfv7/bbnuCsUN1ogVsB9+pp5GSd1x9AYqpVHvNkzkMWpupRR0gHuzh9Ky4nmbcD
	 6RHJyZ4+ORnYH57eyzrfaXfSh4ZpTWHcztKZyebWiKxeHOEt094Xmt6quBNcnxvJJM
	 /TjHYWmFn5ACCqgu/LAMVwACXQerYtGoUgAx6EGOBwKp4AuIbW5GN7+zi3Mz4KxAxe
	 q9wQHaoQSIbV2UHzbYQaYxrLiu8wbKCdCY0i1c+4Nxzo7BRQW4GsZlWF8rMyKhJPGm
	 idXuAbrOiOhPmMMhk4sUio5F582qp/wnB0IuTZlbOzM8jHu0ptCeGkHV1yIaHQhcvZ
	 tcNo13IfTATmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79EC38113E;
	Fri, 18 Sep 2026 15:03:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B8AF23F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 813DB60B75
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5oGNGrB6dbU for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 15:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A80E360659
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789743781;
 b=a+BPu3d4tEB4vNDfxBPW3XFEooU4xG6VNa7Gupz1fUNTNRpnWIj8YGMuLbioHYJNzS4x
 47WBz241NYt+Qrt0qdOTgcC6smqv8DUayiWnjqdTkL1Q/GGh52c6Wq9BlObJMX3MGfltm
 V3kgl3oNvaAK6A2SC6Eg3a/2TRfEERCPZsXJyax1niX3qeZloXrONLfz93xQX6/NVVzYp
 GszXC6Kqbtyjj7HGTJODoqLzIXkOjLL05qtibp/9XbMcKBatJghDtn5eUSzdwNnkX+Dlg
 QPvjWlJvpSASVydECPbys0Z8bG4dQWP/9gCRExh3kqLqUE0HKurqVvoRbj4YkgB+axQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789743781;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=dRS9oBj4N4qBXFHPBsykLYU7JjPQ5rKaDTotcjzOsII=;
 b=rp5A0ghUr6QHydFUJGfiNrbDEusIcIbMvV1/8Pd+CbR5KCCc3MjvQJWpjEouqJsaWTPW
 75+lu+LCHGTKrcHS8sGxNrHSFqBl7uQ66+miBvkHH+uR2PkDOhB3DlpD3z6FDmlhWalKl
 QhR2TegFwT1RJddZeH43diSHdtuVIHe4Ev4TqIIN3sm3xlydRzzgppplFN3umXBzBGQtY
 dLlRKYwQRKxIBSQYu13v/+/vn8haN5odnvZ4zv6L+lFlm/JWjnUNR4VNq8+Hm/bf/QXcm
 cBjVc8P2lxMDPLUUjxZvbDMklhzVNhTHFESLiSzaSY9ULv+UG5NTgXd0aSr4WeA+ZPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ETiE1l1h; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::d;
 helo=mail-oi2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ETiE1l1h
Received: from mail-oi2-x0d.google.com (mail-oi2-x0d.google.com
 [IPv6:2607:f8b0:4864:32::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A80E360659
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:03:01 +0000 (UTC)
Received: by mail-oi2-x0d.google.com with SMTP id
 46e09a7af769-805cc8b4231so451407a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789743780; x=1790348580;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dRS9oBj4N4qBXFHPBsykLYU7JjPQ5rKaDTotcjzOsII=;
 b=ETiE1l1hItZM3gxNOJueZbSOLZdITtX7VperhF3e0FxGMHpzVg3zGk+ehmyliqxZ/2
 Tsel1S2bcHIYd1//i+ft5zokgnOl/6TTo6AuLpTapedKuIV0y1Bzvd2YmFVNMtXKWIiv
 EIZll3gIG3Sqmdc8EJP8Kki60zFF0UAoUBCj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789743780; x=1790348580;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dRS9oBj4N4qBXFHPBsykLYU7JjPQ5rKaDTotcjzOsII=;
 b=Nq5jhlHJmta+6EvyV4exYnfZCRF998gEWoHQwRFThKDya0viRM7C3Ba3E0mw855k7S
 xv/VYqbHpLhWl7dhBwW/pN/uAMC2YucDC8mRx/kwnfyR/cwZ76Ix1xD+zyYaZGtclnfi
 T+/KC6v0W7K7OrHeDZhlS+Cig08GsvP1lAfrUwoS68v4cOLzPHVpEBzj+MfnYXJA4oYx
 lMAZV5sE4kZjJ8gE6HOunUs2n+V1+h38dxpUTQdTRRja1ihlbvxoKg85FygbshImTj5I
 EZGIzdMJSCeYFdQEXP9oeIqd2Xq3/VKg2bFmBnrYhTkbk3FPa4Pb1+ogA2zN+EaXqdYT
 AWqg==
X-Gm-Message-State: AFuF++nSz7raE2tEjmJDOrCWFwGc9l3QB1905La/t4x+w3Nvs2PahfTe
 Dhsub9TyCAhwxNAH4D2NUOs7MA/TwmXQBsWAtNKdeH4S2Qc6Bt83no+eaGgpb1HxR8A=
X-Gm-Gg: AYBFou0za8juYL4k/vQGDAo/nRM4puMSju/PpjgrKKpKUcXb11ddAKIUmFR+rv2uZf+
 HrAc6nPmLNr8ZeuTm2gB1yEF4Pk21LsFPHM0vL/HQSqRsrRFfbecFfPi9XdGnq8ytPzoLL72m3h
 ExBz7i0vi5twrTKgtuJ+WfaRl78e4XEcyzXsofOunjRB9WZX4G0q8VBtyE7NNtvXoucxhHFw/hs
 gsSrQnUHm2KNhO8SHOY23mUHb5UUtQnp0WJiKuY0ePlZgiB6mlOcUuHbJUh55bpDIUFPVRQ1qsK
 MTG09sub/gubIjET2f0MdGBg2xAFdmp1duTNwL/jfyHGT2tIXvNwiQY9QDWIKdfK77au1NAYP5v
 /KrQQWlyzqamCQkMZQNsY+V1pwj7IerQfDCaD46rZjMsi3IXWMlq3r/nXF/wBpMwNhzSwjFds48
 4iCaStPK79H/+3hEoiK+P9lwaHs5gy36HO3k6ZilUO3wJinwtFJSglVJbwdGfCaOzW4fyjlQZ+v
 S8ymmUy02Cyx0iP16kjVL3NJGOcMPZdBoahMrPGVJZCcX/1em1nWAEtBQYz1a+NUc0C/wBlhhkX
 Ezm06C+bEOpesdfWAMQb
X-Received: by 2002:a05:6830:6306:b0:807:70aa:b2ac with SMTP id
 46e09a7af769-80de2ddd1d3mr3190299a34.22.1789743779313; 
 Fri, 18 Sep 2026 08:02:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e52854f16sm1638516a34.27.2026.09.18.08.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:02:58 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:02:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 04/11] lib: Track whether a phase has a decompressor
Message-ID: <20260918150255.GO858934@bill-the-cat>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-4-7985ac56ee9e@flipper.net>
 <20260917195251.GM858934@bill-the-cat>
 <CAKTNdwH1co27+N2PX_DW76U7Qx6zbP9O0aMXm_7aA25DL=O=GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D2qLyEYQPl6H8H19"
Content-Disposition: inline
In-Reply-To: <CAKTNdwH1co27+N2PX_DW76U7Qx6zbP9O0aMXm_7aA25DL=O=GQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--D2qLyEYQPl6H8H19
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 10:57:33AM +0400, Alexey Charkov wrote:
> On Thu, Sep 17, 2026 at 11:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Sep 17, 2026 at 06:02:25PM +0400, Alexey Charkov wrote:
> >
> > > spl_decompression_enabled() names the two algorithms SPL happened to
> > > support, so every algorithm added to image_decomp() requires editing =
the
> > > header. It also asks about CONFIG_SPL_* from a header included in eve=
ry
> > > phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about =
the
> > > wrong phase.
> > >
> > > Add a hidden per-phase symbol selected by any of the compression
> > > algorithms and ask about that instead, which also matches how
> > > image_decomp() gates its own cases.
> > >
> > > SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > >  include/spl.h |  6 +++---
> > >  lib/Kconfig   | 30 ++++++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/spl.h b/include/spl.h
> > > index 8a9f799f192a..50b41a3a3908 100644
> > > --- a/include/spl.h
> > > +++ b/include/spl.h
> > > @@ -1204,13 +1204,13 @@ int spl_load_fit_image(struct spl_image_info =
*spl_image,
> > >                      const struct legacy_img_hdr *header);
> > >
> > >  /*
> > > - * spl_decompression_enabled() - check decompression support is enab=
led for SPL build
> > > + * spl_decompression_enabled() - check decompression support is enab=
led for this phase
> > >   *
> > > - * Returns  true  if decompression support is enabled, else False
> > > + * Returns  true  if any decompression algorithm is enabled, else Fa=
lse
> > >   */
> > >  static inline bool spl_decompression_enabled(void)
> > >  {
> > > -     return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZM=
A);
> > > +     return CONFIG_IS_ENABLED(DECOMPRESSION);
> > >  }
> > >
> >
> > Is this build time check really required, or shouldn't the callers fail
> > out appropriately already?
>=20
> The build time check keeps the size at bay. At first I tried dropping
> the conditional altogether, but it then caused the decompression
> helpers (like the image header parsing function) to be compiled in
> even on boards with no compression enabled, and several of them
> overflowed their SRAM size by ~500 bytes.
>=20
> I guess I could either inline this Kconfig check into the callers and
> drop this indirection from the header - now that it's a one-liner
> anyway - or try and introduce a compile-time short-circuit path in the
> decompression helper functions themselves for the !DECOMPRESSION case.
> Do you have any preference?

Dang. I was hoping we could avoid adding the DECOMPRESSION symbol as
well. You've looked at all the paths I can think of too, already, so
lets go with the first option of just doing this inline in the one place
that needs it. Thanks.

--=20
Tom

--D2qLyEYQPl6H8H19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq1SnAAKCRAr4qD1Cr/k
CnzIAPiAI5GygfDNb+FIjD8N+x/nPHTCUMCfJicXAnz4AUG0AQC9l8WUpnu1JB6G
bMcDgxX4gL1/0In4opUKnLTgu+nCDA==
=Zv7+
-----END PGP SIGNATURE-----

--D2qLyEYQPl6H8H19--
