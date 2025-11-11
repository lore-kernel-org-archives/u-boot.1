Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428ACCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9862E83B8A;
	Tue, 11 Nov 2025 14:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C12gAxs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FAFB83BC8; Tue, 11 Nov 2025 14:56:45 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C116783A79
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-656c07e3241so1820764eaf.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762869401; x=1763474201; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e+An5XwjkXRnp90quCnYaNxJrVxlGPF8Waq1KL3HOSA=;
 b=C12gAxs9ZjtgMT7JWNkH1IbgmJshLTDgX5iBskvhB28xAO7zvHZLEfYRoav4xCD0Ue
 GB/mpbIGxhRkF028qu3chchl61Aa9ZXjmGG1eNvFn2nSx8Nj5gvEtsCYoyJOpXQfpEHF
 cvG0zjwC6+OVptkQbfyjEjEwitZsnTNObfZMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762869401; x=1763474201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+An5XwjkXRnp90quCnYaNxJrVxlGPF8Waq1KL3HOSA=;
 b=t7Qj8zaQHb8/HFHiLDDKvzEdUmZfWMOTGcZP6Enk6JfCO/ZFA/asTxTZKEt0MQYg9+
 CYnZTm+QStTdtGkWckg6eLZcf3YWkKZvwffqFVx190uKVKPA6XQL4ZdyzABHEI5OwR3e
 P0MGXpYlBAYHP4f/Mw3RdEVj9pu+g09ZUjxw/EAX09E7qdU3FQVsg4TQdBR7aGAoUre6
 eYRKIZ4VpjrhCEIh1dz+620z2XCqN7S8zlb95QteRW8IRZH4QKQv8hQsof5chyOCZ8qG
 Hnp8fHo+oQrKW/OO16YALbICZVbBBd81iWE5LLLBJjS0wUV6KWPDkbHrLV3sz8DWRq6S
 mxiA==
X-Gm-Message-State: AOJu0Yy4/zPgY9ej9xl/c9tuLsyqSDPVfwZo7QrHuvXIVMh5HTugMJnA
 E0w5eNiG1YBc7qU+xSb+FhKutHCBj0Q/R10p4GgMVxF8aPER8ct65/TMC2bmYexlbGQ=
X-Gm-Gg: ASbGncv9dtEg9qawiiiPFvlEnsScYW4Qnv0ouuu9pYDsblrHDMpqGDTNvh2sxl5OdWd
 PizkGxvCzFUGKPPSjhPM6SIgXnP74nUrccOLgtQIGBhyJDQ7shb4gLU0S8aWqLtxY6wdImr58fF
 Xx9HtdoJZtYryCHNa+hhJ4i0/3w6sPMj3JnEj4Tfj1C2qqdznTuRRs/vAhp182fpQzm9ax4lCFT
 Bfov41Zuj+GufecNjSmaarIIYLkPhu559rH9uUrpA+W98MRLhWDVytS3eUPCLvNzClCImXJExOL
 Ct7sp6PMZoopThJ4zSFleMmYRiK3p4pQ/jviKztwwtrMRrfI6HbEYPZ9opT9avA5OwBx4FJYE82
 +xyF4prCleXFynKp4/92bDG3+OTQO9d1Nl/uYJspNBO/y2qzYdeoFvwebMebp9YiNlyAyQ7ZuhE
 1GC/SbmBivGMzeXVDTItnFfJjkVgrCd9KtxiCwF84=
X-Google-Smtp-Source: AGHT+IF2Bsieo4QUMgHtaXdJZnqwAB0rabuRs5D/1CnsKWw1G7ewaI8TBZ8fnRm/p+5ra8wor6/x6A==
X-Received: by 2002:a05:6820:2905:b0:63e:effa:86f5 with SMTP id
 006d021491bc7-656d8eb8572mr5666118eaf.7.1762869401369; 
 Tue, 11 Nov 2025 05:56:41 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656f3ba2650sm2847822eaf.11.2025.11.11.05.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:56:40 -0800 (PST)
Date: Tue, 11 Nov 2025 07:56:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Gitlab: Add a "sage-lab" stage to access a board farm
Message-ID: <20251111135638.GT6688@bill-the-cat>
References: <20251110154231.2629710-1-trini@konsulko.com>
 <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6KLrv1lapLqB29bG"
Content-Disposition: inline
In-Reply-To: <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
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


--6KLrv1lapLqB29bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 05:58:22AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 10 Nov 2025 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > This is the Gitlab side of adding support for the board lab connected to
> > the "konsulko-sage" runner. On the software side, this lab uses only
> > upstream labgrid. On the hardware side, each device under test is
> > connected to its own exporter (typically a Raspberry Pi 4) that must be
> > turned on (and cleanly turned off) as part of a given test cycle.
> >
> > Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspberry
> > Pi 3 and Raspberry Pi 4. In all cases, we enable additional options to
> > run more tests on the board. As we have some networking tests, we test
> > both the legacy network stack and lwIP. In the case of Pi platforms, we
> > test all of 32bit configuration, plain configuration and rpi_arm64, and
> > again with and without lwIP.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SELFTEST
> > based on overall binary size. I've created
> > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
> > to track addressing that issue.
> > ---
> >  .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++++++++++
> >  .gitlab-ci.yml          |   5 ++
> >  2 files changed, 187 insertions(+)
> >  create mode 100644 .gitlab-ci-sage-lab.yml
>=20
> Would it be possible to add some docs about this? Does the exporting
> rpi do a full system boot and then run some scripts to load things
> onto the board, then shut down?

I don't understand your question. Yes, the exporter is powered on/off in
the test job, as explained in the commit message. When it comes up it
registers the device under test with the coordinator (and unregisters
when powering off).

--=20
Tom

--6KLrv1lapLqB29bG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRNAkwAKCRAr4qD1Cr/k
CoeUAQD3Iw9dCpQ9uAxuuQyAf5Ewi02h2P5MObzHBvlAM27BuQD/RvfCGEBcgcj2
klLjagTH7rgq27bNfAqm6gyxbbfPHgI=
=1RYD
-----END PGP SIGNATURE-----

--6KLrv1lapLqB29bG--
