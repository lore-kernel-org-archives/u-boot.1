Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6314DC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6967887CF;
	Fri, 12 Jul 2024 18:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ylw0BBuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D50B887CF; Fri, 12 Jul 2024 18:58:28 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B055887CD
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-704473c0698so1072749a34.3
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720803505; x=1721408305; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OdkzIAn0TNvSAZpIEBdpbXuKzLB869bCYiVzCDyL+KQ=;
 b=Ylw0BBuNDXiera5jRGJZL/toiJjQSJzPwt8pPYZWUE9KQb72ZZM/bPYroTZbZmUEcp
 u3F4wvdOaAcHOBF/zDxDmslbIseE6dqt1zCIjE8E8wRRQOehRAk6Bsmn7rn9V+wzV7g+
 rt35ghhoekuvNkTWNHIXZriBKgnFlfpqb2NZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720803505; x=1721408305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdkzIAn0TNvSAZpIEBdpbXuKzLB869bCYiVzCDyL+KQ=;
 b=wQY8WWUTjfon6XbglMIDv5LlZDmWg3/pxI0RtL9cc4E1spJDAPoljRRmpAtbgWw26S
 BLihLGGBENl9XwZsyIPK9VZYMF+kLyKux0+ez/SsIeJ54FLl35TIFBD9Xy8e0ok/jDgQ
 0sXv7k2cTz+dm6dAM/VHGYhDLvkeR28PPDAdkKiKxKQsPVt60AcQHFX8rGolxY2AhVC2
 lh7jap9AfyI7NXRjsLsYskkS7usFpejnNTd6IEllYS6czAgGVBxOBhJFiWAAD4UHnYZf
 7v/yGMdRogLXQo2SbYUkk0QURU5zA8oLCwD8wD+cuerbVJsM4OQ03KymxJERUjJwypgt
 ntCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp1S3dKZsdQ0oJilePlnzNZn47uFPR5TO+VIIVfMuFoznBfnbzzItMC10MX2Se19UVCk0mU8TnX38zizlLf69SQOIqzQ==
X-Gm-Message-State: AOJu0YwHTVFoZvABmsxRKZoumclOl2CkqCqgT1f1nD2FsdX5J9yXWUg0
 ei/PYidIUCLvfmxUEZ1NGBVkGAsGT2SUvhLgpVu2ta6kOgyrDeeet3Fo7SHevKqfxmcTsOQk3PS
 a4qbRig==
X-Google-Smtp-Source: AGHT+IFQW3HCMUw527lnTLdoW/putAmFCi4acafsol418xFiYj055jUt5Tsxlhtg1lR4WJMV317aUg==
X-Received: by 2002:a05:6830:3b8e:b0:708:b100:3a35 with SMTP id
 46e09a7af769-708b10f7cc2mr5770676a34.21.1720803504232; 
 Fri, 12 Jul 2024 09:58:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f6b4acsm1622437a34.9.2024.07.12.09.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:58:23 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:58:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH uboot] dt-bindings: clock: rcar-gen2: Remove obsolete
 header files
Message-ID: <20240712165821.GA38804@bill-the-cat>
References: <6355fbaa5e3c40d6790cb5aa6ffc1c573c1f08ed.1720790104.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="20NhckF+NpALL0uk"
Content-Disposition: inline
In-Reply-To: <6355fbaa5e3c40d6790cb5aa6ffc1c573c1f08ed.1720790104.git.geert+renesas@glider.be>
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


--20NhckF+NpALL0uk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 03:17:38PM +0200, Geert Uytterhoeven wrote:
> The clock definitions in <dt-bindings/clock/r8a779?-clock.h> were
> superseded by those in <dt-bindings/clock/r8a779?-cpg-mssr.h> a long
> time ago.
>=20
> In fact U-Boot never used <dt-bindings/clock/r8a779?-clock.h>.
> The unused headers, their replacements, and the corresponding
> r8a779?.dtsi files were introduced together in U-Boot v2018.03.
>=20
> Fixes: 16b6e4aa3732cee1 ("ARM: dts: rmobile: Import R8A7790 DTS from Linu=
x 4.15-rc8")
> Fixes: edd15fcffba31452 ("ARM: dts: rmobile: Import R8A7791 DTS from Linu=
x 4.15-rc8")
> Fixes: a3fb9ff3b33fae05 ("ARM: dts: rmobile: Import R8A7792 DTS from Linu=
x 4.15-rc8")
> Fixes: 92aa09959271d08f ("ARM: dts: rmobile: Import R8A7793 DTS from Linu=
x 4.15-rc8")
> Fixes: 9a26fc5a73fe2369 ("ARM: dts: rmobile: Import R8A7794 DTS from Linu=
x 4.15-rc8")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Cfr. https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit=
/?h=3Dclk-next&id=3Dd6c5fc9add9eb7a0d5bd179ab07cbf43e32b28d8
>=20
> I assume the corresponding header files under
> dts/upstream/include/dt-bindings/clock/ will be removed automatically
> in a future "Subtree merge tag 'v6.11-dts' of devicetree-rebasing repo
> [1] into dts/upstream" commit?

Yes, it should get deleted when we move to v6.11-dts, thanks!

--=20
Tom

--20NhckF+NpALL0uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRYK0ACgkQFHw5/5Y0
tyzFSgwAgat3BTLqor+fihRaVpy8QU39wVsPh77vst89kJvCTSC6kYBCKT0qaZ97
VcjJfPaiEqGZqZOnB23+ulhScOZjcLYDhARayquV07DmyATR8nuNZ+pyEYeh843b
0kkWYUi9GIH5vvsztyGjXRM1EnSnzyU3B7I4/llYB22XPYdSVaupBFwfBeJcawml
J7GnwiSNhpQFQOz4CCOrqf6kLKtuDpliKbO3DUj2zhx3oG8egbpOWZWUygZVm81K
co4M2oqOFrQQAAPkJVrpUN4D4LfeOnm3hxWYFORyqGS7K6k6nDJCAYF+xEfW2AZr
SpTboM6nO3ryqnaLyNFGNTGfDijD9f7/XYzh1kVzkLeDDhP57fmCTWpLIMFRo1RV
KFIIk6BcRRaVeNZpeOUoEb5fON+sfBxZ98tOsCCWg7Gp9un6gapcvON95SIBA7v2
q9VuJYNfo35/TdTZyfuLssy0vHvnBSAGAqN3G3hlLPc/uagBIW4st9gpy93tXqec
eCuKJHGW
=jcnK
-----END PGP SIGNATURE-----

--20NhckF+NpALL0uk--
