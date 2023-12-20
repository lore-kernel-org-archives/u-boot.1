Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19056C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2630C87872;
	Wed, 20 Dec 2023 22:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jmjOL2wI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E787D87846; Wed, 20 Dec 2023 22:02:18 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF228787E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5e54d40cca2so1326657b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106135; x=1703710935; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wc9kvAp21tON0hIQ0YY5OR33mB9pXTdID2VFgV3BXK0=;
 b=jmjOL2wI68FlD4IYl0+Ck/E2NWqqx9iDSy1svkxk4ohMn8dFj9A22IhxmqXFYsNSnS
 ay/TA0NJXVVp/H6ZRcxnOYEeM8jl/p4B3j7WX6AZe9pYfzfmFSJH3w/QeJGxgefFu2Za
 SSQeONHObQ+F/sC8CJmx/zPjLcd72wkX+WRfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106135; x=1703710935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wc9kvAp21tON0hIQ0YY5OR33mB9pXTdID2VFgV3BXK0=;
 b=hlJfw5W+xFZt1YrKrC+rPPIabjuyzIw6JLLFKj66cJtyYSSL1lUNpgu0ErZqoc9McU
 VKFQC6CrPl3MJQ81fl0xLIK0e6RjsdN0OfGkr0/EjY4BH5mOcGVKJTuMkA7OX9pcuh8w
 mUT7UmIYVm7T7KVbYcEiAOK48pcxSyJi6C7AJHLxI8/lbh8Esp3ZskNSrrdM4wV/e113
 0NmmdNGZheBpGCrhl/yE2tuH1+Aubd9NUDVvqpHodx7U8II/aeFnR/F08gLBNVeFx2Tj
 rEXZg00uN4wQOB/0m/leQPYiftOkIdgSpd+ddujaxBIeQl8Dp700SKhhZOOh4PzT36K0
 PIoA==
X-Gm-Message-State: AOJu0YzytdzghnsS78KtKR2GGZEh7ThMUbkv4uQ/7fFsZj3W+TebZuTr
 ep01RBErk25OD6VNB++T6q6aOATMKv9vj28xz/4=
X-Google-Smtp-Source: AGHT+IFeTbFUXiQdS17LUMgGynNaeIqPTOD3Y7+ymoOceDrKjncVbImz37faw/NxupLKh/Vtt+tgWA==
X-Received: by 2002:a0d:da04:0:b0:5d7:1940:8df0 with SMTP id
 c4-20020a0dda04000000b005d719408df0mr289490ywe.87.1703106135225; 
 Wed, 20 Dec 2023 13:02:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 h206-20020a8153d7000000b005d755416307sm231986ywb.73.2023.12.20.13.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:02:14 -0800 (PST)
Date: Wed, 20 Dec 2023 16:02:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] pxe_utils: Increase feedback to user when fdt file is
 not found
Message-ID: <20231220210213.GB2513409@bill-the-cat>
References: <20231207142819.1511709-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kd3xTHpDzc+Nn91k"
Content-Disposition: inline
In-Reply-To: <20231207142819.1511709-1-michael@amarulasolutions.com>
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


--Kd3xTHpDzc+Nn91k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 03:28:19PM +0100, Michael Trimarchi wrote:

> extlinux.conf can set fdtdir. fdtdir look for fdt file using
> information found in the enviroment variable. The function does
> not report any error in the case the file is not found
>=20
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame

Applied to u-boot/next, thanks!

--=20
Tom

--Kd3xTHpDzc+Nn91k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVlQACgkQFHw5/5Y0
tyyS+wwAnAAB0dAYNP7UzfFphG4JSCOHW4UMlv2h6I3QVSaSZhSc+wCa8+igS3eC
MbBVF/F8k62W02ZGQGVjEsNlKyXC4G43bMoM0lAldMM50CbuC0EFAknI5byN8Q2Z
pXeOzHfhtASnOVvFF16gQctfmMl9xUATCw93bJVwJ29V4qEbb5+y5jThKY9Fq8MC
X4EiRpFWTOWLhfR9LlqAdNuKFdReDmI+pxDH2S4Ntf4RT7Y44TRvZeLIFOT6qfnc
qY8oQPBWWY1zHLyuDV4z//IaMSkemfjrZ4n3hD2+0KdvulEdRRxX5XixABW91dqg
KgKSnOgGRXiO9hmDZqQSRAj061Rc6Vm3ZOSiGAjFyVLg+6mrJIfbAYUk/e35FVi8
N6cMmJtLcBH+DWj6SKOK0e8p7utlPQe8P/AvWdl0EJ/6P6uIWAjcHvr8RpI7zsxp
7EssBdBolJuYrg3wDjy0mHm1c5RK7j7vVV5+XXYN9ceq2CeuYSePKWGJMP+8vypg
yKN/HH5G
=J/CO
-----END PGP SIGNATURE-----

--Kd3xTHpDzc+Nn91k--
