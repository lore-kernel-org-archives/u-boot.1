Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F11CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 15:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B2B83D2E;
	Fri,  7 Nov 2025 16:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LC7cnciR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDF483DA7; Fri,  7 Nov 2025 16:56:57 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216D083D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e3dac349easo554324fac.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762531014; x=1763135814; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g+iUt2oelOOL2mIXS1HCzyrxw7p5dNRuTfEpGY1pHYk=;
 b=LC7cnciRgXi6eyi/Pv2ejmBDvYo8HnaOl1WfMuVGOnnOomxwF9ck3FaLdke49R5Umu
 v+5jtogsrBYePrNKWbok7WpqApzzC+LRY+6qF9UUgs0I/H9vW/LUy5VkeBI3wHvO4N9M
 4z/ARFJjHU4ZMXj1MAsQMxkSkWQ3wahjGILVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531014; x=1763135814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+iUt2oelOOL2mIXS1HCzyrxw7p5dNRuTfEpGY1pHYk=;
 b=Pv2IrMZEgO328ngkYPXndd+qfxymC6juc67JvMFiro9M52adHZXjEDaf5jDwqFZGxv
 i6v95+30qHCjKIiqF01jhCCZzf6rpsgzHFpYqwm7b5NTIqKzYGnk2EXv/cPFj7BVeMZ6
 qYeNsml3hhuEnp6gweCx3QilThbu5ZIlsC2nGE4qjHI0FDmn7CRlWRkQSVgE54hcL082
 mdg4Xu2EqAq8p3kKPywBIPTNuwcA3iIFYy2JublA3BbhMAjPPPxKcsXNNi6JWHpPj4Gk
 Gbrpq8V1K4JerOf1XwQBVLlbr75slNf6jq0NLuN709w+4ryt5QTc3ltDvjxcV0Bf3ojT
 SG4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJTxq1TzH01xLpXQWzzp7NRhZpsgmE41L1/UZU6cJrYzP6vbxWAizmhk42H+NYKnUbZzvriwk=@lists.denx.de
X-Gm-Message-State: AOJu0YwZcbyVsG/lnQyB3mU3P62QeIMOoBZ8PYP5sBBhExvgEvt7qrLw
 iO6kJqixjrO9AZZe+t6y8Tu1Vq35C16kstkaCYhKgSGvNmwdo63ygu0wxg+gaEG4+kk=
X-Gm-Gg: ASbGncujoHh4FMKOBV0MJLZFoLLrpwL6U+kcKq52j/axYducsdEQQVLmwXnQpEW41sy
 BG+TcXRR668OSgR7CkLDWRj+5+47h0xqfz1Y+Stb8EH9zb1AGGvr+ZGtPTPLk0aVFWkes8HJdwL
 EVkAPMNofGrhD9YQMT/RX/kT0palwqkKJztgZIfOasCA8AX4rVKELVfGGHadP1h7WsX2Wj14KEE
 VRJo2qv8iaTyRfPpd6IMz1RdwVX6QS1DG6N8MJHQkviXdsfVck6eu0+sJ8KYdHAWh9F78cN7SCY
 4vVT691SjBJzasNUpO8z3+nzddo21KACqkXR94ntQEYo5zooZh5LXp02NXLHc+fmxpwGJ2d7VlW
 zj6Uoper/5BZpQ/aNJXCYbwVDuWQoJIfKaMVzDKZSB+93JnyiLODyObFpXKmHf5H/RrpUoFOygM
 kbJl/8BAK8H5MIP42AsL/n7hDqqerWBcikJYnxMOnzw3YzdtxHoA==
X-Google-Smtp-Source: AGHT+IGW5YwdE9PwUhtVT6OauLqXdlHPgT9l+STMofWEJM6sqos/GEoogHOxZIaCERVUwao2oRLE5Q==
X-Received: by 2002:a05:6870:ac21:b0:3d2:a262:3d3b with SMTP id
 586e51a60fabf-3e41e497ae8mr2565280fac.16.1762531013823; 
 Fri, 07 Nov 2025 07:56:53 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f1ec269sm1842706fac.20.2025.11.07.07.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:56:53 -0800 (PST)
Date: Fri, 7 Nov 2025 09:56:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
Message-ID: <20251107155650.GE6688@bill-the-cat>
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
 <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yCEIBPFG50m1afp/"
Content-Disposition: inline
In-Reply-To: <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
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


--yCEIBPFG50m1afp/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 03:06:47PM +0100, Marek Vasut wrote:
> On 11/7/25 10:12 AM, Heinrich Schuchardt wrote:
> > On 11/6/25 22:08, Marek Vasut wrote:
> > > In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT =
and
> > > DT with U-Boot extras, to show how much does the U-Boot DT differ from
> > > the base DT. This is particularly useful together with OF_UPSTREAM, to
> > > minimize the diff between upstream DTs and U-Boot DTs.
> > >=20
> > > Example usage:
> > > $ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=3D1
> > > $ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff
> > >=20
> > > This still has a downside. Even 'dtc -I dts -O dts ...' applied on
> > > base DT and U-Boot augmented DT can produce different phandle IDs
> > > for the same node in those two DTs, which results in a lot of noise
> > > in the resulting diff. The only way I can think of is to patch DTC
> > > to emit full paths in those phandles instead, something like a
> > > phandle =3D <&{/full/path/to/remote/end} ...>;
>=20
> What bothers me is ^ this part.
>=20
> Hello Heinrich,
>=20
> > Without documentation developers will not know about the new feature.
> > Could you, please, add a doc/build/ change in the next iteration.
> Sure, although I am not convinced it should go in in its current form.
> Please see my first line of comment.

Maybe we put it in the u-boot-extras repo for now as a standalone
script, so people can be asked to run it and look at the output?

--=20
Tom

--yCEIBPFG50m1afp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ4WwgAKCRAr4qD1Cr/k
CoXnAQDKOtyxBYkZWHDx5BTc1cr0VAhJGa3mRkdfNykFx61llAD+IQntOWxmx/ML
ybAcXgeMilhtj6j4ODR+owBNu4ARCwg=
=i9qW
-----END PGP SIGNATURE-----

--yCEIBPFG50m1afp/--
