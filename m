Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C9CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F3F83E8E;
	Wed,  8 Oct 2025 18:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IjIf84rO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513EC84054; Wed,  8 Oct 2025 18:06:18 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 373D383E42
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7b3e2a51678so64728a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759939575; x=1760544375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e+itxPQhyP+900KXCNJMtmXQVUUe7ZK/wrVB/l1lSM4=;
 b=IjIf84rOhBDYvba4EFBOndAyCYSZdIdtXs/C/XqzO1e3uuQH/EOP0zCyc0OEG40cZy
 uTB+2TgFCxge27eaez5RVQd2ChkrMU7+bABLowIp+0Y4h1sWL35LQ08fQiEj33yXGpKw
 nNuAsHwO4HF5FF8E1ncvieUGF4d7YrVrlz96Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759939575; x=1760544375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+itxPQhyP+900KXCNJMtmXQVUUe7ZK/wrVB/l1lSM4=;
 b=E0Db/hlMH7+GlgPzAjHIu1UqnzD1AYGoBSASda9OAo16aZs59Fvmkr7u0WbIttfgP3
 MB12sFQpvCBEcdiDR38twOjA9K0HlcxMs17GiO15Zx2v+tQZh3cu0NQMAWj6mZspIr5r
 fQVrETQi6SA7OpAIRa8RGZQcy3qj7NINzPjX9TWFhGWLHvAps0uN4rFWiaFmR7y5gTx8
 NcdTX4gofE5O6s9s0gdvKH25oloyZ3U+/pr/6LYIgWiFOD+cv0pPgF4mUfr5Q1n5IYy2
 aKv+lkVuqjcbJqIdp7pSYZGDEd4Go+vpZ6Ygc4q7Zw7ooys/lbKLb6HqtLnNtltpexja
 FR9w==
X-Gm-Message-State: AOJu0Yxiz1ngYbzILCpEW5H5OHih4PCjxR4fgO1fkqLeadPADB4My8NO
 Geg7mg5S8tB+wbL2k0cLYsYlY/UpqJUDLDSXIVrQTTp6t6oEnK/PXytzyqpbd9NiU7Q=
X-Gm-Gg: ASbGnct0cIvi8yJSKgoode2HNsBvJJm9r5qVjtdKljJutnArCFrmis0Vxpo706Q1YKm
 1JQ526Zo/7I8gD5/tCK0md7wVnMRmFUzK7YI5j2lsQTWcOhrSCn+FBbTm5MF4TV5yU6lEb7lMOe
 gIkJVjbtTrzIX/Rvn29NKzh1piNuInQH7gltQXsXCNF60piniHVMWNAFTcSJ8C87hWtBa++FaFC
 dQq8Qt+Nv4m3ubqVHb0o/AzvKe+2e59yJVCdcRTIsqCD3jOWyzRlsiJC96OiIUQsLrm+Q0kTcbJ
 FneOI/98RrN/X7I0jxZuqrYRNhHhklfWBIXa1/OCX9BjaE/x7HfMJKU7hX9gd8BjRRTtC5QhLY9
 G3G7rEck6o9xyxNi57UMaJJY/BafIpZ1btpcsNliMkMIVfekTuOSOmFCmmfRSooIT0ouJ9Tx1N4
 Y+0ygCBmyBhP2EILxica0r
X-Google-Smtp-Source: AGHT+IHM+7/2pc5nq0JxvkkZHgdTUzYXO9d9S7ASfVhdeBuiDlID96XmxaKW0UPba9sCbm9vaalibA==
X-Received: by 2002:a05:6830:67d8:b0:782:46c7:2c21 with SMTP id
 46e09a7af769-7c02af612b6mr4965423a34.11.1759939574892; 
 Wed, 08 Oct 2025 09:06:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e5b04ccabsm3687327eaf.22.2025.10.08.09.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 09:06:13 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:06:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, quentin.schulz@cherry.de
Subject: Re: [PATCH v2] cmd/dma: implement dmareset command
Message-ID: <20251008160610.GZ298503@bill-the-cat>
References: <20250913163913.395-1-briansune@gmail.com>
 <20250923181254.830-1-briansune@gmail.com>
 <175989732707.1794629.12743192393543638744.b4-ty@konsulko.com>
 <CAN7C2SCedVQ5Z_5eAeC51M9zWKyqb_kkUcubzvJMSLiBy3rOhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SF4d/5wnmJs8hKlM"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCedVQ5Z_5eAeC51M9zWKyqb_kkUcubzvJMSLiBy3rOhA@mail.gmail.com>
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


--SF4d/5wnmJs8hKlM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 11:34:11PM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:22=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> > [1/1] cmd/dma: implement dmareset command
> >       commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
> > --
> > Tom
>=20
> May I ask do there are any documentation to show how to run this
> command on boot.scr
> Or possible during U-Boot setup?

Well, once it's enabled in your build you can invoke it like normal, or
add it to your boot.cmd script, or possibly add it to CONFIG_PREBOOT and
run it that way, depending on how it's supposed to be used.

--=20
Tom

--SF4d/5wnmJs8hKlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOaL7gAKCRAr4qD1Cr/k
CmraAP9MB+UZv7FwlKU8fouLIZfEevELK1o55GG3QH3JNznD3AEAimmTOUVGLtGC
MV6eqi3ojxZVtMG4ld23qJFk7T7BGAM=
=wJf7
-----END PGP SIGNATURE-----

--SF4d/5wnmJs8hKlM--
