Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D9CCFC501
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 19:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68B583A8C;
	Fri, 21 Nov 2025 20:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g01YXRnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5553883A9F; Fri, 21 Nov 2025 20:55:19 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BD483A8A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 20:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6e815310aso1378110a34.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763754916; x=1764359716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fimFJea+j92hEp7WTj+NG2kNIUu06xrxrBKaxuzYmMI=;
 b=g01YXRnRsPjEveVdulJKXxzLB+sZIayqqlcjWTzoywLTh4Jwrd3PDImXF0ftYF8M8W
 9MKIgm7AiTBFvvx+76Irbg91voSdk9LTqxCqMwu8korAGmtspHD6nCzMeDCzHQdQ+vao
 HqnGVQF5k7FrpgJi0EGUHHPiE4Ij+NABerP4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763754916; x=1764359716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fimFJea+j92hEp7WTj+NG2kNIUu06xrxrBKaxuzYmMI=;
 b=FqBFoLbnVH9bu3y6taHR8n+csyO+qPixKLeHzfw/LduJSY8CxzGK3yhepepAez+ef7
 9CL7Qpfc8dJrMuI2zzgav8ZD+ApZKXEV2ana+JSAkpJdSRy+HdS5Xw7AFNxiRIhbthlF
 sUq6h1Eb7nNh6yI+Jv2RHe3EgB8Mdp8bXFvRRSRBu3TZnEe5LvPqwJPZTPbZyLiXreDg
 PRt4QnOB0CTiCEEoHDcXdAZH5qVe2LSVcSelKKH7HNiSthCzBMw0t6qx4NMJZYzHfFjG
 Wee/Y03ggVU4X5xPRG7sJ0ep/vyVgaJt9WQ7JoDKD9GGP3aN7N2dR0meSgwTj3ZrfOnH
 I1eg==
X-Gm-Message-State: AOJu0YxDSZNMfxDkRZshWRiHG1i9nPn14NrvnP+XL1DVny3SzN7Inw/c
 aZZx8fdX4TsewkBxmAs2X5K6R7HB9Q9JR3gWqxZtPvbmM4LzhBFiXFr8eR/6bkrtpYo=
X-Gm-Gg: ASbGncuznrlIgx2p744YpxVB3G8QD9fNninxEw/q0HyWA/IZcCygb+wLty3RHVLRLia
 VmFTdHGVC/hnLToo4ClzUZCNXDLXL3PAGORO8jpGZiu3+bmvWcVqjGW/ZsaQWs1gCJcbDO4re68
 WxjjZp4GySRNdVw5Owel7BtlgYbibnUYe/el/93GBXMu573kn1kGv2DePYQ+n8H0fDglBPEx1St
 ZTyVIvXPnsuQP4O+2d/qlvxWVWQLEdTehqFtCqwY8QA0HBOebJLKJGxbp5PBiwtlfZYYaa3K9Sm
 bf6JthYqvPulGZ3FTqwJwk2ICzpv4WHKhRQNZFSXjX607G/nh7RbQA+idSOSyb3twhS5cenNXkb
 ObGBZAv0KXz6Gff0e8nlhXBrG60gblM6yj7SrunxEW3UwWhjtoAmLOrhD8eLotlCt7Wm7pTXJ9q
 6xlWK2WcspvA8qn7aSd1UnsvWJmrPtj0EjQdbbdbRwU3xe7zeIcA==
X-Google-Smtp-Source: AGHT+IGZl9Jp+M1YBxZtmWMvIDSkqOn6DqyvFNi0vCTkHNDU6ruSgXJ3hL2ccUdwx4XWOqGUMC5e3w==
X-Received: by 2002:a05:6830:2685:b0:7c7:5974:3563 with SMTP id
 46e09a7af769-7c798de46f2mr1648486a34.29.1763754915790; 
 Fri, 21 Nov 2025 11:55:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d32cbd9sm2634211a34.11.2025.11.21.11.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 11:55:15 -0800 (PST)
Date: Fri, 21 Nov 2025 13:55:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251121195512.GE2125796@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a6u8a0dF+lL8unJI"
Content-Disposition: inline
In-Reply-To: <20251113175700.GM6688@bill-the-cat>
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


--a6u8a0dF+lL8unJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:57:00AM -0600, Tom Rini wrote:
> On Thu, Nov 13, 2025 at 01:21:07PM +0100, Marek Vasut wrote:
>=20
> > Synchronize local copy of DTC with Linux 6.17 , using commits picked
> > from Linux kernel. This also includes two fix up patches to make the
> > DM core work with new 8-byte alignment checking in libfdt and another
> > fix for NULL pointer check that is missing in libfdt.
> >=20
> > This depends on the following patches sent separately, which fix
> > various 8-byte alignment problems in the code base:
> >=20
> >  - boot: android: Always use 8-byte aligned DT with libfdt
> >  - test/py: android: Point fdt command to aligned addresses
> >  - test/py: Use aligned address for overlays in 'extension' test
> >  - sandbox: Fix DT compiler address warnings in sandbox DTs
> >  - sandbox: Fix DT compiler pin warnings in sandbox DTs
> >  - boot: Assure FDT is always at 8-byte aligned address
> >  - arm: qemu: Eliminate fdt_high and initrd_high misuse
> >  - efi_loader: Assure fitImage from capsule is used from 8-byte aligned=
 address
> >  - MIPS: Assure end of U-Boot is at 8-byte aligned offset
>=20
> So, taking a look at the test branch you pointed me at, my big concern
> is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
> with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB and
> SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_navqp
> is a bit more than 3KiB / 548 bytes, with the average feeling like
> ~4KiB/1KiB for aarch64.

I'm coming back to this to try and better understand things. And one
problem here is that upstream dtc changes really trip up LTO. I made as
a local hack, a change for imx8mp_dhcom_pdk2 to NOT use LTO (and so SPL
fails to link, but it's about the same growth, given the change in
overflows sram by numbers). This brought the size change down from ~6KiB
to ~4KiB.  Since this was already a hack just for investigation, I then
started out with giving full U-Boot the "assume perfect dtb" mask. This
reduces growth by 900 bytes.

A better test case is pinephone because it's aarch64 but not LTO. And
with a full mask in U-Boot hack, the size growth for full U-Boot is
around 1000 bytes and 300 bytes in SPL.

And so to me, there's a few questions. The first of which is, how is
what's being done so terrible for LTO. It's not good for normal
optimizations either, but it's really bad with LTO. The second of which
is, is there something being done with how the sanity checks are
performed that can be re-examined? Take fdt_get_string for example,
which grows by 120 bytes without changing the mask at all, and the code
changes are trivial switches to the new FDT_ASSUME mechanic and dropping
extra parens. That shouldn't have size growth, I would expect.

--=20
Tom

--a6u8a0dF+lL8unJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSDDnAAKCRAr4qD1Cr/k
ClxKAP97XN6lUZquPa0jaQYADRTiTJ5JLfb6Y/0/h8RQbNUrpgD9HiBGSp04CKwO
7frtXqbijEgXdhHk/TYKMrBH0N5pyA0=
=1seA
-----END PGP SIGNATURE-----

--a6u8a0dF+lL8unJI--
