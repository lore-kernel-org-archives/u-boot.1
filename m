Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BCDCEACD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 14:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267C689181;
	Tue,  1 Oct 2024 16:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LlMfYZSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F230C89209; Tue,  1 Oct 2024 16:43:33 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C6D89203
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 16:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4585e25f42bso55915511cf.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727793810; x=1728398610; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MwFH9LtPcKiwHQx2wso6aFk0bNa/UpqCvWx7ZYszq3g=;
 b=LlMfYZSYOLpcAX4CONTyE17z0r9kN7CNBa9Aq9aVFFTkbEnHJ96MdcHksxlXayXi1r
 adWXoDQ8fiq3ZEa9d4ENOa3eRIiosDWMtdraDXf7SXTbz/VOcn49AvE9HPnv2VTKku1x
 XXsYP6b3g5vwsHcAMFF4jCh4NM0bSPlzkuYb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727793810; x=1728398610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwFH9LtPcKiwHQx2wso6aFk0bNa/UpqCvWx7ZYszq3g=;
 b=F8ysm1WitQPVbaJGqrWvr7bWHL1N0+H9IhPYkSM085ke8Z0KkKerN81DJz+IG5y+jS
 W+5Nqjhz+KO1Edx5FFuTmY6GyYZjv8ETq8r7KLEBSYhNxy2zVJ9sXvKPyb7ByWBkZEE4
 QnHwjoG2NmrI6jocPOW1HBIEpchAyofPCEBWgfETziEpM9hYxPGQ6zn0YFWth35qMuqx
 XnxB8Rf/APs1DKt/8ojKKVH1mCYeUakwZA11rGTF5A0UUHdSXObvCPZP5xm0bqrXzzJJ
 uxmn/5fLbXyfs2hrowNxRnu1+SM4+h4699mx52RCO5dj2UawcCrN97A5ninouTfs+Oh0
 SDuA==
X-Gm-Message-State: AOJu0YxKkqzEm9JNWaZtCVz65ZzZUCNRF36UtX9mCBP5Qy3G8lcxt8NF
 brDtiC6gkSPScRS3bgRIu9ICxH5KoS5I6ZUMb5coOFCupULu6yPwA2vmi96bSAOwWr9HkvuZA5Z
 zMr0=
X-Google-Smtp-Source: AGHT+IGDqUNIlaNu/oFldHEortRMP8sql7bZNUrc6ZNmsL8p8p+gRwaVYHZrXZLjIHQ4/wmBjfDL8A==
X-Received: by 2002:a05:622a:144c:b0:458:5cbb:bb8 with SMTP id
 d75a77b69052e-45c9f230990mr259961621cf.25.1727793810456; 
 Tue, 01 Oct 2024 07:43:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f2e0254sm46173451cf.48.2024.10.01.07.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 07:43:29 -0700 (PDT)
Date: Tue, 1 Oct 2024 08:43:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>
Subject: Re: [PATCH 0/3] env: mmc: fix use of two separate partitions with
 proper type GUID
Message-ID: <20241001144326.GE4737@bill-the-cat>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <871q10j5vo.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="28aFZIt8HpNArWp4"
Content-Disposition: inline
In-Reply-To: <871q10j5vo.fsf@prevas.dk>
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


--28aFZIt8HpNArWp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 03:43:23PM +0200, Rasmus Villemoes wrote:
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:
>=20
> > I always define a disk layout with two separate partitions for the two
> > copies of the U-Boot environment and, being the one who introduced the
> > type GUID for such partitions, of course also set those partitions'
> > type GUID appropriately.
> >
> > This has worked just fine, but, it turns out, only because I've never
> > had CONFIG_PARTITION_TYPE_GUID enabled on any of my boards; I've
> > always just set the offsets of the two partitions via the config
> > variables CONFIG_ENV_OFFSET(,_REDUND).
> >
> > I didn't even know that env/mmc.c had learnt to look for the env
> > partition based on the type GUID, or that that would overrule the
> > ENV_OFFSET config variables, until I experienced weird random
> > corruption while doing bringup for an stm32 board, where
> > PARTITION_TYPE_GUID is automatically set because it is select'ed by
> > CMD_STM32PROG.
> >
> > These patches try to fix the code to fit my scheme, while not changing
> > anything for existing setups that use the two-copies-one-partition
> > scheme, other than complaining loudly if the system is misconfigured
> > and avoiding such random corruption of neighbouring partitions.
>=20
> Tom, any chance these could be picked up before 2024.10 release? And if
> not, at least be put in -next so I have some stable sha1s to refer to
> in my own branch.

I'll take this to next soon, thanks.

--=20
Tom

--28aFZIt8HpNArWp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8CosACgkQFHw5/5Y0
tywE+wv/fm2aXJiEZ6zAhthCbiBSYnr5meD0TayJTg2O9L4mwOPRajLAZzrmCl0b
4k0tzAoPjVtsn1N4NbKiSyMRV8HBWY8izwrpIXuvKwJCvLGSVx21/Mxj9nGsCaU7
RcEp4tKC6yQJ7PyEfSE1+0PRJI2c6RfjzbRzSxaiFQBEQoiWwOhtlv59Dy8eRU+q
6j8l1anqWaJMw33PxyrEBqpyhmu7UqCDHm780pkI5Vaka2q3tyy/D8DHUc88aVu/
4PsMYqy+9/RAdyjGHwV4H3fIMmyoMHsEkU1AMs1ZNxBDwEO/bsFV2XVD8AkPp/TW
jdV3/FGxuI4/NTooVlMebPSii25XM1j8yZ/pwpmf5uK3URKm+1ivFoKfqPpGVFsF
cyQLHhY1on5Jg0NP9pvz+4gGBTcKKVxGL5pcwpUPcQnnB/jNVMiN+VEV636jWUHF
x4zQYycyECZXVmv2uv4Plrnt3vu7e8czw45BPTylwBmODk1YQJOVQ5wZdgCVx1uG
vifEUJRy
=orjD
-----END PGP SIGNATURE-----

--28aFZIt8HpNArWp4--
