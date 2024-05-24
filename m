Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6F5C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 15:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF32188897;
	Fri, 24 May 2024 17:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WK+jWZre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CCD8889B; Fri, 24 May 2024 17:08:15 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11446886E3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 17:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-794ab28c3d4so73000385a.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716563292; x=1717168092; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E7rrTfGPbEo6MT6FOywrJAPXOmqMU5RiiP1X1/N37dE=;
 b=WK+jWZreiGiwsvIXDlC2jrTQvtAcnDwFzDIpCeRBG4m6vTGzH31E9xJRafay6ueDza
 YYN5u1Fn2Z3mbwhbMTKVGSatqwO3/BHy9L/EJLHwPS5nFKWKyHGqQxay0a3y2tY+enDd
 NJ44RsF3U5UjaRkLGjMeTSIvOzZd6iuR/a+sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716563292; x=1717168092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7rrTfGPbEo6MT6FOywrJAPXOmqMU5RiiP1X1/N37dE=;
 b=H+Dx8/yxBQxI/SBTQa1cyl9wCeDoWLm0yk/ApLL0guGBq6lS873Lwx0zhD2BoIN9Sl
 H6jxRw4RnVSBRxK/fDaOAt66lu4w5zhw0EkBKKqgfADZkctdOk2Db6BC0Pem8AixG+rG
 RjY3B6cH8Mo8CFrz0z6G+MSCItmiJi8+zwwB2y41Ozn9k/tpVT8hBtGiEcBvUskH1RTp
 pc7clb63qi5KpMVxIZ6TeGcBabAzVhXq5TNLBq86YjxEruHEXGeGKBduI/WEGpb/Y5Hp
 ZR0bBxN9tN2da/y0k4F9KQSt8o9IQ2ANvsoPQMutyEzWn+HayPV1VXGZWh0kC2Qpoxod
 HrAA==
X-Gm-Message-State: AOJu0YykEBfV5UWe/vYPVhVEY+uYVHBVXR8DybkWzAH+b54Uf5m0UYL3
 asfKMED+dUT5LJqqAYjOWgt/m6e4UNPMyDpZnL23Dg62fHq7OjKl2TMrYSPRxXM=
X-Google-Smtp-Source: AGHT+IEZoyjE5jJIJxZ21wh1ueyQZscAz8Gm+TXfFEOWfAlsRwhsMhz+QAa+GITCRj5GTREduPRCgw==
X-Received: by 2002:a05:620a:8415:b0:78d:646d:e2e7 with SMTP id
 af79cd13be357-794ab122ce3mr228007885a.66.1716563291877; 
 Fri, 24 May 2024 08:08:11 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd46c58sm69912185a.131.2024.05.24.08.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 08:08:11 -0700 (PDT)
Date: Fri, 24 May 2024 09:08:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH 12/15] configs: add qemu_arm64_lwip_defconfig
Message-ID: <20240524150808.GZ2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
 <20240523150246.GO2568172@bill-the-cat>
 <0684e59c-523b-4b6f-9ed2-138122c8c127@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+9mtZWlloktz8h7w"
Content-Disposition: inline
In-Reply-To: <0684e59c-523b-4b6f-9ed2-138122c8c127@linaro.org>
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


--+9mtZWlloktz8h7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:09:33PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 5/23/24 17:02, Tom Rini wrote:
> > On Wed, May 22, 2024 at 06:00:12PM +0200, Jerome Forissier wrote:
> >=20
> >> Add qemu_arm64_lwip_defconfig which was created from
> >> qemu_arm64_defconfig with CONFIG_NET_LWIP enabled.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  configs/qemu_arm64_lwip_defconfig | 70 +++++++++++++++++++++++++++++++
> >>  1 file changed, 70 insertions(+)
> >>  create mode 100644 configs/qemu_arm64_lwip_defconfig
> >>
> >> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lw=
ip_defconfig
> >> new file mode 100644
> >> index 0000000000..c8dadbce37
> >> --- /dev/null
> >> +++ b/configs/qemu_arm64_lwip_defconfig
> >> @@ -0,0 +1,70 @@
> >> +CONFIG_ARM=3Dy
> >> +CONFIG_POSITION_INDEPENDENT=3Dy
> >> +CONFIG_ARCH_QEMU=3Dy
> >=20
> > Setting aside that I would like lwip to default to y, at least in the
> > first few iterations (so that testing is easier),
>=20
> I could certainly do this. By creating a new defconfig, my goal was to
> minimize the impacts on existing use cases.

Yes but then it makes it harder to out of the box see what the deltas
are.

> > this should be using
> > the #include method rather than duplicating the whole config.
>=20
> I've done that for v2. Let me know if you still prefer I change
> qemu_arm64_defconfig instead.

This is fine for v2, yeah. Once that's posted I'll grab everything and:
- Throw it at the small HW lab I have
- Enable it by default for everyone and throw it at CI
- Also throw it at my script for world build before/after and using
  buildman's bloat checker to see what grew how much where.

--=20
Tom

--+9mtZWlloktz8h7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQrVgACgkQFHw5/5Y0
tyyaLwv+L+zZfGLcGHId78LKBlh4p6bH1m15WIo5N9NuhSclCzIDkrKIjmhWXYDN
RQ3zfQAX8W2FsmVYIYFXTCI3tKMcjcFvwUzM4HmZ1i1WU76SOwe1krlwa7I3ZZuz
lamMIeEP//OE36ogZQ/6sT8LLR+IF5KUgkcI4PPepOzyeiVR2zLdpTAT/Mqq5u6/
QGPmv3CibElb4aRW6LJ+2ovbYrIu+RWLBX/N7zAQOCvOIYBOcRTTbhBHL68XC2x4
Pltgde3aL3NXtYXQcFuhU3mh1Pn5sFUHH3t/zlY0G5CW4YChvnn/1D8DhVZzG+TB
dFtOn4TRQcsevITYZI8bgrFY8jOBb/glD8lzOItZ3FKpQnpotO/H1vAUGzCRNJFX
+K8bx/EUxN0jUr/tmgIfyBbyZ+Gly8vIRgpjCCG+1H4opq925tbUBPq5Hz/kt68G
DJGtwym8QPl73EjvQDTAC9Da+InFIwQqo0UeJwWKl0D1FVQjGkxQdrXIrvxhENBy
lvWoqR1Z
=jB2h
-----END PGP SIGNATURE-----

--+9mtZWlloktz8h7w--
