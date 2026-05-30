Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE71CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5B484671;
	Sat, 30 May 2026 16:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FJikXzWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B403D8405A; Sat, 30 May 2026 16:22:56 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BB38405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 16:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso13175559a34.0
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780150972; x=1780755772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HfAX69/Yc2KPEJkgOPND0VrCFXZjcdf3kt1AAHdOl0s=;
 b=FJikXzWf9E61mk9FGu5h8kqqkMhJZV2AMftHbGOE4EQtTmauSu4FVmviZlQCGyJolV
 3WOyQ3Y5dSK2vv3kpHIAumH21+uTMQg7GtS3YlQqfoBoXLqm62HYxBU4TcqMlTgmm4I4
 M0qZroX23JX2SvqTqKiIUggDSqOG3+dqsr1rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780150972; x=1780755772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfAX69/Yc2KPEJkgOPND0VrCFXZjcdf3kt1AAHdOl0s=;
 b=Fs4MsXn4k42ErHKMqNhYMGVRNhsl77hYyNSuC2pRNWD1iOcjj3Bjl84wvlmeMSlX13
 rvmPp2cBuPvxtxlLbLVKOUT6sMbdOaup1dFTKcU12h075nfYaiBE6hDJXcd106xPSkjn
 OTZTuZEkUR97zfnXnriyERzIXzF7fV1F2NbfG5i0RfKdrfJ2d2yr4MCqJEK0oHnU2HV0
 jo4bZTVuPeKmxMCT73hB3gwIEKyRJx++YzcgoWBzOePnxDstcoNB70MgYs/GKOzy6en3
 OQqrlf3TEcczYE1US8EWJxpYtM+7YOA5GuyrWbWEUK3VUBegzmsnf/QFiUhHbCv4qg9F
 1UGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0EcR20npDlvhxiELlJ7srlT8l/2BdlIB2PMMmg13MoMxG1AWBiaY3W2W3Rl9WiGucRa5ugPQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb5f2vf+BJPjFk8VUFEi+gnf44g0bMa8UJiuZAECqsLaYj3qHw
 9DLs491MPsqVMXPc9+S0qIL5rRN0ttaOLx4d620rTvMegAH56ippkt0mV25ZDi4PcFw=
X-Gm-Gg: Acq92OH0FUgehXSsb3EryQ3zMqVwyetBNnlx/Ry/JExkjBmatajhCkDfcFW+2uOKjJy
 rpXZk9og3gbJ6Jr1ASxzTZX/lddaTfU1QNDRq6bqohADoiaPGOSgaSZNVAjp0P6jlMafP/qqMKw
 hz/KZrJqJLcP9paAo/F8Kpw8+u/5Aafm/HrrGAdBV1DMYSAjxUjgdJXf3JNFRmeCwnLxmQb0Hy8
 QNtoNvTeVBqlq3fUzWRKaXX9T2AgYM1poUTyHN5Z56fWHTNgrkP4UinSBT/pcrKHSjIcnbcp5wz
 qsNSKeTM8JQNKM3e69O2+VcteAJJwBRwhLyP6f/9e6u8A4SNsaDZeJPWs3Q1fCDH7jzWTtBlL/0
 QwPpS3bQTUa+/iV2rG2thKGi2/ANScLb5yJy/f/yGi866EXKu/VkVFmX7YQzhqM2ZdJGlPwH8pt
 Cgvt8GrBeBntscZXaosV5qZVLLXENiCJOi56CLXu1IjcttvBczN0XcYF/luNAzL/EscXGgMjPFH
 5GgHW7WvyxeOOPLm569OOAUHb9Ip1uD4IrtZUkVAljC6bMRVHn+yexvOj16tu402qU=
X-Received: by 2002:a05:6830:4192:b0:7dc:d28a:3d2a with SMTP id
 46e09a7af769-7e6a1d65d10mr2389773a34.15.1780150972198; 
 Sat, 30 May 2026 07:22:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d8a609sm3759519a34.24.2026.05.30.07.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 07:22:51 -0700 (PDT)
Date: Sat, 30 May 2026 08:22:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Message-ID: <20260530142249.GH627328@bill-the-cat>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
 <20260530140644.GG627328@bill-the-cat>
 <e7d1a88c-6542-40eb-b21b-b9382bdf5306@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A7IndKNkG1XxuVH1"
Content-Disposition: inline
In-Reply-To: <e7d1a88c-6542-40eb-b21b-b9382bdf5306@mailbox.org>
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


--A7IndKNkG1XxuVH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 04:16:34PM +0200, Marek Vasut wrote:
> On 5/30/26 4:06 PM, Tom Rini wrote:
>=20
> > > The revert is wrong as that breaks other things , like use of DRAM ab=
ove 4
> > > GiB boundary, which is exactly why this change was implemented. If RP=
i has
> > > limitations, then those limitations should be imposed on RPi, not glo=
bally,
> > > so add the LMB reservations on RPi.
> >=20
> > Isn't the case you describe still a theoretical and not used in tree
> > case?
>=20
> No, this is used by the Sparrow Hawk board, which depends on it.

Since when, and can we just also revert that to it's old behavior?

>=20
> > And note that Ilias' patches to relocate to the top of memory also
> > fail on Pi. So there's something to be debugged here and worked out
> > before we add this seemingly enhanced behavior. Hence, the need to
> > revert it for now until it can be fixed.
> We still have two RCs to go, so I don't see the need for a hasty revert t=
hat
> breaks other systems, esp. if Ilias is looking into the RPi situation now,
> and I already offered a way to fix the RPi in the short term without
> breaking the other systems.

Ilias is not (yet) looking in to the problem with his series. I'm just
noting that Pi is showing examples of the complicated memory map with
things above and below 4G. And yes, we have a month between now and the
release so a revert (or several, to return Sparrow Hawk to working) is
currently on the table, if no one can work out how to fix things.
Perhaps you'd have some suggestions if you read all of the threads? This
wasn't just "Oh, this commit broke things, revert" as your emails imply
to me this morning. People have gone through and tried adding what
seemed to be the missing map information, yet it was insufficient.

--=20
Tom

--A7IndKNkG1XxuVH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahrytQAKCRAr4qD1Cr/k
CoclAP4wmpb/TRX0gY5rbNubHKQYai8p0CIhIdFH8pb4DOL0GQEAkvJIow8CzTlB
r8HQwQ/b1XW2NhU5ZH/WHaz+4v2yVAE=
=0GiY
-----END PGP SIGNATURE-----

--A7IndKNkG1XxuVH1--
