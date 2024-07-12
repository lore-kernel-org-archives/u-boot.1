Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D9C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 17:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39D1885EC;
	Fri, 12 Jul 2024 19:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJadp026";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527D8885EC; Fri, 12 Jul 2024 19:31:44 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E883F88315
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 19:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2598001aae7so1177719fac.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720805500; x=1721410300; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qQT8VE0MbE+9IGc4GCEOwa02MA+7HSIQZx+57k70yY4=;
 b=AJadp026C1N0L2uYvBEv0Fpiw78zXjluMRFYTJ53zrDnRzmYh5/NZ1tgKDB9CByMXP
 Zpc91pIeXB07XBwOg2A6o7CtJqDwz3DqVpYApNuUahstRkOG+p190yJ6mHvQy2lUYPJa
 uvIwIHszcyVo0DqlvutBaHIa9qnv6hEqYoGNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720805500; x=1721410300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQT8VE0MbE+9IGc4GCEOwa02MA+7HSIQZx+57k70yY4=;
 b=jmGS0PewqCgYs5iJb9y4wxVJr9j9CRt5n9vmGlvUd474bcjd9UU6CJgEXYrtVF2Wrh
 MGQu7IgI0ohtvrS9/J37CNHwM604qVMNe0H1G5Y7fQNe8zhhyI4SAW4h9lLFk5+WwKa+
 SI1Ca0BHeAFjeeQmbx/+HQbF/z8Y8GBxpmr7Qsy39eYQ+IEPvOsdm6v8B31N7rfOY6O0
 QwIft0jj46qXhUCRRtaEFJ7tSm0FgQaHRkd5DFj/sz+/BalpT7BkPGlHDOFYyzA61znO
 3cUHFjDctkepyMKLKlRYz4YOxFoLFRpYOUBLkNLRLd8ZU54Rt/9OMo5vUFjEsBulM3g+
 IhhQ==
X-Gm-Message-State: AOJu0YylVMFiqNiB+brL5jIaMi+l4YkFvSBiCxFCe5F/lgpkmUrvtwGR
 RXcgOG+1oLh7I9I4HNxUuyb3HHSl7jD29vIb7RWKpaKzduT5YreowsTiYlAmCrA=
X-Google-Smtp-Source: AGHT+IFUuLGuUu68odbL5fFdwu0bO0ZB/fSK1bx2smWzo4fA/AUk10uBfsHCohpeFY0ioM4L9jvqPQ==
X-Received: by 2002:a05:6870:96a7:b0:254:77f7:7bdd with SMTP id
 586e51a60fabf-25eaec8ddecmr11079733fac.50.1720805500637; 
 Fri, 12 Jul 2024 10:31:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa083bb1sm2336434fac.31.2024.07.12.10.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 10:31:40 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:31:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com
Subject: Re: Pull request: rpi-2024.10 rc1
Message-ID: <20240712173138.GB38804@bill-the-cat>
References: <CALeDE9MOQ=G9r9We04-_1KVB7EvawCWi2DH1Yz6wMVTRp+FejQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ao5qAJPzHFTLWmGW"
Content-Disposition: inline
In-Reply-To: <CALeDE9MOQ=G9r9We04-_1KVB7EvawCWi2DH1Yz6wMVTRp+FejQ@mail.gmail.com>
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


--Ao5qAJPzHFTLWmGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:36:32PM +0100, Peter Robinson wrote:

> Hi Tom,
>=20
> Please pull the updates for the Raspberry Pi:
>=20
> Updates for RPi for 2024.10:
> - board: rpi: remove leftover CONFIG_HW_WATCHDOG block
> - arm: bcm283x: remove unused empty hw_watchdog_disable
> - board: raspberrypi: Fix format specifier for printing rev_scheme
> - Revert "arm: dts: bcm283x: Add minimal smbios information"
>=20
> The following changes since commit 3f772959501c99fbe5aa0b22a36efe3478d1ae=
1c
>=20
> are available in the Git repository at:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2024.10-rc1

Applied to u-boot/master, thanks!

--=20
Tom

--Ao5qAJPzHFTLWmGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRaHIACgkQFHw5/5Y0
tyzeEQv/elUVU8zkkBtWpQQc4VxUj5s00Qon76FJ7XRpngBM3cNhuaqvkmSO8aFa
rOeqLBnntETK73Z4OQ6RA/nlOKATBaf7/PbDmFla9lpTBWxj5v54Qy/NgHT1ONag
hcF6raiiY6FBrN3X11BBiqE/1aPzNYE/uoApnHacGXmlvmyP0g8YTOfZJgBNK5mu
o474WTmxWy3BarXTavUB+kKj1T8UpZd34d/u1cLFxjVBdQVl0uOhts+inVi6yFOO
8Mx8Sn915W7Ck7Q2rXxzPU9pKdthHf6srRD2KkmhdmZ5DILBIPLR74MKN0vto4Y8
PIY3nKssoSlSMwvS67wLNelLTeK9eGd1cwUqRSYihG1YBtfl92aQuLJa87HRsSF8
4N3gtAssn7ndqBytREFGofU3OacZT42xHBPtxSuLrL4obEjOz4D4o+p/nR52zKem
WvGePTsKE2XWMm5amG0WerLRNm6HXp3ILqtyKHaIZz4aXtqBtVYpaxikfHAX6f4O
YVDyxPeA
=9NhA
-----END PGP SIGNATURE-----

--Ao5qAJPzHFTLWmGW--
