Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92755C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 22:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B9888460E;
	Sun, 19 Jul 2026 00:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VyKuzNvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038BA847AF; Sun, 19 Jul 2026 00:25:13 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16AFF842FC
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 00:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so2567669a34.3
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784413509; x=1785018309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bBicM3C4dHf8BOa/K0Jd03EK2KjkqWtTeCA0C2y/bm8=;
 b=VyKuzNvXt1bsKePIxLzG5mUAD6Z6R7GpZtJSbcLZJdF6Ixv5EJ2NsuBhbUFCOBeuFW
 PbQpQpqrp2Gw1x4/DUywZhKZyzO88Zy7XtfXejAAXNEnZvT0u/wTiir8moLEmorfLE6p
 mqLZGg5ctFoejfakKqfeYDKfcp3bivZmqqfPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784413509; x=1785018309;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bBicM3C4dHf8BOa/K0Jd03EK2KjkqWtTeCA0C2y/bm8=;
 b=GQa/Sj8s+RGmd8lJWlVwHjmJo+JDH+GLZQxI1TbNyb6SoHbVBtTD2eNNBYfPxySTF/
 pA63hms3hym8mKUFXn97dEf2VfYkSisXmVMV3cXLwBQ8+gdy50B6JEBu+FpENY4yS0l5
 nrt1IQcb2lo4C5l7YmPVVPPTnjJ5QgLYpsy3PTA9MnSRqwyqx33ulSurXk1Pwnj9arwD
 Hv4d8JjyoQd9qOQzZbXaSArKgBffTaKZKGiYQ7D2C572LI7qsCg2/JDzbEyjcH4l6sMm
 iMeBGosTq7w0A5y2e6vU6OH1UevHOBzB9yZbOQYoKzzMDkTEouprZOV95eekbAtyrvIk
 6XBg==
X-Gm-Message-State: AOJu0Yxbo7DQ1KzagU0TJrn2ES0mBUMjRKGfuMnxS50pwpDQ57J4AvRc
 sbvEg920D6uj6mn5MfgCO9KGB8cCxFZ6+eh4ppUBEuodmCcbt1oGoT6jC/wBROA8wwU=
X-Gm-Gg: AfdE7cmJ4DaLoNPTYta1B7lArtU1gjuCUccHd3cqXsCheY3ugmXg3JELx70p89JDtlg
 /OKrMh5qHHO1svNH9bvQuZW9D5mzWmyLk5U1L8mVNrHBN1B56hiivc2/bvCcllGMUHXlM8Yoawu
 VqkOXLQZHA6VC+1Vpkvb8ttzdYHbo03+XG61u2p04tSSdOQDc7HV5sJf0ns31o+FxBBJZqnMKx2
 4AiEtHS1g4AmqFhwLFWBf/ifdg5clQcuZFrZ1HcB58/1qq+GcvNrdPH/n3tdEuY0XhAJQx4ItKN
 q60LyqgzdfLcPndQK6L29o5gvRicU7v5JIrbajkQAMCxCSl7vYP9dk5eVSecKXGyYdfBqAe1Mdm
 nvEDumlnVddsTYwEqMfOMxsk/J0AHxeFLJqWWxakeGqIPejPDYq1b86EzKrunAsq7n36kPDLWSC
 W7agA3wM2Gv0OwRcfsCzxRuhOq8rdqLhLBh3ENc8h6/0ykoy9Zgz3dhy8vG20Dg8PdfeERUgKSS
 Si7oRta8YZFEaTYFSW0Ubt+sm4=
X-Received: by 2002:a05:6830:4c16:b0:7e9:ea18:d1ea with SMTP id
 46e09a7af769-7eda099e0damr4612108a34.28.1784413508716; 
 Sat, 18 Jul 2026 15:25:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edad98ab3dsm4182199a34.12.2026.07.18.15.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 15:25:07 -0700 (PDT)
Date: Sat, 18 Jul 2026 16:25:05 -0600
From: Tom Rini <trini@konsulko.com>
To: anoduck <anoduck@protonmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH RFC PineTab-V DTS File] RFC: Pine64 Pinetab-V dts Device
 Tree File
Message-ID: <20260718222505.GV749385@bill-the-cat>
References: <20260718-develop-v1-1-d4b5c0675f87@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AtLyEKbGQa8Km9Vy"
Content-Disposition: inline
In-Reply-To: <20260718-develop-v1-1-d4b5c0675f87@protonmail.com>
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


--AtLyEKbGQa8Km9Vy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 08:10:38AM +0000, anoduck wrote:

> Added compilable PineTab-V device-tree dts file derived from pine64 commu=
nity distributed dts and additional parameters
> Community provided definitions:
>     - Audio Codec
>     - Accelerometer
>=20
> Additional parameters include:
>     - Definitions for sd-card and on board EMMC devices
>     - Definitins for power supply to sd-card
>=20
> Signed-off-by: The Anoduck <anoduck@protonmail.com>
> ---
> Provide support for the Pine64 Pinetab-V Risc-V 64bit Tablet
>=20
> Signed-off-by: anoduck <anoduck@protonmail.com>
> ---
>  .../src/riscv/starfive/jh7110-pine64-pinetabv.dts  | 116 +++++++++++++++=
++++++
>  1 file changed, 116 insertions(+)

So per the documentation at
https://docs.u-boot-project.org/en/latest/develop/devicetree/control.html#r=
esyncing-with-devicetree-rebasing
we only take modifications in dts/upstream that are strict cherry-pick's
=66rom the upstream source. This needs to be done under arch/riscv/
instead, and you should split the additional changes in to a
-u-boot.dtsi suffixed file, so that it's easier to replace this with the
upstream file when ready. Thanks.

--=20
Tom

--AtLyEKbGQa8Km9Vy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalv9PQAKCRAr4qD1Cr/k
CtVBAQCd1Ub+p0YygNFqjcIZ2CiHqZoyN0PhCk2IvL3aW8Z1rgD/XOH9dyHQP1pE
JFjY1JVxOP/nYvKqggxv+rzxiFBH+w4=
=Ao+R
-----END PGP SIGNATURE-----

--AtLyEKbGQa8Km9Vy--
