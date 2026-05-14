Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60B8CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 18:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDDC84687;
	Thu, 14 May 2026 20:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mR6Jjg0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254C784693; Thu, 14 May 2026 20:40:48 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5A58465A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so6807883a34.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778784044; x=1779388844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8yUH8p87x0HxwysFqFsK3hZ6y6NXIWCQOj0C459TpU0=;
 b=mR6Jjg0nxY8G5vNVIjLBknQWvtu6/F0XncC5WE3LjH7SZLedZMEVxDxgp2vVpV8IsY
 2tYGuZcSuLJmRwB5gI7bODjbFV+mE5erCZI3xxlELi3KkCivfohChAxdqUaxVDe7E/q/
 liE0zh8//McpswrCLi2dlLt3DMAzRSGUzDmv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778784044; x=1779388844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8yUH8p87x0HxwysFqFsK3hZ6y6NXIWCQOj0C459TpU0=;
 b=g/PeG8p7jyTtrnH2jbXzVkUn+mP2Y+xVkeDX0JZMQdnXCicFUTDC7Z5mqkJo0tpAWX
 uqbyVIGczIqWWXyDYQn9QPW8fKrCcuLfxAPCIHycZecB/O2XgF066MHpWy18UHa3auzT
 BJKfuqVh5W7n9ZLgJ8BivtBKYbiswkNxuHnYzHVr1+xxRf2AiDSFuoUMDS4f+H3BRrgh
 r3vTR0N1Y+mr/OaV+eihs4QsfGfbX+WpxhpIE+wcGq3Ma5Wsapcj6z4HW4QUbXEy77Oy
 BrHc9JP1jDXn/odBEG52KEEW9fG214wGNvNHb3+hJ6OLsVnk9QLBx3HVHcr7cf6lrnAA
 WdbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hhkba5FcsP8anwm1DfVS0gg74IxMHFllnt0JSVq6+G/R2ac6rcoFmE/OWSuVWleE52MjPHos=@lists.denx.de
X-Gm-Message-State: AOJu0YxsedT9ctROMFDomd/l+WN9Bp5Blz7BLOYJOCZrJ4I3EmJZfovQ
 weVb/dwyuuUS0rF+0HLCMM+B70G70hp0NgNAOuuR/Zh2xh/E4m583nk1TyBrmtjdxZw=
X-Gm-Gg: Acq92OHNrUNbetI6svY03OYvdRuFG873MxVvow0z/tHI92v/WZ1KZS+ghthnyReXVHF
 a2Mu5qkeiMCVtb7X3mLsuzbBKIQzLQjelGxWKUptxJfJgk5SHquYW8zr+VpF7MmhK0ze/ECcELp
 VPk197khx2N74plKY5/zdUzD2QJAUzbWPFQ9e/xeyhK/+fV+maczDyj/Na3VEzqRvrdJi7cJbyg
 3KhObj5APT0DFkEer623ARBrVmvGNI3YwEHc4aTrNAXdmfRFVX0KTfXYTWiAE9z0XBIV+WgDcws
 z2vtv5H2Qerwbo5CBZg27egLq0bIQlAhn/KuWM7XJ6DpPqfIhaPaLHUckJ94gzxEANDuciU+gIR
 L06QE6KLDLv71+wGd6hf9GQwZUnZ3t0v79b7wL8Os/TmZjBlcy0WvoMxSKcSoLFZv9w9uzZ1jvW
 DtzzmMKnSk/dvdQQmVygEJB/SDuRUvukge3hkkMuqkb+FWTsO8em1N3cXsvYT5MwsgkDVe1cXSP
 keY52J3Z8fHNzEQkYZ6Vo7o+pisJi7JNw+JDOZaATKNlLY/Kwk=
X-Received: by 2002:a05:6830:923:b0:7de:84b5:88e3 with SMTP id
 46e09a7af769-7e4f2a398damr273989a34.8.1778784044452; 
 Thu, 14 May 2026 11:40:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e3f39542bbsm2516890a34.8.2026.05.14.11.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 11:40:43 -0700 (PDT)
Date: Thu, 14 May 2026 12:40:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
Message-ID: <20260514184041.GX1858239@bill-the-cat>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
 <177857908918.1655329.7242382998405759036.b4-review@b4>
 <20260512174438.GP1858239@bill-the-cat>
 <177865029535.2037938.14829007973486614845.b4-reply@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dQk04+ksIOh133wH"
Content-Disposition: inline
In-Reply-To: <177865029535.2037938.14829007973486614845.b4-reply@b4>
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


--dQk04+ksIOh133wH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 11:01:35AM +0530, Neha Malcom Francis wrote:
> On 2026-05-12 11:44:38-06:00, Tom Rini wrote:
> > On Tue, May 12, 2026 at 03:14:49PM +0530, Neha Malcom Francis wrote:
> >=20
> > > On Tue, 05 May 2026 18:36:24 +0200, Ernest Van Hoecke <ernestvanhoeck=
e@gmail.com> wrote:
> > >=20
> > > Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> >=20
> > Out of genuine curiosity, the Message-ID here implies "b4 review" was
> > used here. Is that correct? And how useful did you find it for this
> > case? Thanks.
>=20
> Yes correct. I've recent started using b4 review to help me get on track =
with
> upstream reviews. Personally it's been quite helpful. I can track only the
> patches I'm reviewing, and quickly give A-bys or R-bys and look at follow=
ups.
> And you can get checkpatch checks done instantly. So all in all, I will be
> continuing to use this further. I'm trying to get used to using neomutt a=
s well
> so that I use both in my workflow since you can integrate b4 review with =
neomutt
> as well.

Thank you for the feedback.

--=20
Tom

--dQk04+ksIOh133wH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagYXJgAKCRAr4qD1Cr/k
CkAzAQD0FShgZVzkKRKhhfGz+GN8joQcL7EEzOOdd0U21kuF8wD/V/Qdcp0UJeXg
doWiloLKON1OoI1l/b4X6lmPXPIjJAc=
=3HGi
-----END PGP SIGNATURE-----

--dQk04+ksIOh133wH--
