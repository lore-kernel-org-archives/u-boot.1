Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF9BC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C2C87782;
	Wed, 29 Nov 2023 20:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jhzedHsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9363787782; Wed, 29 Nov 2023 20:02:26 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DBA8777B
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5cdc0b3526eso911017b3.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701284542; x=1701889342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PcBKeJsKt+Roasz0v1naRUxWIOpYBtLfQ5xNPiC6TzM=;
 b=jhzedHszjjF85XdataEnjiDJb7scK87VgVRifsRIEel7+ufq1vCvb2t9cxugs8OI8X
 SM873GSEv1LXi1X38XOVVLMqzUh/pxjnxuB66P6LlxSmFiJQ4krzXE1DCbEOo5hmMs6p
 5c7uy/l1iiGA2TK/NUFOGAH+g3q5lR743/heI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701284542; x=1701889342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcBKeJsKt+Roasz0v1naRUxWIOpYBtLfQ5xNPiC6TzM=;
 b=ga7uTO3K0+GeWg6xhztOkEMBAeK89FMmeOKcYbvLXl+JigZWkRO/Uf94cG3opROS6G
 NHYJIY7QruLqOrt41k/IGIBSJnfChrjgg602/ed7pN1PeinNDfLq6eYOpHdYLxX0xGzJ
 sLkPWu1MYicJ8wiFQSM+J+ZIvJtcfNQHDhut9CVi2B4FQvJAkbRUUIE0nN/qipKCGzBB
 EoNoeHro1sPYZKAuUCc5/HWU7RYeBcQgHdHty+vg1bRGWuyJ/J3Sk6AJvH8L+I8R7Q58
 Mzstj5wBA6ZCu49YIRBQBpwlA8Q6IJMW9psevrVLhuhsfJ1XMnoI4s8i3nJC+I8OFNBD
 S04g==
X-Gm-Message-State: AOJu0Yw0UkVsA7EhYFvVbz8mG7H7nFDeYzz4q3gPvg2+PHFYD4GtUljZ
 KQZJDOFG9qxRSf8xgJFTKZK6hQ==
X-Google-Smtp-Source: AGHT+IHzHkSwEXPTpHD57NNGdkBTndkGP7v7ThfK3Xt/uxEh/1wuIb2yMo1BQbLzKgaGrors4qyDxw==
X-Received: by 2002:a0d:dd48:0:b0:5ca:befc:a40d with SMTP id
 g69-20020a0ddd48000000b005cabefca40dmr15747142ywe.24.1701284542439; 
 Wed, 29 Nov 2023 11:02:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 gb12-20020a05690c408c00b005cf2d42a7b2sm3225892ywb.93.2023.11.29.11.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 11:02:22 -0800 (PST)
Date: Wed, 29 Nov 2023 14:02:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231129190220.GN2513409@bill-the-cat>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vJJLzijI2B35z7R9"
Content-Disposition: inline
In-Reply-To: <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
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


--vJJLzijI2B35z7R9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 07:59:00PM +0100, Ahmad Fatoum wrote:
> Hi,
>=20
> a few more comments after decompiling the FIT image:
>=20
> On 29.11.23 18:21, Simon Glass wrote:
> > +    with fsw.add_node('kernel'):
> > +        fsw.property_string('description', args.name)
> > +        fsw.property_string('type', 'kernel_noload')
>=20
> The specification only says no loading done, but doesn't explain what it
> means for a bootloader to _not_ load an image. Looking into the U-Boot co=
mmit
> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces t=
his,
> apparently no loading means ignoring load and entry address?
>=20
> I presume missing load and entry is something older U-Boot versions
> were unhappy about? Please let me know if the semantics are as I understo=
od,
> so I can prepare a barebox patch supporting it.

So the matching side for this series in U-Boot is:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D382849&state=3D*

And in short, for IH_TYPE_KERNEL_NOLOAD we do our best to use it
in-place. For decompression we allocate some space to decompress to.

--=20
Tom

--vJJLzijI2B35z7R9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnirIACgkQFHw5/5Y0
tywO/Qv/c1oNc+/ouJBT1KN2K5RbgEALOt+sPZhysWelxhSqkcPlCjb5gfuJ7ajV
Ul6k85FSpkGagwKzxfHCIxhuhNRgNTJ5CQZCZ5MwXV/H8oWad0dUVVbIbcWwe11/
y9nWedxeH0poGkNULDIDQZr6d76QRvZjl631Xsz/jgTYlCXtTCin55blEo4d1oqL
L203Zw/qoqem8gHc3UEUcVBfudB3hKE5NVKarLqcbW179w0tnKnCTunDWC8+Hseh
FgcJ5m+x4xn4bkNkEiPZnVwhWFLsu90PAUY7SCGt1dyilThXE2WYoYGLULi3OeLz
3EzdtJkMPqy65I95k1+fAYBHaKN/EecR7nytt7XxP/8SE/N/Qt4R72L5Uf/CCjVs
WbPx6LV02Ig8z4F5sH3JXgaw3W0xrYWH7F9rhSbxGiWi7OAFosfXFsGTSbShpBuC
rKD+0n8q2yqyuPBpOOV18L33WCapVyvWwjf24ozKiUiaitcXvQ5REdRVp20/bhq8
55QIYmgN
=y4fu
-----END PGP SIGNATURE-----

--vJJLzijI2B35z7R9--
