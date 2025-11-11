Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D1FCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0659E839D6;
	Tue, 11 Nov 2025 14:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="luL+sMr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB6C83BB1; Tue, 11 Nov 2025 14:35:11 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C1283946
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d13986f8so522251a34.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762868107; x=1763472907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K8T7iTSqJNNBRmyDnqyoNmSmHpLVhOYDhdJ41HulPJE=;
 b=luL+sMr1izQ1pyGsJ9BjmH1xsoO2TEpqhbbCczE/cblznqhanGM6X4yRfSrPvC4tXB
 RVu201sEOENETksd3Q9Qo6Qq/ak+8++VVr8nJ4KhyM2rFXX8kFbYC50kF8XVHZHoVrQu
 ZvomppA22kgie3ompBIY4VEQFq7ZYlSx8R/hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762868107; x=1763472907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8T7iTSqJNNBRmyDnqyoNmSmHpLVhOYDhdJ41HulPJE=;
 b=g+PTNXbcMhU67kWMgcQi7U1ZeD+E6vsJFm/MMlmSWL2knGS+S6e9L6AcvNcCF5YNuz
 e9kOTgzpE9nNHChOGY68Js4R8+ea8yGBo28IIxbJ6JTtDV8VeUbbiCPgoC6dVv77148d
 wQ3iOf0pHDr/qzAaQBvc4vg6sLNd4nI4tcbB13bhEHENMtTYyErBbZ6Cr9D0BhPRiU0O
 kgM0BjKQfLGy+o7bFO0r1lGWSDSyW8xSGGCHKHabpNMXT/TPHn8Pia3n0WV4UeWUM8mF
 gEY9v8LjE6CIxMrmXcWaEvJrm66Chv4mlF51P2YwAeFAHkjKQGLloMkQr5jxXP/h8Fhq
 S2Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc0/sJvGT6wrvLlnlzjMJysHefgamL8jmoYiNqHG80Swm3P0yExR9PL6CyVs4g2SqA54ock3o=@lists.denx.de
X-Gm-Message-State: AOJu0YxMmnVeWJ+SYFuliAgFyCyq8/19x5marJtr11YlQjAX4OorssLY
 Aq5aum/uU443fviv8jlYrtLAReKQrYVaMKvN3hacCefyN9pCUbtyYwUYznUTQ/zqFak=
X-Gm-Gg: ASbGncuCpXnByMJT9Rva/2sJKp3pSzEq+zOfy1KRAi4MX1OJA/5cYOLE3nWQ1cMHWcV
 rMDunCNGrO2X8qnQjdvIn2phlfn5nuE2HIQIX8ZzDg5+mgO5b5x41ocCd8OO1P+njvGhMI23tOg
 32nRQherIYt15kRyzW2vNoYiIXP1TZgKUI9SlWkoloQ2j4i1j9Ois3/z2ghIuBwz2DbSKxSDfup
 TScz1AIBNDTiHobdawKyrEMi6eB1c0UEYengOMJflmD9ltGl2MUtAC+qBwnd5zB2ip1b2AtlD+P
 Gu/e8u2uo7D/KRl4fZ6f/PqkexLhi19oQfGIB4C0D+7g06Fnz7vCpE2H2iIsRLceC1EOOLiQUj+
 wbS1fvmG0rFFAXw1rkWBXlXhBb0yT3wovwt29asP8Zs7qG1EumWM24T3LrvDmlYPWS3bty8R1n+
 TNhqUUrvlpJvCkAsnFd3MQ+FHjbS4AbKDv21HLiI4=
X-Google-Smtp-Source: AGHT+IE5s7SisIT4c2zE3BuxFCE5c/VW0R01IQmGM9I4kP9RS+JYZai6f99mR0aWa/IVxKtYm/NWBQ==
X-Received: by 2002:a05:6830:4427:b0:7c7:26e:4686 with SMTP id
 46e09a7af769-7c720b7e730mr1907591a34.5.1762868107512; 
 Tue, 11 Nov 2025 05:35:07 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0a715sm7042126a34.4.2025.11.11.05.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:35:06 -0800 (PST)
Date: Tue, 11 Nov 2025 07:35:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Swamil Jain <s-jain1@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, devarsht@ti.com,
 aradhya.bhatia@linux.dev, n-jain1@ti.com,
 tomi.valkeinen@ideasonboard.com, vigneshr@ti.com, praneeth@ti.com,
 h-shenoy@ti.com, u-kumar1@ti.com, n-francis@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/2] Refactor tidss_drv and enable early splash on AM625
Message-ID: <20251111133504.GS6688@bill-the-cat>
References: <20251106085842.629521-1-s-jain1@ti.com>
 <DE1M02OMYGCG.UGUVC26WQW5I@ti.com>
 <20251106133745.GX6688@bill-the-cat>
 <15de746b-85f1-4cbf-a803-a225d7cc2d44@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VEtaeOluGyuyNU4l"
Content-Disposition: inline
In-Reply-To: <15de746b-85f1-4cbf-a803-a225d7cc2d44@ti.com>
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


--VEtaeOluGyuyNU4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 02:38:10PM +0530, Swamil Jain wrote:
>=20
> On 06-11-2025 19:07, Tom Rini wrote:
> > On Thu, Nov 06, 2025 at 05:56:38PM +0530, Anshul Dalal wrote:
> > > On Thu Nov 6, 2025 at 2:28 PM IST, Swamil Jain wrote:
> > > > This series:
> > > > - Refactors tidss_drv
> > > > - Adds am62x_a53_splashscreen.config to enable splashscreen at u-bo=
ot
> > > >    SPL
> > > >=20
> > > > Signed-off-by: Swamil Jain <s-jain1@ti.com>
> > > > ---
> > >=20
> > > Tested-by: Anshul Dalal <anshuld@ti.com>
> > >=20
> > > I also went ahead and did a sandbox build and the driver seems to bui=
ld
> > > fine contrary to what Tom saw[1].
> > >=20
> > > Below are the steps I followed, am I missing something here?
> > >   1. make sandbox_defconfig
> > >   2. Select CONFIG_VIDEO_TIDSS via menuconfig
> > >   3. make -j`nproc`
> > >=20
> > > [1]: https://lore.kernel.org/u-boot/20251105164114.GQ6688@bill-the-ca=
t/
> >=20
> > v4 drops the header in question :)
> >=20
>=20
> Hi Tom, as we have the patches tested and sandbox builds also fine, does =
the
> series look good, could it be possible to pick it?

I've assigned it to the video custodian as yes it looks generally fine,
thanks.

--=20
Tom

--VEtaeOluGyuyNU4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRM7iAAKCRAr4qD1Cr/k
CmQdAQCUJK2zdIMKEuTcTm8Z83F8GbR7qNJC+oLxXKVEu8heuwEAkUEud3/aAJ3c
Eff4wud26gjN03jicBUH7lH6vpnWKQM=
=WM06
-----END PGP SIGNATURE-----

--VEtaeOluGyuyNU4l--
